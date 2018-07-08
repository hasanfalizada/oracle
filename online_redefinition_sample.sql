ALTER SESSION FORCE PARALLEL DML;

CREATE TABLE CUST
(
    C_ID      NUMBER PRIMARY KEY,
    C_ZIP     NUMBER,
    C_NAME    VARCHAR (30) DEFAULT NULL,
    C_LOB     CLOB
);

INSERT INTO CUST
     VALUES (1,
             94065,
             'hhh',
             'ttt');

CREATE TABLE CUST_INT
(
    C_ID      NUMBER NOT NULL,
    C_ZIP     NUMBER,
    C_NAME    VARCHAR (30) DEFAULT NULL,
    C_LOB     CLOB
)
LOB (C_LOB) STORE AS SECUREFILE (NOCACHE FILESYSTEM_LIKE_LOGGING);

DECLARE
    COL_MAPPING   VARCHAR2 (1000);
BEGIN
    COL_MAPPING :=
           'c_id c_id , '
        || 'c_zip c_zip , '
        || 'c_name c_name, '
        || 'c_lob c_lob';
    DBMS_REDEFINITION.START_REDEF_TABLE ('bdsm',
                                         'cust',
                                         'cust_int',
                                         COL_MAPPING);
END;
/

DECLARE
    ERROR_COUNT   PLS_INTEGER := 0;
BEGIN
    DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS ('bdsm',
                                             'cust',
                                             'cust_int',
                                             1,
                                             TRUE,
                                             TRUE,
                                             TRUE,
                                             FALSE,
                                             ERROR_COUNT);
    DBMS_OUTPUT.PUT_LINE ('errors := ' || TO_CHAR (ERROR_COUNT));
END;

EXEC DBMS_REDEFINITION.FINISH_REDEF_TABLE('bdsm', 'cust', 'cust_int');

DROP TABLE CUST_INT;

SELECT * FROM CUST;