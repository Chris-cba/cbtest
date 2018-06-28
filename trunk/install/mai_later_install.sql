-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_later_install.sql-arc   2.2   Jun 28 2018 07:41:56   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_later_install.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 07:41:56  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

spool mai_recreate.lst

prompt Running MAI scripts

set define on
set feedback off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'drop_maitab' run_file
from dual
/
start '&run_file'
/

set define on
set feedback off
select '&exor_base'||'cor'||'&terminator'||'install'||
	'&terminator'||'mai.tab' run_file
from dual
/
start '&&run_file'
/

set define on
set feedback off
select '&exor_base'||'cor'||'&terminator'||'install'||
	'&terminator'||'maiviews' run_file
from dual
/
start '&&run_file'
/

spool off
set feedback off
set define on
prompt
prompt Running Compile Invalid Objects ...
set term off
select '&exor_base'||'cor'||'&terminator'||'admin'||
	'&terminator'||'utl'||'&terminator'||'compile_invalid_objs' run_file
from dual
/
start '&&run_file'

exit;

