CREATE OR REPLACE TRIGGER dummy_contract_delete
AFTER     DELETE
ON    standard_items
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/dummy_contract_delete.trg-arc   3.2   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   dummy_contract_delete.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  delete
  from   contract_items
  where  cni_con_id = (
     select max(con_id)
     from   contracts
         where  con_code = (select hop_value
                    from   hig_options
                    where  hop_id = 'DUMCONCODE'))
  and    cni_sta_item_code = :old.sta_item_code;
END;
/
