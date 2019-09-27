CREATE OR REPLACE TRIGGER insert_doc_def_priorities
AFTER    INSERT
ON    defect_priorities
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/insert_doc_def_priorities.trg-arc   3.4   Sep 27 2019 15:18:06   Chris.Baugh  $
--       Module Name      : $Workfile:   insert_doc_def_priorities.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:06  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.4  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
