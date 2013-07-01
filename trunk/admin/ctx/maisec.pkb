CREATE OR REPLACE PACKAGE BODY maisec AS
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/ctx/maisec.pkb-arc   3.4   Jul 01 2013 15:47:26   James.Wadsworth  $
--       Module Name      : $Workfile:   maisec.pkb  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:47:26  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:57:26  $
--       PVCS Version     : $Revision:   3.4  $
--
--   Author : Mike Huitson
--
--   Package for implementing contract-based security
--
--
------------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------------------------
--
  g_body_sccsid     CONSTANT  varchar2(2000) := '$Revision:   3.4  $';
  --
  g_package_name  CONSTANT varchar2(30) := 'maisec';
  --
--
----------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------
--
FUNCTION get_con_string(pi_schema   IN VARCHAR2
                       ,pi_mode     IN VARCHAR2
                       ,pi_updating IN BOOLEAN)
  RETURN VARCHAR2 IS
  /*
  || The pi_updating parameter is not used here as we are
  || only restricting who can query records, however this
  || may change in the future.
  */
  lv_retval VARCHAR2(2000);
  lv_inctopcon  hig_option_values.hov_value%TYPE;
  lv_dumconcode hig_option_values.hov_value%TYPE;
  --
BEGIN
  /*
  || Make sure the user can only see appropriate Contracts.
  */
  IF pi_mode = c_admin_unit
   THEN
      --
      lv_inctopcon  := NVL(hig.get_sysopt('INCTOPCON'),'N');
      lv_dumconcode := NVL(hig.get_sysopt('DUMCONCODE'),'DISABLED');
      --
      lv_retval := '(con_admin_org_id IN(SELECT hag_child_admin_unit'
        ||CHR(10)||'                       FROM hig_admin_groups'
        ||CHR(10)||'                           ,hig_users'
        ||CHR(10)||'                      WHERE hus_username = SYS_CONTEXT(''NM3_SECURITY_CTX'',''USERNAME'')'
        ||CHR(10)||'                        AND hus_admin_unit = hag_parent_admin_unit';
      IF lv_inctopcon = 'Y'
       THEN
          lv_retval := lv_retval
            ||CHR(10)||'                     UNION'
            ||CHR(10)||'                     SELECT hau_admin_unit'
            ||CHR(10)||'                       FROM hig_admin_units'
            ||CHR(10)||'                      WHERE hau_level = 1'
            ||CHR(10)||'                        AND hig.get_sysopt(''INCTOPCON'') = ''Y'')';
      ELSE
          lv_retval := lv_retval||')';
      END IF;
      --
      IF lv_dumconcode != 'DISABLED'
       THEN
          lv_retval := lv_retval||CHR(10)||' OR con_code = '||nm3flx.string(lv_dumconcode);
      END IF;
      --
      lv_retval := lv_retval||') ';
      --
  ELSIF pi_mode = c_user
   THEN
      lv_retval := 'con_contr_org_id IN(SELECT oun_org_id'
        ||CHR(10)||'                      FROM v_user_contractors) ';
  END IF;
  --
  RETURN lv_retval;
  --
END get_con_string;
--
------------------------------------------------------------------------------------
--
FUNCTION con_predicate_read(schema_in VARCHAR2
                           ,name_in   VARCHAR2)
  RETURN VARCHAR2 IS
  --
  lv_retval             VARCHAR2(2000);
  lv_con_sec_mode       hig_option_values.hov_value%TYPE := hig.get_sysopt(p_option_id => 'CONSECMODE');
  lv_user_unrestricted  CONSTANT BOOLEAN := Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE';
  --
BEGIN
  --
  IF lv_con_sec_mode != c_not_enabled
   AND NOT lv_user_unrestricted
   THEN
      /*
      || Contract Security is in use so
      || build a predicate to restrict access.
      */
      lv_retval := get_con_string(pi_schema   => schema_in
                                 ,pi_mode     => lv_con_sec_mode
                                 ,pi_updating => FALSE);
  ELSE
      /*
      || Contract Security is not in use so
      || don't restrict access.
      */
      lv_retval := NULL;
  END IF;
  --
  RETURN lv_retval;
  --
END con_predicate_read;
--
------------------------------------------------------------------------------------
--
FUNCTION get_wo_string(pi_schema   IN VARCHAR2
                      ,pi_mode     IN VARCHAR2
                      ,pi_updating IN BOOLEAN)
  RETURN VARCHAR2 IS
  /*
  || The pi_updating parameter is not used here as we are
  || only restricting who can query records, however this
  || may change in the future.
  */
  lv_retval VARCHAR2(2000);
  --
BEGIN
  /*
  || Make sure the user can only see Work Orders for the appropriate Contracts.
  */
  lv_retval := 'wor_con_id IN(SELECT con_id'
    ||CHR(10)||'                FROM contracts) ';
  --
  RETURN lv_retval;
  --
END get_wo_string;
--
------------------------------------------------------------------------------------
--
FUNCTION wo_predicate_read(schema_in VARCHAR2
                          ,name_in   VARCHAR2)
  RETURN VARCHAR2 IS
  --
  lv_retval             VARCHAR2(2000);
  lv_con_sec_mode       hig_option_values.hov_value%TYPE := hig.get_sysopt(p_option_id => 'CONSECMODE');
  lv_user_unrestricted  CONSTANT BOOLEAN := Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE';
  --
BEGIN
  --
  IF lv_con_sec_mode != c_not_enabled
   AND NOT lv_user_unrestricted
   THEN
      /*
      || Contract Security is in use so
      || build a predicate to restrict access.
      */
      lv_retval := get_wo_string(pi_schema   => schema_in
                                ,pi_mode     => lv_con_sec_mode
                                ,pi_updating => FALSE);
  ELSE
      /*
      || Contract Security is not in use so
      || don't restrict access.
      */
      lv_retval := NULL;
  END IF;
  --
  RETURN lv_retval;
  --
END wo_predicate_read;
--
------------------------------------------------------------------------------------
--
FUNCTION get_boq_string(pi_schema   IN VARCHAR2
                       ,pi_mode     IN VARCHAR2
                       ,pi_updating IN BOOLEAN)
  RETURN VARCHAR2 IS
  /*
  || The pi_updating parameter is not used here as we are
  || only restricting who can query records, however this
  || may change in the future.
  */
  lv_retval VARCHAR2(2000);
  --
BEGIN
  /*
  || Make sure the user can only see the BOQs for Work Orders
  || on appropriate Contracts.
  */
--  lv_retval := '(NVL(boq_wol_id,0) = 0'
--    ||CHR(10)||' OR EXISTS(SELECT 1'
--    ||CHR(10)||'             FROM work_order_lines'
--    ||CHR(10)||'                 ,work_orders'
--    ||CHR(10)||'            WHERE wor_works_order_no = wol_works_order_no'
--    ||CHR(10)||'              AND wol_id = boq_wol_id)) '
--  ;
  lv_retval := '(NVL(boq_wol_id,0) = 0'
    ||CHR(10)||' OR boq_wol_id IN(SELECT wol_id'
    ||CHR(10)||'                    FROM work_order_lines'
    ||CHR(10)||'                        ,work_orders'
    ||CHR(10)||'                   WHERE wor_works_order_no = wol_works_order_no)) '
  ;
  --
  RETURN lv_retval;
  --
END get_boq_string;
--
------------------------------------------------------------------------------------
--
FUNCTION boq_predicate_read(schema_in VARCHAR2
                           ,name_in   VARCHAR2)
  RETURN VARCHAR2 IS
  --
  lv_retval             VARCHAR2(2000);
  lv_con_sec_mode       hig_option_values.hov_value%TYPE := hig.get_sysopt(p_option_id => 'CONSECMODE');
  lv_user_unrestricted  CONSTANT BOOLEAN := Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE';
  --
BEGIN
  --
  IF lv_con_sec_mode != c_not_enabled
   AND NOT lv_user_unrestricted
   THEN
      /*
      || Contract Security is in use so
      || build a predicate to restrict access.
      */
      lv_retval := get_boq_string(pi_schema   => schema_in
                                 ,pi_mode     => lv_con_sec_mode
                                 ,pi_updating => FALSE);
  ELSE
      /*
      || Contract Security is not in use so
      || don't restrict access.
      */
      lv_retval := NULL;
  END IF;
  --
  RETURN lv_retval;
  --
END boq_predicate_read;
--
------------------------------------------------------------------------------------
--
FUNCTION get_cni_string(pi_schema   IN VARCHAR2
                       ,pi_mode     IN VARCHAR2
                       ,pi_updating IN BOOLEAN)
  RETURN VARCHAR2 IS
  /*
  || The pi_updating parameter is not used here as we are
  || only restricting who can query records, however this
  || may change in the future.
  */
  lv_retval VARCHAR2(2000);
  --
BEGIN
  /*
  || Make sure the user can only see Contract Items for appropriate Contracts.
  */
  lv_retval := 'cni_con_id IN(SELECT con_id'
    ||CHR(10)||'                FROM contracts) '
  ;
  --
  RETURN lv_retval;
  --
END get_cni_string;
--
------------------------------------------------------------------------------------
--
FUNCTION cni_predicate_read(schema_in VARCHAR2
                           ,name_in   VARCHAR2)
  RETURN VARCHAR2 IS
  --
  lv_retval             VARCHAR2(2000);
  lv_con_sec_mode       hig_option_values.hov_value%TYPE := hig.get_sysopt(p_option_id => 'CONSECMODE');
  lv_user_unrestricted  CONSTANT BOOLEAN := Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE';
  --
BEGIN
  --
  IF lv_con_sec_mode != c_not_enabled
   AND NOT lv_user_unrestricted
   THEN
      /*
      || Contract Security is in use so
      || build a predicate to restrict access.
      */
      lv_retval := get_cni_string(pi_schema   => schema_in
                                 ,pi_mode     => lv_con_sec_mode
                                 ,pi_updating => FALSE);
  ELSE
      /*
      || Contract Security is not in use so
      || don't restrict access.
      */
      lv_retval := NULL;
  END IF;
  --
  RETURN lv_retval;
  --
END cni_predicate_read;
--
------------------------------------------------------------------------------------
--
END maisec;
/
