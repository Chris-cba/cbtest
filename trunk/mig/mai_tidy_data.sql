REM Copyright 2013 Bentley Systems Incorporated. All rights reserved.
REM @(#)$Header:   //vm_latest/archives/mai/mig/mai_tidy_data.sql-arc   2.1   Jul 01 2013 16:00:06   James.Wadsworth  $

set echo off
set linesize 120
set heading off
set feedback off
--
---------------------------------------------------------------------------------------------------
--
-- Removing redundant modules roles/modules
--
delete from hig_module_roles
where hmr_module IN ('MAI2312','MAI2130','MAI1060','MAI2150','MAI2350')
/
delete from hig_modules
where hmo_module IN ('MAI2312','MAI2130','MAI1060','MAI2150','MAI2350')
/
commit;
--
---------------------------------------------------------------------------------------------------
--

