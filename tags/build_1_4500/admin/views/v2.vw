CREATE OR REPLACE FORCE VIEW v2 (g,h,i) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v2.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v2.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 14:37:22  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       vfm_insp_acty_area_code  g
     , vfm_defect_code          h
     , vfm_maint_acty_area_code i
from   valid_for_maintenance
/