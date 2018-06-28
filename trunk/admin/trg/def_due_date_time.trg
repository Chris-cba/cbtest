CREATE OR REPLACE TRIGGER def_due_date_time
AFTER INSERT OR UPDATE
OF def_priority
  ,def_time_hrs
  ,def_time_mins
ON DEFECTS
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/def_due_date_time.trg-arc   3.2   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   def_due_date_time.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

  --
  TYPE rep_rec IS RECORD(are_date_work_done activities_report.are_date_work_done%TYPE
                        ,are_rse_he_id      activities_report.are_rse_he_id%TYPE
                        ,rep_action_cat     repairs.rep_action_cat%TYPE);
  TYPE rep_tab IS TABLE OF rep_rec;
  lt_rep rep_tab;
  --
  lv_def_date   date;
  lv_action_cat repairs.rep_action_cat%TYPE;
  lv_err        number;
  lv_outdate    date;
  --
  PROCEDURE get_repairs
    IS
  BEGIN
    --
    SELECT are_date_work_done
          ,are_rse_he_id
          ,rep_action_cat
      BULK COLLECT
      INTO lt_rep
      FROM activities_report
          ,repairs
     WHERE are_report_id     = :new.def_are_report_id
       AND rep_def_defect_id = :new.def_defect_id
         ;
   --
  EXCEPTION
    WHEN no_data_found
     THEN
        NULL;
    WHEN others
     THEN
        RAISE;
  END;
  --
BEGIN
  /*
  ||Get Details Of Any Associated Repairs.
  */
  get_repairs;
  /*
  ||Recalculate The Date Due For Associated Repairs.
  */
  FOR i IN 1..lt_rep.count LOOP
    /*
    ||Calculate The Due Date.
    */
    IF ((hig.get_sysopt('REPSETPERD') = 'Y' AND :new.def_ity_sys_flag = 'D')
        OR (hig.get_sysopt('REPSETPERL') = 'Y' AND :new.def_ity_sys_flag = 'L'))
     AND (lt_rep(i).rep_action_cat = 'P' AND :new.def_priority = '1')
     AND lt_rep.count = 1
     THEN
        /*
        ||The Defect Only Has A Permanent Repair
        ||So Use The Temporary Interval To Calculate
        ||The Due Date.
        */
        lv_action_cat := 'T';
        --
    ELSE
        lv_action_cat := lt_rep(i).rep_action_cat;
    END IF;
    --
    lv_def_date := TO_DATE(TO_CHAR(TRUNC(lt_rep(i).are_date_work_done),'DD-MON-RRRR')
                           ||ltrim(to_char(:new.def_time_hrs,'09'))
                           ||ltrim(to_char(:new.def_time_mins,'09'))
                          ,'DD-MON-RRRRHH24MI');
    --
    mai.rep_date_due(p_date               => lv_def_date
                    ,p_atv_acty_area_code => :new.def_atv_acty_area_code
                    ,p_dpr_priority       => :new.def_priority
                    ,p_dpr_action_cat     => lv_action_cat
                    ,p_heid               => lt_rep(i).are_rse_he_id
                    ,p_out_date           => lv_outdate
                    ,p_error              => lv_err);
    /*
    ||Update The Repair.
    */
    UPDATE repairs
       SET rep_date_due      = lv_outdate
     WHERE rep_def_defect_id = :new.def_defect_id
       AND rep_action_cat    = lt_rep(i).rep_action_cat
         ;
    --
  END LOOP;
  --
END;
/
