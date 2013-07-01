-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3082_mai3100.sql-arc   2.1   Jul 01 2013 16:02:14   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3082_mai3100.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:14  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
undefine exor_base
undefine run_file
undefine terminator
col exor_base new_value exor_base noprint
col run_file new_value run_file noprint
col terminator new_value terminator noprint

set verify off head off term on

cl scr
prompt
prompt
prompt Please enter the value for exor base. This is the directory under which
prompt the exor software resides (eg c:\exor\ on a client PC). If the value
prompt entered is not correct, the process will not proceed.
prompt There is no default value for this value.
prompt
prompt INPORTANT: Please ensure that the exor base value is terminated with
prompt the directory seperator for your operating system
prompt (eg \ in Windows or / in UNIX).
prompt

accept exor_base prompt "Enter exor base directory now : "

select substr('&exor_base',(length('&exor_base'))) terminator
from dual
/
select decode('&terminator',
              '/',null,
              '\',null,
              'inv_term') run_file 
from dual
/

set term off
start '&run_file'
set term on

prompt
prompt About to upgrade Maintenance Manager by exor to V3.1.0.0 using exor base : &exor_base
prompt
accept ok_res prompt "OK to Continue with this setting ? (Y/N) "
prompt
accept p_admin_type prompt "Enter the Admin Type to be used for Inventory Types (eg NETW) : "
prompt
select decode(upper('&ok_res'),'Y','&exor_base'||'mai'||'&terminator'||
        'install'||'&terminator'||'mai3010_mai3100_upg','exit') run_file
from dual
/
start '&run_file'

prompt
prompt The Highways upgrade scripts could not be found in the directory
prompt specified for exor base (&exor_base). 
prompt
prompt Please re-run the upgrade script and enter the correct directory name.
prompt
accept leave_it prompt "Press RETURN to exit from SQL*PLUS"
exit;
