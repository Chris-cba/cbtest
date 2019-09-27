CREATE OR REPLACE FORCE VIEW v_budgets ( v_sys_flag
                                        , v_agency
                                        , v_group
                                        , v_job_code
                                        , v_item_code
                                        , v_fyr_id
                                        , v_budget
                                        , v_committed
                                        , v_actual) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_budgets.vw-arc   3.3   Sep 27 2019 15:36:16   Chris.Baugh  $
--       Module Name      : $Workfile:   v_budgets.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
    bud_sys_flag,
    bud_agency,
    rse_group,
    bud_job_code,
    bud_icb_item_code||bud_icb_sub_item_code||bud_icb_sub_sub_item_code,
    bud_fyr_id,
    decode(bud_value,-1, 0, bud_value) bud_value,  
    nvl(bud_committed,0) bud_committed,  
    nvl(bud_actual,0) bud_actual  
from    budgets, road_groups_all  
where bud_rse_he_id = rse_he_id (+)
/
