WITH
    letters
    AS
        (SELECT 'a' letter FROM DUAL
         UNION ALL
         SELECT 'b' letter FROM DUAL
         UNION ALL
         SELECT 'c' letter FROM DUAL
         UNION ALL
         SELECT 'd' letter FROM DUAL
         UNION ALL
         SELECT 'e' letter FROM DUAL
         UNION ALL
         SELECT 'm' letter FROM DUAL)
SELECT letter , next_letter
  FROM (SELECT letter,
               LEAD (letter) OVER (ORDER BY ROWNUM)     next_letter,
               MOD (ROWNUM, 2)                          m
          FROM letters)
 WHERE m = 1;