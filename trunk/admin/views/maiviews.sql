--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/maiviews.sql-arc   2.15   Jul 01 2013 15:55:26   James.Wadsworth  $
--       Module Name      : $Workfile:   maiviews.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:26  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:17:08  $
--       Version          : $Revision:   2.15  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
SET echo OFF
SET term OFF
--
COL run_file new_value run_file noprint
--
-------------------------------------------------------------------------
--
PROMPT budget_lines
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'budget_lines.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT def_rep_treat
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'def_rep_treat.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT def_rep_treat_wo
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'def_rep_treat_wo.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT gis_work_orders
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'gis_work_orders.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT interface_claims_boq
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'interface_claims_boq.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT interface_claims_wol
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'interface_claims_wol.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT interface_claims_wor
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'interface_claims_wor.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT interface_completions
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'interface_completions.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT inv_on_roads
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'inv_on_roads.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT inv_on_route
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'inv_on_route.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT inv_type_colours
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'inv_type_colours.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT nm3_network_attribs
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'nm3_network_attribs.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT temp_act_report_lines
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'temp_act_report_lines.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT temp_activities_report
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'temp_activities_report.vw' run_file
FROM dual
/
START '&run_file'

--
-------------------------------------------------------------------------
--
PROMPT tma_mai_wol_details_vw
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'tma_mai_wol_details_vw.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT tma_mai_wor_vw
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'tma_mai_wor_vw.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT units
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'units.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v1
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v1.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v2
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v2.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v3
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v3.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v5
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v5.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_all_contractor_users
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_all_contractor_users.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_are_batch_grouping
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_are_batch_grouping.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_budgets
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_budgets.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_budgets2
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_budgets2.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_budgets3
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_budgets3.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_disc_usage
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_disc_usage.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3800_aud
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3800_aud.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3800_boq
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3800_boq.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3800_con
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3800_con.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3806_def
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3806_def.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3806_def2
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3806_def2.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3816_not
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3816_not.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3820_wol
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3820_wol.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3842_wol
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3842_wol.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai7040_det
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai7040_det.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai7040_sum
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai7040_sum.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_process_contractors
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_process_contractors.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_road_construction
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_road_construction.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_ukpms_road_section
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_ukpms_road_section.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_user_contractors
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_user_contractors.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_user_contracts
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_user_contracts.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_wwo
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_wwo.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_wwol
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_wwol.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_work_order_status
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_work_order_status.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai_users
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai_users.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT mai_insp_load_batches_v
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'mai_insp_load_batches_v.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3856_woc
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3856_woc.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
PROMPT v_mai3856_wol
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'v_mai3856_wol.vw' run_file
FROM dual
/
START '&run_file'
--
-- new views above this
--
set term on


