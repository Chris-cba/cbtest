CREATE OR REPLACE FORCE VIEW v_process_contractors
  (oun_org_id
  ,oun_unit_code
  ,oun_name
  ,oun_contractor_id
  ,oun_electronic_orders_flag
  ,oun_start_date
  ,oun_end_date)
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_process_contractors.vw-arc   3.4   Jun 28 2018 04:46:54   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v_process_contractors.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:54  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.4  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       oun_org_id
      ,oun_unit_code
      ,oun_name
      ,oun_contractor_id
      ,oun_electronic_orders_flag
      ,oun_start_date
      ,oun_end_date
  FROM org_units
 WHERE oun_org_unit_type = 'CO'
   AND oun_org_id IN(SELECT con_contr_org_id
                       FROM contracts
                      WHERE con_code != NVL(hig.get_sysopt('DUMCONCODE'),'@')
                        AND con_admin_org_id IN(SELECT hag_child_admin_unit
                                                  FROM hig_admin_groups
                                                      ,hig_users
                                                 WHERE hus_user_id = To_Number(Sys_Context('NM3CORE','USER_ID'))
                                                   AND hus_admin_unit = hag_parent_admin_unit
                                                 UNION
                                                SELECT hau_admin_unit
                                                  FROM hig_admin_units
                                                 WHERE hau_level = 1
                                                   AND hig.get_sysopt('INCTOPCON') = 'Y'))
/
