CREATE OR REPLACE TRIGGER wol_audit
AFTER UPDATE OR DELETE OR INSERT
ON work_order_lines
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/wol_audit.trg-arc   3.3   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   wol_audit.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:02  $
--       Version          : $Revision:   3.3  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  if (inserting) then
     mai_audit.wol_create(:new.wol_works_order_no
                         ,:new.wol_id);

  elsif (deleting) then
     mai_audit.wol_delete(:old.wol_works_order_no
                         ,:old.wol_id);

  else
     mai_audit.wol_audit_setup(:old.wol_works_order_no
                              ,:old.wol_id
                              ,:old.wol_date_complete
                              ,:old.wol_est_cost
                              ,:old.wol_act_cost
                              ,:old.wol_rse_he_id
                              ,:old.wol_status_code
                              ,:old.wol_gang);

     mai_audit.wol_audit(:new.wol_works_order_no
                        ,:new.wol_id
                        ,:new.wol_date_complete
                        ,:new.wol_est_cost
                        ,:new.wol_act_cost
                        ,:new.wol_rse_he_id
                        ,:new.wol_status_code
                        ,:new.wol_gang);
  end if;

END;
/
