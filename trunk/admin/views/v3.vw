CREATE OR REPLACE FORCE VIEW v3(j,k) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v3.vw-arc   3.1   Jul 01 2013 15:55:50   James.Wadsworth  $
--       Module Name      : $Workfile:   v3.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:27:32  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       rsm_rse_he_id_of j
     , rsm_rse_he_id_in k
from   road_seg_membs
/
