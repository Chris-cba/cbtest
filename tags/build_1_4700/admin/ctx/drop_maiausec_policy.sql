--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/ctx/drop_maiausec_policy.sql-arc   1.2   Jul 01 2013 15:47:26   James.Wadsworth  $
--       Module Name      : $Workfile:   drop_maiausec_policy.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 15:47:26  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:57:26  $
--       SCCS Version     : $Revision:   1.2  $
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

declare
  cursor c1 is
     select * from user_policies where package = 'MAIAUSEC';
begin
  for irec in c1 loop
    dbms_rls.drop_policy(sys_context('NM3CORE', 'APPLICATION_OWNER'), irec.object_name, irec.policy_name );
  end loop;
end;
/

