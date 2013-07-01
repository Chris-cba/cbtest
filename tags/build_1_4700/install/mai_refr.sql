-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_refr.sql-arc   2.1   Jul 01 2013 16:02:10   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_refr.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:10  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------

spool refresh_mai

set define on
set feedback off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maiviews' run_file
from dual
/
start '&&run_file'

set feedback off

set define on
set feedback off
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maipck' run_file
from dual
/
start '&&run_file'

set feedback off
set echo off

set define on
set feedback off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maitrgcre' run_file
from dual
/
start '&&run_file'

set feedback off

set define on
set feedback off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mairoles' run_file
from dual
/
set echo off feed on
start '&&run_file'

spool off
exit;
