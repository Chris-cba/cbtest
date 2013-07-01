CREATE OR REPLACE package body maigis as
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maigis.pkb-arc   2.1   Jul 01 2013 16:26:50   James.Wadsworth  $
--       Module Name      : $Workfile:   maigis.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:26:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:44  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
--
-----------------------------------------------------------------------------
--   Originally taken from @(#)maigis.pck	1.4 10/01/98
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
   procedure    create_gis_themes_from_ity ( p_rowcount out number ) is

   begin

        -- create all inventory themes

	insert into gis_themes_all (
	   GT_THEME_ID, GT_THEME_NAME, GT_TABLE_NAME, GT_WHERE, GT_PK_COLUMN, GT_LABEL_COLUMN, GT_RSE_TABLE_NAME,
	   GT_RSE_FK_COLUMN, GT_ST_CHAIN_COLUMN, GT_END_CHAIN_COLUMN, GT_X_COLUMN, GT_Y_COLUMN, GT_OFFSET_FIELD,
	   GT_FEATURE_TABLE, GT_FEATURE_PK_COLUMN, GT_FEATURE_FK_COLUMN, GT_ROUTE_THEME, GT_XSP_COLUMN )
	select nth_theme_id_seq.nextval, upper(substr( translate( ity_descr,' {}[]*+;,','_________'), 1, 30)),
               ity_view_name, null, 'IIT_ITEM_ID', 'IIT_ITEM_ID', 'ROAD_SEGS', 'IIT_RSE_HE_ID','IIT_ST_CHAIN',
               decode( ity_pnt_or_cont, 'P', '', 'C','IIT_END_CHAIN'),
	       null, null, null, null, null, null, 'N', 'iit_x_sect'
	from inv_item_types
	where ity_view_name is not null
	and not exists ( select 'exists' from gis_themes
			 where gt_theme_name = substr( translate( ity_descr,' {}[]*+;,','_________'), 1, 30) );

        p_rowcount := sql%rowcount;

	insert into gis_theme_functions (
 	   GTF_GT_THEME_ID,
 	   GTF_HMO_MODULE,
 	   GTF_PARAMETER,
 	   GTF_MENU_OPTION )
	select gt_theme_id, 'MAI2310', 'RSE_HE_ID', gt_theme_name||' by Road'
	from gis_themes_all, inv_item_types
	where gt_table_name = ity_view_name;

	insert into gis_theme_functions (
 	   GTF_GT_THEME_ID,
 	   GTF_HMO_MODULE,
 	   GTF_PARAMETER,
 	   GTF_MENU_OPTION )
	select gt_theme_id, 'MAI2310', 'GIS_SESSION_ID', initcap( gt_theme_name )
	from gis_themes_all, inv_item_types
	where gt_table_name = ity_view_name;

	insert into gis_theme_roles
	(gthr_theme_id, gthr_role, gthr_mode )
	select gt_theme_id, 'MAI_ADMIN','NORMAL'
	from gis_themes_all;

   end;

   procedure    create_gis_themes_from_dty ( p_rowcount in out number ) is

   cursor c1 is
     select distinct dty_atv_acty_area_code,
	   'create view '||dty_atv_acty_area_code||'_defects ' ||
           'as select DEF_DEFECT_ID, DEF_RSE_HE_ID, DEF_ST_CHAIN, DEF_ATV_ACTY_AREA_CODE, '||
	   'DEF_DEFECT_CODE, DEF_STATUS_CODE,'||
           'rep_tre_treat_code from defects, repairs where rep_def_defect_id = def_defect_id ' ||
           'and def_atv_acty_area_code = '||''''||dty_atv_acty_area_code||''''||null  view_string
     from def_types;


   gt_id number;

   begin
	p_rowcount := 0;

        for dty_rec in c1 loop

        select nth_theme_id_seq.nextval into gt_id from dual;

	dbms_output.put_line( 'theme no '||to_char(gt_id));
	insert into gis_themes_all (
	   GT_THEME_ID, GT_THEME_NAME, GT_TABLE_NAME, GT_WHERE, GT_PK_COLUMN, GT_LABEL_COLUMN, GT_RSE_TABLE_NAME,
	   GT_RSE_FK_COLUMN, GT_ST_CHAIN_COLUMN, GT_END_CHAIN_COLUMN, GT_X_COLUMN, GT_Y_COLUMN, GT_OFFSET_FIELD,
	   GT_FEATURE_TABLE, GT_FEATURE_PK_COLUMN, GT_FEATURE_FK_COLUMN, GT_ROUTE_THEME, GT_XSP_COLUMN )
	values ( gt_id, dty_rec.dty_atv_acty_area_code||'_DEFECTS', dty_rec.dty_atv_acty_area_code||'_DEFECTS',
               null, 'DEF_DEFECT_ID', 'DEF_DEFECT_ID', 'ROAD_SEGS', 'DEF_RSE_HE_ID','DEF_ST_CHAIN', null,
	       null, null, null, null, null, null, 'N', null );

        p_rowcount := p_rowcount + 1;

	insert into gis_theme_functions (
 	   GTF_GT_THEME_ID,
 	   GTF_HMO_MODULE,
 	   GTF_PARAMETER,
 	   GTF_MENU_OPTION )
	values ( gt_id, 'MAI3806', 'RSE_HE_ID', dty_rec.dty_atv_acty_area_code||' Defects by road' );

	insert into gis_theme_functions (
 	   GTF_GT_THEME_ID,
 	   GTF_HMO_MODULE,
 	   GTF_PARAMETER,
 	   GTF_MENU_OPTION )
	values ( gt_id, 'MAI3806', 'GIS_SESSION_ID', 'Query '||dty_rec.dty_atv_acty_area_code||' defects');

	insert into gis_theme_roles
	(gthr_theme_id, gthr_role, gthr_mode )
	values ( gt_id, 'MAI_USER', 'NORMAL' );

--
        hig.execute_ddl( dty_rec.view_string );

        if hig.get_sysopt( 'HIGPUBSYN') = 'Y' then
	   hig.execute_ddl( 'create public synonym '||
			    dty_rec.dty_atv_acty_area_code||'_defects for '||user||'.'||
			    dty_rec.dty_atv_acty_area_code||'_defects' );
        end if;

	end loop;

	commit;

   end;
end;
/
