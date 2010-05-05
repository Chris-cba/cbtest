CREATE OR REPLACE PACKAGE BODY mai_wo_automation
AS
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/pck/mai_wo_automation.pkb-arc   3.0   May 05 2010 12:04:24   malexander  $
--       Module Name      : $Workfile:   mai_wo_automation.pkb  $
--       Date into PVCS   : $Date:   May 05 2010 12:04:24  $
--       Date fetched Out : $Modtime:   May 05 2010 12:04:02  $
--       Version          : $Revision:   3.0  $
--       Based on SCCS version : 
-------------------------------------------------------------------------
--
--all global package variables here

  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '$Revision:   3.0  $';

  g_package_name CONSTANT varchar2(30) := 'mai_wo_automation' ;
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
FUNCTION get_rse (pi_rse_he_id IN road_segments_all.rse_he_id%TYPE)
RETURN road_segments_all%ROWTYPE
IS
--
   CURSOR c_get_rse
   IS
   SELECT *
   FROM   road_segments 
   WHERE  rse_he_id = pi_rse_he_id;
   l_rse_rec road_segments_all%ROWTYPE;
--
BEGIN
--
   OPEN  c_get_rse;
   FETCH c_get_rse INTO l_rse_rec;
   CLOSE c_get_rse;

   Return l_rse_rec;   
--
END get_rse;
--
FUNCTION get_bud_details(pi_bud_id IN budgets.bud_id%TYPE)
Return g_bud_rec%TYPE  
IS 
--
   CURSOR c_bud
   IS
   SELECT BUD_ICB_ITEM_CODE||BUD_ICB_SUB_ITEM_CODE||BUD_ICB_SUB_SUB_ITEM_CODE 
         ,icb_work_category_name
         ,BUD_SYS_FLAG
         ,BUD_RSE_HE_ID
         ,BUD_FYR_ID
         ,icb_id
   From   Budgets
         ,item_code_breakdowns
   WHERE  icb_dtp_flag = BUD_SYS_FLAG
   AND    icb_item_code = BUD_ICB_ITEM_CODE  
   AND    icb_sub_item_code = BUD_ICB_SUB_ITEM_CODE  
   AND    icb_sub_sub_item_code = BUD_ICB_SUB_SUB_ITEM_CODE
   AND    decode(hig.get_sysopt('ICBFGAC'),'Y',icb_agency_code,BUD_AGENCY) = BUD_AGENCY
   AND    bud_id = pi_bud_id ;
   l_bud_rec g_bud_rec%TYPE;
--
BEGIN
--
   OPEN  c_bud;
   FETCH c_bud INTO l_bud_rec;
   CLOSE c_bud ;   

   Return l_bud_rec;
--
END get_bud_details;
--
FUNCTION get_con(pi_con_id IN contracts.con_id%TYPE)
Return   contracts%ROWTYPE
IS
--
   CURSOR c_con
   IS
   SELECT *
   FROM   contracts 
   WHERE  con_id = pi_con_id;
   l_con_rec contracts%ROWTYPE;
--
BEGIN
--
   OPEN  c_con;
   FETCH c_con INTO l_con_rec;
   CLOSE c_con;

   Return l_con_rec ;
--
END  get_con;
--
FUNCTION get_atv(pi_atv_acty_code IN Varchar2)
Return   activities%ROWTYPE
IS
--
   CURSOR c_atv
   IS
   SELECT *
   FROM   activities 
   WHERE  atv_acty_area_code = pi_atv_acty_code;
   l_atv_rec activities%ROWTYPE;
--
BEGIN
--
   OPEN  c_atv;
   FETCH c_atv INTO l_atv_rec;
   CLOSE c_atv;

   Return l_atv_rec ;
--
END  get_atv;
--
FUNCTION get_dty(pi_dty_code IN Varchar2)
Return   def_types%ROWTYPE
IS
--
   CURSOR c_dty
   IS
   SELECT *
   FROM   def_types
   WHERE  dty_defect_code = pi_dty_code;
   l_dty_rec def_types%ROWTYPE;
--
BEGIN
--
   OPEN  c_dty;
   FETCH c_dty INTO l_dty_rec;
   CLOSE c_dty;

   Return l_dty_rec ;
--
END  get_dty;
--
FUNCTION get_tre(pi_tre_code IN Varchar2)
Return   treatments%ROWTYPE
IS
--
   CURSOR c_tre
   IS
   SELECT *
   FROM   treatments
   WHERE  tre_treat_code = pi_tre_code;
   l_tre_rec treatments%ROWTYPE;
--
BEGIN
--
   OPEN  c_tre;
   FETCH c_tre INTO l_tre_rec;
   CLOSE c_tre;

   Return l_tre_rec ;
--
END  get_tre;
--
FUNCTION check_detail_exists(pi_mawr_id IN mai_auto_wo_rules.mawr_id%TYPE)
Return   Boolean
IS
--
   l_cnt Number ;
--
BEGIN
--
   SELECT Count(0)
   INTO   l_cnt
   FROM   mai_auto_wo_rule_criteria
   WHERE  mawc_mawr_id  = pi_mawr_id ;

   Return Nvl(l_cnt,0) > 0; 
--
END check_detail_exists;
--
PROCEDURE delete_criteria(pi_mawr_id IN mai_auto_wo_rules.mawr_id%TYPE)
IS
BEGIN
--
   DELETE 
   FROM   mai_auto_wo_rule_criteria
   WHERE  mawc_mawr_id = pi_mawr_id;
--
END delete_criteria;
--
PROCEDURE copy_rule(pi_mawr_id IN  mai_auto_wo_rules.mawr_id%TYPE
                   ,po_mawr_id OUT mai_auto_wo_rules.mawr_id%TYPE)
IS
--
   l_mawr_id mai_auto_wo_rules.mawr_id%TYPE;
--
BEGIN
--
   SELECT mawr_id_seq.nextval
   INTO   l_mawr_id 
   FROM   dual;
   INSERT INTO mai_auto_wo_rules SELECT l_mawr_id 
                                        ,mawr_name
                                        ,mawr_descr
                                        ,mawr_admin_unit
                                        ,mawr_road_group_id
                                        ,mawr_scheme_type
                                        ,mawr_bud_id
                                        ,mawr_con_id
                                        ,mawr_aggregate_repairs
                                        ,mawr_start_date
                                        ,mawr_end_date
                                        ,mawr_enabled
                                        ,Null
                                        ,Null
                                        ,Null
                                        ,Null
                                  FROM   mai_auto_wo_rules
                                  WHERE  mawr_id = pi_mawr_id ;
   
   INSERT INTO mai_auto_wo_rule_criteria SELECT mawc_id_seq.nextval
                                                ,l_mawr_id
                                                ,mawc_atv_acty_area_code
                                                ,mawc_dty_defect_code
                                                ,mawc_priority
                                                ,mawc_include_temp_repair
                                                ,mawc_include_perm_repair
                                                ,mawc_tre_treat_code
                                                ,mawc_auto_instruct
                                                ,mawc_enabled 
                                                ,Null
                                                ,Null
                                                ,Null
                                                ,Null
                                         FROM   mai_auto_wo_rule_criteria
                                         WHERE  mawc_mawr_id  = pi_mawr_id ;
   po_mawr_id := l_mawr_id ;
--
END copy_rule;
--
FUNCTION duplicate_rule(pi_mawr_rec IN mai_auto_wo_rules%ROWTYPE)
RETURN BOOLEAN
IS
--
   l_cnt Number;
--
BEGIN
--
   SELECT Count(0)
   INTO   l_cnt
   FROM   mai_auto_wo_rules
   WHERE  mawr_admin_unit           = pi_mawr_rec.mawr_admin_unit
   AND    Nvl(mawr_road_group_id,0) = Nvl(pi_mawr_rec.mawr_road_group_id,0)
   AND    mawr_start_date           = pi_mawr_rec.mawr_start_date
   AND    mawr_scheme_type          = pi_mawr_rec.mawr_scheme_type
   AND    mawr_bud_id               = pi_mawr_rec.mawr_bud_id
   AND    mawr_con_id               = pi_mawr_rec.mawr_con_id   
   AND    mawr_id                  != pi_mawr_rec.mawr_id ;

   RETURN Nvl(l_cnt,0) > 0 ;
--
END duplicate_rule;
--
FUNCTION get_mawr(pi_mawr_id IN mai_auto_wo_rules.mawr_id%TYPE)
Return   mai_auto_wo_rules%ROWTYPE
IS
--
   CURSOR c_mawr 
   IS
   SELECT *
   FROM   mai_auto_wo_rules
   WHERE  mawr_id = pi_mawr_id;
   l_mawr_rec mai_auto_wo_rules%ROWTYPE;   
--
BEGIN
--
   OPEN  c_mawr;
   FETCH c_mawr INTO l_mawr_rec;
   CLOSE c_mawr;

   RETURN l_mawr_rec; 
--
END get_mawr;
--
END mai_wo_automation;
/



