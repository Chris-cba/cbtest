-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/pck/imf_mai_pkh.sql-arc   3.0   Mar 13 2009 14:34:24   gjohnson  $
--       Module Name      : $Workfile:   imf_mai_pkh.sql  $
--       Date into PVCS   : $Date:   Mar 13 2009 14:34:24  $
--       Date fetched Out : $Modtime:   Mar 13 2009 14:34:08  $
--       Version          : $Revision:   3.0  $
--       Based on SCCS version : 
-------------------------------------------------------------------------
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

