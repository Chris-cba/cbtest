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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_road_construction.vw-arc   3.1   Jul 01 2013 15:55:32   James.Wadsworth  $
--       Module Name      : $Workfile:   v_road_construction.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:32  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:25:10  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
