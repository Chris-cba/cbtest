--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/ROAD_SEG_MEMBS_ALL.vw-arc   1.3   Jul 01 2013 16:03:54   James.Wadsworth  $
--       Module Name      : $Workfile:   ROAD_SEG_MEMBS_ALL.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:03:54  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       PVCS Version     : $Revision:   1.3  $
--
----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
----------------------------------------------------------------------------
--
CREATE OR REPLACE FORCE VIEW ROAD_SEG_MEMBS_ALL
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
   -- changed in mai4600 fix 5
   ---------------------------------------------------------------------------
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

