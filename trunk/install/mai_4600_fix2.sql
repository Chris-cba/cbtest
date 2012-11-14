--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4600_fix2.sql-arc   1.2   Nov 14 2012 12:05:38   Rob.Coupe  $
--       Module Name      : $Workfile:   mai_4600_fix2.sql  $
--       Date into PVCS   : $Date:   Nov 14 2012 12:05:38  $
--       Date fetched Out : $Modtime:   Nov 14 2012 12:05:00  $
--       PVCS Version     : $Revision:   1.2  $
--
----------------------------------------------------------------------------
--   Copyright (c) 2012 Bentley Systems Incorporated.
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
define logfile1='mai_4600_fix2_&log_extension'
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
 -- Check that HIG has been installed @ v4.6.0.0
 --
 hig2.product_exists_at_version (p_product        => 'MAI'
                                ,p_VERSION        => '4.6.0.0'
                                );

END;
/
WHENEVER SQLERROR CONTINUE
--
--------------------------------------------------------------------------------
-- Package Headers
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT maiausec.pkh
SET TERM OFF
--
SET FEEDBACK ON
start maiausec.pkh
SET FEEDBACK OFF


--------------------------------------------------------------------------------
-- Package Bodies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT maiausec.pkw
SET TERM OFF
--
SET FEEDBACK ON
start maiausec.pkw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Function
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT get_admin_unit.fnw
SET TERM OFF
--
SET FEEDBACK ON
start get_admin_unit.fnw
SET FEEDBACK OFF
--------------------------------------------------------------------------------
-- Synonyms for package and function
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT Creating synonym for maiausec
SET TERM OFF
--
SET FEEDBACK ON
begin
  nm3ddl.create_synonym_for_object('MAIAUSEC');
end;  
/
SET FEEDBACK OFF
--
SET TERM ON 
PROMPT Creating synonym for get_admin_unit
SET TERM OFF
--
SET FEEDBACK ON
begin
  nm3ddl.create_synonym_for_object('GET_ADMIN_UNIT');
end;  
/
SET FEEDBACK OFF

--------------------------------------------------------------------------------
-- Apply the security policies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT Creating security policies
SET TERM OFF
--
SET FEEDBACK ON
start add_maiausec_policy.sql
SET FEEDBACK OFF

--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4600_fix2.sql 
--
SET FEEDBACK ON
start log_mai_4600_fix2.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--