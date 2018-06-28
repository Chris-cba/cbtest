CREATE OR REPLACE FORCE VIEW inv_on_roads AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/inv_on_roads.vw-arc   3.2   Jun 28 2018 04:46:50   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   inv_on_roads.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:50  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 * 
from road_sections_all
   , inv_items_all
where rse_he_id = iit_rse_he_id
/
