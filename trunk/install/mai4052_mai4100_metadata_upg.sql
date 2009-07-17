------------------------------------------------------------------
-- mai4052_mai4100_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4052_mai4100_metadata_upg.sql-arc   3.0   Jul 17 2009 18:16:00   mhuitson  $
--       Module Name      : $Workfile:   mai4052_mai4100_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Jul 17 2009 18:16:00  $
--       Date fetched Out : $Modtime:   Jul 17 2009 18:12:24  $
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
PROMPT Update module params for mai2200r
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 105221
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (STUART MARSHALL)
-- Update to mai2200r module_params to use teh new v_are_batch_grouping view.
-- 
------------------------------------------------------------------
update gri_module_params
set gmp_where = 'are_report_id IN (SELECT max_are_report_id FROM v_are_batch_grouping are1 WHERE are1.are_batch_id = NVL (:batch_id, are1.are_batch_id)) ORDER BY TO_NUMBER (are_batch_id)'
where gmp_module = 'MAI2200R'
and gmp_param = 'BATCH_ID'
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Update NO_ALLOWED parameter.
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Correct metadata for the parameter no_allowed to prevent ORA-00932 error when validating in GRI0200.
-- 
------------------------------------------------------------------
UPDATE gri_module_params
   SET gmp_where             = 'GPL_PARAM = ''NO_ALLOWED'''
      ,gmp_default_where     = DECODE(gmp_default_where,NULL,NULL,'GPL_VALUE=''5'' AND GPL_PARAM=''NO_ALLOWED''')
      ,gmp_lov               = 'Y'
WHERE  gmp_param             = 'NO_ALLOWED'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Metadata To Support Contract Security.
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New Metadata For Contract Security Enhancement.
-- 
------------------------------------------------------------------
/*
||Add the Contract Security Mode Domain.
*/
INSERT
  INTO hig_domains
      (hdo_domain
      ,hdo_product
      ,hdo_title
      ,hdo_code_length)
SELECT 'CONTRACT_SECURITY'
      ,'MAI'
      ,'Values for PO CONSECMODE'
      ,1
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_domains
                   WHERE hdo_domain = 'CONTRACT_SECURITY')
/

/*
||Add Codes to the Contract Security Mode Domain.
*/
INSERT
  INTO hig_codes
      (hco_domain
      ,hco_code
      ,hco_meaning
      ,hco_system
      ,hco_seq
      ,hco_start_date
      ,hco_end_date)
SELECT 'CONTRACT_SECURITY'
      ,'N'
      ,'Not Enabled'
      ,'Y'
      ,1
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_codes
                   WHERE hco_domain = 'CONTRACT_SECURITY'
                     AND hco_code = 'N')
/

INSERT
  INTO hig_codes
      (hco_domain
      ,hco_code
      ,hco_meaning
      ,hco_system
      ,hco_seq
      ,hco_start_date
      ,hco_end_date)
SELECT 'CONTRACT_SECURITY'
      ,'A'
      ,'Contract Admin Unit Security Enabled'
      ,'Y'
      ,2
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_codes
                   WHERE hco_domain = 'CONTRACT_SECURITY'
                     AND hco_code = 'A')
/

INSERT
  INTO hig_codes
      (hco_domain
      ,hco_code
      ,hco_meaning
      ,hco_system
      ,hco_seq
      ,hco_start_date
      ,hco_end_date)
SELECT 'CONTRACT_SECURITY'
      ,'U'
      ,'Contractor User Security Enabled'
      ,'Y'
      ,3
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_codes
                   WHERE hco_domain = 'CONTRACT_SECURITY'
                     AND hco_code = 'U')
/

/*
||New Product Option CONSECMODE.
*/
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
SELECT 'CONSECMODE'
      ,'MAI'
      ,'Contractor Security Mode'
      ,'Set to "U"ser or "A"dmin Unit, to enable Contract Security.'
      ,'CONTRACT_SECURITY'
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_list
                   WHERE hol_id = 'CONSECMODE')
/

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value)
SELECT 'CONSECMODE'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_values
                   WHERE hov_id = 'CONSECMODE')
/

/*
||Add The Contractor User Security Status Domain.
*/
INSERT
  INTO hig_domains
      (hdo_domain
      ,hdo_product
      ,hdo_title
      ,hdo_code_length)
SELECT 'CONTRACTOR_USER_SEC'
      ,'MAI'
      ,'Contractor User Security Status'
      ,1
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_domains
                   WHERE hdo_domain = 'CONTRACTOR_USER_SEC')
/

/*
||Add Codes To The Domain.
*/
INSERT
  INTO hig_codes
      (hco_domain
      ,hco_code
      ,hco_meaning
      ,hco_system
      ,hco_seq
      ,hco_start_date
      ,hco_end_date)
SELECT 'CONTRACTOR_USER_SEC'
      ,'Y'
      ,'Enabled'
      ,'Y'
      ,1
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_codes
                   WHERE hco_domain = 'CONTRACTOR_USER_SEC'
                     AND hco_code = 'Y')
/

INSERT
  INTO hig_codes
      (hco_domain
      ,hco_code
      ,hco_meaning
      ,hco_system
      ,hco_seq
      ,hco_start_date
      ,hco_end_date)
SELECT 'CONTRACTOR_USER_SEC'
      ,'N'
      ,'Not enabled, see Product Option CONSECMODE'
      ,'Y'
      ,2
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_codes
                   WHERE hco_domain = 'CONTRACTOR_USER_SEC'
                     AND hco_code = 'N')
/

------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

