CREATE OR REPLACE TRIGGER wol_audit
AFTER UPDATE OR DELETE OR INSERT
ON work_order_lines
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/wol_audit.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   wol_audit.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:13:20  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
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
