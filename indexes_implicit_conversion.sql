DECLARE
    TYPE t IS TABLE OF INTEGER
        INDEX BY VARCHAR2 (3);

    tt   t;
BEGIN
    FOR indx IN 1 .. 10
    LOOP
        tt (indx) := 100;   -- Here the magic starts. "indx" is actually of 
                            -- type of VARCHAR2, so, automatic conversion takes 
                            -- place. So, instead of 1,2,3,4,5,6,7,8,9,10 - 
                            -- 49,50,51,52,53,54,55,56,57,49 ASCII codes are 
                            -- being stored respectively.
    END LOOP;

    DBMS_OUTPUT.put_line (tt.COUNT);    -- COUNT is a function that returns the 
                                        -- number of elements in the collection 
                                        -- (ignoring deleted elements, even if 
                                        -- DELETE kept placeholders for them).
                                        -- And the answer is 10.
                                        
    DBMS_OUTPUT.put_line (tt.FIRST);    -- For an associative array indexed by 
                                        -- string, the first and last elements 
                                        -- are those with the lowest and highest 
                                        -- key values, respectively. And the 
                                        -- answer is 1, because of the lowest 
                                        -- ASCII code - 49.
                                        
    DBMS_OUTPUT.put_line (tt.LAST);    -- For an associative array indexed by 
                                       -- string, the first and last elements 
                                       -- are those with the lowest and highest 
                                       -- key values, respectively. And the 
                                       -- answer is 9, because of the highest 
                                       -- ASCII code - 57.
END;