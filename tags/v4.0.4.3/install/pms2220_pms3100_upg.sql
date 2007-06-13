-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/pms2220_pms3100_upg.sql-arc   2.0   Jun 13 2007 16:32:40   smarshall  $
--       Module Name      : $Workfile:   pms2220_pms3100_upg.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:40  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:52  $
--       SCCS Version     : $Revision:   2.0  $
--       based on SCCS Version     : 1.3
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
--
spool pms3090_upg.LOG
--
--get some db info

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ( 'HIG','NET','PMS');

WHENEVER SQLERROR EXIT
begin
   hig2.pre_upgrade_check (p_product               => 'PMS'
                          ,p_new_version           => '3.1.0.0'
                          ,p_allowed_old_version_1 => '2.2.2.0'
                          );
END;
/
WHENEVER SQLERROR CONTINUE
--
---------------------------------------------------------------------------------------------------
--
--            **************** PUT TABLE UPGRADES HERE *******************
--
---------------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------------
--
--             **************** END OF TABLE UPGRADES *******************
--
---------------------------------------------------------------------------------------------------
--
SET define ON
SET feedback OFF
prompt strhier.pkh
SELECT '&exor_base'||'mai'||'&terminator'||'install'||'pms2220_pms3100_metadata_upg.sql' run_file
FROM dual
/
START '&run_file'
--
set define on
set term on
prompt Running hig_user_roles
set term off
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'hig_user_roles' run_file
from dual
/
start '&&run_file'
--
prompt upgrade_the_version_number
DECLARE
   l_product hig_products.hpr_product%TYPE := 'PMS';
BEGIN
   hig2.upgrade(l_product,'pms2220_pms3100_upg.sql','Upgrade from 2.2.2.0 to 3.1.0.0','3.1.0.0');
END;
/
COMMIT;
--
---------------------------------------------------------------------------------------------------
--
SELECT 'Product update to version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ( 'HIG','NET','PMS');
--
EXIT
