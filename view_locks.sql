SELECT * FROM V$LOCK;

SELECT * FROM V$LOCKED_OBJECT;

SELECT * FROM V$LOCK_TYPE;

SELECT * FROM DBA_LOCKS;

SELECT T.STATUS,
       T.START_TIME,
       T.NAME,
       S.USERNAME,
       LO.OBJECT_ID,
       DO.OBJECT_NAME,
       DO.OBJECT_TYPE
  FROM V$TRANSACTION  T
       JOIN V$SESSION S ON T.SES_ADDR = S.SADDR
       JOIN V$LOCKED_OBJECT LO ON LO.XIDSQN = T.XIDSQN
       JOIN DBA_OBJECTS DO ON DO.OBJECT_ID = LO.OBJECT_ID;

  SELECT NVL (owner, 'SYS') owner,
         session_id,
         name,
         TYPE,
         mode_held,
         mode_requested
    FROM dba_ddl_locks
ORDER BY 1, 2, 3;