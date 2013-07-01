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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/dummy_contract_update.trg-arc   3.1   Jul 01 2013 15:52:52   James.Wadsworth  $
--       Module Name      : $Workfile:   dummy_contract_update.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
