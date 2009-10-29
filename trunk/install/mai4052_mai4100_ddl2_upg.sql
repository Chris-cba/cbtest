------------------------------------------------------------------
-- mai4052_mai4100_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4052_mai4100_ddl2_upg.sql-arc   3.0   Oct 29 2009 17:37:22   malexander  $
--       Module Name      : $Workfile:   mai4052_mai4100_ddl2_upg.sql  $
--       Date into PVCS   : $Date:   Oct 29 2009 17:37:22  $
--       Date fetched Out : $Modtime:   Oct 29 2009 17:36:44  $
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
-- log 716904 and log 719542 DDL changes to update HE_ID max length from 8 to 9 and RSE_DESCR from 80 to 240.
-- This script covers a number of tables used by the MAI Inventory Loader and also tables that are replicated
-- in each users own schema.
--
-- This has been scripted separately in order to make it rerunable on it's own.
-- 
------------------------------------------------------------------
SET TERM ON
PROMPT HHINV_LOAD Tables


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
    upgrade_table(pi_tablename => 'HHINV_ITEM_ERR_1'
                 ,pi_stmt      => 'ALTER TABLE HHINV_ITEM_ERR_1 MODIFY(REC_SEQ_NO NUMBER(38,0),HWAY_SEQ_NO NUMBER(38,0),SECT_HDR_SEQ_NO NUMBER(38,0))');
    --
    upgrade_table(pi_tablename => 'HHINV_ITEM_ERR_2'
                 ,pi_stmt      => 'ALTER TABLE HHINV_ITEM_ERR_2 MODIFY(HE_ID NUMBER(38,0),REC_SEQ_NO NUMBER(38,0),SECT_HDR_SEQ_NO NUMBER(38,0))');
    --
    upgrade_table(pi_tablename => 'HHINV_ITEM_ERR_3'
                 ,pi_stmt      => 'ALTER TABLE HHINV_ITEM_ERR_3 MODIFY(HE_ID NUMBER(38,0),REC_SEQ_NO NUMBER(38,0))');
    --
    upgrade_table(pi_tablename => 'TEMP_LOAD_2'
                 ,pi_stmt      => 'ALTER TABLE TEMP_LOAD_2 MODIFY(HE_ID NUMBER(38,0),SECT_HDR_SEQ_NO NUMBER(38,0))');
    --
    upgrade_table(pi_tablename => 'HHINV_LOAD_2'
                 ,pi_stmt      => 'ALTER TABLE HHINV_LOAD_2 MODIFY(HE_ID NUMBER(38,0),REC_SEQ_NO NUMBER(38,0),SECT_HDR_SEQ_NO NUMBER(38,0))');
    --
    upgrade_table(pi_tablename => 'HHINV_LOAD_3'
                 ,pi_stmt      => 'ALTER TABLE HHINV_LOAD_3 MODIFY(HE_ID NUMBER(38,0),REC_SEQ_NO NUMBER(38,0))');
    --
    upgrade_table(pi_tablename => 'HHINV_ODL_LOG'
                 ,pi_stmt      => 'ALTER TABLE HHINV_ODL_LOG MODIFY(LAST_SEQ_NO NUMBER(38,0),NEW_SEQ_NO NUMBER(38,0),Z_REC_SEQ_NO NUMBER(38,0))');
    --
    upgrade_table(pi_tablename => 'HHINV_RUN_LOG'
                 ,pi_stmt      => 'ALTER TABLE HHINV_RUN_LOG MODIFY(MAX_SEQ_NO  NUMBER(38,0))');
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
                   'ALTER TABLE '||pi_username||'.HHINV_LOAD_1 MODIFY(REC_SEQ_NO NUMBER(38,0))'
                   --
                WHEN table_name = 'HHINV_HOLD_1'
                THEN
                   'ALTER TABLE '||pi_username||'.HHINV_HOLD_1 MODIFY(REC_SEQ_NO NUMBER(38,0))'
                   --
                WHEN table_name = 'HHINV_LOAD_2'
                THEN
                   'ALTER TABLE '||pi_username||'.HHINV_LOAD_2 MODIFY(HE_ID NUMBER(38,0),REC_SEQ_NO NUMBER(38,0),SECT_HDR_SEQ_NO NUMBER(38,0))'
                   --
                WHEN table_name = 'HHINV_LOAD_3'
                THEN
                   'ALTER TABLE '||pi_username||'.HHINV_LOAD_3 MODIFY(HE_ID NUMBER(38,0),REC_SEQ_NO NUMBER(38,0))'
                   --
                WHEN table_name = 'TEMP_LOAD_2'
                THEN
                   'ALTER TABLE '||pi_username||'.TEMP_LOAD_2 MODIFY(HE_ID NUMBER(38,0),SECT_HDR_SEQ_NO NUMBER(38,0))'
                   --
                WHEN table_name = 'TEMP_2140'
                THEN
                   'ALTER TABLE '||pi_username||'.TEMP_2140 MODIFY(RSE_HE_ID NUMBER(38,0))'
                   --
                ELSE NULL
           END alter_table
      BULK COLLECT
      INTO lt_tables
          ,lt_stmts
      FROM dba_tables
     WHERE owner = pi_username
       AND table_name IN('HHINV_LOAD_1'
                        ,'HHINV_HOLD_1'
                        ,'HHINV_LOAD_2'
                        ,'HHINV_LOAD_3'
                        ,'TEMP_LOAD_2'
                        ,'TEMP_2140')
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
