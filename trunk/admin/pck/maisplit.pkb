CREATE OR REPLACE PACKAGE BODY maisplit AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maisplit.pkb-arc   2.2   Feb 23 2009 10:41:38   jwadsworth  $
--       Module Name      : $Workfile:   maisplit.pkb  $
--       Date into SCCS   : $Date:   Feb 23 2009 10:41:38  $
--       Date fetched Out : $Modtime:   Feb 23 2009 10:39:56  $
--       SCCS Version     : $Revision:   2.2  $
--       Based onSCCS Version     : 1.7
--
-- This package contains procedures and functions which are required by
-- the Split process within Network Manager.
--
-- Maintenance Manager specific functionality can be found here,
-- whilst the core functionality of the network processes can be found
-- in the HIGSPLIT package.
--
-- Originally taken from '@(#)maisplit.pck 1.14 01/11/02';
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------
--
--all global package variables here
--
   g_body_sccsid     CONSTANT  varchar2(2000) := '$Revision:   2.2  $';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'maisplit';
--
--
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
-----------------------------------------------------------------------------
--**** SPLIT PROCEDURES *****
-----------------------------------------------------------------------------

  procedure check_data (p_id        in     number,
                        p_chain     in     number,
                        p_effective in     date,
                        p_errors    in out number,
                        p_err_text  in out varchar2) is
  --
  -- Before a section is split, associated Maint. Manager data is checked here.
  -- Associated data for other products is checked in separate procedures
  -- eg. Structures data is checked in the STRSPLIT.CHECK_DATA procedure.
  --

    l_rse_sys_flag        road_segs.rse_sys_flag%type;
    l_rse_agency          road_segs.rse_agency%type;
    l_rse_linkcode        road_segs.rse_linkcode%type;
    l_rse_sect_no         road_segs.rse_sect_no%type;
    l_rse_length          road_segs.rse_length%type;
    l_rse_start_date      road_segs.rse_start_date%type;

    l_message      varchar2(80);

    cursor c1 is
      select rse_sys_flag,
             rse_agency,
             rse_linkcode,
             rtrim(rse_sect_no),
             rse_length,
             rse_start_date
      from   road_segs
      where  rse_he_id = p_id;

--    cursor c2 is
--      select 'ERROR : Inventory created or made historical after Effective Date'
--      from   inv_items_all
--      where  iit_rse_he_id = p_id
--      and    p_effective < greatest(trunc(iit_cre_date),
--             nvl(trunc(iit_end_date), p_effective));

    cursor c3 is
      select 'ERROR : Inspection or work completed after Effective Date'
      from   activities_report
      where  are_rse_he_id = p_id
      and    p_effective < nvl(trunc(are_date_work_done), p_effective+1);

    cursor c4 is
      select 'ERROR : Defects completed after Effective Date'
      from   defects
      where  def_rse_he_id = p_id
      and    nvl(trunc(def_date_compl), p_effective) > p_effective;
--
-- SM 09022006 - Removed the check for the wor_date_closed is null so that the edit can be done regardless of
-- open works orders.
--
    cursor c5 is
      select 'ERROR : Work Orders open or completed after Effective Date'
      from   work_orders,
             work_order_lines
      where  wor_works_order_no = wol_works_order_no
      and    wol_rse_he_id = p_id
      and   (/*wor_date_closed is null
      or     */p_effective < trunc(wor_date_closed));

    cursor c6 is
      select 'ERROR : Ext Activity Road Usages open or closed after Effective Date'
      from   ext_act_road_usage
      where  exu_rse_he_id = p_id
      and    (exu_sign_off_date is null
       or     trunc(exu_sign_off_date) > p_effective);

    cursor c7 is
      select 'ERROR : Incomplete Inventory (Stage1) Load'
      from   hhinv_load_1
      where  rec_type = 'B'
      and    substr(full_value,1,10) = upper( l_rse_agency||l_rse_linkcode)
      and   (decode(l_rse_sys_flag,'D',SUBSTR(full_value,12,2)
                                ,SUBSTR(full_value,12,5)))=upper(l_rse_sect_no);
  --
  -- if Stage1 suceeds, then subsequent stages might fail for various reasons
  -- including Inventory having been loaded for a Section which has not yet
  -- been created; so test not only RSE_HE_ID but also Agency, Link, Section
  -- NOTE: this test will identify any stage after Stage1 which is incomplete
  --
    cursor c8 is
      select 'ERROR : Incomplete Inventory (non-Stage1) load'
      from   hhinv_sect_log HSL
      where ((HSL.linkcode = upper(l_rse_agency||l_rse_linkcode) and
              HSL.section_code = upper(l_rse_sect_no))
       or    (HSL.linkcode = upper(l_rse_linkcode) and
              HSL.section_code = upper(l_rse_sect_no))
       or    (HSL.he_id = p_id)
             )
      and    (HSL.error_msg IS NOT NULL OR
              HSL.error_level IS NOT NULL);

    cursor c9 is
      select 'ERROR : Incomplete Inspection load'
      from   hh_load_recs HLR
      where  upper( HLR.record_type) = 'G'
      and    RTRIM(SUBSTR( HLR.record_text,1,INSTR( HLR.record_text,',')),',')||
             LTRIM(SUBSTR( HLR.record_text,INSTR( HLR.record_text,','),
            (INSTR( HLR.record_text,',',1,2)-INSTR( HLR.record_text,','))),', 0') =
             upper(l_rse_agency||l_rse_linkcode||LTRIM(l_rse_sect_no,'0 '));

    begin

    open c1;
    fetch c1 into l_rse_sys_flag,
             l_rse_agency,
             l_rse_linkcode,
             l_rse_sect_no,
             l_rse_length,
             l_rse_start_date;
    close c1;

--    open c2;
--    fetch c2 into l_message;
--    if c2%found then
--      p_errors := p_errors + 1;
--      dbms_output.put_line(l_message);
--      p_err_text := l_message;
--    end if;
--    close c2;

    open c3;
    fetch c3 into l_message;
    if c3%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_err_text := p_err_text||chr(13)||l_message;
    end if;
    close c3;

    open c4;
    fetch c4 into l_message;
    if c4%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_err_text := p_err_text||chr(13)||l_message;
    end if;
    close c4;

    open c5;
    fetch c5 into l_message;
    if c5%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_err_text := p_err_text||chr(13)||l_message;
    end if;
    close c5;

    open c6;
    fetch c6 into l_message;
    if c6%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_err_text := p_err_text||chr(13)||l_message;
    end if;
    close c6;

    open c7;
    fetch c7 into l_message;
    if c7%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_err_text := p_err_text||chr(13)||l_message;
    end if;
    close c7;

    open c8;
    fetch c8 into l_message;
    if c8%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_err_text := p_err_text||chr(13)||l_message;
    end if;
    close c8;

    open c9;
    fetch c9 into l_message;
    if c9%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_err_text := p_err_text||chr(13)||l_message;
    end if;
    close c9;

    end check_data;

-----------------------------------------------------------------------------
  procedure create_new_insp (p_old_insp in number
                            ,p_new_insp in number
                            ,p_road     in number
                            ,p_start    in number
                            ,p_end      in number
                            ,p_actioned in date) is
  begin
  -- create new inspection
    insert into activities_report
      (are_maint_insp_flag,
       are_report_id,
       are_rse_he_id,
       are_date_work_done,
       are_end_chain,
       are_initiation_type,
       are_peo_person_id_actioned,
       are_st_chain,
       are_insp_load_date,
       are_wol_works_order_no,
       are_sched_act_flag,
       are_created_date,
       are_last_updated_date,
       are_batch_id,
       are_peo_person_id_insp2,
       are_surface_condition,
       are_weather_condition)
    select a2.are_maint_insp_flag
    ,      p_new_insp
    ,      p_road
    ,      a2.are_date_work_done
    ,      p_end
    ,      a2.are_initiation_type
    ,      a2.are_peo_person_id_actioned
    ,      p_start
    ,      a2.are_insp_load_date
    ,      a2.are_wol_works_order_no
    ,      a2.are_sched_act_flag
    ,      a2.are_created_date
    ,      p_actioned
    ,      a2.are_batch_id
    ,      a2.are_peo_person_id_insp2
    ,      a2.are_surface_condition
    ,      a2.are_weather_condition
    from   activities_report a2
    where  a2.are_report_id = p_old_insp;

  -- insert activity codes for new inspection
    insert into act_report_lines
      (arl_act_status,
       arl_are_report_id,
       arl_atv_acty_area_code,
       arl_not_seq_flag,
       arl_report_id_part_of,
       arl_created_date,
       arl_last_updated_date)
    select 'C'
    ,      p_new_insp
    ,      arl2.arl_atv_acty_area_code
    ,      ''
    ,      ''
    ,      arl2.arl_created_date
    ,      p_actioned
    from   act_report_lines arl2
    where  arl2.arl_are_report_id = p_old_insp;

  end create_new_insp;
-----------------------------------------------------------------------------
  procedure create_new_defect (p_old_defect in number
                              ,p_new_defect in number
                              ,p_road       in number
                              ,p_new_insp   in number
                              ,p_st_chain   in number
                              ,p_actioned   in date) is

  cursor c_superceded_status is
    select hsc_status_code
    from   hig_status_codes
    where  hsc_allow_feature8 = 'Y'
    and    hsc_domain_code = 'DEFECTS';

  cursor c_boq is
    select boq_id
    ,      boq_defect_id
    from   boq_items
    ,      repairs
    where  boq_defect_id = rep_def_defect_id
    and    boq_rep_action_cat = rep_action_cat
    and    rep_date_completed is null
    and    not exists (select 'x'
                       from   work_order_lines
                       where  wol_rep_action_cat = rep_action_cat
                       and    wol_def_defect_id = rep_def_defect_id)
    and    rep_def_defect_id = p_old_defect
  for update of boq_defect_id;

  cursor c_get_table_descr is
    select das_table_name
      from doc_assocs
     where das_rec_id = to_char(p_old_defect);

  l_superceded  hig_status_codes.hsc_status_code%TYPE;
  l_table_descr doc_assocs.das_table_name%TYPE;

  begin

    open c_superceded_status;
    fetch c_superceded_status into l_superceded;
    close c_superceded_status;

    insert into defects
      (DEF_DEFECT_ID, DEF_RSE_HE_ID, DEF_IIT_ITEM_ID, DEF_ST_CHAIN,
       DEF_ARE_REPORT_ID, DEF_ATV_ACTY_AREA_CODE, DEF_SISS_ID, DEF_WORKS_ORDER_NO,
       DEF_CREATED_DATE, DEF_DEFECT_CODE, DEF_LAST_UPDATED_DATE, DEF_ORIG_PRIORITY,
       DEF_PRIORITY, DEF_STATUS_CODE, DEF_SUPERSEDED_FLAG, DEF_AREA,
       DEF_ARE_ID_NOT_FOUND, DEF_COORD_FLAG, DEF_DATE_COMPL, DEF_DATE_NOT_FOUND,
       DEF_DEFECT_CLASS, DEF_DEFECT_DESCR, DEF_DEFECT_TYPE_DESCR, DEF_DIAGRAM_NO,
       DEF_HEIGHT, DEF_IDENT_CODE, DEF_ITY_INV_CODE, DEF_ITY_SYS_FLAG,
       DEF_LENGTH, DEF_LOCN_DESCR, DEF_MAINT_WO, DEF_MAND_ADV,
       DEF_NOTIFY_ORG_ID, DEF_NUMBER, DEF_PER_CENT, DEF_PER_CENT_ORIG,
       DEF_PER_CENT_REM, DEF_RECHAR_ORG_ID, DEF_SERIAL_NO, DEF_SKID_COEFF,
       DEF_SPECIAL_INSTR, DEF_SUPERSEDED_ID, DEF_TIME_HRS, DEF_TIME_MINS,
       DEF_UPDATE_INV, DEF_X_SECT, DEF_NORTHING, DEF_EASTING,
       DEF_RESPONSE_CATEGORY)
    select p_new_defect, p_road, iih_new_item_id, p_st_chain,
           p_new_insp, def_atv_acty_area_code, def_siss_id, def_works_order_no,
           def_created_date, def_defect_code, p_actioned, def_orig_priority,
           def_priority, def_status_code, def_superseded_flag, def_area,
           def_are_id_not_found, def_coord_flag, def_date_compl, def_date_not_found,
           def_defect_class, def_defect_descr, def_defect_type_descr, def_diagram_no,
           def_height, def_ident_code, def_ity_inv_code, def_ity_sys_flag,
           def_length, def_locn_descr, def_maint_wo, def_mand_adv,
           def_notify_org_id, def_number, def_per_cent, def_per_cent_orig,
           def_per_cent_rem, def_rechar_org_id, def_serial_no, def_skid_coeff,
           def_special_instr, def_superseded_id, def_time_hrs, def_time_mins,
           def_update_inv, def_x_sect, def_northing, def_easting, def_response_category
    from   inv_item_history
    ,      defects
    where  iih_new_rse_he_id(+) = p_road
    and    iih_item_id(+) = def_iit_item_id
    and    def_defect_id = p_old_defect;

    open c_get_table_descr;
    fetch c_get_table_descr into l_table_descr;

    nm3reclass.ins_doc_assocs( pi_new_id => p_new_defect
                             , pi_old_id => p_old_defect
                             , pi_table_name => l_table_descr --'DEFECTS'
                             );	                             

    close c_get_table_descr;
    
    insert into repairs
     (REP_ACTION_CAT, REP_ATV_ACTY_AREA_CODE, REP_DATE_DUE, REP_DEF_DEFECT_ID,
      REP_RSE_HE_ID, REP_SUPERSEDED_FLAG, REP_COMPLETED_HRS, REP_COMPLETED_MINS,
      REP_DATE_COMPLETED, REP_DESCR, REP_TRE_TREAT_CODE, REP_OLD_DUE_DATE,
      REP_CREATED_DATE, REP_LAST_UPDATED_DATE)
    select rep_action_cat, rep_atv_acty_area_code, rep_date_due, p_new_defect,
           p_road, rep_superseded_flag, rep_completed_hrs, rep_completed_mins,
           rep_date_completed, rep_descr, rep_tre_treat_code, rep_old_due_date,
           rep_created_date, p_actioned
    from   repairs r2
    where  r2.rep_date_completed is null
    and    not exists (select 'x'
                       from   work_order_lines
                       where  wol_rep_action_cat = r2.rep_action_cat
                       and    wol_def_defect_id = r2.rep_def_defect_id)
    and    r2.rep_def_defect_id = p_old_defect;

    update defects
    set    def_superseded_flag = 'Y'
    ,      def_superseded_id = p_new_defect
    ,      def_status_code = l_superceded
    where  def_defect_id = p_old_defect;

    update repairs
    set    rep_superseded_flag = 'Y'
    where  rep_def_defect_id = p_old_defect;

    for i in c_boq loop
      update boq_items
      set    boq_defect_id = p_new_defect
      where current of c_boq;
    end loop;

  end create_new_defect;
-----------------------------------------------------------------------------

  procedure split_data (p_id        in number,
                        p_chain     in number,
                        p_effective in date,
                        p_id1       in number,
                        p_id2       in number,
                        p_actioned  in date) is
  --
  -- When a section is split, associated Maint. Manager data is processed here.
  -- Associated data for other products is processed in separate procedures
  -- eg. Structures data is processed in the STRSPLIT.SPLIT_DATA procedure.
  --

    l_rse_length           road_segs.rse_length%TYPE;
    l_rse_road_environment road_segs.rse_road_environment%TYPE;
    l_rse_sys_flag         road_segs.rse_sys_flag%TYPE;
    l_rse_scl_sect_class   road_segs.rse_scl_sect_class%TYPE;

    l_are_report_id1       activities_report.are_report_id%TYPE;
    l_are_report_id2       activities_report.are_report_id%TYPE;
    l_def_defect_id        defects.def_defect_id%TYPE;
    l_st_chain             activities_report.are_st_chain%TYPE;
    l_end_chain            activities_report.are_end_chain%TYPE;

    l_scheme_id            number;
    l_max_seq_no           number;

    cursor c1 is
      select rse_length,
      rse_road_environment,
      rse_sys_flag,
      rse_scl_sect_class
      from   road_segs
      where  rse_he_id = p_id;

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
                                and    def_rse_he_id       = p_id);

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
--      ,      min(iih_new_item_id)  new_item
--      from   inv_items_all
--      ,      inv_item_history
--      where  iit_item_id = iih_item_id
--      and    iih_new_rse_he_id in (p_id1, p_id2)
--      group by iit_item_id, iit_primary_key;

  begin

  --
  -- Get extra attributes from the section being split.
  --
    open c1;
    fetch c1 into l_rse_length,
             l_rse_road_environment,
             l_rse_sys_flag,
             l_rse_scl_sect_class;
    close c1;

-----------------------------------------------------------------------------
--
--   INVENTORY
--
-----------------------------------------------------------------------------
  --
  -- Create a set of inventory records for the first new road section.
  --
--    insert into inv_item_history (
--        IIH_CREATED_DATE, IIH_NEW_ITEM_ID,
--        IIH_INV_CODE, IIH_NEW_RSE_HE_ID,
--        IIH_ST_CHAIN, IIH_END_CHAIN,
--        IIH_X_SECT, IIH_ITEM_ID, IIH_RSE_HE_ID,
--        IIH_LAST_UPDATED_DATE, IIH_END_DATE, IIH_OPERATION
--       )
--    select iit_created_date,iit_item_id_seq.nextval,
--           iit_ity_inv_code,p_id1,
--           iit_st_chain,iit_end_chain,
--           iit_x_sect, iit_item_id, p_id,
--           iit_last_updated_date, iit_end_date, 'SPLIT'
--    from   inv_items
--    where  iit_st_chain < p_chain
--    and    iit_rse_he_id = p_id;
----
---- RAC Added new attributes (post 2107 release).
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
--    select p_actioned, p_effective, iih_new_item_id, IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, p_actioned,
--           iih_new_rse_he_id, IIT_ST_CHAIN, IIT_ANGLE, IIT_ANGLE_TXT, IIT_CLASS, IIT_CLASS_TXT,
--           IIT_COLOUR, IIT_COLOUR_TXT, 'I', IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE,
--           least(iit_end_chain,p_chain), IIT_END_DATE, IIT_GAP, IIT_HEIGHT, IIT_HEIGHT_2, IIT_ID_CODE,
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
--    where  iit_st_chain < p_chain
--    and    iit_rse_he_id = p_id
--    and    iit_item_id = iih_item_id
--    and    iih_new_rse_he_id = p_id1;
--
----
----  The join above should not need the restriction on chainage, the history record will
----  only exist if the chainage value is less than the split point.
----
--
--    dbms_output.put_line ('MAISPLIT.SPLIT_DATA : inv_items count1='||SQL%ROWCOUNT);
--
--  --
--  -- Create a set of inventory records for the second new road section.
--  --
--    insert into inv_item_history (
--        IIH_CREATED_DATE, IIH_NEW_ITEM_ID,
--        IIH_INV_CODE, IIH_NEW_RSE_HE_ID,
--        IIH_ST_CHAIN, IIH_END_CHAIN,
--        IIH_X_SECT, IIH_ITEM_ID, IIH_RSE_HE_ID,
--        IIH_LAST_UPDATED_DATE, IIH_END_DATE, IIH_OPERATION
--       )
--    select iit_created_date,iit_item_id_seq.nextval,
--           iit_ity_inv_code,p_id2,
--           iit_st_chain,iit_end_chain,
--           iit_x_sect, iit_item_id, p_id,
--           iit_last_updated_date, iit_end_date, 'SPLIT'
--    from   inv_items
--    where  nvl(iit_end_chain,iit_st_chain) >= p_chain
--    and    not (iit_end_chain = p_chain and iit_st_chain < p_chain)
--    and    iit_rse_he_id = p_id;
----
---- RAC Added new attributes (Post 2107)
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
--      IIT_XTRA_NUMBER_1, IIT_X_SECT, IIT_PRIMARY_KEY, IIT_FOREIGN_KEY, IIT_DET_XSP , IIT_OFFSET,
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
--    select p_actioned, p_effective, iih_new_item_id, IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, p_actioned,
--           iih_new_rse_he_id, greatest( iit_st_chain - p_chain, 0), IIT_ANGLE, IIT_ANGLE_TXT, IIT_CLASS, IIT_CLASS_TXT,
--           IIT_COLOUR, IIT_COLOUR_TXT, 'I', IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE,
--           iit_end_chain-p_chain, IIT_END_DATE, IIT_GAP, IIT_HEIGHT, IIT_HEIGHT_2, IIT_ID_CODE,
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
--    where  nvl(iit_end_chain,iit_st_chain) >= p_chain
--    and    not (iit_end_chain = p_chain and iit_st_chain < p_chain)
--    and    iit_rse_he_id = p_id
--    and    iit_item_id = iih_item_id
--    and    iih_new_rse_he_id = p_id2;
--
-- dbms_output.put_line ('MAISPLIT.SPLIT_DATA : inv_items count2='||SQL%ROWCOUNT);
--
--  --
--  -- Close all inventory attached to the road section being split.
--  --
--    update inv_items
--    set    iit_end_date = p_effective,
--           iit_coord_flag = decode(iit_coord_flag,'I',null,'D') ,
--           iit_last_updated_date = p_actioned
--    where  iit_rse_he_id = p_id;
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
--
--  --
--  -- Recalculate the max inventory chainage on both new road sections
--  --
--    update road_segs
--    set    rse_max_chain =
--          (select max(nvl(iit_end_chain,iit_st_chain))
--           from   inv_items
--           where  iit_rse_he_id = p_id1)
--    where  rse_he_id = p_id1;
--
--    update road_segs
--    set    rse_max_chain =
--          (select max(nvl(iit_end_chain,iit_st_chain))
--           from   inv_items
--           where  iit_rse_he_id = p_id2)
--    where  rse_he_id = p_id2;

-----------------------------------------------------------------------------
--
--   ACTIVITY REPORTS, DEFECTS AND REPAIRS
--
-----------------------------------------------------------------------------
  -- Inspections with available defects are duplicated from the original
  -- road section onto both new road sections, to keep survey dates etc. intact.
  -- Outstanding defects are duplicated from the original road section
  -- onto the appropriate new road section, according to the chainage.
  -- Those on the original section are marked as superseded.
  -- Those on the new section are attached to the new inspection.
  --
  for i in c_open_insp loop
    if i.are_st_chain <= p_chain then
      if i.are_end_chain > p_chain then
        l_end_chain := p_chain;
      else
        l_end_chain := i.are_end_chain;
      end if;
      open c2;
      fetch c2 into l_are_report_id1;
      close c2;
      create_new_insp(i.are_report_id
                     ,l_are_report_id1
                     ,p_id1
                     ,i.are_st_chain
                     ,l_end_chain
                     ,p_actioned);
    end if;
    if i.are_end_chain > p_chain then
      if i.are_st_chain <= p_chain then
        l_st_chain := 0;
      else
        l_st_chain := i.are_st_chain - p_chain;
      end if;
      l_end_chain := i.are_end_chain - p_chain;
      open c2;
      fetch c2 into l_are_report_id2;
      close c2;
      create_new_insp(i.are_report_id
                     ,l_are_report_id2
                     ,p_id2
                     ,l_st_chain
                     ,l_end_chain
                     ,p_actioned);
    end if;
    for j in c_defects(i.are_report_id) loop
      open c3;
      fetch c3 into l_def_defect_id;
      close c3;
      if j.def_st_chain <= p_chain then
        create_new_defect(j.def_defect_id
                         ,l_def_defect_id
                         ,p_id1
                         ,l_are_report_id1
                         ,j.def_st_chain
                         ,p_actioned);
      else
        create_new_defect(j.def_defect_id
                         ,l_def_defect_id
                         ,p_id2
                         ,l_are_report_id2
                         ,j.def_st_chain - p_chain
                         ,p_actioned);
      end if;
    end loop;
  end loop;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
  --
  -- Copy affected external activity records to the first new road section
  --
    insert into ext_act_road_usage
        (exu_rse_he_id,exu_ext_id,exu_current,
         exu_start_date,exu_sign_off_date,exu_created_date,exu_last_updated_date
        )
    select p_id1,exu_ext_id,exu_current,
           exu_start_date,exu_sign_off_date,p_actioned,p_actioned
    from   ext_act_road_usage
    where  exu_rse_he_id = p_id;

    dbms_output.put_line ('MAISPLIT.SPLIT_DATA : ext_act_road count='||SQL%ROWCOUNT);

  --
  -- Close external activities associated with the section being split.
  --
    update ext_act_road_usage
    set    exu_sign_off_date = p_effective,
           exu_last_updated_date = p_actioned
    where  exu_rse_he_id = p_id;

-----------------------------------------------------------------------------
--
--   STRUCTURAL PROJECTS
--
-----------------------------------------------------------------------------

    split_schemes(p_id, p_id1, p_id2, p_chain);

-----------------------------------------------------------------------------
--
--   LOCAL AND SECTION FREQUENCIES
--
-----------------------------------------------------------------------------
  --
  -- Create a set of local_freqs records for the first new road section
  --
    insert into local_freqs
          (lfr_atv_acty_area_code, lfr_int_code, lfr_rse_he_id,
           lfr_approved_by, lfr_approved_ref, lfr_date_approved,
           lfr_descr, lfr_end_chain, lfr_ity_inv_code,
           lfr_start_chain, lfr_ity_sys_flag)
    select lfr_atv_acty_area_code, lfr_int_code, p_id1,
           lfr_approved_by, lfr_approved_ref, lfr_date_approved,
           lfr_descr, least(lfr_end_chain,p_chain), lfr_ity_inv_code,
           lfr_start_chain, lfr_ity_sys_flag
    from   local_freqs
    where  lfr_rse_he_id = p_id
    and    lfr_start_chain < p_chain;

    dbms_output.put_line ('MAISPLIT.SPLIT_DATA : local_freqs count1='||SQL%ROWCOUNT);

  --
  -- Create a set of local_freqs records for the second new road section
  --
    insert into local_freqs
          (lfr_atv_acty_area_code, lfr_int_code, lfr_rse_he_id,
           lfr_approved_by, lfr_approved_ref, lfr_date_approved,
           lfr_descr, lfr_end_chain, lfr_ity_inv_code,
           lfr_start_chain, lfr_ity_sys_flag)
    select lfr_atv_acty_area_code, lfr_int_code, p_id2,
           lfr_approved_by, lfr_approved_ref, lfr_date_approved,
           lfr_descr, (lfr_end_chain-p_chain), lfr_ity_inv_code,
           greatest((lfr_start_chain-p_chain),0), lfr_ity_sys_flag
    from   local_freqs
    where  lfr_rse_he_id = p_id
    and    lfr_end_chain >= p_chain
    and not (lfr_end_chain = p_chain and lfr_start_chain < p_chain);

    dbms_output.put_line ('MAISPLIT.SPLIT_DATA : local_freqs count2='||SQL%ROWCOUNT);

  --
  -- Delete all section_freqs records attached to the original road section.
  --
    delete section_freqs
    where  sfr_rse_he_id = p_id;

  --
  -- Create a set of section_freqs records for the first new road section
  --
    insert into section_freqs (
           sfr_rse_he_id,
           sfr_atv_acty_area_code,
           sfr_int_code )
    select p_id1,
           afr_atv_acty_area_code,
           max(afr_int_code)
    from   act_freqs a
    where  afr_ity_sys_flag = l_rse_sys_flag
    and    afr_scl_sect_class = l_rse_scl_sect_class
    and    afr_road_environment = l_rse_road_environment
    and   (afr_ity_inv_code = '%%'
    or     afr_ity_inv_code in
      (select iit_ity_inv_code
       from   inv_items_all
       where  iit_rse_he_id = p_id1))
    and not exists
       (select 1
        from   act_freqs b
        where  afr_ity_sys_flag = l_rse_sys_flag
        and    afr_scl_sect_class = l_rse_scl_sect_class
        and    afr_road_environment = l_rse_road_environment
        and    MAISPLIT.freq(a.afr_int_code) < MAISPLIT.freq(b.afr_int_code))
    group by p_id1, afr_atv_acty_area_code;

    dbms_output.put_line ('MAISPLIT.SPLIT_DATA : section_freqs count1='||SQL%ROWCOUNT);

  --
  -- Create a set of section_freqs records for the second new road section
  --
    insert into section_freqs (
           sfr_rse_he_id,
           sfr_atv_acty_area_code,
           sfr_int_code )
    select p_id2,
           afr_atv_acty_area_code,
           max(afr_int_code)
    from   act_freqs a
    where  afr_ity_sys_flag = l_rse_sys_flag
    and    afr_scl_sect_class = l_rse_scl_sect_class
    and    afr_road_environment = l_rse_road_environment
    and   (afr_ity_inv_code = '%%'
    or     afr_ity_inv_code in
   (select iit_ity_inv_code
    from   inv_items_all
    where  iit_rse_he_id = p_id2))
    and not exists
          (select 1
           from   act_freqs b
           where  afr_ity_sys_flag = l_rse_sys_flag
           and    afr_scl_sect_class = l_rse_scl_sect_class
           and    afr_road_environment = l_rse_road_environment
           and    MAISPLIT.freq(a.afr_int_code) < MAISPLIT.freq(b.afr_int_code))
    group by p_id2, afr_atv_acty_area_code;

    dbms_output.put_line ('MAISPLIT.SPLIT_DATA : section_freqs count2='||SQL%ROWCOUNT);

  end split_data;

-----------------------------------------------------------------------------

  procedure split_schemes(p_id  road_segs.rse_he_id%type
    ,p_id1  road_segs.rse_he_id%type
    ,p_id2  road_segs.rse_he_id%type
    ,p_chain scheme_roads.start_point%type) is

    cursor c1 is
      select a.scheme_id
      from   scheme_roads a
      where exists
   ( select 'x'
     from  scheme_roads b
     where b.rse_he_id = p_id
     and b.scheme_id = a.scheme_id )
      group by scheme_id;

    cursor c2 (scheme in number) is
      select scheme_id,
             scheme_road_id,
             end_point,
             seq_no
      from   scheme_roads
      where  rse_he_id = p_id
      and    scheme_id = scheme
      and    start_point < p_chain
      and    end_point   > p_chain;

    cursor c3 is
      select sch_rd_seq.nextval
      from   dual;

    lseq number;

  begin
  --
  -- Process affected schemes one at a time.
  -- SCHEME_ROADS records are moved from the old section to the new ones.
  -- NB. Do not reorder the updates as the sequence is critical.
  --

    dbms_output.put_line ('MAISPLIT.SPLIT_DATA : Start Structural Schemes Split');

    for scheme in c1 loop

  --
  -- Update any scheme segments which start after the split point.
  --

      update scheme_roads
      set    rse_he_id = p_id2,
             start_point = start_point - p_chain ,
             end_point   = end_point - p_chain
      where  rse_he_id = p_id
      and    scheme_id = scheme.scheme_id
      and    start_point >= p_chain;

  --
  -- Create an extra scheme segment for each one that spanned the split point
  --

      for scheme_road in c2 (scheme.scheme_id) loop

         open c3;
         fetch c3 into lseq;
         close c3;

         insert into scheme_roads (
           scheme_id,
      scheme_road_id,
      seq_no,
      rse_he_id,
      start_point,
      end_point,
       start_flag )
         values (
           scheme_road.scheme_id,
      lseq,
      scheme_road.seq_no,
       p_id2,
       0,
       scheme_road.end_point - p_chain,
       'N' );

         insert into scheme_activities (
           scheme_road_id,
           seq_no,
           acty_area_code,
           siss_id,
           overlay_flag,
           depth,
           cost,
           xsp_codes,
           primary_flag )
         select
           lseq,
           seq_no,
           acty_area_code,
           siss_id,
           overlay_flag,
           depth,
           cost,
           xsp_codes,
           primary_flag
         from scheme_activities
         where scheme_road_id = scheme_road.scheme_road_id;

      end loop;

  --
  -- Update any scheme segments which start before the split point.
  --

      update scheme_roads
      set    rse_he_id = p_id1,
             end_point = least( end_point, p_chain )
      where  rse_he_id = p_id
      and    scheme_id = scheme.scheme_id
      and    start_point < p_chain;

    end loop;

  end split_schemes;

-----------------------------------------------------------------------------

  function freq (p_int_code in varchar) return number is
    l_return number:=0;
    cursor c1 is
      select nvl(int_freq_per_year,99999 -
          trunc((nvl(int_hrs,0)+23)/24) -
          nvl(int_days,0) -
          nvl(int_months,0) * 30 -
          nvl(int_yrs,0) *365 )
      from   intervals
      where  int_code = p_int_code;
  begin

    open c1;
    fetch c1 into l_return;
    close c1;

    return l_return;

  end freq;

-----------------------------------------------------------------------------
--**** UNSPLIT PROCEDURES *****
-----------------------------------------------------------------------------

  procedure data_check
 (p_id        in number,      -- section to be checked
  p_actioned_date in varchar2,
  p_errors     in out number,
  p_error_string in out varchar2) is
  --
  -- Checks that the user has supplied valid parameters.
  -- This procedure is also used by the unmerge process.
  --

    l_sys_flag  varchar2(1);
    l_agency  road_sections.rse_agency%type;
    l_linkcode  road_sections.rse_linkcode%type;
    l_sect_no  road_sections.rse_sect_no%type;

    l_message    varchar2(80);

    cursor c1 is
      select rse_sys_flag,
        rse_agency,
        rse_linkcode,
        rse_sect_no
      from   road_sections_all
      where  rse_he_id = p_id;
--
--    cursor c2 is
--      select 'Error : Inventory created or modified'
--      from   inv_items_all
--      where  iit_rse_he_id = p_id
--      and    iit_last_updated_date > to_date(p_actioned_date,
--         'DD-MON-YYYY,HH24:MI:SS');

    cursor c3 is
      select 'Error : Inspection or Maintenance Reports created or modified'
      from   activities_report
      where  are_rse_he_id = p_id
      and    are_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');

    cursor c4 is
      select 'Error : Inspection or Maintenance Report Lines created or modified'
      from   act_report_lines
      where  arl_are_report_id in
            (select are_report_id
             from   activities_report
             where  are_rse_he_id = p_id
            )
      and    arl_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');

    cursor c5 is
      select 'Error : Defects created or modified'
      from   defects
      where  def_rse_he_id = p_id
      and    def_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');

    cursor c6 is
      select 'Error : Repairs created or modified'
      from   repairs
      where  rep_rse_he_id = p_id
      and    rep_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');

    cursor c7 is
      select 'Error : Work Order Lines exist'
      from   work_orders WOR,
        work_order_lines WOL
      where  WOR.wor_works_order_no = WOL.wol_works_order_no
      and    WOL.wol_rse_he_id = p_id;

    cursor c8 is
      select 'Error : Ext. Activity Road Usages created or modified'
      from   ext_act_road_usage
      where  exu_rse_he_id = p_id
      and    exu_last_updated_date > to_date(p_actioned_date,
         'DD-MON-YYYY,HH24:MI:SS');

    cursor c9 is
      select 'Error : Incomplete Inventory (Stage 1) load'
      from   hhinv_load_1 HL1
      where  HL1.rec_type = 'B'
      and   (SUBSTR(HL1.full_value,1,10) = upper( l_agency||l_linkcode)
      and    DECODE(l_sys_flag ,'D',SUBSTR( HL1.full_value,12,2)
                   ,SUBSTR( HL1.full_value,12,5)) = upper( l_sect_no)
            );

  -- if Stage1 suceeds, then subsequent stages might fail for various reasons
  -- including Inventory having been loaded for a Section which has not yet
  -- been created; so test not only RSE_HE_ID but also Agency, Link, Section
  -- strings. this test will identify any stage subsequent to Stage1 which is
  -- incomplete.

    cursor c10 is
      select 'Error : Incomplete Inventory (non-Stage 1) load'
      from   hhinv_sect_log HSL
      where (
            (HSL.linkcode = upper( l_agency||l_linkcode)
             and HSL.section_code = upper( l_sect_no)
            )
         or (HSL.linkcode = upper( l_linkcode)
             and HSL.section_code = upper( l_sect_no)
            )
         or (HSL.he_id = p_id
            )
            )
      and   (HSL.error_msg IS NOT NULL
             or HSL.error_level IS NOT NULL
            );

    cursor c11 is
      select 'Error : Incomplete Inspection load'
      from   hh_load_recs HLR
      where  upper( HLR.record_type) = 'G'
      and   (RTRIM(SUBSTR( HLR.record_text,1,INSTR( HLR.record_text,',')),',')||
             LTRIM(SUBSTR( HLR.record_text,INSTR( HLR.record_text,','),
            (INSTR( HLR.record_text,',',1,2)-INSTR( HLR.record_text,','))),', 0') =
             upper( l_agency||l_linkcode||LTRIM( l_sect_no,'0 '))
            );

  begin

    open c1;
    fetch c1 into l_sys_flag,
   l_agency,
   l_linkcode,
     l_sect_no;
    if c1%notfound then
      p_errors := p_errors + 1;
      l_message := 'This section does not exist.';
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c1;

--    open c2;
--    fetch c2 into l_message;
--    if c2%found then
--      p_errors := p_errors + 1;
--      dbms_output.put_line(l_message);
--      p_error_string:=p_error_string||l_message||chr(13);
--    end if;
--    close c2;

    open c3;
    fetch c3 into l_message;
    if c3%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c3;

    open c4;
    fetch c4 into l_message;
    if c4%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c4;

    open c5;
    fetch c5 into l_message;
    if c5%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c5;

    open c6;
    fetch c6 into l_message;
    if c6%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c6;

    open c7;
    fetch c7 into l_message;
    if c7%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c7;

    open c8;
    fetch c8 into l_message;
    if c8%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c8;

    open c9;
    fetch c9 into l_message;
    if c9%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c9;

    open c10;
    fetch c10 into l_message;
    if c10%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string:=p_error_string||l_message||chr(13);
    end if;
    close c10;

    open c11;
    fetch c11 into l_message;
    if c11%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string := p_error_string||l_message||chr(13);
    end if;
    close c11;

  end data_check;

-----------------------------------------------------------------------------

  procedure check_data_unsplit
      (p_id1  in  number,
  p_id2  in  number,
  p_actioned  in  varchar2,
  p_errors  in out number,
  p_error_string in out  varchar2) is

    begin

      data_check(p_id1, p_actioned, p_errors, p_error_string);

      data_check(p_id2, p_actioned, p_errors, p_error_string);

    end check_data_unsplit;

-----------------------------------------------------------------------------

  procedure unsplit_data
 (p_id        in     number,      --rse_he_id to be unsplit
   p_id1    in     number,
  p_id2    in     number,
  p_history_date  in     varchar2) is

    l_length       number;
    l_table_name       varchar2(32);
    l_unactioned_date  varchar2(22) := to_char(sysdate,'DD-MON-YYYY,HH24:MI:SS');
    l_today_date       varchar2(11) := to_char(sysdate ,'DD-MON-YYYY');
    l_rmmsflag        varchar2(1) := hig.get_sysopt('RMMSFLAG');
    err_string        varchar2(1000);


    cursor c1 is
      select nvl(rse_length,0)
      from   road_sections
      where  rse_he_id = p_id1;


  begin

  -- activity_lines
    delete from act_report_lines
    where arl_are_report_id in
   (select are_report_id
     from activities_report
    where are_rse_he_id in (p_id1,p_id2)
   );

  -- activities
    delete from activities_report
    where are_rse_he_id in (p_id1,p_id2);



  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  -- Create table temp_defects which will
  -- contain the defect data for the sections created from the split.
  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
                                    ,def_response_category)
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
   FROM DEFECTS
   WHERE def_rse_he_id IN(p_id1,p_id2);

  
    update repairs
    set    rep_superseded_flag = 'N'
    where  rep_def_defect_id in (select def.def_defect_id
                                 from   defects def
                                 ,      temp_undo_defect_edit tmp
                                 where  def.def_superseded_id = tmp.def_defect_id
                                 and    tmp.def_rse_he_id in (p_id1,p_id2)
                                 and    tmp.def_date_compl is null);

    update boq_items
    set    boq_defect_id = (select def.def_defect_id
                            from   defects def
                            ,      temp_undo_defect_edit tmp
                            where  def.def_superseded_id = tmp.def_defect_id
                            and    tmp.def_defect_id = boq_defect_id
                            and    tmp.def_date_compl is null)
    where  boq_defect_id in (select tmp.def_defect_id
                             from   temp_undo_defect_edit tmp
                             where  tmp.def_rse_he_id IN (p_id1,p_id2)
                             and    tmp.def_date_compl is null);

    update defects
    set  DEF_LAST_UPDATED_DATE = to_date(l_unactioned_date,
      'DD-MON-YYYY,HH24:MI:SS')
    ,    def_superseded_id = null
    ,    def_superseded_flag = 'N'
    ,    def_status_code = 'AVAILABLE'
    where  def_superseded_id IN
          (select tmp.def_defect_id
    from   temp_undo_defect_edit tmp
      where  tmp.def_rse_he_id IN (p_id1,p_id2)
           and    tmp.def_date_compl is null);


  -- repairs
    delete from repairs
    where rep_rse_he_id in (p_id1,p_id2);

  -- defects
    delete from defects
    where def_rse_he_id in (p_id1,p_id2);


  --local_freq
    delete from local_freqs
    where lfr_rse_he_id in (p_id1,p_id2);


  -- section_freq
    delete from section_freqs
    where sfr_rse_he_id in (p_id1,p_id2);


  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  --This code was not called in NET1020.RPT
  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  -- ext_act_road_usage
    delete from ext_act_road_usage
    where exu_rse_he_id in (p_id1,p_id2)
    and l_rmmsflag in ('3','4');


  --ext_act_end_date
    update ext_act_road_usage
    set    exu_sign_off_date = null,
     exu_current = 'Y',
    EXU_LAST_UPDATED_DATE = to_date(l_unactioned_date,
        'DD-MON-YYYY,HH24:MI:SS')
    where  exu_rse_he_id = p_id
    and    l_rmmsflag in ('3','4');

-- JW 29-MAY-2007 - Log 51555
--
-- The undo split fails because the second update statement on scheme_roads results in a 
-- ORA-01407 error. This happens because l_length is null and this results in an attempt to set 
-- the start_point (a not null column) to null. With the agreement of Colin Stewart both update 
-- statements have been commented out since scheme_roads is a pre-Atlas table.
--
--
--schemes_1
--    update scheme_roads
--    set rse_he_id = p_id
--    where rse_he_id = p_id1;
--
--schemes_2
--    update scheme_roads
--    set    rse_he_id = p_id,
--    start_point = start_point + l_length,
--    end_point   = end_point + l_length
--    where  rse_he_id = p_id2;

  exception
    when others then

dbms_output.put_line ('WHEN OTHERS: '||sqlerrm);

  -- trap the error string

      err_string := sqlerrm;

      raise_application_error( -20001, err_string );

  end unsplit_data;

--
-----------------------------------------------------------------------------
--
END maisplit;
/
