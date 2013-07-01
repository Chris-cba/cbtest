--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix4.sql-arc   3.3   Jul 01 2013 16:01:50   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4300_fix4.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       PVCS Version     : $Revision:   3.3  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
define logfile1='mai_4300_fix4_1_&log_extension'
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

DECLARE
 CURSOR c1 IS
 SELECT DECODE (COUNT(*), 3, 'Y', NULL) FIX_1_TO_3_APPLIED
 FROM  (SELECT 'FIX1'
        FROM   hig_upgrades
        WHERE  hup_product = 'MAI'
        AND    remarks     = 'MAI 4300 FIX 1'
        UNION
        SELECT 'FIX2'
        FROM   hig_upgrades
        WHERE  hup_product = 'MAI'
        AND    remarks     = 'MAI 4300 FIX 2' 
        UNION
        SELECT 'FIX3'
        FROM   hig_upgrades
        WHERE  hup_product = 'MAI'
        AND    remarks     = 'MAI 4300 FIX 3'
       );
 l_dummy VARCHAR2(1);
BEGIN
  --
  -- Check that the user isn't sys or system
  --
  IF USER IN ('SYS','SYSTEM')
  THEN
    RAISE_APPLICATION_ERROR(-20000,'You cannot install this product as ' || USER);
  END IF;

  --
  -- Check that MAI has been installed @ v4.3.0.0
  --
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.3.0.0'
                                 );

 OPEN c1;
 FETCH c1 INTO l_dummy;
 CLOSE c1;

 IF l_dummy IS NULL THEN
   RAISE_APPLICATION_ERROR(-20001,'"Maintenance Manager 4300 Fixes 1, 2 and 3" must be applied before proceeding - contact exor support for further information');
 END IF;

END;
/
WHENEVER SQLERROR CONTINUE
--
--
--------------------------------------------------------------------------------
-- DDL
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_4300_fix4_ddl_upg.sql
SET TERM OFF
--
SET FEEDBACK ON
start mai_4300_fix4_ddl_upg.sql
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Package Bodies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_inspection_api.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai_inspection_api.pkw
SET FEEDBACK OFF
--
--
SET TERM ON 
PROMPT works_func.pkw
SET TERM OFF
--
SET FEEDBACK ON
start works_func.pkw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Views
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_insp_load_batches_v.vw
SET TERM OFF
--
SET FEEDBACK ON
start mai_insp_load_batches_v.vw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Views
--------------------------------------------------------------------------------
--
Begin
nm3ddl.create_synonym_for_object('MAI_INSP_LOAD_BATCHES_V');
End;
/
--
--------------------------------------------------------------------------------
-- Metadata
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_4300_fix4_metadata_upg.sql
SET TERM OFF
--
SET FEEDBACK ON
start mai_4300_fix4_metadata_upg.sql
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4300_fix4.sql 
--
SET FEEDBACK ON
start log_mai_4300_fix4.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--
