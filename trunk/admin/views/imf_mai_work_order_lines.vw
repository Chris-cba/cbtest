CREATE OR REPLACE FORCE VIEW imf_mai_work_order_lines
  (work_order_line_id
  ,work_order_number
  ,location_description
  ,network_element_id
  ,standard_item_sub_section_id
  ,standard_item_sub_section_desc
  ,work_category
  ,work_category_description
  ,agency_code
  ,agency_code_description
  ,defect_id
  ,defect_type
  ,defect_type_description
  ,defect_priority
  ,defect_priority_description
  ,defect_asset_type
  ,defect_asset_id
  ,repair_category
  ,repair_category_description
  ,schedule_id
  ,schedule_description
  ,worksheet
  ,register
  ,register_status
  ,register_status_description
  ,contract_payments_id
  ,activity_code
  ,activity_description
  ,treatment_code
  ,treatment_description
  ,estimated_cost
  ,labour_units
  ,actual_cost
  ,remarks
  ,date_created
  ,days_since_created
  ,target_date
  ,days_to_target_date
  ,date_repaired
  ,days_since_repaired
  ,date_completed
  ,days_since_completed
  ,date_paid
  ,days_since_paid
  ,payment_code
  ,work_order_line_status
  ,work_order_line_status_descr
  ,invoice_status
  ,invoice_status_description
  ,budget_id)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_work_order_lines.vw-arc   3.9   Apr 20 2011 16:55:20   Chris.Baugh  $
       --       Module Name      : $Workfile:   imf_mai_work_order_lines.vw  $
       --       Date into PVCS   : $Date:   Apr 20 2011 16:55:20  $
       --       Date fetched Out : $Modtime:   Apr 20 2011 16:54:22  $
       --       Version          : $Revision:   3.9  $
       -- Foundation view displaying maintenance manager work order lines
       -------------------------------------------------------------------------
       -- SM 03042009
       -- Added rowid=1 to ICB inline sql to cater for ICBFGAC product option
       -- SM 28052009
       -- Added icb_agency_code and hau_name (agency_code_descr)
       -------------------------------------------------------------------------
       wol.wol_id                                                       work_order_line_id
      ,wol.wol_works_order_no                                           work_order_number
      ,NVL(def.def_locn_descr,wol.wol_locn_descr)                       location_description
      ,wol.wol_rse_he_id                                                network_element_id
      ,wol.wol_siss_id                                                  standard_item_sub_section_id
      ,(SELECT siss_name
          FROM standard_item_sub_sections
         WHERE siss_id = wol.wol_siss_id)                               standard_item_sub_section_desc
      ,wol.wol_icb_work_code                                            work_category
      ,(SELECT icb_work_category_name
          FROM budgets
              ,item_code_breakdowns
         WHERE icb_dtp_flag = bud_sys_flag
           AND icb_agency_code = bud_agency
           AND icb_item_code = bud_icb_item_code
           AND icb_sub_item_code = bud_icb_sub_item_code
           AND icb_sub_sub_item_code = bud_icb_sub_sub_item_code
           AND bud_id = wol.wol_bud_id)                                 work_category_description
      ,(SELECT bud_agency
          FROM budgets
         WHERE bud_id = wol.wol_bud_id)                                 agency_code
      ,(SELECT hau_name
          FROM hig_admin_units
         WHERE hau_authority_code = (SELECT bud_agency
                                       FROM budgets
                                      WHERE bud_id = wol.wol_bud_id))   agency_code_description
      ,wol.wol_def_defect_id                                            defect_id
      ,def.def_defect_code                                              defect_type
      ,(SELECT dty_descr1
          FROM def_types
         WHERE dty_defect_code = def.def_defect_code
           AND dty_atv_acty_area_code = def.def_atv_acty_area_code
           AND dty_dtp_flag = def.def_ity_sys_flag)                     defect_type_description
      ,def.def_priority                                                 defect_priority
      ,(SELECT hco_meaning
          FROM hig_codes
         WHERE hco_domain = 'DEFECT_PRIORITIES'
           AND hco_code = def.def_priority )                            defect_priority_description
      ,(SELECT nit_inv_type
          FROM inv_type_translations
         WHERE ity_inv_code = def.def_ity_inv_code)                     defect_asset_type
      ,def.def_iit_item_id                                              defect_asset_id
      ,wol.wol_rep_action_cat                                           repair_category
      ,(SELECT hco_meaning
          FROM hig_codes
         WHERE hco_domain = 'REPAIR_TYPE'
           AND hco_code = wol.wol_rep_action_cat)                       repair_category_description
      ,wol.wol_schd_id                                                  schedule_id
      ,(SELECT schd_name
          FROM schedules
         WHERE schd_id = wol.wol_schd_id)                               schedule_description
      ,wol.wol_work_sheet_no                                            worksheet
      ,wol.wol_register_flag                                            register
      ,DECODE(wol.wol_register_flag,'N',NULL
                                       ,mai.determine_reg_status_for_flag(wol.wol_works_order_no
                                                                         ,wol.wol_register_flag
                                                                         ,wol.wol_id)) register_status
      ,DECODE(wol.wol_register_flag,'N',NULL
                                       ,(SELECT hco_meaning                          
                                           FROM hig_codes                            
                                          WHERE hco_domain = 'WOR_REGISTER_STATUS'         
                                            AND hco_code = mai.determine_reg_status_for_flag(wol.wol_works_order_no
                                                                                            ,wol.wol_register_flag
                                                                                            ,wol.wol_id))) register_status_description
      ,wol.wol_cnp_id                                                   contract_payments_id
      ,wol.wol_act_area_code                                            activity_code
      ,(SELECT atv_descr
          FROM activities
         WHERE atv_acty_area_code = wol.wol_act_area_code
           AND atv_dtp_flag = (SELECT wor_sys_flag
                                 FROM work_orders
                                WHERE wor_works_order_no = wol.wol_works_order_no)) activity_description
      ,DECODE(wol.wol_flag,'S',wol.wol_ss_tre_treat_code
                              ,(SELECT rep_tre_treat_code
                                  FROM repairs
                                 WHERE rep_def_defect_id = wol.wol_def_defect_id
                                   AND rep_action_cat = wol.wol_rep_action_cat )) treatment_code
      ,(SELECT tre_descr
          FROM treatments
         WHERE tre_treat_code = DECODE(wol.wol_flag,'S',wol.wol_ss_tre_treat_code
                                                       ,(SELECT rep_tre_treat_code
                                                           FROM repairs
                                                          WHERE rep_def_defect_id = wol.wol_def_defect_id
                                                            AND rep_action_cat = wol.wol_rep_action_cat ))) treatment_description
      ,wol.wol_est_cost                                                 estimated_cost
      ,wol.wol_est_labour                                               labour_units
      ,wol.wol_act_cost                                                 actual_cost
      ,wol.wol_descr                                                    remarks
      ,wol.wol_date_created                                             date_created
      ,TRUNC(SYSDATE) - TRUNC(wol.wol_date_created)                     days_since_created
	  ,wol.wol_target_date                                              target_date
	  ,TRUNC(wol.wol_target_date) - TRUNC(SYSDATE)                      days_to_target_date
      ,wol.wol_date_repaired                                            date_repaired
      ,TRUNC(SYSDATE) - TRUNC(wol.wol_date_repaired)                    days_since_repaired
      ,wol.wol_date_complete                                            date_completed
      ,TRUNC(SYSDATE) - TRUNC(wol.wol_date_complete)                    days_since_completed
      ,wol.wol_date_paid                                                date_paid
      ,TRUNC(SYSDATE) - TRUNC(wol.wol_date_paid)                        days_since_paid
      ,wol.wol_payment_code                                             payment_code
      ,wol.wol_status_code                                              work_order_line_status
      ,(SELECT hsc_status_name
          FROM hig_status_codes
         WHERE hsc_domain_code = 'WORK_ORDER_LINES'
           AND hsc_status_code = wol.wol_status_code)                   work_order_line_status_descr
      ,wol.wol_invoice_status                                           invoice_status
      ,DECODE(wol.wol_invoice_status,'B','Both Held and Outstanding Invoices exist'
                                    ,'O','Oustanding Invoice exists'
                                    ,'H','Held Invoice exists'
                                    ,'A','All Invoices have been Paid') invoice_status_description
      ,wol.wol_bud_id                                                   budget_id
  FROM defects def 
      ,work_order_lines wol
 WHERE wol.wol_def_defect_id = def.def_defect_id(+);

COMMENT ON TABLE imf_mai_work_order_lines IS 'Maintenance Manager Foundation view of all Works Order Lines, showing Works Order Line details, key dates in the life cycle of the work and summary cost information. This view can be used to produce statistical and summary Maintenance Manager reports where Works Order Line details are required.';

COMMENT ON COLUMN imf_mai_work_order_lines.work_order_line_id             IS 'The internal id of the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.work_order_number              IS 'The Works Order Number that the Works Order Line is associated with.';
COMMENT ON COLUMN imf_mai_work_order_lines.location_description           IS 'The Location Description held against either the Works Order Line or the associated Defect.';
COMMENT ON COLUMN imf_mai_work_order_lines.network_element_id             IS 'The internal id of the network element that the Works Order Line is associated with.';
COMMENT ON COLUMN imf_mai_work_order_lines.standard_item_sub_section_id   IS 'The Standard Item Sub Section associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.standard_item_sub_section_desc IS 'The Standard Item Sub Section description.';
COMMENT ON COLUMN imf_mai_work_order_lines.work_category                  IS 'The Work Category associated with the Budget that is used for the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.work_category_description      IS 'The Work Category Description.';
COMMENT ON COLUMN imf_mai_work_order_lines.agency_code                    IS 'The Agency Code associated with the Budget that is used for the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.agency_code_description        IS 'The Agency description.';
COMMENT ON COLUMN imf_mai_work_order_lines.defect_id                      IS 'The internal id of the Defect that the Repair associated with the Works Order Line belongs to.';
COMMENT ON COLUMN imf_mai_work_order_lines.defect_type                    IS 'The Type of the Defect that the Repair associated with the Works Order Line belongs to.';
COMMENT ON COLUMN imf_mai_work_order_lines.defect_type_description        IS 'The Defect Type description.';
COMMENT ON COLUMN imf_mai_work_order_lines.defect_priority                IS 'The Priority of the Defect that the Repair associated with the Works Order Line belongs to.';
COMMENT ON COLUMN imf_mai_work_order_lines.defect_priority_description    IS 'The Defect Priority Description.';
COMMENT ON COLUMN imf_mai_work_order_lines.defect_asset_type              IS 'The Asset Type related to the Defect that the Repair associated with the Works Order Line belongs to.';
COMMENT ON COLUMN imf_mai_work_order_lines.defect_asset_id                IS 'The internal id of the Asset related to the Defect that the Repair associated with the Works Order Line belongs to.';
COMMENT ON COLUMN imf_mai_work_order_lines.repair_category                IS 'The Action Category of the Repair associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.repair_category_description    IS 'The Repair Action Category description.';
COMMENT ON COLUMN imf_mai_work_order_lines.schedule_id                    IS 'The internal id of the Schedule associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.schedule_description           IS 'The description of the Schedule associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.worksheet                      IS 'The Worksheet Number associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.register                       IS 'The Works should be included in the TMA Register? (Y/N)';
COMMENT ON COLUMN imf_mai_work_order_lines.register_status                IS 'The Status of the Works within the TMA Register.';
COMMENT ON COLUMN imf_mai_work_order_lines.register_status_description    IS 'The description of the Status of the Works within the TMA Register.';
COMMENT ON COLUMN imf_mai_work_order_lines.contract_payments_id           IS 'The internal id of the most recent Contract Payment (Payment Run) made against the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.activity_code                  IS 'The Activity Code associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.activity_description           IS 'The Activity description.';
COMMENT ON COLUMN imf_mai_work_order_lines.treatment_code                 IS 'The Treatment Code associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.treatment_description          IS 'The Treatment description.';
COMMENT ON COLUMN imf_mai_work_order_lines.estimated_cost                 IS 'The Estimated Cost of the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.labour_units                   IS 'The Total number of Labour Units associated with the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.actual_cost                    IS 'The Actual Cost of the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.remarks                        IS 'General remarks held against the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.date_created                   IS 'The date the Works Order Line was created within the system.';
COMMENT ON COLUMN imf_mai_work_order_lines.days_since_created             IS 'The number of days since the Works Order Line was created.';
COMMENT ON COLUMN imf_mai_work_order_lines.target_date                    IS 'The date the Works Order Line is due to be completed.';
COMMENT ON COLUMN imf_mai_work_order_lines.days_to_target_date            IS 'The number of days until the Work Order Line is due to be completed.';
COMMENT ON COLUMN imf_mai_work_order_lines.date_repaired                  IS 'Date the Works Order Line was repaired.';
COMMENT ON COLUMN imf_mai_work_order_lines.days_since_repaired            IS 'The number of days since the Works Order Line was repaired.';
COMMENT ON COLUMN imf_mai_work_order_lines.date_completed                 IS 'Date the Works Order Line was completed.';
COMMENT ON COLUMN imf_mai_work_order_lines.days_since_completed           IS 'The number of days since the Works Order Line was completed.';
COMMENT ON COLUMN imf_mai_work_order_lines.date_paid                      IS 'Date the Works Order Line was paid.';
COMMENT ON COLUMN imf_mai_work_order_lines.days_since_paid                IS 'The number of days since the Works Order Line was paid.';
COMMENT ON COLUMN imf_mai_work_order_lines.payment_code                   IS 'The Works Order Line payment code.';
COMMENT ON COLUMN imf_mai_work_order_lines.work_order_line_status         IS 'The Works Order Line Status code.';
COMMENT ON COLUMN imf_mai_work_order_lines.work_order_line_status_descr   IS 'The Works Order Line Status description.';
COMMENT ON COLUMN imf_mai_work_order_lines.invoice_status                 IS 'The Status Code of the most recent Invoice/Claim raised for the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.invoice_status_description     IS 'The description of the Status Code of the most recent Invoice/Claim raised for the Works Order Line.';
COMMENT ON COLUMN imf_mai_work_order_lines.budget_id                      IS 'The internal id of the Budget that the Works Order Line is associated with.';