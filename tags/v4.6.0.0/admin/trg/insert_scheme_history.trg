CREATE OR REPLACE TRIGGER insert_scheme_history
BEFORE    INSERT OR UPDATE
OF    status_code
ON    schemes
FOR    EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/insert_scheme_history.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   insert_scheme_history.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:08:58  $
--       Version          : $Revision:   3.0  $
--
--  Inserts a scheme_history record whenever the scheme status changes
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  if :old.status_code is null or :new.status_code != :old.status_code
  then
    insert into scheme_history
                values (
                       :new.scheme_id,
                        sysdate,
                       :new.status_code,
                        user,
                       :new.reason);
  end if;
END;
/
