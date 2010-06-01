-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/maidata5.sql-arc   2.7   Jun 01 2010 12:03:02   malexander  $
--       Module Name      : $Workfile:   maidata5.sql  $
--       Date into PVCS   : $Date:   Jun 01 2010 12:03:02  $
--       Date fetched Out : $Modtime:   Jun 01 2010 11:55:02  $
--       Version          : $Revision:   2.7  $
--       Table Owner      : MAI_METADATA
--       Generation Date  : 01-JUN-2010 11:55
--
--   Product metadata script
--   As at Release 4.2.1.0
--
--   Copyright (c) exor corporation ltd, 2010
--
--   TABLES PROCESSED
--   ================
--   FINANCIAL_YEARS
--   HHINV_RUN_LOG
--   JOB_SIZES
--   STANDARD_ITEM_SECTIONS
--   STANDARD_ITEM_SUB_SECTIONS
--   VAT_RATES
--   DOC_TEMPLATE_GATEWAYS
--   DOC_TEMPLATE_COLUMNS
--   WO_AUDIT_COLUMNS
--   HIG_HD_MODULES
--   HIG_HD_MOD_USES
--   HIG_HD_LOOKUP_JOIN_DEFS
--   HIG_HD_LOOKUP_JOIN_COLS
--   HIG_HD_SELECTED_COLS
--   HIG_HD_JOIN_DEFS
--   HIG_HD_TABLE_JOIN_COLS
--
-----------------------------------------------------------------------------


set define off;
set feedback off;

---------------------------------
-- START OF GENERATED METADATA --
---------------------------------


----------------------------------------------------------------------------------------
-- FINANCIAL_YEARS
--
-- select * from mai_metadata.financial_years
-- order by fyr_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT financial_years
SET TERM OFF

INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1991'
       ,to_date('19910401000000','YYYYMMDDHH24MISS')
       ,to_date('19920331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1991');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1992'
       ,to_date('19920401000000','YYYYMMDDHH24MISS')
       ,to_date('19930331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1992');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1993'
       ,to_date('19930401000000','YYYYMMDDHH24MISS')
       ,to_date('19940331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1993');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1994'
       ,to_date('19940401000000','YYYYMMDDHH24MISS')
       ,to_date('19950331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1994');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1995'
       ,to_date('19950401000000','YYYYMMDDHH24MISS')
       ,to_date('19960331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1995');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1996'
       ,to_date('19960401000000','YYYYMMDDHH24MISS')
       ,to_date('19970331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1996');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1997'
       ,to_date('19970401000000','YYYYMMDDHH24MISS')
       ,to_date('19980331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1997');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1998'
       ,to_date('19980401000000','YYYYMMDDHH24MISS')
       ,to_date('19990331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1998');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '1999'
       ,to_date('19990401000000','YYYYMMDDHH24MISS')
       ,to_date('20000331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '1999');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2000'
       ,to_date('20000401000000','YYYYMMDDHH24MISS')
       ,to_date('20010331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2000');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2001'
       ,to_date('20010401000000','YYYYMMDDHH24MISS')
       ,to_date('20020331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2001');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2002'
       ,to_date('20020401000000','YYYYMMDDHH24MISS')
       ,to_date('20030331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2002');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2003'
       ,to_date('20030401000000','YYYYMMDDHH24MISS')
       ,to_date('20040331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2003');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2004'
       ,to_date('20040401000000','YYYYMMDDHH24MISS')
       ,to_date('20050331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2004');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2005'
       ,to_date('20050401000000','YYYYMMDDHH24MISS')
       ,to_date('20060331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2005');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2006'
       ,to_date('20060401000000','YYYYMMDDHH24MISS')
       ,to_date('20070331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2006');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2007'
       ,to_date('20070401000000','YYYYMMDDHH24MISS')
       ,to_date('20080331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2007');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2008'
       ,to_date('20080401000000','YYYYMMDDHH24MISS')
       ,to_date('20090331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2008');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2009'
       ,to_date('20090401000000','YYYYMMDDHH24MISS')
       ,to_date('20100331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2009');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2010'
       ,to_date('20100401000000','YYYYMMDDHH24MISS')
       ,to_date('20110331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2010');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2011'
       ,to_date('20110401000000','YYYYMMDDHH24MISS')
       ,to_date('20120331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2011');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2012'
       ,to_date('20120401000000','YYYYMMDDHH24MISS')
       ,to_date('20130331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2012');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2013'
       ,to_date('20130401000000','YYYYMMDDHH24MISS')
       ,to_date('20140331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2013');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2014'
       ,to_date('20140401000000','YYYYMMDDHH24MISS')
       ,to_date('20150331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2014');
--
INSERT INTO FINANCIAL_YEARS
       (FYR_ID
       ,FYR_START_DATE
       ,FYR_END_DATE
       )
SELECT 
        '2015'
       ,to_date('20150401000000','YYYYMMDDHH24MISS')
       ,to_date('20160331000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM FINANCIAL_YEARS
                   WHERE FYR_ID = '2015');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HHINV_RUN_LOG
--
-- select * from mai_metadata.hhinv_run_log
-- order by run_num
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hhinv_run_log
SET TERM OFF

INSERT INTO HHINV_RUN_LOG
       (FST_RUN_DATE
       ,LST_RUN_DATE
       ,NO_OF_RUNS
       ,RUN_NUM
       ,RUN_STAGE
       ,RUN_STAT
       ,ERROR_MSG
       ,ITEM_CNT
       ,ITEM_ERR_CNT
       ,MAX_SEQ_NO
       ,SECTION_CNT
       ,SECTION_ERR_CNT
       )
SELECT 
        to_date('19010101000000','YYYYMMDDHH24MISS')
       ,to_date('19010101000000','YYYYMMDDHH24MISS')
       ,0
       ,0
       ,'10'
       ,10
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HHINV_RUN_LOG
                   WHERE RUN_NUM = 0);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- JOB_SIZES
--
-- select * from mai_metadata.job_sizes
-- order by job_code
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT job_sizes
SET TERM OFF

INSERT INTO JOB_SIZES
       (JOB_CODE
       ,JOB_DESCR
       ,JOB_MIN_SIZE
       ,JOB_MAX_SIZE
       )
SELECT 
        '0'
       ,'All DOT jobs'
       ,0
       ,999999999 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM JOB_SIZES
                   WHERE JOB_CODE = '0');
--
INSERT INTO JOB_SIZES
       (JOB_CODE
       ,JOB_DESCR
       ,JOB_MIN_SIZE
       ,JOB_MAX_SIZE
       )
SELECT 
        '1'
       ,'All Local jobs'
       ,0
       ,999999999 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM JOB_SIZES
                   WHERE JOB_CODE = '1');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- STANDARD_ITEM_SECTIONS
--
-- select * from mai_metadata.standard_item_sections
-- order by sis_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT standard_item_sections
SET TERM OFF

INSERT INTO STANDARD_ITEM_SECTIONS
       (SIS_ID
       ,SIS_NAME
       ,SIS_DESCR
       ,SIS_START_DATE
       ,SIS_END_DATE
       )
SELECT 
        'ALL'
       ,'All Standard Items'
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM STANDARD_ITEM_SECTIONS
                   WHERE SIS_ID = 'ALL');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- STANDARD_ITEM_SUB_SECTIONS
--
-- select * from mai_metadata.standard_item_sub_sections
-- order by siss_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT standard_item_sub_sections
SET TERM OFF

INSERT INTO STANDARD_ITEM_SUB_SECTIONS
       (SISS_ID
       ,SISS_SIS_ID
       ,SISS_NAME
       ,SISS_DESCR
       ,SISS_MATERIAL
       ,SISS_XSP_TYPE
       ,SISS_START_DATE
       ,SISS_END_DATE
       ,SISS_UNIT
       )
SELECT 
        'ALL'
       ,'ALL'
       ,'All Standard Items'
       ,''
       ,''
       ,''
       ,null
       ,null
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM STANDARD_ITEM_SUB_SECTIONS
                   WHERE SISS_ID = 'ALL');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- VAT_RATES
--
-- select * from mai_metadata.vat_rates
-- order by vat_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT vat_rates
SET TERM OFF

INSERT INTO VAT_RATES
       (VAT_ID
       ,VAT_RATE
       ,VAT_EFFECTIVE_DATE
       )
SELECT 
        '1'
       ,17.5
       ,to_date('19950101000000','YYYYMMDDHH24MISS') FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM VAT_RATES
                   WHERE VAT_ID = '1');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- DOC_TEMPLATE_GATEWAYS
--
-- select * from mai_metadata.doc_template_gateways
-- order by dtg_template_name
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT doc_template_gateways
SET TERM OFF

INSERT INTO DOC_TEMPLATE_GATEWAYS
       (DTG_DMD_ID
       ,DTG_OLE_TYPE
       ,DTG_TABLE_NAME
       ,DTG_TEMPLATE_NAME
       ,DTG_DLC_ID
       ,DTG_TEMPLATE_DESCR
       ,DTG_POST_RUN_PROCEDURE
       )
SELECT 
        2
       ,'WORD'
       ,'WORK_ORDERS'
       ,'3480_WOR'
       ,2
       ,'Full Works Order Template'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_GATEWAYS
                   WHERE DTG_TEMPLATE_NAME = '3480_WOR');
--
INSERT INTO DOC_TEMPLATE_GATEWAYS
       (DTG_DMD_ID
       ,DTG_OLE_TYPE
       ,DTG_TABLE_NAME
       ,DTG_TEMPLATE_NAME
       ,DTG_DLC_ID
       ,DTG_TEMPLATE_DESCR
       ,DTG_POST_RUN_PROCEDURE
       )
SELECT 
        2
       ,'WORD'
       ,'WORK_ORDERS'
       ,'NMA_WOR'
       ,2
       ,'Full Works Order Template'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_GATEWAYS
                   WHERE DTG_TEMPLATE_NAME = 'NMA_WOR');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- DOC_TEMPLATE_COLUMNS
--
-- select * from mai_metadata.doc_template_columns
-- order by dtc_template_name
--         ,dtc_col_alias
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT doc_template_columns
SET TERM OFF

INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.AUTHORISED_BY(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'AUTHORISED_BY'
       ,20
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'AUTHORISED_BY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_ORDER_BAL_SUM(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'BAL_SUM'
       ,6
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'BAL_SUM');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_DATE_RAISED'
       ,'DATE'
       ,'DATE_RAISED'
       ,17
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DATE_RAISED');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_1'
       ,91
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_10'
       ,94
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_2'
       ,92
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_3'
       ,93
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_4'
       ,95
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_5'
       ,96
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_6'
       ,97
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_7'
       ,98
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_8'
       ,99
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_EST_VALUE(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_EST_VALUE_9'
       ,100
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_EST_VALUE_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_1'
       ,51
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_10'
       ,60
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_2'
       ,52
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_3'
       ,53
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_4'
       ,54
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_5'
       ,55
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_6'
       ,56
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_7'
       ,57
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_8'
       ,58
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_LOC_FULL(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_9'
       ,59
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_1'
       ,71
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_10'
       ,74
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_2'
       ,72
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_3'
       ,73
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_4'
       ,75
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_5'
       ,76
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_6'
       ,77
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_7'
       ,78
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_8'
       ,79
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_QTY(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_QTY_9'
       ,80
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_QTY_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_1'
       ,81
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_10'
       ,84
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_2'
       ,82
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_3'
       ,83
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_4'
       ,85
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_5'
       ,86
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_6'
       ,87
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_7'
       ,88
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_8'
       ,89
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_RATE(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_RATE_9'
       ,90
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_RATE_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_1'
       ,61
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_10'
       ,70
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_2'
       ,62
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_3'
       ,63
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_4'
       ,64
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_5'
       ,65
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_6'
       ,66
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_7'
       ,67
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_8'
       ,68
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_DEFECT_UNIT(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_UNIT_9'
       ,69
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_UNIT_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_JOB_NUMBER'
       ,'VARCHAR2'
       ,'JOB_NUMBER'
       ,29
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'JOB_NUMBER');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_SYS_FLAG'
       ,'VARCHAR2'
       ,'NETWORK_INDICATOR'
       ,2
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'NETWORK_INDICATOR');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_WORKS_ORDER_NO'
       ,'VARCHAR2'
       ,'ORDER_NO'
       ,1
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'ORDER_NO');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_ORDER_TOTAL(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'ORDER_TOTAL'
       ,9
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'ORDER_TOTAL');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.RAISED_BY(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'RAISED_BY'
       ,21
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'RAISED_BY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_1'
       ,101
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_10'
       ,104
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_2'
       ,102
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_3'
       ,103
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_4'
       ,105
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_5'
       ,106
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_6'
       ,107
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_7'
       ,108
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_8'
       ,109
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_REPAIR_DESC(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'REPAIR_DESC_9'
       ,110
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'REPAIR_DESC_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_ROAD_GROUP(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'ROAD_GROUP'
       ,3
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'ROAD_GROUP');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_STD_TEXT'
       ,'VARCHAR2'
       ,'STD_TEXT'
       ,18
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'STD_TEXT');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_ORDER_SUB_TOTAL(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'SUB_TOTAL'
       ,7
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'SUB_TOTAL');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_EST_BALANCING_SUM'
       ,'NUMBER'
       ,'WEBS'
       ,22
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WEBS');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_EST_COMPLETE'
       ,'DATE'
       ,'WECMP'
       ,23
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WECMP');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_EST_COST'
       ,'NUMBER'
       ,'WECST'
       ,24
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WECST');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_EST_LABOUR'
       ,'NUMBER'
       ,'WEL'
       ,25
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WEL');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_ICB_SUB_ITEM_CODE'
       ,'VARCHAR2'
       ,'WISIC'
       ,27
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WISIC');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_ICB_SUB_SUB_ITEM_CODE'
       ,'VARCHAR2'
       ,'WISSIC'
       ,28
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WISSIC');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_ICB_ITEM_CODE'
       ,'VARCHAR2'
       ,'WITC'
       ,26
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WITC');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_LAST_PRINT_DATE'
       ,'DATE'
       ,'WLPD'
       ,30
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WLPD');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(1,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_1'
       ,111
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(10,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_10'
       ,120
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(2,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_2'
       ,112
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(3,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_3'
       ,113
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(4,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_4'
       ,114
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(5,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_5'
       ,115
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(6,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_6'
       ,116
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(7,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_7'
       ,117
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(8,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_8'
       ,118
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_ITEM_NO(9,WOR_WORKS_ORDER_NO)'
       ,'NUMBER'
       ,'WOL_ITEM_9'
       ,119
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ITEM_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_1'
       ,31
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_10'
       ,40
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_2'
       ,32
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_3'
       ,33
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_4'
       ,34
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_5'
       ,35
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_6'
       ,36
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_7'
       ,37
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_8'
       ,38
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_LINK(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_LINK_9'
       ,39
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_LINK_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_1'
       ,41
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_10'
       ,50
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_2'
       ,42
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_3'
       ,43
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_4'
       ,44
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_5'
       ,45
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_6'
       ,46
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_7'
       ,47
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_8'
       ,48
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WWO.GET_WOL_SECTNO(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_SECTNO_9'
       ,49
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_SECTNO_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_ACT_COST_CODE'
       ,'VARCHAR2'
       ,'WOR_ACT_COST_CODE'
       ,5
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_ACT_COST_CODE');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_ACT_LABOUR'
       ,'NUMBER'
       ,'WOR_ACT_LABOUR'
       ,8
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_ACT_LABOUR');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_AGENCY'
       ,'VARCHAR2'
       ,'WOR_AGENCY'
       ,4
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_AGENCY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_CHEAPEST_FLAG'
       ,'VARCHAR2'
       ,'WOR_CHEAPEST_FLAG'
       ,10
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_CHEAPEST_FLAG');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_CLOSED_BY_ID'
       ,'NUMBER'
       ,'WOR_CLOSED_BY_ID'
       ,11
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_CLOSED_BY_ID');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_COC_COST_CENTRE'
       ,'VARCHAR2'
       ,'WOR_COC_COST_CENTRE'
       ,12
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_COC_COST_CENTRE');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_COST_RECHARG'
       ,'NUMBER'
       ,'WOR_COST_RECHARG'
       ,13
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_COST_RECHARG');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_DATE_CLOSED'
       ,'DATE'
       ,'WOR_DATE_CLOSED'
       ,14
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DATE_CLOSED');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_DATE_CONFIRMED'
       ,'DATE'
       ,'WOR_DATE_CONFIRMED'
       ,15
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DATE_CONFIRMED');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_DATE_MOD'
       ,'DATE'
       ,'WOR_DATE_MOD'
       ,16
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DATE_MOD');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        '3480_WOR'
       ,'WOR_DESCR'
       ,'VARCHAR2'
       ,'WOR_DESCR'
       ,19
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = '3480_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DESCR');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_AGENCY'
       ,'VARCHAR2'
       ,'AGENCY'
       ,2
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'AGENCY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.AUTHORISED_BY(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'AUTHORISED_BY'
       ,3
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'AUTHORISED_BY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_ORDER_BAL_SUM(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'BAL_SUM'
       ,6
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BAL_SUM');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_1'
       ,114
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_10'
       ,123
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_2'
       ,115
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_3'
       ,116
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_4'
       ,117
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_5'
       ,118
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_6'
       ,119
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_7'
       ,120
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_8'
       ,121
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE_TOTAL(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'BOQ_LINE_TOTAL_9'
       ,122
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'BOQ_LINE_TOTAL_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_ACT_COMMENCE_BY'
       ,'DATE'
       ,'COMMENCED_ON'
       ,11
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'COMMENCED_ON');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_COMMENCE_BY'
       ,'DATE'
       ,'COMMEN_BY'
       ,7
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'COMMEN_BY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DATE_CLOSED'
       ,'DATE'
       ,'COMPLETED_ON'
       ,11
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'COMPLETED_ON');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_EST_COMPLETE'
       ,'DATE'
       ,'COMPLETE_BY'
       ,11
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'COMPLETE_BY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_REVISED_COMP_DATE'
       ,'DATE'
       ,'COMPLT_BY'
       ,8
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'COMPLT_BY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_CONTRACT(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'CONTRACT'
       ,9
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'CONTRACT');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DATE_RAISED'
       ,'DATE'
       ,'DATE_RAISED'
       ,10
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DATE_RAISED');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DEF_CORRECTION_PERIOD'
       ,'NUMBER'
       ,'DEF_CORRECTION'
       ,11
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_CORRECTION');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_1'
       ,12
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_10'
       ,21
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_2'
       ,13
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_3'
       ,14
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_4'
       ,15
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_5'
       ,16
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_6'
       ,17
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_7'
       ,18
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_8'
       ,19
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_LOC(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'DEF_LOC_9'
       ,20
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'DEF_LOC_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_CORR_EXTENSION_TIME'
       ,'NUMBER'
       ,'EXTEN_TIME'
       ,22
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'EXTEN_TIME');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_INTERIM_PAYMENT_FLAG'
       ,'VARCHAR2'
       ,'INTERIM'
       ,23
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'INTERIM');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_JOB_NUMBER'
       ,'VARCHAR2'
       ,'JOB_NUMBER'
       ,24
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'JOB_NUMBER');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_METHOD_STATEMENT_FLAG'
       ,'VARCHAR2'
       ,'METHOD'
       ,25
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'METHOD');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_NETWORK_IND(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'NETWORK_INDICATOR'
       ,4
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'NETWORK_INDICATOR');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_WORKS_ORDER_NO'
       ,'VARCHAR2'
       ,'ORDER_NO'
       ,1
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'ORDER_NO');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_ORDER_TOTAL(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'ORDER_TOTAL'
       ,26
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'ORDER_TOTAL');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_WORKS_PROGRAMME_FLAG'
       ,'VARCHAR2'
       ,'PROG_FLAG'
       ,27
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'PROG_FLAG');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DEF_CORRECTION_ACCEPTABLE'
       ,'VARCHAR2'
       ,'QUALITY_ACC'
       ,28
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'QUALITY_ACC');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.RAISED_BY(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'RAISED_BY'
       ,29
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'RAISED_BY');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_RISK_ASSESSMENT_FLAG'
       ,'VARCHAR2'
       ,'RISK_ASS'
       ,30
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'RISK_ASS');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_ROAD_GROUP(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'ROAD_GROUP'
       ,31
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'ROAD_GROUP');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_ADDITIONAL_SAFETY_FLAG'
       ,'VARCHAR2'
       ,'SPECIAL_CDM'
       ,32
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'SPECIAL_CDM');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_STD_TEXT'
       ,'VARCHAR2'
       ,'STD_TEXT'
       ,33
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'STD_TEXT');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_ORDER_SUB_TOTAL(WOR_WORKS_ORDER_NO)'
       ,'VARCHAR2'
       ,'SUB_TOTAL'
       ,34
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'SUB_TOTAL');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_ACT_COST_CODE'
       ,'VARCHAR2'
       ,'WACC'
       ,35
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WACC');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_LAST_PRINT_DATE'
       ,'DATE'
       ,'WLPD'
       ,36
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WLPD');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL10_BOQ_LINE1'
       ,82
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL10_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL10_BOQ_LINE2'
       ,83
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL10_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL10_BOQ_LINE3'
       ,84
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL10_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL10_BOQ_LINE4'
       ,85
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL10_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL10_BOQ_LINE5'
       ,86
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL10_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL1_BOQ_LINE1'
       ,37
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL1_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL1_BOQ_LINE2'
       ,38
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL1_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL1_BOQ_LINE3'
       ,39
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL1_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL1_BOQ_LINE4'
       ,40
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL1_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL1_BOQ_LINE5'
       ,41
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL1_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL2_BOQ_LINE1'
       ,42
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL2_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL2_BOQ_LINE2'
       ,43
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL2_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL2_BOQ_LINE3'
       ,44
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL2_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL2_BOQ_LINE4'
       ,45
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL2_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL2_BOQ_LINE5'
       ,46
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL2_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL3_BOQ_LINE1'
       ,47
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL3_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL3_BOQ_LINE2'
       ,48
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL3_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL3_BOQ_LINE3'
       ,49
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL3_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL3_BOQ_LINE4'
       ,50
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL3_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL3_BOQ_LINE5'
       ,51
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL3_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL4_BOQ_LINE1'
       ,52
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL4_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL4_BOQ_LINE2'
       ,53
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL4_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL4_BOQ_LINE3'
       ,54
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL4_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL4_BOQ_LINE4'
       ,55
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL4_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL4_BOQ_LINE5'
       ,56
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL4_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL5_BOQ_LINE1'
       ,57
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL5_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL5_BOQ_LINE2'
       ,58
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL5_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL5_BOQ_LINE3'
       ,59
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL5_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL5_BOQ_LINE4'
       ,60
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL5_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL5_BOQ_LINE5'
       ,61
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL5_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL6_BOQ_LINE1'
       ,62
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL6_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL6_BOQ_LINE2'
       ,63
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL6_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL6_BOQ_LINE3'
       ,64
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL6_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL6_BOQ_LINE4'
       ,65
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL6_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL6_BOQ_LINE5'
       ,66
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL6_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL7_BOQ_LINE1'
       ,67
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL7_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL7_BOQ_LINE2'
       ,68
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL7_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL7_BOQ_LINE3'
       ,69
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL7_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL7_BOQ_LINE4'
       ,70
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL7_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL7_BOQ_LINE5'
       ,71
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL7_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL8_BOQ_LINE1'
       ,72
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL8_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL8_BOQ_LINE2'
       ,73
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL8_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL8_BOQ_LINE3'
       ,74
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL8_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL8_BOQ_LINE4'
       ,75
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL8_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL8_BOQ_LINE5'
       ,76
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL8_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(1,WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL9_BOQ_LINE1'
       ,77
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL9_BOQ_LINE1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(2,WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL9_BOQ_LINE2'
       ,78
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL9_BOQ_LINE2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(3,WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL9_BOQ_LINE3'
       ,79
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL9_BOQ_LINE3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(4,WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL9_BOQ_LINE4'
       ,80
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL9_BOQ_LINE4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_BOQ_LINE(5,WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL9_BOQ_LINE5'
       ,81
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL9_BOQ_LINE5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_1'
       ,87
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_10'
       ,96
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_2'
       ,88
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_3'
       ,89
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_4'
       ,90
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_5'
       ,91
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_6'
       ,92
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_7'
       ,93
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_8'
       ,94
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_DEFECT_ID(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_DEFECT_ID_9'
       ,95
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_DEFECT_ID_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(1,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_1'
       ,97
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_1');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(10,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_10'
       ,106
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_10');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(2,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_2'
       ,98
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_2');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(3,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_3'
       ,99
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_3');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(4,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_4'
       ,100
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_4');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(5,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_5'
       ,101
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_5');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(6,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_6'
       ,102
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_6');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(7,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_7'
       ,103
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_7');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(8,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_8'
       ,104
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_8');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WWO.GET_WOL_ROAD_SECTION(WWO.GET_WOL_ID(9,WOR_WORKS_ORDER_NO))'
       ,'VARCHAR2'
       ,'WOL_ROAD_SECTION_9'
       ,105
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOL_ROAD_SECTION_9');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_ACT_LABOUR'
       ,'NUMBER'
       ,'WOR_ACT_LABOUR'
       ,107
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_ACT_LABOUR');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_CLOSED_BY_ID'
       ,'NUMBER'
       ,'WOR_CLOSED_BY_ID'
       ,108
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_CLOSED_BY_ID');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_COC_COST_CENTRE'
       ,'VARCHAR2'
       ,'WOR_COC_COST_CENTRE'
       ,109
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_COC_COST_CENTRE');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_COST_RECHARG'
       ,'NUMBER'
       ,'WOR_COST_RECHARG'
       ,110
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_COST_RECHARG');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DATE_CLOSED'
       ,'DATE'
       ,'WOR_DATE_CLOSED'
       ,111
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DATE_CLOSED');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DATE_CONFIRMED'
       ,'DATE'
       ,'WOR_DATE_CONFIRMED'
       ,112
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DATE_CONFIRMED');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DATE_MOD'
       ,'DATE'
       ,'WOR_DATE_MOD'
       ,113
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DATE_MOD');
--
INSERT INTO DOC_TEMPLATE_COLUMNS
       (DTC_TEMPLATE_NAME
       ,DTC_COL_NAME
       ,DTC_COL_TYPE
       ,DTC_COL_ALIAS
       ,DTC_COL_SEQ
       ,DTC_USED_IN_PROC
       ,DTC_IMAGE_FILE
       )
SELECT 
        'NMA_WOR'
       ,'WOR_DESCR'
       ,'VARCHAR2'
       ,'WOR_DESCR'
       ,5
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_TEMPLATE_COLUMNS
                   WHERE DTC_TEMPLATE_NAME = 'NMA_WOR'
                    AND  DTC_COL_ALIAS = 'WOR_DESCR');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- WO_AUDIT_COLUMNS
--
-- select * from mai_metadata.wo_audit_columns
-- order by wac_column_name
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT wo_audit_columns
SET TERM OFF

INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'BOQ_ACT_COST'
       ,'BOQ Actual Cost'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'BOQ_ACT_COST');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'BOQ_ACT_QUANTITY'
       ,'BOQ Actual Quantity'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'BOQ_ACT_QUANTITY');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'BOQ_ACT_RATE'
       ,'BOQ Actual Rate'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'BOQ_ACT_RATE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'BOQ_EST_COST'
       ,'BOQ Estimate Cost'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'BOQ_EST_COST');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'BOQ_EST_QUANTITY'
       ,'BOQ Quantity Estimate'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'BOQ_EST_QUANTITY');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'BOQ_EST_RATE'
       ,'BOQ Estimate Rate'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'BOQ_EST_RATE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'BOQ_STA_ITEM_CODE'
       ,'BOQ Item Code'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'BOQ_STA_ITEM_CODE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOL_ACT_COST'
       ,'WOL Actual Cost'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOL_ACT_COST');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOL_DATE_COMPLETE'
       ,'WOL Completed Date'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOL_DATE_COMPLETE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOL_EST_COST'
       ,'WOL Estimate Cost'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOL_EST_COST');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOL_GANG'
       ,'WOL Gang'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOL_GANG');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOL_RSE_HE_ID'
       ,'WOL Road Section'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOL_RSE_HE_ID');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOL_STATUS_CODE'
       ,'WOL Status Code'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOL_STATUS_CODE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_ACT_COST'
       ,'Total Cost'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_ACT_COST');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_ACT_COST_CODE'
       ,'Cost Code'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_ACT_COST_CODE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_CLOSED_BY_ID'
       ,'Completed By'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_CLOSED_BY_ID');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_CON_ID'
       ,'Contract'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_CON_ID');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_DATE_CONFIRMED'
       ,'Instructed Date'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_DATE_CONFIRMED');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_EST_COMPLETE'
       ,'Estimated Completion Date'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_EST_COMPLETE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_EST_COST'
       ,'Estimate Cost'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_EST_COST');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_LAST_PRINT_DATE'
       ,'WO Print Date'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_LAST_PRINT_DATE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_MOD_BY_ID'
       ,'Authorised by'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_MOD_BY_ID');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_PEO_PERSON_ID'
       ,'Originator'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_PEO_PERSON_ID');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_PRIORITY'
       ,'Priority'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_PRIORITY');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_RSE_HE_ID_GROUP'
       ,'Road Segment'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_RSE_HE_ID_GROUP');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_SCORE'
       ,'Contractor Score'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_SCORE');
--
INSERT INTO WO_AUDIT_COLUMNS
       (WAC_COLUMN_NAME
       ,WAC_DISPLAY_TEXT
       ,WAC_AUDITED
       )
SELECT 
        'WOR_WORKS_ORDER_NO'
       ,'Work Order Number'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM WO_AUDIT_COLUMNS
                   WHERE WAC_COLUMN_NAME = 'WOR_WORKS_ORDER_NO');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_HD_MODULES
--
-- select * from mai_metadata.hig_hd_modules
-- order by hhm_module
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_hd_modules
SET TERM OFF

INSERT INTO HIG_HD_MODULES
       (HHM_MODULE
       ,HHM_TAG
       )
SELECT 
        'MAI2510'
       ,'audit_file' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MODULES
                   WHERE HHM_MODULE = 'MAI2510');
--
INSERT INTO HIG_HD_MODULES
       (HHM_MODULE
       ,HHM_TAG
       )
SELECT 
        'MAI2520'
       ,'routine_inspection_rule_file' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MODULES
                   WHERE HHM_MODULE = 'MAI2520');
--
INSERT INTO HIG_HD_MODULES
       (HHM_MODULE
       ,HHM_TAG
       )
SELECT 
        'MAI2530'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MODULES
                   WHERE HHM_MODULE = 'MAI2530');
--
INSERT INTO HIG_HD_MODULES
       (HHM_MODULE
       ,HHM_TAG
       )
SELECT 
        'MAI2530_A'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MODULES
                   WHERE HHM_MODULE = 'MAI2530_A');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_HD_MOD_USES
--
-- select * from mai_metadata.hig_hd_mod_uses
-- order by hhu_hhm_module
--         ,hhu_seq
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_hd_mod_uses
SET TERM OFF

INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2510'
       ,'DUAL'
       ,1
       ,'file_date'
       ,null
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2510'
                    AND  HHU_SEQ = 1);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2510'
       ,'NM_ELEMENTS'
       ,2
       ,'section'
       ,null
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2510'
                    AND  HHU_SEQ = 2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2510'
       ,'ACTIVITIES_REPORT'
       ,3
       ,'inspection'
       ,2
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2510'
                    AND  HHU_SEQ = 3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2510'
       ,'ACT_REPORT_LINES'
       ,4
       ,''
       ,3
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2510'
                    AND  HHU_SEQ = 4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2510'
       ,'DEFECTS'
       ,5
       ,'defect'
       ,3
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2510'
                    AND  HHU_SEQ = 5);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2510'
       ,'REPAIRS'
       ,6
       ,'action'
       ,5
       ,'(rep_action_cat = ''I'' or rep_date_completed IS NOT NULL)'
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2510'
                    AND  HHU_SEQ = 6);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2520'
       ,'road_sections_all'
       ,1
       ,'section'
       ,null
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2520'
                    AND  HHU_SEQ = 1);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2520'
       ,'RIRF_SECT_FREQS'
       ,2
       ,'section_activity'
       ,1
       ,''
       ,'Y'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2520'
                    AND  HHU_SEQ = 2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2520'
       ,'RIRF_ACTIVITIES'
       ,3
       ,'valid_act'
       ,null
       ,''
       ,'Y'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2520'
                    AND  HHU_SEQ = 3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2520'
       ,'RIRF_ACTIVITY_INT'
       ,4
       ,'action_interval'
       ,3
       ,''
       ,'Y'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2520'
                    AND  HHU_SEQ = 4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2520'
       ,'RIRF_DEF_TYPES'
       ,5
       ,'activity_defect'
       ,3
       ,''
       ,'Y'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2520'
                    AND  HHU_SEQ = 5);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2520'
       ,'RIRF_XSP_VALUES'
       ,6
       ,''
       ,null
       ,''
       ,'Y'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2520'
                    AND  HHU_SEQ = 6);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,1
       ,'ne'
       ,null
       ,'ne_id IN (SELECT rtg_tag_id FROM  report_tags WHERE rtg_job_id = :extent )AND   ne_nt_type  = ''HERM'''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 1);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,2
       ,'ne'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,3
       ,'ne'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,4
       ,'ne'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,1
       ,'def'
       ,null
       ,'def_rse_he_id IN (SELECT rtg_tag_id FROM  report_tags  WHERE rtg_job_id = :extent) AND def_status_code = ''AVAILABLE'''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 1);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,2
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,3
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,4
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,5
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 5);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6.2
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6.2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6.3
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6.3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6.4
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6.4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'BOQ_ITEMS'
       ,7
       ,'boq'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 7);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_HD_LOOKUP_JOIN_DEFS
--
-- select * from mai_metadata.hig_hd_lookup_join_defs
-- order by hhl_hhu_hhm_module
--         ,hhl_hhu_seq
--         ,hhl_join_seq
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_hd_lookup_join_defs
SET TERM OFF

INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,3
       ,1
       ,'HIG_CODES'
       ,'hgc'
       ,'N'
       ,'hgc.hco_domain = ''INITIATION_TYPE''' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 3
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,4
       ,2
       ,'ACTIVITIES'
       ,'act'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 4
                    AND  HHL_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,5
       ,1
       ,'ACTIVITIES'
       ,'act'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,5
       ,3
       ,'DEF_TYPES'
       ,'dty'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 3);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,5
       ,4
       ,'NM_INV_TYPES'
       ,'nit'
       ,'Y'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 4);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,5
       ,5
       ,'HIG_CODES'
       ,'hc1'
       ,'Y'
       ,'hc1.hco_domain (+) = ''XSP_VALUES''' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 5);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,5
       ,6
       ,'HIG_CODES'
       ,'hc2'
       ,'N'
       ,'hc2.hco_domain = ''DEFECT_PRIORITIES''' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 6);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,6
       ,2
       ,'HIG_CODES'
       ,'hc1'
       ,'N'
       ,'hc1.hco_domain = ''REPAIR_TYPE''' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 6
                    AND  HHL_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2510'
       ,6
       ,5
       ,'DEFECTS'
       ,'def'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHL_HHU_SEQ = 6
                    AND  HHL_JOIN_SEQ = 5);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,1
       ,1
       ,'nm_elements'
       ,'ne'
       ,'N'
       ,'ne_nt_type = ''HERM''' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 1
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,5
       ,1
       ,'repairs'
       ,'rep'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,5
       ,2
       ,'treatments'
       ,'tre'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_1 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_2 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6.2
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_3 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6.3
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_4 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6.4
                    AND  HHL_JOIN_SEQ = 1);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_HD_LOOKUP_JOIN_COLS
--
-- select * from mai_metadata.hig_hd_lookup_join_cols
-- order by hho_hhl_hhu_hhm_module
--         ,hho_hhl_hhu_seq
--         ,hho_hhl_join_seq
--         ,hho_parent_col
--         ,hho_lookup_col
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_hd_lookup_join_cols
SET TERM OFF

INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,3
       ,1
       ,'ARE_INITIATION_TYPE'
       ,'HCO_CODE'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 3
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'ARE_INITIATION_TYPE'
                    AND  HHO_LOOKUP_COL = 'HCO_CODE');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,4
       ,2
       ,'ARL_ATV_ACTY_AREA_CODE'
       ,'ATV_ACTY_AREA_CODE'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 4
                    AND  HHO_HHL_JOIN_SEQ = 2
                    AND  HHO_PARENT_COL = 'ARL_ATV_ACTY_AREA_CODE'
                    AND  HHO_LOOKUP_COL = 'ATV_ACTY_AREA_CODE');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,1
       ,'DEF_ITY_SYS_FLAG'
       ,'ATV_DTP_FLAG'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'DEF_ITY_SYS_FLAG'
                    AND  HHO_LOOKUP_COL = 'ATV_DTP_FLAG');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,1
       ,'def_atv_acty_area_code'
       ,'ATV_ACTY_AREA_CODE'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'ATV_ACTY_AREA_CODE');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,3
       ,'DEF_ATV_ACTY_AREA_CODE'
       ,'DTY_ATV_ACTY_AREA_CODE'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 3
                    AND  HHO_PARENT_COL = 'DEF_ATV_ACTY_AREA_CODE'
                    AND  HHO_LOOKUP_COL = 'DTY_ATV_ACTY_AREA_CODE');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,3
       ,'DEF_DEFECT_CODE'
       ,'DTY_DEFECT_CODE'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 3
                    AND  HHO_PARENT_COL = 'DEF_DEFECT_CODE'
                    AND  HHO_LOOKUP_COL = 'DTY_DEFECT_CODE');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,3
       ,'DEF_ITY_SYS_FLAG'
       ,'DTY_DTP_FLAG'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 3
                    AND  HHO_PARENT_COL = 'DEF_ITY_SYS_FLAG'
                    AND  HHO_LOOKUP_COL = 'DTY_DTP_FLAG');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,4
       ,'DEF_ITY_INV_CODE'
       ,'NIT_INV_TYPE'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 4
                    AND  HHO_PARENT_COL = 'DEF_ITY_INV_CODE'
                    AND  HHO_LOOKUP_COL = 'NIT_INV_TYPE');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,5
       ,'def_x_sect'
       ,'hco_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 5
                    AND  HHO_PARENT_COL = 'def_x_sect'
                    AND  HHO_LOOKUP_COL = 'hco_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,5
       ,6
       ,'def_priority'
       ,'hco_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 6
                    AND  HHO_PARENT_COL = 'def_priority'
                    AND  HHO_LOOKUP_COL = 'hco_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,6
       ,2
       ,'rep_action_cat'
       ,'hco_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 2
                    AND  HHO_PARENT_COL = 'rep_action_cat'
                    AND  HHO_LOOKUP_COL = 'hco_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2510'
       ,6
       ,5
       ,'REP_DEF_DEFECT_ID'
       ,'DEF_DEFECT_ID'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 5
                    AND  HHO_PARENT_COL = 'REP_DEF_DEFECT_ID'
                    AND  HHO_LOOKUP_COL = 'DEF_DEFECT_ID');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,1
       ,1
       ,'def_rse_he_id'
       ,'ne_id'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 1
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_rse_he_id'
                    AND  HHO_LOOKUP_COL = 'ne_id');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,5
       ,1
       ,'def_defect_id'
       ,'rep_def_defect_id'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_id'
                    AND  HHO_LOOKUP_COL = 'rep_def_defect_id');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,5
       ,2
       ,'rep_tre_treat_code'
       ,'tre_treat_code'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 2
                    AND  HHO_PARENT_COL = 'rep_tre_treat_code'
                    AND  HHO_LOOKUP_COL = 'tre_treat_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_ity_sys_flag'
       ,'dty_dtp_flag'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_ity_sys_flag'
                    AND  HHO_LOOKUP_COL = 'dty_dtp_flag');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.2
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.2
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_ity_sys_flag'
       ,'dty_dtp_flag'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.2
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_ity_sys_flag'
                    AND  HHO_LOOKUP_COL = 'dty_dtp_flag');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.3
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.3
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_ity_sys_flag'
       ,'dty_dtp_flag'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.3
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_ity_sys_flag'
                    AND  HHO_LOOKUP_COL = 'dty_dtp_flag');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.4
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.4
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'def_ity_sys_flag'
       ,'dty_dtp_flag'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.4
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_ity_sys_flag'
                    AND  HHO_LOOKUP_COL = 'dty_dtp_flag');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_HD_SELECTED_COLS
--
-- select * from mai_metadata.hig_hd_selected_cols
-- order by hhc_hhu_hhm_module
--         ,hhc_hhu_seq
--         ,hhc_column_seq
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_hd_selected_cols
SET TERM OFF

INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,1
       ,486
       ,'X'
       ,'N'
       ,'Y'
       ,'file_date'
       ,'SYSDATE'
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 486);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,2
       ,483
       ,'NE_UNIQUE'
       ,'N'
       ,'Y'
       ,'label'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 483);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,3
       ,478
       ,'ARE_MAINT_INSP_FLAG'
       ,'N'
       ,'Y'
       ,'type'
       ,'decode(are_maint_insp_flag, ''S'', ''Safety'', ''Detailed'')'
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 478);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,3
       ,479
       ,'HCO_MEANING'
       ,'N'
       ,'Y'
       ,'reason'
       ,''
       ,null
       ,null
       ,1
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 479);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,3
       ,480
       ,'ARE_DATE_WORK_DONE'
       ,'N'
       ,'Y'
       ,'insp_start'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 480);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,3
       ,482
       ,'ARE_DATE_WORK_DONE'
       ,'N'
       ,'Y'
       ,'insp_end'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 482);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,3
       ,490
       ,'ARE_ST_CHAIN'
       ,'N'
       ,'Y'
       ,'start_chainage'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 490);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,3
       ,491
       ,'ARE_END_CHAIN'
       ,'N'
       ,'Y'
       ,'end_chainage'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 491);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,4
       ,471
       ,'ATV_DESCR'
       ,'N'
       ,'Y'
       ,'activity'
       ,''
       ,null
       ,null
       ,2
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 471);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,5
       ,472
       ,'DEF_ST_CHAIN'
       ,'N'
       ,'Y'
       ,'defect_chainage'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 472);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,5
       ,475
       ,'HCO_MEANING'
       ,'N'
       ,'Y'
       ,'xsp'
       ,''
       ,null
       ,null
       ,5
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 475);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,5
       ,478
       ,'ATV_DESCR'
       ,'N'
       ,'Y'
       ,'defect_activity'
       ,''
       ,null
       ,null
       ,1
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 478);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,5
       ,484
       ,'DTY_DESCR1'
       ,'N'
       ,'Y'
       ,'defect_name'
       ,''
       ,null
       ,null
       ,3
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 484);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,5
       ,485
       ,'NIT_DESCR'
       ,'N'
       ,'Y'
       ,'inventory'
       ,''
       ,null
       ,null
       ,4
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 485);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,5
       ,487
       ,'HCO_MEANING'
       ,'N'
       ,'Y'
       ,'category'
       ,''
       ,null
       ,null
       ,6
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 487);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,5
       ,489
       ,'DEF_CREATED_DATE'
       ,'N'
       ,'Y'
       ,'observation_date'
       ,'to_date(def_created_date||'' ''||def_time_hrs||'':''||def_time_mins, ''dd-mon-RRRR HH24:mi'')'
       ,null
       ,null
       ,null
       ,''
       ,'dd-MON-YYYY HH24:MI:SS' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 489);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,6
       ,488
       ,'REP_DATE_COMPLETED'
       ,'N'
       ,'Y'
       ,'action_date'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 488);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,6
       ,490
       ,'HCO_MEANING'
       ,'N'
       ,'Y'
       ,'action_type'
       ,''
       ,null
       ,null
       ,2
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 490);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,6
       ,492
       ,'REP_DESCR'
       ,'N'
       ,'Y'
       ,'action_desc'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 492);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2510'
       ,6
       ,494
       ,'DEF_WORKS_ORDER_NO'
       ,'N'
       ,'Y'
       ,'wo_ref'
       ,''
       ,null
       ,null
       ,5
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 494);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,1
       ,1
       ,'rse_unique'
       ,'N'
       ,'Y'
       ,'label'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,2
       ,1
       ,'act_name'
       ,'N'
       ,'Y'
       ,'act_name'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,2
       ,2
       ,'interval'
       ,'N'
       ,'Y'
       ,'interval'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,2
       ,3
       ,'frequency'
       ,'N'
       ,'Y'
       ,'frequency'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 3);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,2
       ,4
       ,'freq_int'
       ,'N'
       ,'Y'
       ,'freq_int'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 4);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,2
       ,5
       ,'freq_int_unit'
       ,'N'
       ,'Y'
       ,'freq_int_unit'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 5);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,3
       ,1
       ,'valid_act_name'
       ,'N'
       ,'Y'
       ,'valid_act_name'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,3
       ,2
       ,'act_desc'
       ,'N'
       ,'Y'
       ,'act_desc'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,4
       ,1
       ,'category'
       ,'N'
       ,'Y'
       ,'category'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,4
       ,2
       ,'action'
       ,'N'
       ,'Y'
       ,'action'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,4
       ,3
       ,'act_interval'
       ,'N'
       ,'Y'
       ,'act_interval'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 3);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,4
       ,4
       ,'unit'
       ,'N'
       ,'Y'
       ,'unit'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 4);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,5
       ,1
       ,'defect_name'
       ,'N'
       ,'Y'
       ,'defect_name'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,5
       ,2
       ,'defect_desc'
       ,'N'
       ,'Y'
       ,'defect_desc'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2520'
       ,6
       ,1
       ,'xsp'
       ,'N'
       ,'Y'
       ,'xsp'
       ,''
       ,null
       ,null
       ,null
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,1
       ,'1'
       ,'N'
       ,'Y'
       ,'rec1'
       ,'''"1'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,2
       ,'ne_unique'
       ,'N'
       ,'Y'
       ,'ne_unique'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,3
       ,'''NRM'''
       ,'N'
       ,'Y'
       ,'insp'
       ,'''NRM'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 3);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,4
       ,'any_defects'
       ,'N'
       ,'Y'
       ,'any_defects'
       ,'mai_gmis_util.defects_exist_on_section (ne_id)'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 4);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,5
       ,'ne_length'
       ,'N'
       ,'Y'
       ,'ne_length'
       ,'to_char(nm3net.get_ne_length(ne_id), ''99999.999'')||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 5);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,2
       ,20
       ,'2'
       ,'N'
       ,'Y'
       ,'rec'
       ,'''"2'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 20);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,2
       ,21
       ,'ne_descr'
       ,'N'
       ,'Y'
       ,'road_name'
       ,'rtrim(ne_name_1)'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 21);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,2
       ,22
       ,'null'
       ,'N'
       ,'Y'
       ,''
       ,'null||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 22);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,3
       ,30
       ,'3'
       ,'N'
       ,'Y'
       ,'rec3'
       ,'''"3'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 30);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,3
       ,31
       ,'section_desc'
       ,'N'
       ,'Y'
       ,'section_desc'
       ,'rtrim(ne_descr)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 31);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,4
       ,40
       ,'4'
       ,'N'
       ,'Y'
       ,'rec4'
       ,'''"4'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 40);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,4
       ,41
       ,'NULL'
       ,'N'
       ,'Y'
       ,''
       ,'NULL'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 41);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,4
       ,42
       ,'sysdate'
       ,'N'
       ,'Y'
       ,'download_date'
       ,'TO_CHAR(sysdate, ''YYMMDD'')||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 42);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,1
       ,1
       ,'1'
       ,'N'
       ,'Y'
       ,'line1'
       ,'''"1'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,1
       ,2
       ,'ne_unique'
       ,'N'
       ,'Y'
       ,'ne_unique'
       ,'ne_unique||''"'''
       ,null
       ,null
       ,1
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,21
       ,'2'
       ,'N'
       ,'Y'
       ,'line2'
       ,'''"2'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 21);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,22
       ,'def_defect_id'
       ,'N'
       ,'Y'
       ,'def_defect_id'
       ,''
       ,null
       ,1
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 22);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,23
       ,'def_atv_acty_area_code'
       ,'N'
       ,'Y'
       ,'def_atv_acty_area_code'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 23);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,24
       ,'def_defect_code'
       ,'N'
       ,'Y'
       ,'def_defect_code'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 24);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,25
       ,'def_priority'
       ,'N'
       ,'Y'
       ,'def_priority'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 25);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,26
       ,'on_works_order'
       ,'N'
       ,'Y'
       ,'on_wo'
       ,'decode(def_works_order_no, NULL, ''N'', ''Y'')'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 26);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,27
       ,'def_works_order_no'
       ,'N'
       ,'Y'
       ,'def_works_order_no'
       ,'def_works_order_no||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 27);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,31
       ,'3'
       ,'N'
       ,'Y'
       ,'line3'
       ,'''"3'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 31);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,32
       ,'def_locn_descr'
       ,'N'
       ,'Y'
       ,'def_locn_descr'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 32);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,33
       ,'def_st_chain'
       ,'N'
       ,'Y'
       ,'def_st_chain'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 33);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,34
       ,'def_x_sect'
       ,'N'
       ,'Y'
       ,'def_x_sect'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 34);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,35
       ,'NULL'
       ,'N'
       ,'Y'
       ,''
       ,'NULL||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 35);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,4
       ,41
       ,'''"4'''
       ,'N'
       ,'Y'
       ,'line4'
       ,'''"4'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 41);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,4
       ,42
       ,'def_defect_descr'
       ,'N'
       ,'Y'
       ,'def_defect_descr'
       ,'def_defect_descr||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 42);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,1
       ,'5'
       ,'N'
       ,'Y'
       ,'line5'
       ,'''"5'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,2
       ,'rep_tre_treat_code'
       ,'N'
       ,'Y'
       ,'rep_tre_treat_code'
       ,''
       ,null
       ,null
       ,1
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,3
       ,'tre_descr'
       ,'N'
       ,'Y'
       ,'tre_descr'
       ,''
       ,null
       ,null
       ,2
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 3);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,4
       ,'def_update_inv'
       ,'N'
       ,'Y'
       ,'def_update_inv'
       ,'def_update_inv||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 4);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6
       ,2
       ,'1'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_1)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.2
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,2
       ,'2'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_2)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.2
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.3
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,2
       ,'3'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_3)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.3
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.4
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,2
       ,'4'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_4)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.4
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,7
       ,1
       ,'1'
       ,'N'
       ,'Y'
       ,'line7'
       ,'''"7'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 7
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,7
       ,2
       ,'boq_sta_item_code'
       ,'N'
       ,'Y'
       ,'boq_sta_item_code'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 7
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,7
       ,3
       ,'boq_est_quantitiy'
       ,'N'
       ,'Y'
       ,'boq_est_quantitiy'
       ,'boq_est_quantity||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 7
                    AND  HHC_COLUMN_SEQ = 3);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_HD_JOIN_DEFS
--
-- select * from mai_metadata.hig_hd_join_defs
-- order by hht_hhu_hhm_module
--         ,hht_hhu_seq
--         ,hht_join_seq
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_hd_join_defs
SET TERM OFF

INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2510'
       ,2
       ,493
       ,'TABLE'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHT_HHU_SEQ = 2
                    AND  HHT_JOIN_SEQ = 493);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2510'
       ,3
       ,494
       ,'TABLE'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHT_HHU_SEQ = 3
                    AND  HHT_JOIN_SEQ = 494);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2510'
       ,3
       ,496
       ,'TABLE'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHT_HHU_SEQ = 3
                    AND  HHT_JOIN_SEQ = 496);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2510'
       ,5
       ,495
       ,'TABLE'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHT_HHU_SEQ = 5
                    AND  HHT_JOIN_SEQ = 495);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2520'
       ,1
       ,1
       ,'TABLE'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2520'
       ,3
       ,1
       ,'TABLE'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHT_HHU_SEQ = 3
                    AND  HHT_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2520'
       ,3
       ,2
       ,'TABLE'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHT_HHU_SEQ = 3
                    AND  HHT_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530'
       ,1
       ,1
       ,'TABLE'
       ,'join to line 2' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530'
       ,1
       ,2
       ,'TABLE'
       ,'join to line 3' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530'
       ,1
       ,3
       ,'TABLE'
       ,'join to line 4' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 3);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,2
       ,'TABLE'
       ,'to line 2' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,3
       ,'TABLE'
       ,'to line 3' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 3);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,4
       ,'TABLE'
       ,'to line 4' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 4);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,5
       ,'TABLE'
       ,'to line 5' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 5);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.2
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6.2);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.3
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6.3);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.4
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6.4);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,7
       ,'TABLE'
       ,'to line 7 (boq_items)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 7);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_HD_TABLE_JOIN_COLS
--
-- select * from mai_metadata.hig_hd_table_join_cols
-- order by hhj_hht_hhu_hhm_module
--         ,hhj_hht_hhu_parent_table
--         ,hhj_hht_join_seq
--         ,hhj_parent_col
--         ,hhj_hhu_child_table
--         ,hhj_child_col
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_hd_table_join_cols
SET TERM OFF

INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2510'
       ,2
       ,493
       ,'NE_ID'
       ,3
       ,'ARE_RSE_HE_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 2
                    AND  HHJ_HHT_JOIN_SEQ = 493
                    AND  HHJ_PARENT_COL = 'NE_ID'
                    AND  HHJ_HHU_CHILD_TABLE = 3
                    AND  HHJ_CHILD_COL = 'ARE_RSE_HE_ID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2510'
       ,3
       ,494
       ,'ARE_REPORT_ID'
       ,5
       ,'DEF_ARE_REPORT_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 3
                    AND  HHJ_HHT_JOIN_SEQ = 494
                    AND  HHJ_PARENT_COL = 'ARE_REPORT_ID'
                    AND  HHJ_HHU_CHILD_TABLE = 5
                    AND  HHJ_CHILD_COL = 'DEF_ARE_REPORT_ID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2510'
       ,3
       ,496
       ,'ARE_REPORT_ID'
       ,4
       ,'ARL_ARE_REPORT_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 3
                    AND  HHJ_HHT_JOIN_SEQ = 496
                    AND  HHJ_PARENT_COL = 'ARE_REPORT_ID'
                    AND  HHJ_HHU_CHILD_TABLE = 4
                    AND  HHJ_CHILD_COL = 'ARL_ARE_REPORT_ID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2510'
       ,5
       ,495
       ,'DEF_DEFECT_ID'
       ,6
       ,'REP_DEF_DEFECT_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2510'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 5
                    AND  HHJ_HHT_JOIN_SEQ = 495
                    AND  HHJ_PARENT_COL = 'DEF_DEFECT_ID'
                    AND  HHJ_HHU_CHILD_TABLE = 6
                    AND  HHJ_CHILD_COL = 'REP_DEF_DEFECT_ID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2520'
       ,1
       ,1
       ,'rse_unique'
       ,2
       ,'rse_unique' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 1
                    AND  HHJ_PARENT_COL = 'rse_unique'
                    AND  HHJ_HHU_CHILD_TABLE = 2
                    AND  HHJ_CHILD_COL = 'rse_unique');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2520'
       ,3
       ,1
       ,'valid_act_name'
       ,4
       ,'valid_act_name' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 3
                    AND  HHJ_HHT_JOIN_SEQ = 1
                    AND  HHJ_PARENT_COL = 'valid_act_name'
                    AND  HHJ_HHU_CHILD_TABLE = 4
                    AND  HHJ_CHILD_COL = 'valid_act_name');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2520'
       ,3
       ,2
       ,'valid_act_name'
       ,5
       ,'valid_act_name' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2520'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 3
                    AND  HHJ_HHT_JOIN_SEQ = 2
                    AND  HHJ_PARENT_COL = 'valid_act_name'
                    AND  HHJ_HHU_CHILD_TABLE = 5
                    AND  HHJ_CHILD_COL = 'valid_act_name');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530'
       ,1
       ,1
       ,'ROWID'
       ,2
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 1
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 2
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530'
       ,1
       ,2
       ,'ROWID'
       ,3
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 2
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 3
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530'
       ,1
       ,3
       ,'ROWID'
       ,4
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 3
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 4
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,2
       ,'ROWID'
       ,2
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 2
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 2
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,3
       ,'ROWID'
       ,3
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 3
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 3
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,4
       ,'ROWID'
       ,4
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 4
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 4
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,5
       ,'ROWID'
       ,5
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 5
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 5
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6
       ,'ROWID'
       ,6
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 6
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 6
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.2
       ,'ROWID'
       ,6.2
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 6.2
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 6.2
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.3
       ,'ROWID'
       ,6.3
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 6.3
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 6.3
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.4
       ,'ROWID'
       ,6.4
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 6.4
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 6.4
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,7
       ,'DEF_DEFECT_ID'
       ,7
       ,'BOQ_DEFECT_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 7
                    AND  HHJ_PARENT_COL = 'DEF_DEFECT_ID'
                    AND  HHJ_HHU_CHILD_TABLE = 7
                    AND  HHJ_CHILD_COL = 'BOQ_DEFECT_ID');
--
--
--
----------------------------------------------------------------------------------------

--
COMMIT;
--
set feedback on
set define on
--
-------------------------------
-- END OF GENERATED METADATA --
-------------------------------
--
