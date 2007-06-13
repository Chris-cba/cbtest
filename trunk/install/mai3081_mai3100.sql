-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3081_mai3100.sql-arc   2.0   Jun 13 2007 16:32:34   smarshall  $
--       Module Name      : $Workfile:   mai3081_mai3100.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:34  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
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
