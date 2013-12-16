------------------------------------------------------------------
-- mai4520_mai4700_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4520_mai4700_ddl_upg.sql-arc   1.0   Dec 16 2013 08:46:18   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4520_mai4700_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Dec 16 2013 08:46:18  $
--       Date fetched Out : $Modtime:   Oct 24 2013 10:03:02  $
--       Version          : $Revision:   1.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2013

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT DDL for the XSP change
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- DDL for the XSP change
-- 
------------------------------------------------------------------
DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Defects Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Del_Inv_Items Modify Del_Iit_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Deleted_Defects Modify Dld_Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Interface_Wol Modify Iwol_Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Inv_Mp_Errors Modify Ime_Xsp Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Inv_Tmp Modify Iit_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Mai_Insp_Load_Error_Def Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Temp_Pms4440_Roadcons Modify Const_Iit_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Temp_Replace_Defects Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Temp_Undo_Defect_Edit Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT DDL Changes for National vs Local
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Addition of Admin Unit to DEFECT_PRIORITIES, DOC_DEF_PRIORITIES and AUTO_DEFECT_SELECTION_PRIORITY
-- 
------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Admin Unit column to DEFECT_PRIORITIES
SET TERM OFF

DECLARE
  --
  already_exists EXCEPTION;
  PRAGMA exception_init( already_exists,-01430); 
  --
  lv_top_admin_unit hig_admin_units.hau_admin_unit%TYPE;
  --
  PROCEDURE get_top_admin_unit
    IS
  BEGIN
    SELECT hau_admin_unit
      INTO lv_top_admin_unit
      FROM hig_admin_units
     WHERE hau_level = 1
         ;
  EXCEPTION
    WHEN no_data_found
     THEN
        raise_application_error(-20001,'Cannot find the top admin unit.');
    WHEN others
     THEN RAISE;
  END;
BEGIN
  /*
  ||Add the Admin Unit Column.
  */
  EXECUTE IMMEDIATE('ALTER TABLE defect_priorities ADD(dpr_admin_unit NUMBER(9))');
  /*
  ||Populate existing rows with the top Admin Unit;
  */
  get_top_admin_unit;
  --
  EXECUTE IMMEDIATE('UPDATE defect_priorities SET dpr_admin_unit = :lv_top_admin_unit') USING lv_top_admin_unit;
  /*
  ||Make the column NOT NULL.
  */
  EXECUTE IMMEDIATE('ALTER TABLE defect_priorities MODIFY(dpr_admin_unit NOT NULL)');
  /*
  ||Rebuild the Unique Index.
  */
  EXECUTE IMMEDIATE('DROP INDEX DPR_INDEX_P1');
  EXECUTE IMMEDIATE('CREATE UNIQUE INDEX DPR_INDEX_P1 ON DEFECT_PRIORITIES(dpr_admin_unit, dpr_atv_acty_area_code, dpr_priority, dpr_action_cat)');
  /*
  ||Create FK for Admin Unit.
  */
  EXECUTE IMMEDIATE('CREATE INDEX dpr_fk_nau_ind ON defect_priorities (dpr_admin_unit)');
  EXECUTE IMMEDIATE('ALTER TABLE defect_priorities ADD (CONSTRAINT dpr_fk_nau FOREIGN KEY (dpr_admin_unit) REFERENCES nm_admin_units_all (nau_admin_unit))');
END;
/

------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Admin Unit column to DOC_DEF_PRIORITIES
SET TERM OFF

DECLARE
  --
  already_exists EXCEPTION;
  PRAGMA exception_init( already_exists,-01430); 
  --
  lv_top_admin_unit hig_admin_units.hau_admin_unit%TYPE;
  --
  PROCEDURE get_top_admin_unit
    IS
  BEGIN
    SELECT hau_admin_unit
      INTO lv_top_admin_unit
      FROM hig_admin_units
     WHERE hau_level = 1
         ;
  EXCEPTION
    WHEN no_data_found
     THEN
        raise_application_error(-20001,'Cannot find the top admin unit.');
    WHEN others
     THEN RAISE;
  END;
BEGIN
  /*
  ||Add the Admin Unit Column.
  */
  EXECUTE IMMEDIATE('ALTER TABLE doc_def_priorities ADD(ddp_dpr_admin_unit NUMBER(9))');
  /*
  ||Populate existing rows with the top Admin Unit;
  */
  get_top_admin_unit;
  --
  EXECUTE IMMEDIATE('UPDATE doc_def_priorities SET ddp_dpr_admin_unit = :lv_top_admin_unit') USING lv_top_admin_unit;
  /*
  ||Make the column NOT NULL.
  */
  EXECUTE IMMEDIATE('ALTER TABLE doc_def_priorities MODIFY(ddp_dpr_admin_unit NOT NULL)');
  /*
  ||Rebuild the Unique Index.
  */
  EXECUTE IMMEDIATE('DROP INDEX DDP_INDEX_P1');
  EXECUTE IMMEDIATE('CREATE UNIQUE INDEX DDP_INDEX_P1 ON doc_def_priorities (ddp_dpr_admin_unit, ddp_dpr_acty_area_code, ddp_dpr_priority, ddp_dpr_action_cat, ddp_doc_compl_cpr_id)');
  /*
  ||Create FK for Admin Unit.
  */
  EXECUTE IMMEDIATE('CREATE INDEX ddp_fk_nau_ind ON doc_def_priorities (ddp_dpr_admin_unit)');
  EXECUTE IMMEDIATE('ALTER TABLE doc_def_priorities ADD (CONSTRAINT ddp_fk_nau FOREIGN KEY (ddp_dpr_admin_unit) REFERENCES nm_admin_units_all (nau_admin_unit))');
END;
/

------------------------------------------------------------------
SET TERM ON
PROMPT Addition of Admin Unit column to AUTO_DEFECT_SELECTION_PRIORITY
SET TERM OFF
DECLARE
  --
  already_exists EXCEPTION;
  PRAGMA exception_init( already_exists,-01430); 
  --
  lv_top_admin_unit hig_admin_units.hau_admin_unit%TYPE;
  --
  PROCEDURE get_top_admin_unit
    IS
  BEGIN
    SELECT hau_admin_unit
      INTO lv_top_admin_unit
      FROM hig_admin_units
     WHERE hau_level = 1
         ;
  EXCEPTION
    WHEN no_data_found
     THEN
        raise_application_error(-20001,'Cannot find the top admin unit.');
    WHEN others
     THEN RAISE;
  END;
BEGIN
  /*
  ||Add the Admin Unit Column.
  */
  EXECUTE IMMEDIATE('ALTER TABLE auto_defect_selection_priority ADD(adsp_admin_unit NUMBER(9))');
  /*
  ||Populate existing rows with the top Admin Unit;
  */
  get_top_admin_unit;
  --
  EXECUTE IMMEDIATE('UPDATE auto_defect_selection_priority SET adsp_admin_unit = :lv_top_admin_unit') USING lv_top_admin_unit;
  /*
  ||Make the column NOT NULL.
  */
  EXECUTE IMMEDIATE('ALTER TABLE auto_defect_selection_priority MODIFY(adsp_admin_unit NOT NULL)');
  /*
  ||Rebuild the Unique Index.
  */
  EXECUTE IMMEDIATE('DROP INDEX adsp_unique_ind');
  EXECUTE IMMEDIATE('CREATE UNIQUE INDEX adsp_unique_ind ON auto_defect_selection_priority (adsp_admin_unit, adsp_atv_acty_area_code, adsp_defect_code, adsp_flex_attrib, adsp_cntrl_value)');
  /*
  ||Create FK for Admin Unit.
  */
  EXECUTE IMMEDIATE('CREATE INDEX adsp_fk_nau_ind ON auto_defect_selection_priority (adsp_admin_unit)');
  EXECUTE IMMEDIATE('ALTER TABLE auto_defect_selection_priority ADD (CONSTRAINT adsp_fk_nau FOREIGN KEY (adsp_admin_unit) REFERENCES nm_admin_units_all (nau_admin_unit))');
END;
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT INV_TYPE_TRANSLATION changes for UKP
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Additional columns added for inventory loader
-- 
------------------------------------------------------------------
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS76 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS77 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS78 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS79 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS80 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS81 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS82 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS83 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS84 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS85 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS86 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS87 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS88 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS89 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS90 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS91 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS92 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS93 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS94 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS95 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS96 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS97 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS98 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS99 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS100 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS101 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS102 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS103 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS104 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS105 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS106 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS107 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS108 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS109 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS110 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS111 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS112 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS113 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS114 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS115 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS116 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS117 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS118 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS119 VARCHAR2(32);
--
ALTER TABLE INV_TYPE_TRANSLATIONS ADD ITY_HHPOS120 VARCHAR2(32);
--
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

