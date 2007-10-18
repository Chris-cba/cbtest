------------------------------------------------------------------
-- mai4010_mai4020_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4010_mai4020_metadata_upg.sql-arc   2.1   Oct 18 2007 12:05:36   jwadsworth  $
--       Module Name      : $Workfile:   mai4010_mai4020_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Oct 18 2007 12:05:36  $
--       Date fetched Out : $Modtime:   Oct 18 2007 11:52:22  $
--       Version          : $Revision:   2.1  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2007
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
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
PROMPT CIM Interface Add Product Option IFUSEDEFXY
SET TERM OFF

-- MH  29-MAY-2007
-- 
-- DEVELOPMENT COMMENTS
-- Added to allow TfL to include a defects x and y co-ordinates in the WO Interface file.
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
SELECT 'IFUSEDEFXY'
      ,'MAI'
      ,'Interface Use Defect X,Y'
      ,'(Y/N) Enter Y to include the Defects X,Y co-ordinates in the CIM Work Order File.'
      ,NULL
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_list
                   WHERE hol_id = 'IFUSEDEFXY')
     ;

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value)
SELECT 'IFUSEDEFXY'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM  hig_option_values
                   WHERE  hov_id = 'IFUSEDEFXY')
     ;
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT MAI5056.rex metadata insert into gri_modules
SET TERM OFF

-- SSC  26-JUL-2007
-- 
-- ASSOCIATED LOG#
-- 49521
-- 
-- CUSTOMER
-- 
-- 
-- PROBLEM
-- 
-- 
-- DEVELOPMENT COMMENTS
-- Test Manager log number 49521.
-- gri_modules metadata for MAI5065.rex not in previous upgrade scripts.  Was correctly included in the metadata account, and hence the maidata2.sql script.
------------------------------------------------------------------
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5065'
       ,'R25'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5065');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Insert of gri_modules data required for certain reports to run
SET TERM OFF

-- MAX  04-MAY-2007
-- 
-- ASSOCIATED LOG#
-- 708607
-- 
-- CUSTOMER
-- London Borough of Harrow
-- 
-- PROBLEM
-- We get an unexpected error occurred message when trying to use `Print Inventory Gap/Overlap' located in Maintenance Manager > Inventory > Reports.  Message: UNEXPECTED ERROR OCCURRED  ORA-20072: gri_modules record not found  ORA-06512: at 'HIGHWAYS HIGGRI', line 1022  ORA-06512: at 'HIGHWAYS HIGGRI', line 1143  ORA-06512: at 'HIGHWAYS.HIGGRI', line 1294
-- 
-- 
-- DEVELOPMENT COMMENTS
-- A script to insert gri_modules with data for reports that didnt require parameters in version 2 but do now see logs 708607 (main), 706731 and 708613
------------------------------------------------------------------
DECLARE
   --
   -- *******************************
   -- * GRI_MODULES - MAX 04-May-07 *
   -- ********************************************************
   -- * A script to insert gri_modules with data for reports *
   -- * that didn't require parameters in version 2 but do   *
   -- * now see logs 708607 (main), 706731 and 708613          *
   -- ********************************************************
   --
   TYPE tab_rec_grm IS TABLE OF gri_modules%ROWTYPE INDEX BY BINARY_INTEGER;
   --
   l_rec_grm     gri_modules%ROWTYPE;
   l_tab_rec_grm tab_rec_grm;
   --
   l_grm_count   PLS_INTEGER := 0;
   --
   PROCEDURE add_grm IS
   BEGIN
      l_grm_count := l_grm_count + 1;
      l_tab_rec_grm(l_grm_count) := l_rec_grm;
   END add_grm;
   --
BEGIN
   --
   l_rec_grm.grm_module       := 'MAI5205';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 132;
   l_rec_grm.grm_pagesize     := 66;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI5225';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI5215';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null; 
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI9020';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis'; 
   l_rec_grm.grm_tag_flag     := 'N'; 
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI5200';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI5210';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI3946';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI5065';
   l_rec_grm.grm_module_type  := 'R25';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   l_rec_grm.grm_module       := 'MAI2105C';
   l_rec_grm.grm_module_type  := 'SVR';
   l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
   l_rec_grm.grm_file_type    := 'lis';
   l_rec_grm.grm_tag_flag     := 'N';
   l_rec_grm.grm_tag_table    := Null;
   l_rec_grm.grm_tag_column   := Null;
   l_rec_grm.grm_tag_where    := Null;
   l_rec_grm.grm_linesize     := 66;
   l_rec_grm.grm_pagesize     := 132;
   l_rec_grm.grm_pre_process  := Null;
   add_grm;
   --
   FOR i IN 1..l_grm_count
   LOOP
      l_rec_grm := l_tab_rec_grm(i);
      INSERT INTO gri_modules
            (grm_module
            ,grm_module_type
            ,grm_module_path
            ,grm_file_type
            ,grm_tag_flag
            ,grm_tag_table
            ,grm_tag_column
            ,grm_tag_where
            ,grm_linesize
            ,grm_pagesize
            ,grm_pre_process
            )
      SELECT l_rec_grm.grm_module
            ,l_rec_grm.grm_module_type
            ,l_rec_grm.grm_module_path
            ,l_rec_grm.grm_file_type
            ,l_rec_grm.grm_tag_flag
            ,l_rec_grm.grm_tag_table
            ,l_rec_grm.grm_tag_column
            ,l_rec_grm.grm_tag_where
            ,l_rec_grm.grm_linesize
            ,l_rec_grm.grm_pagesize
            ,l_rec_grm.grm_pre_process
      FROM   dual
      WHERE NOT EXISTS (SELECT 1
                        FROM   gri_modules
                        WHERE  grm_module = l_rec_grm.grm_module
                       )
      AND EXISTS (SELECT 1
                  FROM   hig_modules
                  WHERE  hmo_module = l_rec_grm.grm_module
                 );
   END LOOP;
--
END;
/
COMMIT;
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Update incorrect where clause value stored in gri_module_params.gmp_where to the correct value
SET TERM OFF

-- MAX  09-MAY-2007
-- 
-- ASSOCIATED LOG#
-- 706707
-- 
-- CUSTOMER
-- InterRoute (Area 2)
-- 
-- PROBLEM
-- we are trying to select a Defect Type but which ever one we select, eg BCK, always returns SMTH
-- 
-- DEVELOPMENT COMMENTS
-- Update incorrect where clause value stored in gri_module_params.gmp_where to the correct value
------------------------------------------------------------------
/*
-- MAX Log 706707 (09-May-07 Fix)
-- Problem:  we are trying to select a Defect Type but which ever one we select, 
--           eg BCK, always returns SMTH
-- Solution: SQL for where clause not quite correct.  Requires brackets around the
--           statement
*/
update gri_module_params
set    gmp_where = '((:A_OR_G = ''A'' AND :ACTIVITY IS NOT NULL AND DTY_ATV_ACTY_AREA_CODE'
                  ||' = :ACTIVITY) OR (:A_OR_G = ''G''  AND :ACTIVITY_GROUP IS NOT NULL '
                  ||'AND DTY_ATV_ACTY_AREA_CODE IN (SELECT AGM_ACTY_CODE FROM ACT_GROUP_MEMBS '
                  ||'WHERE AGM_GROUP_CODE = :ACTIVITY_GROUP)) OR (:A_OR_G = ''A'' AND '
                  ||':ACTIVITY IS NULL) OR (:A_OR_G = ''G'' AND :ACTIVITY_GROUP IS NULL)) '
                  ||'ORDER BY DTY_DEFECT_CODE'
where  gmp_module = 'MAI5100'
and    gmp_param  = 'DEFECT_TYPE';

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT NER MAI-925
SET TERM OFF

-- SSC  03-AUG-2007
-- 
-- ASSOCIATED LOG#
-- 49186
-- 
-- CUSTOMER
-- 
-- 
-- PROBLEM
-- 
-- 
-- DEVELOPMENT COMMENTS
-- Test Manager log 49186.
-- If a Gang can not be found in hig_codes in the domain GANG_WORK_TYPE, a message was raised in mai3888.fmt to inform the user.  Added a new record to nm_errors so that the error can be raised correctly.
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
       ,925
       ,null
       ,'Invalid Gang work type'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 925);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT NER MAI-004
SET TERM OFF

-- DIY  06-AUG-2007
-- 
-- ASSOCIATED LOG#
-- 703727
-- 
-- CUSTOMER
-- Transport for London
-- 
-- PROBLEM
-- Invalid error message raised.
-- 
-- DEVELOPMENT COMMENTS
-- 703727 - script to add missing error (MAI-004) for NM0206.fmt
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
       ,4
       ,null
       ,'Error Closing Element'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 4);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Update gri_module_params where GMP_PARAM = 'DEFECT_PRIORITY'
SET TERM OFF

-- SSC  08-AUG-2007
-- 
-- ASSOCIATED LOG#
-- 709089
-- 
-- CUSTOMER
-- Transport for London
-- 
-- PROBLEM
-- custom defect priorities were creates for tfl, thefore the defualt out of box ones were end dated, they still appear in system. how do we remove these?
-- 
-- DEVELOPMENT COMMENTS
-- log: 709089
-- Problem: custom defect priorities were created for tfl, thefore the default out of box ones were end dated, they still appear in system. how do we remove these?
-- Solution: Change to GRI_MODULE_PARAMETERS.
-- The gmp_where changed from:-
-- HCO_DOMAIN='DEFECT_PRIORITIES'
-- to 
-- HCO_DOMAIN='DEFECT_PRIORITIES' AND HCO_END_DATE IS NULL
-- Where the gmp_param = 'DEFECT_PRIORITY'
------------------------------------------------------------------
update gri_module_params
set GMP_WHERE = 'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
where GMP_PARAM = 'DEFECT_PRIORITY';
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT MAI2105C gri metadata
SET TERM OFF

-- SSC  22-AUG-2007
-- 
-- ASSOCIATED LOG#
-- 49531
-- 
-- CUSTOMER
-- 
-- 
-- PROBLEM
-- 
-- 
-- DEVELOPMENT COMMENTS
-- Test manager log.
-- Gri metadata missing for module MAI2105C.
-- This is a C file, so metadata is only required for the gri_modules table.
------------------------------------------------------------------
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2105C'
       ,'SVR'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2105C');
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT mai3863 additional metadata
SET TERM OFF

-- SSC  14-SEP-2007
-- 
-- ASSOCIATED LOG#
-- 709407
-- 
-- CUSTOMER
-- Department of Regional Development(NI)
-- 
-- PROBLEM
-- In this module ALL inspectors are listed when the list of inspectors
--                 should be restricted by the specified admin unit. 
--                 In the DRD there are over 150 inspectors and it is a nightmare to look down
--                 a list of 150 just to locate a single inspector.
-- 
-- DEVELOPMENT COMMENTS
-- logged by DRD.
-- DRD wanted to only show a list of inspectors restricted by the admin unit of the current user when they run mai3863.  This allows the user to specify if they want to see a list of all inspectors, or a list restricted by their own admin unit.
-- Also DRD wanted to be able to specify a default file name when creating a PED file.  The new user option PEDFILE allows the user to do this.  See the log for more details...
------------------------------------------------------------------
--
--HIG_CODES
--
Insert into HIG_CODES
   (HCO_DOMAIN, HCO_CODE, HCO_MEANING, HCO_SYSTEM, HCO_SEQ, 
    HCO_START_DATE, HCO_END_DATE)
Select 'USER_OPTIONS', 'PEDFILE', 'Mai3863 Edif Filename', 'N', 36, 
    NULL, NULL
from dual
where not exists (select 1 from HIG_CODES where HCO_DOMAIN = 'USER_OPTIONS' and HCO_CODE = 'PEDFILE');

--
--HIG_OPTION_LIST
--
Insert into HIG_OPTION_LIST
   (HOL_ID, HOL_PRODUCT, HOL_NAME, HOL_REMARKS, HOL_DOMAIN, 
    HOL_DATATYPE, HOL_MIXED_CASE, HOL_USER_OPTION)
Select 'PEDFILE', 'MAI', 'Mai3863 Edif Filename', 'This will be the default filename provided for the specified user.', NULL, 
    'VARCHAR2', 'Y', 'Y'
from dual
where not exists (select 1 from HIG_OPTION_LIST where HOL_ID = 'PEDFILE');

--
--GRI_PARAMS
--
Insert into GRI_PARAMS
   (GP_PARAM, GP_PARAM_TYPE, GP_TABLE, GP_COLUMN, GP_DESCR_COLUMN, 
    GP_SHOWN_COLUMN, GP_SHOWN_TYPE, GP_DESCR_TYPE, GP_ORDER, GP_CASE, 
    GP_GAZ_RESTRICTION)
select 'PEDFILE', 'CHAR', NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL, 
    NULL 
from dual
where not exists (select 1 from GRI_PARAMS where GP_PARAM = 'PEDFILE');

--
--GRI_MODULE_PARAMS
--
Insert into GRI_MODULE_PARAMS
   (GMP_MODULE, GMP_PARAM, GMP_SEQ, GMP_PARAM_DESCR, GMP_MANDATORY, 
    GMP_NO_ALLOWED, GMP_WHERE, GMP_TAG_RESTRICTION, GMP_TAG_WHERE, GMP_DEFAULT_TABLE, 
    GMP_DEFAULT_COLUMN, GMP_DEFAULT_WHERE, GMP_VISIBLE, GMP_GAZETTEER, GMP_LOV, 
    GMP_VAL_GLOBAL, GMP_WILDCARD, GMP_HINT_TEXT, GMP_ALLOW_PARTIAL, GMP_BASE_TABLE, 
    GMP_BASE_TABLE_COLUMN, GMP_OPERATOR)
Select 'MAI3863', 'PEDFILE', 9, 'Specified Filename', 'Y', 
    1, NULL, 'N', NULL, 'HIG_USER_OPTIONS', 
    'HUO_VALUE', 'HUO_ID=''PEDFILE'' AND HUO_HUS_USER_ID=( SELECT HUS_USER_ID FROM HIG_USERS WHERE HUS_USERNAME=USER)', 'N', 'N', 'N', 
    NULL, 'N', NULL, 'N', NULL, 
    NULL, NULL
from dual
where not exists (select 1 from GRI_MODULE_PARAMS where GMP_MODULE = 'MAI3863' and GMP_PARAM = 'PEDFILE');
    
Insert into GRI_MODULE_PARAMS
   (GMP_MODULE, GMP_PARAM, GMP_SEQ, GMP_PARAM_DESCR, GMP_MANDATORY, 
    GMP_NO_ALLOWED, GMP_WHERE, GMP_TAG_RESTRICTION, GMP_TAG_WHERE, GMP_DEFAULT_TABLE, 
    GMP_DEFAULT_COLUMN, GMP_DEFAULT_WHERE, GMP_VISIBLE, GMP_GAZETTEER, GMP_LOV, 
    GMP_VAL_GLOBAL, GMP_WILDCARD, GMP_HINT_TEXT, GMP_ALLOW_PARTIAL, GMP_BASE_TABLE, 
    GMP_BASE_TABLE_COLUMN, GMP_OPERATOR)
Select 'MAI3863', 'ANSWER2', 10, 'Restrict Inspector by AU', 'Y', 
    1, 'GPL_PARAM=''ANSWER''', 'N', NULL, 'GRI_PARAM_LOOKUP', 
    'GPL_VALUE', 'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER''', 'N', 'N', 'Y', 
    NULL, 'N', 'Restrict the inspector listing by Administration Unit ?', 'N', NULL, 
    NULL, NULL
from dual
where not exists (select 1 from GRI_MODULE_PARAMS where GMP_MODULE = 'MAI3863' and GMP_PARAM = 'ANSWER2');
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
COMMIT
/
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

