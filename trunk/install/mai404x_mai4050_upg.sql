--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai404x_mai4050_upg.sql-arc   3.0   Aug 13 2008 14:41:38   smarshall  $
--       Module Name      : $Workfile:   mai404x_mai4050_upg.sql  $
--       Date into PVCS   : $Date:   Aug 13 2008 14:41:38  $
--       Date fetched Out : $Modtime:   Aug 11 2008 16:45:04  $
--       Version          : $Revision:   3.0  $
--       
-------------------------------------------------------------------------
--
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
--       
-------------------------------------------------------------------------
--
-- work out what scripts are to be ran and what to call our logfile
--
undefine log_extension
undefine four_three_to_five
undefine four_to_four_three
undefine log_extension
undefine logfile1
undefine logfile2
col      four_three_to_five  new_value four_three_to_five  noprint
col      four_to_four_three new_value four_to_four_three noprint
col      log_extension new_value log_extension noprint
col      logfile1 new_value logfile1 noprint
col      logfile2 new_value logfile2 noprint
--       
-------------------------------------------------------------------------
--
set term off

SELECT 'Y' four_to_four_three
FROM hig_products WHERE hpr_product = 'MAI' AND hpr_version = '4.0.4.0'
UNION
SELECT 'N' four_to_four_three
FROM hig_products WHERE hpr_product = 'MAI' AND hpr_version != '4.0.4.0'
/
SELECT 'Y' four_three_to_five
FROM hig_products WHERE hpr_product = 'MAI' AND hpr_version IN ('4.0.4.0','4.0.4.3')
UNION
SELECT 'N' four_three_to_five
FROM hig_products WHERE hpr_product = 'MAI' AND hpr_version NOT IN ('4.0.4.0','4.0.4.3')
/
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
SELECT 'mai'||replace(hpr_version,'.',Null)||'_mai4050_1&log_extension' logfile1
FROM hig_products WHERE hpr_product = 'MAI' 
/
SELECT 'mai'||replace(hpr_version,'.',Null)||'_mai4050_2&log_extension' logfile2
FROM hig_products WHERE hpr_product = 'MAI' 
/

set term on
--       
-------------------------------------------------------------------------
--
spool &logfile1
--       
-------------------------------------------------------------------------
--
SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product = 'ENQ';
---------------------------------------------------------------------------------------------------
--                        ****************   CHECK(S)   *******************
WHENEVER SQLERROR EXIT

DECLARE
 CURSOR c1 IS
 SELECT 'Y'
 FROM   hig_upgrades
 WHERE  hup_product = 'NET'
 AND    remarks = 'NET 4040 FIX 8';
 
 l_dummy VARCHAR2(1);

begin
   hig2.pre_upgrade_check (p_product               => 'MAI'
                          ,p_new_version           => '4.0.5.0'
                          ,p_allowed_old_version_1 => '4.0.4.3'
                          ,p_allowed_old_version_2 => '4.0.4.0'
                          );

  hig2.product_exists_at_version (p_product    => 'NET'
                                 ,p_version    => '4.0.5.0'
                                  );
/*
  hig2.product_exists_at_version (p_product    => 'NSG'
                                 ,p_version    => '4.0.4.5'
                                  );
*/
  
  OPEN c1;
  FETCH c1 INTO l_dummy;
  CLOSE c1;
  
  IF l_dummy IS NULL THEN
     RAISE_APPLICATION_ERROR(-20001,'"Network Manager 4040 Fix 8" must be applied before proceeding - contact exor support for further information');
  END IF;
                                  
END;
/
WHENEVER SQLERROR CONTINUE
--
---------------------------------------------------------------------------------------------------
--                        ****************   DDL   *******************
SET TERM ON
PROMPT 4.0.4.0 to 4.0.4.3. DDL Changes (if required)...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4040_mai4043_ddl_upg.sql' run_file
FROM dual
WHERE '&four_to_four_three' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&four_to_four_three' = 'N'
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
----
--
SET TERM ON
PROMPT 4.0.4.3 to 4.0.5.0. DDL Changes (if required)...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4043_mai4050_ddl_upg.sql' run_file
FROM dual
WHERE '&four_three_to_five' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&four_three_to_five' = 'N'
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--               ****************   RE-RUN INDEXES   *******************
--
-- not this time around
--
--
---------------------------------------------------------------------------------------------------
--               ****************   RE-RUN CONSTRAINTS   *******************
--
-- not this time around
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
--                        **************** MATERIALIZED VIEWS   ****************
--
-- not this time around
--
---------------------------------------------------------------------------------------------------
--                        **************** RE-RUN TRIGGERS   ****************
--
SET TERM ON
Prompt Triggers...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'maitrgcre.sql' run_file
FROM dual
/
SET FEEDBACK ON
start '&&run_file'
SET FEEDBACK OFF

SET TERM ON
PROMPT Who Triggers
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'nm3'||'&terminator'||'admin'||'&terminator'||'trg'||
       '&terminator'||'who_trg.sql' run_file
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




SET TERM ON
PROMPT 4.0.4.0 to 4.0.4.3. Metadata Changes (if required)...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4040_mai4043_metadata_upg.sql' run_file
FROM dual
WHERE '&four_to_four_three' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&four_to_four_three' = 'N'
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
----
--
SET TERM ON
PROMPT 4.0.4.3 to 4.0.5.0. Metadata Changes (if required)...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai4043_mai4050_metadata_upg.sql' run_file
FROM dual
WHERE '&four_three_to_five' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&four_three_to_five' = 'N'
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
      hig2.upgrade('MAI','mai404x_mai4050_upg.sql','Upgrade from 4.0.4.0/4.0.4.3 to 4.0.5.0','4.0.5.0');
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
