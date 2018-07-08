/********************************************************************** 
/* 
/* Filename: bdsm.sql 
/* Component: Component_Name 
/* Package: BDSM 
/* Designer: Hasan Alizada 
/* Developer: Hasan Alizada 
/* Version: 1.0 
/* Copyright (c) 2018, Hasan Alizada.  All rights reserved. 
/* 
/* Description: BDSM (Basic Developer Software Management - consonant 
/* with DBMS - don't confuse with Sadomasochism) is PL/SQL package,
/* helping you to start development in Oracle RDBMS.
/*
/* Run this script under SYS.
/*
/* This schema should be installed only on development database.
/* 
/**********************************************************************/

CREATE USER BDSM IDENTIFIED BY BDSM QUOTA UNLIMITED ON USERS;
GRANT CREATE SESSION TO BDSM;
GRANT RESOURCE TO BDSM;
GRANT SELECT ANY TABLE TO BDSM;
GRANT EXEMPT ACCESS POLICY TO BDSM;
GRANT EXP_FULL_DATABASE TO BDSM;
GRANT EXECUTE ON DBMS_REDEFINITION TO BDSM;
GRANT ALTER ANY TABLE TO BDSM;
GRANT DROP ANY TABLE TO BDSM;
GRANT LOCK ANY TABLE TO BDSM;
GRANT CREATE ANY TABLE TO BDSM;
GRANT SELECT ANY TABLE TO BDSM;
GRANT CREATE ANY TRIGGER TO BDSM;
GRANT CREATE ANY INDEX TO BDSM;
GRANT CREATE TABLE TO BDSM;
GRANT CREATE VIEW TO BDSM;
GRANT CREATE JOB TO BDSM;
GRANT CREATE SEQUENCE TO BDSM;
GRANT CREATE TRIGGER TO BDSM;
GRANT CREATE PROCEDURE TO BDSM;
GRANT CREATE SYNONYM TO BDSM;
GRANT CREATE PUBLIC SYNONYM TO BDSM;
GRANT CREATE ANY CONTEXT TO BDSM;
GRANT CREATE ANY DIRECTORY TO BDSM;
GRANT CREATE JOB TO BDSM;
GRANT DROP ANY CONTEXT TO BDSM;
GRANT CREATE ANY TRIGGER TO BDSM;
GRANT ADMINISTER DATABASE TRIGGER TO BDSM;
GRANT ADVISOR TO BDSM;
GRANT EXECUTE ON DBMS_TRACE TO BDSM;
GRANT EXECUTE ON DBMS_RLS TO BDSM;
GRANT EXECUTE ON DBMS_FGA TO BDSM;
GRANT EXECUTE ON DBMS_CRYPTO TO BDSM;
GRANT EXECUTE ON DBMS_RESULT_CACHE TO BDSM;
GRANT EXECUTE ON DBMS_PIPE TO BDSM;
GRANT EXECUTE ON DBMS_PROFILER TO BDSM;
GRANT EXECUTE ON DBMS_LOCK TO BDSM;
GRANT EXECUTE ON DBMS_HPROF TO BDSM;
GRANT EXECUTE ON DBMS_MONITOR TO BDSM;
GRANT SELECT ON V_$LATCH TO BDSM;
GRANT SELECT ON V_$THREAD TO BDSM;
GRANT SELECT ON V_$SESSION_WAIT TO BDSM;
GRANT SELECT ON V_$RESULT_CACHE_STATISTICS TO BDSM;
GRANT SELECT ON V_$RESULT_CACHE_MEMORY TO BDSM;
GRANT SELECT ON V_$RESULT_CACHE_OBJECTS TO BDSM;
GRANT SELECT ON V_$RESULT_CACHE_DEPENDENCY TO BDSM;
GRANT SELECT ON V_$PROCESS TO BDSM;
GRANT SELECT ON V_$PROCESS_MEMORY TO BDSM;
GRANT SELECT ON V_$SESSION TO BDSM;
GRANT SELECT ON V_$LOCK TO BDSM;
GRANT SELECT ON V_$LOCK_TYPE TO BDSM;
GRANT SELECT ON V_$RESERVED_WORDS TO BDSM;
GRANT SELECT ON V_$SQL TO BDSM;
GRANT SELECT ON V_$SYSAUX_OCCUPANTS TO BDSM;
GRANT SELECT ON V_$SQL_PLAN TO BDSM;
GRANT SELECT ON V_$SQLAREA TO BDSM;
GRANT SELECT ON V_$SESSTAT TO BDSM;
GRANT SELECT ON V_$EVENT_NAME TO BDSM;
GRANT SELECT ON V_$STATNAME TO BDSM;
GRANT SELECT ON V_$MYSTAT TO BDSM;
GRANT SELECT ON V_$SGASTAT TO BDSM;
GRANT SELECT ON V_$INSTANCE TO BDSM;
GRANT SELECT ON V_$DATABASE TO BDSM;
GRANT SELECT ON V_$PROCESS TO BDSM;
GRANT SELECT ON V_$DATAFILE TO BDSM;
GRANT SELECT ON V_$TABLESPACE TO BDSM;
GRANT SELECT ON V_$TRANSACTION TO BDSM;
GRANT SELECT ON DBA_PARALLEL_EXECUTE_CHUNKS TO BDSM;
GRANT SELECT ON DBA_PARALLEL_EXECUTE_TASKS TO BDSM;
GRANT SELECT ON DBA_ROLE_PRIVS TO BDSM;
GRANT SELECT ON DBA_SYS_PRIVS TO BDSM;
GRANT SELECT ON DBA_OBJECTS TO BDSM;
GRANT SELECT ON DBA_LOCKS TO BDSM;
GRANT SELECT ON DBA_AUTOTASK_CLIENT TO BDSM;
GRANT SELECT ON DBA_ADVISOR_LOG TO BDSM;
GRANT SELECT ON DBA_TABLESPACES TO BDSM;
GRANT SELECT ON DBA_CPOOL_INFO TO BDSM;
GRANT SELECT ON DBA_AUDIT_OBJECT TO BDSM;
GRANT SELECT ON DBA_AUDIT_SESSION TO BDSM;
GRANT SELECT ON DBA_DATA_FILES TO BDSM;
GRANT SELECT ON DBA_HIST_SQLSTAT TO BDSM;
GRANT SELECT ON DBA_HIST_SNAPSHOT TO BDSM;
GRANT SELECT ON DBA_HIST_SQLTEXT TO BDSM;
GRANT SELECT ON DBA_FGA_AUDIT_TRAIL TO BDSM;
GRANT SELECT ON DBA_FREE_SPACE TO BDSM;
GRANT SELECT ON PLSQL_TRACE_EVENTS TO BDSM;
GRANT SELECT ON PLSQL_TRACE_RUNS TO BDSM;
GRANT SELECT ON UNIFIED_AUDIT_TRAIL TO BDSM;
GRANT ALTER SYSTEM TO BDSM;

CREATE TABLE BDSM.LOG_LOB
(
    ID      INTEGER CONSTRAINT PK_LOG_LOB PRIMARY KEY,
    DATA    NCLOB
);


CREATE TABLE BDSM.LOG_SEVERITY
(
    ID      INTEGER CONSTRAINT PK_LOG_SEVERITY PRIMARY KEY,
    NAME    VARCHAR2 (10 CHAR)
);


CREATE TABLE BDSM.LOG
(
    LOG_ID                    INTEGER CONSTRAINT PK_LOG_ID PRIMARY KEY,
    LOG_SEVERITY_ID           INTEGER
                                 CONSTRAINT FK_SEVERITY_ID
                                     REFERENCES BDSM.LOG_SEVERITY (ID),
    LOG_TIMESTAMP             DATE,
    LOG_DEBUG_FLAG            VARCHAR2 (1 CHAR),
    LOG_DEBUG_SESSION_INFO    NCLOB,
    LOG_MESSAGE               VARCHAR2 (4000 CHAR),
    LOG_DEBUG_PARAMETERS      NCLOB
);

INSERT INTO BDSM.LOG_SEVERITY
     VALUES (0, 'INFO');

INSERT INTO BDSM.LOG_SEVERITY
     VALUES (1, 'MINOR');

INSERT INTO BDSM.LOG_SEVERITY
     VALUES (2, 'MAJOR');

INSERT INTO BDSM.LOG_SEVERITY
     VALUES (3, 'CRITICAL');

INSERT INTO BDSM.LOG_SEVERITY
     VALUES (4, 'BLOCKER');

COMMIT;

CREATE TYPE BDSM.MAP_RECORD AS OBJECT
(
    KEY VARCHAR2 (500),
    VALUE VARCHAR2 (500)
);

CREATE TYPE BDSM.MAP AS TABLE OF BDSM.MAP_RECORD;

CREATE SEQUENCE BDSM.LOG_SEQUENCE;

CREATE OR REPLACE PACKAGE BDSM.P
IS
    PROCEDURE SAY (MESSAGE IN VARCHAR2);

    FUNCTION SINFO
        RETURN NCLOB;

    PROCEDURE LOG (SEVERITY_ID        IN BDSM.LOG.LOG_SEVERITY_ID%TYPE,
                   LOG_MESSAGE        IN BDSM.LOG.LOG_MESSAGE%TYPE,
                   DEBUG_PARAMETERS   IN BDSM.MAP DEFAULT NULL,
                   ENABLE_DEBUG       IN BOOLEAN DEFAULT FALSE);

    FUNCTION SETLOB (LOB_DATA IN NCLOB)
        RETURN INTEGER;

    FUNCTION GETLOB (LOB_ID IN INTEGER)
        RETURN NCLOB;

    PROCEDURE CUR (IN_CUR IN SYS_REFCURSOR);
END;
/

CREATE OR REPLACE PACKAGE BODY BDSM.P
IS
    PROCEDURE SAY (MESSAGE IN VARCHAR2)
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE (MESSAGE);
    END;

    FUNCTION SINFO
        RETURN NCLOB
    IS
        SESSION_INFO_LOB   NCLOB;
        SESSION_INFO       BDSM.MAP
                               := BDSM.MAP (
                                      BDSM.MAP_RECORD (
                                          'ACTION',
                                          SYS_CONTEXT ('userenv', 'ACTION')),
                                      BDSM.MAP_RECORD (
                                          'AUDITED_CURSORID',
                                          SYS_CONTEXT ('userenv',
                                                       'AUDITED_CURSORID')),
                                      BDSM.MAP_RECORD (
                                          'AUTHENTICATED_IDENTITY',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'AUTHENTICATED_IDENTITY')),
                                      BDSM.MAP_RECORD (
                                          'AUTHENTICATION_DATA',
                                          SYS_CONTEXT ('userenv',
                                                       'AUTHENTICATION_DATA')),
                                      BDSM.MAP_RECORD (
                                          'AUTHENTICATION_METHOD',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'AUTHENTICATION_METHOD')),
                                      BDSM.MAP_RECORD (
                                          'BG_JOB_ID',
                                          SYS_CONTEXT ('userenv',
                                                       'BG_JOB_ID')),
                                      BDSM.MAP_RECORD (
                                          'CDB_NAME',
                                          SYS_CONTEXT ('userenv', 'CDB_NAME')),
                                      BDSM.MAP_RECORD (
                                          'CLIENT_IDENTIFIER',
                                          SYS_CONTEXT ('userenv',
                                                       'CLIENT_IDENTIFIER')),
                                      BDSM.MAP_RECORD (
                                          'CLIENT_INFO',
                                          SYS_CONTEXT ('userenv',
                                                       'CLIENT_INFO')),
                                      BDSM.MAP_RECORD (
                                          'CLIENT_PROGRAM_NAME',
                                          SYS_CONTEXT ('userenv',
                                                       'CLIENT_PROGRAM_NAME')),
                                      BDSM.MAP_RECORD (
                                          'CON_ID',
                                          SYS_CONTEXT ('userenv', 'CON_ID')),
                                      BDSM.MAP_RECORD (
                                          'CON_NAME',
                                          SYS_CONTEXT ('userenv', 'CON_NAME')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_BIND',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_BIND')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_EDITION_ID',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_EDITION_ID')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_EDITION_NAME',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'CURRENT_EDITION_NAME')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_SCHEMA',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_SCHEMA')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_SCHEMAID',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_SCHEMAID')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_SQL',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_SQL')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_SQL_LENGTH',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_SQL_LENGTH')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_USER',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_USER')),
                                      BDSM.MAP_RECORD (
                                          'CURRENT_USERID',
                                          SYS_CONTEXT ('userenv',
                                                       'CURRENT_USERID')),
                                      BDSM.MAP_RECORD (
                                          'DATABASE_ROLE',
                                          SYS_CONTEXT ('userenv',
                                                       'DATABASE_ROLE')),
                                      BDSM.MAP_RECORD (
                                          'DB_DOMAIN',
                                          SYS_CONTEXT ('userenv',
                                                       'DB_DOMAIN')),
                                      BDSM.MAP_RECORD (
                                          'DB_NAME',
                                          SYS_CONTEXT ('userenv', 'DB_NAME')),
                                      BDSM.MAP_RECORD (
                                          'DB_SUPPLEMENTAL_LOG_LEVEL',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'DB_SUPPLEMENTAL_LOG_LEVEL')),
                                      BDSM.MAP_RECORD (
                                          'DB_UNIQUE_NAME',
                                          SYS_CONTEXT ('userenv',
                                                       'DB_UNIQUE_NAME')),
                                      BDSM.MAP_RECORD (
                                          'DBLINK_INFO',
                                          SYS_CONTEXT ('userenv',
                                                       'DBLINK_INFO')),
                                      BDSM.MAP_RECORD (
                                          'ENTRYID',
                                          SYS_CONTEXT ('userenv', 'ENTRYID')),
                                      BDSM.MAP_RECORD (
                                          'ENTERPRISE_IDENTITY',
                                          SYS_CONTEXT ('userenv',
                                                       'ENTERPRISE_IDENTITY')),
                                      BDSM.MAP_RECORD (
                                          'FG_JOB_ID',
                                          SYS_CONTEXT ('userenv',
                                                       'FG_JOB_ID')),
                                      BDSM.MAP_RECORD (
                                          'GLOBAL_CONTEXT_MEMORY',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'GLOBAL_CONTEXT_MEMORY')),
                                      BDSM.MAP_RECORD (
                                          'GLOBAL_UID',
                                          SYS_CONTEXT ('userenv',
                                                       'GLOBAL_UID')),
                                      BDSM.MAP_RECORD (
                                          'HOST',
                                          SYS_CONTEXT ('userenv', 'HOST')),
                                      BDSM.MAP_RECORD (
                                          'IDENTIFICATION_TYPE',
                                          SYS_CONTEXT ('userenv',
                                                       'IDENTIFICATION_TYPE')),
                                      BDSM.MAP_RECORD (
                                          'INSTANCE',
                                          SYS_CONTEXT ('userenv', 'INSTANCE')),
                                      BDSM.MAP_RECORD (
                                          'INSTANCE_NAME',
                                          SYS_CONTEXT ('userenv',
                                                       'INSTANCE_NAME')),
                                      BDSM.MAP_RECORD (
                                          'IP_ADDRESS',
                                          SYS_CONTEXT ('userenv',
                                                       'IP_ADDRESS')),
                                      BDSM.MAP_RECORD (
                                          'IS_APPLY_SERVER',
                                          SYS_CONTEXT ('userenv',
                                                       'IS_APPLY_SERVER')),
                                      BDSM.MAP_RECORD (
                                          'IS_DG_ROLLING_UPGRADE',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'IS_DG_ROLLING_UPGRADE')),
                                      BDSM.MAP_RECORD (
                                          'ISDBA',
                                          SYS_CONTEXT ('userenv', 'ISDBA')),
                                      BDSM.MAP_RECORD (
                                          'LANG',
                                          SYS_CONTEXT ('userenv', 'LANG')),
                                      BDSM.MAP_RECORD (
                                          'LANGUAGE',
                                          SYS_CONTEXT ('userenv', 'LANGUAGE')),
                                      BDSM.MAP_RECORD (
                                          'MODULE',
                                          SYS_CONTEXT ('userenv', 'MODULE')),
                                      BDSM.MAP_RECORD (
                                          'NETWORK_PROTOCOL',
                                          SYS_CONTEXT ('userenv',
                                                       'NETWORK_PROTOCOL')),
                                      BDSM.MAP_RECORD (
                                          'NLS_CALENDAR',
                                          SYS_CONTEXT ('userenv',
                                                       'NLS_CALENDAR')),
                                      BDSM.MAP_RECORD (
                                          'NLS_CURRENCY',
                                          SYS_CONTEXT ('userenv',
                                                       'NLS_CURRENCY')),
                                      BDSM.MAP_RECORD (
                                          'NLS_DATE_FORMAT',
                                          SYS_CONTEXT ('userenv',
                                                       'NLS_DATE_FORMAT')),
                                      BDSM.MAP_RECORD (
                                          'NLS_DATE_LANGUAGE',
                                          SYS_CONTEXT ('userenv',
                                                       'NLS_DATE_LANGUAGE')),
                                      BDSM.MAP_RECORD (
                                          'NLS_SORT',
                                          SYS_CONTEXT ('userenv', 'NLS_SORT')),
                                      BDSM.MAP_RECORD (
                                          'NLS_TERRITORY',
                                          SYS_CONTEXT ('userenv',
                                                       'NLS_TERRITORY')),
                                      BDSM.MAP_RECORD (
                                          'ORACLE_HOME',
                                          SYS_CONTEXT ('userenv',
                                                       'ORACLE_HOME')),
                                      BDSM.MAP_RECORD (
                                          'OS_USER',
                                          SYS_CONTEXT ('userenv', 'OS_USER')),
                                      BDSM.MAP_RECORD (
                                          'PLATFORM_SLASH',
                                          SYS_CONTEXT ('userenv',
                                                       'PLATFORM_SLASH')),
                                      BDSM.MAP_RECORD (
                                          'POLICY_INVOKER',
                                          SYS_CONTEXT ('userenv',
                                                       'POLICY_INVOKER')),
                                      BDSM.MAP_RECORD (
                                          'PROXY_ENTERPRISE_IDENTITY',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'PROXY_ENTERPRISE_IDENTITY')),
                                      BDSM.MAP_RECORD (
                                          'PROXY_USER',
                                          SYS_CONTEXT ('userenv',
                                                       'PROXY_USER')),
                                      BDSM.MAP_RECORD (
                                          'PROXY_USERID',
                                          SYS_CONTEXT ('userenv',
                                                       'PROXY_USERID')),
                                      BDSM.MAP_RECORD (
                                          'SERVER_HOST',
                                          SYS_CONTEXT ('userenv',
                                                       'SERVER_HOST')),
                                      BDSM.MAP_RECORD (
                                          'SERVICE_NAME',
                                          SYS_CONTEXT ('userenv',
                                                       'SERVICE_NAME')),
                                      BDSM.MAP_RECORD (
                                          'SESSION_EDITION_ID',
                                          SYS_CONTEXT ('userenv',
                                                       'SESSION_EDITION_ID')),
                                      BDSM.MAP_RECORD (
                                          'SESSION_EDITION_NAME',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'SESSION_EDITION_NAME')),
                                      BDSM.MAP_RECORD (
                                          'SESSION_USER',
                                          SYS_CONTEXT ('userenv',
                                                       'SESSION_USER')),
                                      BDSM.MAP_RECORD (
                                          'SESSION_USERID',
                                          SYS_CONTEXT ('userenv',
                                                       'SESSION_USERID')),
                                      BDSM.MAP_RECORD (
                                          'SESSIONID',
                                          SYS_CONTEXT ('userenv',
                                                       'SESSIONID')),
                                      BDSM.MAP_RECORD (
                                          'SID',
                                          SYS_CONTEXT ('userenv', 'SID')),
                                      BDSM.MAP_RECORD (
                                          'STATEMENTID',
                                          SYS_CONTEXT ('userenv',
                                                       'STATEMENTID')),
                                      BDSM.MAP_RECORD (
                                          'TERMINAL',
                                          SYS_CONTEXT ('userenv', 'TERMINAL')),
                                      BDSM.MAP_RECORD (
                                          'UNIFIED_AUDIT_SESSIONID',
                                          SYS_CONTEXT (
                                              'userenv',
                                              'UNIFIED_AUDIT_SESSIONID')));
    BEGIN
        FOR REC IN (SELECT * FROM TABLE (SESSION_INFO))
        LOOP
            IF REC.VALUE IS NOT NULL
            THEN
                SESSION_INFO_LOB :=
                       SESSION_INFO_LOB
                    || REC.KEY
                    || '  ::::::::::::::::::::::::::::::::::::::  '
                    || REC.VALUE
                    || CHR (10);
            END IF;
        END LOOP;

        RETURN SESSION_INFO_LOB;
    END;

    PROCEDURE LOG (SEVERITY_ID        IN BDSM.LOG.LOG_SEVERITY_ID%TYPE,
                   LOG_MESSAGE        IN BDSM.LOG.LOG_MESSAGE%TYPE,
                   DEBUG_PARAMETERS   IN BDSM.MAP DEFAULT NULL,
                   ENABLE_DEBUG       IN BOOLEAN DEFAULT FALSE)
    IS
        DEBUG_FLAG              BDSM.LOG.LOG_DEBUG_FLAG%TYPE
                                    := CASE WHEN LOG.ENABLE_DEBUG THEN 'Y' ELSE NULL END;
        DEBUG_PARAMETERS_LOB    NCLOB;
        SESSION_INFO_LOB        NCLOB
            := CASE WHEN LOG.ENABLE_DEBUG THEN SINFO () ELSE NULL END;
        INCORRECT_SEVERITY_ID   EXCEPTION;
        PRAGMA EXCEPTION_INIT (INCORRECT_SEVERITY_ID, -02291);
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        IF DEBUG_PARAMETERS IS NOT NULL
        THEN
            FOR REC IN (SELECT * FROM TABLE (DEBUG_PARAMETERS))
            LOOP
                DEBUG_PARAMETERS_LOB :=
                       DEBUG_PARAMETERS_LOB
                    || REC.KEY
                    || '  ::::::::::::::::::::::::::::::::::::::  '
                    || REC.VALUE
                    || CHR (10);
            END LOOP;
        END IF;

        INSERT INTO BDSM.LOG (LOG_ID,
                              LOG_SEVERITY_ID,
                              LOG_TIMESTAMP,
                              LOG_DEBUG_FLAG,
                              LOG_DEBUG_SESSION_INFO,
                              LOG_MESSAGE,
                              LOG_DEBUG_PARAMETERS)
             VALUES (BDSM.LOG_SEQUENCE.NEXTVAL,
                     LOG.SEVERITY_ID,
                     SYSDATE,
                     DEBUG_FLAG,
                     SESSION_INFO_LOB,
                     LOG.LOG_MESSAGE,
                     DEBUG_PARAMETERS_LOB);

        COMMIT;
    EXCEPTION
        WHEN INCORRECT_SEVERITY_ID
        THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR (-20666, 'Log severity ID is wrong!');
    END;

    FUNCTION SETLOB (LOB_DATA IN NCLOB)
        RETURN INTEGER
    IS
        OUT_SEQUENCE_ID   INTEGER;
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO BDSM.LOG_LOB (ID, DATA)
             VALUES (BDSM.LOG_SEQUENCE.NEXTVAL, LOB_DATA)
             RETURN ID
               INTO OUT_SEQUENCE_ID;

        COMMIT;

        RETURN OUT_SEQUENCE_ID;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            RAISE;
    END;

    FUNCTION GETLOB (LOB_ID IN INTEGER)
        RETURN NCLOB
    IS
        OUT_LOB   NCLOB;
    BEGIN
        SELECT DATA
          INTO OUT_LOB
          FROM BDSM.LOG_LOB
         WHERE ID = LOB_ID;

        RETURN OUT_LOB;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            OUT_LOB := NULL;
            RETURN OUT_LOB;
    END;

    PROCEDURE CUR (IN_CUR IN SYS_REFCURSOR)
    IS
        CURID     NUMBER;
        DESCTAB   DBMS_SQL.DESC_TAB3;
        COLCNT    NUMBER;
        INT_CUR   SYS_REFCURSOR;
    BEGIN
        INT_CUR := IN_CUR;
        CURID := DBMS_SQL.TO_CURSOR_NUMBER (INT_CUR);
        DBMS_SQL.DESCRIBE_COLUMNS3 (CURID, COLCNT, DESCTAB);

        FOR I IN 1 .. COLCNT
        LOOP
            DBMS_OUTPUT.PUT_LINE (
                   'COL_TYPE: '
                || DESCTAB (I).COL_TYPE
                || ', '
                || 'COL_MAX_LEN: '
                || DESCTAB (I).COL_MAX_LEN
                || ', '
                || 'COL_NAME: '
                || DESCTAB (I).COL_NAME
                || ', '
                || 'COL_NAME_LEN: '
                || DESCTAB (I).COL_NAME_LEN
                || ', '
                || 'COL_SCHEMA_NAME: '
                || DESCTAB (I).COL_SCHEMA_NAME
                || ', '
                || 'COL_SCHEMA_NAME_LEN: '
                || DESCTAB (I).COL_SCHEMA_NAME_LEN
                || ', '
                || 'COL_PRECISION: '
                || DESCTAB (I).COL_PRECISION
                || ', '
                || 'COL_SCALE: '
                || DESCTAB (I).COL_SCALE
                || ', '
                || 'COL_CHARSETID: '
                || DESCTAB (I).COL_CHARSETID
                || ', '
                || 'COL_CHARSETFORM: '
                || DESCTAB (I).COL_CHARSETFORM
                || ', '
                || 'COL_NULL_OK: '
                || CASE
                       WHEN DESCTAB (I).COL_NULL_OK THEN 'TRUE'
                       ELSE 'FALSE'
                   END
                || ', '
                || 'COL_TYPE_NAME: '
                || DESCTAB (I).COL_TYPE_NAME
                || ', '
                || 'COL_TYPE_NAME_LEN: '
                || DESCTAB (I).COL_TYPE_NAME_LEN);
        END LOOP;

        DBMS_SQL.CLOSE_CURSOR (CURID);
    END;
END;
/


CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_ALTER_TRIGGER
    BEFORE ALTER
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    OLD_DDL_LOB_ID                INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);
    OLD_DDL_LOB_ID :=
        BDSM.P.SETLOB (
            DBMS_METADATA.GET_DDL (OBJECT_TYPE   => ORA_DICT_OBJ_TYPE,
                                   NAME          => ORA_DICT_OBJ_NAME,
                                   SCHEMA        => ORA_DICT_OBJ_OWNER));

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been altered!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;'),
                                 BDSM.MAP_RECORD (
                                     'Old DDL ',
                                        'SELECT p.getlob (lob_id => '
                                     || OLD_DDL_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_ANALYZE_TRIGGER
    BEFORE ANALYZE
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been analyzed!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/


CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_ASSOCIATE_STATISTICS_TRIGGER
    BEFORE ASSOCIATE STATISTICS
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been associated with statistics!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_AUDIT_TRIGGER
    BEFORE AUDIT
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been audited!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_COMMENT_TRIGGER
    BEFORE COMMENT
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    OLD_DDL_LOB_ID                INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);
    OLD_DDL_LOB_ID :=
        BDSM.P.SETLOB (
            DBMS_METADATA.GET_DDL (OBJECT_TYPE   => ORA_DICT_OBJ_TYPE,
                                   NAME          => ORA_DICT_OBJ_NAME,
                                   SCHEMA        => ORA_DICT_OBJ_OWNER));

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been commented!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;'),
                                 BDSM.MAP_RECORD (
                                     'Old DDL ',
                                        'SELECT p.getlob (lob_id => '
                                     || OLD_DDL_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_CREATE_TRIGGER
    BEFORE CREATE
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been created!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_DISASSOCIATE_STATISTICS_TRIGGER
    BEFORE DISASSOCIATE STATISTICS
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been disassociated with statistics!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_DROP_TRIGGER
    BEFORE DROP
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    OLD_DDL_LOB_ID                INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);
    OLD_DDL_LOB_ID :=
        BDSM.P.SETLOB (
            DBMS_METADATA.GET_DDL (OBJECT_TYPE   => ORA_DICT_OBJ_TYPE,
                                   NAME          => ORA_DICT_OBJ_NAME,
                                   SCHEMA        => ORA_DICT_OBJ_OWNER));

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been dropped!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;'),
                                 BDSM.MAP_RECORD (
                                     'Old DDL ',
                                        'SELECT p.getlob (lob_id => '
                                     || OLD_DDL_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_GRANT_TRIGGER
    BEFORE GRANT
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been granted!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_NOAUDIT_TRIGGER
    BEFORE NOAUDIT
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been unaudited!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_RENAME_TRIGGER
    BEFORE RENAME
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    OLD_DDL_LOB_ID                INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);
    OLD_DDL_LOB_ID :=
        BDSM.P.SETLOB (
            DBMS_METADATA.GET_DDL (OBJECT_TYPE   => ORA_DICT_OBJ_TYPE,
                                   NAME          => ORA_DICT_OBJ_NAME,
                                   SCHEMA        => ORA_DICT_OBJ_OWNER));

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been renamed!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;'),
                                 BDSM.MAP_RECORD (
                                     'Old DDL ',
                                        'SELECT p.getlob (lob_id => '
                                     || OLD_DDL_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_REVOKE_TRIGGER
    BEFORE REVOKE
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been revoked!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE OR REPLACE TRIGGER SYS.BDSM_BEFORE_TRUNCATE_TRIGGER
    BEFORE TRUNCATE
    ON DATABASE
DECLARE
    SQL_STATEMENT                 ORA_NAME_LIST_T;
    SQL_STATEMENT_ROWS_COUNT      PLS_INTEGER;
    SQL_STATEMENT_PARSED          NCLOB;
    SQL_STATEMENT_PARSED_LOB_ID   INTEGER;
    UNIT_NOT_FOUND_EXCEPTION      EXCEPTION;
    PRAGMA EXCEPTION_INIT (UNIT_NOT_FOUND_EXCEPTION, -31603);
BEGIN
    SQL_STATEMENT_ROWS_COUNT := ORA_SQL_TXT (SQL_STATEMENT);

    FOR I IN 1 .. SQL_STATEMENT_ROWS_COUNT
    LOOP
        SQL_STATEMENT_PARSED := SQL_STATEMENT_PARSED || SQL_STATEMENT (I);
    END LOOP;

    SQL_STATEMENT_PARSED_LOB_ID := BDSM.P.SETLOB (SQL_STATEMENT_PARSED);

    BDSM.P.LOG (
        SEVERITY_ID        => 0,
        LOG_MESSAGE        =>
               'Database '
            || ORA_DICT_OBJ_TYPE
            || ' '
            || ORA_DICT_OBJ_OWNER
            || '.'
            || ORA_DICT_OBJ_NAME
            || ' has been truncated!',
        DEBUG_PARAMETERS   => BDSM.MAP (
                                 BDSM.MAP_RECORD ('IP address ',
                                                  ORA_CLIENT_IP_ADDRESS),
                                 BDSM.MAP_RECORD ('Database name ',
                                                  ORA_DATABASE_NAME),
                                 BDSM.MAP_RECORD ('Object name ',
                                                  ORA_DICT_OBJ_NAME),
                                 BDSM.MAP_RECORD ('Object owner ',
                                                  ORA_DICT_OBJ_OWNER),
                                 BDSM.MAP_RECORD ('Object type ',
                                                  ORA_DICT_OBJ_TYPE),
                                 BDSM.MAP_RECORD ('Login user ',
                                                  ORA_LOGIN_USER),
                                 BDSM.MAP_RECORD ('Event ', ORA_SYSEVENT),
                                 BDSM.MAP_RECORD (
                                     'Statement ',
                                        'SELECT p.getlob (lob_id => '
                                     || SQL_STATEMENT_PARSED_LOB_ID
                                     || ') lob_data FROM DUAL;')),
        ENABLE_DEBUG       => TRUE);
EXCEPTION
    WHEN UNIT_NOT_FOUND_EXCEPTION
    THEN
        NULL;
END;
/

CREATE TABLE BDSM.PLSQL_PROFILER_RUNS
(
    RUNID              NUMBER PRIMARY KEY,
    RELATED_RUN        NUMBER,
    RUN_OWNER          VARCHAR2 (128),
    RUN_DATE           DATE,
    RUN_COMMENT        VARCHAR2 (2047),
    RUN_TOTAL_TIME     NUMBER,
    RUN_SYSTEM_INFO    VARCHAR2 (2047),
    RUN_COMMENT1       VARCHAR2 (2047),
    SPARE1             VARCHAR2 (256)
);

COMMENT ON TABLE BDSM.PLSQL_PROFILER_RUNS IS
    'Run-specific information for the PL/SQL profiler';

CREATE TABLE BDSM.PLSQL_PROFILER_UNITS
(
    RUNID             NUMBER REFERENCES BDSM.PLSQL_PROFILER_RUNS,
    UNIT_NUMBER       NUMBER,
    UNIT_TYPE         VARCHAR2 (128),
    UNIT_OWNER        VARCHAR2 (128),
    UNIT_NAME         VARCHAR2 (128),
    UNIT_TIMESTAMP    DATE,
    TOTAL_TIME        NUMBER DEFAULT 0 NOT NULL,
    SPARE1            NUMBER,
    SPARE2            NUMBER,
    PRIMARY KEY (RUNID, UNIT_NUMBER)
);

COMMENT ON TABLE BDSM.PLSQL_PROFILER_UNITS IS
    'Information about each library unit in a run';

CREATE TABLE BDSM.PLSQL_PROFILER_DATA
(
    RUNID          NUMBER,
    UNIT_NUMBER    NUMBER,
    LINE#          NUMBER NOT NULL,
    TOTAL_OCCUR    NUMBER,
    TOTAL_TIME     NUMBER,
    MIN_TIME       NUMBER,
    MAX_TIME       NUMBER,
    SPARE1         NUMBER,
    SPARE2         NUMBER,
    SPARE3         NUMBER,
    SPARE4         NUMBER,
    PRIMARY KEY (RUNID, UNIT_NUMBER, LINE#),
    FOREIGN KEY (RUNID, UNIT_NUMBER) REFERENCES BDSM.PLSQL_PROFILER_UNITS
);

COMMENT ON TABLE BDSM.PLSQL_PROFILER_DATA IS
    'Accumulated data from all profiler runs';

CREATE SEQUENCE BDSM.PLSQL_PROFILER_RUNNUMBER START WITH 1 NOCACHE;

CREATE TABLE SYS.PLSQL_TRACE_RUNS
(
    RUNID              NUMBER PRIMARY KEY, 
    RUN_DATE           DATE,               
    RUN_OWNER          VARCHAR2 (31),      
    RUN_COMMENT        VARCHAR2 (2047), 
    RUN_COMMENT1       VARCHAR2 (2047),    
    RUN_END            DATE,               
    RUN_FLAGS          VARCHAR2 (2047),    
    RELATED_RUN        NUMBER,             
    RUN_SYSTEM_INFO    VARCHAR2 (2047),    
    SPARE1             VARCHAR2 (256)      
);

COMMENT ON TABLE SYS.PLSQL_TRACE_RUNS IS
    'Run-specific information for the PL/SQL trace';

CREATE TABLE SYS.PLSQL_TRACE_EVENTS
(
    RUNID                NUMBER REFERENCES SYS.PLSQL_TRACE_RUNS, 
    EVENT_SEQ            NUMBER,         
    EVENT_TIME           DATE,                                    
    RELATED_EVENT        NUMBER,
    EVENT_KIND           NUMBER,
    EVENT_UNIT_DBLINK    VARCHAR2 (4000),
    EVENT_UNIT_OWNER     VARCHAR2 (31),
    EVENT_UNIT           VARCHAR2 (31),       
    EVENT_UNIT_KIND      VARCHAR2 (31),
    EVENT_LINE           NUMBER,     
    EVENT_PROC_NAME      VARCHAR2 (31),        
    STACK_DEPTH          NUMBER,
    PROC_NAME            VARCHAR2 (31), 
    PROC_DBLINK          VARCHAR2 (4000),
    PROC_OWNER           VARCHAR2 (31),
    PROC_UNIT            VARCHAR2 (31),
    PROC_UNIT_KIND       VARCHAR2 (31),
    PROC_LINE            NUMBER,
    PROC_PARAMS          VARCHAR2 (2047),
        ICD_INDEX            NUMBER,
    USER_EXCP            NUMBER,
    EXCP                 NUMBER,
    EVENT_COMMENT        VARCHAR2 (2047),
    MODULE               VARCHAR2 (4000),
    ACTION               VARCHAR2 (4000),
    CLIENT_INFO          VARCHAR2 (4000),
    CLIENT_ID            VARCHAR2 (4000),
    ECID_ID              VARCHAR2 (4000),
    ECID_SEQ             NUMBER,
    CALLSTACK            CLOB,
    ERRORSTACK           CLOB,
    PRIMARY KEY (RUNID, EVENT_SEQ)
);

COMMENT ON TABLE SYS.PLSQL_TRACE_EVENTS IS
    'Accumulated data from all trace runs';

CREATE SEQUENCE SYS.PLSQL_TRACE_RUNNUMBER START WITH 1 NOCACHE;

CREATE TABLE BDSM.DBMSHP_RUNS
(
    RUNID                 NUMBER PRIMARY KEY,
    RUN_TIMESTAMP         TIMESTAMP,
    TOTAL_ELAPSED_TIME    INTEGER,
    RUN_COMMENT           VARCHAR2 (2047)
);

COMMENT ON TABLE BDSM.DBMSHP_RUNS IS
    'Run-specific information for the hierarchical profiler';

CREATE TABLE BDSM.DBMSHP_FUNCTION_INFO
(
    RUNID                    NUMBER REFERENCES BDSM.DBMSHP_RUNS ON DELETE CASCADE,
    SYMBOLID                 NUMBER,
    OWNER                    VARCHAR2 (128),
    MODULE                   VARCHAR2 (128),
    TYPE                     VARCHAR2 (32),
    FUNCTION                 VARCHAR2 (4000),
    LINE#                    NUMBER,
    HASH                     RAW (32) DEFAULT NULL,
    NAMESPACE                VARCHAR2 (32) DEFAULT NULL,
    SUBTREE_ELAPSED_TIME     INTEGER DEFAULT NULL,
    FUNCTION_ELAPSED_TIME    INTEGER DEFAULT NULL,
    CALLS                    INTEGER DEFAULT NULL,
    SQL_ID                   VARCHAR2 (13),
    SQL_TEXT                 VARCHAR2 (4000),
    PRIMARY KEY (RUNID, SYMBOLID)
);

COMMENT ON TABLE BDSM.DBMSHP_FUNCTION_INFO IS
    'Information about each function in a run';

CREATE TABLE BDSM.DBMSHP_PARENT_CHILD_INFO
(
    RUNID                    NUMBER,
    PARENTSYMID              NUMBER,
    CHILDSYMID               NUMBER,
    SUBTREE_ELAPSED_TIME     INTEGER DEFAULT NULL,
    FUNCTION_ELAPSED_TIME    INTEGER DEFAULT NULL,
    CALLS                    INTEGER DEFAULT NULL,
    FOREIGN KEY
        (RUNID, CHILDSYMID)
        REFERENCES BDSM.DBMSHP_FUNCTION_INFO (RUNID, SYMBOLID)
            ON DELETE CASCADE,
    FOREIGN KEY
        (RUNID, PARENTSYMID)
        REFERENCES BDSM.DBMSHP_FUNCTION_INFO (RUNID, SYMBOLID)
            ON DELETE CASCADE
);

COMMENT ON TABLE BDSM.DBMSHP_PARENT_CHILD_INFO IS
    'Parent-child information from a profiler runs';

CREATE SEQUENCE BDSM.DBMSHP_RUNNUMBER START WITH 1 NOCACHE;

CREATE OR REPLACE DIRECTORY BDSM_DIR AS '/var/bdsm';

GRANT ALL ON DIRECTORY BDSM_DIR TO BDSM;

CREATE OR REPLACE VIEW BDSM.STATS
AS
    SELECT 'STAT...' || A.NAME NAME, B.VALUE
      FROM V$STATNAME A, V$MYSTAT B
     WHERE A.STATISTIC# = B.STATISTIC#
    UNION ALL
    SELECT 'LATCH.' || NAME, GETS FROM V$LATCH;

CREATE GLOBAL TEMPORARY TABLE BDSM.RUN_STATS
(
    RUNID    VARCHAR2 (15),
    NAME     VARCHAR2 (80),
    VALUE    INT
)
ON COMMIT PRESERVE ROWS;

CREATE OR REPLACE PACKAGE BDSM.RUNSTATS_PKG
AS
    PROCEDURE RS_START;

    PROCEDURE RS_MIDDLE;

    PROCEDURE RS_STOP (P_DIFFERENCE_THRESHOLD IN NUMBER DEFAULT 0);
END;
/

CREATE OR REPLACE PACKAGE BODY BDSM.RUNSTATS_PKG
AS
    G_START   NUMBER;
    G_RUN1    NUMBER;
    G_RUN2    NUMBER;

    PROCEDURE RS_START
    IS
    BEGIN
        DELETE FROM BDSM.RUN_STATS;

        INSERT INTO BDSM.RUN_STATS
            SELECT 'BEFORE', STATS.* FROM STATS;

        G_START := DBMS_UTILITY.GET_TIME;
    END RS_START;

    PROCEDURE RS_MIDDLE
    IS
    BEGIN
        G_RUN1 := (DBMS_UTILITY.GET_TIME - G_START);

        INSERT INTO BDSM.RUN_STATS
            SELECT 'AFTER 1', STATS.* FROM STATS;

        G_START := DBMS_UTILITY.GET_TIME;
    END RS_MIDDLE;

    PROCEDURE RS_STOP (P_DIFFERENCE_THRESHOLD IN NUMBER DEFAULT 0)
    IS
    BEGIN
        G_RUN2 := (DBMS_UTILITY.GET_TIME - G_START);

        DBMS_OUTPUT.PUT_LINE ('RUN 1 RAN IN ' || G_RUN1 || ' HSEC');

        DBMS_OUTPUT.PUT_LINE ('RUN 2 RAN IN ' || G_RUN2 || ' HSEC');

        DBMS_OUTPUT.PUT_LINE (
               'RUN 1 RAN IN '
            || ROUND (G_RUN1 / G_RUN2 * 100, 2)
            || '% OF THE TIME OF RUN 
2');

        DBMS_OUTPUT.PUT_LINE (CHR (9));

        INSERT INTO BDSM.RUN_STATS
            SELECT 'AFTER 2', STATS.* FROM STATS;

        DBMS_OUTPUT.PUT_LINE (
               RPAD ('NAME', 30)
            || LPAD ('RUN 1', 14)
            || LPAD ('RUN 2', 14)
            || LPAD ('DIFFERENCE', 14));

        FOR X
            IN (  SELECT    RPAD (A.NAME, 30)
                         || TO_CHAR (B.VALUE - A.VALUE, '9,999,999,999')
                         || TO_CHAR (C.VALUE - B.VALUE, '9,999,999,999')
                         || TO_CHAR (
                                ((C.VALUE - B.VALUE) - (B.VALUE - A.VALUE)),
                                '9,999,999,999')
                             DATA
                    FROM BDSM.RUN_STATS A, BDSM.RUN_STATS B, BDSM.RUN_STATS C
                   WHERE     A.NAME = B.NAME
                         AND B.NAME = C.NAME
                         AND A.RUNID = 'BEFORE'
                         AND B.RUNID = 'AFTER 1'
                         AND C.RUNID = 'AFTER 2'
                         AND (C.VALUE - A.VALUE) > 0
                         AND ABS ((C.VALUE - B.VALUE) - (B.VALUE - A.VALUE)) >
                             P_DIFFERENCE_THRESHOLD
                ORDER BY ABS ((C.VALUE - B.VALUE) - (B.VALUE - A.VALUE)))
        LOOP
            DBMS_OUTPUT.PUT_LINE (X.DATA);
        END LOOP;

        DBMS_OUTPUT.PUT_LINE (CHR (9));

        DBMS_OUTPUT.PUT_LINE (
            'RUN 1 LATCHES TOTAL COMPARED TO RUN 2 -- DIFFERENCE AND PERCENTAGE');

        DBMS_OUTPUT.PUT_LINE (
               LPAD ('RUN 1', 14)
            || LPAD ('RUN 2', 14)
            || LPAD ('DIFF', 14)
            || LPAD ('PCT', 10));

        FOR X
            IN (SELECT    TO_CHAR (RUN1, '9,999,999,999')
                       || TO_CHAR (RUN2, '9,999,999,999')
                       || TO_CHAR (DIFF, '9,999,999,999')
                       || TO_CHAR (ROUND (G_RUN1 / G_RUN2 * 100, 2),
                                   '99,999.99')
                       || '%'
                           DATA
                  FROM (SELECT SUM (B.VALUE - A.VALUE)
                                   RUN1,
                               SUM (C.VALUE - B.VALUE)
                                   RUN2,
                               SUM (
                                   (C.VALUE - B.VALUE) - (B.VALUE - A.VALUE))
                                   DIFF
                          FROM BDSM.RUN_STATS A, BDSM.RUN_STATS B, BDSM.RUN_STATS C
                         WHERE     A.NAME = B.NAME
                               AND B.NAME = C.NAME
                               AND A.RUNID = 'BEFORE'
                               AND B.RUNID = 'AFTER 1'
                               AND C.RUNID = 'AFTER 2'
                               AND A.NAME LIKE 'LATCH%'))
        LOOP
            DBMS_OUTPUT.PUT_LINE (X.DATA);
        END LOOP;
    END RS_STOP;
END;
/

CREATE OR REPLACE PUBLIC SYNONYM P FOR BDSM.P;