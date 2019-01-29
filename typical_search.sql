SELECT name,
  FROM table t
 WHERE NVL (name, ' ') = NVL (NULL, NVL (name, ' '))
   AND NVL (surname, ' ') = NVL (NULL, NVL (surname, ' '));
   AND NVL (age, 0) = NVL (NULL, NVL (age, 0))