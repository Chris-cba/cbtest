CREATE OR REPLACE FORCE VIEW imf_mai_wo_instruct
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_wo_instruct.vw-arc   3.0   May 06 2010 18:49:46   mhuitson  $
       --       Module Name      : $Workfile:   imf_mai_wo_instruct.vw  $
       --       Date into PVCS   : $Date:   May 06 2010 18:49:46  $
       --       Date fetched Out : $Modtime:   May 06 2010 18:46:34  $
       --       Version          : $Revision:   3.0  $
       -- Foundation view displaying maintenance manager work orders
       -------------------------------------------------------------------------
       wor.work_order_number
      ,wor.work_order_descr
      ,(SELECT COUNT (*)
          FROM work_order_lines
         WHERE wol_works_order_no = wor.work_order_number) number_of_lines
      ,wor.interim_payment_flag
      ,wor.network_type
      ,net.network_element_reference
      ,net.network_element_description
      ,wor.order_priority
      ,wor.order_priority_descr
      ,wor.scheme_type
      ,wor.scheme_type_descr
      ,wor.contract_code
      ,wor.contract_name
      ,wor.contractor_code
      ,wor.contractor_name
      ,wor.contact
      ,wor.originator_initials
      ,wor.originator_name
      ,wor.order_date_raised
      ,wor.cost_centre
      ,wor.job_number
      ,wor.order_remarks
      ,wor.order_estimated_cost
      ,wor.order_estimated_balancing_sum
      ,wor.order_estimated_total
      ,wor.labour_units
      ,DECODE(mai_sdo_util.wo_has_shape(hig.get_sysopt('SDOWOLNTH'),wor.work_order_number),'TRUE','Y','N') order_has_shape
  FROM imf_net_network net
      ,imf_mai_work_orders wor
 WHERE wor.order_instructed_date IS NULL
   AND wor.order_completed_date IS NULL
   AND wor.order_estimated_cost IS NOT NULL
   AND wor.network_element_id = net.network_element_id
   AND (NOT EXISTS(SELECT 1
                     FROM mai_wo_users
                    WHERE mwu_user_id = nm3user.get_user_id)
        OR wor.work_order_number IN (SELECT wor_works_order_no
                                       FROM work_orders
                                      WHERE wor_forwarded_to = nm3user.get_user_id
                                     UNION
                                     SELECT wol_works_order_no
                                       FROM work_order_lines wol
                                      WHERE (EXISTS(SELECT 1
                                                      FROM mai_wo_users
                                                     WHERE mwu_user_id = nm3user.get_user_id
                                                       AND mwu_restrict_by_workcode = 'N')
                                             OR wol.wol_bud_id IN (SELECT bud_id
                                                                     FROM budgets
                                                                         ,mai_wo_user_work_codes
                                                                    WHERE mwuw_user_id = nm3user.get_user_id
                                                                      AND mwuw_icb_item_code = bud_icb_item_code
                                                                      AND NVL(mwuw_icb_sub_item_code,bud_icb_sub_item_code) = bud_icb_sub_item_code
                                                                      AND NVL(mwuw_icb_sub_sub_item_code,bud_icb_sub_sub_item_code) = bud_icb_sub_sub_item_code))
                                        AND (EXISTS(SELECT 1
                                                      FROM mai_wo_users
                                                     WHERE mwu_user_id = nm3user.get_user_id
                                                       AND mwu_restrict_by_road_group = 'N')
                                             OR wol_rse_he_id IN(SELECT nm_ne_id_of
                                                                   FROM nm_members
                                                                  WHERE nm_type = 'G'
                                                                CONNECT BY PRIOR nm_ne_id_of = nm_ne_id_in
                                                                  START WITH nm_ne_id_in IN(SELECT mwur_road_group_id
                                                                                              FROM mai_wo_user_road_groups
                                                                                             WHERE mwur_user_id = nm3user.get_user_id)
                                                                 UNION
                                                                 SELECT mwur_road_group_id
                                                                   FROM mai_wo_user_road_groups
                                                                  WHERE mwur_user_id = nm3user.get_user_id))))
/

COMMENT ON COLUMN imf_mai_wo_instruct.work_order_number             IS 'Unique identifier of the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.work_order_descr              IS 'Description of the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.number_of_lines               IS 'Count of Lines associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.interim_payment_flag          IS 'Interim Payments can be made? (Y/N)';
COMMENT ON COLUMN imf_mai_wo_instruct.network_type                  IS 'Network Type of the Road Group on the Works Order';
COMMENT ON COLUMN imf_mai_wo_instruct.network_element_reference     IS 'Network Element Reference of the Road Group on the Works Order';
COMMENT ON COLUMN imf_mai_wo_instruct.network_element_description   IS 'Network Element Description of the Road Group on the Works Order';
COMMENT ON COLUMN imf_mai_wo_instruct.order_priority                IS 'The Priority Code on the works order.';
COMMENT ON COLUMN imf_mai_wo_instruct.order_priority_descr          IS 'The description of the Priority Code on the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.scheme_type                   IS 'The Scheme Type Code on the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.scheme_type_descr             IS 'The description of the Scheme Type Code on the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.contract_code                 IS 'The Code of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_wo_instruct.contract_name                 IS 'The Name of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_wo_instruct.contractor_code               IS 'The Code of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_wo_instruct.contractor_name               IS 'The Name of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_wo_instruct.contact                       IS 'The Contact details on the Works Order';
COMMENT ON COLUMN imf_mai_wo_instruct.originator_initials           IS 'The initials of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.originator_name               IS 'The name of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.order_date_raised             IS 'The date the Works Order was raised.';
COMMENT ON COLUMN imf_mai_wo_instruct.cost_centre                   IS 'The Cost Centre Code on the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.job_number                    IS 'The Job Number on the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.order_remarks                 IS 'General remarks held against the works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.order_estimated_cost          IS 'The Estimated Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.order_estimated_balancing_sum IS 'The Estimate Balancing Sum of the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.order_estimated_total         IS 'The Estimated Cost + the Estimated Balancing Sum.';
COMMENT ON COLUMN imf_mai_wo_instruct.labour_units                  IS 'The number of Labour Units associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.order_has_shape               IS 'One or more Lines on the Works Order has a shape recorded within the standard exor Work Order Lines Theme? (Y/N)';