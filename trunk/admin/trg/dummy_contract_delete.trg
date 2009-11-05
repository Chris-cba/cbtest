CREATE OR REPLACE TRIGGER dummy_contract_delete
AFTER     DELETE
ON    standard_items
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/dummy_contract_delete.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   dummy_contract_delete.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:09:42  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
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
