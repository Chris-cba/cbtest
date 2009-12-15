------------------------------------------------------------------
-- mai4100_mai4200_ddl2_upg.sql
------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4100_mai4200_ddl2_upg.sql-arc   3.0   Dec 15 2009 23:02:26   mhuitson  $
--       Module Name      : $Workfile:   mai4100_mai4200_ddl2_upg.sql  $
--       Date into PVCS   : $Date:   Dec 15 2009 23:02:26  $
--       Date fetched Out : $Modtime:   Dec 09 2009 18:09:36  $
--       Version          : $Revision:   3.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2009
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- DDL changes to update ST_CHAIN and END_CHAIN on the table TEMP_LOAD_2
-- this table is replicated in each users own schema.
--
-- This has been scripted separately in order to make it rerunable on it's own.
-- 
------------------------------------------------------------------
SET TERM ON
PROMPT TEMP_LOAD_2 Table

DECLARE
  --
  lt_users nm3type.tab_varchar30;
  --
  PROCEDURE get_users
    IS
  BEGIN
    SELECT hus_username
      BULK COLLECT
      INTO lt_users
      FROM hig_users
          ,dba_users
     WHERE account_status = 'OPEN'
       AND username = hus_username
       AND hus_is_hig_owner_flag != 'Y'
         ;
  END get_users;
  --
  PROCEDURE upgrade_table(pi_tablename IN VARCHAR2
                         ,pi_stmt      IN VARCHAR2)
    IS
    --
    lv_step      NUMBER;
    lv_temptable VARCHAR2(61);
    --
  BEGIN
    --
    lv_temptable := pi_tablename||'_'||TO_CHAR(SYSDATE,'DDMMRRHH24MI');
    --
    lv_step := 1;
    EXECUTE IMMEDIATE 'CREATE TABLE '||lv_temptable||' AS SELECT * FROM '||pi_tablename;
    --
    lv_step := 2;
    EXECUTE IMMEDIATE 'DELETE '||pi_tablename;
    --
    lv_step := 3;
    EXECUTE IMMEDIATE pi_stmt;
    --
    lv_step := 4;
    EXECUTE IMMEDIATE 'INSERT INTO '||pi_tablename||' SELECT * FROM '||lv_temptable;
    --
    lv_step := 5;
    EXECUTE IMMEDIATE 'DROP TABLE '||lv_temptable;
    --
  EXCEPTION
    WHEN others
     THEN
        IF lv_step IN(2,3)
         THEN
            ROLLBACK;
            EXECUTE IMMEDIATE 'DROP TABLE '||lv_temptable;
        END IF;
        --
        raise_application_error(-20001,'Error Occured While Upgrading Table '||pi_tablename||CHR(10)||SQLERRM);
        --
  END upgrade_table;
  --
  PROCEDURE alter_higowner_tables
    IS
  BEGIN
    --
    upgrade_table(pi_tablename => 'TEMP_LOAD_2'
                 ,pi_stmt      => 'ALTER TABLE TEMP_LOAD_2 MODIFY(ST_CHAIN NUMBER,END_CHAIN NUMBER)');
    --
  END alter_higowner_tables;
  --
  PROCEDURE alter_user_tables(pi_username IN VARCHAR2)
    IS
    --
    lt_tables nm3type.tab_varchar32767;
    lt_stmts  nm3type.tab_varchar32767;
    --
  BEGIN
    /*
    ||Get The Alter Table Statements That Need To Be Run For The Given User.
    */
    SELECT pi_username||'.'||table_name tablename
          ,CASE WHEN table_name = 'HHINV_LOAD_1'
                THEN
                   'ALTER TABLE '||pi_username||'.TEMP_LOAD_2 MODIFY(ST_CHAIN NUMBER,END_CHAIN NUMBER)'
                   --
                ELSE NULL
           END alter_table
      BULK COLLECT
      INTO lt_tables
          ,lt_stmts
      FROM dba_tables
     WHERE owner = pi_username
       AND table_name = 'HHINV_LOAD_1'
         ;
    /*
    ||Run The Statements.
    */
    FOR i IN 1..lt_tables.count LOOP
      IF lt_stmts(i) IS NOT NULL
       THEN
          upgrade_table(pi_tablename => lt_tables(i)
                       ,pi_stmt      => lt_stmts(i));
      END IF;
    END LOOP;
    --
  END alter_user_tables;
  --
BEGIN
  /*
  ||Upgrade The Highways Owners Copies Of The Tables.
  */
  alter_higowner_tables;
  /*
  ||Upgrade Any Other Users Copies Of The Tables.
  */
  EXECUTE IMMEDIATE 'GRANT ALTER ANY TABLE TO '||USER;
  --
  get_users;
  --
  FOR i IN 1..lt_users.count LOOP
    --
    alter_user_tables(pi_username => lt_users(i));
    --
  END LOOP;
  --
  EXECUTE IMMEDIATE 'REVOKE ALTER ANY TABLE FROM '||USER;
  --
END;
/

SET TERM OFF
------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------
