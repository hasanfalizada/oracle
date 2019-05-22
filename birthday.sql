/* Detecting if somebody is eligible for campaign, if today is his birthday. Also, 3 days after birthday is ok. */
SELECT 'Today I''m happy!'
  FROM DUAL
WHERE (  TRUNC (SYSDATE)
        - TO_DATE (
                TO_CHAR (TO_DATE ('21051990', 'ddmmyyyy'), 'ddmm')
             || TO_CHAR (SYSDATE, 'yyyy'),
             'dd.mm.yyyy')) BETWEEN 0
                                AND 3