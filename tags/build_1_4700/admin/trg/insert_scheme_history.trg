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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/insert_scheme_history.trg-arc   3.1   Jul 01 2013 15:52:52   James.Wadsworth  $
--       Module Name      : $Workfile:   insert_scheme_history.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--  Inserts a scheme_history record whenever the scheme status changes
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
