CREATE OR REPLACE FORCE VIEW v_user_contracts
  (con_id
  ,con_code
  ,con_name
  ,con_admin_org_id
  ,con_contr_org_id
  ,con_start_date
  ,con_end_date
  ,con_status_code
  ,con_external_ref
  ,con_retention_rate
  ,con_max_retention
  ,con_liquid_damages
  ,con_last_work_sheet_no
  ,con_last_payment_no
  ,con_last_wor_no
  ,con_cost_code
  ,con_spend_ytd
  ,con_spend_to_date
  ,con_damages_to_date
  ,con_remarks
  ,con_retention_to_date
  ,con_year_end_date)
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_user_contracts.vw-arc   3.2   Jun 28 2018 04:46:54   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v_user_contracts.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:54  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       con_id
      ,con_code
      ,con_name
      ,con_admin_org_id
      ,con_contr_org_id
      ,con_start_date
      ,con_end_date
      ,con_status_code
      ,con_external_ref
      ,con_retention_rate
      ,con_max_retention
      ,con_liquid_damages
      ,con_last_work_sheet_no
      ,con_last_payment_no
      ,con_last_wor_no
      ,con_cost_code
      ,con_spend_ytd
      ,con_spend_to_date
      ,con_damages_to_date
      ,con_remarks
      ,con_retention_to_date
      ,con_year_end_date
  FROM contracts
      ,v_user_contractors
 WHERE con_contr_org_id = oun_org_id
/
