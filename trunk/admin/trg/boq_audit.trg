CREATE OR REPLACE TRIGGER boq_audit
AFTER UPDATE OR DELETE OR INSERT
ON boq_items
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/boq_audit.trg-arc   3.1   Jul 01 2013 15:52:50   James.Wadsworth  $
--       Module Name      : $Workfile:   boq_audit.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
