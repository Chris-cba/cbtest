CREATE OR REPLACE FORCE VIEW imf_mai_work_orders
  (works_order_number
  ,works_order_description
  ,works_order_status
  ,works_order_type
  ,works_order_type_description
  ,interim_payment
  ,priority
  ,priority_description
  ,network_element_id
  ,sys_flag
  ,sys_flag_description
  ,scheme_type
  ,scheme_type_description
  ,register
  ,register_status
  ,register_status_description
  ,contract_id
  ,contract_code
  ,contract_name
  ,contractor_id
  ,contractor_code
  ,contractor_name
  ,contact
  ,originator_id
  ,originator_initials
  ,originator_name
  ,authorised_by_id
  ,authorised_by_initials
  ,authorised_by_name
  ,cost_centre
  ,job_number
  ,rechargable
  ,cost_recharged
  ,remarks
  ,date_raised
  ,days_since_raised
  ,target_date
  ,days_to_target_date
  ,date_instructed
  ,days_since_instructed
  ,date_last_printed
  ,date_received
  ,days_since_received
  ,received_by_id
  ,received_by_initials
  ,received_by_name
  ,date_completed
  ,days_since_completed
  ,estimated_cost
  ,estimated_balancing_sum
  ,estimated_total
  ,labour_units
  ,actual_cost
  ,actual_balancing_sum
  ,actual_total) 
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_work_orders.vw-arc   3.1   Jun 28 2010 13:33:46   mhuitson  $
       --       Module Name      : $Workfile:   imf_mai_work_orders.vw  $
       --       Date into PVCS   : $Date:   Jun 28 2010 13:33:46  $
       --       Date fetched Out : $Modtime:   Jun 22 2010 11:49:22  $
       --       Version          : $Revision:   3.1  $
       -- Foundation view displaying maintenance manager work orders
       -------------------------------------------------------------------------
       wor_works_order_no                           works_order_number
      ,wor_descr                                    works_order_description
      ,(SELECT wor_status
          FROM v_work_order_status vwor
         WHERE vwor.wor_works_order_no = wor.wor_works_order_no) works_order_status
      ,wor_flag                                     works_order_type
      ,(SELECT hco_meaning                          
          FROM hig_codes                            
         WHERE hco_domain = 'WOR_FLAG'              
           AND hco_code = wor_flag)                 works_order_type_description
      ,wor_interim_payment_flag                     interim_payment
      ,wor_priority                                 priority
      ,NVL((SELECT hco_meaning                      
              FROM hig_codes                        
             WHERE hco_domain = 'WOR_PRIORITY'      
               AND hco_code = wor.wor_priority)     
          ,(SELECT wpr_name                         
              FROM work_order_priorities            
             WHERE wpr_id = wor.wor_priority))      priority_description
      ,wor_rse_he_id_group                          network_element_id
      ,wor_sys_flag                                 sys_flag
      ,(SELECT hco_meaning                          
          FROM hig_codes                            
         WHERE hco_domain = 'ROAD_SYS_FLAG'         
           AND hco_code = wor.wor_sys_flag)         sys_flag_description
      ,wor_scheme_type                              scheme_type
      ,(SELECT hco_meaning                          
          FROM hig_codes                            
         WHERE hco_domain = 'SCHEME_TYPES'          
           AND hco_code = wor.wor_scheme_type)      scheme_type_description
      ,wor_register_flag                            register
      ,wor_register_status                          register_status
      ,(SELECT hco_meaning                          
          FROM hig_codes                            
         WHERE hco_domain = 'WOR_REGISTER_STATUS'         
           AND hco_code = wor.wor_register_status)  register_status_description
      ,wor_con_id                                   contract_id
      ,con_code                                     contract_code
      ,con_name                                     contract_name
      ,con_contr_org_id                             contractor_id
      ,(SELECT oun_unit_code                        
          FROM org_units                            
         WHERE con_contr_org_id = oun_org_id)       contractor_code
      ,(SELECT oun_name                             
          FROM org_units                            
         WHERE con_contr_org_id = oun_org_id)       contractor_name
      ,wor_contact                                  contact
      ,wor_peo_person_id                            originator_id
      ,(SELECT hus_initials
          FROM hig_users
         WHERE hus_user_id = wor.wor_peo_person_id) originator_initials
      ,(SELECT hus_name
          FROM hig_users
         WHERE hus_user_id = wor.wor_peo_person_id) originator_name
      ,wor_mod_by_id                                authorised_by_id
      ,(SELECT hus_initials
          FROM hig_users
         WHERE hus_user_id = wor.wor_mod_by_id)     authorised_by_initials
      ,(SELECT hus_name
          FROM hig_users
         WHERE hus_user_id = wor.wor_mod_by_id)     authorised_by_name
      ,wor_coc_cost_centre                          cost_centre
      ,wor_job_number                               job_number
      ,wor_rechargeable                             rechargable
      ,wor_cost_recharg                             cost_recharged
      ,wor_remarks                                  remarks
      ,wor_date_raised                              date_raised
      ,TRUNC(SYSDATE) - TRUNC(wor_date_raised)      days_since_raised
      ,wor_est_complete                             target_date
      ,TRUNC(wor_est_complete) - TRUNC(SYSDATE)     days_to_target_date
      ,wor_date_confirmed                           date_instructed
      ,TRUNC(SYSDATE) - TRUNC(wor_date_confirmed)   days_since_instructed
      ,wor_last_print_date                          date_last_printed
      ,wor_date_received                            date_received
      ,TRUNC(SYSDATE) - TRUNC(wor_date_received)    days_since_received
      ,wor_received_by                              received_by_id
      ,(SELECT hus_initials
          FROM hig_users
         WHERE hus_user_id = wor.wor_received_by)   received_by_initials
      ,(SELECT hus_name
          FROM hig_users
         WHERE hus_user_id = wor.wor_received_by)   received_by_name
      ,wor_date_closed                              date_completed
      ,TRUNC(SYSDATE) - TRUNC(wor_date_closed) days_since_completed
      ,wor_est_cost                                 order_estimated_cost
      ,wor_est_balancing_sum                        order_estimated_balancing_sum
      ,wor_est_cost + wor_est_balancing_sum         order_estimated_total
      ,wor_est_labour                               labour_units
      ,wor_act_cost                                 order_actual_cost
      ,wor_act_balancing_sum                        order_actual_balancing_sum
      ,wor_act_cost + wor_act_balancing_sum         order_actual_total
  FROM work_orders wor
      ,contracts con
 WHERE con.con_id = wor.wor_con_id
     ;
         
COMMENT ON TABLE imf_mai_work_orders IS 'Maintenance Manager Foundation view of all Works Orders, showing Works Order details, calculated due dates and work order costings. This view can be used to produce statistical and summary Maintenance Manager reports where Works Order details are required.';

COMMENT ON COLUMN imf_mai_work_orders.works_order_number            IS 'The Works Order Number.';      
COMMENT ON COLUMN imf_mai_work_orders.works_order_description       IS 'The Works Order Description.';
COMMENT ON COLUMN imf_mai_work_orders.works_order_status            IS 'The current status of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.works_order_type              IS 'The Works Order Type, e.g. M - Cyclic Maintenance or D - Defect Clearance';
COMMENT ON COLUMN imf_mai_work_orders.works_order_type_description  IS 'The Works Order Type Description';
COMMENT ON COLUMN imf_mai_work_orders.interim_payment               IS 'Interim Payments can be made? (Y/N)';
COMMENT ON COLUMN imf_mai_work_orders.priority                      IS 'The Works Order Priority code.';
COMMENT ON COLUMN imf_mai_work_orders.priority_description          IS 'The Works Order Priority meaning.';
COMMENT ON COLUMN imf_mai_work_orders.network_element_id            IS 'Internal id of the Road Group associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.sys_flag                      IS 'The Sys Flag of the Road Group associated with the Works Order (L/D).';
COMMENT ON COLUMN imf_mai_work_orders.sys_flag_description          IS 'Sys Flag description.';
COMMENT ON COLUMN imf_mai_work_orders.scheme_type                   IS 'The Works Order Scheme Type.';
COMMENT ON COLUMN imf_mai_work_orders.scheme_type_description       IS 'The Works Order Scheme Type description.';
COMMENT ON COLUMN imf_mai_work_orders.register                      IS 'The Works should be included in the TMA Register? (Y/N)';
COMMENT ON COLUMN imf_mai_work_orders.register_status               IS 'The Status of the Works within the TMA Register.';
COMMENT ON COLUMN imf_mai_work_orders.register_status_description   IS 'The description of the Status of the Works within the TMA Register.';
COMMENT ON COLUMN imf_mai_work_orders.contract_id                   IS 'The internal id of the Contract associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.contract_code                 IS 'The Code of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_work_orders.contract_name                 IS 'The Name of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_work_orders.contractor_id                 IS 'The internal id of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_work_orders.contractor_code               IS 'The Code of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_work_orders.contractor_name               IS 'The Name of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_work_orders.contact                       IS 'The Contact details on the Works Order';
COMMENT ON COLUMN imf_mai_work_orders.originator_id                 IS 'The internal id of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.originator_initials           IS 'The initials of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.originator_name               IS 'The name of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.authorised_by_id              IS 'The internal id of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.authorised_by_initials        IS 'The initials of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.authorised_by_name            IS 'The name of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.cost_centre                   IS 'The Cost Centre code associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.job_number                    IS 'The Job Number associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.rechargable                   IS 'Is the Cost of the Works rechargable to an external organisation? (Y/N).';
COMMENT ON COLUMN imf_mai_work_orders.cost_recharged                IS 'The Total Cost that has been recharged to an external organisation.';
COMMENT ON COLUMN imf_mai_work_orders.remarks                       IS 'General remarks held against the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.date_raised                   IS 'The date the Works Order was raised.';
COMMENT ON COLUMN imf_mai_work_orders.days_since_raised             IS 'The number of days since the Works Order was raised.';
COMMENT ON COLUMN imf_mai_work_orders.target_date                   IS 'The Target Completion Date of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.days_to_target_date           IS 'The number of days until the Target Completion date of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.date_instructed               IS 'The date the Works Order was Instructed.';
COMMENT ON COLUMN imf_mai_work_orders.days_since_instructed         IS 'The number of days since the Works Order was Instructed.';
COMMENT ON COLUMN imf_mai_work_orders.date_last_printed             IS 'The date the Works Order was printed.';
COMMENT ON COLUMN imf_mai_work_orders.date_received                 IS 'The date the Works Order was marked as Received.';
COMMENT ON COLUMN imf_mai_work_orders.days_since_received           IS 'The number of days since the Works Order was marked as Received.';
COMMENT ON COLUMN imf_mai_work_orders.received_by_id                IS 'The internal id of the person who marked the Works Order as Received.';
COMMENT ON COLUMN imf_mai_work_orders.received_by_initials          IS 'The initials of the person who marked the Works Order as Received.';
COMMENT ON COLUMN imf_mai_work_orders.received_by_name              IS 'The name of the person who marked the Works Order as Received.';
COMMENT ON COLUMN imf_mai_work_orders.date_completed                IS 'The date the Works Order was completed.';
COMMENT ON COLUMN imf_mai_work_orders.days_since_completed          IS 'The number of days since the Works Order was completed.';
COMMENT ON COLUMN imf_mai_work_orders.estimated_cost                IS 'The Estimated Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.estimated_balancing_sum       IS 'The Estimate Balancing Sum of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.estimated_total               IS 'The Estimated Cost + the Estimated Balancing Sum.';
COMMENT ON COLUMN imf_mai_work_orders.labour_units                  IS 'The Total number of Labour Units associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.actual_cost                   IS 'The Actual Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.actual_balancing_sum          IS 'The Balancing Sum to be applied to the Actual Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders.actual_total                  IS 'The sum of the Actual Cost and the Actual Balancing Sum.';
