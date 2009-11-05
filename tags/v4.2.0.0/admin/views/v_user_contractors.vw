CREATE OR REPLACE FORCE VIEW v_user_contractors
  (oun_org_id)
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_user_contractors.vw-arc   3.0   Nov 05 2009 10:35:02   gjohnson  $
--       Module Name      : $Workfile:   v_user_contractors.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:02  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:13:58  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       cou_oun_org_id oun_org_id
  FROM contractor_users
      ,hig_users
 WHERE hus_username = USER
   AND hus_user_id = cou_hus_user_id
 UNION
SELECT cor_oun_org_id oun_org_id
  FROM contractor_roles
      ,hig_user_roles
 WHERE hur_username = USER
   AND hur_role = cor_role
/