--**************************************************************************
--	This script creates Inventory views based on entered inventory data
--**************************************************************************
----------------------------------------------------------------------------
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/inv_views.sql-arc   2.2   Jun 28 2018 07:41:26   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   inv_views.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 07:41:26  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
--       SCCS Version     : $Revision:   2.2  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

set head off
cl scr
prompt Highways by Exor - Maintenance Manager
prompt =====================================
prompt .
prompt .
prompt Creating Inventory Views
prompt ========================
prompt .
prompt .
prompt Working ...
set serveroutput on
--
declare
       --
       v_stg        varchar2(2000);
       s_stg        varchar2(2000);
       v_query      integer;
       v_inv_type   inv_item_types.ity_inv_code%type;
       v_sys_flag   inv_item_types.ity_sys_flag%type;
       v_road_segs  inv_item_types.ity_incl_road_segs%type;
       exec_ok      integer;
       --
       cursor all_inv_types
       is select ity_inv_code  item_type
                ,ity_view_name view_name
                ,ity_sys_flag  sys_flag
                ,ity_incl_road_segs road_segs
          from   inv_item_types
          order by
                 ity_inv_code
                ,ity_sys_flag;



Procedure Create_view ( view_name      in inv_item_types.ity_view_name%type
                       ,inventory_type in inv_item_types.ity_inv_code%type
                       ,sys_flag       in inv_item_types.ity_sys_flag%type)is
       --
       v_stg          varchar2(2000) := 'Create or Replace view '||view_name||
                                        ' as select /* INDEX (INV_ITEMS_ALL IIT_INDEX_P2) */';
       lc_from        varchar2(2000);
       s_stg          varchar2(2000);
       v_query        integer;
       exec_ok        integer;
       l_p_or_c       inv_item_types.ity_pnt_or_cont%type;
       incl_road_segs inv_item_types.ity_incl_road_segs%type;

       TYPE view_attribs IS RECORD
      (ita_attrib_name   VARCHAR2(30),
       ita_view_col_name VARCHAR2(30));
      --
      TYPE view_attribs_table IS TABLE OF view_attribs
      INDEX BY BINARY_INTEGER;

      view_attribs_tab view_attribs_table;

       --
       -- get type of inventory item so end-chain can be included/excluded
       --
       cursor get_p_or_c is
          select ity_pnt_or_cont,
                 ity_incl_road_segs
          from inv_item_types
          where ity_inv_code = inventory_type
          and ity_sys_flag = sys_flag ;
       --
       -- Obtain all specified inventory columns for the selected inventory
       -- type.
       --
       cursor all_attributes
       is select ita_attrib_name
                    ,ita_view_col_name
                    ,ita_dtp_code
          from     inv_type_attribs
          where    ita_iit_inv_code = inventory_type
          and      ita_ity_sys_flag = sys_flag
          order by ita_disp_seq_no;
       --
   invalid_item_type exception;
   ln_array_count    number;
   --
   Function Synonym_exists( synonym in inv_item_types.ity_view_name%type ) return boolean is
     cursor syn_exists is
      select 1
       from   all_synonyms
       where  synonym_name= synonym
       and    owner       = 'PUBLIC';
    --
    v_exists integer;
    --
    begin
       open  syn_exists;
       fetch syn_exists into v_exists;
       if syn_exists%found then
          close syn_exists;
          return true;
       else  close syn_exists;
          return false;
       end if;
   end Synonym_Exists;

   FUNCTION IN_VIEW_COL_LIST (ita_attrib_name VARCHAR2,
                              ita_view_col_name VARCHAR2) RETURN BOOLEAN IS
     ln_return_value BOOLEAN := FALSE;
   BEGIN
     FOR i IN 1..view_attribs_tab.count LOOP
       IF UPPER(NVL(ita_view_col_name,ita_attrib_name)) = UPPER(NVL(view_attribs_tab(i).ita_view_col_name,view_attribs_tab(i).ita_attrib_name)) THEN
         ln_return_value := TRUE;
         exit;
       END IF;
     END LOOP;
     --
     RETURN ln_return_value;
   END;
   --
begin
   --
   dbms_output.enable (1000000);
   --
   view_attribs_tab.delete;
   --
   open get_p_or_c;
   fetch get_p_or_c into l_p_or_c,incl_road_segs;
   if get_p_or_c%notfound then
      close get_p_or_c;
      raise invalid_item_type;
   else
      close get_p_or_c;
      if l_p_or_c = 'P' then

         view_attribs_tab(1).ita_attrib_name   := 'iit_created_date';
         view_attribs_tab(1).ita_view_col_name := '';
         view_attribs_tab(2).ita_attrib_name   := 'iit_cre_date';
         view_attribs_tab(2).ita_view_col_name := '';
         view_attribs_tab(3).ita_attrib_name   := 'iit_item_id';
         view_attribs_tab(3).ita_view_col_name := '';
         view_attribs_tab(4).ita_attrib_name   := 'iit_ity_inv_code';
         view_attribs_tab(4).ita_view_col_name := '';
         view_attribs_tab(5).ita_attrib_name   := 'iit_ity_sys_flag';
         view_attribs_tab(5).ita_view_col_name := '';
         view_attribs_tab(6).ita_attrib_name   := 'iit_last_updated_date';
         view_attribs_tab(6).ita_view_col_name := '';
         view_attribs_tab(7).ita_attrib_name   := 'iit_description';
         view_attribs_tab(7).ita_view_col_name := '';
         view_attribs_tab(8).ita_attrib_name   := 'iit_rse_he_id';
         view_attribs_tab(8).ita_view_col_name := '';
         view_attribs_tab(9).ita_attrib_name   := 'iit_st_chain';
         view_attribs_tab(9).ita_view_col_name := '';
         view_attribs_tab(10).ita_attrib_name   := 'iit_x_sect';
         view_attribs_tab(10).ita_view_col_name := '';
         view_attribs_tab(11).ita_attrib_name   := 'iit_width';
         view_attribs_tab(11).ita_view_col_name := '';
         view_attribs_tab(12).ita_attrib_name   := 'iit_end_date';
         view_attribs_tab(12).ita_view_col_name := '';
         --
       else
         view_attribs_tab(1).ita_attrib_name   := 'iit_created_date';
         view_attribs_tab(1).ita_view_col_name := '';
         view_attribs_tab(2).ita_attrib_name   := 'iit_cre_date';
         view_attribs_tab(2).ita_view_col_name := '';
         view_attribs_tab(3).ita_attrib_name   := 'iit_item_id';
         view_attribs_tab(3).ita_view_col_name := '';
         view_attribs_tab(4).ita_attrib_name   := 'iit_ity_inv_code';
         view_attribs_tab(4).ita_view_col_name := '';
         view_attribs_tab(5).ita_attrib_name   := 'iit_ity_sys_flag';
         view_attribs_tab(5).ita_view_col_name := '';
         view_attribs_tab(6).ita_attrib_name   := 'iit_last_updated_date';
         view_attribs_tab(6).ita_view_col_name := '';
         view_attribs_tab(7).ita_attrib_name   := 'iit_description';
         view_attribs_tab(7).ita_view_col_name := '';
         view_attribs_tab(8).ita_attrib_name   := 'iit_rse_he_id';
         view_attribs_tab(8).ita_view_col_name := '';
         view_attribs_tab(9).ita_attrib_name   := 'iit_st_chain';
         view_attribs_tab(9).ita_view_col_name := '';
         view_attribs_tab(10).ita_attrib_name   := 'iit_end_chain';
         view_attribs_tab(10).ita_view_col_name := '';
         view_attribs_tab(11).ita_attrib_name   := 'iit_x_sect';
         view_attribs_tab(11).ita_view_col_name := '';
         view_attribs_tab(12).ita_attrib_name   := 'iit_width';
         view_attribs_tab(12).ita_view_col_name := '';
         view_attribs_tab(13).ita_attrib_name   := 'iit_end_date';
         view_attribs_tab(13).ita_view_col_name := '';
       end if;
       --

--
          for each_attribute in all_attributes
          loop
            IF not IN_VIEW_COL_LIST(each_attribute.ita_attrib_name,each_attribute.ita_view_col_name) THEN
              ln_array_count := view_attribs_tab.count +1;
              view_attribs_tab(ln_array_count).ita_attrib_name   := each_attribute.ita_attrib_name;
              view_attribs_tab(ln_array_count).ita_view_col_name := each_attribute.ita_view_col_name;
            END IF;
          end loop;
          --
          IF incl_road_segs = 'Y' THEN
            ln_array_count := view_attribs_tab.count +1;
            view_attribs_tab(ln_array_count).ita_attrib_name   := 'RSE_LENGTH_STATUS';
            view_attribs_tab(ln_array_count).ita_view_col_name := 'SEC_LEN_STAT';
            ln_array_count := ln_array_count +1;
            view_attribs_tab(ln_array_count).ita_attrib_name   := 'RSE_UNIQUE';
            view_attribs_tab(ln_array_count).ita_view_col_name := '';
            ln_array_count := ln_array_count +1;
            view_attribs_tab(ln_array_count).ita_attrib_name   := 'RSE_DESCR';
            view_attribs_tab(ln_array_count).ita_view_col_name := '';
            ln_array_count := ln_array_count +1;
            view_attribs_tab(ln_array_count).ita_attrib_name   := 'RSE_LENGTH';
            view_attribs_tab(ln_array_count).ita_view_col_name := '';
            ln_array_count := ln_array_count +1;
            view_attribs_tab(ln_array_count).ita_attrib_name   := 'RSE_ROAD_ENVIRONMENT';
            view_attribs_tab(ln_array_count).ita_view_col_name := '';
            ln_array_count := ln_array_count +1;
            view_attribs_tab(ln_array_count).ita_attrib_name   := 'RSE_END_DATE';
            view_attribs_tab(ln_array_count).ita_view_col_name := '';
            ln_array_count := ln_array_count +1;
            view_attribs_tab(ln_array_count).ita_attrib_name   := 'RSE_ADMIN_UNIT';
            view_attribs_tab(ln_array_count).ita_view_col_name := '';
            lc_from := ' from inv_items_all, road_sections_all where iit_rse_he_id = rse_he_id and iit_ity_inv_code='||''''
                       ||inventory_type||''''||' and
                       iit_ity_sys_flag='||''''||sys_flag||'''';
          ELSE
            lc_from := ' from inv_items_all where iit_ity_inv_code='||''''
                        ||inventory_type||''''||' and
                          iit_ity_sys_flag='||''''||sys_flag||'''';
          END IF;
          --
          v_query:=dbms_sql.open_cursor;
          FOR i IN 1..view_attribs_tab.count LOOP
            v_stg := v_stg||' '||view_attribs_tab(i).ita_attrib_name||' '||view_attribs_tab(i).ita_view_col_name;
            IF i <> view_attribs_tab.count THEN
              v_stg := v_stg||',';
            END IF;
          END LOOP;
          v_stg := v_stg||' '||lc_from;
          dbms_sql.parse(v_query,v_stg,dbms_sql.v7);
          exec_ok:=dbms_sql.execute(v_query);
          dbms_sql.close_cursor(v_query);
          --
          if hig.get_sysopt('HIGPUBSYN') = 'Y'
          then   --
               if synonym_exists(view_name)
               then s_stg:='drop public synonym '||view_name;
                    --
                    v_query:=dbms_sql.open_cursor;
                    dbms_sql.parse(v_query,s_stg,dbms_sql.v7);
                    exec_ok:=dbms_sql.execute(v_query);
                    dbms_sql.close_cursor(v_query);
                    --
               end if;
               --
               -- Create the public synonym for the previouslry created view.
               --
               s_stg:='create public synonym '||
                       view_name||
                      ' for '||user||'.'||view_name;
               --
               v_query:=dbms_sql.open_cursor;
               dbms_sql.parse(v_query,s_stg,dbms_sql.v7);
               exec_ok:=dbms_sql.execute(v_query);
               dbms_sql.close_cursor(v_query);
               --
          end if;
  end if;
          --
exception
  when others then
     dbms_output.put_line(SUBSTR(v_stg,1,200));
     dbms_output.put_line(SUBSTR(v_stg,201,200));
     dbms_output.put_line(SUBSTR(v_stg,401,200));
     dbms_output.put_line(SUBSTR(v_stg,601,200));
     dbms_output.put_line(SUBSTR(v_stg,801,200));
     dbms_output.put_line(SUBSTR(v_stg,1001,200));
     dbms_output.put_line(SUBSTR(v_stg,1201,200));
     dbms_output.put_line(SUBSTR(v_stg,1401,200));
     dbms_output.put_line(SUBSTR(v_stg,1601,200));
     dbms_output.put_line(SUBSTR(v_stg,1801,200));
end Create_View;

begin
      dbms_output.enable (1000000);
      --
      for each_inv_type in all_inv_types
      loop
          Create_view(each_inv_type.view_name,each_inv_type.item_type,each_inv_type.sys_flag);
     end loop;
  end;
/
