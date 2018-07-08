WITH
    V1
    AS
        (SELECT 'Field 1 - row 1' F1, 'Field2 - row 1' F2 FROM DUAL
         UNION ALL
         SELECT 'Field 1 - row 2', 'Field2 - row 2' FROM DUAL
         UNION ALL
         SELECT 'Field 1 - row 3', 'Field2 - row 3' FROM DUAL)
SELECT F1, F2
  FROM (SELECT V3.COLUMN_VALUE || '+' || V2.F1 CHANCE_NO, V2.*
          FROM (SELECT * FROM V1) V2,
               TABLE (
                   CAST (
                       MULTISET (    SELECT LEVEL
                                       FROM DUAL
                                 CONNECT BY LEVEL <= 2) AS SYS.ODCINUMBERLIST))
               V3);