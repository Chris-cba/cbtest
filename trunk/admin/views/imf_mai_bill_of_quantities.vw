CREATE OR REPLACE FORCE VIEW imf_mai_bill_of_quantities
  (bill_of_quantities_id
  ,bill_of_quantities_parent_id
  ,defect_id
  ,work_order_line_id
  ,standard_item_code
  ,standard_item_name
  ,standard_item_sub_section_id
  ,standard_item_sub_section_name
  ,standard_item_allow_percent
  ,repair_category
  ,repair_category_description
  ,date_created
  ,unit_of_measure
  ,estimated_quantity
  ,estimated_rate
  ,estimated_cost
  ,estimated_labour
  ,actual_quantity
  ,actual_rate
  ,actual_cost
  ,actual_labour)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/imf_mai_bill_of_quantities.vw-arc   3.13   Sep 27 2019 15:35:56   Chris.Baugh  $
       --       Module Name      : $Workfile:   imf_mai_bill_of_quantities.vw  $
       --       Date into PVCS   : $Date:   Sep 27 2019 15:35:56  $
       --       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
       --       Version          : $Revision:   3.13  $
       -- Foundation view displaying bill of quantities for a defect
       -------------------------------------------------------------------------
       -- SM 03042009
       -- Added rownum=1 to ICB inline sql to cater for ICBFGAC product option
       ------------------------------------------------------------------
       --   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
       ------------------------------------------------------------------
       bi.boq_id                                                                  bill_of_quantities_id
      ,bi.boq_parent_id                                                           bill_of_quantities_parent_id
      ,bi.boq_defect_id                                                           defect_id
      ,bi.boq_wol_id                                                              work_order_line_id
      ,bi.boq_sta_item_code                                                       standard_item_code
      ,DECODE(bi.boq_parent_id,null,nvl(bi.boq_item_name,si.sta_item_name)
                                   ,'->'||nvl(bi.boq_item_name,si.sta_item_name)) standard_item_name
      ,si.sta_siss_id                                                             standard_item_sub_section_id
      ,( SELECT siss.siss_name 
           FROM standard_item_sub_sections siss 
          WHERE siss.siss_id = si.sta_siss_id)                                    standard_item_sub_section_name
	  ,NVL(sta_allow_percent, 'Y')												  standard_item_allow_percent
      ,bi.boq_rep_action_cat                                                      repair_category
      ,( SELECT hco.hco_meaning
           FROM hig_codes hco
          WHERE hco.hco_domain = 'REPAIR_TYPE'  
            AND hco.hco_code = bi.boq_rep_action_cat)                             repair_category_description
      ,bi.boq_date_created                                                        date_created
      ,si.sta_unit                                                                unit_of_measure
      ,bi.boq_est_quantity                                                        estimated_quantity
      ,bi.boq_est_rate                                                            estimated_rate
      ,bi.boq_est_cost                                                            estimated_cost
      ,bi.boq_est_labour                                                          estimated_labour
      ,bi.boq_act_quantity                                                        actual_quantity
      ,bi.boq_act_rate                                                            actual_rate
      ,bi.boq_act_cost                                                            actual_cost
      ,bi.boq_act_labour                                                          actual_labour
  FROM standard_items si
      ,boq_items bi
 WHERE bi.boq_sta_item_code = si.sta_item_code(+)
 ORDER
    BY nvl(bi.boq_parent_id,bi.boq_id)
      ,bi.boq_id
     ;

COMMENT ON TABLE IMF_MAI_BILL_OF_QUANTITIES IS 'Maintenance Manager foundation view of all Bill of Quantities Items, showing details of estimated and actual quantities and costs. This view can be joined to the defect or work order line foundation views to produce reports showing cost summaries and variances.';

COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.BILL_OF_QUANTITIES_ID IS 'The internal Bill Of Quantities Item Id';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.BILL_OF_QUANTITIES_PARENT_ID IS 'The internal Bill Of Quantities Item Id of a Percentage Items Parent';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.DEFECT_ID IS 'The internal id of the Defect that the Bill Of Quantities Item is associated with';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.WORK_ORDER_LINE_ID IS 'The internal id of the Works Order Line that the Bill Of Quantities Item is associated with';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_CODE IS 'The Standard Item Code associated with the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_NAME IS 'The Standard Item Name associated with the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_SUB_SECTION_ID IS 'The Standard Item Sub Section Id associated with the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_SUB_SECTION_NAME IS 'The Standard Item Sub Section Name associated with the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.STANDARD_ITEM_ALLOW_PERCENT IS 'The Standard Item associated with the Bill Of Quantities Item will allow assignment of percentage items';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.REPAIR_CATEGORY IS 'The Action Category of the Repair that the Bill Of Quantities Item is associated with';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.REPAIR_CATEGORY_DESCRIPTION IS 'The Description of the Action Category of the Repair that the Bill Of Quantities Item is associated with';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.DATE_CREATED IS 'The date the Bill Of Quantities Item was created';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.UNIT_OF_MEASURE IS 'The Unit Of Measure used by the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_QUANTITY IS 'The Estimated Quantity of the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_RATE IS 'The Rate used to calculate the Estimated Cost of the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_COST IS 'The Estimated Cost of the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ESTIMATED_LABOUR IS 'The Estimated Labour Units associated with the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_QUANTITY IS 'The Actual Quantity of the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_RATE IS 'The Rate used to calculate the Actual Cost of the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_COST IS 'The Actual Cost of the Bill Of Quantities Item';
COMMENT ON COLUMN IMF_MAI_BILL_OF_QUANTITIES.ACTUAL_LABOUR IS 'The Actual Labour Units associated with the Bill Of Quantities Item';

