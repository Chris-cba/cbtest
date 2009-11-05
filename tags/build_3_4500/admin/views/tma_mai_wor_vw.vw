CREATE OR REPLACE FORCE VIEW tma_mai_wor_vw
( 
 mwo_works_order_no
,mwo_descr
,mwo_date_raised
,mwo_flag
)        
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/tma_mai_wor_vw.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   tma_mai_wor_vw.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:12:48  $
--       Version          : $Revision:   3.0  $
--
--       View supports MAI to TMA integration and is referenced initially in MAI3900
--
-------------------------------------------------------------------------
--
        wor_works_order_no
       ,wor_descr
       ,wor_date_raised
       ,wor_flag
FROM    work_orders    
/

comment on table tma_mai_wor_vw is 'View supports MAI to TMA integration and is referenced initially in MAI3900'
/