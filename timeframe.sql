  SELECT t.batch_date,
           TRUNC (t.batch_date, 'hh24')
         + (TRUNC (TO_CHAR (t.batch_date, 'mi') / 30) * 30) / 24 / 60,
         t.*
    FROM batches t
ORDER BY t.batch_date DESC;