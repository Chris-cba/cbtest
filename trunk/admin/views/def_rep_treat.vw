CREATE OR REPLACE FORCE VIEW def_rep_treat ( def_defect_id
                                           , def_atv_acty_area_code
                                           , are_date_work_done
                                           , def_defect_code
                                           , dty_descr1
                                           , def_status_code
                                           , def_siss_id
                                           , def_works_order_no
                                           , def_priority
                                           , def_ity_inv_code
                                           , def_locn_descr
                                           , def_iit_item_id
                                           , rep_action_cat
                                           , rac
                                           , rep_tre_treat_code
                                           , rep_descr
                                           , rep_date_due
                                           , rse_he_id
                                           , rse_unique
                                           , rse_descr
                                           , are_initiation_type
                                           , ait
                                           , iit_primary_key
                                           , insp_initials
                                           , insp_name) AS 
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/def_rep_treat.vw-arc   3.3   Sep 27 2019 15:35:56   Chris.Baugh  $
--       Module Name      : $Workfile:   def_rep_treat.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:35:56  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       def_defect_id
     , def_atv_acty_area_code
     , are_date_work_done
     , def_defect_code
     , dty_descr1
     , def_status_code
     , def_siss_id
     , def_works_order_no
     , def_priority
     , def_ity_inv_code
     , def_locn_descr
     , def_iit_item_id
     , rep_action_cat
     , hco1.hco_meaning rac
     , rep_tre_treat_code
     , rep_descr
     , rep_date_due
     , rse_he_id
     , rse_unique
     , rse_descr
     , are_initiation_type
     , hco2.hco_meaning ait
     , iit_primary_key
     , hus_initials
     , hus_name
from   defects, repairs, road_segs, inv_items_all, def_types,
       hig_codes hco1, hig_codes hco2, activities_report, hig_users
where  def_defect_id = rep_def_defect_id
  and  def_are_report_id = are_report_id
  and  def_rse_he_id = rse_he_id
  and  def_iit_item_id = iit_item_id(+)
  and  def_atv_acty_area_code = dty_atv_acty_area_code
  and  def_defect_code = dty_defect_code
  and  def_ity_sys_flag = dty_dtp_flag
  and  hco1.hco_domain = 'REPAIR_TYPE'
  and  hco1.hco_code = rep_action_cat
  and  hco2.hco_domain = 'INITIATION_TYPE'
  and  hco2.hco_code = are_initiation_type
  and  are_peo_person_id_actioned = hus_user_id
  and  def_date_compl is null
/
