------------------------------------------------------------------
-- mai4210_mai4300_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4210_mai4300_ddl_upg.sql-arc   3.2   Oct 13 2010 16:32:18   Mike.Alexander  $
--       Module Name      : $Workfile:   mai4210_mai4300_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Oct 13 2010 16:32:18  $
--       Date fetched Out : $Modtime:   Oct 13 2010 16:21:34  $
--       Version          : $Revision:   3.2  $
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
SET TERM ON
PROMPT Sort Out Activities Primary Key
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Indexes are now being created after the constraints, as a result the existing index atv_index_p1 is causing problems. This index is to be dropped, a similar index will be created by default as a result of the Primary Key constraint.
-- Also added the index mia_atv_fk_ind on mai_inv_activities to support the FK Constaint to activities.
-- 
------------------------------------------------------------------
ALTER TABLE mai_inv_activities
  DROP CONSTRAINT mia_atv_fk
/

ALTER TABLE activities
  DROP CONSTRAINT atv_pk
/

DECLARE
  --ORA-01418: specified index does not exist
  index_not_found EXCEPTION;
  PRAGMA EXCEPTION_INIT(index_not_found,-01418); 
  --
BEGIN
  --
  EXECUTE IMMEDIATE 'DROP INDEX atv_index_p1';
  --   
EXCEPTION
  WHEN index_not_found
   THEN
      NULL;
  WHEN others
   THEN
      RAISE;
END;
/

ALTER TABLE activities
  ADD (CONSTRAINT atv_pk
       PRIMARY KEY(atv_acty_area_code,atv_dtp_flag))
/

ALTER TABLE mai_inv_activities
  ADD (CONSTRAINT mia_atv_fk
       FOREIGN KEY(mia_atv_acty_area_code,mia_sys_flag)
       REFERENCES activities(atv_acty_area_code,atv_dtp_flag))
/

DECLARE
  --ORA-00955: name is already used by an existing object
  object_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(object_exists,-00955);
  --
BEGIN
  --
  EXECUTE IMMEDIATE 'CREATE INDEX mia_atv_fk_ind ON mai_inv_activities(mia_atv_acty_area_code, mia_sys_flag)';
  --   
EXCEPTION
  WHEN object_exists
   THEN
      NULL;
  WHEN others
   THEN
      RAISE;
END;
/

------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

