--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4043_mai4050_upg.sql-arc   3.1   Jul 01 2013 16:03:08   James.Wadsworth  $
--       Module Name      : $Workfile:   mai4043_mai4050_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:03:08  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:36  $
--       Version          : $Revision:   3.1  $
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
-- Grab date/time to append to log file names this is standard to all upgrade/install scripts
undefine log_extension
col         log_extension new_value log_extension noprint
set term off
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
set term on
---------------------------------------------------------------------------------------------------
-- Spool to Logfile
define logfile1='mai4043_mai4050_1_&log_extension'
define logfile2='mai4043_mai4050_2_&log_extension'
spool &logfile1
--get some db info
SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product = 'MAI';
---------------------------------------------------------------------------------------------------
--                        ****************   CHECK(S)   *******************
WHENEVER SQLERROR EXIT
begin
   hig2.pre_upgrade_check (p_product               => 'MAI'
                          ,p_new_version           => '4.0.5.0'
                          ,p_allowed_old_version_1 => '4.0.4.3'
                          );
END;
/
WHENEVER SQLERROR CONTINUE
--
---------------------------------------------------------------------------------------------------
--                        ****************   DDL   *******************
SET TERM ON
PROMPT DDL Changes...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4043_mai4050_ddl_upg.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--               ****************   RE-RUN INDEXES   *******************
SET TERM ON
PROMPT Re-running Indexes...
PROMPT Ignore errors resulting from index already existing...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai.ind' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--               ****************   RE-RUN CONSTRAINTS   *******************
SET TERM ON
PROMPT Re-running Constraints...
PROMPT Ignore errors resulting from constraint already existing...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai.con' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        **************** VIEWS   ****************
SET TERM ON
PROMPT Views...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'views'||'&terminator'||'maiviews.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        **************** TRIGGERS   ****************
--
--
---------------------------------------------------------------------------------------------------
--                  **************** PACKAGE HEADERS AND BODIES   ****************
--
SET TERM ON
PROMPT Package Headers...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
       '&terminator'||'pck'||'&terminator'||'maipkh.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
PROMPT Package Bodies...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
       '&terminator'||'pck'||'&terminator'||'maipkb.sql' run_file
FROM dual
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
start '&run_file'
spool &logfile2
SET TERM ON
start compile_all.sql
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
---------------------------------------------------------------------------------------------------
--                  ****************   METADATA  *******************
SET TERM ON
PROMPT Metadata Changes...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4043_mai4050_metadata_upg.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
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
SET DEFINE ON
SELECT '&exor_base'||'nm3'||'&terminator'||'install'||
    '&terminator'||'hig_user_roles.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Ensuring all users have HIG_USER role...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'nm3'||'&terminator'||'install'||
    '&terminator'||'users_without_hig_user.sql' run_file
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
      hig2.upgrade('MAI','mai4043_mai4050_upg.sql','Upgrade from 4.0.4.3 to 4.0.5.0','4.0.5.0');
END;
/
COMMIT;
SET HEADING OFF
SELECT 'Product updated to version '||hpr_product||' ' ||hpr_version product_version
FROM hig_products
WHERE hpr_product = 'MAI';
spool off
exit
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************
