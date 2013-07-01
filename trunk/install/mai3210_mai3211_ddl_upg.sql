--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai3211_ddl_upg.sql-arc   2.1   Jul 01 2013 16:02:18   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3210_mai3211_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:18  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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

