rem "@(#)mai2110_tab_cre.sql	1.1 09/08/03"
create table hhinv_temp_7883
           (he_id number(8), max_chain number(6))
/
create table road_sect_ora as select * from road_segments_all where rownum < 1
/
create table SCTDTAIL (sct_id number(8),
date_fn date)
/
