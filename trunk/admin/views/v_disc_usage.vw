CREATE OR REPLACE FORCE VIEW v_disc_usage
   ( v_cng_disc_group,
     v_oun_org_id,
     v_cnr_start_date,
     v_cnr_end_date )
AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_disc_usage.vw-arc   3.1   Jul 01 2013 15:55:28   James.Wadsworth  $
--       Module Name      : $Workfile:   v_disc_usage.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:28  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:20:46  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       oun_cng_disc_group,
       oun_org_id,
       to_date(null),
       to_date(null)
from org_units
where oun_cng_disc_group is not null
/
