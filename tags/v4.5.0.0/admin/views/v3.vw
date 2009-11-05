CREATE OR REPLACE FORCE VIEW v3(j,k) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v3.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v3.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 14:38:46  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       rsm_rse_he_id_of j
     , rsm_rse_he_id_in k
from   road_seg_membs
/