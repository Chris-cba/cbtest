CREATE OR REPLACE FORCE VIEW imf_mai_defect_repairs
  (defect_id
  ,defect_status
  ,defect_status_description
  ,defect_description
  ,location_description
  ,special_instructions
  ,priority
  ,priority_description
  ,priority_interval
  ,defect_type
  ,defect_type_description
  ,diagram_number
  ,height
  ,length
  ,area
  ,asset_modification_code
  ,asset_modification_description
  ,notify_organisation_id
  ,notify_organisation_code
  ,notify_organisation_name
  ,recharge_organisation_id
  ,recharge_organisation_code
  ,recharge_organisation_name
  ,superseded
  ,superseded_by_defect_id
  ,date_inspected
  ,date_recorded
  ,defect_date_completed
  ,date_not_found
  ,not_found_inspection_id
  ,network_element_id
  ,network_element_offset
  ,xsp
  ,xsp_description
  ,easting
  ,northing
  ,asset_type
  ,asset_id
  ,inspection_id
  ,inspection_batch_id
  ,primary_inspector_id
  ,primary_inspector_initials
  ,primary_inspector_name
  ,activity_code
  ,activity_description
  ,repair_category
  ,repair_category_description
  ,treatment_code
  ,treatment_description
  ,repair_description
  ,date_created
  ,date_due
  ,repair_date_completed
  ,repair_time_completed_hours
  ,repair_time_completed_mins
  ,repair_late
  ,days_to_date_due
  ,hours_to_date_due
  ,days_completed_before_due
  ,hours_completed_before_due
  ,days_since_inspected
  ,hours_since_inspected
  ,works_order_number)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_defect_repairs.vw-arc   3.3   Jul 07 2010 01:54:18   mhuitson  $
       --       Module Name      : $Workfile:   imf_mai_defect_repairs.vw  $
       --       Date into PVCS   : $Date:   Jul 07 2010 01:54:18  $
       --       Date fetched Out : $Modtime:   Jul 07 2010 01:50:28  $
       --       Version          : $Revision:   3.3  $
       -- Foundation view displaying maintenance defect repairs
       -------------------------------------------------------------------------
       def_defect_id                                     defect_id
      ,def_status_code                                   defect_status
      ,(SELECT hsc_status_name
          FROM hig_status_codes
         WHERE hsc_domain_code = 'DEFECTS'
           AND hsc_status_code = def_status_code)        defect_status_description
      ,def_defect_descr                                  defect_description
      ,def_locn_descr                                    location_description
      ,def_special_instr                                 special_instructions
      ,def_priority                                      priority
      ,(SELECT hco_meaning
          FROM hig_codes
         WHERE hco_domain = 'DEFECT_PRIORITIES'
           AND hco_code = def_priority )                 priority_description
      ,(SELECT dpr.dpr_int_code
          FROM defect_priorities dpr
         WHERE dpr_atv_acty_area_code = def_atv_acty_area_code
           AND  dpr_priority = def_priority
           AND  dpr_action_cat = rep_action_cat)         priority_interval
      ,def_defect_code                                   defect_type
      ,(SELECT dty_descr1
          FROM def_types
         WHERE dty_defect_code = def_defect_code
           AND dty_atv_acty_area_code = def_atv_acty_area_code
           AND dty_dtp_flag = def_ity_sys_flag )         defect_type_description
      ,def_diagram_no                                    diagram_number
      ,def_height                                        height
      ,def_length                                        length
      ,def_area                                          area
      ,def_update_inv                                    asset_modification_code
      ,(SELECT hco_meaning
          FROM hig_codes
         WHERE hco_domain = 'ASSET_MODIFICATION'
           AND hco_code = def_update_inv)                asset_modification_description
      ,def_notify_org_id                                 notify_organisation_id
      ,(SELECT oun_unit_code
          FROM org_units
         WHERE oun_org_id = def_notify_org_id)           notify_organisation_code
      ,(SELECT oun_name
          FROM org_units
         WHERE oun_org_id = def_notify_org_id)           notify_organisation_name
      ,def_rechar_org_id                                 recharge_organisation_id
      ,(SELECT oun_unit_code
          FROM org_units
         WHERE oun_org_id = def_rechar_org_id)           recharge_organisation_code
      ,(SELECT oun_name
          FROM org_units
         WHERE oun_org_id = def_rechar_org_id)           recharge_organisation_name
      ,def_superseded_flag                               superseded
      ,def_superseded_id                                 superseded_by_defect_id
      ,TO_DATE(TO_CHAR(are_date_work_done,'DD-MON-RRRR')
               ||' '||LPAD(NVL(def_time_hrs,'00'),2,'0')
               ||':'||LPAD(NVL(def_time_mins,'00'),2,'0')
              ,'DD-MON-RRRR HH24:MI')                    date_inspected
      ,def_created_date                                  date_recorded
      ,def_date_compl                                    defect_date_completed
      ,def_date_not_found                                date_not_found
      ,def_are_id_not_found                              not_found_inspection_id
      ,def_rse_he_id                                     network_element_id
      ,def_st_chain                                      network_element_offset
      ,def_x_sect                                        xsp
      ,(SELECT hco_meaning
          FROM hig_codes
         WHERE hco_domain = 'XSP_VALUES'
           AND hco_code = def_x_sect )                   xsp_description
      ,def_easting                                       easting
      ,def_northing                                      northing
      ,(SELECT nit_inv_type
          FROM inv_type_translations
         WHERE ity_inv_code = def_ity_inv_code)          asset_type
      ,def_iit_item_id                                   asset_id
      ,are_report_id                                     inspection_id
      ,are_batch_id                                      inspection_batch_id
      ,are_peo_person_id_actioned                        primary_inspector_id
      ,(SELECT hus.hus_initials
          FROM hig_users hus
         WHERE hus.hus_user_id = are_peo_person_id_actioned) primary_inspector_initials
      ,(SELECT hus.hus_name
          FROM hig_users hus
         WHERE hus.hus_user_id = are_peo_person_id_actioned) primary_inspector_name
      ,rep_atv_acty_area_code                            activity_code
      ,(SELECT atv_descr
          FROM activities
         WHERE atv_acty_area_code = rep_atv_acty_area_code
           AND atv_dtp_flag = (SELECT def_ity_sys_flag
                                 FROM defects
                                WHERE def_defect_id = rep_def_defect_id)) activity_description
      ,rep_action_cat                                    repair_category
      ,(SELECT hco.hco_meaning
          FROM hig_codes hco
         WHERE hco.hco_domain = 'REPAIR_TYPE'
           AND hco.hco_code = rep_action_cat)            repair_category_description
      ,rep_tre_treat_code                                treatment_code
      ,(SELECT tre_descr
          FROM treatments
         WHERE tre_treat_code = rep_tre_treat_code)      treatment_description
      ,rep_descr                                         repair_description
      ,are_date_work_done
      ,rep_date_due                                      date_due
      ,rep_date_completed                                repair_date_completed
      ,rep_completed_hrs                                 repair_time_completed_hours
      ,rep_completed_mins                                repair_time_completed_mins
      ,CASE
         WHEN (rep_date_completed IS NULL AND rep_date_due < sysdate)
          OR (rep_date_completed IS NOT NULL AND rep_date_due < rep_date_completed)
          THEN
              'Y'
          ELSE
              'N'
       END                                               repair_late
      ,TRUNC(rep_date_due) - TRUNC(SYSDATE)              days_to_date_due
      ,(rep_date_due - SYSDATE)*24                       hours_to_date_due
      ,TRUNC(rep_date_due) - TRUNC(rep_date_completed)   days_completed_before_due
      ,(rep_date_due - rep_date_completed)*24            hours_completed_before_due
      ,(TRUNC(SYSDATE) - TRUNC(are_date_work_done) )     days_since_inspected
      ,((SYSDATE - are_date_work_done)*24)               hours_since_inspected
      ,(SELECT wol_works_order_no
          FROM work_order_lines
         WHERE wol_def_defect_id = rep_def_defect_id
           AND wol_rep_action_cat = rep_action_cat
           AND wol_status_code NOT IN(SELECT hsc_status_code
                                        FROM hig_status_codes
                                       WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                         AND hsc_allow_feature5 = 'Y'))  works_order_number
  FROM repairs
      ,defects
      ,activities_report
 WHERE are_report_id = def_are_report_id
   AND def_defect_id = rep_def_defect_id
  WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_DEFECT_REPAIRS IS 'Maintenance Manager foundation view of all Repairs, showing details of the Repair as well as the associated Defect and Inspection. This view can be used to produce statistical and summary Maintenance Manager reports where Repair, Defect and Inspection details are required.';

COMMENT ON COLUMN imf_mai_defect_repairs.defect_id                      IS 'The internal id of the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.defect_status                  IS 'The Defect Status Code.';
COMMENT ON COLUMN imf_mai_defect_repairs.defect_status_description      IS 'The Defect Status description.';
COMMENT ON COLUMN imf_mai_defect_repairs.defect_description             IS 'Defect description.';
COMMENT ON COLUMN imf_mai_defect_repairs.location_description           IS 'The Location Description held against the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.special_instructions           IS 'Any Special Instructions held against the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.priority                       IS 'The Defect Priority';
COMMENT ON COLUMN imf_mai_defect_repairs.priority_description           IS 'The Defect Priority description';
COMMENT ON COLUMN imf_mai_defect_repairs.priority_interval              IS 'The Interval associated with the Defect Priority ';
COMMENT ON COLUMN imf_mai_defect_repairs.defect_type                    IS 'The Defect Type';
COMMENT ON COLUMN imf_mai_defect_repairs.defect_type_description        IS 'The Defect Type description.';
COMMENT ON COLUMN imf_mai_defect_repairs.diagram_number                 IS 'The Defect Diagram Number';
COMMENT ON COLUMN imf_mai_defect_repairs.height                         IS 'The Height of the Defect';
COMMENT ON COLUMN imf_mai_defect_repairs.length                         IS 'The Length of the Defect';
COMMENT ON COLUMN imf_mai_defect_repairs.area                           IS 'The Area of the Defect';
COMMENT ON COLUMN imf_mai_defect_repairs.asset_modification_code        IS 'The Asset Modification Code associated with the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.asset_modification_description IS 'The Asset Modification description';
COMMENT ON COLUMN imf_mai_defect_repairs.notify_organisation_id         IS 'The internal id of the Organisation to be Notified of the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.notify_organisation_code       IS 'The Code of the Organisation to be Notified of the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.notify_organisation_name       IS 'The Name of the Organisation to be Notified of the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.recharge_organisation_id       IS 'The internal id of the Organisation to be Charged for the repair of the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.recharge_organisation_code     IS 'The Code of the Organisation to be Charged for the repair of the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.recharge_organisation_name     IS 'The Name of the Organisation to be Charged for the repair of the Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.superseded                     IS 'Flag indicating whether the Repair has been superseded. (Y/N)';
COMMENT ON COLUMN imf_mai_defect_repairs.superseded_by_defect_id        IS 'The internal id of the Defect that has superseded this Defect.';
COMMENT ON COLUMN imf_mai_defect_repairs.date_inspected                 IS 'The date that the Inspection was carried out.';
COMMENT ON COLUMN imf_mai_defect_repairs.date_recorded                  IS 'The date the Defect was entered\loaded into the system.';
COMMENT ON COLUMN imf_mai_defect_repairs.date_not_found                 IS 'The date the Defect was not refound during a subsequent Inspection of the same type.';
COMMENT ON COLUMN imf_mai_defect_repairs.not_found_inspection_id        IS 'The internal id of the subsequent Inspection during which the Defect was not refound.';
COMMENT ON COLUMN imf_mai_defect_repairs.defect_date_completed                 IS 'The date the Defect was completed.';
COMMENT ON COLUMN imf_mai_defect_repairs.network_element_id             IS 'The internal id of the Network Element that the Defect is associated with.';
COMMENT ON COLUMN imf_mai_defect_repairs.network_element_offset         IS 'The Offset, relative to the Network Element, at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defect_repairs.xsp                            IS 'The XSP code, relative to the Network Element, at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defect_repairs.xsp_description                IS 'The XSP description.';
COMMENT ON COLUMN imf_mai_defect_repairs.easting                        IS 'The easting (x co-ordinate) at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defect_repairs.northing                       IS 'The northing (y co-ordinate) at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defect_repairs.asset_type                     IS 'The Type of Asset that the Defect is associated with.';
COMMENT ON COLUMN imf_mai_defect_repairs.asset_id                       IS 'The internal id of the Asset that the Defect is associated with.';
COMMENT ON COLUMN imf_mai_defect_repairs.inspection_id                  IS 'The internal id of the Inspection.';
COMMENT ON COLUMN imf_mai_defect_repairs.inspection_batch_id            IS 'The internal batch id that the Inspection is associated with.';
COMMENT ON COLUMN imf_mai_defect_repairs.primary_inspector_id           IS 'Internal User id of the Primary Inspector.';
COMMENT ON COLUMN imf_mai_defect_repairs.primary_inspector_initials     IS 'The Primary Inspectors initials.';
COMMENT ON COLUMN imf_mai_defect_repairs.primary_inspector_name         IS 'The Primary Inspectors name.';
COMMENT ON COLUMN imf_mai_defect_repairs.activity_code                  IS 'The Activity Code associated with the Repair.';
COMMENT ON COLUMN imf_mai_defect_repairs.activity_description           IS 'The Activity description.';
COMMENT ON COLUMN imf_mai_defect_repairs.repair_category                IS 'Repair category';
COMMENT ON COLUMN imf_mai_defect_repairs.repair_category_description    IS 'repair category description';
COMMENT ON COLUMN imf_mai_defect_repairs.treatment_code                 IS 'Treatment code';
COMMENT ON COLUMN imf_mai_defect_repairs.treatment_description          IS 'Treatment description';
COMMENT ON COLUMN imf_mai_defect_repairs.repair_description             IS 'Repair description';
COMMENT ON COLUMN imf_mai_defect_repairs.date_created                   IS 'The date the Repair was created within the system.';
COMMENT ON COLUMN imf_mai_defect_repairs.date_due                       IS 'The date the Repair is due to by completed by.';
COMMENT ON COLUMN imf_mai_defect_repairs.repair_date_completed          IS 'The date the Repair was completed.';
COMMENT ON COLUMN imf_mai_defect_repairs.repair_time_completed_hours    IS 'The hour upon which the repair was completed.';
COMMENT ON COLUMN imf_mai_defect_repairs.repair_time_completed_mins     IS 'The minute upon which the repair was completed.';
COMMENT ON COLUMN imf_mai_defect_repairs.repair_late                    IS 'Indicates whether the repair was late. (Y/N)';
COMMENT ON COLUMN imf_mai_defect_repairs.days_to_date_due               IS 'The number of days until the Repair Date Due.';
COMMENT ON COLUMN imf_mai_defect_repairs.hours_to_date_due              IS 'The number of hours until the Repair Date Due.';
COMMENT ON COLUMN imf_mai_defect_repairs.days_completed_before_due      IS 'The number of days prior to the Due Date that the repair was completed. (A negative value indicates the number of days late)';
COMMENT ON COLUMN imf_mai_defect_repairs.hours_completed_before_due     IS 'The number of hours prior to the Due Date that the repair was completed. (A negative value indicates the number of hours late)';
COMMENT ON COLUMN imf_mai_defect_repairs.days_since_inspected           IS 'Days since an inspection took place';
COMMENT ON COLUMN imf_mai_defect_repairs.hours_since_inspected          IS 'Hours since an inspection took place';
COMMENT ON COLUMN imf_mai_defect_repairs.works_order_number             IS 'The Works Order Number associated with the Repair.';
