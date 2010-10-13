------------------------------------------------------------------
-- mai4210_mai4300_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4210_mai4300_metadata_upg.sql-arc   3.2   Oct 13 2010 16:32:18   Mike.Alexander  $
--       Module Name      : $Workfile:   mai4210_mai4300_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Oct 13 2010 16:32:18  $
--       Date fetched Out : $Modtime:   Oct 13 2010 16:21:36  $
--       Version          : $Revision:   3.2  $
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
PROMPT Modification to 9221 NM_ERRORS entry
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 715215  Welsh Assembly Group
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107374
-- 
-- TASK DETAILS
-- Inspection Loader - When an invalid Activity was encountered on the H record the old Inspection Loader raised a misleading error message referring to the Defect Time. The old inspection Loader has been replaced (see the New Functionality section of this document) and the new Loader has been coded to raise a more informative error message.
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modification to 9221 NM_ERRORS entry
-- 
------------------------------------------------------------------
UPDATE nm_errors
SET ner_descr = 'Error : Invalid activity area code on H type record for this section.'
WHERE ner_appl = 'MAI'
AND ner_id = 9221
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Default DEF_SUPERSEDING_RULES entries
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109948
-- 
-- TASK DETAILS
-- N/A
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Default DEF_SUPERSEDING_RULES entries
-- 
------------------------------------------------------------------
DECLARE
  lv_defmatpar   hig_options.hop_value%TYPE := NVL (hig.get_sysopt ('DEFMATPAR'), '5');
  lv_usedefchnl  hig_options.hop_value%TYPE := NVL(hig.get_sysopt ('USEDEFCHNL'), 'N');
  lv_usedefchnd  hig_options.hop_value%TYPE := NVL(hig.get_sysopt ('USEDEFCHNL'), 'N');
    
BEGIN    
  IF lv_usedefchnl = 'Y' OR
     lv_usedefchnd = 'Y' THEN
     
     INSERT INTO def_superseding_rules
        ( dsr_id
        , dsr_admin_unit
        , dsr_initiation_type
        , dsr_tolerance)
     SELECT dsr_id_seq.nextval,
            hau_admin_unit,
            hco_code,
            lv_defmatpar
       FROM hig_codes,
            hig_admin_units
      WHERE hco_domain = 'INITIATION_TYPE'
        AND hco_end_date IS NULL
        AND hau_level = 1
        AND hau_end_date IS NULL
        AND NOT EXISTS (SELECT 1
                          FROM def_superseding_rules def1
                         WHERE def1.dsr_admin_unit = hau_admin_unit
                           AND def1.dsr_initiation_type = hco_code);

    COMMIT;      

  END IF;
  
END;
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Inspection Loader Error Messages that were missing from 4210.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109933
-- 
-- TASK DETAILS
-- Missing error messages for the new Inspection Loader have been added.
-- The codes for the missing errors are, 9510, 9209, 9211, 9511, 9512 and 9535.
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Inspection Loader Error Messages that were missing from 4210.
-- These were also released as part of MAI 4210 Fix 1.
-- 
------------------------------------------------------------------
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
       ,9510
       ,null
       ,'Error : Invalid action completion date. : Ensure that the action completion date is correct.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9510);
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
       ,9209
       ,null
       ,'Error : The Secondary inspector cannot be located. : Correct the Secondary inspectors initials in the G record.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9209);
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
       ,9211
       ,null
       ,'Error : Invalid Road Surface condition code. : Correct the Road Surface condition code.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9211);
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
       ,9511
       ,null
       ,'Error : Invalid action completion time. : Ensure that the action completion time is correct.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9511);
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
       ,9512
       ,null
       ,'Error : Job item location error. : Ensure that the job item is correct.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9512);
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
       ,9535
       ,null
       ,'Invalid Record Type Found'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9535);

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT GRI LOV SQL changed for MAI3900
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109223
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- GRI LOV SQL changed for MAI3900
-- 
------------------------------------------------------------------
UPDATE gri_module_params 
SET    gmp_where = 'ARE_REPORT_ID IN (
SELECT DISTINCT (SELECT Max(are_report_id) FROM  activities_report A WHERE A.are_batch_id = b.ARE_BATCH_ID ) are_id
FROM activities_report b WHERE are_batch_id IS NOT NULL AND ARE_BATCH_ID = Nvl( :BATCH_ID, ARE_BATCH_ID)
) ORDER BY To_Number(ARE_BATCH_ID)'
WHERE gmp_param = 'BATCH_ID' AND gmp_module = 'MAI3900' 
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Work Order Date Raised Time Element changes.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108904
-- 
-- TASK DETAILS
-- Works Orders (MAI3800) - A Time element has been added to the Date Raised to allow for accurate calculation of the Target Date when Works Order Priorities and Intervals are in use.
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Time element has been added to wor_date_raised to need to truncate it here.
-- 
------------------------------------------------------------------
UPDATE gri_module_params
   SET gmp_tag_where = 'TRUNC(WOR_DATE_RAISED) >= :FROM_DATE'
 WHERE GMP_MODULE = 'MAI8000'
   AND GMP_PARAM = 'FROM_DATE'
/

UPDATE gri_module_params
   SET gmp_tag_where = 'TRUNC(WOR_DATE_RAISED) <=:TO_DATE'
 WHERE GMP_MODULE = 'MAI8000'
   AND  GMP_PARAM = 'TO_DATE'
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Corrected MAI3819 Module title
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Corrected MAI3819 Module title
-- 
------------------------------------------------------------------
UPDATE hig_modules
SET    hmo_title = 'Application Attributes'
WHERE  hmo_module = 'MAI3819';



------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Changes to mete model BOQ$  and PRO$
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110115
-- 
-- TASK DETAILS
-- N/A
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Changes to mete model BOQ$  and PRO$
-- 
------------------------------------------------------------------
UPDATE nm_inv_type_attribs_all 
set       ita_query = 'SELECT DISTINCT cni_sta_item_code sta_item_code '||
                                    '       ,sis_name '||
                  '             ,cni_sta_item_code '||
                                    'FROM standard_item_sections sis '||
                  '         ,standard_item_sub_sections sts '||
                                    '    ,standard_items '||
                  '        ,contract_items '||
                                    '    ,contracts '||
                  'WHERE  To_Date(Trunc(Sysdate)) BETWEEN Nvl(con_start_date,To_Date(Trunc(Sysdate))) '||
                                    '                   AND Nvl(con_end_date,To_Date(Trunc(Sysdate))) '||
                  'AND con_id = cni_con_id '||
                                    'AND cni_sta_item_code = sta_item_code '|| 
                  'AND sta_siss_id = sts.siss_id '||
                                    'AND sts.siss_sis_id = sis.sis_id ' 
WHERE ita_inv_type = 'BOQ$' AND ita_attrib_name = 'BOQ_STA_ITEM_CODE' ;


UPDATE nm_inv_type_attribs_all
SET       ita_displayed  = 'Y' 
               ,ita_disp_width = Decode(ita_format,'VARCHAR2',20,10) 
 WHERE   ita_inv_type = 'PRO$' ;


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Navigator meta data
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110126
-- 
-- TASK DETAILS
-- N/A
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Populate Products for each hierarchy node
-- 
------------------------------------------------------------------
UPDATE hig_navigator 
SET       hnv_hpr_product = Decode(hnv_hierarchy_label,'Notice','TMA'
                                                               ,'Enquiry','ENQ'
                                                               ,'Asset','AST','MAI');



------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Remove All Traces of the old Inspection Loader.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109665
-- 
-- TASK DETAILS
-- The C modules (mai2200d and mai2200c) previously used to load Inspection data have been replaced by a single module running under the new Process Management Framework. See the New Functionality section of this document or the MAI User Guide for further details of the new Inspection Loader.
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- A new Inspection Loader has been intriduced that uses the Process Management Framework so the old C Inspection Loader has been removed.
-- 
------------------------------------------------------------------
DELETE hig_user_favourites
 WHERE huf_child IN('MAI2200C','MAI2200D','MAI5091','MAI2250')
/

DELETE hig_system_favourites
 WHERE hsf_child IN('MAI2200C','MAI2200D','MAI5091','MAI2250')
/

DELETE hig_standard_favourites
 WHERE hstf_child IN('MAI2200C','MAI2200D','MAI5091','MAI2250')
/

DELETE gri_module_params
 WHERE gmp_module IN('MAI2200C','MAI2200D','MAI5091')
/

DELETE gri_modules
 WHERE grm_module IN('MAI2200C','MAI2200D','MAI5091')
/

DELETE nm_theme_functions_all
 WHERE ntf_hmo_module IN('MAI2200C','MAI2200D','MAI5091','MAI2250')
/

DELETE hig_module_roles
 WHERE hmr_module IN('MAI2200C','MAI2200D','MAI5091','MAI2250')
/

DELETE hig_modules
 WHERE hmo_module IN('MAI2200C','MAI2200D','MAI5091','MAI2250')
/

--Rename MAI2200R
UPDATE hig_modules
   SET hmo_title = 'Maintenance Inspection Loader Report'
 WHERE hmo_module = 'MAI2200R'
 /
 
--Reinsert the menu metadata for MAI2200R that was removed during
--the MAI4210 upgrade. Note that the module description has changed.
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER)
SELECT 'MAI_LOADERS_INSPECTIONS'
       ,'MAI2200R'
       ,'Maintenance Inspection Loader Report'
       ,'M'
       ,30
 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2200R')
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Product Option CIMALLEST
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 723588  Worcestershire County Council (H&W)
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 726867  Oxfordshire County Council
-- 
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 727889  Hampshire County Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 109080
-- 
-- TASK DETAILS
-- New Product Option CIMALLEST which, when set to 'Y', will ensure only estimated costs are included in the CIM interface WO file.
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- New Product Option CIMALLEST
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
select 'CIMALLEST'
      ,'MAI'
      ,'Use Estimated Cost for WO file'      
      ,'If set to Y, WO file will always contain estimated cost values for Work Order and BOQ costs '
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'CIMALLEST');

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'CIMALLEST'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'CIMALLEST')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Additional Values for the ASSET_MODIFICATION domain.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109859
-- 
-- TASK DETAILS
-- All modules that refer to the "inventory change" flag have been changed to use the ASSET_MODIFICATION domain, bringing them in line with the "Create Defect From Locator" form (MAI3807).
-- All labels in forms and reports have been changed to "Asset Modification".
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Additional Values Y and N for the ASSET_MODIFICATION domain.
-- 
------------------------------------------------------------------
INSERT INTO HIG_CODES
       (HCO_DOMAIN
       ,HCO_CODE
       ,HCO_MEANING
       ,HCO_SYSTEM
       ,HCO_SEQ
       ,HCO_START_DATE
       ,HCO_END_DATE
       )
SELECT 
        'ASSET_MODIFICATION'
       ,'Y'
       ,'Yes'
       ,'Y'
       ,5
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                    AND  HCO_CODE = 'Y');
                    
INSERT INTO HIG_CODES
       (HCO_DOMAIN
       ,HCO_CODE
       ,HCO_MEANING
       ,HCO_SYSTEM
       ,HCO_SEQ
       ,HCO_START_DATE
       ,HCO_END_DATE
       )
SELECT 
        'ASSET_MODIFICATION'
       ,'N'
       ,'No'
       ,'Y'
       ,6
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                    AND  HCO_CODE = 'N');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Added GRI parameter ANSWER2 for MAI3900
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 725423  W.S. Atkins- Area 6
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 109351
-- 
-- TASK DETAILS
-- Parameter 'End Dated Sections (Y/N)' has been added to the Print Inspections Report (MAI3900) parameter list, allowing for the reporting of Inspection Details for End Dated sections
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Added GRI parameter ANSWER2 for MAI3900
-- 
------------------------------------------------------------------
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'ANSWER2'
       ,10
       ,'End Dated Sections (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER2'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER2'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'ANSWER2');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Update Standard Defect Theme FT Asset Type.
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- **** COMMENTS TO BE ADDED BY MIKE HUITSON ****
-- 
------------------------------------------------------------------
DECLARE
  --
  lv_view_name     user_tables.table_name%TYPE := mai_sdo_util.g_view_name;
  lv_ne_id_col     user_tab_columns.column_name%TYPE := mai_sdo_util.g_view_ne_id_col;
  lv_st_chain_col  user_tab_columns.column_name%TYPE := mai_sdo_util.g_view_st_chain_col;
  --
  PROCEDURE check_columns
    IS
    --
    lv_temp  NUMBER;
    --
  BEGIN
    --
    SELECT 1
      INTO lv_temp
      FROM user_tab_columns
     WHERE table_name = lv_view_name
       AND column_name = lv_ne_id_col
         ;
    --
    SELECT 1
      INTO lv_temp
      FROM user_tab_columns
     WHERE table_name = lv_view_name
       AND column_name = lv_st_chain_col
         ;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        raise_application_error(-20001,'Unable to update Defects Theme FT Asset Metamodel - Missing LRS Columns on view');
    WHEN others
     THEN
        RAISE;
  END check_columns;
  --
BEGIN
  --Check For The Standard Theme View.
  IF nm3ddl.does_object_exist(lv_view_name)
   THEN
      --
      check_columns;
      --
      UPDATE nm_inv_types_all
         SET nit_lr_ne_column_name = lv_ne_id_col
            ,nit_lr_st_chain = lv_st_chain_col
            ,nit_lr_end_chain = lv_st_chain_col
       WHERE nit_table_name = lv_view_name
           ;
      --
      COMMIT;
      --
  END IF;
END;
/
------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

