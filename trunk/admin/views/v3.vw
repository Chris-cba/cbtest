CREATE OR REPLACE FORCE VIEW v3(j,k) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v3.vw-arc   3.2   Jun 28 2018 04:46:54   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v3.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:54  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:56  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       rsm_rse_he_id_of j
     , rsm_rse_he_id_in k
from   road_seg_membs
/
