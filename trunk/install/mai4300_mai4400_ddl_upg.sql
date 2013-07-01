------------------------------------------------------------------
-- mai4300_mai4400_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4300_mai4400_ddl_upg.sql-arc   3.1   Jul 01 2013 16:03:30   James.Wadsworth  $
--       Module Name      : $Workfile:   mai4300_mai4400_ddl_upg.sql  $
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
PROMPT Addition of DEF_SISS_ID to MAI_AUTO_WO_RULE_CRITERIA
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110419
-- 
-- TASK DETAILS
-- The Automatic Works Order functionality has been enhanced to allow the specification of SISS Code in the Criteria tab of the Automatic Works Order Rules form (MAI3818).
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of DEF_SISS_ID to MAI_AUTO_WO_RULE_CRITERIA
-- 
------------------------------------------------------------------
ALTER TABLE mai_auto_wo_rule_criteria
  ADD(mawc_def_siss_id   VARCHAR2(3));

ALTER TABLE mai_auto_wo_rule_criteria
  DROP CONSTRAINT mawc_uk;

ALTER TABLE mai_auto_wo_rule_criteria
  ADD CONSTRAINT mawc_uk UNIQUE(mawc_mawr_id  
                               ,mawc_atv_acty_area_code
                               ,mawc_dty_defect_code
                               ,mawc_def_siss_id
                               ,mawc_priority
                               ,mawc_include_temp_repair
                               ,mawc_include_perm_repair
                               ,mawc_tre_treat_code);

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT DEFECT.DEF_LOCN_DESCR increase to 1000 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 716498  Cheltenham Borough Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727959  Hampshire County Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107258
-- 
-- TASK DETAILS
-- The Defect Location Description and Works Order Line Location Description fields have been expanded to 1000 characters.
-- NB. When passed into the MAI to TMA interface these fields will be truncated to 120 characters in accordance with the EToN specification.
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- DEFECTS. DEF_LOCN_DESCR increased to varchar2(1000)
-- 
------------------------------------------------------------------
alter table defects
modify
( def_locn_descr   varchar2(1000)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT INTERFACE_WOL.IWOL_DEF_LOCN_DESCR increase to 1000 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 716498  Cheltenham Borough Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727959  Hampshire County Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107258
-- 
-- TASK DETAILS
-- The Defect Location Description and Works Order Line Location Description fields have been expanded to 1000 characters.
-- NB. When passed into the MAI to TMA interface these fields will be truncated to 120 characters in accordance with the EToN specification.
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- INTERFACE_WOL.IWOL_DEF_LOCN_DESCR increased to varchar2(1000)
-- 
------------------------------------------------------------------
alter table interface_wol
modify
( iwol_def_locn_descr   varchar2(1000)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT MAI_INSP_LOAD_ERROR_DEF.DEF_LOCN_DESCR increase to 1000 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 716498  Cheltenham Borough Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727959  Hampshire County Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107258
-- 
-- TASK DETAILS
-- The Defect Location Description and Works Order Line Location Description fields have been expanded to 1000 characters.
-- NB. When passed into the MAI to TMA interface these fields will be truncated to 120 characters in accordance with the EToN specification.
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- MAI_INSP_LOAD_ERROR_DEF.DEF_LOCN_DESCR increased to varchar2(1000)
-- 
------------------------------------------------------------------
alter table mai_insp_load_error_def
modify
( def_locn_descr   varchar2(1000)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT TEMP_UNDO_DEFECT_EDIT.DEF_LOCN_DESCR increase to 1000 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 716498  Cheltenham Borough Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727959  Hampshire County Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107258
-- 
-- TASK DETAILS
-- The Defect Location Description and Works Order Line Location Description fields have been expanded to 1000 characters.
-- NB. When passed into the MAI to TMA interface these fields will be truncated to 120 characters in accordance with the EToN specification.
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- TEMP_UNDO_DEFECT_EDIT.DEF_LOCN_DESCR increased to varchar2(1000)
-- 
------------------------------------------------------------------
alter table temp_undo_defect_edit
modify
( def_locn_descr   varchar2(1000)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT WORK_ORDER_LINES.WOL_LOCN_DESCR increase to 1000 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 716498  Cheltenham Borough Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727959  Hampshire County Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107258
-- 
-- TASK DETAILS
-- The Defect Location Description and Works Order Line Location Description fields have been expanded to 1000 characters.
-- NB. When passed into the MAI to TMA interface these fields will be truncated to 120 characters in accordance with the EToN specification.
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- WORK_ORDER_LINES.WOL_LOCN_DESCR increased to varchar2(1000)
-- 
------------------------------------------------------------------
alter table work_order_lines
modify
( wol_locn_descr   varchar2(1000)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Drop HH_LOAD_BATCHES and HH_LOAD_RECS tables
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110255
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Drop old inspection loader tables HH_LOAD_BATCHES and HH_LOAD_RECS
-- 
------------------------------------------------------------------
DECLARE
  ex_not_exists exception;
  pragma exception_init(ex_not_exists,-942);
BEGIN
  EXECUTE IMMEDIATE('DROP TABLE HH_LOAD_RECS');
EXCEPTION
  WHEN ex_not_exists THEN
     NULL;
  WHEN OTHERS THEN
    RAISE;
END;
/

DECLARE
  ex_not_exists exception;
  pragma exception_init(ex_not_exists,-942);
BEGIN
  EXECUTE IMMEDIATE('DROP TABLE HH_LOAD_BATCHES');
EXCEPTION
  WHEN ex_not_exists THEN
     NULL;
  WHEN OTHERS THEN
    RAISE;
END;
/


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT ACTIVITIES_REPORT.ARE_INITIATION_TYPE increase to 10 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727985  Area 2 - Balfour Beatty Mott McDonald
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 110178
-- 
-- TASK DETAILS
-- The Inspection Initiation Type can now be up to 10 characters in length (previously 3 characters).
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- ACTIVITIES_REPORT.ARE_INITIATION_TYPE increased to varchar2(10)
-- 
------------------------------------------------------------------
alter table activities_report
modify
( are_initiation_type   varchar2(10)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT DEF_SUPERSEDING_RULES.DSR_INITIATION_TYPE increase to 10 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727985  Area 2 - Balfour Beatty Mott McDonald
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 110178
-- 
-- TASK DETAILS
-- The Inspection Initiation Type can now be up to 10 characters in length (previously 3 characters).
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- DEF_SUPERSEDING_RULES.DSR_INITIATION_TYPE increased to varchar2(10)
-- 
------------------------------------------------------------------
alter table def_superseding_rules
modify
( dsr_initiation_type   varchar2(10)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT MAI_INSP_LOAD_ERROR_ARE.ARE_INITIATION_TYPE increase to 10 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727985  Area 2 - Balfour Beatty Mott McDonald
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 110178
-- 
-- TASK DETAILS
-- The Inspection Initiation Type can now be up to 10 characters in length (previously 3 characters).
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- MAI_INSP_LOAD_ERROR_ARE.ARE_INITIATION_TYPE increased to varchar2(10)
-- 
------------------------------------------------------------------
alter table mai_insp_load_error_are
modify
( are_initiation_type   varchar2(10)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT DROP MAI3890_DOCTMP, MAI3890_INVTMP and MAI3890_WKTMP tables
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110187
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Drop tables used by redundant module MAI3890
-- 
------------------------------------------------------------------
DECLARE
  ex_not_exists exception;
  pragma exception_init(ex_not_exists,-942);
BEGIN
  EXECUTE IMMEDIATE('DROP TABLE MAI3890_DOCTMP');
EXCEPTION
  WHEN ex_not_exists THEN
     NULL;
  WHEN OTHERS THEN
    RAISE;
END;
/
DECLARE
  ex_not_exists exception;
  pragma exception_init(ex_not_exists,-942);
BEGIN
  EXECUTE IMMEDIATE('DROP TABLE MAI3890_INVTMP');
EXCEPTION
  WHEN ex_not_exists THEN
     NULL;
  WHEN OTHERS THEN
    RAISE;
END;
/
DECLARE
  ex_not_exists exception;
  pragma exception_init(ex_not_exists,-942);
BEGIN
  EXECUTE IMMEDIATE('DROP TABLE MAI3890_WKTMP');
EXCEPTION
  WHEN ex_not_exists THEN
     NULL;
  WHEN OTHERS THEN
    RAISE;
END;
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Temp table for defect selection.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 729347  TfL Capita - new contract
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 110575
-- 
-- TASK DETAILS
-- Defect Selection in the Works Order form (MAI3800) has previously had a limit of around 5000 defects/repairs that match the specified criteria before an error is raised.
-- Changes have been made to remove this limitation.
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Temporary table used by MAI3800 for defect selection.
-- 
------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE mai_def_selection_temp
  (mdst_defect_id  NUMBER(8)  NOT NULL
  ,mdst_action_cat VARCHAR2(1) NOT NULL)
  ON COMMIT DELETE ROWS
/

ALTER TABLE mai_def_selection_temp
 ADD (CONSTRAINT mdst_pk PRIMARY KEY 
  (mdst_defect_id,mdst_action_cat))
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Drop action_wor_status and complete_wor_status triggers
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 728847  Worcestershire County Council (H&W)
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 110266
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 110561
-- 
-- TASK DETAILS
-- When a work order contains multiple Defects and one of the Defects is associated with an Enquiry, the completion of any of the Defects, not associated with the Enquiry, can sometimes trigger a change to the Enquiry status. Modifications have been made to ensure Defect status changes will only affect the Enquiry associated with that Defect.
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Drop action_wor_status and complete_wor_status, which updated the PEM status. Functionality is now triggered on Defect status change
-- 
------------------------------------------------------------------
DECLARE
  ex_not_exists exception;
  pragma exception_init(ex_not_exists,-4080);
BEGIN
 EXECUTE IMMEDIATE('DROP TRIGGER action_wor_status');
EXCEPTION
 WHEN ex_not_exists 
 THEN
    NULL;
 WHEN OTHERS 
 THEN
    RAISE;
END;
/
--
DECLARE
  ex_not_exists exception;
  pragma exception_init(ex_not_exists,-4080);
BEGIN
 EXECUTE IMMEDIATE('DROP TRIGGER complete_wor_status');
EXCEPTION
 WHEN ex_not_exists 
 THEN
    NULL;
 WHEN OTHERS 
 THEN
    RAISE;
END;
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of WOL_TARGET_DATE to WORK_ORDER_LINES
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110522
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of WOL_TARGET_DATE to WORK_ORDER_LINES
-- 
------------------------------------------------------------------
ALTER TABLE work_order_lines
  ADD (wol_target_date DATE);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of CON_RECALC_DUE_DATE to CONTRACTS
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110522
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of CON_RECALC_DUE_DATE to CONTRACTS
-- 
------------------------------------------------------------------
ALTER TABLE contracts
  ADD (con_recalc_due_date VARCHAR2(1));
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Date Authorised Column on WORK_ORDERS
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110527
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Addition of Date Authorised Column on WORK_ORDERS
-- 
------------------------------------------------------------------
ALTER TABLE work_orders
  ADD(wor_date_authorised DATE);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT WOR_REMARKS increased to 1000 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110657
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Increased WORK_ORDERS.WOR_REMARKS to 1000 characters
-- 
------------------------------------------------------------------
alter table work_orders
modify
(wor_remarks   varchar2(1000)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT WORK_ORDER_LINES.WOL_DESCR increased to 1000 chars
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110657
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Increased WORK_ORDER_LINES.WOL_DESCR to 1000 characters
-- 
------------------------------------------------------------------
alter table work_order_lines
modify
(wol_descr   varchar2(1000)
)
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of IWOR_REMARKS to INTERFACE_WOR
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110657
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of IWOR_REMARKS to INTERFACE_WOR
-- 
------------------------------------------------------------------
ALTER TABLE interface_wor
  ADD(iwor_remarks varchar2(1000));
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Addition of iwol_descr to INTERFACE_WOL
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110657
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of iwol_descr to INTERFACE_WOL
-- 
------------------------------------------------------------------
ALTER TABLE interface_wol
  ADD(iwol_descr varchar2(1000));
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New table MAI_USERS
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- **** COMMENTS TO BE ADDED BY MIKE HUITSON ****
-- 
------------------------------------------------------------------
CREATE TABLE MAI_USERS
  (MUS_USER_ID            NUMBER(9)    NOT NULL
  ,MUS_WOR_FLAG           VARCHAR2(1)  NOT NULL
  ,MUS_WOR_VALUE_MIN      NUMBER(9)
  ,MUS_WOR_VALUE_MAX      NUMBER(9)
  ,MUS_WOR_AUR_ALLOWED    VARCHAR2(1)  NOT NULL
  ,MUS_WOR_AUR_MIN        NUMBER(9)
  ,MUS_WOR_AUR_MAX        NUMBER(9)
  ,MUS_WOR_AUR_DAILY_MAX  NUMBER(9))
/

ALTER TABLE MAI_USERS
  ADD CONSTRAINT MUS_PK
  PRIMARY KEY (MUS_USER_ID)
  USING INDEX
/

ALTER TABLE MAI_USERS
  ADD CONSTRAINT MUS_HUS_FK
  FOREIGN KEY (MUS_USER_ID)
  REFERENCES HIG_USERS (HUS_USER_ID)
  ON DELETE CASCADE
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Check column order of DEF_TYPES and rebuild if required.
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Check column order of DEF_TYPES and rebuild if required.
-- 
------------------------------------------------------------------
DECLARE
  --
  TYPE columns_rec IS RECORD(table_name  VARCHAR2(30)
                         ,column_name VARCHAR2(30)
                         ,column_id   NUMBER);
  --
  TYPE columns_tab IS TABLE OF columns_rec INDEX BY BINARY_INTEGER;
  --
  lt_columns columns_tab;
  --
  PROCEDURE add(pi_table_name IN VARCHAR2
               ,pi_column_name IN VARCHAR2
               ,pi_column_id   IN NUMBER)
    IS
    --
  BEGIN
    --
    lt_columns(lt_columns.COUNT+1).table_name := pi_table_name;
    lt_columns(lt_columns.COUNT).column_name := pi_column_name;
    lt_columns(lt_columns.COUNT).column_id := pi_column_id;         
    --
  END add;
  --
  FUNCTION column_ok(pi_column columns_rec)
    RETURN BOOLEAN IS
    --
    CURSOR c1
        IS
    SELECT 'x'
      FROM user_tab_cols
     WHERE table_name = pi_column.table_name
       AND column_name = pi_column.column_name
       AND column_id = pi_column.column_id
         ;
    --
    l_dummy VARCHAR2(1) := Null;
    --
  BEGIN
    --
    OPEN  c1;
    FETCH c1
     INTO l_dummy;
    CLOSE c1;
    --
    IF l_dummy IS NULL
     THEN
        RETURN(FALSE);
    ELSE
        RETURN(TRUE);
    END IF;
    --
  END column_ok;
  --
BEGIN
  /*
  ||Set the column order to check.
  */
  add('DEF_TYPES','DTY_ATV_ACTY_AREA_CODE','1');
  add('DEF_TYPES','DTY_DEFECT_CODE'       ,'2');
  add('DEF_TYPES','DTY_DTP_FLAG'          ,'3');
  add('DEF_TYPES','DTY_DESCR1'            ,'4');
  add('DEF_TYPES','DTY_DESCR2'            ,'5');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_1'    ,'6');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_2'    ,'7');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_3'    ,'8');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_4'    ,'9');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_1'   ,'10');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_2'   ,'11');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_3'   ,'12');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_4'   ,'13');
  add('DEF_TYPES','DTY_START_DATE'        ,'14');
  add('DEF_TYPES','DTY_END_DATE'          ,'15');
  /*
  ||Check the columns.
  */
  FOR i IN 1..lt_columns.COUNT LOOP
    IF NOT column_ok(lt_columns(i))
     THEN
        /*
        ||Column order is not valid so rebuild the table.
        */
        DECLARE
          --
          already_exists EXCEPTION;
          PRAGMA Exception_INIT( already_exists,-01430);
          index_not_found EXCEPTION;
          PRAGMA EXCEPTION_INIT(index_not_found,-01418);
          lv_backup_tab VARCHAR2(100) := 'DEF_TYPES_'||TO_CHAR(SYSDATE,'JSSSSS');
          -- 
        BEGIN
          /*
          ||Make backup copy of original table.
          */
          EXECUTE IMMEDIATE 'ALTER TABLE DEF_TYPES RENAME TO '||lv_backup_tab; 
          /*
          ||Create the table with the correct column order.
          */
          EXECUTE IMMEDIATE 'CREATE TABLE def_types'
                          ||' (dty_atv_acty_area_code VARCHAR2(2) NOT NULL'
                          ||' ,dty_defect_code        VARCHAR2(4) NOT NULL'
                          ||' ,dty_dtp_flag           VARCHAR2(1) NOT NULL'
                          ||' ,dty_descr1             VARCHAR2(40)'
                          ||' ,dty_descr2             VARCHAR2(40)'
                          ||' ,dty_hh_attribute_1     VARCHAR2(32)'
                          ||' ,dty_hh_attribute_2     VARCHAR2(32)'
                          ||' ,dty_hh_attribute_3     VARCHAR2(32)'
                          ||' ,dty_hh_attribute_4     VARCHAR2(32)'
                          ||' ,dty_hh_attri_text_1    VARCHAR2(12)'
                          ||' ,dty_hh_attri_text_2    VARCHAR2(12)'
                          ||' ,dty_hh_attri_text_3    VARCHAR2(12)'
                          ||' ,dty_hh_attri_text_4    VARCHAR2(12)'
                          ||' ,dty_start_date         DATE'
                          ||' ,dty_end_date           DATE)';
          /*
          ||Populate the rebuilt table.
          */
          EXECUTE IMMEDIATE 'INSERT INTO def_types'
                          ||' (dty_atv_acty_area_code'
                          ||' ,dty_defect_code'
                          ||' ,dty_dtp_flag'
                          ||' ,dty_descr1'
                          ||' ,dty_descr2'
                          ||' ,dty_hh_attribute_1'
                          ||' ,dty_hh_attribute_2'
                          ||' ,dty_hh_attribute_3'
                          ||' ,dty_hh_attribute_4'
                          ||' ,dty_hh_attri_text_1'
                          ||' ,dty_hh_attri_text_2'
                          ||' ,dty_hh_attri_text_3'
                          ||' ,dty_hh_attri_text_4'
                          ||' ,dty_start_date'
                          ||' ,dty_end_date) '
                          ||'SELECT dty_atv_acty_area_code'
                          ||' ,dty_defect_code'
                          ||' ,dty_dtp_flag'
                          ||' ,dty_descr1'
                          ||' ,dty_descr2'
                          ||' ,dty_hh_attribute_1'
                          ||' ,dty_hh_attribute_2'
                          ||' ,dty_hh_attribute_3'
                          ||' ,dty_hh_attribute_4'
                          ||' ,dty_hh_attri_text_1'
                          ||' ,dty_hh_attri_text_2'
                          ||' ,dty_hh_attri_text_3'
                          ||' ,dty_hh_attri_text_4'
                          ||' ,dty_start_date'
                          ||' ,dty_end_date'
                          ||' FROM '||lv_backup_tab;
          --
          COMMIT;
          /*
          ||Rebuild the index.
          */
          EXECUTE IMMEDIATE 'DROP INDEX dty_index_p1';
          --
          EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX dty_index_p1 ON def_types(dty_defect_code, dty_atv_acty_area_code, dty_dtp_flag)';
          /*
          ||Analyse the table.
          */
          EXECUTE IMMEDIATE 'ANALYZE TABLE def_types COMPUTE STATISTICS';
          --
        EXCEPTION
          WHEN already_exists 
           THEN
              NULL;
          WHEN index_not_found
           THEN
              NULL;
          WHEN OTHERS
           THEN
              RAISE;
        END;
        /*
        ||Table has been rebuilt so exit the loop.
        */
        EXIT;
        --
    END IF; 
  END LOOP;
  --
END; 
/
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

