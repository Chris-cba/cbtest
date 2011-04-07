-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/maidata2.sql-arc   2.15   Apr 07 2011 10:28:42   Mike.Alexander  $
--       Module Name      : $Workfile:   maidata2.sql  $
--       Date into PVCS   : $Date:   Apr 07 2011 10:28:42  $
--       Date fetched Out : $Modtime:   Apr 07 2011 10:25:24  $
--       Version          : $Revision:   2.15  $
--       Table Owner      : MAI_METADATA
--       Generation Date  : 07-APR-2011 10:25
--
--   Product metadata script
--   As at Release 4.4.0.0
--
--   Copyright (c) exor corporation ltd, 2011
--
--   TABLES PROCESSED
--   ================
--   GRI_MODULES
--   GRI_PARAMS
--   GRI_MODULE_PARAMS
--   GRI_PARAM_DEPENDENCIES
--   GRI_PARAM_LOOKUP
--   LOAD_ERRORS
--   NM_AU_TYPES
--
-----------------------------------------------------------------------------


set define off;
set feedback off;

---------------------------------
-- START OF GENERATED METADATA --
---------------------------------


----------------------------------------------------------------------------------------
-- GRI_MODULES
--
-- select * from mai_metadata.gri_modules
-- order by grm_module
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT gri_modules
SET TERM OFF

INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI1230'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI1230');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI1808'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI1808');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI1840'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI1840');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2100C'
       ,'SVR'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2100C');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2105C'
       ,'SVR'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2105C');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2110C'
       ,'SVR'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2110C');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2115'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2115');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2200R'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2200R');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2210'
       ,'SVR'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2210');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2220'
       ,'N/A'
       ,'${PROD_HOME}/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,55
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2220');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2222'
       ,'N/A'
       ,'${PROD_HOME}/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,55
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2222');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2224'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lst'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,54
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2224');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2320'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2320');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2330'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2330');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2500'
       ,'SVR'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2500');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2501'
       ,'SVR'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2501');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2510'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2510');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2520'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2520');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2521'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'R25'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2521');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI2780'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI2780');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI30060'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI30060');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3100'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3100');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3105'
       ,'N/A'
       ,'${PROD_HOME}/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,55
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3105');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3250'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3250');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3470'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3470');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3480'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3480');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3485'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3485');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3490'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3490');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3500'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3500');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3505'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3505');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3515'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3515');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3516'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3516');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3517'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3517');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3518'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS_ALL'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3518');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3691'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3691');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3693'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3693');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3830'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3830');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3834'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3834');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3840'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3840');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3841'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3841');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3850'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3850');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3852'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3852');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3858'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3858');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3859'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'ord'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3859');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3863'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'ped'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3863');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3865'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3865');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3900'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3900');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3902'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,'ROAD_SEGS'
       ,'RSE_HE_ID'
       ,'RSE_TYPE=''S'' AND RSE_END_DATE'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3902');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3904'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3904');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3905'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3905');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3906'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3906');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3907'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3907');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3908'
       ,'N/A'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3908');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3909'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3909');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3910'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3910');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3911'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3911');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3912'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3912');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3916'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3916');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3919'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3919');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3920'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3920');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3922'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3922');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3924'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3924');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3926'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3926');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3930'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3930');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3932'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3932');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3934'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3934');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3942'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3942');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3943'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3943');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3944'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3944');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3946'
       ,'R25'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3946');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3948'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3948');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3950'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3950');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3952'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3952');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3954'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3954');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3956'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3956');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3960'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3960');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3970'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3970');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3980'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3980');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3981'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3981');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3982'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3982');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3984'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3984');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3986'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3986');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3988'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3988');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3992'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3992');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI3994'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'Y'
       ,'ROAD_SECTIONS'
       ,'RSE_HE_ID'
       ,'RSE_END_DATE IS NULL'
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3994');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5001'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5001');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5010'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5010');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5011'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5011');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5015'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5015');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5018'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5018');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5021'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5021');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5022'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,46
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5022');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5024'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5024');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5025'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5025');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5027'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5027');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5030'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5030');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5031'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5031');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5032'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5032');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5034A'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5034A');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5034B'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5034B');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5035A'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5035A');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5035B'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5035B');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5037'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5037');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5037A'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5037A');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5038'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5038');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5050'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5050');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5050D'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5050D');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5060'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5060');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5065'
       ,'R25'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5065');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5070'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5070');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5075'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5075');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5080'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5080');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5090'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5090');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5100'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5100');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5125'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5125');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5130'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5130');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5200'
       ,'R25'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5200');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5205'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5205');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5210'
       ,'R25'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5210');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5215'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5215');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5220'
       ,'R25'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5220');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5225'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5225');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5235'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5235');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI5240'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI5240');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI6100'
       ,'N/A'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI6100');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI6110'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI6110');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI6120'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,80
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI6120');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI7040'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'R25'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI7040');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI8000'
       ,'N/A'
       ,'$PROD_HOME/BIN'
       ,'lis'
       ,'Y'
       ,'WORK_ORDERS'
       ,'WOR_WORKS_ORDER_NO'
       ,''
       ,80
       ,80
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI8000');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI9010'
       ,'SQL'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI9010');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAI9020'
       ,'R25'
       ,'$PROD_HOME\bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,66
       ,132
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI9020');
--
INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT 
        'MAICRVW'
       ,'R25'
       ,'$PROD_HOME/bin'
       ,'lis'
       ,'N'
       ,''
       ,''
       ,''
       ,132
       ,66
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAICRVW');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- GRI_PARAMS
--
-- select * from mai_metadata.gri_params
-- order by gp_param
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT gri_params
SET TERM OFF

INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'ACTIVITY'
       ,'CHAR'
       ,'ACTIVITIES'
       ,'ATV_ACTY_AREA_CODE'
       ,'ATV_DESCR'
       ,'ATV_ACTY_AREA_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'ACTIVITY2'
       ,'CHAR'
       ,'ACTIVITIES'
       ,'ATV_ACTY_AREA_CODE'
       ,'ATV_DESCR'
       ,'ATV_ACTY_AREA_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'ACTIVITY2');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'ACTIVITY_GROUP'
       ,'CHAR'
       ,'ACTIVITY_GROUPS'
       ,'ACG_GROUP_CODE'
       ,'ACG_DESCR'
       ,'ACG_GROUP_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'ACTIVITY_GROUP');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'ANSWER2'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'ANSWER2');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'ASSET'
       ,'NUMBER'
       ,'INV_ITEMS_ALL'
       ,'IIT_ITEM_ID'
       ,'IIT_ITY_INV_CODE'
       ,'IIT_PRIMARY_KEY'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'ASSET');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'A_OR_G'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'A_OR_G');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'A_OR_R'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'A_OR_R');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'BATCH_ID'
       ,'NUMBER'
       ,'ACTIVITIES_REPORT'
       ,'ARE_BATCH_ID'
       ,'TO_CHAR(ARE_DATE_WORK_DONE)'
       ,'ARE_BATCH_ID'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'BATCH_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'CHAINAGE2'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'COMMIT_PER_ROWS'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'COMMIT_PER_ROWS');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'CONTRACTOR_CODE'
       ,'CHAR'
       ,'ORG_UNITS'
       ,'OUN_CONTRACTOR_ID'
       ,'OUN_NAME'
       ,'OUN_CONTRACTOR_ID'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'CONTRACTOR_CODE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'CONTRACT_ID'
       ,'NUMBER'
       ,'CONTRACTS'
       ,'CON_ID'
       ,'CON_NAME'
       ,'CON_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'CONTRACT_STATUS'
       ,'CHAR'
       ,'HIG_STATUS_CODES'
       ,'HSC_STATUS_CODE'
       ,'HSC_STATUS_NAME'
       ,'HSC_STATUS_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'CONTRACT_STATUS');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'CW_HG_KB'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'CW_HG_KB');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'C_OR_I'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'C_OR_I');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'C_OR_O'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'C_OR_O');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'DEFECT_ID'
       ,'NUMBER'
       ,'DEFECTS'
       ,'DEF_DEFECT_ID'
       ,'DEF_LOCN_DESCR'
       ,'DEF_DEFECT_ID'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'DEFECT_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'DEFECT_PRIORITY'
       ,'CHAR'
       ,'HIG_CODES'
       ,'HCO_CODE'
       ,'HCO_MEANING'
       ,'HCO_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'DEFECT_TYPE'
       ,'CHAR'
       ,'DEF_TYPES'
       ,'DTY_DEFECT_CODE'
       ,'DTY_DESCR1'
       ,'DTY_DEFECT_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'DEFECT_TYPE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'DEF_STATUS'
       ,'CHAR'
       ,'HIG_STATUS_CODES'
       ,'HSC_STATUS_CODE'
       ,'HSC_STATUS_NAME'
       ,'HSC_STATUS_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'DEF_STATUS');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'DIRECTORY'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'LOWER'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'DIRECTORY');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'DISCIPLINE'
       ,'CHAR'
       ,'HIG_CODES'
       ,'HCO_CODE'
       ,'HCO_MEANING'
       ,'HCO_CODE'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'DISCIPLINE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'FILENAME'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'LOWER'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'FILENAME');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'FILETYPE'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'FILETYPE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'FINANCIAL_YEAR'
       ,'CHAR'
       ,'FINANCIAL_YEARS'
       ,'FYR_ID'
       ,'FYR_ID'
       ,'FYR_ID'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'FINANCIAL_YEAR');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'FROM_ASSET'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'FROM_ASSET');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'FROM_DATE'
       ,'DATE'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'F_OR_M'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'F_OR_M');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'GANG'
       ,'NUMBER'
       ,'HIG_CODES'
       ,'TO_NUMBER(HCO_CODE)'
       ,'HCO_MEANING'
       ,'HCO_CODE'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'GANG');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'INITIATION_TYPE'
       ,'CHAR'
       ,'HIG_CODES'
       ,'HCO_CODE'
       ,'HCO_MEANING'
       ,'HCO_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'INITIATION_TYPE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'INSPECTION_TYPE'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'INSPECTION_TYPE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'INSP_BATCH'
       ,'NUMBER'
       ,'HH_LOAD_BATCHES'
       ,'BATCH_ID'
       ,'TO_CHAR(BATCH_ID)'
       ,'BATCH_ID'
       ,'NUMBER'
       ,'CHAR'
       ,'BATCH_ID'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'INSP_BATCH');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'INVENTORY_GROUP'
       ,'CHAR'
       ,'HIG_CODES'
       ,'HCO_CODE'
       ,'HCO_MEANING'
       ,'HCO_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'INVENTORY_GROUP');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'INVENTORY_ITEM'
       ,'CHAR'
       ,'INV_ITEM_TYPES'
       ,'ITY_INV_CODE'
       ,'ITY_DESCR'
       ,'ITY_INV_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'INVENTORY_ITEM2'
       ,'CHAR'
       ,'INV_ITEM_TYPES'
       ,'ITY_INV_CODE'
       ,'ITY_DESCR'
       ,'ITY_INV_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'INVENTORY_ITEM2');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'INV_ATTRI_DOMAINS'
       ,'CHAR'
       ,'INV_ATTRI_DOMAINS'
       ,'IAD_VALUE'
       ,'IAD_MEANING'
       ,'IAD_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'INV_ATTRI_DOMAINS');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'LOCAL_DTP'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'LP_OR_OTHER'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'LP_OR_OTHER');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'MAI_P_DEL_REV'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'MAI_P_DEL_REV');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'MATERIAL'
       ,'CHAR'
       ,'INV_ATTRI_DOMAINS'
       ,'IAD_VALUE'
       ,'IAD_MEANING'
       ,'IAD_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'MATERIAL');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'M_OR_I'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'M_OR_I');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'NM_ELEMENT'
       ,'NUMBER'
       ,'NM_ELEMENTS'
       ,'NE_ID'
       ,'NE_DESCR'
       ,'NE_UNIQUE'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,''
       ,'NW_ALL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'NM_ELEMENT');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'NOTICE_ID'
       ,'NUMBER'
       ,'NOTICES'
       ,'NOT_ID'
       ,'TO_CHAR(NOT_DATE_PRINTED)'
       ,'NOT_ID'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'NOTICE_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'NOTIFY_ORG'
       ,'NUMBER'
       ,'ORG_UNITS'
       ,'OUN_ORG_ID'
       ,'OUN_NAME'
       ,'OUN_UNIT_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'NOTIFY_ORG');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'ORDER_SHEET_BOTH'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'ORDER_SHEET_BOTH');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'O_OR_P'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'O_OR_P');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'PBI_QRY'
       ,'CHAR'
       ,'PBI_QUERY'
       ,'QRY_ABBREV'
       ,'QRY_ABBREV'
       ,'QRY_ABBREV'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,'UPPER'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'PBI_QRY');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'PEDFILE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'PEDFILE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'REPAIR_TYPE'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'REPAIR_TYPE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'ROAD_ID'
       ,'NUMBER'
       ,'ROAD_SEGMENTS_ALL'
       ,'RSE_HE_ID'
       ,'RSE_DESCR'
       ,'RSE_UNIQUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'RUN_NUM'
       ,'NUMBER'
       ,'HHINV_RUN_LOG'
       ,'RUN_NUM'
       ,'TO_CHAR(RUN_NUM)'
       ,'RUN_NUM'
       ,'NUMBER'
       ,'CHAR'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'RUN_NUM');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'R_OR_C_OR_A'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'R_OR_C_OR_A');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'R_OR_T'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'R_OR_T');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SCHD_ID'
       ,'NUMBER'
       ,'SCHEDULES'
       ,'SCHD_ID'
       ,'SCHD_NAME'
       ,'SCHD_ID'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SCHD_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SCHEME_PRIORITY1'
       ,'NUMBER'
       ,'SCHEMES'
       ,'PRIORITY1'
       ,'PRIORITY1'
       ,'PRIORITY1'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SCHEME_PRIORITY1');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SCHEME_PRIORITY2'
       ,'NUMBER'
       ,'SCHEMES'
       ,'PRIORITY2'
       ,'PRIORITY2'
       ,'PRIORITY2'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SCHEME_PRIORITY2');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SCHEME_TYPE'
       ,'CHAR'
       ,'HIG_CODES'
       ,'HCO_CODE'
       ,'HCO_MEANING'
       ,'HCO_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SCHEME_TYPE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SISS_ID'
       ,'CHAR'
       ,'STANDARD_ITEM_SUB_SECTIONS'
       ,'SISS_ID'
       ,'SISS_NAME'
       ,'SISS_ID'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SIS_ID'
       ,'CHAR'
       ,'STANDARD_ITEM_SECTIONS'
       ,'SIS_ID'
       ,'SIS_NAME'
       ,'SIS_ID'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SIS_ID');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'STA_ITEM_CODE'
       ,'CHAR'
       ,'STANDARD_ITEMS'
       ,'STA_ITEM_CODE'
       ,'STA_ITEM_NAME'
       ,'STA_ITEM_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'STA_ITEM_CODE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'STOP_FROM'
       ,'CHAR'
       ,'INV_ITEMS_ALL'
       ,'IIT_PRIMARY_KEY'
       ,'IIT_PRIMARY_KEY'
       ,'IIT_PRIMARY_KEY'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'STOP_FROM');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'STOP_TO'
       ,'CHAR'
       ,'INV_ITEMS_ALL'
       ,'IIT_PRIMARY_KEY'
       ,'IIT_PRIMARY_KEY'
       ,'IIT_PRIMARY_KEY'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'STOP_TO');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SVR_FORMAT'
       ,'CHAR'
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_DESCR'
       ,'GPL_VALUE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SVR_FORMAT');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'SVR_HH_LOAD_BATCH'
       ,'NUMBER'
       ,'HH_LOAD_RECS B'
       ,'B.BATCH_ID'
       ,'TO_CHAR(BATCH_ID)'
       ,'BATCH_ID'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'SVR_HH_LOAD_BATCH');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'TARGET_FROM_DATE'
       ,'DATE'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'TARGET_FROM_DATE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'TARGET_TO_DATE'
       ,'DATE'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'TARGET_TO_DATE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'TO_ASSET'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'TO_ASSET');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'TO_DATE'
       ,'DATE'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'TRADE'
       ,'CHAR'
       ,'STANDARD_ITEMS'
       ,'STA_ITEM_CODE'
       ,'STA_ITEM_NAME'
       ,'STA_ITEM_CODE'
       ,'CHAR'
       ,'CHAR'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'TRADE');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'TREATMENT'
       ,'CHAR'
       ,'TREATMENTS'
       ,'TRE_TREAT_CODE'
       ,'TRE_DESCR'
       ,'TRE_TREAT_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'TREATMENT');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'WORKS_ORDER_NO2'
       ,'CHAR'
       ,'WORK_ORDERS'
       ,'WOR_WORKS_ORDER_NO'
       ,'RPAD(SUBSTR(WOR_DESCR,1,35),35)||''  ''||TO_CHAR(WOR_DATE_CONFIRMED)'
       ,'WOR_WORKS_ORDER_NO'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'WORKS_ORDER_NO2');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'WORK_CATEGORY'
       ,'CHAR'
       ,'ITEM_CODE_BREAKDOWNS'
       ,'ICB_WORK_CODE'
       ,'ICB_WORK_CATEGORY_NAME'
       ,'ICB_WORK_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'WORK_CATEGORY');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'WORK_SHEET_NO'
       ,'NUMBER'
       ,'WORK_ORDER_LINES'
       ,'WOL_WORK_SHEET_NO'
       ,'TO_CHAR(WOL_WORK_SHEET_DATE)'
       ,'WOL_WORK_SHEET_NO'
       ,'NUMBER'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'WORK_SHEET_NO');
--
INSERT INTO GRI_PARAMS
       (GP_PARAM
       ,GP_PARAM_TYPE
       ,GP_TABLE
       ,GP_COLUMN
       ,GP_DESCR_COLUMN
       ,GP_SHOWN_COLUMN
       ,GP_SHOWN_TYPE
       ,GP_DESCR_TYPE
       ,GP_ORDER
       ,GP_CASE
       ,GP_GAZ_RESTRICTION
       )
SELECT 
        'WORK_STATUS'
       ,'CHAR'
       ,'HIG_STATUS_CODES'
       ,'HSC_STATUS_CODE'
       ,'HSC_STATUS_NAME'
       ,'HSC_STATUS_CODE'
       ,'CHAR'
       ,''
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAMS
                   WHERE GP_PARAM = 'WORK_STATUS');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- GRI_MODULE_PARAMS
--
-- select * from mai_metadata.gri_module_params
-- order by gmp_module
--         ,gmp_param
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT gri_module_params
SET TERM OFF

INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI1230'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI1230'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI1230'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI1230'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI1808'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI1808'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI1808'
       ,'ORG_CODE'
       ,3
       ,'Organisation Code'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE = :ORG_TYPE OR :ORG_TYPE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI1808'
                    AND  GMP_PARAM = 'ORG_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI1808'
       ,'ORG_TYPE'
       ,2
       ,'Organisation Type'
       ,'Y'
       ,1
       ,'HCO_DOMAIN = ''ORG_UNIT_TYPE'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI1808'
                    AND  GMP_PARAM = 'ORG_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI1840'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI1840'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2100C'
       ,'ANSWER'
       ,2
       ,'Allow Duplicate Sections'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'Enter Y to Allow Duplicate Sections/Inventories to be loaded'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2100C'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2100C'
       ,'LOADER_FILE'
       ,3
       ,'Load File Path'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Enter pathname of load file'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2100C'
                    AND  GMP_PARAM = 'LOADER_FILE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2100C'
       ,'SVR_FORMAT'
       ,1
       ,'Update'
       ,'Y'
       ,1
       ,'GPL_PARAM=''SVR_FORMAT'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'Enter U for Update Mode'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2100C'
                    AND  GMP_PARAM = 'SVR_FORMAT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2110C'
       ,'ANSWER'
       ,1
       ,'Continue'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'Enter Y to continue'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2110C'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2115'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2115'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2115'
       ,'CHAINAGE'
       ,3
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2115'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2115'
       ,'CHAINAGE2'
       ,4
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2115'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2115'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2115'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2200R'
       ,'BATCH_ID'
       ,1
       ,'Inspection Batch Id'
       ,'Y'
       ,1
       ,'are_report_id IN (SELECT max_are_report_id FROM v_are_batch_grouping are1 WHERE are1.are_batch_id = NVL (:batch_id, are1.are_batch_id)) ORDER BY TO_NUMBER (are_batch_id)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2200R'
                    AND  GMP_PARAM = 'BATCH_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2210'
       ,'LOCAL_DTP'
       ,1
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE = ''D'' and GPL_PARAM = ''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2210'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2210'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL and rse_sys_flag = nvl(:LOCAL_DTP,rse_sys_flag) and rse_sys_flag = nvl(:LOCAL_DTP,rse_sys_flag)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2210'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2220'
       ,'EFFECTIVE_DATE'
       ,2
       ,'Effective Date'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the date at which the data is effective.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2220'
                    AND  GMP_PARAM = 'EFFECTIVE_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2220'
       ,'HIG_USER_ID'
       ,3
       ,'Person Identification'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USERS'
       ,'HUS_USER_ID'
       ,'HUS_USERNAME = USER'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,'Enter initials of responsible person'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2220'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2222'
       ,'EFFECTIVE_DATE'
       ,2
       ,'Effective Date'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the date at which the data is effective.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2222'
                    AND  GMP_PARAM = 'EFFECTIVE_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2222'
       ,'HIG_USER_ID'
       ,3
       ,'Person Identification'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USERS'
       ,'HUS_USER_ID'
       ,'HUS_USERNAME = USER'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,'Enter initials of responsible person'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2222'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2224'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2224'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2224'
       ,'EFFECTIVE_DATE'
       ,2
       ,'Effective Date'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the date from which the data is effective.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2224'
                    AND  GMP_PARAM = 'EFFECTIVE_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2224'
       ,'HIG_USER_ID'
       ,6
       ,'Person Identification'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USERS'
       ,'HUS_USER_ID'
       ,'HUS_USERNAME = USER'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,'Enter initials of responsible person'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2224'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2224'
       ,'ROAD_ID'
       ,4
       ,'Road Id'
       ,'Y'
       ,20
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,'Enter the road identification (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2224'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2224'
       ,'ROAD_TYPE'
       ,3
       ,'Road Type'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,'Enter the road type.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2224'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2320'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2320'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2320'
       ,'ROAD_ID'
       ,2
       ,'Road Section'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL AND RSE_TYPE=''S'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,'Enter a Road Section, not a Road Group'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2320'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2330'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2330'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2330'
       ,'FROM_DATE'
       ,3
       ,'Date From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2330'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2330'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2330'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2330'
       ,'TO_DATE'
       ,4
       ,'Date To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2330'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2500'
       ,'INVENTORY_GROUP'
       ,2
       ,'Inventory Group'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''INVENTORY_GROUPS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'ENter the Inventory Group'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2500'
                    AND  GMP_PARAM = 'INVENTORY_GROUP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2500'
       ,'INVENTORY_ITEM'
       ,3
       ,'Inventory Item'
       ,'N'
       ,15
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Inventory Item, leave blank for all items'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2500'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2500'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2500'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2501'
       ,'INVENTORY_ITEM'
       ,2
       ,'Inventory Item'
       ,'N'
       ,15
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Inventory Item, leave blank for all items'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2501'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2501'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2501'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'ACTIVITY'
       ,6
       ,'Activity'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,'='
       ,'DEFECTS'
       ,'DEF_ATV_ACTY_AREA_CODE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'ACTIVITY2'
       ,7
       ,'Scheduled activity'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,'='
       ,'ACT_REPORT_LINES'
       ,'ARL_ATV_ACTY_AREA_CODE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'ACTIVITY2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'DEFECT_PRIORITY'
       ,9
       ,'Defect category'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,'='
       ,'DEFECTS'
       ,'DEF_PRIORITY'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'DEFECT_TYPE'
       ,10
       ,'Defect Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,'='
       ,'DEFECTS'
       ,'DEF_DEFECT_CODE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'DEFECT_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'DIRECTORY'
       ,11
       ,'Output directory'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_HUS_USER_ID = (SELECT HUS_USER_ID FROM HIG_USERS WHERE HUS_USERNAME = USER) AND  HUO_ID = ''UTL_DIR'''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'DIRECTORY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'FILENAME'
       ,12
       ,'Output Filename'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'FILENAME');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'FROM_DATE'
       ,4
       ,'Inspections on or after'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,'>='
       ,'ACTIVITIES_REPORT'
       ,'ARE_DATE_WORK_DONE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'INITIATION_TYPE'
       ,3
       ,'Reason for inspection'
       ,'N'
       ,1
       ,'HCO_DOMAIN = ''INITIATION_TYPE'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,'='
       ,'ACTIVITIES_REPORT'
       ,'ARE_INITIATION_TYPE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'INITIATION_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'INSPECTION_TYPE'
       ,2
       ,'The type of inspection'
       ,'N'
       ,1
       ,'GPL_PARAM = ''INSPECTION_TYPE'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,'='
       ,'ACTIVITIES_REPORT'
       ,'ARE_MAINT_INSP_FLAG'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'INSPECTION_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'INVENTORY_ITEM'
       ,8
       ,'Inventory'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,'='
       ,'DEFECTS'
       ,'DEF_ITY_INV_CODE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'ROAD_ID'
       ,1
       ,'The road section'
       ,'N'
       ,6
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,'='
       ,'NM_ELEMENTS'
       ,'NE_ID'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2510'
       ,'TO_DATE'
       ,5
       ,'Inspections on or before'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,'<='
       ,'ACTIVITIES_REPORT'
       ,'ARE_DATE_WORK_DONE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2510'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2520'
       ,'COMMIT_PER_ROWS'
       ,3
       ,'Commit Per rows'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'DUAL'
       ,'0'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Commit per <num> rows. Value 0 will commit only if the input succeeds'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2520'
                    AND  GMP_PARAM = 'COMMIT_PER_ROWS');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2520'
       ,'DIRECTORY'
       ,1
       ,'RIRF file directory'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2520'
                    AND  GMP_PARAM = 'DIRECTORY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2520'
       ,'FILENAME'
       ,2
       ,'Filename'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2520'
                    AND  GMP_PARAM = 'FILENAME');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2780'
       ,'ACTIVITY'
       ,2
       ,'Activity Area'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select an Activity Area, leave blank for all Activity Areas'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2780'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI2780'
       ,'SCHEME_TYPE'
       ,1
       ,'Scheme Type'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''SCHEME_TYPES'''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select a Scheme Type, leave blank for all Scheme Types'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI2780'
                    AND  GMP_PARAM = 'SCHEME_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI30060'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,''
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI30060'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI30060'
       ,'EFFECTIVE_DATE'
       ,5
       ,'Effective Date'
       ,'N'
       ,1
       ,':FROM_DATE IS NULL AND :START_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Use this date to see historical data AT this date'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI30060'
                    AND  GMP_PARAM = 'EFFECTIVE_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI30060'
       ,'FROM_DATE'
       ,3
       ,'Date From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULLAND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI30060'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI30060'
       ,'INVENTORY_GROUP'
       ,6
       ,'Inventory Group'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''INVENTORY_GROUPS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'ENter the Inventory Group'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI30060'
                    AND  GMP_PARAM = 'INVENTORY_GROUP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI30060'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI30060'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI30060'
       ,'TO_DATE'
       ,4
       ,'Date To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI30060'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'ACTIVITY'
       ,7
       ,'Activity Area'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Activity Area, leave null for all areas'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'A_NUMBER'
       ,9
       ,'Days Ahead'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'DUAL'
       ,'30'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the Number of days ahead if Reporting by time order'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'A_NUMBER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'CHAINAGE'
       ,4
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'CHAINAGE2'
       ,5
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'M_OR_I'
       ,6
       ,'Maintenance or Inspection'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''M_OR_I'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''M'' AND GPL_PARAM = ''M_OR_I'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter M for Maintenance Activities, I for Inspection Activities'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'M_OR_I');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'R_OR_T'
       ,8
       ,'Road or Time Order'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''R_OR_T'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''R'' AND GPL_PARAM = ''R_OR_T'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select R for Road Order, or T from Time Order'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'R_OR_T');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3100'
       ,'TEXT'
       ,10
       ,'Scheduled Initiation Types'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'DUAL'
       ,'''NRM,DUM'''
       ,''
       ,'N'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Comma Separated List Of Scheduled Initiation Types'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3100'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3105'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3105'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3105'
       ,'A_OR_R'
       ,3
       ,'Activity or Road'
       ,'N'
       ,1
       ,'GPL_PARAM = ''A_OR_R'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''A'' AND GPL_PARAM = ''A_OR_R'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select A for Report by Activity, R for Report by Road or leave blank for both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3105'
                    AND  GMP_PARAM = 'A_OR_R');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3105'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3105'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3250'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3250'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3250'
       ,'CHAINAGE'
       ,3
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the defect start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3250'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3250'
       ,'DEFECT_ID'
       ,6
       ,'Defect Id'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter a Defect Id or leave blank for all defects'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3250'
                    AND  GMP_PARAM = 'DEFECT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3250'
       ,'FROM_DATE'
       ,4
       ,'Start Date'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start date for Defects being recorded'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3250'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3250'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3250'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3250'
       ,'TO_DATE'
       ,5
       ,'End Date'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end date for Defects being recorded'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3250'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3470'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Work Order Number'
       ,'Y'
       ,1
       ,'WOR_FLAG = ''D'' AND WOR_CON_ID IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Work Order number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3470'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3480'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3480'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3485'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3485'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3490'
       ,'FROM_DATE'
       ,2
       ,'Date From'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3490'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3490'
       ,'LOCAL_DTP'
       ,4
       ,'Local or DoT Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT, or Leave Blank for All Roads'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3490'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3490'
       ,'R_OR_C_OR_A'
       ,1
       ,'Works Order Status'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''R_OR_C_OR_A'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''A'' AND GPL_PARAM = ''R_OR_C_OR_A'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select A for All, C for Complete or R for Raised Works Orders'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3490'
                    AND  GMP_PARAM = 'R_OR_C_OR_A');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3490'
       ,'TO_DATE'
       ,3
       ,'Date To'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3490'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3500'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3500'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'ANSWER'
       ,6
       ,'Cyclical Maintenance Only'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Y to restrict report to Cyclical Works Orders only'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'C_OR_O'
       ,8
       ,'Complete or Outstanding Works Orders'
       ,'N'
       ,1
       ,'GPL_PARAM = ''C_OR_O'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter C for Complete Orders, O for Outstanding Orders or leave blank for both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'C_OR_O');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'FROM_DATE'
       ,3
       ,'From Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'LOCAL_DTP'
       ,7
       ,'Local or DTp Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp, or Leave Blank for All Roads'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'SCHEME_TYPE'
       ,5
       ,'Scheme Type'
       ,'Y'
       ,1
       ,'HCO_DOMAIN = ''SCHEME_TYPES'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select a Scheme Type'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'SCHEME_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'TO_DATE'
       ,4
       ,'To Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3505'
       ,'WORK_CATEGORY'
       ,9
       ,'Work Category'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,'Enter the work category or partial work catgory with LIKE operator.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3505'
                    AND  GMP_PARAM = 'WORK_CATEGORY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3515'
       ,'ANSWER'
       ,3
       ,'Include Cost Values'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'N'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3515'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3515'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Start Range Order Number'
       ,'Y'
       ,1
       ,'WOR_DATE_CONFIRMED IS NOT NULL AND WOR_FLAG = ''D'' AND WOR_CON_ID IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Start range Work Order number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3515'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3515'
       ,'WORKS_ORDER_NO2'
       ,2
       ,'End Range Order Number'
       ,'N'
       ,1
       ,'WOR_DATE_CONFIRMED IS NOT NULL AND WOR_FLAG = ''D'' AND WOR_CON_ID IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Start range Work Order number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3515'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'ANSWER'
       ,10
       ,'Include Inactive (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'CONTRACTOR_CODE'
       ,4
       ,'Contractor Id'
       ,'Y'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ELECTRONIC_ORDERS_FLAG=''Y'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Contractor Identifier'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'CONTRACTOR_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'CONTRACT_ID'
       ,3
       ,'Contract Id'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'FROM_DATE'
       ,6
       ,'Raised Date From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'ROAD_TYPE'
       ,1
       ,'Road Type'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,'Enter the road type.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'TARGET_FROM_DATE'
       ,8
       ,'Target  Date From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'TARGET_FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'TARGET_TO_DATE'
       ,9
       ,'Target Date To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'TARGET_TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'TO_DATE'
       ,7
       ,'Raised Date To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3516'
       ,'TRADE'
       ,5
       ,'Trade'
       ,'N'
       ,1
       ,'STA_SISS_ID=''LBI'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Trade'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3516'
                    AND  GMP_PARAM = 'TRADE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3517'
       ,'SCHD_ID'
       ,3
       ,'Schedule Id'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3517'
                    AND  GMP_PARAM = 'SCHD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3517'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Start Range Order Number'
       ,'Y'
       ,1
       ,'WOR_DATE_CONFIRMED IS NOT NULL AND WOR_FLAG = ''M'' AND WOR_CON_ID IS NOT NULL AND UPPER(WOR_DESCR) NOT LIKE ''%CANCEL%'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Start range Work Order number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3517'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3517'
       ,'WORKS_ORDER_NO2'
       ,2
       ,'End Range Order Number'
       ,'N'
       ,1
       ,'WOR_DATE_CONFIRMED IS NOT NULL AND WOR_FLAG = ''M'' AND WOR_CON_ID IS NOT NULL AND UPPER(WOR_DESCR) NOT LIKE ''%CANCEL%'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Start range Work Order number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3517'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3518'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3518'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3518'
       ,'FROM_DATE'
       ,4
       ,'At Date'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3518'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3518'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3518'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3518'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3518'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3830'
       ,'A_NUMBER'
       ,2
       ,'Sequence No'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The sequence number to be used in the file name.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3830'
                    AND  GMP_PARAM = 'A_NUMBER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3830'
       ,'CONTRACTOR_CODE'
       ,1
       ,'Contractor Id'
       ,'Y'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ELECTRONIC_ORDERS_FLAG=''Y'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Contractor Identifier'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3830'
                    AND  GMP_PARAM = 'CONTRACTOR_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3830'
       ,'TEXT'
       ,3
       ,'File path'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID = ''INTERPATH'' AND HUO_HUS_USER_ID = (SELECT MAX(HUS_USER_ID) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'N'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The location the file is to be created. NOTE: Must be referenced in INIT.ORA'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3830'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3834'
       ,'A_NUMBER'
       ,2
       ,'Sequence No'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The sequence number to be used in the file name.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3834'
                    AND  GMP_PARAM = 'A_NUMBER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3834'
       ,'CONTRACTOR_ID'
       ,1
       ,'Contractor Id'
       ,'Y'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''CO'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Contractor Identifier'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3834'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3834'
       ,'TEXT'
       ,2
       ,'File path'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID = ''INTERPATH'' AND HUO_HUS_USER_ID = (SELECT MAX(HUS_USER_ID) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'N'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The location the file is to be created. NOTE: Must be referenced in INIT.ORA'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3834'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3834'
       ,'TO_DATE'
       ,3
       ,'Run Up To Date'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Optional. Processing will include work orders instructed up to this date.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3834'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3840'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3840'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3840'
       ,'ANSWER2'
       ,3
       ,'Apply VAT (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER2'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''Y'' AND GPL_PARAM=''ANSWER2'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3840'
                    AND  GMP_PARAM = 'ANSWER2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3840'
       ,'CONTRACT_ID'
       ,2
       ,'Contract Id'
       ,'N'
       ,1
       ,'(CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3840'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3841'
       ,'CONTRACT_ID'
       ,1
       ,'Select Contract'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Contract'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3841'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3850'
       ,'A_NUMBER'
       ,2
       ,'Sequence No'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The sequence number to be used in the file name.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3850'
                    AND  GMP_PARAM = 'A_NUMBER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3850'
       ,'CONTRACTOR_CODE'
       ,1
       ,'Contractor Id'
       ,'Y'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ELECTRONIC_ORDERS_FLAG=''Y'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Contractor Identifier'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3850'
                    AND  GMP_PARAM = 'CONTRACTOR_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3850'
       ,'FILENAME'
       ,2
       ,'Upload File'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Upload file for web'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3850'
                    AND  GMP_PARAM = 'FILENAME');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3850'
       ,'TEXT'
       ,3
       ,'File path'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID = ''INTERPATH'' AND HUO_HUS_USER_ID = (SELECT MAX(HUS_USER_ID) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'N'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The location in which the file resides. NOTE: Must be referenced in INIT.ORA'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3850'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3852'
       ,'A_NUMBER'
       ,2
       ,'Sequence No'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The sequence number to be used in the file name.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3852'
                    AND  GMP_PARAM = 'A_NUMBER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3852'
       ,'CONTRACTOR_CODE'
       ,1
       ,'Contractor Id'
       ,'Y'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ELECTRONIC_ORDERS_FLAG=''Y'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Contractor Identifier'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3852'
                    AND  GMP_PARAM = 'CONTRACTOR_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3852'
       ,'FILENAME'
       ,2
       ,'Upload File'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Upload file for web'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3852'
                    AND  GMP_PARAM = 'FILENAME');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3852'
       ,'TEXT'
       ,3
       ,'File path'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID = ''INTERPATH'' AND HUO_HUS_USER_ID = (SELECT MAX(HUS_USER_ID) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'N'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The location in which the file resides. NOTE: Must be referenced in INIT.ORA'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3852'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3858'
       ,'A_NUMBER'
       ,1
       ,'Sequence No'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The sequence number to be used in the file name.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3858'
                    AND  GMP_PARAM = 'A_NUMBER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3858'
       ,'TEXT'
       ,2
       ,'File path'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID = ''INTERPATH'' AND HUO_HUS_USER_ID = (SELECT MAX(HUS_USER_ID) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'N'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The location the file is to be created. NOTE: Must be referenced in INIT.ORA'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3858'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3859'
       ,'FILENAME'
       ,3
       ,'Input Filename'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the input filename. Do not enter a directory structure.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3859'
                    AND  GMP_PARAM = 'FILENAME');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3859'
       ,'FILETYPE'
       ,2
       ,'File Type'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''FILETYPE'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''W'' AND GPL_PARAM=''FILETYPE'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the filetype to output.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3859'
                    AND  GMP_PARAM = 'FILETYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3859'
       ,'TEXT'
       ,1
       ,'File path'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID = ''INTERPATH'' AND HUO_HUS_USER_ID = (SELECT MAX(HUS_USER_ID) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The location in which the file resides. NOTE: Must be referenced in INIT.ORA'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3859'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'ACTIVITY'
       ,4
       ,'Activity Area'
       ,'N'
       ,6
       ,'ATV_ACTY_AREA_CODE IN (SELECT AFR_ATV_ACTY_AREA_CODE FROM ACT_FREQS,INV_ITEM_TYPES WHERE NVL(AFR_ITY_INV_CODE,ITY_INV_CODE)=ITY_INV_CODE AND AFR_ITY_SYS_FLAG=ITY_SYS_FLAG AND ITY_ELEC_DRAIN_CARR=:DISCIPLINE)'
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select an Activity Area, leave blank for all Activity Areas'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'ACTIVITY_GROUP'
       ,4
       ,'Activity Group'
       ,'N'
       ,1
       ,'ACG_GROUP_CODE IN (SELECT AGM_GROUP_CODE FROM ACT_GROUP_MEMBS,ACT_FREQS,INV_ITEM_TYPES WHERE AGM_ACTY_CODE=AFR_ATV_ACTY_AREA_CODE AND NVL(AFR_ITY_INV_CODE,ITY_INV_CODE)=ITY_INV_CODE AND AFR_ITY_SYS_FLAG=ITY_SYS_FLAG AND ITY_ELEC_DRAIN_CARR=:DISCIPLINE)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Activity Group, leave blank for all Activity Groups'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'ACTIVITY_GROUP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'ANSWER'
       ,8
       ,'Hierarchical Inventory ?'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'N'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'ANSWER2'
       ,10
       ,'Restrict Inspector by AU'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'N'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Restrict the inspector listing by Administration Unit ?'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'ANSWER2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'DISCIPLINE'
       ,1
       ,'Discipline'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''INVENTORY_GROUPS'' AND SYSDATE BETWEEN NVL(HCO_START_DATE,SYSDATE) and NVL(HCO_END_DATE,SYSDATE) ORDER BY HCO_SEQ, HCO_CODE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'DISCIPLINE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'INVENTORY_ITEM'
       ,6
       ,'Inventory Item Type'
       ,'N'
       ,1
       ,'ITY_ELEC_DRAIN_CARR = NVL(:DISCIPLINE,ITY_ELEC_DRAIN_CARR) ORDER BY ITY_INV_CODE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'A valid inventory item type must be entered here'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'PEDFILE'
       ,9
       ,'Specified Filename'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID=''PEDFILE'' AND HUO_HUS_USER_ID=( SELECT HUS_USER_ID FROM HIG_USERS WHERE HUS_USERNAME=USER)'
       ,'N'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'PEDFILE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_GTY_GROUP_TYPE = :ROAD_TYPE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'Y'
       ,1
       ,'GTY_GROUP_TYPE != ''SECT'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'TEXT'
       ,5
       ,'File path'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,'HIG_USER_OPTIONS'
       ,'HUO_VALUE'
       ,'HUO_ID = ''INTERPATH'' AND HUO_HUS_USER_ID = (SELECT MAX(HUS_USER_ID) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'The location in which the file resides.NOTE: Must be referenced in INIT.ORA'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'TEXT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3863'
       ,'XSP'
       ,7
       ,'Inventory Item XSP'
       ,'N'
       ,5
       ,'HCO_DOMAIN = ''XSP_VALUES'' ORDER BY HCO_SEQ, HCO_CODE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'XSP of inventory, or leave blank for all'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3863'
                    AND  GMP_PARAM = 'XSP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'FROM_ASSET'
       ,8
       ,'From Asset'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'Y'
       ,'Enter the from asset range value'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'FROM_ASSET');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'FROM_DATE'
       ,4
       ,'From Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'HIG_USER_ID'
       ,7
       ,'Person Identification'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,'Enter initials of responsible person'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'INVENTORY_ITEM'
       ,6
       ,'Inventory Item'
       ,'N'
       ,15
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Inventory Item, leave blank for all items'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'TO_ASSET'
       ,9
       ,'To Asset'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'Y'
       ,'Enter the End asset range value'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'TO_ASSET');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3865'
       ,'TO_DATE'
       ,5
       ,'To Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3865'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'ANSWER'
       ,9
       ,'Include Comments (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'ANSWER2'
       ,10
       ,'End Dated Sections (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER2'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER2'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'ANSWER2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'BATCH_ID'
       ,6
       ,'Inspection Batch Id'
       ,'N'
       ,1
       ,'ARE_REPORT_ID IN ('||CHR(10)||'SELECT DISTINCT (SELECT Max(are_report_id) FROM  activities_report A WHERE A.are_batch_id = b.ARE_BATCH_ID ) are_id'||CHR(10)||'FROM activities_report b WHERE are_batch_id IS NOT NULL AND ARE_BATCH_ID = Nvl( :BATCH_ID, ARE_BATCH_ID)'||CHR(10)||') ORDER BY To_Number(ARE_BATCH_ID)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'BATCH_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'DEFECT_PRIORITY'
       ,7
       ,'Defect Priority'
       ,'N'
       ,5
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter value of Defect Priority (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'FROM_DATE'
       ,3
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'HIG_USER_ID'
       ,5
       ,'Inspector'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'NOTIFY_ORG'
       ,8
       ,'Notifiable Organisation'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''NO'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'NOTIFY_ORG');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'ROAD_TYPE'
       ,1
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3900'
       ,'TO_DATE'
       ,4
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3900'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3902'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3902'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3902'
       ,'DEFECT_ID'
       ,4
       ,'Defect Id'
       ,'Y'
       ,1
       ,'DEF_RSE_HE_ID IN ('||CHR(10)||'SELECT :ROAD_ID FROM DUAL UNION'||CHR(10)||'SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN =:ROAD_ID)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the defect id that you wish to report on.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3902'
                    AND  GMP_PARAM = 'DEFECT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3902'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3902'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3902'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3902'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'DEFECT_ID'
       ,8
       ,'Defect Id'
       ,'N'
       ,1
       ,'((:ROAD_ID IS NOT NULL AND DEF_RSE_HE_ID IN ('||CHR(10)||'SELECT :ROAD_ID FROM DUAL UNION'||CHR(10)||'SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN IN (:ROAD_ID))) OR  :ROAD_ID IS NULL)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'DEFECT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'DEFECT_PRIORITY'
       ,7
       ,'Defect Priority'
       ,'N'
       ,5
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter value of Defect Priority (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'FROM_DATE'
       ,5
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,9
       ,'Notice Id'
       ,'N'
       ,1
       ,':ROAD_TYPE IS NULL AND :ROAD_ID IS NULL AND :NOTIFY_ORG IS NULL AND :FROM_DATE IS NULL AND :TO_DATE IS NULL AND :DEFECT_PRIORITY IS NULL AND :DEFECT_ID IS NULL'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT DEF_RSE_HE_ID FROM DEFECTS,NOTICE_DEFECTS WHERE NOD_NOT_ID=:NOTICE_ID AND NOD_DEF_DEFECT_ID=DEF_DEFECT_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'NOTICE_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'NOTIFY_ORG'
       ,4
       ,'Notifiable Organisation'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''NO'' AND OUN_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (:ADMIN_UNIT)) AND OUN_ORG_ID NOT IN (SELECT OUN_ORG_ID FROM ORG_UNITS, HIG_OPTIONS WHERE OUN_UNIT_CODE=HOP_VALUE AND OUN_ORG_UNIT_TYPE=''NO'' AND HOP_ID=''UNKNOWNORG'')'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'NOTIFY_ORG');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3904'
       ,'TO_DATE'
       ,6
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3904'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3905'
       ,'CHAINAGE'
       ,2
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3905'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3905'
       ,'CHAINAGE2'
       ,3
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3905'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3905'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3905'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3906'
       ,'ANSWER'
       ,3
       ,'Print Lab Units (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3906'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3906'
       ,'ANSWER2'
       ,4
       ,'Print Target Repair Dates (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER2'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER2'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3906'
                    AND  GMP_PARAM = 'ANSWER2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3906'
       ,'ORDER_SHEET_BOTH'
       ,5
       ,'Wrks Ord/Ctrl Sht/Both'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ORDER_SHEET_BOTH'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''W'' AND GPL_PARAM=''ORDER_SHEET_BOTH'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter W - Works Order, C - Control Sheet, B - Both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3906'
                    AND  GMP_PARAM = 'ORDER_SHEET_BOTH');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3906'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'Y'
       ,1
       ,'WOR_FLAG = ''D'' AND WOR_CON_ID IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3906'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3906'
       ,'WORK_SHEET_NO'
       ,2
       ,'Work Sheet No'
       ,'N'
       ,1
       ,'WOL_WORKS_ORDER_NO IN (SELECT WOL_WORKS_ORDER_NO'||CHR(10)||'FROM WORK_ORDER_LINES'||CHR(10)||'WHERE WOL_WORKS_ORDER_NO = :WORKS_ORDER_NO'||CHR(10)||'AND WOL_WORK_SHEET_NO IS NOT NULL)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3906'
                    AND  GMP_PARAM = 'WORK_SHEET_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3907'
       ,'ANSWER'
       ,3
       ,'Print Lab Units (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3907'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3907'
       ,'ORDER_SHEET_BOTH'
       ,4
       ,'Wrks Ord/Ctrl Sht/Both'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ORDER_SHEET_BOTH'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''W'' AND GPL_PARAM=''ORDER_SHEET_BOTH'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter W - Works Order, C - Control Sheet, B - Both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3907'
                    AND  GMP_PARAM = 'ORDER_SHEET_BOTH');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3907'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'Y'
       ,1
       ,'WOR_FLAG = ''M'''||CHR(10)||'AND WOR_CON_ID IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3907'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3907'
       ,'WORK_SHEET_NO'
       ,2
       ,'Work Sheet No'
       ,'N'
       ,1
       ,'WOL_WORKS_ORDER_NO IN (SELECT WOL_WORKS_ORDER_NO FROM WORK_ORDER_LINES WHERE WOL_WORKS_ORDER_NO = :WORKS_ORDER_NO AND WOL_WORK_SHEET_NO IS NOT NULL)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3907'
                    AND  GMP_PARAM = 'WORK_SHEET_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3908'
       ,'ANSWER'
       ,2
       ,'Print Labour Units (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3908'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3908'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3908'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3909'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Confirmed Works Order No'
       ,'Y'
       ,1
       ,'WOR_DATE_CONFIRMED IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter a Confirmed Work Order number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3909'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG _PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'ASSET'
       ,3
       ,'Asset Reference'
       ,'N'
       ,1
       ,'IIT_END_DATE IS NULL AND ((:ROAD_ID IS NOT NULL AND IIT_RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF ='||CHR(10)||'RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN IN (:ROAD_ID))) OR :ROAD_ID IS NULL) AND IIT_PRIMARY_KEY IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'ASSET');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'DEFECT_PRIORITY'
       ,5
       ,'Defect Priority'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Defect Priority, leave Blank for all Priorities'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'DEF_STATUS'
       ,8
       ,'Defect Status'
       ,'N'
       ,1
       ,'HSC_DOMAIN_CODE=''DEFECTS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'DEF_STATUS');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'FROM_DATE'
       ,3
       ,'From Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'HIG_USER_ID'
       ,7
       ,'Inspector'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'SISS_ID'
       ,6
       ,'SISS'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3910'
       ,'TO_DATE'
       ,4
       ,'To Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3910'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3911'
       ,'ANSWER'
       ,2
       ,'Display Cost Values'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''Y'' AND GPL_PARAM=''ANSWER'''
       ,'N'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3911'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3911'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'N'
       ,20
       ,''
       ,'Y'
       ,'WOR_WORKS_ORDER_NO IN (:WORKS_ORDER_NO)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Specific Works Order No (Use Insert Record to specify more than one)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3911'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3912'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3912'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3912'
       ,'ANSWER'
       ,7
       ,'Overdue Responses Only (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3912'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3912'
       ,'FROM_DATE'
       ,5
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3912'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3912'
       ,'NOTIFY_ORG'
       ,4
       ,'Notifiable Organisation'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''NO'' AND OUN_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (:ADMIN_UNIT)) AND OUN_ORG_ID NOT IN (SELECT OUN_ORG_ID FROM ORG_UNITS, HIG_OPTIONS WHERE OUN_UNIT_CODE=HOP_VALUE AND OUN_ORG_UNIT_TYPE=''NO'' AND HOP_ID=''UNKNOWNORG'')'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3912'
                    AND  GMP_PARAM = 'NOTIFY_ORG');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3912'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3912'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3912'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3912'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3912'
       ,'TO_DATE'
       ,6
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR  (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3912'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3916'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'N'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3916'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3916'
       ,'FROM_DATE'
       ,4
       ,'Date Issued From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3916'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3916'
       ,'NOTIFY_ORG'
       ,6
       ,'Notifiable Organisation'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''NO'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3916'
                    AND  GMP_PARAM = 'NOTIFY_ORG');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3916'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3916'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3916'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3916'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3916'
       ,'TO_DATE'
       ,5
       ,'Date Issued To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3916'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3919'
       ,'ANSWER'
       ,1
       ,'Draft Report?'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3919'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3919'
       ,'WORKS_ORDER_NO'
       ,2
       ,'Confirmed Works Order No'
       ,'Y'
       ,1
       ,'WOR_WORKS_ORDER_NO IN (SELECT WOR_WORKS_ORDER_NO FROM WORK_ORDERS WHERE WOR_DATE_CONFIRMED IS NOT NULL AND :ANSWER = ''N'' UNION SELECT WOR_WORKS_ORDER_NO FROM WORK_ORDERS WHERE :ANSWER = ''Y'') '
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter a Confirmed Work Order number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3919'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'N'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'DEFECT_PRIORITY'
       ,7
       ,'Defect Priority'
       ,'N'
       ,5
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Defect Priority ( Use Insert Record for multiple Values )'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'DEFECT_TYPE'
       ,6
       ,'Defect Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'DEFECT_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'FROM_DATE'
       ,4
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'SISS_ID'
       ,8
       ,'SISS'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'STA_ITEM_CODE'
       ,9
       ,'Item Code'
       ,'N'
       ,1
       ,'((STA_SISS_ID= :SISS_ID) OR :SISS_ID IS NULL)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'STA_ITEM_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'TO_DATE'
       ,5
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3920'
       ,'XSP'
       ,10
       ,'XSP'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''XSP_VALUES'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3920'
                    AND  GMP_PARAM = 'XSP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'DEFECT_PRIORITY'
       ,7
       ,'Defect Priority'
       ,'N'
       ,5
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter value of Defect Priority (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'DEFECT_TYPE'
       ,6
       ,'Defect Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'DEFECT_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'FROM_DATE'
       ,4
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'SISS_ID'
       ,8
       ,'SISS'
       ,'N'
       ,5
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter value of SISS (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'STA_ITEM_CODE'
       ,9
       ,'Item Code'
       ,'N'
       ,5
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,'Enter value of Item Code (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'STA_ITEM_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'TO_DATE'
       ,5
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3922'
       ,'XSP'
       ,10
       ,'XSP'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''XSP_VALUES'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3922'
                    AND  GMP_PARAM = 'XSP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'CONTRACT_ID'
       ,8
       ,'Contract Name'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'DEFECT_PRIORITY'
       ,7
       ,'Defect Priority'
       ,'N'
       ,5
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter value of Defect Priority (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'FROM_DATE'
       ,4
       ,'Date Instructed From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'REPAIR_TYPE'
       ,9
       ,'Repair Type (P/T)'
       ,'N'
       ,1
       ,'GPL_PARAM=''REPAIR_TYPE'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'REPAIR_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'TO_DATE'
       ,5
       ,'Date Instructed To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3924'
       ,'WORK_STATUS'
       ,6
       ,'Work Status'
       ,'N'
       ,1
       ,'HSC_DOMAIN_CODE = ''WORK_ORDER_LINES'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3924'
                    AND  GMP_PARAM = 'WORK_STATUS');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'N'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'ANSWER'
       ,12
       ,'Include Schedule Work (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'CONTRACT_ID'
       ,7
       ,'Contract Id'
       ,'N'
       ,1
       ,'(CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'DEFECT_PRIORITY'
       ,6
       ,'Defect Priority'
       ,'N'
       ,5
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter value of Defect Priority (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'FROM_DATE'
       ,4
       ,'Date Instructed From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'NO_ALLOWED'
       ,11
       ,'Include Defects due for completion within the next (n) days?'
       ,'N'
       ,1
       ,'GPL_PARAM = ''NO_ALLOWED'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'NO_ALLOWED');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'SISS_ID'
       ,9
       ,'SISS'
       ,'N'
       ,5
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter value of SISS (use Insert Record for multiple values)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'TO_DATE'
       ,5
       ,'Date Instructed To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'WORKS_ORDER_NO'
       ,8
       ,'Works Order No'
       ,'N'
       ,1
       ,'(WOR_CON_ID=:CONTRACT_ID OR :CONTRACT_ID IS NULL)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3926'
       ,'XSP'
       ,10
       ,'XSP'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''XSP_VALUES'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3926'
                    AND  GMP_PARAM = 'XSP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3930'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3930'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3930'
       ,'FROM_DATE'
       ,4
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3930'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3930'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3930'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3930'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3930'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3930'
       ,'TO_DATE'
       ,5
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3930'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3932'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3932'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3932'
       ,'CONTRACTOR_ID'
       ,2
       ,'Contractor'
       ,'N'
       ,1
       ,'(OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ORG_ID IN (SELECT CON_CONTR_ORG_ID FROM CONTRACTS WHERE CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3932'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3932'
       ,'CONTRACT_ID'
       ,3
       ,'Contract Id'
       ,'N'
       ,1
       ,'((:CONTRACTOR_ID IS NOT NULL AND CON_CONTR_ORG_ID = :CONTRACTOR_ID) OR (:CONTRACTOR_ID IS NULL AND CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT=:ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3932'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3932'
       ,'FROM_DATE'
       ,4
       ,'Date Instructed From'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3932'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3932'
       ,'TO_DATE'
       ,5
       ,'Date Instructed To'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3932'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3934'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'N'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3934'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3934'
       ,'CONTRACT_ID'
       ,2
       ,'Contract Id'
       ,'N'
       ,1
       ,'(CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3934'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3934'
       ,'FROM_DATE'
       ,4
       ,'Date Completed From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3934'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3934'
       ,'SISS_ID'
       ,3
       ,'SISS'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3934'
                    AND  GMP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3934'
       ,'TO_DATE'
       ,5
       ,'Date Completed To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3934'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3942'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3942'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3942'
       ,'CONTRACT_ID'
       ,2
       ,'Contract Id'
       ,'Y'
       ,1
       ,'(CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3942'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3944'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3944'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3944'
       ,'ANSWER'
       ,7
       ,'Include Notifiables (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3944'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3944'
       ,'FROM_DATE'
       ,5
       ,'Date Paid From'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3944'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3944'
       ,'ORG_CODE'
       ,4
       ,'Rechargable Organisation'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE=''RE'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3944'
                    AND  GMP_PARAM = 'ORG_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3944'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3944'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3944'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3944'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3944'
       ,'TO_DATE'
       ,6
       ,'Date Paid To'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3944'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3948'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3948'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3948'
       ,'CONTRACT_ID'
       ,2
       ,'Contract'
       ,'N'
       ,1
       ,'(CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3948'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3948'
       ,'FROM_DATE'
       ,3
       ,'Date Instructed From'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3948'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3948'
       ,'TO_DATE'
       ,4
       ,'Date Instructed To'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3948'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'A_NUMBER'
       ,8
       ,'Sample Number'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'A_NUMBER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'CONTRACT_ID'
       ,4
       ,'Contract Id'
       ,'N'
       ,1
       ,'(CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'FROM_DATE'
       ,5
       ,'Date Completed From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'NO_ALLOWED'
       ,7
       ,'Sample Percentage'
       ,'N'
       ,1
       ,'GPL_PARAM = ''NO_ALLOWED'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''5'' AND GPL_PARAM=''NO_ALLOWED'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'NO_ALLOWED');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'SISS_ID'
       ,9
       ,'SISS'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3950'
       ,'TO_DATE'
       ,6
       ,'Date Completed To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3950'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3952'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3952'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3952'
       ,'FROM_DATE'
       ,4
       ,'Quality Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the Quality Inspected From date'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3952'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3952'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3952'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3952'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3952'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3952'
       ,'TO_DATE'
       ,5
       ,'Quality Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the Quality Inspected To date'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3952'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3954'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3954'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3954'
       ,'CONTRACTOR_ID'
       ,4
       ,'Contractor'
       ,'N'
       ,1
       ,'(OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ORG_ID IN (SELECT CON_CONTR_ORG_ID FROM CONTRACTS WHERE CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3954'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3954'
       ,'CONTRACT_ID'
       ,5
       ,'Contract Id'
       ,'N'
       ,1
       ,'((:CONTRACTOR_ID IS NOT NULL AND CON_CONTR_ORG_ID = :CONTRACTOR_ID) OR (:CONTRACTOR_ID IS NULL AND CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT=:ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3954'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3954'
       ,'FROM_DATE'
       ,2
       ,'Date Completed From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3954'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3954'
       ,'TO_DATE'
       ,3
       ,'Date Completed To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3954'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3956'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3956'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3956'
       ,'FROM_DATE'
       ,2
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3956'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3956'
       ,'TO_DATE'
       ,3
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3956'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3960'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3960'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3960'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'N'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3960'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3960'
       ,'SCHD_ID'
       ,3
       ,'Schedule Id'
       ,'N'
       ,1
       ,'((:ROAD_ID IS NOT NULL AND SCHD_RSE_HE_ID IN(SELECT RSM_RSE_HE_ID_IN FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_OF IN (:ROAD_ID))) OR  :ROAD_ID IS NULL)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3960'
                    AND  GMP_PARAM = 'SCHD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3970'
       ,'GANG'
       ,1
       ,'Gang'
       ,'Y'
       ,1
       ,'HCO_DOMAIN=''GANG'' AND SYSDATE BETWEEN NVL(HCO_START_DATE,SYSDATE) AND NVL(HCO_END_DATE,SYSDATE)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter The Gang For The Report'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3970'
                    AND  GMP_PARAM = 'GANG');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3970'
       ,'ORDER_SHEET_BOTH'
       ,2
       ,'Wrks Ord/Ctrl Sht/Both'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ORDER_SHEET_BOTH'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''W'' AND GPL_PARAM=''ORDER_SHEET_BOTH'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter W - Works Order, C - Control Sheet, B - Both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3970'
                    AND  GMP_PARAM = 'ORDER_SHEET_BOTH');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3980'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3980'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3980'
       ,'CONTRACTOR_ID'
       ,2
       ,'Contractor'
       ,'N'
       ,1
       ,'(OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ORG_ID IN (SELECT CON_CONTR_ORG_ID FROM CONTRACTS WHERE CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3980'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3980'
       ,'CONTRACT_ID'
       ,3
       ,'Contract Id'
       ,'N'
       ,1
       ,'((:CONTRACTOR_ID IS NOT NULL AND CON_CONTR_ORG_ID = :CONTRACTOR_ID) OR (:CONTRACTOR_ID IS NULL AND CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT=:ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3980'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3980'
       ,'CONTRACT_STATUS'
       ,4
       ,'Contract Status'
       ,'N'
       ,1
       ,'HSC_DOMAIN_CODE=''CONTRACTS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3980'
                    AND  GMP_PARAM = 'CONTRACT_STATUS');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3981'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3981'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3981'
       ,'ANSWER'
       ,3
       ,'Include Inactive (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3981'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3981'
       ,'CONTRACTOR_ID'
       ,2
       ,'Contractor'
       ,'N'
       ,1
       ,'(OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ORG_ID IN (SELECT CON_CONTR_ORG_ID FROM CONTRACTS WHERE CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3981'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3982'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3982'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3982'
       ,'CONTRACTOR_ID'
       ,2
       ,'Contractor'
       ,'N'
       ,1
       ,'(OUN_ORG_UNIT_TYPE=''CO'' AND OUN_ORG_ID IN (SELECT CON_CONTR_ORG_ID FROM CONTRACTS WHERE CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3982'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3982'
       ,'CONTRACT_ID'
       ,3
       ,'Contract Id'
       ,'N'
       ,1
       ,'((:CONTRACTOR_ID IS NOT NULL AND CON_CONTR_ORG_ID = :CONTRACTOR_ID) OR (:CONTRACTOR_ID IS NULL AND CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT=:ADMIN_UNIT)))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3982'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3984'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3984'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3984'
       ,'CONTRACT_ID'
       ,2
       ,'Contract Id'
       ,'N'
       ,1
       ,'(CON_ADMIN_ORG_ID IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3984'
                    AND  GMP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3986'
       ,'FROM_DATE'
       ,5
       ,'Start Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3986'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3986'
       ,'MATERIAL'
       ,3
       ,'Material'
       ,'N'
       ,1
       ,'IAD_ITA_ATTRIB_NAME=''IIT_MATERIAL'' AND IAD_ITA_INV_CODE=''RC'''||CHR(10)||''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3986'
                    AND  GMP_PARAM = 'MATERIAL');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3986'
       ,'SISS_ID'
       ,2
       ,'SISS ID'
       ,'N'
       ,1
       ,'(:SIS_ID IS NULL OR :SIS_ID = SISS_SIS_ID)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3986'
                    AND  GMP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3986'
       ,'SIS_ID'
       ,1
       ,'SIS ID'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3986'
                    AND  GMP_PARAM = 'SIS_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3986'
       ,'TO_DATE'
       ,6
       ,'End Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3986'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3986'
       ,'XSP'
       ,4
       ,'XSP Category'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''XSP_TYPE'' AND SYSDATE BETWEEN NVL(HCO_START_DATE,SYSDATE) AND NVL(HCO_END_DATE,SYSDATE)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3986'
                    AND  GMP_PARAM = 'XSP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3988'
       ,'ANSWER'
       ,2
       ,'Include Inactive (Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3988'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3988'
       ,'STA_ITEM_CODE'
       ,1
       ,'Item Code'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3988'
                    AND  GMP_PARAM = 'STA_ITEM_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3992'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3992'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3992'
       ,'FROM_DATE'
       ,4
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3992'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3992'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3992'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3992'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3992'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3992'
       ,'TO_DATE'
       ,5
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3992'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3994'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3994'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3994'
       ,'FROM_DATE'
       ,4
       ,'Date Inspected From'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL'||CHR(10)||'AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3994'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3994'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,'NVL(RSE_GTY_GROUP_TYPE,''SECT'')=NVL(:ROAD_TYPE,NVL(RSE_GTY_GROUP_TYPE,''SECT''))'
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3994'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3994'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3994'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI3994'
       ,'TO_DATE'
       ,5
       ,'Date Inspected To'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR'||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3994'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5001'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5001'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5001'
       ,'CHAINAGE'
       ,5
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5001'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5001'
       ,'CHAINAGE2'
       ,6
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5001'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5001'
       ,'INVENTORY_ITEM'
       ,7
       ,'Inventory Item'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Inventory Item'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5001'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5001'
       ,'LOCAL_DTP'
       ,4
       ,'Local or DTp Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5001'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5001'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5001'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5001'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5001'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5010'
       ,'CHAINAGE'
       ,3
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5010'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5010'
       ,'CHAINAGE2'
       ,4
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5010'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5010'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5010'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5010'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5010'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5011'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5011'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5011'
       ,'CHAINAGE'
       ,4
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5011'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5011'
       ,'CHAINAGE2'
       ,5
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5011'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5011'
       ,'INVENTORY_ITEM'
       ,6
       ,'Inventory Item'
       ,'N'
       ,6
       ,''
       ,'N'
       ,''
       ,'INV_ITEM_TYPES'
       ,'ITY_INV_CODE'
       ,'ITY_INV_CODE = ''LL'' AND ROWNUM = 1'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Inventory Item, leave blank for all items'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5011'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5011'
       ,'LOCAL_DTP'
       ,3
       ,'Local or DTp Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5011'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5011'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5011'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5015'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5015'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5015'
       ,'CHAINAGE'
       ,4
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5015'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5015'
       ,'CHAINAGE2'
       ,5
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5015'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5015'
       ,'LOCAL_DTP'
       ,3
       ,'Local or DTp Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5015'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5015'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5015'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5018'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5018'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5018'
       ,'CHAINAGE'
       ,3
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5018'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5018'
       ,'CHAINAGE2'
       ,4
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5018'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5018'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5018'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'ANSWER'
       ,7
       ,'Access Area Subtraction'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''Y'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Y to subtract Access Areas in calculations'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'ANSWER2'
       ,9
       ,'Print Length/Width?'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''ANSWER2'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''Y'' AND GPL_PARAM=''ANSWER2'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Y to for Length and Width to appear on report'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'ANSWER2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'F_OR_M'
       ,6
       ,'Verge Area'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''F_OR_M'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''F'' AND GPL_PARAM = ''F_OR_M'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select F for Full width, or M for Maintained Width'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'F_OR_M');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'INVENTORY_ITEM'
       ,5
       ,'Inventory Item'
       ,'Y'
       ,1
       ,'ITY_INV_CODE IN ( SELECT ITA_IIT_INV_CODE  FROM  INV_TYPE_ATTRIBS,INV_ITEM_TYPES  WHERE   ITA_ATTRIB_NAME  = ''IIT_WIDTH''  AND   ITY_INV_CODE     = ITA_IIT_INV_CODE AND   ITY_PNT_OR_CONT  = ''C'') AND ITY_SYS_FLAG = :LOCAL_DTP'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Inventory Item'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'INVENTORY_ITEM2'
       ,7
       ,'Access Area Type'
       ,'N'
       ,1
       ,'ITY_INV_CODE IN ( SELECT ITA_IIT_INV_CODE  FROM  INV_TYPE_ATTRIBS,INV_ITEM_TYPES  WHERE   ITA_ATTRIB_NAME  = ''IIT_WIDTH''  AND   ITY_INV_CODE     = ITA_IIT_INV_CODE) AND ITY_SYS_FLAG = :LOCAL_DTP AND :ANSWER = ''Y'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Access Area Inventory Type to be subtracted'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'INVENTORY_ITEM2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'INV_ATTRI_DOMAINS'
       ,8
       ,'Surface Material Type'
       ,'N'
       ,1
       ,'IAD_ITA_INV_CODE = :INVENTORY_ITEM AND IAD_ITA_ATTRIB_NAME = ''IIT_MATERIAL'' AND IAD_ITA_ITY_SYS_FLAG = :LOCAL_DTP'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select a Surface Material or leave blank for all'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'INV_ATTRI_DOMAINS');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'LOCAL_DTP'
       ,4
       ,'Local or DoT Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT, or Leave Blank for All Roads'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'ROAD_ID'
       ,3
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT) AND RSE_GTY_GROUP_TYPE = :ROAD_TYPE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5021'
       ,'ROAD_TYPE'
       ,2
       ,'Road Type'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5021'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5022'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5022'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5022'
       ,'CHAINAGE'
       ,4
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5022'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5022'
       ,'CHAINAGE2'
       ,5
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5022'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5022'
       ,'INVENTORY_GROUP'
       ,6
       ,'Inventory Group'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''INVENTORY_GROUPS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Inventory Group'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5022'
                    AND  GMP_PARAM = 'INVENTORY_GROUP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5022'
       ,'LOCAL_DTP'
       ,3
       ,'Local or DTp Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5022'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5022'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5022'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5024'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5024'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5024'
       ,'CHAINAGE'
       ,4
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5024'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5024'
       ,'CHAINAGE2'
       ,5
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5024'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5024'
       ,'LOCAL_DTP'
       ,3
       ,'Local or DTp Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5024'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5024'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5024'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5025'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5025'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5025'
       ,'CHAINAGE'
       ,3
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5025'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5025'
       ,'CHAINAGE2'
       ,4
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5025'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5025'
       ,'FROM_DATE'
       ,5
       ,'Start Date'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5025'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5025'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5025'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5025'
       ,'TO_DATE'
       ,6
       ,'End Date'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end date for inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5025'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5027'
       ,'ACTIVITY'
       ,2
       ,'Activity Area'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5027'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5027'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5027'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5027'
       ,'XSP'
       ,3
       ,'XSP'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''XSP_VALUES'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5027'
                    AND  GMP_PARAM = 'XSP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5030'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5030'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5030'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5030'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5031'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5031'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5031'
       ,'CHAINAGE'
       ,4
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5031'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5031'
       ,'CHAINAGE2'
       ,5
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5031'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5031'
       ,'LOCAL_DTP'
       ,3
       ,'Local or DTp Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5031'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5031'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5031'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5032'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5032'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5032'
       ,'CHAINAGE'
       ,3
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5032'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5032'
       ,'CHAINAGE2'
       ,4
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5032'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5032'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,'RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF = RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN = :ROAD_ID)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5032'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034A'
       ,'FROM_DATE'
       ,3
       ,'Start Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034A'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034A'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034A'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034A'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034A'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034A'
       ,'TO_DATE'
       ,4
       ,'End Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034A'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034B'
       ,'ACTIVITY'
       ,3
       ,'Activity Area'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034B'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034B'
       ,'FROM_DATE'
       ,4
       ,'Start Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034B'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034B'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034B'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034B'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034B'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5034B'
       ,'TO_DATE'
       ,5
       ,'End Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5034B'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035A'
       ,'FROM_DATE'
       ,3
       ,'Start Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035A'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035A'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035A'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035A'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035A'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035A'
       ,'TO_DATE'
       ,4
       ,'End Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035A'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035B'
       ,'ACTIVITY'
       ,3
       ,'Activity Area'
       ,'Y'
       ,1
       ,''
       ,'Y'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035B'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035B'
       ,'FROM_DATE'
       ,4
       ,'Start Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035B'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035B'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035B'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035B'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035B'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5035B'
       ,'TO_DATE'
       ,5
       ,'End Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5035B'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037'
       ,'LP_OR_OTHER'
       ,4
       ,'Electrical Inventory'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LP_OR_OTHER'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'LP for Lighting Points, O for Other Electrical Items or blank for both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037'
                    AND  GMP_PARAM = 'LP_OR_OTHER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037'
       ,'ORG_CODE'
       ,3
       ,'Electricity Board'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE = ''EB'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Electricty Board'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037'
                    AND  GMP_PARAM = 'ORG_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037A'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037A'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037A'
       ,'LP_OR_OTHER'
       ,4
       ,'Electrical Inventory'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LP_OR_OTHER'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'LP for Lighting Points, O for Other Electrical Items or blank for both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037A'
                    AND  GMP_PARAM = 'LP_OR_OTHER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037A'
       ,'ORG_CODE'
       ,3
       ,'Electricity Board'
       ,'N'
       ,1
       ,'OUN_ORG_UNIT_TYPE = ''EB'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Electricty Board'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037A'
                    AND  GMP_PARAM = 'ORG_CODE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5037A'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5037A'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5038'
       ,'FINANCIAL_YEAR'
       ,3
       ,'Financial Year'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,'FINANCIAL_YEARS'
       ,'FYR_ID'
       ,'SYSDATE >= FYR_START_DATE AND SYSDATE <= FYR_END_DATE'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Financial Year to be reported'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5038'
                    AND  GMP_PARAM = 'FINANCIAL_YEAR');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5038'
       ,'LOCAL_DTP'
       ,4
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5038'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5038'
       ,'ROAD_ID'
       ,1
       ,'Road Part Id'
       ,'Y'
       ,1
       ,'RSE_GTY_GROUP_TYPE=''RP'' AND RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Road Part'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5038'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5038'
       ,'SCHEME_TYPE'
       ,2
       ,'Scheme Type'
       ,'Y'
       ,1
       ,'HCO_DOMAIN=''SCHEME_TYPES'' AND HCO_CODE IN (''RD'',''SC'')'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter a Sceme Type'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5038'
                    AND  GMP_PARAM = 'SCHEME_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5050'
       ,'INVENTORY_ITEM'
       ,1
       ,'Inventory Item'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Inventory Item, leave blank for all items'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5050'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5050D'
       ,'LOCAL_DTP'
       ,1
       ,'Local or DTp Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5050D'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5060'
       ,'FROM_DATE'
       ,3
       ,'Start Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5060'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5060'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5060'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5060'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5060'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5060'
       ,'TO_DATE'
       ,4
       ,'End Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5060'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5070'
       ,'FROM_DATE'
       ,3
       ,'Start Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5070'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5070'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5070'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5070'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5070'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5070'
       ,'TO_DATE'
       ,4
       ,'End Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter End Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5070'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5075'
       ,'LOCAL_DTP'
       ,1
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5075'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5075'
       ,'ROAD_ID'
       ,2
       ,'Road Part Id'
       ,'Y'
       ,1
       ,'RSE_GTY_GROUP_TYPE=''RP'' AND RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5075'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5080'
       ,'FROM_DATE'
       ,3
       ,'Start Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-12),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5080'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5080'
       ,'LOCAL_DTP'
       ,2
       ,'Local or DoT Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DoT'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5080'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5080'
       ,'ROAD_ID'
       ,1
       ,'Road Part'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,'Enter a Road Part Only'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5080'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5080'
       ,'TO_DATE'
       ,4
       ,'End Date'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter Start Date for Inspections'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5080'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5090'
       ,'MAI_P_DEL_REV'
       ,2
       ,'Review batch or delete it'
       ,'Y'
       ,1
       ,'GPL_PARAM=''MAI_P_DEL_REV'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'Y'
       ,'Review the batch headers or review and delete them '
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5090'
                    AND  GMP_PARAM = 'MAI_P_DEL_REV');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5090'
       ,'RUN_NUM'
       ,1
       ,'Loaded Inventory Batch'
       ,'N'
       ,1
       ,'RUN_NUM>0 AND RUN_STAGE=''OK'' and item_err_cnt  + section_err_cnt = 0'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter a valid loaded inventory batch number'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5090'
                    AND  GMP_PARAM = 'RUN_NUM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'ACTIVITY'
       ,6
       ,'Activity Area'
       ,'N'
       ,1
       ,'ATV_ACTY_AREA_CODE = ATV_ACTY_AREA_CODE AND ATV_DTP_FLAG = :LOCAL_DTP ORDER BY ATV_ACTY_AREA_CODE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Activity Area, leave blank for all Activity Areas'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'ACTIVITY_GROUP'
       ,5
       ,'Activity Group'
       ,'N'
       ,1
       ,'ACG_GROUP_CODE = ACG_GROUP_CODE ORDER BY ACG_GROUP_CODE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Activity Group, leave blank for all Activity Groups'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'ACTIVITY_GROUP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'ANSWER'
       ,12
       ,'Include Late Defects(Y/N)'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''Y'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'ASSET'
       ,2
       ,'Asset Reference'
       ,'N'
       ,1
       ,'IIT_END_DATE IS NULL AND ((:ROAD_ID IS NOT NULL AND IIT_RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF ='||CHR(10)||'RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN IN (:ROAD_ID))) OR :ROAD_ID IS NULL) AND IIT_PRIMARY_KEY IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'ASSET');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'A_OR_G'
       ,3
       ,'Activity Area or Group'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''A_OR_G'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''A'' AND GPL_PARAM = ''A_OR_G'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select A to report based on Activty Areas, or G from Activity Groups'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'A_OR_G');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'C_OR_I'
       ,10
       ,'Complete or Incomplete Defects'
       ,'N'
       ,1
       ,'GPL_PARAM = ''C_OR_I'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter C for Complete Defects, I for Incomplete Defects or leave blank for both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'C_OR_I');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'DEFECT_PRIORITY'
       ,13
       ,'Defect Priority'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Defect Priority, leave Blank for all Priorities'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'DEFECT_TYPE'
       ,7
       ,'Defect Type'
       ,'N'
       ,6
       ,'((:A_OR_G = ''A'' AND :ACTIVITY IS NOT NULL AND DTY_ATV_ACTY_AREA_CODE = :ACTIVITY) OR (:A_OR_G = ''G''  AND :ACTIVITY_GROUP IS NOT NULL AND DTY_ATV_ACTY_AREA_CODE IN (SELECT AGM_ACTY_CODE FROM ACT_GROUP_MEMBS WHERE AGM_GROUP_CODE = :ACTIVITY_GROUP)) OR (:A_OR_G = ''A'' AND :ACTIVITY IS NULL) OR (:A_OR_G = ''G'' AND :ACTIVITY_GROUP IS NULL)) ORDER BY DTY_DEFECT_CODE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'DEFECT_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'FROM_DATE'
       ,14
       ,'Date From'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(ADD_MONTHS(SYSDATE,-1),''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'LOCAL_DTP'
       ,4
       ,'Local or DTp Flag'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp, or Leave Blank for All Roads'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'O_OR_P'
       ,11
       ,'Outstanding or Progressing Defects'
       ,'N'
       ,1
       ,'GPL_PARAM = ''O_OR_P'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter O for Outstanding Defects, P for Progressing Defects or blank for both'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'O_OR_P');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'ROAD_ID'
       ,1
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'TO_DATE'
       ,15
       ,'Date To'
       ,'Y'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'N'
       ,''
       ,'DUAL'
       ,'TO_CHAR(SYSDATE,''DD-MON-YYYY'')'
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'TREATMENT'
       ,9
       ,'Treatment'
       ,'N'
       ,6
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'TREATMENT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5100'
       ,'XSP'
       ,8
       ,'XSP'
       ,'N'
       ,6
       ,'HCO_DOMAIN=''XSP_VALUES'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5100'
                    AND  GMP_PARAM = 'XSP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'ACTIVITY'
       ,4
       ,'Activity Area'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Activity Area, leave blank for all Activity Areas'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'ACTIVITY_GROUP'
       ,5
       ,'Activity Group'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Activity Group, leave blank for all Activity Groups'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'ACTIVITY_GROUP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'ASSET'
       ,3
       ,'Asset Reference'
       ,'N'
       ,1
       ,'IIT_END_DATE IS NULL AND ((:ROAD_ID IS NOT NULL AND IIT_RSE_HE_ID IN (SELECT :ROAD_ID FROM DUAL UNION SELECT RSM_RSE_HE_ID_OF FROM ROAD_SEG_MEMBS CONNECT BY PRIOR RSM_RSE_HE_ID_OF ='||CHR(10)||'RSM_RSE_HE_ID_IN START WITH RSM_RSE_HE_ID_IN IN (:ROAD_ID))) OR :ROAD_ID IS NULL) AND IIT_PRIMARY_KEY IS NOT NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'ASSET');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'A_OR_G'
       ,3
       ,'Activity Area or Group'
       ,'Y'
       ,1
       ,'GPL_PARAM = ''A_OR_G'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''A'' AND GPL_PARAM = ''A_OR_G'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select A to report based on Activty Areas, or G from Activity Groups'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'A_OR_G');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'DEFECT_PRIORITY'
       ,6
       ,'Defect Priority'
       ,'N'
       ,1
       ,'HCO_DOMAIN=''DEFECT_PRIORITIES'' AND HCO_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Defect Priority, leave Blank for all Priorities'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'LOCAL_DTP'
       ,7
       ,'Local or DTp Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''D'' AND GPL_PARAM =''LOCAL_DTP'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp, or Leave Blank for All Roads'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5125'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5125'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI5130'
       ,'WORKS_ORDER_NO'
       ,1
       ,'Works Order No'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI5130'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6100'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6100'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6100'
       ,'CHAINAGE'
       ,4
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6100'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6100'
       ,'CHAINAGE2'
       ,5
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6100'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6100'
       ,'INVENTORY_ITEM'
       ,6
       ,'Inventory Item'
       ,'N'
       ,1
       ,'ITY_PNT_OR_CONT=''P'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the inventory item type'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6100'
                    AND  GMP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6100'
       ,'LOCAL_DTP'
       ,3
       ,'Local or DTp Flag'
       ,'N'
       ,1
       ,'GPL_PARAM = ''LOCAL_DTP'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter L for Local, D for DTp'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6100'
                    AND  GMP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6100'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6100'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6110'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'N'
       ,''
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6110'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6110'
       ,'CW_HG_KB'
       ,3
       ,'Inventory Item'
       ,'N'
       ,1
       ,'GPL_PARAM=''CW_HG_KB'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select CW, HG, KB or leave blank for all 3 Inventory Items'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6110'
                    AND  GMP_PARAM = 'CW_HG_KB');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6110'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6110'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6120'
       ,'ANSWER'
       ,5
       ,'Include Child Items ?'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''Y'' AND GPL_PARAM=''ANSWER'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Do you wish to include child inventory items in the report ?'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6120'
                    AND  GMP_PARAM = 'ANSWER');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6120'
       ,'ANSWER2'
       ,6
       ,'Include Attribute Data'
       ,'Y'
       ,1
       ,'GPL_PARAM=''ANSWER2'''
       ,'N'
       ,''
       ,'GRI_PARAM_LOOKUP'
       ,'GPL_VALUE'
       ,'GPL_VALUE=''Y''  AND GPL_PARAM=''ANSWER2'''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Do you wish to include attribute data in the report ?'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6120'
                    AND  GMP_PARAM = 'ANSWER2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6120'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'N'
       ,1
       ,'NVL( RSE_GTY_GROUP_TYPE, ''SECT'' ) = :ROAD_TYPE'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'Y'
       ,'road_id'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6120'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6120'
       ,'ROAD_TYPE'
       ,1
       ,'Road Type'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,'road_type'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6120'
                    AND  GMP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6120'
       ,'STOP_FROM'
       ,3
       ,'From Bus Stop'
       ,'N'
       ,1
       ,'IIT_ITY_INV_CODE=''CD'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the Start range Bus Stop value.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6120'
                    AND  GMP_PARAM = 'STOP_FROM');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI6120'
       ,'STOP_TO'
       ,4
       ,'To Bus Stop'
       ,'N'
       ,1
       ,'IIT_ITY_INV_CODE=''CD'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter the End range Bus Stop value.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI6120'
                    AND  GMP_PARAM = 'STOP_TO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI7040'
       ,'PBI_QRY'
       ,1
       ,'Name of PBI Report'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI7040'
                    AND  GMP_PARAM = 'PBI_QRY');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'CONTRACTOR_ID'
       ,70
       ,'Contractor'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_CON_ID = :CONTRACTOR_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Contractor'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'FROM_DATE'
       ,20
       ,'From Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'Y'
       ,'TRUNC(WOR_DATE_RAISED) >= :FROM_DATE'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'H2'
       ,50
       ,'Originated By'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_PEO_PERSON_ID = :H2'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Originated By'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'H2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'HIG_USER_ID'
       ,40
       ,'Authorised By'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_MOD_BY_ID = :HIG_USER_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Authorised By'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'ROAD_ID'
       ,60
       ,'Road Id'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_RSE_HE_ID_GROUP = :ROAD_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Road Group'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'TEMPLATE_NAME'
       ,10
       ,'Template'
       ,'Y'
       ,1
       ,'DTG_TEMPLATE_NAME IN (SELECT DTU_TEMPLATE_NAME FROM DOC_TEMPLATE_USERS,HIG_USERS  WHERE DTU_USER_ID = HUS_USER_ID AND HUS_USERNAME = USER) '||CHR(10)||'AND DTG_TABLE_NAME =''WORK_ORDERS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Template to Use'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'TEMPLATE_NAME');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'TO_DATE'
       ,30
       ,'To Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR '||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'Y'
       ,'TRUNC(WOR_DATE_RAISED) <=:TO_DATE'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI8000'
       ,'WORKS_ORDER_NO'
       ,80
       ,'Works Order No'
       ,'N'
       ,20
       ,''
       ,'Y'
       ,'WOR_WORKS_ORDER_NO IN (:WORKS_ORDER_NO)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Specific Works Order No (Use Insert Record to specify more than one)'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI9010'
       ,'ADMIN_UNIT'
       ,1
       ,'Admin Unit'
       ,'Y'
       ,1
       ,'(HAU_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT IN (SELECT HUS_ADMIN_UNIT FROM HIG_USERS WHERE HUS_USERNAME = USER)))'
       ,'Y'
       ,'RSE_ADMIN_UNIT IN (SELECT HAG_CHILD_ADMIN_UNIT FROM HIG_ADMIN_GROUPS WHERE HAG_PARENT_ADMIN_UNIT = :ADMIN_UNIT)'
       ,'HIG_ADMIN_UNITS'
       ,'HAU_ADMIN_UNIT'
       ,'HAU_ADMIN_UNIT = (SELECT MAX(HUS_ADMIN_UNIT) FROM HIG_USERS WHERE HUS_USERNAME = USER)'
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI9010'
                    AND  GMP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI9010'
       ,'CHAINAGE'
       ,3
       ,'Start Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the start chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI9010'
                    AND  GMP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI9010'
       ,'CHAINAGE2'
       ,4
       ,'End Chainage'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the end chainage'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI9010'
                    AND  GMP_PARAM = 'CHAINAGE2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAI9010'
       ,'ROAD_ID'
       ,2
       ,'Road Id'
       ,'Y'
       ,1
       ,'RSE_END_DATE IS NULL'
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'Y'
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI9010'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT 
        'MAICRVW'
       ,'SYSTEM_PWD'
       ,1
       ,'SYSTEM Password'
       ,'Y'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Enter the SYSTEM password'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAICRVW'
                    AND  GMP_PARAM = 'SYSTEM_PWD');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- GRI_PARAM_DEPENDENCIES
--
-- select * from mai_metadata.gri_param_dependencies
-- order by gpd_module
--         ,gpd_dep_param
--         ,gpd_indep_param
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT gri_param_dependencies
SET TERM OFF

INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI1808'
       ,'ORG_CODE'
       ,'ORG_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI1808'
                    AND  GPD_DEP_PARAM = 'ORG_CODE'
                    AND  GPD_INDEP_PARAM = 'ORG_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2200R'
       ,'BATCH_ID'
       ,'BATCH_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2200R'
                    AND  GPD_DEP_PARAM = 'BATCH_ID'
                    AND  GPD_INDEP_PARAM = 'BATCH_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2210'
       ,'ROAD_ID'
       ,'LOCAL_DTP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2210'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2224'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2224'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2330'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2330'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2330'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2330'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2330'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2330'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2330'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2330'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2330'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2330'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2510'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2510'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2510'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2510'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2510'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2510'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI2510'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI2510'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI30060'
       ,'EFFECTIVE_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI30060'
                    AND  GPD_DEP_PARAM = 'EFFECTIVE_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI30060'
       ,'EFFECTIVE_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI30060'
                    AND  GPD_DEP_PARAM = 'EFFECTIVE_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI30060'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI30060'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI30060'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI30060'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI30060'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI30060'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI30060'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI30060'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI30060'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI30060'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3100'
       ,'CHAINAGE2'
       ,'CHAINAGE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3100'
                    AND  GPD_DEP_PARAM = 'CHAINAGE2'
                    AND  GPD_INDEP_PARAM = 'CHAINAGE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3100'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3100'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3470'
       ,'WORKS_ORDER_NO'
       ,'WORKS_ORDER_NO' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3470'
                    AND  GPD_DEP_PARAM = 'WORKS_ORDER_NO'
                    AND  GPD_INDEP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3490'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3490'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3490'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3490'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3490'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3490'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3490'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3490'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3505'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3505'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3505'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3505'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3505'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3505'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3505'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3505'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'TARGET_FROM_DATE'
       ,'TARGET_FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'TARGET_FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TARGET_FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'TARGET_FROM_DATE'
       ,'TARGET_TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'TARGET_FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TARGET_TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'TARGET_TO_DATE'
       ,'TARGET_FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'TARGET_TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TARGET_FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'TARGET_TO_DATE'
       ,'TARGET_TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'TARGET_TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TARGET_TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3516'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3516'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3518'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3518'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3840'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3840'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3863'
       ,'ACTIVITY'
       ,'DISCIPLINE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3863'
                    AND  GPD_DEP_PARAM = 'ACTIVITY'
                    AND  GPD_INDEP_PARAM = 'DISCIPLINE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3863'
       ,'ACTIVITY_GROUP'
       ,'DISCIPLINE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3863'
                    AND  GPD_DEP_PARAM = 'ACTIVITY_GROUP'
                    AND  GPD_INDEP_PARAM = 'DISCIPLINE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3863'
       ,'INVENTORY_ITEM'
       ,'DISCIPLINE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3863'
                    AND  GPD_DEP_PARAM = 'INVENTORY_ITEM'
                    AND  GPD_INDEP_PARAM = 'DISCIPLINE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3863'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3863'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3865'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3865'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3865'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3865'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3865'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3865'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3865'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3865'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3900'
       ,'BATCH_ID'
       ,'BATCH_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3900'
                    AND  GPD_DEP_PARAM = 'BATCH_ID'
                    AND  GPD_INDEP_PARAM = 'BATCH_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3900'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3900'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3900'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3900'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3900'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3900'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3900'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3900'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3900'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3900'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3902'
       ,'DEFECT_ID'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3902'
                    AND  GPD_DEP_PARAM = 'DEFECT_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3902'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3902'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'DEFECT_ID'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'DEFECT_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,'DEFECT_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTICE_ID'
                    AND  GPD_INDEP_PARAM = 'DEFECT_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,'DEFECT_PRIORITY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTICE_ID'
                    AND  GPD_INDEP_PARAM = 'DEFECT_PRIORITY');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTICE_ID'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,'NOTIFY_ORG' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTICE_ID'
                    AND  GPD_INDEP_PARAM = 'NOTIFY_ORG');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTICE_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTICE_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTICE_ID'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTICE_ID'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'NOTIFY_ORG'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'NOTIFY_ORG'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3904'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3904'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3906'
       ,'WORK_SHEET_NO'
       ,'WORKS_ORDER_NO' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3906'
                    AND  GPD_DEP_PARAM = 'WORK_SHEET_NO'
                    AND  GPD_INDEP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3907'
       ,'WORK_SHEET_NO'
       ,'WORKS_ORDER_NO' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3907'
                    AND  GPD_DEP_PARAM = 'WORK_SHEET_NO'
                    AND  GPD_INDEP_PARAM = 'WORKS_ORDER_NO');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3910'
       ,'ASSET'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3910'
                    AND  GPD_DEP_PARAM = 'ASSET'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3910'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3910'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3910'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3910'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3910'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3910'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3910'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3910'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3912'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3912'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3912'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3912'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3912'
       ,'NOTIFY_ORG'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3912'
                    AND  GPD_DEP_PARAM = 'NOTIFY_ORG'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3912'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3912'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3912'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3912'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3912'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3912'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3916'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3916'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3916'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3916'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3916'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3916'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3916'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3916'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3916'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3916'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3919'
       ,'WORKS_ORDER_NO'
       ,'ANSWER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3919'
                    AND  GPD_DEP_PARAM = 'WORKS_ORDER_NO'
                    AND  GPD_INDEP_PARAM = 'ANSWER');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3920'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3920'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3920'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3920'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3920'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3920'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3920'
       ,'STA_ITEM_CODE'
       ,'SISS_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3920'
                    AND  GPD_DEP_PARAM = 'STA_ITEM_CODE'
                    AND  GPD_INDEP_PARAM = 'SISS_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3920'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3920'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3920'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3920'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3922'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3922'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3922'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3922'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3922'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3922'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3922'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3922'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3922'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3922'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3924'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3924'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3924'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3924'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3924'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3924'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3924'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3924'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3924'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3924'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3926'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3926'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3926'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3926'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3926'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3926'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3926'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3926'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3926'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3926'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3926'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3926'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3926'
       ,'WORKS_ORDER_NO'
       ,'CONTRACT_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3926'
                    AND  GPD_DEP_PARAM = 'WORKS_ORDER_NO'
                    AND  GPD_INDEP_PARAM = 'CONTRACT_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3930'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3930'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3930'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3930'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3930'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3930'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3930'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3930'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3930'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3930'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3932'
       ,'CONTRACTOR_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3932'
                    AND  GPD_DEP_PARAM = 'CONTRACTOR_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3932'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3932'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3932'
       ,'CONTRACT_ID'
       ,'CONTRACTOR_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3932'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3932'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3932'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3932'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3932'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3932'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3932'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3932'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3932'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3934'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3934'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3934'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3934'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3934'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3934'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3934'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3934'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3934'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3934'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3942'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3942'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3944'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3944'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3944'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3944'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3944'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3944'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3944'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3944'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3944'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3944'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3948'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3948'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3948'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3948'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3948'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3948'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3948'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3948'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3948'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3948'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3950'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3950'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3950'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3950'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3950'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3950'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3950'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3950'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3950'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3950'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3950'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3950'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3952'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3952'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3952'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3952'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3952'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3952'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3952'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3952'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3952'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3952'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3954'
       ,'CONTRACTOR_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3954'
                    AND  GPD_DEP_PARAM = 'CONTRACTOR_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3954'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3954'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3954'
       ,'CONTRACT_ID'
       ,'CONTRACTOR_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3954'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3954'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3954'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3954'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3954'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3954'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3954'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3954'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3954'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3956'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3956'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3956'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3956'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3956'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3956'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3956'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3956'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3960'
       ,'SCHD_ID'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3960'
                    AND  GPD_DEP_PARAM = 'SCHD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3980'
       ,'CONTRACTOR_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3980'
                    AND  GPD_DEP_PARAM = 'CONTRACTOR_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3980'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3980'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3980'
       ,'CONTRACT_ID'
       ,'CONTRACTOR_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3980'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3981'
       ,'CONTRACTOR_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3981'
                    AND  GPD_DEP_PARAM = 'CONTRACTOR_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3982'
       ,'CONTRACTOR_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3982'
                    AND  GPD_DEP_PARAM = 'CONTRACTOR_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3982'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3982'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3982'
       ,'CONTRACT_ID'
       ,'CONTRACTOR_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3982'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3984'
       ,'CONTRACT_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3984'
                    AND  GPD_DEP_PARAM = 'CONTRACT_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3986'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3986'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3986'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3986'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3986'
       ,'SISS_ID'
       ,'SIS_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3986'
                    AND  GPD_DEP_PARAM = 'SISS_ID'
                    AND  GPD_INDEP_PARAM = 'SIS_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3986'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3986'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3986'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3986'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3992'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3992'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3992'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3992'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3992'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3992'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3992'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3992'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3992'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3992'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3994'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3994'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3994'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3994'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3994'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3994'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3994'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3994'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI3994'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3994'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5001'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5001'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5011'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5011'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5015'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5015'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5018'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5018'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'INVENTORY_ITEM'
       ,'LOCAL_DTP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'INVENTORY_ITEM'
                    AND  GPD_INDEP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'INVENTORY_ITEM2'
       ,'ANSWER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'INVENTORY_ITEM2'
                    AND  GPD_INDEP_PARAM = 'ANSWER');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'INVENTORY_ITEM2'
       ,'LOCAL_DTP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'INVENTORY_ITEM2'
                    AND  GPD_INDEP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'INV_ATTRI_DOMAINS'
       ,'INVENTORY_ITEM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'INV_ATTRI_DOMAINS'
                    AND  GPD_INDEP_PARAM = 'INVENTORY_ITEM');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'INV_ATTRI_DOMAINS'
       ,'LOCAL_DTP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'INV_ATTRI_DOMAINS'
                    AND  GPD_INDEP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'LOCAL_DTP'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'LOCAL_DTP'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5021'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5021'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5024'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5024'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5030'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5030'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034A'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034A'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034A'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034A'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034A'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034A'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034A'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034A'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034B'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034B'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034B'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034B'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034B'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034B'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5034B'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5034B'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035A'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035A'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035A'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035A'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035A'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035A'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035A'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035A'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035B'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035B'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035B'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035B'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035B'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035B'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5035B'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5035B'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5060'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5060'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5060'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5060'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5060'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5060'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5060'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5060'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5070'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5070'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5070'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5070'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5070'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5070'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5070'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5070'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5080'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5080'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5080'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5080'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5080'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5080'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5080'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5080'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'ACTIVITY'
       ,'ACTIVITY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'ACTIVITY'
                    AND  GPD_INDEP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'ACTIVITY'
       ,'LOCAL_DTP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'ACTIVITY'
                    AND  GPD_INDEP_PARAM = 'LOCAL_DTP');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'ACTIVITY_GROUP'
       ,'ACTIVITY_GROUP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'ACTIVITY_GROUP'
                    AND  GPD_INDEP_PARAM = 'ACTIVITY_GROUP');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'ASSET'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'ASSET'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'DEFECT_TYPE'
       ,'ACTIVITY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'DEFECT_TYPE'
                    AND  GPD_INDEP_PARAM = 'ACTIVITY');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'DEFECT_TYPE'
       ,'ACTIVITY_GROUP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'DEFECT_TYPE'
                    AND  GPD_INDEP_PARAM = 'ACTIVITY_GROUP');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'DEFECT_TYPE'
       ,'A_OR_G' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'DEFECT_TYPE'
                    AND  GPD_INDEP_PARAM = 'A_OR_G');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5100'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5100'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI5125'
       ,'ASSET'
       ,'ROAD_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI5125'
                    AND  GPD_DEP_PARAM = 'ASSET'
                    AND  GPD_INDEP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI6100'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI6100'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI6110'
       ,'ROAD_ID'
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI6110'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ADMIN_UNIT');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI6120'
       ,'ROAD_ID'
       ,'ROAD_TYPE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI6120'
                    AND  GPD_DEP_PARAM = 'ROAD_ID'
                    AND  GPD_INDEP_PARAM = 'ROAD_TYPE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT 
        'MAI8000'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- GRI_PARAM_LOOKUP
--
-- select * from mai_metadata.gri_param_lookup
-- order by gpl_param
--         ,gpl_value
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT gri_param_lookup
SET TERM OFF

INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'ANSWER2'
       ,'N'
       ,'No' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'ANSWER2'
                    AND  GPL_VALUE = 'N');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'ANSWER2'
       ,'Y'
       ,'Yes' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'ANSWER2'
                    AND  GPL_VALUE = 'Y');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'A_OR_G'
       ,'A'
       ,'Activity Area' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'A_OR_G'
                    AND  GPL_VALUE = 'A');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'A_OR_G'
       ,'G'
       ,'Activity Group' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'A_OR_G'
                    AND  GPL_VALUE = 'G');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'A_OR_R'
       ,'A'
       ,'Report by Activity' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'A_OR_R'
                    AND  GPL_VALUE = 'A');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'A_OR_R'
       ,'R'
       ,'Report by Road' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'A_OR_R'
                    AND  GPL_VALUE = 'R');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'CW_HG_KB'
       ,'CW'
       ,'Carriageway' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'CW_HG_KB'
                    AND  GPL_VALUE = 'CW');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'CW_HG_KB'
       ,'HG'
       ,'Hedge' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'CW_HG_KB'
                    AND  GPL_VALUE = 'HG');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'CW_HG_KB'
       ,'KB'
       ,'Kerb' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'CW_HG_KB'
                    AND  GPL_VALUE = 'KB');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'C_OR_I'
       ,'C'
       ,'Complete' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'C_OR_I'
                    AND  GPL_VALUE = 'C');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'C_OR_I'
       ,'I'
       ,'Incomplete' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'C_OR_I'
                    AND  GPL_VALUE = 'I');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'C_OR_O'
       ,'C'
       ,'Complete' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'C_OR_O'
                    AND  GPL_VALUE = 'C');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'C_OR_O'
       ,'O'
       ,'Outstanding' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'C_OR_O'
                    AND  GPL_VALUE = 'O');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'FILETYPE'
       ,'C'
       ,'Completions' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'FILETYPE'
                    AND  GPL_VALUE = 'C');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'FILETYPE'
       ,'I'
       ,'Invoices' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'FILETYPE'
                    AND  GPL_VALUE = 'I');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'FILETYPE'
       ,'S'
       ,'Sections' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'FILETYPE'
                    AND  GPL_VALUE = 'S');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'FILETYPE'
       ,'W'
       ,'Work Orders' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'FILETYPE'
                    AND  GPL_VALUE = 'W');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'F_OR_M'
       ,'F'
       ,'Full Width' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'F_OR_M'
                    AND  GPL_VALUE = 'F');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'F_OR_M'
       ,'M'
       ,'Maintained Width' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'F_OR_M'
                    AND  GPL_VALUE = 'M');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'INSPECTION_TYPE'
       ,'D'
       ,'Detailed' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'INSPECTION_TYPE'
                    AND  GPL_VALUE = 'D');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'INSPECTION_TYPE'
       ,'S'
       ,'Safety' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'INSPECTION_TYPE'
                    AND  GPL_VALUE = 'S');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'LOCAL_DTP'
       ,'D'
       ,'DoT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'LOCAL_DTP'
                    AND  GPL_VALUE = 'D');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'LOCAL_DTP'
       ,'L'
       ,'Local' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'LOCAL_DTP'
                    AND  GPL_VALUE = 'L');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'LP_OR_OTHER'
       ,'LP'
       ,'Lighting Points' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'LP_OR_OTHER'
                    AND  GPL_VALUE = 'LP');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'LP_OR_OTHER'
       ,'O'
       ,'Other Electrical Inventory' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'LP_OR_OTHER'
                    AND  GPL_VALUE = 'O');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'MAI_P_DEL_REV'
       ,'DELETE'
       ,'Delete batches' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'MAI_P_DEL_REV'
                    AND  GPL_VALUE = 'DELETE');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'MAI_P_DEL_REV'
       ,'REVIEW'
       ,'Review batches for deletion' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'MAI_P_DEL_REV'
                    AND  GPL_VALUE = 'REVIEW');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'M_OR_I'
       ,'I'
       ,'Inspection' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'M_OR_I'
                    AND  GPL_VALUE = 'I');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'M_OR_I'
       ,'M'
       ,'Maintenance' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'M_OR_I'
                    AND  GPL_VALUE = 'M');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'ORDER_SHEET_BOTH'
       ,'B'
       ,'Works Sheet and Control Sheet' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'ORDER_SHEET_BOTH'
                    AND  GPL_VALUE = 'B');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'ORDER_SHEET_BOTH'
       ,'C'
       ,'Control Sheet only' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'ORDER_SHEET_BOTH'
                    AND  GPL_VALUE = 'C');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'ORDER_SHEET_BOTH'
       ,'W'
       ,'Works Order only' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'ORDER_SHEET_BOTH'
                    AND  GPL_VALUE = 'W');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'O_OR_P'
       ,'O'
       ,'Outstanding' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'O_OR_P'
                    AND  GPL_VALUE = 'O');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'O_OR_P'
       ,'P'
       ,'Progressing' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'O_OR_P'
                    AND  GPL_VALUE = 'P');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'REPAIR_TYPE'
       ,'P'
       ,'Permanent' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'REPAIR_TYPE'
                    AND  GPL_VALUE = 'P');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'REPAIR_TYPE'
       ,'T'
       ,'Temporary' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'REPAIR_TYPE'
                    AND  GPL_VALUE = 'T');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'R_OR_C_OR_A'
       ,'A'
       ,'All Works Orders' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'R_OR_C_OR_A'
                    AND  GPL_VALUE = 'A');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'R_OR_C_OR_A'
       ,'C'
       ,'Complete Works Orders' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'R_OR_C_OR_A'
                    AND  GPL_VALUE = 'C');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'R_OR_C_OR_A'
       ,'R'
       ,'Raised (Uncompleted) Works Orders' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'R_OR_C_OR_A'
                    AND  GPL_VALUE = 'R');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'R_OR_T'
       ,'R'
       ,'Road Order' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'R_OR_T'
                    AND  GPL_VALUE = 'R');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'R_OR_T'
       ,'T'
       ,'Time Order' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'R_OR_T'
                    AND  GPL_VALUE = 'T');
--
INSERT INTO GRI_PARAM_LOOKUP
       (GPL_PARAM
       ,GPL_VALUE
       ,GPL_DESCR
       )
SELECT 
        'SVR_FORMAT'
       ,'U'
       ,'Update Mode' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_LOOKUP
                   WHERE GPL_PARAM = 'SVR_FORMAT'
                    AND  GPL_VALUE = 'U');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- LOAD_ERRORS
--
-- select * from mai_metadata.load_errors
-- order by ler_error_no
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT load_errors
SET TERM OFF

INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid defect attribute combination.'
       ,9025
       ,'Correct the defect type attribute.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9025);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Activity (H) Record expected but not found.'
       ,9104
       ,'Correct the Activity Record Type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9104);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Comment Type.'
       ,9105
       ,'Correct the Comment Type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9105);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : G record expected but not found.'
       ,9200
       ,'Correct the record type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9200);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Number of attributes in G record type is less than 7'
       ,9201
       ,'Correct the G record information.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9201);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Initiation nmeonic is not recognised.'
       ,9202
       ,'Correct the initiation nmeonic code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9202);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid initiation inspection date.'
       ,9203
       ,'Correct the Inspection initiation date in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9203);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid initiation inspection time.'
       ,9204
       ,'Correct the inspection time in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9204);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid survey type indicator.'
       ,9205
       ,'Correct the survey type indicator in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9205);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid survey direction indicator.'
       ,9206
       ,'Correct the survey indicator value in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9206);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Linkcode / Section identifier.'
       ,9207
       ,'Correct the Linkcode / Section identifier in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9207);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : The Primary inspector cannot be located.'
       ,9208
       ,'Correct the Primary inspectors initials in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9208);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : The Secondary inspector cannot be located.'
       ,9209
       ,'Correct the Secondary inspectors initials in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9209);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Defect sequence value DEF_DEFECT_ID missing from CODE_CONTROLS'
       ,9210
       ,'Insert the DEF_DEFECT_ID entry into CODE_CONTROLS.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9210);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Road Surface condition code.'
       ,9211
       ,'Correct the Road Surface condition code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9211);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Weather condition code.'
       ,9212
       ,'Correct the weathher condition code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9212);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to obtain interval code.'
       ,9213
       ,'Check the interval codes for valid code values.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9213);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to locate specified section.'
       ,9214
       ,'Check the document management section reference.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9214);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to obtain document sequence number.'
       ,9215
       ,'Check the document sequence for availability.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9215);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to obtain inspectors Admin unit.'
       ,9216
       ,'Check the current inspectors Administration unit.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9216);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to insert into the DOCS table.'
       ,9217
       ,'Check the complaint record for errors.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9217);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to insert into the DOC_ASSOCS table.'
       ,9218
       ,'Check the complaint record and correct.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9218);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to obtain the status for a new defect.'
       ,9219
       ,'Check the STATUS CODES values.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9219);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : H record expected but not found.'
       ,9220
       ,'Correct the H record indicator.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9220);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid activity area code on H type record for this section.'
       ,9221
       ,'Correct the defect location time hhmm'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9221);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : P record expected but not found.'
       ,9240
       ,'Correct the P record indicator.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9240);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Chainage on I record exceeds required chainage for section.'
       ,9260
       ,'Correct the section chainage.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9260);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid defect Location time.'
       ,9261
       ,'Correct the defect location time hhmm'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9261);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid chainage indicator.'
       ,9262
       ,'Correct the chainage indicator value.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9262);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid sub-section item code.'
       ,9263
       ,'Correct the sub-section item code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9263);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid notifiable organisation code.'
       ,9264
       ,'Correct the notifiable organisation code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9264);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid rechargeable organisation code.'
       ,9265
       ,'Correct the rechargeable organisation code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9265);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Cross Sectional Position (XSP)'
       ,9266
       ,'Correct the Cross Sectional Position.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9266);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid activity nmeonic/defect code combination.'
       ,9300
       ,'Correct the activity code nmeonic.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9300);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid inspection time.'
       ,9301
       ,'Correct the inspection time in the G record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9301);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Inspection date.'
       ,9302
       ,'Correct the Inspection date.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9302);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Survey type.'
       ,9303
       ,'Correct the Survey Type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9303);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid defect priority code.'
       ,9304
       ,'Correct the defect priority code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9304);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Defect/Priority combination.'
       ,9305
       ,'Correct the Defect/Priority and re-submit.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9305);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid reverse survey direction indicator.'
       ,9309
       ,'Correct the Reverse Survey Direction indicator value (Y/N).'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9309);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Treatment Code.'
       ,9400
       ,'Correct the treatment code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9400);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Start chainage exceeds end chainage.'
       ,9401
       ,'Correct the chainage values.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9401);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Incorrect start chainage value ( chainage is null )'
       ,9402
       ,'Correct the start chainage value.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9402);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Inspection Date less than previously loaded inspection.  '
       ,9500
       ,'Correct the inspection date.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9500);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Defect Location (I) Record Type.'
       ,9501
       ,'Correct the Defect Location Record Type indicator.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9501);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid Defect (J) record Type.'
       ,9502
       ,'Correct the Defect Location Record Type indicator.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9502);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Action record (K/L/M/N) expected but not found.'
       ,9503
       ,'Correct the action type record for this section.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9503);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Section chainage record (P) expected but not found.'
       ,9504
       ,'Correct the section chainage record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9504);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Repair record expected but not found.'
       ,9505
       ,'Correct the repair record and re-submit.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9505);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Repair target date cannot be obtained from defect priorities.'
       ,9506
       ,'Check the defect priorities or correct the defect/activity code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9506);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to obtain system option WEEKEND.'
       ,9507
       ,'Ensure that the system option WEEKEND is defined.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9507);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to obtain the current day from DUAL.'
       ,9508
       ,'Ensure that there is select access from dual - ask support.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9508);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to locate defect priority interval record.'
       ,9509
       ,'Ensure that there is a defect priority record for this interval.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9509);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid action completion date.'
       ,9510
       ,'Ensure that the action completion date is correct.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9510);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid action completion time.'
       ,9511
       ,'Ensure that the action completion time is correct.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9511);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Job item location error.'
       ,9512
       ,'Ensure that the job item is correct.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9512);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Q type record expected but not found.'
       ,9513
       ,'Ensure that the next record is a Job Item record type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9513);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : R type record expected but not found.'
       ,9514
       ,'Ensure that the next record is a Comment record type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9514);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : S type record expected but not found.'
       ,9515
       ,'Ensure that the next record is a Complaint record type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9515);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Unable to locate INTERVAL record.'
       ,9516
       ,'Ensure there is an INTERVAL record present.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9516);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : An immediate (COMPLETED) repair may NOT have BOQ items.'
       ,9517
       ,'All BOQ items associated with the immediate repair must be deleted.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9517);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Recalibration for section inspection not started at chainage 0 '
       ,9600
       ,'Correct the Start Chainge.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9600);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Recalibration for section execeeds 50% of section length .'
       ,9601
       ,'Correct the Section Length or Chainage value.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9601);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Error cannot find P record to carry out recalibration.'
       ,9602
       ,'Correct the P record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9602);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Defect XSP required but not supplied.'
       ,9603
       ,'Correct the defect location record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9603);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : No Default Treatment for this Defect / Activity area.'
       ,9604
       ,'Correct the Default Treatment type.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9604);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Defect chainage value required but not supplied.'
       ,9605
       ,'Correct the defect location record.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9605);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid complaint record date.'
       ,9701
       ,'Correct the complaint record date.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9701);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid complaint record time.'
       ,9702
       ,'Correct the complaint record time.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9702);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Error : Invalid complaint source code.'
       ,9703
       ,'Correct the complaint source code.'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9703);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Invalid Combination of Complaint Category / Complaint Type'
       ,9704
       ,'The Complaint Category used is derived from the User Option ENQCAT. The'
       ,'Complaint Type is supplied in the DCD load file. Check Document Types / Classes'
       ,'(DOC0110) to ensure that the combination is valid, that they are not end dated'
       ,'and that complaints are allowed for these values.' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9704);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Invalid defect Response Category. Use the DOMAINS form.'
       ,9705
       ,'Using the DOMAINS form check that the category displayed within the'
       ,'specified record exists for the DEFECT_RESPONSE_CAT domain.'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9705);
--
INSERT INTO LOAD_ERRORS
       (LER_DESCR
       ,LER_ERROR_NO
       ,LER_ACTION_1
       ,LER_ACTION_2
       ,LER_ACTION_3
       ,LER_ACTION_4
       )
SELECT 
        'Could not derive Default Complaint Status'
       ,9706
       ,'Check a valid Complaint Status has been set in Status Codes module (HIG9110).'
       ,'The Default Complaint Status should have Feature Code 1 set to Y.'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM LOAD_ERRORS
                   WHERE LER_ERROR_NO = 9706);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- NM_AU_TYPES
--
-- select * from mai_metadata.nm_au_types
-- order by nat_admin_type
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT nm_au_types
SET TERM OFF

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
