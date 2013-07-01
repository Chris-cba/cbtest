CREATE OR REPLACE FORCE VIEW v_mai3856_wol
  ( WOL_ID
  , WOL_WORKS_ORDER_NO
  , WOL_RSE_HE_ID
  , RSE_UNIQUE
  , RSE_DESCR
  , WOL_DEF_DEFECT_ID
  , WOL_SCHD_ID
  , WOL_STATUS_CODE
  , WOL_DATE_COMPLETE
  , WOL_INVOICE_STATUS
  , WOL_ACT_COST
  , WOL_EST_COST
  , WOR_PEO_PERSON_ID
  , WOR_MOD_BY_ID) AS
SELECT
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3856_wol.vw-arc   3.2   Jul 01 2013 15:55:30   James.Wadsworth  $
--       Module Name      : $Workfile:   v_mai3856_wol.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:04:42  $
--       Version          : $Revision:   3.2  $
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
        wol_id
       ,wol_works_order_no
       ,wol_rse_he_id
       ,rse_unique
       ,rse_descr
       ,wol_def_defect_id
       ,wol_schd_id
       ,wol_status_code
       ,wol_date_complete
       ,wol_invoice_status
       ,wol_act_cost
       ,wol_est_cost
       ,wor_peo_person_id
       ,wor_mod_by_id
from road_segments_all rsa
       ,work_orders wor
       ,work_order_lines wol
where  wol.wol_rse_he_id = rsa.rse_he_id
and    wol.wol_works_order_no = wor.wor_works_order_no
and exists (select 1
                   from  claim_payments cp
                 where  cp.cp_wol_id =wol.wol_id)
/
