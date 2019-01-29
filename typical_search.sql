SELECT name,
  FROM table t
 WHERE NVL (name, ' ') = NVL (NULL, NVL (name, ' '));