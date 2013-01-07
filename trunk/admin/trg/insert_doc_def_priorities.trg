CREATE OR REPLACE TRIGGER insert_doc_def_priorities
AFTER    INSERT
ON    defect_priorities
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/insert_doc_def_priorities.trg-arc   3.1   Jan 07 2013 10:00:34   Chris.Baugh  $
--       Module Name      : $Workfile:   insert_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Jan 07 2013 10:00:34  $
--       Date fetched Out : $Modtime:   Jul 19 2012 12:12:58  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  if :new.dpr_priority is not null then
     insert into doc_def_priorities
       ( ddp_dpr_admin_unit,
	     ddp_dpr_acty_area_code,
         ddp_dpr_priority,
         ddp_dpr_action_cat,
         ddp_doc_compl_cpr_id,
         ddp_dpr_int_code,
         ddp_dpr_use_working_days )
     values
       ( :new.dpr_admin_unit,
         :new.dpr_atv_acty_area_code,
         :new.dpr_priority,
         :new.dpr_action_cat,
         '',
         :new.dpr_int_code,
         :new.dpr_use_working_days );
  end if;
END;
/
