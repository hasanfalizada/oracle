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

SELECT 'TRUE'
  FROM DUAL
 WHERE REGEXP_LIKE ('Həəsn Əlizadə', '^[A-Za-z0-9 \-\(\)\\\?\/]*$');  -- Only english characters

 SELECT LENGTH (REGEXP_REPLACE ('12345vvv6a', '[^0-9]', '')) FROM DUAL; -- Extracting only digits

 SELECT 'true'
  FROM DUAL
 WHERE REGEXP_LIKE ('AZE12345678', '^[[:alpha:]+]{2,3}[[:digit:]+]{5,8}$') -- Passport serial number check

 SELECT REGEXP_REPLACE (
          'asdas asdas asdas 1212 asdasdas         af    afaf  a f              asdf afaf  afaff      ',
          '[[:space:]]*',
          '')
          tr
  FROM DUAL; -- Full space trimming

SELECT 'true'
  FROM DUAL
WHERE REGEXP_LIKE ('123567', '^[[:digit:]+]{6}$');  -- Exactly 6 digits

SELECT REGEXP_SUBSTR (pair,
                      '[^:]+',
                      1,
                      1)
          key,
       REGEXP_SUBSTR (pair,
                      '[^:]+',
                      1,
                      2)
          VALUE
  FROM (    SELECT REGEXP_SUBSTR ('key1:value1,key2:value2',
                                  '[^,]+',
                                  1,
                                  LEVEL)
                      pair
              FROM DUAL
        CONNECT BY REGEXP_SUBSTR ('key1:value1,key2:value2',
                                  '[^,]+',
                                  1,
                                  LEVEL)
                      IS NOT NULL); -- Parsing map structure


SELECT REGEXP_SUBSTR ('Hasan Alizada@',
                      '([^ ]+)\@',
                      1,
                      1,
                      NULL,
                      1)
  FROM DUAL; -- Between two special characters