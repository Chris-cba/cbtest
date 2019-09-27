CREATE OR REPLACE FORCE VIEW v_mai7040_sum AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_mai7040_sum.vw-arc   3.3   Sep 27 2019 15:36:20   Chris.Baugh  $
--       Module Name      : $Workfile:   v_mai7040_sum.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:20  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       rse_agency||rse_linkcode v_linkcode
      ,sum(nvl(pbi_end_mp,pbi_begin_mp) - pbi_begin_mp) v_sum_length
      ,sum(pbi_count) v_sum_count
      ,pbi_qry_id v_qry_id
from   road_segments
      ,pbi_results
where  pbi_rse_he_id = rse_he_id
and    pbi_user_name = user
group by rse_agency||rse_linkcode
        ,pbi_qry_id
/
