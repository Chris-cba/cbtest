CREATE OR REPLACE TRIGGER dummy_contract_insert
AFTER     INSERT
ON    standard_items
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/dummy_contract_insert.trg-arc   3.2   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   dummy_contract_insert.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  if :new.sta_rate is not null then
    insert into contract_items
    (      cni_con_id
      ,cni_sta_item_code
      ,cni_rate
    )
    select con_id
      ,:new.sta_item_code
      ,:new.sta_rate
    from   contracts
    where  con_code = (select hop_value
               from   hig_options
               where  hop_id = 'DUMCONCODE');
  end if;
END;
/
