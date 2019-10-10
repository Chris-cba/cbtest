------------------------------------------------------------------
-- mai4700_mai4800_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/mai4700_mai4800_ddl_upg.sql-arc   1.0   Oct 10 2019 09:29:12   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4700_mai4800_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Oct 10 2019 09:29:12  $
--       Date fetched Out : $Modtime:   Oct 09 2019 14:29:48  $
--       Version          : $Revision:   1.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2014

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------
SET TERM ON
PROMPT Add column to MAI_AUTO_WO_RULES
SET TERM OFF
DECLARE
  col_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(col_exists,-1430);
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE mai_auto_wo_rules 
                       ADD mawr_use_inspection_date VARCHAR2(1)';
EXCEPTION
  WHEN col_exists THEN
    NULL;
  WHEN OTHERS THEN
    RAISE;
END;
/
------------------------------------------------------------------
SET TERM ON
PROMPT Contract Breakdown changes
SET TERM OFF
SET TERM ON 
PROMPT Alter CONTRACTS table
SET TERM OFF
--
DECLARE
  columns_exist EXCEPTION;
  PRAGMA exception_init( columns_exist, -1430);
BEGIN
  EXECUTE IMMEDIATE
  'ALTER TABLE contracts
   ADD CON_BREAKDOWN VARCHAR2(1)';
EXCEPTION
  WHEN columns_exist THEN
    NULL;
END;
/
--
SET TERM ON 
PROMPT Create MAI_CONTRACT_BREAKDOWN table
SET TERM OFF

DECLARE
  object_exists EXCEPTION;
  PRAGMA exception_init( object_exists, -955);
BEGIN
  EXECUTE IMMEDIATE
  'CREATE TABLE MAI_CONTRACT_BREAKDOWN
   (
   CBRR_CON_CODE                       VARCHAR2(10) 
  ,CBRR_STA_ITEM_CODE                  VARCHAR2(10) 
  ,CBRR_VALUE1                         NUMBER(10,2) 
  ,CBRR_VALUE2                         NUMBER(10,2) 
  ,CBRR_VALUE3                         NUMBER(10,2) 
  ,CBRR_VALUE4                         NUMBER(10,2) 
  ,CBRR_VALUE5                         NUMBER(10,2) 
  ,CBRR_VALUE6                         NUMBER(10,2) 
  ,CBRR_VALUE7                         NUMBER(10,2) 
  ,CBRR_VALUE8                         NUMBER(10,2) 
  ,CBRR_VALUE9                         NUMBER(10,2) 
  ,CBRR_VALUE10                        NUMBER(10,2) 
  ,CBRR_ERROR                          VARCHAR2(4000) 
   )';
EXCEPTION
  WHEN object_exists THEN
    NULL;
END;
/
--
DECLARE
  object_exists EXCEPTION;
  PRAGMA exception_init( object_exists, -2260);
BEGIN
  EXECUTE IMMEDIATE
  'ALTER TABLE MAI_CONTRACT_BREAKDOWN
   ADD (CONSTRAINT CBRR_PK PRIMARY KEY 
    (CBRR_CON_CODE,CBRR_STA_ITEM_CODE))';
EXCEPTION
  WHEN object_exists THEN
    NULL;
END;
/
------------------------------------------------------------------
-- Inventory Loasder Table Changes
------------------------------------------------------------------
SET TERM ON 
PROMPT Create Inventory Loader Table Changes table
SET TERM OFF

SET DEFINE ON
SET FEEDBACK OFF
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'inv_loader_table_changes.sql' run_file
FROM DUAL
/
SET ECHO OFF FEED ON
start '&&run_file'


------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

