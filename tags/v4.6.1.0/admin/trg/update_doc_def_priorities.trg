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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/update_doc_def_priorities.trg-arc   3.1   Jan 07 2013 10:00:48   Chris.Baugh  $
--       Module Name      : $Workfile:   update_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Jan 07 2013 10:00:48  $
--       Date fetched Out : $Modtime:   Jul 19 2012 13:43:08  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
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
