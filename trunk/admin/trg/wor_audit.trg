CREATE OR REPLACE TRIGGER wor_audit
AFTER UPDATE OR INSERT
ON work_orders
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/wor_audit.trg-arc   3.1   Jul 01 2013 15:53:20   James.Wadsworth  $
--       Module Name      : $Workfile:   wor_audit.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:53:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  if (inserting) then
     mai_audit.wor_create(:new.wor_works_order_no
                         ,:new.wor_peo_person_id
                         ,:new.wor_mod_by_id);
  else
     mai_audit.wor_audit_setup(:old.wor_works_order_no
                              ,:old.wor_act_cost
                              ,:old.wor_date_confirmed
                              ,:old.wor_act_cost_code
                              ,:old.wor_closed_by_id
                              ,:old.wor_con_id
                              ,:old.wor_est_complete
                              ,:old.wor_est_cost
                              ,:old.wor_last_print_date
                              ,:old.wor_priority
                              ,:old.wor_rse_he_id_group
                              ,:old.wor_score
                              ,:old.wor_peo_person_id
                              ,:old.wor_mod_by_id);

     mai_audit.wor_audit(:new.wor_works_order_no
                        ,:new.wor_act_cost
                        ,:new.wor_date_confirmed
                        ,:new.wor_act_cost_code
                        ,:new.wor_closed_by_id
                        ,:new.wor_con_id
                        ,:new.wor_est_complete
                        ,:new.wor_est_cost
                        ,:new.wor_last_print_date
                        ,:new.wor_priority
                        ,:new.wor_rse_he_id_group
                        ,:new.wor_score
                        ,:new.wor_peo_person_id
                        ,:new.wor_mod_by_id);
   end if;
END;
/
