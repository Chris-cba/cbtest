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
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_budgets3.vw-arc   3.2   Jun 28 2018 04:46:52   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v_budgets3.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:52  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
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
