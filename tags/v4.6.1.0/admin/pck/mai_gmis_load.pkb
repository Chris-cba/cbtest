CREATE OR REPLACE PACKAGE BODY mai_gmis_load AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_gmis_load.pkb-arc   2.2   Jan 07 2013 09:50:32   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_gmis_load.pkb  $
--       Date into SCCS   : $Date:   Jan 07 2013 09:50:32  $
--       Date fetched Out : $Modtime:   Jul 20 2012 11:26:48  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.20
--
--
--   Author : D. Cope
--
--   Gmis survery file loader package
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2004
-----------------------------------------------------------------------------
--
--all global package variables here
--
   g_body_sccsid     CONSTANT  varchar2(2000) := '$Revision:   2.2  $';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mai_gmis_load';
--
   c_this_module     CONSTANT  hig_modules.hmo_module%TYPE := 'MAIWEB2540';
   c_module_title    CONSTANT  hig_modules.hmo_title%TYPE  := hig.get_module_title(c_this_module);
   --c_survey_filename CONSTANT  nm_upload_files.name%TYPE   := 'SURVEY.DAT';
-- file constants
   c_ne_type             CONSTANT  nm_elements.ne_type%TYPE    := 'HERM';
   c_are_maint_insp_flag CONSTANT  activities_report.are_maint_insp_flag%TYPE := 'D';
   c_def_siss_id         CONSTANT  defects.def_siss_id%TYPE := 'ALL'; -- default SISS type
   c_rep_action_cat      CONSTANT  repairs.rep_action_cat%TYPE  := 'P'; -- default to permanent repair
   c_dummy_arl           CONSTANT  act_report_lines.arl_atv_acty_area_code%TYPE := 'DU';
  -- boq items
   c_boq_work_flag       CONSTANT  boq_items.boq_work_flag%TYPE := 'D';
   c_boq_no_wol_id       CONSTANT  boq_items.boq_wol_id%TYPE    := 0; -- no wol id as yet
   c_boq_est_dim1        CONSTANT  boq_items.boq_est_dim1%TYPE  := 1;

--
  -- stores of parsed information
  g_are_report       activities_report%ROWTYPE;
  g_arl              act_report_lines%ROWTYPE;
  g_defect_status    defects.def_superseded_flag%TYPE;
  g_repair           repairs%ROWTYPE;
  g_boq              boq_items%ROWTYPE;
--
-- flag to determine if defect has been entered or not
  g_inspection_outstanding boolean := FALSE;
  g_defect_outstanding     boolean := FALSE;
  g_repair_outstanding     boolean := FALSE;
-- batch id
  g_batch_id         activities_report.are_batch_id%TYPE;
  
  -- PT: type and variable to hold id's of defects
  -- Used in tracking newly created defects; cleared in clear_all_details()
	type defect_id_tbl is table of DEFECTS.DEF_DEFECT_ID%type index by binary_integer;
  g_defect_id_tbl defect_id_tbl;
  
  g_dbglevel constant number := 2;
--
-----------------------------------------------------------------------------
--
PROCEDURE sccs_tags IS
BEGIN
   htp.p('<!--');
   htp.p('--');
   htp.p('-----------------------------------------------------------------------------');
   htp.p('--');
   htp.p('--   SCCS Identifiers :-');
   htp.p('--');
   htp.p('--       sccsid           : @(#)mai_gmis_load.pkb	1.9 03/30/05');
   htp.p('--       Module Name      : mai_gmis_load.pkb');
   htp.p('--       Date into SCCS   : 05/03/30 11:17:29');
   htp.p('--       Date fetched Out : 05/03/30 11:17:33');
   htp.p('--       SCCS Version     : 1.9');
   htp.p('--');
   htp.p('--');
   htp.p('--   Author : D. Cope');
   htp.p('--');
   htp.p('--   Gmis survery file loader package');
   htp.p('--');
   htp.p('-----------------------------------------------------------------------------');
   htp.p('--	Copyright (c) exor corporation ltd, 2004');
   htp.p('-----------------------------------------------------------------------------');
   htp.p('--');
   htp.p('-->');
END sccs_tags;
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
-- PT translates boolean to varchar2 for debug
function to_char(p_in in boolean) return varchar2 is
begin
	if p_in then return 'true';
  elsif not p_in then return 'false';
  else return null;
  end if;
end;
--
-----------------------------------------------------------------------------
--
FUNCTION get_a_field (p_line  IN varchar2
                     ,p_field IN pls_integer) RETURN varchar2 IS
BEGIN

   RETURN nm3load.get_csv_value_from_line(p_seq        => p_field
                                         ,p_delim_char => CHR(44)
                                         ,p_line       => p_line);
END get_a_field;
--
-----------------------------------------------------------------------------
--
PROCEDURE show_status (p_load_file IN boolean DEFAULT FALSE
                      ,p_batch     IN activities_report.are_batch_id%TYPE DEFAULT NULL
                      ,p_msg       IN varchar2 DEFAULT NULL
                      ,p_loadfile  IN varchar2 DEFAULT NULL) IS

BEGIN
  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'show_status');

  -- if we have a file to load then go ahead and process
  IF p_load_file THEN
    gmis_loader(p_loadfile => p_loadfile);
  ELSE
    nm3web.head(p_close_head => FALSE
               ,p_title      => c_module_title);

    htp.headclose;

    htp.bodyopen;

    nm3web.module_startup(pi_module => c_this_module);

    htp.header(2, hig.get_module_title(a_module => c_this_module));

    htp.br;

    htp.tableopen(cborder => 'border=0');

    htp.formopen(curl     => g_package_name||'.load_survey_file');

    htp.p('</td>');
    htp.tablerowclose;

    htp.tablerowopen;


    htp.tabledata(htf.formsubmit(cvalue => 'Return'));

    htp.tablerowclose;

    htp.formclose;

    htp.tableclose;

    IF p_batch IS NOT NULL THEN
      htp.header(2, 'Batch: '||p_batch);
    END IF;

    IF p_msg IS NOT NULL THEN
      htp.header(2, p_msg);
    END IF;

    nm3web.CLOSE;

  END IF;

  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'show_status');
END show_status;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug_arl (pi_rec_arl act_report_lines%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
   nm_debug.debug('arl_act_status         : '||pi_rec_arl.arl_act_status,p_level);
   nm_debug.debug('arl_are_report_id      : '||pi_rec_arl.arl_are_report_id,p_level);
   nm_debug.debug('arl_atv_acty_area_code : '||pi_rec_arl.arl_atv_acty_area_code,p_level);
   nm_debug.debug('arl_created_date       : '||pi_rec_arl.arl_created_date,p_level);
   nm_debug.debug('arl_last_updated_date  : '||pi_rec_arl.arl_last_updated_date,p_level);
   nm_debug.debug('arl_not_seq_flag       : '||pi_rec_arl.arl_not_seq_flag,p_level);
   nm_debug.debug('arl_report_id_part_of  : '||pi_rec_arl.arl_report_id_part_of,p_level);
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug_rep (pi_rec_rep repairs%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.debug('rep_def_defect_id      : '||pi_rec_rep.rep_def_defect_id,p_level);
   nm_debug.debug('rep_action_cat         : '||pi_rec_rep.rep_action_cat,p_level);
   nm_debug.debug('rep_rse_he_id          : '||pi_rec_rep.rep_rse_he_id,p_level);
   nm_debug.debug('rep_tre_treat_code     : '||pi_rec_rep.rep_tre_treat_code,p_level);
   nm_debug.debug('rep_atv_acty_area_code : '||pi_rec_rep.rep_atv_acty_area_code,p_level);
   nm_debug.debug('rep_created_date       : '||pi_rec_rep.rep_created_date,p_level);
   nm_debug.debug('rep_date_due           : '||pi_rec_rep.rep_date_due,p_level);
   nm_debug.debug('rep_last_updated_date  : '||pi_rec_rep.rep_last_updated_date,p_level);
   nm_debug.debug('rep_superseded_flag    : '||pi_rec_rep.rep_superseded_flag,p_level);
   nm_debug.debug('rep_completed_hrs      : '||pi_rec_rep.rep_completed_hrs,p_level);
   nm_debug.debug('rep_completed_mins     : '||pi_rec_rep.rep_completed_mins,p_level);
   nm_debug.debug('rep_date_completed     : '||pi_rec_rep.rep_date_completed,p_level);
   nm_debug.debug('rep_descr              : '||pi_rec_rep.rep_descr,p_level);
   nm_debug.debug('rep_local_date_due     : '||pi_rec_rep.rep_local_date_due,p_level);
   nm_debug.debug('rep_old_due_date       : '||pi_rec_rep.rep_old_due_date,p_level);
--
END debug_rep;
--
-----------------------------------------------------------------------------
--
PROCEDURE clear_defect IS
l_dummy_def defects%ROWTYPE;
BEGIN
  g_defect := l_dummy_def;
  g_defect_outstanding:= FALSE;
END clear_defect;
--
-----------------------------------------------------------------------------
--
PROCEDURE clear_repair IS
l_dummy_rep repairs%ROWTYPE;
BEGIN
  g_repair := l_dummy_rep;
  g_repair_outstanding := FALSE;
END clear_repair;
--
-----------------------------------------------------------------------------
--
PROCEDURE clear_boq IS
l_dummy_boq boq_items%ROWTYPE;
BEGIN
  g_boq := l_dummy_boq;
END clear_boq;
--
-----------------------------------------------------------------------------
--
PROCEDURE clear_all_details IS
l_dummy_act activities_report%ROWTYPE;
l_dummy_arl act_report_lines%ROWTYPE;
BEGIN
  nm_debug.debug('clear_all_details', g_dbglevel);
  g_inspection_outstanding  := FALSE;
  g_are_report              := l_dummy_act;
  g_are_report.are_batch_id := g_batch_id;
  g_arl                     := l_dummy_arl;
  
  -- now call the others
  clear_defect;
  clear_repair;
  clear_boq;
END clear_all_details;
--
-----------------------------------------------------------------------------
--
PROCEDURE defect_outstanding IS
BEGIN
  g_defect_outstanding := TRUE;
END defect_outstanding;
--
-----------------------------------------------------------------------------
--
FUNCTION defect_outstanding RETURN boolean IS
BEGIN
  RETURN g_defect_outstanding;
END defect_outstanding;
--
-----------------------------------------------------------------------------
--
PROCEDURE defect_processed IS
BEGIN
  nm_debug.debug('defect_processed');
  g_defect_outstanding := FALSE;
END defect_processed;
--
-----------------------------------------------------------------------------
--
PROCEDURE repair_outstanding IS
BEGIN
  g_repair_outstanding := TRUE;
END repair_outstanding;
--
-----------------------------------------------------------------------------
--
FUNCTION repair_outstanding RETURN boolean IS
BEGIN
  RETURN g_repair_outstanding;
END repair_outstanding;
--
-----------------------------------------------------------------------------
--
PROCEDURE repair_processed IS
BEGIN
  nm_debug.debug('repair_processed');
  g_repair_outstanding := FALSE;
END repair_processed;
--
-----------------------------------------------------------------------------
--
PROCEDURE inspection_outstanding IS
BEGIN
  g_inspection_outstanding := TRUE;
END inspection_outstanding;
--
-----------------------------------------------------------------------------
--
FUNCTION inspection_outstanding RETURN boolean IS
BEGIN
  RETURN g_inspection_outstanding;
END inspection_outstanding;
--
-----------------------------------------------------------------------------
--
PROCEDURE inspection_processed IS
BEGIN
  nm_debug.debug('inspection_processed');
  g_inspection_outstanding := FALSE;
END inspection_processed;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_inspection_record IS
BEGIN
	nm_debug.debug('create_inspection_record:'
  	||' inspection_outstanding='||to_char(inspection_outstanding)
    , g_dbglevel);
    
  IF inspection_outstanding THEN
    mai_tab_are.debug(pi_rec_are => g_are_report);
    debug_arl(g_arl);
    g_are_report.are_report_id := mai.activities_report_id(p_rse_he_id          => g_are_report.are_rse_he_id
                                                          ,p_maint_insp_flag    => g_are_report.are_maint_insp_flag
                                                          ,p_date_work_done     => g_are_report.are_date_work_done
                                                          ,p_initiation_type    => g_are_report.are_initiation_type
                                                          ,p_person_id_actioned => g_are_report.are_peo_person_id_actioned
                                                          ,p_person_id_insp2    => NULL
                                                          ,p_surface            => g_are_report.are_surface_condition
                                                          ,p_weather            => g_are_report.are_weather_condition
                                                          ,p_acty_area_code     => g_arl.arl_atv_acty_area_code
                                                          ,p_start_chain        => NULL
                                                          ,p_end_chain          => NULL);
    -- this is not performed by the procedure so
    UPDATE activities_report are
    SET    are.are_insp_load_date = SYSDATE
          ,are.are_batch_id       = g_are_report.are_batch_id
    WHERE  are.are_report_id      = g_are_report.are_report_id;

    g_arl.arl_are_report_id := g_are_report.are_report_id;

    inspection_processed;
  END IF;
END create_inspection_record;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_are_with_no_arl IS
BEGIN
	nm_debug.debug('create_are_with_no_arl:', g_dbglevel);
  g_arl.arl_atv_acty_area_code := c_dummy_arl;

  create_inspection_record;
END create_are_with_no_arl;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_defect IS
	v_defect_id DEFECTS.DEF_DEFECT_ID%type;
BEGIN
	nm_debug.debug('create_defect:'||' defect_id='||g_defect.def_defect_id
    , g_dbglevel);
  mai_tab_def.debug(pi_rec_def =>g_defect);


  -- PT 06.07.2005 
  -- added code to store the newly created defect_id for given negative id's
	v_defect_id := g_defect.def_defect_id;
  g_defect.def_defect_id := mai.create_defect(p_defect_rec => g_defect);
	nm_debug.debug('create_defect 2:'
  	||' created_defect_id='||g_defect.def_defect_id, g_dbglevel);
  if v_defect_id < 0 then
  	g_defect_id_tbl(v_defect_id) := g_defect.def_defect_id;
		nm_debug.debug('create_defect 3:'
	  	||' id_tbl('||v_defect_id||')='||g_defect.def_defect_id
      , g_dbglevel);
  end if;

  -- add the area code to activity report lines if this is a new area code
  mai_gmis_util.add_arl(pi_arl => g_arl);
END create_defect;
--
-----------------------------------------------------------------------------
--
-- PT deletes a defect and all its child records
procedure delete_defect(p_defect_id in DEFECTS.DEF_DEFECT_ID%type) is
	v_rep_count pls_integer;
  v_boq_count pls_integer;
begin
	nm_debug.debug('delete_defect:'||' defect_id='||p_defect_id
    , g_dbglevel);
  -- lock before deleting children, raises error if not found.
  mai_tab_def.lock_gen(p_defect_id);
  delete from repairs where rep_def_defect_id = p_defect_id;
  v_rep_count := sql%rowcount;
  delete from boq_items where boq_defect_id = p_defect_id;
  v_boq_count := sql%rowcount;
  mai_tab_def.del(p_defect_id);
	nm_debug.debug('delete_defect 2: deleted: repairs='||v_rep_count
  	||' boqs='||v_boq_count, g_dbglevel);
end;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_repair IS
l_dummy pls_integer;
BEGIN
	nm_debug.debug('create_repair:'
    ||' repair_outstanding='||to_char(repair_outstanding)
    , g_dbglevel);
  g_repair.rep_def_defect_id := g_defect.def_defect_id;

  IF repair_outstanding THEN
    debug_rep(g_repair);
    l_dummy := mai.create_repair(p_defect_id      => g_repair.rep_def_defect_id
                                ,p_action_cat     => g_repair.rep_action_cat
                                ,p_rse_he_id      => g_repair.rep_rse_he_id
                                ,p_treat_code     => g_repair.rep_tre_treat_code
                                ,p_acty_area_code => g_repair.rep_atv_acty_area_code
                                ,p_date_due       => g_repair.rep_date_due
                                ,p_descr          => g_repair.rep_descr
                                ,p_local_date_due => NULL
                                ,p_old_due_date   => NULL);
    repair_processed;
  END IF;

END create_repair;
--
-----------------------------------------------------------------------------
--

PROCEDURE create_boq IS
-- we will not use mai.create_boq_items as this relies on treatment models being in place
-- and Nofolk do not use them
BEGIN
	nm_debug.debug('create_boq:', g_dbglevel);
 mai_tab_boq.debug(g_boq);

  mai_gmis_util.get_boq_rates(p_rec_boq => g_boq);
  mai_tab_boq.ins(p_rec_boq => g_boq);
END create_boq;
--
-----------------------------------------------------------------------------
--
-- PT cheks if a section has a record in activities_report table
function is_section_in_report(
	 p_section in varchar2
  ,p_date	in varchar2
  ,p_time in varchar2
  ,p_user_initials varchar2) return boolean
is
	v_section_id 	ACTIVITIES_REPORT.ARE_RSE_HE_ID%type;
  v_date 				ACTIVITIES_REPORT.ARE_DATE_WORK_DONE%type;
  v_user_id 		HIG_USERS.HUS_USER_ID%type;
  v_ret 				boolean;
  cursor cur(
  		 p_rse_he_id 	ACTIVITIES_REPORT.ARE_RSE_HE_ID%type
  		,p_date 			ACTIVITIES_REPORT.ARE_DATE_WORK_DONE%type
      ,p_person_id 	HIG_USERS.HUS_USER_ID%type)
  is
		select 0
		from activities_report a
		where a.ARE_RSE_HE_ID = p_rse_he_id
		   	and a.ARE_DATE_WORK_DONE = p_date
		     and a.ARE_PEO_PERSON_ID_ACTIONED = p_person_id;
	rec cur%rowtype;
begin
	nm_debug.proc_start(g_package_name, 'is_section_in_report');
  nm_debug.debug('p_section='||p_section||', p_date='||p_date||', p_time='||p_time
  	||', p_initials='||p_user_initials);
  -- variables extracted for easier debug
	v_section_id := nm3net.get_ne_id(p_section, c_ne_type);
	v_date := to_date(p_date||' '||p_time, 'RRMMDD HH24MI');
  v_user_id := mai_gmis_validate.get_user_id(p_user_initials);
  open cur(v_section_id, v_date, v_user_id);
  fetch cur into rec;
 	if cur%found then
  	v_ret := true;
  else
  	v_ret := false;
  end if;
  close cur;
  nm_debug.proc_end(g_package_name, 'is_section_in_report');
  return v_ret;
exception
	when others then
  	nm_debug.debug(sqlerrm||': v_section_id='||v_section_id||', v_date='||v_date
    	||', v_user_id='||v_user_id);
    raise;
end;
--
-----------------------------------------------------------------------------
--
-- Processes defect in status g_defect_status = 'N'
procedure process_new_defect is
begin
	nm_debug.debug('process_new_defect:', g_dbglevel);
  g_defect.def_status_code := mai_gmis_util.get_hsc_code('DEFECTS', 1);
  create_defect;
  defect_processed;
end;
--
-----------------------------------------------------------------------------
--
PROCEDURE process_defect(parsed_all_defect_details IN boolean) IS
BEGIN
	nm_debug.debug('process_defect:'
  	||' parsed_all_details='||to_char(parsed_all_defect_details)
    ||' defect_outstanding='||to_char(defect_outstanding)
    ||' g_defect_status='||g_defect_status
    , g_dbglevel);
    
  IF defect_outstanding THEN
    
    CASE g_defect_status
      WHEN 'N' THEN
        --nm_debug.debug('New Defect');
        IF parsed_all_defect_details THEN
        	process_new_defect;
          /*
          g_defect.def_status_code := mai_gmis_util.get_hsc_code('DEFECTS', 1);
          create_defect;
          defect_processed;
          */
        END IF;
        
      WHEN 'U' THEN
        nm_debug.debug('Unchanged');
        -- unchanged defect
        -- if the defect is recorded as new (negative defect_id) and unchanged then ignore
        IF g_defect.def_defect_id > 0 THEN
          mai_gmis_util.touch_defect(p_defect_id => g_defect.def_defect_id
                                    ,p_date      => g_defect.def_last_updated_date);
        END IF;
        defect_processed;
        
      WHEN 'C' THEN
        nm_debug.debug('Changed');
        
        -- only do work if all parsed
        if parsed_all_defect_details then
	        
	        -- PT 06.07.2005
	        -- 3.3.2 if defect_id is negative then
	        -- delete the previously created defect and process the current one as new
	        if g_defect.def_defect_id < 0 then
	        	nm_debug.debug('  Changed: negative id('||g_defect.def_defect_id||')', g_dbglevel);
	        	declare
	          	v_prev_defect_id DEFECTS.DEF_DEFECT_ID%type;
	          begin
            	-- create_defect() stores the id's created from negative input id's 
              -- in g_defect_id_tbl
	          	v_prev_defect_id := g_defect_id_tbl(g_defect.def_defect_id);
	            delete_defect(v_prev_defect_id);
	          exception
	          	when no_data_found then
	            	nm_debug.debug('  Changed: not found id('||g_defect.def_defect_id||')', g_dbglevel);
	            	null; -- no defect has already been created on this negative id
	        	end;
	         	process_new_defect;
	          
	        -- 3.3.3 If defect is in a completed order then treat as new
	        elsif mai_gmis_util.is_defect_in_completed_order(g_defect.def_defect_id) then
            nm_debug.debug('process_defect 3.3.3.1: '
            	||'In copleted order defect_id='||g_defect.def_defect_id, g_dbglevel);
	          process_new_defect;
	          
	        -- Logic that was in place before Norfolk changes begins here
	        elsif mai_gmis_util.defect_supersedable(g_defect.def_defect_id) THEN
	           -- record the superseding defect id
	           g_defect.def_superseded_id := g_defect.def_defect_id;
	           g_defect.def_status_code := mai_gmis_util.get_hsc_code('DEFECTS', 1);
	
	           create_defect;
	           mai_gmis_util.supersede_defect(p_sup_defect => g_defect.def_superseded_id
	                                         ,p_new_defect => g_defect.def_defect_id);
	           defect_processed;
	        END IF;
          
				end if; -- parsed all details     

      WHEN 'R' THEN
        nm_debug.debug('Rectified');
        
        -- PT Start norfolk mofidication 3.3.1
        -- New defects cannot be rectified
        if g_defect.def_defect_id < 0 then
        	nm_debug.debug('Rectified rejected id='||g_defect.def_defect_id);
        	hig.raise_ner(pi_appl => nm3type.c_mai
                     ,pi_id   => 908
                     ,pi_supplementary_info => g_defect_status);
        	
        end if;
        -- PT End norfolk modification 3.3.1
        
	        -- 3.3.3 If defect is in an active order then ignore
	      if mai_gmis_util.is_defect_in_active_order(g_defect.def_defect_id) then
						null;
            nm_debug.debug('process_defect 3.3.3.2: '
            	||'In open order defect_id='||g_defect.def_defect_id, g_dbglevel);
					
        
        
        -- Logic before norfolk modifications begins here
        elsIF mai_gmis_util.defect_completable(g_defect.def_defect_id) THEN
           mai_gmis_util.complete_defect(p_defect_id => g_defect.def_defect_id
                                        ,p_date      => g_defect.def_last_updated_date);
        END IF;
        defect_processed;
        
      ELSE
        -- not matched
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 30
                     ,pi_supplementary_info => g_defect_status);
    END CASE;

  END IF;
  nm_debug.proc_end(g_package_name, 'process_defect('
  	||to_char(parsed_all_defect_details)||')');
    
END process_defect;
--
-----------------------------------------------------------------------------
--
PROCEDURE check_format (p_line   IN nm3type.max_varchar2
                       ,p_record IN pls_integer) IS
l_num_fields pls_integer;
--
FUNCTION character_occurrences(p_line IN nm3type.max_varchar2
                              ,p_char IN varchar2) RETURN pls_integer IS
BEGIN
  RETURN LENGTH(p_line) - LENGTH(REPLACE(p_line, p_char, NULL));
END character_occurrences;
--
BEGIN
  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'check_format');

  l_num_fields := character_occurrences(p_line, CHR(44));

  CASE p_record
    WHEN 1 THEN
      IF l_num_fields != 10 THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
      END IF;
    WHEN 2 THEN
      IF l_num_fields != 7 THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
      END IF;
    WHEN 3 THEN
      IF l_num_fields != 3 THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
      END IF;
    WHEN 4 THEN
      IF l_num_fields != 1 THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
      END IF;
    WHEN 5 THEN
      IF l_num_fields != 3 THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
      END IF;
    WHEN 6 THEN
      IF l_num_fields != 2 THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
      END IF;
    WHEN 7 THEN
      IF l_num_fields != 2 THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
      END IF;
    WHEN NULL THEN
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
    ELSE
        hig.raise_ner(pi_appl => nm3type.c_hig
                     ,pi_id   => 70
                     ,pi_supplementary_info => 'Incorrect file format');
  END CASE;

  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'check_format');
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE parse_line1 (p_line IN varchar2) IS
BEGIN
	nm_debug.debug('parse_line1: line="'||p_line, g_dbglevel);
	
  g_are_report.are_rse_he_id                := nm3net.get_ne_id(get_a_field(p_line, 2), c_ne_type);
  g_are_report.are_initiation_type          := mai_gmis_validate.hco_is_valid('INITIATION_TYPE', rtrim(get_a_field(p_line, 3)));
  g_are_report.are_peo_person_id_actioned   := mai_gmis_validate.get_user_id(UPPER(get_a_field(p_line, 4)));
  g_are_report.are_date_work_done           := TO_DATE(get_a_field(p_line, 5)||get_a_field(p_line, 6), 'YYMMDDHH24MI');
  g_are_report.are_surface_condition        := mai_gmis_validate.hco_is_valid('SURFACE_CONDITION', get_a_field(p_line, 10));

  g_are_report.are_maint_insp_flag          := c_are_maint_insp_flag;

END parse_line1;
--
-----------------------------------------------------------------------------
--
PROCEDURE parse_line2 (p_line IN varchar2) IS
	l_sys_flag road_segs.rse_sys_flag%TYPE := NVL(mai_gmis_validate.get_ity_sys_flag(g_are_report.are_rse_he_id), 'L');
BEGIN
  nm_debug.debug('parse_line2: line="'||p_line, g_dbglevel);
  
  g_defect.def_defect_id       := get_a_field(p_line, 2);
  g_arl.arl_atv_acty_area_code := mai_gmis_validate.activity_is_valid(get_a_field(p_line, 3), l_sys_flag);
  g_defect.def_defect_code     := mai_gmis_validate.def_code_is_valid(p_defect_code => get_a_field(p_line, 4)
                                                                     ,p_area_code   => g_arl.arl_atv_acty_area_code
                                                                     ,p_sys_flag    => l_sys_flag);
  g_defect.def_priority     := mai_gmis_validate.hco_is_valid('DEFECT_PRIORITIES', get_a_field(p_line, 5));
  g_defect.def_created_date := TO_DATE(get_a_field(p_line, 6), 'YYMMDD');
  g_defect.def_time_hrs     := TO_NUMBER(substr(get_a_field(p_line, 7), 1, 2));
  g_defect.def_time_mins    := TO_NUMBER(substr(get_a_field(p_line, 7), 3));
  g_defect_status           := get_a_field(p_line, 8);

  -- now validate the priority against area and repair type
  g_defect.def_priority := mai_gmis_validate.dpr_is_valid_for_area(pi_dpr_admin_unit         => mai_priority.get_lowest_dpr_admin_unit(pi_ne_id => g_are_report.are_rse_he_id)
                                                                  ,pi_dpr_atv_acty_area_code => g_arl.arl_atv_acty_area_code
                                                                  ,pi_dpr_priority           => g_defect.def_priority
                                                                  ,pi_dpr_action_cat         => c_rep_action_cat);
  -- other fields
  g_defect.def_siss_id            := c_def_siss_id;
  g_defect.def_rse_he_id          := g_are_report.are_rse_he_id;
  g_defect.def_atv_acty_area_code := g_arl.arl_atv_acty_area_code;
  g_defect.def_ity_sys_flag       := l_sys_flag;
  g_defect.def_orig_priority      := g_defect.def_priority;
  g_defect.def_last_updated_date  := mai_gmis_util.add_time(p_date    => g_defect.def_created_date
                                                           ,p_hours   => g_defect.def_time_hrs
                                                           ,p_minutes => g_defect.def_time_mins);
END parse_line2;
--
-----------------------------------------------------------------------------
--
PROCEDURE parse_line3 (p_line IN varchar2) IS
BEGIN
  g_defect.def_locn_descr                   := get_a_field(p_line, 2);
  g_defect.def_st_chain                     := mai_gmis_validate.check_chainage(p_ne_id => g_are_report.are_rse_he_id
                                                                               ,p_chain => TO_NUMBER(get_a_field(p_line, 3)));

  g_defect.def_x_sect                       := mai_gmis_validate.check_xsp(pi_ne_id  => g_defect.def_rse_he_id
                                                                          ,pi_x_sect => get_a_field(p_line, 4));

END parse_line3;
--
-----------------------------------------------------------------------------
--
PROCEDURE parse_line4 (p_line IN varchar2) IS
BEGIN
  g_defect.def_defect_descr                  := get_a_field(p_line, 2);

END parse_line4;
--
-----------------------------------------------------------------------------
--
PROCEDURE parse_line5 (p_line IN varchar2) IS
l_error number;
l_today date := sysdate;

BEGIN
  g_repair.rep_tre_treat_code               := mai_gmis_validate.treatment_is_valid(get_a_field(p_line, 2));
  g_repair.rep_descr                        := nm3flx.left(get_a_field(p_line, 3),240);
  g_defect.def_update_inv                   := mai_gmis_validate.hco_is_valid('ASSET_MODIFICATION', get_a_field(p_line, 4));

  -- other repair items
  g_repair.rep_def_defect_id                := g_defect.def_defect_id;
  g_repair.rep_action_cat                   := c_rep_action_cat;
  g_repair.rep_rse_he_id                    := g_defect.def_rse_he_id;
  g_repair.rep_atv_acty_area_code           := g_defect.def_atv_acty_area_code;
  g_repair.rep_created_date                 := g_defect.def_created_date;
  g_repair.rep_last_updated_date            := l_today;

  -- calculate the repair due date from the defect priority

  mai.rep_date_due(p_date               => g_defect.def_created_date
                  ,p_atv_acty_area_code => g_repair.rep_atv_acty_area_code
                  ,p_dpr_priority       => g_defect.def_priority
                  ,p_dpr_action_cat     => g_repair.rep_action_cat
                  ,p_heid               => g_repair.rep_rse_he_id
                  ,p_out_date           => g_repair.rep_date_due
                  ,p_error              => l_error);
END parse_line5;
--
-----------------------------------------------------------------------------
--
PROCEDURE parse_line6 (p_line IN varchar2) IS
l_dty_num pls_integer;
l_def_col def_types.dty_hh_attribute_1%TYPE;
l_sql     nm3type.max_varchar2;
l_val     nm3type.max_varchar2;

e_conversion_error EXCEPTION;
PRAGMA EXCEPTION_INIT(e_conversion_error, -6502);

BEGIN
  l_dty_num := TO_NUMBER(get_a_field(p_line,2));
  l_def_col := mai_gmis_validate.get_def_attr_col(p_defect_code    => g_defect.def_defect_code
                                                 ,p_acty_area_code => g_defect.def_atv_acty_area_code
                                                 ,p_sys_flag       => g_defect.def_ity_sys_flag
                                                 ,p_attr_num       => l_dty_num);
  l_val := get_a_field(p_line, 3);

  IF l_def_col IS NOT NULL
     AND l_val IS NOT NULL THEN

      l_sql := 'BEGIN'||CHR(10);
      l_sql := l_sql || g_package_name||'.g_defect.'||l_def_col||' := '|| nm3flx.string(l_val)||';'||CHR(10);
      l_sql := l_sql || 'END;';

      BEGIN

        EXECUTE IMMEDIATE l_sql;
      EXCEPTION
      WHEN e_conversion_error THEN
         hig.raise_ner(pi_appl               => nm3type.c_hig
                      ,pi_id                 => 111
                      ,pi_supplementary_info => l_def_col || ' cannot store '|| l_val);
      END;
  END IF;
END parse_line6;
--
-----------------------------------------------------------------------------
--
PROCEDURE parse_line7 (p_line IN varchar2) IS
BEGIN
  nm_debug.debug('parse_line7: line="'||p_line, g_dbglevel);
  
  g_boq.boq_sta_item_code := mai_gmis_validate.std_item_is_valid(get_a_field(p_line, 2));
  g_boq.boq_item_name     := mai_tab_std.get(pi_sta_item_code => g_boq.boq_sta_item_code).sta_item_name;
  g_boq.boq_est_quantity  := mai_gmis_validate.std_quantity_within_limits(p_std_item => g_boq.boq_sta_item_code
                                                                         ,p_qty => get_a_field(p_line, 3));

  -- fields from other records

  g_boq.boq_id             := mai_tab_boq.next_boq_id_seq;
  g_boq.boq_work_flag      := c_boq_work_flag;
  g_boq.boq_defect_id      := g_defect.def_defect_id;
  g_boq.boq_rep_action_cat := g_repair.rep_action_cat;
  g_boq.boq_wol_id         := c_boq_no_wol_id;
  g_boq.boq_date_created   := g_defect.def_created_date;
  g_boq.boq_est_dim1       := c_boq_est_dim1;

  mai_gmis_util.get_boq_rates(p_rec_boq => g_boq);
END parse_line7;
--
-----------------------------------------------------------------------------
--
FUNCTION parse_file(pi_file        IN     clob
                   ,pio_error_text IN OUT varchar2
                   ,pio_error_line IN OUT pls_integer
                   ,pio_error_data IN OUT varchar2) RETURN boolean IS

  l_line_number  pls_integer := 0;
  l_file nm3type.tab_varchar32767 := nm3clob.clob_to_tab_varchar(pi_file);
  l_current_line nm3type.max_varchar2;
  l_record_type  pls_integer;
  --
  FUNCTION file_read RETURN boolean IS
  BEGIN
    IF NVL(l_line_number,0) >= l_file.COUNT THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
  --
  FUNCTION get_next_line RETURN varchar2 IS
  BEGIN
    l_line_number := l_line_number +1;
    IF l_line_number > l_file.COUNT THEN
      RETURN NULL;
    ELSE
      -- trim braces from the line
      nm_debug.debug(substr(l_file(l_line_number), instr(l_file(l_line_number), CHR(34)) + 1, instr(l_file(l_line_number), CHR(34), -1, 1) -2 ));
      RETURN substr(l_file(l_line_number), instr(l_file(l_line_number), CHR(34)) + 1, instr(l_file(l_line_number), CHR(34), -1, 1) -2 );
    END IF;
  
  END get_next_line;
  --
  FUNCTION record_number (p_line IN varchar2) RETURN pls_integer IS
  BEGIN
    RETURN to_number(get_a_field(p_line, 1));
  EXCEPTION
    WHEN OTHERS THEN
      hig.raise_ner(pi_appl => nm3type.c_hig
                   ,pi_id   => 70
                   ,pi_supplementary_info => 'Incorrect file format');
  
  END record_number;
  --
  PROCEDURE create_outstanding_defect IS
  BEGIN
  	nm_debug.debug('create_outstanding_defect:'
    	||' defect_outstanding='||to_char(defect_outstanding)
      ||' repair_outstanding='||to_char(repair_outstanding)
      , g_dbglevel);
    IF defect_outstanding THEN
      process_defect(TRUE);
    END IF;
    IF repair_outstanding THEN
      create_repair;
    END IF;
  END;
  --
  PROCEDURE create_outstanding_recs IS
  BEGIN
  	nm_debug.debug('create_outstanding_recs:'
    	||' inspection_outstanding='||to_char(inspection_outstanding)
      , g_dbglevel);
    -- if inspection  outstanding then a 2 record must not have been processed
    IF inspection_outstanding THEN
      create_are_with_no_arl;
    END IF;
    create_outstanding_defect;
  END create_outstanding_recs;
  --
  
BEGIN
  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'parse_file');
  nm_debug.debug('parse_file:', g_dbglevel);
  
  clear_all_details;
  l_current_line := get_next_line;
  
  
  /* PT 30.01.2006 this is moved into loop
  -- PT 06.07.2005
  -- 3.3.4 Check if file has already been processed
  -- if yes then exit with error
  
 	l_record_type := record_number(l_current_line);
   
   -- first line in file must be of type 1
	if l_record_type = 1 then
		check_format(l_current_line, l_record_type);
    
    -- check if first section reported by this user at this time is already in
    -- active_reports. If yes then file is already processed, raise error.
    begin
      if is_section_in_report(
      	 get_a_field(l_current_line, 2) -- section
        ,get_a_field(l_current_line, 5)	-- date
        ,get_a_field(l_current_line, 6)	-- time
        ,get_a_field(l_current_line, 4)) -- user initials
      then
    		nm_debug.debug('Raise Error: Section is in open report', g_dbglevel);
        hig.raise_ner(pi_appl => nm3type.c_mai
                 ,pi_id   => 909
                 ,pi_supplementary_info => l_current_line);
      end if;
    end;
   
   -- raise invalid file format error 
   else
    hig.raise_ner(pi_appl => nm3type.c_hig
                 ,pi_id   => 30
                 ,pi_supplementary_info => l_current_line);
   end if;
  -- End PT 06.07.2005
  End PT 30.01.2006 */
  
  -- Normal processing begins here
  WHILE NOT file_read LOOP

    l_record_type := record_number(l_current_line);
    
    check_format(l_current_line, l_record_type);

    nm_debug.debug('parse_file: case: record_type='||l_record_type, g_dbglevel);
    
    CASE l_record_type
      
      WHEN 1 THEN
        -- PT 30.01.06 the dupliate section check moved into loop
        -- check if section reported by this user at this time is already in
        -- active_reports. If yes then raise error.
        begin
          if is_section_in_report(
          	 get_a_field(l_current_line, 2) -- section
            ,get_a_field(l_current_line, 5)	-- date
            ,get_a_field(l_current_line, 6)	-- time
            ,get_a_field(l_current_line, 4)) -- user initials
          then
        		nm_debug.debug('Raise Error: Section is in open report', g_dbglevel);
            hig.raise_ner(pi_appl => nm3type.c_mai
                     ,pi_id   => 909
                     ,pi_supplementary_info => l_current_line);
          end if;
        end;
        -- end PT 30.01.06

         create_outstanding_recs;
         clear_all_details;
         parse_line1(l_current_line);
         inspection_outstanding;

      WHEN 2 THEN
         create_outstanding_defect;
         clear_defect;
         clear_repair;
         parse_line2(l_current_line);
         defect_outstanding; -- we now have a defect to enter
         create_inspection_record;
         g_defect.def_are_report_id := g_are_report.are_report_id;
         process_defect(FALSE);
      WHEN 3 THEN
         parse_line3(l_current_line);
      WHEN 4 THEN
         parse_line4(l_current_line);
      WHEN 5 THEN
         parse_line5(l_current_line);
         repair_outstanding;
      WHEN 6 THEN
         parse_line6(l_current_line);
      WHEN 7 THEN
         create_outstanding_recs;
         clear_boq;
         parse_line7(l_current_line);
         create_boq;
      WHEN NULL THEN
         hig.raise_ner(pi_appl => nm3type.c_hig
                      ,pi_id   => 30
                      ,pi_supplementary_info => l_current_line);
      ELSE -- bad format
         hig.raise_ner(pi_appl => nm3type.c_hig
                      ,pi_id   => 30
                      ,pi_supplementary_info => l_current_line);
    END CASE;
    l_current_line := get_next_line;

  END LOOP;


  create_outstanding_recs;
  
	nm_debug.debug('parse_file: end', g_dbglevel);

  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'parse_file');
                   
	--raise_application_error(-20999, 'Test error: Finished Processing File');

  RETURN TRUE;

EXCEPTION
  WHEN others THEN
    pio_error_text := SQLERRM;
    pio_error_line := l_line_number;
    pio_error_data := l_current_line;
    ROLLBACK TO before_file_processing;
    RETURN FALSE;
END parse_file;
--
-----------------------------------------------------------------------------
--
PROCEDURE gmis_loader(p_loadfile IN varchar2) IS
l_nuf       nm_upload_files%ROWTYPE;
l_glb       mai_gmis_load_batches%ROWTYPE;
l_success   nm_errors%ROWTYPE := hig.get_ner(nm3type.c_hig, 2);
l_parsed    boolean;

BEGIN
	--nm_debug.debug_on;
  --nm_debug.set_level(2);
  
	
  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'gmis_loader');

  -- get the file from nm_upload_files
  l_nuf := nm3get.get_nuf(pi_name => p_loadfile);
  -- do some checks on the file

  -- insert the file in gmis_load_batches

  l_glb.glb_load_batch  := mai_tab_are.next_are_batch_id_seq;
  g_batch_id            := l_glb.glb_load_batch;
  l_glb.glb_load_file   := nm3clob.blob_to_clob(pi_blob => l_nuf.blob_content);
  l_glb.glb_error_text  := l_success.ner_descr;

  SAVEPOINT before_file_processing;

  clear_all_details;
  
  -- clear the negative id's table, that is used in tracking new defects
  g_defect_id_tbl.delete;

  -- perform the main checking
  l_parsed := parse_file(pi_file        => l_glb.glb_load_file
                        ,pio_error_text => l_glb.glb_error_text
                        ,pio_error_line => l_glb.glb_line_number
                        ,pio_error_data => l_glb.glb_error_data);
  --perform inserts

  l_glb.glb_load_errors := nm3flx.i_t_e(l_parsed, 'N', 'Y');

  nm3file.dos2unix(pi_file => l_glb.glb_load_file);

  mai_tab_glb.ins(p_rec_glb => l_glb);
  -- file has passed checking delete the file from nm_upload_files

  nm3del.del_nuf(pi_name            => p_loadfile
                ,pi_raise_not_found => FALSE);
                

  COMMIT;
  -- reload the web from with message to display
  show_status(p_load_file => FALSE
             ,p_batch     => l_glb.glb_load_batch
             ,p_msg       => l_glb.glb_error_text);

  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'gmis_loader');
END gmis_loader;
--
-----------------------------------------------------------------------------
--
FUNCTION gmis_reload(pi_batch           IN  mai_gmis_load_batches.glb_load_batch%TYPE
                    ,po_glb_error_data  OUT mai_gmis_load_batches.glb_error_data%TYPE
                    ,po_glb_error_text  OUT mai_gmis_load_batches.glb_error_text%TYPE
                    ,po_glb_line_number OUT mai_gmis_load_batches.glb_line_number%TYPE) RETURN boolean IS

l_glb       mai_gmis_load_batches%ROWTYPE := mai_tab_glb.get(pi_glb_load_batch => pi_batch);
l_success   nm_errors%ROWTYPE := hig.get_ner(nm3type.c_hig, 2);
l_parsed    boolean := TRUE;

BEGIN
  --nm_debug.debug_on;
  --nm_debug.set_level(2);
  
  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'gmis_reload');

  -- do some checks on the file

  g_batch_id            := l_glb.glb_load_batch;
  l_glb.glb_line_number := NULL;
  l_glb.glb_error_data  := NULL;
  l_glb.glb_error_text  := l_success.ner_descr;

  SAVEPOINT before_file_processing;

  clear_all_details;
  
  -- clear the negative id's table, that is used in tracking new defects
  g_defect_id_tbl.delete;

  -- perform the main checking
  l_parsed := parse_file(pi_file        => l_glb.glb_load_file
                        ,pio_error_text => l_glb.glb_error_text
                        ,pio_error_line => l_glb.glb_line_number
                        ,pio_error_data => l_glb.glb_error_data);

  -- update return variables

  po_glb_line_number := l_glb.glb_line_number;
  po_glb_error_data  := l_glb.glb_error_data;
  po_glb_error_text  := l_glb.glb_error_text;


  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'gmis_reload');
                   
  RETURN l_parsed;

END gmis_reload;
--
-----------------------------------------------------------------------------
--
FUNCTION file_is_loaded (p_file IN varchar2) RETURN boolean IS

CURSOR get_file (p_file IN nm_upload_files.name%TYPE) IS
SELECT 1
FROM   nm_upload_files
WHERE  name = p_file;

dummy    pls_integer;
l_retval boolean;
BEGIN
  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'file_is_loaded');

  OPEN get_file(p_file);
  FETCH get_file INTO dummy;
  l_retval := get_file%FOUND;
  CLOSE get_file;

  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'file_is_loaded');

  RETURN l_retval;
END file_is_loaded;
--
-----------------------------------------------------------------------------
--
PROCEDURE load_survey_file IS
l_err nm_errors.ner_descr%TYPE;
BEGIN

  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'load_survey_file');

  nm3web.head(p_close_head => FALSE
             ,p_title      => c_module_title);

  sccs_tags;

  htp.headclose;

  htp.bodyopen;

  nm3web.module_startup(pi_module => c_this_module);


  htp.header(2, hig.get_module_title(a_module => c_this_module));

  htp.br;

  htp.tableopen(cborder => 'border=0');

  htp.formopen(curl     => g_package_name||'.process_survey_file'
              ,cenctype => 'multipart/form-data');

  htp.p('</td>');
  htp.tablerowclose;

  htp.tablerowopen;
  htp.tabledata('Filename:');
  htp.tabledata(htf.formfile(cname => 'p_in'));
  htp.tablerowclose;

  htp.tabledata(htf.formsubmit(cvalue => 'Upload'));

  htp.formclose;

  htp.tableclose;

  nm3web.CLOSE;

  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'load_survey_file');
END load_survey_file;
--
-----------------------------------------------------------------------------
--
PROCEDURE process_survey_file(p_in  IN varchar2 DEFAULT NULL) IS

l_msg                      varchar2(500);
l_file_loaded              boolean       := FALSE;
l_uploaded_filename        varchar2(200) := nm3upload.strip_dad_reference(p_in);
BEGIN
  nm_debug.proc_start(p_package_name   => g_package_name
                     ,p_procedure_name => 'process_survey_file');

  IF p_in IS NULL THEN

    l_msg := hig.raise_and_catch_ner(pi_appl               => nm3type.c_hig
                                    ,pi_id                 => 179
                                    ,pi_supplementary_info => 'Not a valid GMIS survey file');
    l_file_loaded := FALSE;

    nm3del.del_nuf(pi_name            => p_in
                  ,pi_raise_not_found => FALSE);
  ELSE

    l_file_loaded := TRUE;
    UPDATE NM_UPLOAD_FILES
    SET    name = l_uploaded_filename
    WHERE  name = p_in;

  END IF;

  show_status(p_load_file => l_file_loaded
             ,p_msg       => l_msg
             ,p_loadfile  => l_uploaded_filename);

  nm_debug.proc_end(p_package_name   => g_package_name
                   ,p_procedure_name => 'process_survey_file');

END process_survey_file;

--
-----------------------------------------------------------------------------
--
PROCEDURE create_survey_file(p_job_id   IN  NUMBER,
                             p_stmt     IN  VARCHAR2,
                             p_sector   IN  VARCHAR2,
                             p_feedback OUT NUMBER) IS

   l_file       CLOB;
   l_nuf        nm_upload_files%ROWTYPE;
   feedback     pls_integer;
   l_sql_in     VARCHAR2(2500);
   cur2         pls_integer := DBMS_SQL.OPEN_CURSOR;
   cur1         pls_integer := DBMS_SQL.OPEN_CURSOR;

   
   c_route_file     varchar2(50) := 'ROUTE';
   c_exist_file     varchar2(50) := 'EXIST';
   c_file_extension varchar2(4)  := '.DAT' ;
  
   l_user_initials hig_users.hus_initials%type;
--
   PROCEDURE create_file(p_file IN varchar2) IS
   BEGIN
      l_nuf.name           := p_file;
      l_nuf.mime_type      := 'text/plain';
      l_nuf.doc_size       := dbms_lob.getlength(l_file);
      l_nuf.dad_charset    := 'ascii';
      l_nuf.last_updated   := SYSDATE;
      l_nuf.content_type   := 'BLOB';
      l_nuf.blob_content   := nm3clob.clob_to_blob(l_file);
      
      nm3ins.ins_nuf(l_nuf);
   END create_file;
--
BEGIN

   -- Checking nm_upload_files if they exist then do not want to
   -- overwrite what someone might be using

  l_user_initials:=nm3get.get_hus(user).hus_initials;
  c_route_file   :=c_route_file||l_user_initials||c_file_extension;
  c_exist_file   :=c_exist_file||l_user_initials||c_file_extension;
  --
  IF nm3get.get_nuf (pi_name            => c_route_file
                    ,pi_raise_not_found => FALSE
                     ).name IS NOT NULL THEN
    hig.raise_ner (pi_appl               => nm3type.c_hig
                  ,pi_id                 => 64
                  ,pi_supplementary_info => 'nm_upload_files.name = '||nm3flx.string(c_route_file)
                  );
  END IF;

   -- Populate Report_tags table

  l_sql_in := 'INSERT INTO report_tags '||
              '(rtg_job_id,rtg_tag_id) '||
              'SELECT '||p_job_id||',ne_id '||
              'FROM nm_elements_all '||
              ',nm3_network_attribs '||
              'WHERE ne_nt_type = '||''''||'HERM'||''''||
              'and ne_id = section_id '||
              'and  '||p_stmt||
              ' and ne_id in ( select nm_ne_id_of '||
                              'from   nm_members_all '||
                               'connect by prior nm_ne_id_of = nm_ne_id_in '||
                               'start with nm_ne_id_in = ( select ne_id from nm_elements_all where ne_unique = '||''''||p_sector||''''||'))';



   --

   DBMS_SQL.PARSE (cur2, l_sql_in, dbms_sql.v7);

   feedback := DBMS_SQL.EXECUTE (cur2);

   DBMS_SQL.CLOSE_CURSOR (cur2);

   --
   COMMIT;
   --
    
   IF feedback = 0 THEN

     -- nothing inserted into report tags so no need to carry on
      p_feedback := feedback;


   ELSE

      p_feedback := feedback;

   --
      hig_hd_query.set_parameter('MAI2530', 'extent', p_job_id);


      l_file := hig_hd_extract.output_csv('MAI2530');
      -- get the resulting clob and put it in nm_upload_files.

      nm3file.unix2dos(l_file);

      create_file(c_route_file);

   --

      hig_hd_query.set_parameter('MAI2530_A', 'extent', p_job_id);

      l_file := hig_hd_extract.output_csv('MAI2530_A');

      nm3file.unix2dos(l_file);

      create_file(c_exist_file);

   --

      DELETE report_tags
      WHERE rtg_job_id = p_job_id;
      COMMIT;

   --

   END IF;

END create_survey_file;
--
-----------------------------------------------------------------------------
--
PROCEDURE update_batch(pi_batch      IN     mai_gmis_load_batches.glb_load_batch%TYPE) IS
l_clob CLOB;
BEGIN
  l_clob := nm3clob.tab_varchar_to_clob(g_current_batch_file);
  
  UPDATE mai_gmis_load_batches
  SET    glb_load_file = l_clob
  WHERE  glb_load_batch = pi_batch;
  
END update_batch;
--
-----------------------------------------------------------------------------
--
PROCEDURE query_batch_details(pi_batch      IN     mai_gmis_load_batches.glb_load_batch%TYPE
                             ,po_batch_dets IN OUT tab_rec_glb_batch_details) IS

l_glb     mai_gmis_load_batches%ROWTYPE;

BEGIN
  
  l_glb := mai_tab_glb.get(pi_glb_load_batch => pi_batch);
  
  g_current_batch_file := nm3clob.clob_to_tab_varchar(l_glb.glb_load_file);
  
  FOR irec IN 1..g_current_batch_file.COUNT LOOP
    
    po_batch_dets(irec).file_text         := substr(g_current_batch_file(irec), 1, instr(g_current_batch_file(irec), CHR(10)) -1);
    po_batch_dets(irec).line_number       := irec;

  END LOOP;
  
END query_batch_details;
--
-----------------------------------------------------------------------------
--
PROCEDURE update_batch_detail(pi_batch       IN    mai_gmis_load_batches.glb_load_batch%TYPE
                             ,po_batch_dets  IN OUT tab_rec_glb_batch_details) IS
BEGIN
  -- update the package copy of the batch
  -- add the trimmed LF character at the end
  FOR irecord IN 1..po_batch_dets.COUNT LOOP
    g_current_batch_file(po_batch_dets(irecord).line_number) := po_batch_dets(irecord).file_text||CHR(10);
  END LOOP;
  
  update_batch(pi_batch);
END update_batch_detail;
--
-----------------------------------------------------------------------------
--
PROCEDURE lock_batch_detail(pi_batch       IN     mai_gmis_load_batches.glb_load_batch%TYPE
                           ,po_batch_dets  IN OUT tab_rec_glb_batch_details) IS
BEGIN
  mai_tab_glb.lock_gen(pi_glb_load_batch => pi_batch);
END lock_batch_detail;
--
-----------------------------------------------------------------------------
--
PROCEDURE delete_batch_detail(pi_batch       IN     mai_gmis_load_batches.glb_load_batch%TYPE
                             ,po_batch_dets  IN OUT tab_rec_glb_batch_details) IS
BEGIN
  
  FOR irecord IN 1..po_batch_dets.COUNT LOOP
    -- dont delete the record as this leaves a hole that the nm3clob package cannot deal with
    -- instead shift all elements above the deleted row down one
    
    FOR irec IN po_batch_dets(irecord).line_number..g_current_batch_file.COUNT-1 LOOP
    
      g_current_batch_file(irec) := g_current_batch_file(irec+1);
    END LOOP;
  
  END LOOP;
  
  update_batch(pi_batch);
  
END delete_batch_detail;
--
-----------------------------------------------------------------------------
--
PROCEDURE insert_batch_detail(pi_batch       IN     mai_gmis_load_batches.glb_load_batch%TYPE
                             ,po_batch_dets  IN OUT tab_rec_glb_batch_details) IS
BEGIN
  nm_debug.debug_on;

  -- shift all elements up by one to create a space for our new record
  FOR irecord IN 1..po_batch_dets.COUNT LOOP
    
      nm_debug.debug(po_batch_dets(irecord).line_number);
      
    FOR irec IN REVERSE po_batch_dets(irecord).line_number..g_current_batch_file.COUNT+1 LOOP
      g_current_batch_file(irec) := g_current_batch_file(irec-1);
    END LOOP;
    
    -- add the trimmed LF character at the end
    g_current_batch_file(po_batch_dets(irecord).line_number) := po_batch_dets(1).file_text||CHR(10);
    
  END LOOP;
  
 
  update_batch(pi_batch);
  
END insert_batch_detail;
--
-----------------------------------------------------------------------------
--

END mai_gmis_load;
/
