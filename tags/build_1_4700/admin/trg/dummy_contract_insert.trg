CREATE OR REPLACE TRIGGER dummy_contract_insert
AFTER     INSERT
ON    standard_items
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/dummy_contract_insert.trg-arc   3.1   Jul 01 2013 15:52:52   James.Wadsworth  $
--       Module Name      : $Workfile:   dummy_contract_insert.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
