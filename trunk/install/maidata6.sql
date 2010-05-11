/***************************************************************************

INFO
====
As at Release 3.2.0.0

GENERATION DATE
===============
04-JAN-2005 16:21

TABLES PROCESSED
================
DOC_GATEWAYS
DOC_GATE_SYNS

TABLE OWNER
===========
MAIDATA31

MODE (A-Append R-Refresh)
========================
R

***************************************************************************/

define sccsid = '$Revision:   2.2  $'
set define off;
set feedback off;

---------------------------------
-- START OF GENERATED METADATA --
---------------------------------

--
--********** DOC_GATEWAYS **********--
--
-- Columns
-- DGT_TABLE_NAME                 NOT NULL VARCHAR2(30)
--   DGT_PK (Pos 1)
-- DGT_TABLE_DESCR                NOT NULL VARCHAR2(30)
--   DGT_UK1 (Pos 1)
-- DGT_PK_COL_NAME                NOT NULL VARCHAR2(30)
-- DGT_LOV_DESCR_LIST                      VARCHAR2(254)
-- DGT_LOV_FROM_LIST                       VARCHAR2(254)
-- DGT_LOV_JOIN_CONDITION                  VARCHAR2(254)
-- DGT_EXPAND_MODULE                       VARCHAR2(30)
-- DGT_START_DATE                          DATE
-- DGT_END_DATE                            DATE
--
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'PEOPLE';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'PEOPLE'
       ,'People'
       ,'PEO_PERSON_ID'
       ,'PEOPLE.PEO_INITIALS||'' ''||PEOPLE.PEO_NAME'
       ,'PEOPLE'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'ORG_UNITS';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'ORG_UNITS'
       ,'Organisations'
       ,'OUN_ORG_ID'
       ,'OUN_NAME'
       ,'ORG_UNITS'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'INV_ITEMS_ALL';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'INV_ITEMS_ALL'
       ,'Road Inventory Items'
       ,'IIT_ITEM_ID'
       ,'IIT_ITY_SYS_FLAG||'' ''||IIT_ITY_INV_CODE||'' ''||IIT_ST_CHAIN||'' ''||IIT_END_CHAIN||'' ''||IIT_NOTE'
       ,'INV_ITEMS_ALL'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'DEFECTS';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'DEFECTS'
       ,'Defects'
       ,'DEF_DEFECT_ID'
       ,'RSE_UNIQUE||'', ''||'||CHR(10)||'RPAD(DEF_DEFECT_CODE,4)||'', ''||'||CHR(10)||'DEF_CREATED_DATE||'', ''||'||CHR(10)||'NVL(DEF_LOCN_DESCR,''UNKNOWN'')'||CHR(10)||''
       ,'DEFECTS,ROAD_SEGMENTS_ALL'
       ,'DEFECTS.DEF_RSE_HE_ID = ROAD_SEGMENTS_ALL.RSE_HE_ID'
       ,'mai3806'
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'WORK_ORDERS';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'WORK_ORDERS'
       ,'Work Orders'
       ,'WOR_WORKS_ORDER_NO'
       ,'NVL(WOR_DESCR,''UNKNOWN'')'
       ,'WORK_ORDERS'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'SCHEMES SCH';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'SCHEMES SCH'
       ,'Structural Schemes'
       ,'SCHEME_ID'
       ,'SCHEME_NAME'
       ,'SCHEMES'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'SCHEDULES';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'SCHEDULES'
       ,'Schedules'
       ,'SCHD_ID'
       ,'SCHD_NAME'
       ,'SCHEDULES'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'CONTRACTS';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'CONTRACTS'
       ,'Contracts'
       ,'CON_ID'
       ,'RPAD(CON_CODE,11)||CON_NAME'
       ,'CONTRACTS'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'STANDARD_ITEMS';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'STANDARD_ITEMS'
       ,'Standard Items'
       ,'STA_ITEM_CODE'
       ,'STA_ITEM_NAME'
       ,'STANDARD_ITEMS'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'ACTIVITIES_REPORT';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'ACTIVITIES_REPORT'
       ,'Activities Report'
       ,'ARE_REPORT_ID'
       ,'''BATCH''||LPAD(nvl(ARE_BATCH_ID,''0''),6)||''   INSPECTION''||LPAD(ARE_REPORT_ID,8)||''   ''||ARE_INITIATION_TYPE||''   ''||ARE_DATE_WORK_DONE||''   ''||RSE_UNIQUE'
       ,'ACTIVITIES_REPORT,ROAD_SEGMENTS_ALL'
       ,'ACTIVITIES_REPORT.ARE_RSE_HE_ID = ROAD_SEGMENTS_ALL.RSE_HE_ID'
       ,''
       ,null
       ,null FROM DUAL;
--
DELETE FROM DOC_GATEWAYS
 WHERE DGT_TABLE_NAME = 'DEF_REP_TREAT';
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'DEF_REP_TREAT'
       ,'Defects Repairs Inspections'
       ,'DEF_DEFECT_ID'
       ,'DTY_DESCR1||'',''|| REP_DESCR'
       ,'DEF_REP_TREAT'
       ,''
       ,''
       ,null
       ,null FROM DUAL;
--
--
--********** DOC_GATE_SYNS **********--
--
-- Columns
-- DGS_DGT_TABLE_NAME             NOT NULL VARCHAR2(30)
--   DGS_FK_DGT (Pos 1)
--   DGS_PK (Pos 1)
-- DGS_TABLE_SYN                  NOT NULL VARCHAR2(30)
--   DGS_PK (Pos 2)
--
--
DELETE FROM DOC_GATE_SYNS
 WHERE DGS_DGT_TABLE_NAME = 'INV_ITEMS_ALL'
  AND  DGS_TABLE_SYN = 'INV_ITEMS';
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'INV_ITEMS_ALL'
       ,'INV_ITEMS' FROM DUAL;
--
DELETE FROM DOC_GATE_SYNS
 WHERE DGS_DGT_TABLE_NAME = 'DEFECTS'
  AND  DGS_TABLE_SYN = 'V_MAI3806_DEF';
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'DEFECTS'
       ,'V_MAI3806_DEF' FROM DUAL;
--
DELETE FROM DOC_GATE_SYNS
 WHERE DGS_DGT_TABLE_NAME = 'INV_ITEMS_ALL'
  AND  DGS_TABLE_SYN = 'INV_ON_ROADS';
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'INV_ITEMS_ALL'
       ,'INV_ON_ROADS' FROM DUAL;
--
DELETE FROM DOC_GATE_SYNS
 WHERE DGS_DGT_TABLE_NAME = 'DEF_REP_TREAT'
  AND  DGS_TABLE_SYN = 'DEFECTS';
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'DEF_REP_TREAT'
       ,'DEFECTS' FROM DUAL;
--
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
