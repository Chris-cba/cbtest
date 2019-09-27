-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/inv_term.sql-arc   2.3   Sep 27 2019 15:56:16   Chris.Baugh  $
--       Module Name      : $Workfile:   inv_term.sql  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:56:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:41:02  $
--       SCCS Version     : $Revision:   2.3  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
