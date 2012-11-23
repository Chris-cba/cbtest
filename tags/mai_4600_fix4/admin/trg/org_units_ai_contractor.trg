CREATE OR REPLACE TRIGGER org_units_ai_contractor 
AFTER INSERT
ON ORG_UNITS 
FOR EACH ROW
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/trg/org_units_ai_contractor.trg-arc   3.0   Nov 23 2012 17:43:12   Mike.Huitson  $
--       Module Name      : $Workfile:   org_units_ai_contractor.trg  $
--       Date into SCCS   : $Date:   Nov 23 2012 17:43:12  $
--       Date fetched Out : $Modtime:   Nov 23 2012 17:19:22  $
--       SCCS Version     : $Revision:   3.0  $
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2012
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


