--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/c/mai2110c/mai2110_tab_cre.sql-arc   2.2   Sep 03 2009 13:33:46   mhuitson  $
--       Module Name      : $Workfile:   mai2110_tab_cre.sql  $
--       Date into PVCS   : $Date:   Sep 03 2009 13:33:46  $
--       Date fetched Out : $Modtime:   Sep 03 2009 13:33:02  $
--       PVCS Version     : $Revision:   2.2  $
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
