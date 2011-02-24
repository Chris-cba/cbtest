CREATE OR REPLACE FORCE VIEW v_mai_users
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai_users.vw-arc   3.0   Feb 24 2011 18:08:44   Mike.Huitson  $
--       Module Name      : $Workfile:   v_mai_users.vw  $
--       Date into PVCS   : $Date:   Feb 24 2011 18:08:44  $
--       Date fetched Out : $Modtime:   Feb 16 2011 12:19:48  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
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