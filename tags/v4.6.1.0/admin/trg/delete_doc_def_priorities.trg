CREATE OR REPLACE TRIGGER delete_doc_def_priorities
AFTER DELETE
ON    defect_priorities
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/delete_doc_def_priorities.trg-arc   3.1   Jan 07 2013 10:00:20   Chris.Baugh  $
--       Module Name      : $Workfile:   delete_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Jan 07 2013 10:00:20  $
--       Date fetched Out : $Modtime:   Jul 19 2012 13:41:14  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
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
