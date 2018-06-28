CREATE OR REPLACE FORCE VIEW v_mai7040_det AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_mai7040_det.vw-arc   3.2   Jun 28 2018 04:46:54   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v_mai7040_det.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:54  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       rse_unique v_road_id
      ,rse_descr v_descr
      ,pbi_begin_mp v_st_chain
      ,pbi_end_mp v_end_chain
      ,nvl(pbi_end_mp,pbi_begin_mp) - pbi_begin_mp v_length
      ,pbi_qry_id v_qry_id
from   road_segments
      ,pbi_results
where  pbi_rse_he_id = rse_he_id
and    pbi_user_name = user
/
