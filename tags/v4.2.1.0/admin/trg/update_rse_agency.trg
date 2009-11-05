CREATE OR REPLACE TRIGGER update_rse_agency
BEFORE    INSERT OR UPDATE
OF    schd_agency
ON    schedules
FOR    each row
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/update_rse_agency.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   update_rse_agency.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:11:32  $
--       Version          : $Revision:   3.0  $
--
-- This trigger is a workaround that enables budget reports to work.
-- These reports necessitate an agency code be held against each road
-- group involved in cyclic maintenance, however the Maintain Road
-- Groups module does not allow entry of an agency.
-- This trigger ensures that road group agencies are automatically
-- populated from the agency of a schedule.
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  if :new.schd_agency != :old.schd_agency then
    update road_segs
    set    rse_agency = :new.schd_agency
    where  rse_agency is not null
    and    rse_he_id = :new.schd_rse_he_id;
  end if;
END;
/
