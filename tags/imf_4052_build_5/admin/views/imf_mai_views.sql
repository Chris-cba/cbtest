-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_views.sql-arc   3.3   Mar 18 2009 15:29:58   drawat  $
--       Module Name      : $Workfile:   imf_mai_views.sql  $
--       Date into PVCS   : $Date:   Mar 18 2009 15:29:58  $
--       Date fetched Out : $Modtime:   Mar 18 2009 15:29:14  $
--       Version          : $Revision:   3.3  $
--       Based on SCCS version : 
-------------------------------------------------------------------------
--
SET echo OFF
SET term OFF
--
COL run_file new_value run_file noprint
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_bill_of_quantities.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_inspections.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_repairs.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_defects.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_defect_repairs.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_work_orders.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_work_order_lines.vw' run_file
FROM dual
/
START '&run_file'
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_budgets.vw' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
-- new views above this
--
-------------------------------------------------------------------------
--

set term on



