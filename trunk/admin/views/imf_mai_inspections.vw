CREATE OR REPLACE FORCE VIEW imf_mai_inspections
(
   network_element_id,
   inspection_id,
   inspection_batch_id,
   inspection_type,
   inspection_type_descr,
   inspection_start_offset,
   inspection_end_offset,
   primary_inspector_id,
   primary_inspector_initials,
   primary_inspector_name,
   primary_inspector_username,
   secondary_inspector_id,
   secondary_inspector_initials,
   secondary_inspector_name,
   secondary_inspector_username,
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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_inspections.vw-arc   3.4   May 12 2009 14:45:38   smarshall  $
--       Module Name      : $Workfile:   imf_mai_inspections.vw  $
--       Date into PVCS   : $Date:   May 12 2009 14:45:38  $
--       Date fetched Out : $Modtime:   May 12 2009 14:41:24  $
--       Version          : $Revision:   3.4  $
-- Foundation view displaying maintenance inspections
-------------------------------------------------------------------------
-- SM 03042009
-- Added inspector_name.
-- SM 12052009
-- Added secondary_inspector details and renamed inspector details to be
-- primary_inspector details.
-------------------------------------------------------------------------
   are_rse_he_id,
   are_report_id,
   are_batch_id,
   are_maint_insp_flag,
   DECODE(are_maint_insp_flag, 'D', 'Detailed', 'S', 'Safety', 'M', 'Maintenance'),
   are_st_chain,
   are_end_chain,
   are_peo_person_id_actioned,
   ( SELECT HUS.HUS_INITIALS
       FROM HIG_USERS HUS
      WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_ACTIONED ) primary_inspector_initials,
   ( SELECT HUS.HUS_NAME
       FROM HIG_USERS HUS
      WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_ACTIONED ) primary_inspector_name,
   ( SELECT HUS.HUS_USERNAME
       FROM HIG_USERS HUS
      WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_ACTIONED ) primary_inspector_username,
   are_peo_person_id_insp2,
   ( SELECT HUS.HUS_INITIALS
       FROM HIG_USERS HUS
      WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_INSP2 ) secondary_inspector_initials,
   ( SELECT HUS.HUS_NAME
       FROM HIG_USERS HUS
      WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_INSP2 ) secondary_inspector_name,
   ( SELECT HUS.HUS_USERNAME
       FROM HIG_USERS HUS
      WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_INSP2 ) secondary_inspector_username,      	
   are_created_date,
   are_date_work_done,
   are_insp_load_date,
   (TRUNC(are_date_work_done) - TRUNC(SYSDATE)) days_before_inspection_due,
   ((are_date_work_done - SYSDATE)*24) hours_before_inspection_due   
FROM activities_report
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
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.primary_inspector_id IS 'Internal id for the Primary Inspector';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.primary_inspector_initials IS 'Primary Inspectors initials';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.primary_inspector_username IS 'Name of Primary Inspector';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.primary_inspector_username IS 'Primary Inspectors username';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.secondary_inspector_id IS 'Internal id for the Secondary Inspector';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.secondary_inspector_initials IS 'Secondary Inspectors initials';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.secondary_inspector_username IS 'Name of Secondary Inspector';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.secondary_inspector_username IS 'Secondary Inspectors username';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.date_of_entry IS 'Date of entry of the inspection';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.date_inspected IS 'The inspection date';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.date_loaded IS 'Date of the inspection details being loaded';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.days_before_inspection_due IS 'Days before an inspection is due';
COMMENT ON COLUMN IMF_MAI_INSPECTIONS.hours_before_inspection_due IS 'Hours before an inspection is due';

