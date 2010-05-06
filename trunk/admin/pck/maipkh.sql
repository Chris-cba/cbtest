-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/maipkh.sql-arc   2.3   May 06 2010 14:37:34   cbaugh  $
--       Module Name      : $Workfile:   maipkh.sql  $
--       Date into SCCS   : $Date:   May 06 2010 14:37:34  $
--       Date fetched Out : $Modtime:   May 06 2010 14:36:42  $
--       SCCS Version     : $Revision:   2.3  $
--       based on SCCS Version     : 1.10
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maipck.sql	1.22 11/27/02'
-----------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
-- Copyright (c) 2003 exor corporation.
--
-- This script creates all package headers for the Maintenance Manager product.
-- It should be executed during upgrades and new installations.
--
-----------------------------------------------------------------------------
-- Drop and recreate temporary tables used by split/merge/repl/recal/close.
-- These tables are created with a single dummy column by mai.tab.
-- They are recreated here with a full set of columns, so that the
-- corresponding packages are able to compile.
-----------------------------------------------------------------------------

col run_file new_value run_file noprint

-----------------------------------------------------------------------------
-- Mai package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mai.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiReports package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mai_reports.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiGIS package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maigis.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiPBI package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maipbi.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiSplit package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maisplit.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiMerge package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maimerge.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiRepl package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mairepl.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiRecal package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mairecal.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiClose package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maiclose.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- PMSLayer package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'pmslayer.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- WWO package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'works_func.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- IntUtil package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'int_utility.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- InvCopy package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'inv_copy.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiWO package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maiwo.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- Interfaces package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'interfaces.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- PInterface package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'pinterface.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiFinM package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maifinm.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- Inv package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'inv.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- Mai3863 package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai3863.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiBudgets package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai_budgets.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- Mai2325 package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai2325.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiAudit package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai_audit.pkh' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_load.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_util.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_validate.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_act.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_are.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_arl.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_boq.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_def.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dpr.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dty.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_glb.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_std.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_tre.pkh' run_file
FROM dual
/
--
START '&run_file'
-- nm3units wrapper package
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'higunit.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai2110c.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'wo_budget_check.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_sdo_util.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai3942.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_wo_automation.pkh' run_file
FROM dual
/
--
START '&run_file'
--
-----------------------------------------------------------------------------
-- mai_inspection_loader package
-----------------------------------------------------------------------------
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_inspection_loader.pkh' run_file
FROM dual
/
--
START '&run_file'
-----------------------------------------------------------------------------
-- mai_inspection_api package
-----------------------------------------------------------------------------
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_inspection_api.pkh' run_file
FROM dual
/
--
START '&run_file'

