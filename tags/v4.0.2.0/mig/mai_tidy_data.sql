REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/mig/mai_tidy_data.sql-arc   2.0   Jun 13 2007 16:46:24   smarshall  $

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

