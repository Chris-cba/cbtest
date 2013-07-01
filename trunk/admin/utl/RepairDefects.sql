--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/utl/RepairDefects.sql-arc   1.1   Jul 01 2013 15:54:48   James.Wadsworth  $
--       Module Name      : $Workfile:   RepairDefects.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:54:48  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:03:24  $
--       PVCS Version     : $Revision:   1.1  $
--
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
SET SERVEROUTPUT ON
SET TIMING ON
DECLARE
  --
  lv_comp_count        NUMBER := 0;
  lv_uncomp_count      NUMBER := 0;
  lv_completed_status  hig_status_codes.hsc_status_code%TYPE;
  lv_initial_status  hig_status_codes.hsc_status_code%TYPE;
  --
  CURSOR get_def_to_complete
      IS
  SELECT def_defect_id
    FROM defects
        ,activities_report
   WHERE (are_insp_load_date IS NOT NULL
          AND are_insp_load_date >= (SELECT TRUNC(date_upgraded)
                                       FROM hig_upgrades
                                      WHERE hup_product = 'MAI'
                                        AND to_version = '4.3.0.0'))
     AND are_report_id = def_are_report_id
     AND def_date_compl IS NULL
     AND def_status_code NOT IN(SELECT hsc_status_code
                                  FROM hig_status_codes
                                 WHERE hsc_domain_code = 'DEFECTS'
                                   AND hsc_allow_feature4 = 'Y')
     AND NOT EXISTS(SELECT 1
                      FROM repairs
                     WHERE rep_def_defect_id = def_defect_id
                       AND rep_date_completed IS NULL)
    ;
  --
  CURSOR get_def_to_uncomplete
      IS
  SELECT def_defect_id
    FROM defects
        ,activities_report
   WHERE (are_insp_load_date IS NOT NULL
          AND are_insp_load_date >= (SELECT TRUNC(date_upgraded)
                                       FROM hig_upgrades
                                      WHERE hup_product = 'MAI'
                                        AND to_version = '4.3.0.0'))
     AND are_report_id = def_are_report_id
     AND def_date_compl IS NOT NULL
     AND def_status_code IN(SELECT hsc_status_code
                              FROM hig_status_codes
                             WHERE hsc_domain_code = 'DEFECTS'
                               AND hsc_allow_feature4 = 'Y')
     AND def_inspection_date >= (SELECT TRUNC(date_upgraded)
                                   FROM hig_upgrades
                                  WHERE hup_product = 'MAI'
                                    AND to_version = '4.3.0.0')
     AND EXISTS(SELECT 1
                  FROM repairs
                 WHERE rep_def_defect_id = def_defect_id
                   AND rep_date_completed IS NULL)
       ;
  --
  CURSOR get_completed_status
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'DEFECTS'
     AND hsc_allow_feature4 = 'Y'
     AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                            AND NVL(hsc_end_date,TRUNC(SYSDATE))
   ORDER
      BY hsc_seq_no DESC
       ;
  --
  CURSOR get_initial_status
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'DEFECTS'
     AND hsc_allow_feature1 = 'Y'
     AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                            AND NVL(hsc_end_date,TRUNC(SYSDATE))
   ORDER
      BY hsc_seq_no DESC
       ;
  --
  PROCEDURE check_date_due IS
    --
    lv_calc_date_due  DATE;
    lv_count          PLS_INTEGER := 0;
    lv_dummy          NUMBER;
    lv_action_cat     repairs.rep_action_cat%TYPE;
    lv_repsetperd     hig_options.hop_value%TYPE := hig.GET_SYSOPT('REPSETPERD');
    lv_repsetperl     hig_options.hop_value%TYPE := hig.GET_SYSOPT('REPSETPERL');
    --
    CURSOR get_repairs
        IS
    SELECT rep_def_defect_id
          ,rep_action_cat
          ,rep_date_due
          ,rep_atv_acty_area_code
          ,rep_rse_he_id
          ,def_priority
          ,are_date_work_done
          ,(SELECT count(*)
              FROM repairs r2
             WHERE r2.rep_def_defect_id = def_defect_id) rep_count
          ,(SELECT rse_sys_flag
              FROM road_segs
             WHERE rse_he_id = rep_rse_he_id) sys_flag 
      FROM repairs
          ,defects
          ,activities_report
     WHERE (are_insp_load_date IS NOT NULL
            AND are_insp_load_date >= (SELECT TRUNC(date_upgraded)
                                         FROM hig_upgrades
                                        WHERE hup_product = 'MAI'
                                          AND to_version = '4.3.0.0'))
       AND are_report_id = def_are_report_id
       AND def_defect_id = rep_def_defect_id
     ORDER
        BY rep_def_defect_id
          ,rep_action_cat
         ;
    --
  BEGIN
    --
    FOR rep_rec IN get_repairs LOOP
      /*
      ||Calculate Date Due.
      */
      IF((rep_rec.sys_flag = 'D' and lv_repsetperd = 'Y')
         OR(rep_rec.sys_flag = 'L' and lv_repsetperl = 'Y'))
        AND rep_rec.rep_action_cat = 'P'
        AND rep_rec.def_priority = '1'
        AND rep_rec.rep_count = 1  -- ie. No Other Repairs on Defect.
       THEN
          lv_action_cat := 'T';
      ELSE
          lv_action_cat := rep_rec.rep_action_cat;
      END IF;
      --
      mai.rep_date_due(rep_rec.are_date_work_done
                      ,rep_rec.rep_atv_acty_area_code
                      ,rep_rec.def_priority
                      ,lv_action_cat
                      ,rep_rec.rep_rse_he_id
                      ,lv_calc_date_due
                      ,lv_dummy);
      --
      --dbms_output.put_line('Defect Id = '||rep_rec.rep_def_defect_id
      --                   ||' Action Cat = '||rep_rec.rep_action_cat
      --                   ||' Inspection Date '||TO_CHAR(rep_rec.are_date_work_done,'DD-MON-YYYY HH24:MI')
      --                   ||' Current Due Date = '||TO_CHAR(rep_rec.rep_date_due,'DD-MON-YYYY HH24:MI')
      --                   ||' Calc Due Date = '||TO_CHAR(lv_calc_date_due,'DD-MON-YYYY HH24:MI')
      --                   ||CASE WHEN lv_calc_date_due != rep_rec.rep_date_due THEN ' : Update Required' ELSE NULL END);
      IF lv_calc_date_due != rep_rec.rep_date_due
       THEN
          UPDATE repairs
             SET rep_date_due = lv_calc_date_due
           WHERE rep_def_defect_id = rep_rec.rep_def_defect_id
             AND rep_action_cat = rep_rec.rep_action_cat
               ;
          lv_count := lv_count+1;
      END IF;
      --
    END LOOP;
    --
    dbms_output.put_line('# Number of Repair Due Dates recalculated: '||lv_count);
    --
  END check_date_due;
  --
BEGIN
  --
  dbms_output.enable(1000000);
  dbms_output.put_line('================================================================================'); 
  dbms_output.put_line('# Correcting Defect/Repair data'); 
  dbms_output.put_line('================================================================================'); 
  --
  OPEN  get_completed_status;
  FETCH get_completed_status
   INTO lv_completed_status;
  CLOSE get_completed_status;
  --
  dbms_output.put_line('#');
  dbms_output.put_line('# Checking for Defects that should be completed...'); 
  --
  FOR comp_rec IN get_def_to_complete LOOP
    --
    UPDATE defects
       SET def_date_compl = (SELECT MAX(rep_date_completed)
                               FROM repairs
                              WHERE rep_def_defect_id = def_defect_id)
          ,def_status_code = lv_completed_status
          ,def_superseded_flag = 'N'
          ,def_superseded_id = NULL
     WHERE def_defect_id = comp_rec.def_defect_id
         ;
    --
    UPDATE repairs
       SET rep_superseded_flag = 'N'
     WHERE rep_def_defect_id = comp_rec.def_defect_id
         ;
    --
    lv_comp_count := lv_comp_count + 1;
    --
  END LOOP;
  --
  dbms_output.put_line('# Number of Defects completed: '||lv_comp_count); 
  --
  OPEN  get_initial_status;
  FETCH get_initial_status
   INTO lv_initial_status;
  CLOSE get_initial_status;
  --
  dbms_output.put_line('#');
  dbms_output.put_line('# Checking for Defects that should be uncompleted...'); 
  --
  FOR uncomp_rec IN get_def_to_uncomplete LOOP
    --
    UPDATE defects
       SET def_date_compl = NULL
          ,def_status_code = lv_initial_status
     WHERE def_defect_id = uncomp_rec.def_defect_id
         ;
    --
    lv_uncomp_count := lv_uncomp_count + 1;
    --
  END LOOP;
  dbms_output.put_line('# Number of Defects uncompleted: '||lv_uncomp_count); 
  dbms_output.put_line('#');
  --
  dbms_output.put_line('# Checking for Repair Due Dates that should be recalculated...'); 
  check_date_due;  
  dbms_output.put_line('#');
  --
  dbms_output.put_line('================================================================================'); 
  dbms_output.put_line('# Correcting Defect/Repair data finished successfully'||CASE WHEN (lv_uncomp_count+lv_comp_count) > 0 THEN ' : Please issue a COMMIT' ELSE NULL END);
  dbms_output.put_line('================================================================================'); 
  --
END;
/
SET SERVEROUTPUT OFF
SET TIMING OFF
