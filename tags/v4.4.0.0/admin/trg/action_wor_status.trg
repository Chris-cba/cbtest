CREATE OR REPLACE TRIGGER action_wor_status
  AFTER UPDATE OF wol_status_code
  ON work_order_lines
  FOR EACH ROW
DECLARE
  -----------------------------------------------------------------------------
  --
  --   PVCS Identifiers :-
  --
  --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/action_wor_status.trg-arc   3.2   Apr 14 2011 09:40:18   Chris.Baugh  $
  --       Module Name      : $Workfile:   action_wor_status.trg  $
  --       Date into PVCS   : $Date:   Apr 14 2011 09:40:18  $
  --       Date fetched Out : $Modtime:   Apr 14 2011 09:33:38  $
  --       Version          : $Revision:   3.2  $
  --
  --
  -----------------------------------------------------------------------------
  --    Copyright (c) exor corporation ltd, 2009
  -----------------------------------------------------------------------------
  --
  CURSOR c_actioned_wol(cp_wol_status_code  work_order_lines.wol_status_code%TYPE)
      IS
  SELECT hsc_allow_feature7
    FROM hig_status_codes
   WHERE hsc_domain_code = 'WORK_ORDER_LINES'
     AND hsc_status_code = cp_wol_status_code
     AND SYSDATE BETWEEN NVL(hsc_start_date, SYSDATE)
                     AND NVL(hsc_end_date, SYSDATE);
                     
  CURSOR c_status_code(cp_feature6   hig_status_codes.hsc_allow_feature6%TYPE)
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'COMPLAINTS'
     AND hsc_allow_feature5 = 'Y'
     AND hsc_allow_feature6 = cp_feature6
     AND SYSDATE BETWEEN NVL(hsc_start_date, SYSDATE)
                     AND NVL(hsc_end_date, SYSDATE);  

  --
  lv_feature7   hig_status_codes.hsc_allow_feature7%TYPE;
  lv_status     hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  IF :new.wol_status_code IS NOT NULL
   THEN
      -- Check if WOL has been actioned
      OPEN c_actioned_wol(:new.wol_status_code);
      FETCH c_actioned_wol INTO lv_feature7;
      CLOSE c_actioned_wol;
      
      /*-----------------------
      || If the WO has been actioned need to set status of
      || any associated PEMs, for the Defect on the WO to WA.
      || If the WO is not actioned, need to ensure the PEM status
      || is WI
      -------------------------*/
      OPEN c_status_code(lv_feature7);
      FETCH c_status_code INTO lv_status;
      CLOSE c_status_code;
        
      UPDATE docs
      SET  doc_status_code = lv_status,
           doc_reason      = DECODE(lv_feature7, 'Y','Work Order Actioned : ', 'Work Order Instructed : ')||:new.wol_works_order_no
      WHERE  doc_id IN (SELECT das_doc_id
                        FROM   doc_assocs
                        WHERE  das_rec_id = TO_CHAR(:new.wol_def_defect_id)
                        AND  das_table_name = 'DEFECTS')
      AND  doc_status_code IN (SELECT hsc_status_code
                               FROM   hig_status_codes
                               WHERE  hsc_domain_code = 'COMPLAINTS'
                               AND  hsc_allow_feature5 = 'Y'
                               AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
                                                      AND nvl(hsc_end_date, sysdate));

  END IF;
  
END;
/