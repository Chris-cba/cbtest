CREATE OR REPLACE FORCE VIEW inv_on_roads AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/inv_on_roads.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   inv_on_roads.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:41:56  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
 * 
from road_sections_all
   , inv_items_all
where rse_he_id = iit_rse_he_id
/