CREATE OR REPLACE FORCE VIEW V1 (a,b,c,d,e,f) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v1.vw-arc   3.1   Jul 01 2013 15:55:50   James.Wadsworth  $
--       Module Name      : $Workfile:   v1.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:27:04  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       def_defect_id          a
     , def_date_compl         b
     , def_rse_he_id          c
     , def_defect_code        d
     , def_atv_acty_area_code e
     , def_st_chain           f
FROM   defects
/
