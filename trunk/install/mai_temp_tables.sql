-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_temp_tables.sql-arc   2.3   Sep 27 2019 15:56:18   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_temp_tables.sql  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:56:18  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:50:30  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Graeme Johnson
--
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

--
Prompt Tables for MAI Group Edits Undo - temp tables replace 3 conventional Oracle tables
Prompt ==================================================================================
DROP TABLE TEMP_UNMERGE_DEFECTS
/
DROP TABLE TEMP_UNSPLIT_DEFECTS
/
DROP TABLE TEMP_UNREPLACE_DEFECTS
/

DROP TABLE TEMP_UNDO_DEFECT_EDIT
/
CREATE GLOBAL TEMPORARY TABLE TEMP_UNDO_DEFECT_EDIT
(
  DEF_DEFECT_ID           NUMBER(8)             NOT NULL,
  DEF_RSE_HE_ID           NUMBER(8)             NOT NULL,
  DEF_IIT_ITEM_ID         NUMBER(8),
  DEF_ST_CHAIN            NUMBER(6),
  DEF_ARE_REPORT_ID       NUMBER(8)             NOT NULL,
  DEF_ATV_ACTY_AREA_CODE  VARCHAR2(2 BYTE)      NOT NULL,
  DEF_SISS_ID             VARCHAR2(3 BYTE),
  DEF_WORKS_ORDER_NO      VARCHAR2(16 BYTE),
  DEF_CREATED_DATE        DATE                  NOT NULL,
  DEF_DEFECT_CODE         VARCHAR2(4 BYTE)      NOT NULL,
  DEF_LAST_UPDATED_DATE   DATE                  NOT NULL,
  DEF_ORIG_PRIORITY       VARCHAR2(4 BYTE)      NOT NULL,
  DEF_PRIORITY            VARCHAR2(4 BYTE)      NOT NULL,
  DEF_STATUS_CODE         VARCHAR2(10 BYTE)     NOT NULL,
  DEF_SUPERSEDED_FLAG     VARCHAR2(1 BYTE)      NOT NULL,
  DEF_AREA                NUMBER(8,1),
  DEF_ARE_ID_NOT_FOUND    NUMBER(8),
  DEF_COORD_FLAG          VARCHAR2(1 BYTE),
  DEF_DATE_COMPL          DATE,
  DEF_DATE_NOT_FOUND      DATE,
  DEF_DEFECT_CLASS        VARCHAR2(1 BYTE),
  DEF_DEFECT_DESCR        VARCHAR2(40 BYTE),
  DEF_DEFECT_TYPE_DESCR   VARCHAR2(40 BYTE),
  DEF_DIAGRAM_NO          VARCHAR2(7 BYTE),
  DEF_HEIGHT              NUMBER(6,1),
  DEF_IDENT_CODE          VARCHAR2(8 BYTE),
  DEF_ITY_INV_CODE        VARCHAR2(2 BYTE),
  DEF_ITY_SYS_FLAG        VARCHAR2(1 BYTE),
  DEF_LENGTH              NUMBER(6,1),
  DEF_LOCN_DESCR          VARCHAR2(40 BYTE),
  DEF_MAINT_WO            NUMBER(8),
  DEF_MAND_ADV            VARCHAR2(1 BYTE),
  DEF_NOTIFY_ORG_ID       NUMBER(8),
  DEF_NUMBER              NUMBER(5,1),
  DEF_PER_CENT            NUMBER(5,1),
  DEF_PER_CENT_ORIG       NUMBER(5,1),
  DEF_PER_CENT_REM        NUMBER(5,1),
  DEF_RECHAR_ORG_ID       NUMBER(8),
  DEF_SERIAL_NO           VARCHAR2(6 BYTE),
  DEF_SKID_COEFF          NUMBER(4,1),
  DEF_SPECIAL_INSTR       VARCHAR2(254 BYTE),
  DEF_SUPERSEDED_ID       NUMBER(8),
  DEF_TIME_HRS            NUMBER(2),
  DEF_TIME_MINS           NUMBER(2),
  DEF_UPDATE_INV          VARCHAR2(1 BYTE),
  DEF_X_SECT              VARCHAR2(1 BYTE),
  DEF_EASTING             NUMBER,
  DEF_NORTHING            NUMBER,
  DEF_RESPONSE_CATEGORY   VARCHAR2(4 BYTE)
)
ON COMMIT DELETE ROWS
/

