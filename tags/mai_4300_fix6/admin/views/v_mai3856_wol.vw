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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3856_wol.vw-arc   3.0   Jul 25 2011 09:17:20   Mike.Alexander  $
--       Module Name      : $Workfile:   v_mai3856_wol.vw  $
--       Date into PVCS   : $Date:   Jul 25 2011 09:17:20  $
--       Date fetched Out : $Modtime:   Jul 25 2011 09:15:14  $
--       Version          : $Revision:   3.0  $
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2011
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
from  claim_payments cp
       ,road_segments_all rsa
       ,work_orders wor
       ,work_order_lines wol
where  wol.wol_rse_he_id = rsa.rse_he_id
and    wol.wol_works_order_no = wor.wor_works_order_no
and    cp.cp_wol_id =wol.wol_id
/