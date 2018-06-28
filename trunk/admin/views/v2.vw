CREATE OR REPLACE FORCE VIEW v2 (g,h,i) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v2.vw-arc   3.2   Jun 28 2018 04:46:54   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v2.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:54  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:56  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       vfm_insp_acty_area_code  g
     , vfm_defect_code          h
     , vfm_maint_acty_area_code i
from   valid_for_maintenance
/
