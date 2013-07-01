CREATE OR REPLACE FORCE VIEW v_mai3800_con ( TOTAL
                                           , NO_PRICED
                                           , CON_ID
                                           , WOL_WORKS_ORDER_NO
                                           , OUN_MINIMUM
                                           , OUN_MAXIMUM ) 
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3800_con.vw-arc   3.1   Jul 01 2013 15:55:30   James.Wadsworth  $
--       Module Name      : $Workfile:   v_mai3800_con.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:22:00  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
         sum(cni.cni_rate * boq.boq_est_quantity) total
        ,count(*) no_priced
        ,con.con_id
        ,wol.wol_works_order_no
        ,oun.oun_minimum
        ,oun.oun_maximum
from     contract_items cni
        ,work_order_lines wol
        ,boq_items boq
        ,contracts con
        ,org_units oun
where    con.con_id = cni.cni_con_id
and      cni.cni_sta_item_code = boq.boq_sta_item_code
and      con.con_contr_org_id  = oun.oun_org_id
and      wol.wol_id            = boq.boq_wol_id
and      sysdate between nvl(con.con_start_date, sysdate) and nvl(con.con_end_date, sysdate)
and      exists (select 1
                 from  standard_items sta
                 where sta.sta_rogue_flag    = 'N'
                 and   sta.sta_unit != (select hop_value from hig_options where hop_id = 'PERC_ITEM')
                 and   sysdate between nvl(sta.sta_start_date, sysdate) and nvl(sta.sta_end_date, sysdate)
                 and   sta.sta_item_code     = boq.boq_sta_item_code)
and      exists (select 1
                 from  hig_status_codes hsc
                 where hsc.hsc_domain_code    = 'CONTRACTS'
                 and   hsc.hsc_allow_feature2 = 'Y'
                 and   hsc.hsc_status_code    = con.con_status_code)
and      sysdate between nvl(oun.oun_start_date, sysdate) and nvl(oun.oun_end_date, sysdate)
and      exists (select 1
                 from  hig_status_codes hsc
                 where hsc.hsc_domain_code    = 'WORK_ORDER_LINES'
                 and   hsc.hsc_allow_feature1 = 'Y'
                 and   hsc.hsc_status_code    = wol.wol_status_code)
and      (   cni.cni_rse_he_id is null
          or cni.cni_rse_he_id in (select     rsm_rse_he_id_in
                                   from       road_seg_membs
                                   connect by prior rsm_rse_he_id_in = rsm_rse_he_id_of
                                   and        rsm_end_date is null
                                   start with rsm_rse_he_id_of       = wol_rse_he_id
                                   and        rsm_end_date is null)
         )
and      exists( select 1
                 from   hig_admin_groups
                        ,hig_users
                 where  hag_parent_admin_unit = hus_admin_unit
                 and    hus_username = user
                 and    hag_child_admin_unit = con.con_admin_org_id
                 union
                 select 1
                 from   hig_admin_units
                 where  hau_level = 1
                 and    hau_admin_unit = con.con_admin_org_id)
group by con.con_id
        ,wol.wol_works_order_no
        ,oun.oun_minimum
        ,oun.oun_maximum
/
