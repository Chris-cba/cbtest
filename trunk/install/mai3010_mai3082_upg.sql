--
define sccsid = '$Revision:   2.1  $'
spool mai3082_upg.LOG
--
--get some db info

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
--
SELECT 'Current version of '||hpr_product||' '||hpr_version||DECODE(hpr_product,'MAI',' *',Null)
FROM hig_products
WHERE hpr_key IS NOT NULL;
--
WHENEVER SQLERROR EXIT
begin
   hig2.pre_upgrade_check (p_product               => 'MAI'
                          ,p_new_version           => '3.0.8.2'
                          ,p_allowed_old_version_1 => '3.0.1.0'
                          );
END;
/
WHENEVER SQLERROR CONTINUE
---------------------------------------------------------------------------------------------------
--
--            **************** PUT TABLE UPGRADES HERE *******************
--
---------------------------------------------------------------------------------------------------
--
--
---------------------------------------------------------------------------------------------------
--
--             **************** END OF TABLE UPGRADES *******************
--
---------------------------------------------------------------------------------------------------
--
--
prompt Upgrade the version_number...
DECLARE
   l_product hig_products.hpr_product%TYPE := 'MAI';
BEGIN
   hig2.upgrade(l_product,'mai3010_mai3082_upg.sql','Upgrade from 3.0.1.0 to 3.0.8.2','3.0.8.2');
END;
/
COMMIT;
--
--
SELECT 'Product updated to version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('MAI');
--
EXIT
