CREATE OR REPLACE FORCE VIEW tma_mai_wol_details_vw
( 
 wol_works_order_no
,wol_id
,def_locn_descr
,rse_unique
,rse_descr
,def_defect_id
,def_defect_code
,def_priority
,def_date_compl
,wol_icb_work_code
)        
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/tma_mai_wol_details_vw.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   tma_mai_wol_details_vw.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:12:18  $
--       Version          : $Revision:   3.0  $
--
--       View supports MAI to TMA integration and is referenced initially in MAI3900
--  
-------------------------------------------------------------------------
--
        wol.wol_works_order_no
       ,wol.wol_id
       ,NVL(def.def_locn_descr,wol.wol_locn_descr) 
       ,rse.rse_unique     
       ,rse.rse_descr
       ,def.def_defect_id
       ,def.def_defect_code
       ,def.def_priority
       ,def.def_date_compl
       ,wol.wol_icb_work_code
FROM    work_order_lines wol
       ,defects def
       ,road_segs rse
WHERE   wol.wol_def_defect_id      = def.def_defect_id(+)               
AND     wol.wol_rse_he_id          = rse.rse_he_id 
AND     Nvl(wol_register_flag,'N') = 'Y'
/
comment on table tma_mai_wol_details_vw is 'View supports MAI to TMA integration and is referenced initially in MAI3900'
/