-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_refresh.sql-arc   2.3   Sep 27 2019 15:56:18   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_refresh.sql  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:56:18  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:49:56  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
prompt About to refresh the Maintinence Manager Module of Highways by exor using exor base : &exor_base
prompt
accept ok_res prompt "OK to Continue with this setting ? (Y/N) "

select decode(upper('&ok_res'),'Y','&exor_base'||'mai'||'&terminator'||
        'install'||'&terminator'||'mai_refr','exit') run_file
from dual
/

start '&run_file'

prompt
prompt The Highways install scripts could not be found in the directory
prompt specified for exor base (&exor_base). 
prompt
prompt Please re-run the installation script and enter the correct directory name.
prompt
accept leave_it prompt "Press RETURN to exit from SQL*PLUS"
exit;
