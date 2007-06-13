-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/mig/mai2220_mai40_upg.sql-arc   2.0   Jun 13 2007 16:46:24   smarshall  $
--       Module Name      : $Workfile:   mai2220_mai40_upg.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:46:24  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:45:44  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version : 1.5
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2004
-----------------------------------------------------------------------------


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
define logfile1='mai2220_mai40_1_&log_extension'
define logfile2='mai2220_mai40_2_&log_extension'
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
--
select 'Upgrade Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MM:SS') from dual;

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;

SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET', 'MAI');
--
---------------------------------------------------------------------------------------------------
--                        ****************   CHECK(S)   *******************
WHENEVER SQLERROR EXIT
SET FEEDBACK OFF

BEGIN
 
     hig2.pre_upgrade_check (p_product               => 'MAI'
                            ,p_new_version           => '4.0'
                            ,p_allowed_old_version_1 => '2.2.2.0'
                            );

END;
/
--
---------------------------------------------------------------------------------------------------
--
--                        ****************   DDL   *******************
WHENEVER SQLERROR CONTINUE
SET FEEDBACK OFF


SET TERM ON
Prompt 3110 DDL Changes...
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'mig'||
        '&terminator'||'mai2220_mai3110_ddl_upg.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

-- no ddl from 3110 to 3120
-- no ddl from 3120 to 3130

SET TERM ON
PROMPT 3200 DDL Changes...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'mig'||
        '&terminator'||'mai3130_mai3200_ddl_upg' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF


SET TERM ON
PROMPT 3210 DDL Changes...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'mig'||
        '&terminator'||'mai3200_mai3210_ddl_upg' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF


-- run in 3210..3211 ddl changes if upgrading from 3210
--
SET TERM ON
PROMPT 3211 DDL Changes...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'mig'||
        '&terminator'||'mai3210_mai3211_ddl_upg.sql' run_file
from dual;
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

--
-- main set of ddl changes
--
SET TERM OFF
PROMPT 4000 DDL Changes...
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai3210_mai40_ddl_upg' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

-- check that 3 key tables in MAI have the correct columns/column orders
--
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'check_mai_table_columns.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF


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
--
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

-- drop the inv_copy package as it is superfluous
DROP PACKAGE inv_copy
/
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
---------------------------------------------------------------------------------------------------
--                        ****************   META-DATA  *******************
--


SET TERM ON
PROMPT maidata1 Metadata...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata1.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

SET TERM ON
PROMPT maidata2 Metadata...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata2.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

SET TERM ON
PROMPT maidata3 Metadata...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata3.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

SET TERM ON
PROMPT Not Running maidata4 Metadata...
PROMPT maidata5 Metadata...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata5.sql' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF


SET TERM ON
PROMPT 3200 Metadata...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'mig'||
        '&terminator'||'mai3130_mai3200_metadata_upg' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

--work around for Hig user options v USER_OPTIONS domain
--recreate the domain, then drop it after the metadata has been run in

INSERT INTO HIG_DOMAINS 
( HDO_DOMAIN, HDO_PRODUCT, HDO_TITLE,HDO_CODE_LENGTH ) 
select
'USER_OPTIONS', 'MAI', 'USER OPTIONS', 10
from dual
where not exists
(select 'z' from hig_domains 
where hdo_domain='USER_OPTIONS');


SET TERM ON
PROMPT 3210 Metadata...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'mig'||
        '&terminator'||'mai3200_mai3210_metadata_upg' run_file
FROM dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF


UPDATE  hig_option_list
SET hol_user_option='Y'
WHERE hol_id IN ('DEFSCHTYPL','DEFSCHTYPD','DEFSCHTYPU')
/

delete from hig_codes where hco_domain = 'USER_OPTIONS'
/
delete from hig_domains where hdo_domain = 'USER_OPTIONS'
/


SET TERM ON
PROMPT 4000 Metadata...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai3210_mai40_metadata_upg' run_file
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
--                        ****************   Version 2 Mai inventory views  *******************
SET TERM ON
PROMPT V2 Views ...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'utl'||'&terminator'||'inviews.sql' run_file
from dual
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
      hig2.upgrade('MAI','mai2220_mai40.sql','Upgraded from 2.2.2.0 to 4.0','4.0');
      hig2.upgrade('PMS','mai2220_mai40.sql','Upgraded from 2.2.2.0 to 4.0','4.0');
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
