CREATE OR REPLACE TRIGGER delete_doc_def_priorities
AFTER DELETE
ON    defect_priorities
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/delete_doc_def_priorities.trg-arc   3.3   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   delete_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.3  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
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
