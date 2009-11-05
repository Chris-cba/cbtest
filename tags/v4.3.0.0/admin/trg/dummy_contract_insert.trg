CREATE OR REPLACE TRIGGER dummy_contract_insert
AFTER     INSERT
ON    standard_items
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/dummy_contract_insert.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   dummy_contract_insert.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:09:22  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
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
