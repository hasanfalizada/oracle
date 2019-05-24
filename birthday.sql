/* Detecting if somebody is eligible for campaign, if today is his birthday. Also, 3 days after birthday is ok. Leap year is reaplced by 28th. */
WITH t
     AS (SELECT 'X' dummy, TO_DATE ('21051990', 'ddmmyyyy') birthday
           FROM DUAL)
SELECT 'Today I''m happy!' MESSAGE
  FROM DUAL d LEFT JOIN t ON d.dummy = t.dummy
 WHERE (  TRUNC (SYSDATE)
        - TO_DATE (
                TO_CHAR (
                   CASE
                      WHEN     EXTRACT (DAY FROM t.birthday) = 29
                           AND EXTRACT (MONTH FROM t.birthday) = 2
                      THEN
                         TO_DATE ('2802' || EXTRACT (YEAR FROM t.birthday),
                                  'ddmmyyyy')
                      ELSE
                         t.birthday
                   END,
                   'ddmm')
             || TO_CHAR (SYSDATE, 'yyyy'),
             'ddmmyyyy')) BETWEEN 0
                              AND 3