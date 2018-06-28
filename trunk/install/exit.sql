-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/exit.sql-arc   2.2   Jun 28 2018 07:41:24   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   exit.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 07:41:24  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
--       SCCS Version     : $Revision:   2.2  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
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
