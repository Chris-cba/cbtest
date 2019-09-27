CREATE OR REPLACE TRIGGER delete_doc_def_priorities
AFTER DELETE
ON    defect_priorities
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/delete_doc_def_priorities.trg-arc   3.4   Sep 27 2019 15:18:06   Chris.Baugh  $
--       Module Name      : $Workfile:   delete_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:06  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.4  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  delete from doc_def_priorities
  where  ddp_dpr_admin_unit = :old.dpr_admin_unit
    and  ddp_dpr_acty_area_code   = :old.dpr_atv_acty_area_code
    and  ddp_dpr_priority         = :old.dpr_priority
    and  ddp_dpr_action_cat       = :old.dpr_action_cat
    and  ddp_dpr_int_code         = :old.dpr_int_code
    and  ddp_dpr_use_working_days = :old.dpr_use_working_days;
END;
/
