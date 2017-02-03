--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_4500_fix20.sql-arc   1.0   Feb 03 2017 11:03:34   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_4500_fix20.sql  $
--       Date into PVCS   : $Date:   Feb 03 2017 11:03:34  $
--       Date fetched Out : $Modtime:   Feb 04 2016 10:24:48  $
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
define logfile1='mai_4500_fix20_1_&log_extension'
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
-- Views
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT Creating view v_work_order_status.vw
SET TERM OFF
--
SET FEEDBACK ON
start v_work_order_status.vw
SET FEEDBACK OFF

--
----------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4500_fix20.sql 
--
SET FEEDBACK ON
start log_mai_4500_fix20.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--