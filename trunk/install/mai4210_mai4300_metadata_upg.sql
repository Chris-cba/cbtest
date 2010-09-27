------------------------------------------------------------------
-- mai4210_mai4300_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4210_mai4300_metadata_upg.sql-arc   3.0   Sep 27 2010 10:54:14   mike.alexander  $
--       Module Name      : $Workfile:   mai4210_mai4300_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Sep 27 2010 10:54:14  $
--       Date fetched Out : $Modtime:   Sep 27 2010 10:52:06  $
--       Version          : $Revision:   3.0  $
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
-- No details supplied
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
-- No details supplied
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
-- No details supplied
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
-- No details supplied
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
-- No details supplied
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
-- No details supplied
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

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

