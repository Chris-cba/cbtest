CREATE OR REPLACE FORCE VIEW v_user_contractors
  (oun_org_id)
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_user_contractors.vw-arc   3.1   Apr 22 2010 17:11:44   mhuitson  $
--       Module Name      : $Workfile:   v_user_contractors.vw  $
--       Date into PVCS   : $Date:   Apr 22 2010 17:11:44  $
--       Date fetched Out : $Modtime:   Apr 22 2010 17:07:48  $
--       Version          : $Revision:   3.1  $
-------------------------------------------------------------------------
--
       cou_oun_org_id oun_org_id
  FROM contractor_users
      ,hig_users
 WHERE hus_username = nm3user.get_username(nm3context.get_context(nm3context.get_namespace,'USER_ID'))
   AND hus_user_id = cou_hus_user_id
 UNION
SELECT cor_oun_org_id oun_org_id
  FROM contractor_roles
      ,hig_user_roles
 WHERE hur_username = nm3user.get_username(nm3context.get_context(nm3context.get_namespace,'USER_ID'))
   AND hur_role = cor_role
/