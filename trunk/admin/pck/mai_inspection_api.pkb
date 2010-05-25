CREATE OR REPLACE PACKAGE BODY mai_inspection_api AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_inspection_api.pkb-arc   3.8   May 25 2010 14:50:10   cbaugh  $
--       Module Name      : $Workfile:   mai_inspection_api.pkb  $
--       Date into PVCS   : $Date:   May 25 2010 14:50:10  $
--       Date fetched Out : $Modtime:   May 25 2010 14:06:02  $
--       PVCS Version     : $Revision:   3.8  $
--
-----------------------------------------------------------------------------
--  Copyright (c) exor corporation ltd, 2007
-----------------------------------------------------------------------------
--
g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   3.8  $';
g_package_name  CONSTANT  varchar2(30)   := 'mai_inspection_api';
--
insert_error  EXCEPTION;
--
-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN varchar2 IS
BEGIN
   RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_are_to_insp_tab(pi_are_rec   IN     activities_report%ROWTYPE
                             ,pio_insp_tab IN OUT mai_inspection_api.insp_tab)
  IS
BEGIN
  --
  pio_insp_tab(pio_insp_tab.count+1).insp_record := pi_are_rec;
  --
END add_are_to_insp_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_activities_tab_to_insp_tab(pi_activities_tab IN     activities_tab
                                        ,pio_insp_tab      IN OUT mai_inspection_api.insp_tab)
  IS
BEGIN
  --
  IF pio_insp_tab.count > 0
   THEN
      pio_insp_tab(pio_insp_tab.count).insp_activities := pi_activities_tab;
  END IF;
  --
END add_activities_tab_to_insp_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_def_tab_to_insp_tab(pi_def_tab   IN     mai_inspection_api.def_tab
                                 ,pio_insp_tab IN OUT mai_inspection_api.insp_tab)
  IS
BEGIN
  --
  IF pio_insp_tab.count > 0
   THEN
      pio_insp_tab(pio_insp_tab.count).insp_defects := pi_def_tab;
  END IF;
  --
END add_def_tab_to_insp_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_comm_tab_to_insp_tab(pi_com_tab   IN     mai_inspection_api.com_tab
                                  ,pio_insp_tab IN OUT mai_inspection_api.insp_tab)
  IS
BEGIN
  --
  pio_insp_tab(pio_insp_tab.count).insp_comments := pi_com_tab;
  --
END add_comm_tab_to_insp_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_def_to_def_tab(pi_def_rec  IN     defects%ROWTYPE
                            ,pio_def_tab IN OUT mai_inspection_api.def_tab)
  IS
BEGIN
  --
  pio_def_tab(pio_def_tab.count+1).def_record := pi_def_rec;
  --
END add_def_to_def_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_def_attr_tab_to_def_tab(pi_def_attr_tab IN     mai_inspection_api.def_attr_tab
                                     ,pio_def_tab     IN OUT mai_inspection_api.def_tab)
  IS
BEGIN
  --
  IF pio_def_tab.count > 0
   THEN
      pio_def_tab(pio_def_tab.count).def_attribs := pi_def_attr_tab;
  END IF;
  --
END add_def_attr_tab_to_def_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_rep_tab_to_def_tab(pi_rep_tab  IN     mai_inspection_api.rep_tab
                                ,pio_def_tab IN OUT mai_inspection_api.def_tab)
  IS
BEGIN
  --
  IF pio_def_tab.count > 0
   THEN
      pio_def_tab(pio_def_tab.count).def_repairs := pi_rep_tab;
  END IF;
  --
END add_rep_tab_to_def_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_das_tab_to_def_tab(pi_das_tab  IN     mai_inspection_api.das_tab
                                ,pio_def_tab IN OUT mai_inspection_api.def_tab)
  IS
BEGIN
  --
  IF pio_def_tab.count > 0
   THEN
      pio_def_tab(pio_def_tab.count).def_assocs := pi_das_tab;
  END IF;
  --
END add_das_tab_to_def_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_rep_to_rep_tab(pi_rep_rec  IN     repairs%ROWTYPE
                            ,pio_rep_tab IN OUT mai_inspection_api.rep_tab)
  IS
BEGIN
  --
  pio_rep_tab(pio_rep_tab.count+1).rep_record := pi_rep_rec;
  --
END add_rep_to_rep_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_boq_tab_to_rep_tab(pi_boq_tab  IN     mai_inspection_api.boq_tab
                                ,pio_rep_tab IN OUT mai_inspection_api.rep_tab)
  IS
BEGIN
  --
  IF pio_rep_tab.count > 0
   THEN
      pio_rep_tab(pio_rep_tab.count).rep_boqs := pi_boq_tab;
  END IF;
  --
END add_boq_tab_to_rep_tab;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_boq_to_boq_tab(pi_boq_rec  IN     boq_items%ROWTYPE
                            ,pio_boq_tab IN OUT mai_inspection_api.boq_tab)
  IS
BEGIN
  --
  pio_boq_tab(pio_boq_tab.count+1).boq_record := pi_boq_rec;
  --
END add_boq_to_boq_tab;
--
-----------------------------------------------------------------------------
--
FUNCTION get_next_id(pi_seq_name IN VARCHAR2)
  RETURN NUMBER IS
  --
  lv_query_string varchar2(1000) := 'SELECT '||pi_seq_name||'.nextval FROM dual';
  lv_seq_no number;
  --
BEGIN
  --
  EXECUTE IMMEDIATE lv_query_string INTO lv_seq_no;
  --
  RETURN lv_seq_no;
  --
END get_next_id;
--
-----------------------------------------------------------------------------
--
FUNCTION get_insp(pi_are_report_id IN activities_report.are_report_id%TYPE)
  RETURN activities_report%ROWTYPE IS
  --
  lr_retval activities_report%ROWTYPE;
  --
BEGIN
  --
  SELECT *
    INTO lr_retval
    FROM activities_report
   WHERE are_report_id = pi_are_report_id
       ;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20001,'Invalid Inspection Id: '||pi_are_report_id);
  WHEN others
   THEN
      RAISE;
END get_insp;
--
-----------------------------------------------------------------------------
--
FUNCTION get_sta(pi_sta_item_code IN standard_items.sta_item_code%TYPE)
  RETURN standard_items%ROWTYPE IS
  --
  lr_retval standard_items%ROWTYPE;
  --
BEGIN
  --
  SELECT *
    INTO lr_retval
    FROM standard_items
   WHERE sta_item_code = pi_sta_item_code
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20033,'Cannot Find Specfied Standard Item.');
  WHEN others
   THEN
      RAISE;
END get_sta;
--
-----------------------------------------------------------------------------
--
FUNCTION get_dpr(pi_rep_action_cat     IN repairs.rep_action_cat%TYPE
                ,pi_atv_acty_area_code IN activities.atv_acty_area_code%TYPE
                ,pi_def_priority       IN defects.def_priority%TYPE
                ,pi_effective_date     IN DATE)
  RETURN defect_priorities%ROWTYPE IS
  --
  lr_retval defect_priorities%ROWTYPE;
  --
BEGIN
  --
  SELECT dpr.*
    INTO lr_retval
    FROM hig_codes
        ,defect_priorities dpr
   WHERE dpr.dpr_priority           = pi_def_priority
     AND dpr.dpr_atv_acty_area_code = pi_atv_acty_area_code
     AND dpr.dpr_action_cat         = hco_code
     AND hco_code                   = pi_rep_action_cat
     AND hco_domain                 = 'REPAIR_TYPE'
     AND pi_effective_date BETWEEN NVL(hco_start_date,pi_effective_date)
                               AND NVL(hco_end_date  ,pi_effective_date)
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN lr_retval;
  WHEN others
   THEN
      RAISE;
END get_dpr;
--
-----------------------------------------------------------------------------
--
FUNCTION get_initial_defect_status(pi_effective_date IN DATE)
  RETURN hig_status_codes.hsc_status_code%TYPE IS
  --
  lv_retval  hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  --
  SELECT hsc_status_code
    INTO lv_retval
    FROM hig_status_codes
   WHERE hsc_domain_code = 'DEFECTS'
     AND hsc_allow_feature1 = 'Y'
     AND pi_effective_date BETWEEN NVL(hsc_start_date,pi_effective_date)
                               AND NVL(hsc_end_date,pi_effective_date)
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20020,'Cannot Find Initial Defect Status.');
  WHEN others
   THEN
      RAISE;
END get_initial_defect_status;
--
-----------------------------------------------------------------------------
--
FUNCTION get_complete_defect_status(pi_effective_date IN DATE)
  RETURN hig_status_codes.hsc_status_code%TYPE IS
  --
  lv_retval  hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  --
  SELECT hsc_status_code
    INTO lv_retval
    FROM hig_status_codes
   WHERE hsc_domain_code = 'DEFECTS'
     AND hsc_allow_feature4 = 'Y'
     AND pi_effective_date BETWEEN NVL(hsc_start_date,pi_effective_date)
                               AND NVL(hsc_end_date,pi_effective_date)
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20021,'Cannot Find Complete Defect Status.');
  WHEN others
   THEN
      RAISE;
END get_complete_defect_status;
--
-----------------------------------------------------------------------------
--
FUNCTION get_superseded_defect_status(pi_effective_date IN DATE)
  RETURN hig_status_codes.hsc_status_code%TYPE IS
  --
  lv_retval  hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  --
  SELECT hsc_status_code
    INTO lv_retval
    FROM hig_status_codes
   WHERE hsc_domain_code = 'DEFECTS'
     AND hsc_allow_feature8 = 'Y'
     AND pi_effective_date BETWEEN NVL(hsc_start_date,pi_effective_date)
                               AND NVL(hsc_end_date,pi_effective_date)
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20021,'Cannot Find Complete Defect Status.');
  WHEN others
   THEN
      RAISE;
END get_superseded_defect_status;
--
-----------------------------------------------------------------------------
--
FUNCTION get_default_treatment(pi_defect_type IN defects.def_defect_code%TYPE
                              ,pi_priority    IN defects.def_priority%TYPE
                              ,pi_activity    IN activities.atv_acty_area_code%TYPE)
  RETURN default_treats.dft_tre_treat_code%TYPE IS
  --
  lv_retval  default_treats.dft_tre_treat_code%TYPE;
  --
BEGIN
  --
  SELECT dft_tre_treat_code 
    INTO lv_retval
    FROM default_treats
   WHERE dft_def_defect_code    = pi_defect_type
     AND dft_dpr_priority       = pi_priority
     AND dft_atv_acty_area_code = pi_activity
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN NULL;
  WHEN others
   THEN
      RAISE;
END get_default_treatment;
--
-----------------------------------------------------------------------------
--
FUNCTION get_admin_unit(pi_iit_ne_id IN nm_inv_items_all.iit_ne_id%TYPE
                       ,pi_rse_he_id IN nm_elements_all.ne_id%TYPE)
  RETURN nm_admin_units.nau_admin_unit%TYPE IS
  --
  lv_retval nm_admin_units.nau_admin_unit%TYPE;
  --
BEGIN
  IF pi_iit_ne_id IS NOT NULL
   THEN
      --
      lv_retval := nm3inv.get_inv_item_all(pi_iit_ne_id).iit_admin_unit;
      --
  ELSIF pi_rse_he_id IS NOT NULL
   THEN
      --
      lv_retval := nm3net.get_ne(pi_rse_he_id).ne_admin_unit;
      --
  END IF;
  --
  RETURN lv_retval;
  --
END get_admin_unit;
--
-----------------------------------------------------------------------------
--
FUNCTION get_insp_defects(pi_are_report_id   IN  activities_report.are_report_id%TYPE)
   RETURN defects_tab
    IS

  lt_insp_defects defects_tab;

BEGIN
  --
  SELECT *
    BULK COLLECT
    INTO lt_insp_defects
    FROM defects
   WHERE def_are_report_id = pi_are_report_id
       ;
         
  return lt_insp_defects;
  --
END get_insp_defects;
--
-----------------------------------------------------------------------------
--
FUNCTION defect_on_wol(pi_defect_id IN defects.def_defect_id%TYPE)
  RETURN BOOLEAN IS
  --
  lv_dummy NUMBER;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM dual
   WHERE EXISTS(SELECT 'x'
                  FROM repairs
                      ,work_order_lines
                 WHERE wol_def_defect_id = pi_defect_id
                   AND wol_def_defect_id = rep_def_defect_id
                   AND wol_rep_action_cat = rep_action_cat
                   AND rep_date_completed IS NULL)
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END defect_on_wol;
--
-----------------------------------------------------------------------------
--
FUNCTION ins_insp(pi_insp_rec activities_report%ROWTYPE)
  RETURN activities_report.are_report_id%TYPE IS
  --
  lv_report_id activities_report.are_report_id%TYPE;
  --
BEGIN
  /*
  ||Check The Report Id (Primary Key).
  */
  IF pi_insp_rec.are_report_id IS NULL
   THEN
      lv_report_id := get_next_id('are_report_id_seq');
  ELSE
      lv_report_id := pi_insp_rec.are_report_id;
  END IF;
  /*
  ||Insert The Inspection.
  */
  INSERT
    INTO activities_report
        (are_report_id
        ,are_rse_he_id
        ,are_batch_id
        ,are_created_date
        ,are_last_updated_date
        ,are_maint_insp_flag
        ,are_sched_act_flag
        ,are_date_work_done
        ,are_end_chain
        ,are_initiation_type
        ,are_insp_load_date
        ,are_peo_person_id_actioned
        ,are_peo_person_id_insp2
        ,are_st_chain
        ,are_surface_condition
        ,are_weather_condition
        ,are_wol_works_order_no)
  VALUES(lv_report_id
        ,pi_insp_rec.are_rse_he_id
        ,pi_insp_rec.are_batch_id
        ,pi_insp_rec.are_created_date
        ,pi_insp_rec.are_last_updated_date
        ,pi_insp_rec.are_maint_insp_flag
        ,pi_insp_rec.are_sched_act_flag
        ,pi_insp_rec.are_date_work_done
        ,pi_insp_rec.are_end_chain
        ,pi_insp_rec.are_initiation_type
        ,pi_insp_rec.are_insp_load_date
        ,pi_insp_rec.are_peo_person_id_actioned
        ,pi_insp_rec.are_peo_person_id_insp2
        ,pi_insp_rec.are_st_chain
        ,pi_insp_rec.are_surface_condition
        ,pi_insp_rec.are_weather_condition
        ,NULL);
  --
  IF SQL%rowcount != 1 THEN
    RAISE insert_error;
  END IF;
  --
  RETURN lv_report_id;
  --
EXCEPTION
  WHEN insert_error
   THEN
      raise_application_error(-20039, 'Error occured while creating Activities Report.');
  WHEN others
   THEN
      RAISE;
END ins_insp;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_insp_line(pi_report_id          IN activities_report.are_report_id%TYPE
                       ,pi_report_date        IN activities_report.are_created_date%TYPE
                       ,pi_atv_acty_area_code IN activities.atv_acty_area_code%TYPE) IS
BEGIN
  --
  INSERT
    INTO act_report_lines
        (arl_act_status
        ,arl_are_report_id
        ,arl_atv_acty_area_code
        ,arl_created_date
        ,arl_last_updated_date
        ,arl_not_seq_flag
        ,arl_report_id_part_of)
  SELECT 'C'
        ,pi_report_id
        ,pi_atv_acty_area_code
        ,pi_report_date
        ,pi_report_date
        ,NULL
        ,NULL
    FROM dual
   WHERE NOT EXISTS(SELECT 'x'
                      FROM act_report_lines
                     WHERE arl_are_report_id      = pi_report_id
                       AND arl_atv_acty_area_code = pi_atv_acty_area_code)
       ;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20041, 'Error Occured While Creating Activities Report Line : '||SQLERRM);
END ins_insp_line;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_insp_lines(pi_arl_tab IN act_report_lines_tab)
  IS
BEGIN
  /*
  ||Insert The Lines.
  */
  FORALL i IN 1 .. pi_arl_tab.COUNT
    INSERT
      INTO act_report_lines
    VALUES pi_arl_tab(i)
         ;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20041, 'Error Occured While Creating Activity Report Line(s) : '||SQLERRM);
END ins_insp_lines;
--
-----------------------------------------------------------------------------
--
FUNCTION ins_defect(pi_defect_rec defects%ROWTYPE)
  RETURN defects.def_defect_id%TYPE IS
  --
  lv_defect_id   defects.def_defect_id%TYPE;
  --
BEGIN
  /*
  ||Check The Defect Id (Primary Key).
  */
  IF pi_defect_rec.def_defect_id IS NULL
   THEN
      lv_defect_id := get_next_id('def_defect_id_seq');
  ELSE
      lv_defect_id := pi_defect_rec.def_defect_id;
  END IF;
  /*
  ||Insert The Defect.
  */
  INSERT 
    INTO defects 
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
        ,def_response_category) 
 VALUES (lv_defect_id
        ,pi_defect_rec.def_rse_he_id
        ,pi_defect_rec.def_iit_item_id
        ,pi_defect_rec.def_st_chain
        ,pi_defect_rec.def_are_report_id
        ,pi_defect_rec.def_atv_acty_area_code
        ,pi_defect_rec.def_siss_id
        ,pi_defect_rec.def_works_order_no
        ,pi_defect_rec.def_created_date
        ,pi_defect_rec.def_defect_code
        ,sysdate
        ,pi_defect_rec.def_orig_priority
        ,pi_defect_rec.def_priority
        ,pi_defect_rec.def_status_code
        ,'N'
        ,pi_defect_rec.def_area
        ,pi_defect_rec.def_are_id_not_found
        ,pi_defect_rec.def_coord_flag
        ,NULL
        ,NULL
        ,pi_defect_rec.def_defect_class
        ,pi_defect_rec.def_defect_descr
        ,pi_defect_rec.def_defect_type_descr
        ,pi_defect_rec.def_diagram_no
        ,pi_defect_rec.def_height
        ,pi_defect_rec.def_ident_code
        ,pi_defect_rec.def_ity_inv_code
        ,pi_defect_rec.def_ity_sys_flag
        ,pi_defect_rec.def_length
        ,pi_defect_rec.def_locn_descr
        ,pi_defect_rec.def_maint_wo
        ,pi_defect_rec.def_mand_adv
        ,pi_defect_rec.def_notify_org_id
        ,pi_defect_rec.def_number
        ,pi_defect_rec.def_per_cent
        ,pi_defect_rec.def_per_cent_orig
        ,pi_defect_rec.def_per_cent_rem
        ,pi_defect_rec.def_rechar_org_id
        ,pi_defect_rec.def_serial_no
        ,pi_defect_rec.def_skid_coeff
        ,pi_defect_rec.def_special_instr
        ,NULL
        ,pi_defect_rec.def_time_hrs
        ,pi_defect_rec.def_time_mins
        ,pi_defect_rec.def_update_inv
        ,pi_defect_rec.def_x_sect
        ,pi_defect_rec.def_easting
        ,pi_defect_rec.def_northing
        ,pi_defect_rec.def_response_category);
  --
  IF SQL%rowcount != 1 THEN
    RAISE insert_error;
  END IF;
  --
  RETURN lv_defect_id;
  --
EXCEPTION
  WHEN insert_error
   THEN
      raise_application_error(-20040, 'Error occured while creating Activities Report.');
  WHEN others
   THEN
      RAISE;
END ins_defect;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_repairs(pi_repair_tab IN repairs_tab)
  IS
BEGIN
  /*
  ||Insert The Repairs.
  */
  FORALL i IN 1 .. pi_repair_tab.COUNT
    INSERT
      INTO repairs
    VALUES pi_repair_tab(i)
         ;
  --
EXCEPTION
  WHEN DUP_VAL_ON_INDEX
   THEN
      raise_application_error(-20044,'Cannot Create More Than One Repair Of Each Repair Type');
  WHEN others
   THEN
      raise_application_error(-20041, 'Error Occured While Creating Repair(s) : '||SQLERRM);
END ins_repairs;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_boqs(pi_boq_tab IN boq_items_tab) IS
  --
  lt_boq_tab  boq_items_tab;
  --
BEGIN
  --
  lt_boq_tab := pi_boq_tab;
  /*
  ||Check The BOQ Id (Primary Key).
  */
  FOR i IN 1..lt_boq_tab.count LOOP
    --
    IF lt_boq_tab(i).boq_id IS NULL
     THEN
        lt_boq_tab(i).boq_id := get_next_id('boq_id_seq');
    END IF;
    --
  END LOOP;
  /*
  ||Insert The BOQs.
  */
  FORALL i IN 1 .. lt_boq_tab.COUNT
    INSERT
      INTO boq_items
    VALUES lt_boq_tab(i)
         ;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20042, 'Error Occured While Creating BOQs : '||SQLERRM);
END ins_boqs;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_doc_assocs(pi_doc_id     docs.doc_id%TYPE
                        ,pi_rec_id     doc_assocs.das_rec_id%TYPE
                        ,pi_table_name doc_assocs.das_table_name%TYPE) IS
                        
BEGIN

  INSERT
    INTO DOC_ASSOCS
        (das_doc_id
        ,das_rec_id
        ,das_table_name)
  VALUES(pi_doc_id,
         pi_rec_id,
         pi_table_name);
          
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20041, 'Error Occured While Creating DOC_ASSOCS Entry : '||SQLERRM);
END ins_doc_assocs;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_comment(pi_com_tab        com_tab
                     ,pi_rse_he_id      activities_report.are_rse_he_id%TYPE
                     ,pi_are_report_id  activities_report.are_report_id%TYPE) IS

  lv_table   VARCHAR2(10);
  
BEGIN

  /*
  ||Process all Comments
  */
  
  FOR i IN 1 .. pi_com_tab.count LOOP
    /*
    ||Insert DOCS entry.
    */
    lv_table := 'DOCS';
    --
    INSERT
      INTO DOCS
          (doc_id
          ,doc_title
          ,doc_category
          ,doc_dtp_code
          ,doc_date_issued
          ,doc_descr
          ,doc_reference_code)
    VALUES(pi_com_tab(i).com_doc_id
          ,pi_com_tab(i).com_title
          ,pi_com_tab(i).com_category
          ,pi_com_tab(i).com_dtp_code
          ,pi_com_tab(i).com_date_issued
          ,pi_com_tab(i).com_descr
          ,pi_com_tab(i).com_reference_code);
          
    /*
    ||Insert DOC_ASSOCS entry.
    */
    lv_table := 'DOC_ASSOCS';
    --
    ins_doc_assocs(pi_doc_id     =>pi_com_tab(i).com_doc_id
                  ,pi_rec_id     =>pi_rse_he_id
                  ,pi_table_name =>'ROAD_SEGMENTS_ALL');
    --
    ins_doc_assocs(pi_doc_id     =>pi_com_tab(i).com_doc_id
                  ,pi_rec_id     =>pi_are_report_id
                  ,pi_table_name =>'ACTIVITIES_REPORT');

  END LOOP;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20041, 'Error Occured While Creating '||lv_table||' Entry : '||SQLERRM);
END ins_comment;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_defect_doc(pi_das_tab      IN  das_tab) IS

  lv_table   VARCHAR2(10);
  
BEGIN

  /*
  ||Process all Comments
  */
  
  FOR i IN 1 .. pi_das_tab.count LOOP
  nm_debug.debug('Defect Assoc Doc Id = '||pi_das_tab(i).das_doc_id);
    /*
    ||Insert DOCS entry.
    */
    lv_table := 'DOCS';
    --
    INSERT
      INTO DOCS
          (doc_id
          ,doc_title
          ,doc_category
          ,doc_dtp_code
          ,doc_date_issued
          ,doc_file
          ,doc_dlc_dmd_id
          ,doc_dlc_id
          ,doc_descr
          ,doc_reference_code)
    VALUES(pi_das_tab(i).das_doc_id
          ,pi_das_tab(i).das_title
          ,pi_das_tab(i).das_category
          ,pi_das_tab(i).das_dtp_code
          ,pi_das_tab(i).das_date_issued
          ,pi_das_tab(i).das_file
          ,pi_das_tab(i).das_dlc_dmd_id
          ,pi_das_tab(i).das_dlc_id
          ,pi_das_tab(i).das_descr
          ,pi_das_tab(i).das_reference_code);
          
    /*
    ||Insert DOC_ASSOCS entry.
    */
    lv_table := 'DOC_ASSOCS';
    --
    ins_doc_assocs(pi_doc_id     =>pi_das_tab(i).das_doc_id
                  ,pi_rec_id     =>pi_das_tab(i).das_def_defect_id
                  ,pi_table_name =>'DEFECTS');
    --
  END LOOP;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20041, 'Error Occured While Creating '||lv_table||' Entry : '||SQLERRM);
END ins_defect_doc;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_asset(pi_item_type defects.def_ity_inv_code%TYPE
                       ,pi_item_id   nm_inv_items_all.iit_ne_id%TYPE)
  RETURN BOOLEAN IS
  --
  lv_nm3_inv_type  nm_inv_types_all.nit_inv_type%TYPE;
  lv_ft_id         NUMBER;
  lv_retval        BOOLEAN;
  lv_sql           nm3type.max_varchar2;
  --
  lr_inv_type  nm_inv_types_all%ROWTYPE;
  lr_nm3_asset nm_inv_items_all%ROWTYPE;
  --
BEGIN
  /*
  ||Translate The Two Character MAI Inv Code
  ||Into a 4 Character NM3 Asset Type.
  */
  BEGIN
    lv_nm3_inv_type := mai.translate_mai_inv_type(pi_item_type);
  EXCEPTION
    WHEN others
     THEN
        raise_application_error(-20003,'Cannot Translate Asset Type.');
  END;
  /*
  ||Get The Asset Type Details.
  */
  lr_inv_type := nm3get.get_nit(lv_nm3_inv_type);
  /*
  ||Check The Asset Exists.
  */
  IF lr_inv_type.nit_table_name IS NOT NULL
   THEN
      /*
      ||Build SQL To Check FT Asset.
      */
      lv_sql := 'SELECT '||lr_inv_type.nit_lr_ne_column_name
              ||'  FROM '||lr_inv_type.nit_table_name
              ||' WHERE '||lr_inv_type.nit_lr_ne_column_name||'='||pi_item_id;
      /*
      ||Execute SQL.
      */
      EXECUTE IMMEDIATE(lv_sql) INTO lv_ft_id;
      /*
      ||Check The Value Returned.
      */
      IF lv_ft_id IS NOT NULL
       THEN
          lv_retval := TRUE;
      ELSE
          lv_retval := FALSE;
      END IF;
      --
  ELSE
      /*
      ||Check nm3 Asset.
      */
      lr_nm3_asset := nm3inv.get_inv_item_all(pi_item_id);
      lv_retval := TRUE;
  END IF;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN others
   THEN
     RETURN FALSE;
END validate_asset;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_section(pi_rse_he_id IN nm_elements_all.ne_id%TYPE)
  RETURN road_sections%ROWTYPE IS
  --
  lv_retval road_sections%ROWTYPE;
  --
BEGIN
  --
  --check_network_security(pi_ne_id => pi_rse_he_id);
  --
  SELECT rse.*
    INTO lv_retval
    FROM road_sections rse
   WHERE rse.rse_he_id = pi_rse_he_id
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20005,'Invalid Section Specified.');
  WHEN others
   THEN
      RAISE;
END validate_section;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_user_id(pi_user_id        IN hig_users.hus_user_id%TYPE
                         ,pi_effective_date IN DATE)
  RETURN BOOLEAN IS
  --
  lv_dummy NUMBER;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM hig_users
   WHERE pi_effective_date BETWEEN NVL(hus_start_date,pi_effective_date)
                               AND NVL(hus_end_date-1,pi_effective_date)
     AND hus_user_id = pi_user_id
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_user_id;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_defect_status(pi_defect_rec     IN defects%ROWTYPE
                               ,pi_effective_date IN DATE)
  RETURN BOOLEAN IS
  --
  lv_retval  BOOLEAN := FALSE;
  --
BEGIN
  /*
  ||Defects Can Be Created With Either
  ||The Initial Or Completed Status Code.
  */
  IF pi_defect_rec.def_status_code = get_initial_defect_status(pi_effective_date => pi_effective_date)
   OR pi_defect_rec.def_status_code = get_complete_defect_status(pi_effective_date => pi_effective_date)
   THEN
      lv_retval := TRUE;
  END IF;
  --
  RETURN lv_retval;
  --
END validate_defect_status;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_chainage(pi_chainage   IN NUMBER
                           ,pi_rse_length IN NUMBER) IS
BEGIN
  --
  nm_debug.debug('Validate Chainage');
  nm_debug.debug('pi_chainage = '||pi_chainage);
  nm_debug.debug('pi_rse_length = '||pi_rse_length);
  IF pi_chainage < 0
   THEN
      --
      raise_application_error(-20006,'Value Is Less Than Zero.');
      --
  ELSIF pi_chainage > pi_rse_length
   THEN
      --
      raise_application_error(-20007,'Value Is Greater Than Section Length.');
      --
  END IF;
  --
END validate_chainage;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_initiation_type(pi_initiation_type IN activities_report.are_initiation_type%TYPE
                                 ,pi_effective_date  IN DATE)
  RETURN BOOLEAN IS
BEGIN
  --
  hig.valid_fk_hco(pi_hco_domain     => 'INITIATION_TYPE'
                  ,pi_hco_code       => pi_initiation_type
                  ,pi_effective_date => pi_effective_date);
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END validate_initiation_type;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_asset_activity(pi_inv_type        IN defects.def_ity_inv_code%TYPE
                                ,pi_maint_insp_flag IN activities.atv_maint_insp_flag%TYPE
                                ,pi_sys_flag        IN VARCHAR2
                                ,pi_activity        IN activities.atv_acty_area_code%TYPE)
  RETURN BOOLEAN IS
  --
  lv_dummy  NUMBER;
  lv_retval BOOLEAN := TRUE;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM activities
        ,mai_inv_activities
   WHERE mia_sys_flag           = pi_sys_flag
     AND mia_nit_inv_type       = pi_inv_type
     AND mia_atv_acty_area_code = pi_activity
     AND mia_sys_flag           = atv_dtp_flag
     AND mia_atv_acty_area_code = atv_acty_area_code
     AND atv_maint_insp_flag    = pi_maint_insp_flag
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_asset_activity;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_network_activity(pi_maint_insp_flag IN activities.atv_maint_insp_flag%TYPE
                                  ,pi_sys_flag        IN VARCHAR2
                                  ,pi_activity        IN activities.atv_acty_area_code%TYPE
                                  ,pi_effective_date  IN DATE)
  RETURN BOOLEAN IS
  --
  lv_dummy  NUMBER;
  lv_retval BOOLEAN := TRUE;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM activities
   WHERE atv_dtp_flag        = pi_sys_flag
     AND atv_maint_insp_flag = pi_maint_insp_flag
     AND atv_acty_area_code  = pi_activity
     AND pi_effective_date BETWEEN NVL(atv_start_date,pi_effective_date)
                               AND NVL(atv_end_date  ,pi_effective_date)
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_network_activity;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_weather_condition(pi_weather_condition IN activities_report.are_weather_condition%TYPE
                                   ,pi_effective_date    IN DATE)
  RETURN BOOLEAN IS
BEGIN
  --
  hig.valid_fk_hco(pi_hco_domain     => 'WEATHER_CONDITION'
                  ,pi_hco_code       => pi_weather_condition
                  ,pi_effective_date => pi_effective_date);
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END validate_weather_condition;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_surface_condition(pi_surface_condition IN activities_report.are_surface_condition%TYPE
                                   ,pi_effective_date    IN DATE)
  RETURN BOOLEAN IS
BEGIN
  --
  hig.valid_fk_hco(pi_hco_domain     => 'SURFACE_CONDITION'
                  ,pi_hco_code       => pi_surface_condition
                  ,pi_effective_date => pi_effective_date);
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END validate_surface_condition;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_asset_modification(pi_asset_modification IN defects.def_update_inv%TYPE
                                    ,pi_effective_date     IN DATE)
  RETURN BOOLEAN IS
BEGIN
  --
  hig.valid_fk_hco(pi_hco_domain     => 'ASSET_MODIFICATION'
                  ,pi_hco_code       => pi_asset_modification
                  ,pi_effective_date => pi_effective_date);
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END validate_asset_modification;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_maint_insp_flag(pi_maint_insp_flag IN VARCHAR2)
  RETURN BOOLEAN IS
BEGIN
  --
  IF pi_maint_insp_flag IN('S','D')
   THEN
      RETURN TRUE;
  ELSE
      RETURN FALSE;
  END IF;
  --
END validate_maint_insp_flag;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_defect_type(pi_activity       IN activities.atv_acty_area_code%TYPE
                             ,pi_sys_flag       IN VARCHAR2
                             ,pi_defect_type    IN def_types.dty_defect_code%TYPE
                             ,pi_effective_date IN DATE)
  RETURN BOOLEAN IS
  --
  lv_dummy  NUMBER;
  --
BEGIN
  /*
  ||Check The Parameters.
  */
  IF pi_activity IS NULL
   THEN
      --
      raise_application_error(-20016,'No Activity Supplied.');
      --
  ELSIF pi_sys_flag IS NULL
   THEN
      --
      raise_application_error(-20019,'No Sys Flag Supplied.');
      --
  ELSIF pi_effective_date IS NULL
   THEN
      --
      raise_application_error(-20008,'No Inspection Date Supplied.');
      --
  END IF;
  /*
  ||Check The Defect Type.
  */
  SELECT 1
    INTO lv_dummy
    FROM def_types
   WHERE dty_defect_code = pi_defect_type
     AND dty_dtp_flag    = pi_sys_flag
     AND dty_atv_acty_area_code = pi_activity
     AND pi_effective_date BETWEEN NVL(dty_start_date,pi_effective_date)
                               AND NVL(dty_end_date  ,pi_effective_date)
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_defect_type;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_priority(pi_priority           IN defects.def_priority%TYPE
                          ,pi_atv_acty_area_code IN activities.atv_acty_area_code%TYPE
                          ,pi_action_cat         IN repairs.rep_action_cat%TYPE DEFAULT 'P'
                          ,pi_effective_date     IN DATE)
  RETURN BOOLEAN IS
  --
  lv_dummy NUMBER;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM hig_codes
        ,defect_priorities
   WHERE dpr_priority           = pi_priority
     AND dpr_atv_acty_area_code = pi_atv_acty_area_code
     AND dpr_action_cat         = pi_action_cat
     AND dpr_priority           = hco_code
     AND hco_domain             = 'DEFECT_PRIORITIES'
     AND pi_effective_date BETWEEN NVL(hco_start_date,pi_effective_date)
                               AND NVL(hco_end_date  ,pi_effective_date)
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_priority;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_siss_id(pi_siss_id        IN standard_item_sub_sections.siss_id%TYPE
                         ,pi_effective_date IN DATE)
  RETURN BOOLEAN IS
  --
  lv_dummy NUMBER;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM standard_item_sub_sections
   WHERE pi_effective_date BETWEEN NVL(siss_start_date,pi_effective_date)
                               AND NVL(siss_end_date,pi_effective_date)
     AND siss_id = pi_siss_id
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_siss_id;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_treatment(pi_treatment          IN treatments.tre_treat_code%TYPE
                           ,pi_sys_flag           IN VARCHAR2
                           ,pi_atv_acty_area_code IN activities.atv_acty_area_code%TYPE
                           ,pi_defect_type        IN def_types.dty_defect_code%TYPE
                           ,pi_effective_date     IN DATE)
  RETURN BOOLEAN IS
  --
  lv_dummy  NUMBER;
  --
BEGIN
  /*
  ||Check The Parameters.
  */
  IF pi_defect_type IS NULL
   THEN
      --
      raise_application_error(-20024,'No Defect Type Supplied.');
      --
  ELSIF pi_atv_acty_area_code IS NULL
   THEN
      --
      raise_application_error(-20016,'No Activity Supplied.');
      --
  ELSIF pi_sys_flag IS NULL
   THEN
      --
      raise_application_error(-20019,'No Sys Flag Supplied.');
      --
  ELSIF pi_effective_date IS NULL
   THEN
      --
      raise_application_error(-20008,'No Inspection Date Supplied.');
      --
  END IF;
  /*
  ||Check The Treatment.
  */
  SELECT 1
    INTO lv_dummy
    FROM def_treats
        ,treatments
   WHERE tre_treat_code         = pi_treatment
     AND tre_treat_code         = dtr_tre_treat_code
     AND dtr_sys_flag           = pi_sys_flag
     AND dtr_dty_acty_area_code = pi_atv_acty_area_code
     AND dtr_dty_defect_code    = pi_defect_type
     AND pi_effective_date BETWEEN NVL(tre_start_date,pi_effective_date)
                               AND NVL(tre_end_date  ,pi_effective_date)
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_treatment;
--
-----------------------------------------------------------------------------
FUNCTION validate_doc_category(pi_hco_code        IN hig_codes.hco_code%TYPE
                              ,pi_effective_date  IN date)
  RETURN BOOLEAN IS
  --
  lv_dummy PLS_INTEGER;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM hig_codes
   WHERE hco_code                   = pi_hco_code
     AND hco_domain                 = 'DOC_CATEGORIES'
     AND pi_effective_date BETWEEN NVL(hco_start_date,pi_effective_date)
                               AND NVL(hco_end_date  ,pi_effective_date)
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END validate_doc_category;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_doc_type(pi_dtp_code        IN doc_types.dtp_code%TYPE
                          ,pi_effective_date  IN date)
  RETURN BOOLEAN IS
  --
  lv_dummy PLS_INTEGER;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM doc_types
   WHERE dtp_code = pi_dtp_code
     AND pi_effective_date BETWEEN NVL(dtp_start_date,pi_effective_date)
                               AND NVL(dtp_end_date  ,pi_effective_date)
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END validate_doc_type;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_file_location(pi_dlc_name  IN     doc_locations.dlc_name%TYPE
                               ,po_dlc_dmd_id   OUT doc_locations.dlc_dmd_id%TYPE
                               ,po_dlc_id       OUT doc_locations.dlc_id%TYPE)
  RETURN BOOLEAN IS
  --
  --
BEGIN
  --
  SELECT dlc_dmd_id, 
         dlc_id 
    INTO po_dlc_dmd_id,
         po_dlc_id
    FROM doc_locations
  WHERE dlc_name = pi_dlc_name
      ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END validate_file_location;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_insp_rec(pio_insp_rec IN OUT activities_report%ROWTYPE
                           ,po_sys_flag     OUT VARCHAR2)
  IS
  --
  lr_insp_rec  activities_report%ROWTYPE;
  lr_rse       road_sections%ROWTYPE;
  --
  lv_insp_init  hig_options.hop_value%TYPE := NVL(hig.get_sysopt('INSP_INIT'),'DUM');
  lv_insp_sdf   hig_options.hop_value%TYPE := NVL(hig.get_sysopt('INSP_SDF'),'D');
  --
BEGIN
  --
  lr_insp_rec := pio_insp_rec;
  /*
  ||Validate The Section.
  */
  IF lr_insp_rec.are_rse_he_id IS NULL
   THEN
      raise_application_error(-20004,'No Section Supplied.');
  ELSE
      lr_rse := validate_section(lr_insp_rec.are_rse_he_id);
  END IF;
  /*
  ||Default The Inspection Created Date.
  */
  IF lr_insp_rec.are_created_date IS NULL
   THEN
      lr_insp_rec.are_created_date := SYSDATE;
  END IF;
  --
  IF lr_insp_rec.are_last_updated_date IS NULL
   THEN
      lr_insp_rec.are_last_updated_date := lr_insp_rec.are_created_date;
  END IF;
  /*
  ||Default Or Validate The Start Chainage.
  */
  IF lr_insp_rec.are_st_chain IS NULL
   THEN
      lr_insp_rec.are_st_chain := 0;
  ELSE
      validate_chainage(pi_chainage   => lr_insp_rec.are_st_chain
                       ,pi_rse_length => lr_rse.rse_length);
  END IF;
  /*
  ||Default Or Validate The End Chainage.
  */
  IF lr_insp_rec.are_end_chain IS NULL
   THEN
      lr_insp_rec.are_end_chain := lr_rse.rse_length;
  ELSE
      validate_chainage(pi_chainage   => lr_insp_rec.are_end_chain
                       ,pi_rse_length => lr_rse.rse_length);
  END IF;
  /*
  ||Check Scheduled Activity Flag
  */
  IF lr_insp_rec.are_sched_act_flag IS NULL
   THEN
      lr_insp_rec.are_sched_act_flag := 'Y';
  END IF;
  /*
  ||Validate Inspection Date.
  */
  IF lr_insp_rec.are_date_work_done IS NULL
   THEN
      --
      raise_application_error(-20008,'No Inspection Date Supplied.');
      --
  ELSIF lr_insp_rec.are_date_work_done >= SYSDATE
   THEN
      --
      raise_application_error(-20009,'Inspection Date May Not Be Later Than Today.'); --(843,'M_MGR')
      --
  end if;
  /*
  ||Validate Inspectors User Id.
  */
  IF NOT validate_user_id(pi_user_id        => lr_insp_rec.are_peo_person_id_actioned
                         ,pi_effective_date => lr_insp_rec.are_date_work_done)
   THEN
      --
      raise_application_error(-20010,'Invalid User Id Specified For Inspector.');
      --
  END IF;
  /*
  ||Validate Second Inspectors User Id.
  */
  IF lr_insp_rec.are_peo_person_id_insp2 IS NOT NULL
   AND NOT validate_user_id(pi_user_id        => lr_insp_rec.are_peo_person_id_insp2
                           ,pi_effective_date => lr_insp_rec.are_date_work_done)
   THEN
      --
      raise_application_error(-20011,'Invalid User Id Specified For Second Inspector.');
      --
  END IF;
  /*
  ||Validate Or Default The Initiation Type.
  */
  IF lr_insp_rec.are_initiation_type IS NULL
   THEN
      lr_insp_rec.are_initiation_type := lv_insp_init;
  END IF;
  --
  IF NOT validate_initiation_type(pi_initiation_type => lr_insp_rec.are_initiation_type
                                 ,pi_effective_date  => lr_insp_rec.are_date_work_done)
   THEN
      raise_application_error(-20012,'Invalid Initiation Type Specified.');
  END IF;
  --
  /*
  ||Validate Or Default The Safety/Detailed Flag.
  */
  IF lr_insp_rec.are_maint_insp_flag IS NULL
   THEN
      lr_insp_rec.are_maint_insp_flag := lv_insp_sdf;
  END IF;
  --
  IF NOT validate_maint_insp_flag(lr_insp_rec.are_maint_insp_flag)
   THEN
      raise_application_error(-20013,'Invalid Safety/Detailed Flag Specified.');
  END IF;
  /*
  ||Validate Weather Condition.
  */
  IF lr_insp_rec.are_weather_condition IS NOT NULL
   THEN
      IF NOT validate_weather_condition(pi_weather_condition => lr_insp_rec.are_weather_condition
                                       ,pi_effective_date    => lr_insp_rec.are_date_work_done)
       THEN
          raise_application_error(-20015,'Invalid Weather Condition Specified.');
      END IF;
  END IF;
  /*
  ||Validate Surface Condition.
  */
  IF lr_insp_rec.are_surface_condition IS NOT NULL
   THEN
      IF NOT validate_surface_condition(pi_surface_condition => lr_insp_rec.are_surface_condition
                                       ,pi_effective_date    => lr_insp_rec.are_date_work_done)
       THEN
          raise_application_error(-20015,'Invalid Road Surface Condition Specified.');
      END IF;
  END IF;
  /*
  ||Assign The Validated Record To The Output Record.
  */
  pio_insp_rec := lr_insp_rec;
  po_sys_flag := lr_rse.rse_sys_flag;
  --
END validate_insp_rec;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_defect_rec(pi_are_report_id       IN     activities_report.are_report_id%TYPE
                             ,pi_are_rse_he_id       IN     activities_report.are_rse_he_id%TYPE
                             ,pi_are_date_work_done  IN     activities_report.are_date_work_done%TYPE
                             ,pi_are_maint_insp_flag IN     activities_report.are_maint_insp_flag%TYPE
                             ,pi_def_attr_tab        IN     def_attr_tab
                             ,pi_defect_rec          IN OUT defects%ROWTYPE)
  IS
  --
  lr_rse         road_sections%ROWTYPE;
  lr_defect_rec  defects%ROWTYPE := pi_defect_rec;
  --
  lv_siss  hig_options.hop_value%TYPE := NVL(hig.get_sysopt('DEF_SISS'),'ALL');
  --
  lv_def_attr1 VARCHAR2(254);
  lv_def_attr2 VARCHAR2(254);
  lv_def_attr3 VARCHAR2(254);
  lv_def_attr4 VARCHAR2(254);
  --
  PROCEDURE process_def_attr(pi_def_type  IN def_types.dty_defect_code%TYPE
                            ,pi_activity  IN def_types.dty_atv_acty_area_code%TYPE
                            ,pi_sys_flag  IN def_types.dty_dtp_flag%TYPE
                            ,pi_def_attr1 IN VARCHAR2
                            ,pi_def_attr2 IN VARCHAR2
                            ,pi_def_attr3 IN VARCHAR2
                            ,pi_def_attr4 IN VARCHAR2) IS
    --
    lr_def_types  def_types%ROWTYPE;
    lv_attr       VARCHAR2(20);
    --
    PROCEDURE set_attribute(pi_column IN VARCHAR2
                           ,pi_value  IN VARCHAR2)
      IS
      --
      lv_data_type  all_tab_columns.data_type%TYPE;
      lv_column_assign VARCHAR2(100) := 'BEGIN mai_inspection_api.gr_defect_rec.'||pi_column||' := ';
      --
    BEGIN
      nm_debug.debug('ATTR Column = '||pi_column);
      nm_debug.debug('ATTR Value = '||pi_value);
      /*
      ||Get The Datatype Of The Column.
      */
      SELECT data_type
        INTO lv_data_type
        FROM all_tab_columns
       WHERE table_name  = 'DEFECTS'
         AND column_name = pi_column
         AND owner = hig.get_application_owner
           ;
      /*
      ||Set The Value.
      */
      nm_debug.debug('ATTR Datatype = '||lv_data_type);

      IF lv_data_type = 'NUMBER'
       THEN
          --
          EXECUTE IMMEDIATE lv_column_assign||'TO_NUMBER('||pi_value||'); END;';
          --
      ELSIF lv_data_type = 'DATE'
       THEN
          --
          EXECUTE IMMEDIATE lv_column_assign||'TO_DATE('||nm3flx.string(pi_value)
                                                   ||','||nm3flx.string('DD-MON-YYYY')||');';
          --
      ELSE
          --
          EXECUTE IMMEDIATE lv_column_assign||pi_value||';';
          --
      END IF;
      --
    EXCEPTION
      WHEN others
       THEN
          raise_application_error(-20045,'Invalid Defect Attribute Value Specified. ['||lv_attr||']');
    END set_attribute;
  BEGIN
    /*
    ||Set The Package Global Defect Record.
    ||This Is Used Because The Dynamic SQL
    ||Used To Set The Attribute Values Needs
    ||To Be Able To See The Record It Is Updating.
    */
    gr_defect_rec := lr_defect_rec;
    /*
    ||Get Attribute Details
    */
    SELECT *
      INTO lr_def_types
      FROM def_types
     WHERE dty_defect_code        = pi_def_type
       AND dty_atv_acty_area_code = pi_activity
       AND dty_dtp_flag           = pi_sys_flag
         ;
    /*
    ||Validate The Attributes
    ||And Assign To Defect Record.
    */
    IF lr_def_types.dty_hh_attribute_1 IS NOT NULL
     AND pi_def_attr1 IS NOT NULL
     THEN
        lv_attr := lr_def_types.dty_hh_attri_text_1;
        set_attribute(pi_column => lr_def_types.dty_hh_attribute_1
                     ,pi_value  => pi_def_attr1);
    END IF;
    --
    IF lr_def_types.dty_hh_attribute_2 IS NOT NULL
     AND pi_def_attr2 IS NOT NULL
     THEN
        lv_attr := lr_def_types.dty_hh_attri_text_2;
        set_attribute(pi_column => lr_def_types.dty_hh_attribute_2
                     ,pi_value  => pi_def_attr2);
    END IF;
    --
    IF lr_def_types.dty_hh_attribute_3 IS NOT NULL
     AND pi_def_attr3 IS NOT NULL
     THEN
        lv_attr := lr_def_types.dty_hh_attri_text_3;
        set_attribute(pi_column => lr_def_types.dty_hh_attribute_3
                     ,pi_value  => pi_def_attr3);
    END IF;
    --
    IF lr_def_types.dty_hh_attribute_4 IS NOT NULL
     AND pi_def_attr4 IS NOT NULL
     THEN
        lv_attr := lr_def_types.dty_hh_attri_text_4;
        set_attribute(pi_column => lr_def_types.dty_hh_attribute_4
                     ,pi_value  => pi_def_attr4);
    END IF;
    /*
    ||The Attribute Values Have Been Set In
    ||The Package Global Record, Now Update
    ||The Local Record And Initialise The
    ||Global One.
    */
    lr_defect_rec := gr_defect_rec;
    gr_defect_rec := NULL;
    --
  END process_def_attr;
BEGIN
  --
  nm_debug.debug('Validate Defect');
  /*
  ||Validate/Default The Inspection Id.
  */
  nm_debug.debug('Insp Id');
  IF lr_defect_rec.def_are_report_id IS NULL
   OR lr_defect_rec.def_are_report_id != pi_are_report_id
   THEN
      lr_defect_rec.def_are_report_id := pi_are_report_id;
  END IF;
  /*
  ||Validate/Default The Section.
  */
  nm_debug.debug('Section');
  IF lr_defect_rec.def_rse_he_id IS NULL
   THEN
      --
      lr_defect_rec.def_rse_he_id := pi_are_rse_he_id;
      --
  ELSIF lr_defect_rec.def_rse_he_id != pi_are_rse_he_id
   THEN
      --
      raise_application_error(-20038,'Defect Section Must Match The Inspection Section.');
      --
  ELSE
      --
      lr_rse := validate_section(lr_defect_rec.def_rse_he_id);
      lr_defect_rec.def_ity_sys_flag := lr_rse.rse_sys_flag;
      --
  END IF;
  /*
  ||Validate Activity Code.
  */
  nm_debug.debug('Activity');
  IF lr_defect_rec.def_iit_item_id IS NOT NULL
   THEN
      IF NOT validate_asset_activity(pi_inv_type        => lr_defect_rec.def_ity_inv_code
                                    ,pi_maint_insp_flag => pi_are_maint_insp_flag
                                    ,pi_sys_flag        => lr_rse.rse_sys_flag
                                    ,pi_activity        => lr_defect_rec.def_atv_acty_area_code)
       THEN
          raise_application_error(-20017,'Invalid Asset Activity Code Supplied.');
      END IF;
  ELSE
      IF NOT validate_network_activity(pi_maint_insp_flag => pi_are_maint_insp_flag
                                      ,pi_sys_flag        => lr_rse.rse_sys_flag
                                      ,pi_activity        => lr_defect_rec.def_atv_acty_area_code
                                      ,pi_effective_date  => pi_are_date_work_done)
       THEN
          raise_application_error(-20018,'Invalid Network Activity Code Supplied.');
      END IF;
  END IF;
  /*
  ||Validate Defect Type.
  */
  nm_debug.debug('Defect Type');
  IF lr_defect_rec.def_defect_code IS NULL
   THEN
      raise_application_error(-20024,'No Defect Type Supplied.');
  ELSE
     IF NOT validate_defect_type(pi_activity       => lr_defect_rec.def_atv_acty_area_code
                                ,pi_sys_flag       => lr_rse.rse_sys_flag
                                ,pi_defect_type    => lr_defect_rec.def_defect_code
                                ,pi_effective_date => pi_are_date_work_done)
      THEN
         raise_application_error(-20025,'Invalid Defect Type Supplied.');
     END IF;
  END IF;
  /*
  ||Default  SISS Code.
  */
  nm_debug.debug('SISS');
  IF lr_defect_rec.def_siss_id IS NULL
   THEN
      lr_defect_rec.def_siss_id := lv_siss;
  END IF;
  --
  IF NOT validate_siss_id(pi_siss_id        => lr_defect_rec.def_siss_id
                         ,pi_effective_date => pi_are_date_work_done)
   THEN
      --
      raise_application_error(-20028,'Invalid SISS Id Specified.');
      --
  END IF;
  /*
  ||Validate Priority.
  */
  nm_debug.debug('Priority');
  IF lr_defect_rec.def_priority IS NULL
   THEN
      --
      raise_application_error(-20026,'No Priority Specified.');
      --
  END IF;
  --
  IF NOT validate_priority(pi_priority           => lr_defect_rec.def_priority
                          ,pi_atv_acty_area_code => lr_defect_rec.def_atv_acty_area_code
                          ,pi_effective_date     => pi_are_date_work_done)
   THEN
      --
      raise_application_error(-20027,'Invalid Priority Specified. Priority ['||lr_defect_rec.def_priority
                                   ||'] Activity ['||lr_defect_rec.def_atv_acty_area_code||']');
      --
  END IF;
  lr_defect_rec.def_orig_priority := lr_defect_rec.def_priority;
  /*
  ||Validate The Asset Modification Flag.
  */
  IF lr_defect_rec.def_update_inv IS NOT NULL
   THEN
      IF NOT validate_asset_modification(pi_asset_modification => lr_defect_rec.def_update_inv
                                        ,pi_effective_date     => pi_are_date_work_done)
       THEN
          raise_application_error(-20001,'Invalid Asset Modification Flag Specified.');
      END IF;
  END IF;
  /*
  ||Set The Created Date Fields
  */
  nm_debug.debug('Dates');
  IF lr_defect_rec.def_created_date IS NULL
   THEN
      lr_defect_rec.def_created_date := TRUNC(pi_are_date_work_done);
      lr_defect_rec.def_time_hrs     := 0;
      lr_defect_rec.def_time_mins    := 0;
  END IF;
  /*
  ||Default / Validate Defect Status.
  */
  nm_debug.debug('Status');
  IF lr_defect_rec.def_status_code IS NULL
   THEN
      /*
      ||If A Completion Date Has Been Supplied
      ||Set The Status To Complete, Otherwise
      ||Set The Status To Available.
      */
      IF lr_defect_rec.def_date_compl IS NULL
       THEN
          lr_defect_rec.def_status_code := get_initial_defect_status(pi_effective_date => pi_are_date_work_done);
      ELSE
          lr_defect_rec.def_status_code := get_complete_defect_status(pi_effective_date => pi_are_date_work_done);
      END IF;
  END IF;
  --
  IF lr_defect_rec.def_status_code = get_complete_defect_status(pi_effective_date => pi_are_date_work_done)
   AND lr_defect_rec.def_date_compl IS NULL
   THEN
      lr_defect_rec.def_date_compl := lr_defect_rec.def_created_date;
  END IF;
  --
  IF NOT validate_defect_status(pi_defect_rec     => lr_defect_rec
                               ,pi_effective_date => pi_are_date_work_done)
   THEN
      --
      raise_application_error(-20022,'Invalid Defect Status Specified.');
      --
  END IF;
  /*
  ||Assign The Attributes.
  */
  CASE
    WHEN pi_def_attr_tab.count = 1
     THEN
        lv_def_attr1 := pi_def_attr_tab(1);
    WHEN pi_def_attr_tab.count = 2
     THEN
        lv_def_attr1 := pi_def_attr_tab(1);
        lv_def_attr2 := pi_def_attr_tab(2);
    WHEN pi_def_attr_tab.count = 3
     THEN
        lv_def_attr1 := pi_def_attr_tab(1);
        lv_def_attr2 := pi_def_attr_tab(2);
        lv_def_attr3 := pi_def_attr_tab(3);
    WHEN pi_def_attr_tab.count >= 4
     THEN
        lv_def_attr1 := pi_def_attr_tab(1);
        lv_def_attr2 := pi_def_attr_tab(2);
        lv_def_attr3 := pi_def_attr_tab(3);
        lv_def_attr4 := pi_def_attr_tab(4);
  END CASE;
  --
  process_def_attr(pi_def_type  => gr_defect_rec.def_defect_code
                  ,pi_activity  => gr_defect_rec.def_atv_acty_area_code
                  ,pi_sys_flag  => lr_rse.rse_sys_flag
                  ,pi_def_attr1 => lv_def_attr1
                  ,pi_def_attr2 => lv_def_attr2
                  ,pi_def_attr3 => lv_def_attr3
                  ,pi_def_attr4 => lv_def_attr4);
  nm_debug.debug('Defect Validation Complete');
  /*
  ||Assign Any Changes To The Defect To The IN/OUT Parameter.
  */
  pi_defect_rec := lr_defect_rec;
  --
END validate_defect_rec;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_repair_boqs(pi_def_defect_id      IN     defects.def_defect_id%TYPE
                              ,pi_rep_action_cat     IN     repairs.rep_action_cat%TYPE
                              ,pi_rep_created_date   IN     repairs.rep_created_date%TYPE
                              ,pi_admin_unit         IN     nm_admin_units.nau_admin_unit%TYPE
                              ,pi_rep_tre_treat_code IN     treatments.tre_treat_code%TYPE
                              ,pi_atv_acty_area_code IN     activities.atv_acty_area_code%TYPE
                              ,pi_def_defect_code    IN     defects.def_defect_code%TYPE
                              ,pi_sys_flag           IN     VARCHAR2
                              ,po_error_flag            OUT VARCHAR2
                              ,pio_boq_tab           IN OUT boq_tab)
  IS
  --
  lt_boq_tab       boq_tab;
  lt_tre_boqs_tab  mai.tre_boqs_tab;
  --
  lr_sta  standard_items%ROWTYPE;
  --
  lv_error_flag  VARCHAR2(1) := 'N';
  --
  lv_usetremodd   hig_options.hop_value%TYPE := hig.GET_SYSOPT('USETREMODD');
  lv_usetremodl   hig_options.hop_value%TYPE := hig.GET_SYSOPT('USETREMODL');
  lv_tremodlev    hig_options.hop_value%TYPE := hig.get_sysopt('TREMODLEV');
  lv_perc_item    hig_option_values.hov_value%TYPE := hig.get_sysopt('PERC_ITEM');
  --
BEGIN
  nm_debug.debug('Validating Repair BOQs for defect('||pi_def_defect_id||')');
  nm_debug.debug('BOQ count ='||pio_boq_tab.count);
  /*
  ||If BOQs Have Been Provided Then Validate Them
  ||Otherwise If The System Is Configured To Enforce
  ||Treatment Models Check For A Valid Model And
  ||Apply It.
  */
  IF pio_boq_tab.count > 0
   THEN
      --
      lt_boq_tab := pio_boq_tab;
      --
      FOR i IN 1..lt_boq_tab.COUNT LOOP
        --
        BEGIN
          --
          lt_boq_tab(i).boq_record.boq_work_flag    := 'D';
          lt_boq_tab(i).boq_record.boq_defect_id    := pi_def_defect_id;
          lt_boq_tab(i).boq_record.boq_wol_id       := 0;
          lt_boq_tab(i).boq_record.boq_date_created := pi_rep_created_date;
          /*
          ||Validate Standard Item Code.
          */
          IF lt_boq_tab(i).boq_record.boq_sta_item_code IS NOT NULL
           THEN
              lr_sta := get_sta(pi_sta_item_code => lt_boq_tab(i).boq_record.boq_sta_item_code);
              IF lr_sta.sta_unit = lv_perc_item
               THEN
                  raise_application_error(-20099,'Parent BOQs Based On Percentage Item Codes Are Not Supported.');
              END IF;
          ELSE
              raise_application_error(-20032,'Invalid Standard Item Code Specified.');
          END IF;
          lt_boq_tab(i).boq_record.boq_item_name := lr_sta.sta_item_name;
          /*
          ||Check/Default Dimentions.
          */
          IF lt_boq_tab(i).boq_record.boq_est_dim1 IS NULL
           THEN
              lt_boq_tab(i).boq_record.boq_est_dim1 := 0;
          END IF;
          --
          IF lr_sta.sta_dim2_text IS NOT NULL
           AND lt_boq_tab(i).boq_record.boq_est_dim2 IS NULL
           THEN
              lt_boq_tab(i).boq_record.boq_est_dim2 := 1;
          END IF;
          --
          IF lr_sta.sta_dim3_text IS NOT NULL
           AND lt_boq_tab(i).boq_record.boq_est_dim3 IS NULL
           THEN
              lt_boq_tab(i).boq_record.boq_est_dim3 := 1;
          END IF;
          --
          /*
          ||Set Estimated Quantity.
          */
          lt_boq_tab(i).boq_record.boq_est_quantity := lt_boq_tab(i).boq_record.boq_est_dim1
                                            * NVL(lt_boq_tab(i).boq_record.boq_est_dim2,1)
                                            * NVL(lt_boq_tab(i).boq_record.boq_est_dim3,1);
          /*
          ||Check Quantity.
          */
          IF lt_boq_tab(i).boq_record.boq_est_quantity < lr_sta.sta_min_quantity
           AND lt_boq_tab(i).boq_record.boq_est_quantity != 0
           THEN
              raise_application_error(-20035,'Estimated Quantity Is Below The Minimum Quantity.');
          END IF;
          --
          IF lt_boq_tab(i).boq_record.boq_est_quantity > lr_sta.sta_max_quantity
           AND lt_boq_tab(i).boq_record.boq_est_quantity != 0
           THEN
              raise_application_error(-20036,'Estimated Quantity Is Above The Maximum Quantity.');
          END IF;
          /*
          ||Calculate Estimated Labour
          */
          lt_boq_tab(i).boq_record.boq_est_labour := lt_boq_tab(i).boq_record.boq_est_quantity * NVL(lr_sta.sta_labour_units,0);
          /*
          ||Validate Estimated Rate.
          */
          lt_boq_tab(i).boq_record.boq_est_rate := lr_sta.sta_rate;
          /*
          ||Validate Estimated Cost.
          */
          IF lt_boq_tab(i).boq_record.boq_est_cost IS NULL
           OR lt_boq_tab(i).boq_record.boq_est_cost != ROUND((lt_boq_tab(i).boq_record.boq_est_rate * lt_boq_tab(i).boq_record.boq_est_quantity),2)
           THEN
              lt_boq_tab(i).boq_record.boq_est_cost := ROUND((lt_boq_tab(i).boq_record.boq_est_rate * lt_boq_tab(i).boq_record.boq_est_quantity),2);
          END IF;
          --
        EXCEPTION
          WHEN others
           THEN
              lv_error_flag := 'Y';
              lt_boq_tab(i).boq_error := SQLERRM;
        END;
      END LOOP;
      --
  ELSE
      IF((pi_sys_flag = 'D' and lv_usetremodd = 'Y') OR
         (pi_sys_flag = 'L' and lv_usetremodl = 'Y'))
       THEN
          --
          mai.get_tre_boqs(pi_admin_unit         => pi_admin_unit
                          ,pi_treat_code         => pi_rep_tre_treat_code
                          ,pi_atv_acty_area_code => pi_atv_acty_area_code
                          ,pi_defect_code        => pi_def_defect_code
                          ,pi_sys_flag           => pi_sys_flag
                          ,po_results            => lt_tre_boqs_tab);
          --
          FOR i IN 1..lt_tre_boqs_tab.count LOOP
            --
            lt_boq_tab(i).boq_record.boq_id             := get_next_id('boq_id_seq');
            lt_boq_tab(i).boq_record.boq_work_flag      := 'D';
            lt_boq_tab(i).boq_record.boq_defect_id      := pi_def_defect_id;
            lt_boq_tab(i).boq_record.boq_rep_action_cat := pi_rep_action_cat;
            lt_boq_tab(i).boq_record.boq_wol_id         := 0;
            lt_boq_tab(i).boq_record.boq_date_created   := pi_rep_created_date;
            lt_boq_tab(i).boq_record.boq_sta_item_code  := lt_tre_boqs_tab(i).boq_sta_item_code;
            lt_boq_tab(i).boq_record.boq_item_name      := lt_tre_boqs_tab(i).sta_item_name;
            lt_boq_tab(i).boq_record.boq_est_dim1       := lt_tre_boqs_tab(i).boq_est_dim1;
            lt_boq_tab(i).boq_record.boq_est_dim2       := lt_tre_boqs_tab(i).boq_est_dim2;
            lt_boq_tab(i).boq_record.boq_est_dim3       := lt_tre_boqs_tab(i).boq_est_dim3;
            lt_boq_tab(i).boq_record.boq_est_quantity   := lt_tre_boqs_tab(i).boq_est_quantity;
            lt_boq_tab(i).boq_record.boq_est_rate       := lt_tre_boqs_tab(i).boq_est_rate;
            lt_boq_tab(i).boq_record.boq_est_cost       := lt_tre_boqs_tab(i).boq_est_cost;
            lt_boq_tab(i).boq_record.boq_est_labour     := lt_tre_boqs_tab(i).boq_est_labour;
            --
          END LOOP;
      END IF;
  END IF;
  /*
  ||Assign The Validated Table To The Output Table.
  */
  po_error_flag := lv_error_flag;
  pio_boq_tab := lt_boq_tab;
  --
END validate_repair_boqs;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_repairs(pi_insp_rec    IN     activities_report%ROWTYPE
                          ,pi_defect_rec  IN     defects%ROWTYPE
                          ,pi_admin_unit  IN     hig_admin_units.hau_admin_unit%TYPE
                          ,po_error_flag     OUT VARCHAR2
                          ,pio_repair_tab IN OUT rep_tab)
  IS
  --
  lt_rep_tab   rep_tab;
  lt_boq_tab   boq_tab;
  --
  lr_defect_priorities  defect_priorities%ROWTYPE;
  lr_rse                road_sections%ROWTYPE;
  --
  lv_action_cat  repairs.rep_action_cat%TYPE;
  lv_repsetperd  hig_options.hop_value%TYPE := hig.GET_SYSOPT('REPSETPERD');
  lv_repsetperl  hig_options.hop_value%TYPE := hig.GET_SYSOPT('REPSETPERL');
  lv_dummy       NUMBER;
  --
  lv_rep_error_flag  VARCHAR2(1) := 'N';
  lv_boq_error_flag  VARCHAR2(1) := 'N';
  --
BEGIN
  --
  lt_rep_tab := pio_repair_tab;
  --
  FOR i IN 1..lt_rep_tab.count LOOP
    /*
    ||Validate The Repair.
    */
    BEGIN
      /*
      ||Default The Section.
      */
      lt_rep_tab(i).rep_record.rep_rse_he_id := pi_defect_rec.def_rse_he_id;
      --
      lr_rse := validate_section(lt_rep_tab(i).rep_record.rep_rse_he_id);
      /*
      ||Default Defect Id.
      */
      lt_rep_tab(i).rep_record.rep_def_defect_id := pi_defect_rec.def_defect_id;
      /*
      ||Default Activity Code.
      */
      lt_rep_tab(i).rep_record.rep_atv_acty_area_code := pi_defect_rec.def_atv_acty_area_code;
      /*
      ||Default Date Created And Date Updated.
      */
      lt_rep_tab(i).rep_record.rep_created_date      := pi_defect_rec.def_created_date;
      lt_rep_tab(i).rep_record.rep_last_updated_date := pi_defect_rec.def_created_date;
      /*
      ||Default Superceded Flag.
      */
      lt_rep_tab(i).rep_record.rep_superseded_flag   := 'N';
      /*
      ||Validate Action Category.
      */
      IF lt_rep_tab(i).rep_record.rep_action_cat IS NULL
       THEN
          raise_application_error(-20029,'No Repair Action Category Specified.');
      END IF;
      --
      lr_defect_priorities := get_dpr(pi_rep_action_cat     => lt_rep_tab(i).rep_record.rep_action_cat
                                     ,pi_atv_acty_area_code => lt_rep_tab(i).rep_record.rep_atv_acty_area_code
                                     ,pi_def_priority       => pi_defect_rec.def_priority
                                     ,pi_effective_date     => pi_insp_rec.are_date_work_done);
      --
      IF lr_defect_priorities.dpr_action_cat IS NULL
       THEN
          raise_application_error(-20030,'Invalid Repair Action Category Specified.');
      END IF;
      /*
      ||Validate Treatment.
      */
      IF lt_rep_tab(i).rep_record.rep_tre_treat_code IS NOT NULL
       THEN
          IF NOT validate_treatment(pi_treatment          => lt_rep_tab(i).rep_record.rep_tre_treat_code
                                   ,pi_sys_flag           => lr_rse.rse_sys_flag
                                   ,pi_atv_acty_area_code => lt_rep_tab(i).rep_record.rep_atv_acty_area_code
                                   ,pi_defect_type        => pi_defect_rec.def_defect_code
                                   ,pi_effective_date     => pi_insp_rec.are_date_work_done)
           THEN
              raise_application_error(-20031,'Invalid Treatment Specified.');
          END IF;
      END IF;
      /*
      ||Calculate Date Due.
      */
      IF((lr_rse.rse_sys_flag = 'D' and lv_repsetperd = 'Y')
         OR(lr_rse.rse_sys_flag = 'L' and lv_repsetperl = 'Y'))
        AND lt_rep_tab(i).rep_record.rep_action_cat = 'P'
        AND pi_defect_rec.def_priority = '1'
        AND lt_rep_tab.COUNT = 1  -- ie. No Other Repairs To Be Created.
       THEN
         lv_action_cat := 'T';
      ELSE
         lv_action_cat := lt_rep_tab(i).rep_record.rep_action_cat;
      END IF;
      --
      mai.rep_date_due(pi_defect_rec.def_created_date
                      ,lt_rep_tab(i).rep_record.rep_atv_acty_area_code
                      ,pi_defect_rec.def_priority
                      ,lv_action_cat
                      ,lt_rep_tab(i).rep_record.rep_rse_he_id
                      ,lt_rep_tab(i).rep_record.rep_date_due
                      ,lv_dummy);
      IF lv_dummy <> 0
       THEN
          IF lv_dummy = 8509
           THEN
              hig.raise_ner(nm3type.c_mai,904); --Cannot Find Interval For Priority/Repair Category
          ELSIF lv_dummy = 8213
           THEN
              hig.raise_ner(nm3type.c_mai,905); --Cannot Find Interval For Road
          ELSE
              hig.raise_ner(nm3type.c_mai,906); --Cannot Find Due Date From Interval
          END IF;
      END IF;
      /*
      ||Default Local Date Due.
      */
      lt_rep_tab(i).rep_record.rep_local_date_due := lt_rep_tab(i).rep_record.rep_date_due;
      /*
      ||Nullify Old Date Due.
      */
      lt_rep_tab(i).rep_record.rep_old_due_date := NULL;
      /*
      ||Build A Table Of BOQs Related To
      ||This Repair For Validation.
      */
      lt_boq_tab := lt_rep_tab(i).rep_boqs;
      
      FOR j IN 1..lt_boq_tab.count LOOP
        --
        IF lt_boq_tab(j).boq_record.boq_rep_action_cat IS NULL
         THEN
            lt_boq_tab(j).boq_record.boq_rep_action_cat := lt_rep_tab(i).rep_record.rep_action_cat;
        END IF;
        --
      END LOOP;
      /*
      ||Validate The BOQs Or Apply A Treatment Model.
      */
      validate_repair_boqs(pi_def_defect_id      => pi_defect_rec.def_defect_id
                          ,pi_rep_action_cat     => lt_rep_tab(i).rep_record.rep_action_cat
                          ,pi_rep_created_date   => lt_rep_tab(i).rep_record.rep_created_date
                          ,pi_admin_unit         => pi_admin_unit
                          ,pi_rep_tre_treat_code => lt_rep_tab(i).rep_record.rep_tre_treat_code
                          ,pi_atv_acty_area_code => lt_rep_tab(i).rep_record.rep_atv_acty_area_code
                          ,pi_def_defect_code    => pi_defect_rec.def_defect_code
                          ,pi_sys_flag           => lr_rse.rse_sys_flag
                          ,po_error_flag         => lv_boq_error_flag
                          ,pio_boq_tab           => lt_boq_tab);
      /*
      ||Assign Any BOQs Returned (including any error text) To The Repairs Table.
      */
      lt_rep_tab(i).rep_boqs := lt_boq_tab;
      --
      IF NVL(lv_boq_error_flag,'N') = 'Y'
       THEN
          lv_rep_error_flag := 'Y';
      END IF;
      --
    EXCEPTION
      WHEN others
       THEN
          
          lv_rep_error_flag := 'Y';
          lt_rep_tab(i).rep_error := SQLERRM;
    END;
    --
  END LOOP;
  /*
  ||Assign The Validated Table To The Output Table.
  */
  po_error_flag := lv_rep_error_flag;
  pio_repair_tab := lt_rep_tab;
  --
END validate_repairs;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_doc_assocs(pi_effective_date IN     date
                             ,pio_error_flag    IN OUT VARCHAR2
                             ,pio_das_tab       IN OUT das_tab)
  IS
  --
  lt_das_tab   das_tab;
  --
  lv_text            mai_insp_load_recs.milr_error_text%TYPE;
  lv_ner_id          nm_errors.ner_id%TYPE;
  lv_doc_type        doc_types.dtp_code%TYPE := NULL;
  lv_doc_locn        doc_locations.dlc_location_name%TYPE;
  --
  doc_assoc_error    EXCEPTION;
  --
BEGIN
  --
  lt_das_tab := pio_das_tab;
  --
  FOR i IN 1..lt_das_tab.count LOOP
    /*
    ||Validate The Doc Assoc.
    */
    BEGIN
      /*
      || Validate Doc Type
      */
      lv_doc_type := NVL(lt_das_tab(i).das_dtp_code, hig.get_sysopt('DEFDOCTYPE'));
      
      IF NOT validate_doc_type(pi_dtp_code       => lv_doc_type
                              ,pi_effective_date => pi_effective_date)
       THEN
         lv_ner_id := 9286;
         RAISE doc_assoc_error;
      ELSE
         -- In case the Product option is used, ensure this is reflected
         -- in the lt_das_table entry
         lt_das_tab(i).das_dtp_code := lv_doc_type;
      END IF;
         
      /*
      ||Assign Default Title, if title not supplied
      */
      IF lt_das_tab(i).das_title IS NULL
       THEN
         lt_das_tab(i).das_title := Substr(lv_doc_type||' '||
                                           doc.get_table_descr('DEFECTS')||' - '
                                           ||lt_das_tab(i).das_def_defect_id, 1, 60);
      END IF;   
      /*
      || Validate Category
      */
      IF lt_das_tab(i).das_category IS NOT NULL
       THEN
        IF NOT validate_doc_category(pi_hco_code       => lt_das_tab(i).das_category
                                    ,pi_effective_date => pi_effective_date)
         THEN
           lv_ner_id := 9287;
           RAISE doc_assoc_error;
        END IF;
      END IF;
      /*
      ||Default Date Issued.
      */
      lt_das_tab(i).das_date_issued := pi_effective_date;
      /*
      || Check File Name provided
      */
      IF lt_das_tab(i).das_file IS NULL
       THEN
         lv_ner_id := 9288;
         RAISE doc_assoc_error;
      ELSE
         lt_das_tab(i).das_reference_code := lt_das_tab(i).das_file;
      END IF;
      /*
      ||Assign default description, if not supplied
      */
      IF lt_das_tab(i).das_descr IS NULL THEN
         
         lt_das_tab(i).das_descr := lv_doc_type||' automatically associated with Defect';
      END IF;
      /*
      || Validate location
      */
      lv_doc_locn := NVL(lt_das_tab(i).das_location, hig.get_sysopt('DEFDOCLOCN'));
      IF NOT validate_file_location(pi_dlc_name    => lv_doc_locn 
                                   ,po_dlc_dmd_id  => lt_das_tab(i).das_dlc_dmd_id
                                   ,po_dlc_id      => lt_das_tab(i).das_dlc_id)
       THEN
         lv_ner_id := 9289;
         RAISE doc_assoc_error;
      ELSE
         -- In case the Product option is used, ensure this is reflected
         -- in the lt_das_table entry
         lt_das_tab(i).das_location := lv_doc_locn;
      END IF; 
      
    EXCEPTION
      WHEN doc_assoc_error
       THEN
          --
          pio_error_flag := 'Y';
          lv_text := SUBSTR(nm3get.get_ner(pi_ner_id   => lv_ner_id
                     ,pi_ner_appl => 'MAI').ner_descr
                     ,1
                     ,4000);
          lt_das_tab(i).das_error := lv_text;

      WHEN others
       THEN
          --
          pio_error_flag := 'Y';
          lt_das_tab(i).das_error := SQLERRM;
    END;
    --
  END LOOP;
         
  /*       
  ||Assign The Validated Table To The Output Table.
  */
  nm_debug.debug('validate_doc_assocs = '||pio_error_flag);
  pio_das_tab := lt_das_tab;
  --
END validate_doc_assocs;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_insp_activities(pi_insp_rec       IN     activities_report%ROWTYPE
                                  ,pi_section_length IN     nm_elements_all.ne_length%TYPE
                                  ,pi_sys_flag       IN     VARCHAR2
                                  ,po_error_flag        OUT VARCHAR2
                                  ,pio_activities    IN OUT activities_tab
                                  ,pio_arl_tab       IN OUT act_report_lines_tab)
  IS
  --
  lv_last_insp_date  DATE;
  lv_error_flag      VARCHAR2(1) := 'N';
  --
  lt_activities  activities_tab;
  lt_arl         act_report_lines_tab;
  --
  PROCEDURE chk_activity(pi_activity IN activities.atv_acty_area_code%TYPE)
    IS
    --
    lv_dummy  PLS_INTEGER;
    --
  BEGIN
    SELECT 1
      INTO lv_dummy
      FROM activities
     WHERE atv_acty_area_code = pi_activity
       AND atv_dtp_flag = pi_sys_flag
         ;
  EXCEPTION
    WHEN no_data_found
     THEN
        raise_application_error(-20001,'Invalid Inspection Activity Supplied.'||pi_activity);
    WHEN others
     THEN
        RAISE;
  END chk_activity;
  --
  FUNCTION get_last_insp_date(pi_activity IN activities.atv_acty_area_code%TYPE)
    RETURN DATE IS
    --
    lv_retval  DATE;
    --
  BEGIN
    --
    SELECT NVL((MAX(are_date_work_done)),TO_DATE('01-JAN-1951','DD-MON-YYYY'))
      INTO lv_retval
      FROM activities_report
          ,act_report_lines
     WHERE arl_atv_acty_area_code = pi_activity
       AND arl_act_status = 'C'
       AND arl_are_report_id = are_report_id
       AND are_rse_he_id = pi_insp_rec.are_rse_he_id
       AND are_initiation_type = pi_insp_rec.are_initiation_type
         ;
    --
    RETURN lv_retval;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        RETURN NULL;
    WHEN others
     THEN
        RAISE;
  END get_last_insp_date;
  --
  PROCEDURE remove_duplicate_activities(pio_act_tab IN OUT activities_tab)
    IS
    --
    lt_tmp_act activities_tab;
    --
    lo_tmp_act nm_code_tbl := nm_code_tbl();
    --
  BEGIN
    --
    FOR i IN 1..pio_act_tab.count LOOP
      lo_tmp_act.extend;
      lo_tmp_act(i) := pio_act_tab(i).atv_acty_area_code;
    END LOOP;
    --
    SELECT DISTINCT column_value
          ,NULL
      BULK COLLECT 
      INTO lt_tmp_act
      FROM TABLE(lo_tmp_act)
         ;
    --
    pio_act_tab := lt_tmp_act;
    --
  END remove_duplicate_activities;
  --
BEGIN
  /*
  ||Make Sure We Have A List Of Distinct Values.
  */
  lt_activities := pio_activities;
  remove_duplicate_activities(pio_act_tab => lt_activities);
  /*
  ||Loop Through The Supplied Activities
  ||And Make Sure They Exist In The Table.
  */
  FOR i IN 1..lt_activities.count LOOP
    BEGIN
      /*
      ||Make Sure The Activity Code Exists.
      */
      chk_activity(pi_activity => lt_activities(i).atv_acty_area_code);
      /*
      ||Start To Build Up The act_report_lines record.
      */
      lt_arl(i).arl_are_report_id      := pi_insp_rec.are_report_id;
      lt_arl(i).arl_atv_acty_area_code := lt_activities(i).atv_acty_area_code;
      lt_arl(i).arl_created_date       := pi_insp_rec.are_date_work_done;
      lt_arl(i).arl_last_updated_date  := pi_insp_rec.are_date_work_done;
      lt_arl(i).arl_act_status         := 'C';
      /*
      ||Check The Date Of The Last Inspection Against This Activity.
      */
      lv_last_insp_date := get_last_insp_date(pi_activity => lt_activities(i).atv_acty_area_code);
      /*
      ||Calculate The Values Of The Remaining Columns.
      */
      IF lv_last_insp_date IS NOT NULL
       THEN
          --
          IF pi_section_length < (pi_insp_rec.are_end_chain - pi_insp_rec.are_st_chain + 20)
           THEN
              --
              lt_arl(i).arl_act_status := 'C';
              --
              IF lv_last_insp_date > pi_insp_rec.are_date_work_done
               THEN
                  lt_arl(i).arl_not_seq_flag := 'A';
                  /* Inspection date is less than previously */
                  hig.raise_ner(pi_appl => 'MAI'
                               ,pi_id   => 9500);
              ELSE
                  UPDATE act_report_lines
                     SET arl_act_status = 'I'
                        ,arl_created_date = SYSDATE
                   WHERE arl_atv_acty_area_code = lt_activities(i).atv_acty_area_code
                     AND arl_act_status = 'O'
                     AND arl_are_report_id IN(SELECT are_report_id
                                                FROM activities_report
                                               WHERE are_rse_he_id = pi_insp_rec.are_rse_he_id
                                                 AND are_date_work_done >= lv_last_insp_date)
                       ;
              END IF;
              --
          ELSE
              IF lv_last_insp_date > pi_insp_rec.are_date_work_done
               THEN
                  lt_arl(i).arl_not_seq_flag := 'A';
                  lt_arl(i).arl_act_status := 'I';
                  hig.raise_ner(pi_appl => 'MAI'
                               ,pi_id   => 9500);
              ELSE
                 --
                 UPDATE act_report_lines
                    SET arl_act_status = 'P'
                       ,arl_report_id_part_of = pi_insp_rec.are_report_id
                       ,arl_last_updated_date = SYSDATE
                  WHERE arl_atv_acty_area_code = lt_activities(i).atv_acty_area_code
                    AND arl_act_status = 'O'
                    AND arl_are_report_id IN(SELECT are_report_id
                                               FROM activities_report are
                                              WHERE are_rse_he_id = pi_insp_rec.are_rse_he_id
                                                AND are_date_work_done >= lv_last_insp_date
                                                AND EXISTS(SELECT arl_atv_acty_area_code
                                                                 ,SUM(are_end_chain - are_st_chain)
                                                             FROM activities_report are3
                                                                 ,act_report_lines arl3
                                                            WHERE arl3.arl_are_report_id = are3.are_report_id
                                                              AND arl3.arl_act_status = 'O'
                                                              AND arl3.arl_atv_acty_area_code = lt_activities(i).atv_acty_area_code
                                                              AND arl3.arl_are_report_id = are3.are_report_id
                                                              AND are3.are_rse_he_id = are.are_rse_he_id
                                                              AND are_date_work_done >= lv_last_insp_date
                                                            GROUP
                                                               BY arl3.arl_atv_acty_area_code
                                                           HAVING SUM(are3.are_end_chain - are3.are_st_chain)
                                                                    + count(are3.are_st_chain)*10 + (pi_insp_rec.are_end_chain - pi_insp_rec.are_st_chain)
                                                                    > pi_section_length))
                      ;
                 --
                 IF SQL%ROWCOUNT > 0
                  THEN
                     lt_arl(i).arl_act_status := 'C';
                     lt_arl(i).arl_report_id_part_of := pi_insp_rec.are_report_id;
                 ELSE
                     lt_arl(i).arl_act_status := 'O';
                     lt_arl(i).arl_report_id_part_of := NULL;
                 END IF;
                 --
             END IF;
          END IF;     
      END IF;
      --
    EXCEPTION
      WHEN others
       THEN
          lv_error_flag := 'Y';
          lt_activities(i).atv_error := SQLERRM;
    END;
  END LOOP;
  /*
  ||Assign OUT Parameters.
  */
  po_error_flag := lv_error_flag;
  pio_activities := lt_activities;
  pio_arl_tab := lt_arl;
  --
END validate_insp_activities;
--
-----------------------------------------------------------------------------
--
FUNCTION usedefchn(pi_sys_flag IN VARCHAR2)
  RETURN BOOLEAN IS
  --
  lv_retval    BOOLEAN := FALSE;
  lv_temp      hig_option_values.hov_value%TYPE;
  --
BEGIN
  --
  lv_temp := hig.get_sysopt('USEDEFCHN'||pi_sys_flag);
  --
  IF NVL(lv_temp,'N') = 'Y'
   THEN
      lv_retval := TRUE;
  END IF;
  --
  RETURN lv_retval;
  --
END usedefchn;
--
-----------------------------------------------------------------------------
--
FUNCTION get_tolerance(pi_admin_unit          IN nm_admin_units.nau_admin_unit%TYPE
                      ,pi_are_initiation_type IN activities_report.are_initiation_type%TYPE)
  RETURN def_superseding_rules.dsr_tolerance%TYPE IS
  --
  CURSOR C_tolerance (pi_hier_admin_unit nm_admin_units.nau_admin_unit%TYPE)IS
  SELECT dsr_tolerance
    FROM def_superseding_rules
   WHERE dsr_initiation_type = pi_are_initiation_type
     AND dsr_admin_unit = pi_hier_admin_unit;

  TYPE admin_unit_tab IS TABLE OF nm_admin_units.nau_admin_unit%TYPE INDEX BY BINARY_INTEGER;
  lt_admin_units admin_unit_tab;
     
  lv_tolerance   def_superseding_rules.dsr_tolerance%TYPE;
  lv_retval      def_superseding_rules.dsr_tolerance%TYPE := NULL;
  lv_row_found   BOOLEAN;
  --
BEGIN
  /*
  || Get Admin Unit Hierarchy
  */
  SELECT admin_unit
    BULK COLLECT
    INTO lt_admin_units
    FROM (SELECT hag_parent_admin_unit admin_unit, 
                 hau_level admin_level
            FROM hig_admin_groups,
                 hig_admin_units
           WHERE hag_direct_link='Y'
             AND hau_admin_unit = hag_parent_admin_unit
           START WITH hag_child_admin_unit = pi_admin_unit                                                                     
         CONNECT BY PRIOR hag_parent_admin_unit=hag_child_admin_unit
             AND hag_direct_link='Y'
           UNION
          SELECT hau_admin_unit admin_unit, 
                 hau_level admin_level
            FROM hig_admin_units
           WHERE hau_admin_unit = pi_admin_unit
           ORDER BY admin_level DESC);
  --
  /*
  || Try and match the Admin Unit and Initiation Type
  || against the Deffect Tolerance Rules
  */  
  nm_debug.debug('Finding tolerance for Admin Unit '||pi_admin_unit||' and '||pi_are_initiation_type);

  FOR i IN 1 .. lt_admin_units.count LOOP
  --
   OPEN C_tolerance(pi_hier_admin_unit => lt_admin_units(i));
   FETCH C_tolerance INTO lv_tolerance;
   lv_row_found := C_tolerance%FOUND;
   CLOSE C_tolerance;
     
   IF lv_row_found 
    THEN
       nm_debug.debug('Tolerance '||lv_tolerance||' found for Admin Unit '||lt_admin_units(i));
       lv_retval := lv_tolerance;
       EXIT;
   END IF;
     
  END LOOP;
  --
  RETURN lv_retval;
  --
END get_tolerance;
--
-----------------------------------------------------------------------------
--
FUNCTION update_sect_last_updated(pi_ne_id              IN nm_elements_all.ne_id%TYPE
                                 ,pi_are_date_work_done IN activities_report.are_date_work_done%TYPE)
  RETURN BOOLEAN IS
  --
  lv_attrib_name nm_inv_type_attribs_all.ita_attrib_name%TYPE;
  lv_iit_ne_id   nm_inv_items_all.iit_ne_id%TYPE;
  lv_string      nm3type.max_varchar2;
  --
BEGIN
  /*
  ||Get The AD Attribute To Update.
  */
  SELECT ita_attrib_name
    INTO lv_attrib_name
    FROM nm_inv_type_attribs
   WHERE ita_inv_type = (SELECT nad_inv_type
                           FROM nm_nw_ad_types
                          WHERE EXISTS(SELECT 1
                                         FROM nm_elements_all
		                                    WHERE ne_id = pi_ne_id
				                                  AND ne_nt_type = nad_nt_type
					                                AND NVL(ne_gty_group_type,'$$$') = NVL(nad_gty_type,'$$$')
					                                AND nad_primary_ad = 'Y'))
     AND UPPER(ita_view_col_name) = 'RSE_LAST_INSPECTED'
       ;
  /*
  ||Get The AD Asset To Update.
  */
  SELECT nad_iit_ne_id
    INTO lv_iit_ne_id
    FROM nm_nw_ad_link
   WHERE nad_ne_id = pi_ne_id
     AND nad_primary_ad = 'Y'
       ;
  --
  lv_string := 'UPDATE nm_inv_items '
                ||'SET '||lv_attrib_name||' = TO_DATE('||nm3flx.string(pi_are_date_work_done)||') '
              ||'WHERE iit_ne_id = '||lv_iit_ne_id;
  --
  execute immediate lv_string;
  --
  RETURN TRUE;
  --
EXCEPTION
 WHEN others
  THEN
     RETURN FALSE;
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE upd_notrefound_defects(pi_are_report_id       IN activities_report.are_report_id%TYPE
                                ,pi_are_maint_insp_flag IN activities_report.are_maint_insp_flag%TYPE
                                ,pi_are_initiation_type IN activities_report.are_initiation_type%TYPE
                                ,pi_are_rse_he_id       IN activities_report.are_rse_he_id%TYPE
                                ,pi_are_st_chain        IN activities_report.are_st_chain%TYPE
                                ,pi_are_end_chain       IN activities_report.are_end_chain%TYPE
                                ,pi_are_date_work_done  IN activities_report.are_date_work_done%TYPE)
  IS
  --
  lv_notrefound        hig_option_values.hov_value%TYPE := hig.get_sysopt('NOTREFOUND');
  lv_def_compl_status  hig_status_codes.hsc_status_code%TYPE;
  lv_sys_flag          VARCHAR2(1);
  --
  TYPE def_id_tab IS TABLE OF defects.def_defect_id%TYPE INDEX BY BINARY_INTEGER;
  lt_defects def_id_tab;
  --
  PROCEDURE get_all_defects
    IS
  BEGIN
    --
    SELECT def_defect_id
      BULK COLLECT
      INTO lt_defects
      FROM defects
          ,activities_report
     WHERE are_date_work_done < pi_are_date_work_done
       AND are_report_id = def_are_report_id
       AND def_superseded_flag = 'N'
       AND def_rse_he_id = pi_are_rse_he_id
       AND def_date_compl IS NULL
       AND def_st_chain BETWEEN NVL(pi_are_st_chain,0) 
                            AND NVL(pi_are_end_chain,0)
       AND def_atv_acty_area_code IN(SELECT arl_atv_acty_area_code
                                       FROM act_report_lines
                                      WHERE arl_are_report_id = pi_are_report_id)
       AND NOT EXISTS(SELECT 'X'
                        FROM work_order_lines
                       WHERE wol_def_defect_id = def_defect_id)
         ;
    --
  END get_all_defects;
  --
  PROCEDURE get_pri_defects
    IS
  BEGIN
    --
    SELECT def_defect_id
      BULK COLLECT
      INTO lt_defects
      FROM defects
          ,activities_report
     WHERE are_date_work_done < pi_are_date_work_done
       AND are_report_id = def_are_report_id
       AND SUBSTR(def_priority,1,1) != '1'
       AND def_superseded_flag = 'N'
       AND def_rse_he_id = pi_are_rse_he_id
       AND def_date_compl IS NULL
       AND def_st_chain BETWEEN NVL(pi_are_st_chain,0) 
                            AND NVL(pi_are_end_chain,0)
       AND def_atv_acty_area_code IN(SELECT arl_atv_acty_area_code
                                       FROM act_report_lines
                                      WHERE arl_are_report_id = pi_are_report_id)
       AND NOT EXISTS(SELECT 'X'
                        FROM work_order_lines
                       WHERE wol_def_defect_id = def_defect_id)
         ;
    --
  END get_pri_defects;
  --
BEGIN
  --
  lv_sys_flag := validate_section(pi_rse_he_id => pi_are_rse_he_id).rse_sys_flag;
  --
  IF usedefchn(pi_sys_flag => lv_sys_flag)
   AND pi_are_maint_insp_flag = 'D'
   AND pi_are_initiation_type = 'NRM'
   THEN
      --
      lv_def_compl_status := get_complete_defect_status(pi_effective_date => pi_are_date_work_done);
      --
      IF lv_notrefound = 'ALL'
       THEN
          get_all_defects;
      ELSIF lv_notrefound = 'PRI'
       THEN
          get_pri_defects;
      END IF;
      --
      FOR i IN 1..lt_defects.count LOOP
        --
        UPDATE repairs
           SET rep_date_completed    = TRUNC(pi_are_date_work_done)
              ,rep_completed_hrs     = TO_NUMBER(TO_CHAR(pi_are_date_work_done,'HH24'))
              ,rep_completed_mins    = TO_NUMBER(TO_CHAR(pi_are_date_work_done,'MI'))
              ,rep_last_updated_date = SYSDATE
         WHERE rep_def_defect_id = lt_defects(i)
             ;
        --
        UPDATE defects
           SET def_date_compl        = pi_are_date_work_done
              ,def_status_code       = lv_def_compl_status
              ,def_are_id_not_found  = pi_are_report_id
              ,def_date_not_found    = pi_are_date_work_done
              ,def_last_updated_date = SYSDATE
         WHERE def_defect_id = lt_defects(i)
             ;
        --
      END LOOP;
      --
  END IF;
  --
END upd_notrefound_defects;
--
-----------------------------------------------------------------------------
--
PROCEDURE upd_notrefound_defects(pi_are_report_id IN activities_report.are_report_id%TYPE)
  IS
  --
  lr_insp  activities_report%ROWTYPE;
  --
BEGIN
  /*
  ||Get The Inspection Details.
  */
  lr_insp := get_insp(pi_are_report_id => pi_are_report_id);  
  /*
  ||Supersede Any Matching Defects.
  */
  upd_notrefound_defects(pi_are_report_id       => lr_insp.are_report_id
                        ,pi_are_maint_insp_flag => lr_insp.are_maint_insp_flag
                        ,pi_are_initiation_type => lr_insp.are_initiation_type
                        ,pi_are_rse_he_id       => lr_insp.are_rse_he_id
                        ,pi_are_st_chain        => lr_insp.are_st_chain
                        ,pi_are_end_chain       => lr_insp.are_end_chain
                        ,pi_are_date_work_done  => lr_insp.are_date_work_done);
  --
END upd_notrefound_defects;
--
-----------------------------------------------------------------------------
--
FUNCTION match_defect(pi_def_defect_id          IN defects.def_defect_id%TYPE
                     ,pi_def_created_date       IN defects.def_created_date%TYPE
                     ,pi_def_ity_inv_code       IN defects.def_ity_inv_code%TYPE
                     ,pi_def_atv_acty_area_code IN defects.def_atv_acty_area_code%TYPE
                     ,pi_def_defect_code        IN defects.def_defect_code%TYPE
                     ,pi_def_rse_he_id          IN defects.def_rse_he_id%TYPE
                     ,pi_def_st_chain           IN defects.def_st_chain%TYPE
                     ,pi_def_x_sect             IN defects.def_x_sect%TYPE
                     ,pi_def_mand_adv           IN defects.def_mand_adv%TYPE
                     ,pi_def_priority           IN defects.def_priority%TYPE
                     ,pi_are_report_id          IN activities_report.are_report_id%TYPE
                     ,pi_are_initiation_type    IN activities_report.are_initiation_type%TYPE
                     ,pi_are_maint_insp_flag    IN activities_report.are_maint_insp_flag%TYPE
                     ,pi_are_date_work_done     IN activities_report.are_date_work_done%TYPE
                     ,pi_dsr_tolerance          IN def_superseding_rules.dsr_tolerance%TYPE)
  RETURN matched_defects_tab IS
  --
  lv_defsuptype  hig_option_values.hov_value%TYPE := hig.get_sysopt('DEFSUPTYPE');
  --
  lt_matched_defects  matched_defects_tab;
  --
  PROCEDURE get_matching_defects_1
    IS
  BEGIN
    --
    SELECT def_defect_id
          ,def_priority
      BULK COLLECT
      INTO lt_matched_defects
      FROM defects
     WHERE def_superseded_flag != 'Y'
       AND def_date_compl IS NULL
       AND def_created_date < pi_def_created_date
       AND NVL(def_ity_inv_code,'@*!') = NVL(pi_def_ity_inv_code,'@*!')
       AND def_are_report_id != pi_are_report_id
       AND def_atv_acty_area_code = pi_def_atv_acty_area_code
       AND def_defect_code = pi_def_defect_code
       AND def_rse_he_id = pi_def_rse_he_id
       AND def_st_chain BETWEEN (pi_def_st_chain - pi_dsr_tolerance)
                            AND (pi_def_st_chain + pi_dsr_tolerance)
       AND NVL(def_x_sect,'@*!') = NVL(pi_def_x_sect,'@*!')
       AND NVL(def_mand_adv,'@*!') = NVL(pi_def_mand_adv,'@*!')
     ORDER
        BY def_defect_id
         ;
    --
  END get_matching_defects_1;
  --
  PROCEDURE get_matching_defects_2
    IS
  BEGIN
    --
    SELECT def_defect_id
          ,def_priority
      BULK COLLECT
      INTO lt_matched_defects
      FROM defects
          ,activities_report
     WHERE are_report_id != pi_are_report_id
       AND are_initiation_type = pi_are_initiation_type
       AND are_maint_insp_flag = pi_are_maint_insp_flag
       AND are_date_work_done < pi_are_date_work_done
       AND are_report_id = def_are_report_id
       AND def_superseded_flag != 'Y'
       AND def_date_compl IS NULL
       AND NVL(def_ity_inv_code,'@*!') = NVL(pi_def_ity_inv_code,'@*!')
       AND def_atv_acty_area_code = pi_def_atv_acty_area_code
       AND def_defect_code = pi_def_defect_code
       AND def_rse_he_id = pi_def_rse_he_id
       AND def_priority = pi_def_priority
       AND def_st_chain BETWEEN (pi_def_st_chain - NVL(pi_dsr_tolerance,5))
                            AND (pi_def_st_chain + NVL(pi_dsr_tolerance,5))
       AND NVL(def_x_sect,'@*!') = NVL(pi_def_x_sect,'@*!')
       AND NVL(def_mand_adv,'@*!') = NVL(pi_def_mand_adv,'@*!')
     ORDER
        BY def_defect_id
         ;
    --
  END get_matching_defects_2;
  --
BEGIN
  --
  IF lv_defsuptype = 1
   THEN
      get_matching_defects_1;
  ELSIF lv_defsuptype = 2
   THEN
      get_matching_defects_2;
  END IF;
  --
  RETURN lt_matched_defects;
  --
END match_defect;
--
-----------------------------------------------------------------------------
--
PROCEDURE supersede_defect(pi_superseded_defect_id      IN defects.def_defect_id%TYPE
                          ,pi_superseded_priority       IN defects.def_priority%TYPE
                          ,pi_active_defect_id          IN defects.def_defect_id%TYPE
                          ,pi_active_priority           IN defects.def_priority%TYPE
                          ,pi_active_rse_he_id          IN defects.def_rse_he_id%TYPE
                          ,pi_active_coord_flag         IN defects.def_coord_flag%TYPE
                          ,pi_are_initiation_type       IN activities_report.are_initiation_type%TYPE
                          ,pi_active_are_date_work_done IN activities_report.are_date_work_done%TYPE)
  IS
  --
  lv_defsupres   hig_option_values.hov_value%TYPE := hig.get_sysopt('DEFSUPRES');
  lv_rmmsflag    hig_option_values.hov_value%TYPE := hig.get_sysopt('RMMSFLAG');
  --
  lv_admin_unit         nm_admin_units.nau_admin_unit%TYPE;
  lv_superseded_status  hig_status_codes.hsc_status_code%TYPE;
  --
  lv_superseded_defect_id  defects.def_defect_id%TYPE;
  lv_active_defect_id      defects.def_defect_id%TYPE;
  --
  lv_dsr_tolerance         def_superseding_rules.dsr_tolerance%TYPE := NULL;
  --
BEGIN
  /*
  ||Get The Admin Unit Of The Inspected Section.
  */
  lv_admin_unit := nm3net.get_ne(pi_active_rse_he_id).ne_admin_unit;
  --
  lv_dsr_tolerance := get_tolerance(pi_admin_unit          =>lv_admin_unit
                                   ,pi_are_initiation_type =>pi_are_initiation_type);
                                
  IF lv_dsr_tolerance IS NOT NULL
   THEN
      /*
      ||Check The Defect Being Superseded To See If It's
      ||On A Work Order Line, If It Is Then The New Defect
      ||Should Be Superseded Instead.
      */
      IF defect_on_wol(pi_defect_id => pi_superseded_defect_id)
       THEN
          /*
          ||Switch The Id's.
          */
          lv_superseded_defect_id := pi_active_defect_id;
          lv_active_defect_id := pi_superseded_defect_id;
      ELSE
          /*
          ||Set The Id's As They Were Passed In.
          */
          lv_superseded_defect_id := pi_superseded_defect_id;
          lv_active_defect_id := pi_active_defect_id;
      END IF;
      /*
      ||Get The Superseded Defect Status.
      */
      lv_superseded_status := get_superseded_defect_status(pi_effective_date => pi_active_are_date_work_done);
      --
      UPDATE defects
         SET def_superseded_flag = 'Y'
            ,def_status_code = lv_superseded_status
            ,def_coord_flag = DECODE(lv_rmmsflag,3,pi_active_coord_flag,def_coord_flag)
            ,def_superseded_id = lv_active_defect_id
            ,def_last_updated_date = SYSDATE
       WHERE def_defect_id = lv_superseded_defect_id
           ;
      --
      UPDATE repairs
         SET rep_superseded_flag  = 'Y'
            ,rep_last_updated_date = SYSDATE
       WHERE rep_def_defect_id = lv_superseded_defect_id
           ;
      --
      IF NVL(lv_defsupres,'Y') = 'Y'
       THEN
          /*
          ||Following Code Is For Rmms Amendment Set 5 For Superseding Defects.
          ||It Ensures That For Matching Defects Of The Same Category The
          ||Superseding Defect Will Retain The Due Date Of The Superseded Defect
          ||Where The Categories Do Not Match (Eg Going From 1 To 2) Then The
          ||New Due Date Is Retained.
          */
          UPDATE REPAIRS a
             SET a.rep_old_due_date = a.rep_date_due
                ,(a.rep_date_due,a.rep_local_date_due)=(SELECT b.rep_date_due
                                                              ,b.rep_local_date_due
                                                          FROM repairs b
                                                         WHERE b.rep_def_defect_id = lv_superseded_defect_id
                                                           AND b.rep_action_cat    = a.rep_action_cat)
                ,rep_last_updated_date = SYSDATE
           WHERE a.rep_def_defect_id = lv_active_defect_id
             AND a.rep_action_cat in(SELECT c.rep_action_cat
                                       FROM repairs c
                                      WHERE c.rep_def_defect_id = lv_superseded_defect_id)
             AND EXISTS(SELECT 'x'
                          FROM defects c
                              ,defects d
                         WHERE c.def_defect_id = lv_superseded_defect_id
                           AND c.def_superseded_id = d.def_defect_id
                           AND d.def_defect_id = lv_active_defect_id
                           AND d.def_date_compl IS NULL
                           AND NOT EXISTS(SELECT 'x'
                                            FROM repairs
                                                ,work_order_lines
                                           WHERE wol_def_defect_id = lv_active_defect_id
                                             AND wol_def_defect_id = rep_def_defect_id
                                             AND wol_rep_action_cat = rep_action_cat
                                             AND rep_date_completed IS NULL)
                           AND SUBSTR(c.def_priority,1,1) = SUBSTR(d.def_priority,1,1))
               ;
          --
          IF pi_active_priority != pi_superseded_priority
           THEN
              UPDATE repairs
                 SET rep_old_due_date = rep_date_due
               WHERE rep_def_defect_id = lv_active_defect_id
                 AND rep_date_completed is null
                   ;
          END IF;
          --
          IF lv_active_defect_id > lv_superseded_defect_id
           THEN
              --
              UPDATE repairs a
                 SET a.rep_old_due_date = a.rep_date_due
                    ,(a.rep_date_due, a.rep_local_date_due)=(SELECT TO_DATE(TO_DATE(a.rep_date_due)
                                                                              - TO_DATE(pi_active_are_date_work_done)
                                                                              + TO_DATE(d.are_date_work_done))
                                                                    ,TO_DATE(TO_DATE(a.rep_date_due)
                                                                               - TO_DATE(pi_active_are_date_work_done)
                                                                               + TO_DATE(d.are_date_work_done))
                                                                FROM repairs b
                                                                    ,defects c
                                                                    ,activities_report d
                                                               WHERE c.def_defect_id = lv_superseded_defect_id
                                                                 AND b.rep_def_defect_id = c.def_defect_id
                                                                 AND d.are_report_id = c.def_are_report_id
                                                                 AND b.rep_action_cat != 'I'
                                                                 AND a.rep_action_cat != b.rep_action_cat)
               WHERE a.rep_def_defect_id = lv_active_defect_id
                 AND NOT EXISTS(SELECT 'x'
                                  FROM repairs g
                                 WHERE g.rep_def_defect_id = lv_superseded_defect_id
                                   AND g.rep_action_cat = a.rep_action_cat)
                   ;
              --
              UPDATE repairs a
                 SET a.rep_old_due_date = a.rep_date_due
                    ,a.rep_date_due=(SELECT b.rep_date_due
                                       FROM repairs b
                                      WHERE b.rep_def_defect_id = lv_active_defect_id
                                        AND a.rep_action_cat    = b.rep_action_cat)
               WHERE a.rep_def_defect_id = lv_superseded_defect_id
                 AND a.rep_action_cat in(SELECT c.rep_action_cat
                                           FROM repairs c
                                          WHERE c.rep_def_defect_id = lv_active_defect_id)
                 AND EXISTS(SELECT 'x'
                              FROM repairs
                                  ,work_order_lines
                             WHERE wol_def_defect_id = lv_active_defect_id
                               AND wol_def_defect_id = rep_def_defect_id
                               AND wol_rep_action_cat = rep_action_cat
                               AND rep_date_completed IS NULL)
                   ;
              --
          END IF;
          --
      END IF;
      --
  END IF;
  --
END supersede_defect;
--
-----------------------------------------------------------------------------
--
PROCEDURE supersede_insp_defects(pi_are_report_id       IN activities_report.are_report_id%TYPE
                                ,pi_are_maint_insp_flag IN activities_report.are_maint_insp_flag%TYPE
                                ,pi_are_initiation_type IN activities_report.are_initiation_type%TYPE
                                ,pi_are_rse_he_id       IN activities_report.are_rse_he_id%TYPE
                                ,pi_are_date_work_done  IN activities_report.are_date_work_done%TYPE)
  IS
  --
  lv_admin_unit     nm_admin_units.nau_admin_unit%TYPE;
  lv_dsr_tolerance  def_superseding_rules.dsr_tolerance%TYPE := NULL;

  --
  lt_matched_defects  matched_defects_tab;
  --
  lt_insp_defects     defects_tab;
  --
BEGIN
  /*
  ||Get The Admin Unit Of The Inspected Section.
  */
  nm_debug.debug('Looking up Admin Unit');
  lv_admin_unit := nm3net.get_ne(pi_are_rse_he_id).ne_admin_unit;
  nm_debug.debug('Admin Unit is '||lv_admin_unit);
  --
  lv_dsr_tolerance := get_tolerance(pi_admin_unit          =>lv_admin_unit
                                   ,pi_are_initiation_type =>pi_are_initiation_type);
                                
  IF lv_dsr_tolerance IS NOT NULL
   THEN
      /*
      ||Get Details Of The Defects 
      ||On The Inspection Passed In.
      */
      nm_debug.debug('Looking up Inspection Defects.');
      lt_insp_defects := get_insp_defects(pi_are_report_id  =>pi_are_report_id);
      nm_debug.debug(lt_insp_defects.count||' Defects found.');
      /*
      ||Search For Matching Defects On
      ||Previous Inspections And Flag
      ||Them As Superseded.
      */
      FOR i IN 1..lt_insp_defects.count LOOP
        /*
        ||Get Matching Defects.
        */
        nm_debug.debug('Matching Defects.');
        lt_matched_defects := match_defect(pi_def_defect_id          => lt_insp_defects(i).def_defect_id
                                          ,pi_def_created_date       => lt_insp_defects(i).def_created_date
                                          ,pi_def_ity_inv_code       => lt_insp_defects(i).def_ity_inv_code
                                          ,pi_def_atv_acty_area_code => lt_insp_defects(i).def_atv_acty_area_code
                                          ,pi_def_defect_code        => lt_insp_defects(i).def_defect_code
                                          ,pi_def_rse_he_id          => lt_insp_defects(i).def_rse_he_id
                                          ,pi_def_st_chain           => lt_insp_defects(i).def_st_chain
                                          ,pi_def_x_sect             => lt_insp_defects(i).def_x_sect
                                          ,pi_def_mand_adv           => lt_insp_defects(i).def_mand_adv
                                          ,pi_def_priority           => lt_insp_defects(i).def_priority
                                          ,pi_are_report_id          => pi_are_report_id
                                          ,pi_are_initiation_type    => pi_are_initiation_type
                                          ,pi_are_maint_insp_flag    => pi_are_maint_insp_flag
                                          ,pi_are_date_work_done     => pi_are_date_work_done
                                          ,pi_dsr_tolerance          => lv_dsr_tolerance);
        nm_debug.debug(lt_matched_defects.count||' Matching Defects Found');
        /*
        ||Supersede Any Matching Defects.
        ||(only supersede the first one for now, this is how the C Loader worked but will be reviewed at some point).
        */
        IF lt_matched_defects.count > 0
         THEN
            FOR j IN 1..1 LOOP
              --
              nm_debug.debug('Calling supersede_defect, defect_id = '||lt_matched_defects(j).def_defect_id);
              supersede_defect(pi_superseded_defect_id      => lt_matched_defects(j).def_defect_id
                              ,pi_superseded_priority       => lt_matched_defects(j).def_priority
                              ,pi_active_defect_id          => lt_insp_defects(i).def_defect_id
                              ,pi_active_priority           => lt_insp_defects(i).def_priority
                              ,pi_active_rse_he_id          => lt_insp_defects(i).def_rse_he_id
                              ,pi_active_coord_flag         => lt_insp_defects(i).def_coord_flag
                              ,pi_are_initiation_type       => pi_are_initiation_type
                              ,pi_active_are_date_work_done => pi_are_date_work_done);
              --
              nm_debug.debug('Defect superseded');
            END LOOP;
        END IF;
        --
      END LOOP;
      --
  END IF;
  --
END supersede_insp_defects;
--
-----------------------------------------------------------------------------
--
PROCEDURE supersede_insp_defects(pi_are_report_id IN activities_report.are_report_id%TYPE)
  IS
  --
  lr_insp  activities_report%ROWTYPE;
  --
BEGIN
  /*
  ||Get The Inspection Details.
  */
  lr_insp := get_insp(pi_are_report_id => pi_are_report_id);  
  /*
  ||Supersede Any Matching Defects.
  */
  supersede_insp_defects(pi_are_report_id       => pi_are_report_id 
                        ,pi_are_maint_insp_flag => lr_insp.are_maint_insp_flag
                        ,pi_are_initiation_type => lr_insp.are_initiation_type
                        ,pi_are_rse_he_id       => lr_insp.are_rse_he_id
                        ,pi_are_date_work_done  => lr_insp.are_date_work_done);
  --
END supersede_insp_defects;
--
-----------------------------------------------------------------------------
--
PROCEDURE auto_create_wo(pi_are_report_id       IN activities_report.are_report_id%TYPE)
  IS
  --
  lv_work_order_no       work_orders.wor_works_order_no%TYPE;
  lv_auto_create_error   VARCHAR2(4000);
  --
  lt_insp_defects     defects_tab;
  --
BEGIN
   lt_insp_defects := get_insp_defects(pi_are_report_id  =>pi_are_report_id);

   /*
   || For each of the Defects on the Inspection
   || check if Auto Create Work Orders is required
   */
   hig_process_api.log_it(' ');
   hig_process_api.log_it('Attempting Automatic Work Order Creation');
   
   FOR i IN 1..lt_insp_defects.count LOOP
              
      mai_wo_api.create_auto_defect_wo(pi_defect_id      => lt_insp_defects(i).def_defect_id
                                      ,po_work_order_no  => lv_work_order_no
                                      ,po_error          => lv_auto_create_error);
                                                
      IF lv_auto_create_error IS NULL 
       THEN
         hig_process_api.log_it('Created Work Order '||lv_work_order_no);
      ELSE
         hig_process_api.log_it(pi_message       => 'Warning: '||lv_auto_create_error
                               ,pi_message_type  => 'W');
      END IF;
                                                         
   END LOOP;
  --
END auto_create_wo;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_inspection(pio_insp_rec  IN OUT insp_rec
                           ,pi_commit     IN     VARCHAR2
                           ,po_error_flag    OUT VARCHAR2)
  IS
  --
  lv_insp_id        activities_report.are_report_id%TYPE;
  lv_defect_id      defects.def_defect_id%TYPE;
  lv_action_cat     repairs.rep_action_cat%TYPE;
  lv_admin_unit     hig_admin_units.hau_admin_unit%TYPE;
  lv_asset_type     defects.def_ity_inv_code%TYPE;
  lv_insp_sys_flag  VARCHAR2(1);
  lv_error_flag     VARCHAR2(1);
  --
  lv_entity_type   VARCHAR2(10);
  lv_boqs_created  NUMBER;
  lv_dummy         NUMBER;
  lv_iit_rse_he_id nm_elements_all.ne_id%TYPE;
  lv_text          mai_insp_load_recs.milr_error_text%TYPE;
  --
  lr_insp_rec     activities_report%ROWTYPE;
  lt_arl          act_report_lines_tab;
  lr_defect_rec   defects%ROWTYPE;
  lt_def_attribs  def_attr_tab;
  lt_ins_repairs  repairs_tab;
  lt_repairs      rep_tab;
  lr_repair_rec   repairs%ROWTYPE;
  lr_rse          road_sections%ROWTYPE;
  lt_boqs         boq_tab;
  lt_ins_boqs     boq_items_tab;
  lt_das_tab      das_tab;
  --
  invalid_inspection  EXCEPTION;
  --
BEGIN
  --
  nm_debug.debug_on;
  /*
  ||Assign Input Parameters To Local Parameters
  */
  nm_debug.debug('create_defect, assigning input to local params');
  lr_insp_rec   := pio_insp_rec.insp_record;
  /*
  ||Validate The Inspection.
  */
  BEGIN
    validate_insp_rec(pio_insp_rec => lr_insp_rec
                     ,po_sys_flag  => lv_insp_sys_flag);
    lv_insp_id := ins_insp(pi_insp_rec => lr_insp_rec);
    lr_insp_rec.are_report_id := lv_insp_id;
    nm_debug.debug('Inspection Created ['||lv_insp_id ||']');
  EXCEPTION
    WHEN others
     THEN
        pio_insp_rec.insp_error := SQLERRM;
        RAISE invalid_inspection;
  END;
  /*
  ||Validate and Insert The Supplied Inspection Activities.
  */
  BEGIN
    validate_insp_activities(pi_insp_rec       => lr_insp_rec
                            ,pi_section_length => validate_section(lr_insp_rec.are_rse_he_id).rse_length
                            ,pi_sys_flag       => lv_insp_sys_flag
                            ,po_error_flag     => lv_error_flag
                            ,pio_activities    => pio_insp_rec.insp_activities
                            ,pio_arl_tab       => lt_arl);
    --
    IF NVL(lv_error_flag,'N') = 'Y'
     THEN
        RAISE invalid_inspection;
    END IF;
    --
    IF lt_arl.count > 0
     THEN
        ins_insp_lines(pi_arl_tab => lt_arl);
    END IF;
    --
  EXCEPTION
    WHEN others
     THEN
        pio_insp_rec.insp_error := SQLERRM;
        RAISE invalid_inspection;
  END;
  /*
  ||Loop Through The Supplied Defects.
  */
  FOR i IN 1..pio_insp_rec.insp_defects.count LOOP
    --
    BEGIN
      --
      lr_defect_rec  := pio_insp_rec.insp_defects(i).def_record;
      lt_def_attribs := pio_insp_rec.insp_defects(i).def_attribs;
      lt_repairs     := pio_insp_rec.insp_defects(i).def_repairs;
      lt_das_tab     := pio_insp_rec.insp_defects(i).def_assocs;
      /*
      ||Process The Defect.
      */
      BEGIN
        /*
        ||Check/Validate The Asset Id.
        */
        IF lr_defect_rec.def_iit_item_id IS NOT NULL
         THEN
            /*
            ||Asset Id Supplied So Make Sure
            ||The Asset Type Has Also Been Given.
            */
            IF lr_defect_rec.def_ity_inv_code IS NOT NULL
             THEN
                /*
                ||Check That The Asset Exists.
                */
                IF NOT validate_asset(pi_item_type => lr_defect_rec.def_ity_inv_code
                                     ,pi_item_id   => lr_defect_rec.def_iit_item_id)
                 THEN
                    raise_application_error(-20001,'Invalid Asset Type/Asset Id Supplied.');
                END IF;
                /*
                ||Asset exists but can we work with it?
                ||
                ||Don't do this when bulk loading...
                ||
                check_asset_security(pi_inv_type  => lr_defect_rec.def_ity_inv_code
                                    ,pi_iit_ne_id => lr_defect_rec.def_iit_item_id
                                    ,pi_user_id   => pi_insp_rec.are_peo_person_id_actioned);
                */
            ELSE
               raise_application_error(-20002,'No Asset Type Supplied.');
            END IF;
            /*
            ||Get The Maintenance Section Associated With The Asset Or
            ||The Relevant Dummy Section For Off Network Assets.
            */
            lv_iit_rse_he_id := mai.get_budget_allocation(p_inv_type  => lr_defect_rec.def_ity_inv_code
                                                         ,p_iit_ne_id => lr_defect_rec.def_iit_item_id);
            /*
            ||Make Sure The Asset's Section Matches
            ||The Section Being Inspected.
            */
            IF lv_iit_rse_he_id != lr_insp_rec.are_rse_he_id
             THEN
                raise_application_error(-20002,'Supplied Asset Is Not Associated With The Inspected Section.');
            END IF;
            --
        /*
        ||The ELSE Clause Below Has Been Removed To Support RMMS
        ||File Loading Where The Asset Type Can Be Specified But
        ||The Asset Id Is Not Given.
        */
        --ELSE
            /*
            ||No Asset Id Supplied So Make Sure
            ||The Asset Type Is Also NULL.
            */
        --    lr_defect_rec.def_ity_inv_code := NULL;
        END IF;
        /*
        ||Validate The Defect.
        */
        nm_debug.debug('Validating Defect.');
        validate_defect_rec(pi_are_report_id       => lr_insp_rec.are_report_id
                           ,pi_are_rse_he_id       => lr_insp_rec.are_rse_he_id
                           ,pi_are_date_work_done  => lr_insp_rec.are_date_work_done
                           ,pi_are_maint_insp_flag => lr_insp_rec.are_maint_insp_flag
                           ,pi_def_attr_tab        => lt_def_attribs
                           ,pi_defect_rec          => lr_defect_rec);
        /*
        ||Process The Defect.
        */
        lr_defect_rec.def_are_report_id := lr_insp_rec.are_report_id;
        --
        /*
        || Create The Defect.
        */
        nm_debug.debug('Creating Defect.');
        lv_defect_id := ins_defect(lr_defect_rec);
        lr_defect_rec.def_defect_id := lv_defect_id;
        nm_debug.debug('Defect Id = '||lv_defect_id);
      EXCEPTION
        WHEN others
         THEN  
            /*
            ||Error validaing the Defect, set the error text
            ||for the Defect and raise invalid_inspection
            ||(no point validaing the repairs/boqs).
            */
            pio_insp_rec.insp_defects(i).def_error := SQLERRM;
            RAISE invalid_inspection;
      END;
      /*
      ||Validate The Repairs.
      */
      nm_debug.debug('Getting Admin Unit.');
      lv_admin_unit := get_admin_unit(lr_defect_rec.def_iit_item_id
                                     ,lr_defect_rec.def_rse_he_id);
      --
      nm_debug.debug('Validating Repairs.');
      validate_repairs(pi_insp_rec    => lr_insp_rec
                      ,pi_defect_rec  => lr_defect_rec
                      ,pi_admin_unit  => lv_admin_unit
                      ,po_error_flag  => lv_error_flag
                      ,pio_repair_tab => lt_repairs);
      --
      
      IF NVL(lv_error_flag,'N') != 'Y'
       THEN
          /*
          ||Create The Repairs.
          */
          nm_debug.debug('Creating '||lt_repairs.count||' repairs.');
          FOR j IN 1..lt_repairs.count LOOP
            --
            lt_ins_repairs(j) := lt_repairs(j).rep_record;
            --
            FOR k IN 1..lt_repairs(j).rep_boqs.count LOOP
              --
              lt_ins_boqs(lt_ins_boqs.count+1) := lt_repairs(j).rep_boqs(k).boq_record;
              --
            END LOOP;
            --
          END LOOP;
          --
          ins_repairs(pi_repair_tab => lt_ins_repairs);
          /*
          ||Create The BOQs.
          */
          nm_debug.debug('Creating '||lt_ins_boqs.count||' BOQs.');
          IF lt_ins_boqs.count > 0
           THEN
              ins_boqs(pi_boq_tab => lt_ins_boqs);
          END IF;
      ELSE
         nm_debug.debug('Repair Validation Failed');
      END IF;
      /*
      ||Validate Doc Assocs.
      */
      nm_debug.debug('Validating Doc Assocs.');
      validate_doc_assocs(pi_effective_date => lr_insp_rec.are_date_work_done
                         ,pio_error_flag    => lv_error_flag
                         ,pio_das_tab       => lt_das_tab);

      IF NVL(lv_error_flag,'N') != 'Y'
       THEN   
       --
         nm_debug.debug('Creating Doc Assocs '||lt_das_tab.count);
         ins_defect_doc(pi_das_tab => lt_das_tab);
       --
      END IF;
      /*
      ||Clear Down The Ins Tables.
      */
      lt_ins_repairs.delete;
      lt_ins_boqs.delete;
      /*
      ||Set The Defect Output Data.
      */
      pio_insp_rec.insp_defects(i).def_record  := lr_defect_rec;
      pio_insp_rec.insp_defects(i).def_attribs := lt_def_attribs;
      pio_insp_rec.insp_defects(i).def_repairs := lt_repairs;
      pio_insp_rec.insp_defects(i).def_assocs  := lt_das_tab;
      --
    EXCEPTION        
      WHEN invalid_inspection
       THEN
          /*
          ||Should already have handled the error text to be retruned.
          ||for the current defect, set the error flag and validate
          ||the next Defect.
          */
          lv_error_flag := 'Y'; 
      WHEN others
       THEN
          /*
          ||Defect Repair and BOQ validation errors should already
          ||have been handled and invalid_inspection raised so
          ||this should be Oracle errors etc so update the Defect
          ||level error text and raise invalid_inspection.
          */
          pio_insp_rec.insp_defects(i).def_error := SQLERRM;
          RAISE invalid_inspection;
    END;
    --
  END LOOP;
  --
  IF NVL(lv_error_flag,'N') != 'Y'
   THEN
      BEGIN
        /*
        ||Supersede Any Defects That Have Been Refound.
        */
        nm_debug.debug('Starting Superseding Logic');
        supersede_insp_defects(pi_are_report_id       => lr_insp_rec.are_report_id
                              ,pi_are_maint_insp_flag => lr_insp_rec.are_maint_insp_flag
                              ,pi_are_initiation_type => lr_insp_rec.are_initiation_type
                              ,pi_are_rse_he_id       => lr_insp_rec.are_rse_he_id
                              ,pi_are_date_work_done  => lr_insp_rec.are_date_work_done);
        nm_debug.debug('Returned From Superseding Logic');
        /*
        ||Process Not Refound Defects.
        */
        nm_debug.debug('Starting Not Refound Logic');
        upd_notrefound_defects(pi_are_report_id       => lr_insp_rec.are_report_id 
                              ,pi_are_maint_insp_flag => lr_insp_rec.are_maint_insp_flag
                              ,pi_are_initiation_type => lr_insp_rec.are_initiation_type
                              ,pi_are_rse_he_id       => lr_insp_rec.are_rse_he_id
                              ,pi_are_st_chain        => lr_insp_rec.are_st_chain
                              ,pi_are_end_chain       => lr_insp_rec.are_end_chain
                              ,pi_are_date_work_done  => lr_insp_rec.are_date_work_done);
        nm_debug.debug('Not Refound Logic Complete');
      EXCEPTION
        WHEN others
         THEN
            pio_insp_rec.insp_error := SQLERRM;
            RAISE invalid_inspection;
      END;
  ELSE
      RAISE invalid_inspection;
  END IF;
  
  BEGIN
    --
    auto_create_wo(pi_are_report_id       => lr_insp_rec.are_report_id); 
    --  
  EXCEPTION
    WHEN others
         THEN
            nm_debug.debug('Auto create Work Order error :'||SQLERRM);
  END;
  /*
  ||Loop Through The Comments.
  */
  FOR i IN 1..pio_insp_rec.insp_comments.count LOOP
    nm_debug.debug('Processing Comment');
    --
    BEGIN
      IF NOT validate_doc_category(pi_hco_code       => pio_insp_rec.insp_comments(i).com_category
                                  ,pi_effective_date => lr_insp_rec.are_date_work_done)
       THEN
         lv_error_flag := 'Y';
         lv_text := SUBSTR(nm3get.get_ner(pi_ner_id   => 9105
                          ,pi_ner_appl => 'MAI').ner_descr
                     ,1
                     ,4000);
         pio_insp_rec.insp_comments(i).com_error := lv_text;

      END IF;
    EXCEPTION        
      WHEN others
       THEN
          /*
          ||Handle any Oracle erros and raise invalid_inspection.
          */
          pio_insp_rec.insp_comments(i).com_error := SQLERRM;
          RAISE invalid_inspection;
    END;
  
  END LOOP;

  /*
  || If comments OK create document details.
  */
  IF NVL(lv_error_flag,'N') != 'Y'
   THEN
     ins_comment(pi_com_tab         =>pio_insp_rec.insp_comments
                ,pi_rse_he_id      =>lr_insp_rec.are_rse_he_id
                ,pi_are_report_id  =>lr_insp_rec.are_report_id);
  ELSE
     RAISE invalid_inspection;
  END IF;                
  /*
  ||Commit If Required.
  */
  IF NVL(pi_commit,'Y') = 'Y'
   THEN
   nm_debug.debug('Commit.');
      COMMIT;
  END IF;
  --
  --
  nm_debug.debug('Create Inspection returns'||lv_error_flag);
  po_error_flag := lv_error_flag;
  pio_insp_rec.insp_record := lr_insp_rec;
  --
EXCEPTION
  WHEN OTHERS
   THEN
      ROLLBACK;
      po_error_flag := 'Y';
      --RAISE;
END create_inspection;
--
-----------------------------------------------------------------------------
--
PROCEDURE construct_tree_plsql_table
  (pi_process_id           IN PLS_INTEGER
  ,po_tab_initial_state    IN OUT nm3type.tab_number
  ,po_tab_depth            IN OUT nm3type.tab_number
  ,po_tab_label            IN OUT nm3type.tab_varchar80
  ,po_tab_icon             IN OUT nm3type.tab_varchar30
  ,po_tab_data             IN OUT nm3type.tab_varchar30
  ,po_tab_parent           IN OUT nm3type.tab_varchar30) IS

  TYPE batches_tab IS TABLE OF mai_insp_load_batches.milb_batch_id%TYPE INDEX BY BINARY_INTEGER;
  TYPE activities_rec IS RECORD(are_report_id mai_insp_load_error_are.are_report_id%TYPE,
                                are_error     mai_insp_load_error_are.are_error%TYPE);
  TYPE activities_tab IS TABLE OF activities_rec INDEX BY BINARY_INTEGER;
  TYPE defects_rec IS RECORD(def_defect_id mai_insp_load_error_def.def_defect_id%TYPE,
                             def_error     mai_insp_load_error_def.def_error%TYPE);
  TYPE defects_tab IS TABLE OF defects_rec INDEX BY BINARY_INTEGER;
  TYPE repairs_rec IS RECORD(rep_action_cat mai_insp_load_error_rep.rep_action_cat%TYPE,
                             rep_error      mai_insp_load_error_rep.rep_error%TYPE);
  TYPE repairs_tab IS TABLE OF repairs_rec INDEX BY BINARY_INTEGER;
  TYPE boq_rec IS RECORD(boq_id         mai_insp_load_error_boq.boq_id%TYPE,
                         boq_error      mai_insp_load_error_boq.boq_error%TYPE);
  TYPE boq_tab IS TABLE OF boq_rec INDEX BY BINARY_INTEGER;
  TYPE comments_rec IS RECORD(com_doc_id        mai_insp_load_error_com.com_doc_id%TYPE,
                              com_error         mai_insp_load_error_com.com_error%TYPE);
  TYPE comments_tab IS TABLE OF comments_rec INDEX BY BINARY_INTEGER;
  TYPE def_assocs_rec IS RECORD(das_doc_id        mai_insp_load_error_das.das_doc_id%TYPE,
                                das_error         mai_insp_load_error_das.das_error%TYPE);
  TYPE def_assocs_tab IS TABLE OF def_assocs_rec INDEX BY BINARY_INTEGER;
  --
  lt_batches          batches_tab; 
  lt_activities       activities_tab; 
  lt_defects          defects_tab; 
  lt_repairs          repairs_tab; 
  lt_boqs             boq_tab; 
  lt_comments         comments_tab; 
  lt_def_assocs       def_assocs_tab; 
  --
  lv_index        binary_integer :=0;
  
BEGIN

  SELECT distinct milb_batch_id
  BULK COLLECT
  INTO  lt_batches
  FROM mai_insp_load_batches,
       mai_insp_load_error_are
  WHERE are_batch_id = milb_batch_id
    AND milb_hp_process_id = pi_process_id;
    
  FOR b IN 1 .. lt_batches.count LOOP

    lv_index := lv_index+1;
    po_tab_initial_state(lv_index) := 1;
    po_tab_depth(lv_index)         := 1;
    po_tab_label(lv_index)         := 'Batch - '||lt_batches(b);
    po_tab_icon(lv_index)          := 'fdrclose';
    po_tab_data(lv_index)          := lt_batches(b);
    po_tab_parent(lv_index)        := NULL;
    
    SELECT are_report_id,
           are_error
    BULK COLLECT
    INTO  lt_activities
    FROM mai_insp_load_error_are
    WHERE are_batch_id = lt_batches(b);
    
    FOR x IN 1 .. lt_activities.count LOOP

      lv_index := lv_index+1;
      po_tab_initial_state(lv_index) := 1;
      po_tab_depth(lv_index)         := 2;
      po_tab_label(lv_index)         := 'Inspection - '||lt_activities(x).are_report_id;
      IF lt_activities(x).are_error IS NULL THEN
         po_tab_icon(lv_index)       := 'inspection';
      ELSE
         po_tab_icon(lv_index)       := 'abort';
      END IF;
      po_tab_data(lv_index)          := lt_activities(x).are_report_id;
      po_tab_parent(lv_index)        := NULL;
      
      SELECT def_defect_id,
             def_error
      BULK COLLECT
      INTO  lt_defects
      FROM mai_insp_load_error_def
      WHERE def_are_report_id = lt_activities(x).are_report_id;
          
      FOR j IN 1 .. lt_defects.count LOOP
        lv_index := lv_index+1;
        po_tab_initial_state(lv_index) := 1;
        po_tab_depth(lv_index)         := 3;
        po_tab_label(lv_index)         := 'Defect - '||lt_defects(j).def_defect_id;
        IF lt_defects(j).def_error IS NULL THEN
           po_tab_icon(lv_index)       := 'defect';
        ELSE
           po_tab_icon(lv_index)       := 'abort';
        END IF;
        po_tab_data(lv_index)          := lt_defects(j).def_defect_id;
        po_tab_parent(lv_index)        := lt_activities(x).are_report_id;


        SELECT das_doc_id,
               das_error
        BULK COLLECT
        INTO lt_def_assocs
        FROM mai_insp_load_error_das
        WHERE das_def_defect_id = lt_defects(j).def_defect_id;

        IF lt_def_assocs.count >0 Then
          lv_index := lv_index+1;
            po_tab_initial_state(lv_index) := 1;
            po_tab_depth(lv_index)         := 4;
            po_tab_label(lv_index)         := 'Documents';
            po_tab_data(lv_index)          := lt_defects(j).def_defect_id;
            po_tab_parent(lv_index)        := NULL;
        END IF;
        
        FOR k IN 1 .. lt_def_assocs.count LOOP

          IF lt_def_assocs(k).das_error IS NULL THEN
             po_tab_icon(lv_index)       := 'exor';
          ELSE
             po_tab_icon(lv_index)       := 'abort';
             exit;
          END IF;

        END LOOP;
        
        SELECT rep_action_cat,
               rep_error
        BULK COLLECT
        INTO lt_repairs
        FROM mai_insp_load_error_rep
        WHERE rep_def_defect_id = lt_defects(j).def_defect_id;

        FOR k IN 1 .. lt_repairs.count LOOP
          lv_index := lv_index+1;
          po_tab_initial_state(lv_index) := 1;
          po_tab_depth(lv_index)         := 4;
          po_tab_label(lv_index)         := 'Repair - '||lt_repairs(k).rep_action_cat;
          IF lt_repairs(k).rep_error IS NULL THEN
             po_tab_icon(lv_index)       := 'repair';
          ELSE
             po_tab_icon(lv_index)       := 'abort';
          END IF;
          po_tab_data(lv_index)          := lt_repairs(k).rep_action_cat;
          po_tab_parent(lv_index)        := lt_defects(j).def_defect_id;

          SELECT boq_id,
                 boq_error
          BULK COLLECT
          INTO lt_boqs
          FROM mai_insp_load_error_boq
          WHERE boq_defect_id = lt_defects(j).def_defect_id
            AND boq_rep_action_cat = lt_repairs(k).rep_action_cat;

          FOR l IN 1 ..lt_boqs.count LOOP
            lv_index := lv_index+1;
            po_tab_initial_state(lv_index) := 1;
            po_tab_depth(lv_index)         := 5;
            po_tab_label(lv_index)         := 'BOQ - '||lt_boqs(l).boq_id;
            IF lt_boqs(l).boq_error IS NULL THEN
               po_tab_icon(lv_index)       := 'fdrclose';
            ELSE
               po_tab_icon(lv_index)       := 'abort';
            END IF;
            po_tab_data(lv_index)          := lt_boqs(l).boq_id;
            po_tab_parent(lv_index)        := NULL;
            
          END LOOP;
            
          
        END LOOP;
          
      END LOOP;

      SELECT com_doc_id,
             com_error
      BULK COLLECT
      INTO  lt_comments
      FROM mai_insp_load_error_com
      WHERE com_are_report_id = lt_activities(x).are_report_id;

      IF lt_comments.count >0 Then
          lv_index := lv_index+1;
          po_tab_initial_state(lv_index) := 1;
          po_tab_depth(lv_index)         := 3;
          po_tab_label(lv_index)         := 'Comments';
          po_tab_data(lv_index)          := NULL;
          po_tab_parent(lv_index)        := NULL;
      END IF;
        
      FOR j IN 1 .. lt_comments.count LOOP
        IF lt_comments(j).com_error IS NULL THEN
           po_tab_icon(lv_index)       := 'square';
        ELSE
           po_tab_icon(lv_index)       := 'abort';
           exit;
        END IF;
        
      END LOOP;
      
    END LOOP;
  
  END LOOP;
    
  IF lt_batches.count = 0 THEN

    lv_index := lv_index+1;
    po_tab_initial_state(lv_index) := 1;
    po_tab_depth(lv_index)         := 1;
    po_tab_label(lv_index)         := 'No Invalid Inspections';
    po_tab_icon(lv_index)          := NULL;
    po_tab_data(lv_index)          := NULL;
    po_tab_parent(lv_index)        := NULL;
  END IF;
  
END construct_tree_plsql_table;

END mai_inspection_api;
/
