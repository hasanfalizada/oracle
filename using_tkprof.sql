ALTER SESSION SET TRACEFILE_IDENTIFIER = 'bdsm_oracle_trace';

SELECT STATUS,
       SID,
       SERIAL#,
       SQL_TRACE
  FROM V$SESSION
 WHERE USERNAME = USER;

SELECT *
  FROM V$PARAMETER
 WHERE NAME IN ('diagnostic_dest',
                'max_dump_file_size',
                'timed_statistics',
                'tracefile_identifier',
                'user_dump_dest');

SELECT * FROM V$DIAG_INFO;

BEGIN
    DBMS_MONITOR.SESSION_TRACE_ENABLE ( --        session_id   => SYS_CONTEXT ('userenv', 'sid'),
                                               --        waits        => TRUE,
                                               --        binds        => FALSE
                                     );
END;

SELECT SYS_CONTEXT ('userenv', 'sid') FROM DUAL;

    SELECT LEVEL
      FROM DUAL
CONNECT BY ROWNUM < 100000;

BEGIN
    DBMS_MONITOR.SESSION_TRACE_DISABLE ( --        session_id   => SYS_CONTEXT ('userenv', 'sid')
                                        );
END;

-- # ./tkprof /u01/app/oracle/diag/rdbms/orcl/orcl/trace/orcl_ora_12605_bdsm_oracle_trace.trc /var/bdsm/formatted_report.prf