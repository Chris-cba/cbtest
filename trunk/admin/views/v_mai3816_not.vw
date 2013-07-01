CREATE OR REPLACE FORCE VIEW v_mai3816_not AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3816_not.vw-arc   3.1   Jul 01 2013 15:55:30   James.Wadsworth  $
--       Module Name      : $Workfile:   v_mai3816_not.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:22:54  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
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
