-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/exit.sql-arc   2.1   Jul 01 2013 16:00:24   James.Wadsworth  $
--       Module Name      : $Workfile:   exit.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:00:24  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:32  $
--       SCCS Version     : $Revision:   2.1  $
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
