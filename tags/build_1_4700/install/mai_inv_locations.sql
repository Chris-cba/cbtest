-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_inv_locations.sql-arc   2.1   Jul 01 2013 16:02:10   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_inv_locations.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:10  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
--
--   Author : A Edwards
--
-----------------------------------------------------------------------------
--
--   mai_inv_locations - 
--       allows users to view Inventory against a different
--       network level than datums. Change the Group type 
--       to match the type you wish to locate against.
--
--       Currently, this is set to 'SECT' to match the standard
--       UK group type for road sections (one level up from datums)
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
-- NM2_INV_LOCATIONS_PLA view
-----------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW nm2_inv_locations_pla ( iit_ne_id
                                                   , nm2_pla
                                                   ) AS
   SELECT 
   --------------------------------------------------------------------------
   --
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_inv_locations.sql-arc   2.1   Jul 01 2013 16:02:10   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_inv_locations.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:10  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
   --
   --------------------------------------------------------------------------
   iit_ne_id, nm3pla.get_connected_chunks ( iit_ne_id, 'SECT' )  nm2_pla
     FROM nm_inv_items_all;
     
-----------------------------------------------------------------------------
-- NM2_INV_LOCATIONS view
-----------------------------------------------------------------------------
CREATE OR REPLACE FORCE VIEW nm2_inv_locations ( iit_ne_id
                                               , pl_ne_id
                                               , pl_start
                                               , pl_end
                                               , pl_measure
                                               ) AS
   SELECT 
   --------------------------------------------------------------------------
   --
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_inv_locations.sql-arc   2.1   Jul 01 2013 16:02:10   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_inv_locations.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:10  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
   --
   --------------------------------------------------------------------------
   iit_ne_id, pl.pl_ne_id, pl.pl_start, pl.pl_end, pl.pl_measure
     FROM nm2_inv_locations_pla v
   , TABLE ( v.nm2_pla.npa_placement_array ) pl;


-----------------------------------------------------------------------------
-- Populate nm2_inv_locations_tab
-----------------------------------------------------------------------------

INSERT INTO nm2_inv_locations_tab
  SELECT * FROM nm2_inv_locations;

COMMIT;

