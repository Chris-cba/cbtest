--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/trg/claim_payment_audit_b_ud_trg.trg-arc   2.1   Jul 01 2013 15:52:50   James.Wadsworth  $
--       Module Name      : $Workfile:   claim_payment_audit_b_ud_trg.trg  $
--       Date into SCCS   : $Date:   Jul 01 2013 15:52:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:01:52  $
--       SCCS Version     : $Revision:   2.1  $
--       
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
CREATE OR REPLACE TRIGGER CLAIM_PAYMENT_AUDIT_B_UD_TRG
BEFORE DELETE OR UPDATE
ON CLAIM_PAYMENTS
FOR EACH ROW
BEGIN
  mai_audit.cpa_audit( :OLD.CP_WOC_CLAIM_REF
                     , :OLD.CP_WOC_CON_ID          
                     , :OLD.CP_WOL_ID              
                     , :OLD.CP_STATUS              
                     , :OLD.CP_CLAIM_VALUE         
                     , :OLD.CP_PAYMENT_ID          
                     , :OLD.CP_PAYMENT_VALUE       
                     , :OLD.CP_PAYMENT_DATE        
                     , :OLD.CP_FIS_PAYMENT_REF
                     , :OLD.CP_FYR_ID              
                     , :OLD.CP_INVOICE_NO          
                     );
  if :NEW.CP_STATUS = 'A'
    and :NEW.CP_STATUS != :OLD.CP_STATUS
    then                    
      mai_audit.cp_audit( :OLD.CP_WOL_ID
                        , :NEW.CP_STATUS
                        , :OLD.CP_STATUS
                        );
  end if;
END;
/
