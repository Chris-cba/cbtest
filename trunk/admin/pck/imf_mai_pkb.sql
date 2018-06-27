-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/pck/imf_mai_pkb.sql-arc   3.2   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   imf_mai_pkb.sql  $
--       Date into PVCS   : $Date:   Jun 27 2018 13:06:30  $
--       Date fetched Out : $Modtime:   Jun 27 2018 13:05:30  $
--       Version          : $Revision:   3.2  $
--       Based on SCCS version : 
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
SET echo OFF
SET term OFF
--
col run_file new_value run_file noprint
--
SET TERM ON
PROMPT imf_mai_foundation_layer
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'pck'||'&terminator'||'imf_mai_foundation_layer.pkw' run_file
FROM dual
/
START '&run_file'
/
--
---------------------------------------------------------------------------------
--

--
-- New proc above here
--
SET term ON

