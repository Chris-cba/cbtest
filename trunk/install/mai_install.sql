-- SCCS ID Keyword, do not remove
define sccsid = '"$Header:   //vm_latest/archives/mai/install/mai_install.sql-arc   2.10   Aug 27 2009 12:02:52   malexander  $"'

REM Copyright (c) Exor Corporation Ltd, 2008

set echo off
set linesize 120
set heading off
set feedback off

--
-- Grab date/time to append to log file names this is standard to all upgrade/install scripts
--
undefine log_extension
col      log_extension new_value log_extension noprint
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
define logfile1='mai_install_1_&log_extension'
define logfile2='mai_install_2_&log_extension'
spool &logfile1
--
---------------------------------------------------------------------------------------------------
--                    ********************* ACCEPT PARAMETERS *************************
set term off
undefine p_admin_type
col      p_admin_type  new_value p_admin_type noprint
set term on

prompt   List of Admin Type Codes
prompt   ========================
select   nat_admin_type
        ,nat_descr
from     nm_au_types
order by 1
/
prompt
accept   p_admin_type    prompt "Enter the Admin Type Code to associate with Inventory Types: "
set term off
select upper('&p_admin_type') p_admin_type
from dual
/
set term on

DECLARE
  v_dummy VARCHAR2(1) := Null;

  CURSOR c_chk IS
  SELECT 'x'
  FROM   nm_au_types
  WHERE  nat_admin_type = '&p_admin_type';

BEGIN

  OPEN c_chk;
  FETCh c_chk INTO v_dummy;
  CLOSE c_chk;
  IF v_dummy IS NULL THEN
       RAISE_APPLICATION_ERROR(-20000,'Install terminated - invalid parameter value');
  END IF;

END;
/
WHENEVER SQLERROR CONTINUE
--
---------------------------------------------------------------------------------------------------
--                                     ********** CHECKS  ***********
select 'Installation Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MM:SS') from dual;

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;

SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET');

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
-- Check that MAI has not already been installed
--
BEGIN
   --
   FOR v_recs IN (SELECT hpr_version
                  FROM user_tables
                      ,hig_products
                  WHERE hpr_product = 'MAI'
                  AND   table_name = 'STANDARD_ITEMS') LOOP

               RAISE_APPLICATION_ERROR(-20000,'MAI version '||v_recs.hpr_version||' already installed.');

   END LOOP;
END;
/

--
-- Check that HIG has been installed @ v4.1.0.0, as MAI is dependent this
--
BEGIN
 hig2.product_exists_at_version (p_product        => 'HIG'
                                ,p_VERSION        => '4.1.0.0'
                                );
END;
/

WHENEVER SQLERROR CONTINUE

--
---------------------------------------------------------------------------------------------------
--                        ****************   TABLES  *******************
SET TERM ON
PROMPT Tables...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai.tab' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   INDEXES  *******************
SET TERM ON
PROMPT Indexes...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai.ind' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   CONSTRAINTS  *******************
SET TERM ON
Prompt Constraints...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai.con' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   SEQUENCES  *******************
SET TERM ON
PROMPT Sequences...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai.sqs' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   UKP TABLES  *******************
SET TERM ON
PROMPT UKP Tables...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
	'&terminator'||'ukp.tab' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************  TRANSLATION VIEWS  *******************
SET TERM ON
PROMPT Translation Views...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||
        '&terminator'||'mai_transviews.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
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
--                        ****************   PACKAGE HEADERS  *******************
SET TERM ON
PROMPT Package Headers...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maipkh.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--                        ****************   PACKAGE BODIES  *******************
SET TERM ON
PROMPT Package Bodies...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maipkb.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
---------------------------------------------------------------------------------------------------
--                        ****************   TRIGGERS  *******************
SET TERM ON
PROMPT Triggers...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'trg'||'&terminator'||'maitrgcre.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
---------------------------------------------------------------------------------------------------
--                        ************** NM2 INV LOCATIONS ****************
SET TERM ON
PROMPT NM2 Inv Locations
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai_inv_locations.sql' run_file
from dual
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
--                        ****************   META-DATA  *******************
--
SET TERM ON
Prompt Meta-Data
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata_install.sql' run_file
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

SET DEFINE ON
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
--                        ****************   ROLES  *******************
SET TERM ON
PROMPT Roles...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mairoles.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
PROMPT User Roles...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai_user_roles.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Updating HIG_USER_ROLES...
SET TERM OFF
SET DEFINE ON
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
      hig2.upgrade('MAI','mai_install.sql','Installed','4.1.0.0');
      hig2.upgrade('PMS','mai_install.sql','Installed','4.1.0.0');
END;
/
COMMIT;
SELECT 'Product installed at version '||hpr_product||' ' ||hpr_version details
FROM hig_products
WHERE hpr_product IN ('MAI','PMS');
--
--
spool off
exit
