CREATE OR REPLACE TRIGGER delete_doc_def_priorities
AFTER DELETE
ON    defect_priorities
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/delete_doc_def_priorities.trg-arc   3.2   Jul 01 2013 15:52:50   James.Wadsworth  $
--       Module Name      : $Workfile:   delete_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
