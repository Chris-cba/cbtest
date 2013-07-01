REM Copyright 2013 Bentley Systems Incorporated. All rights reserved.
REM @(#)$Header:   //vm_latest/archives/mai/mig/mai_pre_mig_checks.sql-arc   2.1   Jul 01 2013 16:00:06   James.Wadsworth  $

set echo off
set linesize 120
set heading off
set pages 1000
set serverout on
set feedback off


WHENEVER SQLERROR CONTINUE

PROMPT
PROMPT MAI Pre-Migration Checks
PROMPT ==========================
set term off

drop table mai_temp_sequences
/
create table mai_temp_sequences
as select * from user_sequences
where 1=0
/

spool mai_pre_mig_checks.log
set term on

WHENEVER SQLERROR EXIT

DECLARE

  TYPE tab_varchar2 IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;
  l_tab_table_name     tab_varchar2;
  l_missing_tabs       tab_varchar2;
  
  FUNCTION table_exists (p_table_name IN varchar2) RETURN BOOLEAN IS
  
  CURSOR get_Tab IS
  SELECT 1
  FROM   user_tables
  WHERE  table_name = p_table_name;
    
  l_found boolean := FALSE;
  l_dummy pls_integer;
  BEGIN
    
    OPEN get_tab;
    FETCH get_tab INTO l_dummy;
    IF get_tab%FOUND THEN
      l_found := TRUE;
    END IF;
    CLOSE get_tab;
    
    RETURN l_found;
  END table_exists;
  --
  FUNCTION ukpms_licenced RETURN boolean IS
    l_found boolean := FALSE;
    l_dummy pls_integer;
    
    CURSOR ukp_licenced IS
    SELECT 1
    FROM   hig_products
    WHERE  hpr_product = 'UKP'
    AND    hpr_key IS NOT NULL;
  BEGIN
    OPEN ukp_licenced;
    FETCH ukp_licenced INTO l_dummy;
    IF ukp_licenced%FOUND THEN
      l_found := TRUE;
    END IF;
    CLOSE ukp_licenced;
    
    RETURN l_found;
  END ukpms_licenced;
  --
BEGIN
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ACTIVITIES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ACTIVITIES_REPORT';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ACTIVITY_GROUPS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ACT_FREQS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ACT_GROUP_MEMBS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ACT_REPORT_LINES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'AUTO_DEFECT_SELECTION_PRIORITY';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'BOQ_ITEMS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'BPR34A_TT';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'BPR34B_TT';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'BPR35A_TT';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'BPR35B_TT';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'BUDGETS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'CLAIM_PAYMENTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'COLOUR_LAYER_MAP';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'CONTRACTOR_DISC_BANDS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'CONTRACTOR_DISC_GROUPS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'CONTRACTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'CONTRACT_ITEMS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'CONTRACT_PAYMENTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'CONTRACT_SURCHARGES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'COST_CENTRES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DEFAULT_TREATS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DEFECT_PRIORITIES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DEF_MOVEMENTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DEF_TREATS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DEF_TYPES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DELETED_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DEL_INV_ITEMS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DOC_DEF_PRIORITIES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'DOC_DEF_TREATS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'EXT_ACTIVITIES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'EXT_ACT_ROAD_USAGE';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_HOLD_1';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_ITEM_ERR_1';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_ITEM_ERR_2';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_ITEM_ERR_3';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_LOAD_1';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_LOAD_2';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_LOAD_3';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_ODL_LOG';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_RUN_LOG';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HHINV_SECT_LOG';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HH_LOAD_BATCHES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'HH_LOAD_RECS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'IFF_SECT_STACK';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'IHMS_ALLOCATED_AMTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'IHMS_CONVERSIONS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INSURANCE_CLAIM_ACTIVITIES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INSURANCE_CLAIM_PARAMETERS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_BOQ';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_CLAIMS_BOQ_ALL';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_CLAIMS_WOL_ALL';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_CLAIMS_WOR_ALL';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_COMPLETIONS_ALL';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_ERRONEOUS_RECORDS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_HEADERS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_RUN_LOG';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_WOL';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INTERFACE_WOR';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INV_ITEM_TYPES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INV_MP_ERRORS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'INV_TMP';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ITEM_CODE_BREAKDOWNS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'JOB_SIZES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'LAMP_CONFIGS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'LOAD_ERRORS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'LOCAL_FREQS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'MAI2325_QUERY';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'MAI2325_RESULTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'MAI3890_DOCTMP';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'MAI3890_INVTMP';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'MAI3890_WKTMP';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'NAVIGATOR';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'NL_AREA_USAGES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'NOTICES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'NOTICE_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'ORG_UNITS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'PBI_QUERY';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'PBI_QUERY_ATTRIBS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'PBI_QUERY_TYPES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'PBI_RESULTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'PBI_RESULTS_INV';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'PEOPLE';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'QUERYTAB$$$';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'RELATED_INVENTORY';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'RELATED_MAINTENANCE';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'REPAIRS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEDULES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEDULE_ITEMS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEDULE_ROADS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEMES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEME_ACTIVITIES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEME_ASSESSMENTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEME_CONTRACTORS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEME_HISTORY';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SCHEME_ROADS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SECTION_FREQS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SECT_FREQ1';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'SECT_FREQ2';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'STANDARD_ITEMS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'STANDARD_ITEM_SECTIONS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'STANDARD_ITEM_SUB_SECTIONS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_2140';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_ACT_LINES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_BPR3100_ARE';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_BPR3100_ARL';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_CONTRACTS_LOCK';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_LOAD_2';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_COMMENTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_COMPSCHEMES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_DEFBANDS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_DEFECT_LIST';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_DETTRTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_REPORT_SECTIONS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_ROADCONS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_STRIP_DATA';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_STRIP_HEADER';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_PMS4440_STRIP_LIST';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_REPLACE_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_SPLIT_LINES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_UNMERGE_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_UNREPLACE_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TEMP_UNSPLIT_DEFECTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TMP_BPR2140';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TREATMENTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TREATMENT_MODELS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'TREATMENT_MODEL_ITEMS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'VALID_FOR_MAINTENANCE';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'VAT_RATES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'WOL_INTERIM_PAYMENTS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'WORK_ORDERS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'WORK_ORDER_CLAIMS';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'WORK_ORDER_LINES';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'WO_AUDIT';
  l_tab_table_name(l_tab_table_name.COUNT+1) := 'WO_AUDIT_COLUMNS';
--
-- UKP tables required in MAI will be recreated, not imported
--   
  
 
--
-----------
--
  IF ukpms_licenced THEN
    -- only check for these RP4.02 tables if UKPMS is licenced
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PASS_ROAD_RUN_TIME_DETS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_AUTOMATIC_PASS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_VIEW_DEFINITIONS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_XSP_REVERSAL';

    l_tab_table_name(l_tab_table_name.COUNT+1) := 'TMP_UKP0015_RSE_MEMBS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'TMP_UKP0095';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKP03_SUMMARY_REPORT_WHERE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ACCIDENTS_AT_WORKS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_AGE_WEIGHTING';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ANALYSIS_PERIOD';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ATTR_IN_PROJECT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_AUTOMATIC_PASS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_BASIC_DEFECT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_BUDGET';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_BUDGET_HEAD';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_BUDGET_HEAD_INSTANCE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_BUDGET_HEAD_RULE_LINE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_BUDGET_INSTANCE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_BUDGET_REPORT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CHOP_ATTRIBS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CI_PAVET_FOR_FEATURE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CLOSURE_DUE_TO_WORKS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CLOSURE_TYPE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CONDITION_INDEX';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CONDITION_INDEX_REPORT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CONSEQUENT_COST_PER';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CONSTRUCTION_TYPE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_COST_OF_ACCIDENTS_WORKS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_CROSS_SECTIONAL_POSITION';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFAULT_FEATURE_WIDTHS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECTIVENESS_CALC';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECTS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_BASE_DATE_GROUP';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_CALC_ATTS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_CALC_STEPS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_CATEGORY';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_COMPOSITION';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_LENGTHS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_LENGTH_CI';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_LENGTH_FUNCTIONAL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_LENGTH_TREATMENTS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_PARAMETER';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_PARAM_OPT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEFECT_TRANSFORMATION';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DEF_LEN_SUMMARY_EXTRACT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DELAY_DUE_TO_WORKS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DIVERSION_QUALITY';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DRAINAGE_STATUS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_DURATION_OF_WORKS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_EFFECT_OF_TREATMENT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ESTIM_TREAT_UNIT_COST';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_FEATURE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_FEATURE_ATTRIBUTE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_FEATURE_ATTRIBUTE_OPT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_FEATURE_CI_PAVEMENT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_FEATURE_HIERARCHY';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_FOOTWAY_STATUS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_FW_OPENING_FREQUENCY';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_GENERIC_TREATMENT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_INTERVENTION_LVL_HIER';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_LOCAL_WEIGHTING';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_METHOD_1_RATING_COORD';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_METHOD_2_RATING_LOOKUP';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_NET_SEL_MERGE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_NON_PRIN_PI_UDLS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_OVERALL_CI_CALC';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_OVERALL_CI_CALC_DETAIL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PASS_AUDIT_ENTRIES';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PASS_BUDGET_INSTANCE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PASS_ROAD_RUN_TIME_DETS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PASS_SURVEY_TYPES';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PAVEMENT_TYPE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PAVEMENT_TYPE_FOR_CONS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PAVEMENT_TYPE_TREAT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PROJECTION_CURVE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PROJECTION_CURVE_POINT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PROJECTION_PARAMETERS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_PROJECTION_RELATIONSHIP';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_RANKING_CURVE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_RATING_CI_CALC_DETAIL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_RATING_DEFECTS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_RATING_LENGTH_CI_CALC';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_RMMS_UKPMS_MAPPING';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ROAD_TYPE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ROAD_TYPE_XSP';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ROUTINE_MAINT_COST';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_RULE_LINE_TREATMENT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_RULE_SET';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_SECT_LABEL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_SURVEY';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_SURVEY_TYPE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_T1_SURVEY_TYPES';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TEMP_RATING_CI_CALC';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TEMP_VAR_CI_LENGTHS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TRAFFIC_LEVEL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREATMENT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREATMENT_COMPOSITION';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREATMENT_FUNCTIONAL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREATMENT_TYPE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREAT_COMP_SISS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREAT_SEL_INTVENT_LVL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREAT_SEL_RULE_CELL';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_TREAT_SEL_RULE_LINE';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_UKP0018_TEMP';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_VALID_DEFECT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_VALID_DEFECT_PARAMETER';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_VALID_DEFECT_PARAM_OPT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_VALUE_OF_TIME';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_VEHICULAR_TRAFFIC';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_VIEW_DEFINITIONS';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_XSP_FEATURES';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_XSP_MAPPING';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_XSP_REVERSAL';
  
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_ROAD_HIERARCHY';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_SPEED_LIMIT';
    l_tab_table_name(l_tab_table_name.COUNT+1) := 'UKPMS_SURFACE_TYPE';
  END IF;
  
  FOR i IN 1..l_tab_table_name.COUNT LOOP
   
    IF NOT table_exists(l_tab_table_name(i)) THEN
      l_missing_tabs(l_missing_tabs.COUNT+1) := l_tab_table_name(i);
    END IF;		
               
  END LOOP;
   
  IF l_missing_tabs.COUNT > 0 THEN
    RAISE_APPLICATION_ERROR(-20000, 'Migration Aborted');
  ELSE
    dbms_output.put_line('Pre-migration checks complete.');
     
    dbms_output.put_line('Storing sequence numbers');
     
    insert into mai_temp_sequences (
    select * from user_sequences
    WHERE SEQUENCE_NAME IN (
                        'ARE_BATCH_ID_SEQ'
                       ,'ARE_REPORT_ID_SEQ'
                       ,'BOQ_ID_SEQ'
                       ,'BUD_ID_SEQ'
                       ,'CNP_ID_SEQ'
                       ,'CON_ID_SEQ'
                       ,'DEF_DEFECT_ID_SEQ'
                       ,'EXT_ID_SEQ'
                       ,'FILE_ID_SEQ'
                       ,'ICB_ID_SEQ'
                       ,'IIT_ITEM_ID_SEQ'
                       ,'IH_ID_SEQ'
                       ,'INSURANCE_CLAIM_ID'
                       ,'IWOR_ID_SEQ'
                       ,'NEG_BOQ_ID_SEQ'
                       ,'NEXT_SEQ'
                       ,'NOT_ID_SEQ'
                       ,'OUN_ORG_ID_SEQ'
                       ,'PBI_ID'
                       ,'PBR_ID'
                       ,'PEO_PERSON_ID_SEQ'
                       ,'SCHD_ID_SEQ'
                       ,'SCHEME_ID_SEQ'
                       ,'SCH_RD_SEQ'
                       ,'TMO_ID_SEQ'
                       ,'WOC_REF_SEQ'
                       ,'WOL_CHECK_ID_SEQ'
                       ,'WOL_ID_SEQ'));
  END IF;
   
  COMMIT;
EXCEPTION 
  WHEN OTHERS THEN
    
    dbms_output.put_line('Error: The following tables are missing, please contact EXOR support.');
     
    FOR i IN 1..l_missing_tabs.COUNT LOOP
      dbms_output.put_line(l_missing_tabs(i));
    END LOOP;
    
    RAISE;
END;      
/

prompt
prompt Table Contents
prompt ==============

select sequence_name
      ,last_number 
from mai_temp_sequences;

prompt
Prompt Done: Please check mai_pre_mig_checks.log
spool off

