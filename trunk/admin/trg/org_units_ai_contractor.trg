CREATE OR REPLACE TRIGGER org_units_ai_contractor 
AFTER INSERT
ON ORG_UNITS 
FOR EACH ROW
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/trg/org_units_ai_contractor.trg-arc   3.2   Jun 28 2018 04:36:42   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   org_units_ai_contractor.trg  $
--       Date into SCCS   : $Date:   Jun 28 2018 04:36:42  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       SCCS Version     : $Revision:   3.2  $
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
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


