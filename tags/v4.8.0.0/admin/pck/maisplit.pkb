CREATE OR REPLACE PACKAGE BODY maisplit
  AS
  --
  -----------------------------------------------------------------------------
  --   PVCS Identifiers :-
  --
  --       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/maisplit.pkb-arc   2.10   Sep 27 2019 14:40:22   Chris.Baugh  $
  --       Module Name      : $Workfile:   maisplit.pkb  $
  --       Date into SCCS   : $Date:   Sep 27 2019 14:40:22  $
  --       Date fetched Out : $Modtime:   Sep 27 2019 14:34:48  $
  --       SCCS Version     : $Revision:   2.10  $
  --       Based onSCCS Version     : 1.7
  --
  -- This package contains procedures and functions which are required by
  -- the Split process within Network Manager.
  -- Maintenance Manager specific functionality can be found here,
  -- whilst the core functionality of the network processes can be found
  -- in the HIGSPLIT package.
  -- Originally taken from '@(#)maisplit.pck 1.14 01/11/02';
  -----------------------------------------------------------------------------
  --   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
  -----------------------------------------------------------------------------
  --
  --all global package variables here
  --
  g_body_sccsid     CONSTANT  varchar2(2000) := '$Revision:   2.10  $';
  --  g_body_sccsid is the SCCS ID for the package body
  --
  g_package_name    CONSTANT  varchar2(30)   := 'maisplit';
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
  --**** SPLIT PROCEDURES *****
  -----------------------------------------------------------------------------
  --
  PROCEDURE check_data(p_id        IN     NUMBER
                      ,p_chain     IN     NUMBER
                      ,p_effective IN     DATE
                      ,p_errors    IN OUT NUMBER
                      ,p_err_text  IN OUT VARCHAR2)
    IS
    --
    -- Before a section is split, associated Maint. Manager data is checked here.
    -- Associated data for other products is checked in separate procedures
    -- eg. Structures data is checked in the STRSPLIT.CHECK_DATA procedure.
    --
    l_rse_sys_flag    road_segs.rse_sys_flag%TYPE;
    l_rse_agency      road_segs.rse_agency%TYPE;
    l_rse_linkcode    road_segs.rse_linkcode%TYPE;
    l_rse_sect_no     road_segs.rse_sect_no%TYPE;
    l_rse_length      road_segs.rse_length%TYPE;
    l_rse_start_date  road_segs.rse_start_date%TYPE;
    l_message         VARCHAR2(80);
    --
    CURSOR c1(cp_id nm_elements_all.ne_id%TYPE)
        IS
    SELECT rse_sys_flag
          ,rse_agency
          ,rse_linkcode
          ,RTRIM(rse_sect_no)
          ,rse_length
          ,rse_start_date
      FROM road_segs
     WHERE rse_he_id = cp_id
         ;
    --
    CURSOR c3(cp_id         nm_elements_all.ne_id%TYPE
             ,cp_effective  DATE)
        IS
    SELECT 'ERROR : Inspection or work completed after Effective Date'
      FROM activities_report
     WHERE are_rse_he_id = cp_id
       AND cp_effective < NVL(TRUNC(are_date_work_done),cp_effective+1)
         ;
    --
    CURSOR c4(cp_id         nm_elements_all.ne_id%TYPE
             ,cp_effective  DATE)
        IS
    SELECT 'ERROR : Defects completed after Effective Date'
      FROM defects
     WHERE def_rse_he_id = cp_id
       AND NVL(TRUNC(def_date_compl),cp_effective) > cp_effective
         ;
    --
    -- SM 09022006 - Removed the check for the wor_date_closed is null so that the edit can be done regardless of
    -- open works orders.
    --
    CURSOR c5(cp_id         nm_elements_all.ne_id%TYPE
             ,cp_effective  DATE)
        IS
    SELECT 'ERROR : Work Orders open or completed after Effective Date'
      FROM work_orders
          ,work_order_lines
     WHERE wor_works_order_no = wol_works_order_no
       AND wol_rse_he_id = cp_id
       AND (cp_effective < TRUNC(wor_date_closed))
         ;
    --
    CURSOR c6(cp_id         nm_elements_all.ne_id%TYPE
             ,cp_effective  DATE)
        IS
    SELECT 'ERROR : Ext Activity Road Usages open or closed after Effective Date'
      FROM ext_act_road_usage
     WHERE exu_rse_he_id = cp_id
       AND (exu_sign_off_date IS NULL
            OR TRUNC(exu_sign_off_date) > cp_effective)
         ;
    --
    CURSOR c7(cp_rse_agency    road_segs.rse_agency%TYPE
             ,cp_rse_linkcode  road_segs.rse_linkcode%TYPE
             ,cp_rse_sys_flag  road_segs.rse_sys_flag%TYPE
             ,cp_rse_sect_no   road_segs.rse_sect_no%TYPE)
        IS
    SELECT 'ERROR : Incomplete Inventory (Stage1) Load'
      FROM hhinv_load_1
     WHERE rec_type = 'B'
       AND SUBSTR(full_value,1,10) = UPPER(cp_rse_agency||cp_rse_linkcode)
       AND (DECODE(cp_rse_sys_flag,'D',SUBSTR(full_value,12,2)
                                      ,SUBSTR(full_value,12,5))) = UPPER(cp_rse_sect_no)
         ;
    --
    -- if Stage1 suceeds, then subsequent stages might fail for various reasons
    -- including Inventory having been loaded for a Section which has not yet
    -- been created; so test not only RSE_HE_ID but also Agency, Link, Section
    -- NOTE: this test will identify any stage after Stage1 which is incomplete
    --
    CURSOR c8(cp_id            nm_elements_all.ne_id%TYPE
             ,cp_rse_agency    road_segs.rse_agency%TYPE
             ,cp_rse_linkcode  road_segs.rse_linkcode%TYPE
             ,cp_rse_sect_no   road_segs.rse_sect_no%TYPE)
        IS
    SELECT 'ERROR : Incomplete Inventory (non-Stage1) load'
      FROM hhinv_sect_log hsl
     WHERE ((hsl.linkcode = UPPER(cp_rse_agency||cp_rse_linkcode)
             AND hsl.section_code = UPPER(cp_rse_sect_no))
            OR (hsl.linkcode = UPPER(cp_rse_linkcode)
                AND hsl.section_code = UPPER(cp_rse_sect_no))
            OR (hsl.he_id = cp_id))
       AND (hsl.error_msg IS NOT NULL
            OR hsl.error_level IS NOT NULL)
         ;
    --
  BEGIN
    --
    OPEN  c1(p_id);
    FETCH c1
    INTO l_rse_sys_flag
        ,l_rse_agency
        ,l_rse_linkcode
        ,l_rse_sect_no
        ,l_rse_length
        ,l_rse_start_date;
    CLOSE c1;
    --
    OPEN  c3(p_id,p_effective);
    FETCH c3
     INTO l_message;
    IF c3%FOUND
     THEN
        p_errors := p_errors + 1;
        p_err_text := p_err_text||CHR(13)||l_message;
    END IF;
    CLOSE c3;
    --
    OPEN  c4(p_id,p_effective);
    FETCH c4
     INTO l_message;
    IF c4%FOUND
     THEN
        p_errors := p_errors + 1;
        p_err_text := p_err_text||CHR(13)||l_message;
    END IF;
    CLOSE c4;
    --
    OPEN  c5(p_id,p_effective);
    FETCH c5
     INTO l_message;
    IF c5%FOUND
     THEN
        p_errors := p_errors + 1;
        p_err_text := p_err_text||CHR(13)||l_message;
    END IF;
    CLOSE c5;
    --
    OPEN  c6(p_id,p_effective);
    FETCH c6
     INTO l_message;
    IF c6%FOUND
     THEN
        p_errors := p_errors + 1;
        p_err_text := p_err_text||CHR(13)||l_message;
    END IF;
    CLOSE c6;
    --
    OPEN  c7(l_rse_agency
            ,l_rse_linkcode
            ,l_rse_sys_flag
            ,l_rse_sect_no);
    FETCH c7
     INTO l_message;
    IF c7%FOUND
     THEN
        p_errors := p_errors + 1;
        p_err_text := p_err_text||CHR(13)||l_message;
    END IF;
    CLOSE c7;
    --
    OPEN  c8(p_id
            ,l_rse_agency
            ,l_rse_linkcode
            ,l_rse_sect_no);
    FETCH c8
     INTO l_message;
    IF c8%FOUND
     THEN
        p_errors := p_errors + 1;
        p_err_text := p_err_text||CHR(13)||l_message;
    END IF;
    CLOSE c8;
    --
  END check_data;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE create_new_insp(p_old_insp IN NUMBER
                           ,p_new_insp IN NUMBER
                           ,p_road     IN NUMBER
                           ,p_start    IN NUMBER
                           ,p_end      IN NUMBER
                           ,p_actioned IN DATE)
    IS
  BEGIN
    /*
    ||create new inspection.
    */
    INSERT
      INTO activities_report
          (are_maint_insp_flag
          ,are_report_id
          ,are_rse_he_id
          ,are_date_work_done
          ,are_end_chain
          ,are_initiation_type
          ,are_peo_person_id_actioned
          ,are_st_chain
          ,are_insp_load_date
          ,are_wol_works_order_no
          ,are_sched_act_flag
          ,are_created_date
          ,are_last_updated_date
          ,are_batch_id
          ,are_peo_person_id_insp2
          ,are_surface_condition
          ,are_weather_condition)
    SELECT a2.are_maint_insp_flag
          ,p_new_insp
          ,p_road
          ,a2.are_date_work_done
          ,p_end
          ,a2.are_initiation_type
          ,a2.are_peo_person_id_actioned
          ,p_start
          ,a2.are_insp_load_date
          ,a2.are_wol_works_order_no
          ,a2.are_sched_act_flag
          ,a2.are_created_date
          ,p_actioned
          ,a2.are_batch_id
          ,a2.are_peo_person_id_insp2
          ,a2.are_surface_condition
          ,a2.are_weather_condition
      FROM activities_report a2
     WHERE a2.are_report_id = p_old_insp
         ;

    /*
    ||insert activity codes for new inspection.
    */
    INSERT
      INTO act_report_lines
          (arl_act_status
          ,arl_are_report_id
          ,arl_atv_acty_area_code
          ,arl_not_seq_flag
          ,arl_report_id_part_of
          ,arl_created_date
          ,arl_last_updated_date)
    SELECT 'C'
          ,p_new_insp
          ,arl2.arl_atv_acty_area_code
          ,''
          ,''
          ,arl2.arl_created_date
          ,p_actioned
      FROM act_report_lines arl2
     WHERE arl2.arl_are_report_id = p_old_insp
         ;
    --
  END create_new_insp;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE create_new_defect (p_old_defect IN NUMBER
                              ,p_new_defect IN NUMBER
                              ,p_road       IN NUMBER
                              ,p_new_insp   IN NUMBER
                              ,p_st_chain   IN NUMBER
                              ,p_actioned   IN DATE)
    IS
    --
    CURSOR c_superceded_status
        IS
    SELECT hsc_status_code
      FROM hig_status_codes
     WHERE hsc_allow_feature8 = 'Y'
       AND hsc_domain_code = 'DEFECTS'
         ;
    --
    CURSOR c_boq
        IS
    SELECT boq_id
          ,boq_defect_id
      FROM boq_items
          ,repairs
     WHERE boq_defect_id = rep_def_defect_id
       AND boq_rep_action_cat = rep_action_cat
       AND rep_date_completed IS NULL
       AND NOT EXISTS(SELECT 'x'
                        FROM work_order_lines
                       WHERE wol_rep_action_cat = rep_action_cat
                         AND wol_def_defect_id = rep_def_defect_id)
       AND rep_def_defect_id = p_old_defect
       FOR UPDATE OF boq_defect_id
         ;
    --
    CURSOR c_get_table_descr
        IS
    SELECT das_table_name
      FROM doc_assocs
     WHERE das_rec_id = TO_CHAR(p_old_defect)
       AND (das_table_name = 'DEFECTS'
            OR das_table_name IN (SELECT dgs_table_syn
                                    FROM doc_gate_syns
                                   WHERE dgs_dgt_table_name = 'DEFECTS'))
         ;
    --
    l_superceded  hig_status_codes.hsc_status_code%TYPE;
    l_table_descr doc_assocs.das_table_name%TYPE;
    --
  BEGIN
    --
    OPEN  c_superceded_status;
    FETCH c_superceded_status
     INTO l_superceded;
    CLOSE c_superceded_status;
    --
    INSERT
      INTO defects
          (def_defect_id, def_rse_he_id, def_iit_item_id, def_st_chain
          ,def_are_report_id, def_atv_acty_area_code, def_siss_id, def_works_order_no
          ,def_created_date, def_defect_code, def_last_updated_date, def_orig_priority
          ,def_priority, def_status_code, def_superseded_flag, def_area
          ,def_are_id_not_found, def_coord_flag, def_date_compl, def_date_not_found
          ,def_defect_class, def_defect_descr, def_defect_type_descr, def_diagram_no
          ,def_height, def_ident_code, def_ity_inv_code, def_ity_sys_flag
          ,def_length, def_locn_descr, def_maint_wo, def_mand_adv
          ,def_notify_org_id, def_number, def_per_cent, def_per_cent_orig
          ,def_per_cent_rem, def_rechar_org_id, def_serial_no, def_skid_coeff
          ,def_special_instr, def_superseded_id, def_time_hrs, def_time_mins
          ,def_update_inv, def_x_sect, def_northing, def_easting
          ,def_response_category,def_status_reason,def_inspection_date)
    SELECT p_new_defect, p_road, iih_new_item_id, p_st_chain
          ,p_new_insp, def_atv_acty_area_code, def_siss_id, def_works_order_no
          ,def_created_date, def_defect_code, p_actioned, def_orig_priority
          ,def_priority, def_status_code, def_superseded_flag, def_area
          ,def_are_id_not_found, def_coord_flag, def_date_compl, def_date_not_found
          ,def_defect_class, def_defect_descr, def_defect_type_descr, def_diagram_no
          ,def_height, def_ident_code, def_ity_inv_code, def_ity_sys_flag
          ,def_length, def_locn_descr, def_maint_wo, def_mand_adv
          ,def_notify_org_id, def_number, def_per_cent, def_per_cent_orig
          ,def_per_cent_rem, def_rechar_org_id, def_serial_no, def_skid_coeff
          ,def_special_instr, def_superseded_id, def_time_hrs, def_time_mins
          ,def_update_inv, def_x_sect, def_northing, def_easting, def_response_category
          ,def_status_reason,def_inspection_date
      FROM inv_item_history
          ,defects
     WHERE iih_new_rse_he_id(+) = p_road
       AND iih_item_id(+) = def_iit_item_id
       AND def_defect_id = p_old_defect
         ;
    --
    OPEN  c_get_table_descr;
    FETCH c_get_table_descr
     INTO l_table_descr;
    IF c_get_table_descr%FOUND
     THEN
        nm3reclass.ins_doc_assocs(pi_new_id     => p_new_defect
                                 ,pi_old_id     => p_old_defect
                                 ,pi_table_name => l_table_descr);
    END IF;
    CLOSE c_get_table_descr;
    --
    INSERT
      INTO repairs
          (rep_action_cat, rep_atv_acty_area_code, rep_date_due, rep_def_defect_id
          ,rep_rse_he_id, rep_superseded_flag, rep_completed_hrs, rep_completed_mins
          ,rep_date_completed, rep_descr, rep_tre_treat_code, rep_old_due_date
          ,rep_created_date, rep_last_updated_date)
    SELECT rep_action_cat, rep_atv_acty_area_code, rep_date_due, p_new_defect
          ,p_road, rep_superseded_flag, rep_completed_hrs, rep_completed_mins
          ,rep_date_completed, rep_descr, rep_tre_treat_code, rep_old_due_date
          ,rep_created_date, p_actioned
      FROM repairs r2
     WHERE r2.rep_date_completed IS NULL
       AND NOT EXISTS(SELECT 'x'
                        FROM work_order_lines
                       WHERE wol_rep_action_cat = r2.rep_action_cat
                         AND wol_def_defect_id = r2.rep_def_defect_id)
       AND r2.rep_def_defect_id = p_old_defect
         ;
    --
    UPDATE defects
       SET def_superseded_flag = 'Y'
          ,def_superseded_id = p_new_defect
          ,def_status_code = l_superceded
     WHERE def_defect_id = p_old_defect
         ;
    --
    UPDATE repairs
       SET rep_superseded_flag = 'Y'
     WHERE rep_def_defect_id = p_old_defect
         ;
    --
    FOR i IN c_boq LOOP
      UPDATE boq_items
         SET boq_defect_id = p_new_defect
       WHERE CURRENT OF c_boq;
    END LOOP;
    --
  END create_new_defect;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE split_data(p_id        IN NUMBER
                      ,p_chain     IN NUMBER
                      ,p_effective IN DATE
                      ,p_id1       IN NUMBER
                      ,p_id2       IN NUMBER
                      ,p_actioned  IN DATE) IS
    --
    -- When a section is split, associated Maint. Manager data is processed here.
    -- Associated data for other products is processed in separate procedures
    -- eg. Structures data is processed in the STRSPLIT.SPLIT_DATA procedure.
    --
    l_rse_length           road_segs.rse_length%TYPE;
    l_rse_road_environment road_segs.rse_road_environment%TYPE;
    l_rse_sys_flag         road_segs.rse_sys_flag%TYPE;
    l_rse_scl_sect_class   road_segs.rse_scl_sect_class%TYPE;
    l_are_report_id1       activities_report.are_report_id%TYPE;
    l_are_report_id2       activities_report.are_report_id%TYPE;
    l_def_defect_id        defects.def_defect_id%TYPE;
    l_st_chain             activities_report.are_st_chain%TYPE;
    l_end_chain            activities_report.are_end_chain%TYPE;
    l_scheme_id            NUMBER;
    l_max_seq_no           NUMBER;
    --
    CURSOR c1
        IS
    SELECT rse_length
          ,rse_road_environment
          ,rse_sys_flag
          ,rse_scl_sect_class
      FROM road_segs
     WHERE rse_he_id = p_id
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
                               AND def_rse_he_id = p_id)
         ;
    --
    CURSOR c_defects(l_insp number)
        IS
    SELECT def_defect_id
          ,NVL(def_st_chain,0) def_st_chain
      FROM defects
     WHERE def_defect_id in(SELECT rep_def_defect_id
                              FROM repairs
                             WHERE rep_date_completed IS NULL
                               AND NOT EXISTS(SELECT 'x'
                                                FROM work_order_lines
                                               WHERE wol_def_defect_id = rep_def_defect_id
                                                 AND wol_rep_action_cat = rep_action_cat))
       AND def_superseded_flag = 'N'
       AND def_are_report_id   = l_insp
         ;
    --
  BEGIN
    /*
    ||Get extra attributes from the section being split.
    */
    OPEN  c1;
    FETCH c1
     INTO l_rse_length
         ,l_rse_road_environment
         ,l_rse_sys_flag
         ,l_rse_scl_sect_class;
    CLOSE c1;
    -----------------------------------------------------------------------------
    --   ACTIVITY REPORTS, DEFECTS AND REPAIRS
    -----------------------------------------------------------------------------
    -- Inspections with available defects are duplicated from the original
    -- road section onto both new road sections, to keep survey dates etc. intact.
    -- Outstanding defects are duplicated from the original road section
    -- onto the appropriate new road section, according to the chainage.
    -- Those on the original section are marked as superseded.
    -- Those on the new section are attached to the new inspection.
    --
    FOR i IN c_open_insp LOOP
      --
      IF i.are_st_chain <= p_chain
       THEN
          IF i.are_end_chain > p_chain
           THEN
              l_end_chain := p_chain;
          ELSE
              l_end_chain := i.are_end_chain;
          END IF;
          --
          OPEN  c2;
          FETCH c2
           INTO l_are_report_id1;
          CLOSE c2;
          --
          create_new_insp(i.are_report_id
                         ,l_are_report_id1
                         ,p_id1
                         ,i.are_st_chain
                         ,l_end_chain
                         ,p_actioned);
      END IF;
      --
      IF i.are_end_chain > p_chain
       THEN
          IF i.are_st_chain <= p_chain
           THEN
              l_st_chain := 0;
          ELSE
              l_st_chain := i.are_st_chain - p_chain;
          END IF;
          --
          l_end_chain := i.are_end_chain - p_chain;
          OPEN  c2;
          FETCH c2
           INTO l_are_report_id2;
          CLOSE c2;
          create_new_insp(i.are_report_id
                         ,l_are_report_id2
                         ,p_id2
                         ,l_st_chain
                         ,l_end_chain
                         ,p_actioned);
      END IF;
      --
      FOR j IN c_defects(i.are_report_id) LOOP
        OPEN  c3;
        FETCH c3
         INTO l_def_defect_id;
        CLOSE c3;
        --
        IF j.def_st_chain <= p_chain
         THEN
            create_new_defect(j.def_defect_id
                             ,l_def_defect_id
                             ,p_id1
                             ,l_are_report_id1
                             ,j.def_st_chain
                             ,p_actioned);
        ELSE
            create_new_defect(j.def_defect_id
                             ,l_def_defect_id
                             ,p_id2
                             ,l_are_report_id2
                             ,j.def_st_chain - p_chain
                             ,p_actioned);
        END IF;
      END LOOP;
    END LOOP;
    /*
    ||Copy affected external activity records to the first new road section
    */
    INSERT
      INTO ext_act_road_usage
          (exu_rse_he_id,exu_ext_id,exu_current,exu_start_date
          ,exu_sign_off_date,exu_created_date,exu_last_updated_date)
    SELECT p_id1,exu_ext_id,exu_current,exu_start_date
          ,exu_sign_off_date,p_actioned,p_actioned
      FROM ext_act_road_usage
     WHERE exu_rse_he_id = p_id
         ;
    /*
    ||Close external activities associated with the section being split.
    */
    UPDATE ext_act_road_usage
       SET exu_sign_off_date = p_effective
          ,exu_last_updated_date = p_actioned
     WHERE exu_rse_he_id = p_id
         ;

    -----------------------------------------------------------------------------
    --STRUCTURAL PROJECTS
    -----------------------------------------------------------------------------
    split_schemes(p_id, p_id1, p_id2, p_chain);
    -----------------------------------------------------------------------------
    --LOCAL AND SECTION FREQUENCIES
    -----------------------------------------------------------------------------
    -- Create a set of local_freqs records for the first new road section
    INSERT
      INTO local_freqs
          (lfr_atv_acty_area_code, lfr_int_code, lfr_rse_he_id
          ,lfr_approved_by, lfr_approved_ref, lfr_date_approved
          ,lfr_descr, lfr_end_chain, lfr_ity_inv_code
          ,lfr_start_chain, lfr_ity_sys_flag)
    SELECT lfr_atv_acty_area_code, lfr_int_code, p_id1
          ,lfr_approved_by, lfr_approved_ref, lfr_date_approved
          ,lfr_descr, LEAST(lfr_end_chain,p_chain), lfr_ity_inv_code
          ,lfr_start_chain, lfr_ity_sys_flag
      FROM local_freqs
     WHERE lfr_rse_he_id = p_id
       AND lfr_start_chain < p_chain
         ;
    /*
    ||Create a set of local_freqs records for the second new road section
    */
    INSERT
      INTO local_freqs
          (lfr_atv_acty_area_code, lfr_int_code, lfr_rse_he_id
          ,lfr_approved_by, lfr_approved_ref, lfr_date_approved
          ,lfr_descr, lfr_end_chain, lfr_ity_inv_code
          ,lfr_start_chain, lfr_ity_sys_flag)
    SELECT lfr_atv_acty_area_code, lfr_int_code, p_id2
          ,lfr_approved_by, lfr_approved_ref, lfr_date_approved
          ,lfr_descr, (lfr_end_chain-p_chain), lfr_ity_inv_code
          ,GREATEST((lfr_start_chain-p_chain),0), lfr_ity_sys_flag
      FROM local_freqs
     WHERE lfr_rse_he_id = p_id
       AND lfr_end_chain >= p_chain
       AND NOT(lfr_end_chain = p_chain
               AND lfr_start_chain < p_chain)
         ;
    /*
    ||Delete all section_freqs records attached to the original road section.
    */
    DELETE section_freqs
     WHERE sfr_rse_he_id = p_id
         ;
    /*
    ||Create a set of section_freqs records for the first new road section
    */
    INSERT
      INTO section_freqs
          (sfr_rse_he_id
          ,sfr_atv_acty_area_code
          ,sfr_int_code)
    SELECT p_id1
          ,afr_atv_acty_area_code
          ,MAX(afr_int_code)
      FROM act_freqs a
     WHERE afr_ity_sys_flag = l_rse_sys_flag
       AND afr_scl_sect_class = l_rse_scl_sect_class
       AND afr_road_environment = l_rse_road_environment
       AND (afr_ity_inv_code = '%%'
            OR afr_ity_inv_code IN(SELECT iit_ity_inv_code
                                     FROM inv_items_all
                                    WHERE iit_rse_he_id = p_id1))
       AND NOT EXISTS(SELECT 1
                        FROM act_freqs b
                       WHERE afr_ity_sys_flag = l_rse_sys_flag
                         AND afr_scl_sect_class = l_rse_scl_sect_class
                         AND afr_road_environment = l_rse_road_environment
                         AND maisplit.freq(a.afr_int_code) < maisplit.freq(b.afr_int_code))
     GROUP
        BY p_id1
          ,afr_atv_acty_area_code
         ;
    /*
    ||Create a set of section_freqs records for the second new road section.
    */
    INSERT
      INTO section_freqs
          (sfr_rse_he_id
          ,sfr_atv_acty_area_code
          ,sfr_int_code)
    SELECT p_id2
          ,afr_atv_acty_area_code
          ,MAX(afr_int_code)
      FROM act_freqs a
     WHERE afr_ity_sys_flag = l_rse_sys_flag
       AND afr_scl_sect_class = l_rse_scl_sect_class
       AND afr_road_environment = l_rse_road_environment
       AND (afr_ity_inv_code = '%%'
            OR afr_ity_inv_code IN(SELECT iit_ity_inv_code
                                     FROM inv_items_all
                                    WHERE iit_rse_he_id = p_id2))
       AND NOT EXISTS(SELECT 1
                        FROM act_freqs b
                       WHERE afr_ity_sys_flag = l_rse_sys_flag
                         AND afr_scl_sect_class = l_rse_scl_sect_class
                         AND afr_road_environment = l_rse_road_environment
                         AND maisplit.freq(a.afr_int_code) < maisplit.freq(b.afr_int_code))
     GROUP
        BY p_id2
          ,afr_atv_acty_area_code
         ;
    --
  END split_data;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE split_schemes(p_id    IN road_segs.rse_he_id%TYPE
                         ,p_id1   IN road_segs.rse_he_id%TYPE
                         ,p_id2   IN road_segs.rse_he_id%TYPE
                         ,p_chain IN scheme_roads.start_point%TYPE)
    IS
    --
    CURSOR c1
        IS
    SELECT a.scheme_id
      FROM scheme_roads a
     WHERE EXISTS(SELECT 'x'
                    FROM scheme_roads b
                   WHERE b.rse_he_id = p_id
                     AND b.scheme_id = a.scheme_id )
     GROUP
        BY scheme_id
         ;
    --
    CURSOR c2(scheme IN NUMBER)
        IS
    SELECT scheme_id
          ,scheme_road_id
          ,end_point
          ,seq_no
      FROM scheme_roads
     WHERE rse_he_id = p_id
       AND scheme_id = scheme
       AND start_point < p_chain
       AND end_point > p_chain
         ;
    --
    CURSOR c3
        IS
    SELECT sch_rd_seq.NEXTVAL
      FROM dual
         ;
    --
    lseq  NUMBER;
    --
  BEGIN
    /*
    ||Process affected schemes one at a time.
    ||SCHEME_ROADS records are moved from the old section to the new ones.
    ||NB. Do not reorder the updates as the sequence is critical.
    */
    FOR scheme IN c1 LOOP
      /*
      ||Update any scheme segments which start after the split point.
      */
      UPDATE scheme_roads
         SET rse_he_id = p_id2
            ,start_point = start_point - p_chain
            ,end_point = end_point - p_chain
       WHERE rse_he_id = p_id
         AND scheme_id = scheme.scheme_id
         AND start_point >= p_chain
           ;
      /*
      ||Create an extra scheme segment for each one that spanned the split point
      */
      FOR scheme_road IN c2(scheme.scheme_id) LOOP
        --
        OPEN  c3;
        FETCH c3
         INTO lseq;
        CLOSE c3;
        --
        INSERT
          INTO scheme_roads
              (scheme_id
              ,scheme_road_id
              ,seq_no
              ,rse_he_id
              ,start_point
              ,end_point
              ,start_flag)
        VALUES(scheme_road.scheme_id
              ,lseq
              ,scheme_road.seq_no
              ,p_id2
              ,0
              ,scheme_road.end_point - p_chain
              ,'N');
        --
        INSERT
          INTO scheme_activities
              (scheme_road_id
              ,seq_no
              ,acty_area_code
              ,siss_id
              ,overlay_flag
              ,depth
              ,cost
              ,xsp_codes
              ,primary_flag)
        SELECT lseq
              ,seq_no
              ,acty_area_code
              ,siss_id
              ,overlay_flag
              ,depth
              ,cost
              ,xsp_codes
              ,primary_flag
          FROM scheme_activities
         WHERE scheme_road_id = scheme_road.scheme_road_id
             ;
        --
      END LOOP;
      /*
      ||Update any scheme segments which start before the split point.
      */
      UPDATE scheme_roads
         SET rse_he_id = p_id1
            ,end_point = LEAST(end_point,p_chain )
       WHERE rse_he_id = p_id
         AND scheme_id = scheme.scheme_id
         AND start_point < p_chain
           ;
      --
    END LOOP;
    --
  END split_schemes;

  --
  -----------------------------------------------------------------------------
  --
  FUNCTION freq(p_int_code IN VARCHAR)
    RETURN NUMBER IS
    --
    l_return  NUMBER:=0;
    --
    CURSOR c1
        IS
    SELECT NVL(int_freq_per_year,99999 - TRUNC((NVL(int_hrs,0)+23)/24)
                                       - NVL(int_days,0)
                                       - NVL(int_months,0)*30
                                       - NVL(int_yrs,0)*365)
      FROM intervals
     WHERE int_code = p_int_code
         ;
    --
  BEGIN
    --
    OPEN  c1;
    FETCH c1
     INTO l_return;
    CLOSE c1;
    --
    RETURN l_return;
    --
  END freq;

  -----------------------------------------------------------------------------
  --**** UNSPLIT PROCEDURES *****
  -----------------------------------------------------------------------------
  PROCEDURE data_check(p_id            IN     NUMBER
                      ,p_actioned_date IN     VARCHAR2
                      ,p_errors        IN OUT NUMBER
                      ,p_error_string  IN OUT VARCHAR2)
    IS
    /*
    ||Checks that the user has supplied valid parameters.
    ||This procedure is also used by the unmerge process.
    */
    l_sys_flag  VARCHAR2(1);
    l_agency    road_sections.rse_agency%TYPE;
    l_linkcode  road_sections.rse_linkcode%TYPE;
    l_sect_no   road_sections.rse_sect_no%TYPE;
    l_message   VARCHAR2(80);
    --
    cursor c1
        is
    select rse_sys_flag
          ,rse_agency
          ,rse_linkcode
          ,rse_sect_no
      from road_sections_all
     where rse_he_id = p_id
         ;
    --
    cursor c3
        is
    select 'Error : Inspection or Maintenance Reports created or modified'
      from activities_report
     where are_rse_he_id = p_id
       and are_last_updated_date > to_date(p_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
         ;
    --
    cursor c4
        is
    select 'Error : Inspection or Maintenance Report Lines created or modified'
      from act_report_lines
     where arl_are_report_id in(select are_report_id
                                  from activities_report
                                 where are_rse_he_id = p_id)
       and arl_last_updated_date > to_date(p_actioned_date,'DD-MON-YYYY,HH24:MI:SS');
    --
    cursor c5 is
      select 'Error : Defects created or modified'
      from   defects
      where  def_rse_he_id = p_id
      and    def_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');
    --
    cursor c6 is
      select 'Error : Repairs created or modified'
      from   repairs
      where  rep_rse_he_id = p_id
      and    rep_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');
    --
    cursor c7 is
      select 'Error : Work Order Lines exist'
      from   work_orders WOR,
        work_order_lines WOL
      where  WOR.wor_works_order_no = WOL.wol_works_order_no
      and    WOL.wol_rse_he_id = p_id;
    --
    cursor c8 is
      select 'Error : Ext. Activity Road Usages created or modified'
      from   ext_act_road_usage
      where  exu_rse_he_id = p_id
      and    exu_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');
    --
    cursor c9 is
      select 'Error : Incomplete Inventory (Stage 1) load'
      from   hhinv_load_1 HL1
      where  HL1.rec_type = 'B'
      and   (SUBSTR(HL1.full_value,1,10) = upper( l_agency||l_linkcode)
      and    DECODE(l_sys_flag ,'D',SUBSTR( HL1.full_value,12,2)
                   ,SUBSTR( HL1.full_value,12,5)) = upper( l_sect_no)
            );
    --
    -- if Stage1 suceeds, then subsequent stages might fail for various reasons
    -- including Inventory having been loaded for a Section which has not yet
    -- been created; so test not only RSE_HE_ID but also Agency, Link, Section
    -- strings. this test will identify any stage subsequent to Stage1 which is
    -- incomplete.
    --
    CURSOR c10
        IS
    SELECT 'Error : Incomplete Inventory (non-Stage 1) load'
      FROM   hhinv_sect_log HSL
     WHERE ((HSL.linkcode = UPPER(l_agency||l_linkcode)
             AND HSL.section_code = UPPER(l_sect_no))
            OR(HSL.linkcode = UPPER(l_linkcode)
               AND HSL.section_code = UPPER(l_sect_no))
            OR (HSL.he_id = p_id))
       AND (HSL.error_msg IS NOT NULL
            OR HSL.error_level IS NOT NULL);
    --
  BEGIN
    --
    OPEN  c1;
    FETCH c1
     INTO l_sys_flag
         ,l_agency
         ,l_linkcode
         ,l_sect_no;
    IF c1%notfound
     THEN
        p_errors := p_errors + 1;
        l_message := 'This section does not exist.';
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c1;
    --
    OPEN  c3;
    FETCH c3
     INTO l_message;
    IF c3%FOUND
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c3;
    --
    OPEN  c4;
    FETCH c4
     INTO l_message;
    IF c4%FOUND
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c4;
    --
    OPEN  c5;
    FETCH c5
     INTO l_message;
    IF c5%found
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c5;
    --
    OPEN  c6;
    FETCH c6
     INTO l_message;
    IF c6%FOUND
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c6;
    --
    OPEN  c7;
    FETCH c7
     INTO l_message;
    IF c7%FOUND
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c7;
    --
    OPEN  c8;
    FETCH c8
     INTO l_message;
    IF c8%FOUND
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c8;
    --
    OPEN  c9;
    FETCH c9
     INTO l_message;
    IF c9%FOUND
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c9;
    --
    OPEN  c10;
    FETCH c10
     INTO l_message;
    IF c10%FOUND
     THEN
        p_errors := p_errors + 1;
        p_error_string:=p_error_string||l_message||chr(13);
    END IF;
    CLOSE c10;
    --
  END data_check;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE check_data_unsplit(p_id1          IN      NUMBER  -- first split section
                              ,p_id2          IN      NUMBER  -- second split section
                              ,p_actioned     IN      VARCHAR2
                              ,p_errors       IN OUT  NUMBER
                              ,p_error_string IN OUT  VARCHAR2)
    IS
    --
  BEGIN
    --
    data_check(p_id1
              ,p_actioned
              ,p_errors
              ,p_error_string);
    --
    data_check(p_id2
              ,p_actioned
              ,p_errors
              ,p_error_string);
    --
  END check_data_unsplit;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE unsplit_data(p_id           IN NUMBER  -- section to be unsplit
                        ,p_id1          IN NUMBER  -- first split section
                        ,p_id2          IN NUMBER  -- second split section
                        ,p_history_date IN VARCHAR2)
    IS
    --
    l_length           NUMBER;
    l_table_name       VARCHAR2(32);
    l_unactioned_date  VARCHAR2(22) := TO_CHAR(SYSDATE,'DD-MON-YYYY,HH24:MI:SS');
    l_today_date       VARCHAR2(11) := TO_CHAR(SYSDATE,'DD-MON-YYYY');
    l_rmmsflag         VARCHAR2(1) := hig.get_sysopt('RMMSFLAG');
    err_string         VARCHAR2(1000);
    --
    CURSOR c1
        IS
    SELECT NVL(rse_length,0)
      FROM road_sections
     WHERE rse_he_id = p_id1;
    --
  BEGIN
    /*
    ||activity_lines.
    */
    DELETE act_report_lines
     WHERE arl_are_report_id IN(SELECT are_report_id
                                  FROM activities_report
                                 WHERE are_rse_he_id IN(p_id1,p_id2))
         ;
    /*
    ||activities.
    */
    DELETE activities_report
     WHERE are_rse_he_id IN(p_id1,p_id2)
         ;
    /*
    ||Create table temp_defects which will
    ||contain the defect data for the sections created from the split.
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
     WHERE def_rse_he_id IN(p_id1,p_id2)
         ;
    --
    UPDATE repairs
       SET rep_superseded_flag = 'N'
     WHERE rep_def_defect_id IN(SELECT def.def_defect_id
                                  FROM defects def
                                      ,temp_undo_defect_edit tmp
                                 WHERE def.def_superseded_id = tmp.def_defect_id
                                   AND tmp.def_rse_he_id IN(p_id1,p_id2)
                                   AND tmp.def_date_compl IS NULL)
         ;
    --
    UPDATE boq_items
       SET boq_defect_id = (SELECT def.def_defect_id
                              FROM defects def
                                  ,temp_undo_defect_edit tmp
                             WHERE def.def_superseded_id = tmp.def_defect_id
                               AND tmp.def_defect_id = boq_defect_id
                               AND tmp.def_date_compl IS NULL)
     WHERE boq_defect_id IN(SELECT tmp.def_defect_id
                              FROM temp_undo_defect_edit tmp
                             WHERE tmp.def_rse_he_id IN(p_id1,p_id2)
                               AND tmp.def_date_compl IS NULL)
         ;
    --
    UPDATE defects
       SET DEF_LAST_UPDATED_DATE = TO_DATE(l_unactioned_date,'DD-MON-YYYY,HH24:MI:SS')
          ,def_superseded_id = NULL
          ,def_superseded_flag = 'N'
          ,def_status_code = 'AVAILABLE'
     WHERE def_superseded_id IN(SELECT tmp.def_defect_id
                                  FROM temp_undo_defect_edit tmp
                                 WHERE tmp.def_rse_he_id IN (p_id1,p_id2)
                                   AND tmp.def_date_compl IS NULL)
         ;
    --
    DELETE repairs
     WHERE rep_rse_he_id IN(p_id1,p_id2)
         ;
    --
    DELETE defects
     WHERE def_rse_he_id IN(p_id1,p_id2)
         ;
    --
    DELETE local_freqs
     WHERE lfr_rse_he_id IN(p_id1,p_id2)
         ;
    --
    DELETE section_freqs
     WHERE sfr_rse_he_id IN(p_id1,p_id2)
         ;
    --
    DELETE ext_act_road_usage
     WHERE exu_rse_he_id IN(p_id1,p_id2)
       AND l_rmmsflag IN('3','4')
         ;
    --
    UPDATE ext_act_road_usage
       SET exu_sign_off_date = NULL
          ,exu_current = 'Y'
          ,exu_last_updated_date = TO_DATE(l_unactioned_date,'DD-MON-YYYY,HH24:MI:SS')
     WHERE exu_rse_he_id = p_id
       AND l_rmmsflag IN('3','4')
         ;
    -- JW 29-MAY-2007 - Log 51555
    --
    -- The undo split fails because the second update statement on scheme_roads results in a 
    -- ORA-01407 error. This happens because l_length is null and this results in an attempt to set 
    -- the start_point (a not null column) to null. With the agreement of Colin Stewart both update 
    -- statements have been commented out since scheme_roads is a pre-Atlas table.
    --
    --
    --schemes_1
    --    update scheme_roads
    --    set rse_he_id = p_id
    --    where rse_he_id = p_id1;
    --
    --schemes_2
    --    update scheme_roads
    --    set    rse_he_id = p_id,
    --    start_point = start_point + l_length,
    --    end_point   = end_point + l_length
    --    where  rse_he_id = p_id2;
  EXCEPTION
    WHEN OTHERS
     THEN
        err_string := SQLERRM;
        raise_application_error( -20001, err_string );
  END unsplit_data;
  --
END maisplit;
/
