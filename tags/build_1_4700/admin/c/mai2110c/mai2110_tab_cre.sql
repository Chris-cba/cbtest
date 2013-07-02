--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/c/mai2110c/mai2110_tab_cre.sql-arc   2.3   Jul 02 2013 10:29:04   James.Wadsworth  $
--       Module Name      : $Workfile:   mai2110_tab_cre.sql  $
--       Date into PVCS   : $Date:   Jul 02 2013 10:29:04  $
--       Date fetched Out : $Modtime:   Jul 02 2013 09:54:14  $
--       PVCS Version     : $Revision:   2.3  $
--
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
CREATE TABLE hhinv_temp_7883
            (he_id     NUMBER(38,0)
            ,max_chain NUMBER(6))
/
CREATE TABLE road_sect_ora
          AS SELECT *
               FROM road_segments_all
              WHERE rownum < 1
/
CREATE TABLE sctdtail
            (sct_id  NUMBER(38,0)
            ,date_fn DATE)
/
