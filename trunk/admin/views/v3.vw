CREATE OR REPLACE FORCE VIEW v3(j,k) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v3.vw-arc   3.3   Sep 27 2019 15:36:20   Chris.Baugh  $
--       Module Name      : $Workfile:   v3.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:20  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       rsm_rse_he_id_of j
     , rsm_rse_he_id_in k
from   road_seg_membs
/
