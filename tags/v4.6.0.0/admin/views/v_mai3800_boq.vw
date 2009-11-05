CREATE OR REPLACE FORCE VIEW v_mai3800_boq 
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3800_boq.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v_mai3800_boq.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:33:44  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       wor_works_order_no    v_works_order_no
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