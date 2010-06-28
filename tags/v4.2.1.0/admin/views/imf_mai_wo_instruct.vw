CREATE OR REPLACE FORCE VIEW imf_mai_wo_instruct
  (works_order_number
  ,works_order_description
  ,works_order_status
  ,number_of_lines
  ,works_order_type
  ,works_order_type_description
  ,interim_payment
  ,priority
  ,priority_description
  ,network_element_reference
  ,network_element_description
  ,sys_flag
  ,sys_flag_description
  ,scheme_type
  ,scheme_type_description
  ,contract_code
  ,contract_name
  ,contractor_code
  ,contractor_name
  ,contact
  ,originator_id
  ,originator_initials
  ,originator_name
  ,authorised_by_id
  ,authorised_by_initials
  ,authorised_by_name
  ,date_raised
  ,days_since_raised
  ,cost_centre
  ,job_number
  ,remarks
  ,estimated_cost
  ,estimated_balancing_sum
  ,estimated_total
  ,labour_units
  ,works_order_has_shape)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_wo_instruct.vw-arc   3.2   Jun 28 2010 13:33:46   mhuitson  $
       --       Module Name      : $Workfile:   imf_mai_wo_instruct.vw  $
       --       Date into PVCS   : $Date:   Jun 28 2010 13:33:46  $
       --       Date fetched Out : $Modtime:   Jun 18 2010 16:15:10  $
       --       Version          : $Revision:   3.2  $
       -- Foundation view displaying maintenance manager work orders
       -------------------------------------------------------------------------
       wor.works_order_number                              works_order_number
      ,wor.works_order_description                         works_order_description
      ,wor.works_order_status                              works_order_status
      ,(SELECT COUNT (*)
          FROM work_order_lines
         WHERE wol_works_order_no = wor.works_order_number) number_of_lines
      ,wor.works_order_type                                works_order_type
      ,wor.works_order_type_description                    works_order_type_description
      ,wor.interim_payment                                 interim_payment
      ,wor.priority                                        priority
      ,wor.priority_description                            priority_description
      ,ne.ne_unique                                        network_element_reference
      ,ne.ne_descr                                         network_element_description
      ,wor.sys_flag                                        sys_flag
      ,wor.sys_flag_description                            sys_flag_description
      ,wor.scheme_type                                     scheme_type
      ,wor.scheme_type_description                         scheme_type_description
      ,wor.contract_code                                   contract_code
      ,wor.contract_name                                   contract_name
      ,wor.contractor_code                                 contractor_code
      ,wor.contractor_name                                 contractor_name
      ,wor.contact                                         contact
      ,wor.originator_id                                   originator_id
      ,wor.originator_initials                             originator_initials
      ,wor.originator_name                                 originator_name
      ,wor.authorised_by_id                                authorised_by_id
      ,wor.authorised_by_initials                          authorised_by_initials
      ,wor.authorised_by_name                              authorised_by_name
      ,wor.date_raised                                     date_raised
      ,wor.days_since_raised                               days_since_raised
      ,wor.cost_centre                                     cost_centre
      ,wor.job_number                                      job_number
      ,wor.remarks                                         remarks
      ,wor.estimated_cost                                  estimated_cost
      ,wor.estimated_balancing_sum                         estimated_balancing_sum
      ,wor.estimated_total                                 estimated_total
      ,wor.labour_units                                    labour_units
      ,DECODE(mai_sdo_util.wo_has_shape(hig.get_sysopt('SDOWOLNTH')
             ,wor.works_order_number),'TRUE','Y','N')      works_order_has_shape
  FROM nm_elements_all ne
      ,imf_mai_work_orders wor
 WHERE wor.date_instructed IS NULL
   AND wor.date_completed IS NULL
   AND wor.estimated_cost IS NOT NULL
   AND wor.network_element_id = ne.ne_id(+)
   AND (NOT EXISTS(SELECT 1
                     FROM mai_wo_users
                    WHERE mwu_user_id = nm3user.get_user_id)
        OR wor.works_order_number IN (SELECT wor_works_order_no
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

COMMENT ON TABLE imf_mai_wo_instruct IS 'Maintenance Manager Foundation view of Works Orders awaiting Instruction. This view is intended to be used as the basis of the Instruct Work Order Work Tray and is therefore restricted by the Work Order User criteria that can be specified as an administrative function of the Work Order Work Tray.';

COMMENT ON COLUMN imf_mai_wo_instruct.works_order_number            IS 'The Works Order Number.';      
COMMENT ON COLUMN imf_mai_wo_instruct.works_order_description       IS 'The Works Order Description.';
COMMENT ON COLUMN imf_mai_wo_instruct.works_order_status            IS 'The current status of the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.number_of_lines               IS 'Count of Lines associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.interim_payment               IS 'Interim Payments can be made? (Y/N)';
COMMENT ON COLUMN imf_mai_wo_instruct.works_order_type              IS 'The Works Order Type, e.g. M - Cyclic Maintenance or D - Defect Clearance';
COMMENT ON COLUMN imf_mai_wo_instruct.works_order_type_description  IS 'The Works Order Type Description';
COMMENT ON COLUMN imf_mai_wo_instruct.priority                      IS 'The Works Order Priority code.';
COMMENT ON COLUMN imf_mai_wo_instruct.priority_description          IS 'The Works Order Priority description.';
COMMENT ON COLUMN imf_mai_wo_instruct.network_element_reference     IS 'The Network Element Reference of the Road Group associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.network_element_description   IS 'The Network Element Description of the Road Group associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.sys_flag                      IS 'The Sys Flag of the Road Group associated with the Works Order (L/D).';
COMMENT ON COLUMN imf_mai_wo_instruct.sys_flag_description          IS 'Sys Flag description.';
COMMENT ON COLUMN imf_mai_wo_instruct.scheme_type                   IS 'The Works Order Scheme Type.';
COMMENT ON COLUMN imf_mai_wo_instruct.scheme_type_description       IS 'The Works Order Scheme Type description.';
COMMENT ON COLUMN imf_mai_wo_instruct.contract_code                 IS 'The Code of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_wo_instruct.contract_name                 IS 'The Name of the Contract that the Works Order is assigned to.';
COMMENT ON COLUMN imf_mai_wo_instruct.contractor_code               IS 'The Code of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_wo_instruct.contractor_name               IS 'The Name of the Contractor associated with the Contract.';
COMMENT ON COLUMN imf_mai_wo_instruct.contact                       IS 'The Contact details on the Works Order';
COMMENT ON COLUMN imf_mai_wo_instruct.originator_id                 IS 'The internal id of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.originator_initials           IS 'The initials of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.originator_name               IS 'The name of the person that raised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.authorised_by_id              IS 'The internal id of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.authorised_by_initials        IS 'The initials of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.authorised_by_name            IS 'The name of the person who authorised the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.date_raised                   IS 'The date the Works Order was raised.';
COMMENT ON COLUMN imf_mai_wo_instruct.days_since_raised             IS 'The number of days since the Works Order was raised.';
COMMENT ON COLUMN imf_mai_wo_instruct.cost_centre                   IS 'The Cost Centre code associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.job_number                    IS 'The Job Number associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.remarks                       IS 'General remarks held against the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.estimated_cost                IS 'The Estimated Cost of the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.estimated_balancing_sum       IS 'The Estimate Balancing Sum of the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.estimated_total               IS 'The Estimated Cost + the Estimated Balancing Sum.';
COMMENT ON COLUMN imf_mai_wo_instruct.labour_units                  IS 'The Total number of Labour Units associated with the Works Order.';
COMMENT ON COLUMN imf_mai_wo_instruct.works_order_has_shape         IS 'One or more Lines on the Works Order has a shape recorded within the standard exor Work Order Lines Theme? (Y/N)';