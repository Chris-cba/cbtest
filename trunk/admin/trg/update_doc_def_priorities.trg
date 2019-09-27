CREATE OR REPLACE TRIGGER update_doc_def_priorities
AFTER    UPDATE
OF    dpr_int_code, dpr_use_working_days
ON    defect_priorities
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/update_doc_def_priorities.trg-arc   3.4   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   update_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:02  $
--       Version          : $Revision:   3.4  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  if :new.dpr_int_code != :old.dpr_int_code or
     :new.dpr_use_working_days != :old.dpr_use_working_days then
      update doc_def_priorities
      set    ddp_dpr_int_code = :new.dpr_int_code,
             ddp_dpr_use_working_days = :new.dpr_use_working_days
      where  ddp_dpr_acty_area_code = :new.dpr_atv_acty_area_code
        and  ddp_dpr_priority       = :new.dpr_priority
        and  ddp_dpr_action_cat     = :new.dpr_action_cat
        and ddp_dpr_admin_unit = :new.dpr_admin_unit;
  end if;
END;
/
