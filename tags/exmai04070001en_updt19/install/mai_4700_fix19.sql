-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/mai_4700_fix19.sql-arc   1.0   Jul 05 2016 09:33:34   Upendra.Hukeri  $
--       Module Name      : $Workfile:   mai_4700_fix19.sql  $
--       Date into PVCS   : $Date:   Jul 05 2016 09:33:34  $
--       Date fetched Out : $Modtime:   Jul 05 2016 09:32:26  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2016 Bentley Systems Incorporated. All rights reserved
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
define logfile1='mai_4700_fix19_1_&log_extension'
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

DECLARE
	--
	CURSOR c1 is
		SELECT 'Y'
		FROM   hig_upgrades
		WHERE  hup_product = 'NET'
		AND    remarks = 'NET 4700 FIX 42 (Build 1)';
	--
	l_dummy_c1 VARCHAR2(1);
BEGIN
  --
  -- Check that the user isn't sys or system
  --
  IF USER IN ('SYS','SYSTEM')
  THEN
    RAISE_APPLICATION_ERROR(-20000,'You cannot install this product as ' || USER);
  END IF;

  --
  -- Check that MAI has been installed @ v4.7.0.0
  --
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.7.0.0'
                                 );


        --
	-- 	Check that NET 4700 FIX 42 (Build 1) has already been applied
	--
	OPEN  c1;
	FETCH c1 INTO l_dummy_c1;
	CLOSE c1;
	--
	IF l_dummy_c1 IS NULL THEN
		RAISE_APPLICATION_ERROR(-20001,'NET 4700 FIX 42 (Build 1) must be applied before proceeding - contact exor support for further information');
	END IF;
	--

END;
/

WHENEVER SQLERROR CONTINUE
--
--------------------------------------------------------------------------------
-- Tables
--------------------------------------------------------------------------------

SET TERM ON 
PROMPT Alter CONTRACTS table
SET TERM OFF
--
Insert into hig_option_list (Select 'DEFPHOTTEM','MAI','eB Template Id for defects','eB template ID for creating documents for defects.',null,'NUMBER','N','N',2000 From dual 
Where Not Exists (Select 1 From hig_option_list
                  Where hol_id = 'DEFPHOTTEM' ))
/

Insert into hig_option_values (Select 'DEFPHOTTEM',1234 From dual
                               Where Not Exists (Select 1 From hig_option_values 
                                                 Where  hov_id = 'DEFPHOTTEM' ))
/


Insert into hig_option_list (Select 'COMMTEMPLA','MAI','eB Template Id for comments','eB template ID for creating commnets document.',null,'NUMBER','N','N',2000 From dual 
Where Not Exists (Select 1 From hig_option_list
                  Where hol_id = 'COMMTEMPLA' ))
/

Insert into hig_option_values (Select 'COMMTEMPLA',1234 From dual
                               Where Not Exists (Select 1 From hig_option_values 
                                                 Where  hov_id = 'COMMTEMPLA' ))
/

SET TERM ON 
PROMPT mai_inspection_api.pkw
--
SET FEEDBACK ON
start mai_inspection_api.pkw
SET FEEDBACK OFF

--
----------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4700_fix19.sql 
--
SET FEEDBACK ON
start log_mai_4700_fix19.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--