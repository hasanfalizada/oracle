SELECT REGEXP_SUBSTR ('FTRECEIVER=Elxan;CM01=10102;',
                      '=([^;]*)',
                      1,
                      1,
                      NULL,
                      1)
  FROM DUAL;

SELECT REGEXP_SUBSTR ('Hasan, Hasan2, Hasan3',
                      '[^,]+',
                      1,
                      1)
  FROM DUAL;

SELECT REGEXP_SUBSTR (';FTRECEIVER=ALikhan Damirov;',
                      '(^|;)FTRECEIVER=(.*?);',
                      1,
                      1,
                      'i',
                      2)
  FROM DUAL;

SELECT REGEXP_SUBSTR ('VID=8;',
                      '(^|*)VID=(.*?);',
                      1,
                      1,
                      'i',
                      2)
  FROM DUAL;

SELECT 'true'
  FROM DUAL
 WHERE REGEXP_LIKE ('Həsən', '([[:alpha:]]$)'); -- Only letters

 SELECT 'true'
  FROM DUAL
 WHERE REGEXP_LIKE ('ha@hasanalizada.net',
                    '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'); -- Correct e-mail