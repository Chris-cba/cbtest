-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/imf_mai_install.sql-arc   3.2   Jun 28 2018 07:41:26   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   imf_mai_install.sql  $
--       Date into PVCS   : $Date:   Jun 28 2018 07:41:26  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:34  $
--       Version          : $Revision:   3.2  $
--       Based on SCCS version : 
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
SET echo OFF
SET term OFF
--
COL run_file new_value run_file noprint
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT Maintenance Manager
PROMPT ===================
SET TERM OFF
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT Foundation Views...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_views.sql' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT View Constraints...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_views.con' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT Package Headers...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'pck'||'&terminator'||'imf_mai_pkh.sql' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT Package Bodies...
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'pck'||'&terminator'||'imf_mai_pkb.sql' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
