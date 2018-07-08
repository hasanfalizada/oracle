WITH
    YOURTABLE
    AS
        (SELECT '1' ID, 'test' DESCRIPTION, '123' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '2' ID, 'test' DESCRIPTION, '123' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '3' ID, 'test' DESCRIPTION, '123' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '4' ID, 'test' DESCRIPTION, '124' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '5' ID, 'test' DESCRIPTION, '124' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '6' ID, 'test' DESCRIPTION, '124' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '7' ID, 'test' DESCRIPTION, '125' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '8' ID, 'test' DESCRIPTION, '125' SESSION_UNIQUE_ID FROM DUAL
         UNION ALL
         SELECT '9' ID, 'test' DESCRIPTION, '125' SESSION_UNIQUE_ID FROM DUAL)
SELECT JSON_ARRAYAGG (OBJ)     YOURFINALJSON
  FROM (  SELECT JSON_ARRAYAGG (OBJ)     OBJ
            FROM (SELECT JSON_OBJECT (
                             'id' VALUE ID,
                             'description' VALUE DESCRIPTION,
                             'session_unique_id' VALUE SESSION_UNIQUE_ID)
                             OBJ
                    FROM YOURTABLE) T
        GROUP BY JSON_VALUE (T.OBJ, '$.session_unique_id')) T