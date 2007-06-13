-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_inv_locations.sql-arc   2.0   Jun 13 2007 16:32:32   smarshall  $
--       Module Name      : $Workfile:   mai_inv_locations.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:32  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
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
--	Copyright (c) exor corporation ltd, 2004
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
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_inv_locations.sql-arc   2.0   Jun 13 2007 16:32:32   smarshall  $
--       Module Name      : $Workfile:   mai_inv_locations.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:32  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
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
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_inv_locations.sql-arc   2.0   Jun 13 2007 16:32:32   smarshall  $
--       Module Name      : $Workfile:   mai_inv_locations.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:32  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
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

