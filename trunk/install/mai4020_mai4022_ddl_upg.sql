------------------------------------------------------------------
-- mai4020_mai4022_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4020_mai4022_ddl_upg.sql-arc   2.1   Jul 01 2013 16:03:02   James.Wadsworth  $
--       Module Name      : $Workfile:   mai4020_mai4022_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:03:02  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:36  $
--       Version          : $Revision:   2.1  $
--
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


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



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

