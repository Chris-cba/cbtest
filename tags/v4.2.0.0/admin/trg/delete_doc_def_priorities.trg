CREATE OR REPLACE TRIGGER delete_doc_def_priorities
AFTER DELETE
ON    defect_priorities
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/delete_doc_def_priorities.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   delete_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:14:24  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  delete from doc_def_priorities
  where  ddp_dpr_acty_area_code   = :old.dpr_atv_acty_area_code
    and  ddp_dpr_priority         = :old.dpr_priority
    and  ddp_dpr_action_cat       = :old.dpr_action_cat
    and  ddp_dpr_int_code         = :old.dpr_int_code
    and  ddp_dpr_use_working_days = :old.dpr_use_working_days;
END;
/
