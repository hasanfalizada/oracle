CREATE OR REPLACE FUNCTION MASK_PAN (IN_PAN IN VARCHAR2)
    RETURN VARCHAR2
IS
    MASKED_PAN   VARCHAR2 (20);
BEGIN
    IF IN_PAN IS NOT NULL
    THEN
        MASKED_PAN :=
               SUBSTR (NVL (IN_PAN, '****'), 1, 6)
            || '******'
            || SUBSTR (NVL (IN_PAN, '****'), 13, 4);
    ELSIF IN_PAN IS NULL
    THEN
        MASKED_PAN := NULL;
    ELSE
        MASKED_PAN := NULL;
    END IF;

    RETURN MASKED_PAN;
END;