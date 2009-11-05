CREATE OR REPLACE TRIGGER insert_doc_def_priorities
AFTER    INSERT
ON    defect_priorities
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/insert_doc_def_priorities.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   insert_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:15:02  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  if :new.dpr_priority is not null then
     insert into doc_def_priorities
       ( ddp_dpr_acty_area_code,
         ddp_dpr_priority,
         ddp_dpr_action_cat,
         ddp_doc_compl_cpr_id,
         ddp_dpr_int_code,
         ddp_dpr_use_working_days )
     values
       ( :new.dpr_atv_acty_area_code,
         :new.dpr_priority,
         :new.dpr_action_cat,
         '',
         :new.dpr_int_code,
         :new.dpr_use_working_days );
  end if;
END;
/
