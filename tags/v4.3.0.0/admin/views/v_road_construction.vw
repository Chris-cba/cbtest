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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_road_construction.vw-arc   3.0   Nov 05 2009 10:35:02   gjohnson  $
--       Module Name      : $Workfile:   v_road_construction.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:02  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:39:42  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
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