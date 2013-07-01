--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4600_fix8.sql-arc   3.1   Jul 01 2013 16:01:56   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4600_fix8.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:56  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       PVCS Version     : $Revision:   3.1  $
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
define logfile1='mai_4600_fix8_1_&log_extension'
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
  -- Check that MAI has been installed @ v4.6.0.0
  --
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.6.0.0'
                                 );

END;
/

WHENEVER SQLERROR CONTINUE
--
--
--------------------------------------------------------------------------------
-- Product Option
--------------------------------------------------------------------------------
--
INSERT
  INTO hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
SELECT 'PEDDATEATR'
      ,'MAI'
      ,'PEDIF file Date Attributes'
      ,'If set to Y, any date attributes (record type 12) will be exported with a of type "D" and a length of 11 when creating the PEDIF file. If set to N the date attributes will be exported with a type of "S" and a length of 7 as was previously the case before the introduction of this option.'
      ,'Y_OR_N'
      ,'VARCHAR2'
      ,'N'
      ,'N'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM hig_option_list
                    WHERE hol_id = 'PEDDATEATR')
/

INSERT
  INTO hig_option_values
      (hov_id
      ,hov_value)
SELECT 'PEDDATEATR'
      ,'N'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM hig_option_values
                    WHERE hov_id = 'PEDDATEATR')
/

COMMIT
/

--
--------------------------------------------------------------------------------
-- Package Bodies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT pedif.pkw
SET TERM OFF
--
SET FEEDBACK ON
start pedif.pkw
SET FEEDBACK OFF
--
----------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4600_fix8.sql 
--
SET FEEDBACK ON
start log_mai_4600_fix8.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--
