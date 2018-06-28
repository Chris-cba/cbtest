CREATE OR REPLACE TRIGGER delete_doc_def_treats
AFTER DELETE
ON    def_treats
FOR   EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/delete_doc_def_treats.trg-arc   3.2   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   delete_doc_def_treats.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  delete from doc_def_treats
  where  ddt_dtr_acty_area_code = :old.dtr_dty_acty_area_code
    and  ddt_dtr_defect_code = :old.dtr_dty_defect_code
    and  ddt_dtr_treat_code = :old.dtr_tre_treat_code
    and  ddt_dtr_sys_flag = :old.dtr_sys_flag;
END;
/
