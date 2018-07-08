CREATE TABLE TEST_TABLE
AS
        SELECT ROWNUM RN, LEVEL LEV
          FROM DUAL
    CONNECT BY ROWNUM < 100000;

SELECT * FROM TEST_TABLE;

CREATE OR REPLACE PROCEDURE TEST
    AUTHID DEFINER
IS
    N   NUMBER;

    PROCEDURE FOO
    IS
    BEGIN
        SELECT COUNT (*)
          INTO N
          FROM TEST_TABLE
         WHERE ROWNUM < 10;
    END FOO;
BEGIN                                                                  -- test
    FOR I IN 1 .. 3
    LOOP
        FOO;
    END LOOP;
END TEST;
/

BEGIN
    DBMS_HPROF.START_PROFILING ('BDSM_DIR', 'test.trc');
END;
/

BEGIN
    TEST;
END;
/

BEGIN
    DBMS_HPROF.STOP_PROFILING;
END;
/



DECLARE
    RUNID   NUMBER;
BEGIN
    RUNID :=
        DBMS_HPROF.ANALYZE (LOCATION => 'BDSM_DIR', FILENAME => 'test.trc');
    DBMS_OUTPUT.PUT_LINE ('runid = ' || RUNID);
END;

SELECT * FROM DBMSHP_RUNS;

SELECT * FROM DBMSHP_FUNCTION_INFO;

SELECT * FROM DBMSHP_PARENT_CHILD_INFO;

-- Under oracle
-- # plshprof -output report test.trc
-- # plshprof -output report_difference test.trc test2.trc

DROP TABLE TEST_TABLE;