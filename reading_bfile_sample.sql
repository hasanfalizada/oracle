DECLARE
    FIL   BFILE;
    POS   INTEGER;
    AMT   BINARY_INTEGER;
    BUF   RAW (40);
BEGIN
    SELECT AD_GRAPHIC
      INTO FIL
      FROM PRINT_MEDIA
     WHERE PRODUCT_ID = 3106;

    DBMS_LOB.OPEN (FIL, DBMS_LOB.LOB_READONLY);
    AMT := 40;
    POS := 1 + DBMS_LOB.GETLENGTH (FIL);
    BUF := '';
    DBMS_LOB.READ (FIL,
                   AMT,
                   POS,
                   BUF);
    DBMS_OUTPUT.PUT_LINE (
        'Read F1 past EOF: ' || UTL_RAW.CAST_TO_VARCHAR2 (BUF));
    DBMS_LOB.CLOSE (FIL);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('End of File reached. Closing file');
            DBMS_LOB.FILECLOSE (FIL);
        END;
END;