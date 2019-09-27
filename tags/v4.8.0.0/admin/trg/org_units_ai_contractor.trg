CREATE OR REPLACE TRIGGER org_units_ai_contractor 
AFTER INSERT
ON ORG_UNITS 
FOR EACH ROW
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/trg/org_units_ai_contractor.trg-arc   3.3   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   org_units_ai_contractor.trg  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:02  $
--       SCCS Version     : $Revision:   3.3  $
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
DECLARE
  --
BEGIN
  /*
  ||If the new record is a contractor and the contract security
  ||is setup to be user based then insert a row into contract_users
  ||for the current user so that they can query it.
  */
  IF :new.oun_org_unit_type = 'CO'
   AND hig.get_sysopt(p_option_id => 'CONSECMODE') = maisec.c_user
   THEN
      INSERT
        INTO contractor_users
            (cou_oun_org_id, cou_hus_user_id) 
      VALUES(:new.oun_org_id
            ,TO_NUMBER(Sys_Context('NM3CORE','USER_ID')))
           ;
  END IF;
  --
END org_units_ai_contractor;
/


