--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3130_mai3200_ddl_upg.sql-arc   2.0   Jun 13 2007 16:32:34   smarshall  $
--       Module Name      : $Workfile:   mai3130_mai3200_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:34  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.5
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

-- GJ 10-SEP-04
-- Ensure that synonyms do not exist against the following objects
-- if they do then you get 'object with that name already exists' errors
-- when performing MAI network operations
--
EXECUTE nm3ddl.drop_synonym_for_object('TEMP_REPLACE_DEFECTS');
EXECUTE nm3ddl.drop_synonym_for_object('TEMP_UNREPLACE_DEFECTS');
EXECUTE nm3ddl.drop_synonym_for_object('TEMP_UNSPLIT_DEFECTS');
EXECUTE nm3ddl.drop_synonym_for_object('TEMP_UNMERGE_DEFECTS');

-- DC 17-SEP-04
-- Drop redundant package inv_copy
DROP PACKAGE inv_copy;

-- FJF 19-Oct-04
-- Ensure nullable column remains so
BEGIN
 execute immediate('alter table contract_items modify ( CNI_RSE_HE_ID null )');
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/  


--
---------------------------------------------------------------------------------------------------
--       ****************   Replace public synonyms with views and package   *******************

Prompt Replacing some MAI public synonyms with views and package (ignore drop errors) 
Prompt ==============================================================================
drop public synonym inv_type_colours;

drop table units;

drop public synonym units;

drop public synonym higunit;

CREATE OR REPLACE FORCE VIEW inv_type_colours
AS
SELECT
 col_id,
 ity_inv_code
FROM nm_inv_type_colours;

CREATE OR REPLACE FORCE VIEW UNITS
(UN_DOMAIN_ID, UN_UNIT_ID, UN_UNIT_NAME, UN_FORMAT_MASK)
AS
SELECT un_domain_id
      ,un_unit_id
      ,un_unit_name
      ,un_format_mask
FROM   nm_units;


--
---------------------------------------------------------------------------------------------------
--                      ****************   End of replace synonyms  *******************

-- GJ 18-NOV-2004
-- Global temp tables required for undo of network edits on defects
--
Prompt Tables for MAI Group Edits Undo - temp tables replace 3 conventional Oracle tables  (ignore drop errors)
Prompt ========================================================================================================
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
  DEF_ATV_ACTY_AREA_CODE  VARCHAR2(2)      NOT NULL,
  DEF_SISS_ID             VARCHAR2(3),
  DEF_WORKS_ORDER_NO      VARCHAR2(16),
  DEF_CREATED_DATE        DATE                  NOT NULL,
  DEF_DEFECT_CODE         VARCHAR2(4)      NOT NULL,
  DEF_LAST_UPDATED_DATE   DATE                  NOT NULL,
  DEF_ORIG_PRIORITY       VARCHAR2(4)      NOT NULL,
  DEF_PRIORITY            VARCHAR2(4)      NOT NULL,
  DEF_STATUS_CODE         VARCHAR2(10)     NOT NULL,
  DEF_SUPERSEDED_FLAG     VARCHAR2(1)      NOT NULL,
  DEF_AREA                NUMBER(8,1),
  DEF_ARE_ID_NOT_FOUND    NUMBER(8),
  DEF_COORD_FLAG          VARCHAR2(1),
  DEF_DATE_COMPL          DATE,
  DEF_DATE_NOT_FOUND      DATE,
  DEF_DEFECT_CLASS        VARCHAR2(1),
  DEF_DEFECT_DESCR        VARCHAR2(40),
  DEF_DEFECT_TYPE_DESCR   VARCHAR2(40),
  DEF_DIAGRAM_NO          VARCHAR2(7),
  DEF_HEIGHT              NUMBER(6,1),
  DEF_IDENT_CODE          VARCHAR2(8),
  DEF_ITY_INV_CODE        VARCHAR2(2),
  DEF_ITY_SYS_FLAG        VARCHAR2(1),
  DEF_LENGTH              NUMBER(6,1),
  DEF_LOCN_DESCR          VARCHAR2(40),
  DEF_MAINT_WO            NUMBER(8),
  DEF_MAND_ADV            VARCHAR2(1),
  DEF_NOTIFY_ORG_ID       NUMBER(8),
  DEF_NUMBER              NUMBER(5,1),
  DEF_PER_CENT            NUMBER(5,1),
  DEF_PER_CENT_ORIG       NUMBER(5,1),
  DEF_PER_CENT_REM        NUMBER(5,1),
  DEF_RECHAR_ORG_ID       NUMBER(8),
  DEF_SERIAL_NO           VARCHAR2(6),
  DEF_SKID_COEFF          NUMBER(4,1),
  DEF_SPECIAL_INSTR       VARCHAR2(254),
  DEF_SUPERSEDED_ID       NUMBER(8),
  DEF_TIME_HRS            NUMBER(2),
  DEF_TIME_MINS           NUMBER(2),
  DEF_UPDATE_INV          VARCHAR2(1),
  DEF_X_SECT              VARCHAR2(1),
  DEF_EASTING             NUMBER,
  DEF_NORTHING            NUMBER,
  DEF_RESPONSE_CATEGORY   VARCHAR2(4)
)
ON COMMIT DELETE ROWS
/
--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

