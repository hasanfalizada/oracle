DECLARE
    L_SQL_STMT           VARCHAR2 (1000);
    L_TRY                NUMBER;
    L_STATUS             NUMBER;
    TASK_NAME   CONSTANT VARCHAR2 (50) := 'my_task';
BEGIN
    DBMS_PARALLEL_EXECUTE.CREATE_TASK (TASK_NAME);
    DBMS_PARALLEL_EXECUTE.CREATE_CHUNKS_BY_ROWID (TASK_NAME,
                                                  'BDSM',
                                                  'TEST_T',
                                                  TRUE,
                                                  100);
    L_SQL_STMT := 'update test_t e 
      SET e.RN = e.RN * 2
      WHERE rowid BETWEEN :start_id AND :end_id';
    DBMS_PARALLEL_EXECUTE.RUN_TASK (TASK_NAME,
                                    L_SQL_STMT,
                                    DBMS_SQL.NATIVE,
                                    PARALLEL_LEVEL   => 10);

    L_TRY := 0;
    L_STATUS := DBMS_PARALLEL_EXECUTE.TASK_STATUS (TASK_NAME);

    WHILE (L_TRY < 2 AND L_STATUS != DBMS_PARALLEL_EXECUTE.FINISHED)
    LOOP
        L_TRY := L_TRY + 1;
        DBMS_PARALLEL_EXECUTE.RESUME_TASK (TASK_NAME);
        L_STATUS := DBMS_PARALLEL_EXECUTE.TASK_STATUS (TASK_NAME);
    END LOOP;

    DBMS_PARALLEL_EXECUTE.DROP_TASK (TASK_NAME);
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_PARALLEL_EXECUTE.DROP_TASK (TASK_NAME);
        RAISE;
END;