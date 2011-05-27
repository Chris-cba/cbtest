CREATE OR REPLACE PACKAGE BODY mairecal AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mairecal.pkb-arc   2.2   May 27 2011 09:45:44   Steve.Cooper  $
--       Module Name      : $Workfile:   mairecal.pkb  $
--       Date into SCCS   : $Date:   May 27 2011 09:45:44  $
--       Date fetched Out : $Modtime:   May 25 2011 13:09:00  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.3
--
--	This package contains procedures and functions which are required by
--	the Shift / Recalibrate process within Network Manager.
--
--	Maintenance Manager specific functionality can be found here,
--	whilst the core functionality of the network processes can be found
--	in the HIGRECAL package.
--
--  Originally taken from '@(#)mairecal.pck 1.4 08/07/98';
--  Now taken from '@(#)mairecal.pck	1.5 01/30/03';
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------

/* History
  05.12.07 PT rewrite of recal_data() - now uses the recalibrate start point parameter like other products
                this fixes the bug that start point was not considered in recalibrate
*/

   g_body_sccsid     CONSTANT  varchar2(2000) := '@(#)$Revision:   2.2  $';
   g_package_name    CONSTANT  varchar2(30)   := 'mairecal';
--
   l_rmmsflag                  hig_options.hop_value%TYPE := hig.get_sysopt('RMMSFLAG');
--
-----------------------------------------------------------------------------
--
  procedure check_overhang(p_min_chain    	in 	number,
			   p_max_chain    	in 	number,
			   p_length 		in	road_sections.rse_length%type,
			   p_adjust		in	number,
                           p_err_text     	in     	varchar2,
                           p_errors       	in out 	number,
                           p_error_string 	in out 	varchar2);
                           
  type placement_tbl_rec is record (
     begin_mp nm3type.tab_number
    ,end_mp nm3type.tab_number
  );

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
------------------------------------------------------------------------------
--**** SHIFT PROCEDURES *****
-----------------------------------------------------------------------------

  procedure check_data
	(p_rse_he_id	  in number,   	-- section to shift
	 p_new_length  	  in number, 	-- new shift length
	 p_from_chain	  in number,	-- chainage from which to shift
       p_chain_adjust	  in number,	-- chainage to shift by
	 p_errors    	  in out number,
	 p_error_string	  in out varchar2) is

    l_min_chain  inv_items_all.iit_st_chain%type;
    l_max_chain  inv_items_all.iit_st_chain%type;
    l_message    varchar2(80);

--    cursor c1 is
--      select min(iit_st_chain), max(iit_end_chain)
--      from   inv_items
--      where  iit_rse_he_id = p_rse_he_id
--      and    iit_st_chain >= p_from_chain;

    cursor c2 is
      select min(are_st_chain), max(are_end_chain)
      from   activities_report
      where  are_rse_he_id = p_rse_he_id
      and    are_st_chain >= p_from_chain;

    cursor c3 is
      select min(def_st_chain), max(def_st_chain)
      from   defects
      where  def_rse_he_id = p_rse_he_id
      and    def_st_chain >= p_from_chain;

/*
    cursor c4 is
      select min(st_chain), max(end_chain)
      from   hhinv_item_err_2
      where  he_id     = p_rse_he_id
      and    st_chain >= p_from_chain;

    cursor c5 is
      select min(st_chain), max(end_chain)
      from   hhinv_load_2
      where  he_id     = p_rse_he_id
      and    st_chain >= p_from_chain;

    cursor c6 is
      SELECT MIN(st_chain), MAX(end_chain)
      FROM   hhinv_load_3
      where  he_id     = p_rse_he_id
      and    st_chain >= p_from_chain;
*/
    cursor c7 is
      SELECT MIN(lfr_start_chain), MAX(lfr_end_chain)
      FROM   local_freqs
      where  lfr_rse_he_id    = p_rse_he_id
      and    lfr_start_chain >= p_from_chain;

    cursor c8 is
      select MIN(wol_are_st_chain), MAX(wol_are_st_chain)
      from   work_order_lines
      where  wol_rse_he_id     = p_rse_he_id
      and    wol_are_st_chain >= p_from_chain;

    cursor c9 is
      select min(start_point), max(end_point)
      from   scheme_roads
      where  rse_he_id = p_rse_he_id
      and    start_point >= p_from_chain;

  begin

--    open c1;
--    fetch c1 into l_min_chain, l_max_chain;
--    if c1%notfound then
--      p_errors := p_errors + 1;
--      l_message := 'ERROR : There is no inventory present at the chainage entered.';
--      dbms_output.put_line(l_message);
--      p_error_string := p_error_string||chr(13)||l_message;
--    end if;
--    close c1;

--    check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
--				    'inventory', p_errors, p_error_string);

    open c2;
    fetch c2 into l_min_chain, l_max_chain;
    if c2%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'activity reports', p_errors, p_error_string);
    end if;
    close c2;

    open c3;
    fetch c3 into l_min_chain, l_max_chain;
    if c3%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'defects', p_errors, p_error_string);
    end if;
    close c3;
/*
    open c4;
    fetch c4 into l_min_chain, l_max_chain;
    if c4%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'inventory in load work tables', p_errors, p_error_string);
    end if;
    close c4;

    open c5;
    fetch c5 into l_min_chain, l_max_chain;
    if c5%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'inventory in load work tables', p_errors, p_error_string);
    end if;
    close c5;

    open c6;
    fetch c6 into l_min_chain, l_max_chain;
    if c6%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'inventory in load work tables', p_errors, p_error_string);
    end if;
    close c6;
*/
    open c7;
    fetch c7 into l_min_chain, l_max_chain;
    if c7%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'local frequencies', p_errors, p_error_string);
    end if;
    close c7;

    open c8;
    fetch c8 into l_min_chain, l_max_chain;
    if c8%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'work order details', p_errors, p_error_string);
    end if;
    close c8;

    open c9;
    fetch c9 into l_min_chain, l_max_chain;
    if c9%found then
      check_overhang(l_min_chain, l_max_chain, p_new_length, p_chain_adjust,
					'scheme details', p_errors, p_error_string);
    end if;
    close c9;

  end check_data;

-----------------------------------------------------------------------------

/****************************************************************************
*                                                                           *
*  Not sure if the business rules here are correct. Take the case where an  *
*  inventory item has a start chainage of 5 less than the shift from point  *
*  and an end chainage 5 after. If the adjustment is 10 this item will not  *
*  be affected by the shift. Should it be???                                *
*                                                                           *
****************************************************************************/

  procedure shift_data
	(p_rse_he_id	  in number,   	-- section to shift
	 p_new_length  	  in number, 	-- not required here
	 p_from_chain	  in number,	-- chainage from which to shift
       p_chain_adjust	  in number) is	-- chainage to shift by
  --
  --  This procedure updates all tables that hold a start/end chainage
  --  and increments both the start/end values by the amount of the shift.
  --  This occurs for ALL "items" that start AFTER, ON or SPAN (ie. start
  --  before and end after) the shift point.
  --

    l_actioned_date varchar2(22) := to_char(SYSDATE, 'DD-MON-YYYY,HH24:MI:SS');

  begin

--    update inv_items
--    set    iit_st_chain = decode(sign(iit_st_chain - p_from_chain), -1, iit_st_chain,
--                          iit_st_chain + p_chain_adjust),
--           iit_end_chain = iit_end_chain + p_chain_adjust,
--           iit_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
--    where  iit_rse_he_id = p_rse_he_id
--    and   (iit_st_chain >= p_from_chain
--    or     iit_end_chain >= p_from_chain);

    --update road_sections
    --set    rse_max_chain = (
    --         select greatest(max(nvl(iit_st_chain,0)), max(nvl(iit_end_chain,0)))
    --         from   inv_items
    --         where  iit_rse_he_id = p_rse_he_id),
    --       rse_length = p_new_length
    --where  rse_he_id = p_rse_he_id;

    update activities_report
    set    are_st_chain = decode(sign(are_st_chain - p_from_chain), -1, are_st_chain,
                          are_st_chain + p_chain_adjust),
           are_end_chain = are_end_chain + p_chain_adjust,
           are_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  are_rse_he_id = p_rse_he_id
    and   (are_st_chain >= p_from_chain
    or     are_end_chain >= p_from_chain);

    update defects
    set    def_st_chain = decode(sign(def_st_chain - p_from_chain), -1, def_st_chain,
				  def_st_chain + p_chain_adjust),
           def_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  def_rse_he_id = p_rse_he_id
    and    def_st_chain >= p_from_chain;
/*
    update hhinv_item_err_2
    set    st_chain = decode(sign(st_chain - p_from_chain), -1, st_chain,
			    st_chain  + p_chain_adjust),
           end_chain = end_chain + p_chain_adjust
    where  he_id     = p_rse_he_id
    and   (st_chain >= p_from_chain
    or     end_chain >= p_from_chain);

    update hhinv_load_2
    set    st_chain  = decode(sign(st_chain - p_from_chain), -1, st_chain,
			     st_chain  + p_chain_adjust),
           end_chain = end_chain + p_chain_adjust
    where  he_id = p_rse_he_id
    and   (st_chain >= p_from_chain
    or     end_chain >= p_from_chain);

    update hhinv_load_3
    set    st_chain  = decode(sign(st_chain - p_from_chain), -1, st_chain,
			     st_chain  + p_chain_adjust),
           end_chain = end_chain + p_chain_adjust
    where  he_id = p_rse_he_id
    and   (st_chain >= p_from_chain
    or     end_chain >= p_from_chain);
*/
    update local_freqs
    set    lfr_start_chain = decode(sign(lfr_start_chain - p_from_chain), -1,
				    lfr_start_chain, lfr_start_chain  + p_chain_adjust),
           lfr_end_chain = lfr_end_chain + p_chain_adjust
    where  lfr_rse_he_id = p_rse_he_id
    and   (lfr_start_chain >= p_from_chain
    or     lfr_end_chain >= p_from_chain);

    update work_order_lines
    set    wol_are_st_chain = decode(sign(wol_are_st_chain - p_from_chain), -1,
				      wol_are_st_chain, wol_are_st_chain + p_chain_adjust)
    where  wol_rse_he_id = p_rse_he_id
    and    wol_are_st_chain >= p_from_chain;

    update scheme_roads
    set    start_point = decode(sign(start_point - p_from_chain), -1, start_point,
                         start_point + p_chain_adjust),
           end_point = end_point + p_chain_adjust
    where  rse_he_id = p_rse_he_id
    and   (start_point >= p_from_chain
    or     end_point >= p_from_chain);

  end shift_data;

-----------------------------------------------------------------------------
--**** RECALIBRATE PROCEDURES *****
-----------------------------------------------------------------------------


  procedure recalibrate_placements(
     ptr_mp in out placement_tbl_rec
    ,pi_recal_start_point in number
    ,pi_length_ratio in number
    ,pi_dec_places in number
  )
  is
    l_new_begin_mp        number;
    l_new_end_mp          number;
    l_begin_mp_from_recal number;
    l_end_mp_from_recal   number;
    
  begin
    for i in 1 .. ptr_mp.begin_mp.count loop
      l_begin_mp_from_recal := ptr_mp.begin_mp(i) - pi_recal_start_point;
      
      if ptr_mp.begin_mp(i) < pi_recal_start_point then
         l_new_begin_mp := ptr_mp.begin_mp(i);
         
      else
         l_new_begin_mp := pi_recal_start_point + (l_begin_mp_from_recal * pi_length_ratio);
         
      end if;
      
      l_end_mp_from_recal := ptr_mp.end_mp(i) - pi_recal_start_point;
      
      if ptr_mp.end_mp(i) < pi_recal_start_point then
         l_new_end_mp := ptr_mp.end_mp(i);
         
      else
         l_new_end_mp := pi_recal_start_point + (l_end_mp_from_recal * pi_length_ratio);
         
      end if;

      ptr_mp.begin_mp(i)  := round(l_new_begin_mp, pi_dec_places);
      ptr_mp.end_mp(i) := round(l_new_end_mp, pi_dec_places );
    
    end loop;
    
  end;


  procedure recal_data(
     pi_ne_id in number
    ,pi_recal_start_point in number
    ,pi_length_ratio in number
    ,pi_dec_places in number
  )
  is
    t_rowid     nm3type.tab_rowid;
    tr_mp       placement_tbl_rec;
    l_actioned_date constant date := sysdate;

  begin
  
    -- activities report
    select rowid, are_st_chain, are_end_chain
    bulk collect into t_rowid, tr_mp.begin_mp, tr_mp.end_mp
    from activities_report
      where are_rse_he_id = pi_ne_id
        and are_end_chain >= pi_recal_start_point;
    recalibrate_placements(
       ptr_mp               => tr_mp
      ,pi_recal_start_point => pi_recal_start_point
      ,pi_length_ratio      => pi_length_ratio
      ,pi_dec_places        => pi_dec_places
    );
    forall i in 1..t_rowid.count
    update activities_report set
       are_st_chain  = tr_mp.begin_mp(i)
      ,are_end_chain = tr_mp.end_mp(i)
      ,are_last_updated_date = l_actioned_date
    where rowid = t_rowid(i);
    

    -- defects
    select rowid, def_st_chain, def_st_chain
    bulk collect into t_rowid, tr_mp.begin_mp, tr_mp.end_mp
    from defects
      where def_rse_he_id = pi_ne_id
        and def_st_chain >= pi_recal_start_point;
    recalibrate_placements(
       ptr_mp               => tr_mp
      ,pi_recal_start_point => pi_recal_start_point
      ,pi_length_ratio      => pi_length_ratio
      ,pi_dec_places        => pi_dec_places
    );
    forall i in 1..t_rowid.count
    update defects set
       def_st_chain  = tr_mp.begin_mp(i)
      ,def_last_updated_date = l_actioned_date
    where rowid = t_rowid(i);
    
    
    -- local_freqs
    select rowid, lfr_start_chain, lfr_end_chain
    bulk collect into t_rowid, tr_mp.begin_mp, tr_mp.end_mp
    from local_freqs
      where lfr_rse_he_id = pi_ne_id
        and lfr_end_chain >= pi_recal_start_point;
    recalibrate_placements(
       ptr_mp               => tr_mp
      ,pi_recal_start_point => pi_recal_start_point
      ,pi_length_ratio      => pi_length_ratio
      ,pi_dec_places        => pi_dec_places
    );
    forall i in 1..t_rowid.count
    update local_freqs set
       lfr_start_chain  = tr_mp.begin_mp(i)
      ,lfr_end_chain = tr_mp.end_mp(i)
    where rowid = t_rowid(i);
    
    
    -- work_order_lines
    select rowid, wol_are_st_chain, wol_are_st_chain
    bulk collect into t_rowid, tr_mp.begin_mp, tr_mp.end_mp
    from work_order_lines
      where wol_rse_he_id = pi_ne_id
        and wol_are_st_chain >= pi_recal_start_point;
    recalibrate_placements(
       ptr_mp               => tr_mp
      ,pi_recal_start_point => pi_recal_start_point
      ,pi_length_ratio      => pi_length_ratio
      ,pi_dec_places        => pi_dec_places
    );
    forall i in 1..t_rowid.count
    update work_order_lines set
       wol_are_st_chain  = tr_mp.begin_mp(i)
    where rowid = t_rowid(i);
    
    
    -- scheme_roads
    select rowid, start_point, end_point
    bulk collect into t_rowid, tr_mp.begin_mp, tr_mp.end_mp
    from scheme_roads
      where rse_he_id = pi_ne_id
        and end_point >= pi_recal_start_point;
    recalibrate_placements(
       ptr_mp               => tr_mp
      ,pi_recal_start_point => pi_recal_start_point
      ,pi_length_ratio      => pi_length_ratio
      ,pi_dec_places        => pi_dec_places
    );
    forall i in 1..t_rowid.count
    update scheme_roads set
       start_point  = tr_mp.begin_mp(i)
      ,end_point = tr_mp.end_mp(i)
    where rowid = t_rowid(i);
    

--     update activities_report
--     set    are_st_chain  = round(are_st_chain * l_recal_factor),
--            are_end_chain  = round(are_end_chain * l_recal_factor),
--            are_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
--      where  are_rse_he_id = p_rse_he_id;

--     update defects
--     set     def_st_chain = round(def_st_chain * l_recal_factor),
--             def_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
--     where   def_rse_he_id = p_rse_he_id;
    
    
-- PT all the hhinv_ tables were alerady commented out
--    update hhinv_item_err_2
--    set    st_chain = round(st_chain * l_recal_factor),
--           end_chain = round(end_chain * l_recal_factor)
--    where  he_id = p_rse_he_id;
--
--    update hhinv_load_2
--    set    st_chain = round(st_chain * l_recal_factor),
--           end_chain = round(end_chain * l_recal_factor)
--    where  he_id = p_rse_he_id;
--
--    update hhinv_load_3
--    set    st_chain = round(st_chain * l_recal_factor),
--           end_chain = round(end_chain * l_recal_factor)
--    where  he_id = p_rse_he_id;

-- PT the active tables continue here
--     update local_freqs
--     set   lfr_start_chain = round(lfr_start_chain * l_recal_factor),
--           lfr_end_chain   = round(lfr_end_chain * l_recal_factor)
--     where lfr_rse_he_id = p_rse_he_id;

--     update work_order_lines
--     set   wol_are_st_chain = round(wol_are_st_chain * l_recal_factor)
--     where wol_rse_he_id = p_rse_he_id;

--     update scheme_roads
--     set    start_point = round(start_point * l_recal_factor),
--            end_point = round(end_point * l_recal_factor)
--     where  rse_he_id = p_rse_he_id;

  end recal_data;
--
---------------------------------------------------------------------------------
--
PROCEDURE mai_reversal ( p_effective_date DATE DEFAULT To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY')) IS
-- This procedure will create new MAI objects
-- after a reversal has been done on a route.
-- the nm_reversal table needs to be populated
--
--
-- This is basically a copy of the mairepl.replace_data procedure
--  except that all of the MPs (chainages) used are the length complement
--  do deal with the reversed data
--
    l_are_report_id	number;
    l_def_defect_id	number;
    l_table_name		varchar2(32);
    l_actioned_date	varchar2(22) := to_char(sysdate ,'DD-MON-YYYY,HH24:MI:SS');
    l_actioned	        date := to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS');
    l_rse_length_1	number;
    l_rse_sys_flag      varchar2(1);
--
    l_ne_id         NUMBER;
    l_ne_id_new     NUMBER;
    l_tab_ne_id_orig    nm3type.tab_number;
    l_tab_ne_id_new     nm3type.tab_number;
--
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
                                and    def_rse_he_id       = l_ne_id
                               );

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

  begin
--
   nm_debug.proc_start(g_package_name,'mai_reversal');
--
   SELECT ne_id
         ,ne_new_id
    BULK  COLLECT
    INTO  l_tab_ne_id_orig
         ,l_tab_ne_id_new
    FROM  nm_reversal;
--
-----------------------------------------------------------------------------
--
--   ACTIVITY REPORTS, DEFECTS, REPAIRS
--
-----------------------------------------------------------------------------

   FOR reversal_index IN 1..l_tab_ne_id_orig.COUNT
    LOOP
      l_ne_id     := l_tab_ne_id_orig(reversal_index);
      l_ne_id_new := l_tab_ne_id_new(reversal_index);
     for i in c_open_insp loop
       open c2;
       fetch c2 into l_are_report_id;
       close c2;
       maisplit.create_new_insp(i.are_report_id
                               ,l_are_report_id
                               ,l_ne_id_new
                               ,nm3rvrs.reverse_length(l_ne_id_new , i.are_st_chain )
                               ,nm3rvrs.reverse_length(l_ne_id_new , i.are_end_chain )
                               ,p_effective_date);
       for j in c_defects(i.are_report_id) loop
         open c3;
         fetch c3 into l_def_defect_id;
         close c3;
         maisplit.create_new_defect(j.def_defect_id
                                   ,l_def_defect_id
                                   ,l_ne_id_new
                                   ,l_are_report_id
                                   ,nm3rvrs.reverse_length(l_ne_id_new , j.def_st_chain )
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
       select 	l_ne_id_new,
   		EXU_EXT_ID,
   		EXU_CURRENT,
   		EXU_START_DATE,
   		EXU_SIGN_OFF_DATE,
   		to_date( l_actioned_date,'DD-MON-YYYY,HH24:MI:SS'),
   		to_date( l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
       from   	ext_act_road_usage
       where  	EXU_RSE_HE_ID = l_ne_id
       and    	l_rmmsflag in ('3','4');

       update  ext_act_road_usage
       set 	exu_sign_off_date = p_effective_date,
   	 	exu_current = null,
   	 	EXU_LAST_UPDATED_DATE = to_date(l_actioned_date,'DD-MON-YYYY,HH24:MI:SS')
       where 	exu_rse_he_id = l_ne_id
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
           l_ne_id_new,lfr_approved_by,
           lfr_approved_ref,lfr_date_approved,lfr_descr,
           nm3rvrs.reverse_length(l_ne_id_new , lfr_end_chain ),
           lfr_ity_inv_code,nm3rvrs.reverse_length(l_ne_id_new , lfr_start_chain ),
           lfr_ity_sys_flag
           from local_freqs
       where lfr_rse_he_id = l_ne_id;

     --section_freq
       INSERT INTO section_freqs
           (	 SFR_ATV_ACTY_AREA_CODE,
           	SFR_INT_CODE,
           	SFR_RSE_HE_ID )
       SELECT 	SFR_ATV_ACTY_AREA_CODE,
   		SFR_INT_CODE,
   		l_ne_id_new
       FROM	section_freqs
       WHERE 	SFR_RSE_HE_ID = l_ne_id;


   -----------------------------------------------------------------------------
   --
   --   STRUCTURAL PROJECTS
   --
   -----------------------------------------------------------------------------

       update scheme_roads
       set    rse_he_id = l_ne_id_new
       where  rse_he_id = l_ne_id;
   END LOOP;
--
   nm_debug.proc_end(g_package_name,'mai_reversal');
--
END mai_reversal;
--
-----------------------------------------------------------------------------
--
  procedure check_overhang(p_min_chain    	in 	number,
			   p_max_chain    	in 	number,
			   p_length 		in	road_sections.rse_length%type,
			   p_adjust		in	number,
                           p_err_text     	in     	varchar2,
                           p_errors       	in out 	number,
                           p_error_string 	in out 	varchar2) is

    l_message varchar2(80);

  --
  --    Function to check if items are shifted off the beginning of the section
  --    OR off the end, OR point items (which have only a start chain)
  --    exceed the end of the section
  --
      function overhang(p_min_chain number,
                        p_max_chain number ) return boolean is
      begin

        if (nvl(p_min_chain,999999) + nvl(p_adjust,0) < 0) or
           (nvl(p_max_chain,0) + nvl(p_adjust,0) > (nvl(p_length,0) * 1.05)) or
           (nvl(p_min_chain,0) + nvl(p_adjust,0) > (nvl(p_length,0) * 1.05)) then

          return TRUE;
        else
          return FALSE;
        end if;

      end overhang;

    begin

      if overhang(p_min_chain, p_max_chain) then
        p_errors := p_errors + 1;
        l_message := 'ERROR : Overhanging '||p_err_text||' shift aborted.';
        dbms_output.put_line(l_message);
        p_error_string := p_error_string||chr(13)||l_message;
      end if;

    end check_overhang;
--
-----------------------------------------------------------------------------
--
PROCEDURE mai_reclassify
                    (pi_old_ne_id      nm_elements.ne_id%TYPE
                    ,pi_new_ne_id      nm_elements.ne_id%TYPE
                    ,pi_effective_date DATE
                    ) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'mai_reclassify');
--
   mairepl.replace_data
	(p_rse_he_id_new  => pi_new_ne_id
	,p_rse_he_id      => pi_old_ne_id
	,p_effective_date => pi_effective_date
	);
--
   nm_debug.proc_end(g_package_name,'mai_reclassify');
--
END mai_reclassify;
--
-----------------------------------------------------------------------------
--
END mairecal;
/
