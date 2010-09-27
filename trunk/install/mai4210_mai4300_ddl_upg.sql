------------------------------------------------------------------
-- mai4210_mai4300_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4210_mai4300_ddl_upg.sql-arc   3.0   Sep 27 2010 10:54:16   mike.alexander  $
--       Module Name      : $Workfile:   mai4210_mai4300_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Sep 27 2010 10:54:16  $
--       Date fetched Out : $Modtime:   Sep 27 2010 10:52:06  $
--       Version          : $Revision:   3.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2010

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT DEFECTS flexible attribute modifications
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 710404  City of York Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 710506  City of York Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 711639  Oxfordshire County Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 108076
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modification to DEFECTS, and associated tables, for flexible attribute columns
-- 
------------------------------------------------------------------
alter table defects
modify
( def_area            NUMBER
, def_coord_flag      VARCHAR2(240)
, def_diagram_no      VARCHAR2(240)
, def_height          NUMBER
, def_ident_code      VARCHAR2(240)
, def_length          NUMBER
, def_number          NUMBER
, def_per_cent        NUMBER
, def_per_cent_orig   NUMBER
, def_per_cent_rem    NUMBER
, def_serial_no       VARCHAR2(240)
, def_skid_coeff      NUMBER
)
/
alter table mai_insp_load_error_def
modify
( def_area            NUMBER
, def_coord_flag      VARCHAR2(240)
, def_diagram_no      VARCHAR2(240)
, def_height          NUMBER
, def_ident_code      VARCHAR2(240)
, def_length          NUMBER
, def_number          NUMBER
, def_per_cent        NUMBER
, def_per_cent_orig   NUMBER
, def_per_cent_rem    NUMBER
, def_serial_no       VARCHAR2(240)
, def_skid_coeff      NUMBER
)
/
alter table temp_replace_defects
modify
( def_area            NUMBER
, def_coord_flag      VARCHAR2(240)
, def_diagram_no      VARCHAR2(240)
, def_height          NUMBER
, def_ident_code      VARCHAR2(240)
, def_length          NUMBER
, def_number          NUMBER
, def_per_cent        NUMBER
, def_per_cent_orig   NUMBER
, def_per_cent_rem    NUMBER
, def_serial_no       VARCHAR2(240)
, def_skid_coeff      NUMBER
)
/
alter table temp_undo_defect_edit
modify
( def_area            NUMBER
, def_coord_flag      VARCHAR2(240)
, def_diagram_no      VARCHAR2(240)
, def_height          NUMBER
, def_ident_code      VARCHAR2(240)
, def_length          NUMBER
, def_number          NUMBER
, def_per_cent        NUMBER
, def_per_cent_orig   NUMBER
, def_per_cent_rem    NUMBER
, def_serial_no       VARCHAR2(240)
, def_skid_coeff      NUMBER
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Index SCHR_INDEX_P1
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727184  Sineco
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 108594
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Task 0108594
-- 
-- Made Unique Index  SCHR_INDEX_P1 non-unique.
-- 
------------------------------------------------------------------
DROP INDEX SCHR_INDEX_P1
/

CREATE INDEX SCHR_INDEX_P1 ON SCHEDULE_ROADS
 (SCHR_SCHD_ID
 ,SCHR_STA_ITEM_CODE
 ,SCHR_RSE_HE_ID)
/

------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

