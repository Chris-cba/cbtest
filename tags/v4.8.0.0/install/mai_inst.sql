-- PVCS Identifiers :-
--
-- pvcsid : $Header:   //new_vm_latest/archives/mai/install/mai_inst.sql-arc   2.1   Jun 28 2018 07:41:56   Gaurav.Gaurkar  $
-- Module Name : $Workfile:   mai_inst.sql  $
-- Date into PVCS : $Date:   Jun 28 2018 07:41:56  $
-- Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
-- PVCS Version : $Revision:   2.1  $
-- Based on SCCS version : 
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

-- Check that the user isn't sys or system
WHENEVER SQLERROR EXIT
BEGIN
   --
      IF USER IN ('SYS','SYSTEM')
       THEN
         RAISE_APPLICATION_ERROR(-20000,'You cannot install Maintenance Manager by exor as ' || USER);
      END IF;
END;      
/
WHENEVER SQLERROR CONTINUE

undefine exor_base
undefine run_file
undefine terminator
col exor_base new_value exor_base noprint
col run_file new_value run_file noprint
col terminator new_value terminator noprint

set verify off head off term on feedback off

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
prompt About to install Maintenance Manager using exor base : &exor_base
prompt
accept ok_res prompt "OK to Continue with this setting ? (Y/N) "
prompt
select decode(upper('&ok_res'),'Y','&exor_base'||'mai'||'&terminator'||
        'install'||'&terminator'||'mai_install','exit') run_file
from dual
/

start '&run_file'

prompt
prompt The Maintenance Manager install scripts could not be found in the directory
prompt specified for exor base (&exor_base).
prompt
prompt Please re-run the installation script and enter the correct directory name.
prompt
accept leave_it prompt "Press RETURN to exit from SQL*PLUS"
exit;
