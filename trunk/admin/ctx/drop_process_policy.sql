--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/ctx/drop_process_policy.sql-arc   1.1   Nov 19 2012 15:11:44   Rob.Coupe  $
--       Module Name      : $Workfile:   drop_process_policy.sql  $
--       Date into SCCS   : $Date:   Nov 19 2012 15:11:44  $
--       Date fetched Out : $Modtime:   Nov 19 2012 15:11:30  $
--       SCCS Version     : $Revision:   1.1  $
--
-----------------------------------------------------------------------------
--    Copyright (c) Bentley Systems 2012
-----------------------------------------------------------------------------

declare
  cursor c1 is
     select * from user_policies where package = 'HIG_PROCESS_SECURITY';
begin
  for irec in c1 loop
    dbms_rls.drop_policy(sys_context('NM3CORE', 'APPLICATION_OWNER'), irec.object_name, irec.policy_name );
  end loop;
end;
/


