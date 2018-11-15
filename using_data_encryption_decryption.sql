DECLARE
    INPUT_STRING      VARCHAR2 (200) := 'Secret Message';
    OUTPUT_STRING     VARCHAR2 (200);
    ENCRYPTED_RAW     RAW (2000);              -- stores encrypted binary text
    DECRYPTED_RAW     RAW (2000);              -- stores decrypted binary text
    NUM_KEY_BYTES     NUMBER := 256 / 8;     -- key length 256 bits (32 bytes)
    KEY_BYTES_RAW     RAW (32);               -- stores 256-bit encryption key
    ENCRYPTION_TYPE   PLS_INTEGER
        :=                                            -- total encryption type
             DBMS_CRYPTO.ENCRYPT_AES256
           + DBMS_CRYPTO.CHAIN_CBC
           + DBMS_CRYPTO.PAD_PKCS5;
    IV_RAW            RAW (16);
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Original string: ' || INPUT_STRING);
    KEY_BYTES_RAW := DBMS_CRYPTO.RANDOMBYTES (NUM_KEY_BYTES);
    IV_RAW := DBMS_CRYPTO.RANDOMBYTES (16);
    ENCRYPTED_RAW :=
        DBMS_CRYPTO.ENCRYPT (
            SRC   => UTL_I18N.STRING_TO_RAW (INPUT_STRING, 'AL32UTF8'),
            TYP   => ENCRYPTION_TYPE,
            KEY   => KEY_BYTES_RAW,
            IV    => IV_RAW);
    OUTPUT_STRING := UTL_I18N.RAW_TO_CHAR (ENCRYPTED_RAW);
    DBMS_OUTPUT.PUT_LINE ('Encrypted string: ' || ENCRYPTED_RAW);
    -- The encrypted value "encrypted_raw" can be used here
    DECRYPTED_RAW :=
        DBMS_CRYPTO.DECRYPT (SRC   => ENCRYPTED_RAW,
                             TYP   => ENCRYPTION_TYPE,
                             KEY   => KEY_BYTES_RAW,
                             IV    => IV_RAW);
    OUTPUT_STRING := UTL_I18N.RAW_TO_CHAR (DECRYPTED_RAW, 'AL32UTF8');
    DBMS_OUTPUT.PUT_LINE ('Decrypted string: ' || OUTPUT_STRING);
END;

SELECT DBMS_CRYPTO.RANDOMBYTES (16) FROM DUAL;

SELECT DBMS_CRYPTO.RANDOMINTEGER FROM DUAL;

SELECT DBMS_CRYPTO.RANDOMNUMBER FROM DUAL;

SELECT standard_hash ('1', 'SHA512') FROM DUAL;