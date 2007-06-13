CREATE OR REPLACE PACKAGE BODY maipbi AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maipbi.pkb-arc   2.0   Jun 13 2007 17:36:52   smarshall  $
--       Module Name      : $Workfile:   maipbi.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:52  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maipbi.pck	1.5 01/07/00'
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------

 -----------------------------------------------------------------------------
 -- Procedure to create and execute pbi code
 --
 procedure construct_pbi(p_qry_id in pbi_query.qry_id%type,code in out varchar2) as
 --
 -- This same rule is hard-coded into:
 -- 'bpr2110c' - 'Inventory Loader'
 -- 'bpr2300.inp' - 'Maintain Inventory Items'
 -- It permits Inventory to be created to a end chainage of Section Length + 5%
 -- Here it enables such Inventory to be reported

   RSE_LENGTH_RULE constant varchar2(20) := '(rse_length*1.05)';
   currentline              number(8,0);
   counter                  number(8,0);
   alpha                    varchar2(8);
   insert_value1            varchar2(15000);
   sql_select1 	          varchar2(500);
   sql_select2 	          varchar2(500);
   sql_select3 	          varchar2(500);
   sql_from1                varchar2(500);
   sql_from2    	          varchar2(500);
   sql_where1 	          varchar2(500);
   sql_where4 	          varchar2(500);
   sql_where5a 	          varchar2(2000);
   sql_where5 	          varchar2(2000);
   sql_subquery1            varchar2(500);
   sql_subquery2            varchar2(300);
   sql_subquery3            varchar2(500);
   sql_subquery7            varchar2(2000);
   sql_having1              varchar2(600);
   sql_having2              varchar2(400);
   sql_group_by1            varchar2(200);
   sql_group_by2            varchar2(400);
   rows_processed           number;

   sql_select10           varchar2(500);
   sql_from10             varchar2(500);
   sql_where10            varchar2(500);
   sql_group_by20	  varchar2(400);


   item_sql_select        varchar2(500);
   item_sql_where         varchar2(500);
   item_sql_subquery	  varchar2(500);
   item_sql_main_where    varchar2(500);
   item_sql_main_wherea   varchar2(500);

	cursor c1 (qry_num number) is
	select *
	from   pbi_query
	where  qry_id = qry_num;

	cursor c2 (qry_num number) is
	select qrt_qry_id, qrt_inv_code, qrt_sys_flag, qrt_x_sect, rownum
	from   pbi_query_types
	where  qrt_qry_id = qry_num;

	cursor c3 (qry_num number) is
	select rownum
	from   pbi_query_types
	where  qrt_qry_id = qry_num
	and    rownum <
	(select count(*)
	from    pbi_query_types
	where   qrt_qry_id = qry_num);

	cursor c4 (qry_num number,
                   qry_inv_code char,
                   qry_sys_flag char,
                   qry_x_sect char) is
	select *
	from pbi_query_attribs
	where qra_qry_id = qry_num
      and   qra_qrt_inv_code = qry_inv_code
      and   qra_qrt_sys_flag = qry_sys_flag
      and   nvl(qra_qrt_x_sect,'~') = nvl(qry_x_sect,'~');

begin

  for qry in c1 (p_qry_id) loop

	sql_select1 :=
	'insert into pbi_results ( PBI_USER_NAME ,PBI_QRY_ID ,PBI_RSE_HE_ID ,PBI_BEGIN_MP ,PBI_END_MP ,PBI_COUNT) '||
	'select USER ,'||to_char(qry.qry_id)||', rse_he_id'
	||', max(greatest( ';

	item_sql_select :=
	'insert into pbi_results_inv (PBI_USER_NAME ,PBI_QRY_ID ,PBI_RSE_HE_ID ,PBI_BEGIN_MP ,PBI_END_MP ,PBI_COUNT, ' ||
	'PBI_ITEM_ID) select USER, ' || to_char(qry.qry_id) || ', iit_rse_he_id, iit_st_chain, iit_end_chain, 0, ' ||
	'iit_item_id from inv_items where ';

	item_sql_where := 'and iit_rse_he_id in (select pbi_rse_he_id from pbi_results)';

	for t in c2 (p_qry_id) loop
	   sql_select2 := sql_select2||
				't'||to_char(t.rownum )||'.iit_st_chain,';
	end loop;

	sql_select2 := sql_select2||
		nvl(to_char(qry.qry_begin_mp), '0')||
		')) Begin_mp, min(least(';

 	/* build the select statement */
	for t2 in c2 (p_qry_id) loop
	   sql_select3 := sql_select3||
	      'nvl(t'||to_char(t2.rownum )||'.iit_end_chain,t'||
                       to_char(t2.rownum )||'.iit_st_chain ),' ;
	end loop;


	sql_from1 := nvl(to_char(qry.qry_end_mp), RSE_LENGTH_RULE)||
	')) end_mp, count(*)   from ';

	sql_from10 := nvl(to_char(qry.qry_end_mp), RSE_LENGTH_RULE)||
	')) end_mp, count(*), t.iit_item_id   from inv_items t, ';

 	/* build the from statement */
	for t3 in c2 (p_qry_id) loop
	   sql_from2 := sql_from2||
		'inv_items t'||to_char(t3.rownum )||',' ;
	end loop;





	/* Strip the comma off the line */
	sql_from2 := substr(sql_from2,1,length(sql_from2)-1);

	sql_where1 := ' where  ';

	sql_where10 := ' where t.iit_rse_he_id = rse_he_id and ';

 	/* build the select statement */
	for t6 in c3 (p_qry_id) loop
	if t6.rownum = 1 then
	   sql_where4 := ' t1.iit_rse_he_id = rse_he_id and ';
	   sql_where4 := sql_where4||
	't'||to_char(t6.rownum )||'.iit_rse_he_id = '||
	't'||to_char(t6.rownum+1)||'.iit_rse_he_id and ' ;
	else
	   sql_where4 := sql_where4||
	't'||to_char(t6.rownum )||'.iit_rse_he_id = '||
	't'||to_char(t6.rownum+1)||'.iit_rse_he_id and ' ;
	end if;
	end loop;


---------------------------------------------------

	counter := 0;

	for types in c2(qry.qry_id)  loop
		counter := counter + 1;
		alpha := to_char(counter);

		item_sql_main_where := '(iit_ity_inv_code = '||
		              ''''||types.qrt_inv_code||''''||
                              ' and ';
                /*  Added by JH 25-JAN-93   */
                item_sql_main_where := item_sql_main_where||
                              'iit_ity_sys_flag = '||
                              ''''||types.qrt_sys_flag||''''||
                              ' and ';
                /*  ------------------------ */
		select item_sql_main_where||
		'nvl(iit_x_sect,''~'') '||
		decode(types.qrt_x_sect,'', '= ''~'' ','%',' like '||
		''''||types.qrt_x_sect||'''',  ' = '||
		''''||types.qrt_x_sect||'''') ||'  '
		into item_sql_main_where
		from dual;

	for attribs in c4 (p_qry_id,
                           types.qrt_inv_code,
                           types.qrt_sys_flag,
                           types.qrt_x_sect) loop

		select  item_sql_main_where||
			' and '||attribs.qra_attrib_name ||' '||
		        attribs.qra_condition||' '||
			decode(attribs.qra_condition,
			'IS NOT NULL','',
			'IS NULL','',
			'IN','('||attribs.qra_value1||')',
			'NOT IN','('||attribs.qra_value1||')',
			'BETWEEN',
		        attribs.qra_value1||' and '||attribs.qra_value2,
			decode(attribs.qra_format,'NUMBER','',
			'''')||
			attribs.qra_value1||
			decode(attribs.qra_format,'NUMBER','',
			''''))
			||' '
		into item_sql_main_where
		from dual;
		/* this is a workaround; a error appears when the data
		   is put into item_sql_main_where directly */

		item_sql_main_wherea := item_sql_main_wherea || item_sql_main_where;
		item_sql_main_where := '';
	end loop;

		item_sql_main_wherea := item_sql_main_wherea || item_sql_main_where;
		item_sql_main_where := null;

	if qry.qry_begin_mp is not null or qry.qry_end_mp is not null then
	item_sql_main_where :=
	'and (iit_st_chain between '||
		nvl(to_char(qry.qry_begin_mp),
		'iit_st_chain')||'  and '||
		nvl(to_char(qry.qry_end_mp),'iit_st_chain')||' or ';

	item_sql_main_where := item_sql_main_where||
		'iit_end_chain between '||
		nvl(to_char(qry.qry_end_mp),
			'iit_end_chain')||'  and '||
		nvl(to_char(qry.qry_end_mp),
			'iit_end_chain')||' or ';

	item_sql_main_where := item_sql_main_where||
	nvl(to_char(qry.qry_begin_mp),
		'iit_st_chain')||' between '||
		'iit_st_chain and iit_end_chain or ';

	item_sql_main_where := item_sql_main_where ||
	nvl(to_char(qry.qry_end_mp),'iit_end_chain')||' between '||
		'iit_st_chain and '||
		'iit_end_chain )';

	end if;

	item_sql_main_wherea := item_sql_main_wherea || item_sql_main_where;
	item_sql_main_where := null;
	item_sql_main_wherea := item_sql_main_wherea ||') or ';

	end loop;

	item_sql_main_where := substr(item_sql_main_wherea,1,length(item_sql_main_wherea)-4);

---------------------------------------------------





	counter := 0;

	for types in c2(qry.qry_id)  loop
		counter := counter + 1;
		alpha := to_char(counter);

		sql_where5 := '(t'||alpha||'.iit_ity_inv_code = '||
		              ''''||types.qrt_inv_code||''''||
                              ' and ';
                /*  Added by JH 25-JAN-93   */
                sql_where5 := sql_where5||
                              't'||alpha||'.iit_ity_sys_flag = '||
                              ''''||types.qrt_sys_flag||''''||
                              ' and ';
                /*  ------------------------ */
		select sql_where5||
		'nvl(t'||alpha||'.iit_x_sect,''~'') '||
		decode(types.qrt_x_sect,'', '= ''~'' ','%',' like '||
		''''||types.qrt_x_sect||'''',  ' = '||
		''''||types.qrt_x_sect||'''') ||'  '
		into sql_where5
		from dual;

	for attribs in c4 (p_qry_id,
                           types.qrt_inv_code,
                           types.qrt_sys_flag,
                           types.qrt_x_sect) loop

		select  sql_where5||
			' and t'||alpha||'.'||attribs.qra_attrib_name ||' '||
		        attribs.qra_condition||' '||
			decode(attribs.qra_condition,
			'IS NOT NULL','',
			'IS NULL','',
			'IN','('||attribs.qra_value1||')',
			'NOT IN','('||attribs.qra_value1||')',
			'BETWEEN',
		        attribs.qra_value1||' and '||attribs.qra_value2,
			decode(attribs.qra_format,'NUMBER','',
			'''')||
			attribs.qra_value1||
			decode(attribs.qra_format,'NUMBER','',
			''''))
			||' '
		into sql_where5
		from dual;
		/* this is a workaround; a error appears when the data
		   is put into sql_where5 directly */

		sql_where5a := sql_where5a || sql_where5;
		sql_where5 := '';
	end loop;

		sql_where5a := sql_where5a || sql_where5;
		sql_where5 := null;

	if qry.qry_begin_mp is not null or qry.qry_end_mp is not null then
	sql_where5 :=
	'and (t'||alpha||'.iit_st_chain between '||
		nvl(to_char(qry.qry_begin_mp),
		alpha||'.iit_st_chain')||'  and '||
		nvl(to_char(qry.qry_end_mp),alpha||'.iit_st_chain')||' or ';

	sql_where5 := sql_where5||
		't'||alpha||'.iit_end_chain between '||
		nvl(to_char(qry.qry_end_mp),'t'||
			alpha||'.iit_end_chain')||'  and '||
		nvl(to_char(qry.qry_end_mp),'t'||
			alpha||'.iit_end_chain')||' or ';

	sql_where5 := sql_where5||
	nvl(to_char(qry.qry_begin_mp),'t'||alpha||
		'.iit_st_chain')||' between '||
		't'||alpha||'.iit_st_chain and t'||alpha||'.iit_end_chain or ';

	sql_where5 := sql_where5 ||
	nvl(to_char(qry.qry_end_mp),'t'||alpha||'.iit_end_chain')||' between '||
		't'||alpha||'.iit_st_chain and t'||alpha||
		'.iit_end_chain )';

	end if;

	sql_where5a := sql_where5a || sql_where5;
	sql_where5 := null;
	sql_where5a := sql_where5a ||') and ';

	end loop;

	sql_where5 := substr(sql_where5a,1,length(sql_where5a)-5);







	if sql_from2 is null then
	sql_from2 := sql_from2||' road_segments ';
	else
	sql_from2 := sql_from2||', road_segments ';
	sql_subquery1 :=
	'and t1.iit_rse_he_id =  rse_he_id and ' ;
	end if;

	item_sql_subquery :=
	' t1.iit_rse_he_id =  rse_he_id and ' ;

	if qry.qry_rse_he_id is not null
        then
	  sql_subquery2 := 'rse_he_id = '||to_char(qry.qry_rse_he_id)||' and ';
	  sql_subquery3 := 'rse_end_date is null AND rse_type = ''S''  ';
	end if;

	/* input group criteria if necessary here */

	if qry.qry_group is not null
        then
            sql_subquery7 :=
         ' (rse_he_id,''S'') in ' ||
         ' ( select rsm_rse_he_id_of,rsm_type from road_seg_membs ' ||
         ' where sysdate between ' ||
         ' rsm_start_date ' ||
         ' and nvl(rsm_end_date,sysdate) ' ||
         ' connect by prior rsm_rse_he_id_of = rsm_rse_he_id_in ' ||
         ' and sysdate between ' ||
         ' rsm_start_date ' ||
         ' and nvl(rsm_end_date,sysdate) ' ||
         ' start with rsm_rse_he_id_in = ' ||
           to_char(qry.qry_rsm_rse_he_id) ||
         ' and sysdate between ' ||
         ' rsm_start_date ' ||
         ' and nvl(rsm_end_date,sysdate)) ';
	end if;

	/* Insert having criteria */
	sql_having1 := ' having max(greatest(';
 	/* build the from statement */
	for t4 in c2 (p_qry_id) loop
	   sql_having1 := sql_having1||
		't'||to_char(t4.rownum) ||'.iit_st_chain,';

	end loop;
	/* Strip the comma off the line */

	sql_having1 := sql_having1||'0'||
		')) <= min(least(';

 	/* build the select statement */
	for t5 in c2 (p_qry_id) loop
	   sql_having2 := sql_having2||
           ' nvl(t'||to_char(t5.rownum )||'.iit_end_chain,'||
               't'||to_char(t5.rownum )||'.iit_st_chain),';
	end loop;

	sql_having2 := sql_having2||RSE_LENGTH_RULE|| ')) ';

	sql_group_by1 :=
            ' group by rse_he_id  ';

	for t in c2 (p_qry_id) loop
	   sql_group_by2:= sql_group_by2||
			',t'||to_char(t.rownum )||'.iit_st_chain, '||
			't'||to_char(t.rownum )||'.iit_end_chain, '||
			't'||to_char(t.rownum )||'.iit_x_sect';
 	end loop;


	sql_group_by20:= ',t.iit_item_id';

	insert_value1 :=
	sql_select1||
	sql_select2||
	sql_select3||
	sql_from1||
	sql_from2||
	sql_where1||
	sql_where4||
	sql_where5||
	sql_subquery1||
	sql_subquery2||
	sql_subquery3||
	sql_subquery7||
	sql_having1||
	sql_having2||
	sql_group_by1||
	sql_group_by2;

        delete from pbi_results
        where pbi_user_name = USER;

        code := insert_value1;
	hig.execute_sql (insert_value1, rows_processed);

	commit;


--   make sure that user has at least one result record so that
--   reports will run

      if rows_processed = 0 then
        insert into pbi_results
        (pbi_user_name, pbi_qry_id)
        select USER ,p_qry_id
        from dual
        where 0 =
        (select nvl(count(pbi_user_name),0)
        from pbi_results
        where pbi_user_name = USER
        );
      end if;

      if item_sql_main_where is null then
         item_sql_main_where := '1 = 1';
      end if;

      insert_value1 :=
      item_sql_select||
      item_sql_main_where||
      item_sql_where;

      delete from pbi_results_inv
      where pbi_user_name = USER;

      hig.execute_sql (insert_value1, rows_processed);

      commit;

  end loop;
end ;

end maipbi;
/
