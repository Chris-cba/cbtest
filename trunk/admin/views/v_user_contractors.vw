CREATE OR REPLACE FORCE VIEW v_user_contractors
  (oun_org_id)
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_user_contractors.vw-arc   3.3   Jul 01 2013 15:55:32   James.Wadsworth  $
--       Module Name      : $Workfile:   v_user_contractors.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:32  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:25:52  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       cou_oun_org_id oun_org_id
  FROM contractor_users
      ,hig_users
 WHERE hus_username = Sys_Context('NM3_SECURITY_CTX','USERNAME')
   AND hus_user_id = cou_hus_user_id
 UNION
SELECT cor_oun_org_id oun_org_id
  FROM contractor_roles
      ,hig_user_roles
 WHERE hur_username = Sys_Context('NM3_SECURITY_CTX','USERNAME')
   AND hur_role = cor_role
/
