CREATE OR REPLACE FORCE VIEW v_mai3842_wol( CON_CODE
                                          , WOL_ID
                                          , WOL_WORKS_ORDER_NO
                                          , WOL_RSE_HE_ID
                                          , WOL_DEF_DEFECT_ID
                                          , WOL_REP_ACTION_CAT
                                          , WOL_CHECK_RESULT
                                          , WOL_ACT_COST
                                          , WOL_STATUS_CODE
                                          , WOL_SCHD_ID
                                          , WOL_WORK_SHEET_NO
                                          , WOL_FLAG
                                          , RSE_UNIQUE
                                          , RSE_DESCR
                                          , WOL_EST_COST
                                          , WOR_PEO_PERSON_ID
                                          , WOR_REMARKS
                                          , WOR_MOD_BY_ID
                                          , WOL_FINAL) AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_mai3842_wol.vw-arc   3.2   Jun 28 2018 04:46:54   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v_mai3842_wol.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:54  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
        con_code
       ,wol_id
       ,wol_works_order_no
       ,wol_rse_he_id
       ,wol_def_defect_id
       ,wol_rep_action_cat
       ,wol_check_result
       ,wol_act_cost
       ,wol_status_code
       ,wol_schd_id
       ,wol_work_sheet_no
       ,wol_flag
       ,rse_unique
       ,rse_descr
       ,wol_est_cost
       ,wor_peo_person_id
       ,wor_remarks
       ,wor_mod_by_id
       ,wol_final
from    road_segments_all rsa
       ,contracts con
       ,work_orders wor
       ,work_order_lines wol
where  wol.wol_rse_he_id = rsa.rse_he_id
and    wol.wol_works_order_no = wor.wor_works_order_no
and    wor.wor_con_id = con.con_id
and    wol.wol_date_paid is null
and exists (select hsc_status_code
            from hig_status_codes hsc
            where hsc.hsc_domain_code = 'WORK_ORDER_LINES'
            and (hsc.hsc_allow_feature3 = 'Y'
            or  hsc.hsc_allow_feature2 = 'Y'
            or  hsc.hsc_allow_feature8 = 'Y'
            or (hsc.hsc_allow_feature9 = 'Y' and hsc.hsc_allow_feature4 = 'N'))
            and hsc.hsc_status_code = wol.wol_status_code)
/
