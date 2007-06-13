--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3200_mai3210_ddl_upg.sql-arc   2.0   Jun 13 2007 16:32:36   smarshall  $
--       Module Name      : $Workfile:   mai3200_mai3210_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:36  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.4
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2004
-----------------------------------------------------------------------------
--
--
--
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
--
Prompt Creating table TT_MAI5060
Prompt =========================
CREATE TABLE tt_mai5060
(
 area_code VARCHAR2(2),
 inv_code  VARCHAR2(2),
 inv_pc    VARCHAR2(1),
 no_pt_defects  NUMBER,
 no_inv_items  NUMBER,
 length_inv NUMBER
);

--------------------------------------------------------------------------------------------------------
--Maintenance Manager change for Colin - Increased field from 55 to 254
--------------------------------------------------------------------------------------------------------
ALTER TABLE ITEM_CODE_BREAKDOWNS
MODIFY (ICB_WORK_CATEGORY_NAME VARCHAR2 (254));

--------------------------------------------------------------------------------------
--MAI_BUDGET_ALLOCATIONS
--------------------------------------------------------------------------------------
Prompt
Prompt Creating table MAI_BUDGET_ALLOCATIONS
Prompt =====================================
CREATE TABLE MAI_BUDGET_ALLOCATIONS
 (MBA_NIT_INV_TYPE  VARCHAR2(4)     NOT NULL
 ,MBA_NE_ID         NUMBER(9)       NOT NULL
 ,MBA_CRITERIA      VARCHAR2(4000)  NOT NULL)
/

COMMENT ON TABLE MAI_BUDGET_ALLOCATIONS IS 'Table To Map Asset Types To Default Elements Created Within The Required Budget Group.'
/

ALTER TABLE MAI_BUDGET_ALLOCATIONS
 ADD (CONSTRAINT MBA_PK PRIMARY KEY
  (MBA_NIT_INV_TYPE
  ,MBA_NE_ID))
/

ALTER TABLE MAI_BUDGET_ALLOCATIONS
 ADD (CONSTRAINT MBA_NIT_FK FOREIGN KEY
  (MBA_NIT_INV_TYPE) REFERENCES NM_INV_TYPES_ALL
  (NIT_INV_TYPE))
/

ALTER TABLE MAI_BUDGET_ALLOCATIONS
 ADD (CONSTRAINT MBA_NE_FK FOREIGN KEY
  (MBA_NE_ID) REFERENCES NM_ELEMENTS_ALL
  (NE_ID))
/

--------------------------------------------------------------------------------------
--MAI_INV_ACTIVITIES
--------------------------------------------------------------------------------------
Prompt
Prompt Creating table MAI_INV_ACTIVITIES
Prompt =================================
CREATE TABLE MAI_INV_ACTIVITIES
 (MIA_NIT_INV_TYPE        VARCHAR2(4)  NOT NULL
 ,MIA_SYS_FLAG            VARCHAR2(1)  NOT NULL
 ,MIA_ATV_ACTY_AREA_CODE  VARCHAR2(2)  NOT NULL)
/

COMMENT ON TABLE MAI_INV_ACTIVITIES IS 'Table To Define Valid Activity Codes For A Given Asset Type And Sys Flag.'
/

ALTER TABLE MAI_INV_ACTIVITIES
 ADD (CONSTRAINT MIA_PK PRIMARY KEY
  (MIA_NIT_INV_TYPE
  ,MIA_SYS_FLAG
  ,MIA_ATV_ACTY_AREA_CODE))
/

ALTER TABLE MAI_INV_ACTIVITIES
 ADD (CONSTRAINT MIA_NIT_FK FOREIGN KEY
  (MIA_NIT_INV_TYPE) REFERENCES NM_INV_TYPES_ALL
  (NIT_INV_TYPE))
/

ALTER TABLE ACTIVITIES
 ADD (CONSTRAINT ATV_PK PRIMARY KEY
  (ATV_ACTY_AREA_CODE,ATV_DTP_FLAG))
/

ALTER TABLE MAI_INV_ACTIVITIES
 ADD (CONSTRAINT MIA_ATV_FK FOREIGN KEY
  (MIA_ATV_ACTY_AREA_CODE,MIA_SYS_FLAG) REFERENCES ACTIVITIES
  (ATV_ACTY_AREA_CODE,ATV_DTP_FLAG))
/

--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

