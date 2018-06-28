CREATE OR REPLACE FORCE VIEW v5(a1,a2,a3,a4) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v5.vw-arc   3.2   Jun 28 2018 04:46:54   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v5.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:54  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:56  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       def_defect_id A1,
       def_date_compl A2,
       def_rse_he_id A3,
       def_superseded_id A4
from defects
/
