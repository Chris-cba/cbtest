CREATE OR REPLACE FORCE VIEW v2 (g,h,i) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v2.vw-arc   3.3   Sep 27 2019 15:36:20   Chris.Baugh  $
--       Module Name      : $Workfile:   v2.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:20  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       vfm_insp_acty_area_code  g
     , vfm_defect_code          h
     , vfm_maint_acty_area_code i
from   valid_for_maintenance
/
