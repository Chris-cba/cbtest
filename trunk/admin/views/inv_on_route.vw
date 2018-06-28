CREATE OR REPLACE FORCE VIEW inv_on_route
( iit_item_id
, iit_st_chain
, iit_end_chain
, rse_he_id
, ity_inv_code
, iit_st_date
, iit_end_date
, route_id
, route_begin_mp
, route_end_mp
, begin_mp
, end_mp
, rsm_start_date
, rsm_end_date ) 
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/inv_on_route.vw-arc   3.2   Jun 28 2018 04:46:50   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   inv_on_route.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:50  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       o.iit_item_id,
       o.iit_st_chain,
       o.iit_end_chain,
       o.iit_rse_he_id,
       o.iit_ity_inv_code,
       o.iit_cre_date,
       o.iit_end_date,
       r.rsm_rse_he_id_in,
       r.rsm_route_begin_mp,
       r.rsm_route_end_mp,
       r.rsm_begin_mp,
       r.rsm_end_mp,
       r.rsm_start_date,
       r.rsm_end_date
from inv_items_all o, road_seg_membs_all r
where  r.rsm_rse_he_id_of = o.iit_rse_he_id
/
