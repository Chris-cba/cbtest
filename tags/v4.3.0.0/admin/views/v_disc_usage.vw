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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_disc_usage.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v_disc_usage.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:33:12  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       oun_cng_disc_group,
       oun_org_id,
       to_date(null),
       to_date(null)
from org_units
where oun_cng_disc_group is not null
/