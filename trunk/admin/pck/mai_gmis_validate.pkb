CREATE OR REPLACE PACKAGE BODY mai_gmis_validate AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_gmis_validate.pkb-arc   2.3   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_gmis_validate.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:30  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:54:14  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.3
--
--
--   Author : Darren Cope
--
--   mai_gmis_validate body
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--all global package variables here

  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '"$Revision:   2.3  $"';

  g_package_name CONSTANT varchar2(30) := 'mai_gmis_validate';

  g_error_code CONSTANT pls_integer := -20001;

  g_validation_problem EXCEPTION;
  PRAGMA EXCEPTION_INIT(g_validation_problem, -20001);
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
FUNCTION activity_is_valid(p_acty_area_code IN activities.atv_acty_area_code%TYPE
                          ,p_dtp_flag       IN activities.atv_dtp_flag%TYPE) RETURN activities.atv_acty_area_code%TYPE IS
BEGIN
 RETURN  mai_tab_act.get(pi_atv_acty_area_code => p_acty_area_code
                        ,pi_atv_dtp_flag       => p_dtp_flag
                        ,pi_raise_not_found    => TRUE).atv_acty_area_code;

END activity_is_valid;
--
-----------------------------------------------------------------------------
--
PROCEDURE raise_her(pi_appl               IN nm_errors.ner_appl%TYPE
                   ,pi_id                 IN nm_errors.ner_id%TYPE
                   ,pi_sqlcode            IN pls_integer DEFAULT -20000
                   ,pi_supplementary_info IN varchar2    DEFAULT NULL
                   ) IS
--
     l_rec_her hig_errors%ROWTYPE := nm3get.get_her(pi_her_no => pi_id
                                                   ,pi_her_appl => pi_appl);
--
     l_sqlcode pls_integer := ABS(pi_sqlcode) * (-1);
     l_sqlerrm varchar2(32767);
--
     l_id_char varchar2(5);
--
  BEGIN
     --
     l_id_char := LTRIM(TO_CHAR(pi_id,'0000'),' ');
     --
     IF  ABS(l_sqlcode) NOT BETWEEN 20000 AND 20999
      OR l_sqlcode IS NULL
      THEN
        l_sqlcode := -20000;
     END IF;
     --
     l_sqlerrm := pi_appl||'-'||l_id_char||': '||l_rec_her.her_descr;
     --
     IF pi_supplementary_info IS NOT NULL
      THEN
        l_sqlerrm := l_sqlerrm||': '||pi_supplementary_info;
     END IF;
     --

     RAISE_APPLICATION_ERROR(l_sqlcode,l_sqlerrm);
END raise_her;
--
-----------------------------------------------------------------------------
--
FUNCTION get_user_id(p_user IN hig_users.hus_initials%TYPE) RETURN hig_users.hus_user_id%TYPE IS
CURSOR get_user (p_inits IN hig_users.hus_initials%TYPE) IS
SELECT hus_user_id
FROM   hig_users
WHERE  hus_initials = p_inits;

l_retval hig_users.hus_user_id%TYPE;
l_found  boolean;
BEGIN
  OPEN get_user(p_user);
  FETCH get_user INTO l_retval;
  l_found := get_user%FOUND;
  CLOSE get_user;
  
  IF NOT l_found THEN
    hig.raise_ner (pi_appl               => nm3type.c_hig
                  ,pi_id                 => 67
                  ,pi_sqlcode            => g_error_code
                  ,pi_supplementary_info => 'hig_users'
                                            ||CHR(10)||'hus_intials => '||p_user);
  END IF;

  RETURN l_retval;
END get_user_id;
--
-----------------------------------------------------------------------------
--
FUNCTION hco_is_valid(p_domain IN hig_codes.hco_domain%TYPE
                     ,p_code   IN hig_codes.hco_code%TYPE) RETURN hig_codes.hco_code%TYPE IS
BEGIN

  RETURN nm3get.get_hco(pi_hco_domain        => p_domain
                       ,pi_hco_code          => p_code
                       ,pi_raise_not_found   => TRUE
                       ,pi_not_found_sqlcode => g_error_code).hco_code;
END hco_is_valid;
--
-----------------------------------------------------------------------------
--
FUNCTION check_chainage(p_ne_id IN nm_elements_all.ne_id%TYPE
                       ,p_chain IN nm_elements_all.ne_length%TYPE) RETURN nm_elements_all.ne_length%TYPE IS
l_ne_length nm_elements_all.ne_length%TYPE := nm3net.get_ne_length(p_ne_id => p_ne_id);
BEGIN
  IF p_chain IS NULL THEN
    RETURN NULL;
  ELSIF p_chain NOT BETWEEN 0 AND l_ne_length THEN
    hig.raise_ner(pi_appl => nm3type.c_net
                 ,pi_id   => 892);
  END IF;
  
  RETURN p_chain;
END check_chainage;
--
-----------------------------------------------------------------------------
--
FUNCTION check_xsp(pi_ne_id         IN nm_elements.ne_id%TYPE
                  ,pi_x_sect        IN xsp_restraints.xsr_x_sect_value%TYPE) RETURN xsp_restraints.xsr_x_sect_value%TYPE IS

l_retval xsp_restraints.xsr_x_sect_value%TYPE;
BEGIN
  IF pi_x_sect IS NOT NULL THEN
    IF nm3xsp.xsp_valid_for_ne(pi_ne_id => pi_ne_id
                              ,pi_xsp   => pi_x_sect) THEN
       l_retval := pi_x_sect;
    ELSE
       hig.raise_ner (pi_appl               => nm3type.c_hig
                     ,pi_id                 => 67
                     ,pi_sqlcode            => -20000
                     ,pi_supplementary_info => 'nm_xsp_restraints '
                                               ||CHR(10)||'x_sect_value => '||pi_x_sect
                      );
       l_retval := NULL;
    END IF;
  
  END IF;
  
  RETURN l_retval;

END check_xsp;
--
-----------------------------------------------------------------------------
--
FUNCTION def_code_is_valid(p_defect_code IN def_types.dty_defect_code%TYPE
                          ,p_area_code   IN def_types.dty_atv_acty_area_code%TYPE
                          ,p_sys_flag    IN def_types.dty_dtp_flag%TYPE) RETURN def_types.dty_defect_code%TYPE IS

BEGIN
 RETURN mai_tab_dty.get(pi_dty_defect_code        => p_defect_code
                       ,pi_dty_atv_acty_area_code => p_area_code
                       ,pi_dty_dtp_flag           => p_sys_flag
                       ,pi_raise_not_found        => TRUE).dty_defect_code;
END def_code_is_valid;
--
-----------------------------------------------------------------------------
--
FUNCTION treatment_is_valid(p_tre_code IN repairs.rep_tre_treat_code%TYPE) RETURN repairs.rep_tre_treat_code%TYPE IS

BEGIN
  RETURN mai_tab_tre.get(pi_tre_treat_code  => p_tre_code
                        ,pi_raise_not_found => TRUE).tre_treat_code;
END treatment_is_valid;
--
-----------------------------------------------------------------------------
--
FUNCTION std_item_is_valid(p_std_item IN standard_items.sta_item_code%TYPE) RETURN standard_items.sta_item_code%TYPE IS
BEGIN
  RETURN mai_tab_std.get(pi_sta_item_code   => p_std_item
                        ,pi_raise_not_found => TRUE).sta_item_code;
  
END std_item_is_valid;
--
-----------------------------------------------------------------------------
--
FUNCTION std_quantity_within_limits (p_std_item IN standard_items.sta_item_code%TYPE
                                    ,p_qty      IN standard_items.sta_min_quantity%TYPE) RETURN standard_items.sta_min_quantity%TYPE IS
l_sta standard_items%ROWTYPE := mai_tab_std.get(pi_sta_item_code   => p_std_item
                                               ,pi_raise_not_found => TRUE);
l_her hig_errors%ROWTYPE := nm3get.get_her(pi_her_no          => 245
                                          ,pi_her_appl        => 'M_MGR'
                                          ,pi_raise_not_found => TRUE);
BEGIN
  IF p_qty IS NULL THEN
      hig.raise_ner(pi_appl => nm3type.c_hig
                   ,pi_id   => 30
                   ,pi_supplementary_info => 'Standard Item '||p_std_item||', quantity cannot be null');
  ELSIF p_qty NOT BETWEEN l_sta.sta_min_quantity AND  l_sta.sta_max_quantity THEN
      -- old error raised the old way
      raise_her(pi_appl => 'M_MGR'
               ,pi_id   => 245);
  END IF;
  
  RETURN p_qty;
END std_quantity_within_limits;
--
-----------------------------------------------------------------------------
--
FUNCTION get_ity_sys_flag(p_rse_he_id IN nm_elements.ne_id%TYPE) RETURN road_segs.rse_sys_flag%TYPE IS

CURSOR get_sys (p_rse_he_id IN road_segs.rse_he_id%TYPE) IS
SELECT rse.rse_sys_flag
FROM   road_segs rse
WHERE  rse.rse_he_id = p_rse_he_id;

l_retval road_segs.rse_sys_flag%TYPE;
BEGIN
  OPEN get_sys(p_rse_he_id);
  FETCH get_sys INTO l_retval;
  CLOSE get_sys;
  
  RETURN l_retval;
END get_ity_sys_flag;
--
-----------------------------------------------------------------------------
--
FUNCTION get_def_attr_col(p_defect_code     defects.def_defect_code%TYPE
                         ,p_acty_area_code  defects.def_atv_acty_area_code%TYPE
                         ,p_sys_flag        defects.def_ity_sys_flag%TYPE
                         ,p_attr_num        pls_integer) RETURN def_types.dty_hh_attribute_1%TYPE IS
 l_dty def_types%ROWTYPE := mai_tab_dty.get(pi_dty_defect_code        => p_defect_code
                                           ,pi_dty_atv_acty_area_code => p_acty_area_code
                                           ,pi_dty_dtp_flag           => p_sys_flag
                                           ,pi_raise_not_found        => FALSE);
 l_retval def_types.dty_hh_attribute_1%TYPE;
BEGIN
  CASE p_attr_num
    WHEN 1 THEN
      l_retval := l_dty.dty_hh_attribute_1;
    WHEN 2 THEN
      l_retval := l_dty.dty_hh_attribute_2;
    WHEN 3 THEN
      l_retval := l_dty.dty_hh_attribute_3;
    WHEN 4 THEN
      l_retval := l_dty.dty_hh_attribute_4;
    ELSE 
      l_retval := NULL;
  END CASE;
  
  RETURN l_retval;
END get_def_attr_col;
--
-----------------------------------------------------------------------------
--
FUNCTION dpr_is_valid_for_area (pi_dpr_admin_unit         IN defect_priorities.dpr_admin_unit%TYPE
                               ,pi_dpr_atv_acty_area_code IN defect_priorities.dpr_atv_acty_area_code%TYPE 
                               ,pi_dpr_priority           IN defect_priorities.dpr_priority%TYPE
                               ,pi_dpr_action_cat         IN defect_priorities.dpr_action_cat%TYPE) RETURN defect_priorities.dpr_priority%TYPE IS
BEGIN
  RETURN mai_tab_dpr.get(pi_dpr_admin_unit         => pi_dpr_admin_unit
                        ,pi_dpr_atv_acty_area_code => pi_dpr_atv_acty_area_code
                        ,pi_dpr_priority           => pi_dpr_priority
                        ,pi_dpr_action_cat         => pi_dpr_action_cat
                        ,pi_raise_not_found        => TRUE).dpr_priority;
END dpr_is_valid_for_area;
--
-----------------------------------------------------------------------------
--
END mai_gmis_validate;
/
