-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_refr.sql-arc   2.2   Jun 28 2018 07:41:58   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_refr.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 07:41:58  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
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
