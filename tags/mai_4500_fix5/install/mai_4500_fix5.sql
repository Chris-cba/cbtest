--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4500_fix5.sql-arc   3.0   Jun 12 2012 15:49:36   Mike.Alexander  $
--       Module Name      : $Workfile:   mai_4500_fix5.sql  $
--       Date into PVCS   : $Date:   Jun 12 2012 15:49:36  $
--       Date fetched Out : $Modtime:   Jun 12 2012 15:41:52  $
--       PVCS Version     : $Revision:   3.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2012 Bentley Systems Incorporated.
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
define logfile1='mai_4500_fix5_&log_extension'
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
--
--------------------------------------------------------------------------------
-- Package Body
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
--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4500_fix5.sql 
--
SET FEEDBACK ON
start log_mai_4500_fix5.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--