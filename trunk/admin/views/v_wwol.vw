CREATE OR REPLACE FORCE VIEW v_wwol ( v_works_order_no
                                    , v_wol_id
                                    , v_item_code
                                    , v_item_name
                                    , v_unit
                                    , v_est_quantity_total
                                    , v_est_cost_total
                                    , v_act_quantity_total
                                    , v_act_cost_total ) 
AS 
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_wwol.vw-arc   3.3   Sep 27 2019 15:36:20   Chris.Baugh  $
--       Module Name      : $Workfile:   v_wwol.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:20  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
  wor_works_order_no    v_works_order_no
 ,wol_id                   v_wol_id
 ,boq_sta_item_code     v_item_code
 ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)        v_item_name
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
 group  by wor_works_order_no,wol_id
 ,boq_sta_item_code
 ,decode(sta_rogue_flag,'N',sta_descr,boq_item_name)
 ,sta_unit
/
