CREATE OR REPLACE FORCE VIEW v5(a1,a2,a3,a4) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v5.vw-arc   3.1   Jul 01 2013 15:55:50   James.Wadsworth  $
--       Module Name      : $Workfile:   v5.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:27:50  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       def_defect_id A1,
       def_date_compl A2,
       def_rse_he_id A3,
       def_superseded_id A4
from defects
/
