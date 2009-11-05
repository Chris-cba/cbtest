CREATE OR REPLACE TRIGGER delete_doc_def_treats
AFTER DELETE
ON    def_treats
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/delete_doc_def_treats.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   delete_doc_def_treats.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:13:52  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  delete from doc_def_treats
  where  ddt_dtr_acty_area_code = :old.dtr_dty_acty_area_code
    and  ddt_dtr_defect_code = :old.dtr_dty_defect_code
    and  ddt_dtr_treat_code = :old.dtr_tre_treat_code
    and  ddt_dtr_sys_flag = :old.dtr_sys_flag;
END;
/
