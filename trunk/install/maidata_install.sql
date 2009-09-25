REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/install/maidata_install.sql-arc   2.1   Sep 25 2009 10:48:14   malexander  $

set echo off
set linesize 120
set heading off
set feedback off

DECLARE
  l_temp nm3type.max_varchar2;
BEGIN
  -- Dummy call to HIG to instantiate it
  l_temp := hig.get_version;
  l_temp := nm_debug.get_version;
EXCEPTION
  WHEN others
   THEN
     Null;
END;
/
--
--
----------------------------------------------------------------------------
--Call a proc in nm_debug to instantiate it before calling metadata scripts.
--
--If this is not done any inserts into hig_option_values may fail due to
-- mutating trigger when nm_debug checks DEBUGAUTON.
----------------------------------------------------------------------------
BEGIN
  nm_debug.debug_off;
END;
/
--
--
---------------------------------------------------------------
--Strip out application metadata
-- Some application metadata was previously installed with Core
-- Metadata will be installed correctly with data files
---------------------------------------------------------------
--
SET TERM ON
Prompt removing application metadata ...
SET TERM OFF
SET DEFINE ON
select 'delete  from hig_standard_favourites where (substr(hstf_parent,1,3) '||
        'like ''MAI%'' OR hstf_child = ''MAI'')' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
Commit;
/
--
--
SET TERM ON
Prompt Running maidata1...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata1' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Running maidata2...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata2' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Running maidata3...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata3' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Running maidata4...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata4' run_file
from dual
/
SET FEEDBACK ON
start &&run_file &p_admin_type
SET FEEDBACK OFF
--
--
SET TERM ON
Prompt Running maidata5...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata5' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
SET TERM ON
Prompt Re-Running maidata2...
SET TERM OFF
SET DEFINE ON
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata2' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--

