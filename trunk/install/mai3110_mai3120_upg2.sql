--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3110_mai3120_upg2.sql-arc   2.1   Jul 01 2013 16:02:16   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3110_mai3120_upg2.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:16  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--
--
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
--
-- Grab date/time to append to log file names this is standard to all upgrade/install scripts

undefine log_extension
col         log_extension new_value log_extension noprint
set term off
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
set term on

---------------------------------------------------------------------------------------------------


-- Spool to Logfile

define logfile1='mai3110_mai3120_1_&log_extension'
define logfile2='mai3110_mai3120_2_&log_extension'
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
                          ,p_new_version           => '3.1.2.0'
                          ,p_allowed_old_version_1 => '3.1.1.0'
                          );
END;
/
WHENEVER SQLERROR CONTINUE
--
--
---------------------------------------------------------------------------------------------------
--                        ****************   VERSION NUMBER   *******************
SET TERM ON
Prompt Setting The Version Number...
SET TERM OFF

BEGIN
      hig2.upgrade('MAI','mai3110_mai3120_upg.sql','Upgrade from 3.1.1.0 to 3.1.2.0','3.1.2.0');
END;
/
COMMIT;

SET HEADING OFF
SELECT 'Product updated to version '||hpr_product||' ' ||hpr_version product_version
FROM hig_products
WHERE hpr_product = 'MAI';


spool off
exit
--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

