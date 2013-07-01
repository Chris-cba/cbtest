-- SCCS ID Keyword, do not remove
define sccsid = '$Revision:   2.1  $';
--
-- Generated for Oracle 8 on Tue Mar 30  13:12:43 2004 by Server Generator 6.0.3.3.0
 

PROMPT Creating View 'V_MAI3816_NOT'
CREATE OR REPLACE FORCE VIEW V_MAI3816_NOT
 AS SELECT oun1.oun_unit_code oun_unit_code_not,
       oun1.oun_name      oun_name_not,
       hau.hau_unit_code  oun_unit_code_admin,
       hau.hau_name       oun_name_admin,
       notices.*
from   org_units       oun1,
       hig_admin_units hau,
       notices
  WHERE not_org_id_notified    = oun1.oun_org_id
and    oun1.oun_org_unit_type = 'NO'
and    not_org_id_admin       = hau.hau_admin_unit(+)
/

PROMPT Creating View 'V_BUDGETS'
CREATE OR REPLACE FORCE VIEW V_BUDGETS
 (V_SYS_FLAG
 ,V_AGENCY
 ,V_GROUP
 ,V_JOB_CODE
 ,V_ITEM_CODE
 ,V_FYR_ID
 ,V_BUDGET
 ,V_COMMITTED
 ,V_ACTUAL)
 AS SELECT bud_sys_flag,
	bud_agency,
	rse_group,
	bud_job_code,
	bud_icb_item_code||bud_icb_sub_item_code||bud_icb_sub_sub_item_code,
	bud_fyr_id,
	decode(bud_value,-1, 0, bud_value) bud_value,  
	nvl(bud_committed,0) bud_committed,  
	nvl(bud_actual,0) bud_actual  
from	budgets, road_groups_all
  WHERE bud_rse_he_id = rse_he_id (+)
/

PROMPT Creating View 'DEF_REP_TREAT_WO'
CREATE OR REPLACE FORCE VIEW DEF_REP_TREAT_WO
 AS SELECT def_defect_id, def_atv_acty_area_code, are_date_work_done,
       def_defect_code, dty_descr1, def_status_code, def_siss_id,
       def_works_order_no, def_priority, def_ity_inv_code,
       def_locn_descr, def_iit_item_id, rep_action_cat,
       hco1.hco_meaning rac, rep_tre_treat_code, rep_date_due,
       rse_he_id, rse_unique, rse_descr, are_initiation_type,
       hco2.hco_meaning ait, iit_primary_key
from   defects, repairs, road_segs, inv_items_all, def_types,
       hig_codes hco1, hig_codes hco2, activities_report
  WHERE def_defect_id = rep_def_defect_id
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

PROMPT Creating View 'V5'
CREATE OR REPLACE FORCE VIEW V5
 AS SELECT def_defect_id A1,
       def_date_compl A2,
       def_rse_he_id A3,
       def_superseded_id A4
from defects
/

PROMPT Creating View 'GIS_WORK_ORDERS'
CREATE OR REPLACE FORCE VIEW GIS_WORK_ORDERS
 (LINE_ID
 ,LINE_DESCRIPTION
 ,ORDER_DESCRIPTION
 ,ORDER_NO
 ,LINE_TYPE
 ,DEFECT_ID
 ,WOL_RSE_HE_ID
 ,START_CHAIN
 ,XSP
 ,STATUS
 ,ESTIMATED_COST
 ,ACTUAL_COST
 ,CREATED_DATE
 ,INSTRUCTED_DATE
 ,CHECK_RESULT
 ,COMPLETE_DATE
 ,PAID_DATE)
 AS SELECT wol_id,
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
  WHERE wol_rse_he_id=rse_he_id
and wol_def_defect_id=def_defect_id(+)
and wol_works_order_no=wor_works_order_no
/

PROMPT Creating View 'INTERFACE_CLAIMS_WOL'
CREATE OR REPLACE FORCE VIEW INTERFACE_CLAIMS_WOL
 AS SELECT *
from   interface_claims_wol_all
  WHERE nvl(icwol_status, 'D') != 'D'
/

PROMPT Creating View 'V_BUDGETS2'
CREATE OR REPLACE FORCE VIEW V_BUDGETS2
 (V_SYS_FLAG
 ,V_AGENCY
 ,V_RSE_HE_ID
 ,V_JOB_CODE
 ,V_ITEM_CODE
 ,V_SUB_ITEM_CODE
 ,V_SUB_SUB_ITEM_CODE
 ,V_FYR_ID
 ,V_BUDGET
 ,V_COMMITTED
 ,V_ACTUAL)
 AS SELECT bud_sys_flag,
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

PROMPT Creating View 'V_WWO'
CREATE OR REPLACE FORCE VIEW V_WWO
 AS SELECT wor_works_order_no    v_works_order_no
      ,boq_sta_item_code     v_item_code
      ,decode(sta_rogue_flag,'N'
,sta_descr,boq_item_name)        v_item_name
      ,sta_unit              v_unit
      ,sum(boq_est_quantity) v_est_quantity_total
      ,sum(boq_est_cost)     v_est_cost_total
      ,sum(boq_act_quantity) v_act_quantity_total
      ,sum(boq_act_cost)     v_act_cost_total
from   standard_items
      ,boq_items
      ,work_order_lines
      ,work_orders
  WHERE boq_sta_item_code = sta_item_code
and    boq_wol_id = wol_id
and    wol_works_order_no = wor_works_order_no
group  by wor_works_order_no
         ,boq_sta_item_code
         ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)
         ,sta_unit
/

PROMPT Creating View 'V_MAI7040_SUM'
CREATE OR REPLACE FORCE VIEW V_MAI7040_SUM
 AS SELECT rse_agency||rse_linkcode v_linkcode
      ,sum(nvl(pbi_end_mp,pbi_begin_mp) - pbi_begin_mp) v_sum_length
      ,sum(pbi_count) v_sum_count
      ,pbi_qry_id v_qry_id
from   road_segments
      ,pbi_results
  WHERE pbi_rse_he_id = rse_he_id
and    pbi_user_name = user
group by rse_agency||rse_linkcode
        ,pbi_qry_id
/

PROMPT Creating View 'INTERFACE_CLAIMS_BOQ'
CREATE OR REPLACE FORCE VIEW INTERFACE_CLAIMS_BOQ
 AS SELECT *
from   interface_claims_boq_all
  WHERE nvl(icboq_status, 'D') != 'D'
/

PROMPT Creating View 'V_BUDGETS3'
CREATE OR REPLACE FORCE VIEW V_BUDGETS3
 (V_SYS_FLAG
 ,V_AGENCY
 ,V_RSE_HE_ID
 ,V_JOB_CODE
 ,V_JOB_DESCR
 ,V_ITEM_CODE
 ,V_WORK_CATEGORY
 ,V_FYR_ID
 ,V_COST_CODE
 ,V_BUDGET
 ,V_COMMITTED
 ,V_ACTUAL)
 AS SELECT bud_sys_flag,
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
  WHERE bud_job_code = job_code (+)
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

PROMPT Creating View 'V_DISC_USAGE'
CREATE OR REPLACE FORCE VIEW V_DISC_USAGE
 (V_CNG_DISC_GROUP
 ,V_OUN_ORG_ID
 ,V_CNR_START_DATE
 ,V_CNR_END_DATE)
 AS SELECT oun_cng_disc_group,
       oun_org_id,
       to_date(null),
       to_date(null)
from org_units
  WHERE oun_cng_disc_group is not null
/

PROMPT Creating View 'V_MAI3806_DEF'
CREATE OR REPLACE FORCE VIEW V_MAI3806_DEF
 AS SELECT are_date_work_done,
       are_batch_id,
       are_initiation_type,
       hus_initials,
       are_maint_insp_flag,
       rse_admin_unit,
       are_st_chain,
       are_end_chain,
       def.*,
       def.rowid def_rowid
from   hig_users hus,
       road_segments_all,
       activities_report,
       defects def
  WHERE are_report_id = def_are_report_id
and    hus.hus_user_id(+) = are_peo_person_id_actioned
and    def_rse_he_id = rse_he_id
/

PROMPT Creating View 'INTERFACE_COMPLETIONS'
CREATE OR REPLACE FORCE VIEW INTERFACE_COMPLETIONS
 AS SELECT *
from   interface_completions_all
  WHERE ic_status is not null
/

PROMPT Creating View 'INV_ON_ROUTE'
CREATE OR REPLACE FORCE VIEW INV_ON_ROUTE
 (IIT_ITEM_ID
 ,IIT_ST_CHAIN
 ,IIT_END_CHAIN
 ,RSE_HE_ID
 ,ITY_INV_CODE
 ,IIT_ST_DATE
 ,IIT_END_DATE
 ,ROUTE_ID
 ,ROUTE_BEGIN_MP
 ,ROUTE_END_MP
 ,BEGIN_MP
 ,END_MP
 ,RSM_START_DATE
 ,RSM_END_DATE)
 AS SELECT o.iit_item_id,
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
  WHERE r.rsm_rse_he_id_of = o.iit_rse_he_id
/

PROMPT Creating View 'V_WWOL'
CREATE OR REPLACE FORCE VIEW V_WWOL
 (V_WORKS_ORDER_NO
 ,V_WOL_ID
 ,V_ITEM_CODE
 ,V_ITEM_NAME
 ,V_UNIT
 ,V_EST_QUANTITY_TOTAL
 ,V_EST_COST_TOTAL
 ,V_ACT_QUANTITY_TOTAL
 ,V_ACT_COST_TOTAL)
 AS SELECT wor_works_order_no    v_works_order_no
 ,wol_id	  			 v_wol_id
 ,boq_sta_item_code     v_item_code
 ,decode(sta_rogue_flag,'N'
,sta_descr,boq_item_name)        v_item_name
 ,sta_unit              v_unit
 ,sum(boq_est_quantity) v_est_quantity_total
 ,sum(boq_est_cost)     v_est_cost_total
 ,sum(boq_act_quantity) v_act_quantity_total
 ,sum(boq_act_cost)     v_act_cost_total
 from   standard_items
 ,boq_items
 ,work_order_lines
 ,work_orders
  WHERE boq_sta_item_code = sta_item_code
 and    boq_wol_id = wol_id
 and    wol_works_order_no = wor_works_order_no
 group  by wor_works_order_no,wol_id
 ,boq_sta_item_code
 ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)
 ,sta_unit
/

PROMPT Creating View 'DEF_REP_TREAT'
CREATE OR REPLACE FORCE VIEW DEF_REP_TREAT
 (DEF_DEFECT_ID
 ,DEF_ATV_ACTY_AREA_CODE
 ,ARE_DATE_WORK_DONE
 ,DEF_DEFECT_CODE
 ,DTY_DESCR1
 ,DEF_STATUS_CODE
 ,DEF_SISS_ID
 ,DEF_WORKS_ORDER_NO
 ,DEF_PRIORITY
 ,DEF_ITY_INV_CODE
 ,DEF_LOCN_DESCR
 ,DEF_IIT_ITEM_ID
 ,REP_ACTION_CAT
 ,RAC
 ,REP_TRE_TREAT_CODE
 ,REP_DESCR
 ,REP_DATE_DUE
 ,RSE_HE_ID
 ,RSE_UNIQUE
 ,RSE_DESCR
 ,ARE_INITIATION_TYPE
 ,AIT
 ,IIT_PRIMARY_KEY
 ,INSP_INITIALS
 ,INSP_NAME)
 AS SELECT def_defect_id, def_atv_acty_area_code, are_date_work_done,
       def_defect_code, dty_descr1, def_status_code, def_siss_id,
       def_works_order_no, def_priority, def_ity_inv_code,
       def_locn_descr, def_iit_item_id, rep_action_cat,
       hco1.hco_meaning rac, rep_tre_treat_code, rep_descr, 
rep_date_due,
       rse_he_id, rse_unique, rse_descr, are_initiation_type,
       hco2.hco_meaning ait, iit_primary_key, hus_initials, hus_name
from   defects, repairs, road_segs, inv_items_all, def_types,
       hig_codes hco1, hig_codes hco2, activities_report, hig_users
  WHERE def_defect_id = rep_def_defect_id
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

PROMPT Creating View 'INTERFACE_CLAIMS_WOR'
CREATE OR REPLACE FORCE VIEW INTERFACE_CLAIMS_WOR
 AS SELECT *
from   interface_claims_wor_all
  WHERE nvl(icwor_status, 'D') != 'D'
/

PROMPT Creating View 'TEMP_ACTIVITIES_REPORT'
CREATE OR REPLACE FORCE VIEW TEMP_ACTIVITIES_REPORT
 AS SELECT are_date_work_done col1
from   activities_report
/

PROMPT Creating View 'V_MAI7040_DET'
CREATE OR REPLACE FORCE VIEW V_MAI7040_DET
 AS SELECT rse_unique v_road_id
      ,rse_descr v_descr
      ,pbi_begin_mp v_st_chain
      ,pbi_end_mp v_end_chain
      ,nvl(pbi_end_mp,pbi_begin_mp) - pbi_begin_mp v_length
      ,pbi_qry_id v_qry_id
from   road_segments
      ,pbi_results
  WHERE pbi_rse_he_id = rse_he_id
and    pbi_user_name = user
/

PROMPT Creating View 'V_MAI3820_WOL'
CREATE OR REPLACE FORCE VIEW V_MAI3820_WOL
 AS SELECT rse_unique,
       rse_descr,
       hus_initials,
       wol.*
from   road_segments_all,
       hig_users,
       work_order_lines wol
  WHERE wol_rse_he_id = rse_he_id
and    wol_check_peo_id = hus_user_id (+)
and    wol_date_complete is not null
/

PROMPT Creating View 'V_MAI3800_AUD'
CREATE OR REPLACE FORCE VIEW V_MAI3800_AUD
 (WAD_WOR_WORKS_ORDER_NO
 ,WAD_WOL_ID
 ,WAD_BOQ_ID
 ,WAD_USER
 ,WAD_DATE
 ,WAD_COLUMN_NAME
 ,WAD_CHANGE
 ,WAD_CHANGE_FROM)
 AS SELECT wad_wor_works_order_no 
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
  WHERE cpay.cp_payment_date is not null 
and    cpay.cp_status     in (select hsc_status_code 
                              from hig_status_codes 
                              where hsc_domain_code = 'CLAIM STATUS' 
                              and   hsc_allow_feature3 = 'Y') 
and    woc.woc_claim_ref  = cpay.cp_woc_claim_ref 
and    woc.woc_con_id     = cpay.cp_woc_con_id 
and    cpay.cp_payment_id = con.cnp_id
/

PROMPT Creating View 'V_MAI3842_WOL'
CREATE OR REPLACE FORCE VIEW V_MAI3842_WOL
 (CON_CODE
 ,WOL_ID
 ,WOL_WORKS_ORDER_NO
 ,WOL_RSE_HE_ID
 ,WOL_DEF_DEFECT_ID
 ,WOL_REP_ACTION_CAT
 ,WOL_CHECK_RESULT
 ,WOL_ACT_COST
 ,WOL_STATUS_CODE
 ,WOL_SCHD_ID
 ,WOL_WORK_SHEET_NO
 ,WOL_FLAG
 ,RSE_UNIQUE
 ,RSE_DESCR)
 AS SELECT con_code
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
from    road_segments_all rsa
       ,contracts con
       ,work_orders wor
       ,work_order_lines wol
  WHERE wol.wol_rse_he_id = rsa.rse_he_id
and    wol.wol_works_order_no = wor.wor_works_order_no
and    wor.wor_con_id = con.con_id
and    wol.wol_date_paid is null
and exists (select hsc_status_code
            from hig_status_codes hsc
            where hsc.hsc_domain_code = 'WORK_ORDER_LINES'
            and (hsc.hsc_allow_feature3 = 'Y'
            or  hsc.hsc_allow_feature2 = 'Y'
            or  hsc.hsc_allow_feature8 = 'Y'
            or (hsc.hsc_allow_feature9 = 'Y' 
and hsc.hsc_allow_feature4 = 'N'))
            and hsc.hsc_status_code = wol.wol_status_code)
/

PROMPT Creating View 'BUDGET_LINES'
CREATE OR REPLACE FORCE VIEW BUDGET_LINES
 (WORKS_ORDER_NO
 ,JOB_NUMBER
 ,WORK_DESCRIPTION
 ,LINE_REFERENCE
 ,ESTIMATED_COST
 ,ACTUAL_COST
 ,STATUS
 ,DATE_INSTRUCTED
 ,DATE_COMPLETED
 ,FINANCIAL_YEAR
 ,BUDGET_VALUE
 ,BUDGET_EXTERNAL_COST_CODE
 ,BUDGET_WORK_CATEGORY)
 AS SELECT wol_works_order_no,
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
  WHERE wol.wol_icb_work_code=
bud.bud_icb_item_code||bud.bud_icb_sub_item_code||
bud.bud_icb_sub_sub_item_code
and   wor.wor_works_order_no=wol.wol_works_order_no
and   bud.bud_fyr_id=fyr.fyr_id
and   wor.wor_date_confirmed between fyr.fyr_start_date 
and fyr.fyr_end_date
and   wol.wol_rse_he_id in (select rsm_rse_he_id_of
                            from road_Seg_membs
                            where wor.wor_date_confirmed between rsm_start_date
                                         and nvl(rsm_end_date,sysdate)
                            connect by prior rsm_rse_he_Id_of=rsm_rse_he_id_in
                            start with rsm_rse_he_id_in=bud.bud_rse_he_id)
/

PROMPT Creating View 'V_MAI3800_CON'
CREATE OR REPLACE FORCE VIEW V_MAI3800_CON
 (TOTAL
 ,NO_PRICED
 ,CON_ID
 ,WOL_WORKS_ORDER_NO
 ,OUN_MINIMUM
 ,OUN_MAXIMUM)
 AS SELECT sum(cni.cni_rate * boq.boq_est_quantity) total
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
  WHERE con.con_id = cni.cni_con_id
and      cni.cni_sta_item_code = boq.boq_sta_item_code
and      con.con_contr_org_id  = oun.oun_org_id
and      wol.wol_id            = boq.boq_wol_id
and      sysdate between nvl(con.con_start_date, sysdate) 
and nvl(con.con_end_date, sysdate)
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

PROMPT Creating View 'V1'
CREATE OR REPLACE FORCE VIEW V1
 (A
 ,B
 ,C
 ,D
 ,E
 ,F)
 AS SELECT def_defect_id, def_date_compl, def_rse_he_id, def_defect_code,
       def_atv_acty_area_code, def_st_chain
from   defects
/

PROMPT Creating View 'V_MAI3800_BOQ'
CREATE OR REPLACE FORCE VIEW V_MAI3800_BOQ
 AS SELECT wor_works_order_no    v_works_order_no
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
  WHERE boq_sta_item_code = sta_item_code
and    boq_wol_id = wol_id
and    wol_works_order_no = wor_works_order_no
group  by wor_works_order_no
         ,boq_sta_item_code
	 ,sta_item_name
         ,sta_unit
/

PROMPT Creating View 'TEMP_ACT_REPORT_LINES'
CREATE OR REPLACE FORCE VIEW TEMP_ACT_REPORT_LINES
 AS SELECT arl_not_seq_flag col1
from   act_report_lines
/

PROMPT Creating View 'V_ROAD_CONSTRUCTION'
CREATE OR REPLACE FORCE VIEW V_ROAD_CONSTRUCTION
 (ST_END_LAYER
 ,HE_ID
 ,ST_CH
 ,END_CH
 ,LAYER)
 AS SELECT DISTINCT IIT_ST_CHAIN||IIT_END_CHAIN||IIT_NO_OF_UNITS ST_END_LAYER
     , IIT_RSE_HE_ID HE_ID
     , IIT_ST_CHAIN ST_CH
     , IIT_END_CHAIN END_CH
     , IIT_NO_OF_UNITS LAYER
 FROM   INV_ITEMS_ALL
  WHERE IIT_ITY_INV_CODE = 'RC'
  AND    IIT_END_DATE IS NULL
/

PROMPT Creating View 'V2'
CREATE OR REPLACE FORCE VIEW V2
 (G
 ,H
 ,I)
 AS SELECT vfm_insp_acty_area_code, vfm_defect_code, vfm_maint_acty_area_code
from   valid_for_maintenance
/

PROMPT Creating View 'INV_ON_ROADS'
CREATE OR REPLACE FORCE VIEW INV_ON_ROADS
 AS SELECT * from road_sections_all, inv_items_all
  WHERE rse_he_id = iit_rse_he_id
/

PROMPT Creating View 'V_UKPMS_ROAD_SECTION'
CREATE OR REPLACE FORCE VIEW V_UKPMS_ROAD_SECTION
 (IIT_CREATED_DATE
 ,IIT_CRE_DATE
 ,IIT_ITEM_ID
 ,IIT_ITY_INV_CODE
 ,IIT_ITY_SYS_FLAG
 ,IIT_LAST_UPDATED_DATE
 ,IIT_RSE_HE_ID
 ,IIT_ST_CHAIN
 ,IIT_X_SECT
 ,IIT_END_CHAIN
 ,IIT_WIDTH
 ,IIT_END_DATE
 ,ROAD_HIER
 ,SPEED_LIMIT
 ,NOMINATED
 ,ROAD_TYPE
 ,NO_OF_LANES
 ,STEP_LEVEL
 ,OFF_CW_TIED_IND
 ,DRAIN_STATUS
 ,VEH_TRAFF_ON_FW
 ,FREQ_OPEN_FW
 ,DIVERSION_QUALITY
 ,SURV_DIRECTION
 ,ON_CW_XSP_METHOD
 ,OFF_CW_XSP_METHOD
 ,TRAFFIC_LEVEL
 ,FOOTWAY_HIER
 ,SEC_LEN_STAT
 ,RSE_UNIQUE
 ,RSE_DESCR
 ,RSE_LENGTH
 ,RSE_ROAD_ENVIRONMENT
 ,RSE_END_DATE
 ,RSE_ADMIN_UNIT)
 AS SELECT /* INDEX (INV_ITEMS_ALL IIT_INDEX_P2) */
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
  WHERE iit_ity_inv_code='UR'
and iit_ity_sys_flag='E'
and iit_rse_he_id = rse_he_id
and 1 = 2
/

PROMPT Creating View 'V3'
CREATE OR REPLACE FORCE VIEW V3
 (J
 ,K)
 AS SELECT rsm_rse_he_id_of, rsm_rse_he_id_in
from   road_seg_membs
/
