------------------------------------------------------------------
-- mai4052_mai4100_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4052_mai4100_metadata_upg.sql-arc   3.2   Oct 08 2009 14:14:56   malexander  $
--       Module Name      : $Workfile:   mai4052_mai4100_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Oct 08 2009 14:14:56  $
--       Date fetched Out : $Modtime:   Oct 08 2009 14:13:36  $
--       Version          : $Revision:   3.2  $
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
SET TERM ON
PROMPT Incorrect module data for certain reports
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 718987  Exor Corporation Ltd
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107382
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (ROB MAY)
-- If fresh install of mai 4.0.4.0 then hig modules data incorrect for certain reports.   The 'use GRI' flag is set to N for the following reports, which causes an error when they are run.  Have checked maidata1 and it is an issue with the script itself.
-- 
------------------------------------------------------------------

UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI3946'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5065'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5200'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5205'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5210'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5215'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5220'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5225'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5235'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI5240'
/
UPDATE hig_modules
SET hmo_use_gri = 'Y'
WHERE hmo_module = 'MAI9020'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Extra financial years data
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 715810  Exor Corporation Ltd
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 107330
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (ROB MAY)
-- Populate additional FINANCIAL_YEARS data, up to the year 2015, so that exor consultants no longer have to do this manually.
-- 
------------------------------------------------------------------

DECLARE
  
  l_fyr_id           financial_years.fyr_id%TYPE;
  l_start_date       financial_years.fyr_start_date%TYPE;
  l_end_date         financial_years.fyr_end_date%TYPE;
  l_terminating_date financial_years.fyr_id%TYPE := '2015';
  
BEGIN
  
  SELECT fyr_id
        ,fyr_start_date
        ,fyr_end_date
  INTO   l_fyr_id
        ,l_start_date
        ,l_end_date
  FROM   financial_years
  WHERE  fyr_id = (SELECT MAX(fyr_id)
                   FROM financial_years);
  
  /* Check if financial year is in the format "2XXX" and existing maximum financial year pre-dates 2015 */   
    
  IF SUBSTR(l_fyr_id,1,1) = 2 
  AND length(l_fyr_id) = 4
  AND  l_fyr_id < l_terminating_date THEN
     LOOP     
  
       l_start_date := add_months(l_start_date,12);
       l_end_date   := add_months(l_end_date,12);
       l_fyr_id     := l_fyr_id + 1;
    
       INSERT INTO financial_years 
                   (fyr_id
                   ,fyr_start_date
                   ,fyr_end_date)
       VALUES (l_fyr_id
             ,l_start_date
             ,l_end_date);
    
       EXIT WHEN l_fyr_id = l_terminating_date; -- '2015'; 
     END LOOP;
  END IF;
  
END;

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Remove DOC_GATE_SYNS record
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 102117
-- 
-- TASK DETAILS
-- Unable to associate documents with a defect thru the Defects form (MAI3808).
-- 
-- 
-- 
-- DEVELOPMENT COMMENTS (GRAEME JOHNSON)
-- When creating a doc_assoc from MAI3808 the incorrect table name is being identified for the association.
-- This is due to an entry in DOC_GATE_SYNS which is now removed.
-- 
------------------------------------------------------------------
delete from doc_gate_syns
where dgs_dgt_table_name = 'DEF_REP_TREAT'
and dgs_table_syn = 'DEFECTS'
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT AUTH_OWN now a  option
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (GRAEME JOHNSON)
-- Product option can now be catered for as a user option
-- 
------------------------------------------------------------------
update hig_option_list
set hol_user_option = 'Y'
where hol_id = 'AUTH_OWN'
/
commit
/
------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

