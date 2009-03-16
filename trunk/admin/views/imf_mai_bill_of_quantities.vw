CREATE OR REPLACE FORCE VIEW imf_mai_bill_of_quantities
(
   BILL_OF_QUANTITIES_ID,
   DEFECT_ID,
   WORK_ORDER_LINE_ID,
   STANDARD_ITEM_CODE,
   STANDARD_ITEM_NAME,
   STANDARD_ITEM_SUB_SECTION_ID,
   STANDARD_ITEM_SUB_SECTION_NAME,
   REPAIR_CATEGORY,
   DATE_CREATED,
   WORK_CATEGORY,
   UNIT_OF_MEASURE,
   ESTIMATED_QUANTITY,
   ESTIMATED_RATE,
   ESTIMATED_DISCOUNT,
   ESTIMATED_COST, 
   ESTIMATED_LABOUR, 
   ACTUAL_QUANTITY,
   ACTUAL_RATE,
   ACTUAL_DISCOUNT,
   ACTUAL_COST, 
   ACTUAL_LABOUR
)
AS
SELECT 
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_bill_of_quantities.vw-arc   3.0   Mar 16 2009 16:19:08   drawat  $
--       Module Name      : $Workfile:   imf_mai_bill_of_quantities.vw  $
--       Date into PVCS   : $Date:   Mar 16 2009 16:19:08  $
--       Date fetched Out : $Modtime:   Mar 16 2009 15:55:16  $
--       Version          : $Revision:   3.0  $
-- Foundation view displaying bill of quantities for a defect
-------------------------------------------------------------------------   
   BI.BOQ_ID,
   BI.BOQ_DEFECT_ID,
   BI.BOQ_WOL_ID,
   BI.BOQ_STA_ITEM_CODE,
   BI.BOQ_ITEM_NAME,
   SI.STA_SISS_ID,
   SISS.SISS_NAME,
   BI.BOQ_REP_ACTION_CAT,
   BI.BOQ_DATE_CREATED,
   BI.BOQ_ICB_WORK_CODE,
   SI.STA_UNIT, 
   BI.BOQ_EST_QUANTITY,
   BI.BOQ_EST_RATE,
   BI.BOQ_EST_DISCOUNT,
   BI.BOQ_EST_COST, 
   BI.BOQ_EST_LABOUR, 
   BI.BOQ_ACT_QUANTITY,
   BI.BOQ_ACT_RATE,
   BI.BOQ_ACT_DISCOUNT,
   BI.BOQ_ACT_COST, 
   BI.BOQ_ACT_LABOUR
FROM BOQ_ITEMS BI,
     STANDARD_ITEMS SI,
     STANDARD_ITEM_SUB_SECTIONS SISS
WHERE BI.BOQ_STA_ITEM_CODE = SI.STA_ITEM_CODE
AND   SI.STA_SISS_ID = SISS.SISS_ID
WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_BILL_OF_QUANTITIES IS 'Maintenance Manager foundation view of all Bill of Quantities items, showing details of estimated and actual work items.   This view can be joined against defect or work order line foundation views to produce reports showing cost summaries and variances.';

COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.BILL_OF_QUANTITIES_ID IS 'Internal Bill Of Quantities Id';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.DEFECT_ID IS 'Internal Id for a defect';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.WORK_ORDER_LINE_ID IS 'Internal Id for work order line';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_CODE IS 'Standard item code for an item of work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_NAME IS 'Standard item name for an item of work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_SUB_SECTION_ID IS 'Internal Id standard item sub sections';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_SUB_SECTION_NAME IS 'Standard item sub section name';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.REPAIR_CATEGORY IS 'Repair Action Category';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.DATE_CREATED IS 'Date the specific work was created';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.WORK_CATEGORY IS 'Internal Cost Breakdown work code';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.UNIT_OF_MEASURE IS 'Unit of measure for the quantity';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_QUANTITY IS 'Estimated quantity for the work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_RATE IS 'Estimated rate for the work cost';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_DISCOUNT IS 'Estimated discount on the work cost';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_COST IS 'Estimated cost for the work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_LABOUR IS 'Estimated labour cost for the work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_QUANTITY IS 'Actual quantity for the work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_RATE IS 'Actual rate for the work cost';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_DISCOUNT IS 'Actual discount on the work cost';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_COST IS 'Actual cost for the work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_LABOUR IS 'Actual labour cost for the work';

