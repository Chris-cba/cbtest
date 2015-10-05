--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_4700_fix11.sql-arc   1.0   Oct 05 2015 11:18:56   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_4700_fix11.sql  $
--       Date into PVCS   : $Date:   Oct 05 2015 11:18:56  $
--       Date fetched Out : $Modtime:   Mar 19 2015 10:21:14  $
--       PVCS Version     : $Revision:   1.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2014 Bentley Systems Incorporated.
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
define logfile1='mai_4700_fix11_1_&log_extension'
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
 -- Check that HIG has been installed @ v4.7.0.0
 --
 hig2.product_exists_at_version (p_product        => 'MAI'
                                ,p_VERSION        => '4.7.0.0'
                                );

END;
/
--
WHENEVER SQLERROR CONTINUE

--------------------------------------------------------------------------------
-- HIG_ALERT_TYPE_MAIL_LOOKUP 
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT Inserting into HIG_ALERT_TYPE_MAIL_LOOKUP
SET TERM OFF
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -17
       ,'DEF$'
       ,'Asset Primary Key'
       ,'select  iit_primary_key from nm_inv_items_all where iit_ne_id = :1'
       ,'DEF_IIT_ITEM_ID'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -17);
SET FEEDBACK OFF				   
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -16
       ,'DEF$'
       ,'Inspector'
       ,'select hc.hus_name from hig_users hc,activities_report are where are.are_peo_person_id_actioned = hc.hus_user_id and are.are_report_id=:1'
       ,'def_are_report_id'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -16);
SET FEEDBACK OFF				   
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -15
       ,'DEF$'
       ,'Initiation Type'
       ,'select hc.hco_meaning from hig_codes hc, activities_report are where hc.hco_domain =''INITIATION_TYPE'' and sysdate between nvl( hc.hco_start_date, sysdate ) and nvl( hc.hco_end_date, sysdate ) and hc.hco_code = are.are_initiation_type and are.are_report_id = :1'
       ,'def_are_report_id'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -15);
SET FEEDBACK OFF				   
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -14
       ,'DEF$'
       ,'Asset Type'
       ,'select nt.nit_descr from nm_inv_items_all ni,nm_inv_types_all nt where ni.iit_ne_id = :1 and nt.nit_inv_type=ni.iit_inv_type'
       ,'DEF_IIT_ITEM_ID'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -14);
SET FEEDBACK OFF
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -13
       ,'DEF$'
       ,'Asset Description'
       ,'select iit_descr from nm_inv_items_all  where iit_ne_id = :1'
       ,'DEF_IIT_ITEM_ID'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -13);
SET FEEDBACK OFF
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -12
       ,'WOR$'
       ,'Contractor Contact'
       ,'select ou.oun_contact_name from contracts c , org_units ou where con_id=:1  and ou.oun_org_unit_type = ''CO'' and ou.oun_org_id = c.con_contr_org_id'
       ,'wor_con_id'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -12);
SET FEEDBACK OFF				   
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -11
       ,'WOR$'
       ,'Contractor Name'
       ,'select ou.oun_name from contracts c, org_units ou where con_id =:1 and ou.oun_org_unit_type = ''CO'' and ou.oun_org_id = c.con_contr_org_id'
       ,'wor_con_id'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -11);
SET FEEDBACK OFF
--
SET FEEDBACK ON
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -10
       ,'WOR$'
       ,'Contractor Phone'
       ,'select ou.oun_phone from contracts c,org_units ou where con_id = :1 and ou.oun_org_unit_type=''CO'' and ou.oun_org_id=c.con_contr_org_id'
       ,'wor_con_id'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -10);
SET FEEDBACK OFF

COMMIT;
--
--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4700_fix11.sql 
--
SET FEEDBACK ON
start log_mai_4700_fix11.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
COMMIT;