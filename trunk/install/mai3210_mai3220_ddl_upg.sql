--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai3220_ddl_upg.sql-arc   2.1   Jul 01 2013 16:02:18   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3210_mai3220_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:18  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
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

--
-- Add FK between budgets and financial_years (which is now a cor table) - Graeme
--
ALTER TABLE BUDGETS ADD 
CONSTRAINT BUD_FYR_FK
 FOREIGN KEY (BUD_FYR_ID)
 REFERENCES FINANCIAL_YEARS (FYR_ID) ENABLE
/ 

--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

