REM Copyright 2013 Bentley Systems Incorporated. All rights reserved.
REM @(#)$Header:   //vm_latest/archives/mai/install/mai3100_mai3110_upg.sql-arc   2.1   Jul 01 2013 16:02:14   James.Wadsworth  $


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
define logfile1='mai3100_mai3110_1_&log_extension'
define logfile2='mai3100_mai3110_2_&log_extension'
spool &logfile1
--
---------------------------------------------------------------------------------------------------
--
select 'Upgrade Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MM:SS') from dual;

SELECT 'Upgrade Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;

SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET', 'MAI','PMS');


--
---------------------------------------------------------------------------------------------------
--                        ****************   CHECK(S)   *******************
WHENEVER SQLERROR EXIT
SET FEEDBACK OFF

BEGIN

     hig2.pre_upgrade_check (p_product               => 'MAI'
                            ,p_new_version           => '3.1.1.0'
                            ,p_allowed_old_version_1 => '3.1.0.0'
                            );

END;
/
--
---------------------------------------------------------------------------------------------------
--                        **************** DDL *******************
WHENEVER SQLERROR CONTINUE
SET FEEDBACK OFF

SET TERM ON
Prompt DDL Changes...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai3100_mai3110_ddl_upg.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   PACKAGES  *******************
SET TERM ON
Prompt Package Headers...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maipkh.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Package Bodies...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maipkb.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   VIEWS  *******************
SET TERM ON
PROMPT Views...
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||
        '&terminator'||'maiviews.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   TRIGGERS   *******************
SET TERM ON
Prompt Triggers...
SET TERM OFF
set define on
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'maitrgcre.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Audit Triggers...
SET TERM OFF
set define on
SELECT '&exor_base'||'nm3'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'who_trg.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   META-DATA   *******************
SET TERM ON
Prompt Meta-Data...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai3100_mai3110_metadata_upg.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   COMPILE SCHEMA   *******************
SET TERM ON
Prompt Creating Compiling Schema Script...
SET TERM OFF
SPOOL OFF

SET define ON
SELECT '&exor_base'||'nm3'||'&terminator'||'admin'||
'&terminator'||'utl'||'&terminator'||'compile_schema.sql' run_file
FROM dual
/
START '&run_file'

spool &logfile2

START compile_all.sql
--
---------------------------------------------------------------------------------------------------
--                        ****************   CONTEXT   *******************
--The compile_all will have reset the user context so we must reinitialise it
--
SET FEEDBACK OFF

SET TERM ON
PROMPT Reinitialising Context...
SET TERM OFF
BEGIN
  nm3context.initialise_context;
  nm3user.instantiate_user;
END;
/
--
---------------------------------------------------------------------------------------------------
--                        ****************   SYNONYMS   *******************
SET TERM ON
Prompt Creating Synonyms That Do Not Exist...
SET TERM OFF
EXECUTE nm3ddl.refresh_all_synonyms;
--
---------------------------------------------------------------------------------------------------
--                        ****************   ROLES   *******************
SET TERM ON
Prompt Updating HIG_USER_ROLES...
SET TERM OFF
set define on
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'hig_user_roles.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   VERSION NUMBER   *******************
SET TERM ON
Prompt Setting The Version Number...
SET TERM OFF
BEGIN
      hig2.upgrade('MAI','mai3100_mai3110_upg.sql','Upgrade from 3.1.0.0 to 3.1.1.0','3.1.1.0');
      hig2.upgrade('PMS','mai3100_mai3110_upg.sql','Upgrade from 3.1.0.0 to 3.1.1.0','3.1.1.0');      
END;
/
COMMIT;
--
--
--
SELECT 'Product updated to version '||hpr_product||' ' ||hpr_version details
FROM hig_products
WHERE hpr_product IN ('MAI','PMS');
--
COMMIT;

spool off
exit

