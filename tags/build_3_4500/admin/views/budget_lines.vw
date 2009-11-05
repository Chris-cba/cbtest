CREATE OR REPLACE FORCE VIEW budget_lines
(
  works_order_no
 ,job_number
 ,work_description
 ,line_reference
 ,estimated_cost
 ,actual_cost
 ,status
 ,date_instructed
 ,date_completed
 ,financial_year
 ,budget_value
 ,budget_external_cost_code
 ,budget_work_category     )
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/budget_lines.vw-arc   3.0   Nov 05 2009 10:35:02   gjohnson  $
--       Module Name      : $Workfile:   budget_lines.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:02  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:05:02  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
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