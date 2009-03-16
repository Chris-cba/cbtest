CREATE OR REPLACE FORCE VIEW imf_mai_inspections
(
   network_element_id,
   inspection_id,
   inspection_batch_id,
   inspection_type,
   inspection_type_descr,
   inspection_start_offset,
   inspection_end_offset,
   inspector_id,
   inspector_initials,
   inspector_username,
   date_of_entry,
   date_inspected,
   date_loaded,
   days_before_inspection_due,
   hours_before_inspection_due
)
AS
SELECT
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_inspections.vw-arc   3.0   Mar 16 2009 16:19:08   drawat  $
--       Module Name      : $Workfile:   imf_mai_inspections.vw  $
--       Date into PVCS   : $Date:   Mar 16 2009 16:19:08  $
--       Date fetched Out : $Modtime:   Mar 16 2009 10:32:28  $
--       Version          : $Revision:   3.0  $
-- Foundation view displaying maintenance inspections
-------------------------------------------------------------------------   
   are_rse_he_id,
   are_report_id,
   are_batch_id,
   are_maint_insp_flag,
   DECODE(are_maint_insp_flag, 'D', 'Detailed', 'S', 'Safety', 'M', 'Maintenance'),
   are_st_chain,
   are_end_chain,
   are_peo_person_id_actioned,
   hus_initials,
   hus_username,
   are_created_date,
   are_date_work_done,
   are_insp_load_date,
   (TRUNC(are_date_work_done) - TRUNC(SYSDATE)) days_before_inspection_due,
   ((are_date_work_done - SYSDATE)*24) hours_before_inspection_due   
FROM activities_report,
     hig_users
WHERE are_peo_person_id_actioned = hus_user_id
WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_INSPECTIONS IS 'Maintenance Manager foundation view of all inspections, showing basic inspection details and calculated inspection due dates.   This view is useful for producing simple inspection statistics and reports.';

COMMENT ON COLUMN IMF_MAI_INSPECTIONS.network_element_id IS 'Internal id for a network element';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspection_id IS 'Internal id for an inspection';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspection_batch_id IS 'Internal id for batch inspection';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspection_type IS 'Inspection type';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspection_type_descr IS 'Inspection type description';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspection_start_offset IS 'Start offset of the inspection';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspection_end_offset IS 'End offset of the inspection';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspector_id IS 'Internal id for the inspector';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspector_initials IS 'Inspector initials';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.inspector_username IS 'Inspector username';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.date_of_entry IS 'Date of entry of the inspection';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.date_inspected IS 'The inspection date';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.date_loaded IS 'Date of the inspection details being loaded';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.days_before_inspection_due IS 'Days before an inspection is due';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.days_before_inspection_due IS 'Hours before an inspection is due';

