-----------------------------------------------------------------------------
--
--   Pvcs Identifiers :-
--
--       Pvcsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix1.sql-arc   3.2   Jul 01 2013 16:01:48   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4300_fix1.sql  $
--       Date Into Pvcs   : $Date:   Jul 01 2013 16:01:48  $
--       Date Fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       Pvcs Version     : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
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
SET TERM ON
--
--------------------------------------------------------------------------------
--
--
-- Spool to Logfile
--
define logfile1='mai_4300_fix1_1_&log_extension'
define logfile2='mai_4300_fix1_2_&log_extension'
spool &logfile1
--
--------------------------------------------------------------------------------
--
SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
--
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET','MAI');
--
--------------------------------------------------------------------------------
--
WHENEVER SQLERROR EXIT

BEGIN
   --
      IF USER IN ('SYS','SYSTEM')
       THEN
         RAISE_APPLICATION_ERROR(-20000,'You cannot install this product as ' || USER);
      END IF;
END;
/

BEGIN

   hig2.product_exists_at_version (p_product        => 'MAI'
                                  ,p_VERSION        => '4.3.0.0'
                                  );
END;
/
WHENEVER SQLERROR CONTINUE
--
--------------------------------------------------------------------------------
--

SET TERM ON
PROMPT Applying Fix
SET TERM OFF

start navigator_data_fix.sql
/
start interfaces.pkh
/
start interfaces.pkw
/
start mai_budgets.pkh
/
start mai_budgets.pkw
/
start mai_cim_automation.pkw
/
start mai_wo_api.pkw
/
start mai_inspection_loader.pkw
/
start mai_wo_automation.pkh
/
start mai_wo_automation.pkw
/
--
--------------------------------------------------------------------------------
--
SET TERM ON
Prompt Compiling Schema
SET TERM OFF
--
SPOOL OFF
--
SET DEFINE ON
SET FEEDBACK ON
start compile_schema.sql
SET FEEDBACK OFF
--
-- SPOOL to Logfile
--
SPOOL &logfile2
START compile_all.sql

alter view network_node compile;

alter synonym road_seg_membs_partial compile;
--
---------------------------------------------------------------------------------------------------
--                    
SET TERM ON
Prompt Logging the application of the fix...
SET TERM OFF
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'mai_4300_fix1.sql'
              ,p_remarks        => 'MAI 4300 FIX 1'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/

SET TERM ON
Prompt Done
spool off
Prompt Please check log files &logfile1 and &logfile2
exit
--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************
