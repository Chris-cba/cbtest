-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/mai_4700_fix20.sql-arc   1.0   Jan 30 2017 11:34:38   Upendra.Hukeri  $
--       Module Name      : $Workfile:   mai_4700_fix20.sql  $
--       Date into PVCS   : $Date:   Jan 30 2017 11:34:38  $
--       Date fetched Out : $Modtime:   Jan 30 2017 11:30:14  $
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
define logfile1='mai_4700_fix20_1_&log_extension'
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
		WHERE  hup_product = 'MAI'
		AND    remarks = 'MAI 4700 FIX 19 (Update 1)';
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
	-- 	Check that MAI 4700 FIX 19 (Update 1) has already been applied
	--
	OPEN  c1;
	FETCH c1 INTO l_dummy_c1;
	CLOSE c1;
	--
	IF l_dummy_c1 IS NULL THEN
		RAISE_APPLICATION_ERROR(-20001,'MAI 4700 FIX 19 (Update 1) must be applied before proceeding - contact exor support for further information');
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
--- Script to create new prodcut options for Maintenace Manager Inspection loader eB photo record creation
--- DEFPHOTFSM - Sets if the D records in and RDI/RSI generate a single eB record against which the files in each D record are loaded into or if
-- a each D record has it's own eB record

-- DEFPHOTLM - Supplies the Title prefix for Defect photo

INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       ,HOL_MAX_LENGTH
       )
SELECT 
        'DEFPHOTFSM'
       ,'MAI'
       ,'Defect Photo files per record'
       ,'If set to N files will be loaded as one record per file if set to yes files will be loaded all files in one record max 20 files'
       ,NULL
       ,'VARCHAR2'
       ,'N'
       ,'N'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFPHOTFSM')
/

INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       ,HOL_MAX_LENGTH
       )
SELECT 
        'DEFPHOTLM'
       ,'MAI'
       ,'Defect Photo Title'
       ,'Title for MAI photo records'
       ,NULL
       ,'VARCHAR2'
       ,'N'
       ,'N'
       ,30 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFPHOTLM')
/

----------------------------------------------------------------------------------------
-- HIG_OPTION_VALUES
--
-- select * from nm3_metadata.hig_option_values
-- order by hov_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_option_values
SET TERM OFF

INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFPHOTFSM'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFPHOTFSM')
/

INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFPHOTLM'
       ,'DEFECT BEFORE PHOTO' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFPHOTLM')
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
PROMPT log_mai_4700_fix20.sql 
--
SET FEEDBACK ON
start log_mai_4700_fix20.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--