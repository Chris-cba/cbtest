------------------------------------------------------------------
-- mai4050_mai4052_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4050_mai4052_metadata_upg.sql-arc   3.0   Feb 03 2009 17:24:10   malexander  $
--       Module Name      : $Workfile:   mai4050_mai4052_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Feb 03 2009 17:24:10  $
--       Date fetched Out : $Modtime:   Feb 03 2009 17:22:58  $
--       Version          : $Revision:   3.0  $
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

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

