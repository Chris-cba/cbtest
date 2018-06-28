CREATE OR REPLACE TRIGGER dummy_contract_update
AFTER   UPDATE
OF      sta_rate, sta_item_code
ON      standard_items
FOR     EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/dummy_contract_update.trg-arc   3.2   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   dummy_contract_update.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  if :new.sta_rate != :old.sta_rate or
     :new.sta_item_code != :old.sta_item_code then
    update contract_items
    set    cni_rate = :new.sta_rate
      ,cni_sta_item_code = :new.sta_item_code
    where  cni_sta_item_code = :old.sta_item_code
    and    cni_con_id = (
       select max(con_id)
       from   contracts
       where  con_code = (
              select hop_id
              from   hig_options
                  where  hop_id = 'DUMCONCODE'));
  end if;
END;
/
