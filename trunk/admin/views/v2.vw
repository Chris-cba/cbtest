CREATE OR REPLACE FORCE VIEW v2 (g,h,i) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v2.vw-arc   3.1   Jul 01 2013 15:55:50   James.Wadsworth  $
--       Module Name      : $Workfile:   v2.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:27:20  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       vfm_insp_acty_area_code  g
     , vfm_defect_code          h
     , vfm_maint_acty_area_code i
from   valid_for_maintenance
/
