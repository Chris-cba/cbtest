CREATE OR REPLACE FORCE VIEW v_mai3800_aud ( wad_wor_works_order_no
                                           , wad_wol_id
                                           , wad_boq_id
                                           , wad_user
                                           , wad_date
                                           , wad_column_name
                                           , wad_change
                                           , wad_change_from ) 
AS 
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3800_aud.vw-arc   3.1   Jul 01 2013 15:55:30   James.Wadsworth  $
--       Module Name      : $Workfile:   v_mai3800_aud.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:21:28  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       wad_wor_works_order_no 
      ,wad_wol_Id 
      ,wad_boq_id 
      ,wad_user 
      ,wad_date 
      ,wad_column_name 
      ,wad_change 
      ,wad_change_from 
from   wo_audit 
union 
-- payments 
select woc.woc_works_order_no 
      ,cpay.cp_wol_id 
      ,to_number(null) -- no boq id 
      ,con.cnp_username 
      ,cpay.cp_payment_date 
      ,woc.woc_claim_type 
      ,to_char(cpay.cp_payment_value) 
      ,null -- no previous payment amount 
from   work_order_claims woc 
      ,claim_payments    cpay 
      ,contract_payments con 
where  cpay.cp_payment_date is not null 
and    cpay.cp_status     in (select hsc_status_code 
                              from hig_status_codes 
                              where hsc_domain_code = 'CLAIM STATUS' 
                              and   hsc_allow_feature3 = 'Y') 
and    woc.woc_claim_ref  = cpay.cp_woc_claim_ref 
and    woc.woc_con_id     = cpay.cp_woc_con_id 
and    cpay.cp_payment_id = con.cnp_id
/
