CREATE OR REPLACE FORCE VIEW inv_on_roads AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/inv_on_roads.vw-arc   3.3   Sep 27 2019 15:36:14   Chris.Baugh  $
--       Module Name      : $Workfile:   inv_on_roads.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:14  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 * 
from road_sections_all
   , inv_items_all
where rse_he_id = iit_rse_he_id
/
