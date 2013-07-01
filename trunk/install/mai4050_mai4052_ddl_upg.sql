------------------------------------------------------------------
-- mai4050_mai4052_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4050_mai4052_ddl_upg.sql-arc   3.3   Jul 01 2013 16:03:24   James.Wadsworth  $
--       Module Name      : $Workfile:   mai4050_mai4052_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:03:24  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:36  $
--       Version          : $Revision:   3.3  $
--
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT WOL_REGISTER column
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Added As Part Of The MAI to TMA Interface Changes.
-- 
------------------------------------------------------------------
ALTER TABLE work_order_lines
 ADD (wol_register_flag  VARCHAR2(1) DEFAULT 'N' NOT NULL)
/
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

