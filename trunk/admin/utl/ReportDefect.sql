--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/utl/ReportDefect.sql-arc   1.1   Jul 01 2013 15:54:48   James.Wadsworth  $
--       Module Name      : $Workfile:   ReportDefect.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:54:48  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:03:34  $
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
  lv_should_be_completed  NUMBER := 0;
  lv_should_not_be_completed  NUMBER := 0;
  --
  CURSOR check_defects
      IS
  SELECT def_not_complete.no_of_defects  should_be_complete
        ,def_complete.no_of_defects      should_not_be_complete
    FROM (SELECT count(*) no_of_defects
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
                               AND rep_date_completed IS NULL)) def_not_complete
        ,(SELECT count(*) no_of_defects
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
                           AND rep_date_completed IS NULL)) def_complete
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
          lv_count := lv_count+1;
      END IF;
      --
    END LOOP;
    --
    dbms_output.put_line('Number of Repairs with invalid Date Due is '||lv_count);
    --
  END check_date_due;
  --
BEGIN
  --
  dbms_output.enable(1000000);
  dbms_output.put_line('================================================================================'); 
  dbms_output.put_line ('# Identify Incorrect Defect/Repair data report'); 
  dbms_output.put_line('================================================================================'); 
  --
  OPEN  check_defects;
  FETCH check_defects
   INTO lv_should_be_completed
       ,lv_should_not_be_completed;
  CLOSE check_defects;
  --
  dbms_output.put_line('Number of Defects that should be completed is '||lv_should_be_completed);
  dbms_output.put_line('Number of Defects completed in error is '||lv_should_not_be_completed);
  --
  check_date_due;
  --
  dbms_output.put_line('================================================================================'); 
  dbms_output.put_line ('# Identify Incorrect Defect/Repair data report finished successfully'); 
  dbms_output.put_line('================================================================================'); 
  --
END;
/
SET SERVEROUTPUT OFF
SET TIMING OFF
