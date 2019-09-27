CREATE OR REPLACE FORCE VIEW v_road_construction
(
     st_end_layer
    ,he_id
    ,st_ch
    ,end_ch
    ,layer
)
AS 
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_road_construction.vw-arc   3.3   Sep 27 2019 15:36:20   Chris.Baugh  $
--       Module Name      : $Workfile:   v_road_construction.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:20  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       DISTINCT IIT_ST_CHAIN||IIT_END_CHAIN||IIT_NO_OF_UNITS ST_END_LAYER
     , IIT_RSE_HE_ID HE_ID
     , IIT_ST_CHAIN ST_CH
     , IIT_END_CHAIN END_CH
     , IIT_NO_OF_UNITS LAYER
 FROM   INV_ITEMS_ALL
  WHERE  IIT_ITY_INV_CODE = 'RC'
  AND    IIT_END_DATE IS NULL
/
