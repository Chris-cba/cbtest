-----------------------------------------------------------------------------
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/maipkw.sql-arc   2.1   Jul 01 2013 16:03:40   James.Wadsworth  $
--       Module Name      : $Workfile:   maipkw.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:03:40  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       SCCS Version     : $Revision:   2.1  $
--       based on SCCS Version     : 1.3
--
-----------------------------------------------------------------------------
-- Originally taken from '@(#)maipck.sql	1.22 11/27/02'
-----------------------------------------------------------------------------
-- Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
-- Mai3863 package
-----------------------------------------------------------------------------
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'mai3863.pkw' run_file
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
