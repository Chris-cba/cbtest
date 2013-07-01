/*
||Work Order Status View.
*/
CREATE OR REPLACE FORCE VIEW v_work_order_status
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_work_order_status.vw-arc   3.5   Jul 01 2013 15:55:48   James.Wadsworth  $
--       Module Name      : $Workfile:   v_work_order_status.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:48  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:26:08  $
--       Version          : $Revision:   3.5  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       wor.wor_works_order_no wor_works_order_no
      ,NVL(wos.wor_status,(SELECT hsc_status_code --DRAFT
                             FROM hig_status_codes
                            WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                              AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                     AND NVL(hsc_end_date,TRUNC(SYSDATE))
                              AND hsc_allow_feature1 = 'Y'
                              AND hsc_allow_feature10 = 'Y'
                              AND rownum = 1)) wor_status
  FROM work_orders wor
      ,(SELECT wol_works_order_no
              ,CASE WHEN (paid + not_done) = wols
                     AND paid >0                   THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature4 = 'Y'
                                                                 AND hsc_allow_feature9 != 'Y'
                                                                 AND rownum = 1) -- PAID 
                    WHEN paid > 0
                      OR part_paid > 0                  THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature4 = 'Y'
                                                                 AND hsc_allow_feature9 = 'Y'
                                                                 AND rownum = 1) --PART PAID 
                    WHEN (completed + not_done) = wols
                     AND completed > 0                  THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature3 = 'Y'
                                                                 AND rownum = 1) --COMPLETED 
                    WHEN completed > 0                  
                      OR part_complete > 0              THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature6 = 'Y'
                                                                 AND rownum = 1)  --PART COMPL 
                    WHEN (instructed + not_done) = wols
                     AND instructed >0                  THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature1 = 'Y'
                                                                 AND hsc_allow_feature10 != 'Y'
                                                                 AND rownum = 1) --INSTRUCTED 
                    WHEN draft = wols
                      OR wols = 0                       THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature1 = 'Y'
                                                                 AND hsc_allow_feature10 = 'Y'
                                                                 AND rownum = 1) --DRAFT 
                    WHEN not_done = wols                THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature5 = 'Y'
                                                                 AND rownum = 1) --NOT DONE
                    WHEN actioned > 0                   THEN (SELECT hsc_status_code
                                                                FROM hig_status_codes
                                                               WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                                                                 AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                                                                                        AND NVL(hsc_end_date,TRUNC(SYSDATE))
                                                                 AND hsc_allow_feature7 = 'Y'
                                                                 AND rownum = 1) --ACTIONED 
                    ELSE 'UNDEFINED'
               END wor_status
          FROM (SELECT wol_works_order_no
                      ,COUNT(wol_id) wols
                      ,SUM(DECODE(hsc_allow_feature10, 'Y', 1, 0)) draft
                      ,SUM(DECODE(hsc_allow_feature1,  'Y', DECODE(hsc_allow_feature10, 'Y', 0, 1), 0)) instructed
                      ,SUM(DECODE(hsc_allow_feature2,  'Y', 1, 0)) + SUM(DECODE(hsc_allow_feature3, 'Y', 1, 0)) completed
                      ,SUM(DECODE(hsc_allow_feature4,  'Y', DECODE(hsc_allow_feature9, 'Y', 0, 1), 0)) paid
                      ,SUM(DECODE(hsc_allow_feature4,  'Y', DECODE(hsc_allow_feature9, 'Y', 1, 0), 0)) part_paid
                      ,SUM(DECODE(hsc_allow_feature5,  'Y', 1, 0)) not_done
                      ,SUM(DECODE(hsc_allow_feature8,  'Y', 1, 0)) + SUM(DECODE(hsc_allow_feature9, 'Y', 1,0)) + SUM(DECODE(hsc_allow_feature6, 'Y', 1,0)) part_complete
                      ,SUM(DECODE(hsc_allow_feature7,  'Y', 1, 0)) actioned
                  FROM work_order_lines
                      ,hig_status_codes
                 WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                   AND hsc_status_code = wol_status_code 
                 GROUP
                    BY wol_works_order_no)) wos
WHERE wos.wol_works_order_no(+) = wor.wor_works_order_no
    ;
