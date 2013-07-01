--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4400_fix3.sql-arc   3.3   Jul 01 2013 16:01:52   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4400_fix3.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       PVCS Version     : $Revision:   3.3  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
--------------------------------------------------------------------------------
--
set echo off
set linesize 120
set heading off
set feedback off
--
-- Grab date/time to append to log file name
--
undefine log_extension
col      log_extension new_value log_extension noprint
set term off
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
set term on
--
--------------------------------------------------------------------------------
--
--
-- Spool to Logfile
--
define logfile1='mai_4400_fix3_1_&log_extension'
spool &logfile1
--
--------------------------------------------------------------------------------
--
select 'Fix Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MI:SS') from dual;

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
--
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET','MAI');

WHENEVER SQLERROR EXIT

BEGIN
  --
  -- Check that the user isn't sys or system
  --
  IF USER IN ('SYS','SYSTEM')
  THEN
    RAISE_APPLICATION_ERROR(-20000,'You cannot install this product as ' || USER);
  END IF;

  --
  -- Check that MAI has been installed @ v4.4.0.0
  --
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.4.0.0'
                                 );

END;
/

-- Check that mai 4400 fix 1 has been applied before proceeeding
Declare
   Cursor c_mai_4400_fix1 Is 
   Select 'Y' 
   From hig_upgrades
   Where remarks = 'MAI 4400 FIX 1';
   --
   l_mai_4400_fix1 Varchar2(1) := 'N';
Begin
   Open c_mai_4400_fix1;
   Fetch c_mai_4400_fix1 Into l_mai_4400_fix1;
   Close c_mai_4400_fix1;
   --
   If Not l_mai_4400_fix1 = 'Y'
   Then
     RAISE_APPLICATION_ERROR(-20000,'This fix is dependent upon Maintenance Manager 4400 FIX 1 being applied. Please apply MAI 4400 FIX 1 before proceeding.');
   End If;
End;
/

WHENEVER SQLERROR CONTINUE
--
--
--------------------------------------------------------------------------------
-- Package Bodies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_wo_api.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai_wo_api.pkw
SET FEEDBACK OFF
--
--
SET TERM ON 
PROMPT mai.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai.pkw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Metadata
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT metadata
SET TERM OFF
--
SET FEEDBACK ON
--
insert into hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
select 'UPDWOTGT'
      ,'MAI'
      ,'Allow update to WO Target Date'      
      ,'If set to Y, the WO Target Date will allow manual update '
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'UPDWOTGT')
/

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'UPDWOTGT'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'UPDWOTGT')
/

commit
/
--
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4400_fix3.sql 
--
SET FEEDBACK ON
start log_mai_4400_fix3.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--
