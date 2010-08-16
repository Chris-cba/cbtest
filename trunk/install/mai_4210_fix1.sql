--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4210_fix1.sql-arc   3.1   Aug 16 2010 10:06:38   Mike.Alexander  $
--       Module Name      : $Workfile:   mai_4210_fix1.sql  $
--       Date into PVCS   : $Date:   Aug 16 2010 10:06:38  $
--       Date fetched Out : $Modtime:   Aug 16 2010 10:06:36  $
--       PVCS Version     : $Revision:   3.1  $
--
--------------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2010
--------------------------------------------------------------------------------
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
define logfile1='mai_4210_fix1_1_&log_extension'
spool &logfile1
--
--------------------------------------------------------------------------------
--
select 'Fix Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MM:SS') from dual;

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
--
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET','MAI');

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

DECLARE
 CURSOR c1 IS
 SELECT 'Y'
 FROM   hig_upgrades
 WHERE  hup_product = 'NET'
 AND    remarks = 'NET 4210 FIX 2';
 
 l_dummy VARCHAR2(1);

begin
  --
  -- Check that HIG/MAI has been installed @ v4.2.1.0
  --

   hig2.product_exists_at_version (p_product        => 'HIG'  
                                  ,p_VERSION        => '4.2.1.0'
                                  );

   hig2.product_exists_at_version (p_product        => 'MAI'
                                  ,p_VERSION        => '4.2.1.0'
                                  );

  OPEN c1;
  FETCH c1 INTO l_dummy;
  CLOSE c1;
  
  IF l_dummy IS NULL THEN
     RAISE_APPLICATION_ERROR(-20001,'"Network Manager 4210 Fix 2" must be applied before proceeding - contact exor support for further information');
  END IF;

end;
/
WHENEVER SQLERROR CONTINUE
--
--
--------------------------------------------------------------------------------
-- Packages
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_inspection_api.pkw 
--
SET FEEDBACK ON
start mai_inspection_api.pkw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_inspection_loader.pkw
--
SET FEEDBACK ON
start mai_inspection_loader.pkw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Views
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT v_work_order_status.vw
--
SET FEEDBACK ON
start v_work_order_status.vw
SET FEEDBACK OFF
--
SET TERM ON 
PROMPT imf_mai_work_orders_all_attribs.vw
--
SET FEEDBACK ON
start imf_mai_work_orders_all_attribs.vw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Compile Schema (not necessary - run manually if required)
--------------------------------------------------------------------------------
--
--SET TERM ON
--Prompt Compiling Schema
--SET TERM OFF
--
--SPOOL OFF
--
--SET DEFINE ON
--SET FEEDBACK ON
--start compile_schema.sql
--SET FEEDBACK OFF
--
-- SPOOL to Logfile
--
--DEFINE logfile='mai_4210_fix1_2_&log_extension'
--SPOOL &logfile
--
--
--SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version details
--FROM v$instance;
--
--
--SELECT 'Current version of '||hpr_product||' ' ||hpr_version details
--FROM hig_products
--WHERE hpr_product IN ('HIG','NET','MAI');
--
--
--START compile_all.sql
--
--------------------------------------------------------------------------------
-- Metadata
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_4210_fix1_metadata_upg.sql 
--
SET FEEDBACK ON
start mai_4210_fix1_metadata_upg.sql
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4210_fix1.sql 
--
SET FEEDBACK ON
start log_mai_4210_fix1.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--