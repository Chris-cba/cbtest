-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/exit.sql-arc   2.3   Sep 27 2019 15:56:16   Chris.Baugh  $
--       Module Name      : $Workfile:   exit.sql  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:56:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:38:12  $
--       SCCS Version     : $Revision:   2.3  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
