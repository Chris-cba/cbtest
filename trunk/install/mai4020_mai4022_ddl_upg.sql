------------------------------------------------------------------
-- mai4020_mai4022_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4020_mai4022_ddl_upg.sql-arc   2.0   Nov 28 2007 08:56:38   jwadsworth  $
--       Module Name      : $Workfile:   mai4020_mai4022_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Nov 28 2007 08:56:38  $
--       Date fetched Out : $Modtime:   Nov 28 2007 08:56:16  $
--       Version          : $Revision:   2.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2007
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

