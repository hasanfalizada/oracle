SELECT name,
  FROM table t
 WHERE NVL (name, ' ') = NVL (NULL, NVL (name, ' '))
    OR NVL (surname, ' ') = NVL (NULL, NVL (surname, ' '));