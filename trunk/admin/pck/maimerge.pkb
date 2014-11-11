CREATE OR REPLACE PACKAGE BODY maimerge
  AS
  --
  -----------------------------------------------------------------------------
  --   PVCS Identifiers :-
  --
  --       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maimerge.pkb-arc   2.3   Nov 11 2014 18:36:06   Mike.Huitson  $
  --       Module Name      : $Workfile:   maimerge.pkb  $
  --       Date into SCCS   : $Date:   Nov 11 2014 18:36:06  $
  --       Date fetched Out : $Modtime:   Nov 11 2014 18:35:28  $
  --       SCCS Version     : $Revision:   2.3  $
  --       Based onSCCS Version     : 1.5
  --
  -- This package contains procedures and functions which are required by
  -- the Merge / UnMerge processes within Network Manager.
  -- Maintenance Manager specific functionality can be found here,
  -- whilst the core functionality of the network processes can be found
  -- in the HIGMERGE package.
  -- Originally taken from '@(#)maimerge.pck  1.11 06/17/02';
  -----------------------------------------------------------------------------
  --   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
  -----------------------------------------------------------------------------
  --
  --all global package variables here
  --
  g_body_sccsid     CONSTANT  varchar2(2000) := '"$Revision:   2.3  $"';
  --  g_body_sccsid is the SCCS ID for the package body
  --
  g_package_name    CONSTANT  varchar2(30)   := 'maimerge';
  --
  -----------------------------------------------------------------------------
  --
  FUNCTION get_version
    RETURN VARCHAR2 IS
  BEGIN
    RETURN g_sccsid;
  END get_version;

  --
  -----------------------------------------------------------------------------
  --
  FUNCTION get_body_version
    RETURN VARCHAR2 IS
  BEGIN
    RETURN g_body_sccsid;
  END get_body_version;

  --
  -----------------------------------------------------------------------------
  --**** MERGE PROCEDURES *****
  -----------------------------------------------------------------------------
  --
  PROCEDURE check_data(p_rse_he_id_1    IN     NUMBER   -- first existing rse_unique to merge
                      ,p_rse_he_id_2    IN     NUMBER   -- second existing rse_unique to merge
                      ,p_sect_no        IN     VARCHAR2 -- new section for result of merge
                      ,p_effective_date IN     DATE     -- effective date of merge
                      ,p_errors         IN OUT NUMBER
                      ,p_error_string   IN OUT VARCHAR2)
    IS
    --
    -- Checks that the user has supplied valid parameters.
    --
  BEGIN
    --
    maisplit.check_data(p_id        => p_rse_he_id_1
                       ,p_chain     => NULL
                       ,p_effective => p_effective_date
                       ,p_errors    => p_errors
                       ,p_err_text  => p_error_string);
    --
    maisplit.check_data(p_id        => p_rse_he_id_2
                       ,p_chain     => NULL
                       ,p_effective => p_effective_date
                       ,p_errors    => p_errors
                       ,p_err_text  => p_error_string);
    --
  END check_data;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE merge_data(p_rse_he_id_new         IN NUMBER   -- new merged section
                      ,p_rse_he_id_1           IN NUMBER   -- first section to merge
                      ,p_rse_he_id_2           IN NUMBER   -- second section to merge
                      ,p_new_starting_section  IN NUMBER   -- number of the section from which the start of the datum/route is measured either 1 or 2
                      ,p_flip_cardinality_of_2 IN VARCHAR2 -- flag if cardinality of section 2 was flipped
                      ,p_effective_date        IN DATE)    -- effective date of merge
    IS
    --
    -- When sections are merged, associated Maint. Manager data is processed here.
    -- Associated data for other products is processed in separate procedures
    -- eg. Structures data is processed in the STRMERGE.MERGE_DATA procedure.
    --
    l_rse_agency_1        road_segs.rse_agency%TYPE;
    l_rse_linkcode_1      road_segs.rse_linkcode%TYPE;
    l_rse_sect_no_1       road_segs.rse_sect_no%TYPE;
    l_rse_length_1        road_segs.rse_length%TYPE;
    l_sys_flag_1          road_segs.rse_sys_flag%TYPE;
    l_road_environment_1  road_segs.rse_road_environment%TYPE;
    l_sect_class_1        road_segs.rse_scl_sect_class%TYPE;
    --
    l_rse_agency_2    road_segs.rse_agency%TYPE;
    l_rse_linkcode_2  road_segs.rse_linkcode%TYPE;
    l_rse_sect_no_2   road_segs.rse_sect_no%TYPE;
    l_rse_length_2    road_segs.rse_length%TYPE;
    l_sys_flag_2      road_segs.rse_sys_flag%TYPE;
    --
    l_rmmsflag        VARCHAR2(1) := hig.get_sysopt('RMMSFLAG');
    l_actioned        DATE := SYSDATE;
    l_actioned_date   VARCHAR2(22) := TO_CHAR(l_actioned,'DD-MON-YYYY,HH24:MI:SS');
    l_any_activities  activities_report.are_report_id%TYPE;
    l_are_report_id   NUMBER;
    l_def_defect_id   NUMBER;
    l_table_name      VARCHAR2(32) := 'TEMP_ACT_LINES';
    l_message         VARCHAR2(80);
    l_ur_code         inv_item_types.ity_inv_code%TYPE;
    --
    CURSOR c1
        IS
    SELECT rse_agency
          ,rse_linkcode
          ,RTRIM(rse_sect_no)
          ,rse_length
          ,rse_sys_flag
          ,rse_road_environment
          ,rse_scl_sect_class
      FROM road_segs
     WHERE rse_he_id = p_rse_he_id_1
         ;
    --
    CURSOR c2
        IS
    SELECT rse_agency
          ,rse_linkcode
          ,RTRIM(rse_sect_no)
          ,rse_length
          ,rse_sys_flag
      FROM road_segs
     WHERE rse_he_id = p_rse_he_id_2
         ;
    --
    CURSOR c3
        IS
    SELECT 'Info : Local Frequencies have been defaulted to cover entire Merged Section'
      FROM local_freqs a
     WHERE a.lfr_rse_he_id = p_rse_he_id_1
       AND NOT EXISTS(SELECT 1
                        FROM local_freqs b
                       WHERE  b.lfr_rse_he_id = p_rse_he_id_2
                         AND    b.lfr_atv_acty_area_code = a.lfr_atv_acty_area_code
                         AND    b.lfr_ity_inv_code = a.lfr_ity_inv_code)
         ;
    --
    CURSOR c4
        IS
    SELECT 'Info : Local Frequences have been defaulted to cover entire Merged Section'
      FROM local_freqs a
     WHERE a.lfr_rse_he_id = p_rse_he_id_2
       AND NOT EXISTS(SELECT 1
                        FROM local_freqs b
                       WHERE b.lfr_rse_he_id = p_rse_he_id_1
                         AND b.lfr_atv_acty_area_code = a.lfr_atv_acty_area_code
                         AND b.lfr_ity_inv_code = a.lfr_ity_inv_code)
         ;
    --
    CURSOR c5
        IS
    SELECT are_report_id_seq.NEXTVAL
      FROM dual
         ;
    --
    CURSOR c6
        IS
    SELECT def_defect_id_seq.NEXTVAL
      FROM dual
         ;
    --
    CURSOR c8
        IS
    SELECT hop_value
      FROM hig_options
     WHERE hop_id = 'SECTINVTYP'
         ;
    --
    CURSOR c_open_insp
        IS
    SELECT are_report_id
          ,are_rse_he_id
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
                               AND def_rse_he_id IN(p_rse_he_id_1,p_rse_he_id_2))
         ;
    --
    CURSOR c_defects(l_insp NUMBER)
        IS
    SELECT def_defect_id
          ,def_rse_he_id
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
       AND def_are_report_id   = l_insp
         ;
    --
  BEGIN
    --
    OPEN  c1;
    FETCH c1
     INTO l_rse_agency_1
         ,l_rse_linkcode_1
         ,l_rse_sect_no_1
         ,l_rse_length_1
         ,l_sys_flag_1
         ,l_road_environment_1
         ,l_sect_class_1;
    CLOSE c1;
    --
    OPEN  c2;
    FETCH c2
     INTO l_rse_agency_2
         ,l_rse_linkcode_2
         ,l_rse_sect_no_2
         ,l_rse_length_2
         ,l_sys_flag_2;
    CLOSE c2;
    /*
    ||Create new ext_act_road_usage records for the new merged section.
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
          ,exu_ext_id,exu_current
          ,exu_start_date
          ,exu_sign_off_date
          ,l_actioned
          ,l_actioned
      FROM ext_act_road_usage
     WHERE exu_rse_he_id = p_rse_he_id_1
       AND l_rmmsflag IN('3','4')
         ;
    --
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
          ,l_actioned
          ,l_actioned
      FROM ext_act_road_usage
     WHERE exu_rse_he_id = p_rse_he_id_2
       AND l_rmmsflag IN('3','4')
         ;
    /*
    ||end date existing ext_act_road_usage roads for original sections
    */
    UPDATE ext_act_road_usage
       SET exu_sign_off_date = p_effective_date
          ,exu_last_updated_date = TO_DATE(l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
     WHERE exu_rse_he_id IN(p_rse_he_id_1,p_rse_he_id_2)
       AND l_rmmsflag IN('3','4')
         ;
    /*
    ||ACTIVITY REPORTS, DEFECTS AND REPAIRS
    ||
    || Inspections with available defects are duplicated from the original
    || road section onto both new road sections, to keep survey dates etc. intact.
    || Outstanding defects are duplicated from the original road section
    || onto the appropriate new road section, according to the chainage.
    || Those on the original section are marked as superseded.
    || Those on the new section are attached to the new inspection.
    */
    FOR i IN c_open_insp LOOP
      IF i.are_rse_he_id = p_rse_he_id_1
       THEN
          OPEN  c5;
          FETCH c5
           INTO l_are_report_id;
          CLOSE c5;
          --
          maisplit.create_new_insp(i.are_report_id
                                  ,l_are_report_id
                                  ,p_rse_he_id_new
                                  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                            ,pi_rse_length_2         => l_rse_length_2
                                                            ,pi_rse_sys_flag         => l_sys_flag_1
                                                            ,pi_chainage_section     => 1
                                                            ,pi_new_starting_section => p_new_starting_section
                                                            ,pi_original_chainage    => i.are_st_chain
                                                            ,pi_cardinality_flipped  => 'N')
                                  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                            ,pi_rse_length_2         => l_rse_length_2
                                                            ,pi_rse_sys_flag         => l_sys_flag_1
                                                            ,pi_chainage_section     => 1
                                                            ,pi_new_starting_section => p_new_starting_section
                                                            ,pi_original_chainage    => i.are_end_chain
                                                            ,pi_cardinality_flipped  => 'N')
                                  ,p_effective_date);
      ELSE
          OPEN  c5;
          FETCH c5
           INTO l_are_report_id;
          CLOSE c5;
          --
          maisplit.create_new_insp(i.are_report_id
                                  ,l_are_report_id
                                  ,p_rse_he_id_new
                                  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                            ,pi_rse_length_2         => l_rse_length_2
                                                            ,pi_rse_sys_flag         => l_sys_flag_2
                                                            ,pi_chainage_section     => 2
                                                            ,pi_new_starting_section => p_new_starting_section
                                                            ,pi_original_chainage    => i.are_st_chain
                                                            ,pi_cardinality_flipped  => p_flip_cardinality_of_2)
                                  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                            ,pi_rse_length_2         => l_rse_length_2
                                                            ,pi_rse_sys_flag         => l_sys_flag_2
                                                            ,pi_chainage_section     => 2
                                                            ,pi_new_starting_section => p_new_starting_section
                                                            ,pi_original_chainage    => i.are_end_chain
                                                            ,pi_cardinality_flipped  => p_flip_cardinality_of_2)
                                  ,p_effective_date);
      END IF;
      --
      FOR j IN c_defects(i.are_report_id) LOOP
        OPEN  c6;
        FETCH c6
         INTO l_def_defect_id;
        CLOSE c6;
        --
        IF j.def_rse_he_id = p_rse_he_id_1
         THEN
            maisplit.create_new_defect(j.def_defect_id
                                      ,l_def_defect_id
                                      ,p_rse_he_id_new
                                      ,l_are_report_id
                                      ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                                ,pi_rse_length_2         => l_rse_length_2
                                                                ,pi_rse_sys_flag         => l_sys_flag_1
                                                                ,pi_chainage_section     => 1
                                                                ,pi_new_starting_section => p_new_starting_section
                                                                ,pi_original_chainage    => j.def_st_chain
                                                                ,pi_cardinality_flipped  => 'N')
                                      ,p_effective_date);
        ELSE
            maisplit.create_new_defect(j.def_defect_id
                                      ,l_def_defect_id
                                      ,p_rse_he_id_new
                                      ,l_are_report_id
                                      ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                                ,pi_rse_length_2         => l_rse_length_2
                                                                ,pi_rse_sys_flag         => l_sys_flag_2
                                                                ,pi_chainage_section     => 2
                                                                ,pi_new_starting_section => p_new_starting_section
                                                                ,pi_original_chainage    => j.def_st_chain
                                                                ,pi_cardinality_flipped  => p_flip_cardinality_of_2)
                                      ,p_effective_date);
        END IF;
      END LOOP;
    END LOOP;
    /*
    ||LOCAL AND SECTION FREQUENCIES
    */
    INSERT
      INTO sect_freq2
          (tt2_rse_he_id
          ,tt2_afr_atv_acty_area_code
          ,tt2_int_code
          ,tt2_dummy)
    SELECT tt1_rse_he_id
          ,afr_atv_acty_area_code
          ,int_code
          ,MAX(NVL(int_freq_per_year
                  ,NVL(int_freq_per_month
                      ,NVL(int_freq_per_week,99999 - TRUNC((NVL(int_hrs,0)+23)/24) - NVL(int_days,0) - NVL(int_months,0) * 30 - NVL(int_yrs,0) * 365))))
      FROM intervals, act_freqs, sect_freq1
     WHERE int_code = afr_int_code
       AND afr_road_environment = l_road_environment_1
       AND afr_scl_sect_class = l_sect_class_1
       AND afr_ity_sys_flag = l_sys_flag_1
       AND (afr_ity_inv_code = tt1_iit_ity_inv_code
            OR afr_ity_inv_code IS NULL)
     GROUP
        BY tt1_rse_he_id
          ,afr_atv_acty_area_code
          ,int_code
         ;
    --
    INSERT
      INTO section_freqs
          (sfr_atv_acty_area_code
          ,sfr_int_code
          ,sfr_rse_he_id)
    SELECT tt2a.tt2_afr_atv_acty_area_code
          ,tt2a.tt2_int_code
          ,p_rse_he_id_new
      FROM sect_freq2 tt2a
     WHERE (tt2a.tt2_dummy,tt2a.tt2_int_code) = (SELECT MAX(tt2b.tt2_dummy)
                                                       ,MIN(tt2b.tt2_int_code)
                                                   FROM sect_freq2 tt2b
                                                  WHERE tt2b.tt2_afr_atv_acty_area_code = tt2a.tt2_afr_atv_acty_area_code
                                                    AND tt2b.tt2_rse_he_id = tt2a.tt2_rse_he_id)
       AND tt2a.tt2_rse_he_id = p_rse_he_id_new
         ;
    --
    INSERT
      INTO local_freqs
          (lfr_atv_acty_area_code
          ,lfr_int_code
          ,lfr_rse_he_id
          ,lfr_date_approved
          ,lfr_descr
          ,lfr_end_chain
          ,lfr_ity_inv_code
          ,lfr_start_chain
          ,lfr_ity_sys_flag)
    SELECT lfr.lfr_atv_acty_area_code
          ,lfr.lfr_int_code
          ,p_rse_he_id_new
          ,lfr.lfr_date_approved
          ,lfr.lfr_descr
          ,nm3merge.get_new_chainage(l_rse_length_1
                                    ,l_rse_length_2
                                    ,l_sys_flag_1
                                    ,1
                                    ,p_new_starting_section
                                    ,lfr.lfr_end_chain
                                    ,'N')
          ,lfr.lfr_ity_inv_code
          ,nm3merge.get_new_chainage(l_rse_length_1
                                    ,l_rse_length_2
                                    ,l_sys_flag_1
                                    ,1
                                    ,p_new_starting_section
                                    ,lfr.lfr_start_chain
                                    ,'N')
          ,lfr.lfr_ity_sys_flag
      FROM local_freqs lfr
     WHERE lfr.lfr_rse_he_id = p_RSE_HE_ID_1
         ;
    --
    INSERT
      INTO local_freqs
          (lfr_atv_acty_area_code
          ,lfr_int_code
          ,lfr_rse_he_id
          ,lfr_date_approved
          ,lfr_descr
          ,lfr_end_chain
          ,lfr_ity_inv_code
          ,lfr_start_chain
          ,lfr_ity_sys_flag)
    SELECT DISTINCT sfr.sfr_atv_acty_area_code
          ,sfr.sfr_int_code
          ,p_rse_he_id_new
          ,p_effective_date
          ,'Defaulted by section Merge'
          ,l_rse_length_1
          ,lfr.lfr_ity_inv_code
          ,0
          ,lfr.lfr_ity_sys_flag
      FROM section_freqs sfr
          ,local_freqs lfr
     WHERE sfr.sfr_atv_acty_area_code = lfr.lfr_atv_acty_area_code
       AND sfr.sfr_rse_he_id = p_rse_he_id_new
       AND lfr.lfr_rse_he_id = p_rse_he_id_2
       AND NOT EXISTS(SELECT 'exists in Section#2 only so create a default for Section#1 part from Section Frequencies for new Section'
                        FROM local_freqs b
                       WHERE b.lfr_atv_acty_area_code = lfr.lfr_atv_acty_area_code
                         AND b.lfr_ity_inv_code = lfr.lfr_ity_inv_code
                         AND b.lfr_rse_he_id = p_rse_he_id_1)
         ;
    --
    INSERT
      INTO local_freqs
          (lfr_atv_acty_area_code
          ,lfr_int_code
          ,lfr_rse_he_id
          ,lfr_date_approved
          ,lfr_descr
          ,lfr_end_chain
          ,lfr_ity_inv_code
          ,lfr_start_chain
          ,lfr_ity_sys_flag)
    SELECT lfr.lfr_atv_acty_area_code
          ,lfr.lfr_int_code
          ,p_rse_he_id_new
          ,lfr.lfr_date_approved
          ,lfr.lfr_descr
          ,nm3merge.get_new_chainage(l_rse_length_1
                                    ,l_rse_length_2
                                    ,l_sys_flag_2
                                    ,2
                                    ,p_new_starting_section
                                    ,lfr.lfr_end_chain
                                    ,p_flip_cardinality_of_2)
          ,lfr.lfr_ity_inv_code
          ,nm3merge.get_new_chainage(l_rse_length_1
                                    ,l_rse_length_2
                                    ,l_sys_flag_2
                                    ,2
                                    ,p_new_starting_section
                                    ,lfr.lfr_start_chain
                                    ,p_flip_cardinality_of_2)
          ,lfr.lfr_ity_sys_flag
      FROM local_freqs lfr
     WHERE lfr.lfr_rse_he_id = p_rse_he_id_2
         ;
    --
    INSERT
      INTO local_freqs
          (lfr_atv_acty_area_code
          ,lfr_int_code
          ,lfr_rse_he_id
          ,lfr_date_approved
          ,lfr_descr
          ,lfr_end_chain
          ,lfr_ity_inv_code
          ,lfr_start_chain
          ,lfr_ity_sys_flag)
    SELECT DISTINCT sfr.sfr_atv_acty_area_code
          ,sfr.sfr_int_code
          ,p_rse_he_id_new
          ,p_effective_date
          ,'Defaulted by section Merge'
          ,l_rse_length_1 + l_rse_length_2
          ,lfr.lfr_ity_inv_code
          ,l_rse_length_1
          ,lfr.lfr_ity_sys_flag
      FROM section_freqs sfr ,local_freqs lfr
     WHERE sfr.sfr_atv_acty_area_code = lfr.lfr_atv_acty_area_code
       AND sfr.sfr_rse_he_id = p_rse_he_id_new
       AND lfr.lfr_rse_he_id = p_rse_he_id_1
       AND NOT EXISTS(SELECT 'exists in Section#2 only so create a default for Section#1 part from Section Frequencies for new Section'
                        FROM local_freqs b
                       WHERE b.lfr_atv_acty_area_code = lfr.lfr_atv_acty_area_code
                         AND b.lfr_ity_inv_code = lfr.lfr_ity_inv_code
                         AND b.lfr_rse_he_id = p_rse_he_id_2)
         ;
    --
    DELETE sect_freq1
     WHERE tt1_rse_he_id = p_rse_he_id_new
         ;
    --
    DELETE sect_freq2
     WHERE tt2_rse_he_id = p_rse_he_id_new
         ;
    --
    OPEN  c3;
    FETCH c3
     INTO l_message;
    IF c3%notfound
     THEN
        OPEN  c4;
        FETCH c4
         INTO l_message;
        CLOSE c4;
    END IF;
    CLOSE c3;
    /*
    ||STRUCTURAL PROJECTS
    */
    /*
    ||move schemes for the first original section onto the new section
    */
    UPDATE scheme_roads
       SET rse_he_id = p_rse_he_id_new
     WHERE rse_he_id = p_rse_he_id_1
         ;
    /*
    ||move schemes for the second original section onto the new section
    */
    UPDATE scheme_roads
       SET rse_he_id = p_rse_he_id_new
          ,start_point = nm3merge.get_new_chainage(l_rse_length_1
                                                  ,l_rse_length_2
                                                  ,l_sys_flag_2
                                                  ,2
                                                  ,p_new_starting_section
                                                  ,start_point
                                                  ,p_flip_cardinality_of_2)
          ,end_point = nm3merge.get_new_chainage(l_rse_length_1
                                                ,l_rse_length_2
                                                ,l_sys_flag_2
                                                ,2
                                                ,p_new_starting_section
                                                ,end_point
                                                ,p_flip_cardinality_of_2)
     WHERE rse_he_id = p_rse_he_id_2
         ;
    --
  END merge_data;

  --
  -----------------------------------------------------------------------------
  --**** UNMERGE PROCEDURES *****
  -----------------------------------------------------------------------------
  --
  PROCEDURE check_data_unmerge(p_id            IN     NUMBER -- rse_he_id to be unmerged
                              ,p_actioned_date IN     VARCHAR2
                              ,p_errors        IN OUT NUMBER
                              ,p_error_string  IN OUT VARCHAR2)
    IS
    --
    -- Checks that the user has supplied valid parameters.
    --
  BEGIN
    --
    maisplit.data_check(p_id, p_actioned_date, p_errors, p_error_string);
    --
  END check_data_unmerge;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE unmerge_data(p_id           IN NUMBER -- rse_he_id to be unmerged
                        ,p_rse_he_id_1  IN NUMBER
                        ,p_rse_he_id_2  IN NUMBER
                        ,p_history_date IN DATE)
    IS
    --
    l_length           NUMBER;
    l_table_name       VARCHAR2(32);
    l_rmmsflag         VARCHAR2(1) := hig.get_sysopt('RMMSFLAG');
    l_unactioned_date  VARCHAR2(22) := TO_CHAR(SYSDATE,'DD-MON-YYYY,HH24:MI:SS');
    --
    CURSOR c1
        IS
    SELECT rse_length
      FROM road_sections_all
     WHERE rse_he_id = p_rse_he_id_1
         ;
    --
  BEGIN
    /*
    ||ACTIVITIES
    */
    DELETE act_report_lines
     WHERE arl_are_report_id IN(SELECT are_report_id
                                  FROM activities_report
                                 WHERE are_rse_he_id = p_id)
         ;
    --
    DELETE activities_report
     WHERE are_rse_he_id = p_id
         ;
    --
    OPEN  c1;
    FETCH c1
     INTO l_length;
    CLOSE c1;
    /*
    ||REPAIRS AND DEFECTS
    */
    DELETE temp_undo_defect_edit;
    --
    INSERT
      INTO temp_undo_defect_edit
          (def_defect_id  -- a global temp table
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
      FROM defects
     WHERE def_rse_he_id = p_id
         ;
    /*
    ||Delete the defects belonging to the section
    ||which were created from the merge.
    */
    DELETE defects
     WHERE def_rse_he_id = p_id
         ;
    /*
    ||Set the compl dates to null for the
    ||original defects which were not completed before the merge. The
    ||records being updated at this point are those created as a history from
    ||the merge and the merge process set them as completed - the
    ||temp_undo_defect_edit table holds the true status of the defects.
    */
    UPDATE repairs
       SET rep_superseded_flag = 'N'
     WHERE rep_def_defect_id IN(SELECT def.def_defect_id
                                  FROM defects def
                                      ,temp_undo_defect_edit tmp
                                 WHERE def.def_superseded_id = tmp.def_defect_id
                                   AND tmp.def_rse_he_id = p_id
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
                             WHERE tmp.def_rse_he_id = p_id
                               AND tmp.def_date_compl IS NULL)
         ;
    --
    UPDATE defects
       SET def_last_updated_date = TO_DATE(l_unactioned_date,'DD-MON-YYYY,HH24:MI:SS')
          ,def_superseded_id = NULL
          ,def_superseded_flag = 'N'
          ,def_status_code = 'AVAILABLE'
     WHERE def_superseded_id IN(SELECT tmp.def_defect_id
                                  FROM temp_undo_defect_edit tmp
                                 WHERE tmp.def_rse_he_id = p_id
                                   AND tmp.def_date_compl IS NULL)
         ;
    --
    DELETE repairs r
     WHERE rep_def_defect_id IN(SELECT tmp.def_defect_id
                                  FROM temp_undo_defect_edit tmp)
         ;
    /*
    ||FREQUENCIES
    */
    DELETE local_freqs
     WHERE lfr_rse_he_id = p_id
         ;
    --
    DELETE section_freqs
     WHERE sfr_rse_he_id = p_id
         ;
    /*
    ||STRUCTURAL PROJECTS
    */
    maisplit.split_schemes(p_id
                          ,p_rse_he_id_1
                          ,p_rse_he_id_2
                          ,l_length);
    /*
    ||EXTERNAL ACTS
    */
    DELETE ext_act_road_usage
     WHERE exu_rse_he_id = p_id
       AND l_rmmsflag IN('3','4')
         ;
    --
    UPDATE ext_act_road_usage
       SET exu_sign_off_date = NULL
          ,exu_current = 'Y'
          ,exu_last_updated_date = TO_DATE(l_unactioned_date,'DD-MON-YYYY,HH24:MI:SS')
     WHERE exu_rse_he_id IN(p_rse_he_id_1, p_rse_he_id_2)
       AND l_rmmsflag IN('3','4')
         ;
    --
  END unmerge_data;
  --
END maimerge;
/
