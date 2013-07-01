CREATE OR REPLACE PACKAGE BODY mairepl AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mairepl.pkb-arc   2.2   Jul 01 2013 16:26:52   James.Wadsworth  $
--       Module Name      : $Workfile:   mairepl.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:26:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:44  $
--       SCCS Version     : $Revision:   2.2  $
--       Based onSCCS Version     : 1.2
--
-----------------------------------------------------------------------------
--
--	This package contains procedures and functions which are required by
--	the Replace / UnReplace processes within Network Manager.
--
--      Maintenance Manager specific functionality can be found here, whilst
--      product specific functionality can be found in separate packages.
--      eg Structures specific logic can be found in STRREPL.PCK .
--
--  Originally taken from '@(#)mairepl.pck 1.13 01/11/02';
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--all global package variables here
--
   g_body_sccsid     CONSTANT  varchar2(2000) := '"$Revision:   2.2  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mairepl';
--
  l_rmmsflag     		varchar2(1) := hig.get_sysopt('RMMSFLAG');
  l_message                     varchar2(80);

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
--
  procedure check_data
	(p_rse_he_id_1	  in number,   	-- section to replace
	 p_rse_he_id_2	  in number,	-- link to replace into
	 p_sect_no   	  in varchar2, 	-- new section to replace into
	 p_effective_date   in date, 	      -- effective date of replace
	 p_errors    	  in out number,
	 p_error_string	  in out varchar2) is
  --
  -- Checks that the user has supplied valid parameters.
  --

  begin

    maisplit.check_data(p_rse_he_id_1, null, p_effective_date, p_errors, p_error_string);

  end check_data;

-----------------------------------------------------------------------------

  procedure replace_data
	(p_rse_he_id_new    in number,      -- new section
	 p_rse_he_id        in number,  	-- section replaced
	 p_effective_date   in date) is    	-- effective date of replace

    l_are_report_id	number;
    l_def_defect_id	number;
    l_table_name		varchar2(32);
    l_actioned_date	varchar2(22) := to_char(sysdate ,'DD-MON-YYYY,HH24:MI:SS');
    l_actioned	        date := to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS');
    l_rse_length_1	number;
    l_rse_sys_flag      varchar2(1);

    cursor c1 is
      select rse_length, rse_sys_flag
      from   road_sections
      where  rse_he_id = p_rse_he_id;

    cursor c2 is
      select are_report_id_seq.nextval
      from   dual;

    cursor c3 is
      select def_defect_id_seq.nextval
      from   dual;

    cursor c_open_insp is
      select are_report_id
      ,      are_st_chain
      ,      are_end_chain
      from   activities_report
      where  are_report_id  in (select def_are_report_id
                                from   defects
                                ,      repairs
                                where  not exists (select 'x'
                                                   from   work_order_lines
                                                   where  wol_def_defect_id = rep_def_defect_id
                                                   and    wol_rep_action_cat = rep_action_cat)
                                and    rep_date_completed  is null
                                and    rep_def_defect_id   = def_defect_id
                                and    def_superseded_flag = 'N'
                                and    def_rse_he_id       = p_rse_he_id);

    cursor c_defects(l_insp number) is
      select def_defect_id
      ,      nvl(def_st_chain,0) def_st_chain
      from   defects
      where  def_defect_id in (select rep_def_defect_id
                               from   repairs
                               where  rep_date_completed is null
                               and    not exists (select 'x'
                                                  from   work_order_lines
                                                  where  wol_def_defect_id = rep_def_defect_id
                                                  and    wol_rep_action_cat = rep_action_cat))
      and    def_superseded_flag = 'N'
      and    def_are_report_id   = l_insp;

--    cursor c7 is
--      select iit_item_id      old_item
--      ,      iit_primary_key  iit_primary_key
--      ,      iih_new_item_id  new_item
--      from   inv_items_all
--      ,      inv_item_history
--      where  iit_primary_key is not null
--      and    iit_item_id = iih_item_id
--      and    iih_new_rse_he_id = p_rse_he_id_new;

  begin

    open c1;
    fetch c1 into l_rse_length_1, l_rse_sys_flag;
    close c1;

-----------------------------------------------------------------------------
--
--   INVENTORY
--
-----------------------------------------------------------------------------
--    insert into inv_item_history (
--        IIH_CREATED_DATE, IIH_NEW_ITEM_ID,
--        IIH_INV_CODE, IIH_NEW_RSE_HE_ID,
--        IIH_ST_CHAIN, IIH_END_CHAIN,
--        IIH_X_SECT, IIH_ITEM_ID, IIH_RSE_HE_ID,
--        IIH_LAST_UPDATED_DATE, IIH_END_DATE, IIH_OPERATION
--       )
--    select iit_created_date,iit_item_id_seq.nextval,
--           iit_ity_inv_code,p_rse_he_id_new,
--           iit_st_chain,iit_end_chain,
--           iit_x_sect, iit_item_id, p_rse_he_id,
--           iit_last_updated_date, iit_end_date, 'REPLACE'
--    from   inv_items
--    where  iit_rse_he_id = p_rse_he_id;
----
--    insert into inv_items
--    ( IIT_CREATED_DATE, IIT_CRE_DATE, IIT_ITEM_ID, IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, IIT_LAST_UPDATED_DATE,
--      IIT_RSE_HE_ID, IIT_ST_CHAIN, IIT_ANGLE, IIT_ANGLE_TXT, IIT_CLASS, IIT_CLASS_TXT,
--      IIT_COLOUR, IIT_COLOUR_TXT, IIT_COORD_FLAG, IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE,
--      IIT_END_CHAIN, IIT_END_DATE, IIT_GAP, IIT_HEIGHT, IIT_HEIGHT_2, IIT_ID_CODE,
--      IIT_INSTAL_DATE, IIT_INVENT_DATE, IIT_INV_OWNERSHIP, IIT_ITEMCODE, IIT_LCO_LAMP_CONFIG_ID, IIT_LENGTH,
--      IIT_MATERIAL, IIT_MATERIAL_TXT, IIT_METHOD, IIT_METHOD_TXT, IIT_NOTE, IIT_NO_OF_UNITS,
--      IIT_OPTIONS, IIT_OPTIONS_TXT, IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER, IIT_OWNER_TXT, IIT_PEO_INVENT_BY_ID,
--      IIT_PHOTO, IIT_POWER, IIT_PROV_FLAG, IIT_REV_BY, IIT_REV_DATE, IIT_TYPE,
--      IIT_TYPE_TXT, IIT_WIDTH, IIT_XTRA_CHAR_1, IIT_XTRA_DATE_1, IIT_XTRA_DOMAIN_1, IIT_XTRA_DOMAIN_TXT_1,
--      IIT_XTRA_NUMBER_1, IIT_X_SECT, IIT_PRIMARY_KEY, IIT_FOREIGN_KEY, IIT_DET_XSP, IIT_OFFSET,
-- IIT_NUM_ATTRIB16, IIT_NUM_ATTRIB17,
--      IIT_NUM_ATTRIB18, IIT_NUM_ATTRIB19, IIT_NUM_ATTRIB20, IIT_NUM_ATTRIB21, IIT_NUM_ATTRIB22, IIT_NUM_ATTRIB23,
--      IIT_NUM_ATTRIB24, IIT_NUM_ATTRIB25, IIT_CHR_ATTRIB26, IIT_CHR_ATTRIB27, IIT_CHR_ATTRIB28, IIT_CHR_ATTRIB29,
--      IIT_CHR_ATTRIB30, IIT_CHR_ATTRIB31, IIT_CHR_ATTRIB32, IIT_CHR_ATTRIB33, IIT_CHR_ATTRIB34, IIT_CHR_ATTRIB35,
--      IIT_CHR_ATTRIB36, IIT_CHR_ATTRIB37, IIT_CHR_ATTRIB38, IIT_CHR_ATTRIB39, IIT_CHR_ATTRIB40, IIT_CHR_ATTRIB41,
--      IIT_CHR_ATTRIB42, IIT_CHR_ATTRIB43, IIT_CHR_ATTRIB44, IIT_CHR_ATTRIB45, IIT_CHR_ATTRIB46, IIT_CHR_ATTRIB47,
--      IIT_CHR_ATTRIB48, IIT_CHR_ATTRIB49, IIT_CHR_ATTRIB50, IIT_CHR_ATTRIB51, IIT_CHR_ATTRIB52, IIT_CHR_ATTRIB53,
--      IIT_CHR_ATTRIB54, IIT_CHR_ATTRIB55, IIT_CHR_ATTRIB56, IIT_CHR_ATTRIB57, IIT_CHR_ATTRIB58, IIT_CHR_ATTRIB59,
--      IIT_CHR_ATTRIB60, IIT_CHR_ATTRIB61, IIT_CHR_ATTRIB62, IIT_CHR_ATTRIB63, IIT_CHR_ATTRIB64, IIT_CHR_ATTRIB65,
--      IIT_CHR_ATTRIB66, IIT_CHR_ATTRIB67, IIT_CHR_ATTRIB68, IIT_CHR_ATTRIB69, IIT_CHR_ATTRIB70, IIT_CHR_ATTRIB71,
--      IIT_CHR_ATTRIB72, IIT_CHR_ATTRIB73, IIT_CHR_ATTRIB74, IIT_CHR_ATTRIB75, IIT_NUM_ATTRIB76, IIT_NUM_ATTRIB77,
--      IIT_NUM_ATTRIB78, IIT_NUM_ATTRIB79, IIT_NUM_ATTRIB80, IIT_NUM_ATTRIB81, IIT_NUM_ATTRIB82, IIT_NUM_ATTRIB83,
--      IIT_NUM_ATTRIB84, IIT_NUM_ATTRIB85, IIT_DATE_ATTRIB86, IIT_DATE_ATTRIB87, IIT_DATE_ATTRIB88, IIT_DATE_ATTRIB89,
--      IIT_DATE_ATTRIB90, IIT_DATE_ATTRIB91, IIT_DATE_ATTRIB92, IIT_DATE_ATTRIB93, IIT_DATE_ATTRIB94, IIT_DATE_ATTRIB95 )
--    select p_effective_date, p_effective_date, iih_new_item_id, IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, p_effective_date,
--           iih_new_rse_he_id, IIT_ST_CHAIN, IIT_ANGLE, IIT_ANGLE_TXT, IIT_CLASS, IIT_CLASS_TXT,
--           IIT_COLOUR, IIT_COLOUR_TXT, 'I', IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE,
--           iit_end_chain, IIT_END_DATE, IIT_GAP, IIT_HEIGHT, IIT_HEIGHT_2, IIT_ID_CODE,
--           IIT_INSTAL_DATE, IIT_INVENT_DATE, IIT_INV_OWNERSHIP, IIT_ITEMCODE, IIT_LCO_LAMP_CONFIG_ID, IIT_LENGTH,
--           IIT_MATERIAL, IIT_MATERIAL_TXT, IIT_METHOD, IIT_METHOD_TXT, IIT_NOTE, IIT_NO_OF_UNITS,
--           IIT_OPTIONS, IIT_OPTIONS_TXT, IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER, IIT_OWNER_TXT, IIT_PEO_INVENT_BY_ID,
--           IIT_PHOTO, IIT_POWER, IIT_PROV_FLAG, IIT_REV_BY, IIT_REV_DATE, IIT_TYPE,
--           IIT_TYPE_TXT, IIT_WIDTH, IIT_XTRA_CHAR_1, IIT_XTRA_DATE_1, IIT_XTRA_DOMAIN_1, IIT_XTRA_DOMAIN_TXT_1,
--           IIT_XTRA_NUMBER_1, IIT_X_SECT, null, IIT_FOREIGN_KEY, IIT_DET_XSP , IIT_OFFSET,
--           IIT_NUM_ATTRIB16, IIT_NUM_ATTRIB17,
--           IIT_NUM_ATTRIB18, IIT_NUM_ATTRIB19, IIT_NUM_ATTRIB20, IIT_NUM_ATTRIB21, IIT_NUM_ATTRIB22, IIT_NUM_ATTRIB23,
--           IIT_NUM_ATTRIB24, IIT_NUM_ATTRIB25, IIT_CHR_ATTRIB26, IIT_CHR_ATTRIB27, IIT_CHR_ATTRIB28, IIT_CHR_ATTRIB29,
--           IIT_CHR_ATTRIB30, IIT_CHR_ATTRIB31, IIT_CHR_ATTRIB32, IIT_CHR_ATTRIB33, IIT_CHR_ATTRIB34, IIT_CHR_ATTRIB35,
--           IIT_CHR_ATTRIB36, IIT_CHR_ATTRIB37, IIT_CHR_ATTRIB38, IIT_CHR_ATTRIB39, IIT_CHR_ATTRIB40, IIT_CHR_ATTRIB41,
--           IIT_CHR_ATTRIB42, IIT_CHR_ATTRIB43, IIT_CHR_ATTRIB44, IIT_CHR_ATTRIB45, IIT_CHR_ATTRIB46, IIT_CHR_ATTRIB47,
--           IIT_CHR_ATTRIB48, IIT_CHR_ATTRIB49, IIT_CHR_ATTRIB50, IIT_CHR_ATTRIB51, IIT_CHR_ATTRIB52, IIT_CHR_ATTRIB53,
--           IIT_CHR_ATTRIB54, IIT_CHR_ATTRIB55, IIT_CHR_ATTRIB56, IIT_CHR_ATTRIB57, IIT_CHR_ATTRIB58, IIT_CHR_ATTRIB59,
--           IIT_CHR_ATTRIB60, IIT_CHR_ATTRIB61, IIT_CHR_ATTRIB62, IIT_CHR_ATTRIB63, IIT_CHR_ATTRIB64, IIT_CHR_ATTRIB65,
--           IIT_CHR_ATTRIB66, IIT_CHR_ATTRIB67, IIT_CHR_ATTRIB68, IIT_CHR_ATTRIB69, IIT_CHR_ATTRIB70, IIT_CHR_ATTRIB71,
--           IIT_CHR_ATTRIB72, IIT_CHR_ATTRIB73, IIT_CHR_ATTRIB74, IIT_CHR_ATTRIB75, IIT_NUM_ATTRIB76, IIT_NUM_ATTRIB77,
--           IIT_NUM_ATTRIB78, IIT_NUM_ATTRIB79, IIT_NUM_ATTRIB80, IIT_NUM_ATTRIB81, IIT_NUM_ATTRIB82, IIT_NUM_ATTRIB83,
--           IIT_NUM_ATTRIB84, IIT_NUM_ATTRIB85, IIT_DATE_ATTRIB86, IIT_DATE_ATTRIB87, IIT_DATE_ATTRIB88, IIT_DATE_ATTRIB89,
--           IIT_DATE_ATTRIB90, IIT_DATE_ATTRIB91, IIT_DATE_ATTRIB92, IIT_DATE_ATTRIB93, IIT_DATE_ATTRIB94, IIT_DATE_ATTRIB95
--    from   inv_items, inv_item_history
--    where  iit_rse_he_id = p_rse_he_id
--    and    iit_item_id = iih_item_id
--    and    iih_new_rse_he_id = p_rse_he_id_new;
--  --
--  -- Close all inventory attached to the road section being replaced.
--  --
--    update inv_items
--    set    iit_end_date = p_effective_date,
--           iit_coord_flag = decode(iit_coord_flag,'I',null,'D') ,
--           iit_last_updated_date = p_effective_date
--    where  iit_rse_he_id = p_rse_he_id;
--
--  --
--  -- remove iit_primary_key from end-dated iit records and
--  -- add to new ones
--  --
--    for i in c7 loop
--      update inv_items_all
--      set    iit_primary_key = null
--      where  iit_item_id = i.old_item;
--
--      update inv_items_all
--      set    iit_primary_key = i.iit_primary_key
--      where  iit_item_id = i.new_item;
--    end loop;

-----------------------------------------------------------------------------
--
--   ACTIVITY REPORTS, DEFECTS, REPAIRS
--
-----------------------------------------------------------------------------

  for i in c_open_insp loop
    open c2;
    fetch c2 into l_are_report_id;
    close c2;
    maisplit.create_new_insp(i.are_report_id
                            ,l_are_report_id
                            ,p_rse_he_id_new
                            ,i.are_st_chain
                            ,i.are_end_chain
                            ,p_effective_date);
    for j in c_defects(i.are_report_id) loop
      open c3;
      fetch c3 into l_def_defect_id;
      close c3;
      maisplit.create_new_defect(j.def_defect_id
                                ,l_def_defect_id
                                ,p_rse_he_id_new
                                ,l_are_report_id
                                ,j.def_st_chain
                                ,p_effective_date);
    end loop;
  end loop;

-----------------------------------------------------------------------------
--
--   EXTERNAL ACTS
--
-----------------------------------------------------------------------------

    insert into ext_act_road_usage
        ( 	EXU_RSE_HE_ID,
          	EXU_EXT_ID,
          	EXU_CURRENT,
          	EXU_START_DATE,
          	EXU_SIGN_OFF_DATE,
         	EXU_CREATED_DATE,
         	EXU_LAST_UPDATED_DATE
         )
    select 	p_rse_he_id_new,
		EXU_EXT_ID,
		EXU_CURRENT,
		EXU_START_DATE,
		EXU_SIGN_OFF_DATE,
		to_date( l_actioned_date,'DD-MON-YYYY,HH24:MI:SS'),
		to_date( l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
    from   	EXT_ACT_ROAD_USAGE
    where  	EXU_RSE_HE_ID = p_rse_he_id
    and    	l_rmmsflag in ('3','4');

    update  ext_act_road_usage
    set 	exu_sign_off_date = p_effective_date,
	 	exu_current = null,
	 	EXU_LAST_UPDATED_DATE = to_date(l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
    where 	exu_rse_he_id = p_rse_he_id
    and 	l_rmmsflag in ('3','4');


-----------------------------------------------------------------------------
--
--   FREQUENCIES
--
-----------------------------------------------------------------------------

   --local_freq
    insert into local_freqs
        (lfr_atv_acty_area_code,lfr_int_code,
        lfr_rse_he_id,lfr_approved_by,
        lfr_approved_ref,lfr_date_approved,
        lfr_descr,lfr_end_chain,lfr_ity_inv_code,
        lfr_start_chain,lfr_ity_sys_flag)
    select lfr_atv_acty_area_code,lfr_int_code,
        p_rse_he_id_new,lfr_approved_by,
        lfr_approved_ref,lfr_date_approved,lfr_descr,
        lfr_end_chain,
        lfr_ity_inv_code,lfr_start_chain,
        lfr_ity_sys_flag
        from local_freqs
    where lfr_rse_he_id = p_rse_he_id;

  --section_freq
    INSERT INTO SECTION_FREQS
        (	 SFR_ATV_ACTY_AREA_CODE,
        	SFR_INT_CODE,
        	SFR_RSE_HE_ID )
    SELECT 	SFR_ATV_ACTY_AREA_CODE,
		SFR_INT_CODE,
		p_rse_he_id_new
    FROM	SECTION_FREQS
    WHERE 	SFR_RSE_HE_ID = p_rse_he_id;


-----------------------------------------------------------------------------
--
--   STRUCTURAL PROJECTS
--
-----------------------------------------------------------------------------

    update scheme_roads
    set    rse_he_id = p_rse_he_id_new
    where  rse_he_id = p_rse_he_id;

  end replace_data;

-----------------------------------------------------------------------------
--**** UNREPLACE PROCEDURES *****
-----------------------------------------------------------------------------

  procedure check_data_unreplace
	(p_id       	in number,
	 p_actioned_date	in varchar2,
	 p_errors    	in out number,
	 p_error_string	in out varchar2) is
  --
  -- Checks that the user has supplied valid parameters.
--  --
--  cursor c1 is
--    select seh_he_id_two_1
--    from   sect_hist
--    where  seh_merge_type = 'R'
--    and    seh_he_id_one = p_id;
--
--    l_id sect_hist.seh_he_id_two_1%TYPE;

  begin
--    open c1;
--    fetch c1 into l_id;
--    close c1;
     Null;
--    maisplit.data_check(l_id, p_actioned_date, p_errors, p_error_string);

  end check_data_unreplace;

-----------------------------------------------------------------------------

  procedure unreplace_data
	(p_id_orig    	in number,		-- section to be unreplaced
	 p_id_del       	in number,		-- section to be deleted
	 p_history_date 	in date) is

    l_unactioned_date 	varchar2(22) := to_char(SYSDATE,'DD-MON-YYYY,HH24:MI:SS');
    l_dummy			number(1);


--    cursor c3 is
--      select iih_item_id      old_item
--      ,      iit_primary_key  iit_primary_key
--      ,      iit_item_id      new_item
--      from   inv_items_all
--      ,      inv_item_history
--      where  iit_primary_key is not null
--      and    iit_item_id = iih_new_item_id
--      and    iih_new_rse_he_id = p_id_del;

  begin




-----------------------------------------------------------------------------
--
--   DEFECTS AND REPAIRS
--
-----------------------------------------------------------------------------

   DELETE FROM temp_undo_defect_edit;  -- a global temp table
--
   INSERT INTO temp_undo_defect_edit (def_defect_id  -- a global temp table
                                    ,def_rse_he_id
                                    ,def_iit_item_id
                                    ,def_st_chain
                                    ,def_are_report_id
                                    ,def_atv_acty_area_code
                                    ,def_siss_id
                                    ,def_works_order_no
                                    ,def_created_date
                                    ,def_defect_code
                                    ,def_last_updated_date
                                    ,def_orig_priority
                                    ,def_priority
                                    ,def_status_code
                                    ,def_superseded_flag
                                    ,def_area
                                    ,def_are_id_not_found
                                    ,def_coord_flag
                                    ,def_date_compl
                                    ,def_date_not_found
                                    ,def_defect_class
                                    ,def_defect_descr
                                    ,def_defect_type_descr
                                    ,def_diagram_no
                                    ,def_height
                                    ,def_ident_code
                                    ,def_ity_inv_code
                                    ,def_ity_sys_flag
                                    ,def_length
                                    ,def_locn_descr
                                    ,def_maint_wo
                                    ,def_mand_adv
                                    ,def_notify_org_id
                                    ,def_number
                                    ,def_per_cent
                                    ,def_per_cent_orig
                                    ,def_per_cent_rem
                                    ,def_rechar_org_id
                                    ,def_serial_no
                                    ,def_skid_coeff
                                    ,def_special_instr
                                    ,def_superseded_id
                                    ,def_time_hrs
                                    ,def_time_mins
                                    ,def_update_inv
                                    ,def_x_sect
                                    ,def_easting
                                    ,def_northing
                                    ,def_response_category
                                    ,def_status_reason
                                    ,def_inspection_date)
   SELECT def_defect_id
         ,def_rse_he_id
         ,def_iit_item_id
         ,def_st_chain
         ,def_are_report_id
         ,def_atv_acty_area_code
         ,def_siss_id
         ,def_works_order_no
         ,def_created_date
         ,def_defect_code
         ,def_last_updated_date
         ,def_orig_priority
         ,def_priority
         ,def_status_code
         ,def_superseded_flag
         ,def_area
         ,def_are_id_not_found
         ,def_coord_flag
         ,def_date_compl
         ,def_date_not_found
         ,def_defect_class
         ,def_defect_descr
         ,def_defect_type_descr
         ,def_diagram_no
         ,def_height
         ,def_ident_code
         ,def_ity_inv_code
         ,def_ity_sys_flag
         ,def_length
         ,def_locn_descr
         ,def_maint_wo
         ,def_mand_adv
         ,def_notify_org_id
         ,def_number
         ,def_per_cent
         ,def_per_cent_orig
         ,def_per_cent_rem
         ,def_rechar_org_id
         ,def_serial_no
         ,def_skid_coeff
         ,def_special_instr
         ,def_superseded_id
         ,def_time_hrs
         ,def_time_mins
         ,def_update_inv
         ,def_x_sect
         ,def_easting
         ,def_northing
         ,def_response_category
         ,def_status_reason
         ,def_inspection_date
   FROM DEFECTS
   WHERE def_rse_he_id = p_id_del;


  --
  -- Delete the defects belonging to the section which were created from the replace.
  --
    delete from defects
    where def_rse_he_id = p_id_del;

  --
  -- repair update
    update repairs
    set    rep_superseded_flag = 'N',
           rep_last_updated_date = to_date(l_unactioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  rep_def_defect_id in (select def.def_defect_id
                                 from   defects def
                                 ,      temp_undo_defect_edit tmp
                                 where  def.def_superseded_id = tmp.def_defect_id)
    and    not exists (select 'x'
                       from   work_order_lines
                       where  wol_rep_action_cat = rep_action_cat
                       and    wol_def_defect_id = rep_def_defect_id);

  -- boq items update
    update boq_items
    set    boq_defect_id = (select def.def_defect_id
                            from   defects def
                            ,      temp_undo_defect_edit tmp
                            where  def.def_superseded_id = tmp.def_defect_id
                            and    tmp.def_defect_id = boq_defect_id)
    where  boq_defect_id in (select tmp2.def_defect_id
                             from   temp_undo_defect_edit tmp2
                             where  tmp2.def_rse_he_id = p_id_del);

  --
    update defects def
    set    def.def_date_compl = null,
           def.def_last_updated_date = to_date(l_unactioned_date ,'DD-MON-YYYY,HH24:MI:SS'),
           def.def_status_code = (select tmp1.def_status_code
                                  from   temp_undo_defect_edit tmp1
                                  where  tmp1.def_defect_id = def.def_superseded_id
                                  and    tmp1.def_rse_he_id = p_id_del),
           def.def_superseded_id = null,
           def.def_superseded_flag = 'N'
    where  def.def_superseded_id IN (select tmp.def_defect_id
                                     from   temp_undo_defect_edit tmp
                                     where  tmp.def_rse_he_id = p_id_del)
    and    def.def_rse_he_id = p_id_orig;


  -- repair delete
    delete from REPAIRS R
    where not exists
         (select 'maintain referential integrity'
          from   DEFECTS D
          where  D.DEF_DEFECT_ID = R.REP_DEF_DEFECT_ID);


-----------------------------------------------------------------------------
--
--   EXTERNAL ACTS
--
-----------------------------------------------------------------------------
    delete from ext_act_road_usage
    where  exu_rse_he_id = p_id_del
    and    l_rmmsflag in ('3','4');

  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  --This code was not called in NET1710.RPT
  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    update ext_act_road_usage
    set    exu_sign_off_date = null,
 	     exu_current = 'Y',
	     exu_last_updated_date = to_date(l_unactioned_date,
					     'DD-MON-YYYY,HH24:MI:SS')
    where  exu_rse_he_id = p_id_orig
    and    l_rmmsflag in ('3','4');


-----------------------------------------------------------------------------
--
--   ACTIVITIES
--
-----------------------------------------------------------------------------
    delete from act_report_lines
    where  arl_are_report_id in
	    (select are_report_id
	     from activities_report
           where are_rse_he_id = p_id_del);

    delete from activities_report
    where are_rse_he_id = p_id_del;

-----------------------------------------------------------------------------
--
--   FREQUENCIES
--
-----------------------------------------------------------------------------
    delete from section_freqs
    where sfr_rse_he_id = p_id_del;

    delete from local_freqs
    where lfr_rse_he_id = p_id_del;

-----------------------------------------------------------------------------
--
--   STRUCTURAL PROJECTS
--
-----------------------------------------------------------------------------
    update scheme_roads
    set    rse_he_id = p_id_orig
    where  rse_he_id = p_id_del;

  end unreplace_data;
--
-----------------------------------------------------------------------------
--
END mairepl;
/
