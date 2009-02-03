------------------------------------------------------------------
-- mai4050_mai4052_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4050_mai4052_ddl_upg.sql-arc   3.0   Feb 03 2009 17:24:10   malexander  $
--       Module Name      : $Workfile:   mai4050_mai4052_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Feb 03 2009 17:24:10  $
--       Date fetched Out : $Modtime:   Feb 03 2009 17:22:58  $
--       Version          : $Revision:   3.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2008

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

