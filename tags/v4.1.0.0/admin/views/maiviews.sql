REM **************************************************************************
REM	This script creates all views for Maintenance Manager.
REM 	Currently it is maintained manually and cannot be generated from CASE.
REM **************************************************************************
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/views/maiviews.sql-arc   2.6   Jul 16 2009 18:33:36   mhuitson  $
--       Module Name      : $Workfile:   maiviews.sql  $
--       Date into SCCS   : $Date:   Jul 16 2009 18:33:36  $
--       Date fetched Out : $Modtime:   Jul 16 2009 18:29:06  $
--       SCCS Version     : $Revision:   2.6  $
--       Based on 
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maiviews.sql	1.37 07/03/02'
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
prompt Creating View TEMP_ACTIVITIES_REPORT

create or replace force view temp_activities_report
as
select are_date_work_done col1
from   activities_report
/
------------------------------------------------------------------------------
prompt Creating View TEMP_ACT_REPORT_LINES

create or replace force view temp_act_report_lines
as
select arl_not_seq_flag col1
from   act_report_lines
/
------------------------------------------------------------------------------
prompt Creating View V1

create or replace force view V1
(a,b,c,d,e,f)
as
select def_defect_id, def_date_compl, def_rse_he_id, def_defect_code,
       def_atv_acty_area_code, def_st_chain
from   defects
/
------------------------------------------------------------------------------
prompt Creating View V2

create or replace force view v2
(g,h,i)
as
select vfm_insp_acty_area_code, vfm_defect_code, vfm_maint_acty_area_code
from   valid_for_maintenance
/
------------------------------------------------------------------------------
prompt Creating View V3

create or replace force view v3
(j,k)
as
select rsm_rse_he_id_of, rsm_rse_he_id_in
from   road_seg_membs
/
------------------------------------------------------------------------------
REM view is used by bpr2730.inp

prompt Creating View V5

create or replace force view v5 as
select def_defect_id A1,
       def_date_compl A2,
       def_rse_he_id A3,
       def_superseded_id A4
from defects
/
------------------------------------------------------------------------------
prompt Creating View V_BUDGETS

create or replace force view V_BUDGETS ( V_SYS_FLAG,
V_AGENCY, V_GROUP, V_JOB_CODE, V_ITEM_CODE,
V_FYR_ID, V_BUDGET, V_COMMITTED, V_ACTUAL
 ) AS
 select   bud_sys_flag,
	bud_agency,
	rse_group,
	bud_job_code,
	bud_icb_item_code||bud_icb_sub_item_code||bud_icb_sub_sub_item_code,
	bud_fyr_id,
	decode(bud_value,-1, 0, bud_value) bud_value,  
	nvl(bud_committed,0) bud_committed,  
	nvl(bud_actual,0) bud_actual  
from	budgets, road_groups_all  
where bud_rse_he_id = rse_he_id (+)
/

------------------------------------------------------------------------------
prompt Creating View V_BUDGETS2

create or replace force view V_BUDGETS2 ( V_SYS_FLAG,
V_AGENCY, V_RSE_HE_ID, V_JOB_CODE, V_ITEM_CODE,
V_SUB_ITEM_CODE, V_SUB_SUB_ITEM_CODE, V_FYR_ID, V_BUDGET,
V_COMMITTED, V_ACTUAL ) AS
select bud_sys_flag,
	null,
	bud_rse_he_id,
	bud_job_code,
	bud_icb_item_code,
	bud_icb_sub_item_code,
	bud_icb_sub_sub_item_code,
	bud_fyr_id,
	decode(bud_value,-1, 0, bud_value) bud_value,  
      nvl(bud_committed,0) bud_committed,
      nvl(bud_actual,0) bud_actual
from	budgets
/

------------------------------------------------------------------------------
prompt Creating View V_BUDGETS3

create or replace force view v_budgets3
       (v_sys_flag,
	v_agency,
	v_rse_he_id,
	v_job_code,
	v_job_descr,
	v_item_code,
	v_work_category,
	v_fyr_id,
	v_cost_code,
	v_budget,
	v_committed,
	v_actual)
as
select
      bud_sys_flag,
	bud_agency,
	bud_rse_he_id,
	bud_job_code,
	job_descr,
	icb_item_code||icb_sub_item_code||icb_sub_sub_item_code,
	icb_work_category_name,
	bud_fyr_id,
	bud_cost_code,
	sum(decode(bud_value,-1, 0, bud_value)),
	sum(nvl(bud_committed,0)),
	sum(nvl(bud_actual,0))
from	job_sizes,
	item_code_breakdowns,
	budgets
where	bud_job_code = job_code (+)
and	bud_icb_item_code = icb_item_code (+)
and	bud_icb_sub_item_code = icb_sub_item_code (+)
and	bud_icb_sub_sub_item_code = icb_sub_sub_item_code (+)
group by bud_sys_flag,
	bud_agency,
	bud_rse_he_id,
	bud_job_code,
	job_descr,
	icb_item_code||icb_sub_item_code||icb_sub_sub_item_code,
	icb_work_category_name,
	bud_fyr_id,
	bud_cost_code
/
------------------------------------------------------------------------------
prompt Creating View V_DISC_USAGE

create or replace force view v_disc_usage
   ( v_cng_disc_group,
     v_oun_org_id,
     v_cnr_start_date,
     v_cnr_end_date )
as
select oun_cng_disc_group,
       oun_org_id,
       to_date(null),
       to_date(null)
from org_units
where oun_cng_disc_group is not null
/
------------------------------------------------------------------------------
prompt Creating View V_MAI3800_BOQ

create or replace force view v_mai3800_boq as
select wor_works_order_no    v_works_order_no
      ,boq_sta_item_code     v_item_code
      ,sta_item_name         v_item_name
      ,sta_unit              v_unit
      ,sum(boq_est_quantity) v_est_quantity_total
      ,sum(boq_est_cost)     v_est_cost_total
      ,sum(boq_act_quantity) v_act_quantity_total
      ,sum(boq_act_cost)     v_act_cost_total
from   standard_items
      ,boq_items
      ,work_order_lines
      ,work_orders
where  boq_sta_item_code = sta_item_code
and    boq_wol_id = wol_id
and    wol_works_order_no = wor_works_order_no
group  by wor_works_order_no
         ,boq_sta_item_code
	 ,sta_item_name
         ,sta_unit
/
------------------------------------------------------------------------------
prompt Creating View V_WWO

create or replace force view v_wwo as
select wor_works_order_no    v_works_order_no
      ,boq_sta_item_code     v_item_code
      ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)        v_item_name
      ,sta_unit              v_unit
      ,sum(boq_est_quantity) v_est_quantity_total
      ,sum(boq_est_cost)     v_est_cost_total
      ,sum(boq_act_quantity) v_act_quantity_total
      ,sum(boq_act_cost)     v_act_cost_total
from   standard_items
      ,boq_items
      ,work_order_lines
      ,work_orders
where  boq_sta_item_code = sta_item_code
and    boq_wol_id = wol_id
and    wol_works_order_no = wor_works_order_no
group  by wor_works_order_no
         ,boq_sta_item_code
         ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)
         ,sta_unit
/
------------------------------------------------------------------------------
prompt Creating View V_MAI3800_CON

create or replace force view V_MAI3800_CON
( TOTAL, NO_PRICED, CON_ID, WOL_WORKS_ORDER_NO, OUN_MINIMUM,
OUN_MAXIMUM ) AS
 select  sum(cni.cni_rate * boq.boq_est_quantity) total
        ,count(*) no_priced
        ,con.con_id
        ,wol.wol_works_order_no
        ,oun.oun_minimum
        ,oun.oun_maximum
from     contract_items cni
        ,work_order_lines wol
        ,boq_items boq
        ,contracts con
        ,org_units oun
where    con.con_id = cni.cni_con_id
and      cni.cni_sta_item_code = boq.boq_sta_item_code
and      con.con_contr_org_id  = oun.oun_org_id
and      wol.wol_id            = boq.boq_wol_id
and      sysdate between nvl(con.con_start_date, sysdate) and nvl(con.con_end_date, sysdate)
and      exists (select 1
                 from  standard_items sta
                 where sta.sta_rogue_flag    = 'N'
                 and   sta.sta_unit != (select hop_value from hig_options where hop_id = 'PERC_ITEM')
                 and   sysdate between nvl(sta.sta_start_date, sysdate) and nvl(sta.sta_end_date, sysdate)
                 and   sta.sta_item_code     = boq.boq_sta_item_code)
and      exists (select 1
                 from  hig_status_codes hsc
                 where hsc.hsc_domain_code    = 'CONTRACTS'
                 and   hsc.hsc_allow_feature2 = 'Y'
                 and   hsc.hsc_status_code    = con.con_status_code)
and      sysdate between nvl(oun.oun_start_date, sysdate) and nvl(oun.oun_end_date, sysdate)
and      exists (select 1
                 from  hig_status_codes hsc
                 where hsc.hsc_domain_code    = 'WORK_ORDER_LINES'
                 and   hsc.hsc_allow_feature1 = 'Y'
                 and   hsc.hsc_status_code    = wol.wol_status_code)
and      (   cni.cni_rse_he_id is null
          or cni.cni_rse_he_id in (select     rsm_rse_he_id_in
                                   from       road_seg_membs
                                   connect by prior rsm_rse_he_id_in = rsm_rse_he_id_of
                                   and        rsm_end_date is null
                                   start with rsm_rse_he_id_of       = wol_rse_he_id
                                   and        rsm_end_date is null)
         )
and      exists( select 1
                 from   hig_admin_groups
                        ,hig_users
                 where  hag_parent_admin_unit = hus_admin_unit
                 and    hus_username = user
                 and    hag_child_admin_unit = con.con_admin_org_id
                 union
                 select 1
                 from   hig_admin_units
                 where  hau_level = 1
                 and    hau_admin_unit = con.con_admin_org_id)
group by con.con_id
        ,wol.wol_works_order_no
        ,oun.oun_minimum
        ,oun.oun_maximum
/
------------------------------------------------------------------------------
prompt Creating View V_MAI3806_DEF

CREATE OR REPLACE FORCE VIEW v_mai3806_def(are_date_work_done
                                          ,are_batch_id
                                          ,are_initiation_type
                                          ,hus_initials
                                          ,are_maint_insp_flag
                                          ,rse_admin_unit
                                          ,are_st_chain
                                          ,are_end_chain
                                          ,def_defect_id
                                          ,def_rse_he_id
                                          ,def_iit_item_id
                                          ,def_st_chain
                                          ,def_are_report_id
                                          ,def_atv_acty_area_code
                                          ,def_siss_id
                                          ,def_works_order_no
                                          ,def_created_date
                                          ,def_defect_code
                                          ,def_last_updated_date
                                          ,def_orig_priority
                                          ,def_priority
                                          ,def_status_code
                                          ,def_superseded_flag
                                          ,def_area
                                          ,def_are_id_not_found
                                          ,def_coord_flag
                                          ,def_date_compl
                                          ,def_date_not_found
                                          ,def_defect_class
                                          ,def_defect_descr
                                          ,def_defect_type_descr
                                          ,def_diagram_no
                                          ,def_height
                                          ,def_ident_code
                                          ,def_ity_inv_code
                                          ,def_ity_sys_flag
                                          ,def_length
                                          ,def_locn_descr
                                          ,def_maint_wo
                                          ,def_mand_adv
                                          ,def_notify_org_id
                                          ,def_number
                                          ,def_per_cent
                                          ,def_per_cent_orig
                                          ,def_per_cent_rem
                                          ,def_rechar_org_id
                                          ,def_serial_no
                                          ,def_skid_coeff
                                          ,def_special_instr
                                          ,def_superseded_id
                                          ,def_time_hrs
                                          ,def_time_mins
                                          ,def_update_inv
                                          ,def_x_sect
                                          ,def_easting
                                          ,def_northing
                                          ,def_response_category
                                          ,def_rowid
                                          ,rep_def_defect_id
                                          ,rep_date_due
                                          ,rep_date_completed
                                          ,rep_descr
                                          ,rep_tre_treat_code) AS
SELECT /*+ FIRST_ROWS_N */
       are_date_work_done
      ,are_batch_id
      ,are_initiation_type
      ,hus_initials
      ,are_maint_insp_flag
      ,ne_admin_unit
      ,are_st_chain
      ,are_end_chain
      ,def.def_defect_id
      ,def.def_rse_he_id
      ,def.def_iit_item_id
      ,def.def_st_chain
      ,def.def_are_report_id
      ,def.def_atv_acty_area_code
      ,def.def_siss_id
      ,def.def_works_order_no
      ,def.def_created_date
      ,def.def_defect_code
      ,def.def_last_updated_date
      ,def.def_orig_priority
      ,def.def_priority
      ,def.def_status_code
      ,def.def_superseded_flag
      ,def.def_area
      ,def.def_are_id_not_found
      ,def.def_coord_flag
      ,def.def_date_compl
      ,def.def_date_not_found
      ,def.def_defect_class
      ,def.def_defect_descr
      ,def.def_defect_type_descr
      ,def.def_diagram_no
      ,def.def_height
      ,def.def_ident_code
      ,def.def_ity_inv_code
      ,def.def_ity_sys_flag
      ,def.def_length
      ,def.def_locn_descr
      ,def.def_maint_wo
      ,def.def_mand_adv
      ,def.def_notify_org_id
      ,def.def_number
      ,def.def_per_cent
      ,def.def_per_cent_orig
      ,def.def_per_cent_rem
      ,def.def_rechar_org_id
      ,def.def_serial_no
      ,def.def_skid_coeff
      ,def.def_special_instr
      ,def.def_superseded_id
      ,def.def_time_hrs
      ,def.def_time_mins
      ,def.def_update_inv
      ,def.def_x_sect
      ,def.def_easting
      ,def.def_northing
      ,def.def_response_category
      ,def.ROWID def_rowid
      ,rep_def_defect_id
      ,rep_date_due
      ,rep_date_completed
      ,rep_descr
      ,rep_tre_treat_code
  FROM hig_users hus
      ,nm_elements
      ,repairs
      ,defects def
      ,activities_report
 WHERE are_report_id = def_are_report_id
   AND are_peo_person_id_actioned = hus.hus_user_id(+)
   AND def_defect_id = rep_def_defect_id
   AND def_rse_he_id = ne_id
/
------------------------------------------------------------------------------
prompt Creating View V_MAI3806_DEF2

CREATE OR REPLACE FORCE VIEW V_MAI3806_DEF2
(WORKS_ORDER_NO, WOL_DATE_CREATED, WOR_EST_COMPLETE, WOL_DATE_COMPLETE, WOL_STATUS_CODE,
 WOL_DATE_PAID, WOL_CNP_ID, WOL_WORK_SHEET_NO, WOL_CHECK_ID, WOL_CHECK_DATE,
 WOR_CON_ID, WOR_DATE_CLOSED, HCO_MEANING, DEF_DEFECT_ID, REP_DESCR,
 REP_TRE_TREAT_CODE, REP_DATE_DUE, REP_DATE_COMPLETED, REP_DEF_DEFECT_ID, REP_SUPERSEDED_FLAG,
 REP_LOCAL_DATE_DUE, REP_OLD_DUE_DATE, REP_CREATED_DATE, REP_LAST_UPDATED_DATE, REP_ACTION_CAT,
 REP_ATV_ACTY_AREA_CODE, REP_COMPLETED_HRS, REP_COMPLETED_MINS, REP_RSE_HE_ID)
AS
SELECT /*+ FIRST_ROWS_N */
       wol.wol_works_order_no
      ,wol.wol_date_created
      ,wor.wor_est_complete
      ,wol.wol_date_complete
      ,wol.wol_status_code
      ,wol.wol_date_paid
      ,wol.wol_cnp_id
      ,wol.wol_work_sheet_no
      ,wol.wol_check_id
      ,wol.wol_check_date
      ,wor.wor_con_id
      ,wor.wor_date_closed
      ,hco.hco_meaning
      ,rep.rep_def_defect_id
      ,rep.rep_descr
      ,rep.rep_tre_treat_code
      ,rep.rep_date_due
      ,rep.rep_date_completed
      ,rep.rep_def_defect_id
      ,rep.rep_superseded_flag
      ,rep.rep_local_date_due
      ,rep.rep_old_due_date
      ,rep.rep_created_date
      ,rep.rep_last_updated_date
      ,rep.rep_action_cat
      ,rep.rep_atv_acty_area_code
      ,rep.rep_completed_hrs
      ,rep.rep_completed_mins
      ,rep.rep_rse_he_id
  FROM repairs rep
      ,hig_codes hco
      ,work_order_lines wol
      ,work_orders wor
 WHERE wor.wor_works_order_no(+) = wol.wol_works_order_no
   AND wol.wol_def_defect_id(+) = rep.rep_def_defect_id
   AND wol.wol_rep_action_cat(+) = rep.rep_action_cat
   AND wol.wol_check_result = hco.hco_code(+)
   AND hco.hco_domain(+) = 'CHECK_RESULT'
 ORDER
    BY wol.wol_id desc
/

------------------------------------------------------------------------------
prompt Creating View V_MAI3816_NOT

create or replace force view v_mai3816_not as
select oun1.oun_unit_code oun_unit_code_not,
       oun1.oun_name      oun_name_not,
       hau.hau_unit_code  oun_unit_code_admin,
       hau.hau_name       oun_name_admin,
       notices.*
from   org_units       oun1,
       hig_admin_units hau,
       notices
where  not_org_id_notified    = oun1.oun_org_id
and    oun1.oun_org_unit_type = 'NO'
and    not_org_id_admin       = hau.hau_admin_unit(+)
/
------------------------------------------------------------------------------
prompt Creating View V_MAI3820_WOL

create or replace force view v_mai3820_wol as
select rse_unique,
       rse_descr,
       hus_initials,
       wol.*
from   road_segments_all,
       hig_users,
       work_order_lines wol
where  wol_rse_he_id = rse_he_id
and    wol_check_peo_id = hus_user_id (+)
and    wol_date_complete is not null
/
------------------------------------------------------------------------------
prompt Creating View V_MAI3842_WOL

create or replace force view V_MAI3842_WOL
( CON_CODE, WOL_ID, WOL_WORKS_ORDER_NO, WOL_RSE_HE_ID, WOL_DEF_DEFECT_ID,
WOL_REP_ACTION_CAT, WOL_CHECK_RESULT, WOL_ACT_COST, WOL_STATUS_CODE,
WOL_SCHD_ID, WOL_WORK_SHEET_NO, WOL_FLAG, RSE_UNIQUE,
RSE_DESCR, WOL_EST_COST, WOR_PEO_PERSON_ID, WOR_REMARKS, WOR_MOD_BY_ID,
WOL_FINAL) AS
select  con_code
       ,wol_id
       ,wol_works_order_no
       ,wol_rse_he_id
       ,wol_def_defect_id
       ,wol_rep_action_cat
       ,wol_check_result
       ,wol_act_cost
       ,wol_status_code
       ,wol_schd_id
       ,wol_work_sheet_no
       ,wol_flag
       ,rse_unique
       ,rse_descr
       ,wol_est_cost
       ,wor_peo_person_id
       ,wor_remarks
       ,wor_mod_by_id
       ,wol_final
from    road_segments_all rsa
       ,contracts con
       ,work_orders wor
       ,work_order_lines wol
where  wol.wol_rse_he_id = rsa.rse_he_id
and    wol.wol_works_order_no = wor.wor_works_order_no
and    wor.wor_con_id = con.con_id
and    wol.wol_date_paid is null
and exists (select hsc_status_code
            from hig_status_codes hsc
            where hsc.hsc_domain_code = 'WORK_ORDER_LINES'
            and (hsc.hsc_allow_feature3 = 'Y'
            or  hsc.hsc_allow_feature2 = 'Y'
            or  hsc.hsc_allow_feature8 = 'Y'
            or (hsc.hsc_allow_feature9 = 'Y' and hsc.hsc_allow_feature4 = 'N'))
            and hsc.hsc_status_code = wol.wol_status_code)
/
------------------------------------------------------------------------------
PROMPT Creating View V_ROAD_CONSTRUCTION

create or replace force view v_road_construction
(
     st_end_layer
    ,he_id
    ,st_ch
    ,end_ch
    ,layer
)
AS SELECT
       DISTINCT IIT_ST_CHAIN||IIT_END_CHAIN||IIT_NO_OF_UNITS ST_END_LAYER
     , IIT_RSE_HE_ID HE_ID
     , IIT_ST_CHAIN ST_CH
     , IIT_END_CHAIN END_CH
     , IIT_NO_OF_UNITS LAYER
 FROM   INV_ITEMS_ALL
  WHERE  IIT_ITY_INV_CODE = 'RC'
  AND    IIT_END_DATE IS NULL
/
----------------------------------------------------------------------------
PROMPT Creating View V_MAI7040_SUM

create or replace force view v_mai7040_sum as
select rse_agency||rse_linkcode v_linkcode
      ,sum(nvl(pbi_end_mp,pbi_begin_mp) - pbi_begin_mp) v_sum_length
      ,sum(pbi_count) v_sum_count
      ,pbi_qry_id v_qry_id
from   road_segments
      ,pbi_results
where  pbi_rse_he_id = rse_he_id
and    pbi_user_name = user
group by rse_agency||rse_linkcode
        ,pbi_qry_id
/
----------------------------------------------------------------------------
PROMPT Creating View V_MAI7040_DET

create or replace force view v_mai7040_det as
select rse_unique v_road_id
      ,rse_descr v_descr
      ,pbi_begin_mp v_st_chain
      ,pbi_end_mp v_end_chain
      ,nvl(pbi_end_mp,pbi_begin_mp) - pbi_begin_mp v_length
      ,pbi_qry_id v_qry_id
from   road_segments
      ,pbi_results
where  pbi_rse_he_id = rse_he_id
and    pbi_user_name = user
/
----------------------------------------------------------------------------

PROMPT Creating View INV_ON_ROADS

create or replace force view inv_on_roads as
select * from road_sections_all, inv_items_all
where rse_he_id = iit_rse_he_id
/
----------------------------------------------------------------------------

prompt creating view INTERFACE_COMPLETIONS

create or replace force view INTERFACE_COMPLETIONS as
select *
from   interface_completions_all
where  ic_status is not null
/
----------------------------------------------------------------------------

prompt creating view INTERFACE_CLAIMS_WOR

create or replace force view INTERFACE_CLAIMS_WOR as
select *
from   interface_claims_wor_all
where  nvl(icwor_status, 'D') != 'D'
/
----------------------------------------------------------------------------

prompt creating view INTERFACE_CLAIMS_WOL

create or replace force view INTERFACE_CLAIMS_WOL as
select *
from   interface_claims_wol_all
where  nvl(icwol_status, 'D') != 'D'
/
----------------------------------------------------------------------------

prompt creating view INTERFACE_CLAIMS_BOQ

create or replace force view INTERFACE_CLAIMS_BOQ as
select *
from   interface_claims_boq_all
where  nvl(icboq_status, 'D') != 'D'
/
----------------------------------------------------------------------------

prompt creating view DEF_REP_TREAT_WO

create or replace force view def_rep_treat_wo as
select def_defect_id, def_atv_acty_area_code, are_date_work_done,
       def_defect_code, dty_descr1, def_status_code, def_siss_id,
       def_works_order_no, def_priority, def_ity_inv_code,
       def_locn_descr, def_iit_item_id, rep_action_cat,
       hco1.hco_meaning rac, rep_tre_treat_code, rep_date_due,
       rse_he_id, rse_unique, rse_descr, are_initiation_type,
       hco2.hco_meaning ait, iit_primary_key
from   defects, repairs, road_segs, inv_items_all, def_types,
       hig_codes hco1, hig_codes hco2, activities_report
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
  and  def_date_compl is null
/
----------------------------------------------------------------------------

prompt creating view DEF_REP_TREAT

create or replace force view DEF_REP_TREAT ( DEF_DEFECT_ID, 
DEF_ATV_ACTY_AREA_CODE, ARE_DATE_WORK_DONE, DEF_DEFECT_CODE, DTY_DESCR1, 
DEF_STATUS_CODE, DEF_SISS_ID, DEF_WORKS_ORDER_NO, DEF_PRIORITY, 
DEF_ITY_INV_CODE, DEF_LOCN_DESCR, DEF_IIT_ITEM_ID, REP_ACTION_CAT, 
RAC, REP_TRE_TREAT_CODE, REP_DESCR, REP_DATE_DUE, 
RSE_HE_ID, RSE_UNIQUE, RSE_DESCR, ARE_INITIATION_TYPE, 
AIT, IIT_PRIMARY_KEY, INSP_INITIALS, INSP_NAME
 ) AS select def_defect_id, def_atv_acty_area_code, are_date_work_done,
       def_defect_code, dty_descr1, def_status_code, def_siss_id,
       def_works_order_no, def_priority, def_ity_inv_code,
       def_locn_descr, def_iit_item_id, rep_action_cat,
       hco1.hco_meaning rac, rep_tre_treat_code, rep_descr, rep_date_due,
       rse_he_id, rse_unique, rse_descr, are_initiation_type,
       hco2.hco_meaning ait, iit_primary_key, hus_initials, hus_name
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

----------------------------------------------------------------------------

Prompt Creating View BUDGET_LINES

create or replace force view budget_lines
(
 WORKS_ORDER_NO    ,
 JOB_NUMBER        ,
 WORK_DESCRIPTION  ,
 LINE_REFERENCE    ,
 ESTIMATED_COST    ,
 ACTUAL_COST       ,
 STATUS            ,
 DATE_INSTRUCTED   ,
 DATE_COMPLETED    ,
 FINANCIAL_YEAR    ,
 BUDGET_VALUE      ,
 BUDGET_EXTERNAL_COST_CODE,
 BUDGET_WORK_CATEGORY     )
as
select
  wol_works_order_no,
  wor_job_number,
  wor_Descr,
  wol_id,
  wol_est_cost +
((wol_est_cost/decode(wor_est_cost,0,1,null,1,wor_est_cost))*nvl(wor_est_balancing_sum,0)),
  wol_act_cost +
((nvl(wol_act_cost,1)/decode(wor_act_cost,0,1,null,1,wor_act_cost))*nvl(wor_act_balancing_sum,0)),
  wol_status_code,
  wor_date_confirmed,
  wol_date_complete,
  bud_fyr_id,
  bud_value,
  bud_cost_code,
  wol_icb_work_code
from work_order_lines wol,
     work_orders wor,
     financial_years  fyr,
     budgets          bud
where wol.wol_icb_work_code=bud.bud_icb_item_code||bud.bud_icb_sub_item_code||
bud.bud_icb_sub_sub_item_code
and   wor.wor_works_order_no=wol.wol_works_order_no
and   bud.bud_fyr_id=fyr.fyr_id
and   wor.wor_date_confirmed between fyr.fyr_start_date and fyr.fyr_end_date
and   wol.wol_rse_he_id in (select rsm_rse_he_id_of
                            from road_Seg_membs
                            where wor.wor_date_confirmed between rsm_start_date
                                  and nvl(rsm_end_date,sysdate)
                            connect by prior rsm_rse_he_Id_of=rsm_rse_he_id_in
                            start with rsm_rse_he_id_in=bud.bud_rse_he_id)
/
----------------------------------------------------------------------------

Prompt Creating View INV_ON_ROUTE

create or replace force view inv_on_route
( iit_item_id, iit_st_chain, iit_end_chain, rse_he_id,
  ity_inv_code, iit_st_date, iit_end_date, route_id, route_begin_mp, route_end_mp,
  begin_mp, end_mp, rsm_start_date, rsm_end_date ) as
select o.iit_item_id,
       o.iit_st_chain,
       o.iit_end_chain,
       o.iit_rse_he_id,
       o.iit_ity_inv_code,
       o.iit_cre_date,
       o.iit_end_date,
       r.rsm_rse_he_id_in,
       r.rsm_route_begin_mp,
       r.rsm_route_end_mp,
       r.rsm_begin_mp,
       r.rsm_end_mp,
       r.rsm_start_date,
       r.rsm_end_date
from inv_items_all o, road_seg_membs_all r
where  r.rsm_rse_he_id_of = o.iit_rse_he_id
/
----------------------------------------------------------------------------

prompt creating view V_MAI3800_AUD

create or replace force view V_MAI3800_AUD ( wad_wor_works_order_no, 
wad_wol_id, wad_boq_id, wad_user, wad_date, 
wad_column_name, wad_change, wad_change_from ) AS select wad_wor_works_order_no 
      ,wad_wol_Id 
      ,wad_boq_id 
      ,wad_user 
      ,wad_date 
      ,wad_column_name 
      ,wad_change 
      ,wad_change_from 
from   wo_audit 
union 
-- payments 
select woc.woc_works_order_no 
      ,cpay.cp_wol_id 
      ,to_number(null) -- no boq id 
      ,con.cnp_username 
      ,cpay.cp_payment_date 
      ,woc.woc_claim_type 
      ,to_char(cpay.cp_payment_value) 
      ,null -- no previous payment amount 
from   work_order_claims woc 
      ,claim_payments    cpay 
      ,contract_payments con 
where  cpay.cp_payment_date is not null 
and    cpay.cp_status     in (select hsc_status_code 
                              from hig_status_codes 
                              where hsc_domain_code = 'CLAIM STATUS' 
                              and   hsc_allow_feature3 = 'Y') 
and    woc.woc_claim_ref  = cpay.cp_woc_claim_ref 
and    woc.woc_con_id     = cpay.cp_woc_con_id 
and    cpay.cp_payment_id = con.cnp_id
/
----------------------------------------------------------------------------
prompt creating view V_WWOL

create or replace force view V_WWOL ( V_WORKS_ORDER_NO,
V_WOL_ID, V_ITEM_CODE, V_ITEM_NAME, V_UNIT,
V_EST_QUANTITY_TOTAL, V_EST_COST_TOTAL, V_ACT_QUANTITY_TOTAL, V_ACT_COST_TOTAL
 ) AS select wor_works_order_no    v_works_order_no
 ,wol_id	  			 v_wol_id
 ,boq_sta_item_code     v_item_code
 ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)        v_item_name
 ,sta_unit              v_unit
 ,sum(boq_est_quantity) v_est_quantity_total
 ,sum(boq_est_cost)     v_est_cost_total
 ,sum(boq_act_quantity) v_act_quantity_total
 ,sum(boq_act_cost)     v_act_cost_total
 from   standard_items
 ,boq_items
 ,work_order_lines
 ,work_orders
 where  boq_sta_item_code = sta_item_code
 and    boq_wol_id = wol_id
 and    wol_works_order_no = wor_works_order_no
 group  by wor_works_order_no,wol_id
 ,boq_sta_item_code
 ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)
 ,sta_unit
/
----------------------------------------------------------------------------
prompt creating view V_UKPMS_ROAD_SECTION

create or replace force view V_UKPMS_ROAD_SECTION  (
  IIT_CREATED_DATE,
  IIT_CRE_DATE,
IIT_ITEM_ID,
IIT_ITY_INV_CODE,
IIT_ITY_SYS_FLAG,
IIT_LAST_UPDATED_DATE,
IIT_RSE_HE_ID,
IIT_ST_CHAIN,
IIT_X_SECT,
IIT_END_CHAIN,
IIT_WIDTH,
IIT_END_DATE,
ROAD_HIER,
SPEED_LIMIT,
NOMINATED,
ROAD_TYPE,
NO_OF_LANES,
STEP_LEVEL,
OFF_CW_TIED_IND,
DRAIN_STATUS,
VEH_TRAFF_ON_FW,
FREQ_OPEN_FW,
DIVERSION_QUALITY,
SURV_DIRECTION,
ON_CW_XSP_METHOD,
OFF_CW_XSP_METHOD,
TRAFFIC_LEVEL,
FOOTWAY_HIER,
SEC_LEN_STAT,
RSE_UNIQUE,
RSE_DESCR,
RSE_LENGTH,
RSE_ROAD_ENVIRONMENT,
RSE_END_DATE,
RSE_ADMIN_UNIT
) AS select /* INDEX (INV_ITEMS_ALL IIT_INDEX_P2) */
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
--

prompt creating view GIS_WORK_ORDERS

create or replace force view gis_work_orders
(line_id,
line_description,
order_description,
order_no,
line_type,
defect_id,
wol_Rse_he_id,
start_chain,
XSP,
status,
estimated_cost,
actual_cost,
created_date,
instructed_date,
check_result,
Complete_date,
paid_date
)
as
select wol_id,
wol_descr,
wor_descr,
wol_works_order_no,
wol_flag,
wol_def_defect_id,
wol_rse_he_id,
decode(wol_flag,'D',def_st_chain,rse_length/2),
decode(wol_flag,'D',def_x_sect,null),
wol_status_code,
wol_est_cost,
wol_act_cost,
wor_date_raised,
wor_date_confirmed,
wol_check_result,
wol_date_complete,
wol_date_paid
from work_order_lines, road_Sections_all, defects, work_orders
where wol_rse_he_id=rse_he_id
and wol_def_defect_id=def_defect_id(+)
and wol_works_order_no=wor_works_order_no
/
prompt creating view INV_TYPE_COLOURS

CREATE OR REPLACE FORCE VIEW inv_type_colours
AS
SELECT
 col_id,
 ity_inv_code
FROM nm_inv_type_colours;

prompt creating view UNITS

CREATE OR REPLACE FORCE VIEW UNITS
(UN_DOMAIN_ID, UN_UNIT_ID, UN_UNIT_NAME, UN_FORMAT_MASK)
AS
SELECT un_domain_id
      ,un_unit_id
      ,un_unit_name
      ,un_format_mask
FROM   nm_units;

prompt creating nm3_network_attribs

CREATE OR REPLACE FORCE VIEW NM3_NETWORK_ATTRIBS(ELEMENT_ID, HIERARCHY, NOMINATED, TOWN, SUB_PARISH, 
 SPARE1, SPARE2, SECTOR, LABEL, SECTION_ID) AS
 select ni.iit_ne_id            element_id
        , ni.iit_chr_attrib35     hierarchy
        , ni.iit_chr_attrib36     nominated
        , ni.iit_chr_attrib27     town
        , mai_gmis_util.get_parish(ni.iit_chr_attrib28)     sub_parish
        , ni.iit_chr_attrib41     spare1
        , ni.iit_chr_attrib42     spare2
        , ni.iit_chr_attrib30     sector
        , ne.ne_unique            label
        , ne.ne_id                section_id
from  nm_elements_all ne
    , nm_group_inv_link_all li
    , nm_inv_items_all ni
where ne.ne_id = li.ngil_ne_ne_id (+)
and   li.ngil_iit_ne_id = ni.iit_ne_id (+)
and   ni.iit_inv_type     ='HERM';
--
-------------------------------------------------------------------------------------------------------------
--
CREATE OR REPLACE FORCE VIEW tma_mai_wol_details_vw
( 
 wol_works_order_no
,wol_id
,def_locn_descr
,rse_unique
,rse_descr
,def_defect_id
,def_defect_code
,def_priority
,def_date_compl
,wol_icb_work_code
)        
AS
SELECT
--
-- View supports MAI to TMA integration and is referenced initially in MAI3900
--  
        wol.wol_works_order_no
       ,wol.wol_id
       ,NVL(def.def_locn_descr,wol.wol_locn_descr) 
       ,rse.rse_unique     
       ,rse.rse_descr
       ,def.def_defect_id
       ,def.def_defect_code
       ,def.def_priority
       ,def.def_date_compl
       ,wol.wol_icb_work_code
FROM    work_order_lines wol
       ,defects def
       ,road_segs rse
WHERE   wol.wol_def_defect_id      = def.def_defect_id(+)               
AND     wol.wol_rse_he_id          = rse.rse_he_id 
AND     Nvl(wol_register_flag,'N') = 'Y'
--AND     wol.wol_status_code        IN (SELECT hsc_status_code
--                                                           FROM   hig_status_codes
--                                                           WHERE  hsc_domain_code = 'WORK_ORDER_LINES'
--                                                           AND    hsc_allow_feature1 = 'Y')
/
comment on table tma_mai_wol_details_vw is 'View supports MAI to TMA integration and is referenced initially in MAI3900'
/
--
-------------------------------------------------------------------------------------------------------------
--
CREATE OR REPLACE FORCE VIEW tma_mai_wor_vw
( 
 mwo_works_order_no
,mwo_descr
,mwo_date_raised
,mwo_flag
)        
AS
SELECT
--
-- View supports MAI to TMA integration and is referenced initially in MAI3900
--
        wor_works_order_no
       ,wor_descr
       ,wor_date_raised
       ,wor_flag
FROM    work_orders    
/

comment on table tma_mai_wor_vw is 'View supports MAI to TMA integration and is referenced initially in MAI3900'
/
--
-------------------------------------------------------------------------------------------------------------
--
CREATE OR REPLACE FORCE VIEW v_are_batch_grouping
(
   max_are_report_id, 
   are_batch_id
)
AS
SELECT
-------------------------------------------------------------------------
-- View displaying activity reports grouped by are_batch_id, 
-- for use with mai2200r module_params
-------------------------------------------------------------------------
   MAX(are_report_id), 
   are_batch_id
FROM activities_report 
GROUP BY are_batch_id
/

----------------------------------------------------------------------------
Prompt Creating View V_ALL_CONTRACTOR_USERS

CREATE OR REPLACE FORCE VIEW v_all_contractor_users
  (oun_org_id
  ,hus_user_id
  ,hus_initials
  ,hus_name
  ,hus_username
  ,via_role)
AS
SELECT cou_oun_org_id oun_org_id
      ,hus_user_id
      ,hus_initials
      ,hus_name
      ,hus_username
      ,'N' via_role
  FROM contractor_users
      ,hig_users
 WHERE hus_user_id = cou_hus_user_id
 UNION
SELECT cor_oun_org_id oun_org_id
      ,hus_user_id
      ,hus_initials
      ,hus_name
      ,hus_username
      ,'Y' via_role
  FROM contractor_roles
      ,hig_user_roles
      ,hig_users
 WHERE hus_username = hur_username
   AND hur_role = cor_role
   AND NOT EXISTS(SELECT 1
                    FROM contractor_users
                   WHERE cou_hus_user_id = hus_user_id)
/

----------------------------------------------------------------------------
Prompt Creating View V_USER_CONTRACTORS

CREATE OR REPLACE FORCE VIEW v_user_contractors
  (oun_org_id)
AS
SELECT cou_oun_org_id oun_org_id
  FROM contractor_users
      ,hig_users
 WHERE hus_username = USER
   AND hus_user_id = cou_hus_user_id
 UNION
SELECT cor_oun_org_id oun_org_id
  FROM contractor_roles
      ,hig_user_roles
 WHERE hur_username = USER
   AND hur_role = cor_role
/

----------------------------------------------------------------------------
Prompt Creating View V_USER_CONTRACTS

CREATE OR REPLACE FORCE VIEW v_user_contracts
  (con_id
  ,con_code
  ,con_name
  ,con_admin_org_id
  ,con_contr_org_id
  ,con_start_date
  ,con_end_date
  ,con_status_code
  ,con_external_ref
  ,con_retention_rate
  ,con_max_retention
  ,con_liquid_damages
  ,con_last_work_sheet_no
  ,con_last_payment_no
  ,con_last_wor_no
  ,con_cost_code
  ,con_spend_ytd
  ,con_spend_to_date
  ,con_damages_to_date
  ,con_remarks
  ,con_retention_to_date
  ,con_year_end_date)
AS
SELECT con_id
      ,con_code
      ,con_name
      ,con_admin_org_id
      ,con_contr_org_id
      ,con_start_date
      ,con_end_date
      ,con_status_code
      ,con_external_ref
      ,con_retention_rate
      ,con_max_retention
      ,con_liquid_damages
      ,con_last_work_sheet_no
      ,con_last_payment_no
      ,con_last_wor_no
      ,con_cost_code
      ,con_spend_ytd
      ,con_spend_to_date
      ,con_damages_to_date
      ,con_remarks
      ,con_retention_to_date
      ,con_year_end_date
  FROM contracts
      ,v_user_contractors
 WHERE con_contr_org_id = oun_org_id
/

--
-------------------------------------------------------------------------------------------------------------
--

REM
REM End of command file
REM
