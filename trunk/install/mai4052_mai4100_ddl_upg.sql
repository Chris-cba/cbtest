------------------------------------------------------------------
-- mai4052_mai4100_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4052_mai4100_ddl_upg.sql-arc   1.0   Jun 15 2009 21:02:04   mhuitson  $
--       Module Name      : $Workfile:   mai4052_mai4100_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Jun 15 2009 21:02:04  $
--       Date fetched Out : $Modtime:   Jun 15 2009 20:57:02  $
--       Version          : $Revision:   1.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2009

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Add 3 extra Cost Code columns to the Budgets table.
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Add extra Cost Code Columns To BUDGETS.
-- 
------------------------------------------------------------------
ALTER TABLE budgets
  ADD (bud_con_cost_code  VARCHAR2(60)
      ,bud_fin_cost_code  VARCHAR2(60)
      ,bud_add_cost_code  VARCHAR2(60))
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT NE_ID and RSE_DESCR changes
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (KIERAN DAWSON)
-- log 716904 & log 719542 DDL changes to update HE_ID max length from 8 to 9 and RSE_DESCR from 80 to 240
-- 
------------------------------------------------------------------
ALTER TABLE IFF_SECT_STACK
MODIFY(ISS_RSE_HE_ID NUMBER(9));

ALTER TABLE PBI_RESULTS_INV
MODIFY(PBI_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_DEFBANDS
MODIFY(BANDS_RSE_HE_ID NUMBER(9));

ALTER TABLE LOCAL_FREQS
MODIFY(LFR_RSE_HE_ID NUMBER(9));

ALTER TABLE SCHEDULE_ROADS
MODIFY(SCHR_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_REPORT_SECTIONS
MODIFY(REP_RSE_HE_ID NUMBER(9));

ALTER TABLE PBI_RESULTS
MODIFY(PBI_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_COMMENTS
MODIFY(COMM_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_COMPSCHEMES
MODIFY(CS_RSE_HE_ID NUMBER(9));

ALTER TABLE DEL_INV_ITEMS
MODIFY(DEL_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_REPLACE_DEFECTS
MODIFY(DEF_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_ROADCONS
MODIFY(CONST_RSE_HE_ID NUMBER(9));

ALTER TABLE WORK_ORDERS
MODIFY(WOR_RSE_HE_ID_GROUP NUMBER(9));

ALTER TABLE WORK_ORDERS
MODIFY(WOR_RSE_HE_ID_LINK NUMBER(9));

ALTER TABLE MAI2325_RESULTS
MODIFY(MAI2325_RSE_HE_ID NUMBER(9));

ALTER TABLE SCHEDULES
MODIFY(SCHD_RSE_HE_ID NUMBER(9));

ALTER TABLE DELETED_DEFECTS
MODIFY(DLD_RSE_HE_ID NUMBER(9));

ALTER TABLE ACTIVITIES_REPORT
MODIFY(ARE_RSE_HE_ID NUMBER(9));

ALTER TABLE EXT_ACT_ROAD_USAGE
MODIFY(EXU_RSE_HE_ID NUMBER(9));

ALTER TABLE WORK_ORDER_LINES
MODIFY(WOL_RSE_HE_ID NUMBER(9));

ALTER TABLE SCHEME_ROADS
MODIFY(RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_UNDO_DEFECT_EDIT
MODIFY(DEF_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_STRIP_DATA
MODIFY(RSE_HE_ID NUMBER(9));

ALTER TABLE BUDGETS
MODIFY(BUD_RSE_HE_ID NUMBER(9));

ALTER TABLE REPAIRS
MODIFY(REP_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_STRIP_HEADER
MODIFY(RSE_HE_ID NUMBER(9));

ALTER TABLE SECT_FREQ1
MODIFY(TT1_RSE_HE_ID NUMBER(9));

ALTER TABLE IHMS_ALLOCATED_AMTS
MODIFY(IHA_RSE_HE_ID NUMBER(9));

ALTER TABLE CONTRACT_ITEMS
MODIFY(CNI_RSE_HE_ID NUMBER(9));

ALTER TABLE SECT_FREQ2
MODIFY(TT2_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_STRIP_LIST
MODIFY(RSE_HE_ID NUMBER(9));

ALTER TABLE DEFECTS
MODIFY(DEF_RSE_HE_ID NUMBER(9));

ALTER TABLE SECTION_FREQS
MODIFY(SFR_RSE_HE_ID NUMBER(9));

ALTER TABLE INSURANCE_CLAIM_PARAMETERS
MODIFY(ICP_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_DETTRTS
MODIFY(DETTRTS_RSE_HE_ID NUMBER(9));

ALTER TABLE TEMP_PMS4440_DEFECTS
MODIFY(DEFECT_RSE_HE_ID NUMBER(9));

ALTER TABLE INV_MP_ERRORS
MODIFY(IME_RSE_HE_ID NUMBER(9));

ALTER TABLE NL_AREA_USAGES
MODIFY(NLU_RSE_HE_ID_IN NUMBER(9));

ALTER TABLE NL_AREA_USAGES
MODIFY(NLU_RSE_HE_ID_OF NUMBER(9));

ALTER TABLE PBI_QUERY
MODIFY(QRY_RSM_RSE_HE_ID NUMBER(9));

ALTER TABLE PBI_QUERY
MODIFY(QRY_RSE_HE_ID NUMBER(9));

ALTER TABLE HHINV_ITEM_ERR_2
MODIFY(HE_ID NUMBER(9));

ALTER TABLE HHINV_ITEM_ERR_3
MODIFY(HE_ID NUMBER(9));

ALTER TABLE TEMP_LOAD_2
MODIFY(HE_ID NUMBER(9));

ALTER TABLE HHINV_LOAD_2
MODIFY(HE_ID NUMBER(9));

ALTER TABLE HHINV_LOAD_3
MODIFY(HE_ID NUMBER(9));

ALTER TABLE SCHEDULE_ROADS
MODIFY(SCHR_IIT_ITEM_ID NUMBER(9));

ALTER TABLE DEL_INV_ITEMS
MODIFY(DEL_IIT_ITEM_ID NUMBER(9));

ALTER TABLE TEMP_REPLACE_DEFECTS
MODIFY(DEF_IIT_ITEM_ID NUMBER(9));

ALTER TABLE WORK_ORDER_LINES
MODIFY(WOL_IIT_ITEM_ID NUMBER(9));

ALTER TABLE TEMP_UNDO_DEFECT_EDIT
MODIFY(DEF_IIT_ITEM_ID NUMBER(9));

ALTER TABLE DEFECTS
MODIFY(DEF_IIT_ITEM_ID NUMBER(9));

ALTER TABLE IFF_SECT_STACK
MODIFY(ISS_RSE_DESCR VARCHAR2(240));
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Add Location Column to work_order_lines
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Add Location Column to work_order_lines.
-- 
------------------------------------------------------------------
ALTER TABLE work_order_lines
  ADD (wol_locn_descr  VARCHAR2(120))
/

------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

