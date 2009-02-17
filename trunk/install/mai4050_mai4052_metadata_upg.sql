------------------------------------------------------------------
-- mai4050_mai4052_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4050_mai4052_metadata_upg.sql-arc   3.2   Feb 17 2009 17:23:16   malexander  $
--       Module Name      : $Workfile:   mai4050_mai4052_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Feb 17 2009 17:23:16  $
--       Date fetched Out : $Modtime:   Feb 17 2009 17:21:52  $
--       Version          : $Revision:   3.2  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2008

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
PROMPT New Product Option - XTRIFLDS
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (JAMES WADSWORTH)
-- **** COMMENTS TO BE ADDED BY JAMES WADSWORTH ****
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
select 'XTRIFLDS'
      ,'MAI'
      ,'Version of Interface Files'      
      ,'If set to 2-1-3 uses additional fields on the end of the WO and WI files. Otherwise set to NA.'
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'XTRIFLDS')
/
insert into hig_option_values
      (hov_id
      ,hov_value)
select 'XTRIFLDS'
      ,'2-1-3'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'XTRIFLDS')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Prodect Option - WCCOMPLETE
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 717676
-- 
-- CUSTOMER
-- Transport for London
-- 
-- PROBLEM
-- When an order is actioned either manually or via a WC file the associated defect should be completed.
-- 
------------------------------------------------------------------

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (STUART MARSHALL)
-- **** COMMENTS TO BE ADDED BY STUART MARSHALL ****
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
select 'WCCOMPLETE'
      ,'MAI'
      ,'Full WC Complete'      
      ,'WC file will complete repairs and defects appropriately when this option is set to ''Y''.'
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'WCCOMPLETE')
/

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'WCCOMPLETE'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'WCCOMPLETE')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT TMA Interface Changes
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New error and Product Option to Support the TMA Interface changes.
-- 
------------------------------------------------------------------
--nm_errors
INSERT
  INTO nm_errors
SELECT 'MAI'
      ,926
      ,NULL
      ,'No Work Order Lines - cannot locate the Work Order on the GIS'
      ,NULL
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM nm_errors
                    WHERE ner_appl = 'MAI'
                      AND ner_id = 926)
/

--Product Option.
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
SELECT 'SDOWOLNTH'
      ,'WMP'
      ,'SDO Work Order Lines Theme ID'
      ,'Theme ID of the Work Order Lines SDO layer'
      ,null
      ,'NUMBER'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM hig_option_list
                    WHERE hol_id = 'SDOWOLNTH')
/

UPDATE hig_codes
   SET hco_meaning = 'Nothing Registered'
 WHERE hco_domain = 'WOR_REGISTER_STATUS'
   AND hco_code = 'N'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Module Metadata for MAI3801_NET
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Module metadata for new Module MAI3801_NET
-- 
------------------------------------------------------------------
INSERT
  INTO hig_modules
      (hmo_module
      ,hmo_title
      ,hmo_filename
      ,hmo_module_type
      ,hmo_fastpath_invalid
      ,hmo_use_gri
      ,hmo_application
      ,hmo_menu)
VALUES('MAI3801_NET'
      ,'Raise Small Scheme Works Order (GIS)'
      ,'mai3801'
      ,'FMX'
      ,'Y'
      ,'N'
      ,'MAI'
      ,'FORM')
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_modules
                   WHERE hmo_module = 'MAI3801_NET');
/

INSERT
  INTO hig_module_roles
      (hmr_module
      ,hmr_role
      ,hmr_mode)
VALUES('MAI3801_NET'
      ,'MAI_ADMIN'
      ,'NORMAL')
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_module_roles
                   WHERE hmr_module = 'MAI3801_NET'
                     AND hmr_role = 'MAI_ADMIN')
/

INSERT
  INTO hig_module_roles
      (hmr_module
      ,hmr_role
      ,hmr_mode)
VALUES('MAI3801_NET'
      ,'MAI_USER'
      ,'NORMAL')
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_module_roles
                   WHERE hmr_module = 'MAI3801_NET'
                     AND hmr_role = 'MAI_USER')
/

------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

