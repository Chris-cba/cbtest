-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/inv_term.sql-arc   2.0   Jun 13 2007 16:32:32   smarshall  $
--       Module Name      : $Workfile:   inv_term.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:32  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
undefine leave_it
col leave_it new_value leave_it noprint
set term on
prompt
prompt &exor_base was specified as the exor base location.
prompt
prompt Value entered for exor base does not end with a recognised directory
prompt terminator. 
prompt
prompt Please re-run the installation script and enter a valid exor base value.
prompt
prompt
prompt
accept leave_it prompt "Press RETURN to exit SQL*PLUS"
prompt
exit;
