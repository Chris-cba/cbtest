CREATE OR REPLACE FORCE VIEW v_mai3856_woc
  ( WOC_CLAIM_REF
  , WOC_INTERIM_NO
  , WOC_WORKS_ORDER_NO
  , WOC_CON_ID
  , WOC_CLAIM_TYPE
  , WOC_CLAIM_DATE
  , WOC_CLAIM_VALUE
  , CON_CODE
  , ORIGINATOR
) AS
SELECT
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_mai3856_woc.vw-arc   3.3   Sep 27 2019 15:36:18   Chris.Baugh  $
--       Module Name      : $Workfile:   v_mai3856_woc.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:18  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
        woc_claim_ref
       ,woc_interim_no
	 ,woc_works_order_no
       ,woc_con_id
       ,woc_claim_type
       ,woc_claim_date
       ,woc_claim_value
       ,con_code
       ,hus_name
 from hig_users hus
     ,contracts con
     ,work_orders wor
     ,work_order_claims woc
where hus.hus_user_id(+) = wor.wor_peo_person_id
  and con.con_id = woc.woc_con_id 
  and wor.wor_works_order_no = woc.woc_works_order_no
/
