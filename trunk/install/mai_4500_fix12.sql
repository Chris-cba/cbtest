--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_4500_fix12.sql-arc   1.0   Sep 22 2015 12:36:22   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_4500_fix12.sql  $
--       Date into PVCS   : $Date:   Sep 22 2015 12:36:22  $
--       Date fetched Out : $Modtime:   Sep 23 2013 11:36:10  $
--       PVCS Version     : $Revision:   1.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2012
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
define logfile1='mai_4500_fix12_1_&log_extension'
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
  -- Check that MAI has been installed @ v4.5.0.0
  --
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.5.0.0'
                                 );

END;
/

WHENEVER SQLERROR CONTINUE
--
--------------------------------------------------------------------------------
-- Product Option
--------------------------------------------------------------------------------
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
/

COMMIT
/

--
--------------------------------------------------------------------------------
-- Package Bodies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT interfaces.pkw
SET TERM OFF
--
SET FEEDBACK ON
start interfaces.pkw
SET FEEDBACK OFF

--
----------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4500_fix12.sql 
--
SET FEEDBACK ON
start log_mai_4500_fix12.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--