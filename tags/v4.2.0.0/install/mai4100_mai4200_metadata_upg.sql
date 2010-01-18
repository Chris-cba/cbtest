------------------------------------------------------------------
-- mai4100_mai4200_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4100_mai4200_metadata_upg.sql-arc   3.0   Jan 18 2010 16:14:32   malexander  $
--       Module Name      : $Workfile:   mai4100_mai4200_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Jan 18 2010 16:14:32  $
--       Date fetched Out : $Modtime:   Jan 18 2010 15:43:00  $
--       Version          : $Revision:   3.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2009

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
PROMPT Fastpath setting of Module
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 108548
-- 
-- TASK DETAILS
-- n/a
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Setting the correct fastpath value for some MAi Reports
-- 
------------------------------------------------------------------
Begin
Update hig_modules
Set     hmo_fastpath_invalid = 'Y'
where  hmo_module_type = 'R25' 
and    hmo_fastpath_invalid = 'N' 
and    hmo_use_gri = 'N';
Commit;
End ;
/


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Added GRI data for Module MAI3841 and MAI8000
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 105219
-- 
-- TASK DETAILS
-- n/a
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 108581
-- 
-- TASK DETAILS
-- n/a
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Added GRI data for modules MAI3841 and MAI8000
-- 
------------------------------------------------------------------
Begin
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
        'MAI8000'
       ,'N/A'
       ,'$PROD_HOME/BIN'
       ,'lis'
       ,'Y'
       ,'WORK_ORDERS'
       ,'WOR_WORKS_ORDER_NO'
       ,''
       ,80
       ,80
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI8000');
                   

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
        'MAI8000'
       ,'CONTRACTOR_ID'
       ,70
       ,'Contractor'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_CON_ID = :CONTRACTOR_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Contractor'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');

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
        'MAI8000'
       ,'FROM_DATE'
       ,20
       ,'From Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'Y'
       ,'WOR_DATE_RAISED >= :FROM_DATE'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'FROM_DATE');

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
        'MAI8000'
       ,'H2'
       ,50
       ,'Originated By'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_PEO_PERSON_ID = :H2'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Originated By'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'H2');

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
        'MAI8000'
       ,'HIG_USER_ID'
       ,40
       ,'Authorised By'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_MOD_BY_ID = :HIG_USER_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Authorised By'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'HIG_USER_ID');

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
        'MAI8000'
       ,'ROAD_ID'
       ,60
       ,'Road Id'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_RSE_HE_ID_GROUP = :ROAD_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Road Group'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'ROAD_ID');

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
        'MAI8000'
       ,'TEMPLATE_NAME'
       ,10
       ,'Template'
       ,'Y'
       ,1
       ,'DTG_TEMPLATE_NAME IN (SELECT DTU_TEMPLATE_NAME FROM DOC_TEMPLATE_USERS,HIG_USERS  WHERE DTU_USER_ID = HUS_USER_ID AND HUS_USERNAME = USER) '||CHR(10)||'AND 
DTG_TABLE_NAME =''WORK_ORDERS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Template to Use'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'TEMPLATE_NAME');

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
        'MAI8000'
       ,'TO_DATE'
       ,30
       ,'To Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR '||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'Y'
       ,'WOR_DATE_RAISED <=:TO_DATE'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'TO_DATE');

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
        'MAI8000'
       ,'WORKS_ORDER_NO'
       ,80
       ,'Works Order No'
       ,'N'
       ,20
       ,''
       ,'Y'
       ,'WOR_WORKS_ORDER_NO IN (:WORKS_ORDER_NO)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Specific Works Order No (Use Insert Record to specify more than one)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');

INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');


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
        'MAI3841'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3841');



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
        'MAI3841'
       ,'CONTRACT_ID'
       ,1
       ,'Select Contract'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Contract'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3841'
                    AND  GMP_PARAM = 'CONTRACT_ID');

Commit;
End ;
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Hig_Options ACTIVECON
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 720597  South Lanarkshire Council
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 108113
-- 
-- TASK DETAILS
-- When running Raise Work Order form (MAI3801) from Locator, both active and inactive contracts are shown in the LOV.  When the product option ACTIVECON is set to Y, the Contractors LOV only shows active contracts now.
-- 
-- 
-- DEVELOPMENT COMMENTS (LINESH SORATHIA)
-- Hig_Options ACTIVECON setup
-- 
------------------------------------------------------------------
BEGIN
--
   INSERT INTO hig_option_list
          ( hol_id
          , hol_product
          , hol_name
          , hol_remarks
          , hol_datatype
          , hol_mixed_case
          , hol_user_option
          )
   SELECT 'ACTIVECON'
          , 'MAI'
          , 'Show Active Contracts Only'
          , 'Set to Y to display only ACTIVE Contracts'
          , 'VARCHAR2'
          , 'N'
          , 'N'
   FROM   Dual
   WHERE  NOT EXISTS ( SELECT 1
                       FROM   hig_option_list
                       WHERE  hol_id = 'ACTIVECON'
              );
                                      
   INSERT INTO hig_option_values
          ( hov_id
          , hov_value
          )
   Select 'ACTIVECON'
          ,'N'
   FROM   Dual
   WHERE  NOT EXISTS( SELECT 1
                      FROM   hig_option_values
                      WHERE  hov_id = 'ACTIVECON'
                    );
   Commit ;
--
END ;                                        
/


------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Update Cost Centre Option
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New Product/User Option to allow the update of Cost Centre in mai3800 at any time in the Work Order life cycle.
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
SELECT 'UPDCOSTCTR'
      ,'MAI'
      ,'Updateable Cost Centre (Y/N)'
      ,'This option can be specified at either Product or User level to determine whether all/specific Users can update the Cost Centre on a Works Order after it has been Instructed.'
      ,'Y_OR_N'
      ,'VARCHAR2'
      ,'N'
      ,'Y'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_list
                   WHERE hol_id = 'UPDCOSTCTR')
/

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value) 
SELECT 'UPDCOSTCTR'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_values
                   WHERE hov_id = 'UPDCOSTCTR')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Allow Interims less than previously paid Option
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New Product Option, when set to Y allows Interim Payments that are lower than previously paid claim in the forms application.
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
SELECT 'NEGINTERIM'
      ,'MAI'
      ,'Allow negative interims (Y/N)'
      ,'This option should be used to determine whether Interim Claims (entered through the application i.e. not via the CIM Interface) can take the value of a Work Order Line below the value previously paid.'
      ,'Y_OR_N'
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_list
                   WHERE hol_id = 'NEGINTERIM')
/

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value) 
SELECT 'NEGINTERIM'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_values
                   WHERE hov_id = 'NEGINTERIM')
/

------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

