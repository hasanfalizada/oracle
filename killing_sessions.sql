SELECT    'ALTER SYSTEM KILL SESSION '''
       || SID
       || ','
       || SERIAL#
       || ''';'
       || CASE
              WHEN SID = SYS_CONTEXT ('userenv', 'sid')
              THEN
                  ' -- CURRENT SESSION!'
              ELSE
                  NULL
          END
           AS SCRIPT
  FROM V$SESSION
 WHERE USERNAME = 'BDSM';