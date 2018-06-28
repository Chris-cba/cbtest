CREATE OR REPLACE FORCE VIEW imf_mai_defects
  (defect_id
  ,inspection_id
  ,defect_description
  ,location_description
  ,special_instructions
  ,defect_status
  ,defect_status_description
  ,network_element_id
  ,network_element_offset
  ,xsp
  ,xsp_description
  ,easting
  ,northing
  ,asset_type
  ,asset_id
  ,activity_code
  ,activity_description
  ,priority
  ,priority_description
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
  ,date_not_found
  ,not_found_inspection_id
  ,date_completed
  ,works_order_number)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/imf_mai_defects.vw-arc   3.5   Jun 28 2018 04:46:50   Gaurav.Gaurkar  $
       --       Module Name      : $Workfile:   imf_mai_defects.vw  $
       --       Date into PVCS   : $Date:   Jun 28 2018 04:46:50  $
       --       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
       --       Version          : $Revision:   3.5  $
       -- Foundation view displaying maintenance defects
       ------------------------------------------------------------------
       --   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
       ------------------------------------------------------------------
       def_defect_id                                     defect_id
      ,def_are_report_id                                 inspection_id
      ,def_defect_descr                                  defect_description
      ,def_locn_descr                                    location_description
      ,def_special_instr                                 special_instructions
      ,def_status_code                                   defect_status
      ,(SELECT hsc_status_name
          FROM hig_status_codes
         WHERE hsc_domain_code = 'DEFECTS'
           AND hsc_status_code = def_status_code)        defect_status_description
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
      ,def_atv_acty_area_code                            activity_code
      ,(SELECT atv_descr
          FROM activities
         WHERE atv_acty_area_code = def_atv_acty_area_code
           AND atv_dtp_flag = def_ity_sys_flag )         activity_description
      ,def_priority                                      priority
      ,(SELECT hco_meaning
          FROM hig_codes
         WHERE hco_domain = 'DEFECT_PRIORITIES'
           AND hco_code = def_priority )                 priority_description
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
      ,TO_DATE(DECODE(def_inspection_date,NULL,NULL
                                              ,TO_CHAR(def_inspection_date,'DD-MON-RRRR')
                                                ||' '||LPAD(NVL(def_time_hrs,'00'),2,'0')
                                                ||':'||LPAD(NVL(def_time_mins,'00'),2,'0'))
              ,'DD-MON-RRRR HH24:MI')                    date_inspected
      ,def_created_date                                  date_recorded
      ,def_date_not_found                                date_not_found
      ,def_are_id_not_found                              not_found_inspection_id
      ,def_date_compl                                    date_completed
      ,def_works_order_no                                works_order_number
  FROM defects
  WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_DEFECTS IS 'Maintenance Manager foundation view of all Defects, showing Defect details. This view can be used to produce statistical and summary Maintenance Manager reports where Defect details are required.';

COMMENT ON COLUMN imf_mai_defects.defect_id                      IS 'The internal id of the Defect.';
COMMENT ON COLUMN imf_mai_defects.inspection_id                  IS 'The internal id of the Inspection that the Defect is associated with.';
COMMENT ON COLUMN imf_mai_defects.defect_description             IS 'Defect description.';
COMMENT ON COLUMN imf_mai_defects.location_description           IS 'The Location Description held against the Defect.';
COMMENT ON COLUMN imf_mai_defects.special_instructions           IS 'Any Special Instructions held against the Defect.';
COMMENT ON COLUMN imf_mai_defects.defect_status                  IS 'The Defect Status Code.';
COMMENT ON COLUMN imf_mai_defects.defect_status_description      IS 'The Defect Status description.';
COMMENT ON COLUMN imf_mai_defects.network_element_id             IS 'The internal id of the Network Element that the Defect is associated with.';
COMMENT ON COLUMN imf_mai_defects.network_element_offset         IS 'The Offset, relative to the Network Element, at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defects.xsp                            IS 'The XSP code, relative to the Network Element, at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defects.xsp_description                IS 'The XSP description.';
COMMENT ON COLUMN imf_mai_defects.easting                        IS 'The easting (x co-ordinate) at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defects.northing                       IS 'The northing (y co-ordinate) at which the Defect was observed.';
COMMENT ON COLUMN imf_mai_defects.asset_type                     IS 'The Type of Asset that the Defect is associated with.';
COMMENT ON COLUMN imf_mai_defects.asset_id                       IS 'The internal id of the Asset that the Defect is associated with.';
COMMENT ON COLUMN imf_mai_defects.activity_code                  IS 'The Activity Code associated with the Defect';
COMMENT ON COLUMN imf_mai_defects.activity_description           IS 'The Activity description';
COMMENT ON COLUMN imf_mai_defects.priority                       IS 'The Defect Priority';
COMMENT ON COLUMN imf_mai_defects.priority_description           IS 'The Defect Priority description';
COMMENT ON COLUMN imf_mai_defects.defect_type                    IS 'The Defect Type';
COMMENT ON COLUMN imf_mai_defects.defect_type_description        IS 'The Defect Type description.';
COMMENT ON COLUMN imf_mai_defects.diagram_number                 IS 'The Defect Diagram Number';
COMMENT ON COLUMN imf_mai_defects.height                         IS 'The Height of the Defect';
COMMENT ON COLUMN imf_mai_defects.length                         IS 'The Length of the Defect';
COMMENT ON COLUMN imf_mai_defects.area                           IS 'The Area of the Defect';
COMMENT ON COLUMN imf_mai_defects.asset_modification_code        IS 'The Asset Modification Code associated with the Defect.';
COMMENT ON COLUMN imf_mai_defects.asset_modification_description IS 'The Asset Modification description';
COMMENT ON COLUMN imf_mai_defects.notify_organisation_id         IS 'The internal id of the Organisation to be Notified of the Defect.';
COMMENT ON COLUMN imf_mai_defects.notify_organisation_code       IS 'The Code of the Organisation to be Notified of the Defect.';
COMMENT ON COLUMN imf_mai_defects.notify_organisation_name       IS 'The Name of the Organisation to be Notified of the Defect.';
COMMENT ON COLUMN imf_mai_defects.recharge_organisation_id       IS 'The internal id of the Organisation to be Charged for the repair of the Defect.';
COMMENT ON COLUMN imf_mai_defects.recharge_organisation_code     IS 'The Code of the Organisation to be Charged for the repair of the Defect.';
COMMENT ON COLUMN imf_mai_defects.recharge_organisation_name     IS 'The Name of the Organisation to be Charged for the repair of the Defect.';
COMMENT ON COLUMN imf_mai_defects.superseded                     IS 'Flag indicating whether the Repair has been superseded. (Y/N)';
COMMENT ON COLUMN imf_mai_defects.superseded_by_defect_id        IS 'The internal id of the Defect that has superseded this Defect.';
COMMENT ON COLUMN imf_mai_defects.date_inspected                 IS 'The date the Inspection that the Defect is associated with was performed.';
COMMENT ON COLUMN imf_mai_defects.date_recorded                  IS 'The date the Defect was entered\loaded into the system.';
COMMENT ON COLUMN imf_mai_defects.date_not_found                 IS 'The date the Defect was not refound during a subsequent Inspection of the same type.';
COMMENT ON COLUMN imf_mai_defects.not_found_inspection_id        IS 'The internal id of the subsequent Inspection during which the Defect was not refound.';
COMMENT ON COLUMN imf_mai_defects.date_completed                 IS 'The date the Defect was completed.';
COMMENT ON COLUMN imf_mai_defects.works_order_number             IS 'The Works Order Number most recently associated with the Defect.';
