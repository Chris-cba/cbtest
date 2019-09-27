CREATE OR REPLACE TRIGGER action_wor_status
  AFTER UPDATE OF wol_status_code
  ON work_order_lines
  FOR EACH ROW
DECLARE
  -----------------------------------------------------------------------------
  --
  --   PVCS Identifiers :-
  --
  --       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/action_wor_status.trg-arc   3.6   Sep 27 2019 15:17:40   Chris.Baugh  $
  --       Module Name      : $Workfile:   action_wor_status.trg  $
  --       Date into PVCS   : $Date:   Sep 27 2019 15:17:40  $
  --       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
  --       Version          : $Revision:   3.6  $
  --
  --
  ------------------------------------------------------------------
  --   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
  ------------------------------------------------------------------
  --
  CURSOR c_actioned_wol(cp_wol_status_code  work_order_lines.wol_status_code%TYPE)
      IS
  SELECT hsc_allow_feature1,
         hsc_allow_feature7,
		 hsc_allow_feature10
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
  lv_feature1   hig_status_codes.hsc_allow_feature1%TYPE;
  lv_feature7   hig_status_codes.hsc_allow_feature7%TYPE;
  lv_feature10  hig_status_codes.hsc_allow_feature10%TYPE;
  lv_status     hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  IF :new.wol_status_code IS NOT NULL
   THEN
      -- Check if WOL has been actioned
      OPEN c_actioned_wol(:new.wol_status_code);
      FETCH c_actioned_wol INTO lv_feature1,
	                            lv_feature7,
								lv_feature10;
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
        
	  IF lv_feature7 = 'Y' -- WO Actioned
		THEN 		  

		UPDATE docs
		  SET  doc_status_code = lv_status,
			   doc_reason      = 'Work Order Actioned : '||:new.wol_works_order_no
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
	  ELSIF lv_feature1 = 'Y' AND -- WO Instructed
	        lv_feature10 = 'N'
		THEN
		
		  UPDATE docs 
		  SET  doc_status_code = lv_status,
			   doc_reason      = 'Work Order Instructed : '||:new.wol_works_order_no
		  WHERE  doc_id IN (SELECT das_doc_id
							FROM   doc_assocs
							WHERE  das_rec_id = TO_CHAR(:new.wol_def_defect_id)
							AND  das_table_name = 'DEFECTS')
		  AND  doc_status_code IN (SELECT hsc_status_code
								   FROM   hig_status_codes
								   WHERE  hsc_domain_code = 'COMPLAINTS'
								   AND hsc_allow_feature5 = 'N' -- only update if status not 'WA'
								   AND hsc_allow_feature6 = 'Y'
								   AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
														  AND nvl(hsc_end_date, sysdate));
	  END IF;

  END IF;
  
END;
/
