CREATE OR REPLACE FORCE VIEW imf_mai_work_order_lines ( work_order_line_id 
                                                      , line_description 
                                                      , work_order_number 
                                                      , network_element_id 
                                                      , standard_item_sub_section_id 
                                                      , standard_item_sub_section_desc
                                                      , work_category
                                                      , work_category_descr
                                                      , defect_id
                                                      , defect_type
                                                      , defect_type_descr 
                                                      , schedule_id
                                                      , schedule_descr
                                                      , contract_payments_id
                                                      , activity_code
                                                      , treatment_code
                                                      , line_quantity
                                                      , line_rate
                                                      , line_estimated_cost
                                                      , line_estimated_labour
                                                      , line_discount 
                                                      , line_actual_cost
                                                      , line_actual_labour
                                                      , line_created_date
                                                      , line_days_since_created
                                                      , line_repaired_date
                                                      , line_days_since_repaired
                                                      , line_complete_date
                                                      , line_days_since_completed
                                                      , line_paid_date
                                                      , line_payment_code 
                                                      , line_status_code
                                                      , line_status_descr 
                                                      , line_invoice_status
                                                      , budget_id
   )
AS
   SELECT -------------------------------------------------------------------------
         --   PVCS Identifiers :-
         --
         --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_work_order_lines.vw-arc   3.2   Apr 03 2009 15:08:46   smarshall  $
         --       Module Name      : $Workfile:   imf_mai_work_order_lines.vw  $
         --       Date into PVCS   : $Date:   Apr 03 2009 15:08:46  $
         --       Date fetched Out : $Modtime:   Apr 03 2009 15:07:32  $
         --       Version          : $Revision:   3.2  $
         -- Foundation view displaying maintenance manager work order lines
         -------------------------------------------------------------------------
         -- SM 03042009
         -- Added rowid=1 to ICB inline sql to cater for ICBFGAC product option
         -------------------------------------------------------------------------          
                                                   wol_id
                                                 , wol_descr
                                                 , wol_works_order_no
                                                 , wol_rse_he_id
                                                 , wol_siss_id
                                                 , (SELECT siss_name
                                                    FROM standard_item_sub_sections
                                                    WHERE siss_id = wol.wol_siss_id)
                                                 , wol_icb_work_code 
                                                 , (SELECT icb_work_category_name
                                                    FROM item_code_breakdowns
                                                    WHERE wol_icb_work_code = icb_work_code
                                                    	AND rownum = 1)
                                                 , wol_def_defect_id
                                                 , wol_rep_action_cat --defect_type 
                                                 , (SELECT hco_meaning 
                                                    FROM hig_codes 
                                                    WHERE hco_domain = 'REPAIR_TYPE'
                                                    AND wol_rep_action_cat = hco_code)
                                                 , wol_schd_id
                                                 , (SELECT schd_name
                                                    FROM schedules
                                                    WHERE schd_id = wol_schd_id)
                                                 , wol_cnp_id --contract_payments
                                                 , wol_act_area_code --activities
                                                 , wol_ss_tre_treat_code
                                                 , wol_quantity
                                                 , wol_rate
                                                 , wol_est_cost 
                                                 , wol_est_labour 
                                                 , wol_discount
                                                 , wol_act_cost
                                                 , wol_act_labour
                                                 , wol_date_created
                                                 , TRUNC (SYSDATE) - TRUNC (wol_date_created)
                                                 , wol_date_repaired                                     
                                                 , TRUNC (SYSDATE) - TRUNC (wol_date_repaired)            
                                                 , wol_date_complete
                                                 , TRUNC (SYSDATE) - TRUNC (wol_date_complete)
                                                 , wol_date_paid
                                                 , wol_payment_code
                                                 , wol_status_code 
                                                 , (SELECT hsc_status_name 
                                                    FROM hig_status_codes 
                                                    WHERE hsc_status_code = wol_status_code 
                                                    AND hsc_domain_code = 'WORK_ORDER_LINES')
                                                 , DECODE( wol_invoice_status
                                                         , 'A', 'Approved'
                                                         , 'O', 'Oustanding')
                                                 , wol_bud_id
   FROM work_order_lines wol;
         
COMMENT ON TABLE IMF_MAI_WORK_ORDER_LINES IS 'Maintenance Manager Foundation view of all work order lines, showing most work order line details, calculated due dates and line costings.   This view is useful for producing statistical and summary maintenance manager reports where work order line details are required. ';

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.WORK_ORDER_LINE_ID IS 'Internal id for work order line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_DESCRIPTION IS 'Description of work order line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.WORK_ORDER_NUMBER IS 'Unique identifier of the works order the line is on.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.NETWORK_ELEMENT_ID IS 'Internal id of the network element the works order line is against.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.STANDARD_ITEM_SUB_SECTION_ID IS 'Internal Id standard item sub sections.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.STANDARD_ITEM_SUB_SECTION_DESC IS 'Standard item sub section name.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.WORK_CATEGORY IS 'Internal Cost Breakdown work code.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.WORK_CATEGORY_DESCR IS 'Internal Cost Breakdown work description.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.DEFECT_ID IS 'The internal id of a defect that may be on the works order line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.DEFECT_TYPE IS 'The repair category associated with the defect on the works order line ie I, T, P.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.DEFECT_TYPE_DESCR IS 'The description of the repair category associated with the defect on the works order line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.SCHEDULE_ID IS 'The internal id of the schedule associated with the works order line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.SCHEDULE_DESCR IS 'The full description of the schedule associated with the works order line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.CONTRACT_PAYMENTS_ID IS 'The internal contract payments id.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.ACTIVITY_CODE IS 'The activity area code.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.TREATMENT_CODE IS 'The treatment code.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_QUANTITY IS 'The lines quantity.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_RATE IS 'The lines rate.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_ESTIMATED_COST IS 'The estimated cost of the line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_ESTIMATED_LABOUR IS 'Estimated labour cost for the work.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_DISCOUNT IS 'The discount on the cost of the line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_ACTUAL_COST IS 'The actual cost of the line.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_ACTUAL_LABOUR IS 'Actual labour cost for the work.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_CREATED_DATE IS 'The date the works order line was entered on the system..';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_DAYS_SINCE_CREATED IS 'The number of days since the works order line was created.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_REPAIRED_DATE IS 'Date the works order line was repaired.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_DAYS_SINCE_REPAIRED IS 'The number of days since the works order line was repaired.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_COMPLETE_DATE IS 'Date the works order line was completed.';                                    

COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_DAYS_SINCE_COMPLETED IS 'The number of days since the works order line was completed.';
      
COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_PAID_DATE IS 'Date the works order line was paid.';
      
COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_PAYMENT_CODE IS 'The works order lines payment code.';
      
COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_STATUS_CODE IS 'The status code of the line.';
      
COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_STATUS_DESCR IS 'The meaning of the status code of the line.';
   
COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.LINE_INVOICE_STATUS IS 'The financial status of this line ie Approved for payment, Outstanding.';
   
COMMENT ON COLUMN IMF_MAI_WORK_ORDER_LINES.BUDGET_ID IS 'The internal id of the budget associated with the works order line.';
   
 
