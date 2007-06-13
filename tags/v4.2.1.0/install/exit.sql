-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/exit.sql-arc   2.0   Jun 13 2007 16:32:32   smarshall  $
--       Module Name      : $Workfile:   exit.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:32  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
undefine leave_it
col leave_it new_value leave_it noprint
prompt
prompt
prompt
prompt Upgrade process aborted at user request.
prompt
prompt
prompt
accept leave_it prompt "Press RETURN to exit SQL*PLUS"
prompt
exit;
