BEGIN 
    FOR i IN (<< set goes here>>) LOOP 
        BEGIN 
           << update statement goes here>> 

            IF SQL%rowcount = 0 THEN 
           << insert statement goes here>>  
            END IF; 
        EXCEPTION 
            WHEN OTHERS THEN 
              dbms_output.Put_line (<< conflict value goes here>> ); 
        END; 
    END LOOP; 
END; 