-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/pck/imf_mai_pkh.sql-arc   3.1   Jul 01 2013 16:32:44   James.Wadsworth  $
--       Module Name      : $Workfile:   imf_mai_pkh.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:32:44  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:31:56  $
--       Version          : $Revision:   3.1  $
--       Based on SCCS version : 
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'pck'||'&terminator'||'imf_mai_foundation_layer.pkh' run_file
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

