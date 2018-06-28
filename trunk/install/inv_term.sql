-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/inv_term.sql-arc   2.2   Jun 28 2018 07:41:26   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   inv_term.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 07:41:26  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
--       SCCS Version     : $Revision:   2.2  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
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
