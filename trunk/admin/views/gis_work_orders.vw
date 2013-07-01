CREATE OR REPLACE FORCE VIEW gis_work_orders
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
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/gis_work_orders.vw-arc   3.1   Jul 01 2013 15:55:04   James.Wadsworth  $
--       Module Name      : $Workfile:   gis_work_orders.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:04  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:08:46  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 wol_id,
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
from work_order_lines
   , road_Sections_all
   , defects
   , work_orders
where wol_rse_he_id=rse_he_id
and wol_def_defect_id=def_defect_id(+)
and wol_works_order_no=wor_works_order_no
/
