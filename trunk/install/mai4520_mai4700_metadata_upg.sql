------------------------------------------------------------------
-- mai4520_mai4700_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4520_mai4700_metadata_upg.sql-arc   1.0   Dec 16 2013 08:46:18   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4520_mai4700_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Dec 16 2013 08:46:18  $
--       Date fetched Out : $Modtime:   Oct 24 2013 10:03:04  $
--       Version          : $Revision:   1.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2013

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF

DECLARE
  l_temp nm3type.max_varchar2;
BEGIN
  -- Dummy call to HIG to instantiate it
  l_temp := hig.get_version;
  l_temp := nm_debug.get_version;
EXCEPTION
  WHEN others
   THEN
 Null;
END;
/

BEGIN
  nm_debug.debug_off;
END;
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT PEDIF File 4 character asset codes
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Previously released as part of MAI 4600 Fix7
-- 
------------------------------------------------------------------
INSERT
  INTO hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
SELECT 'PED4CHRASS'
      ,'MAI'
      ,'PEDIF file 4 Char Asset Codes'
      ,'If set to Y, the 2 character mai Asset Codes will be translated to the 4 Character nm3 equivalents when creating the PEDIF file. If set to N the 2 character codes will be exported as normal.'
      ,'Y_OR_N'
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM hig_option_list
                    WHERE hol_id = 'PED4CHRASS')
/

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value)
SELECT 'PED4CHRASS'
      ,'N'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM hig_option_values
                    WHERE hov_id = 'PED4CHRASS')
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT PEDIF File Date Attributes
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Previously released as part of MAI 4600 Fix8
-- 
------------------------------------------------------------------
INSERT
  INTO hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
SELECT 'PEDDATEATR'
      ,'MAI'
      ,'PEDIF file Date Attributes'
      ,'If set to Y, any date attributes (record type 12) will be exported with a of type "D" and a length of 11 when creating the PEDIF file. If set to N the date attributes will be exported with a type of "S" and a length of 7 as was previously the case before the introduction of this option.'
      ,'Y_OR_N'
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM hig_option_list
                    WHERE hol_id = 'PEDDATEATR')
/

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value)
SELECT 'PEDDATEATR'
      ,'N'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM hig_option_values
                    WHERE hov_id = 'PEDDATEATR')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Product Option CIMMULTFIN
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Product option to allow for multiple Final Invoice files to be processed in CIM
-- 
------------------------------------------------------------------
insert into hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
select 'CIMMULTIF'
      ,'MAI'
      ,'Allow Multi Final CIM Invoices'      
      ,'If set to Y, CIM processing will allow for a Final invoice file to be processed, after a previous Final has been processed'
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'CIMMULTIF')
/

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'CIMMULTIF'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'CIMMULTIF')
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT MAI3505 GRI_MODULE_PARAMS update
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modified for MAI4500 fix 2
-- 
------------------------------------------------------------------
update gri_module_params
set gmp_where = NULL
where gmp_module = 'MAI3505'
and gmp_param = 'ROAD_ID'
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Navigator metadata
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Navigator metadata
-- 
------------------------------------------------------------------
BEGIN
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, HNV_HIER_LABEL_7, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'nm_inv_items_all', 'iit_ne_id', 'defects', 'def_iit_item_id', 
    2, 'Defect', 'iit_ne_id', 'def_defect_id', '-AST1', 
    '-ADEF', 'defect', 'N', 'def_defect_id', 
    'hig_nav.concate_label(def_status_code)', 'hig_nav.concate_label(DEF_ATV_ACTY_AREA_CODE)', 'hig_nav.concate_label(DEF_DEFECT_CODE)', 'hig_nav.concate_label(DEF_PRIORITY)', 'hig_nav.concate_label(DEF_LOCN_DESCR)', 
    'hig_nav.concate_label(DEF_DEFECT_DESCR)', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');

EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;

DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'defects', 'def_are_report_id', 'activities_report', 'are_report_id', 
    3, 'Inspection', 'def_defect_id', 'are_report_id', '-ADEF', 
    '-AINSP', 'inspection', 'Y', 'ARE_REPORT_ID', 
    'hig_nav.concate_label(hig_nav.get_hig_code_meaning(''MAINT_INSP_FLAG'',ARE_MAINT_INSP_FLAG))', 'hig_nav.concate_label(ARE_INITIATION_TYPE)', 'hig_nav.concate_label(ARE_SURFACE_CONDITION)', 'hig_nav.concate_label(hig_nav.get_hig_user_initials(ARE_PEO_PERSON_ID_ACTIONED))', 'hig_nav.concate_label(ARE_BATCH_ID)', 
    TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'defects', 'def_defect_id', 'repairs', 'rep_def_defect_id', 
    3, 'Repair', 'def_defect_id', 'rep_def_defect_id||REP_ACTION_CAT', '-ADEF', 
    '-AREP', 'repair', 'N', 'hig_nav.get_hig_code_meaning(''REPAIR_TYPE'',REP_ACTION_CAT)', 
    'hig_nav.concate_label(REP_TRE_TREAT_CODE)', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'repairs', 'rep_def_defect_id', 'work_order_lines', 'wol_def_defect_id', 
    4, 'Work Order Line', 'rep_def_defect_id||REP_ACTION_CAT', 'wol_id', '-AREP', 
    '-AWOL', 'work_order_line', 'AND REP_ACTION_CAT = WOL_REP_ACTION_CAT', 'N', 'wol_id', 
    'hig_nav.concate_label(wol_status_code)', 'hig_nav.concate_label(hig_nav.get_road_unique(wol_rse_he_id))', 'hig_nav.concate_label(hig_nav.get_road_descr(wol_rse_he_id))', 
    TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'work_order_lines', 'wol_bud_id', 'budgets', 'bud_id', 
    5, 'Budget', 'wol_id', 'bud_id', '-AWOL', 
    '-ABUD', 'budget', 'N', 'BUD_ICB_ITEM_CODE||BUD_ICB_SUB_ITEM_CODE||BUD_ICB_SUB_SUB_ITEM_CODE', 
    'hig_nav.concate_label(hig_nav.get_budget_descr(bud_sys_flag,bud_icb_item_code,bud_icb_sub_item_code,bud_icb_sub_sub_item_code,bud_agency))', 'hig_nav.concate_label(''Budget : ''||bud_value)', 'hig_nav.concate_label(''Committed : ''||BUD_COMMITTED)', 'hig_nav.concate_label(''Actual : ''||BUD_ACTUAL)', 'hig_nav.concate_label(''Balance : ''||hig_nav.get_bud_balance(bud_value,bud_committed,bud_actual))', 
    TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'work_order_lines', 'wol_works_order_no', 'work_orders', 'wor_works_order_no', 
    5, 'Work Order', 'wol_id', 'wor_works_order_no', '-AWOL', 
    '-AWOR', 'works_order', 'N', 'wor_works_order_no', 
    'hig_nav.concate_label(wor_descr)', 'hig_nav.concate_label(wor_scheme_type)', 'hig_nav.concate_label(hig_nav.get_contract_det(wor_con_id))', 
    TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'nm_inv_items_all', 'iit_ne_id', 'schedule_roads', 'schr_iit_item_id', 
    2, 'Cyclic Schedule', 'iit_ne_id', 'schr_schd_id', '-AST1', 
    '-ASCH', 'schedule', 'N', 'schr_schd_id', 
    'hig_nav.concate_label(hig_nav.get_schedule_name(schr_schd_id))', 'hig_nav.concate_label(hig_nav.get_schedule_work_category(schr_schd_id))', 'hig_nav.concate_label(hig_nav.get_schedule_road_group_id(schr_schd_id))', 
    TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'schedule_roads', 'schr_schd_id', 'work_order_lines', 'wol_schd_id', 
    3, 'Work Order Line', 'schr_schd_id', 'wol_id', '-ASCH', 
    '-ASCWOL', 'work_order_line', ' And wol_iit_item_id = schr_iit_item_id ', 'N', 'wol_id', 
    'hig_nav.concate_label(wol_status_code)', 'hig_nav.concate_label(hig_nav.get_road_unique(wol_rse_he_id))', 'hig_nav.concate_label(hig_nav.get_road_descr(wol_rse_he_id))', 
    TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY, HNV_HPR_PRODUCT)
 Values
   ('Assets', 'work_order_lines', 'wol_works_order_no', 'work_orders', 'wor_works_order_no', 
    4, 'Work Order', 'wol_id', 'wor_works_order_no', '-ASCWOL', 
    '-ASCWOR', 'works_order', 'N', 'wor_works_order_no', 
    'hig_nav.concate_label(wor_descr)', 'hig_nav.concate_label(wor_scheme_type)', 'hig_nav.concate_label(hig_nav.get_contract_det(wor_con_id))', 
    TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/18/2012 10:41:05', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', 'MAI');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
DECLARE
--
   already_exists Exception;
   pragma exception_init(already_exists,-00001);
--
BEGIN
--
    Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, HNM_MODIFIED_BY)
 Values
   ('MAI3860', 'SCHD_ID', 'Y', 1, 
    'Cyclic Schedule', TO_DATE('05/09/2012 10:56:35', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS', TO_DATE('05/09/2012 10:56:35', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
EXCEPTION 
   WHEN already_exists
   Then 
       Null;
   WHEN Others 
   Then 
       Raise;
END ;
END ;
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New product option UPDWOTGT
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modified for MAI4500 fix 1
-- 
------------------------------------------------------------------
insert into hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
select 'UPDWOTGT'
      ,'MAI'
      ,'Allow update to WO Target Date'      
      ,'If set to Y, the WO Target Date will allow manual update '
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'UPDWOTGT')
/

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'UPDWOTGT'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'UPDWOTGT')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT HIG_OPTION_LIST update
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modified incorrect metadata settings for 'GISGRPD','GISGRPL','GISGRPTYP' product options
-- 
------------------------------------------------------------------
update hig_option_list
set hol_mixed_case = 'N', 
      hol_user_option = 'Y'
where hol_id in ('GISGRPD','GISGRPL','GISGRPTYP')
/
------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

