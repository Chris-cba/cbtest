CREATE OR REPLACE FORCE VIEW V1 (a,b,c,d,e,f) AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v1.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v1.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 14:37:28  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       def_defect_id          a
     , def_date_compl         b
     , def_rse_he_id          c
     , def_defect_code        d
     , def_atv_acty_area_code e
     , def_st_chain           f
FROM   defects
/