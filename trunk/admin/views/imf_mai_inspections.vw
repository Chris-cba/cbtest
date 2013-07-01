CREATE OR REPLACE FORCE VIEW imf_mai_inspections
  (inspection_id
  ,inspection_batch_id
  ,safety_detailed_flag
  ,safety_detailed_description
  ,initiation_type
  ,initiation_type_description
  ,surface_condition
  ,weather_condition
  ,primary_inspector_id
  ,primary_inspector_initials
  ,primary_inspector_name
  ,secondary_inspector_id
  ,secondary_inspector_initials
  ,secondary_inspector_name
  ,network_element_id
  ,start_offset
  ,end_offset
  ,date_of_entry
  ,date_inspected
  ,date_loaded
  ,number_of_defects)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_inspections.vw-arc   3.7   Jul 01 2013 15:55:04   James.Wadsworth  $
       --       Module Name      : $Workfile:   imf_mai_inspections.vw  $
       --       Date into PVCS   : $Date:   Jul 01 2013 15:55:04  $
       --       Date fetched Out : $Modtime:   Jul 01 2013 14:11:02  $
       --       Version          : $Revision:   3.7  $
       -- Foundation view displaying maintenance inspections
       ------------------------------------------------------------------
       --   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
       ------------------------------------------------------------------
       are_report_id                                          inspection_id
      ,are_batch_id                                           inspection_batch_id
      ,are_maint_insp_flag                                    safety_detailed_flag
      ,DECODE(are_maint_insp_flag,'D','Detailed'
                                 ,'S','Safety'
                                 ,'M','Maintenance')          safety_detailed_description
      ,are_initiation_type                                    initiation_type
      ,(SELECT hco.hco_meaning
          FROM hig_codes hco
         WHERE hco.hco_domain = 'INITIATION_TYPE'
           AND hco.hco_code = are_initiation_type)            initiation_type_description
      ,are_surface_condition                                  surface_condition
      ,are_weather_condition                                  weather_condition
      ,are_peo_person_id_actioned                             primary_inspector_id
      ,(SELECT HUS.HUS_INITIALS
          FROM HIG_USERS HUS
         WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_ACTIONED)  primary_inspector_initials
      ,(SELECT HUS.HUS_NAME
          FROM HIG_USERS HUS
         WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_ACTIONED)  primary_inspector_name
      ,are_peo_person_id_insp2                                secondary_inspector_id
      ,(SELECT HUS.HUS_INITIALS
          FROM HIG_USERS HUS
         WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_INSP2)     secondary_inspector_initials
      ,(SELECT HUS.HUS_NAME
          FROM HIG_USERS HUS
         WHERE HUS.HUS_USER_ID = ARE_PEO_PERSON_ID_INSP2)     secondary_inspector_name
      ,are_rse_he_id                                          network_element_id
      ,are_st_chain                                           start_offset
      ,are_end_chain                                          end_offset
      ,are_created_date                                       date_of_entry
      ,are_date_work_done                                     date_inspected
      ,are_insp_load_date                                     date_loaded
      ,(SELECT count(*)
          FROM defects
         WHERE def_are_report_id = are_report_id)             number_of_defects
  FROM activities_report                  
  WITH READ ONLY
/

COMMENT ON TABLE imf_mai_inspections IS 'Maintenance Manager foundation view of all Inspections, showing basic Inspection details. This view can be used to produce simple Inspection statistics and reports.';

COMMENT ON COLUMN imf_mai_inspections.inspection_id                IS 'The internal id of the Inspection.';
COMMENT ON COLUMN imf_mai_inspections.inspection_batch_id          IS 'The internal batch id that the Inspection is associated with.';
COMMENT ON COLUMN imf_mai_inspections.safety_detailed_flag         IS 'The Inspections Safety/Detailed flag.';
COMMENT ON COLUMN imf_mai_inspections.safety_detailed_description  IS 'The Safety/Detailed flag description.';
COMMENT ON COLUMN imf_mai_inspections.initiation_type              IS 'The Inspections Initiation Type.';
COMMENT ON COLUMN imf_mai_inspections.initiation_type_description  IS 'The Initiation Type description.';
COMMENT ON COLUMN imf_mai_inspections.surface_condition            IS 'The road surface conditions at the time of the inspection.';
COMMENT ON COLUMN imf_mai_inspections.weather_condition            IS 'The weather conditions at the time of the inspection.';
COMMENT ON COLUMN imf_mai_inspections.primary_inspector_id         IS 'Internal User id of the Primary Inspector.';
COMMENT ON COLUMN imf_mai_inspections.primary_inspector_initials   IS 'The Primary Inspectors initials.';
COMMENT ON COLUMN imf_mai_inspections.primary_inspector_name       IS 'The Primary Inspectors name.';
COMMENT ON COLUMN imf_mai_inspections.secondary_inspector_id       IS 'Internal User id of the Secondary Inspector.';
COMMENT ON COLUMN imf_mai_inspections.secondary_inspector_initials IS 'The Secondary Inspectors initials.';
COMMENT ON COLUMN imf_mai_inspections.secondary_inspector_name     IS 'The Secondary Inspectors name.';
COMMENT ON COLUMN imf_mai_inspections.network_element_id           IS 'The internal id of the Network Element that the Inspection is associated with.';
COMMENT ON COLUMN imf_mai_inspections.start_offset                 IS 'The Offset at which the Inspection began.';
COMMENT ON COLUMN imf_mai_inspections.end_offset                   IS 'The Offset at which the Inspection ended.';
COMMENT ON COLUMN imf_mai_inspections.date_of_entry                IS 'The date the Inspection details were entered into the system.';
COMMENT ON COLUMN imf_mai_inspections.date_inspected               IS 'The date the Inspection was performed.';
COMMENT ON COLUMN imf_mai_inspections.date_loaded                  IS 'The date the Inspection details were loaded into the system.';
COMMENT ON COLUMN imf_mai_inspections.number_of_defects            IS 'The number of Defects recorded during the Inspection.';
