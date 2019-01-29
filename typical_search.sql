SELECT name,
  FROM table t
 WHERE NVL (name, ' ') = NVL (NULL, NVL (name, ' '))
   AND NVL (surname, ' ') = NVL (NULL, NVL (surname, ' '));
   AND NVL (age, 0) = NVL (NULL, NVL (age, 0)) -- In case of number datatype
   AND 'MAIN' = CASE
                       WHEN p_main IS NULL OR p_main NOT IN ('Y', 'N') THEN
                        'MAIN'
                       WHEN p_main = 'N' THEN
                        Nvl(Cbcc.Main, 'MAIN')
                       WHEN p_main = 'Y' THEN
                        CASE Cbcc.Main
                            WHEN 'Y' THEN
                             'MAIN'
                            ELSE
                            'NOT MAIN'
                        END
                   END; -- In case of nullable columns