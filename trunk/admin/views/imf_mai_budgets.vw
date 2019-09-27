CREATE OR REPLACE FORCE VIEW imf_mai_budgets
  (budget_id
  ,network_element_id
  ,network_element_reference
  ,network_element_description
  ,sys_flag
  ,sys_flag_description
  ,admin_unit_agency_code
  ,admin_unit_name
  ,admin_unit_code
  ,job_size
  ,work_category
  ,work_category_description
  ,financial_year
  ,financial_year_start_date
  ,financial_year_end_date
  ,budget
  ,committed
  ,actual
  ,balance
  ,comments
  ,cost_code
  ,contractor_cost_code
  ,finance_cost_code
  ,additional_cost_code)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/imf_mai_budgets.vw-arc   1.7   Sep 27 2019 15:35:58   Chris.Baugh  $
       --       Module Name      : $Workfile:   imf_mai_budgets.vw  $
       --       Date into PVCS   : $Date:   Sep 27 2019 15:35:58  $
       --       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
       --       Version          : $Revision:   1.7  $
       -- Foundation view displaying budgets
       ------------------------------------------------------------------
       --   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
       ------------------------------------------------------------------
       b.bud_id                                 budget_id
      ,b.bud_rse_he_id                          network_element_id
      ,ne.ne_unique                             network_element_reference
      ,ne.ne_descr                              network_element_description
      ,b.bud_sys_flag                           sys_flag
      ,(SELECT hco_meaning
          FROM hig_codes
         WHERE hco_domain = 'ROAD_SYS_FLAG'
           AND hco_code = b.bud_sys_flag)       sys_flag_description
      ,nau.nau_authority_code                   admin_unit_agency_code
      ,nau.nau_name                             admin_unit_name
      ,nau.nau_admin_unit                       admin_unit_code
      ,(SELECT js.job_descr
          FROM job_sizes js
         WHERE js.job_code = b.bud_job_code )   job_size
      ,b.bud_icb_item_code||b.bud_icb_sub_item_code||b.bud_icb_sub_sub_item_code  work_category
      ,(SELECT icb.icb_work_category_name
          FROM item_code_breakdowns icb
         WHERE icb.icb_dtp_flag = b.bud_sys_flag
           AND icb.icb_item_code = b.bud_icb_item_code
           AND icb.icb_sub_item_code = b.bud_icb_sub_item_code
           AND icb.icb_sub_sub_item_code = b.bud_icb_sub_sub_item_code
           AND icb_agency_code = b.bud_agency)  work_category_description
      ,b.bud_fyr_id                             financial_year
      ,fyr.fyr_start_date                       financial_year_start_date
      ,fyr.fyr_end_date                         financial_year_end_date
      ,DECODE(b.bud_value, -1, 0, b.bud_value)  budget
      ,NVL(b.bud_committed, 0)                  committed
      ,NVL(b.bud_actual, 0)                     actual
      ,(DECODE(b.bud_value, -1, 0, b.bud_value)
         - (b.bud_committed + b.bud_actual))    balance
      ,NVL(b.bud_comment, 'None')               comments
      ,NVL(b.bud_cost_code, 'Not Set')          cost_code
      ,NVL(b.bud_con_cost_code, 'Not Set')      contractor_cost_code
      ,NVL(b.bud_fin_cost_code, 'Not Set')      finance_cost_code
      ,NVL(b.bud_add_cost_code, 'Not Set')      additional_cost_code
  FROM nm_admin_units nau
      ,nm_elements_all ne
      ,financial_years fyr
      ,budgets b
 WHERE b.bud_fyr_id = fyr.fyr_id
   AND b.bud_rse_he_id = ne.ne_id(+)
   AND b.bud_agency = nau.nau_authority_code
  WITH READ ONLY
/

COMMENT ON TABLE imf_mai_budgets IS 'Maintenance Manager foundation view of Budgets, showing details of the Budgets and the Cost of work planned and carried out against them.';

COMMENT ON COLUMN imf_mai_budgets.budget_id IS 'Internal Id of the Budget.';
COMMENT ON COLUMN imf_mai_budgets.network_element_id IS 'The internal Network Element Id of the Road Group associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.network_element_reference IS 'The Network Element Reference of the Road Group associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.network_element_description IS 'The Network Element Description of the Road Group associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.sys_flag IS 'The Sys Flag the Budget applies to (L/D).';
COMMENT ON COLUMN imf_mai_budgets.sys_flag_description IS 'Sys Flag description.';
COMMENT ON COLUMN imf_mai_budgets.admin_unit_agency_code IS 'The Agency Code of the Admin Unit that the Budget is associated with.';
COMMENT ON COLUMN imf_mai_budgets.admin_unit_name IS 'The Name of the Admin Unit that the Budget is associated with.';
COMMENT ON COLUMN imf_mai_budgets.admin_unit_code IS 'The Code of the Admin Unit that the Budget is associated with.';
COMMENT ON COLUMN imf_mai_budgets.job_size IS 'The Job Size associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.work_category IS 'The Work Category associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.work_category_description IS 'The Work Category Description.';
COMMENT ON COLUMN imf_mai_budgets.financial_year IS 'The Financial Year associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.financial_year_start_date IS 'The Start Date of the associated Financial Year.';
COMMENT ON COLUMN imf_mai_budgets.financial_year_end_date IS 'The End Date of the associated Financial Year.';
COMMENT ON COLUMN imf_mai_budgets.budget IS 'The value of the Budget.';
COMMENT ON COLUMN imf_mai_budgets.committed IS 'The Estimated Cost of work Instructed against the Budget but not Completed.';
COMMENT ON COLUMN imf_mai_budgets.actual IS 'The Actual Cost of work Completed against the Budget.';
COMMENT ON COLUMN imf_mai_budgets.balance IS 'The outstanding Balance available to Instruct work against the Budget.';
COMMENT ON COLUMN imf_mai_budgets.comments IS 'Comments related to the Budget.';
COMMENT ON COLUMN imf_mai_budgets.cost_code IS 'The Cost Code associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.contractor_cost_code IS 'The Contractor Cost Code associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.finance_cost_code IS 'The Finance Cost Code associated with the Budget.';
COMMENT ON COLUMN imf_mai_budgets.additional_cost_code IS 'The Additional Cost Code associated with the Budget.';
