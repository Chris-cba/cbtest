REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/install/mai3100_mai3110.sql-arc   2.0   Jun 13 2007 16:32:34   smarshall  $


undefine exor_base
undefine run_file
undefine terminator
col exor_base new_value exor_base noprint
col run_file new_value run_file noprint
col terminator new_value terminator noprint

set verify off head off term on feed off

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

REM
REM Ensure that exor_base is not greater than 30 characters in length
REM
SELECT DECODE(
              SIGN(30-LENGTH('&exor_base'))
                                          ,1,null
                                          ,'exor_base_too_long.sql') run_file
FROM dual
/
SET term OFF
START '&run_file'
SET term ON

prompt
prompt About to upgrade Maintenance Manager by exor to V3.1.1.0 using exor base : &exor_base
prompt
accept ok_res prompt "OK to Continue with this setting ? (Y/N) "
prompt
prompt
select decode(upper('&ok_res'),'Y','&exor_base'||'mai'||'&terminator'||
        'install'||'&terminator'||'mai3100_mai3110_upg','exit') run_file
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
