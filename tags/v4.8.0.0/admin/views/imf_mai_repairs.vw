CREATE OR REPLACE FORCE VIEW imf_mai_repairs
  (defect_id
  ,repair_category
  ,repair_category_description
  ,network_element_id
  ,repair_description
  ,treatment_code
  ,treatment_description
  ,activity_code
  ,activity_description
  ,superseded
  ,date_created
  ,date_due
  ,date_completed
  ,time_completed_hours
  ,time_completed_mins
  ,repair_late
  ,days_to_date_due
  ,hours_to_date_due
  ,days_completed_before_due
  ,hours_completed_before_due
  ,boq_percent_uplift_code
  ,boq_percent_uplift_description
  ,wol_percent_uplift_code
  ,wol_percent_uplift_description)
AS
SELECT -------------------------------------------------------------------------
       --   PVCS Identifiers :-
       --
       --       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/imf_mai_repairs.vw-arc   3.6   Sep 27 2019 15:35:58   Chris.Baugh  $
       --       Module Name      : $Workfile:   imf_mai_repairs.vw  $
       --       Date into PVCS   : $Date:   Sep 27 2019 15:35:58  $
       --       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
       --       Version          : $Revision:   3.6  $
       -- Foundation view displaying maintenance repairs
       ------------------------------------------------------------------
       --   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
       ------------------------------------------------------------------
       rep_def_defect_id                               defect_id
      ,rep_action_cat                                  repair_category
      ,(SELECT hco.hco_meaning
          FROM hig_codes hco
         WHERE hco.hco_domain = 'REPAIR_TYPE'
           AND hco.hco_code = rep_action_cat)          repair_category_description
      ,rep_rse_he_id                                   network_element_id
      ,rep_descr                                       repair_description
      ,rep_tre_treat_code                              treatment_code
      ,(SELECT tre_descr
          FROM treatments
         WHERE tre_treat_code = rep_tre_treat_code)    treatment_description
      ,rep_atv_acty_area_code                          activity_code
      ,(SELECT atv_descr
          FROM activities
         WHERE atv_acty_area_code = rep_atv_acty_area_code
           AND atv_dtp_flag = (SELECT def_ity_sys_flag
                                 FROM defects
                                WHERE def_defect_id = rep_def_defect_id)) activity_description
      ,rep_superseded_flag                             superseded
      ,rep_created_date                                date_created
      ,rep_date_due                                    date_due
      ,rep_date_completed                              date_completed
      ,rep_completed_hrs                               time_completed_hours
      ,rep_completed_mins                              time_completed_mins
      ,CASE
         WHEN (rep_date_completed IS NULL AND rep_date_due < sysdate)
          OR (rep_date_completed IS NOT NULL AND rep_date_due < rep_date_completed)
          THEN
              'Y'
          ELSE
              'N'
       END                                             repair_late
      ,TRUNC(rep_date_due) - TRUNC(SYSDATE)            days_to_date_due
      ,(rep_date_due - SYSDATE)*24                     hours_to_date_due
      ,TRUNC(rep_date_due) - TRUNC(rep_date_completed) days_completed_before_due
      ,(rep_date_due - rep_date_completed)*24          hours_completed_before_due
	  ,rep_boq_perc_item_code                          boq_percent_uplift_code
	  ,(SELECT sta_item_name 
	      FROM standard_items 
		 WHERE sta_item_code = rep_boq_perc_item_code) boq_percent_uplift_description
	  ,rep_wol_perc_item_code                          wol_percent_uplift_code
	  ,(SELECT sta_item_name 
	      FROM standard_items 
		 WHERE sta_item_code = rep_wol_perc_item_code) wol_percent_uplift_description
  FROM repairs
  WITH READ ONLY
/

COMMENT ON TABLE imf_mai_repairs IS 'Maintenance Manager foundation view of all Repairs, showing basic Repair details and calculated dates. This view can be used to produce statistical and summary Maintenance Manager reports where Repair details are required.';

COMMENT ON COLUMN imf_mai_repairs.defect_id                       IS 'The internal id of the Defect that the Repair is associated with.';
COMMENT ON COLUMN imf_mai_repairs.repair_category                 IS 'The Repair Action Category.';
COMMENT ON COLUMN imf_mai_repairs.repair_category_description     IS 'The Repair Action Category description.';
COMMENT ON COLUMN imf_mai_repairs.network_element_id              IS 'The internal id of the Network Element that the Repair is associated with.';
COMMENT ON COLUMN imf_mai_repairs.repair_description              IS 'Repair description';
COMMENT ON COLUMN imf_mai_repairs.treatment_code                  IS 'The Treatment Code associated with the Repair.';
COMMENT ON COLUMN imf_mai_repairs.treatment_description           IS 'The Treatment description.';
COMMENT ON COLUMN imf_mai_repairs.activity_code                   IS 'The Activity Code associated with the Repair.';
COMMENT ON COLUMN imf_mai_repairs.activity_description            IS 'The Activity description.';
COMMENT ON COLUMN imf_mai_repairs.superseded                      IS 'Flag indicating whether the Repair has been superseded. (Y/N)';
COMMENT ON COLUMN imf_mai_repairs.date_created                    IS 'The date the Repair was created within the system.';
COMMENT ON COLUMN imf_mai_repairs.date_due                        IS 'The date the Repair is due to by completed by.';
COMMENT ON COLUMN imf_mai_repairs.date_completed                  IS 'The date the Repair was completed.';
COMMENT ON COLUMN imf_mai_repairs.time_completed_hours            IS 'The hour upon which the repair was completed.';
COMMENT ON COLUMN imf_mai_repairs.time_completed_mins             IS 'The minute upon which the repair was completed.';
COMMENT ON COLUMN imf_mai_repairs.repair_late                     IS 'Indicates whether the repair was late. (Y/N)';
COMMENT ON COLUMN imf_mai_repairs.days_to_date_due                IS 'The number of days until the Repair Date Due.';
COMMENT ON COLUMN imf_mai_repairs.hours_to_date_due               IS 'The number of hours until the Repair Date Due.';
COMMENT ON COLUMN imf_mai_repairs.days_completed_before_due       IS 'The number of days prior to the Due Date that the repair was completed. (A negative value indicates the number of days late)';
COMMENT ON COLUMN imf_mai_repairs.hours_completed_before_due      IS 'The number of hours prior to the Due Date that the repair was completed. (A negative value indicates the number of hours late)';
COMMENT ON COLUMN imf_mai_repairs.boq_percent_uplift_code         IS 'The BOQ percent uplift Standard Item Code associated with the Repair';
COMMENT ON COLUMN imf_mai_repairs.boq_percent_uplift_description  IS 'The BOQ percent uplift description';
COMMENT ON COLUMN imf_mai_repairs.wol_percent_uplift_code         IS 'The Work Order Line percent uplift Standard Item Code associated with the Repair';
COMMENT ON COLUMN imf_mai_repairs.wol_percent_uplift_description  IS 'The Work Order Line percent uplift description';

