------------------------------------------------------------------
-- mai4043_mai4050_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4043_mai4050_metadata_upg.sql-arc   3.1   Sep 11 2008 16:59:52   malexander  $
--       Module Name      : $Workfile:   mai4043_mai4050_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Sep 11 2008 16:59:52  $
--       Date fetched Out : $Modtime:   Sep 11 2008 16:48:52  $
--       Version          : $Revision:   3.1  $
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
PROMPT gri_module_params update
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 712161
-- 
-- CUSTOMER
-- Department of Regional Development(NI)
-- 
-- PROBLEM
-- The DRD NI have been trying to use this report and have been unable to. 
--  
--     One of the issues that has been raised with the report is that the user ARMSTRONG is always listed in the header of the report. I have examined the Before Report trigger and I have located the reason for this. One of the cursors in the trigger populateds the field variable C_DATABASE and this is where the username is kdisplayed. The cursor is as folloows :
--  
-- select hus.hus_username,
--        hmo.hmo_title,
--        SYSDATE
-- into   :C_DATABASE, :C_TITLE, :C_DATE
-- from   hig_users hus, hig_modules hmo
-- where  UPPER(hmo.hmo_module) = 'MAI3922'
-- and    ROWNUM = 1;
--  
-- Ideally this really needs to be recoded and replaced with somethinbg more efficient but a quick fix for this would be to add the line "and hus_username=user" so the query would be like :
--  
-- select hus.hus_username,
--            hmo.hmo_title,
--            SYSDATE
-- into   :C_DATABASE, :C_TITLE, :C_DATE
-- from   hig_users hus, hig_modules hmo
-- where  UPPER(hmo.hmo_module) = 'MAI3922'
-- and     hus_username=user
-- and    ROWNUM = 1;
--  
-- The aboive could be changed to :
--  
-- :c_database:=user;
-- :c_date        :=sysdate;
-- select hmo_title,
-- into    :C_TITLE
-- from   hig_modules
-- where hmo_module = 'MAI3922';
--  
-- Please can this be logged and passed to development/maintenance for code change.
-- 
-- 
------------------------------------------------------------------

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MICHAEL ALEXANDER)
-- Update of gri_module_params to set Admin Unit, Road Type and Road ID as mandatory items in the List of Defects Not Yet Instructed report.
-- 
------------------------------------------------------------------
Update gri_module_params
Set    gmp_mandatory = 'Y'
Where  gmp_module = 'MAI3922'
And    gmp_param In ('ADMIN_UNIT','ROAD_TYPE','ROAD_ID')
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Product Option - WOREPORDBY
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 713590
-- 
-- CUSTOMER
-- Dorset County Council
-- 
-- PROBLEM
-- I'm not sure of the best contact to answer this so bear with me.
-- 
-- What is the official sorting order of the Items displayed in the Works Order Template (Actual &Estimate)?
-- 
-- I appreciate there may be a Dorset specific answer to this, in which case
-- - how do I find out?
-- 
-- 
------------------------------------------------------------------

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (JAMES WADSWORTH)
-- Determines which order by clause to use within the Print Works Order (Enhanced) report.
-- 
------------------------------------------------------------------
INSERT INTO HIG_OPTION_LIST 
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       ) 
SELECT 'WOREPORDBY'
      ,'MAI'
      ,'WO (Enhanced) Order By Clause'
      ,'This option determines which order by clause is used within the Print Works Order (Enhanced) report. The reports default order by clause is used when the option is set to Y and when it is set to N the ordering is done by boq_sta_item_code'
      ,''
      ,'VARCHAR2'
      ,'Y'
      ,'Y'
FROM DUAL 
WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST 
                   WHERE HOL_ID = 'WOREPORDBY')
/
INSERT INTO hig_option_values 
SELECT 'WOREPORDBY'
      ,'Y' 
FROM dual 
WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES 
                   WHERE HOV_ID = 'WOREPORDBY')
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Product Option - COMPLEDATE
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (JAMES WADSWORTH)
-- The new option allows the completion date to be before the instructed date.
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
      ,hol_mixed_case) 
SELECT 'COMPLEDATE'
      ,'MAI'
      ,'Completion Date'      
      ,'When the flag is set to ''Y'' the Completion date can be equal to or before the Instructed date. If the '||
       'flag is set to ''N'' the Completion date can be equal to or after the Instructed date.'
      ,NULL
      ,'VARCHAR2'
      ,'Y'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_list
                   WHERE hol_id = 'COMPLEDATE')
/
INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value)
SELECT 'COMPLEDATE'
      ,'Y'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM  hig_option_values
                   WHERE  hov_id = 'COMPLEDATE')
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Product option - ZEROPAD
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED PROBLEM MANAGER LOG#
-- 714051
-- 
-- CUSTOMER
-- Exor Corporation Ltd
-- 
-- PROBLEM
-- The CIM spec document shows the filename format for WO extract files as WO999999.XXX
-- 
-- Where 999999 is a sequential number.   Currently, the file as extract is called (e.g.) WO123.CON whereas the spec suggests the numeric element of the filename should be zero-padded to 6 digits (i.e. WO000123.CON)
-- 
-- 1 Create new Y/N product option to enforce padding on file name
-- 
-- 2 If set to `Y' then number part of name is left padded with zero's to 6 digits
-- 
-- 
------------------------------------------------------------------

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (STUART MARSHALL)
-- **** COMMENTS TO BE ADDED BY STUART MARSHALL ****
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
SELECT 'ZEROPAD'
      ,'MAI'
      ,'Zero pad the CIM filenames'      
      ,'his option, when set to Y, means that all filenames used within Interfaces must be padded out with zeros until of the format <filetype><999999>.<concode> ie WO000001.CON.'
      ,NULL
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_option_list
                   WHERE hol_id = 'ZEROPAD')
/
INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value)
SELECT 'ZEROPAD'
      ,'Y'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM  hig_option_values
                   WHERE  hov_id = 'ZEROPAD')
/
------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

