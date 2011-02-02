--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix3.sql-arc   3.0   Feb 02 2011 16:17:40   mike.alexander  $
--       Module Name      : $Workfile:   mai_4300_fix3.sql  $
--       Date into PVCS   : $Date:   Feb 02 2011 16:17:40  $
--       Date fetched Out : $Modtime:   Feb 02 2011 16:17:14  $
--       PVCS Version     : $Revision:   3.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2011
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
define logfile1='mai_4300_fix3_1_&log_extension'
spool &logfile1
--
--------------------------------------------------------------------------------
--
select 'Fix Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MM:SS') from dual;

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
--
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET','MAI');

WHENEVER SQLERROR EXIT

--
-- Check that the user isn't sys or system
--
BEGIN
   --
      IF USER IN ('SYS','SYSTEM')
       THEN
         RAISE_APPLICATION_ERROR(-20000,'You cannot install this product as ' || USER);
      END IF;
END;
/

--
-- Check that MAI has been installed @ v4.3.0.0
--
BEGIN
 hig2.product_exists_at_version (p_product        => 'MAI'
                                ,p_VERSION        => '4.3.0.0'
                                );
END;
/

WHENEVER SQLERROR CONTINUE
--
--
--------------------------------------------------------------------------------
-- Package Bodies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_inspection_api.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai_inspection_api.pkw
SET FEEDBACK OFF
--
SET TERM ON 
PROMPT mai_inspection_loader.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai_inspection_loader.pkw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4300_fix3.sql 
--
SET FEEDBACK ON
start log_mai_4300_fix3.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--