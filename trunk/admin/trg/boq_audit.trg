CREATE OR REPLACE TRIGGER boq_audit
AFTER UPDATE OR DELETE OR INSERT
ON boq_items
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/boq_audit.trg-arc   3.2   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   boq_audit.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN

  if (inserting) then

     mai_audit.boq_create(:new.boq_id
                         ,:new.boq_wol_id);

  elsif (deleting) then

     mai_audit.boq_delete(:old.boq_id
                         ,:old.boq_wol_id);

  else
     mai_audit.boq_audit_setup(:old.boq_id
                              ,:old.boq_wol_id
                              ,:old.boq_act_cost
                              ,:old.boq_act_quantity
                              ,:old.boq_act_rate
                              ,:old.boq_est_cost
                              ,:old.boq_est_quantity
                              ,:old.boq_est_rate
                              ,:old.boq_sta_item_code);

     mai_audit.boq_audit(:new.boq_id
                        ,:new.boq_wol_id
                        ,:new.boq_act_cost
                        ,:new.boq_act_quantity
                        ,:new.boq_act_rate
                        ,:new.boq_est_cost
                        ,:new.boq_est_quantity
                        ,:new.boq_est_rate
                        ,:new.boq_sta_item_code);
  end if;

END;
/
