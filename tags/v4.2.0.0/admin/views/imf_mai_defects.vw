CREATE OR REPLACE FORCE VIEW imf_mai_defects
(
   defect_id,
   defect_status,
   defect_location,
   defect_description,
   defect_priority,
   defect_priority_description,
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
   activity_code,
   activity_description,
   date_loaded,
   date_defect_completed,
   not_found_inspection_id,
   date_not_found,   
   work_order_number
)
AS
SELECT
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_defects.vw-arc   3.1   Mar 19 2009 17:34:00   drawat  $
--       Module Name      : $Workfile:   imf_mai_defects.vw  $
--       Date into PVCS   : $Date:   Mar 19 2009 17:34:00  $
--       Date fetched Out : $Modtime:   Mar 19 2009 17:24:16  $
--       Version          : $Revision:   3.1  $
-- Foundation view displaying maintenance defects
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
   def_atv_acty_area_code,
   ( SELECT atv_descr
       FROM activities
      WHERE atv_acty_area_code = def_atv_acty_area_code
        AND atv_dtp_flag = def_ity_sys_flag ) atv_descr,
   def_created_date,   
   def_date_compl date_defect_completed,
   def_are_id_not_found not_found_inspection_id,
   def_date_not_found date_not_found,   
   def_works_order_no
FROM defects
WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_DEFECTS IS 'Maintenance Manager foundation view of all defects, showing basic defect details.   This view is useful for producing simple defect statistics and reports.';

COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_id IS 'Internal id for defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_status IS 'Defect status';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_location IS 'Defect location';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_description IS 'Defect description';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_priority IS 'Defect priority';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_priority_description IS 'Defect priority description';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_type IS 'Defect type';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_type_description IS 'Defect type description';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_diagram_id IS 'Defect diagram id';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_height IS 'Height of defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_length IS 'Length of defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_area IS 'Area of defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.defect_superseded IS 'Flag indicating whether the defect is superseded';
COMMENT ON COLUMN IMF_MAI_DEFECTS.superseded_by_defect_id IS 'The internal id of the defect that has superseded this defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.network_element_id IS 'Internal id for a network element';
COMMENT ON COLUMN IMF_MAI_DEFECTS.network_element_offset IS 'The offset of the network element';
COMMENT ON COLUMN IMF_MAI_DEFECTS.xsp_code IS 'The XSP code where the defect is located';
COMMENT ON COLUMN IMF_MAI_DEFECTS.xsp_description IS 'The XSP description where the defect is located';
COMMENT ON COLUMN IMF_MAI_DEFECTS.easting IS 'The easting value for the defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.northing IS 'The northing value for the defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.inspection_id IS 'The internal id for the inspection related to this defect';
COMMENT ON COLUMN IMF_MAI_DEFECTS.activity_code IS 'The activity code';
COMMENT ON COLUMN IMF_MAI_DEFECTS.activity_description IS 'The activity description';
COMMENT ON COLUMN IMF_MAI_DEFECTS.date_loaded IS 'The date this defect was loaded';
COMMENT ON COLUMN IMF_MAI_DEFECTS.date_defect_completed IS 'The defect date completion';
COMMENT ON COLUMN IMF_MAI_DEFECTS.not_found_inspection_id IS 'The internal id for a defect that could not be refound';
COMMENT ON COLUMN IMF_MAI_DEFECTS.date_not_found IS 'The date when a defect could not be found';
COMMENT ON COLUMN IMF_MAI_DEFECTS.work_order_number IS 'The work order number related to this defect';


