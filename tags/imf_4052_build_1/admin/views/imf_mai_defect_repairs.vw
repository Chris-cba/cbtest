CREATE OR REPLACE FORCE VIEW imf_mai_defect_repairs
(
   defect_id,
   defect_status,
   defect_location,
   defect_description,
   defect_priority,
   defect_priority_description,
   defect_priority_interval,
   defect_type,
   defect_type_description,
   defect_diagram_id,
   defect_height,
   defect_length,
   defect_area,
   defect_superseded,
   superseded_by_defect_id,
   network_element_id,
   network_element_offset,
   xsp_code,
   xsp_description,
   easting,
   northing,
   inspection_id,
   inspection_batch_id,
   inspector_id,
   inspector_initials,
   inspector_username,
   activity_code,
   activity_description,
   repair_category,
   repair_category_description,
   treatment_code,
   treatment_description,
   repair_description,
   date_inspected,
   date_loaded,
   date_repair_due,
   date_repair_completed,
   repair_late,
   days_before_repair_due,
   hours_before_repair_due,
   days_completed_before_due,
   hours_completed_before_due,
   days_before_inspection_due,
   hours_before_inspection_due,
   work_order_number
)
AS
SELECT 
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_defect_repairs.vw-arc   3.0   Mar 16 2009 16:19:08   drawat  $
--       Module Name      : $Workfile:   imf_mai_defect_repairs.vw  $
--       Date into PVCS   : $Date:   Mar 16 2009 16:19:08  $
--       Date fetched Out : $Modtime:   Mar 16 2009 10:32:30  $
--       Version          : $Revision:   3.0  $
-- Foundation view displaying maintenance defect repairs
-------------------------------------------------------------------------   
   def_defect_id,
   def_status_code,
   def_locn_descr,
   def_defect_descr,
   def_priority,
   ( SELECT hco_meaning
       FROM hig_codes
      WHERE hco_domain = 'DEFECT_PRIORITIES'
        AND hco_code = def_priority ) def_priority_descr,
   dpr_int_code,
   def_defect_code,
   ( SELECT dty_descr1
       FROM def_types
      WHERE dty_defect_code = def_defect_code
        AND dty_atv_acty_area_code = def_atv_acty_area_code
        AND dty_dtp_flag = def_ity_sys_flag ) dty_descr1,
   def_diagram_no,
   def_height,
   def_length,
   def_area,
   def_superseded_flag,
   def_superseded_id,
   def_rse_he_id,
   def_st_chain,
   def_x_sect,
   ( SELECT hco_meaning
       FROM hig_codes
      WHERE hco_domain = 'XSP_VALUES'
        AND hco_code = def_x_sect ) def_x_sect_descr,
   def_easting,
   def_northing,
   def_are_report_id,
   are_batch_id,
   hus_user_id,
   hus_initials,
   hus_username,
   def_atv_acty_area_code,
   ( SELECT atv_descr
       FROM activities
      WHERE atv_acty_area_code = def_atv_acty_area_code
        AND atv_dtp_flag = def_ity_sys_flag) atv_descr,
   rep_action_cat,
   DECODE (rep_action_cat,'I', 'Immediate','T', 'Temporary','Permanent'),
   rep_tre_treat_code,
   ( SELECT tre_descr
       FROM treatments
      WHERE tre_treat_code = rep_tre_treat_code ) tre_descr,
   rep_descr,
   are_date_work_done,
   def_created_date,
   rep_date_due,
   rep_date_completed,
   DECODE (SIGN (rep_date_due - rep_date_completed), -1, 'Y', 'N') repair_late,
   (TRUNC(rep_date_due) - TRUNC(SYSDATE)) days_before_repair_due,
   ((rep_date_due - SYSDATE)*24) hours_before_repair_due,
   (TRUNC(rep_date_due) - TRUNC(rep_date_completed)) days_completed_before_due,
   ((rep_date_due - rep_date_completed)*24) hours_completed_before_due,
   (TRUNC(are_date_work_done) - TRUNC(SYSDATE)) days_before_inspection_due,
   ((are_date_work_done - SYSDATE)*24) hours_before_inspection_due,   
   def_works_order_no
FROM activities_report,
     hig_users,
     defects,
     repairs,
     defect_priorities
WHERE are_peo_person_id_actioned = hus_user_id
  AND are_report_id              = def_are_report_id
  AND def_defect_id              = rep_def_defect_id
  AND def_atv_acty_area_code     = dpr_atv_acty_area_code
  AND def_priority               = dpr_priority
  AND dpr_action_cat             = rep_action_cat
WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_DEFECT_REPAIRS IS 'Maintenance Manager foundation view of all inspections, defects and repairs, showing full details from each step in the process.  This view is useful for reports, statistics and calculations that require a mixture of details from different steps.';

COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_id IS 'Internal id for a defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_status IS 'Defect status';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_location IS 'Defect location';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_description IS 'Defect description';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_priority IS 'Defect priority';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_priority_description IS 'Defect priority description';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_priority_interval IS 'Defect priority interval';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_type IS 'Defect type';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_type_description IS 'Defect type description';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_diagram_id IS 'Defect diagram id';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_height IS 'Height of defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_length IS 'Length of defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_area IS 'Area of defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.defect_superseded IS 'Flag indicating whether the defect is superseded';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.superseded_by_defect_id IS 'The internal id of the defect that has superseded this defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.network_element_id IS 'Internal id for a network element';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.network_element_offset IS 'The offset of the network element';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.xsp_code IS 'The XSP code where the defect is located';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.xsp_description IS 'The XSP description where the defect is located';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.easting IS 'The easting value for the defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.northing IS 'The northing value for the defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.inspection_id IS 'The internal id for the inspection related to this defect';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.inspection_batch_id IS 'Internal id for batch inspection';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.inspector_id IS 'Internal id for the inspector';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.inspector_initials IS 'Inspector initials';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.inspector_username IS 'Inspector username';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.activity_code IS 'The activity code';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.activity_description IS 'The activity description';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.repair_category IS 'Repair category';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.repair_category_description IS 'repair category description';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.treatment_code IS 'Treatment code';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.treatment_description IS 'Treatment description';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.repair_description IS 'Repair description';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.date_inspected IS 'The inspection date';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.date_loaded IS 'Date of the inspection details being loaded';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.date_repair_due IS 'The date the repair is due';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.date_repair_completed IS 'The date the repair was completed';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.repair_late IS 'Indicates whether the repair was late';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.days_before_repair_due IS 'The number of days the repair is due by';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.hours_before_repair_due IS 'The number of hours the repair is due by';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.days_completed_before_due IS 'The number of days the repair was completed before the due date';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.hours_completed_before_due IS 'The number of hours the repair was completed before the due date';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.days_before_inspection_due IS 'Days before an inspection is due';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.days_before_inspection_due IS 'Hours before an inspection is due';
COMMENT ON COLUMN IMF_MAI_DEFECT_REPAIRS.work_order_number IS 'Work order number';

