--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/ctx/drop_maiausec_policy.sql-arc   1.3   Sep 27 2019 13:21:02   Chris.Baugh  $
--       Module Name      : $Workfile:   drop_maiausec_policy.sql  $
--       Date into SCCS   : $Date:   Sep 27 2019 13:21:02  $
--       Date fetched Out : $Modtime:   Sep 27 2019 13:18:02  $
--       SCCS Version     : $Revision:   1.3  $
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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

