REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/mig/mai_migration.sql-arc   2.0   Jun 13 2007 16:46:24   smarshall  $

undefine exor_base
undefine run_file
undefine terminator
COL exor_base new_value exor_base noprint
COL run_file new_value run_file noprint
COL terminator new_value terminator noprint

SET verify OFF head OFF term ON feedback OFF

cl scr
prompt
prompt
prompt Please enter the value FOR exor base. This IS the directory UNDER which
prompt the exor software resides (eg c:\exor\ ON a client PC). IF the value
prompt entered IS NOT correct, the process will NOT proceed.
prompt There IS no DEFAULT value FOR this value.
prompt
prompt IMPORTANT: Please ensure that the exor base value IS terminated WITH
prompt the directory seperator FOR your operating SYSTEM
prompt (eg \ IN Windows OR / IN UNIX).
prompt
prompt
prompt It is VITALLY IMPORTANT that you allow this upgrade to finish on it's own
PROMPT  NEVER "kill" the session because it seems to be taking a long time to run
PROMPT
prompt
ACCEPT exor_base prompt "Enter exor base directory now : "

SELECT SUBSTR('&exor_base',(LENGTH('&exor_base'))) terminator
FROM dual
/
SELECT DECODE('&terminator',
              '/',NULL,
              '\',NULL,
              'inv_term') run_file
FROM dual
/

SET term OFF
START '&run_file'
SET term ON


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
prompt About Migrate Maintenance Manager Objects from v2 to v3 using exor base : &exor_base
prompt

prompt
ACCEPT ok_res prompt "OK to Continue with this setting ? (Y/N) "

SELECT DECODE(UPPER('&ok_res'),'Y','&exor_base'||'mai'||'&terminator'||'mig'||'&terminator'||'mai_mig','exit') run_file
FROM dual
/

START '&run_file'

prompt
prompt The Maintenance Manager migration scripts could NOT be FOUND IN the directory
prompt specified FOR exor base (&exor_base).
prompt
prompt Please re-RUN the migration script AND enter the correct directory name.
prompt
ACCEPT leave_it prompt "Press RETURN to exit from SQL*PLUS"
EXIT;
