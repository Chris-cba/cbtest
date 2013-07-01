CREATE OR REPLACE TRIGGER insert_doc_def_treats
AFTER    INSERT
ON    def_treats
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/insert_doc_def_treats.trg-arc   3.1   Jul 01 2013 15:52:52   James.Wadsworth  $
--       Module Name      : $Workfile:   insert_doc_def_treats.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
