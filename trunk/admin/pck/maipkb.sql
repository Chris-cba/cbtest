-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maipkb.sql-arc   2.8   Feb 24 2011 18:00:46   Mike.Huitson  $
--       Module Name      : $Workfile:   maipkb.sql  $
--       Date into SCCS   : $Date:   Feb 24 2011 18:00:46  $
--       Date fetched Out : $Modtime:   Feb 24 2011 18:00:00  $
--       SCCS Version     : $Revision:   2.8  $
--       Based on SCCS Version     : 1.7
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
-- Copyright (c) 2003 exor corporation.
--
-- This script creates all package wrapped bodies for the Maintenance Manager product.
-- It should be executed during upgrades and new installations.
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Mai package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mai.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiReports package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mai_reports.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiGIS package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maigis.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiPBI package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maipbi.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiSplit package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maisplit.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiMerge package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maimerge.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiRepl package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mairepl.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiRecal package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'mairecal.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiClose package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maiclose.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- PMSLayer package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'pmslayer.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- WWO package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'works_func.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- IntUtil package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'int_utility.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- InvCopy package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'inv_copy.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiWO package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
         '&terminator'||'pck'||'&terminator'||'maiwo.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- Interfaces package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'interfaces.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- PInterface package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'pinterface.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiFinM package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maifinm.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- Inv package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'inv.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- pedif package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'pedif.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiBudgets package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai_budgets.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- Mai2325 package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai2325.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
-- MaiAudit package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai_audit.pkw' run_file
from dual
/
start '&run_file'
-----------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_load.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_util.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_validate.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_act.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_are.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_arl.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_boq.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_def.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dpr.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dty.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_glb.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_std.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_tre.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'higunit.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai2110c.pkw' run_file
FROM dual
/
--
START '&run_file'
--
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'wo_budget_check.pkw' run_file
FROM dual
/
--
START '&run_file'
--
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_sdo_util.pkw' run_file
FROM dual
/
--
START '&run_file'
--
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai3942.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_wo_automation.pkw' run_file
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
'&terminator'||'pck'||'&terminator'||'mai_inspection_loader.pkw' run_file
FROM dual
/
--
START '&run_file'

-----------------------------------------------------------------------------
-- mai_inspection_api package
-----------------------------------------------------------------------------
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_inspection_api.pkw' run_file
FROM dual
/
--
START '&run_file'
--
-----------------------------------------------------------------------------
-- mai_wo_api package
-----------------------------------------------------------------------------
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_wo_api.pkw' run_file
FROM dual
/
--
START '&run_file'
-----------------------------------------------------------------------------
-- mai_cim_automation package
-----------------------------------------------------------------------------
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_cim_automation.pkw' run_file
FROM dual
/
-----------------------------------------------------------------------------
-- mai_users package
-----------------------------------------------------------------------------
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_users.pkw' run_file
FROM dual
/
--
START '&run_file'

