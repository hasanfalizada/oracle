v_daily_dt_from := CASE
                       WHEN Extract(Hour FROM Localtimestamp) BETWEEN 0 AND 4 THEN
                        To_Date(To_Char(SYSDATE - 1, 'dd.mm.yyyy') || ' 05:00:00', 'dd.mm.yyyy hh24:mi:ss')
                       ELSE
                        To_Date(To_Char(SYSDATE, 'dd.mm.yyyy') || ' 05:00:00', 'dd.mm.yyyy hh24:mi:ss')
                   END;
v_daily_dt_to := CASE
                             WHEN Extract(Hour FROM Localtimestamp) BETWEEN 5 AND 23 THEN
                              To_Date(To_Char(SYSDATE + 1, 'dd.mm.yyyy') || ' 05:00:00', 'dd.mm.yyyy hh24:mi:ss')
                             ELSE
                              To_Date(To_Char(SYSDATE, 'dd.mm.yyyy') || ' 05:00:00', 'dd.mm.yyyy hh24:mi:ss')
                         END;