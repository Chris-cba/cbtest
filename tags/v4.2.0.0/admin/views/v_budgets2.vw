CREATE OR REPLACE FORCE VIEW v_budgets2 ( v_sys_flag
                                        , v_agency
                                        , v_rse_he_id
                                        , v_job_code
                                        , v_item_code
                                        , v_sub_item_code
                                        , v_sub_sub_item_code
                                        , v_fyr_id
                                        , v_budget
                                        , v_committed
                                        , v_actual)  AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_budgets2.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v_budgets2.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 14:44:34  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
    bud_sys_flag,
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
from    budgets
/