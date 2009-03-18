CREATE OR REPLACE FORCE VIEW imf_mai_work_orders ( work_order_number
                                                 , work_order_descr
                                                 , interim_payment_flag
                                                 , order_type
                                                 , order_type_descr
                                                 , order_priority
                                                 , order_priority_descr
                                                 , network_element_id
                                                 , network_type
                                                 , scheme_type
                                                 , scheme_type_descr
                                                 , contract_id
                                                 , contract_code
                                                 , contract_name
                                                 , contractor_id
                                                 , contractor_code
                                                 , contractor_name
                                                 , contact
                                                 , originator_id
                                                 , originator_initials
                                                 , originator_name
                                                 , authorised_by_id
                                                 , authorised_by_initials
                                                 , authorised_by_name
                                                 , received_by_id
                                                 , received_by_initials
                                                 , received_by_name
                                                 , cost_centre
                                                 , job_number
                                                 , order_remarks
                                                 , order_date_raised
                                                 , order_days_since_raised
                                                 , order_target_date
                                                 , order_days_to_target_date
                                                 , order_instructed_date
                                                 , order_days_since_instructed
                                                 , order_last_printed_date
                                                 , order_received_date
                                                 , order_days_since_received
                                                 , order_completed_date
                                                 , order_status
                                                 , order_estimated_cost
                                                 , order_estimated_balancing_sum
                                                 , order_estimated_total
                                                 , labour_units
                                                 , order_actual_cost
                                                 , order_actual_balancing_sum
                                                 , order_actual_total
   ) 
AS
   SELECT -------------------------------------------------------------------------
         --   PVCS Identifiers :-
         --
         --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_work_orders.vw-arc   3.0   Mar 18 2009 14:14:40   smarshall  $
         --       Module Name      : $Workfile:   imf_mai_work_orders.vw  $
         --       Date into PVCS   : $Date:   Mar 18 2009 14:14:40  $
         --       Date fetched Out : $Modtime:   Mar 18 2009 14:14:20  $
         --       Version          : $Revision:   3.0  $
         -- Foundation view displaying maintenance manager work orders
         -------------------------------------------------------------------------
                                                   wor_works_order_no
                                                 , wor_descr
                                                 , wor_interim_payment_flag
                                                 , wor_flag
                                                 , (SELECT hco_meaning
                                                    FROM hig_codes
                                                    WHERE hco_domain = 'WOR_FLAG'
                                                    AND hco_code = wor_flag)
                                                 , wor_priority
                                                 , nvl((SELECT hco_meaning 
                                                        FROM hig_codes 
                                                        WHERE hco_domain = 'WOR_PRIORITY'
                                                        AND hco_code = wor.wor_priority), 
                                                        (SELECT wpr_name
                                                         from work_order_priorities
                                                         WHERE wpr_id = wor.wor_priority))
                                                 , wor_rse_he_id_group
                                                 , wor_sys_flag
                                                 , wor_scheme_type 
                                                 , (SELECT hco_meaning 
                                                    FROM hig_codes 
                                                    WHERE hco_domain = 'SCHEME_TYPES'
                                                    AND hco_code = wor.wor_scheme_type)
                                                 , wor_con_id
                                                 , con_code
                                                 , con_name
                                                 , con_contr_org_id
                                                 , (SELECT oun_unit_code
                                                    FROM org_units
                                                    WHERE con_contr_org_id = oun_org_id)
                                                 , (SELECT oun_name
                                                    FROM org_units
                                                    WHERE con_contr_org_id = oun_org_id)
                                                 , wor_contact
                                                 , wor_peo_person_id --originator_id
                                                 , (SELECT hus_initials
                                                    FROM hig_users
                                                    WHERE hus_user_id = wor.wor_peo_person_id)
                                                 , (SELECT hus_name
                                                    FROM hig_users
                                                    WHERE hus_user_id = wor.wor_peo_person_id)
                                                 , wor_mod_by_id --autorised_by_id
                                                 , (SELECT hus_initials
                                                    FROM hig_users
                                                    WHERE hus_user_id = wor.wor_mod_by_id)
                                                 , (SELECT hus_name
                                                    FROM hig_users
                                                    WHERE hus_user_id = wor.wor_mod_by_id)
                                                 , wor_received_by --received_by_id
                                                 , (SELECT hus_initials
                                                    FROM hig_users
                                                    WHERE hus_user_id = wor.wor_received_by)
                                                 , (SELECT hus_name
                                                    FROM hig_users
                                                    WHERE hus_user_id = wor.wor_received_by)
                                                 , wor_coc_cost_centre
                                                 , wor_job_number
                                                 , wor_remarks
                                                 , wor_date_raised
                                                 , TRUNC (SYSDATE) - TRUNC (wor_date_raised)
                                                 , wor_est_complete
                                                 , TRUNC (wor_est_complete) - TRUNC (SYSDATE)
                                                 , wor_date_confirmed
                                                 , TRUNC (SYSDATE) - TRUNC (wor_date_confirmed)
                                                 , wor_last_print_date
                                                 , wor_date_received
                                                 , TRUNC (SYSDATE) - TRUNC (wor_date_received)
                                                 , wor_date_closed
                                                 , DECODE(wor_date_confirmed,NULL,'Not yet instructed', 
                                                          DECODE(wor_date_Closed,NULL, 
                                                          DECODE(wor_act_cost,NULL,'Instructed','Part Complete') 
                                                          ,'Complete'))
                                                 , wor_est_cost
                                                 , wor_est_balancing_sum
                                                 , wor_est_cost + wor_est_balancing_sum
                                                 , wor_est_labour
                                                 , wor_act_cost
                                                 , wor_act_balancing_sum
                                                 , wor_act_cost + wor_act_balancing_sum
   FROM work_orders wor, contracts con
   WHERE wor.wor_con_id = con.con_id;
         
COMMENT ON TABLE IMF_MAI_WORK_ORDERS IS 'Maintenance Manager Foundation view of all work orders, showing most work order details, calculated due dates and work order costings.   This view is useful for producing statistical and summary maintenance manager reports where work order details are required. ';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.WORK_ORDER_NUMBER IS 'Unique identifier of the works order.';      

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.WORK_ORDER_DESCR IS 'Description of the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_PRIORITY IS 'The priority code of the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_PRIORITY_DESCR IS 'The meaning of the priority code of the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.NETWORK_ELEMENT_ID IS 'Internal id of the group location the works order is against.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.NETWORK_TYPE IS 'Network type eg L.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.SCHEME_TYPE IS 'The scheme type code the works order is against.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.SCHEME_TYPE_DESCR IS 'The description of the scheme type code the works order is against.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.CONTRACT_ID IS 'The internal id of the contract the works order is against.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.CONTRACT_CODE IS 'The code of the contract the works order is against.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.CONTRACT_NAME IS 'The name of the contract the works order is against.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.CONTRACTOR_ID IS 'The internal id of the contractor associated with the contract.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.CONTRACTOR_CODE IS 'The code of the contractor associated with the contract.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.CONTRACTOR_NAME IS 'The name of the contractor associated with the contract.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.CONTRACTOR_CODE IS 'The code of the contractor associated with the contract.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORIGINATOR_ID IS 'The internal id of the person that raised the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORIGINATOR_INITIALS IS 'The initials of the person that raised the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORIGINATOR_NAME IS 'The name of the person that raised the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.AUTHORISED_BY_ID IS 'The internal id of the person who authorised the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.AUTHORISED_BY_INITIALS IS 'The initials id of the person who authorised the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.AUTHORISED_BY_NAME IS 'The name of the person who authorised the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.RECEIVED_BY_ID IS 'The internal id of the person who received the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.RECEIVED_BY_INITIALS IS 'The initials of the person who received the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.RECEIVED_BY_NAME IS 'The name of the person who received the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.COST_CENTRE IS 'The cost centre code.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.JOB_NUMBER IS 'The job number.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_REMARKS IS 'General remarks held against the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_DATE_RAISED IS 'The date the order was entered on the system.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_DAYS_SINCE_RAISED IS 'The number of days since the order was raised.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_TARGET_DATE IS 'Target date of the works order completion.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_DAYS_TO_TARGET_DATE IS 'The number of days until the orders target date.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_INSTRUCTED_DATE IS 'Date the works order was instructed.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_DAYS_SINCE_INSTRUCTED IS 'The number of days since the order was instructed.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_LAST_PRINTED_DATE IS 'Date the works order was printed out.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_RECEIVED_DATE IS 'Date the works order was received.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_DAYS_SINCE_RECEIVED IS 'The number of days since the order was received.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_COMPLETED_DATE IS 'Date the works order was completed.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_STATUS IS 'The status of the works order ie Instructed/Completed/etc.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_ESTIMATED_COST IS 'The estimated cost of the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_ESTIMATED_BALANCING_SUM IS 'The estimate balancing sum.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_ESTIMATED_TOTAL IS 'The sum of the estimated cost and the estimated balancing sum.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.LABOUR_UNITS IS 'The number of labour units against the work order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_ACTUAL_COST IS 'The actual cost of the works order.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_ACTUAL_BALANCING_SUM IS 'The actual balancing sum.';

COMMENT ON COLUMN IMF_MAI_WORK_ORDERS.ORDER_ACTUAL_TOTAL IS 'The sum of the actual cost and the actual balancing sum.';
