--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_4500_fix19.sql-arc   1.0   Feb 03 2017 10:30:48   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_4500_fix19.sql  $
--       Date into PVCS   : $Date:   Feb 03 2017 10:30:48  $
--       Date fetched Out : $Modtime:   Jan 27 2016 09:04:14  $
--       PVCS Version     : $Revision:   1.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2012
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
define logfile1='mai_4500_fix19_1_&log_extension'
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
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.5.0.0'
                                 );

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
DECLARE
  columns_exist EXCEPTION;
  PRAGMA exception_init( columns_exist, -1430);
BEGIN
  EXECUTE IMMEDIATE
  'ALTER TABLE contracts
   ADD CON_BREAKDOWN VARCHAR2(1)';
EXCEPTION
  WHEN columns_exist THEN
    NULL;
END;
/
--
SET TERM ON 
PROMPT Create MAI_CONTRACT_BREAKDOWN table
SET TERM OFF

DECLARE
  object_exists EXCEPTION;
  PRAGMA exception_init( object_exists, -955);
BEGIN
  EXECUTE IMMEDIATE
  'CREATE TABLE MAI_CONTRACT_BREAKDOWN
   (
   CBRR_CON_CODE                       VARCHAR2(10) 
  ,CBRR_STA_ITEM_CODE                  VARCHAR2(10) 
  ,CBRR_VALUE1                         NUMBER(10,2) 
  ,CBRR_VALUE2                         NUMBER(10,2) 
  ,CBRR_VALUE3                         NUMBER(10,2) 
  ,CBRR_VALUE4                         NUMBER(10,2) 
  ,CBRR_VALUE5                         NUMBER(10,2) 
  ,CBRR_VALUE6                         NUMBER(10,2) 
  ,CBRR_VALUE7                         NUMBER(10,2) 
  ,CBRR_VALUE8                         NUMBER(10,2) 
  ,CBRR_VALUE9                         NUMBER(10,2) 
  ,CBRR_VALUE10                        NUMBER(10,2) 
  ,CBRR_ERROR                          VARCHAR2(4000) 
   )';
EXCEPTION
  WHEN object_exists THEN
    NULL;
END;
/
--
DECLARE
  object_exists EXCEPTION;
  PRAGMA exception_init( object_exists, -2260);
BEGIN
  EXECUTE IMMEDIATE
  'ALTER TABLE MAI_CONTRACT_BREAKDOWN
   ADD (CONSTRAINT CBRR_PK PRIMARY KEY 
    (CBRR_CON_CODE,CBRR_STA_ITEM_CODE))';
EXCEPTION
  WHEN object_exists THEN
    NULL;
END;
/

--
--------------------------------------------------------------------------------
-- HIG_DOMAINS
--------------------------------------------------------------------------------
--
SET TERM ON
PROMPT hig_domains
SET TERM OFF

INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'BREAKDOWN_HEADINGS'
       ,'MAI'
       ,'MAI3880 Breakdown Column_Headings'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'BREAKDOWN_HEADINGS');
--
INSERT INTO HIG_CODES
       (HCO_DOMAIN
       ,HCO_CODE
       ,HCO_MEANING
       ,HCO_SYSTEM
       ,HCO_SEQ
       ,HCO_START_DATE
       ,HCO_END_DATE
       )
SELECT 
        'BREAKDOWN_HEADINGS'
       ,'VALUE 1'
       ,'Update before using breakdown'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'BREAKDOWN_HEADINGS'
                    AND  HCO_CODE = 'VALUE 1');
--
--------------------------------------------------------------------------------
-- Synonyms
--------------------------------------------------------------------------------
--
SET FEEDBACK ON
BEGIN
  nm3ddl.refresh_all_synonyms;
END;
/
--
--
----------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4500_fix19.sql 
--
SET FEEDBACK ON
start log_mai_4500_fix19.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--