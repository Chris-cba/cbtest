CREATE OR REPLACE FORCE VIEW v_ukpms_road_section  (
  iit_created_date,
  iit_cre_date,
  iit_item_id,
  iit_ity_inv_code,
  iit_ity_sys_flag,
  iit_last_updated_date,
  iit_rse_he_id,
  iit_st_chain,
  iit_x_sect,
  iit_end_chain,
  iit_width,
  iit_end_date,
  road_hier,
  speed_limit,
  nominated,
  road_type,
  no_of_lanes,
  step_level,
  off_cw_tied_ind,
  drain_status,
  veh_traff_on_fw,
  freq_open_fw,
  diversion_quality,
  surv_direction,
  on_cw_xsp_method,
  off_cw_xsp_method,
  traffic_level,
  footway_hier,
  sec_len_stat,
  rse_unique,
  rse_descr,
  rse_length,
  rse_road_environment,
  rse_end_date,
  rse_admin_unit
) AS 
SELECT /* INDEX (INV_ITEMS_ALL IIT_INDEX_P2) */  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_ukpms_road_section.vw-arc   3.0   Nov 05 2009 10:35:02   gjohnson  $
--       Module Name      : $Workfile:   v_ukpms_road_section.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:02  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:08:46  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
        iit_created_date,
            iit_cre_date,
iit_item_id,
iit_ity_inv_code,
iit_ity_sys_flag,
iit_last_updated_date,
iit_rse_he_id,
iit_st_chain,
iit_x_sect,
iit_end_chain,
iit_width,
iit_end_date,
IIT_CHR_ATTRIB27
ROAD_HIER,
IIT_CHR_ATTRIB28
SPEED_LIMIT,
IIT_CHR_ATTRIB29
NOMINATED,
IIT_CHR_ATTRIB30
ROAD_TYPE,
IIT_NUM_ATTRIB16
NO_OF_LANES,
IIT_CHR_ATTRIB31
STEP_LEVEL,
IIT_CHR_ATTRIB32
OFF_CW_TIED_IND,
IIT_CHR_ATTRIB33
DRAIN_STATUS,
IIT_CHR_ATTRIB34
VEH_TRAFF_ON_FW,
IIT_CHR_ATTRIB35
FREQ_OPEN_FW,
IIT_CHR_ATTRIB36
DIVERSION_QUALITY,
IIT_CHR_ATTRIB37
SURV_DIRECTION,
IIT_CHR_ATTRIB38
ON_CW_XSP_METHOD,
IIT_CHR_ATTRIB39
OFF_CW_XSP_METHOD,
IIT_CHR_ATTRIB40
TRAFFIC_LEVEL,
IIT_CHR_ATTRIB41 FOOTWAY_HIER,
RSE_LENGTH_STATUS SEC_LEN_STAT,
 RSE_UNIQUE,
RSE_DESCR,
RSE_LENGTH,
RSE_ROAD_ENVIRONMENT,
RSE_END_DATE,
RSE_ADMIN_UNIT
from inv_items_all,
     road_sections_all
where iit_ity_inv_code='UR'
and iit_ity_sys_flag='E'
and iit_rse_he_id = rse_he_id
and 1 = 2
/