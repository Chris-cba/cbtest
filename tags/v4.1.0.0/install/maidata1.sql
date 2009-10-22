-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/maidata1.sql-arc   2.11   Oct 22 2009 13:33:38   mhuitson  $
--       Module Name      : $Workfile:   maidata1.sql  $
--       Date into PVCS   : $Date:   Oct 22 2009 13:33:38  $
--       Date fetched Out : $Modtime:   Oct 22 2009 13:30:38  $
--       Version          : $Revision:   2.11  $
--       Table Owner      : MAI_METADATA
--       Generation Date  : 22-OCT-2009 13:28
--
--   Product metadata script
--   As at Release 4.1.0.0
--
--   Copyright (c) exor corporation ltd, 2009
--
--   TABLES PROCESSED
--   ================
--   HIG_PRODUCTS
--   NM_ERRORS
--   HIG_DOMAINS
--   HIG_CODES
--   HIG_MODULES
--   HIG_OPTION_LIST
--   HIG_OPTION_VALUES
--   HIG_STATUS_DOMAINS
--   HIG_STATUS_CODES
--   HIG_USER_OPTION_LIST
--   HIG_CHECK_CONSTRAINT_ASSOCS
--   HIG_STANDARD_FAVOURITES
--
-----------------------------------------------------------------------------


set define off;
set feedback off;

---------------------------------
-- START OF GENERATED METADATA --
---------------------------------


----------------------------------------------------------------------------------------
-- HIG_PRODUCTS
--
-- select * from mai_metadata.hig_products
-- order by hpr_product
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_products
SET TERM OFF

INSERT INTO HIG_PRODUCTS
       (HPR_PRODUCT
       ,HPR_PRODUCT_NAME
       ,HPR_VERSION
       ,HPR_PATH_NAME
       ,HPR_KEY
       ,HPR_SEQUENCE
       )
SELECT 
        'MAI'
       ,'maintenance manager'
       ,'3.1.1.0'
       ,''
       ,null
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PRODUCTS
                   WHERE HPR_PRODUCT = 'MAI');
--
INSERT INTO HIG_PRODUCTS
       (HPR_PRODUCT
       ,HPR_PRODUCT_NAME
       ,HPR_VERSION
       ,HPR_PATH_NAME
       ,HPR_KEY
       ,HPR_SEQUENCE
       )
SELECT 
        'PMS'
       ,'structural projects v2 - REDUNDANT'
       ,'3.1.1.0'
       ,''
       ,null
       ,20 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PRODUCTS
                   WHERE HPR_PRODUCT = 'PMS');
--
INSERT INTO HIG_PRODUCTS
       (HPR_PRODUCT
       ,HPR_PRODUCT_NAME
       ,HPR_VERSION
       ,HPR_PATH_NAME
       ,HPR_KEY
       ,HPR_SEQUENCE
       )
SELECT 
        'STP'
       ,'structural projects'
       ,'3.1.1.0'
       ,''
       ,null
       ,20 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PRODUCTS
                   WHERE HPR_PRODUCT = 'STP');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- NM_ERRORS
--
-- select * from mai_metadata.nm_errors
-- order by ner_appl
--         ,ner_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT nm_errors
SET TERM OFF

INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,133
       ,null
       ,'Another Works Order already exists with this number'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 133);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,900
       ,null
       ,'Gang cannot be null for re-allocation.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 900);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,901
       ,null
       ,'Asset Matches More Than One Budget Allocation Criteria. Please Consult Your exor Systems Administrator'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 901);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,902
       ,null
       ,'Budget Allocation does not exist - Please consult your exor Systems Administrator.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 902);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,903
       ,null
       ,'Please Select Assets Of A Single Type'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 903);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,904
       ,null
       ,'Cannot Find Interval For Priority/Repair Category'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 904);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,905
       ,null
       ,'Cannot Find Interval For Road'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 905);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,906
       ,null
       ,'Cannot Find Due Date From Interval'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 906);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,907
       ,null
       ,'Auto Defect Priority : Please check your rules - no priority exists'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 907);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,910
       ,null
       ,'Cannot Delete Record - Corresponding Budget Record Exists on Work_Order_Lines Table.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 910);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,911
       ,null
       ,'Cannot Update Final Flag - Date Repaired is Null.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 911);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,912
       ,null
       ,'Cannot Update to Completed as Contract Year End Date has passed.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 912);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,913
       ,null
       ,'Cannot delete line as section is end dated. Line must be completed.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 913);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,914
       ,900
       ,'Only the most recent invoice can be approved for each Works Order Line.'
       ,'Trying to load an invoice which is not the latest' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 914);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,915
       ,null
       ,'This works order cannot be copied.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 915);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,916
       ,null
       ,'This works order line cannot be copied.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 916);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,917
       ,null
       ,'Cannot derive a works order number.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 917);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,918
       ,null
       ,'TMA must be installed and licenced in order to Self Notice'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 918);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,919
       ,null
       ,'Cannot find matching works order.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 919);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,920
       ,null
       ,'Cannot find matching works order line.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 920);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,921
       ,null
       ,'Cannot Delete / Modify Record as Associated Records Exist'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 921);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,922
       ,null
       ,'Order cannot be instructed as a Dummy Contract is being used.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 922);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,923
       ,null
       ,'Record has changed, do you want to requery?'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 923);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,924
       ,null
       ,'Once report has been produced, press OK to refresh data?'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 924);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,925
       ,null
       ,'Invalid Gang work type'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 925);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,926
       ,null
       ,'No Work Order Lines - cannot locate the Work Order on the GIS'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 926);
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,927
       ,null
       ,'The Dummy Contract specified in Product Option DUMCONCODE is invaild.'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 927);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_DOMAINS
--
-- select * from mai_metadata.hig_domains
-- order by hdo_domain
--
----------------------------------------------------------------------------------------

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
        'ADSP_RSE_ATTS'
       ,'MAI'
       ,'Road Section Attributes'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ADSP_RSE_ATTS');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ASSESSMENT_CODE'
       ,'MAI'
       ,'Assessment Codes'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ASSESSMENT_CODE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ASSET_MODIFICATION'
       ,'MAI'
       ,'Asset Modification Flag'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ASSET_MODIFICATION');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ATV_CALC_TYPE'
       ,'MAI'
       ,'Calculation Method'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ATV_CALC_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ATV_UNIT'
       ,'MAI'
       ,'Unit of Measurement'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ATV_UNIT');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'CHECK_CODE'
       ,'MAI'
       ,'Quality Inspection Check Codes'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'CHECK_CODE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'CHECK_RESULT'
       ,'MAI'
       ,'Quality Inspection Results'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'CHECK_RESULT');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'CONTRACTOR_USER_SEC'
       ,'MAI'
       ,'Contractor User Security Status'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'CONTRACTOR_USER_SEC');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'CONTRACT_SECURITY'
       ,'MAI'
       ,'Values for PO CONSECMODE'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'CONTRACT_SECURITY');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'CREDIT_TYPE'
       ,'MAI'
       ,'Credit Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'CREDIT_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'DEFECT_ATTRIBUTES'
       ,'MAI'
       ,'Defect Attributes'
       ,30 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'DEFECT_ATTRIBUTES');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'DEFECT_PRIORITIES'
       ,'MAI'
       ,'Defect Priorities'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'DEFECT_PRIORITIES');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'DEFLECTOGRAPH_BANDS'
       ,'MAI'
       ,'Bands to aggregate Deflectograph Results'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'DEFLECTOGRAPH_BANDS');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ELEC_BOARD'
       ,'MAI'
       ,'Electricity Board Ids'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ELEC_BOARD');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ELEC_ID'
       ,'MAI'
       ,'Electricity Board Codes'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ELEC_ID');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'GANG'
       ,'MAI'
       ,'Gang Number Allocation'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'GANG');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'GANG_WORK_TYPE'
       ,'MAI'
       ,'Gang Work type'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'GANG_WORK_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'INITIATION_TYPE'
       ,'MAI'
       ,'Activity Reports Initiation Types'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'INITIATION_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'INS_CLAIMS_REPORT'
       ,'MAI'
       ,'Insurance Claims Report Formats'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'INS_CLAIMS_REPORT');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'INTERIM_PAYMENT'
       ,'MAI'
       ,'Interim Payment Status'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'INTERIM_PAYMENT');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'INVENTORY_GROUPS'
       ,'MAI'
       ,'Inventory Groupings'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'INVENTORY_GROUPS');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'LAMP_CONFIGS'
       ,'MAI'
       ,'Lamp Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'LAMP_CONFIGS');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'MAINT_INSP_FLAG'
       ,'MAI'
       ,'Maintenance Inspection Flag'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'MAINT_INSP_FLAG');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ORG_UNIT_TYPE'
       ,'MAI'
       ,'Organisation Unit Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ORG_UNIT_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'PARAMETER_TYPE'
       ,'MAI'
       ,'Parameter Type'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'PARAMETER_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'PBI_CONDITION'
       ,'MAI'
       ,'SQL Condition Types'
       ,20 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'PBI_CONDITION');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'PROGRAMME_TYPE'
       ,'MAI'
       ,'Scheme Programme Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'PROGRAMME_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'QUALITY_CODE'
       ,'MAI'
       ,'Quality Codes'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'QUALITY_CODE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'REPAIR_TYPE'
       ,'MAI'
       ,'Defect Repair Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'REPAIR_TYPE');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'REQUIRED_TYPES'
       ,'MAI'
       ,'Work Category Required Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'REQUIRED_TYPES');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'RESPONSE_TYPES'
       ,'MAI'
       ,'Defect Notice Response Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'RESPONSE_TYPES');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'ROAD_CHARACTERISTIC'
       ,'MAI'
       ,'Inventory Type Characteristics'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ROAD_CHARACTERISTIC');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'SCHEME_TYPES'
       ,'MAI'
       ,'Work Category Scheme Types'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'SCHEME_TYPES');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'SUMMATION_TYPES'
       ,'MAI'
       ,'Road Condition Report - Summation Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'SUMMATION_TYPES');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'USER_OPTIONS'
       ,'MAI'
       ,'Highways User Options'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'USER_OPTIONS');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'WOR_FLAG'
       ,'MAI'
       ,'Works Order Type'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'WOR_FLAG');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'WOR_PRIORITY'
       ,'MAI'
       ,'Works Order Priority'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'WOR_PRIORITY');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'WOR_REGISTER_STATUS'
       ,'MAI'
       ,'Works Order Register Status'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'WOR_REGISTER_STATUS');
--
INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'XSP_TYPE'
       ,'MAI'
       ,'Cross Sectional Position Types'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'XSP_TYPE');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_CODES
--
-- select * from mai_metadata.hig_codes
-- order by hco_domain
--         ,hco_code
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_codes
SET TERM OFF

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
        'ADSP_RSE_ATTS'
       ,'1'
       ,'RSE_ROAD_TYPE'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '1');
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
        'ADSP_RSE_ATTS'
       ,'2'
       ,'RSE_CARRIAGEWAY_TYPE'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '2');
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
        'ADSP_RSE_ATTS'
       ,'3'
       ,'RSE_ROAD_ENVIRONMENT'
       ,'Y'
       ,3
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '3');
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
        'ADSP_RSE_ATTS'
       ,'4'
       ,'RSE_MAINT_CATEGORY'
       ,'Y'
       ,4
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '4');
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
        'ADSP_RSE_ATTS'
       ,'5'
       ,'RSE_FOOTWAY_CATEGORY'
       ,'Y'
       ,5
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '5');
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
        'ADSP_RSE_ATTS'
       ,'6'
       ,'RSE_ROAD_CATEGORY'
       ,'Y'
       ,6
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '6');
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
        'ADSP_RSE_ATTS'
       ,'7'
       ,'RSE_TRAFFIC_LEVEL'
       ,'Y'
       ,7
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '7');
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
        'ADSP_RSE_ATTS'
       ,'8'
       ,'RSE_SCL_SECT_CLASS'
       ,'Y'
       ,8
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ADSP_RSE_ATTS'
                    AND  HCO_CODE = '8');
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
        'ASSESSMENT_CODE'
       ,'DF'
       ,'Deflectograph'
       ,'Y'
       ,4
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSESSMENT_CODE'
                    AND  HCO_CODE = 'DF');
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
        'ASSESSMENT_CODE'
       ,'HL'
       ,'Longitudinal Profile'
       ,'Y'
       ,5
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSESSMENT_CODE'
                    AND  HCO_CODE = 'HL');
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
        'ASSESSMENT_CODE'
       ,'HR'
       ,'Rutting Depth'
       ,'Y'
       ,6
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSESSMENT_CODE'
                    AND  HCO_CODE = 'HR');
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
        'ASSESSMENT_CODE'
       ,'HT'
       ,'Macrotexture'
       ,'Y'
       ,7
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSESSMENT_CODE'
                    AND  HCO_CODE = 'HT');
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
        'ASSESSMENT_CODE'
       ,'MC'
       ,'March'
       ,'Y'
       ,8
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSESSMENT_CODE'
                    AND  HCO_CODE = 'MC');
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
        'ASSESSMENT_CODE'
       ,'SR'
       ,'Skid'
       ,'Y'
       ,9
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSESSMENT_CODE'
                    AND  HCO_CODE = 'SR');
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
        'ASSET_MODIFICATION'
       ,'A'
       ,'Add New'
       ,'Y'
       ,4
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                    AND  HCO_CODE = 'A');
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
        'ASSET_MODIFICATION'
       ,'D'
       ,'Decommission'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                    AND  HCO_CODE = 'D');
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
        'ASSET_MODIFICATION'
       ,'R'
       ,'Replace'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                    AND  HCO_CODE = 'R');
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
        'ASSET_MODIFICATION'
       ,'U'
       ,'Upgrade'
       ,'Y'
       ,3
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                    AND  HCO_CODE = 'U');
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
        'ATV_CALC_TYPE'
       ,'A'
       ,'Area'
       ,'Y'
       ,10
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_CALC_TYPE'
                    AND  HCO_CODE = 'A');
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
        'ATV_CALC_TYPE'
       ,'L'
       ,'Length'
       ,'Y'
       ,11
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_CALC_TYPE'
                    AND  HCO_CODE = 'L');
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
        'ATV_CALC_TYPE'
       ,'N'
       ,'Number'
       ,'Y'
       ,12
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_CALC_TYPE'
                    AND  HCO_CODE = 'N');
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
        'ATV_CALC_TYPE'
       ,'T'
       ,'Trapezium Area Rule'
       ,'Y'
       ,13
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_CALC_TYPE'
                    AND  HCO_CODE = 'T');
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
        'ATV_UNIT'
       ,'GRIP'
       ,'Grip'
       ,'Y'
       ,15
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'GRIP');
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
        'ATV_UNIT'
       ,'GULLEY'
       ,'Gulley'
       ,'Y'
       ,16
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'GULLEY');
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
        'ATV_UNIT'
       ,'ITEM'
       ,'Item'
       ,'Y'
       ,17
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'ITEM');
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
        'ATV_UNIT'
       ,'LIN.M'
       ,'Metres'
       ,'Y'
       ,19
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'LIN.M');
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
        'ATV_UNIT'
       ,'PERCENT'
       ,'Percent'
       ,'Y'
       ,25
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'PERCENT');
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
        'ATV_UNIT'
       ,'PIT'
       ,'Pit'
       ,'Y'
       ,21
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'PIT');
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
        'ATV_UNIT'
       ,'POINT'
       ,'Point'
       ,'Y'
       ,22
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'POINT');
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
        'ATV_UNIT'
       ,'SIGN'
       ,'Sign'
       ,'Y'
       ,23
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'SIGN');
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
        'ATV_UNIT'
       ,'SQ.M'
       ,'Square Metres'
       ,'Y'
       ,24
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ATV_UNIT'
                    AND  HCO_CODE = 'SQ.M');
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
        'CHECK_CODE'
       ,'BR'
       ,'Broken'
       ,'Y'
       ,25
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_CODE'
                    AND  HCO_CODE = 'BR');
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
        'CHECK_CODE'
       ,'CR'
       ,'Cracked'
       ,'Y'
       ,26
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_CODE'
                    AND  HCO_CODE = 'CR');
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
        'CHECK_CODE'
       ,'DF'
       ,'Defective'
       ,'Y'
       ,27
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_CODE'
                    AND  HCO_CODE = 'DF');
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
        'CHECK_CODE'
       ,'HI'
       ,'High'
       ,'Y'
       ,28
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_CODE'
                    AND  HCO_CODE = 'HI');
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
        'CHECK_CODE'
       ,'LO'
       ,'Low'
       ,'Y'
       ,29
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_CODE'
                    AND  HCO_CODE = 'LO');
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
        'CHECK_CODE'
       ,'UN'
       ,'Uneven'
       ,'Y'
       ,30
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_CODE'
                    AND  HCO_CODE = 'UN');
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
        'CHECK_RESULT'
       ,'B'
       ,'Borderline'
       ,'Y'
       ,31
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_RESULT'
                    AND  HCO_CODE = 'B');
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
        'CHECK_RESULT'
       ,'F'
       ,'Fail'
       ,'Y'
       ,32
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_RESULT'
                    AND  HCO_CODE = 'F');
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
        'CHECK_RESULT'
       ,'P'
       ,'Pass'
       ,'Y'
       ,33
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CHECK_RESULT'
                    AND  HCO_CODE = 'P');
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
        'CONTRACTOR_USER_SEC'
       ,'N'
       ,'Not enabled, see Product Option CONSECMODE'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CONTRACTOR_USER_SEC'
                    AND  HCO_CODE = 'N');
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
        'CONTRACTOR_USER_SEC'
       ,'Y'
       ,'Enabled'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CONTRACTOR_USER_SEC'
                    AND  HCO_CODE = 'Y');
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
        'CONTRACT_SECURITY'
       ,'A'
       ,'Contract Admin Unit Security Enabled'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CONTRACT_SECURITY'
                    AND  HCO_CODE = 'A');
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
        'CONTRACT_SECURITY'
       ,'N'
       ,'Not Enabled'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CONTRACT_SECURITY'
                    AND  HCO_CODE = 'N');
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
        'CONTRACT_SECURITY'
       ,'U'
       ,'Contractor User Security Enabled'
       ,'Y'
       ,3
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CONTRACT_SECURITY'
                    AND  HCO_CODE = 'U');
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
        'CREDIT_TYPE'
       ,'1'
       ,'1 month credit'
       ,'Y'
       ,60
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CREDIT_TYPE'
                    AND  HCO_CODE = '1');
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
        'CREDIT_TYPE'
       ,'2'
       ,'2 months credit'
       ,'Y'
       ,61
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'CREDIT_TYPE'
                    AND  HCO_CODE = '2');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_AREA'
       ,'Defect Area'
       ,'Y'
       ,62
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_AREA');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_COORD_FLAG'
       ,'Coord. Flag'
       ,'Y'
       ,63
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_COORD_FLAG');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_DEFECT_DESCR'
       ,'Defect Descr'
       ,'Y'
       ,72
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_DEFECT_DESCR');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_DIAGRAM_NO'
       ,'Diagram No'
       ,'Y'
       ,64
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_DIAGRAM_NO');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_HEIGHT'
       ,'Height'
       ,'Y'
       ,65
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_HEIGHT');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_IDENT_CODE'
       ,'Ident Code'
       ,'Y'
       ,66
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_IDENT_CODE');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_LENGTH'
       ,'Length'
       ,'Y'
       ,67
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_LENGTH');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_NUMBER'
       ,'Number'
       ,'Y'
       ,68
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_NUMBER');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_PER_CENT'
       ,'Per Cent'
       ,'Y'
       ,69
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_PER_CENT');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_SERIAL_NO'
       ,'Serial No'
       ,'Y'
       ,70
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_SERIAL_NO');
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
        'DEFECT_ATTRIBUTES'
       ,'DEF_SKID_COEFF'
       ,'Skid Coeff.'
       ,'Y'
       ,71
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_ATTRIBUTES'
                    AND  HCO_CODE = 'DEF_SKID_COEFF');
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
        'DEFECT_PRIORITIES'
       ,'1'
       ,'Category 1'
       ,'Y'
       ,null
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_PRIORITIES'
                    AND  HCO_CODE = '1');
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
        'DEFECT_PRIORITIES'
       ,'2.1'
       ,'Category 2.1'
       ,'Y'
       ,null
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_PRIORITIES'
                    AND  HCO_CODE = '2.1');
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
        'DEFECT_PRIORITIES'
       ,'2.2'
       ,'Category 2.2'
       ,'Y'
       ,null
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_PRIORITIES'
                    AND  HCO_CODE = '2.2');
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
        'DEFECT_PRIORITIES'
       ,'2.3'
       ,'Category 2.3'
       ,'Y'
       ,null
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFECT_PRIORITIES'
                    AND  HCO_CODE = '2.3');
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
        'DEFLECTOGRAPH_BANDS'
       ,'-99'
       ,'Band A lower limit incl'
       ,'Y'
       ,80
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFLECTOGRAPH_BANDS'
                    AND  HCO_CODE = '-99');
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
        'DEFLECTOGRAPH_BANDS'
       ,'05'
       ,'Band A upper limit incl - Band B lower limit'
       ,'Y'
       ,81
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFLECTOGRAPH_BANDS'
                    AND  HCO_CODE = '05');
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
        'DEFLECTOGRAPH_BANDS'
       ,'10'
       ,'Band B upper limit incl - Band C lower limit'
       ,'Y'
       ,82
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFLECTOGRAPH_BANDS'
                    AND  HCO_CODE = '10');
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
        'DEFLECTOGRAPH_BANDS'
       ,'99'
       ,'Band C upper limit incl'
       ,'Y'
       ,83
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'DEFLECTOGRAPH_BANDS'
                    AND  HCO_CODE = '99');
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
        'ELEC_BOARD'
       ,'1'
       ,'EMEL'
       ,'Y'
       ,101
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '1');
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
        'ELEC_BOARD'
       ,'2'
       ,'EAEL'
       ,'Y'
       ,102
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '2');
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
        'ELEC_BOARD'
       ,'3'
       ,'LOEL'
       ,'Y'
       ,103
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '3');
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
        'ELEC_BOARD'
       ,'4'
       ,'MANW'
       ,'Y'
       ,104
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '4');
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
        'ELEC_BOARD'
       ,'5'
       ,'MIEL'
       ,'Y'
       ,105
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '5');
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
        'ELEC_BOARD'
       ,'6'
       ,'NAPO'
       ,'Y'
       ,106
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '6');
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
        'ELEC_BOARD'
       ,'7'
       ,'NOEL'
       ,'Y'
       ,107
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '7');
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
        'ELEC_BOARD'
       ,'8'
       ,'NORW'
       ,'Y'
       ,108
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '8');
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
        'ELEC_BOARD'
       ,'9'
       ,'PGEN'
       ,'Y'
       ,109
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = '9');
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
        'ELEC_BOARD'
       ,'A'
       ,'SEAB'
       ,'Y'
       ,110
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = 'A');
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
        'ELEC_BOARD'
       ,'B'
       ,'SWAL'
       ,'Y'
       ,111
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = 'B');
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
        'ELEC_BOARD'
       ,'C'
       ,'SOEL'
       ,'Y'
       ,112
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = 'C');
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
        'ELEC_BOARD'
       ,'D'
       ,'SWEL'
       ,'Y'
       ,113
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = 'D');
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
        'ELEC_BOARD'
       ,'E'
       ,'YOEL'
       ,'Y'
       ,114
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_BOARD'
                    AND  HCO_CODE = 'E');
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
        'ELEC_ID'
       ,'EAEL'
       ,'Eastern Electricity'
       ,'Y'
       ,115
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'EAEL');
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
        'ELEC_ID'
       ,'EMEL'
       ,'East Midlands Electricity'
       ,'Y'
       ,116
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'EMEL');
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
        'ELEC_ID'
       ,'LOEL'
       ,'London Electricity PLC'
       ,'Y'
       ,117
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'LOEL');
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
        'ELEC_ID'
       ,'MANW'
       ,'MANWEB'
       ,'Y'
       ,118
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'MANW');
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
        'ELEC_ID'
       ,'MIEL'
       ,'Midlands Electricity'
       ,'Y'
       ,119
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'MIEL');
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
        'ELEC_ID'
       ,'NAPO'
       ,'National Power PLC'
       ,'Y'
       ,120
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'NAPO');
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
        'ELEC_ID'
       ,'NOEL'
       ,'Northern Electric'
       ,'Y'
       ,121
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'NOEL');
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
        'ELEC_ID'
       ,'NORW'
       ,'NORWEB'
       ,'Y'
       ,122
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'NORW');
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
        'ELEC_ID'
       ,'PGEN'
       ,'Powergen'
       ,'Y'
       ,123
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'PGEN');
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
        'ELEC_ID'
       ,'SEAB'
       ,'SEABOARD'
       ,'Y'
       ,124
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'SEAB');
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
        'ELEC_ID'
       ,'SOEL'
       ,'Southern Electric'
       ,'Y'
       ,125
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'SOEL');
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
        'ELEC_ID'
       ,'SWAL'
       ,'South Wales Electricity'
       ,'Y'
       ,126
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'SWAL');
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
        'ELEC_ID'
       ,'SWEL'
       ,'South Western Electricity'
       ,'Y'
       ,127
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'SWEL');
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
        'ELEC_ID'
       ,'YOEL'
       ,'Yorkshire Electricity'
       ,'Y'
       ,128
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ELEC_ID'
                    AND  HCO_CODE = 'YOEL');
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
        'GANG'
       ,'1'
       ,'Gang 1'
       ,'N'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG'
                    AND  HCO_CODE = '1');
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
        'GANG'
       ,'2'
       ,'Gang 2'
       ,'N'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG'
                    AND  HCO_CODE = '2');
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
        'GANG'
       ,'3'
       ,'Gang 3'
       ,'N'
       ,3
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG'
                    AND  HCO_CODE = '3');
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
        'GANG'
       ,'4'
       ,'Gang 4'
       ,'N'
       ,4
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG'
                    AND  HCO_CODE = '4');
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
        'GANG_WORK_TYPE'
       ,'ALL'
       ,'All items'
       ,'N'
       ,4
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG_WORK_TYPE'
                    AND  HCO_CODE = 'ALL');
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
        'GANG_WORK_TYPE'
       ,'CA'
       ,'Cash Value'
       ,'N'
       ,5
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG_WORK_TYPE'
                    AND  HCO_CODE = 'CA');
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
        'GANG_WORK_TYPE'
       ,'JET'
       ,'Jetting'
       ,'N'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG_WORK_TYPE'
                    AND  HCO_CODE = 'JET');
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
        'GANG_WORK_TYPE'
       ,'POT'
       ,'Pothole'
       ,'N'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG_WORK_TYPE'
                    AND  HCO_CODE = 'POT');
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
        'GANG_WORK_TYPE'
       ,'TM'
       ,'Traffic Management'
       ,'N'
       ,3
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'GANG_WORK_TYPE'
                    AND  HCO_CODE = 'TM');
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
        'INITIATION_TYPE'
       ,'DUM'
       ,'Dummy'
       ,'Y'
       ,null
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                    AND  HCO_CODE = 'DUM');
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
        'INITIATION_TYPE'
       ,'NRM'
       ,'Normal'
       ,'Y'
       ,135
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                    AND  HCO_CODE = 'NRM');
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
        'INITIATION_TYPE'
       ,'OTH'
       ,'Other'
       ,'Y'
       ,136
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                    AND  HCO_CODE = 'OTH');
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
        'INITIATION_TYPE'
       ,'PAT'
       ,'Safety Patrol'
       ,'Y'
       ,null
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                    AND  HCO_CODE = 'PAT');
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
        'INITIATION_TYPE'
       ,'PBL'
       ,'Public'
       ,'Y'
       ,137
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                    AND  HCO_CODE = 'PBL');
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
        'INITIATION_TYPE'
       ,'PE'
       ,'Public Enquiry'
       ,'Y'
       ,138
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                    AND  HCO_CODE = 'PE');
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
        'INITIATION_TYPE'
       ,'POL'
       ,'Police'
       ,'Y'
       ,139
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                    AND  HCO_CODE = 'POL');
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
        'INS_CLAIMS_REPORT'
       ,'1'
       ,'Summary of Inspections'
       ,'Y'
       ,140
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INS_CLAIMS_REPORT'
                    AND  HCO_CODE = '1');
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
        'INS_CLAIMS_REPORT'
       ,'2'
       ,'Summary of Inspections and associated Defects'
       ,'Y'
       ,141
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INS_CLAIMS_REPORT'
                    AND  HCO_CODE = '2');
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
        'INS_CLAIMS_REPORT'
       ,'3'
       ,'Full history of Inspections and associated Defects'
       ,'Y'
       ,142
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INS_CLAIMS_REPORT'
                    AND  HCO_CODE = '3');
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
        'INTERIM_PAYMENT'
       ,'P'
       ,'Paid'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INTERIM_PAYMENT'
                    AND  HCO_CODE = 'P');
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
        'INTERIM_PAYMENT'
       ,'U'
       ,'Unpaid'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INTERIM_PAYMENT'
                    AND  HCO_CODE = 'U');
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
        'INVENTORY_GROUPS'
       ,'C'
       ,'Carriageway'
       ,'Y'
       ,143
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INVENTORY_GROUPS'
                    AND  HCO_CODE = 'C');
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
        'INVENTORY_GROUPS'
       ,'D'
       ,'Drainage'
       ,'Y'
       ,144
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INVENTORY_GROUPS'
                    AND  HCO_CODE = 'D');
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
        'INVENTORY_GROUPS'
       ,'E'
       ,'Electrical'
       ,'Y'
       ,145
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INVENTORY_GROUPS'
                    AND  HCO_CODE = 'E');
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
        'INVENTORY_GROUPS'
       ,'O'
       ,'Other'
       ,'Y'
       ,150
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INVENTORY_GROUPS'
                    AND  HCO_CODE = 'O');
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
        'INVENTORY_GROUPS'
       ,'R'
       ,'Road Condition'
       ,'Y'
       ,146
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INVENTORY_GROUPS'
                    AND  HCO_CODE = 'R');
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
        'LAMP_CONFIGS'
       ,'MBF'
       ,'High pressure Mercury, tubular fluorescent'
       ,'Y'
       ,155
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'MBF');
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
        'LAMP_CONFIGS'
       ,'MBI'
       ,'Mercury Halide'
       ,'Y'
       ,156
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'MBI');
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
        'LAMP_CONFIGS'
       ,'MBTL'
       ,'Mercury Tungsten Halogen'
       ,'Y'
       ,157
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'MBTL');
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
        'LAMP_CONFIGS'
       ,'MCF'
       ,'Low High pressure Mercury, tubular fluorescent'
       ,'Y'
       ,158
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'MCF');
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
        'LAMP_CONFIGS'
       ,'SLI'
       ,'Low presure Sodium, linear'
       ,'Y'
       ,159
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'SLI');
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
        'LAMP_CONFIGS'
       ,'SON'
       ,'High pressure Sodium, ellipical envelope'
       ,'Y'
       ,160
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'SON');
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
        'LAMP_CONFIGS'
       ,'SOX'
       ,'Low pressure Sodium, U-bend on standard control gear'
       ,'Y'
       ,161
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'SOX');
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
        'LAMP_CONFIGS'
       ,'SOXE'
       ,'Low pressure Sodium, U-bend new_type low-loss gear'
       ,'Y'
       ,162
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'SOXE');
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
        'LAMP_CONFIGS'
       ,'SOXL'
       ,'Low pressure Sodium, U-bend low-loss control gear'
       ,'Y'
       ,163
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'SOXL');
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
        'LAMP_CONFIGS'
       ,'TF'
       ,'Tungsten'
       ,'Y'
       ,164
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'TF');
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
        'LAMP_CONFIGS'
       ,'TH'
       ,'Tungsten Halogen'
       ,'Y'
       ,165
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'LAMP_CONFIGS'
                    AND  HCO_CODE = 'TH');
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
        'MAINT_INSP_FLAG'
       ,'D'
       ,'Detailed'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'MAINT_INSP_FLAG'
                    AND  HCO_CODE = 'D');
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
        'MAINT_INSP_FLAG'
       ,'S'
       ,'Safety'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'MAINT_INSP_FLAG'
                    AND  HCO_CODE = 'S');
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
        'ORG_UNIT_TYPE'
       ,'A'
       ,'Admin Unit'
       ,'Y'
       ,184
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ORG_UNIT_TYPE'
                    AND  HCO_CODE = 'A');
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
        'ORG_UNIT_TYPE'
       ,'CO'
       ,'Contractor'
       ,'Y'
       ,186
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ORG_UNIT_TYPE'
                    AND  HCO_CODE = 'CO');
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
        'ORG_UNIT_TYPE'
       ,'EB'
       ,'Electricity Board'
       ,'Y'
       ,187
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ORG_UNIT_TYPE'
                    AND  HCO_CODE = 'EB');
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
        'ORG_UNIT_TYPE'
       ,'NO'
       ,'Notifiable Org'
       ,'Y'
       ,188
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ORG_UNIT_TYPE'
                    AND  HCO_CODE = 'NO');
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
        'ORG_UNIT_TYPE'
       ,'PA'
       ,'Parish'
       ,'Y'
       ,189
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ORG_UNIT_TYPE'
                    AND  HCO_CODE = 'PA');
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
        'ORG_UNIT_TYPE'
       ,'RE'
       ,'Rechargeable Org'
       ,'Y'
       ,190
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ORG_UNIT_TYPE'
                    AND  HCO_CODE = 'RE');
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
        'PARAMETER_TYPE'
       ,'CHAR'
       ,'Character'
       ,'Y'
       ,192
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PARAMETER_TYPE'
                    AND  HCO_CODE = 'CHAR');
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
        'PARAMETER_TYPE'
       ,'DATE'
       ,'Date'
       ,'Y'
       ,193
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PARAMETER_TYPE'
                    AND  HCO_CODE = 'DATE');
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
        'PARAMETER_TYPE'
       ,'NUMB'
       ,'Number'
       ,'Y'
       ,194
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PARAMETER_TYPE'
                    AND  HCO_CODE = 'NUMB');
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
        'PBI_CONDITION'
       ,'<'
       ,'Less than'
       ,'Y'
       ,195
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = '<');
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
        'PBI_CONDITION'
       ,'<='
       ,'<='
       ,'Y'
       ,196
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = '<=');
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
        'PBI_CONDITION'
       ,'='
       ,'Equal to'
       ,'Y'
       ,197
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = '=');
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
        'PBI_CONDITION'
       ,'>'
       ,'Greater than'
       ,'Y'
       ,198
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = '>');
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
        'PBI_CONDITION'
       ,'>='
       ,'>='
       ,'Y'
       ,199
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = '>=');
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
        'PBI_CONDITION'
       ,'BETWEEN'
       ,'between'
       ,'Y'
       ,200
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = 'BETWEEN');
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
        'PBI_CONDITION'
       ,'IN'
       ,'In'
       ,'Y'
       ,201
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = 'IN');
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
        'PBI_CONDITION'
       ,'IS NOT NULL'
       ,'is not null'
       ,'Y'
       ,202
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = 'IS NOT NULL');
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
        'PBI_CONDITION'
       ,'IS NULL'
       ,'is null'
       ,'Y'
       ,203
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = 'IS NULL');
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
        'PBI_CONDITION'
       ,'LIKE'
       ,'Like'
       ,'Y'
       ,204
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = 'LIKE');
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
        'PBI_CONDITION'
       ,'NOT IN'
       ,'Not in'
       ,'Y'
       ,205
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = 'NOT IN');
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
        'PBI_CONDITION'
       ,'NOT LIKE'
       ,'Not like'
       ,'Y'
       ,206
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PBI_CONDITION'
                    AND  HCO_CODE = 'NOT LIKE');
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
        'PROGRAMME_TYPE'
       ,'C'
       ,'Current Scheme'
       ,'Y'
       ,223
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PROGRAMME_TYPE'
                    AND  HCO_CODE = 'C');
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
        'PROGRAMME_TYPE'
       ,'H'
       ,'Historic Scheme'
       ,'Y'
       ,224
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PROGRAMME_TYPE'
                    AND  HCO_CODE = 'H');
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
        'PROGRAMME_TYPE'
       ,'R'
       ,'Rolling Scheme'
       ,'Y'
       ,225
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'PROGRAMME_TYPE'
                    AND  HCO_CODE = 'R');
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
        'QUALITY_CODE'
       ,'G'
       ,'Good'
       ,'Y'
       ,226
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'QUALITY_CODE'
                    AND  HCO_CODE = 'G');
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
        'QUALITY_CODE'
       ,'M'
       ,'Medium'
       ,'Y'
       ,227
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'QUALITY_CODE'
                    AND  HCO_CODE = 'M');
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
        'QUALITY_CODE'
       ,'P'
       ,'Poor'
       ,'Y'
       ,228
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'QUALITY_CODE'
                    AND  HCO_CODE = 'P');
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
        'QUALITY_CODE'
       ,'VB'
       ,'Very Bad'
       ,'Y'
       ,229
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'QUALITY_CODE'
                    AND  HCO_CODE = 'VB');
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
        'QUALITY_CODE'
       ,'VG'
       ,'Very Good'
       ,'Y'
       ,230
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'QUALITY_CODE'
                    AND  HCO_CODE = 'VG');
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
        'REPAIR_TYPE'
       ,'I'
       ,'Immediate'
       ,'Y'
       ,231
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'REPAIR_TYPE'
                    AND  HCO_CODE = 'I');
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
        'REPAIR_TYPE'
       ,'P'
       ,'Permanent'
       ,'Y'
       ,232
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'REPAIR_TYPE'
                    AND  HCO_CODE = 'P');
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
        'REPAIR_TYPE'
       ,'T'
       ,'Temporary'
       ,'Y'
       ,233
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'REPAIR_TYPE'
                    AND  HCO_CODE = 'T');
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
        'REQUIRED_TYPES'
       ,'A'
       ,'Area'
       ,'Y'
       ,234
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'REQUIRED_TYPES'
                    AND  HCO_CODE = 'A');
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
        'REQUIRED_TYPES'
       ,'L'
       ,'Length'
       ,'Y'
       ,235
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'REQUIRED_TYPES'
                    AND  HCO_CODE = 'L');
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
        'REQUIRED_TYPES'
       ,'N'
       ,'Number'
       ,'Y'
       ,236
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'REQUIRED_TYPES'
                    AND  HCO_CODE = 'N');
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
        'RESPONSE_TYPES'
       ,'A'
       ,'Accepted'
       ,'Y'
       ,237
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'RESPONSE_TYPES'
                    AND  HCO_CODE = 'A');
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
        'RESPONSE_TYPES'
       ,'N'
       ,'Not Accepted'
       ,'Y'
       ,238
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'RESPONSE_TYPES'
                    AND  HCO_CODE = 'N');
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
        'ROAD_CHARACTERISTIC'
       ,'I'
       ,'Inventory Data'
       ,'Y'
       ,245
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ROAD_CHARACTERISTIC'
                    AND  HCO_CODE = 'I');
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
        'ROAD_CHARACTERISTIC'
       ,'M'
       ,'Machine Data'
       ,'Y'
       ,246
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ROAD_CHARACTERISTIC'
                    AND  HCO_CODE = 'M');
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
        'ROAD_CHARACTERISTIC'
       ,'R'
       ,'Road Condition Data'
       ,'Y'
       ,247
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ROAD_CHARACTERISTIC'
                    AND  HCO_CODE = 'R');
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
        'ROAD_CHARACTERISTIC'
       ,'T'
       ,'Traffic Data'
       ,'Y'
       ,248
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ROAD_CHARACTERISTIC'
                    AND  HCO_CODE = 'T');
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
        'SCHEME_TYPES'
       ,'LR'
       ,'Local Road Bids'
       ,'Y'
       ,276
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SCHEME_TYPES'
                    AND  HCO_CODE = 'LR');
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
        'SCHEME_TYPES'
       ,'RD'
       ,'Road Bids'
       ,'Y'
       ,277
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SCHEME_TYPES'
                    AND  HCO_CODE = 'RD');
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
        'SCHEME_TYPES'
       ,'RN'
       ,'Renewal Bids'
       ,'Y'
       ,278
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SCHEME_TYPES'
                    AND  HCO_CODE = 'RN');
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
        'SCHEME_TYPES'
       ,'SC'
       ,'Summary Bids - Cat2'
       ,'Y'
       ,279
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SCHEME_TYPES'
                    AND  HCO_CODE = 'SC');
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
        'SCHEME_TYPES'
       ,'SN'
       ,'Summary Bids - Non Cat2'
       ,'Y'
       ,280
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SCHEME_TYPES'
                    AND  HCO_CODE = 'SN');
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
        'SUMMATION_TYPES'
       ,'Q'
       ,'Quarterly'
       ,'Y'
       ,286
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SUMMATION_TYPES'
                    AND  HCO_CODE = 'Q');
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
        'SUMMATION_TYPES'
       ,'QT'
       ,'Quarterly Trend'
       ,'Y'
       ,287
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SUMMATION_TYPES'
                    AND  HCO_CODE = 'QT');
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
        'SUMMATION_TYPES'
       ,'TD'
       ,'To Date'
       ,'Y'
       ,288
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SUMMATION_TYPES'
                    AND  HCO_CODE = 'TD');
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
        'SUMMATION_TYPES'
       ,'Y'
       ,'Yearly'
       ,'Y'
       ,289
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'SUMMATION_TYPES'
                    AND  HCO_CODE = 'Y');
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
        'USER_OPTIONS'
       ,'PEDFILE'
       ,'Mai3863 Edif Filename'
       ,'N'
       ,36
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'USER_OPTIONS'
                    AND  HCO_CODE = 'PEDFILE');
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
        'WOR_FLAG'
       ,'D'
       ,'Defect Clearance'
       ,'Y'
       ,309
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_FLAG'
                    AND  HCO_CODE = 'D');
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
        'WOR_FLAG'
       ,'M'
       ,'Cyclic Maintenance'
       ,'Y'
       ,310
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_FLAG'
                    AND  HCO_CODE = 'M');
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
        'WOR_FLAG'
       ,'S'
       ,'Small Schemes'
       ,'Y'
       ,311
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_FLAG'
                    AND  HCO_CODE = 'S');
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
        'WOR_PRIORITY'
       ,'1'
       ,'High Priority'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_PRIORITY'
                    AND  HCO_CODE = '1');
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
        'WOR_PRIORITY'
       ,'2'
       ,'Medium Priority'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_PRIORITY'
                    AND  HCO_CODE = '2');
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
        'WOR_PRIORITY'
       ,'3'
       ,'Low Priority'
       ,'Y'
       ,3
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_PRIORITY'
                    AND  HCO_CODE = '3');
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
        'WOR_REGISTER_STATUS'
       ,'C'
       ,'Completed'
       ,'Y'
       ,2
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_REGISTER_STATUS'
                    AND  HCO_CODE = 'C');
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
        'WOR_REGISTER_STATUS'
       ,'N'
       ,'Nothing to register'
       ,'Y'
       ,3
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_REGISTER_STATUS'
                    AND  HCO_CODE = 'N');
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
        'WOR_REGISTER_STATUS'
       ,'O'
       ,'Outstanding'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'WOR_REGISTER_STATUS'
                    AND  HCO_CODE = 'O');
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
        'XSP_TYPE'
       ,'B'
       ,'Both CWay and FWay'
       ,'Y'
       ,312
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'XSP_TYPE'
                    AND  HCO_CODE = 'B');
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
        'XSP_TYPE'
       ,'C'
       ,'Carriageway'
       ,'Y'
       ,313
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'XSP_TYPE'
                    AND  HCO_CODE = 'C');
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
        'XSP_TYPE'
       ,'F'
       ,'Footway'
       ,'Y'
       ,314
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'XSP_TYPE'
                    AND  HCO_CODE = 'F');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_MODULES
--
-- select * from mai_metadata.hig_modules
-- order by hmo_module
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_modules
SET TERM OFF

INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI0132'
       ,'Work Order Priorities'
       ,'mai0132'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI0132');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1200'
       ,'Activities'
       ,'mai1200'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1200');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1205'
       ,'Activity Groups'
       ,'mai1205'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1205');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1210'
       ,'Local Activity Frequencies'
       ,'mai1210'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1210');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1230'
       ,'Default Section Intervals Calculation'
       ,'mai1230'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1230');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1240'
       ,'Default Section Intervals'
       ,'mai1240'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1240');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1280'
       ,'External Activities'
       ,'mai1280'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1280');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1300'
       ,'Defect Control Data'
       ,'mai1300'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1300');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1315'
       ,'Treatment Data'
       ,'mai1315'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1315');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1320'
       ,'Enquiry/Treatment Types'
       ,'mai1320'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1320');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1325'
       ,'Enquiry/Defect Priorities'
       ,'mai1325'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1325');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1400'
       ,'v2 Asset Type Translations'
       ,'mai1400'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1400');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1430'
       ,'Lamp Configurations'
       ,'mai1430'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1430');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1808'
       ,'List of Organisations'
       ,'mai1808'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1808');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1830'
       ,'People'
       ,'mai1830'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1830');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1840'
       ,'List of People'
       ,'mai1840'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1840');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1870'
       ,'Organisations'
       ,'mai1870'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1870');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1930'
       ,'IHMS Allocated Amounts'
       ,'mai1930'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1930');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI1940'
       ,'Item Code Breakdowns'
       ,'mai1940'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI1940');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2100'
       ,'Load Inventory Data into Database - (Stage 1)'
       ,'mai2100'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2100');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2100C'
       ,'Inventory Loader (Part 1)'
       ,'mai2100c'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2100C');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2100F'
       ,'Stage 1 Inventory Load (Validation only)'
       ,'mai2100f'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2100F');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2105C'
       ,'Reformat Road Group Inventory Data'
       ,'mai2105c'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2105C');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2110'
       ,'Load Inventory Data into Main Database - (Stage 2)'
       ,'mai2110'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2110');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2110C'
       ,'Inventory Loader (Part 2)'
       ,'mai2110c'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2110C');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2115'
       ,'Print Potential Inventory Duplicates'
       ,'mai2115'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2115');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2120'
       ,'Correct Inventory Load Errors'
       ,'mai2120'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2120');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2140'
       ,'Query Network/Inventory Data'
       ,'mai2140'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2140');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2200A'
       ,'Load Bulk Inspection Data - Phase 1'
       ,'mai2200a'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2200A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2200B'
       ,'Load Bulk Inspection Data - Phase 2'
       ,'mai2200b'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2200B');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2200C'
       ,'Inspection Loader (Part 1)'
       ,'mai2200c'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2200C');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2200D'
       ,'Inspection Loader (Part 2)'
       ,'mai2200d'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2200D');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2200E'
       ,'Load Bulk Inspection Data - Phase 1 + 2'
       ,'mai2200e'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2200E');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2200R'
       ,'Bulk Inspection Load - Stage 2 Report'
       ,'mai2200r'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2200R');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2210'
       ,'Print Defective Advisory Roadstuds Report'
       ,'mai2210'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2210');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2220'
       ,'Download Static Ref Data for DCD Inspections'
       ,'mai2220'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2220');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2222'
       ,'Download Standard Item Data for DCD Inspections'
       ,'mai2222'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2222');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2224'
       ,'Download Network Data for DCD Inspections'
       ,'mai2224'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2224');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2250'
       ,'Correct Inspection Load Errors'
       ,'mai2250'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2250');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2305'
       ,'Query Assets'
       ,'mai2305'
       ,'FMX'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2305');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2306'
       ,'Hierarchy Navigator'
       ,'mai2306'
       ,'FMX'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2306');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2310A'
       ,'View Condition Data'
       ,'nm0590'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2310A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2315'
       ,'Print Inventory Items (matrix format)'
       ,'mai2315'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2315');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2320'
       ,'Print Inventory Map'
       ,'mai2320'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2320');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2325'
       ,'Print Inventory Summary'
       ,'mai2325'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2325');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2325A'
       ,'Print Inventory Summary'
       ,'mai2325a'
       ,'R25'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2325A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2330'
       ,'Print Summary of Inventory Changes'
       ,'mai2330'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2330');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2340'
       ,'Asset Strip Map'
       ,'mai2340'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2340');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2470'
       ,'Delete Inspections'
       ,'mai2470'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2470');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2500'
       ,'Download Data for Inventory Survey on DCD'
       ,'mai2500'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2500');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2500A'
       ,'Download Data for Inventory Survey on DCD'
       ,'mai2500a'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2500A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2501'
       ,'Inventory Interface'
       ,'mai2501'
       ,'SVR'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2501');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2510'
       ,'Audit file extract'
       ,'MAI2510'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2510');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2520'
       ,'Routine Inspection Rules File Import'
       ,'MAI2520'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2520');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2521'
       ,'RIRF - Comparison report'
       ,'MAI2521'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2521');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2530'
       ,'Inspection Routes'
       ,'mai2530'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2530');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2550'
       ,'Review GMIS Inspection Loads'
       ,'mai2550'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2550');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2600'
       ,'Audit Analysis Interface'
       ,'mai2600'
       ,'SVR'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2600');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2730'
       ,'Match Duplicate Defects'
       ,'mai2730'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2730');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2760'
       ,'Unmatch Duplicate Defects'
       ,'mai2760'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2760');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2775'
       ,'Batch Setting of Repair Dates'
       ,'mai2775'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2775');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2780'
       ,'Print Item Code Breakdowns'
       ,'mai2780'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2780');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI2790'
       ,'Insurance Claims Reporting'
       ,'mai2790'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI2790');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI30060'
       ,'Print Historical Inventory Data'
       ,'mai30060'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI30060');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3100'
       ,'Print Inspection Schedules'
       ,'mai3100'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3100');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3105'
       ,'Print: Cyclic Maintenance Activities'
       ,'mai3105'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3105');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3150'
       ,'Default Treatments'
       ,'mai3150'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3150');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3250'
       ,'Print Defect Movements'
       ,'mai3250'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3250');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3440'
       ,'Valid For Maintenance Rules'
       ,'mai3440'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3440');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3470'
       ,'Print Defect Details ( Work Orders )'
       ,'mai3470'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3470');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3480'
       ,'Print Works Order (Priced)'
       ,'mai3480'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3480');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3485'
       ,'Print Works Order (Unpriced)'
       ,'mai3485'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3485');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3490'
       ,'Review Raised Works Orders'
       ,'mai3490'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3490');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3500'
       ,'Print Works Orders Detail'
       ,'mai3500'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3500');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3505'
       ,'Print Works Orders (Summary)'
       ,'mai3505'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3505');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3515'
       ,'Print Work Orders ( Metro )'
       ,'mai3515'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3515');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3516'
       ,'Work Order Scheduling Report'
       ,'mai3516.rdf'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3516');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3517'
       ,'Cyclic Work Order Print (Metro)'
       ,'mai3517.rdf'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3517');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3518'
       ,'Road Network Report ( DRD )'
       ,'mai3518'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3518');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3610'
       ,'Cancel Work Orders'
       ,'mai3610'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3610');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3624'
       ,'Discount Groups'
       ,'mai3624'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3624');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3626'
       ,'Cyclic Maintenance Inventory Rules'
       ,'mai3626'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3626');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3628'
       ,'Related Maintenance Activities'
       ,'mai3628'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3628');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3630'
       ,'Budget Allocations'
       ,'mai3630'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3630');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3632'
       ,'Asset Activities'
       ,'mai3632'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3632');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3660'
       ,'Budgets'
       ,'mai3660'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3660');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3662'
       ,'Generate Budgets for Next Year'
       ,'mai3662'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3662');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3666'
       ,'Job Size Codes'
       ,'mai3666'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3666');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3690'
       ,'Print Budget Exceptions Report'
       ,'mai3690'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3690');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3691'
       ,'SQL Print Budget Exceptions Report'
       ,'mai3691'
       ,'SQL'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3691');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3692'
       ,'Print Cost Code Exceptions Report'
       ,'mai3692'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3692');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3693'
       ,'SQL Print Cost Code Exceptions Report'
       ,'mai3693'
       ,'SQL'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3693');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3800'
       ,'Work Orders (Defects)'
       ,'mai3800'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3800');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3800A'
       ,'Work Orders (Cyclic)'
       ,'mai3800'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3800A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3801'
       ,'Raise Work Order'
       ,'mai3801'
       ,'FMX'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3801');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3802'
       ,'Maintain Work Orders - Contractor Interface'
       ,'mai3802'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3802');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3803'
       ,'Work Order Auditing Maintenance'
       ,'mai3803'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3803');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3804'
       ,'View Cyclic Maintenance Work'
       ,'mai3804'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3804');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3805'
       ,'Gang Allocation'
       ,'mai3805'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3805');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3806'
       ,'Defects'
       ,'mai3806'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3806');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3807'
       ,'Locator Create Defects'
       ,'mai3807'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3807');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3807_NET'
       ,'Locator Create Defect On Network'
       ,'mai3807'
       ,'FMX'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3807_NET');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3808'
       ,'Inspections'
       ,'mai3808'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3808');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3810'
       ,'View Defects'
       ,'mai3810'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3810');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3812'
       ,'Defect Priorities'
       ,'mai3812'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3812');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3813'
       ,'Maintain Automatic Defect Prioritisation'
       ,'mai3813'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3813');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3814'
       ,'Treatment Models'
       ,'mai3814'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3814');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3816'
       ,'Responses to Notices'
       ,'mai3816'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3816');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3820'
       ,'Quality Inspection Results'
       ,'mai3820'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3820');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3825'
       ,'Maintenance Report'
       ,'mai3825'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3825');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3830'
       ,'Works Order File Extract'
       ,'mai3830'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3830');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3834'
       ,'Financial Commitment File'
       ,'mai3834'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3834');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3840'
       ,'Payment Run'
       ,'mai3840'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3840');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3840A'
       ,'Payment Run Report A'
       ,'mai3840a'
       ,'R25'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3840A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3840B'
       ,'Payment Run Report B'
       ,'mai3840b'
       ,'R25'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3840B');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3840C'
       ,'Payment Run Report C'
       ,'mai3840c'
       ,'R25'
       ,''
       ,'Y'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3840C');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3841'
       ,'Payment Run Report'
       ,'MAI3941'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3841');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3842'
       ,'Deselect Items for Payment'
       ,'mai3842'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3842');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3844'
       ,'Cost Centre Codes'
       ,'mai3844'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3844');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3846'
       ,'VAT Rates'
       ,'mai3846'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3846');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3848'
       ,'Work Orders Authorisation'
       ,'mai3848'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3848');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3850'
       ,'Completions file'
       ,'mai3850'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3850');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3852'
       ,'Invoice file'
       ,'mai3852'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3852');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3854'
       ,'Invoice Verification form'
       ,'mai3854'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3854');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3856'
       ,'Payment Approval form'
       ,'mai3856'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3856');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3858'
       ,'Payment Transaction file'
       ,'mai3858'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3858');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3859'
       ,'Blackburn Output File Formats'
       ,'mai3859'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3859');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3860'
       ,'Cyclic Maintenance Schedules'
       ,'mai3860'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3860');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3862'
       ,'Cyclic Maintenance Schedules by Road Section'
       ,'mai3862'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3862');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3863'
       ,'Download Inspection by Assets'
       ,'mai3863'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3863');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3865'
       ,'Inventory Audit Report'
       ,'mai3865'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3865');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3880'
       ,'Contracts'
       ,'mai3880'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3880');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3881'
       ,'Contractors'
       ,'mai3881'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3881');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3882'
       ,'Copy a Contract'
       ,'mai3882'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3882');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3884'
       ,'Bulk Update of Contract Items'
       ,'mai3884'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3884');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3886'
       ,'Standard Item Sections and Sub-Sections'
       ,'mai3886'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3886');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3888'
       ,'Standard Items'
       ,'mai3888'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3888');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3890'
       ,'Purge Historical Data'
       ,'mai3890'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3890');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3899'
       ,'Inspections by Group'
       ,'mai3899'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3899');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3900'
       ,'Print Inspection Report'
       ,'mai3900'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3900');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3902'
       ,'Print Defect Details'
       ,'mai3902'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3902');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3904'
       ,'Print Defect Notices'
       ,'mai3904'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3904');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3905'
       ,'Print Roadstud Defects not Set to Mandatory or Advisory'
       ,'mai3905'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3905');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3906'
       ,'Print BOQ Work Order (Defects)'
       ,'mai3906'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3906');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3907'
       ,'Print BOQ Work Order (Cyclic)'
       ,'mai3907'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3907');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3908'
       ,'Print Works Order'
       ,'mai3908'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3908');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3909'
       ,'Print Works Order (NMA)'
       ,'mai3909'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3909');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3910'
       ,'List of Defects by Inspection Date'
       ,'mai3910'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3910');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3911'
       ,'Print Works Order (BRG)'
       ,'mai3911'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3911');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3912'
       ,'List of Notifiable Defects'
       ,'mai3912'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3912');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3916'
       ,'Summary of Notifiable/Rechargeable Defects'
       ,'mai3916'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3916');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3919'
       ,'Print Works Order (Enhanced)'
       ,'mai3919'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3919');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3920'
       ,'Summary of Defects Not Yet Instructed'
       ,'mai3920'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3920');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3922'
       ,'List of Defects Not Yet Instructed'
       ,'mai3922'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3922');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3924'
       ,'List of Instructed Work by Status'
       ,'mai3924'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3924');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3926'
       ,'List of Instructed Defects due for Completion'
       ,'mai3926'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3926');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3930'
       ,'List of Inventory Updates'
       ,'mai3930'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3930');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3932'
       ,'Summary of Work Instructed by Standard Item'
       ,'mai3932'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3932');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3934'
       ,'Summary of Work Volumes by Standard Item'
       ,'mai3934'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3934');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3940'
       ,'Query Payment Run Details'
       ,'mai3940'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3940');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3942'
       ,'List of Items for Payment'
       ,'mai3942'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3942');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3943'
       ,'Billable Works Orders'
       ,'mai3943'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3943');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3944'
       ,'List of Completed Rechargeable Defects'
       ,'mai3944'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3944');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3946'
       ,'List of VAT Rates'
       ,'mai3946'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3946');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3948'
       ,'Summary of Expenditure by Contract'
       ,'mai3948'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3948');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3950'
       ,'List of Work for Quality Inspection'
       ,'mai3950'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3950');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3952'
       ,'Quality Inspection Performance Report'
       ,'mai3952'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3952');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3954'
       ,'Contractor Performance Report'
       ,'mai3954'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3954');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3956'
       ,'Admin Unit Performance Report'
       ,'mai3956'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3956');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3960'
       ,'Print Cyclic Maintenance Schedules'
       ,'mai3960'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3960');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3970'
       ,'Print Gang Work Orders'
       ,'mai3970'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3970');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3980'
       ,'Contract Details Report'
       ,'mai3980'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3980');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3981'
       ,'List of Contractors'
       ,'mai3981'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3981');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3982'
       ,'List of Contract Liabilities'
       ,'mai3982'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3982');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3984'
       ,'List of Contract Rates'
       ,'mai3984'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3984');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3986'
       ,'List of Standard Item Sections and Sub-Sections'
       ,'mai3986'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3986');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3988'
       ,'List of Standard Items'
       ,'mai3988'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3988');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3992'
       ,'Road Section Historical Report'
       ,'mai3992'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3992');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI3994'
       ,'Road Section Historical Statistics'
       ,'mai3994'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI3994');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5001'
       ,'Inventory Item Details'
       ,'mai5001'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5001');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5010'
       ,'Print Road Markings - Hatched Type Area'
       ,'mai5010'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5010');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5011'
       ,'Print Road Markings - Longitudinal'
       ,'mai5011'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5011');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5015'
       ,'Print Road Markings - Transverse and Special'
       ,'mai5015'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5015');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5018'
       ,'Print Sign Areas'
       ,'mai5018'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5018');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5021'
       ,'Print Inventory Areas - Trapezium Rule'
       ,'mai5021'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5021');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5022'
       ,'Print Inspectors Pocket Book'
       ,'mai3900'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5022');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5024'
       ,'Print Local Frequencies and Intervals'
       ,'mai5024'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5024');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5025'
       ,'Print Detailed Inspection Work Done'
       ,'mai5025'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5025');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5027'
       ,'Print Defects by Defect Type'
       ,'mai5027'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5027');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5030'
       ,'Print Default Intervals and Frequencies'
       ,'mai5030'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5030');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5031'
       ,'Print Electrical Inventory'
       ,'mai5031'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5031');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5032'
       ,'Print Cyclic Maintenance Done'
       ,'mai5032'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5032');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5034A'
       ,'Print A Audit - Defects by Type, Activity and Time'
       ,'mai5034a'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5034A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5034B'
       ,'Print B Audit - Defects by Activity,Type and Time'
       ,'mai5034b'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5034B');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5035A'
       ,'Print C Audit - Actions by Activity Area'
       ,'mai5035a'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5035A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5035B'
       ,'Print D Audit - Actions by Defect Type'
       ,'mai5035b'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5035B');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5037'
       ,'Print E Audit - Electrical Report by Ownership'
       ,'mai5037'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5037');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5037A'
       ,'Print E Audit - Electrical Report by Link'
       ,'mai5037a'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5037A');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5038'
       ,'Print T Audit - Audit Of Costs'
       ,'mai5038'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5038');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5050'
       ,'Print List of Inventory Item Types, Attributes and Values'
       ,'mai5050'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5050');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5050D'
       ,'Inventory Item Types, Attribute Values, Names Of Item Values'
       ,'mai5050'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5050D');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5060'
       ,'Print F Audit - Defect for Point and Cont. Inv Items'
       ,'mai5060'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5060');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5065'
       ,'Print Batch with Downloaded Inventory Items'
       ,'mai5065'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5065');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5070'
       ,'Print M Audit - Analysis of Cyclic Maintenance Activities'
       ,'mai5070'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5070');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5075'
       ,'Print Inventory Item Report'
       ,'mai5075'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5075');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5080'
       ,'Print I Audit - 7 and 28 day Safety Inspection Statistics'
       ,'mai5080'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5080');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5090'
       ,'Remove Successfully Loaded Inventory Batches'
       ,'mai5090'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5090');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5091'
       ,'Remove Phase 1 Inspection Batches'
       ,'mai5091'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5091');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5100'
       ,'Print Defect Details (At-a-Glance)'
       ,'mai5100'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5100');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5125'
       ,'Print Defect Details (Strip Plan)'
       ,'mai5125'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5125');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5130'
       ,'Print Works Orders (Strip Plan)'
       ,'mai5130'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5130');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5200'
       ,'Print Lamp Configurations'
       ,'mai5200'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5200');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5205'
       ,'Print Activity Frequencies'
       ,'mai5205'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5205');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5210'
       ,'Print Electricity Boards'
       ,'mai5210'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5210');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5215'
       ,'Print Interval Codes'
       ,'mai5215'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5215');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5220'
       ,'Print Valid Defect Types'
       ,'mai5220'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5220');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5225'
       ,'Print Activities'
       ,'mai5225'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5225');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5235'
       ,'Print Defect Item Types'
       ,'mai5235'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5235');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI5240'
       ,'Print Treatment Codes'
       ,'mai5240'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI5240');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI6100'
       ,'Print Inventory Statistics'
       ,'mai6100'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI6100');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI6110'
       ,'Print Inventory Lengths'
       ,'mai6110'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI6110');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI6120'
       ,'Bus Stop Report'
       ,'mai6120'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI6120');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI7040'
       ,'Parameter Based Inquiry (PBI)'
       ,'mai7040'
       ,'FMX'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI7040');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI7080'
       ,'Chainage (Summary)'
       ,'mai7080'
       ,'R25'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI7080');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI7082'
       ,'Count (Summary)'
       ,'mai7082'
       ,'R25'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI7082');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI7086'
       ,'Count (Detail)'
       ,'mai7086'
       ,'R25'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI7086');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI7088'
       ,'Parameters used in PBI'
       ,'mai7088'
       ,'R25'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI7088');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI8000'
       ,'Batch Works Order Printing'
       ,'mai8000'
       ,'FMX'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI8000');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI9010'
       ,'Detect Inventory Gap/Overlap'
       ,'mai9010'
       ,'SQL'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI9010');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAI9020'
       ,'Print Inventory Gap/Overlap'
       ,'mai9020'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI9020');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAICRVW'
       ,'Inventory Views'
       ,'maicrvw'
       ,'R25'
       ,''
       ,'N'
       ,'Y'
       ,'MAI'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAICRVW');
--
INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT 
        'MAIWEB2540'
       ,'GMIS Survey File Loader'
       ,'mai_gmis_load.load_survey_file'
       ,'WEB'
       ,''
       ,'N'
       ,'N'
       ,'MAI'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAIWEB2540');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_OPTION_LIST
--
-- select * from mai_metadata.hig_option_list
-- order by hol_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_option_list
SET TERM OFF

INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ACTTOSCHEM'
       ,'PMS'
       ,'Activities relate to Schemes'
       ,'Activities relate directly to Schemes and not via Scheme_Roads.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ACTTOSCHEM');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ADDINSTR'
       ,'MAI'
       ,'Add WOLs to Instructed WO'
       ,'If set to Y then new work order lines can be added to an instructed work order, otherwise this is not allowed.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ADDINSTR');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ADDPRINT'
       ,'MAI'
       ,'Add BOQ items to printed WO'
       ,'If this option is set to Y then a user can add BOQ items to a Works Order Line after the Works Order has been printed.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ADDPRINT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ADMINLEVEL'
       ,'PMS'
       ,'Admin Level for Scheme Create'
       ,'This defines the admin level at which schemes can be created'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ADMINLEVEL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ASSETBASED'
       ,'MAI'
       ,'Asset Based Option'
       ,'Set this flag to Y to allow linking to assets'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ASSETBASED');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'AUDIT_ALL'
       ,'MAI'
       ,'Audit all WO changes'
       ,'This option is used to restrict the size of the audit log trail.'||CHR(10)||'If the option is set to Y then every change a user makes to a work order will be audited.'||CHR(10)||'If set to N then intermediate user changes will not be logged.'||CHR(10)||'In this case the audit log will show the beginning and end values for a session but no other changes.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'AUDIT_ALL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'AUTH_OWN'
       ,'MAI'
       ,'Can user authorise a raised WO'
       ,'If this option is set to Y then it is possible for a user who raised a works order to authorise (instruct) the works order.'||CHR(10)||'Otherwise another user will have to authorise a raised WO.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'AUTH_OWN');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'BUDAUDT'
       ,'MAI'
       ,'Budget Audit trail'
       ,'This value must be set to Y to write an audit trail to the temp table'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'BUDAUDT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'BUDGRPTYPD'
       ,'MAI'
       ,'Group Type For Dot Budgets'
       ,'This must be a valid Road Group Type.'||CHR(10)||'It defines how budgets are maintained for trunk roads.'||CHR(10)||'In Maintain Budgets (MAI3660) you may only create trunk road budgets against groups of this type.'||CHR(10)||'In Print Budget Exceptions (MAI3690) you may only select groups of this type for trunk road report parameters.'||CHR(10)||'English authorities must always use RP (for Road Parts).'||CHR(10)||'This option must not be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'BUDGRPTYPD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'BUDGRPTYPL'
       ,'MAI'
       ,'Group Type For Local Budgets'
       ,'This must be a valid Road Group Type.'||CHR(10)||'It defines how budgets are maintained for local roads.'||CHR(10)||'In Maintain Budgets (MAI3660) you may only create local road budgets against groups of this type.'||CHR(10)||'In Print Budget Exceptions (MAI3690) you may only select groups of this type for local road report parameters.'||CHR(10)||'This option must not be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'BUDGRPTYPL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'BUD_SELECT'
       ,'MAI'
       ,'Budget Selection Process'
       ,'The number of stages involved in selecting a budget for a work order line. Valid values are 1 or 2. Sites with large amounts of data should use the 2 stage selection process. This value can be modified at any time.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'BUD_SELECT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CLAIMDEF'
       ,'MAI'
       ,'Default status for new claims'
       ,'Default new claim records to this status (currently A - Approved or H - Held)'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CLAIMDEF');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CLAIMREJT'
       ,'MAI'
       ,'Allow claim rejection'
       ,'Determines whether or not users can reject claims in the claim verification form (Y or N)'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CLAIMREJT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'COMPLEDATE'
       ,'MAI'
       ,'Completion Date'
       ,'When the flag is set to ''Y'' the Completion date can be equal to or before the Instructed date. If the flag is set to ''N'' the Completion date can be equal to or after the Instructed date.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'COMPLEDATE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'COMPWOLEL'
       ,'MAI'
       ,'Complete WOL when interface on'
       ,'This option is dependant on the setting of the electronic orders flag for a contractor. If the option is set to N and the contractor uses electronic orders then the user will not be able to update the order line status from Instructed to Completed'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'COMPWOLEL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CONINTRM'
       ,'MAI'
       ,'Allow Interim at Valuation'
       ,'If this option is set to Y then a user can set the WOL ststus to INTERIM from VALUATION.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CONINTRM');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CONSECMODE'
       ,'MAI'
       ,'Contractor Security Mode'
       ,'Set to "U"ser or "A"dmin Unit, to enable Contract Security.'
       ,'CONTRACT_SECURITY'
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CONSECMODE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CPAFORMAT'
       ,'MAI'
       ,'Format of Works Order Number'
       ,'Set to 0 to show standard format, 1 to show Causeway format.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CPAFORMAT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CPAINTERIM'
       ,'MAI'
       ,'CPA Interims'
       ,'CPA Interims (1= Switched on)'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CPAINTERIM');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CSVSEPVAL'
       ,'MAI'
       ,'CSV File Separator'
       ,'This character is used by the data loaders as the separator between fields.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CSVSEPVAL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CUM_PERC'
       ,'MAI'
       ,'Computation of Percentage item'
       ,'This option should be set to either NORMAL'||CHR(10)||' or CUMULATIVE any other value will be ignored.'||CHR(10)||'This determines the computation method for a percentage item.'||CHR(10)||'When set to NORMAL a percentage item will display the percentage of the standard item.'||CHR(10)||'A setting of CUMULATIVE will result in the percentage item being the sum of the'||CHR(10)||'percentage of the standard item and other precentage items related to the standard item.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CUM_PERC');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CYCGRPTYPD'
       ,'MAI'
       ,'Group Type For Dot Schedules'
       ,'This must contain a list of valid Road Group Types, in the format: LINK,RP'||CHR(10)||'It defines how cyclic maintenance schedules are maintained for trunk roads.'||CHR(10)||'In Maintain Schedules (MAI3860) you may only create trunk road schedules against groups of these types.'||CHR(10)||'This option may be amended on a live system, however you should immediately update the road group on current schedules, for consistency.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CYCGRPTYPD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'CYCGRPTYPL'
       ,'MAI'
       ,'Group Type For Local Schedules'
       ,'This must contain a list of valid Road Group Types, in the format: LINK,TOWN'||CHR(10)||'It defines how cyclic maintenance schedules are maintained for local roads.'||CHR(10)||'In Maintain Schedules (MAI3860) you may only create local schedules against groups of these types.'||CHR(10)||'This option may be amended on a live system, however you should immediately update the road group on every current schedule, for consistency.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'CYCGRPTYPL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFAUTOPRI'
       ,'MAI'
       ,'Defect Automatic Priority'
       ,'Auto Defect Prioritisation - Value of A will make Defect Priority field non-navigable, value of B will make Defect Priority field navigable and'||CHR(10)||'  will allow end user to over-type defaulted value, otherwise if null then dont provide a default priority'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFAUTOPRI');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFITEMTYP'
       ,'MAI'
       ,'Default referencing item'
       ,'The default referencing item'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFITEMTYP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFMATPAR'
       ,'MAI'
       ,'Default Matching Defect Param'
       ,'The distance between defects allowed for automatic defect superseeding'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFMATPAR');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFPRIDATE'
       ,'MAI'
       ,'Set Rep Date On Change Of Pri.'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether or not the repair due date should be recalculated automatically when a defect priority is amended.'||CHR(10)||'In Maintain Defects (MAI3806), if this option is set to Y then the repair due date is recalculated.'||CHR(10)||'This option may be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFPRIDATE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFQRYITY'
       ,'MAI'
       ,'Default Inventory Query Code'
       ,'Set this to a valid Inventory Code View for use in conjunction with MAIQRYINV'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFQRYITY');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFRECALLO'
       ,'MAI'
       ,'Lower Tolerance For Survey Len'
       ,'This option defines the tolerance (as a % of section length) within which an inspections survey length may be lower than the section length before the survey is regarded as Partial (and therefore not recalibrated). This is applied when the rmms_flag is 3 and the section is local.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFRECALLO');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFRECALUP'
       ,'MAI'
       ,'Upper Tolerance For Survey Len'
       ,'This option defines the tolerance (as a % of section length) within which an inspections survey length may be greater than the section length. This is applied to all survey types!'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFRECALUP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFSCHTYPD'
       ,'MAI'
       ,'Default scheme type for DoT'
       ,'This option controls the default value of the scheme type on the defects form for DoT roads'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFSCHTYPD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFSCHTYPL'
       ,'MAI'
       ,'Default scheme type for Local'
       ,'This option controls the default value of the scheme type on the defects form for Local roads.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFSCHTYPL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFSCHTYPU'
       ,'MAI'
       ,'Default Scheme Type Updateable'
       ,'Defaulted Scheme Type On Works Order Updateable(Y/N)'
       ,'Y_OR_N'
       ,'VARCHAR2'
       ,'N'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFSCHTYPU');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEFSUPTYPE'
       ,'MAI'
       ,'Superseding Type'
       ,'should Be Set To 1 Or 2, See User Documentation For Details'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFSUPTYPE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DEF_SISS'
       ,'MAI'
       ,'Default SISS'
       ,'Default SISS Used When Creating A Defect.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEF_SISS');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DETXSP'
       ,'MAI'
       ,'Detailed XSP to be used?'
       ,'This flag switches offset field off in MAI2310 and switches detailed XSP field on'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DETXSP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DISPBID'
       ,'MAI'
       ,'Budget Bid Id'
       ,'This value must be Y to display the Budget Bid id.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DISPBID');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DORECAL'
       ,'MAI'
       ,'Recalibration On/Off Switch'
       ,'This option must be set to Y or N. It determines whether or not the system should recalibrate the inventory (for local roads only) based on the maximum chainage of the inventory compared to the current section length or max chainage. A value of Y will result in recalibration being performed. A value of N will switch off the recalibration logic.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DORECAL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'DUMCONCODE'
       ,'MAI'
       ,'Dummy Contract For Estimates'
       ,'This should be a valid contract code.  '||CHR(10)||'It is known as the dummy contract, since it contains every standard item (with standard costs) and is used to provide cost estimates on work orders prior to assigning a proper contract.  If you are not using dummy contracts, set this option to DISABLED.'||CHR(10)||'In Maintain Standard Items (MAI3888) the dummy contract is automatically maintained in line with any standard item inserts, deletes or rate changes.'||CHR(10)||'In Maintain Work Orders (MAI3800) the dummy contract may be selected by any user, irrespective of admin units.'||CHR(10)||'This option may be amended on a live system.'||CHR(10)||'If you want to switch to a different dummy contract at year-end you must manually populate the new contract first - Copy Contract (MAI3882) is the simplest way to do this.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DUMCONCODE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ENDTOLDTP'
       ,'MAI'
       ,'Section End Tolerance, Dtp'
       ,'Tolerance as a percent'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ENDTOLDTP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ENDTOLLOCL'
       ,'MAI'
       ,'Section End Tolerance, Local'
       ,'Tolerance as a percent'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ENDTOLLOCL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'FCFORMAT'
       ,'MAI'
       ,'Financial Commitment Format'
       ,'This value must be N for the standard format.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'FCFORMAT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'FINAL_FLAG'
       ,'MAI'
       ,'Is Final flag to be shown'
       ,'Either Y or N'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'FINAL_FLAG');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'GANGENABLE'
       ,'MAI'
       ,'Enable Gangs'
       ,'Gangs'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'GANGENABLE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'GENTREMODD'
       ,'MAI'
       ,'Generate Dot Treatment Models'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether or not new treatment models are created automatically from BOQs on trunk road repairs.'||CHR(10)||'In Maintain Work Orders (MAI3800), if this option is set to Y then a treatment model will be created when a new type of BOQ is entered.'||CHR(10)||'This option may be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'GENTREMODD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'GENTREMODL'
       ,'MAI'
       ,'Generate Local Treatment Model'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether or not new treatment models are created automatically from BOQs on local road repairs.'||CHR(10)||'In Maintain Work Orders (MAI3800), if this option is set to Y then a treatment model will be created when a new type of BOQ is entered.'||CHR(10)||'This option may be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'GENTREMODL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'GISGRPD'
       ,'MAI'
       ,'Road Group for DoT GIS Work'
       ,'This must be a valid Road Group.  It will be automatically placed on the header of all DoT work orders created from the GIS.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'GISGRPD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'GISGRPL'
       ,'MAI'
       ,'Road Group for Local GIS Work'
       ,'This must be a valid Road Group.  It will be automatically placed on the header of all local work orders created from the GIS.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'GISGRPL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'GISGRPTYP'
       ,'MAI'
       ,'Group Type for all GIS Work'
       ,'This must be a valid Road Group Type.  It must correspond to the road groups named in the GISGRPD and GISGRPL options.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'GISGRPTYP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'HIERASSNAV'
       ,'MAI'
       ,'Use Hierarchy Navigator'
       ,'If set to Y then the Hierarchy Navigator (MAI2306) is called directly rather than Query Assets (MAI2305) which can itself call MAI2306.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'HIERASSNAV');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ICBFGAC'
       ,'MAI'
       ,'Item code Breakdowns FGAC'
       ,'Y= Item Code Breakdowns to be unique at agency level , N = Item Code Breakdowns to be unique at system level.'||CHR(10)||'Setting this option to Y also relies on additional supporting configuration which should be undertaken by/in consultation with exor.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ICBFGAC');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'IFUSEDEFXY'
       ,'MAI'
       ,'Interface Use Defect X,Y'
       ,'(Y/N) Enter Y to include the Defects X,Y co-ordinates in the CIM Work Order File.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'IFUSEDEFXY');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'IIF_SOURCE'
       ,'MAI'
       ,'Inventry Interface File Source'
       ,'This string will be written into the file header when producing inventory interface files.  It is stored in the database in case DoT decide to change it.  ie to avoid having to recompile the C modules.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'IIF_SOURCE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'INCTOPCON'
       ,'MAI'
       ,'Include Top Level Contracts'
       ,'This option should be set to Y if users are allowed to select Contracts with a top level Admin Unit as well as ones valid for their user Admin Unit.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'INCTOPCON');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'INSP_INIT'
       ,'MAI'
       ,'Dflt Insp Initiation Type'
       ,'Initiation Type Used When Creating A Default Inspection Record.'
       ,'INITIATION_TYPE'
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'INSP_INIT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'INSP_SDF'
       ,'MAI'
       ,'Dflt Insp Safety Detailed Flag'
       ,'Safety/Detailed Flag Used When Creating A Default Inspection Record.'
       ,'MAINT_INSP_FLAG'
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'INSP_SDF');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'LONG_LIST'
       ,'MAI'
       ,'Use List Restriction on LOV''s'
       ,'This option controls the behaviour of LOV''s with a large amount of data. If set to Y then certain LOVs will display a query restriction box before displaying valid values. If set to N then the LOV''s will function as normal. This option can be changed at any time.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'LONG_LIST');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'LZSUBCODE'
       ,'MAI'
       ,'Interface, Leading zeros'
       ,'If set to Y then extract leading zeros'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'LZSUBCODE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'MAIQRYINV'
       ,'MAI'
       ,'Inventory Query Mode'
       ,'Use this flag to select whether the inventory form shoud start in enter query mode'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'MAIQRYINV');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'MANINSACT'
       ,'MAI'
       ,'Safety Inspection Act. Code'
       ,'Default Safety Inspection Activity Code for Inspections by Group'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'MANINSACT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'NOTREFOUND'
       ,'MAI'
       ,'Not Refound'
       ,'Enter One Of The Following Values : OFF - Not refound code ignored : ALL - Not Refound code on and runs for all Defects of whatever priority : PRI - Not Refound code on and runs against all Defects EXCEPT Cat 1s.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'NOTREFOUND');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'PEDFILE'
       ,'MAI'
       ,'Mai3863 Edif Filename'
       ,'This will be the default filename provided for the specified user.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'PEDFILE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'PERC_ITEM'
       ,'MAI'
       ,'Name of Percentage items unit'
       ,'This option must contain a valid unit code.'||CHR(10)||'This defines a unit, that can be used as a unit for a BOQ item to signify'||CHR(10)||'that it relates to the percentage cost of another item.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'PERC_ITEM');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'REPAIRS'
       ,'MAI'
       ,'Overwrite Defect date'
       ,'This value must be 1 to close a defect when a temp repair is completed.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'REPAIRS');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'REPCOMDATE'
       ,'MAI'
       ,'Entry Of Repair Complete Date'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether or not repairs can be completed manually from the defect module.'||CHR(10)||'In Maintain Inspections (MAI3808), if this option is set to Y, then users will be able'||CHR(10)||' to enter a repair completion date and the defect status will be automatically updated.'||CHR(10)||'If this option is set to N then the repair completion date is non-enterable. '||CHR(10)||'This is normally the case when Maintain Work Orders (MAI3800) is in use.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'REPCOMDATE');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'REPSETPERD'
       ,'MAI'
       ,'Auto setting of perm. date due'
       ,'Enter Y to force the system to compute repair due dates for single permanent repairs to be based on the rules of the temporary repair.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'REPSETPERD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'REPSETPERL'
       ,'MAI'
       ,'Auto setting of perm. date due'
       ,'Enter Y to force the system to compute repair due dates for single permanent repairs to be based on the rules of the temporary repair.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'REPSETPERL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'RESTYPACC'
       ,'MAI'
       ,'Response Type For Accepted Def'
       ,'This option must be a valid type of response on defect notifications  ie it must exist in the RESPONSE_TYPES domain.'||CHR(10)||'It defines the code used to indicate that a defect has been accepted by an organisation.'||CHR(10)||'In Maintain Responses to Notices (MAI3816) this option is used to determine if a defect has been accepted by a different organisation.'||CHR(10)||'This option must not be changed on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'RESTYPACC');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ROGUEUPD'
       ,'MAI'
       ,'Enable Edit of Rogue Item Rate'
       ,'Set to Y to enable contractors to change the rate of rogue items in MAI3802'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ROGUEUPD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'SDOWOLNTH'
       ,'WMP'
       ,'SDO Work Order Lines Theme ID'
       ,'Theme ID of the Work Order Lines SDO layer'
       ,''
       ,'NUMBER'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'SDOWOLNTH');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'SH_DTE_REP'
       ,'MAI'
       ,'Show Date Repaired'
       ,'Either Y or N'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'SH_DTE_REP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'STADETAIL'
       ,'MAI'
       ,'Detailed Standard Item LOV'
       ,'Used in Works Orders Lines to allow detailed Standard Item Codes LOV.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'STADETAIL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'STATAMEND'
       ,'MAI'
       ,'WOL status codes amendable'
       ,'Determines whether or not users can amend the status code of work order lines within mai3800 (Y or N)'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'STATAMEND');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'STATVAL'
       ,'MAI'
       ,'mai3802 Status Complete'
       ,'Either Y or N'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'STATVAL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'STRTOLDTP'
       ,'MAI'
       ,'Section Start Tolerance, Dtp'
       ,'Tolerance in metres'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'STRTOLDTP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'STRTOLLOCL'
       ,'MAI'
       ,'Section Start Tolerance, Local'
       ,'Tolerance in metres'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'STRTOLLOCL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'TRECODEMAN'
       ,'MAI'
       ,'Is Treatment code mandatory'
       ,'Either Y or N'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'TRECODEMAN');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'TREMODLEV'
       ,'MAI'
       ,'Treatment Model Admin Level'
       ,'This must be a number corresponding to one of the levels in the admin unit hierarchy.'||CHR(10)||'If defines the admin unit level at which treatment models are maintained.  If treatment models are not being used then set this option to 1.'||CHR(10)||'In Maintain Work Orders (MAI3800), when treatment models are created they will be assigned to the road sections admin unit or a parent thereof, depending on the level.'||CHR(10)||'In Maintain Treatment Models (MAI3814), it is only possible to select admin units from this level.'||CHR(10)||'This option must not be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'TREMODLEV');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'UNKNOWNORG'
       ,'MAI'
       ,'Code For Unknown Notify Orgs'
       ,'This should be a valid code for a notifiable organisation.'||CHR(10)||'It defines the organisation code which is assigned to a defect to indicate that responsibility for the repair lies with another organisation, whose identity is not yet known.'||CHR(10)||'If you do not wish to use this feature then set the option to DISABLED.'||CHR(10)||'In Maintain Defects (MAI3806), then UNKNOWN organisation may be selected by any user irrespective of admin unit.'||CHR(10)||'In Print Defect Notices (MAI3904), instead of printing a letter to the UNKNOWN organisation it will produce letters to all notifiable organisations.'||CHR(10)||'This option must not be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'UNKNOWNORG');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USECYCGRPD'
       ,'MAI'
       ,'Use Groups For Dot Cyclic'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether trunk road schedules and associated work order lines, will be based on road groups or road sections.'||CHR(10)||'In Maintain Work Orders (MAI3800), if this option is set to Y then each trunk road work order line will be based on a road group. If set to N then lines will be based on a road section.'||CHR(10)||'In Maintain Cyclic Schedules (MAI3860), if this option is set to Y then actual quantities may be entered for the schedule items.  If set to N they may not be entered.'||CHR(10)||'In Maintain Cyclic Schedules by Section (MAI3862), if this option is set to N then actual item quantities for road sections are automatically accumulated into schedule totals. If set to Y there is no accumulation.'||CHR(10)||'This option must not be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USECYCGRPD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USECYCGRPL'
       ,'MAI'
       ,'Use Groups For Local Cyclic'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether local road schedules and associated work order lines, will be based on road groups or road sections.'||CHR(10)||'In Maintain Work Orders (MAI3800), if this option is set to Y then each local road work order line will be based on a road group. If set to N then lines will be based on a road section.'||CHR(10)||'In Maintain Cyclic Schedules (MAI3860), if this option is set to Y then actual quantities may be entered for the schedule items.  If set to N they may not be entered.'||CHR(10)||'In Maintain Cyclic Schedules by Section (MAI3862), if this option is set to N then actual item quantities for road sections are automatically accumulated into schedule totals. If set to Y there is no accumulation.'||CHR(10)||'This option must not be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USECYCGRPL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USEDEFCHND'
       ,'MAI'
       ,'Use Chainage On Dot Defects'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether chainage and XSP values are recorded on trunk road defects.'||CHR(10)||'In Inspection Loader (MAI2200), if this option is set to Y then chainages must exist on the load file and superseding of defects will take place.  If set to N then chainages will be set to null and there will be no superseding.'||CHR(10)||'In Maintain Defects (MAI3806), if this option is set to Y then chainages must be entered.  If set to N then chainages are non-enterable.'||CHR(10)||'This option must not be amended on live systems.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USEDEFCHND');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USEDEFCHNL'
       ,'MAI'
       ,'Use Chainage On Local Defects'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether chainage and XSP values are recorded on local road defects.'||CHR(10)||'In Inspection Loader (MAI2200), if this option is set to Y then chainages must exist on the load file and superseding of defects will take place.  If set to N then chainages will be set to null and there will be no superseding.'||CHR(10)||'In Maintain Defects (MAI3806), if this option is set to Y then chainages must be entered.  If set to N then chainages are non-enterable.'||CHR(10)||'This option must not be amended on live systems.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USEDEFCHNL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USEDEFCRDS'
       ,'MAI'
       ,'Use Defect Coordinates'
       ,'Enter Y to enable Defect Coordinates. Otherwise, enter N'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USEDEFCRDS');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USERSREP'
       ,'MAI'
       ,'Run RS Report from Insp. Ldr.'
       ,'Set to Y if the Inspection Loader is to automatically run this report where Advisory RS defects > 10%'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USERSREP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USETREMODD'
       ,'MAI'
       ,'Use Dot Treatment Models'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether or not treatment models are used to populate BOQ items automatically on trunk road repairs.'||CHR(10)||'In Inspection Loader (MAI2200), if this option is set to Y then BOQs will be automatically populated when new repairs are loaded.'||CHR(10)||'In Maintain Defects (MAI3806), if this option is set to Y then BOQs will be automatically populated when repairs are created.'||CHR(10)||'This option may be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USETREMODD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'USETREMODL'
       ,'MAI'
       ,'Use Local Treatment Models'
       ,'This option must be set to Y or N.'||CHR(10)||'It determines whether or not treatment models are used to populate BOQ items automatically on local road repairs.'||CHR(10)||'In Inspection Loader (MAI2200), if this option is set to Y then BOQs will be automatically populated when new repairs are loaded.'||CHR(10)||'In Maintain Defects (MAI3806), if this option is set to Y then BOQs will be automatically populated when repairs are created.'||CHR(10)||'This option may be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'USETREMODL');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'WOREPORDBY'
       ,'MAI'
       ,'WO (Enhanced) Order By Clause'
       ,'This option determines which order by clause is used within the Print Works Order (Enhanced) report. The reports default order by clause is used when the option is set to Y and when it is set to N the ordering is done by boq_sta_item_code'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'WOREPORDBY');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'WORGRPTYP'
       ,'MAI'
       ,'Work Planng Reports Group Type'
       ,'This must be a valid Road Group Type which has the exclusive flag set to Y.'||CHR(10)||'It defines the manner in which defect data is grouped (ie ordered and subtotalled) on several work planning reports.'||CHR(10)||'In List of Defects Due For Completion (MAI3926), if this option is set to LINK then selected defects are listed link by link.'||CHR(10)||'This option may be amended at any time.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'WORGRPTYP');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'WORREFGEN'
       ,'MAI'
       ,'Work Order Ref No Generation'
       ,'This option must be set to M, C or A.'||CHR(10)||'It defines the method to be used for allocation of work order numbers in Maintain Work Orders (MAI3800):'||CHR(10)||'M=Manual Entry, C=Contract Based, A=Admin Unit Based.'||CHR(10)||'This option must not be amended on a live system.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'WORREFGEN');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'WORREPMOD'
       ,'MAI'
       ,'Def Work Order Print Module'
       ,'Work orders can be printed either from the fastpath option or directly from '||CHR(10)||'within the Maintain Work Order - Defects form. This option value should '||CHR(10)||'provide the default print report to execute.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'WORREPMOD');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'WORREPMODC'
       ,'MAI'
       ,'Def Cyclic WO Print Module'
       ,'Work orders can be printed either from the fastpath option or directly from'||CHR(10)||'within the Maintain Work Order - Cyclic form. This option value should'||CHR(10)||'provide the default print report to execute for cyclic work orders.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'WORREPMODC');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'WORSTDTXT'
       ,'MAI'
       ,'Works Order Standard Text'
       ,'This option will appear on each Work Order Description of Work'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'WORSTDTXT');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'XSPMATLEN'
       ,'MAI'
       ,'XSP Material Length'
       ,'Y = Max Length = 2, N = Max Length = 8'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'XSPMATLEN');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'XSPREVDIR'
       ,'MAI'
       ,'XSP In The Reverse  Direction'
       ,'This option must contain a valid XSP Code.'||CHR(10)||'It defines the XSP code for machine data collected in the opposite direction to the standard network direction.'||CHR(10)||'In the Inventory Loader (BPR2100), any machine data collected in the reverse direction will have its chainage reversed and will be stored as inventory against this XSP.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'XSPREVDIR');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'XSPSTDDIR'
       ,'MAI'
       ,'XSP In The Standard Direction'
       ,'This option must contain a valid XSP Code.'||CHR(10)||'It defines the XSP code for machine data collected in the standard network direction.'||CHR(10)||'In the Inventory Loader (BPR2100), any machine data collected in the standard direction will be stored as inventory against this XSP.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'XSPSTDDIR');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'XTRIFLDS'
       ,'MAI'
       ,'Version of Interface Files'
       ,'If set to 2-1-3 uses additional fields on the end of the WO and WI files. Otherwise set to NA.'
       ,''
       ,'VARCHAR2'
       ,'Y'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'XTRIFLDS');
--
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       )
SELECT 
        'ZEROPAD'
       ,'MAI'
       ,'Zero pad the CIM filenames'
       ,'This option, when set to Y, means that all filenames used within Interfaces must be padded out with zeros until of the format <filetype><999999>.<concode> ie WO000001.CON.'
       ,''
       ,'VARCHAR2'
       ,'N'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'ZEROPAD');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_OPTION_VALUES
--
-- select * from mai_metadata.hig_option_values
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
        'ACTTOSCHEM'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ACTTOSCHEM');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ADDINSTR'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ADDINSTR');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ADDPRINT'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ADDPRINT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ADMINLEVEL'
       ,'2' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ADMINLEVEL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ASSETBASED'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ASSETBASED');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'AUDIT_ALL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'AUDIT_ALL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'AUTH_OWN'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'AUTH_OWN');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'BUDAUDT'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'BUDAUDT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'BUDGRPTYPD'
       ,'RP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'BUDGRPTYPD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'BUDGRPTYPL'
       ,'HIER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'BUDGRPTYPL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'BUD_SELECT'
       ,'1' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'BUD_SELECT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CLAIMDEF'
       ,'A' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CLAIMDEF');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CLAIMREJT'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CLAIMREJT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'COMPLEDATE'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'COMPLEDATE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'COMPWOLEL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'COMPWOLEL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CONINTRM'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CONINTRM');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CONSECMODE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CONSECMODE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CPAFORMAT'
       ,'0' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CPAFORMAT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CPAINTERIM'
       ,'0' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CPAINTERIM');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CSVSEPVAL'
       ,',' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CSVSEPVAL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CUM_PERC'
       ,'CUMULATIVE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CUM_PERC');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CYCGRPTYPD'
       ,'RP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CYCGRPTYPD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'CYCGRPTYPL'
       ,'HIER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'CYCGRPTYPL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFAUTOPRI'
       ,'Z' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFAUTOPRI');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFITEMTYP'
       ,'CW' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFITEMTYP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFMATPAR'
       ,'5' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFMATPAR');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFPRIDATE'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFPRIDATE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFQRYITY'
       ,'BPR_DCW' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFQRYITY');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFRECALLO'
       ,'50' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFRECALLO');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFRECALUP'
       ,'5' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFRECALUP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFSCHTYPD'
       ,'RD' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFSCHTYPD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFSCHTYPL'
       ,'LD' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFSCHTYPL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFSCHTYPU'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFSCHTYPU');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFSUPTYPE'
       ,'1' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFSUPTYPE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEF_SISS'
       ,'ALL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEF_SISS');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DETXSP'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DETXSP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DISPBID'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DISPBID');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DORECAL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DORECAL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DUMCONCODE'
       ,'DISABLED' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DUMCONCODE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ENDTOLDTP'
       ,'10' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ENDTOLDTP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ENDTOLLOCL'
       ,'50' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ENDTOLLOCL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'FCFORMAT'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'FCFORMAT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'FINAL_FLAG'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'FINAL_FLAG');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'GANGENABLE'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'GANGENABLE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'GENTREMODD'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'GENTREMODD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'GENTREMODL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'GENTREMODL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'GISGRPD'
       ,'ALL_DOT_SECTIONS' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'GISGRPD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'GISGRPL'
       ,'ALL_LOCAL_SECTIONS' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'GISGRPL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'GISGRPTYP'
       ,'TOP' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'GISGRPTYP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'HIERASSNAV'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'HIERASSNAV');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ICBFGAC'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ICBFGAC');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'IFUSEDEFXY'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'IFUSEDEFXY');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'IIF_SOURCE'
       ,'RMMSINV' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'IIF_SOURCE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'INCTOPCON'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'INCTOPCON');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'INSP_INIT'
       ,'DUM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'INSP_INIT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'INSP_SDF'
       ,'D' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'INSP_SDF');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'LONG_LIST'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'LONG_LIST');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'LZSUBCODE'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'LZSUBCODE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'MAIQRYINV'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'MAIQRYINV');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'MANINSACT'
       ,'SI' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'MANINSACT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'NOTREFOUND'
       ,'ALL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'NOTREFOUND');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'PERC_ITEM'
       ,'X' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'PERC_ITEM');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'REPAIRS'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'REPAIRS');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'REPCOMDATE'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'REPCOMDATE');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'REPSETPERD'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'REPSETPERD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'REPSETPERL'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'REPSETPERL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'RESTYPACC'
       ,'A' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'RESTYPACC');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ROGUEUPD'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ROGUEUPD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'SH_DTE_REP'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'SH_DTE_REP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'STADETAIL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'STADETAIL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'STATAMEND'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'STATAMEND');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'STATVAL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'STATVAL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'STRTOLDTP'
       ,'0' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'STRTOLDTP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'STRTOLLOCL'
       ,'0' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'STRTOLLOCL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'TRECODEMAN'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'TRECODEMAN');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'TREMODLEV'
       ,'1' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'TREMODLEV');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'UNKNOWNORG'
       ,'UNKNOWN' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'UNKNOWNORG');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USECYCGRPD'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USECYCGRPD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USECYCGRPL'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USECYCGRPL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USEDEFCHND'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USEDEFCHND');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USEDEFCHNL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USEDEFCHNL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USEDEFCRDS'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USEDEFCRDS');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USERSREP'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USERSREP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USETREMODD'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USETREMODD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'USETREMODL'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'USETREMODL');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'WOREPORDBY'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'WOREPORDBY');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'WORGRPTYP'
       ,'LINK' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'WORGRPTYP');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'WORREFGEN'
       ,'A' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'WORREFGEN');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'WORREPMOD'
       ,'MAI3909' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'WORREPMOD');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'WORREPMODC'
       ,'MAI3907' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'WORREPMODC');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'WORSTDTXT'
       ,'IN ACCORDANCE WITH TERM MAINTENANCE CONTRACT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'WORSTDTXT');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'XSPMATLEN'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'XSPMATLEN');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'XSPREVDIR'
       ,'5' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'XSPREVDIR');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'XSPSTDDIR'
       ,'4' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'XSPSTDDIR');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'XTRIFLDS'
       ,'NA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'XTRIFLDS');
--
INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'ZEROPAD'
       ,'Y' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'ZEROPAD');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_STATUS_DOMAINS
--
-- select * from mai_metadata.hig_status_domains
-- order by hsd_domain_code
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_status_domains
SET TERM OFF

INSERT INTO HIG_STATUS_DOMAINS
       (HSD_DOMAIN_CODE
       ,HSD_PRODUCT
       ,HSD_DESCRIPTION
       ,HSD_FEATURE1
       ,HSD_FEATURE2
       ,HSD_FEATURE3
       ,HSD_FEATURE4
       ,HSD_FEATURE5
       ,HSD_FEATURE6
       ,HSD_FEATURE7
       ,HSD_FEATURE8
       ,HSD_FEATURE9
       )
SELECT 
        'CLAIM STATUS'
       ,'MAI'
       ,'Interface claim status'
       ,'Can be paid by payment run'
       ,'Held - will not be paid'
       ,'Paid by payment run'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_DOMAINS
                   WHERE HSD_DOMAIN_CODE = 'CLAIM STATUS');
--
INSERT INTO HIG_STATUS_DOMAINS
       (HSD_DOMAIN_CODE
       ,HSD_PRODUCT
       ,HSD_DESCRIPTION
       ,HSD_FEATURE1
       ,HSD_FEATURE2
       ,HSD_FEATURE3
       ,HSD_FEATURE4
       ,HSD_FEATURE5
       ,HSD_FEATURE6
       ,HSD_FEATURE7
       ,HSD_FEATURE8
       ,HSD_FEATURE9
       )
SELECT 
        'CONTRACTS'
       ,'MAI'
       ,'Contract Status Codes'
       ,'Contract may be amended.'
       ,'Contract may be assigned to work orders.'
       ,'Not used'
       ,'Not used'
       ,'Not used'
       ,'Not used'
       ,'Not used'
       ,'Not used'
       ,'Not used' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_DOMAINS
                   WHERE HSD_DOMAIN_CODE = 'CONTRACTS');
--
INSERT INTO HIG_STATUS_DOMAINS
       (HSD_DOMAIN_CODE
       ,HSD_PRODUCT
       ,HSD_DESCRIPTION
       ,HSD_FEATURE1
       ,HSD_FEATURE2
       ,HSD_FEATURE3
       ,HSD_FEATURE4
       ,HSD_FEATURE5
       ,HSD_FEATURE6
       ,HSD_FEATURE7
       ,HSD_FEATURE8
       ,HSD_FEATURE9
       )
SELECT 
        'DEFECTS'
       ,'MAI'
       ,'Status Codes for an individual defect'
       ,'Defects are initially created with this status. This status will be set in MAI3806 or BPR2200'
       ,'The defect is ready to be assigned to a work order.  '||CHR(10)||'This status will be set in MAI3806 and checked in MAI3800.'
       ,'At least one repair on the defect has been assigned to a work order.  '||CHR(10)||'This status will be set in MAI3800.'
       ,'All repairs for the defect have been completed.  '||CHR(10)||'This status will be set in MAI3800.'
       ,'The defect may be manually amended or deleted.'||CHR(10)||'Defects with these statuses may be amended to a different status, providing it is also allowed with feature 5.'
       ,'The defect has been repaired via structural maintenance.'
       ,'Superceded defects are reopened with this status.'||CHR(10)||'This happens in MAI3806 when a superceding defect is deleted.'
       ,'The defect has been written off.'||CHR(10)||'If no chainages are recorded, the inspection loader cannot supercede defects, so they have to be written off.'||CHR(10)||'This may be set manually in mai3806 or automatically from mai3800 (by setting the work status to NOT DONE).'
       ,'The description, type and location are protected.'||CHR(10)||'This feature is only relevant when the defect is updateable'||CHR(10)||'(ie feature5 = Y).  '||CHR(10)||'For DOE these fields are updateable on UNAVAIL defects but are protected on AVAILABLE defects.' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_DOMAINS
                   WHERE HSD_DOMAIN_CODE = 'DEFECTS');
--
INSERT INTO HIG_STATUS_DOMAINS
       (HSD_DOMAIN_CODE
       ,HSD_PRODUCT
       ,HSD_DESCRIPTION
       ,HSD_FEATURE1
       ,HSD_FEATURE2
       ,HSD_FEATURE3
       ,HSD_FEATURE4
       ,HSD_FEATURE5
       ,HSD_FEATURE6
       ,HSD_FEATURE7
       ,HSD_FEATURE8
       ,HSD_FEATURE9
       )
SELECT 
        'PERC_ITEM_COMP'
       ,'MAI'
       ,'Percentage item computation'
       ,'Normal independant computation'
       ,'Cumulative computation (cost dependant on other percentage items)'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used'
       ,'Not Used' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_DOMAINS
                   WHERE HSD_DOMAIN_CODE = 'PERC_ITEM_COMP');
--
INSERT INTO HIG_STATUS_DOMAINS
       (HSD_DOMAIN_CODE
       ,HSD_PRODUCT
       ,HSD_DESCRIPTION
       ,HSD_FEATURE1
       ,HSD_FEATURE2
       ,HSD_FEATURE3
       ,HSD_FEATURE4
       ,HSD_FEATURE5
       ,HSD_FEATURE6
       ,HSD_FEATURE7
       ,HSD_FEATURE8
       ,HSD_FEATURE9
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'MAI'
       ,'Status codes for an individual repair or cyclic maintenance task'
       ,'The work has been assigned to a work order'
       ,'The work has been completed but payment will be delayed'
       ,'The work has been completed and may be paid'
       ,'The work has been completed and payment has been made'
       ,'The work did not take place.'
       ,'An Interim Invoice has been issued against the work'
       ,'The work has been completed on site but an invoice has not been received'
       ,'Enter actual usage of items to be paid.'
       ,'Some of the work has been completed and can be paid.' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_DOMAINS
                   WHERE HSD_DOMAIN_CODE = 'WORK_ORDER_LINES');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_STATUS_CODES
--
-- select * from mai_metadata.hig_status_codes
-- order by hsc_domain_code
--         ,hsc_status_code
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_status_codes
SET TERM OFF

INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'CLAIM STATUS'
       ,'A'
       ,'Approved'
       ,2
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'CLAIM STATUS'
                    AND  HSC_STATUS_CODE = 'A');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'CLAIM STATUS'
       ,'H'
       ,'Held'
       ,3
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'CLAIM STATUS'
                    AND  HSC_STATUS_CODE = 'H');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'CLAIM STATUS'
       ,'P'
       ,'Paid'
       ,1
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'CLAIM STATUS'
                    AND  HSC_STATUS_CODE = 'P');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'CONTRACTS'
       ,'ACTIVE'
       ,'Active'
       ,2
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'CONTRACTS'
                    AND  HSC_STATUS_CODE = 'ACTIVE');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'CONTRACTS'
       ,'INACTIVE'
       ,'Inactive'
       ,1
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'CONTRACTS'
                    AND  HSC_STATUS_CODE = 'INACTIVE');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'DEFECTS'
       ,'AVAILABLE'
       ,'Available to be instructed'
       ,2
       ,'Y'
       ,'Y'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'DEFECTS'
                    AND  HSC_STATUS_CODE = 'AVAILABLE');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'DEFECTS'
       ,'COMPLETED'
       ,'Completed'
       ,4
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'DEFECTS'
                    AND  HSC_STATUS_CODE = 'COMPLETED');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'DEFECTS'
       ,'INSTRUCTED'
       ,'Instructed'
       ,3
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'DEFECTS'
                    AND  HSC_STATUS_CODE = 'INSTRUCTED');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'DEFECTS'
       ,'STR MAINT'
       ,'Repaired by Structural Maint'
       ,5
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'DEFECTS'
                    AND  HSC_STATUS_CODE = 'STR MAINT');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'DEFECTS'
       ,'SUPERSEDED'
       ,'Superseded, not instructed'
       ,6
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'DEFECTS'
                    AND  HSC_STATUS_CODE = 'SUPERSEDED');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'PERC_ITEM_COMP'
       ,'CUMULATIVE'
       ,'Cumulative Computation'
       ,2
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'PERC_ITEM_COMP'
                    AND  HSC_STATUS_CODE = 'CUMULATIVE');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'PERC_ITEM_COMP'
       ,'NORMAL'
       ,'Normal Computation'
       ,1
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'PERC_ITEM_COMP'
                    AND  HSC_STATUS_CODE = 'NORMAL');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'ACTIONED'
       ,'Work completed on site'
       ,8
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'ACTIONED');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'COMPLETED'
       ,'Completed - Ready for Payment'
       ,3
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'COMPLETED');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'HELD'
       ,'Completed - Hold Payment'
       ,2
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'HELD');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'INSTRUCTED'
       ,'Instructed - On Work Order'
       ,1
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'INSTRUCTED');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'INTERIM'
       ,'Part Comp. - Ready for Payment'
       ,10
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'INTERIM');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'NOT DONE'
       ,'Work Not Done'
       ,5
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'NOT DONE');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'PAID'
       ,'Completed - Payment made'
       ,4
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'PAID');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'PART COMP'
       ,'Interim Invoice Received'
       ,7
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'PART COMP');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'PART PAID'
       ,'Interim payment completed'
       ,12
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'PART PAID');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'UNAPPROVED'
       ,'Interim payment not approved'
       ,11
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'UNAPPROVED');
--
INSERT INTO HIG_STATUS_CODES
       (HSC_DOMAIN_CODE
       ,HSC_STATUS_CODE
       ,HSC_STATUS_NAME
       ,HSC_SEQ_NO
       ,HSC_ALLOW_FEATURE1
       ,HSC_ALLOW_FEATURE2
       ,HSC_ALLOW_FEATURE3
       ,HSC_ALLOW_FEATURE4
       ,HSC_ALLOW_FEATURE5
       ,HSC_ALLOW_FEATURE6
       ,HSC_ALLOW_FEATURE7
       ,HSC_ALLOW_FEATURE8
       ,HSC_ALLOW_FEATURE9
       ,HSC_START_DATE
       ,HSC_END_DATE
       )
SELECT 
        'WORK_ORDER_LINES'
       ,'VALUATION'
       ,'Valuation'
       ,9
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,'Y'
       ,'N'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STATUS_CODES
                   WHERE HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
                    AND  HSC_STATUS_CODE = 'VALUATION');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_USER_OPTION_LIST
--
-- select * from mai_metadata.hig_user_option_list
-- order by huol_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_user_option_list
SET TERM OFF

--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_CHECK_CONSTRAINT_ASSOCS
--
-- select * from mai_metadata.hig_check_constraint_assocs
-- order by hcca_constraint_name
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_check_constraint_assocs
SET TERM OFF

INSERT INTO HIG_CHECK_CONSTRAINT_ASSOCS
       (HCCA_CONSTRAINT_NAME
       ,HCCA_TABLE_NAME
       ,HCCA_NER_APPL
       ,HCCA_NER_ID
       )
SELECT 
        'WOR_PK'
       ,'WORK_ORDERS'
       ,'MAI'
       ,133 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CHECK_CONSTRAINT_ASSOCS
                   WHERE HCCA_CONSTRAINT_NAME = 'WOR_PK');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_STANDARD_FAVOURITES
--
-- select * from mai_metadata.hig_standard_favourites
-- order by hstf_parent
--         ,hstf_child
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_standard_favourites
SET TERM OFF

INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'FAVOURITES'
       ,'MAI'
       ,'Maintenance Manager'
       ,'F'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'FAVOURITES'
                    AND  HSTF_CHILD = 'MAI');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI8000'
       ,'Batch Works Order Printing'
       ,'M'
       ,21 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI8000');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_CONTRACTS'
       ,'Contracts'
       ,'F'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_CONTRACTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_FINANCIAL'
       ,'Financial'
       ,'F'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_FINANCIAL');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_INSP'
       ,'Inspections'
       ,'F'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_INSP');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_INTERFACES'
       ,'Interfaces'
       ,'F'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_INTERFACES');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_INV'
       ,'Inventory'
       ,'F'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_INV');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_LOADERS'
       ,'Loaders'
       ,'F'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_LOADERS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_REF'
       ,'Reference'
       ,'F'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_REF');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_REPORTS'
       ,'Reports'
       ,'F'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI'
       ,'MAI_WORKS'
       ,'Works'
       ,'F'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI'
                    AND  HSTF_CHILD = 'MAI_WORKS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI3624'
       ,'Discount Groups'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI3624');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI3880'
       ,'Contracts'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI3880');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI3881'
       ,'Contractors'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI3881');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI3882'
       ,'Copy a Contract'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI3882');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI3884'
       ,'Bulk Update of Contract Items'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI3884');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI3886'
       ,'Standard Item Sections and Sub-Sections'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI3886');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI3888'
       ,'Standard Items'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI3888');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS'
       ,'MAI_CONTRACTS_REPORTS'
       ,'Reports'
       ,'F'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS'
                    AND  HSTF_CHILD = 'MAI_CONTRACTS_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3932'
       ,'Summary of Work Instructed by Standard Item'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3932');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3934'
       ,'Summary of Work Volumes by Standard Item'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3934');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3948'
       ,'Summary of Expenditure by Contract'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3948');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3954'
       ,'Contractor Performance Report'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3954');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3980'
       ,'Contract Details Report'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3980');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3981'
       ,'List of Contractors'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3981');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3982'
       ,'List of Contract Liabilities'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3982');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3984'
       ,'List of Contract Rates'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3984');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3986'
       ,'List of Standard Item Sections and Sub-Sections'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3986');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_CONTRACTS_REPORTS'
       ,'MAI3988'
       ,'List of Standard Items'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_CONTRACTS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3988');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI1930'
       ,'IHMS Allocated Amounts'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI1930');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI3660'
       ,'Budgets'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3660');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI3662'
       ,'Generate Budgets for Next Year'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3662');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI3840'
       ,'Payment Run'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3840');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI3842'
       ,'Deselect Items for Payment'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3842');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI3940'
       ,'Query Payment Run Details'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3940');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL'
       ,'MAI_FINANCIAL_REPORTS'
       ,'Reports'
       ,'F'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI_FINANCIAL_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL_REPORTS'
       ,'MAI3690'
       ,'Print Budget Exceptions Report'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL_REPORTS'
                    AND  HSTF_CHILD = 'MAI3690');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL_REPORTS'
       ,'MAI3692'
       ,'Print Cost Code Exceptions Report'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL_REPORTS'
                    AND  HSTF_CHILD = 'MAI3692');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL_REPORTS'
       ,'MAI3841'
       ,'Payment Run Report'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL_REPORTS'
                    AND  HSTF_CHILD = 'MAI3841');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL_REPORTS'
       ,'MAI3942'
       ,'List of Items for Payment'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL_REPORTS'
                    AND  HSTF_CHILD = 'MAI3942');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_FINANCIAL_REPORTS'
       ,'MAI3944'
       ,'List of Completed Rechargeable Defects'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_FINANCIAL_REPORTS'
                    AND  HSTF_CHILD = 'MAI3944');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_GMIS_LOADERS'
       ,'MAI2530'
       ,'Create Route and Defect Files for GMIS Inspections'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_GMIS_LOADERS'
                    AND  HSTF_CHILD = 'MAI2530');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_GMIS_LOADERS'
       ,'MAI2550'
       ,'Correct GMIS Load File Errors'
       ,'M'
       ,12 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_GMIS_LOADERS'
                    AND  HSTF_CHILD = 'MAI2550');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_GMIS_LOADERS'
       ,'MAIWEB2540'
       ,'GMIS Survey File Loader'
       ,'M'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_GMIS_LOADERS'
                    AND  HSTF_CHILD = 'MAIWEB2540');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI2470'
       ,'Delete Inspections'
       ,'M'
       ,90 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI2470');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI2730'
       ,'Match Duplicate Defects'
       ,'M'
       ,70 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI2730');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI2760'
       ,'Unmatch Duplicate Defects'
       ,'M'
       ,80 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI2760');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI2775'
       ,'Batch Setting of Repair Dates'
       ,'M'
       ,100 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI2775');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI3806'
       ,'Defects'
       ,'M'
       ,30 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI3806');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI3808'
       ,'Inspections'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI3808');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI3810'
       ,'View Defects'
       ,'M'
       ,40 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI3810');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI3816'
       ,'Responses to Notices'
       ,'M'
       ,60 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI3816');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI3899'
       ,'Inspections by Group'
       ,'M'
       ,20 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI3899');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP'
       ,'MAI_INSP_REPORTS'
       ,'Reports'
       ,'F'
       ,110 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP'
                    AND  HSTF_CHILD = 'MAI_INSP_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI2210'
       ,'Print Defective Advisory Roadstuds Report'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI2210');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI2790'
       ,'Insurance Claims Reporting'
       ,'M'
       ,12 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI2790');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3100'
       ,'Print Inspection Schedules'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3100');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3470'
       ,'Print Defect Details ( Work Orders )'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3470');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3900'
       ,'Print Inspection Report'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3900');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3902'
       ,'Print Defect Details'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3902');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3904'
       ,'Print Defect Notices'
       ,'M'
       ,13 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3904');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3905'
       ,'Print Roadstud Defects not Set to Mandatory or Advisory'
       ,'M'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3905');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3910'
       ,'List of Defects by Inspection Date'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3910');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3912'
       ,'List of Notifiable Defects'
       ,'M'
       ,14 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3912');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI3916'
       ,'Summary of Notifiable/Rechargeable Defects'
       ,'M'
       ,15 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI3916');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI5025'
       ,'Detailed Inspection Work Done'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI5025');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI5027'
       ,'Print Defects by Defect Type'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI5027');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI5100'
       ,'Print Defect Details (At-a-Glance)'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI5100');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INSP_REPORTS'
       ,'MAI5125'
       ,'Print Defect Details (Strip Plan)'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INSP_REPORTS'
                    AND  HSTF_CHILD = 'MAI5125');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INTERFACES'
       ,'MAI3830'
       ,'Works Order File Extract'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INTERFACES'
                    AND  HSTF_CHILD = 'MAI3830');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INTERFACES'
       ,'MAI3834'
       ,'Financial Commitment File'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INTERFACES'
                    AND  HSTF_CHILD = 'MAI3834');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INTERFACES'
       ,'MAI3850'
       ,'Completions file'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INTERFACES'
                    AND  HSTF_CHILD = 'MAI3850');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INTERFACES'
       ,'MAI3852'
       ,'Invoice file'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INTERFACES'
                    AND  HSTF_CHILD = 'MAI3852');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INTERFACES'
       ,'MAI3854'
       ,'Invoice Verification form'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INTERFACES'
                    AND  HSTF_CHILD = 'MAI3854');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INTERFACES'
       ,'MAI3856'
       ,'Payment Approval form'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INTERFACES'
                    AND  HSTF_CHILD = 'MAI3856');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INTERFACES'
       ,'MAI3858'
       ,'Payment Transaction file'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INTERFACES'
                    AND  HSTF_CHILD = 'MAI3858');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV'
       ,'MAI2140'
       ,'Query Network/Inventory Data'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV'
                    AND  HSTF_CHILD = 'MAI2140');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV'
       ,'MAI_INV_REPORTS'
       ,'Reports'
       ,'F'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV'
                    AND  HSTF_CHILD = 'MAI_INV_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI2115'
       ,'Print Potential Inventory Duplicates'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI2115');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI2315'
       ,'Print Inventory Items (matrix format)'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI2315');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI2320'
       ,'Print Inventory Map'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI2320');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI2325'
       ,'Print Inventory Summary'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI2325');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI2330'
       ,'Print Summary of Inventory Changes'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI2330');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI30060'
       ,'Print Historical Inventory Data'
       ,'M'
       ,12 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI30060');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5001'
       ,'Inventory Item Details'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5001');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5010'
       ,'Print Road Markings - Hatched Type Area'
       ,'M'
       ,17 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5010');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5011'
       ,'Print Road Markings - Longitudinal'
       ,'M'
       ,16 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5011');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5015'
       ,'Print Road Markings - Transverse and Special'
       ,'M'
       ,15 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5015');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5018'
       ,'Print Sign Areas'
       ,'M'
       ,14 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5018');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5021'
       ,'Print Inventory Areas - Trapezium Rule'
       ,'M'
       ,13 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5021');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5022'
       ,'Print Inspectors Pocket Book'
       ,'M'
       ,19 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5022');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5031'
       ,'Print Electrical Inventory'
       ,'M'
       ,18 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5031');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI5075'
       ,'Print Inventory Item Report'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI5075');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI6100'
       ,'Print Inventory Statistics'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI6100');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI6110'
       ,'Print Inventory Lengths'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI6110');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI9010'
       ,'Detect Inventory Gap/Overlap'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI9010');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_INV_REPORTS'
       ,'MAI9020'
       ,'Print Inventory Gap/Overlap'
       ,'M'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_INV_REPORTS'
                    AND  HSTF_CHILD = 'MAI9020');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS'
       ,'MAI_GMIS_LOADERS'
       ,'GMIS Interface'
       ,'F'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS'
                    AND  HSTF_CHILD = 'MAI_GMIS_LOADERS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS'
       ,'MAI_LOADERS_INSPECTIONS'
       ,'Inspections'
       ,'F'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS'
                    AND  HSTF_CHILD = 'MAI_LOADERS_INSPECTIONS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS'
       ,'MAI_LOADERS_INVENTORY'
       ,'Inventory'
       ,'F'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS'
                    AND  HSTF_CHILD = 'MAI_LOADERS_INVENTORY');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI2200C'
       ,'Inspection Loader (Part 1)'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2200C');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI2200D'
       ,'Inspection Loader (Part 2)'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2200D');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI2200R'
       ,'Bulk Inspection Load - Stage 2 Report'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2200R');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI2220'
       ,'Download Static Ref Data for DCD Inspections'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2220');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI2222'
       ,'Download Standard Item Data for DCD Inspections'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2222');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI2224'
       ,'Download Network Data for DCD Inspections'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2224');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI2250'
       ,'Correct Inspection Load Errors'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI2250');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI3863'
       ,'Download Inspection by Assets'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI3863');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INSPECTIONS'
       ,'MAI5091'
       ,'Remove Phase 1 Inspection Batches'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI5091');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INVENTORY'
       ,'MAI2100C'
       ,'Inventory Loader (Part 1)'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INVENTORY'
                    AND  HSTF_CHILD = 'MAI2100C');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INVENTORY'
       ,'MAI2105C'
       ,'Reformat Road Group Inventory Data'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INVENTORY'
                    AND  HSTF_CHILD = 'MAI2105C');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INVENTORY'
       ,'MAI2110C'
       ,'Inventory Loader (Part 2)'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INVENTORY'
                    AND  HSTF_CHILD = 'MAI2110C');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INVENTORY'
       ,'MAI2120'
       ,'Correct Inventory Load Errors'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INVENTORY'
                    AND  HSTF_CHILD = 'MAI2120');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INVENTORY'
       ,'MAI2500'
       ,'Download Data for Inventory Survey on DCD'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INVENTORY'
                    AND  HSTF_CHILD = 'MAI2500');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INVENTORY'
       ,'MAI5065'
       ,'Print Batch with Downloaded Inventory Items'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INVENTORY'
                    AND  HSTF_CHILD = 'MAI5065');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_LOADERS_INVENTORY'
       ,'MAI5090'
       ,'Remove Successfully Loaded Inventory Batches'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_LOADERS_INVENTORY'
                    AND  HSTF_CHILD = 'MAI5090');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF'
       ,'MAI_REF_FINANCIAL'
       ,'Financial'
       ,'F'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF'
                    AND  HSTF_CHILD = 'MAI_REF_FINANCIAL');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF'
       ,'MAI_REF_INSPECTIONS'
       ,'Inspections'
       ,'F'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF'
                    AND  HSTF_CHILD = 'MAI_REF_INSPECTIONS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF'
       ,'MAI_REF_INVENTORY'
       ,'Inventory'
       ,'F'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF'
                    AND  HSTF_CHILD = 'MAI_REF_INVENTORY');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF'
       ,'MAI_REF_MAINTENANCE'
       ,'Maintenance'
       ,'F'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF'
                    AND  HSTF_CHILD = 'MAI_REF_MAINTENANCE');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL'
       ,'MAI1940'
       ,'Item Code Breakdowns'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI1940');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL'
       ,'MAI3664'
       ,'Financial Years'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3664');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL'
       ,'MAI3666'
       ,'Job Size Codes'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3666');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL'
       ,'MAI3844'
       ,'Cost Centre Codes'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3844');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL'
       ,'MAI3846'
       ,'VAT Rates'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI3846');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL'
       ,'MAI_REF_FINANCIAL_REPORTS'
       ,'Reports'
       ,'F'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL'
                    AND  HSTF_CHILD = 'MAI_REF_FINANCIAL_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL_REPORTS'
       ,'MAI2780'
       ,'Print Item Code Breakdowns'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL_REPORTS'
                    AND  HSTF_CHILD = 'MAI2780');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_FINANCIAL_REPORTS'
       ,'MAI3946'
       ,'List of VAT Rates'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_FINANCIAL_REPORTS'
                    AND  HSTF_CHILD = 'MAI3946');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI1300'
       ,'Defect Control Data'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI1300');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI1315'
       ,'Treatment Data'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI1315');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI1320'
       ,'Enquiry/Treatment Types'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI1320');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI1325'
       ,'Enquiry/Defect Priorities'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI1325');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI1830'
       ,'People'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI1830');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI1870'
       ,'Organisations'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI1870');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI3150'
       ,'Default Treatments'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI3150');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI3812'
       ,'Defect Priorities'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI3812');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI3813'
       ,'Maintain Automatic Defect Prioritisation'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI3813');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI3814'
       ,'Treatment Models'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI3814');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS'
       ,'MAI_REF_INSPECTIONS_REPORTS'
       ,'Reports'
       ,'F'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS'
                    AND  HSTF_CHILD = 'MAI_REF_INSPECTIONS_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS_REPORTS'
       ,'MAI1808'
       ,'List of Organisations'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS_REPORTS'
                    AND  HSTF_CHILD = 'MAI1808');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS_REPORTS'
       ,'MAI1840'
       ,'List of People'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS_REPORTS'
                    AND  HSTF_CHILD = 'MAI1840');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS_REPORTS'
       ,'MAI3250'
       ,'Print Defect Movements'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3250');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS_REPORTS'
       ,'MAI5220'
       ,'Print Valid Defect Types'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS_REPORTS'
                    AND  HSTF_CHILD = 'MAI5220');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS_REPORTS'
       ,'MAI5235'
       ,'Print Defect Item Types'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS_REPORTS'
                    AND  HSTF_CHILD = 'MAI5235');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INSPECTIONS_REPORTS'
       ,'MAI5240'
       ,'Print Treatment Codes'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INSPECTIONS_REPORTS'
                    AND  HSTF_CHILD = 'MAI5240');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INVENTORY'
       ,'MAI1400'
       ,'v2 Asset Type Translations'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INVENTORY'
                    AND  HSTF_CHILD = 'MAI1400');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INVENTORY'
       ,'MAI1430'
       ,'Lamp Configurations'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INVENTORY'
                    AND  HSTF_CHILD = 'MAI1430');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INVENTORY'
       ,'MAI_REF_INVENTORY_REPORTS'
       ,'Reports'
       ,'F'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INVENTORY'
                    AND  HSTF_CHILD = 'MAI_REF_INVENTORY_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INVENTORY_REPORTS'
       ,'MAI5050'
       ,'Print List of Inventory Item Types, Attributes and Values'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INVENTORY_REPORTS'
                    AND  HSTF_CHILD = 'MAI5050');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INVENTORY_REPORTS'
       ,'MAI5200'
       ,'Print Lamp Configurations'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INVENTORY_REPORTS'
                    AND  HSTF_CHILD = 'MAI5200');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_INVENTORY_REPORTS'
       ,'MAI5210'
       ,'Print Electricity Boards'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_INVENTORY_REPORTS'
                    AND  HSTF_CHILD = 'MAI5210');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI0132'
       ,'Work Order Priorities'
       ,'M'
       ,12 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI0132');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI1200'
       ,'Activities'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI1200');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI1205'
       ,'Activity Groups'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI1205');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI1210'
       ,'Local Activity Frequencies'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI1210');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI1230'
       ,'Default Section Intervals Calculation'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI1230');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI1240'
       ,'Default Section Intervals'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI1240');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI3440'
       ,'Valid For Maintenance Rules'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI3440');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI3626'
       ,'Cyclic Maintenance Inventory Rules'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI3626');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI3628'
       ,'Related Maintenance Activities'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI3628');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI3630'
       ,'Budget Allocations'
       ,'M'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI3630');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI3632'
       ,'Asset Activities'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI3632');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI3803'
       ,'Work Order Auditing Maintenance'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI3803');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE'
       ,'MAI_REF_MAINTENANCE_REPORTS'
       ,'Reports'
       ,'F'
       ,14 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE'
                    AND  HSTF_CHILD = 'MAI_REF_MAINTENANCE_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE_REPORTS'
       ,'MAI5024'
       ,'Print Local Frequencies and Intervals'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE_REPORTS'
                    AND  HSTF_CHILD = 'MAI5024');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE_REPORTS'
       ,'MAI5030'
       ,'Print Default Intervals and Frequencies'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE_REPORTS'
                    AND  HSTF_CHILD = 'MAI5030');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE_REPORTS'
       ,'MAI5205'
       ,'Print Activity Frequencies'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE_REPORTS'
                    AND  HSTF_CHILD = 'MAI5205');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE_REPORTS'
       ,'MAI5215'
       ,'Print Interval Codes'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE_REPORTS'
                    AND  HSTF_CHILD = 'MAI5215');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REF_MAINTENANCE_REPORTS'
       ,'MAI5225'
       ,'Print Activities'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REF_MAINTENANCE_REPORTS'
                    AND  HSTF_CHILD = 'MAI5225');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS'
       ,'MAI7040'
       ,'Parameter Based Inquiry (PBI)'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS'
                    AND  HSTF_CHILD = 'MAI7040');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS'
       ,'MAI_REPORTS_AUDIT'
       ,'Audit'
       ,'F'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS'
                    AND  HSTF_CHILD = 'MAI_REPORTS_AUDIT');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS'
       ,'MAI_REPORTS_HIST'
       ,'Historical'
       ,'F'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS'
                    AND  HSTF_CHILD = 'MAI_REPORTS_HIST');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI2501'
       ,'Inventory Interface'
       ,'M'
       ,12 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI2501');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5027'
       ,'Print Defects by Defect Type'
       ,'M'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5027');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5034A'
       ,'Print A Audit - Defects by Type, Activity and Time'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5034A');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5034B'
       ,'Print B Audit - Defects by Activity,Type and Time'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5034B');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5035A'
       ,'Print C Audit - Actions by Activity Area'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5035A');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5035B'
       ,'Print D Audit - Actions by Defect Type'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5035B');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5037'
       ,'Print E Audit - Electrical Report by Ownership'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5037');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5037A'
       ,'Print E Audit - Electrical Report by Link'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5037A');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5038'
       ,'Print T Audit - Audit Of Costs'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5038');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5060'
       ,'Print F Audit - Defect for Point and Cont. Inv Items'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5060');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5070'
       ,'Print M Audit - Analysis of Cyclic Maintenance Activities'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5070');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_AUDIT'
       ,'MAI5080'
       ,'Print I Audit - 7 and 28 day Safety Inspection Statistics'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_AUDIT'
                    AND  HSTF_CHILD = 'MAI5080');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_HIST'
       ,'MAI3992'
       ,'Road Section Historical Report'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_HIST'
                    AND  HSTF_CHILD = 'MAI3992');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_REPORTS_HIST'
       ,'MAI3994'
       ,'Road Section Historical Statistics'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_REPORTS_HIST'
                    AND  HSTF_CHILD = 'MAI3994');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI1280'
       ,'External Activities'
       ,'M'
       ,130 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI1280');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3610'
       ,'Cancel Work Orders'
       ,'M'
       ,110 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3610');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3800'
       ,'Works Orders (Defects)'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3800');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3800A'
       ,'Works Orders (Cyclic)'
       ,'M'
       ,20 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3800A');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3802'
       ,'Maintain Work Orders - Contractor Interface'
       ,'M'
       ,30 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3802');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3804'
       ,'View Cyclic Maintenance Work'
       ,'M'
       ,70 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3804');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3805'
       ,'Gang/Crew Allocation'
       ,'M'
       ,50 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3805');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3820'
       ,'Quality Inspection Results'
       ,'M'
       ,120 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3820');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3825'
       ,'Maintenance Report'
       ,'M'
       ,100 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3825');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3848'
       ,'Work Orders Authorisation'
       ,'M'
       ,60 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3848');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3860'
       ,'Cyclic Maintenance Schedules'
       ,'M'
       ,80 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3860');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI3862'
       ,'Cyclic Maintenance Schedules by Road Section'
       ,'M'
       ,90 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI3862');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS'
       ,'MAI_WORKS_REPORTS'
       ,'Reports'
       ,'F'
       ,140 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS'
                    AND  HSTF_CHILD = 'MAI_WORKS_REPORTS');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3105'
       ,'Print: Cyclic Maintenance Activities'
       ,'M'
       ,14 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3105');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3480'
       ,'Print Works Order (Priced)'
       ,'M'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3480');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3485'
       ,'Print Works Order (Unpriced)'
       ,'M'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3485');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3490'
       ,'Review Raised Works Orders'
       ,'M'
       ,12 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3490');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3500'
       ,'Print Works Orders Detail'
       ,'M'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3500');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3505'
       ,'Print Works Orders (Summary)'
       ,'M'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3505');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3906'
       ,'Print BOQ Work Order (Defects)'
       ,'M'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3906');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3907'
       ,'Print BOQ Work Order (Cyclic)'
       ,'M'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3907');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3909'
       ,'Print Works Order (NMA)'
       ,'M'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3909');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3918'
       ,'Works Orders (Enhanced Format)'
       ,'M'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3918');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3919'
       ,'Print Works Order (Enhanced)'
       ,'M'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3919');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3920'
       ,'Summary of Defects Not Yet Instructed'
       ,'M'
       ,17 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3920');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3922'
       ,'List of Defects Not Yet Instructed'
       ,'M'
       ,16 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3922');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3924'
       ,'List of Instructed Work by Status'
       ,'M'
       ,18 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3924');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3926'
       ,'List of Instructed Defects due for Completion'
       ,'M'
       ,19 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3926');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3930'
       ,'List of Inventory Updates'
       ,'M'
       ,20 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3930');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3950'
       ,'List of Work for Quality Inspection'
       ,'M'
       ,21 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3950');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3952'
       ,'Quality Inspection Performance Report'
       ,'M'
       ,22 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3952');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3956'
       ,'Admin Unit Performance Report'
       ,'M'
       ,23 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3956');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3960'
       ,'Print Cyclic Maintenance Schedules'
       ,'M'
       ,15 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3960');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI3970'
       ,'Print Gang Work Orders'
       ,'M'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI3970');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI5032'
       ,'Print Cyclic Maintenance Done'
       ,'M'
       ,13 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI5032');
--
INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
        'MAI_WORKS_REPORTS'
       ,'MAI5130'
       ,'Print Works Orders (Strip Plan)'
       ,'M'
       ,11 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                    AND  HSTF_CHILD = 'MAI5130');
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
