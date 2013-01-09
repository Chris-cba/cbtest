------------------------------------------------------------------
-- mai4600_mai4610_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4600_mai4610_ddl_upg.sql-arc   1.0   Jan 09 2013 10:35:14   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4600_mai4610_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Jan 09 2013 10:35:14  $
--       Date fetched Out : $Modtime:   Jan 09 2013 10:22:08  $
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
PROMPT DDL Changes for National vs Local
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 112324
-- 
-- TASK DETAILS
-- No details supplied
-- 
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
-- end of script 
------------------------------------------------------------------

