CREATE OR REPLACE FORCE VIEW imf_mai_repairs
(
   network_element_id,
   defect_id,
   repair_category,
   repair_category_description,
   repair_description,
   repair_superseded,
   treatment_code,
   treatment_description,
   activity_area,
   date_repair_loaded,
   date_repair_due,
   date_repair_completed,
   time_repair_completed_hours,
   time_repair_completed_mins,
   repair_late,
   days_before_repair_due,
   hours_before_repair_due,
   days_completed_before_due,
   hours_completed_before_due )
AS
SELECT 
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_repairs.vw-arc   3.0   Mar 16 2009 16:19:08   drawat  $
--       Module Name      : $Workfile:   imf_mai_repairs.vw  $
--       Date into PVCS   : $Date:   Mar 16 2009 16:19:08  $
--       Date fetched Out : $Modtime:   Mar 16 2009 08:52:54  $
--       Version          : $Revision:   3.0  $
-- Foundation view displaying maintenance repairs
-------------------------------------------------------------------------   
   rep_rse_he_id,
   rep_def_defect_id,
   rep_action_cat,
   DECODE (rep_action_cat,'I', 'Immediate','T', 'Temporary','Permanent'),
   rep_descr,
   rep_superseded_flag,
   rep_tre_treat_code,
   ( SELECT tre_descr
       FROM treatments
      WHERE tre_treat_code = rep_tre_treat_code ) tre_descr,
   rep_atv_acty_area_code,
   rep_created_date,
   rep_date_due,
   rep_date_completed,
   rep_completed_hrs,
   rep_completed_mins,
   DECODE (SIGN (rep_date_due - rep_date_completed), -1, 'Y', 'N') repair_late,
   (TRUNC(rep_date_due) - TRUNC(SYSDATE)) days_before_repair_due,
   ((rep_date_due - SYSDATE)*24) hours_before_repair_due,
   (TRUNC(rep_date_due) - TRUNC(rep_date_completed)) days_completed_before_due,
   ((rep_date_due - rep_date_completed)*24) hours_completed_before_due
FROM repairs
WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_REPAIRS IS 'Maintenance Manager foundation view of all repairs, showing basic repair details and calculated repair due dates.   This view is useful for producing simple repair statistics and reports.';

COMMENT ON COLUMN IMF_MAI_REPAIRS.network_element_id IS 'Internal id for a network element';
COMMENT ON COLUMN IMF_MAI_REPAIRS.defect_id IS 'Internal id for defect';
COMMENT ON COLUMN IMF_MAI_REPAIRS.repair_category IS 'Repair category';
COMMENT ON COLUMN IMF_MAI_REPAIRS.repair_category_description IS 'repair category description';
COMMENT ON COLUMN IMF_MAI_REPAIRS.repair_description IS 'Repair description';
COMMENT ON COLUMN IMF_MAI_REPAIRS.repair_superseded IS 'Flag indicating whether the repair is superseded';
COMMENT ON COLUMN IMF_MAI_REPAIRS.treatment_code IS 'Treatment code';
COMMENT ON COLUMN IMF_MAI_REPAIRS.treatment_description IS 'Treatment description';
COMMENT ON COLUMN IMF_MAI_REPAIRS.activity_area IS 'Activity area';
COMMENT ON COLUMN IMF_MAI_REPAIRS.date_repair_loaded IS 'The date when the repair was loaded';
COMMENT ON COLUMN IMF_MAI_REPAIRS.date_repair_due IS 'The date the repair is due';
COMMENT ON COLUMN IMF_MAI_REPAIRS.date_repair_completed IS 'The date the repair was completed';
COMMENT ON COLUMN IMF_MAI_REPAIRS.time_repair_completed_hours IS 'The hour upon which the repair was completed';
COMMENT ON COLUMN IMF_MAI_REPAIRS.time_repair_completed_mins IS 'The minutes upon which the repair was completed';
COMMENT ON COLUMN IMF_MAI_REPAIRS.repair_late IS 'Indicates whether the repair was late';
COMMENT ON COLUMN IMF_MAI_REPAIRS.days_before_repair_due IS 'The number of days the repair is due by';
COMMENT ON COLUMN IMF_MAI_REPAIRS.hours_before_repair_due IS 'The number of hours the repair is due by';
COMMENT ON COLUMN IMF_MAI_REPAIRS.days_completed_before_due IS 'The number of days the repair was completed before the due date';
COMMENT ON COLUMN IMF_MAI_REPAIRS.hours_completed_before_due IS 'The number of hours the repair was completed before the due date';

