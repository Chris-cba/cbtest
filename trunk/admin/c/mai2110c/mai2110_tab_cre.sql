--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //new_vm_latest/archives/mai/admin/c/mai2110c/mai2110_tab_cre.sql-arc   2.4   Jun 28 2018 11:01:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai2110_tab_cre.sql  $
--       Date into PVCS   : $Date:   Jun 28 2018 11:01:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 10:58:06  $
--       PVCS Version     : $Revision:   2.4  $
--
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
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
