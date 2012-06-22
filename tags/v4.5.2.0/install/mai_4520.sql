-- PVCS Identifiers :-
--
-- sccsid : $Header:   //vm_latest/archives/mai/install/mai_4520.sql-arc   1.0   Jun 22 2012 09:44:48   Steve.Cooper  $
-- Module Name : $Workfile:   mai_4520.sql  $
-- Date into PVCS : $Date:   Jun 22 2012 09:44:48  $
-- Date fetched Out : $Modtime:   Jun 21 2012 15:51:22  $
-- PVCS Version : $Revision:   1.0  $
--
----------------------------------------------------------------------------
-- Copyright (c) 2012 Bentley Systems Incorporated.
----------------------------------------------------------------------------
--
set echo off
set linesize 120
set heading off
set feedback off
--
-- Grab date/time to append to log file name
--
undefine log_extension
col log_extension new_value log_extension noprint
set term off
select TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
set term on
--
--------------------------------------------------------------------------------
--
--
-- Spool to Logfile
--
define logfile1='mai_4520_&log_extension'
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
-- Check that MAI has been installed @ v4.5.0.0
--
hig2.product_exists_at_version (p_product => 'MAI'
,p_VERSION => '4.5.0.0'
);
END;
/
WHENEVER SQLERROR CONTINUE
--
--
--
----------------------------------------------------------------------------
-- DDL
----------------------------------------------------------------------------
--
SET TERM ON
PROMPT mai_4520_ddl.sql
SET TERM OFF
--
SET FEEDBACK ON
start mai_4520_ddl.sql
SET FEEDBACK OFF
--
--
----------------------------------------------------------------------------
-- Packages
----------------------------------------------------------------------------
--
SET TERM ON
PROMPT pinterface.pkw
SET TERM OFF
--
SET FEEDBACK ON
start pinterface.pkw
SET FEEDBACK OFF
--
SET TERM ON
PROMPT mai.pkh
SET TERM OFF
--
SET FEEDBACK ON
start mai.pkh
SET FEEDBACK OFF
--
SET TERM ON
PROMPT mai.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai.pkw
SET FEEDBACK OFF
--
--
---------------------------------------------------------------------------------------------------
--                        ****************   VERSION NUMBER   *******************
SET TERM ON
Prompt Setting The Version Number...
SET TERM OFF
BEGIN
      hig2.upgrade('MAI','mai4520.sql','Upgrade from 4.5.0.0 to 4.5.2.0','4.5.2.0');
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
