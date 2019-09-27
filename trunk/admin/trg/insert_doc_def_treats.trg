CREATE OR REPLACE TRIGGER insert_doc_def_treats
AFTER    INSERT
ON    def_treats
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/insert_doc_def_treats.trg-arc   3.3   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   insert_doc_def_treats.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.3  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  if :new.dtr_tre_treat_code is not null then
     insert into doc_def_treats
       ( ddt_dtr_acty_area_code,
         ddt_dtr_defect_code,
         ddt_dtr_treat_code,
         ddt_dtr_sys_flag,
         ddt_doc_compl_type )
     values
       ( :new.dtr_dty_acty_area_code,
         :new.dtr_dty_defect_code,
         :new.dtr_tre_treat_code,
         :new.dtr_sys_flag,
         '' );
  end if;
END;
/
