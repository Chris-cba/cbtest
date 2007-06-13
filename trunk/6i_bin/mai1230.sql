--	Copyright (c) Exor Corporation Ltd, 1997 
--
--    APPLICATION     : MM                             
--    MODULE ID       : MM1230.SQL                                    
--    NAME            : Section Frequencies Update          
--    AUTHOR          : C.Hackforth	07/10/97
--                      Adapted to replace BPR1230.sql, BPR1235.sql,BPR1235A.sql
--                      in migration to v2.1 of MM   
--    TABLES and                                                        
--    VIEWS USED      : Road_Sections_all,                              
--                      Section_Freqs,                                  
--                      Act_Freqs,                                      
--                      Intervals                                       
--                      MAI1230_TT1                                     
--                      MAI1230_TT2                                     
--                                                                      
--	PURPOSE         : This module updates Section Frequencies.
--                      Previously the 3 sql files were for section, 
--                      link & global these being specified in the 
--                      sql script.
--                      A single script is now used and all sections 
--                      within the GRI ROAD_ID will have frequencies
--                      updated.
--                      If the GRI ROAD_ID is a section that section 
--                      alone will be updated.
--                      Else all sections within the group specified 
--                      by the GRI ROAD_ID rse_he_id will be updated.
--                                                                      
--    CALLING MODULES : GRI                                           
--                                                                      
--    MODULES CALLED  : None.                                           
--    COMMENTS        :                                                 
--                                                                      
--    MODIFICATIONS   :                                                 
--  -----------------------------------------------------------------------
-- 
-- 	GRI PARAMS      : ROAD_ID
--
--
--  SCCS ID Keyword, do no remove
define sccsid = "@(#)mai1230.sql	1.1 10/20/03";

SET FEEDBACK OFF;
SET VERIFY OFF;
SET TERM OFF;
SET HEADING OFF;

--SET FEEDBACK ON;
--SET VERIFY ON
--SET HEADING ON;
--SET TERM ON
set serveroutput on;

--spool mai1230.lis


col tabname1 new_value tabname1 noprint;
col tabname2 new_value tabname2 noprint;
col indname2 new_value indname2 noprint;
col spool new_value spool noprint;


select 'MAI1230_TT1_'||userenv('SESSIONID') tabname1,
       'MAI1230_TT2_'||userenv('SESSIONID') tabname2,
       'MAI1230_II2_'||userenv('SESSIONID') indname2
from dual;

drop table &tabname1;

create table &tabname1
(tt1_rse_he_id                   number(8),
 tt1_iit_ity_inv_code            varchar2(2),
 tt1_rse_road_environment	   varchar2(1),	
 tt1_rse_scl_sect_class		   varchar2(2),
 tt1_rse_sys_flag			   varchar2(1))
pctfree 1;

drop table &tabname2;

create table &tabname2
(tt2_afr_atv_acty_area_code      varchar2(2) not null,
 tt2_int_code                    varchar2(4) not null,
 tt2_dummy                       number(6) not null,
 tt2_rse_he_id                   number(8) not null)
pctfree 1;

create index &indname2 on &tabname2
(tt2_afr_atv_acty_area_code);

select higgrirp.get_module_spoolpath(&&1,user)||higgrirp.get_module_spoolfile(&&1) spool 
from dual;



spool &spool

declare
  p_rse_he_id road_sections.rse_he_id%type;
  p_rse_road_environment road_sections.rse_road_environment%type;
  p_rse_scl_sect_class road_sections.rse_scl_sect_class%type;
  p_rse_sys_flag road_sections.rse_sys_flag%type;
  p_temp varchar2(4);
  i number;
  cursor c0 is
    select rse_road_environment,rse_scl_sect_class,rse_sys_flag
    from road_sections
    where rse_he_id = p_rse_he_id;

  cursor c1 is
   select distinct r.rse_he_id, i.iit_ity_inv_code,
	r.rse_road_environment,r.rse_scl_sect_class,r.rse_sys_flag
   from inv_items_all i, road_sections r
   where i.iit_end_date (+) is null
   and   i.iit_rse_he_id (+) = r.rse_he_id
   AND   nvl(i.iit_inv_ownership, 'DTP') = 'DTP'
   and rse_he_id in
  ((select rsm_rse_he_id_of from road_seg_membs
		  connect by prior rsm_rse_he_id_of = rsm_rse_he_id_in
		  start with rsm_rse_he_id_in = p_rse_he_id)
    union
    (select rse_he_id from road_sections
    where rse_he_id= p_rse_he_id));

  cursor c2 is 
   select a.afr_atv_acty_area_code aa, i.int_code code,
       min(nvl(i.int_freq_per_year,
           nvl(i.int_freq_per_month,
           nvl(i.int_freq_per_week,  99999 -
                                 trunc((nvl(i.int_hrs,0)+23)/24) -
                                 nvl(i.int_days,0) -
                                 nvl(i.int_months,0) * 30 -
                                 nvl(i.int_yrs,0) * 365 ))) ) minval,
       t.tt1_rse_he_id rse_he_id
   from activities act, intervals i, act_freqs a, &tabname1 t
   where act.atv_acty_area_code = a.afr_atv_acty_area_code
   and act.atv_dtp_flag = t.tt1_rse_sys_flag
   and i.int_code = a.afr_int_code
   and a.afr_road_environment = t.tt1_rse_road_environment
   and a.afr_scl_sect_class = t.tt1_rse_scl_sect_class
-- and a.afr_ity_sys_flag = t.tt1_rse_sys_flag
   and (a.afr_ity_inv_code = t.tt1_iit_ity_inv_code
   or a.afr_ity_inv_code = '%%')
   group by a.afr_atv_acty_area_code, i.int_code, t.tt1_rse_he_id;

  cursor c3 is
   select tt2a.tt2_afr_atv_acty_area_code aa,
       min(tt2a.tt2_int_code) int_code,
       tt2a.tt2_rse_he_id rse_he_id
   from &tabname2 tt2a
   where tt2a.tt2_dummy = (select min(tt2b.tt2_dummy)
                   from &tabname2 tt2b
                   where tt2b.tt2_afr_atv_acty_area_code =
                         tt2a.tt2_afr_atv_acty_area_code
                   and   tt2b.tt2_rse_he_id = tt2a.tt2_rse_he_id)
   and not exists
    (select 'User amended frequency'
     from section_freqs sfr
     where  sfr.sfr_atv_acty_area_code = tt2a.tt2_afr_atv_acty_area_code
       and sfr_rse_he_id = tt2a.tt2_rse_he_id)
   group by tt2a.tt2_afr_atv_acty_area_code, tt2a.tt2_rse_he_id;

begin

--  p_rse_he_id:= &&1;
  p_rse_he_id:= higgrirp.get_parameter_value(&&1,'ROAD_ID');
  i:=0;

higgrirp.write_gri_spool(&&1,'Phase 1 - Selecting Road Section/Inventory Item Type combinations');
dbms_output.put_line('Phase 1 - Selecting Road Section/Inventory Item Type combinations');

  for c1rec in c1 loop 
    insert into &tabname1 (tt1_rse_he_id, tt1_iit_ity_inv_code,
	tt1_rse_road_environment,tt1_rse_scl_sect_class,tt1_rse_sys_flag)
    values (c1rec.rse_he_id,
		c1rec.iit_ity_inv_code,
		c1rec.rse_road_environment,	
		c1rec.rse_scl_sect_class,
		c1rec.rse_sys_flag);
    i:= i+1; 
  end loop;

higgrirp.write_gri_spool(&&1,to_char(i)||' records selected');
dbms_output.put_line(to_char(i)||' records selected');
higgrirp.write_gri_spool(&&1,'Phase 2 - Selecting Default Section Frequencies...');
dbms_output.put_line('Phase 2 - Selecting Default Section Frequencies...');

  i:=0;
  for c2rec in c2 loop 
    insert into &tabname2 (tt2_afr_atv_acty_area_code,
                         tt2_int_code, tt2_dummy, tt2_rse_he_id)
    values (c2rec.aa, c2rec.code, c2rec.minval,c2rec.rse_he_id); 
    i:= i+1; 
  end loop;

higgrirp.write_gri_spool(&&1,to_char(i)||' records selected');
dbms_output.put_line(to_char(i)||' records selected');
higgrirp.write_gri_spool(&&1,'Phase 3 - Deleting old Default Section Frequencies...');
dbms_output.put_line('Phase 3 - Deleting old Default Section Frequencies...');

  delete from section_freqs
  where  sfr_changed_by is null
  and sfr_rse_he_id in
  ((select rsm_rse_he_id_of from road_seg_membs
		  connect by prior rsm_rse_he_id_of = rsm_rse_he_id_in
		  start with rsm_rse_he_id_in = p_rse_he_id)
    union
    (select rse_he_id from road_sections
    where rse_he_id= p_rse_he_id));


higgrirp.write_gri_spool(&&1,'Phase 4 - Inserting new Default Section Frequencies...');
dbms_output.put_line('Phase 4 - Inserting new Default Section Frequencies...');

  i:=0;
  for c3rec in c3 loop
    insert into section_freqs ( sfr_atv_acty_area_code,
                            sfr_int_code,
                            sfr_rse_he_id )
   values (c3rec.aa,c3rec.int_code,c3rec.rse_he_id);
   i:= i+1; 
  end loop;
higgrirp.write_gri_spool(&&1,to_char(i)||' records inserted');
dbms_output.put_line(to_char(i)||' records inserted');

update gri_report_runs 
set grr_end_date = sysdate,
grr_error_no = 0,
grr_error_descr = 'Normal Successful Completion'
where grr_job_id = &&1; 

higgrirp.write_gri_spool(&&1,'Normal Successful Completion');
dbms_output.put_line('Normal Successful Completion');

end;
/


drop table &tabname1;
drop table &tabname2;

spool off
set term on
exit
