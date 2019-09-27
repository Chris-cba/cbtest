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
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_disc_usage.vw-arc   3.3   Sep 27 2019 15:36:18   Chris.Baugh  $
--       Module Name      : $Workfile:   v_disc_usage.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:18  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       oun_cng_disc_group,
       oun_org_id,
       to_date(null),
       to_date(null)
from org_units
where oun_cng_disc_group is not null
/
