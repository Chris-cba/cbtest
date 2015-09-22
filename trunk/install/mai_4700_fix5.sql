-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/mai_4700_fix5.sql-arc   1.0   Sep 22 2015 13:07:30   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_4700_fix5.sql  $
--       Date into PVCS   : $Date:   Sep 22 2015 13:07:30  $
--       Date fetched Out : $Modtime:   Nov 07 2014 15:03:38  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2014 Bentley Systems Incorporated. All rights reserved
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
define logfile1='mai_4700_fix5_1_&log_extension'
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
  -- Check that MAI has been installed @ v4.7.0.0
  --
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.7.0.0'
                                 );

END;
/

WHENEVER SQLERROR CONTINUE
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
----------------------------------------------------------------------------------
-- Add MAI_AUTO_WO_RULES column
--------------------------------------------------------------------------------
DECLARE
  col_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(col_exists,-1430);
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE mai_auto_wo_rules 
                       ADD mawr_use_inspection_date VARCHAR2(1)';
EXCEPTION
  WHEN col_exists THEN
    NULL;
  WHEN OTHERS THEN
    RAISE;
END;  
/               
----------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4700_fix5.sql 
--
SET FEEDBACK ON
start log_mai_4700_fix5.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--