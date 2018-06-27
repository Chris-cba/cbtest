CREATE OR REPLACE PACKAGE BODY mairepl
AS
  --
  -----------------------------------------------------------------------------
  --   PVCS Identifiers :-
  --
  --       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mairepl.pkb-arc   2.4   Jun 27 2018 13:06:38   Gaurav.Gaurkar  $
  --       Module Name      : $Workfile:   mairepl.pkb  $
  --       Date into SCCS   : $Date:   Jun 27 2018 13:06:38  $
  --       Date fetched Out : $Modtime:   Jun 27 2018 10:54:14  $
  --       SCCS Version     : $Revision:   2.4  $
  --       Based onSCCS Version     : 1.2
  --
  -- This package contains procedures and functions which are required by
  -- the Replace / UnReplace processes within Network Manager.
  -- Maintenance Manager specific functionality can be found here, whilst
  -- product specific functionality can be found in separate packages.
  -- eg Structures specific logic can be found in STRREPL.PCK .
  -- Originally taken from '@(#)mairepl.pck 1.13 01/11/02';
  -----------------------------------------------------------------------------
  --   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
  -----------------------------------------------------------------------------
  --
  g_body_sccsid  CONSTANT  VARCHAR2(2000) := '"$Revision:   2.4  $"';
  -- g_body_sccsid is the SCCS ID for the package body
  --
  g_package_name  CONSTANT  VARCHAR2(30)   := 'mairepl';
  --
  l_rmmsflag  VARCHAR2(1) := hig.get_sysopt('RMMSFLAG');
  l_message   VARCHAR2(80);
  --
  -----------------------------------------------------------------------------
  --
  FUNCTION get_version
    RETURN varchar2 IS
  BEGIN
    RETURN g_sccsid;
  END get_version;

  --
  -----------------------------------------------------------------------------
  --
  FUNCTION get_body_version
    RETURN varchar2 IS
  BEGIN
    RETURN g_body_sccsid;
  END get_body_version;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE check_data(p_rse_he_id_1    IN NUMBER    -- section to replace
                      ,p_rse_he_id_2    IN NUMBER    -- link to replace into
                      ,p_sect_no        IN VARCHAR2  -- new section to replace into
                      ,p_effective_date IN DATE      -- effective date of replace
                      ,p_errors         IN OUT NUMBER
                      ,p_error_string   IN OUT VARCHAR2)
    IS
    --
    -- Checks that the user has supplied valid parameters.
    --
  BEGIN
    --
    maisplit.check_data(p_rse_he_id_1
                       ,NULL
                       ,p_effective_date
                       ,p_errors
                       ,p_error_string);
    --
  END check_data;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE replace_data(p_rse_he_id_new  IN NUMBER  -- new section
                        ,p_rse_he_id      IN NUMBER  -- section replaced
                        ,p_effective_date IN DATE)   -- effective date of replace
    IS
    --
    l_are_report_id  NUMBER;
    l_def_defect_id  NUMBER;
    l_table_name     VARCHAR2(32);
    l_actioned_date  VARCHAR2(22) := TO_CHAR(SYSDATE,'DD-MON-YYYY,HH24:MI:SS');
    l_actioned       DATE := TO_DATE(l_actioned_date,'DD-MON-YYYY,HH24:MI:SS');
    l_rse_length_1   NUMBER;
    l_rse_sys_flag   VARCHAR2(1);
    --
    CURSOR c1
        IS
    SELECT rse_length, rse_sys_flag
      FROM road_sections
     WHERE rse_he_id = p_rse_he_id
         ;
    --
    CURSOR c2
        IS
    SELECT are_report_id_seq.NEXTVAL
      FROM dual
         ;
    --
    CURSOR c3
        IS
    SELECT def_defect_id_seq.NEXTVAL
      FROM dual
         ;
    --
    CURSOR c_open_insp
        IS
    SELECT are_report_id
          ,are_st_chain
          ,are_end_chain
      FROM activities_report
     WHERE are_report_id IN(SELECT def_are_report_id
                              FROM defects
                                  ,repairs
                             WHERE NOT EXISTS(SELECT 'x'
                                                FROM work_order_lines
                                               WHERE wol_def_defect_id = rep_def_defect_id
                                                 AND wol_rep_action_cat = rep_action_cat)
                               AND rep_date_completed IS NULL
                               AND rep_def_defect_id = def_defect_id
                               AND def_superseded_flag = 'N'
                               AND def_rse_he_id = p_rse_he_id)
         ;
    --
    CURSOR c_defects(l_insp NUMBER)
        IS
    SELECT def_defect_id
          ,NVL(def_st_chain,0) def_st_chain
      FROM defects
     WHERE def_defect_id IN(SELECT rep_def_defect_id
                              FROM repairs
                             WHERE rep_date_completed IS NULL
                               AND NOT EXISTS(SELECT 'x'
                                                FROM work_order_lines
                                               WHERE wol_def_defect_id = rep_def_defect_id
                                                 AND wol_rep_action_cat = rep_action_cat))
       AND def_superseded_flag = 'N'
       AND def_are_report_id = l_insp
         ;
    --
  BEGIN
    --
    OPEN  c1;
    FETCH c1
     INTO l_rse_length_1
         ,l_rse_sys_flag;
    CLOSE c1;
    /*
    ||ACTIVITY REPORTS, DEFECTS, REPAIRS
    */
    FOR i IN c_open_insp LOOP
      --
      OPEN  c2;
      FETCH c2
       INTO l_are_report_id;
      CLOSE c2;
      --
      maisplit.create_new_insp(i.are_report_id
                              ,l_are_report_id
                              ,p_rse_he_id_new
                              ,i.are_st_chain
                              ,i.are_end_chain
                              ,p_effective_date);
      --
      FOR j IN c_defects(i.are_report_id) loop
        --
        OPEN  c3;
        FETCH c3
         INTO l_def_defect_id;
        CLOSE c3;
        --
        maisplit.create_new_defect(j.def_defect_id
                                  ,l_def_defect_id
                                  ,p_rse_he_id_new
                                  ,l_are_report_id
                                  ,j.def_st_chain
                                  ,p_effective_date);
        --
      END LOOP;
    END LOOP;
    /*
    ||EXTERNAL ACTS
    */
    INSERT
      INTO ext_act_road_usage
          (exu_rse_he_id
          ,exu_ext_id
          ,exu_current
          ,exu_start_date
          ,exu_sign_off_date
          ,exu_created_date
          ,exu_last_updated_date)
    SELECT p_rse_he_id_new
          ,exu_ext_id
          ,exu_current
          ,exu_start_date
          ,exu_sign_off_date
          ,TO_DATE(l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
          ,TO_DATE(l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
      FROM ext_act_road_usage
     WHERE exu_rse_he_id = p_rse_he_id
       AND l_rmmsflag IN('3','4')
         ;
    --
    UPDATE ext_act_road_usage
       SET exu_sign_off_date = p_effective_date
          ,exu_current = NULL
          ,exu_last_updated_date = TO_DATE(l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
     WHERE exu_rse_he_id = p_rse_he_id
       AND l_rmmsflag IN('3','4')
         ;
    /*
    ||FREQUENCIES
    */
    INSERT
      INTO local_freqs
          (lfr_atv_acty_area_code
          ,lfr_int_code
          ,lfr_rse_he_id
          ,lfr_approved_by
          ,lfr_approved_ref
          ,lfr_date_approved
          ,lfr_descr
          ,lfr_end_chain
          ,lfr_ity_inv_code
          ,lfr_start_chain
          ,lfr_ity_sys_flag)
    SELECT lfr_atv_acty_area_code
          ,lfr_int_code
          ,p_rse_he_id_new
          ,lfr_approved_by
          ,lfr_approved_ref
          ,lfr_date_approved
          ,lfr_descr
          ,lfr_end_chain
          ,lfr_ity_inv_code
          ,lfr_start_chain
          ,lfr_ity_sys_flag
      FROM local_freqs
     WHERE lfr_rse_he_id = p_rse_he_id
         ;
    --
    INSERT
      INTO section_freqs
          (sfr_atv_acty_area_code
          ,sfr_int_code
          ,sfr_rse_he_id)
    SELECT sfr_atv_acty_area_code
          ,sfr_int_code
          ,p_rse_he_id_new
      FROM section_freqs
     WHERE sfr_rse_he_id = p_rse_he_id
         ;
    /*
    ||STRUCTURAL PROJECTS
    */
    UPDATE scheme_roads
       SET rse_he_id = p_rse_he_id_new
     WHERE rse_he_id = p_rse_he_id
         ;
    --
  END replace_data;

  -----------------------------------------------------------------------------
  --**** UNREPLACE PROCEDURES *****
  -----------------------------------------------------------------------------
  PROCEDURE check_data_unreplace(p_id            IN     NUMBER
                                ,p_actioned_date IN     VARCHAR2
                                ,p_errors        IN OUT NUMBER
                                ,p_error_string  IN OUT VARCHAR2)
    IS
  BEGIN
    NULL;
  END check_data_unreplace;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE unreplace_data(p_id_orig      IN NUMBER -- section to be unreplaced
                          ,p_id_del       IN NUMBER -- section to be deleted
                          ,p_history_date IN DATE)
    IS
    --
    l_unactioned_date  VARCHAR2(22) := TO_CHAR(SYSDATE,'DD-MON-YYYY,HH24:MI:SS');
    l_dummy            NUMBER(1);
    --
  BEGIN
    /*
    ||DEFECTS AND REPAIRS
    */
    DELETE temp_undo_defect_edit;
    --
    INSERT
      INTO temp_undo_defect_edit
          (def_defect_id
          ,def_rse_he_id
          ,def_iit_item_id
          ,def_st_chain
          ,def_are_report_id
          ,def_atv_acty_area_code
          ,def_siss_id
          ,def_works_order_no
          ,def_created_date
          ,def_defect_code
          ,def_last_updated_date
          ,def_orig_priority
          ,def_priority
          ,def_status_code
          ,def_superseded_flag
          ,def_area
          ,def_are_id_not_found
          ,def_coord_flag
          ,def_date_compl
          ,def_date_not_found
          ,def_defect_class
          ,def_defect_descr
          ,def_defect_type_descr
          ,def_diagram_no
          ,def_height
          ,def_ident_code
          ,def_ity_inv_code
          ,def_ity_sys_flag
          ,def_length
          ,def_locn_descr
          ,def_maint_wo
          ,def_mand_adv
          ,def_notify_org_id
          ,def_number
          ,def_per_cent
          ,def_per_cent_orig
          ,def_per_cent_rem
          ,def_rechar_org_id
          ,def_serial_no
          ,def_skid_coeff
          ,def_special_instr
          ,def_superseded_id
          ,def_time_hrs
          ,def_time_mins
          ,def_update_inv
          ,def_x_sect
          ,def_easting
          ,def_northing
          ,def_response_category
          ,def_status_reason
          ,def_inspection_date)
    SELECT def_defect_id
          ,def_rse_he_id
          ,def_iit_item_id
          ,def_st_chain
          ,def_are_report_id
          ,def_atv_acty_area_code
          ,def_siss_id
          ,def_works_order_no
          ,def_created_date
          ,def_defect_code
          ,def_last_updated_date
          ,def_orig_priority
          ,def_priority
          ,def_status_code
          ,def_superseded_flag
          ,def_area
          ,def_are_id_not_found
          ,def_coord_flag
          ,def_date_compl
          ,def_date_not_found
          ,def_defect_class
          ,def_defect_descr
          ,def_defect_type_descr
          ,def_diagram_no
          ,def_height
          ,def_ident_code
          ,def_ity_inv_code
          ,def_ity_sys_flag
          ,def_length
          ,def_locn_descr
          ,def_maint_wo
          ,def_mand_adv
          ,def_notify_org_id
          ,def_number
          ,def_per_cent
          ,def_per_cent_orig
          ,def_per_cent_rem
          ,def_rechar_org_id
          ,def_serial_no
          ,def_skid_coeff
          ,def_special_instr
          ,def_superseded_id
          ,def_time_hrs
          ,def_time_mins
          ,def_update_inv
          ,def_x_sect
          ,def_easting
          ,def_northing
          ,def_response_category
          ,def_status_reason
          ,def_inspection_date
      FROM DEFECTS
     WHERE def_rse_he_id = p_id_del
         ;
    /*
    ||Delete the defects belonging to the section which were created from the replace.
    */
    DELETE defects
     WHERE def_rse_he_id = p_id_del
         ;
    /*
    ||repair update.
    */
    UPDATE repairs
       SET rep_superseded_flag = 'N'
          ,rep_last_updated_date = TO_DATE(l_unactioned_date,'DD-MON-YYYY,HH24:MI:SS')
     WHERE rep_def_defect_id IN(SELECT def.def_defect_id
                                  FROM defects def
                                      ,temp_undo_defect_edit tmp
                                 WHERE def.def_superseded_id = tmp.def_defect_id)
       AND NOT EXISTS(SELECT 'x'
                        FROM work_order_lines
                       WHERE wol_rep_action_cat = rep_action_cat
                         AND wol_def_defect_id = rep_def_defect_id)
         ;
    /*
    ||boq items update
    */
    UPDATE boq_items
       SET boq_defect_id = (SELECT def.def_defect_id
                              FROM defects def
                                  ,temp_undo_defect_edit tmp
                             WHERE def.def_superseded_id = tmp.def_defect_id
                               AND tmp.def_defect_id = boq_defect_id)
     WHERE boq_defect_id IN(SELECT tmp2.def_defect_id
                              FROM temp_undo_defect_edit tmp2
                             WHERE tmp2.def_rse_he_id = p_id_del)
         ;
    --
    UPDATE defects def
       SET def.def_date_compl = NULL
          ,def.def_last_updated_date = TO_DATE(l_unactioned_date ,'DD-MON-YYYY,HH24:MI:SS')
          ,def.def_status_code = (SELECT tmp1.def_status_code
                                    FROM temp_undo_defect_edit tmp1
                                   WHERE tmp1.def_defect_id = def.def_superseded_id
                                     AND tmp1.def_rse_he_id = p_id_del)
          ,def.def_superseded_id = NULL
          ,def.def_superseded_flag = 'N'
     WHERE def.def_superseded_id IN(SELECT tmp.def_defect_id
                                      FROM temp_undo_defect_edit tmp
                                     WHERE tmp.def_rse_he_id = p_id_del)
       AND def.def_rse_he_id = p_id_orig
         ;
    -- repair delete
    DELETE repairs
     WHERE NOT EXISTS(SELECT 'maintain referential integrity'
                        FROM defects
                       WHERE def_defect_id = rep_def_defect_id)
         ;
    /*
    ||EXTERNAL ACTS
    */
    DELETE ext_act_road_usage
     WHERE exu_rse_he_id = p_id_del
       AND l_rmmsflag IN('3','4')
         ;
    --
    UPDATE ext_act_road_usage
       SET exu_sign_off_date = NULL
          ,exu_current = 'Y'
          ,exu_last_updated_date = TO_DATE(l_unactioned_date,'DD-MON-YYYY,HH24:MI:SS')
     WHERE exu_rse_he_id = p_id_orig
       AND l_rmmsflag IN('3','4')
         ;
    /*
    ||ACTIVITIES
    */
    DELETE act_report_lines
     WHERE arl_are_report_id IN(SELECT are_report_id
                                  FROM activities_report
                                 WHERE are_rse_he_id = p_id_del)
         ;
    --
    DELETE activities_report
     WHERE are_rse_he_id = p_id_del
         ;
    /*
    ||FREQUENCIES
    */
    DELETE section_freqs
     WHERE sfr_rse_he_id = p_id_del
         ;
    --
    DELETE local_freqs
     WHERE lfr_rse_he_id = p_id_del
         ;
    /*
    ||STRUCTURAL PROJECTS
    */
    UPDATE scheme_roads
       SET rse_he_id = p_id_orig
     WHERE rse_he_id = p_id_del
         ;
    --
  END unreplace_data;
  --
END mairepl;
/
