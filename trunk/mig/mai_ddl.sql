REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/mig/mai_ddl.sql-arc   2.2   Apr 29 2009 11:01:24   Ian Turnbull  $

set echo off
set linesize 120
set heading off
set feedback off
--
---------------------------------------------------------------------------------------------------
--                        ****************   DEFECT UPDATES  *******************
SET TERM ON
PROMPT Updating defect inventory fk values
SET TERM OFF

DECLARE
  inv_defects pls_integer;
BEGIN
  SELECT count(*) 
  INTO   inv_defects
  FROM   defects
  WHERE  def_iit_item_id IS NOT NULL;
  
  IF inv_defects > 0 THEN
     
     EXECUTE IMMEDIATE 'CREATE INDEX iit_v2_item_id ON nm_inv_items_all(iit_num_attrib115)';
     
     UPDATE defects
     SET def_iit_item_id = (SELECT iit_ne_id
                            FROM   nm_inv_items_all
                            WHERE  iit_num_attrib115 = def_iit_item_id)
     WHERE def_iit_item_id IS NOT NULL;
     
     EXECUTE IMMEDIATE 'DROP INDEX iit_v2_item_id';
  END IF;
END;
/
--
---------------------------------------------------------------------------------------------------
--                        ****************   UKP  *******************
DECLARE
  l_dummy PLS_INTEGER;

  CURSOR ukp_licenced IS
  SELECT 1
  FROM   hig_products
  WHERE  hpr_product = 'UKP'
  AND    hpr_key IS NOT NULL;
BEGIN
  OPEN ukp_licenced;
  FETCH ukp_licenced INTO l_dummy;
-- UKP may not be licensed, but the data may be there.  So we need to create the table if its not there, 
--or leave it and upgrade it if its not

   IF ukp_licenced%NOTFOUND THEN  --create required tables for UKP
     IF Nm3ddl.does_object_exist(p_object_name => 'UKPMS_PASS_ROAD_RUN_TIME_DETS'
                               ,p_object_type => 'TABLE') THEN
       --ddl upgrades here
       null;
     else
       EXECUTE IMMEDIATE ('CREATE TABLE UKPMS_PASS_ROAD_RUN_TIME_DETS'||
             '(UPRTD_PASS_ID VARCHAR2(20) NOT NULL'||
             ',UPRTD_RSE_HE_ID NUMBER(9) NOT NULL'||
             ',UPRTD_CVI_DVI_USED VARCHAR2(20)'||
             ',UPRTD_RSE_LENGTH NUMBER'||
             ',UPRTD_ON_CW_METHOD VARCHAR2(1)'||
             ',UPRTD_SURVEYED_LENGTH NUMBER'||
             ',UPRTD_ROAD_TYPE VARCHAR2(5)'||
             ',UPRTD_REC_TYPE VARCHAR2(1)'||
             ',UPRTD_START DATE'||
             ',UPRTD_END DATE )');
     end if;
     IF Nm3ddl.does_object_exist(p_object_name => 'UKPMS_AUTOMATIC_PASS'
                               ,p_object_type => 'TABLE') THEN
       --ddl upgrades here
       execute immediate ('update UKPMS_AUTOMATIC_PASS set UAP_RUN_AGAINST_INVENTORY=''Y'' where UAP_RUN_AGAINST_INVENTORY is null');

       execute immediate ('alter table UKPMS_AUTOMATIC_PASS modify UAP_RUN_AGAINST_INVENTORY default ''Y'' not null');
     else
       EXECUTE IMMEDIATE ('CREATE TABLE UKPMS_AUTOMATIC_PASS'||
             '(UAP_AUTO_PASS VARCHAR2(20) NOT NULL'||
             ',UAP_AUTO_PASS_DESC VARCHAR2(80) NOT NULL'||
             ',UAP_RULE_SET VARCHAR2(20) NOT NULL'||
             ',UAP_DEFECT_LEN_MERG_METHOD VARCHAR2(20) NOT NULL'||
             ',UAP_PROJECTION_METHOD VARCHAR2(20) NOT NULL'||
             ',UAP_TYPE_OF_RANKING VARCHAR2(10) NOT NULL'||
             ',UAP_IS_NETWORK_TRENDS_PASS VARCHAR2(3) NOT NULL'||
             ',UAP_SURVEY_DATA_CUT_OFF DATE NOT NULL'||
             ',UAP_TIME_WINDOW_START DATE'||
             ',UAP_TIME_WINDOW_EFFECTIVE DATE NOT NULL'||
             ',UAP_TIME_WINDOW_END DATE'||
             ',UAP_NUMBER_OF_TIME_WINDOWS NUMBER(5,0)'||
             ',UAP_NETWORK_SELECTION_ID NUMBER(8,0) NOT NULL'||
             ',UAP_DVI_CVI_PRECEDENCE VARCHAR2(20) NOT NULL'||
             ',UAP_MERGE_LENGTH NUMBER'||
             ',UAP_CI_COUNT_TOLERANCE_LEN NUMBER'||
             ',UAP_CI_COUNT_TOLERANCE_PER NUMBER(3,0)'||
             ',UAP_PI_ONLY VARCHAR2(1) NOT NULL'||
             ',UAP_RUN_STATUS VARCHAR2(10) NOT NULL'||
             ',UAP_RUN_AGAINST_INVENTORY VARCHAR2(1) DEFAULT ''Y'' NOT NULL)');
     end if;
     IF Nm3ddl.does_object_exist(p_object_name => 'UKPMS_VIEW_DEFINITIONS'
                               ,p_object_type => 'TABLE') THEN
       --ddl upgrades here
       execute immediate ('update UKPMS_VIEW_DEFINITIONS set UVD_XSP_TYPE=''F'' where UVD_XSP_TYPE is null');

       execute immediate ('alter table UKPMS_VIEW_DEFINITIONS modify UVD_XSP_TYPE default ''F'' not null');
     else
       EXECUTE IMMEDIATE ('CREATE TABLE UKPMS_VIEW_DEFINITIONS'||
            '(UVD_INV_CODE VARCHAR2(10) NOT NULL'||
             ',UVD_SYS_FLAG VARCHAR2(1) NOT NULL'||
             ',UVD_VIEW_NAME VARCHAR2(30) NOT NULL'||
             ',UVD_FEATURE_OR_SURVEY VARCHAR2(1) NOT NULL'||
             ',UVD_DESCR VARCHAR2(200)'||
             ',UVD_UKPMS_CODE VARCHAR2(15) NOT NULL'||
             ',UVD_RP20_META_FEATURE_CODE VARCHAR2(2)'||
             ',UVD_XSP_METHOD_IN_USE VARCHAR2(1)'||
             ',UVD_XSP_TYPE VARCHAR2(1) DEFAULT ''F'' NOT NULL)');
     end if;
     IF Nm3ddl.does_object_exist(p_object_name => 'UKPMS_XSP_REVERSAL'
                               ,p_object_type => 'TABLE') THEN
       --ddl upgrades here
       null;
     else
       EXECUTE IMMEDIATE ('CREATE TABLE UKPMS_XSP_REVERSAL'||
            '(UXR_NORMAL_XSP VARCHAR2(4) NOT NULL'||
             ',UXR_REVERSED_XSP VARCHAR2(4) NOT NULL)');
     end if;
  END IF;
  CLOSE ukp_licenced;
END;
/
  
--
---------------------------------------------------------------------------------------------------
--                        ****************   PERFORMANCE  *******************
SET TERM ON
PROMPT Optmizing Performance
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'utl'||'&terminator'||'set_tables_noparallel.sql' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
---------------------------------------------------------------------------------------------------
--

