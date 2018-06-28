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
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/tma_mai_wor_vw.vw-arc   3.2   Jun 28 2018 04:46:52   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   tma_mai_wor_vw.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:52  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
--
--       View supports MAI to TMA integration and is referenced initially in MAI3900
--
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
        wor_works_order_no
       ,wor_descr
       ,wor_date_raised
       ,wor_flag
FROM    work_orders    
/

comment on table tma_mai_wor_vw is 'View supports MAI to TMA integration and is referenced initially in MAI3900'
/
