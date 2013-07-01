CREATE OR REPLACE FORCE VIEW v_mai3800_boq 
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3800_boq.vw-arc   3.1   Jul 01 2013 15:55:30   James.Wadsworth  $
--       Module Name      : $Workfile:   v_mai3800_boq.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:21:44  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
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
