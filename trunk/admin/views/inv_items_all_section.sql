-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/views/inv_items_all_section.sql-arc   3.1   Jul 31 2009 10:18:18   mhuitson  $
--       Module Name      : $Workfile:   inv_items_all_section.sql  $
--       Date into SCCS   : $Date:   Jul 31 2009 10:18:18  $
--       Date fetched Out : $Modtime:   Jul 31 2009 10:17:48  $
--       SCCS Version     : $Revision:   3.1  $
--       Based on SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
--
--Creates the inv_items_all_section view using a
--configuration suitable for a conflated network
--i.e. the Maintenance Sections are not Datum
--Elements but groups of Datum Elements.
--
prompt
prompt Inventory Translation View For Conflated Networks.
prompt Exor Corporation 2009
prompt
prompt answer ALL questions, pressing RETURN AFTER EACH one
prompt
--
undefine p_grp_type
--
ACCEPT p_grp_type char prompt 'PLEASE ENTER THE GROUP TYPE OF THE MAINTAINENCE SECTIONS : ';
--
prompt
prompt Creating View...
prompt
--
SET verify OFF;
SET feedback OFF;
SET serveroutput ON
--
DECLARE
  pi_group_type VARCHAR2(10) := UPPER('&p_grp_type');
  lv_dummy      NUMBER;
  lv_str        nm3type.max_varchar2;
BEGIN
  /*
  ||Check The Group Type Given.
  */
  SELECT 1
    INTO lv_dummy
   WHERE ngt_group_type = :pi_group_type
     AND ngt_sub_group_allowed = 'N'
     AND EXISTS(SELECT 1
                  FROM nm_linear_types
                 WHERE nlt_gty_type = ngt_group_type)
       ;
  /*
  ||Build The View Script.
  */
  lv_str := 'CREATE OR REPLACE FORCE VIEW inv_items_all_section'
 ||CHR(10)||'-----------------------------------------------------------------------------'
 ||CHR(10)||'--'
 ||CHR(10)||'--   SCCS Identifiers :-'
 ||CHR(10)||'--'
 ||CHR(10)||'--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05             '
 ||CHR(10)||'--       Module Name      : mai_transviews.sql                               '
 ||CHR(10)||'--       Date into SCCS   : 05/02/22 11:22:34                                '
 ||CHR(10)||'--       Date fetched Out : 07/06/07 11:16:38                                '
 ||CHR(10)||'--       SCCS Version     : 1.14                                             '
 ||CHR(10)||'--                                                                           '
 ||CHR(10)||'-----------------------------------------------------------------------------'
 ||CHR(10)||'--   Originally taken from                                                   '
 ||CHR(10)||'-----------------------------------------------------------------------------'
 ||CHR(10)||'--	Copyright (c) exor corporation ltd, 2009                                  '
 ||CHR(10)||'-----------------------------------------------------------------------------'
 ||CHR(10)||'  (iit_created_date'
 ||CHR(10)||'  ,iit_cre_date'
 ||CHR(10)||'  ,iit_item_id'
 ||CHR(10)||'  ,iit_ity_inv_code'
 ||CHR(10)||'  ,iit_ity_sys_flag'
 ||CHR(10)||'  ,iit_last_updated_date'
 ||CHR(10)||'  ,iit_rse_he_id'
 ||CHR(10)||'  ,iit_st_chain'
 ||CHR(10)||'  ,iit_angle'
 ||CHR(10)||'  ,iit_angle_txt'
 ||CHR(10)||'  ,iit_class'
 ||CHR(10)||'  ,iit_class_txt'
 ||CHR(10)||'  ,iit_colour'
 ||CHR(10)||'  ,iit_colour_txt'
 ||CHR(10)||'  ,iit_coord_flag'
 ||CHR(10)||'  ,iit_description'
 ||CHR(10)||'  ,iit_diagram'
 ||CHR(10)||'  ,iit_distance'
 ||CHR(10)||'  ,iit_end_chain'
 ||CHR(10)||'  ,iit_end_date'
 ||CHR(10)||'  ,iit_gap'
 ||CHR(10)||'  ,iit_height'
 ||CHR(10)||'  ,iit_height_2'
 ||CHR(10)||'  ,iit_id_code'
 ||CHR(10)||'  ,iit_instal_date'
 ||CHR(10)||'  ,iit_invent_date'
 ||CHR(10)||'  ,iit_inv_ownership'
 ||CHR(10)||'  ,iit_itemcode'
 ||CHR(10)||'  ,iit_lco_lamp_config_id'
 ||CHR(10)||'  ,iit_length'
 ||CHR(10)||'  ,iit_material'
 ||CHR(10)||'  ,iit_material_txt'
 ||CHR(10)||'  ,iit_method'
 ||CHR(10)||'  ,iit_method_txt'
 ||CHR(10)||'  ,iit_note'
 ||CHR(10)||'  ,iit_no_of_units'
 ||CHR(10)||'  ,iit_options'
 ||CHR(10)||'  ,iit_options_txt'
 ||CHR(10)||'  ,iit_oun_org_id_elec_board'
 ||CHR(10)||'  ,iit_owner'
 ||CHR(10)||'  ,iit_owner_txt'
 ||CHR(10)||'  ,iit_peo_invent_by_id'
 ||CHR(10)||'  ,iit_photo'
 ||CHR(10)||'  ,iit_power'
 ||CHR(10)||'  ,iit_prov_flag'
 ||CHR(10)||'  ,iit_rev_by'
 ||CHR(10)||'  ,iit_rev_date'
 ||CHR(10)||'  ,iit_type'
 ||CHR(10)||'  ,iit_type_txt'
 ||CHR(10)||'  ,iit_width'
 ||CHR(10)||'  ,iit_xtra_char_1'
 ||CHR(10)||'  ,iit_xtra_date_1'
 ||CHR(10)||'  ,iit_xtra_domain_1'
 ||CHR(10)||'  ,iit_xtra_domain_txt_1'
 ||CHR(10)||'  ,iit_xtra_number_1'
 ||CHR(10)||'  ,iit_x_sect'
 ||CHR(10)||'  ,iit_primary_key'
 ||CHR(10)||'  ,iit_foreign_key'
 ||CHR(10)||'  ,iit_det_xsp'
 ||CHR(10)||'  ,iit_offset'
 ||CHR(10)||'  ,iit_num_attrib16'
 ||CHR(10)||'  ,iit_num_attrib17'
 ||CHR(10)||'  ,iit_num_attrib18'
 ||CHR(10)||'  ,iit_num_attrib19'
 ||CHR(10)||'  ,iit_num_attrib20'
 ||CHR(10)||'  ,iit_num_attrib21'
 ||CHR(10)||'  ,iit_num_attrib22'
 ||CHR(10)||'  ,iit_num_attrib23'
 ||CHR(10)||'  ,iit_num_attrib24'
 ||CHR(10)||'  ,iit_num_attrib25'
 ||CHR(10)||'  ,iit_chr_attrib26'
 ||CHR(10)||'  ,iit_chr_attrib27'
 ||CHR(10)||'  ,iit_chr_attrib28'
 ||CHR(10)||'  ,iit_chr_attrib29'
 ||CHR(10)||'  ,iit_chr_attrib30'
 ||CHR(10)||'  ,iit_chr_attrib31'
 ||CHR(10)||'  ,iit_chr_attrib32'
 ||CHR(10)||'  ,iit_chr_attrib33'
 ||CHR(10)||'  ,iit_chr_attrib34'
 ||CHR(10)||'  ,iit_chr_attrib35'
 ||CHR(10)||'  ,iit_chr_attrib36'
 ||CHR(10)||'  ,iit_chr_attrib37'
 ||CHR(10)||'  ,iit_chr_attrib38'
 ||CHR(10)||'  ,iit_chr_attrib39'
 ||CHR(10)||'  ,iit_chr_attrib40'
 ||CHR(10)||'  ,iit_chr_attrib41'
 ||CHR(10)||'  ,iit_chr_attrib42'
 ||CHR(10)||'  ,iit_chr_attrib43'
 ||CHR(10)||'  ,iit_chr_attrib44'
 ||CHR(10)||'  ,iit_chr_attrib45'
 ||CHR(10)||'  ,iit_chr_attrib46'
 ||CHR(10)||'  ,iit_chr_attrib47'
 ||CHR(10)||'  ,iit_chr_attrib48'
 ||CHR(10)||'  ,iit_chr_attrib49'
 ||CHR(10)||'  ,iit_chr_attrib50'
 ||CHR(10)||'  ,iit_chr_attrib51'
 ||CHR(10)||'  ,iit_chr_attrib52'
 ||CHR(10)||'  ,iit_chr_attrib53'
 ||CHR(10)||'  ,iit_chr_attrib54'
 ||CHR(10)||'  ,iit_chr_attrib55'
 ||CHR(10)||'  ,iit_chr_attrib56'
 ||CHR(10)||'  ,iit_chr_attrib57'
 ||CHR(10)||'  ,iit_chr_attrib58'
 ||CHR(10)||'  ,iit_chr_attrib59'
 ||CHR(10)||'  ,iit_chr_attrib60'
 ||CHR(10)||'  ,iit_chr_attrib61'
 ||CHR(10)||'  ,iit_chr_attrib62'
 ||CHR(10)||'  ,iit_chr_attrib63'
 ||CHR(10)||'  ,iit_chr_attrib64'
 ||CHR(10)||'  ,iit_chr_attrib65'
 ||CHR(10)||'  ,iit_chr_attrib66'
 ||CHR(10)||'  ,iit_chr_attrib67'
 ||CHR(10)||'  ,iit_chr_attrib68'
 ||CHR(10)||'  ,iit_chr_attrib69'
 ||CHR(10)||'  ,iit_chr_attrib70'
 ||CHR(10)||'  ,iit_chr_attrib71'
 ||CHR(10)||'  ,iit_chr_attrib72'
 ||CHR(10)||'  ,iit_chr_attrib73'
 ||CHR(10)||'  ,iit_chr_attrib74'
 ||CHR(10)||'  ,iit_chr_attrib75'
 ||CHR(10)||'  ,iit_num_attrib76'
 ||CHR(10)||'  ,iit_num_attrib77'
 ||CHR(10)||'  ,iit_num_attrib78'
 ||CHR(10)||'  ,iit_num_attrib79'
 ||CHR(10)||'  ,iit_num_attrib80'
 ||CHR(10)||'  ,iit_num_attrib81'
 ||CHR(10)||'  ,iit_num_attrib82'
 ||CHR(10)||'  ,iit_num_attrib83'
 ||CHR(10)||'  ,iit_num_attrib84'
 ||CHR(10)||'  ,iit_num_attrib85'
 ||CHR(10)||'  ,iit_date_attrib86'
 ||CHR(10)||'  ,iit_date_attrib87'
 ||CHR(10)||'  ,iit_date_attrib88'
 ||CHR(10)||'  ,iit_date_attrib89'
 ||CHR(10)||'  ,iit_date_attrib90'
 ||CHR(10)||'  ,iit_date_attrib91'
 ||CHR(10)||'  ,iit_date_attrib92'
 ||CHR(10)||'  ,iit_date_attrib93'
 ||CHR(10)||'  ,iit_date_attrib94'
 ||CHR(10)||'  ,iit_date_attrib95)'
 ||CHR(10)||'AS'
 ||CHR(10)||'SELECT UNIQUE iit_date_created iit_created_date, inv.iit_start_date iit_cre_date'
 ||CHR(10)||'      ,inv.iit_ne_id iit_item_id, itt.ity_inv_code iit_ity_inv_code'
 ||CHR(10)||'      ,itt.ity_sys_flag iit_ity_sys_flag'
 ||CHR(10)||'      ,iit_date_modified iit_last_updated_date, mem.ne_id iit_rse_he_id'
 ||CHR(10)||'      ,mem.pl_start iit_st_chain, iit_angle, iit_angle_txt, iit_class'
 ||CHR(10)||'      ,iit_class_txt, iit_colour, iit_colour_txt, iit_coord_flag'
 ||CHR(10)||'      ,iit_description, iit_diagram, iit_distance, mem.pl_end iit_end_chain'
 ||CHR(10)||'      ,iit_end_date, iit_gap, iit_height, iit_height_2, iit_id_code'
 ||CHR(10)||'      ,iit_instal_date, iit_invent_date, iit_inv_ownership, iit_itemcode'
 ||CHR(10)||'      ,iit_lco_lamp_config_id, iit_length, iit_material, iit_material_txt'
 ||CHR(10)||'      ,iit_method, iit_method_txt, iit_note, iit_no_of_units, iit_options'
 ||CHR(10)||'      ,iit_options_txt, iit_oun_org_id_elec_board, iit_owner'
 ||CHR(10)||'      ,iit_owner_txt, iit_peo_invent_by_id, iit_photo, iit_power'
 ||CHR(10)||'      ,iit_prov_flag, iit_rev_by, iit_rev_date, iit_type, iit_type_txt'
 ||CHR(10)||'      ,iit_width, iit_xtra_char_1, iit_xtra_date_1, iit_xtra_domain_1'
 ||CHR(10)||'      ,iit_xtra_domain_txt_1, iit_xtra_number_1, iit_x_sect'
 ||CHR(10)||'      ,iit_primary_key, iit_foreign_key, iit_det_xsp, iit_offset'
 ||CHR(10)||'      ,iit_num_attrib16, iit_num_attrib17, iit_num_attrib18'
 ||CHR(10)||'      ,iit_num_attrib19, iit_num_attrib20, iit_num_attrib21'
 ||CHR(10)||'      ,iit_num_attrib22, iit_num_attrib23, iit_num_attrib24'
 ||CHR(10)||'      ,iit_num_attrib25, iit_chr_attrib26, iit_chr_attrib27'
 ||CHR(10)||'      ,iit_chr_attrib28, iit_chr_attrib29, iit_chr_attrib30'
 ||CHR(10)||'      ,iit_chr_attrib31, iit_chr_attrib32, iit_chr_attrib33'
 ||CHR(10)||'      ,iit_chr_attrib34, iit_chr_attrib35, iit_chr_attrib36'
 ||CHR(10)||'      ,iit_chr_attrib37, iit_chr_attrib38, iit_chr_attrib39'
 ||CHR(10)||'      ,iit_chr_attrib40, iit_chr_attrib41, iit_chr_attrib42'
 ||CHR(10)||'      ,iit_chr_attrib43, iit_chr_attrib44, iit_chr_attrib45'
 ||CHR(10)||'      ,iit_chr_attrib46, iit_chr_attrib47, iit_chr_attrib48'
 ||CHR(10)||'      ,iit_chr_attrib49, iit_chr_attrib50, iit_chr_attrib51'
 ||CHR(10)||'      ,iit_chr_attrib52, iit_chr_attrib53, iit_chr_attrib54'
 ||CHR(10)||'      ,iit_chr_attrib55, iit_chr_attrib56, iit_chr_attrib57'
 ||CHR(10)||'      ,iit_chr_attrib58, iit_chr_attrib59, iit_chr_attrib60'
 ||CHR(10)||'      ,iit_chr_attrib61, iit_chr_attrib62, iit_chr_attrib63'
 ||CHR(10)||'      ,iit_chr_attrib64, iit_chr_attrib65, iit_chr_attrib66'
 ||CHR(10)||'      ,iit_chr_attrib67, iit_chr_attrib68, iit_chr_attrib69'
 ||CHR(10)||'      ,iit_chr_attrib70, iit_chr_attrib71, iit_chr_attrib72'
 ||CHR(10)||'      ,iit_chr_attrib73, iit_chr_attrib74, iit_chr_attrib75'
 ||CHR(10)||'      ,iit_num_attrib76, iit_num_attrib77, iit_num_attrib78'
 ||CHR(10)||'      ,iit_num_attrib79, iit_num_attrib80, iit_num_attrib81'
 ||CHR(10)||'      ,iit_num_attrib82, iit_num_attrib83, iit_num_attrib84'
 ||CHR(10)||'      ,iit_num_attrib85, iit_date_attrib86, iit_date_attrib87'
 ||CHR(10)||'      ,iit_date_attrib88, iit_date_attrib89, iit_date_attrib90'
 ||CHR(10)||'      ,iit_date_attrib91, iit_date_attrib92, iit_date_attrib93'
 ||CHR(10)||'      ,iit_date_attrib94, iit_date_attrib95'
 ||CHR(10)||' FROM (SELECT im.nm_ne_id_in iit_ne_id'
 ||CHR(10)||'             ,rm.nm_ne_id_in ne_id'
 ||CHR(10)||'             ,pl.pl_start'
 ||CHR(10)||'             ,pl.pl_end'
 ||CHR(10)||'         FROM nm_members im'
 ||CHR(10)||'             ,nm_members rm'
 ||CHR(10)||'             ,TABLE(nm3pla.get_connected_chunks(im.nm_ne_id_in,rm.nm_ne_id_in).npa_placement_array) pl'
 ||CHR(10)||'        WHERE im.nm_ne_id_of = rm.nm_ne_id_of'
 ||CHR(10)||'          AND rm.nm_obj_type = '||nm3flx.string(pi_group_type)||') mem'
 ||CHR(10)||'     ,nm_inv_items_all inv'
 ||CHR(10)||'     ,inv_type_translations itt'
 ||CHR(10)||'WHERE itt.nit_inv_type = inv.iit_inv_type'
 ||CHR(10)||'  AND inv.iit_ne_id = mem.iit_ne_id'
   ;
  /*
  ||Create The View.
  */
  EXECUTE IMMEDIATE lv_str;
  /*
  ||Report Success.
  */
  dbms_output.put_line('View Created');
  --
EXCEPTION
  WHEN no_data_found
   THEN
      dbms_output.put_line('Invalid Group Type Entered');
END;
/