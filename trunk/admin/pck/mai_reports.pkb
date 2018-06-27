CREATE OR REPLACE package body maireports as
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_reports.pkb-arc   2.2   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_reports.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:30  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:58:04  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maireports.pck	1.2 05/28/02'
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------


g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   2.2  $';

-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN varchar2 IS
BEGIN
   RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------

Procedure mai2325_report ( job_id in number )
is
       --
       -- Variable declaration section
       --
       v_job_no       integer:=job_id;          -- The selected job number
       a_query        integer;                  -- Query cursor handle
       exec_ok        integer;                  -- Query success indicator
       last_error_pos integer:=0;               -- Displayed error position
       v_query        varchar2(2000);           -- Dynamic query variable
       is_group       boolean:=false;           -- Group boolean indicator
       is_range       boolean:=false;           -- Range boolean indicator
       dbug           boolean:=false;           -- Debugging boolean indicator
       --
       v_group_he_id  road_segs.rse_he_id%type; -- Road group highways element
       v_section      road_segs.rse_he_id%type; -- Section    highways element
       v_rse_from     road_segs.rse_he_id%type; -- Range from highways element
       v_rse_to       road_segs.rse_he_id%type; -- Range to   highways element
       --
       -- Cursor used to detect wether a group has been selected as a report
       -- parameter.
       --
       cursor is_group_sel
       is     select distinct rep_p1
       from   report_params
       where  rep_sessionid = v_job_no
       and    rep_p2 is null;
       --
       -- Cursor used to detect wether a section range has been selected as a
       -- report parameter.
       --
       cursor is_range_sel
       is     select distinct p1.rep_p1
                             ,p1.rep_p2
       from   report_params p1
       where  p1.rep_sessionid= v_job_no
       and    p1.rep_p1 is not null
       and    p1.rep_p2 is not null;
       --
       -- Cursor used to define a dynamic query.
       -- A UNION has been used to provide a query where an attribute has been
       -- specified or where just the inventory type has been specified.
       --
       cursor group_query
       is select 'insert into mai2325_results
                  ( mai2325_link
                   ,mai2325_section
                   ,mai2325_inventory
                   ,mai2325_attribute
                   ,mai2325_number
                   ,mai2325_length
                   ,mai2325_area
                  ) select rse.rse_linkcode
                 ,rse.rse_sect_no
                 ,initcap(ity.ity_descr)
                 ,initcap(ita.ita_scrn_text)
                 ,count(iit.iit_rse_he_id)
 ,sum(nvl(iit.iit_end_chain,0)-nvl(iit.iit_st_chain,0))
 ,sum((nvl(iit.iit_end_chain,0)-nvl(iit.iit_st_chain,0))*nvl(iit.iit_width,0))
        from '||ity2.ity_view_name||' iit
             ,inv_item_types       ity
             ,inv_type_attribs     ita
             ,road_sections_all    rse
where rse.rse_he_id        = '||to_char(v_section)||'
and   ity.ity_inv_code     = nvl('||''''||p2.rep_p3||''''||',ity.ity_inv_code)
and   ity.ity_sys_flag     = rse.rse_sys_flag
and   ita.ita_ity_sys_flag = ity.ity_sys_flag
and   ita.ita_iit_inv_code = ity.ity_inv_code
and   nvl(ita.ita_view_col_name,ita.ita_attrib_name)=nvl('||''''||
p2.rep_p4||''''||',nvl(ita.ita_view_col_name,ita.ita_attrib_name)) and '||
' iit.iit_rse_he_id = rse.rse_he_id  and '||
' iit.'||lower(p2.rep_p4)||' = '||''''||p2.rep_p5||''''||
' group by '||
    '     rse.rse_linkcode
         ,rse.rse_sect_no
         ,initcap(ity.ity_descr)
         ,initcap(ita.ita_scrn_text)'   v_query
from   report_params     p2
      ,road_segments_all rse2
      ,inv_item_types    ity2
      ,inv_type_attribs  ita2
where  p2.rep_sessionid      = v_job_no
and    rse2.rse_he_id        = v_section
and    ity2.ity_sys_flag     = rse2.rse_sys_flag
and    ity2.ity_inv_code     = p2.rep_p3
and    ita2.ita_iit_inv_code = ity2.ity_inv_code
and    ita2.ita_ity_sys_flag = ity2.ity_sys_flag
and    nvl(ita2.ita_view_col_name,ita2.ita_attrib_name)  = p2.rep_p4
and    p2.rep_p4 is not null
union
           select 'insert into mai2325_results
                         ( mai2325_link
                          ,mai2325_section
                          ,mai2325_inventory
                          ,mai2325_attribute
                          ,mai2325_number
                          ,mai2325_length
                          ,mai2325_area
                         )
                  select rse.rse_linkcode
                 ,rse.rse_sect_no
                 ,initcap(ity.ity_descr)
                 ,null
                 ,count(iit.iit_rse_he_id)
 ,sum(nvl(iit.end_chain,0)-nvl(iit.st_chain,0))
 ,sum((nvl(iit.end_chain,0)-nvl(iit.st_chain,0))*nvl(iit.width,0))
        from '||ity2.ity_view_name||' iit
             ,inv_item_types       ity
             ,road_sections_all    rse
where rse.rse_he_id        = '||to_char(v_section)||'
and   ity.ity_inv_code     = nvl('||''''||p2.rep_p3||''''||',ity.ity_inv_code)
and   ity.ity_sys_flag     = rse.rse_sys_flag
and   iit.iit_rse_he_id    = rse.rse_he_id
group by rse.rse_linkcode
        ,rse.rse_sect_no
        ,initcap(ity.ity_descr)
        ,Null '            v_query
from   report_params     p2
      ,road_segments_all rse2
      ,inv_item_types    ity2
where  p2.rep_sessionid      = v_job_no
and    rse2.rse_he_id        = v_section
and    ity2.ity_sys_flag     = rse2.rse_sys_flag
and    ity2.ity_inv_code     = p2.rep_p3
and    p2.rep_p4 is null;
--
       --
       -- Cursor to obtain the full group membership  of a specified road group
       --
       cursor all_group_sections
       is select rse_he_id
          from   road_sections
          where  rse_he_id in
           ( select rsm_rse_he_id_of from road_seg_membs
             where sysdate between trunc(rsm_start_date)
                               and nvl(rsm_end_date,sysdate)
             connect by prior rsm_rse_he_id_of = rsm_rse_he_id_in
             and   sysdate between trunc(rsm_start_date)
                               and nvl(rsm_end_date,sysdate)
             start with rsm_rse_he_id_in = v_group_he_id
             and   sysdate between trunc(rsm_start_date)
                               and nvl(rsm_end_date,sysdate));
       --
       -- Cursor to obtain a range of section highways element values where a
       -- section range has been provided as a report parameter.
       --
       cursor all_range_sections
       is select rse1.rse_he_id rse_he_id
          from   road_segs rse1
          where  rse1.rse_linkcode =
                    ( select distinct rse2.rse_linkcode
                      from   road_segs     rse2
                            ,report_params p1
                      where  p1.rep_sessionid = v_job_no
                      and    rse2.rse_he_id   = to_number(p1.rep_p1))
          and    rse1.rse_sect_no >=
                   ( select distinct rse3.rse_sect_no
                     from   road_segs     rse3
                           ,report_params p2
                     where  p2.rep_sessionid = v_job_no
                     and    rse3.rse_he_id   = to_number(p2.rep_p1))
          and    rse1.rse_sect_no <=
                   ( select distinct rse4.rse_sect_no
                     from   road_segs     rse4
                           ,report_params p3
                     where  p3.rep_sessionid= v_job_no
                     and    rse4.rse_he_id  = to_number(p3.rep_p2));
       --
       -- Cursor to obtain a list of section highways elements where a section
       -- list has been provided as a report parameter.
       --
       cursor all_list_sections
       is select rse_he_id
          from   road_sections
          where  exists
                  ( select 'exists'
                    from   report_params p1
                    where  p1.rep_sessionid     = v_job_no
                    and    to_number(p1.rep_p2) = rse_he_id);
    --
begin
    --
    -- Note: The next line MUST be kept in place.
    --
    dbms_output.enable (1000000);
    --
    if dbug
    then dbms_output.put_line('Debugging is Enabled');
    end if;
    --
    open  is_group_sel;
    fetch is_group_sel
    into  v_group_he_id;
    if    is_group_sel%notfound
    then  close is_group_sel;
          is_group:=false;
          open  is_range_sel;
          fetch is_range_sel into v_rse_from
                                 ,v_rse_to;
          if    is_range_sel%notfound
          then  close is_range_sel;
                is_range:=false;
                --
          else  close is_range_sel;
                is_range:=true;
                --
          end if;
    else  close is_group_sel;
          is_group:=true;
    end if;
    --
    if dbug and is_group
    then dbms_output.put_line('Is Group Is true');
    end if;
    --
    if dbug and is_range
    then dbms_output.put_line('Is Range Is true');
    end if;
    --
    if is_group
    then for each_group_section in all_group_sections
         loop
           v_section:=each_group_section.rse_he_id;
           if dbug
           then dbms_output.put_line('INFO: Section : '||to_char(v_section));
           end if;
           open  group_query;
           loop
              last_error_pos:=0;
              fetch group_query into v_query;
              exit when group_query%notfound;
              if dbug
              then insert into mai2325_query (mai2325_query) values (v_query);
			       dbms_output.put_line('Group query inserted');
			       commit;
              else a_query:=dbms_sql.open_cursor;
                   dbms_sql.parse(a_query,v_query,dbms_sql.native);
              last_error_pos:=dbms_sql.last_error_position;
              exec_ok:=dbms_sql.execute(a_query);
              dbms_sql.close_cursor(a_query);
	      end if;
          end loop;
          close group_query;
         end loop;
         commit;
     elsif is_range
     then for each_range_section in all_range_sections
          loop
           v_section:=each_range_section.rse_he_id;
           open  group_query;
           loop
               fetch group_query into v_query;
               exit when group_query%notfound;
               a_query:=dbms_sql.open_cursor;
               dbms_sql.parse(a_query,v_query,dbms_sql.v7);
               last_error_pos:=dbms_sql.last_error_position;
               exec_ok:=dbms_sql.execute(a_query);
               dbms_sql.close_cursor(a_query);
           end loop;
           close group_query;
         end loop;
         commit;
     else for each_list_section in all_list_sections
         loop
           v_section:=each_list_section.rse_he_id;
           if dbug
           then dbms_output.put_line('INFO: Section : '||to_char(v_section));
           end if;
           open  group_query;
           loop
             fetch group_query into v_query;
             exit when group_query%notfound;
             if dbug
             then insert into mai2325_query (mai2325_query) values (v_query);
             end if;
             a_query:=dbms_sql.open_cursor;
             dbms_sql.parse(a_query,v_query,dbms_sql.v7);
             last_error_pos:=dbms_sql.last_error_position;
             exec_ok:=dbms_sql.execute(a_query);
             dbms_sql.close_cursor(a_query);
           end loop;
           close group_query;
         end loop;
         commit;
     end if;
end mai2325_report;
begin
  null;
end maireports;
/
