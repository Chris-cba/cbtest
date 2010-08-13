CREATE OR REPLACE FORCE VIEW imf_mai_work_orders_all_attrib
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
  ,actual_total
  ,wor_num_attrib01
  ,wor_num_attrib02
  ,wor_num_attrib03
  ,wor_num_attrib04
  ,wor_num_attrib05
  ,wor_num_attrib06
  ,wor_num_attrib07
  ,wor_num_attrib08
  ,wor_num_attrib09
  ,wor_num_attrib10
  ,wor_num_attrib11
  ,wor_num_attrib12
  ,wor_num_attrib13
  ,wor_num_attrib14
  ,wor_num_attrib15
  ,wor_num_attrib16
  ,wor_num_attrib17
  ,wor_num_attrib18
  ,wor_num_attrib19
  ,wor_num_attrib20
  ,wor_num_attrib21
  ,wor_num_attrib22
  ,wor_num_attrib23
  ,wor_num_attrib24
  ,wor_num_attrib25
  ,wor_num_attrib26
  ,wor_num_attrib27
  ,wor_num_attrib28
  ,wor_num_attrib29
  ,wor_num_attrib30
  ,wor_num_attrib31
  ,wor_num_attrib32
  ,wor_num_attrib33
  ,wor_num_attrib34
  ,wor_num_attrib35
  ,wor_num_attrib36
  ,wor_num_attrib37
  ,wor_num_attrib38
  ,wor_num_attrib39
  ,wor_num_attrib40
  ,wor_num_attrib41
  ,wor_num_attrib42
  ,wor_num_attrib43
  ,wor_num_attrib44
  ,wor_num_attrib45
  ,wor_num_attrib46
  ,wor_num_attrib47
  ,wor_num_attrib48
  ,wor_num_attrib49
  ,wor_num_attrib50
  ,wor_num_attrib51
  ,wor_num_attrib52
  ,wor_num_attrib53
  ,wor_num_attrib54
  ,wor_num_attrib55
  ,wor_num_attrib56
  ,wor_num_attrib57
  ,wor_num_attrib58
  ,wor_num_attrib59
  ,wor_num_attrib60
  ,wor_char_attrib61
  ,wor_char_attrib62
  ,wor_char_attrib63
  ,wor_char_attrib64
  ,wor_char_attrib65
  ,wor_char_attrib66
  ,wor_char_attrib67
  ,wor_char_attrib68
  ,wor_char_attrib69
  ,wor_char_attrib70
  ,wor_char_attrib71
  ,wor_char_attrib72
  ,wor_char_attrib73
  ,wor_char_attrib74
  ,wor_char_attrib75
  ,wor_char_attrib76
  ,wor_char_attrib77
  ,wor_char_attrib78
  ,wor_char_attrib79
  ,wor_char_attrib80
  ,wor_char_attrib81
  ,wor_char_attrib82
  ,wor_char_attrib83
  ,wor_char_attrib84
  ,wor_char_attrib85
  ,wor_char_attrib86
  ,wor_char_attrib87
  ,wor_char_attrib88
  ,wor_char_attrib89
  ,wor_char_attrib90
  ,wor_char_attrib91
  ,wor_char_attrib92
  ,wor_char_attrib93
  ,wor_char_attrib94
  ,wor_char_attrib95
  ,wor_char_attrib96
  ,wor_char_attrib97
  ,wor_char_attrib98
  ,wor_char_attrib99
  ,wor_char_attrib100
  ,wor_char_attrib101
  ,wor_char_attrib102
  ,wor_char_attrib103
  ,wor_char_attrib104
  ,wor_char_attrib105
  ,wor_char_attrib106
  ,wor_char_attrib107
  ,wor_char_attrib108
  ,wor_char_attrib109
  ,wor_char_attrib110
  ,wor_char_attrib111
  ,wor_char_attrib112
  ,wor_char_attrib113
  ,wor_char_attrib114
  ,wor_char_attrib115
  ,wor_char_attrib116
  ,wor_char_attrib117
  ,wor_char_attrib118
  ,wor_char_attrib119
  ,wor_char_attrib120
  ,wor_date_attrib121
  ,wor_date_attrib122
  ,wor_date_attrib123
  ,wor_date_attrib124
  ,wor_date_attrib125
  ,wor_date_attrib126
  ,wor_date_attrib127
  ,wor_date_attrib128
  ,wor_date_attrib129
  ,wor_date_attrib130
  ,wor_date_attrib131
  ,wor_date_attrib132
  ,wor_date_attrib133
  ,wor_date_attrib134
  ,wor_date_attrib135
  ,wor_date_attrib136
  ,wor_date_attrib137
  ,wor_date_attrib138
  ,wor_date_attrib139
  ,wor_date_attrib140
  ,wor_date_attrib141
  ,wor_date_attrib142
  ,wor_date_attrib143
  ,wor_date_attrib144
  ,wor_date_attrib145
  ,wor_date_attrib146
  ,wor_date_attrib147
  ,wor_date_attrib148
  ,wor_date_attrib149
  ,wor_date_attrib150
  ,wor_date_attrib151
  ,wor_date_attrib152
  ,wor_date_attrib153
  ,wor_date_attrib154
  ,wor_date_attrib155
  ,wor_date_attrib156
  ,wor_date_attrib157
  ,wor_date_attrib158
  ,wor_date_attrib159
  ,wor_date_attrib160
  ,wor_date_attrib161
  ,wor_date_attrib162
  ,wor_date_attrib163
  ,wor_date_attrib164
  ,wor_date_attrib165
  ,wor_date_attrib166
  ,wor_date_attrib167
  ,wor_date_attrib168
  ,wor_date_attrib169
  ,wor_date_attrib170
  ,wor_date_attrib171
  ,wor_date_attrib172
  ,wor_date_attrib173
  ,wor_date_attrib174
  ,wor_date_attrib175
  ,wor_date_attrib176
  ,wor_date_attrib177
  ,wor_date_attrib178
  ,wor_date_attrib179
  ,wor_date_attrib180) 
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_work_orders_all_attribs.vw-arc   3.0   Aug 13 2010 10:54:40   Mike.Huitson  $
       --       Module Name      : $Workfile:   imf_mai_work_orders_all_attribs.vw  $
       --       Date into PVCS   : $Date:   Aug 13 2010 10:54:40  $
       --       Date fetched Out : $Modtime:   Aug 12 2010 17:34:42  $
       --       Version          : $Revision:   3.0  $
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
      ,wor_num_attrib01
      ,wor_num_attrib02
      ,wor_num_attrib03
      ,wor_num_attrib04
      ,wor_num_attrib05
      ,wor_num_attrib06
      ,wor_num_attrib07
      ,wor_num_attrib08
      ,wor_num_attrib09
      ,wor_num_attrib10
      ,wor_num_attrib11
      ,wor_num_attrib12
      ,wor_num_attrib13
      ,wor_num_attrib14
      ,wor_num_attrib15
      ,wor_num_attrib16
      ,wor_num_attrib17
      ,wor_num_attrib18
      ,wor_num_attrib19
      ,wor_num_attrib20
      ,wor_num_attrib21
      ,wor_num_attrib22
      ,wor_num_attrib23
      ,wor_num_attrib24
      ,wor_num_attrib25
      ,wor_num_attrib26
      ,wor_num_attrib27
      ,wor_num_attrib28
      ,wor_num_attrib29
      ,wor_num_attrib30
      ,wor_num_attrib31
      ,wor_num_attrib32
      ,wor_num_attrib33
      ,wor_num_attrib34
      ,wor_num_attrib35
      ,wor_num_attrib36
      ,wor_num_attrib37
      ,wor_num_attrib38
      ,wor_num_attrib39
      ,wor_num_attrib40
      ,wor_num_attrib41
      ,wor_num_attrib42
      ,wor_num_attrib43
      ,wor_num_attrib44
      ,wor_num_attrib45
      ,wor_num_attrib46
      ,wor_num_attrib47
      ,wor_num_attrib48
      ,wor_num_attrib49
      ,wor_num_attrib50
      ,wor_num_attrib51
      ,wor_num_attrib52
      ,wor_num_attrib53
      ,wor_num_attrib54
      ,wor_num_attrib55
      ,wor_num_attrib56
      ,wor_num_attrib57
      ,wor_num_attrib58
      ,wor_num_attrib59
      ,wor_num_attrib60
      ,wor_char_attrib61
      ,wor_char_attrib62
      ,wor_char_attrib63
      ,wor_char_attrib64
      ,wor_char_attrib65
      ,wor_char_attrib66
      ,wor_char_attrib67
      ,wor_char_attrib68
      ,wor_char_attrib69
      ,wor_char_attrib70
      ,wor_char_attrib71
      ,wor_char_attrib72
      ,wor_char_attrib73
      ,wor_char_attrib74
      ,wor_char_attrib75
      ,wor_char_attrib76
      ,wor_char_attrib77
      ,wor_char_attrib78
      ,wor_char_attrib79
      ,wor_char_attrib80
      ,wor_char_attrib81
      ,wor_char_attrib82
      ,wor_char_attrib83
      ,wor_char_attrib84
      ,wor_char_attrib85
      ,wor_char_attrib86
      ,wor_char_attrib87
      ,wor_char_attrib88
      ,wor_char_attrib89
      ,wor_char_attrib90
      ,wor_char_attrib91
      ,wor_char_attrib92
      ,wor_char_attrib93
      ,wor_char_attrib94
      ,wor_char_attrib95
      ,wor_char_attrib96
      ,wor_char_attrib97
      ,wor_char_attrib98
      ,wor_char_attrib99
      ,wor_char_attrib100
      ,wor_char_attrib101
      ,wor_char_attrib102
      ,wor_char_attrib103
      ,wor_char_attrib104
      ,wor_char_attrib105
      ,wor_char_attrib106
      ,wor_char_attrib107
      ,wor_char_attrib108
      ,wor_char_attrib109
      ,wor_char_attrib110
      ,wor_char_attrib111
      ,wor_char_attrib112
      ,wor_char_attrib113
      ,wor_char_attrib114
      ,wor_char_attrib115
      ,wor_char_attrib116
      ,wor_char_attrib117
      ,wor_char_attrib118
      ,wor_char_attrib119
      ,wor_char_attrib120
      ,wor_date_attrib121
      ,wor_date_attrib122
      ,wor_date_attrib123
      ,wor_date_attrib124
      ,wor_date_attrib125
      ,wor_date_attrib126
      ,wor_date_attrib127
      ,wor_date_attrib128
      ,wor_date_attrib129
      ,wor_date_attrib130
      ,wor_date_attrib131
      ,wor_date_attrib132
      ,wor_date_attrib133
      ,wor_date_attrib134
      ,wor_date_attrib135
      ,wor_date_attrib136
      ,wor_date_attrib137
      ,wor_date_attrib138
      ,wor_date_attrib139
      ,wor_date_attrib140
      ,wor_date_attrib141
      ,wor_date_attrib142
      ,wor_date_attrib143
      ,wor_date_attrib144
      ,wor_date_attrib145
      ,wor_date_attrib146
      ,wor_date_attrib147
      ,wor_date_attrib148
      ,wor_date_attrib149
      ,wor_date_attrib150
      ,wor_date_attrib151
      ,wor_date_attrib152
      ,wor_date_attrib153
      ,wor_date_attrib154
      ,wor_date_attrib155
      ,wor_date_attrib156
      ,wor_date_attrib157
      ,wor_date_attrib158
      ,wor_date_attrib159
      ,wor_date_attrib160
      ,wor_date_attrib161
      ,wor_date_attrib162
      ,wor_date_attrib163
      ,wor_date_attrib164
      ,wor_date_attrib165
      ,wor_date_attrib166
      ,wor_date_attrib167
      ,wor_date_attrib168
      ,wor_date_attrib169
      ,wor_date_attrib170
      ,wor_date_attrib171
      ,wor_date_attrib172
      ,wor_date_attrib173
      ,wor_date_attrib174
      ,wor_date_attrib175
      ,wor_date_attrib176
      ,wor_date_attrib177
      ,wor_date_attrib178
      ,wor_date_attrib179
      ,wor_date_attrib180
  FROM work_orders wor
      ,contracts con
 WHERE con.con_id = wor.wor_con_id
     ;
         
COMMENT ON TABLE imf_mai_work_orders_all_attrib IS 'Maintenance Manager Foundation view of all Works Orders (Including All Flexible Attribute Columns), showing Works Order details, calculated due dates and work order costings. This view can be used to produce statistical and summary Maintenance Manager reports where Works Order details are required.';

COMMENT ON COLUMN imf_mai_work_orders_all_attrib.works_order_number            IS 'The Works Order Number.';      
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.works_order_description       IS 'The Works Order Description.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.works_order_status            IS 'The current status of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.works_order_type              IS 'The Works Order Type, e.g. M - Cyclic Maintenance or D - Defect Clearance';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.works_order_type_description  IS 'The Works Order Type Description';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.interim_payment               IS 'Interim Payments can be made? (Y/N)';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.priority                      IS 'The Works Order Priority code.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.priority_description          IS 'The Works Order Priority meaning.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.network_element_id            IS 'Internal id of the Road Group associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.sys_flag                      IS 'The Sys Flag of the Road Group associated with the Works Order (L/D).';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.sys_flag_description          IS 'Sys Flag description.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.scheme_type                   IS 'The Works Order Scheme Type.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.scheme_type_description       IS 'The Works Order Scheme Type description.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.register                      IS 'The Works should be included in the TMA Register? (Y/N)';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.register_status               IS 'The Status of the Works within the TMA Register.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.register_status_description   IS 'The description of the Status of the Works within the TMA Register.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.contract_id                   IS 'The internal id of the Contract associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.contract_code                 IS 'The Code of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.contract_name                 IS 'The Name of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.contractor_id                 IS 'The internal id of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.contractor_code               IS 'The Code of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.contractor_name               IS 'The Name of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.contact                       IS 'The Contact details on the Works Order';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.originator_id                 IS 'The internal id of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.originator_initials           IS 'The initials of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.originator_name               IS 'The name of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.authorised_by_id              IS 'The internal id of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.authorised_by_initials        IS 'The initials of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.authorised_by_name            IS 'The name of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.cost_centre                   IS 'The Cost Centre code associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.job_number                    IS 'The Job Number associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.rechargable                   IS 'Is the Cost of the Works rechargable to an external organisation? (Y/N).';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.cost_recharged                IS 'The Total Cost that has been recharged to an external organisation.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.remarks                       IS 'General remarks held against the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.date_raised                   IS 'The date the Works Order was raised.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.days_since_raised             IS 'The number of days since the Works Order was raised.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.target_date                   IS 'The Target Completion Date of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.days_to_target_date           IS 'The number of days until the Target Completion date of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.date_instructed               IS 'The date the Works Order was Instructed.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.days_since_instructed         IS 'The number of days since the Works Order was Instructed.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.date_last_printed             IS 'The date the Works Order was printed.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.date_received                 IS 'The date the Works Order was marked as Received.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.days_since_received           IS 'The number of days since the Works Order was marked as Received.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.received_by_id                IS 'The internal id of the person who marked the Works Order as Received.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.received_by_initials          IS 'The initials of the person who marked the Works Order as Received.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.received_by_name              IS 'The name of the person who marked the Works Order as Received.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.date_completed                IS 'The date the Works Order was completed.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.days_since_completed          IS 'The number of days since the Works Order was completed.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.estimated_cost                IS 'The Estimated Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.estimated_balancing_sum       IS 'The Estimate Balancing Sum of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.estimated_total               IS 'The Estimated Cost + the Estimated Balancing Sum.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.labour_units                  IS 'The Total number of Labour Units associated with the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.actual_cost                   IS 'The Actual Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.actual_balancing_sum          IS 'The Balancing Sum to be applied to the Actual Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.actual_total                  IS 'The sum of the Actual Cost and the Actual Balancing Sum.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib01              IS 'The value stored in Numeric Attribute Column 01.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib02              IS 'The value stored in Numeric Attribute Column 02.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib03              IS 'The value stored in Numeric Attribute Column 03.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib04              IS 'The value stored in Numeric Attribute Column 04.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib05              IS 'The value stored in Numeric Attribute Column 05.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib06              IS 'The value stored in Numeric Attribute Column 06.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib07              IS 'The value stored in Numeric Attribute Column 07.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib08              IS 'The value stored in Numeric Attribute Column 08.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib09              IS 'The value stored in Numeric Attribute Column 09.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib10              IS 'The value stored in Numeric Attribute Column 10.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib11              IS 'The value stored in Numeric Attribute Column 11.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib12              IS 'The value stored in Numeric Attribute Column 12.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib13              IS 'The value stored in Numeric Attribute Column 13.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib14              IS 'The value stored in Numeric Attribute Column 14.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib15              IS 'The value stored in Numeric Attribute Column 15.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib16              IS 'The value stored in Numeric Attribute Column 16.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib17              IS 'The value stored in Numeric Attribute Column 17.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib18              IS 'The value stored in Numeric Attribute Column 18.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib19              IS 'The value stored in Numeric Attribute Column 19.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib20              IS 'The value stored in Numeric Attribute Column 20.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib21              IS 'The value stored in Numeric Attribute Column 21.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib22              IS 'The value stored in Numeric Attribute Column 22.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib23              IS 'The value stored in Numeric Attribute Column 23.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib24              IS 'The value stored in Numeric Attribute Column 24.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib25              IS 'The value stored in Numeric Attribute Column 25.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib26              IS 'The value stored in Numeric Attribute Column 26.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib27              IS 'The value stored in Numeric Attribute Column 27.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib28              IS 'The value stored in Numeric Attribute Column 28.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib29              IS 'The value stored in Numeric Attribute Column 29.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib30              IS 'The value stored in Numeric Attribute Column 30.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib31              IS 'The value stored in Numeric Attribute Column 31.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib32              IS 'The value stored in Numeric Attribute Column 32.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib33              IS 'The value stored in Numeric Attribute Column 33.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib34              IS 'The value stored in Numeric Attribute Column 34.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib35              IS 'The value stored in Numeric Attribute Column 35.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib36              IS 'The value stored in Numeric Attribute Column 36.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib37              IS 'The value stored in Numeric Attribute Column 37.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib38              IS 'The value stored in Numeric Attribute Column 38.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib39              IS 'The value stored in Numeric Attribute Column 39.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib40              IS 'The value stored in Numeric Attribute Column 40.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib41              IS 'The value stored in Numeric Attribute Column 41.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib42              IS 'The value stored in Numeric Attribute Column 42.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib43              IS 'The value stored in Numeric Attribute Column 43.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib44              IS 'The value stored in Numeric Attribute Column 44.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib45              IS 'The value stored in Numeric Attribute Column 45.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib46              IS 'The value stored in Numeric Attribute Column 46.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib47              IS 'The value stored in Numeric Attribute Column 47.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib48              IS 'The value stored in Numeric Attribute Column 48.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib49              IS 'The value stored in Numeric Attribute Column 49.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib50              IS 'The value stored in Numeric Attribute Column 50.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib51              IS 'The value stored in Numeric Attribute Column 51.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib52              IS 'The value stored in Numeric Attribute Column 52.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib53              IS 'The value stored in Numeric Attribute Column 53.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib54              IS 'The value stored in Numeric Attribute Column 54.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib55              IS 'The value stored in Numeric Attribute Column 55.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib56              IS 'The value stored in Numeric Attribute Column 56.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib57              IS 'The value stored in Numeric Attribute Column 57.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib58              IS 'The value stored in Numeric Attribute Column 58.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib59              IS 'The value stored in Numeric Attribute Column 59.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_num_attrib60              IS 'The value stored in Numeric Attribute Column 60.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib61             IS 'The value stored in Character Attribute Column 61.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib62             IS 'The value stored in Character Attribute Column 62.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib63             IS 'The value stored in Character Attribute Column 63.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib64             IS 'The value stored in Character Attribute Column 64.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib65             IS 'The value stored in Character Attribute Column 65.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib66             IS 'The value stored in Character Attribute Column 66.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib67             IS 'The value stored in Character Attribute Column 67.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib68             IS 'The value stored in Character Attribute Column 68.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib69             IS 'The value stored in Character Attribute Column 69.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib70             IS 'The value stored in Character Attribute Column 70.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib71             IS 'The value stored in Character Attribute Column 71.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib72             IS 'The value stored in Character Attribute Column 72.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib73             IS 'The value stored in Character Attribute Column 73.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib74             IS 'The value stored in Character Attribute Column 74.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib75             IS 'The value stored in Character Attribute Column 75.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib76             IS 'The value stored in Character Attribute Column 76.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib77             IS 'The value stored in Character Attribute Column 77.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib78             IS 'The value stored in Character Attribute Column 78.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib79             IS 'The value stored in Character Attribute Column 79.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib80             IS 'The value stored in Character Attribute Column 80.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib81             IS 'The value stored in Character Attribute Column 81.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib82             IS 'The value stored in Character Attribute Column 82.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib83             IS 'The value stored in Character Attribute Column 83.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib84             IS 'The value stored in Character Attribute Column 84.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib85             IS 'The value stored in Character Attribute Column 85.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib86             IS 'The value stored in Character Attribute Column 86.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib87             IS 'The value stored in Character Attribute Column 87.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib88             IS 'The value stored in Character Attribute Column 88.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib89             IS 'The value stored in Character Attribute Column 89.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib90             IS 'The value stored in Character Attribute Column 90.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib91             IS 'The value stored in Character Attribute Column 91.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib92             IS 'The value stored in Character Attribute Column 92.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib93             IS 'The value stored in Character Attribute Column 93.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib94             IS 'The value stored in Character Attribute Column 94.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib95             IS 'The value stored in Character Attribute Column 95.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib96             IS 'The value stored in Character Attribute Column 96.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib97             IS 'The value stored in Character Attribute Column 97.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib98             IS 'The value stored in Character Attribute Column 98.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib99             IS 'The value stored in Character Attribute Column 99.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib100            IS 'The value stored in Character Attribute Column 100.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib101            IS 'The value stored in Character Attribute Column 101.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib102            IS 'The value stored in Character Attribute Column 102.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib103            IS 'The value stored in Character Attribute Column 103.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib104            IS 'The value stored in Character Attribute Column 104.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib105            IS 'The value stored in Character Attribute Column 105.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib106            IS 'The value stored in Character Attribute Column 106.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib107            IS 'The value stored in Character Attribute Column 107.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib108            IS 'The value stored in Character Attribute Column 108.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib109            IS 'The value stored in Character Attribute Column 109.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib110            IS 'The value stored in Character Attribute Column 110.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib111            IS 'The value stored in Character Attribute Column 111.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib112            IS 'The value stored in Character Attribute Column 112.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib113            IS 'The value stored in Character Attribute Column 113.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib114            IS 'The value stored in Character Attribute Column 114.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib115            IS 'The value stored in Character Attribute Column 115.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib116            IS 'The value stored in Character Attribute Column 116.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib117            IS 'The value stored in Character Attribute Column 117.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib118            IS 'The value stored in Character Attribute Column 118.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib119            IS 'The value stored in Character Attribute Column 119.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_char_attrib120            IS 'The value stored in Character Attribute Column 120.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib121            IS 'The value stored in Date Attribute Column 121.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib122            IS 'The value stored in Date Attribute Column 122.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib123            IS 'The value stored in Date Attribute Column 123.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib124            IS 'The value stored in Date Attribute Column 124.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib125            IS 'The value stored in Date Attribute Column 125.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib126            IS 'The value stored in Date Attribute Column 126.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib127            IS 'The value stored in Date Attribute Column 127.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib128            IS 'The value stored in Date Attribute Column 128.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib129            IS 'The value stored in Date Attribute Column 129.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib130            IS 'The value stored in Date Attribute Column 130.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib131            IS 'The value stored in Date Attribute Column 131.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib132            IS 'The value stored in Date Attribute Column 132.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib133            IS 'The value stored in Date Attribute Column 133.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib134            IS 'The value stored in Date Attribute Column 134.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib135            IS 'The value stored in Date Attribute Column 135.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib136            IS 'The value stored in Date Attribute Column 136.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib137            IS 'The value stored in Date Attribute Column 137.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib138            IS 'The value stored in Date Attribute Column 138.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib139            IS 'The value stored in Date Attribute Column 139.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib140            IS 'The value stored in Date Attribute Column 140.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib141            IS 'The value stored in Date Attribute Column 141.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib142            IS 'The value stored in Date Attribute Column 142.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib143            IS 'The value stored in Date Attribute Column 143.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib144            IS 'The value stored in Date Attribute Column 144.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib145            IS 'The value stored in Date Attribute Column 145.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib146            IS 'The value stored in Date Attribute Column 146.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib147            IS 'The value stored in Date Attribute Column 147.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib148            IS 'The value stored in Date Attribute Column 148.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib149            IS 'The value stored in Date Attribute Column 149.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib150            IS 'The value stored in Date Attribute Column 150.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib151            IS 'The value stored in Date Attribute Column 151.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib152            IS 'The value stored in Date Attribute Column 152.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib153            IS 'The value stored in Date Attribute Column 153.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib154            IS 'The value stored in Date Attribute Column 154.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib155            IS 'The value stored in Date Attribute Column 155.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib156            IS 'The value stored in Date Attribute Column 156.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib157            IS 'The value stored in Date Attribute Column 157.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib158            IS 'The value stored in Date Attribute Column 158.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib159            IS 'The value stored in Date Attribute Column 159.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib160            IS 'The value stored in Date Attribute Column 160.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib161            IS 'The value stored in Date Attribute Column 161.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib162            IS 'The value stored in Date Attribute Column 162.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib163            IS 'The value stored in Date Attribute Column 163.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib164            IS 'The value stored in Date Attribute Column 164.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib165            IS 'The value stored in Date Attribute Column 165.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib166            IS 'The value stored in Date Attribute Column 166.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib167            IS 'The value stored in Date Attribute Column 167.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib168            IS 'The value stored in Date Attribute Column 168.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib169            IS 'The value stored in Date Attribute Column 169.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib170            IS 'The value stored in Date Attribute Column 170.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib171            IS 'The value stored in Date Attribute Column 171.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib172            IS 'The value stored in Date Attribute Column 172.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib173            IS 'The value stored in Date Attribute Column 173.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib174            IS 'The value stored in Date Attribute Column 174.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib175            IS 'The value stored in Date Attribute Column 175.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib176            IS 'The value stored in Date Attribute Column 176.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib177            IS 'The value stored in Date Attribute Column 177.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib178            IS 'The value stored in Date Attribute Column 178.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib179            IS 'The value stored in Date Attribute Column 179.';
COMMENT ON COLUMN imf_mai_work_orders_all_attrib.wor_date_attrib180            IS 'The value stored in Date Attribute Column 180.';