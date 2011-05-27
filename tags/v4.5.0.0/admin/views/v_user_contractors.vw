CREATE OR REPLACE FORCE VIEW v_user_contractors
  (oun_org_id)
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_user_contractors.vw-arc   3.2   May 27 2011 09:45:44   Steve.Cooper  $
--       Module Name      : $Workfile:   v_user_contractors.vw  $
--       Date into PVCS   : $Date:   May 27 2011 09:45:44  $
--       Date fetched Out : $Modtime:   May 25 2011 15:06:32  $
--       Version          : $Revision:   3.2  $
-------------------------------------------------------------------------
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