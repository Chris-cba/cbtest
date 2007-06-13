--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai3220_ddl_upg.sql-arc   2.0   Jun 13 2007 16:32:36   smarshall  $
--       Module Name      : $Workfile:   mai3210_mai3220_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:36  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.2
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

