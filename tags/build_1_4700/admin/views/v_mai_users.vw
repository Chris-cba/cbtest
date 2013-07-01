CREATE OR REPLACE FORCE VIEW v_mai_users
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai_users.vw-arc   3.1   Jul 01 2013 15:55:30   James.Wadsworth  $
--       Module Name      : $Workfile:   v_mai_users.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:21:00  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       mus_user_id
      ,hus_name
      ,hus_initials
      ,hus_agent_code
      ,hus_job_title
      ,hus_admin_unit
      ,nau_unit_code
      ,nau_name
      ,mus_wor_flag
      ,mus_wor_value_min
      ,mus_wor_value_max
      ,mus_wor_aur_allowed
      ,mus_wor_aur_min
      ,mus_wor_aur_max
      ,mus_wor_aur_daily_max
  FROM nm_admin_units_all
      ,hig_users
      ,mai_users
 WHERE mus_user_id = hus_user_id
   AND hus_admin_unit = nau_admin_unit(+) 
     ;
