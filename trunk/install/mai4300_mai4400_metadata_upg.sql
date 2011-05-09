------------------------------------------------------------------
-- mai4300_mai4400_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4300_mai4400_metadata_upg.sql-arc   3.2   May 09 2011 14:09:18   Mike.Alexander  $
--       Module Name      : $Workfile:   mai4300_mai4400_metadata_upg.sql  $
--       Date into PVCS   : $Date:   May 09 2011 14:09:18  $
--       Date fetched Out : $Modtime:   May 09 2011 12:32:10  $
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
PROMPT Update INITIATION_TYPE Domain Length
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
-- Allow for INITIATION_TYPE domain entries to be 10 chars long
-- 
------------------------------------------------------------------
UPDATE hig_domains
SET hdo_code_length = 10
WHERE hdo_domain = 'INITIATION_TYPE'
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Remove redundant module MAI3890 metadata
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
-- Remove metadata for redundant module MAI3890
-- 
------------------------------------------------------------------
DELETE hig_module_roles
 WHERE hmr_module = 'MAI3890'
/

DELETE hig_modules
 WHERE hmo_module = 'MAI3890'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Add error message for Instruct Works Order.
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- **** COMMENTS TO BE ADDED BY MIKE HUITSON ****
-- 
------------------------------------------------------------------
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,928
       ,null
       ,'Please use the Instruct button to Instruct the Works Order.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 928);

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Modification to 9204 NM_ERRORS entry
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110658
-- 
-- TASK DETAILS
-- A number of error messages used by the Maintenance Inspection Loader have been altered to provide a better description of the problem.
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modification to 9204 NM_ERRORS entry
-- 
------------------------------------------------------------------
UPDATE nm_errors
SET ner_descr = 'Error : Chainage on P record exceeds required chainage for section. : Correct the section chainage.'
WHERE ner_appl = 'MAI'
AND ner_id = 9204
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Modifiaction to 9202 NM_ERRORS entry
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110658
-- 
-- TASK DETAILS
-- A number of error messages used by the Maintenance Inspection Loader have been altered to provide a better description of the problem.
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modifiaction to 9202 NM_ERRORS entry
-- 
------------------------------------------------------------------
UPDATE nm_errors
SET ner_descr = 'Error : Initiation Type is not recognised. : Correct the Initiation Type code.'
WHERE ner_appl = 'MAI'
AND ner_id = 9202
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Add Error Message for MAI4405.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110691
-- 
-- TASK DETAILS
-- Corrected an issue in which The Maintenance Inspection Loader Error Correction form (MAI4405) raised repeated errors (in an infinite loop) when the Batch is highlighted in the tree and the User pressed the "Re-Submit Inspection" button.
-- The form now asks the User to select an Inspection to be resubmitted and returns focus to the tree.
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Add an error message for MAI4405
-- 
------------------------------------------------------------------
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9547
       ,null
       ,'Please Select An Inspection To Be Re-Submitted.'
       ,''
  FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9547);

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Added Error message for MAI3800
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
-- Added Error message for MAI3800
-- 
------------------------------------------------------------------
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,929
       ,null
       ,'Target Date should not be before Date Instructed.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 929)
/

INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,932
       ,null
       ,'Target Date should not be before Date Raised.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 932)
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Mark any existing process types shipped with exor products are non-restartable
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110504
-- 
-- TASK DETAILS
-- To avoid problems when restarting the server we now set all our standard processes to be non-restartable by default. Customers are advised that setting a large number of processes to restartable could cause issues when restarting the server as they could all start simultaneously
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS STRETTLE)
-- Mark any existing process types shipped with exor products are non-restartable
-- 
------------------------------------------------------------------
--
-- Mark any existing process types shipped with exor products are non-restartable
--
update hig_process_types
set hpt_restartable = 'N'
where hpt_process_type_id < 1
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Module Budget Reallocation
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110656
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of metadata for new module Budget Reallocation - MAI3620
-- 
------------------------------------------------------------------
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
        'MAI3620'
       ,'Budget Reallocation'
       ,'mai3620'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3620');

BEGIN
   FOR i IN REVERSE 2 .. 7 LOOP

      UPDATE hig_standard_favourites
         SET hstf_order = hstf_order+1
       WHERE hstf_parent = 'MAI_FINANCIAL'
         AND hstf_order = i;
       
   END LOOP;
END;
/

INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI3620'
       ,'Budget Reallocation'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3620');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Error Massages for "To be Authorised by" field in MAI3800
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110524
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Error Massages for "To be Authorised by" field in MAI3800
-- 
------------------------------------------------------------------
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,930
       ,null
       ,'The selected User is not able to Authorise this Works Order.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 930);

INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,931
       ,null
       ,'Please enter Road Group and Contract.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 931);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Metadata for new MAI Users form (MAI4410)
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Metadata for new MAI Users form (MAI4410)
-- 
------------------------------------------------------------------
INSERT
  INTO HIG_MODULES
      (HMO_MODULE
      ,HMO_TITLE
      ,HMO_FILENAME
      ,HMO_MODULE_TYPE
      ,HMO_FASTPATH_OPTS
      ,HMO_FASTPATH_INVALID
      ,HMO_USE_GRI
      ,HMO_APPLICATION
      ,HMO_MENU)
SELECT 'MAI4410'
      ,'Maintenance Manager User Data'
      ,'mai4410'
      ,'FMX'
      ,''
      ,'N'
      ,'N'
      ,'MAI'
      ,'FORM'
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI4410');

INSERT
  INTO HIG_STANDARD_FAVOURITES
      (HSTF_PARENT
      ,HSTF_CHILD
      ,HSTF_DESCR
      ,HSTF_TYPE
      ,HSTF_ORDER)
SELECT 'MAI_REF'
      ,'MAI_REF_USERS'
      ,'Users'
      ,'F'
      ,5
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF'
                     AND HSTF_CHILD = 'MAI_REF_USERS');

INSERT
  INTO HIG_STANDARD_FAVOURITES
      (HSTF_PARENT
      ,HSTF_CHILD
      ,HSTF_DESCR
      ,HSTF_TYPE
      ,HSTF_ORDER)
SELECT 'MAI_REF_USERS'
      ,'MAI4410'
      ,'Maintenance Manager User Data'
      ,'M'
      ,1
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_USERS'
                     AND HSTF_CHILD = 'MAI4410');

INSERT
  INTO HIG_MODULE_ROLES
      (HMR_MODULE
      ,HMR_ROLE
      ,HMR_MODE)
SELECT 'MAI4410'
      ,'MAI_ADMIN'
      ,'NORMAL'
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4410'
                     AND HMR_ROLE = 'MAI_ADMIN');

INSERT
  INTO HIG_DOMAINS
      (HDO_DOMAIN
      ,HDO_PRODUCT
      ,HDO_TITLE
      ,HDO_CODE_LENGTH)
SELECT 'WOR_VALUE_CHECK'
      ,'MAI'
      ,'Check Works Order value'
      ,1
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'WOR_VALUE_CHECK');

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'WOR_VALUE_CHECK'
      ,'0'
      ,'Not Enabled'
      ,'Y'
      ,1
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_VALUE_CHECK'
                     AND HCO_CODE = '0');

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'WOR_VALUE_CHECK'
      ,'1'
      ,'Raise a warning'
      ,'Y'
      ,2
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_VALUE_CHECK'
                     AND HCO_CODE = '1');
                     
INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'WOR_VALUE_CHECK'
      ,'2'
      ,'Raise an error'
      ,'Y'
      ,3
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_VALUE_CHECK'
                     AND HCO_CODE = '2');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Populate MAI_USERS from HIG_USERS
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Populate MAI_USERS from HIG_USERS
-- 
------------------------------------------------------------------
  INSERT
    INTO mai_users
        (mus_user_id
        ,mus_wor_flag
        ,mus_wor_value_min
        ,mus_wor_value_max
        ,mus_wor_aur_allowed 
        ,mus_wor_aur_min
        ,mus_wor_aur_max
        ,mus_wor_aur_daily_max)
  SELECT hus_user_id
        ,NVL(hus_wor_flag,'0')
        ,hus_wor_value_min
        ,hus_wor_value_max
        ,'Y'
        ,hus_wor_aur_min
        ,hus_wor_aur_max
        ,NULL
    FROM hig_users
   WHERE NOT EXISTS(SELECT 1
                      FROM mai_users
                     WHERE mus_user_id = hus_user_id);


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New product option CIMINCRMKS
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
-- New Product Option CIMINCRMKS
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
select 'CIMINCRMKS'
      ,'MAI'
      ,'Include remarks in WO file'      
      ,'If set to Y, WO file will include Work Order and Work Order Lines remarks '
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'CIMINCRMKS');

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'CIMINCRMKS'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'CIMINCRMKS')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Rename MAI4405
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Rename MAI4405
-- 
------------------------------------------------------------------
UPDATE hig_modules
   SET hmo_title = 'Maintenance Inspection Summary/Error Correction'
 WHERE hmo_module = 'MAI4405';
--
UPDATE hig_standard_favourites
   SET hstf_descr = 'Maintenance Inspection Summary/Error Correction'
 WHERE hstf_child = 'MAI4405';
--
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Modification to AUTH_OWN produc/usert options
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110818
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modified AUTH_OWN product option to only allow upper case. Any existing lower case values will be updated
-- 
------------------------------------------------------------------
UPDATE hig_option_values
   SET hov_value = UPPER(hov_value)
 WHERE hov_id = 'AUTH_OWN';
--
UPDATE hig_option_list
   SET hol_mixed_case = 'N'
 WHERE hol_id = 'AUTH_OWN';
--
UPDATE hig_user_options
   SET huo_value = UPPER(huo_value)
 WHERE huo_id = 'AUTH_OWN';
--
UPDATE hig_user_option_list
   SET huol_mixed_case = 'N'
 WHERE huol_id = 'AUTH_OWN';

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Modification of Loader Errors
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- **** COMMENTS TO BE ADDED BY MIKE HUITSON ****
-- 
------------------------------------------------------------------
UPDATE nm_errors
SET ner_descr = 'I, L, M, N, P or R record must follow a K record'
WHERE ner_appl = 'MAI'
AND ner_id = 9526
/

UPDATE nm_errors
SET ner_descr = 'I, M, N, P, Q or R record must follow a L Record'
WHERE ner_appl = 'MAI'
AND ner_id = 9527
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Default DEF_SUPERSEDING_RULES entries
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110913
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Default DEF_SUPERSEDING_RULES entries
-- 
------------------------------------------------------------------
DECLARE
  lv_defmatpar   hig_options.hop_value%TYPE := NVL (hig.get_sysopt ('DEFMATPAR'), '5');
  lv_usedefchnd  hig_options.hop_value%TYPE := NVL(hig.get_sysopt ('USEDEFCHND'), 'N');
    
BEGIN    
  IF lv_usedefchnd = 'Y' THEN
     
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

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

