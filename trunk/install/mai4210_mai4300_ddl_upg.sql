------------------------------------------------------------------
-- mai4210_mai4300_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4210_mai4300_ddl_upg.sql-arc   3.1   Oct 04 2010 09:35:32   mike.alexander  $
--       Module Name      : $Workfile:   mai4210_mai4300_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Oct 04 2010 09:35:32  $
--       Date fetched Out : $Modtime:   Oct 04 2010 09:33:26  $
--       Version          : $Revision:   3.1  $
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
-- A review of the flexible attribute columns that can be assigned to a Defect Type has been performed and the following changes have been made to the size of data that can be stored in these columns:-
-- 
-- DEF_AREA        from NUMBER(8,1) to NUMBER
-- DEF_COORD_FLAG  from VARCHAR2(1) to VARCHAR2(240) 
-- DEF_DIAGRAM_NO  from VARCHAR2(7) to VARCHAR2(240) 
-- DEF_HEIGHT      from NUMBER(6,1) to NUMBER
-- DEF_IDENT_CODE  from VARCHAR2(8) to VARCHAR2(240) 
-- DEF_LENGTH      from NUMBER(6,1) to NUMBER
-- DEF_NUMBER      from NUMBER(5,1) to NUMBER
-- DEF_PER_CENT    from NUMBER(5,1) to NUMBER
-- DEF_SERIAL_NO   from VARCHAR2(6) to VARCHAR2(240)
-- DEF_SKID_COEFF  from NUMBER(4,1) to NUMBER
-- 
-- 
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
-- Problem when calculating quantities in the "Cyclic Maintenance Schedules" form (MAI3860).
-- An error message ('hig1069 database constraint violated schr_index_p1') was being displayed when the "Schedule By Asset" flag is set to 'Y'.
-- A change has been made to the index schr_index_p1 to resolve this problem.
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

