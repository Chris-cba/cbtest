CREATE OR REPLACE package body maiclose is
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maiclose.pkb-arc   2.0   Jun 13 2007 17:36:52   smarshall  $
--       Module Name      : $Workfile:   maiclose.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:52  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.2
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maiclose.pck	1.2 02/16/98';
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------
  procedure check_data
       (p_id 		 in		number,
	  p_effective_date in		date,
	  p_errors		 in out	number,
	  p_error_string	 in out	varchar2) is

    l_message varchar2(80);

    cursor c1 is
      select 'ERROR : An uncompleted scheme exists for this section.'
      from   scheme_roads scr,
             schemes sch
      where  p_id = scr.rse_he_id
      and    scr.scheme_id = sch.scheme_id
      and   (p_effective_date < nvl(trunc(sch.date_work_complete),p_effective_date)
      or     sch.date_work_complete is null);

    cursor c2 is
      select 'ERROR : '||initcap(hsc_status_code)||' Defects exist for this section'
      from   defects,
             hig_status_codes
      where  def_rse_he_id = p_id
      and    hsc_domain_code = 'DEFECTS'
      and    instr(hsc_allow_feature1||hsc_allow_feature2||hsc_allow_feature5
                   ||hsc_allow_feature7, 'Y') > 0
      and    def_status_code = hsc_status_code
      and    def_date_compl is null;

  begin

    maisplit.check_data(p_id, 0, p_effective_date, p_errors, p_error_string);

    open c1;
    fetch c1 into l_message;
    if c1%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string := p_error_string||chr(13)||l_message;
    end if;
    close c1;

    open c2;
    fetch c2 into l_message;
    if c2%found then
      p_errors := p_errors + 1;
      dbms_output.put_line(l_message);
      p_error_string := p_error_string||chr(13)||l_message;
    end if;
    close c2;

  end check_data;

-----------------------------------------------------------------------------

  procedure close_data
       (p_id 		 in	number,
	  p_effective_date in	date) is

    l_actioned_date  varchar2(22) := to_char(SYSDATE,'DD-MON-YYYY,HH24:MI:SS');

  begin


    -- CP 13/11/2006  Test Id 39894
    -- Comment out the update inv_items_all as handled via nm3 code
    --update inv_items_all
    --set    iit_end_date = p_effective_date,
    --       iit_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS'),
    --       iit_coord_flag = decode(iit_coord_flag,'I',null,'D')
    --where  iit_end_date is null
    --and    iit_rse_he_id = p_id;

    update repairs
    set    rep_date_completed = p_effective_date,
           rep_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  rep_date_completed is null
    and    rep_rse_he_id = p_id;

    update defects
    set    def_date_compl = p_effective_date,
           def_date_not_found = p_effective_date,
           def_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  def_date_compl is null
    and    def_rse_he_id = p_id;

    update ext_act_road_usage
    set    exu_sign_off_date = p_effective_date,
           exu_last_updated_date = to_date(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  exu_rse_he_id = p_id;

  end close_data;

-----------------------------------------------------------------------------
--**** UNCLOSE PROCEDURES *****
-----------------------------------------------------------------------------

  procedure unclose_data
	(p_id       	in     	number,	      -- section to be unclosed
	 p_history_date 	in     	varchar2) is

    l_unactioned_date 	varchar2(22) := to_char(SYSDATE,'DD-MON-YYYY,HH24:MI:SS');
    l_rmmsflag 	      varchar2(1) := hig.get_sysopt('RMMSFLAG');

  begin

    -- CP 13/11/2006  Test Id 39894
    -- Comment out the update inv_items_all as handled via nm3 code
    --update inv_items_all
    --set    iit_coord_flag = 'I',
    --       iit_end_date = null,
    --       iit_last_updated_date = to_date(l_unactioned_date,'DD-MON-YYYY,HH24:MI:SS')
    --where  iit_rse_he_id = p_id
    --and    trunc(iit_end_date) = to_date(p_history_date);

    update repairs
    set    rep_date_completed = null,
	     rep_last_updated_date = to_date(l_unactioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  trunc(rep_date_completed) = to_date(p_history_date)
    and    rep_rse_he_id = p_id
    and    rep_def_defect_id
           in (select def_defect_id
               from   defects
               where  trunc(def_date_compl) = to_date(p_history_date)
               and    trunc(def_date_not_found) = to_date(p_history_date)
               and    def_rse_he_id = p_id);

    update defects
    set    def_date_compl = null,
           def_date_not_found = null,
           def_last_updated_date = to_date(l_unactioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  trunc(def_date_compl) = to_date(p_history_date)
    and    trunc(def_date_not_found) = to_date(p_history_date)
    and    def_rse_he_id = p_id;

    update ext_act_road_usage
    set    exu_sign_off_date = null,
 	     exu_current = 'Y',
           exu_last_updated_date = to_date(l_unactioned_date ,'DD-MON-YYYY,HH24:MI:SS')
    where  exu_rse_he_id = p_id
    and    l_rmmsflag in ('3','4');

  end unclose_data;

end maiclose;
/
