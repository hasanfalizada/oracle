SELECT *
  FROM V$SYSAUX_OCCUPANTS
 WHERE OCCUPANT_NAME = 'PL/SCOPE';

 ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';                                                                                                                                                                      -- Enable
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL, STATEMENTS:ALL';
ALTER SESSION SET PLSCOPE_SETTINGS = "IDENTIFIERS:NONE";                                                                                                                                                                         -- Disable

SELECT *
  FROM ALL_PLSQL_OBJECT_SETTINGS
 WHERE OWNER = USER;

WITH
    V
    AS
        (SELECT LINE,
                COL,
                INITCAP (NAME)     NAME,
                LOWER (TYPE)       TYPE,
                LOWER (USAGE)      USAGE,
                USAGE_ID,
                USAGE_CONTEXT_ID
           FROM ALL_IDENTIFIERS
          WHERE OBJECT_NAME = 'P' AND OBJECT_TYPE = 'PACKAGE')
           SELECT    RPAD (LPAD (' ', 2 * (LEVEL - 1)) || NAME, 20, '.')
                  || ' '
                  || RPAD (TYPE, 20)
                  || RPAD (USAGE, 20)
                      IDENTIFIER_USAGE_CONTEXTS
             FROM V
       START WITH USAGE_CONTEXT_ID = 0
       CONNECT BY PRIOR USAGE_ID = USAGE_CONTEXT_ID
ORDER SIBLINGS BY LINE, COL;

  SELECT USAGE_ID,
         TYPE,
         NAME,
         USAGE,
         LINE,
         COL
    FROM (SELECT USAGE_ID,
                 TYPE,
                 NAME,
                 USAGE,
                 LINE,
                 COL
            FROM ALL_IDENTIFIERS
           WHERE OBJECT_NAME = 'P'
          UNION
          SELECT USAGE_ID,
                 TYPE,
                 'SQL STATEMENT',
                 ' ',
                 LINE,
                 COL
            FROM ALL_STATEMENTS
           WHERE OBJECT_NAME = 'P')
ORDER BY USAGE_ID;


    SELECT USAGE_ID,
           LPAD (' ', 2 * (LEVEL - 1)) || TO_CHAR (USAGE) || ' ' || NAME
               USAGES,
           LINE,
           COL
      FROM (SELECT OBJECT_NAME,
                   USAGE,
                   USAGE_ID,
                   USAGE_CONTEXT_ID,
                   NAME,
                   LINE,
                   COL
              FROM ALL_IDENTIFIERS
             WHERE OBJECT_NAME = 'P'
            UNION
            SELECT OBJECT_NAME,
                   TYPE            USAGE,
                   USAGE_ID,
                   USAGE_CONTEXT_ID,
                   'STATEMENT'     NAME,
                   LINE,
                   COL
              FROM ALL_STATEMENTS
             WHERE OBJECT_NAME = 'P')
START WITH USAGE_CONTEXT_ID = 0 AND OBJECT_NAME = 'P'
CONNECT BY PRIOR USAGE_ID = USAGE_CONTEXT_ID AND OBJECT_NAME = 'P';