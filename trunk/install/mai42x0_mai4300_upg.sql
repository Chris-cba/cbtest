--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai42x0_mai4300_upg.sql-arc   3.4   Jul 01 2013 16:03:28   James.Wadsworth  $
--       Module Name      : $Workfile:   mai42x0_mai4300_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:03:28  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:36  $
--       Version          : $Revision:   3.4  $
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
undefine upg_4200_to_4300
undefine upg_4210_to_4300
undefine log_extension
undefine logfile1
undefine logfile2
col      upg_4200_to_4300  new_value upg_4200_to_4300 noprint
col      upg_4210_to_4300  new_value upg_4210_to_4300 noprint	
col         log_extension new_value log_extension noprint
col      logfile1          new_value logfile1         noprint
col      logfile2          new_value logfile2         noprint
--       
-------------------------------------------------------------------------
--
set term off

SELECT 'Y' upg_4200_to_4300
FROM hig_products WHERE hpr_product ='MAI' AND hpr_version = '4.2.0.0'
UNION
SELECT 'N' upg_4200_to_4300
FROM hig_products WHERE hpr_product ='MAI' AND hpr_version != '4.2.0.0'
/
SELECT 'Y' upg_4210_to_4300
FROM hig_products WHERE hpr_product ='MAI' AND hpr_version IN ('4.2.0.0','4.2.1.0')
UNION
SELECT 'N' upg_4210_to_4300
FROM hig_products WHERE hpr_product ='MAI' AND hpr_version NOT IN ('4.2.0.0','4.2.1.0')
/
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
SELECT 'mai'||replace(hpr_version,'.',Null)||'_mai4300_1_&log_extension' logfile1
FROM hig_products WHERE hpr_product = 'MAI' 
/
SELECT 'mai'||replace(hpr_version,'.',Null)||'_mai4300_2_&log_extension' logfile2
FROM hig_products WHERE hpr_product = 'MAI' 
/

set term on
---------------------------------------------------------------------------------------------------
--
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
                          ,p_new_version           => '4.3.0.0'
                          ,p_allowed_old_version_1 => '4.2.0.0'
                          ,p_allowed_old_version_2 => '4.2.1.0'
                          );

 hig2.product_exists_at_version (p_product        => 'HIG'
                                ,p_VERSION        => '4.3.0.0'
                                );

END;
/

WHENEVER SQLERROR CONTINUE
--
---------------------------------------------------------------------------------------------------
--                        **************** DROP POLICIES *******************
--
-- drop any policies that could be effected by table changes
-- ensure that later on - after a compile schema these policies are re-created
SET TERM ON
PROMPT Dropping Policies...
SET TERM OFF
SET DEFINE ON
SET VERIFY OFF
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'ctx'||'&terminator'||'drop_mai_policy' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   DDL   *******************
SET TERM ON
PROMPT 4.2.0.0 to 4.2.1.0 DDL Changes (if required)...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4200_mai4210_ddl_upg.sql' run_file
FROM dual
WHERE '&upg_4200_to_4300' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&upg_4200_to_4300' = 'N'
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
----
--
SET TERM ON
PROMPT 4.2.1.0 to 4.3.0.0 DDL Changes ...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4210_mai4300_ddl_upg.sql' run_file
FROM dual
WHERE '&upg_4210_to_4300' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&upg_4210_to_4300' = 'N'
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--               ****************   RE-RUN CONSTRAINTS   *******************
--
-- not for an upgrade
--
--
---------------------------------------------------------------------------------------------------
--               ****************   RE-RUN INDEXES   *******************
--
-- not for an upgrade
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
SET TERM ON
PROMPT Triggers...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'trg'||'&terminator'||'maitrgcre.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
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
--                        *****************   MAISEC  *********************
SET TERM ON
prompt MAISEC...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'ctx'||'&terminator'||'maisec.pkh' run_file
from dual
/
SET FEEDBACK ON
start '&&run_file'
SET FEEDBACK OFF
--
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'ctx'||'&terminator'||'maisec.pkw' run_file
from dual
/
SET FEEDBACK ON
start '&&run_file'
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
alter view network_node compile;
--
alter synonym road_seg_membs_partial compile;
--
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
--                        ****************   POLICIES  ********************
SET TERM ON
prompt MAI Policies...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'ctx'||'&terminator'||'mai_policy' run_file
from dual
/
SET FEEDBACK ON
start '&&run_file'
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                  ****************   METADATA  *******************
SET TERM ON
PROMPT Metadata Changes...




SET TERM ON
PROMPT 4.2.0.0 to 4.2.1.0 Metadata Changes (if required)...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4200_mai4210_metadata_upg.sql' run_file
FROM dual
WHERE '&upg_4200_to_4300' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&upg_4200_to_4300' = 'N'
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
----
--
SET TERM ON
PROMPT 4.2.1.0 to 4.3.0.0 Metadata Changes ...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4210_mai4300_metadata_upg.sql' run_file
FROM dual
WHERE '&upg_4210_to_4300' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&upg_4210_to_4300' = 'N'
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
      hig2.upgrade('MAI','mai42x0_mai4300_upg.sql','Upgrade from 4.2.0.0/4.2.1.0 to 4.3.0.0','4.3.0.0');
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
