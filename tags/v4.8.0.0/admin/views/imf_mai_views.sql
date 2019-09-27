-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/imf_mai_views.sql-arc   3.8   Sep 27 2019 15:35:58   Chris.Baugh  $
--       Module Name      : $Workfile:   imf_mai_views.sql  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:35:58  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.8  $
--       Based on SCCS version :
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
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
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_work_orders_all_attrib.vw' run_file
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
-------------------------------------------------------------------------
--
SET TERM ON
PROMPT view_name
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||'&terminator'||'imf_mai_wo_instruct.vw' run_file
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



