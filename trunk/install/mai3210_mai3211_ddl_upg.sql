--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai3211_ddl_upg.sql-arc   2.0   Jun 13 2007 16:32:36   smarshall  $
--       Module Name      : $Workfile:   mai3210_mai3211_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:36  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
--
--
--
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
--


ALTER TABLE HHINV_HOLD_1
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_ITEM_ERR_1
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_ITEM_ERR_2
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_ITEM_ERR_3
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_LOAD_1
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_LOAD_2
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_LOAD_3
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_RUN_LOG
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/
 
ALTER TABLE HHINV_SECT_LOG
  MODIFY (ERROR_MSG  VARCHAR2(4000))
/





--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

