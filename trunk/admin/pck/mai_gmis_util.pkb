CREATE OR REPLACE PACKAGE BODY mai_gmis_util AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_gmis_util.pkb-arc   2.3   Sep 27 2019 14:39:52   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_gmis_util.pkb  $
--       Date into SCCS   : $Date:   Sep 27 2019 14:39:52  $
--       Date fetched Out : $Modtime:   Sep 27 2019 14:09:56  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.3
--
--
--   Author : Darren Cope
--
--   mai_gmis_util body
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--all global package variables here

  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '"$Revision:   2.3  $"';

  g_package_name CONSTANT varchar2(30) := 'mai_gmis_util';
-- defect status codes
  c_def_observed        CONSTANT  defects.def_status_code%TYPE := 'OBSERVED';
  c_arl_complete        CONSTANT  act_report_lines.arl_act_status%TYPE := 'C';
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
FUNCTION get_hsc_code(p_domain             IN hig_status_codes.hsc_domain_code%TYPE
                     ,p_allowable_features IN nm3type.tab_number) RETURN hig_status_codes.hsc_status_code%TYPE
IS
c1 nm3type.ref_cursor;
l_sql nm3type.max_varchar2:=  'SELECT hsc.hsc_status_code'||CHR(10)||
                              'FROM   hig_status_codes hsc'||CHR(10)||
                              'WHERE  hsc.hsc_domain_code = '||nm3flx.string(p_domain)||CHR(10)||
                              'AND    sysdate between nvl(hsc.hsc_start_date, sysdate) and nvl( hsc.hsc_end_date, sysdate)';
l_status_code hig_status_codes.hsc_status_code%TYPE;
BEGIN
  
  FOR i IN 1..p_allowable_features.COUNT LOOP
    l_sql := l_sql ||CHR(10)||'AND    hsc.hsc_allow_feature'||p_allowable_features(i)||' = '||nm3flx.string('Y');
  END LOOP;
  
  OPEN c1 FOR l_sql;
  FETCH c1 INTO l_status_code;
  CLOSE c1;
  
  RETURN l_status_code;
  
END get_hsc_code;
--
-----------------------------------------------------------------------------
--
FUNCTION get_hsc_code(p_domain             IN hig_status_codes.hsc_domain_code%TYPE
                     ,p_allowable_feature  IN pls_integer) RETURN hig_status_codes.hsc_status_code%TYPE
IS
l_feature nm3type.tab_number;
BEGIN
  l_feature(1) := p_allowable_feature;
  
  RETURN get_hsc_code(p_domain             => p_domain
                     ,p_allowable_features => l_feature);
END get_hsc_code;
--
-----------------------------------------------------------------------------
--
FUNCTION add_time(p_date    IN date
                 ,p_hours   IN number
                 ,p_minutes IN number
                 ,p_seconds IN number) RETURN date IS
l_retval date;
BEGIN
 
  RETURN p_date + nvl(p_hours,0) / 24 + nvl(p_minutes, 0) / 1440 + nvl(p_seconds, 0) / 86400;
END add_time;
--
-----------------------------------------------------------------------------
--
FUNCTION defect_supersedable (p_sup_defect IN defects.def_defect_id%TYPE) RETURN boolean IS
l_sup defects%ROWTYPE := mai_tab_def.get(pi_def_defect_id => p_sup_defect);
l_retval boolean;
BEGIN
   IF l_sup.def_status_code = get_hsc_code(p_domain            => 'DEFECTS'
                                          ,p_allowable_feature => 1) THEN
     l_retval := TRUE;
   ELSE
     l_retval := FALSE;
   END IF;   

   RETURN l_retval;
END defect_supersedable;
--
-----------------------------------------------------------------------------
--
PROCEDURE supersede_defect (p_sup_defect IN defects.def_defect_id%TYPE
                           ,p_new_defect IN defects.def_defect_id%TYPE) IS
l_sup defects%ROWTYPE := mai_tab_def.get(pi_def_defect_id => p_sup_defect);
l_superseded_code hig_status_codes.hsc_status_code%TYPE := get_hsc_code(p_domain            => 'DEFECTS'
                                                                       ,p_allowable_feature => 8);
l_today date := SYSDATE;
BEGIN
  
  -- supersede if defect is available
  -- otherwise ignore
  IF l_sup.def_status_code = get_hsc_code(p_domain            => 'DEFECTS'
                                         ,p_allowable_feature => 1) THEN
      
  -- supersede defect
     UPDATE defects
     SET    def_superseded_flag   = 'Y'
           ,def_status_code       = l_superseded_code
           ,def_superseded_id     = p_new_defect
           ,def_last_updated_date = l_today
     WHERE  def_defect_id         = l_sup.def_defect_id;

  -- supersede repair

     UPDATE repairs
     SET    rep_superseded_flag   = 'Y'
           ,rep_last_updated_date = l_today
     WHERE  rep_def_defect_id     = l_sup.def_defect_id;

  END IF;
END supersede_defect;
--
-----------------------------------------------------------------------------
--
FUNCTION defect_completable (p_defect_id IN defects.def_defect_id%TYPE) RETURN boolean IS

l_def    defects%ROWTYPE          := mai_tab_def.get(pi_def_defect_id => p_defect_id);
l_status hig_status_codes%ROWTYPE := nm3get.get_hsc(pi_hsc_domain_code => 'DEFECTS'
                                                   ,pi_hsc_status_code => l_def.def_status_code);
l_comp_status hig_status_codes.hsc_status_code%TYPE := get_hsc_code('DEEFCTS', 4);
l_retval boolean;
BEGIN
  -- if complete do not allow to complete
  IF l_status.hsc_allow_feature4 = 'Y' 
  OR l_status.hsc_allow_feature6 = 'Y'
  OR l_status.hsc_allow_feature8 = 'Y' THEN
    l_retval := FALSE;
  ELSE 
    l_retval := TRUE;
  END IF;

  RETURN l_retval;
END defect_completable;
--
-----------------------------------------------------------------------------
--
PROCEDURE complete_repairs (p_defect_id IN defects.def_defect_id%TYPE
                           ,p_date      IN date DEFAULT NULL) IS
l_today date := NVL(p_date, sysdate);
BEGIN
  
  UPDATE repairs
  SET    rep_date_completed    = l_today
        ,rep_completed_hrs     = TO_CHAR(l_today, 'HH24')
        ,rep_completed_mins    = TO_CHAR(l_today, 'MI')
        ,rep_last_updated_date = l_today
  WHERE  rep_def_defect_id = p_defect_id;
  
END complete_repairs;
--
-----------------------------------------------------------------------------
--
PROCEDURE complete_defect(p_defect_id IN defects.def_defect_id%TYPE
                         ,p_date      IN date DEFAULT NULL) IS

l_def    defects%ROWTYPE          := mai_tab_def.get(pi_def_defect_id => p_defect_id);
l_status hig_status_codes%ROWTYPE := nm3get.get_hsc(pi_hsc_domain_code => 'DEFECTS'
                                                   ,pi_hsc_status_code => l_def.def_status_code);
l_comp_status hig_status_codes.hsc_status_code%TYPE := get_hsc_code('DEFECTS', 4);
l_today       date := NVL(p_date, SYSDATE);

BEGIN
  -- if instructed then set to O - observed complete
  IF l_status.hsc_allow_feature3 = 'Y' THEN
     
     -- if instructed then set to O - OBSERVED AS DONE
    UPDATE defects
    SET    def_status_code       = c_def_observed
          ,def_last_updated_date = l_today
    WHERE  def_defect_id         = p_defect_id;
    
  ELSIF l_status.hsc_allow_feature1 = 'Y'
     OR l_status.hsc_allow_feature2 = 'Y' THEN
    
    -- complete defect if it is AVAILABLE
    
    complete_repairs(p_defect_id => p_defect_id);
    
    UPDATE defects
    SET    def_date_compl        = l_today
          ,def_status_code       = l_comp_status
          ,def_last_updated_date = l_today
    WHERE  def_defect_id         = p_defect_id
    AND    NOT EXISTS (SELECT 1
                       FROM   repairs
                       WHERE  rep_def_defect_id = def_defect_id
                       AND    rep_date_completed IS NULL);
    
  END IF;
  
END complete_defect;
--
-----------------------------------------------------------------------------
--
PROCEDURE get_boq_rates(p_rec_boq IN OUT NOCOPY boq_items%ROWTYPE) IS
l_std_item standard_items%ROWTYPE := mai_tab_std.get(pi_sta_item_code => p_rec_boq.boq_sta_item_code);
BEGIN
  p_rec_boq.boq_est_rate     := l_std_item.sta_rate;
  p_rec_boq.boq_est_labour   := l_std_item.sta_labour_units * nvl(p_rec_boq.boq_est_quantity,1);
  p_rec_boq.boq_est_cost     := ROUND((p_rec_boq.boq_est_quantity * nvl(p_rec_boq.boq_est_rate,1)),2);
  
END get_boq_rates;
--
-----------------------------------------------------------------------------
--
PROCEDURE touch_defect(p_defect_id IN defects.def_defect_id%TYPE
                      ,p_date      IN date DEFAULT NULL) IS
l_upd_date date := NVL(p_date, SYSDATE);
l_def      defects%ROWTYPE := mai_tab_def.get(pi_def_defect_id => p_defect_id);
BEGIN
  IF l_def.def_last_updated_date < l_upd_date THEN
    UPDATE defects
    SET def_last_updated_date = l_upd_date
    WHERE def_defect_id = p_defect_id;
  END IF;
  
END touch_defect;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_arl(pi_arl IN act_report_lines%ROWTYPE) IS
l_arl act_report_lines%ROWTYPE := mai_tab_arl.get(pi_arl_are_report_id      => pi_arl.arl_are_report_id
                                                 ,pi_arl_atv_acty_area_code => pi_arl.arl_atv_acty_area_code
                                                 ,pi_raise_not_found        => FALSE);
l_are activities_report%ROWTYPE := mai_tab_are.get(pi_are_report_id => pi_arl.arl_are_report_id
                                                  ,pi_raise_not_found => TRUE);
l_today date := sysdate;
BEGIN
  IF l_arl.arl_are_report_id IS NULL 
  AND pi_arl.arl_are_report_id IS NOT NULL THEN
    
    --add missing values
    l_arl := pi_arl;
    
    l_arl.arl_act_status        := c_arl_complete;
    l_arl.arl_created_date      := NVL(l_arl.arl_created_date, l_today);
    l_arl.arl_last_updated_date := NVL(l_arl.arl_last_updated_date, l_today);
    
    mai_tab_arl.ins(p_rec_arl => l_arl);
    
  END IF;
END add_arl;
--
-----------------------------------------------------------------------------
--
FUNCTION defects_exist_on_section (p_ne_id IN nm_elements.ne_id%TYPE) RETURN varchar2 IS
 
CURSOR get_defect (p_ne_id IN nm_elements.ne_id%TYPE) IS
/* PT 19.07.05 gmis enhancements
SELECT 'Y'
FROM   defects
WHERE  def_rse_he_id = p_ne_id
AND    def_status_code = 'AVAILABLE';
*/
select 'Y'
from 
  DEFECTS d, 
  HIG_STATUS_CODES sc
where d.DEF_STATUS_CODE = sc.HSC_STATUS_CODE
  and d.DEF_RSE_HE_ID = p_ne_id
  and sc.HSC_DOMAIN_CODE = 'DEFECTS'
  and (sc.HSC_ALLOW_FEATURE1 = 'Y'
    or sc.HSC_ALLOW_FEATURE2 = 'Y'
    or sc.HSC_ALLOW_FEATURE3 = 'Y');

l_retval VARCHAR2(1);
BEGIN
  OPEN get_defect (p_ne_id);
  FETCH get_defect INTO l_retval;
  l_retval := nm3flx.i_t_e(get_defect%FOUND, 'Y', 'N');
  CLOSE get_defect;

  RETURN l_retval;
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_def_attribute (pi_defect_id IN defects.def_defect_id%TYPE
                           ,pi_attribute IN varchar2) RETURN varchar2 IS
c1 nm3type.ref_cursor;
l_qry varchar2(200) := 'select '||pi_attribute
                    ||' from defects'
                    ||' where def_defect_id = '||pi_defect_id;
l_retval nm3type.max_varchar2;
BEGIN
  OPEN c1 FOR l_qry;
  FETCH c1 INTO l_retval;
  CLOSE c1;
  
  RETURN l_retval;
  
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_Parish ( parcode IN HIG_CODES.hco_code%TYPE) RETURN VARCHAR IS

  CURSOR c1( parcode IN NM_INV_ATTRI_LOOKUP_ALL.ial_value%TYPE)
  IS SELECT ial_meaning 
     FROM   NM_INV_ATTRI_LOOKUP_ALL
	 WHERE  ial_domain='SUB_PARISH'
	 AND    ial_value = parcode;

  parname NM_INV_ATTRI_LOOKUP_ALL.ial_meaning%TYPE;

BEGIN
   OPEN c1(parcode);
   FETCH c1 INTO parname;
   IF c1%NOTFOUND
   THEN CLOSE c1;
   ELSE CLOSE c1;
   END IF;

   RETURN parname;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       NULL;

END get_Parish;
--
-----------------------------------------------------------------------------
--
	function is_defect_in_completed_order(
  	p_defect_id in DEFECTS.DEF_DEFECT_ID%type) return boolean
  is
	  cursor cur(p_defect_id in DEFECTS.DEF_DEFECT_ID%type) is
      select 0 
      from WORK_ORDER_LINES wol, HIG_STATUS_CODES hsc
      where wol.WOL_STATUS_CODE = hsc.HSC_STATUS_CODE
      	and hsc.HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
				AND (hsc.hsc_allow_feature2 = 'Y'
				OR 		 hsc.hsc_allow_feature3 = 'Y'
				OR     hsc.hsc_allow_feature4 = 'Y'
				OR     hsc.hsc_allow_feature5 = 'Y'
				OR     hsc.hsc_allow_feature6 = 'Y'
				OR     hsc.hsc_allow_feature7 = 'Y'
				OR     hsc.hsc_allow_feature8 = 'Y'
				OR     hsc.hsc_allow_feature9 = 'Y')
        and wol.WOL_DEF_DEFECT_ID = p_defect_id;
		rec cur%rowtype;
	  v_ret boolean;
	begin
		open cur(p_defect_id);
	  fetch cur into rec;
	  v_ret := cur%found;
	  close cur;
    return v_ret;
	end is_defect_in_completed_order;
--
-----------------------------------------------------------------------------
--
	function is_defect_in_active_order(
  	p_defect_id in DEFECTS.DEF_DEFECT_ID%type) return boolean
  is
	  cursor cur(p_defect_id in DEFECTS.DEF_DEFECT_ID%type) is
			select 0 
      from WORK_ORDER_LINES wol, HIG_STATUS_CODES hsc
      where wol.WOL_STATUS_CODE = hsc.HSC_STATUS_CODE
      	and hsc.HSC_DOMAIN_CODE = 'WORK_ORDER_LINES'
        and hsc.HSC_ALLOW_FEATURE1 = 'Y'
        and wol.WOL_DEF_DEFECT_ID = p_defect_id;
		rec cur%rowtype;
	  v_ret boolean;
	begin
		open cur(p_defect_id);
	  fetch cur into rec;
	  v_ret := cur%found;
	  close cur;
    return v_ret;
	end is_defect_in_active_order;
--
-----------------------------------------------------------------------------
--
END mai_gmis_util;
/
