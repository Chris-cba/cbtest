CREATE OR REPLACE FORCE VIEW v_budgets3 (v_sys_flag
                                       , v_agency
                                       , v_rse_he_id
                                       , v_job_code
                                       , v_job_descr
                                       , v_item_code
                                       , v_work_category
                                       , v_fyr_id
                                       , v_cost_code
                                       , v_budget
                                       , v_committed
                                       , v_actual)  AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_budgets3.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v_budgets3.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 14:46:32  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
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
from    job_sizes,
    item_code_breakdowns,
    budgets
where    bud_job_code = job_code (+)
and    bud_icb_item_code = icb_item_code (+)
and    bud_icb_sub_item_code = icb_sub_item_code (+)
and    bud_icb_sub_sub_item_code = icb_sub_sub_item_code (+)
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