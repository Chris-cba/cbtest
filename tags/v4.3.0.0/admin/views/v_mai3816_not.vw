CREATE OR REPLACE FORCE VIEW v_mai3816_not AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3816_not.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v_mai3816_not.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:37:42  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       oun1.oun_unit_code oun_unit_code_not,
       oun1.oun_name      oun_name_not,
       hau.hau_unit_code  oun_unit_code_admin,
       hau.hau_name       oun_name_admin,
       notices.*
from   org_units       oun1,
       hig_admin_units hau,
       notices
where  not_org_id_notified    = oun1.oun_org_id
and    oun1.oun_org_unit_type = 'NO'
and    not_org_id_admin       = hau.hau_admin_unit(+)
/