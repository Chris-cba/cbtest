------------------------------------------------------------------
-- mai4200_mai4210_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4200_mai4210_metadata_upg.sql-arc   3.4   May 11 2010 14:08:06   malexander  $
--       Module Name      : $Workfile:   mai4200_mai4210_metadata_upg.sql  $
--       Date into PVCS   : $Date:   May 11 2010 14:08:06  $
--       Date fetched Out : $Modtime:   May 11 2010 14:05:28  $
--       Version          : $Revision:   3.4  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2010

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
PROMPT New Product Option WORREFUSER
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New Product Option to force the use of the User's Admin Unit rather than the Contract Admin Unit when generating an Admin Unit based Work Order Number.
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
SELECT 'WORREFUSER'
      ,'MAI'
      ,'Use The Users Admin Unit (Y/N)'
      ,'When the product option WORREFGEN is set to ''A'' (Admin Unit) this option can be set to ''Y'' to force the generation of Work Order Numbers to always use the Users Admin Unit rather than the Admin Unit of the selected Contract.'
      ,'Y_OR_N'
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_list
                   WHERE hol_id = 'WORREFUSER')
/

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value) 
SELECT 'WORREFUSER'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_values
                   WHERE hov_id = 'WORREFUSER')
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Work Order Line and Defect Status Codes.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109186
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New Status Codes for Work Order Lines and Defects.
-- 
------------------------------------------------------------------
UPDATE hig_status_domains
   SET hsd_feature10 = 'Initial Work Order Line Status'
 WHERE hsd_domain_code = 'WORK_ORDER_LINES'
     ;

INSERT
  INTO HIG_STATUS_CODES
      (HSC_DOMAIN_CODE
      ,HSC_STATUS_CODE
      ,HSC_STATUS_NAME
      ,HSC_SEQ_NO
      ,HSC_ALLOW_FEATURE1
      ,HSC_ALLOW_FEATURE2
      ,HSC_ALLOW_FEATURE3
      ,HSC_ALLOW_FEATURE4
      ,HSC_ALLOW_FEATURE5
      ,HSC_ALLOW_FEATURE6
      ,HSC_ALLOW_FEATURE7
      ,HSC_ALLOW_FEATURE8
      ,HSC_ALLOW_FEATURE9
      ,HSC_START_DATE
      ,HSC_END_DATE
      ,HSC_ALLOW_FEATURE10)
SELECT 'WORK_ORDER_LINES'
      ,'DRAFT'
      ,'Draft - New Work Order Line'
      ,1
      ,'Y'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,NULL
      ,NULL
      ,'Y'
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                     AND HSC_STATUS_CODE = 'DRAFT')
/

UPDATE hig_status_domains
   SET hsd_feature10 = 'At least one repair on the defect has been assigned to a work order that has not yet been instructed.'||CHR(10)||'This status will be set in MAI3800 or MAI3801.'
 WHERE hsd_domain_code = 'DEFECTS'
/

INSERT
  INTO HIG_STATUS_CODES
      (HSC_DOMAIN_CODE
      ,HSC_STATUS_CODE
      ,HSC_STATUS_NAME
      ,HSC_SEQ_NO
      ,HSC_ALLOW_FEATURE1
      ,HSC_ALLOW_FEATURE2
      ,HSC_ALLOW_FEATURE3
      ,HSC_ALLOW_FEATURE4
      ,HSC_ALLOW_FEATURE5
      ,HSC_ALLOW_FEATURE6
      ,HSC_ALLOW_FEATURE7
      ,HSC_ALLOW_FEATURE8
      ,HSC_ALLOW_FEATURE9
      ,HSC_START_DATE
      ,HSC_END_DATE
      ,HSC_ALLOW_FEATURE10)
SELECT 'DEFECTS'
      ,'SELECTED'
      ,'Selected onto Works Order'
      ,1
      ,'N'
      ,'N'
      ,'Y'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,'N'
      ,NULL
      ,NULL
      ,'Y'
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'DEFECTS'
                     AND HSC_STATUS_CODE = 'SELECTED')
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New assets shipped for Audit and Alert
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108985
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- This assets will be part of meta data, this will be required to setup Audits and Alerts on the underlying tables. All this assets will be created with suffix '$'.
-- 
-- 
------------------------------------------------------------------
Prompt Inserting into  nm_au_types
INSERT INTO nm_au_types SELECT 'EXT$','Admin Type for Navigator, Audit and Alert Meta Models',Null,Null,Null,Null 
                          FROM   dual 
                          WHERE  NOT EXISTS (SELECT 'x'
                                               FROM    nm_au_types 
                                               WHERE   nat_admin_type = 'EXT$');


Prompt Inserting into NM_INV_TYPES_ALL
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       ,NIT_NOTES
       )
SELECT 
        'WOR$'
       ,'P'
       ,'N'
       ,'C'
       ,'N'
       ,'N'
       ,'N'
       ,'A'
       ,'Works Orders'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,'V_NM_LWOR'
       ,to_date('19010101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,'WORK_ORDERS'
       ,''
       ,''
       ,''
       ,'EXT$'
       ,''
       ,'N'
       ,'WOR_WORKS_ORDER_NO'
       ,'Y'
       ,Sysdate
       ,sysdate
       ,USER
       ,USER
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'WOR$');


INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       ,NIT_NOTES
       )
SELECT 
        'WOL$'
       ,'P'
       ,'N'
       ,'C'
       ,'N'
       ,'N'
       ,'N'
       ,'A'
       ,'Works Order Lines'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,'V_NM_LWOL'
       ,to_date('19010101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,'WORK_ORDER_LINES'
       ,''
       ,''
       ,''
       ,'EXT$'
       ,''
       ,'N'
       ,'WOL_ID'
       ,'Y'
       ,Sysdate
       ,sysdate
       ,USER
       ,USER
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'WOL$');

INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       ,NIT_NOTES
       )
SELECT 
        'DEF$'
       ,'P'
       ,'N'
       ,'C'
       ,'N'
       ,'N'
       ,'N'
       ,'A'
       ,'Defects'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,'V_NM_LDEF'
       ,to_date('19010101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,'DEFECTS'
       ,''
       ,''
       ,''
       ,'EXT$'
       ,''
       ,'N'
       ,'DEF_DEFECT_ID'
       ,'Y'
       ,Sysdate
       ,sysdate
       ,USER
       ,USER
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'DEF$');


INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       ,NIT_NOTES
       )
SELECT 
        'BOQ$'
       ,'P'
       ,'N'
       ,'C'
       ,'N'
       ,'N'
       ,'N'
       ,'A'
       ,'BOQ Items'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,'V_NM_LBOQ'
       ,to_date('19010101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,'BOQ_ITEMS'
       ,''
       ,''
       ,''
       ,'EXT$'
       ,''
       ,'N'
       ,'BOQ_ID'
       ,'Y'
       ,Sysdate
       ,sysdate
       ,USER
       ,USER
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'BOQ$');

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Navigator matadata
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Navigator Hierarchy metadata setup
-- 
------------------------------------------------------------------
Delete from HIG_NAVIGATOR where HNV_HIERARCHY_TYPE IN ('Works Orders','Defects');

delete from hig_navigator_modules where hnm_hierarchy_label != 'Enquiry' ;

Prompt Inserting into HIG_NAVIGATOR
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', NULL, NULL, 'work_orders', 'wor_works_order_no', 
    1, 'Work Order', NULL, 'wor_works_order_no', NULL, 
    '-WOR', 'works_order', NULL, 'Y', 'wor_works_order_no', 
    'hig_nav.concate_label(wor_descr)', 'hig_nav.concate_label(wor_scheme_type)', 'hig_nav.concate_label(hig_nav.get_contract_det(wor_con_id))', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/30/2010 14:46:31', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'WORK_ORDERS', 'wor_works_order_no', 'work_order_lines', 'wol_works_order_no', 
    2, 'Work Order Line', 'wol_works_order_no', 'wol_id', '-WOR', 
    '-WOL', 'work_order_line', NULL, 'Y', 'wol_id', 
    'hig_nav.concate_label(wol_status_code)', 'hig_nav.concate_label(wol_rse_he_id)', 'hig_nav.concate_label(hig_nav.get_road_descr(wol_rse_he_id))', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/19/2010 16:35:07', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'WOR_ORDER_LINES', 'wol_bud_id', 'budgets', 'bud_id', 
    3, 'Budget', 'wol_id', 'bud_id', '-WOL', 
    '-BUD', 'budget', NULL, NULL, 'BUD_ICB_ITEM_CODE||BUD_ICB_SUB_ITEM_CODE||BUD_ICB_SUB_SUB_ITEM_CODE', 
    'hig_nav.concate_label(hig_nav.get_budget_descr(bud_sys_flag,bud_icb_item_code,bud_icb_sub_item_code,bud_icb_sub_sub_item_code,bud_agency))', 'hig_nav.concate_label(''Budget : ''||bud_value)', 'hig_nav.concate_label(''Committed : ''||BUD_COMMITTED)', 'hig_nav.concate_label(''Actual : ''||BUD_ACTUAL)', 'hig_nav.concate_label(''Balance : ''||hig_nav.get_bud_balance(bud_value,bud_committed,bud_actual))', 
    NULL, NULL, NULL, NULL, 1, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/19/2010 16:35:11', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'WORK_ORDER_LINES', 'wol_id', 'tma_id_mapping', 'TIDM_PRIMARY_KEY_VALUE', 
    3, 'Notice', 'wol_id', 'tidm_id', '-WOL', 
    '-TMID', 'tma', 'AND TIDM_ORIGIN = ''WOL''', NULL, 'hig_nav.tma_notice_details(TIDM_RESULTANT_WORKS_ID)', 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, 2, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 09:39:16', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'work_order_lines', 'wol_def_defect_id', 'repairs', 'rep_def_defect_id', 
    3, 'Repair', 'wol_id', 'rep_def_defect_id||rep_action_cat', '-WOL', 
    '-WREP', 'repair', 'AND REP_ACTION_CAT = WOL_REP_ACTION_CAT', NULL, 'hig_nav.get_hig_code_meaning(''REPAIR_TYPE'',REP_ACTION_CAT)', 
    'hig_nav.concate_label(REP_TRE_TREAT_CODE)', NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, 3, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 10:51:45', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'repairs', 'rep_def_defect_id', 'defects', 'def_defect_id', 
    4, 'Defect', 'rep_def_defect_id||rep_action_cat', 'def_defect_id', '-WREP', 
    '-INST', 'defect', NULL, NULL, 'def_defect_id', 
    'hig_nav.concate_label(def_status_code)', 'hig_nav.concate_label(DEF_ATV_ACTY_AREA_CODE)', 'hig_nav.concate_label(DEF_DEFECT_CODE)', 'hig_nav.concate_label(DEF_PRIORITY)', 'hig_nav.concate_label(DEF_LOCN_DESCR)', 
    'hig_nav.concate_label(DEF_DEFECT_DESCR)', NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/19/2010 16:35:21', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'defects', 'To_char(def_defect_id)', 'doc_assocs,docs', 'das_rec_id', 
    5, 'Enquiry', 'def_defect_id', 'das_doc_id', '-INST', 
    '-DOC', 'enquiry', 'AND das_doc_id = docs.doc_id  
AND  doc_dtp_code IN (select dtp_code from doc_types WHERE dtp_allow_complaints = ''Y'')
AND (das_table_name IN (select dgs_table_syn from DOC_GATE_SYNS where dgs_dgt_table_name = ''DEFECTS'') or das_table_name = ''DEFECTS'')
', NULL, 'das_doc_id', 
    'hig_nav.concate_label(hig_nav.get_doc_status_code(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_dtp_code(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_dcl_code(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_compl_type(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_descr(das_doc_id))', 
    'hig_nav.concate_label(hig_nav.get_doc_compl_location(das_doc_id))', NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 09:55:00', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'defects', 'def_are_report_id', 'ACTIVITIES_REPORT', 'are_report_id', 
    4, 'Inspection', 'def_defect_id', 'are_report_id', '-INST', 
    '-INS1', 'inspection', NULL, NULL, 'ARE_REPORT_ID', 
    'hig_nav.concate_label(hig_nav.get_hig_code_meaning(''MAINT_INSP_FLAG'',ARE_MAINT_INSP_FLAG))', 'hig_nav.concate_label(ARE_INITIATION_TYPE)', 'hig_nav.concate_label(ARE_SURFACE_CONDITION)', 'hig_nav.concate_label(hig_nav.get_hig_user_initials(ARE_PEO_PERSON_ID_ACTIONED))', 'hig_nav.concate_label(ARE_BATCH_ID)', 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 09:54:52', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Works Orders', 'defects', 'def_iit_item_id', 'nm_inv_items_all ast', 'ast.iit_ne_id', 
    5, 'Asset', 'def_defect_id', 'ast.iit_ne_id', '-INST', 
    '-AST', 'asset', NULL, NULL, 'ast.iit_primary_key', 
    'hig_nav.concate_label(ast.iit_inv_type)', 'hig_nav.concate_label(hig_nav.get_asset_descr(ast.iit_inv_type))', NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 09:54:49', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', NULL, NULL, 'defects', 'def_defect_id', 
    1, 'Defect', NULL, 'def_defect_id', NULL, 
    '-DEF', 'defect', NULL, 'Y', 'def_defect_id', 
    'hig_nav.concate_label(def_status_code)', 'hig_nav.concate_label(DEF_ATV_ACTY_AREA_CODE)', 'hig_nav.concate_label(DEF_DEFECT_CODE)', 'hig_nav.concate_label(DEF_PRIORITY)', 'hig_nav.concate_label(DEF_LOCN_DESCR)', 
    'hig_nav.concate_label(DEF_DEFECT_DESCR)', NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/30/2010 14:49:56', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'defects', 'def_are_report_id', 'activities_report', 'are_report_id', 
    2, 'Inspection', 'def_defect_id', 'are_report_id', '-DEF', 
    '-INSP', 'inspection', NULL, 'Y', 'ARE_REPORT_ID', 
    'hig_nav.concate_label(hig_nav.get_hig_code_meaning(''MAINT_INSP_FLAG'',ARE_MAINT_INSP_FLAG))', 'hig_nav.concate_label(ARE_INITIATION_TYPE)', 'hig_nav.concate_label(ARE_SURFACE_CONDITION)', 'hig_nav.concate_label(hig_nav.get_hig_user_initials(ARE_PEO_PERSON_ID_ACTIONED))', 'hig_nav.concate_label(ARE_BATCH_ID)', 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/30/2010 14:51:12', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'defects', 'To_Char(def_defect_id)', 'doc_assocs,docs', 'das_rec_id', 
    2, 'Enquiry', 'def_defect_id', 'das_doc_id', '-DEF', 
    '-ENQ', 'enquiry', 'AND das_doc_id = docs.doc_id  
AND  doc_dtp_code IN (select dtp_code from doc_types WHERE dtp_allow_complaints = ''Y'')
AND (das_table_name IN (select dgs_table_syn from DOC_GATE_SYNS where dgs_dgt_table_name = ''DEFECTS'') or das_table_name = ''DEFECTS'')
  ', NULL, 'das_doc_id', 
    'hig_nav.concate_label(hig_nav.get_doc_status_code(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_dtp_code(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_dcl_code(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_compl_type(das_doc_id))', 'hig_nav.concate_label(hig_nav.get_doc_descr(das_doc_id))', 
    'hig_nav.concate_label(hig_nav.get_doc_compl_location(das_doc_id))', NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/19/2010 22:28:34', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'defects', 'def_iit_item_id', 'nm_inv_items_all', 'iit_ne_id', 
    2, 'Asset', 'def_defect_id', 'iit_ne_id', '-DEF', 
    '-DAST', 'asset', NULL, NULL, 'iit_primary_key', 
    'hig_nav.concate_label(iit_inv_type)', 'hig_nav.concate_label(hig_nav.get_asset_descr(iit_inv_type))', NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/21/2010 13:35:55', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'defects', 'def_defect_id', 'repairs', 'rep_def_defect_id', 
    2, 'Repair', 'def_defect_id', 'rep_def_defect_id||REP_ACTION_CAT', '-DEF', 
    '-REP', 'repair', NULL, NULL, 'hig_nav.get_hig_code_meaning(''REPAIR_TYPE'',REP_ACTION_CAT)', 
    'hig_nav.concate_label(REP_TRE_TREAT_CODE)', NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/19/2010 21:51:04', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'repairs', 'rep_def_defect_id', 'work_order_lines', 'wol_def_defect_id', 
    3, 'Work Order Line', 'rep_def_defect_id||REP_ACTION_CAT', 'wol_id', '-REP', 
    '-DWOL', 'work_order_line', 'AND REP_ACTION_CAT = WOL_REP_ACTION_CAT', NULL, 'wol_id', 
    'hig_nav.concate_label(wol_status_code)', 'hig_nav.concate_label(wol_rse_he_id)', 'hig_nav.concate_label(hig_nav.get_road_descr(wol_rse_he_id))', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 10:52:06', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'work_order_lines', 'wol_works_order_no', 'work_orders', 'wor_works_order_no', 
    4, 'Work Order', 'wol_id', 'wor_works_order_no', '-DWOL', 
    '-DWOR', 'works_order', NULL, NULL, 'wor_works_order_no', 
    'hig_nav.concate_label(wor_descr)', 'hig_nav.concate_label(wor_scheme_type)', 'hig_nav.concate_label(hig_nav.get_contract_det(wor_con_id))', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 09:54:39', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'work_order_lines', 'wol_bud_id', 'budgets', 'bud_id', 
    4, 'Budget', 'wol_id', 'bud_id', '-DWOL', 
    '-DBUD', 'budget', NULL, NULL, 'BUD_ICB_ITEM_CODE||BUD_ICB_SUB_ITEM_CODE||BUD_ICB_SUB_SUB_ITEM_CODE', 
    'hig_nav.concate_label(hig_nav.get_budget_descr(bud_sys_flag,bud_icb_item_code,bud_icb_sub_item_code,bud_icb_sub_sub_item_code,bud_agency))', 'hig_nav.concate_label(''Budget : ''||bud_value)', 'hig_nav.concate_label(''Committed : ''||BUD_COMMITTED)', 'hig_nav.concate_label(''Actual : ''||BUD_ACTUAL)', 'hig_nav.concate_label(''Balance : ''||hig_nav.get_bud_balance(bud_value,bud_committed,bud_actual))', 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 09:54:36', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');
Insert into HIG_NAVIGATOR
   (HNV_HIERARCHY_TYPE, HNV_PARENT_TABLE, HNV_PARENT_COLUMN, HNV_CHILD_TABLE, HNV_CHILD_COLUMN, 
    HNV_HIERARCHY_LEVEL, HNV_HIERARCHY_LABEL, HNV_PARENT_ID, HNV_CHILD_ID, HNV_PARENT_ALIAS, 
    HNV_CHILD_ALIAS, HNV_ICON_NAME, HNV_ADDITIONAL_COND, HNV_PRIMARY_HIERARCHY, HNV_HIER_LABEL_1, 
    HNV_HIER_LABEL_2, HNV_HIER_LABEL_3, HNV_HIER_LABEL_4, HNV_HIER_LABEL_5, HNV_HIER_LABEL_6, 
    HNV_HIER_LABEL_7, HNV_HIER_LABEL_8, HNV_HIER_LABEL_9, HNV_HIER_LABEL_10, HNV_HIERARCHY_SEQ, 
    HNV_DATE_CREATED, HNV_CREATED_BY, HNV_DATE_MODIFIED, HNV_MODIFIED_BY)
 Values
   ('Defects', 'work_order_lines', 'wol_id', 'tma_id_mapping', 'tidm_primary_key_value', 
    4, 'Notice', 'wol_id', 'tidm_id', '-DWOL', 
    '-DTMA', 'tma', 'AND TIDM_ORIGIN = ''WOL''', NULL, 'hig_nav.tma_notice_details(TIDM_RESULTANT_WORKS_ID)', 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('04/22/2010 09:54:24', 'MM/DD/YYYY HH24:MI:SS'), 'HIGHWAYS');


Prompt Inserting Into HIG_NAVIGATOR_MODULES....
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3800', 'wo_no', 'Y', 1, 'WORK_ORDERS', 
    'B1.WOR_WORKS_ORDER_NO', 'Work Order', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3800', 'wol_id', 'Y', 1, 'WORK_ORDER_LINES', 
    'B2.WOL_ID', 'Work Order Line', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3806', 'defect_id', 'Y', 1, 'DEFECTS', 
    'B1.DEF_DEFECT_ID', 'Defect', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3808', 'are_report_id', 'Y', 1, NULL, 
    NULL, 'Inspection', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('02/24/2010 11:27:03', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3660', 'bud_id', 'Y', 1, NULL, 
    NULL, 'Budget', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('02/22/2010 16:53:43', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3808', 'nav_defect_id', 'N', 2, NULL, 
    NULL, 'Defect', TO_DATE('03/30/2010 17:47:40', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/30/2010 17:47:40', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3808', 'nav_defect_id', 'N', 2, NULL, 
    NULL, 'Repair', TO_DATE('03/30/2010 17:48:29', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/30/2010 17:48:29', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
Insert into HIG_NAVIGATOR_MODULES
   (HNM_MODULE_NAME, HNM_MODULE_PARAM, HNM_PRIMARY_MODULE, HNM_SEQUENCE, HNM_TABLE_NAME, 
    HNM_FIELD_NAME, HNM_HIERARCHY_LABEL, HNM_DATE_CREATED, HNM_CREATED_BY, HNM_DATE_MODIFIED, 
    HNM_MODIFIED_BY)
 Values
   ('MAI3806', 'defect_id', 'Y', 1, NULL, 
    NULL, 'Repair', TO_DATE('03/30/2010 17:48:29', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/30/2010 17:48:29', 'MM/DD/YYYY HH24:MI:SS'), 
    'DORSET');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Create Attributes for Audit Assets WOR$ script 1
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108985
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Creating attributes for Work Order Asset for Audit
-- 
------------------------------------------------------------------
Delete  From nm_inv_type_attribs_all Where ita_inv_type = 'WOR$' ;

Prompt Inserting into nm_inv_type_attribs_all
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_WORKS_ORDER_NO', 'N', 1, 'N', 
    'VARCHAR2', 16, 0, 'Work Order', NULL, 
    'N', NULL, NULL, NULL, 'WOR_WORKS_ORDER_NO', 
    'WOR_WORKS_ORDER_NO', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    16, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_RSE_HE_ID_GROUP', 'N', 3, 'N', 
    'NUMBER', 9, 0, 'Group ID', NULL, 
    'N', NULL, NULL, NULL, 'WOR_RSE_HE_ID_GROUP', 
    'WOR_RSE_HE_ID_GROUP', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 17:00:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'SELECT NE_UNIQUE ,NE_DESCR ,NE_ID  
FROM NM_ELEMENTS WHERE NE_GTY_GROUP_TYPE IN (SELECT NGT_GROUP_TYPE FROM NM_GROUP_TYPES WHERE  NGT_NT_TYPE IN (SELECT NT_TYPE FROM NM_TYPES WHERE NT_DATUM != ''Y''))', 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CON_ID', 'N', 5, 'N', 
    'NUMBER', 9, 0, 'Contract ID', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CON_ID', 
    'WOR_CON_ID', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select con_code ,con_name ,con_id  from contracts', 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ACT_BALANCING_SUM', 'N', 7, 'N', 
    'NUMBER', 11, 2, 'Actual Balancing Sum', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ACT_BALANCING_SUM', 
    'WOR_ACT_BALANCING_SUM', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    11, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ACT_COST', 'N', 8, 'N', 
    'NUMBER', 11, 2, 'Actual Sub Total', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ACT_COST', 
    'WOR_ACT_COST', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    11, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CLOSED_BY_ID', 'N', 13, 'N', 
    'NUMBER', 8, 0, 'Closed By ID', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CLOSED_BY_ID', 
    'WOR_CLOSED_BY_ID', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hus_initials ,hus_name ,hus_user_id 
from hig_users', 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_COC_COST_CENTRE', 'N', 14, 'N', 
    'VARCHAR2', 3, 0, 'Cost Centre', NULL, 
    'N', NULL, NULL, NULL, 'WOR_COC_COST_CENTRE', 
    'WOR_COC_COST_CENTRE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    3, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_COST_RECHARG', 'N', 15, 'N', 
    'NUMBER', 11, 2, 'Cost Recharged', NULL, 
    'N', NULL, NULL, NULL, 'WOR_COST_RECHARG', 
    'WOR_COST_RECHARG', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    11, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DATE_CLOSED', 'N', 16, 'N', 
    'DATE', 7, 0, 'Date Completed', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DATE_CLOSED', 
    'WOR_DATE_CLOSED', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DATE_CONFIRMED', 'N', 17, 'N', 
    'DATE', 7, 0, 'Date Instructed', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DATE_CONFIRMED', 
    'WOR_DATE_CONFIRMED', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DATE_MOD', 'N', 18, 'N', 
    'DATE', 7, 0, 'Date Modified', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DATE_MOD', 
    'WOR_DATE_MOD', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DATE_RAISED', 'N', 19, 'N', 
    'DATE', 7, 0, 'Date Raised', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DATE_RAISED', 
    'WOR_DATE_RAISED', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DESCR', 'N', 20, 'N', 
    'VARCHAR2', 100, 0, 'Wor Description', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DESCR', 
    'WOR_DESCR', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    100, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_EST_BALANCING_SUM', 'N', 23, 'N', 
    'NUMBER', 11, 2, 'Estimate Balancing Sum', NULL, 
    'N', NULL, NULL, NULL, 'WOR_EST_BALANCING_SUM', 
    'WOR_EST_BALANCING_SUM', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    11, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_EST_COMPLETE', 'N', 24, 'N', 
    'DATE', 7, 0, 'Target Complete', NULL, 
    'N', NULL, NULL, NULL, 'WOR_EST_COMPLETE', 
    'WOR_EST_COMPLETE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_EST_COST', 'N', 25, 'N', 
    'NUMBER', 11, 2, 'Estimate Sub Total', NULL, 
    'N', NULL, NULL, NULL, 'WOR_EST_COST', 
    'WOR_EST_COST', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    11, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_EST_LABOUR', 'N', 26, 'N', 
    'NUMBER', 11, 2, 'Labour Units', NULL, 
    'N', NULL, NULL, NULL, 'WOR_EST_LABOUR', 
    'WOR_EST_LABOUR', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    11, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ICB_ITEM_CODE', 'N', 27, 'N', 
    'VARCHAR2', 2, 0, 'Work Order Item Code', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ICB_ITEM_CODE', 
    'WOR_ICB_ITEM_CODE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ICB_SUB_ITEM_CODE', 'N', 28, 'N', 
    'VARCHAR2', 2, 0, 'Work Order Sub Item Code', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ICB_SUB_ITEM_CODE', 
    'WOR_ICB_SUB_ITEM_CODE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ICB_SUB_SUB_ITEM_CODE', 'N', 29, 'N', 
    'VARCHAR2', 2, 0, 'Work Order Sub Sub Item Code', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ICB_SUB_SUB_ITEM_CODE', 
    'WOR_ICB_SUB_SUB_ITEM_CODE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_JOB_NUMBER', 'N', 30, 'N', 
    'VARCHAR2', 5, 0, 'Job Number', NULL, 
    'N', NULL, NULL, NULL, 'WOR_JOB_NUMBER', 
    'WOR_JOB_NUMBER', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    5, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_LAST_PRINT_DATE', 'N', 31, 'N', 
    'DATE', 7, 0, 'Last Printed', NULL, 
    'N', NULL, NULL, NULL, 'WOR_LAST_PRINT_DATE', 
    'WOR_LAST_PRINT_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_MOD_BY_ID', 'N', 33, 'N', 
    'NUMBER', 8, 0, 'Modified By ID', NULL, 
    'N', NULL, NULL, NULL, 'WOR_MOD_BY_ID', 
    'WOR_MOD_BY_ID', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hus_initials ,hus_name ,hus_user_id 
from hig_users', 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_OUN_ORG_ID', 'N', 34, 'N', 
    'NUMBER', 8, 0, 'Contractor ID', NULL, 
    'N', NULL, NULL, NULL, 'WOR_OUN_ORG_ID', 
    'WOR_OUN_ORG_ID', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select oun_org_id ,oun_name ,oun_org_id 
from org_units', 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_PEO_PERSON_ID', 'N', 35, 'N', 
    'NUMBER', 8, 0, 'Originator User ID', NULL, 
    'N', NULL, NULL, NULL, 'WOR_PEO_PERSON_ID', 
    'WOR_PEO_PERSON_ID', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hus_initials ,hus_name ,hus_user_id 
from hig_users', 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_REMARKS', 'N', 37, 'N', 
    'VARCHAR2', 70, 0, 'Remarks', NULL, 
    'N', NULL, NULL, NULL, 'WOR_REMARKS', 
    'WOR_REMARKS', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    70, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_SCHEME_TYPE', 'N', 41, 'N', 
    'VARCHAR2', 2, 0, 'Scheme Type', NULL, 
    'N', NULL, NULL, NULL, 'WOR_SCHEME_TYPE', 
    'WOR_SCHEME_TYPE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hco_code,hco_meaning,hco_code from HIG_CODES
Where hco_domain = ''SCHEME_TYPES''
order by hco_meaning', 'Y', 
    2, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_SCORE', 'N', 42, 'N', 
    'NUMBER', 1, 0, 'Contractor Score', NULL, 
    'N', NULL, NULL, NULL, 'WOR_SCORE', 
    'WOR_SCORE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_INTERIM_PAYMENT_FLAG', 'N', 44, 'N', 
    'VARCHAR2', 1, 0, 'Interim Payment?', NULL, 
    'N', NULL, NULL, NULL, 'WOR_INTERIM_PAYMENT_FLAG', 
    'WOR_INTERIM_PAYMENT_FLAG', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_RISK_ASSESSMENT_FLAG', 'N', 45, 'N', 
    'VARCHAR2', 1, 0, 'Risk Assessment Report', NULL, 
    'N', NULL, NULL, NULL, 'WOR_RISK_ASSESSMENT_FLAG', 
    'WOR_RISK_ASSESSMENT_FLAG', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_METHOD_STATEMENT_FLAG', 'N', 46, 'N', 
    'VARCHAR2', 1, 0, 'Method Statement', NULL, 
    'N', NULL, NULL, NULL, 'WOR_METHOD_STATEMENT_FLAG', 
    'WOR_METHOD_STATEMENT_FLAG', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_WORKS_PROGRAMME_FLAG', 'N', 47, 'N', 
    'VARCHAR2', 1, 0, 'Works Programme?', NULL, 
    'N', NULL, NULL, NULL, 'WOR_WORKS_PROGRAMME_FLAG', 
    'WOR_WORKS_PROGRAMME_FLAG', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ADDITIONAL_SAFETY_FLAG', 'N', 48, 'N', 
    'VARCHAR2', 1, 0, 'Additional Safety', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ADDITIONAL_SAFETY_FLAG', 
    'WOR_ADDITIONAL_SAFETY_FLAG', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DEF_CORRECTION', 'N', 49, 'N', 
    'DATE', 7, 0, 'Defect Correction', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DEF_CORRECTION', 
    'WOR_DEF_CORRECTION', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DEF_CORRECTION_ACCEPTABLE', 'N', 50, 'N', 
    'VARCHAR2', 1, 0, 'Quality Acceptable?', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DEF_CORRECTION_ACCEPTABLE', 
    'WOR_DEF_CORRECTION_ACCEPTABLE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Create Attributes for Audit Assets WOR$ script 2
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108985
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Creating attributes for Work Order Asset for Audit
-- 
------------------------------------------------------------------
Prompt Inserting into nm_inv_type_attribs_all
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CORR_EXTENSION_TIME', 'N', 51, 'N', 
    'NUMBER', 2, 0, 'Defect Correction Period', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CORR_EXTENSION_TIME', 
    'WOR_CORR_EXTENSION_TIME', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_REVISED_COMP_DATE', 'N', 52, 'N', 
    'DATE', 7, 0, 'Revised Completion', NULL, 
    'N', NULL, NULL, NULL, 'WOR_REVISED_COMP_DATE', 
    'WOR_REVISED_COMP_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_PRICE_VARIATION', 'N', 53, 'N', 
    'NUMBER', 6, 4, 'Final Price Variation%', NULL, 
    'N', NULL, NULL, NULL, 'WOR_PRICE_VARIATION', 
    'WOR_PRICE_VARIATION', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    6, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_COMMENCE_BY', 'N', 54, 'N', 
    'DATE', 7, 0, 'Planned Start', NULL, 
    'N', NULL, NULL, NULL, 'WOR_COMMENCE_BY', 
    'WOR_COMMENCE_BY', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ACT_COMMENCE_BY', 'N', 55, 'N', 
    'DATE', 7, 0, 'Actual Start', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ACT_COMMENCE_BY', 
    'WOR_ACT_COMMENCE_BY', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DEF_CORRECTION_PERIOD', 'N', 56, 'N', 
    'NUMBER', 2, 0, 'Extension of Time', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DEF_CORRECTION_PERIOD', 
    'WOR_DEF_CORRECTION_PERIOD', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_REASON_NOT_CHEAPEST', 'N', 57, 'N', 
    'VARCHAR2', 100, 0, 'Reason not Cheapest', NULL, 
    'N', NULL, NULL, NULL, 'WOR_REASON_NOT_CHEAPEST', 
    'WOR_REASON_NOT_CHEAPEST', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    100, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_PRIORITY', 'N', 58, 'N', 
    'VARCHAR2', 1, 0, 'Priority', NULL, 
    'N', NULL, NULL, NULL, 'WOR_PRIORITY', 
    'WOR_PRIORITY', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hco_code,hco_meaning,hco_code from HIG_CODES
Where hco_domain = ''WOR_PRIORITY''
order by hco_meaning', 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_PERC_ITEM_COMP', 'N', 59, 'N', 
    'VARCHAR2', 10, 0, 'Percent Item Computation', NULL, 
    'N', NULL, NULL, NULL, 'WOR_PERC_ITEM_COMP', 
    'WOR_PERC_ITEM_COMP', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CONTACT', 'N', 60, 'N', 
    'VARCHAR2', 80, 0, 'Contact', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CONTACT', 
    'WOR_CONTACT', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    80, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_DATE_RECEIVED', 'N', 61, 'N', 
    'DATE', 7, 0, 'Date Received', NULL, 
    'N', NULL, NULL, NULL, 'WOR_DATE_RECEIVED', 
    'WOR_DATE_RECEIVED', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_RECEIVED_BY', 'N', 62, 'N', 
    'NUMBER', 9, 0, 'Received By', NULL, 
    'N', NULL, NULL, NULL, 'WOR_RECEIVED_BY', 
    'WOR_RECEIVED_BY', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hus_initials ,hus_name ,hus_user_id 
from hig_users', 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_RECHARGEABLE', 'N', 63, 'N', 
    'VARCHAR2', 1, 0, 'Rechargeable', NULL, 
    'N', NULL, NULL, NULL, 'WOR_RECHARGEABLE', 
    'WOR_RECHARGEABLE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_SUPP_DOCUMENTS', 'N', 64, 'N', 
    'VARCHAR2', 80, 0, 'Supporting Documentation', NULL, 
    'N', NULL, NULL, NULL, 'WOR_SUPP_DOCUMENTS', 
    'WOR_SUPP_DOCUMENTS', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    80, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_EARLIEST_START_DATE', 'N', 65, 'N', 
    'DATE', 7, 0, 'Earliest Start', NULL, 
    'N', NULL, NULL, NULL, 'WOR_EARLIEST_START_DATE', 
    'WOR_EARLIEST_START_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_PLANNED_COMP_DATE', 'N', 66, 'N', 
    'DATE', 7, 0, 'Planned Completion', NULL, 
    'N', NULL, NULL, NULL, 'WOR_PLANNED_COMP_DATE', 
    'WOR_PLANNED_COMP_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_LATEST_COMP_DATE', 'N', 67, 'N', 
    'DATE', 7, 0, 'Latest Completion', NULL, 
    'N', NULL, NULL, NULL, 'WOR_LATEST_COMP_DATE', 
    'WOR_LATEST_COMP_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_SITE_COMPLETE_DATE', 'N', 68, 'N', 
    'DATE', 7, 0, 'Actual Completion', NULL, 
    'N', NULL, NULL, NULL, 'WOR_SITE_COMPLETE_DATE', 
    'WOR_SITE_COMPLETE_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_EST_DURATION', 'N', 69, 'N', 
    'NUMBER', 5, 0, 'Planned Duration', NULL, 
    'N', NULL, NULL, NULL, 'WOR_EST_DURATION', 
    'WOR_EST_DURATION', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    5, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_ACT_DURATION', 'N', 70, 'N', 
    'NUMBER', 5, 0, 'Actual Duration', NULL, 
    'N', NULL, NULL, NULL, 'WOR_ACT_DURATION', 
    'WOR_ACT_DURATION', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    5, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CERT_COMPLETE', 'N', 71, 'N', 
    'VARCHAR2', 40, 0, 'Cert Complete (Client)', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CERT_COMPLETE', 
    'WOR_CERT_COMPLETE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CON_CERT_COMPLETE', 'N', 72, 'N', 
    'VARCHAR2', 40, 0, 'Cert Complete (Contractor)', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CON_CERT_COMPLETE', 
    'WOR_CON_CERT_COMPLETE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_AGREED_BY', 'N', 73, 'N', 
    'VARCHAR2', 40, 0, 'Agreed By Date (Client)', NULL, 
    'N', NULL, NULL, NULL, 'WOR_AGREED_BY', 
    'WOR_AGREED_BY', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_AGREED_BY_DATE', 'N', 74, 'N', 
    'DATE', 7, 0, 'Agreed By (Client)', NULL, 
    'N', NULL, NULL, NULL, 'WOR_AGREED_BY_DATE', 
    'WOR_AGREED_BY_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CON_AGREED_BY', 'N', 75, 'N', 
    'VARCHAR2', 40, 0, 'Agreed By (Contractor)', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CON_AGREED_BY', 
    'WOR_CON_AGREED_BY', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_CON_AGREED_BY_DATE', 'N', 76, 'N', 
    'DATE', 7, 0, 'Agreed By Date (Contractor)', NULL, 
    'N', NULL, NULL, NULL, 'WOR_CON_AGREED_BY_DATE', 
    'WOR_CON_AGREED_BY_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_LATE_COSTS', 'N', 77, 'N', 
    'NUMBER', 12, 2, 'Late Costs', NULL, 
    'N', NULL, NULL, NULL, 'WOR_LATE_COSTS', 
    'WOR_LATE_COSTS', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    12, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_LATE_COST_CERTIFIED_BY', 'N', 78, 'N', 
    'VARCHAR2', 40, 0, 'Late Cost Certified', NULL, 
    'N', NULL, NULL, NULL, 'WOR_LATE_COST_CERTIFIED_BY', 
    'WOR_LATE_COST_CERTIFIED_BY', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_LATE_COST_CERTIFIED_DATE', 'N', 79, 'N', 
    'DATE', 7, 0, 'Late Cost Certified Date', NULL, 
    'N', NULL, NULL, NULL, 'WOR_LATE_COST_CERTIFIED_DATE', 
    'WOR_LATE_COST_CERTIFIED_DATE', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_LOCATION_PLAN', 'N', 80, 'N', 
    'VARCHAR2', 1, 0, 'Location Plan?', NULL, 
    'N', NULL, NULL, NULL, 'WOR_LOCATION_PLAN', 
    'WOR_LOCATION_PLAN', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_UTILITY_PLANS', 'N', 81, 'N', 
    'VARCHAR2', 1, 0, 'Utility Plans?', NULL, 
    'N', NULL, NULL, NULL, 'WOR_UTILITY_PLANS', 
    'WOR_UTILITY_PLANS', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_WORK_RESTRICTIONS', 'N', 82, 'N', 
    'VARCHAR2', 80, 0, 'Work Restrictions', NULL, 
    'N', NULL, NULL, NULL, 'WOR_WORK_RESTRICTIONS', 
    'WOR_WORK_RESTRICTIONS', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    80, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_REGISTER_FLAG', 'N', 83, 'N', 
    'VARCHAR2', 1, 0, 'Register', NULL, 
    'N', NULL, NULL, NULL, 'WOR_REGISTER_FLAG', 
    'WOR_REGISTER_FLAG', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOR$', 'WOR_REGISTER_STATUS', 'N', 84, 'N', 
    'VARCHAR2', 1, 0, 'Register Status', NULL, 
    'N', NULL, NULL, NULL, 'WOR_REGISTER_STATUS', 
    'WOR_REGISTER_STATUS', TO_DATE('03/03/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/03/2010 16:29:22', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hco_code,hco_meaning,hco_code from HIG_CODES
Where hco_domain = ''WOR_REGISTER_STATUS''
order by hco_meaning', 'Y', 
    1, 'N', 'MIXED');


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Create Attribute for Audit Asset WOL$
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108985
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Creating attributes for Work Order Lines Asset for Audit
-- 
------------------------------------------------------------------
Delete  From nm_inv_type_attribs_all Where ita_inv_type = 'WOL$' ;

Prompt Inserting into nm_inv_type_attribs_all
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_ID', 'N', 1, 'N', 
    'NUMBER', 9, 0, 'WOL ID', NULL, 
    'N', NULL, NULL, NULL, 'WOL_ID', 
    'WOL_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_WORKS_ORDER_NO', 'N', 2, 'N', 
    'VARCHAR2', 16, 0, 'Work Order Number', NULL, 
    'N', NULL, NULL, NULL, 'WOL_WORKS_ORDER_NO', 
    'WOL_WORKS_ORDER_NO', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    16, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_RSE_HE_ID', 'N', 3, 'N', 
    'NUMBER', 9, 0, 'Road ID', NULL, 
    'N', NULL, NULL, NULL, 'WOL_RSE_HE_ID', 
    'WOL_RSE_HE_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'SELECT NE_UNIQUE ,NE_DESCR ,NE_ID  
FROM NM_ELEMENTS WHERE NE_nt_TYPE IN  (SELECT NT_TYPE FROM NM_TYPES WHERE NT_DATUM = ''Y'')', 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_SISS_ID', 'N', 4, 'N', 
    'VARCHAR2', 3, 0, 'SISS', NULL, 
    'N', NULL, NULL, NULL, 'WOL_SISS_ID', 
    'WOL_SISS_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    3, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_ICB_WORK_CODE', 'N', 5, 'N', 
    'VARCHAR2', 10, 0, 'Work Category', NULL, 
    'N', NULL, NULL, NULL, 'WOL_ICB_WORK_CODE', 
    'WOL_ICB_WORK_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_DEF_DEFECT_ID', 'N', 6, 'N', 
    'NUMBER', 8, 0, 'Defect ID', NULL, 
    'N', NULL, NULL, NULL, 'WOL_DEF_DEFECT_ID', 
    'WOL_DEF_DEFECT_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_REP_ACTION_CAT', 'N', 7, 'N', 
    'VARCHAR2', 1, 0, 'Repair Category', NULL, 
    'N', NULL, NULL, NULL, 'WOL_REP_ACTION_CAT', 
    'WOL_REP_ACTION_CAT', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_SCHD_ID', 'N', 8, 'N', 
    'NUMBER', 9, 0, 'Schedule', NULL, 
    'N', NULL, NULL, NULL, 'WOL_SCHD_ID', 
    'WOL_SCHD_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_ACT_AREA_CODE', 'N', 10, 'N', 
    'VARCHAR2', 2, 0, 'Activity Area Code', NULL, 
    'N', NULL, NULL, NULL, 'WOL_ACT_AREA_CODE', 
    'WOL_ACT_AREA_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_ACT_COST', 'N', 11, 'N', 
    'NUMBER', 10, 2, 'Actual Cost', NULL, 
    'N', NULL, NULL, NULL, 'WOL_ACT_COST', 
    'WOL_ACT_COST', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_CHECK_CODE', 'N', 16, 'N', 
    'VARCHAR2', 4, 0, 'QI Check Code', NULL, 
    'N', NULL, NULL, NULL, 'WOL_CHECK_CODE', 
    'WOL_CHECK_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    4, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_CHECK_COMMENTS', 'N', 17, 'N', 
    'VARCHAR2', 254, 0, 'QI Check Comments', NULL, 
    'N', NULL, NULL, NULL, 'WOL_CHECK_COMMENTS', 
    'WOL_CHECK_COMMENTS', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    254, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_CHECK_DATE', 'N', 18, 'N', 
    'DATE', 7, 0, 'QI Check date', NULL, 
    'N', NULL, NULL, NULL, 'WOL_CHECK_DATE', 
    'WOL_CHECK_DATE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_CHECK_ID', 'N', 19, 'N', 
    'NUMBER', 9, 0, 'QI Check Batch', NULL, 
    'N', NULL, NULL, NULL, 'WOL_CHECK_ID', 
    'WOL_CHECK_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_CHECK_PEO_ID', 'N', 20, 'N', 
    'NUMBER', 8, 0, 'QI Check By', NULL, 
    'N', NULL, NULL, NULL, 'WOL_CHECK_PEO_ID', 
    'WOL_CHECK_PEO_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hus_initials ,hus_name ,hus_user_id 
from hig_users', 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_CHECK_RESULT', 'N', 21, 'N', 
    'VARCHAR2', 1, 0, 'QI Check result', NULL, 
    'N', NULL, NULL, NULL, 'WOL_CHECK_RESULT', 
    'WOL_CHECK_RESULT', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_DATE_COMPLETE', 'N', 22, 'N', 
    'DATE', 7, 0, 'Date Completed', NULL, 
    'N', NULL, NULL, NULL, 'WOL_DATE_COMPLETE', 
    'WOL_DATE_COMPLETE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_DATE_CREATED', 'N', 23, 'N', 
    'DATE', 7, 0, 'Date Created', NULL, 
    'N', NULL, NULL, NULL, 'WOL_DATE_CREATED', 
    'WOL_DATE_CREATED', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_DATE_PAID', 'N', 24, 'N', 
    'DATE', 7, 0, 'Date Paid', NULL, 
    'N', NULL, NULL, NULL, 'WOL_DATE_PAID', 
    'WOL_DATE_PAID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_DESCR', 'N', 25, 'N', 
    'VARCHAR2', 40, 0, 'Remarks', NULL, 
    'N', NULL, NULL, NULL, 'WOL_DESCR', 
    'WOL_DESCR', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_EST_COST', 'N', 27, 'N', 
    'NUMBER', 10, 2, 'Estimate Cost', NULL, 
    'N', NULL, NULL, NULL, 'WOL_EST_COST', 
    'WOL_EST_COST', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_EST_LABOUR', 'N', 28, 'N', 
    'NUMBER', 10, 2, 'Labour Units', NULL, 
    'N', NULL, NULL, NULL, 'WOL_EST_LABOUR', 
    'WOL_EST_LABOUR', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_STATUS_CODE', 'N', 37, 'N', 
    'VARCHAR2', 10, 0, 'Status', NULL, 
    'N', NULL, NULL, NULL, 'WOL_STATUS_CODE', 
    'WOL_STATUS_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hsc_status_code,hsc_status_name,hsc_status_code FROM HIG_status_CODES
WHERE hsc_domain_code = ''WORK_ORDER_LINES'' 
order by hsc_status_name', 'Y', 
    10, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_DATE_REPAIRED', 'N', 43, 'N', 
    'DATE', 7, 0, 'Repaired Date', NULL, 
    'N', NULL, NULL, NULL, 'WOL_DATE_REPAIRED', 
    'WOL_DATE_REPAIRED', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_INVOICE_STATUS', 'N', 44, 'N', 
    'VARCHAR2', 1, 0, 'Invoice Status', NULL, 
    'N', NULL, NULL, NULL, 'WOL_INVOICE_STATUS', 
    'WOL_INVOICE_STATUS', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_BUD_ID', 'N', 45, 'N', 
    'NUMBER', 9, 0, 'Budget ID', NULL, 
    'N', NULL, NULL, NULL, 'WOL_BUD_ID', 
    'WOL_BUD_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select BUD_ICB_ITEM_CODE , bud_cost_code descr,bud_id 
from budgets', 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_GANG', 'N', 48, 'N', 
    'NUMBER', 22, 0, 'Gang', NULL, 
    'N', NULL, NULL, NULL, 'WOL_GANG', 
    'WOL_GANG', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hco_code,hco_meaning,hco_code from HIG_CODES
Where hco_domain = ''GANG''
order by hco_meaning', 'Y', 
    22, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_REGISTER_FLAG', 'N', 50, 'N', 
    'VARCHAR2', 1, 0, 'Registerable', NULL, 
    'N', NULL, NULL, NULL, 'WOL_REGISTER_FLAG', 
    'WOL_REGISTER_FLAG', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('WOL$', 'WOL_LOCN_DESCR', 'N', 51, 'N', 
    'VARCHAR2', 120, 0, 'Location description', NULL, 
    'N', NULL, NULL, NULL, 'WOL_LOCN_DESCR', 
    'WOL_LOCN_DESCR', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 11:39:47', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    120, 'N', 'MIXED');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Create Attribute for Audit Asset DEF$ script 1
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108985
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Creating attributes for Defects for Audit
-- 
------------------------------------------------------------------
Delete  From nm_inv_type_attribs_all Where ita_inv_type = 'DEF$' ;

Prompt Inserting into nm_inv_type_attribs_all
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_DEFECT_ID', 'N', 1, 'N', 
    'NUMBER', 8, 0, 'Defect Id', NULL, 
    'N', NULL, NULL, NULL, 'DEF_DEFECT_ID', 
    'DEF_DEFECT_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_RSE_HE_ID', 'N', 2, 'N', 
    'NUMBER', 9, 0, 'Road Name', NULL, 
    'N', NULL, NULL, NULL, 'DEF_RSE_HE_ID', 
    'DEF_RSE_HE_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'SELECT NE_UNIQUE ,NE_DESCR ,NE_ID  
FROM NM_ELEMENTS WHERE NE_nt_TYPE IN  (SELECT NT_TYPE FROM NM_TYPES WHERE NT_DATUM = ''Y'')', 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_IIT_ITEM_ID', 'N', 3, 'N', 
    'NUMBER', 9, 0, 'Asset Id', NULL, 
    'N', NULL, NULL, NULL, 'DEF_IIT_ITEM_ID', 
    'DEF_IIT_ITEM_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_ST_CHAIN', 'N', 4, 'N', 
    'NUMBER', 6, 0, 'Start Chain', NULL, 
    'N', NULL, NULL, NULL, 'DEF_ST_CHAIN', 
    'DEF_ST_CHAIN', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    6, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_ARE_REPORT_ID', 'N', 5, 'N', 
    'NUMBER', 8, 0, 'Inspection Id', NULL, 
    'N', NULL, NULL, NULL, 'DEF_ARE_REPORT_ID', 
    'DEF_ARE_REPORT_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_ATV_ACTY_AREA_CODE', 'N', 6, 'N', 
    'VARCHAR2', 2, 0, 'Activity Area Code', NULL, 
    'N', NULL, NULL, NULL, 'DEF_ATV_ACTY_AREA_CODE', 
    'DEF_ATV_ACTY_AREA_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select atv_acty_area_code, atv_descr,atv_acty_area_code from activities 
where atv_maint_insp_flag = ''D'' ', 'Y', 
    2, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_SISS_ID', 'N', 7, 'N', 
    'VARCHAR2', 3, 0, 'SISS', NULL, 
    'N', NULL, NULL, NULL, 'DEF_SISS_ID', 
    'DEF_SISS_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select siss_id,siss_name,siss_id from standard_item_sub_sections
order by  siss_name', 'Y', 
    3, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_WORKS_ORDER_NO', 'N', 8, 'N', 
    'VARCHAR2', 16, 0, 'Work Order Number', NULL, 
    'N', NULL, NULL, NULL, 'DEF_WORKS_ORDER_NO', 
    'DEF_WORKS_ORDER_NO', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    16, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_CREATED_DATE', 'N', 9, 'N', 
    'DATE', 7, 0, 'Date Created', NULL, 
    'N', NULL, NULL, NULL, 'DEF_CREATED_DATE', 
    'DEF_CREATED_DATE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_DEFECT_CODE', 'N', 10, 'N', 
    'VARCHAR2', 4, 0, 'Defect Code', NULL, 
    'N', NULL, NULL, NULL, 'DEF_DEFECT_CODE', 
    'DEF_DEFECT_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select distinct dty_defect_code,dty_descr1,dty_defect_code from def_types order by 1', 'Y', 
    4, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_LAST_UPDATED_DATE', 'N', 11, 'N', 
    'DATE', 7, 0, 'Last Updated Date', NULL, 
    'N', NULL, NULL, NULL, 'DEF_LAST_UPDATED_DATE', 
    'DEF_LAST_UPDATED_DATE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_ORIG_PRIORITY', 'N', 12, 'N', 
    'VARCHAR2', 4, 0, 'Original Priority', NULL, 
    'N', NULL, NULL, NULL, 'DEF_ORIG_PRIORITY', 
    'DEF_ORIG_PRIORITY', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hco_code,hco_meaning,hco_code from HIG_CODES
Where hco_domain = ''DEFECT_PRIORITIES''
order by hco_meaning', 'Y', 
    4, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_PRIORITY', 'N', 13, 'N', 
    'VARCHAR2', 4, 0, 'Priority', NULL, 
    'N', NULL, NULL, NULL, 'DEF_PRIORITY', 
    'DEF_PRIORITY', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select hco_code,hco_meaning,hco_code from HIG_CODES
Where hco_domain = ''DEFECT_PRIORITIES''
order by hco_meaning', 'Y', 
    4, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_STATUS_CODE', 'N', 14, 'N', 
    'VARCHAR2', 10, 0, 'Status Code', NULL, 
    'N', NULL, NULL, NULL, 'DEF_STATUS_CODE', 
    'DEF_STATUS_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_SUPERSEDED_FLAG', 'N', 15, 'N', 
    'VARCHAR2', 1, 0, 'Superseded Flag', NULL, 
    'N', NULL, NULL, NULL, 'DEF_SUPERSEDED_FLAG', 
    'DEF_SUPERSEDED_FLAG', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_AREA', 'N', 16, 'N', 
    'NUMBER', 8, 1, 'Defect Area', NULL, 
    'N', NULL, NULL, NULL, 'DEF_AREA', 
    'DEF_AREA', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_COORD_FLAG', 'N', 18, 'N', 
    'VARCHAR2', 1, 0, 'Coord Flag', NULL, 
    'N', NULL, NULL, NULL, 'DEF_COORD_FLAG', 
    'DEF_COORD_FLAG', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_DATE_COMPL', 'N', 19, 'N', 
    'DATE', 7, 0, 'Date Completed', NULL, 
    'N', NULL, NULL, NULL, 'DEF_DATE_COMPL', 
    'DEF_DATE_COMPL', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_DATE_NOT_FOUND', 'N', 20, 'N', 
    'DATE', 7, 0, 'Not Refound Date', NULL, 
    'N', NULL, NULL, NULL, 'DEF_DATE_NOT_FOUND', 
    'DEF_DATE_NOT_FOUND', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_DEFECT_DESCR', 'N', 22, 'N', 
    'VARCHAR2', 240, 0, 'Defect Description', NULL, 
    'N', NULL, NULL, NULL, 'DEF_DEFECT_DESCR', 
    'DEF_DEFECT_DESCR', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    240, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_DEFECT_TYPE_DESCR', 'N', 23, 'N', 
    'VARCHAR2', 40, 0, 'Defect Type Description', NULL, 
    'N', NULL, NULL, NULL, 'DEF_DEFECT_TYPE_DESCR', 
    'DEF_DEFECT_TYPE_DESCR', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_DIAGRAM_NO', 'N', 24, 'N', 
    'VARCHAR2', 7, 0, 'Diagram Number', NULL, 
    'N', NULL, NULL, NULL, 'DEF_DIAGRAM_NO', 
    'DEF_DIAGRAM_NO', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    7, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_HEIGHT', 'N', 25, 'N', 
    'NUMBER', 6, 1, 'Height', NULL, 
    'N', NULL, NULL, NULL, 'DEF_HEIGHT', 
    'DEF_HEIGHT', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    6, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_IDENT_CODE', 'N', 26, 'N', 
    'VARCHAR2', 8, 0, 'Ident Code', NULL, 
    'N', NULL, NULL, NULL, 'DEF_IDENT_CODE', 
    'DEF_IDENT_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_ITY_INV_CODE', 'N', 27, 'N', 
    'VARCHAR2', 2, 0, 'Inventory Code', NULL, 
    'N', NULL, NULL, NULL, 'DEF_ITY_INV_CODE', 
    'DEF_ITY_INV_CODE', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select ity_inv_code, ity_descr, ity_sys_flag from inv_item_types
order by ity_inv_code', 'Y', 
    2, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_LENGTH', 'N', 29, 'N', 
    'NUMBER', 6, 1, 'Length', NULL, 
    'N', NULL, NULL, NULL, 'DEF_LENGTH', 
    'DEF_LENGTH', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    6, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_LOCN_DESCR', 'N', 30, 'N', 
    'VARCHAR2', 40, 0, 'Location', NULL, 
    'N', NULL, NULL, NULL, 'DEF_LOCN_DESCR', 
    'DEF_LOCN_DESCR', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    40, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_MAND_ADV', 'N', 32, 'N', 
    'VARCHAR2', 1, 0, 'Roadstud Type', NULL, 
    'N', NULL, NULL, NULL, 'DEF_MAND_ADV', 
    'DEF_MAND_ADV', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_NOTIFY_ORG_ID', 'N', 33, 'N', 
    'NUMBER', 8, 0, 'Notifyable Org', NULL, 
    'N', NULL, NULL, NULL, 'DEF_NOTIFY_ORG_ID', 
    'DEF_NOTIFY_ORG_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select oun_org_id ,oun_name ,oun_org_id  from org_units', 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_NUMBER', 'N', 34, 'N', 
    'NUMBER', 5, 1, 'Number', NULL, 
    'N', NULL, NULL, NULL, 'DEF_NUMBER', 
    'DEF_NUMBER', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    5, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_PER_CENT', 'N', 35, 'N', 
    'NUMBER', 5, 1, 'Percent', NULL, 
    'N', NULL, NULL, NULL, 'DEF_PER_CENT', 
    'DEF_PER_CENT', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    5, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_RECHAR_ORG_ID', 'N', 38, 'N', 
    'NUMBER', 8, 0, 'Rechargeable Organisation', NULL, 
    'N', NULL, NULL, NULL, 'DEF_RECHAR_ORG_ID', 
    'DEF_RECHAR_ORG_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', 'select oun_org_id ,oun_name ,oun_org_id  from org_units', 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_SERIAL_NO', 'N', 39, 'N', 
    'VARCHAR2', 6, 0, 'Serial Number', NULL, 
    'N', NULL, NULL, NULL, 'DEF_SERIAL_NO', 
    'DEF_SERIAL_NO', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    6, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_SKID_COEFF', 'N', 40, 'N', 
    'NUMBER', 4, 1, 'Volume', NULL, 
    'N', NULL, NULL, NULL, 'DEF_SKID_COEFF', 
    'DEF_SKID_COEFF', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    4, 'N', 'UPPER');

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Create Attribute for Audit Asset DEF$ script 2
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108985
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Creating attributes for Defects for Audit
-- 
------------------------------------------------------------------
Prompt Inserting into nm_inv_type_attribs_all
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_SPECIAL_INSTR', 'N', 41, 'N', 
    'VARCHAR2', 254, 0, 'Special Instructions', NULL, 
    'N', NULL, NULL, NULL, 'DEF_SPECIAL_INSTR', 
    'DEF_SPECIAL_INSTR', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    254, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_SUPERSEDED_ID', 'N', 42, 'N', 
    'NUMBER', 8, 0, 'Superseded By', NULL, 
    'N', NULL, NULL, NULL, 'DEF_SUPERSEDED_ID', 
    'DEF_SUPERSEDED_ID', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_TIME_HRS', 'N', 43, 'N', 
    'NUMBER', 2, 0, 'Defect Hours', NULL, 
    'N', NULL, NULL, NULL, 'DEF_TIME_HRS', 
    'DEF_TIME_HRS', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_TIME_MINS', 'N', 44, 'N', 
    'NUMBER', 2, 0, 'Defect Minutes', NULL, 
    'N', NULL, NULL, NULL, 'DEF_TIME_MINS', 
    'DEF_TIME_MINS', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    2, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_UPDATE_INV', 'N', 45, 'N', 
    'VARCHAR2', 1, 0, 'Update Inv Flag', NULL, 
    'N', NULL, NULL, NULL, 'DEF_UPDATE_INV', 
    'DEF_UPDATE_INV', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_X_SECT', 'N', 46, 'N', 
    'VARCHAR2', 1, 0, 'XSP', NULL, 
    'N', NULL, NULL, NULL, 'DEF_X_SECT', 
    'DEF_X_SECT', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    1, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_EASTING', 'N', 47, 'N', 
    'NUMBER', 22, 0, 'Easting', NULL, 
    'N', NULL, NULL, NULL, 'DEF_EASTING', 
    'DEF_EASTING', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    22, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('DEF$', 'DEF_NORTHING', 'N', 48, 'N', 
    'NUMBER', 22, 0, 'Northing', NULL, 
    'N', NULL, NULL, NULL, 'DEF_NORTHING', 
    'DEF_NORTHING', TO_DATE('03/04/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/04/2010 14:53:52', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    22, 'N', 'UPPER');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Create Attribute for Audit Asset BOQ$
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108985
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Creating attributes for BOW_items for Audit
-- 
------------------------------------------------------------------
Delete  From nm_inv_type_attribs_all Where ita_inv_type = 'BOQ$' ;

Prompt Inserting into nm_inv_type_attribs_all
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_DEFECT_ID', 'N', 2, 'N', 
    'NUMBER', 8, 0, 'Defect Id', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_DEFECT_ID', 
    'BOQ_DEFECT_ID', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_WOL_ID', 'N', 4, 'N', 
    'NUMBER', 9, 0, 'WOL Id', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_WOL_ID', 
    'BOQ_WOL_ID', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    9, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_STA_ITEM_CODE', 'N', 5, 'N', 
    'VARCHAR2', 10, 0, 'Item Code', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_STA_ITEM_CODE', 
    'BOQ_STA_ITEM_CODE', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ITEM_NAME', 'N', 6, 'N', 
    'VARCHAR2', 254, 0, 'Item Name', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ITEM_NAME', 
    'BOQ_ITEM_NAME', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    254, 'N', 'MIXED');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_DIM1', 'N', 9, 'N', 
    'NUMBER', 10, 2, 'Estimated Dim 1', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_DIM1', 
    'BOQ_EST_DIM1', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_DIM2', 'N', 10, 'N', 
    'NUMBER', 10, 2, 'Estimated Dim 2', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_DIM2', 
    'BOQ_EST_DIM2', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_DIM3', 'N', 11, 'N', 
    'NUMBER', 10, 2, 'Estimated Dim 3', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_DIM3', 
    'BOQ_EST_DIM3', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_QUANTITY', 'N', 12, 'N', 
    'NUMBER', 10, 2, 'Estimated Quantity', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_QUANTITY', 
    'BOQ_EST_QUANTITY', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_RATE', 'N', 13, 'N', 
    'NUMBER', 10, 2, 'Estimated Rate', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_RATE', 
    'BOQ_EST_RATE', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_DISCOUNT', 'N', 14, 'N', 
    'NUMBER', 6, 3, 'Estimated Discount', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_DISCOUNT', 
    'BOQ_EST_DISCOUNT', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    6, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_COST', 'N', 15, 'N', 
    'NUMBER', 10, 2, 'Estimated Cost', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_COST', 
    'BOQ_EST_COST', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_EST_LABOUR', 'N', 16, 'N', 
    'NUMBER', 8, 2, 'Estimated Labour Units', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_EST_LABOUR', 
    'BOQ_EST_LABOUR', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_DIM1', 'N', 17, 'N', 
    'NUMBER', 10, 2, 'Actual Dim 1', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_DIM1', 
    'BOQ_ACT_DIM1', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_DIM2', 'N', 18, 'N', 
    'NUMBER', 10, 2, 'Actual Dim 2', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_DIM2', 
    'BOQ_ACT_DIM2', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_DIM3', 'N', 19, 'N', 
    'NUMBER', 10, 2, 'Actual Dim 3', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_DIM3', 
    'BOQ_ACT_DIM3', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_QUANTITY', 'N', 20, 'N', 
    'NUMBER', 10, 2, 'Actual Quantity', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_QUANTITY', 
    'BOQ_ACT_QUANTITY', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_COST', 'N', 21, 'N', 
    'NUMBER', 10, 2, 'Actual Cost', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_COST', 
    'BOQ_ACT_COST', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_LABOUR', 'N', 22, 'N', 
    'NUMBER', 8, 2, 'Actual Labour Units', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_LABOUR', 
    'BOQ_ACT_LABOUR', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    8, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_RATE', 'N', 23, 'N', 
    'NUMBER', 10, 2, 'Actual Rate', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_RATE', 
    'BOQ_ACT_RATE', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    10, 'N', 'UPPER');
Insert into nm_inv_type_attribs_all
   (ITA_INV_TYPE, ITA_ATTRIB_NAME, ITA_DYNAMIC_ATTRIB, ITA_DISP_SEQ_NO, ITA_MANDATORY_YN, 
    ITA_FORMAT, ITA_FLD_LENGTH, ITA_DEC_PLACES, ITA_SCRN_TEXT, ITA_ID_DOMAIN, 
    ITA_VALIDATE_YN, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
    ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, 
    ITA_UNITS, ITA_FORMAT_MASK, ITA_EXCLUSIVE, ITA_KEEP_HISTORY_YN, ITA_DATE_CREATED, 
    ITA_DATE_MODIFIED, ITA_MODIFIED_BY, ITA_CREATED_BY, ITA_QUERY, ITA_DISPLAYED, 
    ITA_DISP_WIDTH, ITA_INSPECTABLE, ITA_CASE)
 Values
   ('BOQ$', 'BOQ_ACT_DISCOUNT', 'N', 24, 'N', 
    'NUMBER', 6, 3, 'Actual Discount', NULL, 
    'N', NULL, NULL, NULL, 'BOQ_ACT_DISCOUNT', 
    'BOQ_ACT_DISCOUNT', TO_DATE('03/19/2010 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), NULL, 'Y', NULL, 
    NULL, NULL, 'N', 'N', TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 
    TO_DATE('03/19/2010 10:23:32', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', 'DORSET', NULL, 'Y', 
    6, 'N', 'UPPER');


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Recipients Rule Setup for Alert Manager
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108986
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Recipients Rule Setup for Alert Manager
-- 
------------------------------------------------------------------
Delete from HIG_ALERT_RECIPIENT_RULES Where HARR_NIT_INV_TYPE = 'WOR$';

Prompt Inserting into HIG_ALERT_RECIPIENT_RULES
Insert into HIG_ALERT_RECIPIENT_RULES
   (HARR_ID, HARR_NIT_INV_TYPE, HARR_ATTRIBUTE_NAME, HARR_LABEL, HARR_RECIPIENT_TYPE, 
    HARR_SQL, HARR_DATE_CREATED, HARR_CREATED_BY, HARR_DATE_MODIFIED, HARR_MODIFIED_BY)
 Values
   (-1, 'WOR$', 'WOR_CLOSED_BY_ID', NULL, 'USER_ID', 
    NULL, TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET');
Insert into HIG_ALERT_RECIPIENT_RULES
   (HARR_ID, HARR_NIT_INV_TYPE, HARR_ATTRIBUTE_NAME, HARR_LABEL, HARR_RECIPIENT_TYPE, 
    HARR_SQL, HARR_DATE_CREATED, HARR_CREATED_BY, HARR_DATE_MODIFIED, HARR_MODIFIED_BY)
 Values
   (-2, 'WOR$', 'WOR_MOD_BY_ID', NULL, 'USER_ID', 
    NULL, TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET');
Insert into HIG_ALERT_RECIPIENT_RULES
   (HARR_ID, HARR_NIT_INV_TYPE, HARR_ATTRIBUTE_NAME, HARR_LABEL, HARR_RECIPIENT_TYPE, 
    HARR_SQL, HARR_DATE_CREATED, HARR_CREATED_BY, HARR_DATE_MODIFIED, HARR_MODIFIED_BY)
 Values
   (-3, 'WOR$', 'WOR_PEO_PERSON_ID', NULL, 'USER_ID', 
    NULL, TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET');
Insert into HIG_ALERT_RECIPIENT_RULES
   (HARR_ID, HARR_NIT_INV_TYPE, HARR_ATTRIBUTE_NAME, HARR_LABEL, HARR_RECIPIENT_TYPE, 
    HARR_SQL, HARR_DATE_CREATED, HARR_CREATED_BY, HARR_DATE_MODIFIED, HARR_MODIFIED_BY)
 Values
   (-4, 'WOR$', 'WOR_RECEIVED_BY', NULL, 'USER_ID', 
    NULL, TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET', TO_DATE('03/01/2010 11:43:15', 'MM/DD/YYYY HH24:MI:SS'), 'DORSET');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Maintenance Inspection Loader Metadata
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Maintenance Inspection Loader Metadats set-up
-- 
------------------------------------------------------------------
--
----------------------------------------------------------------------------------------
-- NM Errors
----------------------------------------------------------------------------------------
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9000
       ,null
       ,'ERROR: error in outputing previous error condition.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9000);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9001
       ,null
       ,'ERROR: error in opening file for error output.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9001);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9002
       ,null
       ,'ERROR: error in opening file for load input.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9002);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9003
       ,null
       ,'ERROR: X record encountered before end of file.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9003);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9004
       ,null
       ,'ERROR: non x record encountered at end of file.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9004);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9005
       ,null
       ,'ERROR: load terminated before end of load file.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9005);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9006
       ,null
       ,'ERROR: error in closing input load file.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9006);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9007
       ,null
       ,'ERROR: error in closing error output file.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9007);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9008
       ,null
       ,'ERROR: unknown husky hunter record type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9008);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9009
       ,null
       ,'ERROR: file header record is not a known header type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9009);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9010
       ,null
       ,'ERROR: unexpected format in terminator record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9010);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9011
       ,null
       ,'ERROR: record counts do not match terminator record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9011);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9012
       ,null
       ,'ERROR: invalid number of arguments in first G rec.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9012);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9014
       ,null
       ,'ERROR: The number of H and P records must match the numebr of G records.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9014);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9104
       ,null
       ,'Error : Activity (H) Record expected but not found. : Correct the Activity Record Type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9104);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9105
       ,null
       ,'Error : Invalid Comment Type. : Correct the Comment Type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9105);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9106
       ,null
       ,'Error : Enclosed field is not terminated. The enclosing character is '
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9106);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9107
       ,null
       ,'Error : An error occured while processing record '
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9107);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9200
       ,null
       ,'Error : G record expected but not found. : Correct the record type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9200);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9201
       ,null
       ,'Error : Number of attributes in G record type is less than 7 : Correct the G record information.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9201);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9202
       ,null
       ,'Error : Initiation nmeonic is not recognised. : Correct the initiation nmeonic code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9202);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9203
       ,null
       ,'Error : Invalid inspection initiation date. : Correct the Inspection initiation date in the G record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9203);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9204
       ,null
       ,'Error : Invalid inspection initiation time. : Correct the Inspection time in the G record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9204);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9205
       ,null
       ,'Error : Invalid survey type indicator. : Correct the survey type indicator in the G record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9205);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9206
       ,null
       ,'Error : Invalid survey direction indicator. : Correct the survey indicator value in the G record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9206);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9207
       ,null
       ,'Error : Invalid Linkcode / Section identifier. : Correct the Linkcode / Section identifier in the G record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9207);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9208
       ,null
       ,'Error : The Primary inspector cannot be located. : Correct the Primary inspectors initials in the G record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9208);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9212
       ,null
       ,'Error : Invalid Weather condition code. : Correct the weathher condition code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9212);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9213
       ,null
       ,'Error : Unable to obtain interval code. : Check the interval codes for valid code values.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9213);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9214
       ,null
       ,'Error : Unable to locate specified section. : Check the document management section reference.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9214);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9215
       ,null
       ,'Error : Unable to obtain document sequence number. : Check the document sequence for availability.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9215);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9216
       ,null
       ,'Error : Unable to obtain inspectors Admin unit. : Check the current inspectors Administration unit.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9216);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9217
       ,null
       ,'Error : Unable to insert into the DOCS table. : Check the complaint record for errors.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9217);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9218
       ,null
       ,'Error : Unable to insert into the DOC_ASSOCS table. : Check the complaint record and correct.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9218);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9219
       ,null
       ,'Error : Unable to obtain the status for a new defect. : Check the STATUS CODES values.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9219);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9220
       ,null
       ,'Error : H record expected but not found. : Correct the H record indicator.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9220);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9221
       ,null
       ,'Error : Invalid activity area code on H type record for this section. : Correct the defect location time hhmm'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9221);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9240
       ,null
       ,'Error : P record expected but not found. : Correct the P record indicator.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9240);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9260
       ,null
       ,'Error : Chainage on I record exceeds required chainage for section. : Correct the section chainage.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9260);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9261
       ,null
       ,'Error : Invalid defect Location time. : Correct the defect location time hhmm'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9261);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9262
       ,null
       ,'Error : Invalid chainage indicator. : Correct the chainage indicator value.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9262);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9263
       ,null
       ,'Error : Invalid sub-section item code. : Correct the sub-section item code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9263);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9264
       ,null
       ,'Error : Invalid notifiable organisation code. : Correct the notifiable organisation code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9264);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9265
       ,null
       ,'Error : Invalid rechargeable organisation code. : Correct the rechargeable organisation code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9265);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9266
       ,null
       ,'Error : Invalid Cross Sectional Position (XSP) : Correct the Cross Sectional Position.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9266);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9267
       ,null
       ,'Error : Special Instruction exceeds the allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9267);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9268
       ,null
       ,'Error : Location Description exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9268);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9269
       ,null
       ,'Error : Identity Code exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9269);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9270
       ,null
       ,'Error : Diagram Number exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9270);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9271
       ,null
       ,'Error : Invalid Asset Type : Correct the Asset Type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9271);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9272
       ,null
       ,'Error : Defect Description exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9272);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9273
       ,null
       ,'Error : Road Stud Indicator exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9273);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9274
       ,null
       ,'Error : Defect Type exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9274);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9275
       ,null
       ,'Error : Mandatory field, Defect Type, is Missing.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9275);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9276
       ,null
       ,'Error : Mandatory field, Priority, is Missing.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9276);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9277
       ,null
       ,'Error : Priority exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9277);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9278
       ,null
       ,'Error : Defect Response Category exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9278);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9279
       ,null
       ,'Error : Invalid Asset Id.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9279);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9280
       ,null
       ,'Error : Invalid Easting.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9280);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9281
       ,null
       ,'Error : Invalid Northing.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9281);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9282
       ,null
       ,'Error : Attribute Value exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9282);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9283
       ,null
       ,'Error : Repair Description exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9283);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9284
       ,null
       ,'Error : Invalid BOQ Dimension.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9284);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9285
       ,null
       ,'Error : Asset Modification Flag exceeds allowed length.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9285);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9286
       ,null
       ,'Invalid Doc Type Code Supplied.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9286);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9287
       ,null
       ,'Invalid Doc Category Supplied.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9287);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9288
       ,null
       ,'File Name not provided.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9288);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9289
       ,null
       ,'Invalid Document Location Supplied..'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9289);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9300
       ,null
       ,'Error : Invalid Activity code/Defect Type combination. : Correct the Activity code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9300);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9302
       ,null
       ,'Error : Invalid Inspection date. : Correct the Inspection date.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9302);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9303
       ,null
       ,'Error : Invalid Survey type. : Correct the Survey Type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9303);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9305
       ,null
       ,'Error : Invalid Defect/Priority combination. : Correct the Defect/Priority and re-submit.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9305);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9309
       ,null
       ,'Error : Invalid reverse survey direction indicator. : Correct the Reverse Survey Direction indicator value (Y/N).'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9309);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9400
       ,null
       ,'Error : Invalid Treatment Code. : Correct the treatment code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9400);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9401
       ,null
       ,'Error : Start chainage exceeds end chainage. : Correct the chainage values.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9401);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9402
       ,null
       ,'Error : Incorrect start chainage value ( chainage is null ) : Correct the start chainage value.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9402);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9500
       ,null
       ,'Error : Inspection Date less than previously loaded inspection.   : Correct the inspection date.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9500);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9501
       ,null
       ,'Error : Invalid Defect Location (I) Record Type. : Correct the Defect Location Record Type indicator.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9501);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9502
       ,null
       ,'Error : Invalid Defect (J) record Type. : Correct the Defect Location Record Type indicator.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9502);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9503
       ,null
       ,'Error : Action record (K/L/M/N) expected but not found. : Correct the action type record for this section.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9503);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9516
       ,null
       ,'Error : Unable to locate INTERVAL record. : Ensure there is an INTERVAL record present.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9516);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9517
       ,null
       ,'Error : An immediate (COMPLETED) repair may NOT have BOQ items. : All BOQ items associated with the immediate repair must be deleted.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9517);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9520
       ,null
       ,'G record must follow the 1 record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9520);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9521
       ,null
       ,'H record must follow a G record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9521);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9522
       ,null
       ,'I, P or R record must follow a H record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9522);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9523
       ,null
       ,'J record must follow an I record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9523);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9524
       ,null
       ,'D, K, L, M or N record must follow a J record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9524);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9525
       ,null
       ,'D, K, L, M or N record must follow a D record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9525);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9526
       ,null
       ,'L, M, N, P or R record must follow a K record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9526);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9527
       ,null
       ,'M, N, P, Q or R record must follow a L Record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9527);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9528
       ,null
       ,'I, P, Q or R record must follow a M record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9528);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9529
       ,null
       ,'I, P, Q or R record must follow a N record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9529);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9530
       ,null
       ,'G, S or X record must follow a P record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9530);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9531
       ,null
       ,'I, M, N, P, Q or R record must follow a Q record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9531);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9532
       ,null
       ,'R or P record must follow a R record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9532);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9533
       ,null
       ,'S or X record must follow a S Record'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9533);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9534
       ,null
       ,'X record should be the last record in the file'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9534);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9540
       ,null
       ,'Batch Re-Submit Successful'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9540);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9541
       ,null
       ,'Batch Re-Submit Failed'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9541);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9542
       ,null
       ,'Batch contains Invalid Inspections'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9542);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9543
       ,null
       ,'Inspection Re-Submit Successfully'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9543);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9544
       ,null
       ,'Process Completed'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9544);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9545
       ,null
       ,'Inspection Re-Submit Successful'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9545);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9546
       ,null
       ,'Inspection Re-Submit Failed'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9546);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9600
       ,null
       ,'Error : Recalibration for section inspection not started at chainage 0  : Correct the Start Chainge.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9600);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9601
       ,null
       ,'Error : Recalibration for section execeeds 50% of section length . : Correct the Section Length or Chainage value.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9601);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9602
       ,null
       ,'Error : Error cannot find P record to carry out recalibration. : Correct the P record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9602);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9603
       ,null
       ,'Error : Defect XSP required but not supplied. : Correct the defect location record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9603);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9604
       ,null
       ,'Error : No Default Treatment for this Defect / Activity area. : Correct the Default Treatment type.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9604);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9605
       ,null
       ,'Error : Defect chainage value required but not supplied. : Correct the defect location record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9605);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9704
       ,null
       ,'Invalid Combination of Complaint Category / Complaint Type : The Complaint Category used is derived from the User Option ENQCAT. TheComplaint Type is supplied in the DCD load file. Check Document Type'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9704);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9705
       ,null
       ,'Invalid defect Response Category. Use the DOMAINS form. : Using the DOMAINS form check that the category displayed within thespecified record exists for the DEFECT_RESPONSE_CAT domain.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9705);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9706
       ,null
       ,'Could not derive Default Complaint Status : Check a valid Complaint Status has been set in Status Codes module (HIG9110).The Default Complaint Status should have Feature Code 1 set to Y.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9706);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9800
       ,null
       ,'Begining load for file'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9800);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9801
       ,null
       ,'The load Batch Id is'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9801);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9802
       ,null
       ,'Number Of Inspections found in the file'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9802);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9803
       ,null
       ,'Inspection loaded'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9803);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9804
       ,null
       ,'Load complete for file'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9804);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9805
       ,null
       ,'Running Inspection Loader Version'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9805);
--
----------------------------------------------------------------------------------------
-- HIG_MODULES
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI4400'
       ,'Maintenance Inspection Loader'
       ,'hig2510'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI4400');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI4405'
       ,'Maintenance Inspection Error Correction'
       ,'mai4405'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI4405');

--
----------------------------------------------------------------------------------------
-- HIG_STANDARD_FAVOURITES
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI4400'
       ,'Maintenance Inspection Loader'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI4400');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI4405'
       ,'Maintenance Inspection Error Correction'
       ,'M'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI4405');
--
----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPES
--
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_PROCESS_TYPES
       (HPT_PROCESS_TYPE_ID
       ,HPT_NAME
       ,HPT_DESCR
       ,HPT_WHAT_TO_CALL
       ,HPT_INITIATION_MODULE
       ,HPT_INTERNAL_MODULE
       ,HPT_INTERNAL_MODULE_PARAM
       ,HPT_PROCESS_LIMIT
       ,HPT_RESTARTABLE
       ,HPT_SEE_IN_HIG2510
       )
SELECT 
        -1001
       ,'Maintenance Inspection Loader'
       ,'Loads maintenance inspections from RMMS or EID format files'
       ,'mai_inspection_loader.load_rmms_or_eid_file;'
       ,'MAI4400'
       ,'MAI4405'
       ,'PROCESS_ID'
       ,null
       ,'N'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPES
                   WHERE HPT_PROCESS_TYPE_ID = -1001);
--
----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_ROLES
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_PROCESS_TYPE_ROLES
       (HPTR_PROCESS_TYPE_ID
       ,HPTR_ROLE
       )
SELECT 
        -1001
       ,'MAI_ADMIN' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_ROLES
                   WHERE HPTR_PROCESS_TYPE_ID = -1001
                    AND  HPTR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_PROCESS_TYPE_ROLES
       (HPTR_PROCESS_TYPE_ID
       ,HPTR_ROLE
       )
SELECT 
        -1001
       ,'MAI_USER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_ROLES
                   WHERE HPTR_PROCESS_TYPE_ID = -1001
                    AND  HPTR_ROLE = 'MAI_USER');
--
----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_FREQUENCIES
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1001
       ,-1
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1001
                    AND  HPFR_FREQUENCY_ID = -1);
--
----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_FILES
----------------------------------------------------------------------------------------
--
INSERT
  INTO hig_process_type_files
      (hptf_file_type_id
      ,hptf_name
      ,hptf_process_type_id
      ,hptf_input
      ,hptf_output
      ,hptf_input_destination
      ,hptf_input_destination_type
      ,hptf_min_input_files
      ,hptf_max_input_files
      ,hptf_output_destination
      ,hptf_output_destination_type)
SELECT -1001
      ,'Inspection File'
      ,-1001
      ,'Y'
      ,'N'
      ,'MAI_INSP_DIRECTORY'
      ,'ORACLE_DIRECTORY'
      ,1
      ,1
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_process_type_files
                   WHERE hptf_file_type_id = -1001);

--
----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_FILE_EXT
----------------------------------------------------------------------------------------
--
INSERT
  INTO hig_process_type_file_ext
      (hpte_file_type_id
      ,hpte_extension)
 SELECT -1001
       ,'dat'
   FROM dual
  WHERE NOT EXISTS(SELECT 1
                     FROM hig_process_type_file_ext
                    WHERE hpte_file_type_id = -1001
                      AND hpte_extension = 'dat');
                      
--
----------------------------------------------------------------------------------------
-- HIG_MODULE_ROLES
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4400'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4400'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4400'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4400'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4405'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4405'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4405'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4405'
                    AND  HMR_ROLE = 'MAI_USER');
--
--
----------------------------------------------------------------------------------------
-- HIG_DIRECTORIES
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_DIRECTORIES
       (HDIR_NAME
       ,HDIR_PATH
       ,HDIR_URL
       ,HDIR_COMMENTS
       ,HDIR_PROTECTED
       )
SELECT 
        'MAI_INSP_DIRECTORY'
       ,'<to be specified>'
       ,''
       ,'Directory for MAI Inspection Files To Be Loaded.'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DIRECTORIES
                   WHERE HDIR_NAME = 'MAI_INSP_DIRECTORY');
--
----------------------------------------------------------------------------------------
-- HIG_DIRECTORY_ROLES
----------------------------------------------------------------------------------------
--
INSERT INTO HIG_DIRECTORY_ROLES
       (HDR_NAME
       ,HDR_ROLE
       ,HDR_MODE
       )
SELECT 
        'MAI_INSP_DIRECTORY'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DIRECTORY_ROLES
                   WHERE HDR_NAME = 'MAI_INSP_DIRECTORY'
                    AND  HDR_ROLE = 'MAI_USER');

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Module Composite Flexible Attributes
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109271
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- New Module Composite Flexible Attributes
-- 
------------------------------------------------------------------
Prompt Inserting into hig_modules
Insert into hig_modules SELECT 'MAI3819','Composite Flexible Attributes','mai3819.fmx','FMX',Null,'N','N','MAI','FORM' 
                           FROM dual 
                           WHERE not exists (SELECT 'x'
                                               FROM    hig_modules 
                                               WHERE   hmo_module = 'MAI3819');

Prompt Inserting into hig_module_roles
 Insert into hig_module_roles SELECT 'MAI3819','MAI_ADMIN','NORMAL' 
                           FROM dual 
                           WHERE not exists (SELECT 'x'
                                               FROM    hig_module_roles 
                                               WHERE   hmr_module = 'MAI3819'
                                               AND     hmr_role   = 'MAI_ADMIN');                                               

Prompt Inserting into hig_standard_favourites
Insert into hig_standard_favourites SELECT 'MAI_REF_MAINTENANCE', 'MAI3819','Composite Flexible Attributes','M',13.1 
                           FROM dual 
                           WHERE not exists (SELECT 'x'
                                               FROM    hig_standard_favourites 
                                               WHERE   hstf_parent = 'MAI_REF_MAINTENANCE'
                                               AND     hstf_child   = 'MAI3819');


Delete From HIG_FLEX_ATTRIBUTES;

Prompt Inserting into HIG_FLEX_ATTRIBUTES
Insert into HIG_FLEX_ATTRIBUTES
   (HFA_ID, HFA_TABLE_NAME, HFA_ATTRIBUTE1, HFA_ATTRIBUTE2, HFA_ATTRIBUTE3, 
    HFA_ATTRIBUTE4, HFA_ATTRIBUTE5, HFA_DATE_CREATED, HFA_CREATED_BY, HFA_DATE_MODIFIED, 
    HFA_MODIFIED_BY)
 Values
   (-1, 'WORK_ORDERS', 'WOR_SCHEME_TYPE', 'WOR_FLAG', NULL,NULL,NULL, 
    NULL, NULL, Null,Null);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Module Work Order Automation Rules
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109512
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- New Module Work Order Automation Rules
-- 
------------------------------------------------------------------
Prompt  Inserting into hig_modules
 Insert into hig_modules SELECT 'MAI3818','Work Order Automation Rules','mai3818.fmx','FMX',Null,'N','N','MAI','FORM' 
                           FROM dual 
                           WHERE not exists (SELECT 'x'
                                               FROM    hig_modules 
                                               WHERE   hmo_module = 'MAI3818');
                                               

Prompt  Inserting into  hig_module_roles
 Insert into hig_module_roles SELECT 'MAI3818','MAI_ADMIN','NORMAL' 
                           FROM dual 
                           WHERE not exists (SELECT 'x'
                                               FROM    hig_module_roles 
                                               WHERE   hmr_module = 'MAI3818'
                                               AND     hmr_role   = 'MAI_ADMIN');                                               
                                                

Prompt  Inserting into hig_standard_favourites
Insert into hig_standard_favourites SELECT 'MAI_REF_MAINTENANCE', 'MAI3818','Work Order Automation Rules','M',13 
                           FROM dual 
                           WHERE not exists (SELECT 'x'
                                               FROM    hig_standard_favourites 
                                               WHERE   hstf_parent = 'MAI_REF_MAINTENANCE'
                                               AND     hstf_child   = 'MAI3818');

Prompt  Inserting into  nm_errors
Insert into nm_errors Select 'MAI',9806,Null,'The associated Criteria will be deleted if changes are made to this Ruleset, do you want to continue?',Null
                        FROM  dual 
                        WHERE Not Exists (SELECT 'x'
                                            FROM    nm_errors
                                            WHERe ner_id = 9806);
                                            
Insert into nm_errors Select 'MAI',9807,Null,'A Ruleset already exists with these values.',Null
                        FROM  dual 
                        WHERE Not Exists (SELECT 'x'
                                            FROM    nm_errors
                                            WHERe ner_id = 9807);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Product Options DEFDOCTYPE and DEFDOCLOCN
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- New Product Options DEFDOCTYPE and DEFDOCLOCN to provide default Document Type and Document Location values for Defect document attachments loaded via Maintenance Inspection Loader
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
select 'DEFDOCTYPE'
      ,'MAI'
      ,'Default Defect Document Type'      
      ,'Contains the default Document Type for Defect document attachments loaded via Maintenace Inspection Loader.'
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'DEFDOCTYPE')
/
insert into hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
select 'DEFDOCLOCN'
      ,'MAI'
      ,'Default Document Location'      
      ,'Contains the default Document Location for Defect document attachments loaded via Maintenace Inspection Loader.'
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'DEFDOCLOCN')
/

------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

