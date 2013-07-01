------------------------------------------------------------------
-- mai4400_mai4500_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4400_mai4500_ddl_upg.sql-arc   3.1   Jul 01 2013 16:03:30   James.Wadsworth  $
--       Module Name      : $Workfile:   mai4400_mai4500_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:03:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:36  $
--       Version          : $Revision:   3.1  $
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
PROMPT Addition of Percent Uplift columns to STANDARD_ITEMS
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109785
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of Percent Uplift columns to STANDARD_ITEMS
-- 
------------------------------------------------------------------
DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'ALTER TABLE standard_items  ADD (sta_boq_perc_uplift  VARCHAR2(1),'||
                                                                                     '  sta_wol_perc_uplift VARCHAR2(1) ) ';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Percent Uplift Column to CONTRACTS
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109785
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of Percent Uplift Column to CONTRACTS
-- 
------------------------------------------------------------------
DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'ALTER TABLE contracts  ADD (con_allow_perc_uplift  VARCHAR2(1), '||
                                      '                                                   con_include_in_cim        VARCHAR2(1) ) ';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Percent Uplift Column to REPAIRS
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109785
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of Percent Uplift Column to REPAIRS
-- 
------------------------------------------------------------------
DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'ALTER TABLE repairs  ADD (rep_boq_perc_item_code  VARCHAR2(10),' ||
                                                                           ' rep_wol_perc_item_code   VARCHAR2(10)) ';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Percent Uplift Column to WORK_ORDER_LINES
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109785
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of Percent Uplift Column to WORK_ORDER_LINES
-- 
------------------------------------------------------------------
DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'ALTER TABLE work_order_lines  ADD (wol_boq_perc_item_code  VARCHAR2(10),' ||
                                                                                         ' wol_wol_perc_item_code   VARCHAR2(10)) ';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Percent Uplift Column to MAI_INSP_LOAD_ERROR_REP
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109785
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of Percent Uplift Column to MAI_INSP_LOAD_ERROR_REP
-- 
------------------------------------------------------------------
DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'ALTER TABLE mai_insp_load_error_rep  ADD (rep_boq_perc_item_code  VARCHAR2(10),' ||
                                                                           ' rep_wol_perc_item_code   VARCHAR2(10)) ';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

