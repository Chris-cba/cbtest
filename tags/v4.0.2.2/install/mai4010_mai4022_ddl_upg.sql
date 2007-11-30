------------------------------------------------------------------
-- mai4010_mai4022_ddl_upg.sql
------------------------------------------------------------------

-- PVCS Identifiers :-
--
-- pvcsid : $Header:   //vm_latest/archives/mai/install/mai4010_mai4022_ddl_upg.sql-arc   2.0   Nov 30 2007 11:25:54   jwadsworth  $
-- Module Name : $Workfile:   mai4010_mai4022_ddl_upg.sql  $
-- Date into PVCS : $Date:   Nov 30 2007 11:25:54  $
-- Date fetched Out : $Modtime:   Nov 30 2007 11:25:32  $
-- PVCS Version : $Revision:   2.0  $
-- Based on SCCS version : 
------------------------------------------------------------------

------------------------------------------------------------------
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------
SET TERM ON
PROMPT alter table BUDGETS
SET TERM OFF

-- SSC  25-OCT-2007
-- 
-- DEVELOPMENT COMMENTS
-- Checking that BUD_RSE_HE_ID is nullable.
------------------------------------------------------------------
BEGIN
 EXECUTE IMMEDIATE ('alter table BUDGETS modify BUD_RSE_HE_ID null');
EXCEPTION
  WHEN others THEN 
   Null;
END; 
/


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Rebuild WOR_PK
SET TERM OFF

-- AE  26-OCT-2007
-- 
-- DEVELOPMENT COMMENTS
-- Rebuild WOR_PK as a Primary key instead of Unique key
------------------------------------------------------------------
alter table work_orders drop constraint wor_pk;

alter table work_orders add constraint WOR_PK primary key (wor_works_order_no) ENABLE;
------------------------------------------------------------------

SET TERM ON
PROMPT Alter hhinv xsp
SET TERM OFF

-- MH  22-NOV-2007
-- 
-- DEVELOPMENT COMMENTS
-- Expand Inventory Loader xsp columns to 4 characters.
------------------------------------------------------------------
ALTER TABLE HHINV_ITEM_ERR_2
MODIFY(X_SECT VARCHAR2(4));

ALTER TABLE HHINV_LOAD_2
MODIFY(X_SECT VARCHAR2(4));

ALTER TABLE HHINV_LOAD_3
MODIFY(X_SECT VARCHAR2(4));


------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

