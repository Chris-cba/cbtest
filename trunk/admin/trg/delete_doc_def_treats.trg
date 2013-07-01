CREATE OR REPLACE TRIGGER delete_doc_def_treats
AFTER DELETE
ON    def_treats
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/delete_doc_def_treats.trg-arc   3.1   Jul 01 2013 15:52:50   James.Wadsworth  $
--       Module Name      : $Workfile:   delete_doc_def_treats.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  delete from doc_def_treats
  where  ddt_dtr_acty_area_code = :old.dtr_dty_acty_area_code
    and  ddt_dtr_defect_code = :old.dtr_dty_defect_code
    and  ddt_dtr_treat_code = :old.dtr_tre_treat_code
    and  ddt_dtr_sys_flag = :old.dtr_sys_flag;
END;
/
