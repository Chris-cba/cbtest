CREATE OR REPLACE PACKAGE BODY maimerge AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maimerge.pkb-arc   2.2   Jul 01 2013 16:26:50   James.Wadsworth  $
--       Module Name      : $Workfile:   maimerge.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:26:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:44  $
--       SCCS Version     : $Revision:   2.2  $
--       Based onSCCS Version     : 1.5
--
-----------------------------------------------------------------------------
--	This package contains procedures and functions which are required by
--	the Merge / UnMerge processes within Network Manager.
--
--      Maintenance Manager specific functionality can be found here,
--      whilst the core functionality of the network processes can be found
--      in the HIGMERGE package.
--
-- Originally taken from '@(#)maimerge.pck	1.11 06/17/02';
--
-- 01-AUG-2003 SW Updated to incorporate changes made to original up to v1.13
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
   g_package_name    CONSTANT  varchar2(30)   := 'maimerge';
--
   l_dummy_package_variable number;
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
--**** MERGE PROCEDURES *****
-----------------------------------------------------------------------------

  procedure check_data
	(p_rse_he_id_1   	  in number,	-- first existing rse_unique to merge
	 p_rse_he_id_2	  in number,	-- second existing rse_unique to merge
	 p_sect_no   	  in varchar2,    -- new section for result of merge
	 p_effective_date   in date,     	-- effective date of merge
	 p_errors    	  in out number,
	 p_error_string	  in out varchar2) is
  --
  -- Checks that the user has supplied valid parameters.
  --
  begin

    maisplit.check_data(p_rse_he_id_1, null, p_effective_date, p_errors, p_error_string);

    maisplit.check_data(p_rse_he_id_2, null, p_effective_date, p_errors, p_error_string);

  end check_data;
--
-----------------------------------------------------------------------------
--
  procedure merge_data
	(p_rse_he_id_new       in number,    -- new merged section
	 p_rse_he_id_1         in number,	  -- first section to merge
	 p_rse_he_id_2	       in number,	  -- second section to merge
     p_new_starting_section in number,    -- number of the section from which the start of the datum/route is measured either 1 or 2	 
	 p_flip_cardinality_of_2 in VARCHAR2,   -- flag if cardinality of section 2 was flipped	 
	 p_effective_date      in date) is   -- effective date of merge
  --
  -- When sections are merged, associated Maint. Manager data is processed here.
  -- Associated data for other products is processed in separate procedures
  -- eg. Structures data is processed in the STRMERGE.MERGE_DATA procedure.
  --

    l_rse_agency_1          road_segs.rse_agency%type;
    l_rse_linkcode_1        road_segs.rse_linkcode%type;
    l_rse_sect_no_1         road_segs.rse_sect_no%type;
    l_rse_length_1  	    road_segs.rse_length%type;
    l_sys_flag_1            road_segs.rse_sys_flag%type;
    l_road_environment_1    road_segs.rse_road_environment%type;
    l_sect_class_1          road_segs.rse_scl_sect_class%type;


    l_rse_agency_2          road_segs.rse_agency%type;
    l_rse_linkcode_2        road_segs.rse_linkcode%type;
    l_rse_sect_no_2         road_segs.rse_sect_no%type;
    l_rse_length_2          road_segs.rse_length%type;
    l_sys_flag_2            road_segs.rse_sys_flag%type;	

    l_rmmsflag 		    varchar2(1) := hig.get_sysopt('RMMSFLAG');
    l_actioned              date := sysdate;
    l_actioned_date	    varchar2(22) := to_char(l_actioned,
						    'DD-MON-YYYY,HH24:MI:SS');
    l_any_activities        activities_report.are_report_id%type;
    l_are_report_id	    number;
    l_def_defect_id         number;
    l_table_name	    varchar2(32) := 'TEMP_ACT_LINES';
    l_message    	    varchar2(80);

    l_ur_code               inv_item_types.ity_inv_code%type;
	
    cursor c1 is
      select rse_agency,
             rse_linkcode,
             rtrim(rse_sect_no),
             rse_length,
	     	 rse_sys_flag,
	     	 rse_road_environment,
	     	 rse_scl_sect_class 
      from   road_segs
      where  rse_he_id = p_rse_he_id_1;

    cursor c2 is
      select rse_agency,
             rse_linkcode,
             rtrim(rse_sect_no),
	     	 rse_length,
	     	 rse_sys_flag			  
      from   road_segs
      where  rse_he_id = p_rse_he_id_2;

    cursor c3 is
      select 'Info : Local Frequencies have been defaulted to cover entire Merged Section'
      from   local_freqs a
      where  a.lfr_rse_he_id = p_rse_he_id_1
      and    not exists
 	      (select 1 from local_freqs b
	       where  b.lfr_rse_he_id = p_rse_he_id_2
	       and    b.lfr_atv_acty_area_code = a.lfr_atv_acty_area_code
	       and    b.lfr_ity_inv_code = a.lfr_ity_inv_code);

    cursor c4 is
      select 'Info : Local Frequences have been defaulted to cover entire Merged Section'
      from   local_freqs a
      where  a.lfr_rse_he_id = p_rse_he_id_2
      and    not exists
 	      (select 1 from local_freqs b
	       where  b.lfr_rse_he_id = p_rse_he_id_1
	       and    b.lfr_atv_acty_area_code = a.lfr_atv_acty_area_code
	       and    b.lfr_ity_inv_code = a.lfr_ity_inv_code);

    cursor c5 is
      select are_report_id_seq.nextval
      from   dual;

    cursor c6 is
      select def_defect_id_seq.nextval
      from   dual;


    cursor c8 is
      select hop_value
      from   hig_options
      where  hop_id = 'SECTINVTYP';

    cursor c_open_insp is
      select are_report_id
      ,      are_rse_he_id
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
                                and    def_rse_he_id       in (p_rse_he_id_1,p_rse_he_id_2));

    cursor c_defects(l_insp number) is
      select def_defect_id
      ,      def_rse_he_id
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

  begin
  
  
    open c1;
    fetch c1 into l_rse_agency_1,
	              l_rse_linkcode_1,
	              l_rse_sect_no_1,
		          l_rse_length_1,
		  	      l_sys_flag_1,
		  	      l_road_environment_1,
		  	      l_sect_class_1;
    close c1;

    open c2;
    fetch c2 into l_rse_agency_2,
                  l_rse_linkcode_2,
                  l_rse_sect_no_2,
                  l_rse_length_2,
		  	      l_sys_flag_2;			  
    close c2;

  --
  -- create new ext_act_road_usage records for the new merged section
  --
  -- copy from first section
  --
    insert into ext_act_road_usage
 	           (exu_rse_he_id,
			exu_ext_id,
			exu_current,
	        	exu_start_date,
			exu_sign_off_date,
	      	exu_created_date,
			exu_last_updated_date)
    select      	p_rse_he_id_new,
			exu_ext_id,exu_current,
                	exu_start_date,
			exu_sign_off_date,
                	l_actioned,
                	l_actioned
    from        	ext_act_road_usage
    where       	exu_rse_he_id = p_rse_he_id_1
    and         	l_rmmsflag in ('3','4');

  --
  -- copy from second section
  --
    insert into ext_act_road_usage
                 (exu_rse_he_id,
			exu_ext_id,
			exu_current,
                	exu_start_date,
			exu_sign_off_date,
                	exu_created_date,
			exu_last_updated_date)
    select      	p_rse_he_id_new,
			exu_ext_id,
			exu_current,
                	exu_start_date,
			exu_sign_off_date,
                	l_actioned,
                	l_actioned
    from        	ext_act_road_usage
    where       	exu_rse_he_id = p_rse_he_id_2
    and         	l_rmmsflag in ('3','4');

  --
  -- end date existing ext_act_road_usage roads for original sections
  --
    update ext_act_road_usage
    set    exu_sign_off_date = p_effective_date,
           exu_last_updated_date = to_date(l_actioned_date,
					   'DD-MON-YYYY,HH24:MI:SS')
    where  exu_rse_he_id in (p_rse_he_id_1,p_rse_he_id_2)
    and    l_rmmsflag in ('3','4');



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
    if i.are_rse_he_id = p_rse_he_id_1 then
      open c5;
      fetch c5 into l_are_report_id;
      close c5;
      maisplit.create_new_insp(i.are_report_id
                              ,l_are_report_id
                              ,p_rse_he_id_new
							  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                               ,pi_rse_length_2         => l_rse_length_2
											   ,pi_rse_sys_flag         => l_sys_flag_1
                                               ,pi_chainage_section     => 1
											   ,pi_new_starting_section => p_new_starting_section 
						                       ,pi_original_chainage    => i.are_st_chain
						                       ,pi_cardinality_flipped  => 'N')
							  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                               ,pi_rse_length_2         => l_rse_length_2
											   ,pi_rse_sys_flag         => l_sys_flag_1											   
                                               ,pi_chainage_section     => 1
											   ,pi_new_starting_section => p_new_starting_section											   
						                       ,pi_original_chainage    => i.are_end_chain
						                       ,pi_cardinality_flipped  => 'N')											   
--                              ,i.are_st_chain
--                              ,i.are_end_chain
                              ,p_effective_date);
    else
      open c5;
      fetch c5 into l_are_report_id;
      close c5;


      maisplit.create_new_insp(i.are_report_id
                              ,l_are_report_id
                              ,p_rse_he_id_new
							  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                               ,pi_rse_length_2         => l_rse_length_2
											   ,pi_rse_sys_flag         => l_sys_flag_2											   
                                               ,pi_chainage_section     => 2
											   ,pi_new_starting_section => p_new_starting_section											   
						                       ,pi_original_chainage    => i.are_st_chain
						                       ,pi_cardinality_flipped  => p_flip_cardinality_of_2)
							  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                               ,pi_rse_length_2         => l_rse_length_2
											   ,pi_rse_sys_flag         => l_sys_flag_2											   
                                               ,pi_chainage_section     => 2
											   ,pi_new_starting_section => p_new_starting_section											   
						                       ,pi_original_chainage    => i.are_end_chain
						                       ,pi_cardinality_flipped  => p_flip_cardinality_of_2)											   
--                              ,i.are_st_chain + l_rse_length_1
--                              ,i.are_end_chain + l_rse_length_1
                              ,p_effective_date);
							  
							  
    end if;
    for j in c_defects(i.are_report_id) loop
      open c6;
      fetch c6 into l_def_defect_id;
      close c6;
      if j.def_rse_he_id = p_rse_he_id_1 then
	  
--nm_debug.debug('pi_rse_length_1='||to_char(l_rse_length_1));
--nm_debug.debug('pi_rse_length_2='||to_char(l_rse_length_2));
--nm_debug.debug('pi_chainage_section=1');
--nm_debug.debug('pi_original_chainage='||to_char(j.def_st_chain));	 
--nm_debug.debug_off;  
	  
	  
        maisplit.create_new_defect(j.def_defect_id
                                  ,l_def_defect_id
                                  ,p_rse_he_id_new
                                  ,l_are_report_id
                                  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                   ,pi_rse_length_2         => l_rse_length_2
     											   ,pi_rse_sys_flag         => l_sys_flag_1												   
                                                   ,pi_chainage_section     => 1
	   											   ,pi_new_starting_section => p_new_starting_section
						                           ,pi_original_chainage    => j.def_st_chain
						                           ,pi_cardinality_flipped  => 'N')											   
--                                ,j.def_st_chain
                                  ,p_effective_date);
      else

--nm_debug.debug('pi_rse_length_1='||to_char(l_rse_length_1));
--nm_debug.debug('pi_rse_length_2='||to_char(l_rse_length_2));
--nm_debug.debug('pi_chainage_section=2');
--nm_debug.debug('pi_original_chainage='||to_char(j.def_st_chain));

        maisplit.create_new_defect(j.def_defect_id
                                  ,l_def_defect_id
                                  ,p_rse_he_id_new
                                  ,l_are_report_id
                                  ,nm3merge.get_new_chainage(pi_rse_length_1         => l_rse_length_1
                                                   ,pi_rse_length_2         => l_rse_length_2
    											   ,pi_rse_sys_flag         => l_sys_flag_2
                                                   ,pi_chainage_section     => 2
                                                   ,pi_new_starting_section => p_new_starting_section												   
						                           ,pi_original_chainage    => j.def_st_chain
						                           ,pi_cardinality_flipped  => p_flip_cardinality_of_2)											   
--                                  ,j.def_st_chain + l_rse_length_1
                                  ,p_effective_date);
      end if;
    end loop;
  end loop;

-----------------------------------------------------------------------------
--
--   LOCAL AND SECTION FREQUENCIES
--
-----------------------------------------------------------------------------

--    insert into sect_freq1 (tt1_rse_he_id, tt1_iit_ity_inv_code)
--    select distinct rse_he_id, iit_ity_inv_code
--    from   inv_items_all, road_sections
--    where  iit_end_date (+) is null
--    and    iit_rse_he_id (+) = rse_he_id
--    and    rse_he_id = p_rse_he_id_new;

    insert into sect_freq2 (tt2_rse_he_id,
                            tt2_afr_atv_acty_area_code,
	                    tt2_int_code, tt2_dummy)
    select 	tt1_rse_he_id,
                afr_atv_acty_area_code, int_code,
	   	max(nvl(int_freq_per_year,
	   	nvl(int_freq_per_month,
	   	nvl(int_freq_per_week,  99999 -
		trunc((nvl(int_hrs,0)+23)/24) -
		nvl(int_days,0) -
		nvl(int_months,0) * 30 -
		nvl(int_yrs,0) * 365 ))) )
    from  	intervals, act_freqs, sect_freq1
    where 	int_code = afr_int_code
    and   	afr_road_environment = l_road_environment_1
    and   	afr_scl_sect_class = l_sect_class_1
    and   	afr_ity_sys_flag = l_sys_flag_1
    and    (afr_ity_inv_code = tt1_iit_ity_inv_code
    or    	afr_ity_inv_code is null)
    group by tt1_rse_he_id, afr_atv_acty_area_code, int_code;

    insert into section_freqs ( sfr_atv_acty_area_code,
	                        sfr_int_code,sfr_rse_he_id )
    select tt2a.tt2_afr_atv_acty_area_code, tt2a.tt2_int_code, p_rse_he_id_new
    from   sect_freq2 tt2a
    where  (tt2a.tt2_dummy,tt2a.tt2_int_code) = 
	    (select max(tt2b.tt2_dummy)
             ,      min(tt2b.tt2_int_code)
  	     from   sect_freq2 tt2b
	     where  tt2b.tt2_afr_atv_acty_area_code =
	            tt2a.tt2_afr_atv_acty_area_code
	     and    tt2b.tt2_rse_he_id = tt2a.tt2_rse_he_id)
    and    tt2a.tt2_rse_he_id = p_rse_he_id_new;

    insert into LOCAL_FREQS
      (LFR_ATV_ACTY_AREA_CODE,
       LFR_INT_CODE,
       LFR_RSE_HE_ID,
       LFR_DATE_APPROVED,
       LFR_DESCR,
       LFR_END_CHAIN,
       LFR_ITY_INV_CODE,
       LFR_START_CHAIN,
       LFR_ITY_SYS_FLAG
      )
    select LFR.lfr_atv_acty_area_code,
           LFR.lfr_int_code,
           p_rse_he_id_new,
           LFR.lfr_date_approved,
           LFR.lfr_descr,
           nm3merge.get_new_chainage(l_rse_length_1
                           ,l_rse_length_2
                           ,l_sys_flag_1						   
                           ,1
 				           ,p_new_starting_section
                           ,LFR.lfr_end_chain
						   ,'N'),
--         LFR.lfr_end_chain,																		   
           LFR.lfr_ity_inv_code,
           nm3merge.get_new_chainage(l_rse_length_1
                           ,l_rse_length_2
                           ,l_sys_flag_1						   
                           ,1
 				           ,p_new_starting_section						   
                           ,LFR.lfr_start_chain
						   ,'N'),
--           LFR.lfr_start_chain,
           LFR.lfr_ity_sys_flag
    from   local_freqs LFR
    where  LFR.lfr_rse_he_id = p_RSE_HE_ID_1;

    insert into LOCAL_FREQS
      (LFR_ATV_ACTY_AREA_CODE,
       LFR_INT_CODE,
       LFR_RSE_HE_ID,
       LFR_DATE_APPROVED,
       LFR_DESCR,
       LFR_END_CHAIN,
       LFR_ITY_INV_CODE,
       LFR_START_CHAIN,
       LFR_ITY_SYS_FLAG
      )
    select distinct SFR.sfr_atv_acty_area_code,
           SFR.sfr_int_code,
           p_rse_he_id_new,
           p_effective_date,
           'Defaulted by section Merge',
           l_rse_length_1,
           LFR.lfr_ity_inv_code,
           0,
           LFR.lfr_ity_sys_flag
    from   SECTION_FREQS SFR ,local_freqs LFR
    where  SFR.sfr_atv_acty_area_code = LFR.lfr_atv_acty_area_code
    and    SFR.sfr_rse_he_id = p_rse_he_id_new
    and    LFR.lfr_rse_he_id = p_rse_he_id_2
    and    not exists
          (select 'exists in Section#2 only so create a default for Section#1 part from Section Frequencies for new Section'
           from   local_freqs b
           where  b.lfr_atv_acty_area_code = LFR.lfr_atv_acty_area_code
           and  b.lfr_ity_inv_code = LFR.lfr_ity_inv_code
           and  b.lfr_rse_he_id = p_rse_he_id_1
           );

    insert into LOCAL_FREQS
      (LFR_ATV_ACTY_AREA_CODE,
       LFR_INT_CODE,
       LFR_RSE_HE_ID,
       LFR_DATE_APPROVED,
       LFR_DESCR,
       LFR_END_CHAIN,
       LFR_ITY_INV_CODE,
       LFR_START_CHAIN,
       LFR_ITY_SYS_FLAG
      )
    select LFR.lfr_atv_acty_area_code,
           LFR.lfr_int_code,
           p_rse_he_id_new,
           LFR.lfr_date_approved,
           LFR.lfr_descr,
           nm3merge.get_new_chainage(l_rse_length_1
                           ,l_rse_length_2
                           ,l_sys_flag_2
                           ,2
 				           ,p_new_starting_section						   
                           ,LFR.lfr_end_chain
						   ,p_flip_cardinality_of_2),
--        (LFR.lfr_end_chain + l_rse_length_1),
           LFR.lfr_ity_inv_code,
           nm3merge.get_new_chainage(l_rse_length_1
                            ,l_rse_length_2
                           ,l_sys_flag_2							
                            ,2
 				           ,p_new_starting_section							
                            ,LFR.lfr_start_chain
						    ,p_flip_cardinality_of_2),
--        (LFR.lfr_start_chain + l_rse_length_1),
           LFR.lfr_ity_sys_flag
    from   local_freqs LFR
    where  LFR.lfr_rse_he_id = p_rse_he_id_2;

    insert into LOCAL_FREQS
      (LFR_ATV_ACTY_AREA_CODE,
       LFR_INT_CODE,
       LFR_RSE_HE_ID,
       LFR_DATE_APPROVED,
       LFR_DESCR,
       LFR_END_CHAIN,
       LFR_ITY_INV_CODE,
       LFR_START_CHAIN,
       LFR_ITY_SYS_FLAG
      )
    select distinct SFR.sfr_atv_acty_area_code,
           SFR.sfr_int_code,
           p_rse_he_id_new,
           p_effective_date,
           'Defaulted by section Merge',
           (l_rse_length_1 + l_rse_length_2),
           LFR.lfr_ity_inv_code,
           l_rse_length_1,
           LFR.lfr_ity_sys_flag
    from   SECTION_FREQS SFR ,local_freqs LFR
    where  SFR.sfr_atv_acty_area_code = LFR.lfr_atv_acty_area_code
    and    SFR.sfr_rse_he_id = p_rse_he_id_new
    and    LFR.lfr_rse_he_id = p_rse_he_id_1
    and    not exists
          (select 'exists in Section#2 only so create a default for Section#1 part from Section Frequencies for new Section'
           from   local_freqs b
           where  b.lfr_atv_acty_area_code = LFR.lfr_atv_acty_area_code
           and    b.lfr_ity_inv_code = LFR.lfr_ity_inv_code
           and    b.lfr_rse_he_id = p_rse_he_id_2
          );

    delete from sect_freq1
    where tt1_rse_he_id = p_rse_he_id_new;
    delete from sect_freq2
    where tt2_rse_he_id = p_rse_he_id_new;
    
    open c3;
    fetch c3 into l_message;
    if c3%notfound then
      open c4;
      fetch c4 into l_message;
      close c4;
    end if;
    close c3;


-----------------------------------------------------------------------------
--
--   STRUCTURAL PROJECTS
--
-----------------------------------------------------------------------------
  --
  -- move schemes for the first original section onto the new section
  --
    update scheme_roads
    set    rse_he_id = p_rse_he_id_new
    where  rse_he_id = p_rse_he_id_1;

  --
  -- move schemes for the second original section onto the new section
  --
    update scheme_roads
    set    rse_he_id = p_rse_he_id_new,
           start_point =  nm3merge.get_new_chainage(l_rse_length_1
                                          ,l_rse_length_2
                                          ,l_sys_flag_2										  
                                          ,2
  				                          ,p_new_starting_section										  
                                          ,start_point
                                          ,p_flip_cardinality_of_2),
           end_point =  nm3merge.get_new_chainage(l_rse_length_1
                                        ,l_rse_length_2
                                        ,l_sys_flag_2										
                                        ,2
  				                        ,p_new_starting_section										
                                        ,end_point
                                        ,p_flip_cardinality_of_2)
--		   start_point+l_rse_length_1,
--           end_point   = end_point+l_rse_length_1
    where  rse_he_id = p_rse_he_id_2;

  end merge_data;


-----------------------------------------------------------------------------
--**** UNMERGE PROCEDURES *****
-----------------------------------------------------------------------------

  procedure check_data_unmerge
	(p_id       	in number,	     -- rse_he_id to be unmerged
	 p_actioned_date	in varchar2,
	 p_errors    	in out number,
	 p_error_string	in out varchar2) is
  --
  -- Checks that the user has supplied valid parameters.
  --

  begin

    maisplit.data_check(p_id, p_actioned_date, p_errors, p_error_string);

  end check_data_unmerge;

-----------------------------------------------------------------------------

  procedure unmerge_data
	(p_id           in number,	     -- rse_he_id to be unmerged
	 p_rse_he_id_1  in number,
	 p_rse_he_id_2  in number,
	 p_history_date in date) is

    l_length		number;
    l_table_name		varchar2(32);
    l_rmmsflag 		varchar2(1) := hig.get_sysopt('RMMSFLAG');
    l_unactioned_date   varchar2(22) := to_char(SYSDATE,
					       'DD-MON-YYYY,HH24:MI:SS');

    cursor c1 is
      select rse_length
      from   road_sections_all
      where  rse_he_id = p_rse_he_id_1;

  begin

-----------------------------------------------------------------------------
--
--   ACTIVITIES
--
-----------------------------------------------------------------------------
  -- activity_lines
    delete from act_report_lines
    where  arl_are_report_id in
  	  (select are_report_id
	   from activities_report
	   where are_rse_he_id = p_id);

  -- activities
    delete from activities_report
    where are_rse_he_id = p_id;

    open c1;
    fetch c1 into l_length;
    close c1;


-----------------------------------------------------------------------------
--
--   REPAIRS AND DEFECTS
--
-----------------------------------------------------------------------------
--
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
   WHERE def_rse_he_id = p_id;
--
  --
  -- Delete the defects belonging to the section
  -- which were created from the merge.
  --
    delete from defects
    where def_rse_he_id = p_id;

  --
  -- Set the compl dates to null for the
  -- original defects which were not completed before the merge. The
  -- records being updated at this point are those created as a history from
  -- the merge and the merge process set them as completed - the
  -- temp_undo_defect_edit table holds the true status of the defects.
  --


    update repairs
    set    rep_superseded_flag = 'N'
    where  rep_def_defect_id in (select def.def_defect_id
                                 from   defects def
                                 ,      temp_undo_defect_edit tmp
                                 where  def.def_superseded_id = tmp.def_defect_id
                                 and    tmp.def_rse_he_id = p_id
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
                             where  tmp.def_rse_he_id = p_id
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
           where  tmp.def_rse_he_id = p_id
           and    tmp.def_date_compl is null);

/* GJ/MH 15-FEB-2005 performance is dire
    delete from REPAIRS R
    where  not exists
          (select 'maintain referential integrity'
           from   DEFECTS D
           where  D.DEF_DEFECT_ID = R.REP_DEF_DEFECT_ID);
*/
    delete from REPAIRS R
    where  rep_def_defect_id in (select tmp.def_defect_id
                                 from   temp_undo_defect_edit tmp);	
-----------------------------------------------------------------------------
--
--   INVENTORY
--
-----------------------------------------------------------------------------
  --
  -- remove iit_primary_key from new iit records to be deleted and
  -- replace in the old iit records
  --
--    for i in c3 loop
--      update inv_items_all
--      set    iit_primary_key = null
--      where  iit_item_id = i.new_item;
--
--      update inv_items_all
--      set    iit_primary_key = i.iit_primary_key
--      where  iit_item_id = i.old_item;
--    end loop;
--
--  --inv_items_all
--    delete from inv_items_all
--    where iit_rse_he_id = p_id;
--
--  --inv_item_history
--    delete from inv_item_history
--    where iih_new_rse_he_id = p_id;
--
--  --inv_coord_flag
--    update inv_items_all
--    set    iit_coord_flag = 'I',
--	     iit_end_date = null,
--	     iit_last_updated_date = to_date(l_unactioned_date,
--					  'DD-MON-YYYY,HH24:MI:SS')
--    where  iit_rse_he_id in (p_rse_he_id_1,p_rse_he_id_2)
--    and    trunc(iit_end_date) = p_history_date;


-----------------------------------------------------------------------------
--
--   FREQUENCIES
--
-----------------------------------------------------------------------------
  --local_freq
    delete from local_freqs
    where  lfr_rse_he_id = p_id;

  --section_freq
    delete from section_freqs
    where sfr_rse_he_id = p_id;


-----------------------------------------------------------------------------
--
--   STRUCTURAL PROJECTS
--
-----------------------------------------------------------------------------

    maisplit.split_schemes(p_id, p_rse_he_id_1, p_rse_he_id_2, l_length);

-----------------------------------------------------------------------------
--
--   EXTERNAL ACTS
--
-----------------------------------------------------------------------------

  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  --This code was not called in NET1040.RPT
  -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  -- ext_act_road_usage
    delete from ext_act_road_usage
    where exu_rse_he_id = p_id
    and l_rmmsflag in ('3','4');


  --ext_act_end_date
    update ext_act_road_usage
    set    exu_sign_off_date = null,
 	     exu_current = 'Y',
	     exu_last_updated_date = to_date(l_unactioned_date,
					     'DD-MON-YYYY,HH24:MI:SS')
    where  exu_rse_he_id in (p_rse_he_id_1, p_rse_he_id_2)
    and    l_rmmsflag in ('3','4');

  end unmerge_data;
--
-----------------------------------------------------------------------------
--
END maimerge;
/
