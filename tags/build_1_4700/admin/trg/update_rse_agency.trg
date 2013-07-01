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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/update_rse_agency.trg-arc   3.1   Jul 01 2013 15:53:18   James.Wadsworth  $
--       Module Name      : $Workfile:   update_rse_agency.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:53:18  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
-- This trigger is a workaround that enables budget reports to work.
-- These reports necessitate an agency code be held against each road
-- group involved in cyclic maintenance, however the Maintain Road
-- Groups module does not allow entry of an agency.
-- This trigger ensures that road group agencies are automatically
-- populated from the agency of a schedule.
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
