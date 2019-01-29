SELECT name,
  FROM table t
 WHERE NVL (name, ' ') = NVL (NULL, NVL (name, ' '))
   AND NVL (surname, ' ') = NVL (NULL, NVL (surname, ' '));
   AND NVL (age, 0) = NVL (NULL, NVL (age, 0)) -- In case of number datatype
   AND NVL (cbcc.main, ' ') = CASE WHEN NULL IS NULL THEN ' ' ELSE 'Y' END -- In case of nullable columns