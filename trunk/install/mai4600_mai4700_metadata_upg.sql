------------------------------------------------------------------
-- mai4600_mai4700_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4600_mai4700_metadata_upg.sql-arc   1.0   Dec 16 2013 08:46:20   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4600_mai4700_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Dec 16 2013 08:46:20  $
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

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

