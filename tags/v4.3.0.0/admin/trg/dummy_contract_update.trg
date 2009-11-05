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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/dummy_contract_update.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   dummy_contract_update.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:10:02  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
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
