------------------------------------------------------------------
-- mai40_mai4010_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai40_mai4010_ddl_upg.sql-arc   2.1   Jul 01 2013 16:02:20   James.Wadsworth  $
--       Module Name      : $Workfile:   mai40_mai4010_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:36  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
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
PROMPT Introduce PK constraint on WORK_ORDERS
SET TERM OFF

-- GJ  03-APR-2007
-- 
-- DEVELOPMENT COMMENTS
-- Introduce a PK constraint on WORK_ORDERS.
-- 
-- Now that there is a PK constraint on WORK_ORDERS we can trap violation of this constraint in MAI3800 without the need to write bespoke code.
-- 
------------------------------------------------------------------
drop index WOR_INDEX_P1
/
alter table work_orders add constraint WOR_PK UNIQUE (wor_works_order_no) ENABLE
/

------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

