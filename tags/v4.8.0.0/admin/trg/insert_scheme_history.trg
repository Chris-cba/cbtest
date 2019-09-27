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
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/insert_scheme_history.trg-arc   3.3   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   insert_scheme_history.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.3  $
--
--  Inserts a scheme_history record whenever the scheme status changes
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
