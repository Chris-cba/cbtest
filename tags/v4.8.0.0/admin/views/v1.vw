CREATE OR REPLACE FORCE VIEW V1 (a,b,c,d,e,f) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v1.vw-arc   3.3   Sep 27 2019 15:36:20   Chris.Baugh  $
--       Module Name      : $Workfile:   v1.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:20  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
