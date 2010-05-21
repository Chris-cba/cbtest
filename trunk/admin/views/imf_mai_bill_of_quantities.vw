CREATE OR REPLACE FORCE VIEW imf_mai_bill_of_quantities
  (bill_of_quantities_id
  ,defect_id
  ,work_order_line_id
  ,standard_item_code
  ,standard_item_name
  ,standard_item_sub_section_id
  ,standard_item_sub_section_name
  ,repair_category
  ,repair_category_description
  ,work_category
  ,work_category_description
  ,date_created
  ,unit_of_measure
  ,estimated_quantity
  ,estimated_rate
  ,estimated_discount
  ,estimated_cost
  ,estimated_labour
  ,actual_quantity
  ,actual_rate
  ,actual_discount
  ,actual_cost
  ,actual_labour)
AS
SELECT 
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_bill_of_quantities.vw-arc   3.5   May 21 2010 16:29:20   mhuitson  $
--       Module Name      : $Workfile:   imf_mai_bill_of_quantities.vw  $
--       Date into PVCS   : $Date:   May 21 2010 16:29:20  $
--       Date fetched Out : $Modtime:   May 17 2010 15:18:50  $
--       Version          : $Revision:   3.5  $
-- Foundation view displaying bill of quantities for a defect
-------------------------------------------------------------------------
-- SM 03042009
-- Added rownum=1 to ICB inline sql to cater for ICBFGAC product option
-------------------------------------------------------------------------   
       bi.boq_id,
       bi.boq_parent_id,
       bi.boq_defect_id,
       bi.boq_wol_id,
       bi.boq_sta_item_code,
       DECODE(bi.boq_parent_id,null,nvl(bi.boq_item_name,si.sta_item_name)
                                   ,'->'||nvl(bi.boq_item_name,si.sta_item_name))  boq_item_name,
       si.sta_siss_id,
       ( SELECT siss.siss_name 
           FROM standard_item_sub_sections siss 
          WHERE siss.siss_id = si.sta_siss_id),
       bi.boq_rep_action_cat,  
       ( SELECT hco.hco_meaning
           FROM hig_codes hco
          WHERE hco.hco_domain = 'repair_type' 
            AND hco.hco_code = bi.boq_rep_action_cat ),
       bi.boq_icb_work_code,
       (SELECT icb.icb_work_category_name 
          FROM item_code_breakdowns icb
         WHERE icb.icb_work_code = bi.boq_icb_work_code
           AND rownum = 1),
       bi.boq_date_created,
       si.sta_unit, 
       bi.boq_est_quantity,
       bi.boq_est_rate,
       --bi.boq_est_discount,
       null,
       bi.boq_est_cost, 
       bi.boq_est_labour, 
       bi.boq_act_quantity,
       bi.boq_act_rate,
       --bi.boq_act_discount,
       null,
       bi.boq_act_cost, 
       bi.boq_act_labour
  FROM boq_items bip
      ,standard_items si
      ,boq_items bi
 WHERE bi.boq_sta_item_code = si.sta_item_code(+)
   AND bi.boq_parent_id = bip.boq_id(+)
 ORDER
    BY nvl(boq_parent_id,boq_id)
      ,boq_id
     ;

COMMENT ON TABLE IMF_MAI_BILL_OF_QUANTITIES IS 'Maintenance Manager foundation view of all Bill of Quantities items, showing details of estimated and actual work items.   This view can be joined against defect or work order line foundation views to produce reports showing cost summaries and variances.';

COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.BILL_OF_QUANTITIES_ID IS 'Internal Bill Of Quantities Id';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.DEFECT_ID IS 'Internal Id for a defect';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.WORK_ORDER_LINE_ID IS 'Internal Id for work order line';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_CODE IS 'Standard item code for an item of work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_NAME IS 'Standard item name for an item of work';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_SUB_SECTION_ID IS 'Internal Id standard item sub sections';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_SUB_SECTION_NAME IS 'Standard item sub section name';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.REPAIR_CATEGORY IS 'Repair Action Category';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.REPAIR_CATEGORY_DESCRIPTION IS 'Repair Action Category description';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.WORK_CATEGORY IS 'Internal Cost Breakdown work code';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.WORK_CATEGORY_DESCRIPTION IS 'Internal Cost Breakdown work description';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.DATE_CREATED IS 'Date the specific work was created';
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

