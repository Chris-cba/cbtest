REM Copyright 2013 Bentley Systems Incorporated. All rights reserved.
REM @(#)$Header:   //vm_latest/archives/mai/mig/mai_mig.sql-arc   2.1   Jul 01 2013 16:00:06   James.Wadsworth  $

set echo off
set linesize 120
set heading off
set feedback off


--
-- Grab date/time to append to log file names this is standard to all upgrade/install scripts
--
undefine log_extension
col         log_extension new_value log_extension noprint
set term off
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
set term on

--
---------------------------------------------------------------------------------------------------
--
--
-- Spool to Logfile
--
define logfile='mai_mig1_&log_extension'
spool &logfile
--
---------------------------------------------------------------------------------------------------
--
select 'Migration Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MM:SS') from dual;

SELECT 'Migration Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;

SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET', 'MAI','PMS');
--
---------------------------------------------------------------------------------------------------
--
WHENEVER SQLERROR EXIT
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   CHECKS  *******************
SET TERM ON
PROMPT Pre-Migration Checks...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'mig'||'&terminator'||'mai_checks.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   DDL CHANGES   *******************
WHENEVER SQLERROR CONTINUE
SET TERM ON
PROMPT DDL Changes...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'mig'||'&terminator'||'mai_ddl.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   SEQUENCES   *******************
SET TERM ON
PROMPT Re-Creating Sequences...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'mig'||'&terminator'||'mai_sequences.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   TIDY DATA   *******************
SET TERM ON
PROMPT Tidying Data...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'mig'||'&terminator'||'mai_tidy_data.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

--
---------------------------------------------------------------------------------------------------
--
spool off
exit

