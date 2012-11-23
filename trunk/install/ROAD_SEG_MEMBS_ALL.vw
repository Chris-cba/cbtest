--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/ROAD_SEG_MEMBS_ALL.vw-arc   1.0   Nov 23 2012 18:21:54   Rob.Coupe  $
--       Module Name      : $Workfile:   ROAD_SEG_MEMBS_ALL.vw  $
--       Date into PVCS   : $Date:   Nov 23 2012 18:21:54  $
--       Date fetched Out : $Modtime:   Nov 23 2012 18:12:20  $
--       PVCS Version     : $Revision:   1.0  $
--
----------------------------------------------------------------------------
--   Copyright (c) 2012 Bentley Systems Incorporated.
----------------------------------------------------------------------------
--
CREATE OR REPLACE FORCE VIEW HIGHWAYS.ROAD_SEG_MEMBS_ALL
(
   RSM_RSE_HE_ID_IN,
   RSM_RSE_HE_ID_OF,
   RSM_START_DATE,
   RSM_END_DATE,
   RSM_SEQ_NO,
   RSM_TYPE,
   RSM_BEGIN_MP,
   RSM_END_MP,
   RSM_ROUTE_BEGIN_MP,
   RSM_ROUTE_END_MP
)
AS
   SELECT -----------------------------------------------------------------------------
                                                      --   SCCS Identifiers :-
                                                                            --
                 --       sccsid           : @(#)translation.sql 1.37 06/23/05
                                   --       Module Name      : translation.sql
                                 --       Date into SCCS   : 05/06/23 16:09:28
                                 --       Date fetched Out : 05/06/23 16:10:34
                                              --       SCCS Version     : 1.37
                                                                            --
                                                           -- Translation View
                                                                            --
 -----------------------------------------------------------------------------
                                   -- Copyright (c) exor corporation ltd, 2005
 -----------------------------------------------------------------------------
         nm.nm_ne_id_in,
         nm.nm_ne_id_of,
         nm.nm_start_date,
         nm.nm_end_date,
         nm.nm_seq_no,
         (SELECT DECODE (ne_nt_type,  'D', 'S',  'L', 'S',  'G')
            FROM nm_elements_all
           WHERE ne_id = nm_ne_id_of),
         nm.nm_begin_mp,
         nm.nm_end_mp,
         nm.nm_slk,
         nm.nm_end_slk
    FROM nm_members_all nm
   WHERE nm_type = 'G';

