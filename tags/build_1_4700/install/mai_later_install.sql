-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_later_install.sql-arc   2.1   Jul 01 2013 16:02:10   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_later_install.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:10  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
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

