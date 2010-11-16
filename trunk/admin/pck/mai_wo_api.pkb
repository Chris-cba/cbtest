CREATE OR REPLACE PACKAGE BODY mai_wo_api AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_wo_api.pkb-arc   3.16   Nov 16 2010 13:33:30   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_wo_api.pkb  $
--       Date into PVCS   : $Date:   Nov 16 2010 13:33:30  $
--       Date fetched Out : $Modtime:   Nov 16 2010 10:20:00  $
--       PVCS Version     : $Revision:   3.16  $
--
-----------------------------------------------------------------------------
--  Copyright (c) exor corporation ltd, 2007
-----------------------------------------------------------------------------
--
  g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   3.16  $';
  g_package_name  CONSTANT  varchar2(30)   := 'mai_api';
  --
  insert_error  EXCEPTION;
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
FUNCTION get_next_id(pi_seq_name IN VARCHAR2)
  RETURN NUMBER IS
  --
  lv_query   varchar2(100) := 'select '||pi_seq_name||'.nextval from dual';
  lv_retval  number;
  --
BEGIN
  --
  EXECUTE IMMEDIATE lv_query
     INTO lv_retval;
  --
  RETURN lv_retval;
  --
END;
--
-----------------------------------------------------------------------------
--
FUNCTION count_created_work_orders
  RETURN NUMBER IS
BEGIN
  --
  RETURN gt_work_orders.count;
  --
END count_created_work_orders;
--
-----------------------------------------------------------------------------
--
PROCEDURE get_created_work_orders(po_work_orders IN OUT works_order_tab) IS
BEGIN
  po_work_orders := gt_work_orders;
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE clear_created_work_orders_tab IS
  --
  empty_tab works_order_tab;
  --
BEGIN
  /*
  ||Clear The PLSQL Table.
  */
  gt_work_orders := empty_tab;
  --
END clear_created_work_orders_tab;
--
-----------------------------------------------------------------------------
--
FUNCTION get_defect(pi_defect_id IN defects.def_defect_id%TYPE)
  RETURN defects%ROWTYPE IS
  --
  lr_retval defects%ROWTYPE;
  --
BEGIN
  /*
  ||Get Defects Record.
  */
  SELECT *
    INTO lr_retval
    FROM defects
   WHERE def_defect_id = pi_defect_id
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20065,'Invalid Defect Id Supplied.');
  WHEN others
   THEN
      RAISE;
END get_defect;
--
-----------------------------------------------------------------------------
--
FUNCTION get_wol(pi_wol_id IN work_order_lines.wol_id%TYPE)
  RETURN work_order_lines%ROWTYPE IS
  --
  lr_retval  work_order_lines%ROWTYPE;
  --
BEGIN
  /*
  ||Get Work Order Line Record.
  */
  SELECT *
    INTO lr_retval
    FROM work_order_lines
   WHERE wol_id = pi_wol_id
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20096,'Invalid Work Order Line Id Supplied.');
  WHEN others
   THEN
      RAISE;
END get_wol;
--
-----------------------------------------------------------------------------
--
FUNCTION get_and_lock_wol(pi_wol_id IN work_order_lines.wol_id%TYPE)
  RETURN work_order_lines%ROWTYPE IS
  --
  lr_retval  work_order_lines%ROWTYPE;
  --
BEGIN
  /*
  ||Get Work Order Line Record.
  */
  SELECT *
    INTO lr_retval
    FROM work_order_lines
   WHERE wol_id = pi_wol_id
     FOR UPDATE NOWAIT
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20096,'Invalid Work Order Line Id Supplied.');
  WHEN others
   THEN
      RAISE;
END get_and_lock_wol;
--
-----------------------------------------------------------------------------
--
FUNCTION get_wo(pi_works_order_no IN work_orders.wor_works_order_no%TYPE)
  RETURN work_orders%ROWTYPE IS
  --
  lr_retval  work_orders%ROWTYPE;
  --
BEGIN
  /*
  ||Get The Work Order Record.
  */
  SELECT *
    INTO lr_retval
    FROM work_orders
   WHERE wor_works_order_no = pi_works_order_no
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20068,'Invalid Work Order Number Supplied');
  WHEN others
   THEN
      RAISE;
END get_wo;
--
-----------------------------------------------------------------------------
--
FUNCTION get_wo_status(pi_works_order_no IN work_orders.wor_works_order_no%TYPE)
  RETURN hig_status_codes.hsc_status_code%TYPE IS
  --
  lv_retval  hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  /*
  ||Get The Works Order Status.
  */
  SELECT wor_status
    INTO lv_retval
    FROM v_work_order_status
   WHERE wor_works_order_no = pi_works_order_no
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20068,'Invalid Work Order Number Supplied');
  WHEN others
   THEN
      RAISE;
END get_wo_status;
--
-----------------------------------------------------------------------------
--
FUNCTION get_and_lock_wo(pi_works_order_no IN work_orders.wor_works_order_no%TYPE)
  RETURN work_orders%ROWTYPE IS
  --
  lr_retval  work_orders%ROWTYPE;
  --
BEGIN
  /*
  ||Get And Lock The Work Order Record.
  */
  SELECT *
    INTO lr_retval
    FROM work_orders
   WHERE wor_works_order_no = pi_works_order_no
     FOR UPDATE NOWAIT
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20068,'Invalid Work Order Number Supplied');
  WHEN others
   THEN
      RAISE;
END get_and_lock_wo;
--
-----------------------------------------------------------------------------
--
FUNCTION get_user(pi_user_id IN hig_users.hus_user_id%TYPE)
  RETURN hig_users%ROWTYPE IS
  --
  lr_retval hig_users%ROWTYPE;
  --
BEGIN
  --
  SELECT *
    INTO lr_retval
    FROM hig_users
   WHERE hus_user_id = pi_user_id
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
  WHEN others
   THEN
      RAISE;
END get_user;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_user_id(pi_user_id        IN hig_users.hus_user_id%TYPE
                         ,pi_effective_date IN DATE)
  RETURN BOOLEAN IS
  --
  lv_dummy NUMBER;
  --
BEGIN
  --
  SELECT 1
    INTO lv_dummy
    FROM hig_users
   WHERE pi_effective_date BETWEEN NVL(hus_start_date,pi_effective_date)
                               AND NVL(hus_end_date-1,pi_effective_date)
     AND hus_user_id = pi_user_id
       ;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN FALSE;
  WHEN others
   THEN
      RAISE;
END validate_user_id;
--
-----------------------------------------------------------------------------
--
FUNCTION interfaces_used(pi_con_id IN contracts.con_id%TYPE)
  RETURN BOOLEAN IS
  --
  lv_retval BOOLEAN := FALSE;
  lv_flag   org_units.oun_electronic_orders_flag%TYPE;
  --
BEGIN
  --
  SELECT NVL(oun_electronic_orders_flag,'N')
    INTO lv_flag
    FROM contracts
        ,org_units
   WHERE oun_org_id = con_contr_org_id
     AND con_id = pi_con_id
       ;
  --
  IF lv_flag = 'Y'
   THEN
      lv_retval := TRUE;
  END IF;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20064,'Invalid Contract On Work Order.');
  WHEN others
   THEN
      RAISE;
END interfaces_used;
--
-----------------------------------------------------------------------------
--
FUNCTION works_order_complete(pi_works_order_no      work_orders.wor_works_order_no%TYPE
                             ,pi_exclude_wol_id_tab  nm3type.tab_number)
  RETURN BOOLEAN IS
  --
  lv_sql     nm3type.max_varchar2;
  lv_result  PLS_INTEGER;
  lv_retval  BOOLEAN := TRUE;
  --
  FUNCTION build_not_in_clause(pi_exclude_wol_id_tab  nm3type.tab_number)
    RETURN VARCHAR2 IS
    --
    lv_where  nm3type.max_varchar2;
    lv_list   nm3type.max_varchar2;
    --
    PROCEDURE add_list_to_where
      IS
    BEGIN
      /*
      ||If this is not the first list of wol_ids
      ||to be added this list needs added with an AND
      */
      IF lv_where IS NOT NULL
       THEN
          lv_where := lv_where||' AND';
      END IF;
      /*
      ||Add the NOT IN clause to the Where Clause.
      ||(the substr removes the trailing comma from the list).
      */
      lv_where := lv_where||' wol_id NOT IN('||SUBSTR(lv_list,1,LENGTH(lv_list)-1)||')';
      /*
      ||Initialise the list.
      */
      lv_list := NULL;
      --
    END add_list_to_where;
    --
  BEGIN
    /*
    ||Build up a NOT IN clause of wol_ids
    */
    FOR i IN 1..pi_exclude_wol_id_tab.count LOOP
      /*
      ||Only allowed upto 1000 entries
      ||for an IN clause so start a new
      ||one every 1000 records.
      */
      IF MOD(i,1000) = 0
       THEN
          add_list_to_where;
      END IF;
      /*
      ||Add the current defect_id to the list.
      */
      lv_list := lv_list||TO_CHAR(pi_exclude_wol_id_tab(i))||',';
      --
    END LOOP;
    /*
    ||Mop up any defect_ids that haven't yet
    ||been added into the where clause.
    */
    IF lv_list IS NOT NULL
     THEN
        --
        add_list_to_where;
        --
    END IF;
    --
    IF lv_where IS NOT NULL
     THEN
        lv_where := ' AND ('||lv_where||')';
    END IF;
    --
    RETURN lv_where;
    --
  END build_not_in_clause;
  --
BEGIN
  /*
  ||Build The SELECT Statement To Find Any Incomplete WOLs For The Given Works Order Number.
  ||
  ||A List Of WOL_IDs To Be Excluded From The Statement Can Be Passed Into This Function
  ||To Allow For The Calling Code Having Made And Checked WOL Status Changes (Or Deleted WOLs)
  ||That Have Not Yet Been Committed To The Database.
  */
  lv_sql := 'SELECT 1'
           ||' FROM dual'
          ||' WHERE EXISTS(SELECT 1'
                         ||' FROM work_order_lines'
                        ||' WHERE wol_works_order_no = '||nm3flx.string(pi_works_order_no)
                          ||' AND wol_status_code NOT IN(SELECT hsc_status_code'
                                                       ||' FROM hig_status_codes'
                                                      ||' WHERE hsc_domain_code = ''WORK_ORDER_LINES'''
                                                        ||' AND (hsc_allow_feature2 = ''Y'''           -- HELD
                                                             ||' OR hsc_allow_feature3 = ''Y'''        -- COMPLETED
                                                             ||' OR (hsc_allow_feature4 = ''Y'''
                                                                 ||' AND hsc_allow_feature9 != ''Y'')' -- PAID (not PART PAID)
                                                             ||' OR hsc_allow_feature5 = ''Y''))'      -- NOT DONE
                          ||build_not_in_clause(pi_exclude_wol_id_tab => pi_exclude_wol_id_tab)
                          ||')'
       ;
  /*
  ||Execute The Statement.
  */
  EXECUTE IMMEDIATE lv_sql
     INTO lv_result;
  /*
  ||If Any Lines Were Found The Works Order Is Not Complete.
  */
  IF lv_result = 1
   THEN
      lv_retval := FALSE;
  END IF;
  /*
  ||Return The Result.
  */
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      /*
      ||No Lines Found So The Works Order Is Complete.
      */
      RETURN TRUE;
  WHEN others
   THEN
      RAISE;
END works_order_complete;
--
-----------------------------------------------------------------------------
--
PROCEDURE check_asset_security(pi_inv_type  IN nm_inv_types.nit_inv_type%TYPE
                              ,pi_iit_ne_id IN nm_inv_items_all.iit_ne_id%TYPE
                              ,pi_user_id   IN hig_users.hus_user_id%TYPE) IS
  --
  ex_security  EXCEPTION;
  --
  lv_nm3_inv_type  nm_inv_types_all.nit_inv_type%TYPE;
  lr_inv_type      nm_inv_types_all%ROWTYPE;
  --
  FUNCTION check_asset_admin_unit
    RETURN BOOLEAN IS
    --
    lv_dummy NUMBER;
    --
  BEGIN
    --
    SELECT iit_ne_id
      INTO lv_dummy
      FROM nm_inv_items
     WHERE iit_ne_id = pi_iit_ne_id
       AND EXISTS(SELECT 1
                    FROM nm_admin_groups
                        ,nm_user_aus
                   WHERE nua_user_id          = pi_user_id
                     AND nua_mode             = nm3type.get_constant('c_normal')
                     AND nua_admin_unit       = nag_parent_admin_unit
                     AND nag_child_admin_unit = iit_admin_unit)
         ;
    --
    RETURN TRUE;
    --
  EXCEPTION
    WHEN others
     THEN
        RETURN FALSE;
  END;
  --
  FUNCTION check_inv_type_role
    RETURN BOOLEAN IS
    --
    lv_dummy NUMBER;
    --
  BEGIN
    --
    SELECT 1
      INTO lv_dummy
      FROM hig_users
          ,hig_user_roles
          ,nm_inv_type_roles
     WHERE itr_inv_type = lv_nm3_inv_type
       AND itr_mode     = nm3type.get_constant('c_normal')
       AND itr_hro_role = hur_role
       AND hur_username = hus_username
       AND hus_user_id  = pi_user_id
         ;
    --
    RETURN TRUE;
    --
  EXCEPTION
    WHEN others
     THEN
        RETURN FALSE;
  END check_inv_type_role;
  --
BEGIN
  /*
  ||Can't use nm3lock as the Web Service logs on as the
  ||Highways Owner so need to make sure the specified
  ||Inspector can update the asset.
  nm3lock.lock_asset_item(pi_nit_id          => pi_inv_type
                         ,pi_pk_id           => pi_iit_ne_id
                         ,pi_lock_for_update => TRUE
                         ,pi_updrdonly       => nm3lock.get_updrdonly);
  */
  /*
  ||Translate The Two Character MAI Inv Code
  ||Into a 4 Character NM3 Asset Type.
  */
  BEGIN
    lv_nm3_inv_type := mai.translate_mai_inv_type(pi_inv_type);
  EXCEPTION
    WHEN others
     THEN
        raise_application_error(-20003,'Cannot Translate Asset Type.');
  END;
  /*
  ||Get The Asset Type Details.
  */
  lr_inv_type := nm3get.get_nit(lv_nm3_inv_type);
  /*
  ||Check Inspector Security.
  */
  IF NOT check_inv_type_role
   THEN
      raise ex_security;
  END IF;
  --
  IF lr_inv_type.nit_table_name IS NULL
   THEN
      IF NOT check_asset_admin_unit
       THEN
          raise ex_security;
      END IF;
  END IF;
  --
EXCEPTION
  WHEN ex_security
   THEN
      hig.raise_ner(pi_appl => 'HIG'
                   ,pi_id   => 437);
  WHEN others
   THEN
      RAISE;
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE check_network_security(pi_ne_id IN nm_elements_all.ne_id%TYPE) IS
  --
  ex_security  EXCEPTION;
  PRAGMA       exception_init(ex_security,-20000);
  --
BEGIN
  --
  nm3lock.lock_element(p_ne_id               => pi_ne_id
                      ,p_lock_ele_for_update => TRUE
                      ,p_updrdonly           => nm3lock.get_updrdonly);
  --
EXCEPTION
  WHEN ex_security
   THEN
      hig.raise_ner(pi_appl => 'HIG'
                   ,pi_id   => 436);
  WHEN others
   THEN
      RAISE;
END;
--
-----------------------------------------------------------------------------
--
FUNCTION validate_section(pi_rse_he_id IN nm_elements_all.ne_id%TYPE)
  RETURN road_sections%ROWTYPE IS
  --
  lv_retval road_sections%ROWTYPE;
  --
BEGIN
  --
  check_network_security(pi_ne_id => pi_rse_he_id);
  --
  SELECT rse.*
    INTO lv_retval
    FROM road_sections rse
   WHERE rse.rse_he_id = pi_rse_he_id
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20005,'Invalid Section Specified.');
  WHEN others
   THEN
      RAISE;
END validate_section;
--
-----------------------------------------------------------------------------
--
FUNCTION get_sta(pi_sta_item_code IN standard_items.sta_item_code%TYPE)
  RETURN standard_items%ROWTYPE IS
  --
  lr_retval standard_items%ROWTYPE;
  --
BEGIN
  --
  SELECT *
    INTO lr_retval
    FROM standard_items
   WHERE sta_item_code = pi_sta_item_code
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20033,'Cannot Find Specfied Standard Item.');
  WHEN others
   THEN
      RAISE;
END get_sta;
--
-----------------------------------------------------------------------------
--
--FUNCTION get_stp(pi_ss_id IN stp_schemes.ss_id%TYPE)
--  RETURN stp_schemes%ROWTYPE IS
--  --
--  lr_retval stp_schemes%ROWTYPE;
--  --
--BEGIN
--  --
--  SELECT *
--    INTO lr_retval
--    FROM stp_schemes
--   WHERE ss_id = pi_ss_id
--       ;
--  --
--  RETURN lr_retval;
--  --
--EXCEPTION
--  WHEN no_data_found
--   THEN
--      raise_application_error(-20033,'Cannot Find Specfied Scheme.');
--  WHEN others
--   THEN
--      RAISE;
--END get_stp;
--
-----------------------------------------------------------------------------
--
FUNCTION get_insp(pi_insp_id IN activities_report.are_report_id%TYPE)
  RETURN activities_report%ROWTYPE IS
  --
  lr_retval activities_report%ROWTYPE;
  --
BEGIN
  --
  SELECT *
    INTO lr_retval
    FROM activities_report
   WHERE are_report_id = pi_insp_id
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20037,'Cannot Find Specfied Inspection.');
  WHEN others
   THEN
      RAISE;
END get_insp;
--
-----------------------------------------------------------------------------
--
FUNCTION get_instructed_def_status
  RETURN hig_status_codes.hsc_status_code%TYPE IS
  --
  lv_retval  hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  --
  SELECT hsc_status_code
    INTO lv_retval
    FROM hig_status_codes
   WHERE hsc_domain_code = 'DEFECTS'
     AND hsc_allow_feature3 = 'Y'
     AND hsc_allow_feature10 = 'N'
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20020,'Cannot Find Initial Works Order Line Status.');
  WHEN others
   THEN
      RAISE;
END get_instructed_def_status;

---------------------------------------------------------------------------

FUNCTION get_instructed_wol_status
  RETURN hig_status_codes.hsc_status_code%TYPE IS
  --
  lv_retval  hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  --
  SELECT hsc_status_code
    INTO lv_retval
    FROM hig_status_codes
   WHERE hsc_domain_code = 'WORK_ORDER_LINES'
     AND hsc_allow_feature1 = 'Y'
     AND hsc_allow_feature10 != 'Y'
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20020,'Cannot Find Instructed Works Order Line Status.');
  WHEN others
   THEN
      RAISE;
END get_instructed_wol_status;
--
-----------------------------------------------------------------------------
--
FUNCTION get_initial_defect_status
  RETURN hig_status_codes.hsc_status_code%TYPE IS
  --
  lv_retval  hig_status_codes.hsc_status_code%TYPE;
  --
BEGIN
  --
  SELECT hsc_status_code
    INTO lv_retval
    FROM hig_status_codes
   WHERE hsc_domain_code = 'DEFECTS'
     AND hsc_allow_feature1 = 'Y'
     AND hsc_allow_feature10 != 'Y'
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20020,'Cannot Find Instructed Defect Status.');
  WHEN others
   THEN
      RAISE;
END get_initial_defect_status;
----
-------------------------------------------------------------------------------
----
--FUNCTION get_complete_defect_status
--  RETURN hig_status_codes.hsc_status_code%TYPE IS
--  --
--  lv_retval  hig_status_codes.hsc_status_code%TYPE;
--  --
--BEGIN
--  --
--  SELECT hsc_status_code
--    INTO lv_retval
--    FROM hig_status_codes
--   WHERE hsc_domain_code = 'DEFECTS'
--     AND hsc_allow_feature4 = 'Y'
--       ;
--  --
--  RETURN lv_retval;
--  --
--EXCEPTION
--  WHEN no_data_found
--   THEN
--      raise_application_error(-20021,'Cannot Find Complete Defect Status.');
--  WHEN others
--   THEN
--      RAISE;
--END get_complete_defect_status;
----
-------------------------------------------------------------------------------
----
--FUNCTION validate_defect_status(pi_defect_rec     IN defects%ROWTYPE
--                               ,pi_effective_date IN DATE)
--  RETURN BOOLEAN IS
--  --
--  lv_retval  BOOLEAN := FALSE;
--  --
--BEGIN
--  /*
--  ||Defects Can Be Created With Either
--  ||The Initial Or Completed Status Code.
--  */
--  IF pi_defect_rec.def_status_code = get_initial_defect_status
--   OR pi_defect_rec.def_status_code = get_complete_defect_status
--   THEN
--      lv_retval := TRUE;
--  END IF;
--  --
--  RETURN lv_retval;
--  --
--END validate_defect_status;
--
-----------------------------------------------------------------------------
--
PROCEDURE validate_repair_boqs(pi_def_defect_id      IN     defects.def_defect_id%TYPE
                              ,pi_rep_action_cat     IN     repairs.rep_action_cat%TYPE
                              ,pi_rep_created_date   IN     repairs.rep_created_date%TYPE
                              ,pi_admin_unit         IN     nm_admin_units.nau_admin_unit%TYPE
                              ,pi_rep_tre_treat_code IN     treatments.tre_treat_code%TYPE
                              ,pi_atv_acty_area_code IN     activities.atv_acty_area_code%TYPE
                              ,pi_def_defect_code    IN     defects.def_defect_code%TYPE
                              ,pi_sys_flag           IN     VARCHAR2
                              ,pio_boq_tab           IN OUT boq_tab)
  IS
  --
  lt_boq_tab       boq_tab;
  lt_tre_boqs_tab  mai.tre_boqs_tab;
  --
  lr_sta  standard_items%ROWTYPE;
  --
  lv_usetremodd   hig_options.hop_value%TYPE := hig.GET_SYSOPT('USETREMODD');
  lv_usetremodl   hig_options.hop_value%TYPE := hig.GET_SYSOPT('USETREMODL');
  lv_tremodlev    hig_options.hop_value%TYPE := hig.get_sysopt('TREMODLEV');
  lv_perc_item    hig_option_values.hov_value%TYPE := hig.get_sysopt('PERC_ITEM');
  --
BEGIN
  /*
  ||If BOQs Have Been Provided Then Validate Them
  ||Otherwise If The System Is Configured To Enforce
  ||Treatment Models Check For A Valid Model And
  ||Apply It.
  */
  IF pio_boq_tab.count > 0
   THEN
      --
      lt_boq_tab := pio_boq_tab;
      --
      FOR i IN 1..lt_boq_tab.COUNT LOOP
        --
        lt_boq_tab(i).boq_work_flag      := 'D';
        lt_boq_tab(i).boq_defect_id      := pi_def_defect_id;
        lt_boq_tab(i).boq_wol_id         := 0;
        lt_boq_tab(i).boq_date_created   := pi_rep_created_date;
        /*
        ||Validate Standard Item Code.
        */
        IF lt_boq_tab(i).boq_sta_item_code IS NOT NULL
         THEN
            lr_sta := get_sta(pi_sta_item_code => lt_boq_tab(i).boq_sta_item_code);
            IF lr_sta.sta_unit = lv_perc_item
             THEN
                raise_application_error(-20099,'Parent BOQs Based On Percentage Items Codes Are Not Supported.');
            END IF;
        ELSE
            raise_application_error(-20032,'Invalid Standard Item Code Specified.');
        END IF;
        lt_boq_tab(i).boq_item_name := lr_sta.sta_item_name;
        /*
        ||Check/Default Dimentions.
        */
        IF lt_boq_tab(i).boq_est_dim1 IS NULL
         THEN
            lt_boq_tab(i).boq_est_dim1 := 0;
        END IF;
        --
        IF lr_sta.sta_dim2_text IS NOT NULL
         AND lt_boq_tab(i).boq_est_dim2 IS NULL
         THEN
            lt_boq_tab(i).boq_est_dim2 := 1;
        END IF;
        --
        IF lr_sta.sta_dim3_text IS NOT NULL
         AND lt_boq_tab(i).boq_est_dim3 IS NULL
         THEN
            lt_boq_tab(i).boq_est_dim3 := 1;
        END IF;
        --
        /*
        ||Set Estimated Quantity.
        */
        lt_boq_tab(i).boq_est_quantity := lt_boq_tab(i).boq_est_dim1
                                          * NVL(lt_boq_tab(i).boq_est_dim2,1)
                                          * NVL(lt_boq_tab(i).boq_est_dim3,1);
        /*
        ||Check Quantity.
        */
        IF lt_boq_tab(i).boq_est_quantity < lr_sta.sta_min_quantity
         AND lt_boq_tab(i).boq_est_quantity != 0
         THEN
            raise_application_error(-20035,'Estimated Quantity Is Below The Minimum Quantity.');
        END IF;
        --
        IF lt_boq_tab(i).boq_est_quantity > lr_sta.sta_max_quantity
         AND lt_boq_tab(i).boq_est_quantity != 0
         THEN
            raise_application_error(-20036,'Estimated Quantity Is Above The Maximum Quantity.');
        END IF;
        /*
        ||Calculate Estimated Labour
        */
        lt_boq_tab(i).boq_est_labour := lt_boq_tab(i).boq_est_quantity * NVL(lr_sta.sta_labour_units,0);
        /*
        ||Validate Estimated Rate.
        */
        lt_boq_tab(i).boq_est_rate := lr_sta.sta_rate;
        /*
        ||Validate Estimated Cost.
        */
        IF lt_boq_tab(i).boq_est_cost IS NULL
         OR lt_boq_tab(i).boq_est_cost != ROUND((lt_boq_tab(i).boq_est_rate * lt_boq_tab(i).boq_est_quantity),2)
         THEN
            lt_boq_tab(i).boq_est_cost := ROUND((lt_boq_tab(i).boq_est_rate * lt_boq_tab(i).boq_est_quantity),2);
        END IF;
        --
      END LOOP;
      --
  ELSE
      IF((pi_sys_flag = 'D' and lv_usetremodd = 'Y') OR
         (pi_sys_flag = 'L' and lv_usetremodl = 'Y'))
       THEN
          --
          mai.get_tre_boqs(pi_admin_unit         => pi_admin_unit
                          ,pi_treat_code         => pi_rep_tre_treat_code
                          ,pi_atv_acty_area_code => pi_atv_acty_area_code
                          ,pi_defect_code        => pi_def_defect_code
                          ,pi_sys_flag           => pi_sys_flag
                          ,po_results            => lt_tre_boqs_tab);
          --
          FOR i IN 1..lt_tre_boqs_tab.count LOOP
            --
            lt_boq_tab(i).boq_work_flag      := 'D';
            lt_boq_tab(i).boq_defect_id      := pi_def_defect_id;
            lt_boq_tab(i).boq_rep_action_cat := pi_rep_action_cat;
            lt_boq_tab(i).boq_wol_id         := 0;
            lt_boq_tab(i).boq_date_created   := pi_rep_created_date;
            lt_boq_tab(i).boq_sta_item_code  := lt_tre_boqs_tab(i).boq_sta_item_code;
            lt_boq_tab(i).boq_item_name      := lt_tre_boqs_tab(i).sta_item_name;
            lt_boq_tab(i).boq_est_dim1       := lt_tre_boqs_tab(i).boq_est_dim1;
            lt_boq_tab(i).boq_est_dim2       := lt_tre_boqs_tab(i).boq_est_dim2;
            lt_boq_tab(i).boq_est_dim3       := lt_tre_boqs_tab(i).boq_est_dim3;
            lt_boq_tab(i).boq_est_quantity   := lt_tre_boqs_tab(i).boq_est_quantity;
            lt_boq_tab(i).boq_est_rate       := lt_tre_boqs_tab(i).boq_est_rate;
            lt_boq_tab(i).boq_est_cost       := lt_tre_boqs_tab(i).boq_est_cost;
            lt_boq_tab(i).boq_est_labour     := lt_tre_boqs_tab(i).boq_est_labour;
            --
          END LOOP;
      END IF;
  END IF;
  /*
  ||Assign The Validated Table To The Output Table.
  */
  pio_boq_tab := lt_boq_tab;
  --
END validate_repair_boqs;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_boqs(pi_boq_tab IN boq_tab) IS
  --
  lt_boq_tab  boq_tab;
  --
BEGIN
  --
  lt_boq_tab := pi_boq_tab;
  /*
  ||Check The BOQ Id (Primary Key).
  */
  FOR i IN 1..lt_boq_tab.count LOOP
    --
    IF lt_boq_tab(i).boq_id IS NULL
     THEN
        lt_boq_tab(i).boq_id := get_next_id('boq_id_seq');
    END IF;
    --
  END LOOP;
  /*
  ||Insert The BOQs.
  */
  FORALL i IN 1 .. lt_boq_tab.COUNT
    INSERT
      INTO boq_items
    VALUES lt_boq_tab(i)
         ;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20042, 'Error Occured While Creating BOQs : '||SQLERRM);
END ins_boqs;
--
-----------------------------------------------------------------------------
--
FUNCTION get_admin_unit(pi_iit_ne_id IN nm_inv_items_all.iit_ne_id%TYPE
                       ,pi_rse_he_id IN nm_elements_all.ne_id%TYPE)
  RETURN nm_admin_units.nau_admin_unit%TYPE IS
  --
  lv_retval nm_admin_units.nau_admin_unit%TYPE;
  --
BEGIN
  IF pi_iit_ne_id IS NOT NULL
   THEN
      --
      lv_retval := nm3inv.get_inv_item_all(pi_iit_ne_id).iit_admin_unit;
      --
  ELSIF pi_rse_he_id IS NOT NULL
   THEN
      --
      lv_retval := nm3net.get_ne(pi_rse_he_id).ne_admin_unit;
      --
  END IF;
  --
  RETURN lv_retval;
  --
END get_admin_unit;
--
-----------------------------------------------------------------------------
--
FUNCTION get_balancing_sum(pi_con_id IN contracts.con_id%TYPE
                          ,pi_value  IN work_order_lines.wol_act_cost%TYPE)
  RETURN NUMBER IS
  --
  CURSOR c1(cp_con_id contracts.con_id%TYPE)
      IS
  SELECT oun_cng_disc_group
    FROM org_units
        ,contracts
   WHERE con_contr_org_id = oun_org_id
     AND con_id = cp_con_id
       ;
  --
  lv_retval     NUMBER := 0;
  lv_disc_group org_units.oun_cng_disc_group%type;
  --
BEGIN
  OPEN  c1(pi_con_id);
  FETCH c1 into lv_disc_group;
  CLOSE c1;

  IF lv_disc_group IS NOT NULL
   AND pi_value != 0
   THEN
      IF (pi_value < 0)
       THEN
          lv_retval := -maiwo.bal_sum(p_cost           => ABS(pi_value)
                                     ,p_cng_disc_group => lv_disc_group);
      ELSE
          lv_retval := maiwo.bal_sum(p_cost           => ABS(pi_value)
                                    ,p_cng_disc_group => lv_disc_group);
      END IF;
  END IF;
  --
  RETURN lv_retval;
  --
END get_balancing_sum;
--
-----------------------------------------------------------------------------
--
FUNCTION apply_balancing_sum(pi_con_id IN contracts.con_id%TYPE
                            ,pi_value  IN work_order_lines.wol_act_cost%TYPE)
  RETURN NUMBER IS
  --
  lv_retval NUMBER;
  --
BEGIN
  --
  lv_retval := pi_value + get_balancing_sum(pi_con_id => pi_con_id
                                           ,pi_value  => pi_value);
  --
  RETURN lv_retval;
  --
END apply_balancing_sum;
--
-----------------------------------------------------------------------------
--
FUNCTION within_budget(pi_bud_id IN work_order_lines.wol_bud_id%TYPE
                      ,pi_con_id IN contracts.con_id%TYPE
                      ,pi_est    IN work_order_lines.wol_est_cost%TYPE DEFAULT 0
                      ,pi_act    IN work_order_lines.wol_act_cost%TYPE DEFAULT 0
                      ,pi_wol_id IN work_order_lines.wol_id%TYPE DEFAULT NULL)
  RETURN BOOLEAN IS
  --
  lv_retval BOOLEAN;
  --
BEGIN
  /*
  ||Check That The Values Supplied Can Be Added
  ||To The Budget Without Going Over It.
  */
  IF mai_budgets.check_budget(p_bud_id        => pi_bud_id
                             ,p_bud_committed => apply_balancing_sum(pi_con_id,NVL(pi_est,0))
                             ,p_bud_actual    => apply_balancing_sum(pi_con_id,NVL(pi_act,0))
                             ,p_wol_id        => pi_wol_id)
   THEN
      /*
      ||Value Will Exceed The Budget.
      ||See If The User Has The OVER_BUDGET role.
      */
      IF mai_budgets.allow_over_budget
       THEN
          lv_retval := TRUE;
      ELSE
          lv_retval := FALSE;
      END IF;
  ELSE
      lv_retval := TRUE;
  END IF;
  --
  RETURN lv_retval;
  --
END within_budget;
--
-----------------------------------------------------------------------------
--
PROCEDURE add_to_budget(pi_wol_id in work_order_lines.wol_id%TYPE
                       ,pi_bud_id in work_order_lines.wol_bud_id%TYPE
                       ,pi_con_id in contracts.con_id%TYPE
                       ,pi_est    in work_order_lines.wol_est_cost%TYPE DEFAULT 0
                       ,pi_act    in work_order_lines.wol_act_cost%TYPE DEFAULT 0)
  IS
  --
  lv_success BOOLEAN := TRUE;
  --
BEGIN
  --
  IF NVL(pi_est,0) != 0
   THEN
      --
      lv_success := mai_budgets.update_budget_committed(p_wol_id => pi_wol_id
                                                       ,p_bud_id => pi_bud_id
                                                       ,p_bud_committed => apply_balancing_sum(pi_con_id => pi_con_id
                                                                                              ,pi_value  => pi_est));
  END IF;
  --
  IF NVL(pi_act,0) != 0
   AND lv_success
   THEN
      lv_success := mai_budgets.update_budget_actual(p_wol_id     => pi_wol_id
                                                    ,p_bud_id     => pi_bud_id
                                                    ,p_bud_actual => apply_balancing_sum(pi_con_id => pi_con_id
                                                                                        ,pi_value  => pi_act));
  END IF;
  --
  IF NOT lv_success
   THEN
      raise_application_error(-20047,'Budget Exceeded.');
  END IF;
  --
END add_to_budget;
--
-----------------------------------------------------------------------------
--This Procedure Is Intended To Emulate The Form mai3801.

PROCEDURE create_defect_work_order(pi_user_id           IN  hig_users.hus_user_id%TYPE
                                  ,pi_wo_descr          IN  work_orders.wor_descr%TYPE
                                  ,pi_scheme_type       IN  work_orders.wor_scheme_type%TYPE
                                  ,pi_con_id            IN  contracts.con_id%TYPE
                                  ,pi_interim_payment   IN  work_orders.wor_interim_payment_flag%TYPE
                                  ,pi_priority          IN  work_orders.wor_priority%TYPE
                                  ,pi_cost_centre       IN  work_orders.wor_coc_cost_centre%TYPE
                                  ,pi_road_group_id     IN  nm_elements_all.ne_id%TYPE
                                  ,pi_tma_register_flag IN  work_orders.wor_register_flag%TYPE
                                  ,pi_contact           IN  work_orders.wor_contact%TYPE
                                  ,pi_job_number        IN  work_orders.wor_job_number%TYPE
                                  ,pi_rechargeable      IN  work_orders.wor_rechargeable%TYPE
                                  ,pi_date_raised       IN  work_orders.wor_date_raised%TYPE
                                  ,pi_target_date       IN  work_orders.wor_est_complete%TYPE
                                  ,pi_defects           IN  def_rep_list_in_tab
                                  ,pi_defect_boqs       IN  boq_tab
                                  ,pi_commit            IN  VARCHAR2
                                  ,po_work_order_no     OUT work_orders.wor_works_order_no%TYPE
                                  ,po_defects_on_wo     OUT def_rep_list_on_wo_tab
                                  ,po_defects_not_on_wo OUT def_rep_list_not_on_wo_tab)
  IS
  --
  lv_work_order_no  work_orders.wor_works_order_no%TYPE;
  --
  lv_sys_flag           VARCHAR2(1);
  lv_worrefgen          hig_option_values.hov_value%TYPE := hig.get_sysopt('WORREFGEN');
  lv_gisgrptyp          hig_option_values.hov_value%TYPE := hig.get_sysopt('GISGRPTYP');
  lv_gisgrpl            hig_option_values.hov_value%TYPE := hig.get_sysopt('GISGRPL');
  lv_gisgrpd            hig_option_values.hov_value%TYPE := hig.get_sysopt('GISGRPD');
  lv_dumconcode         hig_option_values.hov_value%TYPE := NVL(hig.get_sysopt('DUMCONCODE'),'DEFAULT');
  lv_scheme_type_upd    hig_option_values.hov_value%TYPE := NVL(hig.get_user_or_sys_opt('DEFSCHTYPU'),'Y');
  lv_def_scheme_type_l  hig_option_values.hov_value%TYPE := NVL(hig.get_user_or_sys_opt('DEFSCHTYPL'),'LR');
  lv_def_scheme_type_d  hig_option_values.hov_value%TYPE := NVL(hig.get_user_or_sys_opt('DEFSCHTYPD'),'RD');
  lv_user_admin_unit    nm_admin_units_all.nau_admin_unit%TYPE;
  lv_road_group_id      nm_elements_all.ne_id%TYPE;
  lv_rse_admin_unit     nm_admin_units_all.nau_admin_unit%TYPE;
  lv_rse_sys_flag       VARCHAR2(1);
  lv_work_code          item_code_breakdowns.icb_work_code%TYPE;
  lv_scheme_type        work_orders.wor_scheme_type%TYPE;
  lv_con_admin_unit     nm_admin_units_all.nau_admin_unit%TYPE;
  lv_discount_group     org_units.oun_cng_disc_group%TYPE;
  lv_wor_admin_unit     nm_admin_units_all.nau_admin_unit%TYPE;
  lv_bud_rse_he_id      nm_elements_all.ne_id%TYPE;
  lv_icb_id             item_code_breakdowns.icb_id%TYPE;
  lv_date_raised        work_orders.wor_date_raised%TYPE;
  --
  lv_wor_est_cost          work_orders.wor_est_cost%TYPE := NULL;
  lv_wor_est_labour        work_orders.wor_est_labour%TYPE := 0;
  lv_wor_est_balancing_sum work_orders.wor_est_balancing_sum%TYPE := 0;
  --
  lv_wol_not_done    hig_status_codes.hsc_status_code%TYPE;
  lv_wol_draft       hig_status_codes.hsc_status_code%TYPE;
  lv_def_instructed  hig_status_codes.hsc_status_code%TYPE;
  lv_def_selected    hig_status_codes.hsc_status_code%TYPE;
  lv_def_available   hig_status_codes.hsc_status_code%TYPE;
  --
  lv_wol_null_boq_exists BOOLEAN := FALSE;
  lv_wor_null_boq_exists BOOLEAN := FALSE;
  --
  TYPE wol_rec IS RECORD(wol_id              work_order_lines.wol_id%TYPE
                        ,wol_works_order_no  work_order_lines.wol_works_order_no%TYPE
                        ,wol_rse_he_id       work_order_lines.wol_rse_he_id%TYPE
                        ,wol_siss_id         work_order_lines.wol_siss_id%TYPE
                        ,wol_icb_work_code   work_order_lines.wol_icb_work_code%TYPE
                        ,wol_act_area_code   work_order_lines.wol_act_area_code%TYPE
                        ,wol_def_defect_id   work_order_lines.wol_def_defect_id%TYPE
                        ,wol_rep_action_cat  work_order_lines.wol_rep_action_cat%TYPE
                        ,wol_flag            work_order_lines.wol_flag%TYPE
                        ,wol_status_code     work_order_lines.wol_status_code%TYPE
                        ,wol_wor_flag        work_order_lines.wol_wor_flag%TYPE
                        ,wol_date_created    work_order_lines.wol_date_created%TYPE
                        ,wol_bud_id          work_order_lines.wol_bud_id%TYPE
                        ,wol_est_cost        work_order_lines.wol_est_cost%TYPE
                        ,wol_est_labour      work_order_lines.wol_est_labour%TYPE);
  TYPE wol_tab IS TABLE OF wol_rec INDEX BY BINARY_INTEGER;
  lt_wol wol_tab;
  --
  lt_boq boq_tab;
  lv_boq_tab_ind PLS_INTEGER := 1;
  --
  TYPE selected_repairs_rec IS RECORD(rep_rse_he_id          repairs.rep_rse_he_id%TYPE
                                     ,def_siss_id            defects.def_siss_id%TYPE
                                     ,def_priority           defects.def_priority%TYPE
                                     ,rep_atv_acty_area_code repairs.rep_atv_acty_area_code%TYPE
                                     ,rep_def_defect_id      repairs.rep_def_defect_id%TYPE
                                     ,rep_action_cat         repairs.rep_action_cat%TYPE
                                     ,bud_id                 budgets.bud_id%TYPE
                                     ,work_code              item_code_breakdowns.icb_work_code%TYPE);
  TYPE selected_repairs_tab IS TABLE OF selected_repairs_rec INDEX BY BINARY_INTEGER;
  lt_selected_repairs selected_repairs_tab;
  --
  TYPE repair_boqs_rec IS RECORD(boq_id            boq_items.boq_id%TYPE
                                ,boq_sta_item_code boq_items.boq_sta_item_code%TYPE
                                ,boq_est_quantity  boq_items.boq_est_quantity%TYPE
                                ,boq_est_labour    boq_items.boq_est_labour%TYPE
                                ,sta_rogue_flag    standard_items.sta_rogue_flag%TYPE);
  TYPE repair_boqs_tab IS TABLE OF repair_boqs_rec INDEX BY BINARY_INTEGER;
  lt_repair_boqs repair_boqs_tab;
  --
  PROCEDURE init_defaults
    IS
    --
    PROCEDURE set_date_raised
      IS
    BEGIN
      IF pi_date_raised IS NOT NULL
       THEN
          IF pi_date_raised > SYSDATE
           THEN
              raise_application_error(-20084,'Date Raised Must Be Less Than Or Equal To Todays Date.');
          ELSE
              lv_date_raised := pi_date_raised;
          END IF;
      ELSE
          lv_date_raised := SYSDATE;
      END IF;
    END set_date_raised;
    --
    PROCEDURE ins_defect_list_temp
      IS
      --
      lv_matching_defects NUMBER;
      --
    BEGIN
      /*
      ||If pi_commit wasn't 'Y' the last time
      ||the procedure was called there may still
      ||be records in the temp table.
      */
      DELETE
        FROM defect_list_temp;
      /*
      ||Insert the supplied Defect Ids
      ||into the temp table.
      */
      nm_debug.debug('inserting '||pi_defects.count||'records into defect_list_temp');
      FORALL i IN 1..pi_defects.count
      INSERT
        INTO defect_list_temp
      VALUES pi_defects(i)
           ;
      /*
      ||Make sure all supplied Defect Ids exist.
      */
      SELECT count(*)
        INTO lv_matching_defects
        FROM defects
            ,repairs
       WHERE rep_def_defect_id = def_defect_id
         AND (def_defect_id,rep_action_cat) IN(SELECT dlt_defect_id
                                                     ,dlt_rep_action_cat
                                                 FROM defect_list_temp)
           ;
      --
      IF lv_matching_defects != pi_defects.count
       THEN
          raise_application_error(-20072,'Supplied List Of Defects Contains Invalid Ids');
      END IF;
      --
    EXCEPTION
      WHEN dup_val_on_index
       THEN
          raise_application_error(-20071,'Supplied List Of Defects Contains Duplicates');
      WHEN others
       THEN
          RAISE;
    END ins_defect_list_temp;
    --
    PROCEDURE validate_user
      IS
    BEGIN
      SELECT hus_admin_unit
        INTO lv_user_admin_unit
        FROM hig_users
       WHERE hus_user_id = pi_user_id
           ;
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
      WHEN others
       THEN
          RAISE;
    END validate_user;
    --
    PROCEDURE validate_contract
      IS
      --
      lv_con_code contracts.con_code%TYPE;
       --
    BEGIN
      nm_debug.debug('con_id = '||pi_con_id);
      nm_debug.debug('Date Raised = '||TO_CHAR(lv_date_raised));
      SELECT con_code
            ,con_admin_org_id
            ,oun_cng_disc_group
        INTO lv_con_code
            ,lv_con_admin_unit
            ,lv_discount_group
        FROM org_units
            ,contracts
       WHERE con_id = pi_con_id
         AND TRUNC(lv_date_raised) BETWEEN NVL(con_start_date, TRUNC(lv_date_raised))
                                       AND NVL(con_end_date  , TRUNC(lv_date_raised))
         AND ((con_admin_org_id IN(SELECT hag_child_admin_unit
                                     FROM hig_admin_groups
                                    WHERE hag_parent_admin_unit = lv_user_admin_unit))
              OR con_code = lv_dumconcode)
         AND con_contr_org_id = oun_org_id
           ;
      --
      IF lv_con_code = lv_dumconcode
       THEN
          lv_wor_admin_unit := lv_con_admin_unit;
      ELSE
          lv_wor_admin_unit := lv_user_admin_unit;
      END IF;
      --
    EXCEPTION
      WHEN no_data_found
       THEN
          nm_debug.debug('validate_contract Raised 20063');
          raise_application_error(-20063,'Invalid Contract Id Supplied.');
      WHEN others
       THEN
          nm_debug.debug('validate_contract Raised Others');
          RAISE;
    END validate_contract;
    --
    PROCEDURE validate_interim_flag
      IS
    BEGIN
      --
      IF pi_interim_payment IS NOT NULL
       AND pi_interim_payment NOT IN ('Y', 'N')
       THEN
          raise_application_error(-20081,'Invalid Interim Flag Supplied.');
      END IF;
      --
    END validate_interim_flag;
    --
    PROCEDURE validate_rechargeable
      IS
    BEGIN
      --
      IF pi_rechargeable IS NOT NULL
       AND pi_rechargeable NOT IN ('Y', 'N')
       THEN
          raise_application_error(-20089,'Invalid Rechargeable Flag Supplied.');
      END IF;
      --
    END validate_rechargeable;
    --
    PROCEDURE validate_tma_register_flag(pi_flag IN VARCHAR2)
      IS
    BEGIN
      --
      IF pi_flag IS NOT NULL
       AND pi_flag NOT IN ('Y', 'N')
       THEN
          raise_application_error(-20088,'Invalid TMA Register Flag Supplied.');
      END IF;
      --
    END validate_tma_register_flag;
    --
    PROCEDURE validate_wo_priority
      IS
      --
      lv_dummy NUMBER;
      --
    BEGIN
      --
      IF pi_priority IS NOT NULL
       THEN
          SELECT 1
            INTO lv_dummy
            FROM hig_codes
           WHERE hco_domain = 'WOR_PRIORITY'
             AND hco_code   = pi_priority
             AND TRUNC(lv_date_raised) BETWEEN NVL(hco_start_date,TRUNC(lv_date_raised))
                                           AND NVL(hco_end_date  ,TRUNC(lv_date_raised))
               ;
      END IF;
      --
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20082,'Invalid Work Order Priority Supplied.');
      WHEN others
       THEN
          RAISE;
    END validate_wo_priority;
    --
    PROCEDURE validate_cost_centre
      IS
      --
      lv_dummy NUMBER;
      --
    BEGIN
      --
      IF pi_cost_centre IS NOT NULL
       THEN
          SELECT 1
            INTO lv_dummy
            FROM cost_centres
                ,hig_admin_groups
           WHERE hag_parent_admin_unit = lv_user_admin_unit
             AND hag_child_admin_unit  = coc_org_id
             AND coc_cost_centre       = pi_cost_centre
             AND TRUNC(lv_date_raised) BETWEEN NVL(coc_start_date,TRUNC(lv_date_raised))
                                           AND NVL(coc_end_date  ,TRUNC(lv_date_raised))
               ;
      END IF;
      --
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20080,'Invalid Cost Centre Supplied.');
      WHEN others
       THEN
          RAISE;
    END validate_cost_centre;
    --
    PROCEDURE validate_target_complete
      IS
      --
      lv_dummy NUMBER;
      --
    BEGIN
      --
      IF pi_target_date IS NOT NULL
       AND pi_target_date < lv_date_raised
       THEN
          raise_application_error(-20086,'Target Complete Date Should Not Be Before The Date Raised.');
      END IF;
      --
    END validate_target_complete;
    --
    PROCEDURE validate_road_group(pi_group_id IN nm_elements_all.ne_id%TYPE)
      IS
    BEGIN
      --
      SELECT rse_he_id
            ,rse_admin_unit
            ,rse_sys_flag
        INTO lv_road_group_id
            ,lv_rse_admin_unit
            ,lv_sys_flag
        FROM road_groups
       WHERE rse_he_id = pi_group_id
           ;
      --
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20087,'Invalid Road Group Id Supplied.');
      WHEN others
       THEN
          RAISE;
    END validate_road_group;
    --
    PROCEDURE set_sys_flag(pi_defect_id IN defects.def_defect_id%TYPE
                          ,pi_rse_he_id IN nm_elements_all.ne_id%TYPE)
      IS
      --
      lv_def_he_id nm_elements_all.ne_id%TYPE;
      --
    BEGIN
      --
      IF pi_rse_he_id IS NOT NULL
       THEN
          validate_road_group(pi_rse_he_id);
      ELSE
          SELECT def_ity_sys_flag
                ,def_rse_he_id
            INTO lv_sys_flag
                ,lv_def_he_id
            FROM defects
           WHERE def_defect_id = pi_defect_id
               ;
          --
          BEGIN
            IF lv_sys_flag IS NULL
             THEN
                SELECT rse_sys_flag
                  INTO lv_sys_flag
                  FROM road_sections
                 WHERE rse_he_id = lv_def_he_id
                     ;
            END IF;
          EXCEPTION
           WHEN others
            THEN
               null;
          END;
      END IF;
      --
      IF lv_sys_flag IS NULL
       THEN
          raise_application_error(-20074,'Unable To Obtain sys_flag.');
      END IF;
      --
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20065,'Invalid Defect Id Supplied.');
      WHEN others
       THEN
          RAISE;
    END set_sys_flag;
    --
    PROCEDURE set_road_group(pi_group_name IN VARCHAR2)
      IS
    BEGIN
      --
      SELECT rse_he_id
            ,rse_admin_unit
        INTO lv_road_group_id
            ,lv_rse_admin_unit
        FROM road_groups
       WHERE rse_unique = pi_group_name
           ;
      --
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20060,'Cannot Set Road Group. Please Check Product Options GISGRPTYP, GISGRPL and GISGRPD');
      WHEN others
       THEN
          RAISE;
    END set_road_group;
    --
    PROCEDURE get_wol_not_done
      IS
    BEGIN
      SELECT hsc_status_code
        INTO lv_wol_not_done
        FROM hig_status_codes
       WHERE hsc_domain_code = 'WORK_ORDER_LINES'
         AND hsc_allow_feature5 = 'Y'
         AND TRUNC(lv_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(lv_date_raised))
                                       AND NVL(hsc_end_date  ,TRUNC(lv_date_raised))
           ;
    EXCEPTION
      WHEN too_many_rows
       THEN
          raise_application_error(-20059,'Too Many Values Defined For Work Order Line NOT_DONE Status');
      WHEN no_data_found
       THEN
          raise_application_error(-20055,'Cannot Obtain Value For Work Order Line NOT_DONE Status');
      WHEN others
       THEN
          RAISE;
    END get_wol_not_done;
    --
    PROCEDURE get_wol_draft
      IS
    BEGIN
      SELECT hsc_status_code
        INTO lv_wol_draft
        FROM hig_status_codes
       WHERE hsc_domain_code = 'WORK_ORDER_LINES'
         AND hsc_allow_feature1 = 'Y'
         AND hsc_allow_feature10 = 'Y'
         AND TRUNC(lv_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(lv_date_raised))
                                       AND NVL(hsc_end_date  ,TRUNC(lv_date_raised))
           ;
    EXCEPTION
      WHEN too_many_rows
       THEN
          raise_application_error(-20058,'Too Many Values Defined For Work Order Line DRAFT Status');
      WHEN no_data_found
       THEN
          raise_application_error(-20054,'Cannot Obtain Value For Work Order Line DRAFT Status');
      WHEN others
       THEN
          RAISE;
    END get_wol_draft;
    --
    PROCEDURE get_def_instructed
      IS
    BEGIN
      SELECT hsc_status_code
        INTO lv_def_instructed
        FROM hig_status_codes
       WHERE hsc_domain_code = 'DEFECTS'
         AND hsc_allow_feature3 = 'Y'
         AND hsc_allow_feature10 = 'N'
         AND TRUNC(lv_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(lv_date_raised))
                                       AND NVL(hsc_end_date  ,TRUNC(lv_date_raised))
           ;
    EXCEPTION
      WHEN too_many_rows
       THEN
          raise_application_error(-20057,'Too Many Values Defined For Defect INSTRUCTED Status');
      WHEN no_data_found
       THEN
          raise_application_error(-20053,'Cannot Obtain Value For Defect INSTRUCTED Status');
      WHEN others
       THEN
          RAISE;
    END get_def_instructed;
    --
    PROCEDURE get_def_selected
      IS
    BEGIN
      SELECT hsc_status_code
        INTO lv_def_selected
        FROM hig_status_codes
       WHERE hsc_domain_code = 'DEFECTS'
         AND hsc_allow_feature3 = 'Y'
         AND hsc_allow_feature10 = 'Y'
         AND TRUNC(lv_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(lv_date_raised))
                                       AND NVL(hsc_end_date  ,TRUNC(lv_date_raised))
           ;
    EXCEPTION
      WHEN too_many_rows
       THEN
          raise_application_error(-20057,'Too Many Values Defined For Defect SELECTED Status');
      WHEN no_data_found
       THEN
          raise_application_error(-20053,'Cannot Obtain Value For Defect SELECTED Status');
      WHEN others
       THEN
          RAISE;
    END get_def_selected;
    --
    PROCEDURE get_def_available
      IS
    BEGIN
      SELECT hsc_status_code
        INTO lv_def_available
        FROM hig_status_codes
       WHERE hsc_domain_code = 'DEFECTS'
         AND hsc_allow_feature2 = 'Y'
         AND TRUNC(lv_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(lv_date_raised))
                                       AND NVL(hsc_end_date  ,TRUNC(lv_date_raised))
           ;
    EXCEPTION
      WHEN too_many_rows
       THEN
          raise_application_error(-20056,'Too Many Values Defined For Defect AVAILABLE Status');
      WHEN no_data_found
       THEN
          raise_application_error(-20052,'Cannot Obtain Value For Defect AVAILABLE Status');
      WHEN others
       THEN
          RAISE;
    END get_def_available;
    --
    PROCEDURE set_scheme_type
      IS
      --
      PROCEDURE validate_scheme_type
        IS
      BEGIN
        SELECT icb_work_code
          INTO lv_work_code
          FROM item_code_breakdowns
         WHERE icb_type_of_scheme = lv_scheme_type
           AND icb_dtp_flag       = lv_sys_flag
             ;
      EXCEPTION
        WHEN no_data_found
         THEN
            raise_application_error(-20066,'Invalid Scheme Type');
        WHEN too_many_rows
         THEN
            lv_work_code := NULL;
        WHEN others
         THEN
            RAISE;
      END validate_scheme_type;
      --
    BEGIN
      /*
      ||Determine The Scheme Type To Use.
      */
      IF lv_scheme_type_upd = 'Y'
       AND pi_scheme_type IS NOT NULL
       THEN
          lv_scheme_type := pi_scheme_type;
      ELSE
          IF lv_sys_flag = 'L'
           THEN
              lv_scheme_type := lv_def_scheme_type_l;
          ELSE
              lv_scheme_type := lv_def_scheme_type_d;
          END IF;
      END IF;
      /*
      ||Now Validate The Scheme Type
      ||And Set The Work Code.
      */
      validate_scheme_type;
      --
    END set_scheme_type;
    --
  BEGIN
    /*
    ||Validate/Default the Date Raised.
    */
    set_date_raised;
    /*
    ||If No Defects Have Been Specified Raise An Error.
    */
    IF pi_defects.count = 0
     THEN
        raise_application_error(-20070,'Please Specify At Least One Defect For The Work Order.');
    END IF;
    /*
    ||Insert The Defect Ids Into Temp Table
    ||And Validate Against The Defects Table.
    */
    nm_debug.debug('ins_defect_list_temp');
    ins_defect_list_temp;
    /*
    ||Get The Sys Flag For The Work Order
    ||And Validate The Supplied Road Group Id.
    */
    nm_debug.debug('set_sys_flag');
    set_sys_flag(pi_defect_id => pi_defects(1).dlt_defect_id
                ,pi_rse_he_id => pi_road_group_id);
    /*
    ||Default The Road Group For The Work Order
    ||If Not Suppled.
    */
    nm_debug.debug('set_road_group');
    IF lv_road_group_id IS NULL
     THEN
        IF lv_sys_flag = 'L'
         THEN
            set_road_group(lv_gisgrpl);
        ELSE
            set_road_group(lv_gisgrpd);
        END IF;
    END IF;
    /*
    ||Get The Users Admin Unit.
    */
    nm_debug.debug('validate_user');
    validate_user;
    /*
    ||Get The Contracts Admin Unit.
    */
    nm_debug.debug('validate_contract');
    validate_contract;
    /*
    ||Validate/Default Scheme Type.
    */
    nm_debug.debug('set_scheme_type');
    set_scheme_type;
    /*
    ||Validate The Interim Flag Supplied.
    */
    validate_interim_flag;
    /*
    ||Validate The Work Order Priority Supplied.
    */
    validate_wo_priority;
    /*
    ||Validate The Cost Centre Supplied.
    */
    validate_cost_centre;
    /*
    ||Validate The WO TMA Register Flag.
    */
    validate_tma_register_flag(pi_tma_register_flag);
    /*
    ||Validate The Rechargeable Flag.
    */
    validate_rechargeable;
    /*
    ||Validate The Target Complete Date Supplied.
    */
    validate_target_complete;
    /*
    ||Get Status Codes.
    */
    nm_debug.debug('get_wol_not_done');
    get_wol_not_done;
    nm_debug.debug('get_wol_draft');
    get_wol_draft;
    nm_debug.debug('get_def_instructed');
    get_def_instructed;
    nm_debug.debug('get_def_selected');
    get_def_selected;
    nm_debug.debug('get_def_available');
    get_def_available;
    --
  END init_defaults;
  --
  FUNCTION validate_budget(pi_budget_id   IN budgets.bud_id%TYPE
                          ,pi_defect_id   IN defects.def_defect_id%TYPE)
    RETURN BOOLEAN IS
    --
    lv_retval BOOLEAN := FALSE;
    --
  BEGIN
    /*
    ||Init Variables.
    */
    lv_bud_rse_he_id := NULL;
    lv_icb_id        := NULL;
    lv_work_code     := NULL;
    --
    SELECT bud_rse_he_id
          ,icb_id
          ,icb_work_code
      INTO lv_bud_rse_he_id
          ,lv_icb_id
          ,lv_work_code
      FROM item_code_breakdowns
          ,budgets
          ,financial_years
     WHERE TRUNC(fyr_end_date) >= TRUNC(lv_date_raised)
       AND fyr_id = bud_fyr_id
       AND bud_id = pi_budget_id
       AND bud_icb_item_code = icb_item_code
       AND bud_icb_sub_item_code = icb_sub_item_code
       AND bud_icb_sub_sub_item_code = icb_sub_sub_item_code
       AND bud_sys_flag = icb_dtp_flag
       AND icb_type_of_scheme = lv_scheme_type
       AND EXISTS(SELECT 1
                    FROM defects
                   WHERE def_defect_id = pi_defect_id
                     AND (def_rse_he_id IN(SELECT nm_ne_id_of
                                             FROM nm_members
                                            WHERE nm_type = 'G'
                                          CONNECT BY
                                            PRIOR nm_ne_id_of = nm_ne_id_in
                                            START
                                             WITH nm_ne_id_in = bud_rse_he_id)
                          OR def_rse_he_id = NVL(bud_rse_he_id,def_rse_he_id)))
         ;
    --
    RETURN TRUE;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        RETURN FALSE;
    WHEN others
     THEN
        RAISE;
  END validate_budget;
  --
  PROCEDURE validate_and_replace_boqs(pi_defect_id      IN defects.def_defect_id%TYPE
                                     ,pi_rep_action_cat IN repairs.rep_action_cat%TYPE
                                     ,pi_boqs_tab       IN boq_tab)
    IS
    --
    lv_dummy boq_items.boq_id%TYPE;
    --
    lt_boqs boq_tab;
    --
  BEGIN
    /*
    ||Build A Table Of Supplied BOQs Related To This Defect/Repair For Validation.
    */
    FOR i IN 1..pi_boqs_tab.count LOOP
      --
      IF pi_boqs_tab(i).boq_rep_action_cat IS NULL
       OR pi_boqs_tab(i).boq_defect_id IS NULL
       THEN
          raise_application_error(-20090,'No BOQ Defect Id or Repair Action Category Specified.');
      END IF;
      --
      IF pi_boqs_tab(i).boq_defect_id = pi_defect_id
       AND pi_boqs_tab(i).boq_rep_action_cat = pi_rep_action_cat
       THEN
          lt_boqs(lt_boqs.count+1) := pi_boqs_tab (i);
      END IF;
      --
    END LOOP;
    --
    IF lt_boqs.count > 0
     THEN
        /*
        ||Make Sure The BOQs Specified With A BOQ_ID
        ||Belong To The Specified Defect/Repair.
        */
        FOR i IN 1..lt_boqs.count LOOP
          --
          IF lt_boqs(i).boq_id IS NOT NULL
           THEN
              --
              BEGIN
                SELECT boq_id
                  INTO lv_dummy
                  FROM boq_items
                 WHERE boq_id = lt_boqs(i).boq_id
                   AND boq_defect_id = pi_defect_id
                   AND boq_rep_action_cat = pi_rep_action_cat
                     ;
              EXCEPTION
                WHEN no_data_found
                 THEN
                    raise_application_error(-20091,'BOQ_ID ['||TO_CHAR(lt_boqs(i).boq_id)
                                                 ||'] Is Not A Child Of The Specified Parent - Defect ['
                                                 ||TO_CHAR(pi_defect_id)||'] Repair Type ['||pi_rep_action_cat||'].');
                WHEN others
                 THEN
                    RAISE;
              END;
              --
          END IF;
          --
        END LOOP;
        /*
        ||Validate And Build The New BOQs.
        */
        validate_repair_boqs(pi_def_defect_id      => pi_defect_id
                            ,pi_rep_action_cat     => pi_rep_action_cat
                            ,pi_rep_created_date   => TRUNC(SYSDATE)
                            ,pi_admin_unit         => NULL
                            ,pi_rep_tre_treat_code => NULL
                            ,pi_atv_acty_area_code => NULL
                            ,pi_def_defect_code    => NULL
                            ,pi_sys_flag           => NULL
                            ,pio_boq_tab           => lt_boqs);
        /*
        ||Remove The Old BOQs.
        */
        DELETE boq_items
         WHERE boq_defect_id = pi_defect_id
           AND boq_rep_action_cat = pi_rep_action_cat
             ;
        /*
        ||Insert The New BOQs.
        */
        ins_boqs(pi_boq_tab => lt_boqs);
        --
    END IF;
    --
  END validate_and_replace_boqs;
  --
  PROCEDURE select_defects
    IS
    --
    lt_defect_repairs     mai_wo_api.def_rep_list_in_tab;
    lr_selected_repair    selected_repairs_rec;
    lt_defect_repair_boqs boq_tab;
    --
    PROCEDURE check_defect(pi_budget_id   IN budgets.bud_id%TYPE
                          ,pi_defect_id   IN defects.def_defect_id%TYPE
                          ,pi_repair_type IN repairs.rep_action_cat%TYPE
                          ,pi_work_code   IN item_code_breakdowns.icb_work_code%TYPE)
      IS
      --
      lv_reason VARCHAR2(500);
      --
    BEGIN
      /*
      ||Check The Defect/Repair Against The Selection Criteria.
      */
      SELECT CASE WHEN def_status_code NOT IN(lv_def_available,lv_def_selected,lv_def_instructed)
                    OR def_date_compl IS NOT NULL
                    OR rep_date_completed IS NOT NULL
                   THEN 'Defect/Repair Is Already Complete.'
                  WHEN NVL(rep_superseded_flag,'N') = 'Y'
                   THEN 'Repair Has Been Superseded.'
                  WHEN rep_action_cat NOT IN('P','T')
                   THEN 'Invalid Repair Type.'
                  WHEN def_notify_org_id IS NOT NULL
                   AND def_rechar_org_id IS NULL
                   THEN 'Notifiable Organisation Specifed On Defect But No Rechargeable Organisation Specified.'
                  WHEN def_rse_he_id != rep_rse_he_id
                   THEN 'Repair And Defect Are On Different Sections.'
                  WHEN EXISTS(SELECT 1
                                FROM work_order_lines
                               WHERE wol_def_defect_id  = rep_def_defect_id
                                 AND wol_rep_action_cat = rep_action_cat
                                 AND wol_status_code   != lv_wol_not_done)
                   THEN 'Repair Is Already On A Work Order.'
                  WHEN NOT EXISTS(SELECT 1
                                    FROM ihms_conversions
                                   WHERE ihc_atv_acty_area_code = rep_atv_acty_area_code
                                     AND ihc_atv_acty_area_code = def_atv_acty_area_code
                                     AND ihc_icb_id = lv_icb_id)
                   THEN 'Defect Activity Code Is Invalid For The Budget Specified.'
                  WHEN NOT EXISTS(SELECT 1
                                    FROM hig_admin_groups
                                        ,road_sections
                                   WHERE hag_parent_admin_unit = lv_con_admin_unit
                                     AND hag_child_admin_unit  = rse_admin_unit
                                     AND rse_he_id             = def_rse_he_id)
                   THEN 'Defect Is On A Section Outside Of The Admin Unit Of The Specified Contract.'
                  WHEN def_rse_he_id NOT IN((SELECT nm_ne_id_of
                                               FROM nm_members
                                              WHERE nm_type = 'G'
                                            CONNECT BY
                                              PRIOR nm_ne_id_of = nm_ne_id_in
                                                AND nm_end_date IS NULL
                                              START
                                               WITH nm_ne_id_in = lv_road_group_id
                                              UNION
                                             SELECT ne_id
                                               FROM nm_elements
                                              WHERE ne_id = lv_road_group_id)
                                          INTERSECT
                                             SELECT nm_ne_id_of
                                               FROM nm_members
                                              WHERE nm_type = 'G'
                                            CONNECT BY
                                              PRIOR nm_ne_id_of = nm_ne_id_in
                                                AND nm_end_date IS NULL
                                              START
                                               WITH nm_ne_id_in = NVL(lv_bud_rse_he_id,lv_road_group_id))
                   THEN 'Defect Is On A Section That Is Not A Member Of The Specified Work Order Road Group.'
                  WHEN lv_sys_flag != 'L'
                   AND NOT EXISTS(SELECT 1
                                    FROM road_segments_all
                                        ,item_code_breakdowns
                                   WHERE icb_id = lv_icb_id
                                     AND DECODE(icb_rse_road_environment,null,rse_road_environment
                                                                        , 'R',DECODE(rse_road_environment,'S','S'
                                                                                                             ,'R')
                                                                        , 'S',DECODE(rse_road_environment,'R','R'
                                                                                                             ,'S')
                                                                             ,icb_rse_road_environment)
                                          = rse_road_environment
                                     AND rse_he_id = def_rse_he_id)
                   THEN 'Defect Is On A Section With An Invalid Environment Type For The Budget Specified.'
                  ELSE NULL
             END reason
        INTO lv_reason
        FROM repairs
            ,defects
       WHERE def_defect_id = pi_defect_id
         AND def_defect_id = rep_def_defect_id
         AND rep_action_cat = pi_repair_type
           ;
      --
      IF lv_reason IS NULL
       THEN
          /*
          ||The Repair Has Passed The Checks So Lock The Defect/Repair
          ||Records And Add It To The List To Go On The Work Order.
          */
          SELECT rep_rse_he_id
                ,def_siss_id
                ,def_priority
                ,rep_atv_acty_area_code
                ,rep_def_defect_id
                ,rep_action_cat
                ,pi_budget_id
                ,pi_work_code
            INTO lr_selected_repair
            FROM repairs
                ,defects
           WHERE def_defect_id  = pi_defect_id
             AND def_defect_id  = rep_def_defect_id
             AND rep_action_cat = pi_repair_type
             FOR UPDATE
              OF def_status_code
                 NOWAIT
               ;
          --
          lt_selected_repairs(lt_selected_repairs.count+1) := lr_selected_repair;
          po_defects_on_wo(po_defects_on_wo.count+1).defect_id    := pi_defect_id;
          po_defects_on_wo(po_defects_on_wo.count).rep_action_cat := pi_repair_type;
          --
      ELSE
          /*
          ||Repair Failed Checks So Add It To The List
          ||Of Defect/Repairs Not On The Work Order.
          */
          po_defects_not_on_wo(po_defects_not_on_wo.count+1).defect_id    := pi_defect_id;
          po_defects_not_on_wo(po_defects_not_on_wo.count).rep_action_cat := pi_repair_type;
          po_defects_not_on_wo(po_defects_not_on_wo.count).reason         := lv_reason;
          nm_debug.debug('repair not on WO : '||pi_defect_id||' : '||pi_repair_type||' : '||lv_reason);
      END IF;
    END check_defect;
    --
  BEGIN
    /*
    || Issue a savepoint, to avoid rolling back
    || changes in calling module
    */
    SAVEPOINT create_defect_wo;
    --
    nm_debug.debug('Fetching Defects');
    /*
    ||Get The Supplied Defects From
    ||The Temp Table.
    */
    SELECT *
      BULK COLLECT
      INTO lt_defect_repairs
      FROM defect_list_temp
         ;
    --
    nm_debug.debug(lt_defect_repairs.count||' records fetched');
    FOR i IN 1..lt_defect_repairs.count LOOP
      /*
      ||Validate The Budget.
      */
      IF validate_budget(pi_budget_id   => lt_defect_repairs(i).dlt_budget_id
                        ,pi_defect_id   => lt_defect_repairs(i).dlt_defect_id)
       THEN
          /*
          ||Budget Is Valid So Check That The
          ||Defect Is Valid For The Work Order.
          */
          check_defect(pi_budget_id   => lt_defect_repairs(i).dlt_budget_id
                      ,pi_defect_id   => lt_defect_repairs(i).dlt_defect_id
                      ,pi_repair_type => lt_defect_repairs(i).dlt_rep_action_cat
                      ,pi_work_code   => lv_work_code);
      ELSE
          /*
          ||Repair Failed Budget Check So Add It
          ||To The List Of Defect/Repairs Not On
          ||The Work Order.
          */
          po_defects_not_on_wo(po_defects_not_on_wo.count+1).defect_id    := lt_defect_repairs(i).dlt_defect_id;
          po_defects_not_on_wo(po_defects_not_on_wo.count).rep_action_cat := lt_defect_repairs(i).dlt_rep_action_cat;
          po_defects_not_on_wo(po_defects_not_on_wo.count).reason         := 'Invalid Budget Supplied.';
      END IF;
      --
    END LOOP;
nm_debug.debug('generate WOLs');
    /*
    ||Generate The Work Order Lines For The Selected Defects.
    */
    FOR i IN 1..lt_selected_repairs.count LOOP
      nm_debug.debug('Setting WOL Fields');
      /*
      ||Set The Work Order Line Columns.
      */
      lt_wol(i).wol_works_order_no := lv_work_order_no;
      lt_wol(i).wol_rse_he_id      := lt_selected_repairs(i).rep_rse_he_id;
      lt_wol(i).wol_siss_id        := lt_selected_repairs(i).def_siss_id;
      lt_wol(i).wol_icb_work_code  := lt_selected_repairs(i).work_code;
      lt_wol(i).wol_act_area_code  := lt_selected_repairs(i).rep_atv_acty_area_code;
      lt_wol(i).wol_def_defect_id  := lt_selected_repairs(i).rep_def_defect_id;
      lt_wol(i).wol_rep_action_cat := lt_selected_repairs(i).rep_action_cat;
      lt_wol(i).wol_flag           := 'D';
      lt_wol(i).wol_status_code    := lv_wol_draft;
      lt_wol(i).wol_wor_flag       := 'D';
      lt_wol(i).wol_date_created   := SYSDATE;
      lt_wol(i).wol_bud_id         := lt_selected_repairs(i).bud_id;
      lt_wol(i).wol_est_cost       := NULL;
      lt_wol(i).wol_est_labour     := 0;
      /*
      ||Reset The Null BOQ Cost WOL Level Flag.
      */
      lv_wol_null_boq_exists := FALSE;
      --
      /*
      ||Process BOQs.
      */
      /*
      ||Validate Any Supplied BOQs And Use Them To Replace The Existing Ones.
      */
      IF pi_defect_boqs.count > 0
       THEN
         validate_and_replace_boqs(pi_defect_id      => lt_selected_repairs(i).rep_def_defect_id
                                  ,pi_rep_action_cat => lt_selected_repairs(i).rep_action_cat
                                  ,pi_boqs_tab       => pi_defect_boqs);
      END IF;
      /*
      ||Get Any Boq's For The Repair.
      */
      nm_debug.debug('Fetching BOQs');
      SELECT boq_id
            ,boq_sta_item_code
            ,boq_est_quantity
            ,boq_est_labour
            ,sta_rogue_flag
        BULK COLLECT
        INTO lt_repair_boqs
        FROM boq_items
            ,standard_items
       WHERE sta_item_code      = boq_sta_item_code
         AND boq_rep_action_cat = lt_selected_repairs(i).rep_action_cat
         AND boq_defect_id      = lt_selected_repairs(i).rep_def_defect_id
         FOR UPDATE
          OF boq_est_rate
             NOWAIT
             ;
      --
      FOR j IN 1..lt_repair_boqs.count LOOP
        /*
        ||Set The Identifiers For The BOQ Table.
        */
        nm_debug.debug('Setting BOQ Fields');
        lt_boq(lv_boq_tab_ind).boq_id             := lt_repair_boqs(j).boq_id;
        lt_boq(lv_boq_tab_ind).boq_rep_action_cat := lt_selected_repairs(i).rep_action_cat;
        lt_boq(lv_boq_tab_ind).boq_defect_id      := lt_selected_repairs(i).rep_def_defect_id;
        /*
        ||Update Work Order and Work Order Line Labour Units.
        */
        nm_debug.debug('Calc Labour Units');
        IF lt_repair_boqs(j).boq_est_labour IS NOT NULL
         THEN
            lt_wol(i).wol_est_labour := lt_wol(i).wol_est_labour + lt_repair_boqs(j).boq_est_labour;
            lv_wor_est_labour := lv_wor_est_labour + lt_repair_boqs(j).boq_est_labour;
        END IF;
        /*
        ||Set The Rate For The BOQ From The Contract Item.
        */
        nm_debug.debug('Set BOQ Rate');
        IF lt_repair_boqs(j).sta_rogue_flag != 'Y'
         OR lt_boq(lv_boq_tab_ind).boq_est_rate IS NULL
         THEN
            lt_boq(lv_boq_tab_ind).boq_est_rate := maiwo.reprice_item(p_item_code => lt_repair_boqs(j).boq_sta_item_code
                                                                     ,p_con_id    => pi_con_id
                                                                     ,p_rse_he_id => lt_selected_repairs(i).rep_rse_he_id
                                                                     ,p_priority  => lt_selected_repairs(i).def_priority);
        END IF;
        /*
        ||Calculate The Estimated Cost.
        */
        nm_debug.debug('Calc Costs');
        IF lt_boq(lv_boq_tab_ind).boq_est_rate IS NOT NULL
         THEN
            BEGIN
              /*
              ||Update The BOQ Estimated Cost.
              */
              lt_boq(lv_boq_tab_ind).boq_est_cost := ROUND(lt_boq(lv_boq_tab_ind).boq_est_rate*lt_repair_boqs(j).boq_est_quantity,2);
              nm_debug.debug('BOQ Cost = '||lt_boq(lv_boq_tab_ind).boq_est_cost);
              --
              IF NOT lv_wol_null_boq_exists
               THEN
                  /*
                  ||No Null BOQ Rates Detected So Far
                  ||On This WOL So Add The BOQ Estimated
                  ||Cost To The WOL Total Estimated Cost.
                  */
                  BEGIN
                  /*
                  ||Update Work Order Line Total.
                  */
                  lt_wol(i).wol_est_cost := NVL(lt_wol(i).wol_est_cost,0) + lt_boq(lv_boq_tab_ind).boq_est_cost;
                  EXCEPTION
                    /*
                    ||Trap The Possibility Of The Value
                    ||Being Too Large For The Column.
                    */
                    WHEN value_error
                     THEN
                        raise_application_error(-20077,'Value Too Large For Work Order Line Estimated Cost');
                    WHEN others
                     THEN
                        RAISE;
                  END;
                  --
              END IF;
                --
              IF NOT lv_wor_null_boq_exists
               THEN
                  /*
                  ||No Null BOQ Rates Detected So Far
                  ||On This WO So Add The BOQ Estimated
                  ||Cost To The WO Total Estimated Cost.
                  */
                  BEGIN
                    /*
                    ||Update Work Order Total.
                    */
                    lv_wor_est_cost := NVL(lv_wor_est_cost,0) + lt_boq(lv_boq_tab_ind).boq_est_cost;
                  EXCEPTION
                    /*
                    ||Trap The Possibility Of The Value
                    ||Being Too Large For The Column.
                    */
                    WHEN value_error
                     THEN
                        raise_application_error(-20076,'Value Too Large For Work Order Estimated Cost');
                    WHEN others
                     THEN
                        RAISE;
                  END;
                  --
              END IF;
              --
            EXCEPTION
              /*
              ||Trap The Possibility Of The Value
              ||Being Too Large For The Column.
              */
              WHEN value_error
               THEN
                  lt_boq(lv_boq_tab_ind).boq_est_cost := NULL;
                  lv_wol_null_boq_exists := TRUE;
                  lv_wor_null_boq_exists := TRUE;
              WHEN others
               THEN
                  RAISE;
            END;
        ELSE
            lt_boq(lv_boq_tab_ind).boq_est_cost := NULL;
            lv_wol_null_boq_exists := TRUE;
            lv_wor_null_boq_exists := TRUE;
        END IF;
        --
        lv_boq_tab_ind := lv_boq_tab_ind+1;
        --
      END LOOP; --lt_repair_boqs
      /*
      ||If Null BOQ Estimated Cost Detected
      ||At WOL Level Nullify The WOL Estimated Cost.
      */
      IF lv_wol_null_boq_exists
       THEN
          lt_wol(i).wol_est_cost := NULL;
      END IF;
      --
    END LOOP; --lt_selected_repairs
    /*
    ||If Null BOQ Estimated Cost Detected
    ||At WO Level Nullify The WO Estimated Cost.
    */
    IF lv_wor_null_boq_exists
     THEN
        lv_wor_est_cost := NULL;
    END IF;
    /*
    ||Repricing Caused No Errors So Get The WOL_IDs.
    */
    FOR i IN 1..lt_wol.count LOOP
      --
      lt_wol(i).wol_id := get_next_id('wol_id_seq');
      --
    END LOOP;
    /*
    ||Set The WOL_ID On The BOQs.
    */
    FOR i IN 1..lt_boq.count LOOP
      --
      FOR j IN 1..lt_wol.count LOOP
        IF lt_wol(j).wol_def_defect_id = lt_boq(i).boq_defect_id
         AND lt_wol(j).wol_rep_action_cat = lt_boq(i).boq_rep_action_cat
         THEN
            lt_boq(i).boq_wol_id := lt_wol(j).wol_id;
            exit;
        END IF;
      END LOOP;
      --
    END LOOP;
    --
  END select_defects;
  --
BEGIN
  --
  --nm_debug.debug_on;
  /*
  ||Initialise Defaults.
  */
  init_defaults;
  /*
  ||Generate Work Order No.
  */
  lv_work_order_no := mai.generate_works_order_no(p_con_id     => pi_con_id
                                                 ,p_admin_unit => lv_wor_admin_unit);
  /*
  ||Determine Which Defects Will Go On The WO.
  */
  select_defects;
  /*
  ||Create The Work Order.
  */
  IF lt_wol.count > 0
   THEN
      /*
      ||Calaculate The Estmated Balancing Sum.
      */
      lv_wor_est_balancing_sum := get_balancing_sum(pi_con_id,lv_wor_est_cost);
      /*
      ||Insert The Work Order.
      */
      INSERT
        INTO work_orders
            (wor_scheme_type
            ,wor_works_order_no
            ,wor_descr
            ,wor_sys_flag
            ,wor_rse_he_id_group
            ,wor_flag
            ,wor_con_id
            ,wor_date_raised
            ,wor_est_complete
            ,wor_job_number
            ,wor_peo_person_id
            ,wor_icb_item_code
            ,wor_icb_sub_item_code
            ,wor_icb_sub_sub_item_code
            ,wor_interim_payment_flag
            ,wor_priority
            ,wor_coc_cost_centre
            ,wor_register_flag
            ,wor_contact
            ,wor_rechargeable
            ,wor_est_cost
            ,wor_est_labour
            ,wor_est_balancing_sum
            )
      VALUES(lv_scheme_type
            ,lv_work_order_no
            ,pi_wo_descr
            ,lv_sys_flag
            ,lv_road_group_id
            ,'D'
            ,pi_con_id
            ,lv_date_raised
            ,pi_target_date
            ,NVL(pi_job_number,'00000')
            ,pi_user_id
            ,substr(lv_work_code,1,2)
            ,substr(lv_work_code,3,2)
            ,substr(lv_work_code,5,2)
            ,pi_interim_payment
            ,pi_priority
            ,pi_cost_centre
            ,NVL(pi_tma_register_flag,'N')
            ,pi_contact
            ,pi_rechargeable
            ,lv_wor_est_cost
            ,lv_wor_est_labour
            ,lv_wor_est_balancing_sum
            )
            ;
      /*
      ||Insert The Work Order Lines.
      */
      FORALL i IN 1..lt_wol.count
      INSERT
        INTO(SELECT wol_id
                   ,wol_works_order_no
                   ,wol_rse_he_id
                   ,wol_siss_id
                   ,wol_icb_work_code
                   ,wol_act_area_code
                   ,wol_def_defect_id
                   ,wol_rep_action_cat
                   ,wol_flag
                   ,wol_status_code
                   ,wol_wor_flag
                   ,wol_date_created
                   ,wol_bud_id
                   ,wol_est_cost
                   ,wol_est_labour
               FROM work_order_lines)
      VALUES lt_wol(i)
           ;
      /*
      ||Update Defects.
      */
      FOR i IN 1..lt_wol.count LOOP
        UPDATE defects
           SET def_status_code = DECODE(def_status_code,lv_def_instructed,def_status_code
                                                                         ,lv_def_selected)
              ,def_last_updated_date = SYSDATE
              ,def_works_order_no    = lv_work_order_no
         WHERE def_defect_id = lt_wol(i).wol_def_defect_id
             ;
      END LOOP;
      /*
      ||Update BOQs.
      */
      FOR i IN 1..lt_boq.count LOOP
        UPDATE boq_items
           SET boq_wol_id   = lt_boq(i).boq_wol_id
              ,boq_est_rate = lt_boq(i).boq_est_rate
              ,boq_est_cost = lt_boq(i).boq_est_cost
         WHERE boq_id = lt_boq(i).boq_id
             ;
      END LOOP;
      /*
      ||Set The Output Parameters.
      */
      po_work_order_no := lv_work_order_no;
      --
  END IF;
  /*
  ||Commit If Required.
  */
  IF lt_wol.count > 0
   THEN
      IF NVL(pi_commit,'Y') = 'Y'
       THEN
          nm_debug.debug('Commit.');
          COMMIT;
      END IF;
  ELSE
      /*
      ||No WO created so rollback to ensure
      ||any updates (e.g. last wo number)
      ||are undone.
      */
      ROLLBACK TO create_defect_wo;
  END IF;
  --
 -- nm_debug.debug_off;
  --
EXCEPTION
  WHEN OTHERS
   THEN
      --ROLLBACK TO create_defect_wo;
      --
      --nm_debug.debug_off;
      --
      RAISE;
END create_defect_work_order;
--
-----------------------------------------------------------------------------
--
PROCEDURE authorise_work_order(pi_user_id         IN hig_users.hus_user_id%TYPE
                              ,pi_works_order_no  IN work_orders.wor_works_order_no%TYPE
                              ,pi_commit          IN VARCHAR2)

  IS
  --
  lv_auth_own hig_option_values.hov_value%TYPE := NVL(hig.get_sysopt('AUTH_OWN'),'Y');
  --
  lr_user  hig_users%ROWTYPE;
  lr_wo    work_orders%ROWTYPE;
  --
BEGIN
  /*
  ||Get User Details.
  */
  lr_user := get_user(pi_user_id => pi_user_id);
  /*
  ||Get The Work Order Details.
  */
  lr_wo := get_and_lock_wo(pi_works_order_no => pi_works_order_no);
  /*
  ||Make Sure User Can Authorise.
  */
  IF pi_user_id = lr_wo.wor_peo_person_id
   AND lv_auth_own != 'Y'
   THEN
      raise_application_error(-20075,'Users Are Not Allowed To Authorise Work Orders They Have Raised.');
  END IF;
  --
  IF NOT (TRUNC(lr_wo.wor_date_raised) BETWEEN NVL(lr_user.hus_start_date, TRUNC(lr_wo.wor_date_raised))
                                           AND NVL(lr_user.hus_end_date-1, TRUNC(lr_wo.wor_date_raised)))
   THEN
      raise_application_error(-20078,'Work Order Date Raised Is Outside Users Start/End Dates.');
  END IF;
  --
  IF lr_wo.wor_est_cost IS NOT NULL
   AND apply_balancing_sum(pi_con_id => lr_wo.wor_con_id
                          ,pi_value  => lr_wo.wor_est_cost)
       BETWEEN nvl(lr_user.hus_wor_aur_min,0)
           AND nvl(lr_user.hus_wor_aur_max,999999999)
   THEN
      /*
      ||Okay So Far
      */
      NULL;
  ELSE
      raise_application_error(-20049,'Cannot Authorise Works Order, Cost Is Outside User Limits.');
  END IF;
  /*
  ||All Okay So Authorise.
  */
  UPDATE work_orders
     SET wor_mod_by_id = pi_user_id
   WHERE wor_works_order_no = pi_works_order_no
       ;
  /*
  ||Commit If Required.
  */
  nm_debug.debug('Authorise Work Order '||pi_works_order_no||' complete '||pi_user_id);
  IF NVL(pi_commit,'Y') = 'Y'
   THEN
      COMMIT;
  END IF;
  --
EXCEPTION
  WHEN OTHERS
   THEN
      nm_debug.debug('authorise_work_order '||SQLERRM);
      ROLLBACK;
      RAISE;
END authorise_work_order;
--
-----------------------------------------------------------------------------
--
PROCEDURE authorise_work_order(pi_works_order_no  IN  work_orders.wor_works_order_no%TYPE
                              ,pi_commit          IN  VARCHAR2 DEFAULT 'Y'
                              ,po_error_text      OUT VARCHAR2)
  IS
  --
  lv_user_id  hig_users.hus_user_id%TYPE := nm3user.get_user_id;
  --
BEGIN
  --
  authorise_work_order(pi_user_id        => lv_user_id
                      ,pi_works_order_no => pi_works_order_no
                      ,pi_commit         => pi_commit);
  --
EXCEPTION
  WHEN others
   THEN
      po_error_text := SQLERRM;
END authorise_work_order;
--
-----------------------------------------------------------------------------
--
PROCEDURE instruct_work_order(pi_user_id         IN hig_users.hus_user_id%TYPE
                             ,pi_works_order_no  IN work_orders.wor_works_order_no%TYPE
                             ,pi_date_instructed IN work_orders.wor_date_confirmed%TYPE
                             ,pi_commit          IN VARCHAR2)
  IS
  --
  lv_wol_inst_status hig_status_codes.hsc_status_code%TYPE := get_instructed_wol_status;
  lv_def_inst_status hig_status_codes.hsc_status_code%TYPE := get_instructed_def_status;
  --
  lr_user hig_users%ROWTYPE;
  lr_wo   work_orders%ROWTYPE;
  lr_con  contracts%ROWTYPE;
  lr_org  org_units%ROWTYPE;
  lr_rse  road_sections%ROWTYPE;
  --
  TYPE wol_tab IS TABLE OF work_order_lines%ROWTYPE INDEX BY BINARY_INTEGER;
  lt_wols wol_tab;
  --
  PROCEDURE get_wols
    IS
  BEGIN
    /*
    ||Get And Lock The Work Order Lines Records.
    */
    SELECT *
      BULK COLLECT
      INTO lt_wols
      FROM work_order_lines
     WHERE wol_works_order_no = pi_works_order_no
       FOR UPDATE
        OF wol_est_cost
           NOWAIT
         ;
    /*
    ||Currently BULK COLLECT Doesn't Raise no_data_found
    ||So Check The Number Of Rows Returned.
    */
    IF lt_wols.count = 0
     THEN
        raise_application_error(-20051,'Cannot Instruct A Work Order With No Lines.');
    END IF;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        raise_application_error(-20051,'Cannot Instruct A Work Order With No Lines.');
    WHEN others
     THEN
        RAISE;
  END get_wols;
  --
  FUNCTION all_lines_priced
    RETURN BOOLEAN IS
    --
    lv_retval BOOLEAN := TRUE;
    --
  BEGIN
    FOR i IN 1..lt_wols.count LOOP
      --
      IF lt_wols(i).wol_est_cost IS NULL
       THEN
          lv_retval := FALSE;
          exit;
      END IF;
      --
    END LOOP;
    --
    RETURN lv_retval;
    --
  END all_lines_priced;
  --
  FUNCTION get_usecycgrp
    RETURN VARCHAR2 IS
    --
    lv_sys_flag  VARCHAR2(1);
    lv_retval    hig_option_values.hov_value%TYPE;
    --
  BEGIN
    --
    SELECT rse_sys_flag
      INTO lv_sys_flag
      FROM road_segs
     WHERE rse_he_id = lr_wo.wor_rse_he_id_group
         ;
    --
    IF lv_sys_flag = 'D'
     THEN
        lv_retval := hig.get_sysopt('USECYCGRPD');
    ELSE
        lv_retval := hig.get_sysopt('USECYCGRPL');
    END IF;
    --
    RETURN NVL(lv_retval,'N');
    --
  END get_usecycgrp;
  --
  PROCEDURE check_contract
    IS
    --
    lv_dumconcode   hig_option_values.hov_value%TYPE := NVL(hig.get_sysopt('DUMCONCODE'),'DEFAULT');
    --
    PROCEDURE get_contract
      IS
    BEGIN
      --
      SELECT *
        INTO lr_con
        FROM contracts
       WHERE con_id = lr_wo.wor_con_id
           ;
      --
      SELECT *
        INTO lr_org
        FROM org_units
       WHERE oun_org_id = lr_con.con_contr_org_id
           ;
      --
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20064,'Invalid Contract On Work Order.');
      WHEN others
       THEN
          RAISE;
    END get_contract;
    --
  BEGIN
    IF lr_wo.wor_con_id IS NULL
     THEN
        raise_application_error(-20069,'No Contract On Work Order.');
    ELSE
        --
        get_contract;
        --
        IF lv_dumconcode IS NOT NULL
         AND lv_dumconcode = lr_con.con_code
         THEN
            raise_application_error(-20050,'Cannot Instruct A Work Order That Is Using The Dummy Contract.');
        END IF;
        --
        IF pi_date_instructed NOT BETWEEN lr_con.con_start_date
                                      AND NVL(lr_con.con_year_end_date,lr_con.con_end_date)
         THEN
            raise_application_error(-20061,'Contract On Work Order Is Out Of Date.');
        END IF;
        --
        IF lr_org.oun_gty_group_type IS NOT NULL
         AND lr_wo.wor_flag = 'M'
         AND get_usecycgrp = 'Y'
         THEN
            raise_application_error(-20234,'Contracts Pricing By Area Is Not Allowed On Cyclic Work Orders');
        END IF;
        --
    END IF;
    --
  END check_contract;
  --
  PROCEDURE update_budgets
    IS
  BEGIN
    --
    FOR i IN 1..lt_wols.count LOOP
      --
      IF within_budget(pi_bud_id => lt_wols(i).wol_bud_id
                      ,pi_con_id => lr_wo.wor_con_id
                      ,pi_est    => lt_wols(i).wol_est_cost
                      ,pi_act    => lt_wols(i).wol_act_cost
                      ,pi_wol_id => lt_wols(i).wol_id)
       THEN
          add_to_budget(pi_wol_id => lt_wols(i).wol_id
                       ,pi_bud_id => lt_wols(i).wol_bud_id
                       ,pi_con_id => lr_wo.wor_con_id
                       ,pi_est    => lt_wols(i).wol_est_cost
                       ,pi_act    => lt_wols(i).wol_act_cost);
      ELSE
          nm_debug.debug('Budget Exceeded.');
          raise_application_error(-20047,'Budget Exceeded.');
      END IF;
      --
    END LOOP;
    --
  END update_budgets;
  --
  PROCEDURE update_interfaces
    IS
    --
    lr_ne nm_elements_all%ROWTYPE;
    --
    lv_originator hig_users.hus_name%TYPE;
    --
  BEGIN
    --
    nm_debug.debug('update_interfaces C');
    --
    IF interfaces_used(pi_con_id => lr_wo.wor_con_id)
     THEN
        --
        lv_originator := nm3get.get_hus(pi_hus_user_id => lr_wo.wor_peo_person_id).hus_name;
        --
        interfaces.add_wor_to_list(p_trans_type   => 'C'
                                  ,p_wor_no       => lr_wo.wor_works_order_no
                                  ,p_wor_flag     => lr_wo.wor_flag
                                  ,p_scheme_type  => lr_wo.wor_scheme_type
                                  ,p_con_code     => lr_con.con_code
                                  ,p_originator   => lv_originator
                                  ,p_confirmed    => pi_date_instructed
                                  ,p_est_complete => lr_wo.wor_est_complete
                                  ,p_est_cost     => lr_wo.wor_est_cost
								  ,p_act_cost     => lr_wo.wor_act_cost
                                  ,p_labour       => lr_wo.wor_est_labour
                                  ,p_ip_flag      => lr_wo.wor_interim_payment_flag
                                  ,p_ra_flag      => lr_wo.wor_risk_assessment_flag
                                  ,p_ms_flag      => lr_wo.wor_method_statement_flag
                                  ,p_wp_flag      => lr_wo.wor_works_programme_flag
                                  ,p_as_flag      => lr_wo.wor_additional_safety_flag
                                  ,p_commence_by  => lr_wo.wor_commence_by
                                  ,p_descr        => lr_wo.wor_descr);
        --
        /* clb 30062010 - task 0109900 commented out code, which was creating rec type A data in CIM file
        FOR i IN 1..lt_wols.count LOOP
          --
          lr_ne := nm3get.get_ne(pi_ne_id => lt_wols(i).wol_rse_he_id);
          --
          interfaces.add_wol_to_list(lt_wols(i).wol_id
                                    ,lt_wols(i).wol_works_order_no
                                    ,lt_wols(i).wol_def_defect_id
                                    ,lt_wols(i).wol_schd_id
                                    ,lt_wols(i).wol_icb_work_code
                                    ,lr_ne.ne_unique
                                    ,lr_ne.ne_descr);
          --
        END LOOP;
        */
        --
        interfaces.copy_data_to_interface;
        --
    END IF;
    --
  END update_interfaces;
  --
BEGIN
  --
  nm_debug.debug_on;
  /*
  ||Get User Details.
  */
  lr_user := get_user(pi_user_id => pi_user_id);
  /*
  ||Get The Work Order Details.
  */
  lr_wo := get_and_lock_wo(pi_works_order_no => pi_works_order_no);
  get_wols;
  /*
  ||Make Sure This Isn't A Cyclic Work Order
  */
--  IF lr_wo.wor_flag = 'M'
--   THEN
--      raise_application_error(-20073,'This API Does Not Support Cyclic Work Orders. Please Use The Forms Application To Instruct Cyclic Work Orders.');
--  END IF;
  /*
  ||Make Sure The Work Order Hasn't Already Been Instructed.
  */
  IF lr_wo.wor_date_confirmed IS NOT NULL
   THEN
      raise_application_error(-20079,'Work Order Has Already Been Instructed');
  END IF;
  /*
  ||Check Closure Date, the Work Order May have been Cancelled.
  */
  IF lr_wo.wor_date_closed IS NOT NULL
   THEN
      raise_application_error(-20083,'Work Order Has Been Cancelled.');
  END IF;
  /*
  ||Check The Date Confirmed Provided.
  */
  IF pi_date_instructed < TRUNC(lr_wo.wor_date_raised)
   THEN
      raise_application_error(-20085,'Date Confirmed Must Be On Or Later Than The Date Raised ['
                                     ||TO_CHAR(lr_wo.wor_date_raised,'DD-MON-RRRR')||'].');
  END IF;
  /*
  ||Check The Date Confirmed Provided.
  */
  IF pi_date_instructed > sysdate
   THEN
      raise_application_error(-20085,'Date Confirmed must not be later than today''s date.');
  END IF;
  /*
  ||Check The Contract.
  */
  check_contract;
  /*
  ||Make Sure All Lines Are Priced.
  */
  IF NOT all_lines_priced
   THEN
      raise_application_error(-20048,'All Work Order Lines Must Be Priced.');
  END IF;
  /*
  ||If The Work Order Has Not Been Authorised
  ||Check Whether The User Can Do So. If They
  ||Can Then Authorise It.
  */
  IF lr_wo.wor_mod_by_id IS NULL
   THEN
      nm_debug.debug('Authorising work order');
      authorise_work_order(pi_user_id        => pi_user_id
                          ,pi_works_order_no => pi_works_order_no
                          ,pi_commit         => 'N');
  END IF;
  /*
  ||Instruct The Work Order.
  */
  UPDATE work_orders
     SET wor_date_confirmed = pi_date_instructed
   WHERE wor_works_order_no = pi_works_order_no
       ;
  /*
  ||Update The WOLs.
  */
  UPDATE work_order_lines
     SET wol_status_code = lv_wol_inst_status
   WHERE wol_works_order_no = pi_works_order_no
       ;
  /*
  ||Set the status of any associated Defects to INSTRUCTED
  */
  UPDATE defects
     SET def_status_code = lv_def_inst_status
        ,def_last_updated_date = SYSDATE
   WHERE def_defect_id IN(SELECT wol_def_defect_id
                            FROM work_order_lines
                           WHERE wol_works_order_no = pi_works_order_no)
           ;
  /*
  ||Update The Budgets.
  */
  update_budgets;
  /*
  ||Update Interfaces If Required.
  */
  update_interfaces;
  /*
  ||Commit If Required.
  */
  IF NVL(pi_commit,'Y') = 'Y'
   THEN
      nm_debug.debug('Instruct_work_order Commit. ');
      COMMIT;
  END IF;
  --
EXCEPTION
  WHEN OTHERS
   THEN
      ROLLBACK;
      --
      nm_debug.debug(SUBSTR('instruct_work_order raised : '||SQLERRM,1,4000));
--      nm_debug.debug_off;
      --
      RAISE;
END instruct_work_order;
--
-----------------------------------------------------------------------------
--
PROCEDURE instruct_work_order(pi_works_order_no  IN  work_orders.wor_works_order_no%TYPE
                             ,pi_date_instructed IN  work_orders.wor_date_confirmed%TYPE DEFAULT SYSDATE
                             ,pi_commit          IN  VARCHAR2                            DEFAULT 'Y'
                             ,po_error_text      OUT VARCHAR2)
  IS
  --
  lv_user_id  hig_users.hus_user_id%TYPE := nm3user.get_user_id;
  --
BEGIN
  --
  instruct_work_order(pi_user_id         => lv_user_id
                     ,pi_works_order_no  => pi_works_order_no
                     ,pi_date_instructed => pi_date_instructed
                     ,pi_commit          => pi_commit);
  --
EXCEPTION
  WHEN others
   THEN
      po_error_text := SQLERRM;
END instruct_work_order;
--
-----------------------------------------------------------------------------
--
PROCEDURE instruct_work_orders(pi_date_instructed  IN     work_orders.wor_date_confirmed%TYPE DEFAULT SYSDATE
                              ,pi_commit           IN     VARCHAR2                            DEFAULT 'Y'
                              ,po_error_flag          OUT VARCHAR2
                              ,pio_works_order_tab IN OUT instruct_wo_tab)
  IS
  --
  lv_user_id     hig_users.hus_user_id%TYPE := nm3user.get_user_id;
  lv_error_flag  VARCHAR2(1) := 'N';
  --
  lt_wo instruct_wo_tab;
  --
  PROCEDURE remove_duplicate_wo_numbers(pio_wo_tab IN OUT instruct_wo_tab)
    IS
    --
    lt_tmp_wo instruct_wo_tab;
    --
    lo_tmp_wo_no nm_code_tbl := nm_code_tbl();
    --
  BEGIN
    --
    FOR i IN 1..pio_wo_tab.count LOOP
      lo_tmp_wo_no.extend;
      lo_tmp_wo_no(i) := pio_wo_tab(i).works_order_no;
    END LOOP;
    --
    SELECT DISTINCT column_value
          ,NULL
      BULK COLLECT
      INTO lt_tmp_wo
      FROM TABLE(lo_tmp_wo_no)
         ;
    --
    pio_wo_tab := lt_tmp_wo;
    --
  END remove_duplicate_wo_numbers;
  --
BEGIN
  --
  lt_wo := pio_works_order_tab;
  remove_duplicate_wo_numbers(pio_wo_tab => lt_wo);
  --
  FOR i IN 1..lt_wo.count LOOP
    --
    BEGIN
      --
      instruct_work_order(pi_user_id         => lv_user_id
                         ,pi_works_order_no  => lt_wo(i).works_order_no
                         ,pi_date_instructed => pi_date_instructed
                         ,pi_commit          => pi_commit);
      --
    EXCEPTION
      WHEN others
       THEN
          lt_wo(i).error_text := SQLERRM;
          lv_error_flag := 'Y';
    END;
  END LOOP;
  --
  po_error_flag := lv_error_flag;
  pio_works_order_tab := lt_wo;
  --
END instruct_work_orders;
--
-----------------------------------------------------------------------------
--
PROCEDURE receive_work_order(pi_user_id        IN hig_users.hus_user_id%TYPE
                            ,pi_works_order_no IN work_orders.wor_works_order_no%TYPE
                            ,pi_date_received  IN work_orders.wor_date_received%TYPE
                            ,pi_commit         IN VARCHAR2)
  IS
  --
  lr_wo  work_orders%ROWTYPE;
  --
BEGIN
  nm_debug.debug_on;
  /*
  ||Validate The User ID.
  */
  IF NOT validate_user_id(pi_user_id        => pi_user_id
                         ,pi_effective_date => TRUNC(SYSDATE))
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
  END IF;
  /*
  ||Get The Work Order Details
  ||And Lock The Record For Update.
  */
  lr_wo := get_and_lock_wo(pi_works_order_no => pi_works_order_no);
  /*
  ||Make Sure The WO Can Be Received.
  */
  IF lr_wo.wor_date_confirmed IS NULL
   THEN
      raise_application_error(-20092,'Cannot Set A Works Order That Has Not Been Instructed As Received.');
  END IF;
  /*
  ||Check The Date Received.
  */
  IF pi_date_received < lr_wo.wor_date_confirmed
   THEN
      raise_application_error(-20093,'Date Received ['||TO_CHAR(pi_date_received,'DD-MON-RRRR')
                                   ||']Must Not Be Less Than The Date Instructed ['||TO_CHAR(lr_wo.wor_date_confirmed,'DD-MON-RRRR')||'].');
  END IF;
  /*
  ||Update The Work Order.
  */
  UPDATE work_orders
     SET wor_received_by = pi_user_id
        ,wor_date_received = pi_date_received
   WHERE wor_works_order_no = pi_works_order_no
       ;
  /*
  ||Commit If Required.
  */
  IF NVL(pi_commit,'Y') = 'Y'
   THEN
      nm_debug.debug('Commit.');
      COMMIT;
  END IF;
  --
EXCEPTION
  WHEN OTHERS
   THEN
      ROLLBACK;
      --
      nm_debug.debug(SUBSTR('receive_work_order raised : '||SQLERRM,1,4000));
--      nm_debug.debug_off;
      --
      RAISE;
END receive_work_order;
--
-----------------------------------------------------------------------------
--
FUNCTION get_wol_status_flags(pi_status_code work_order_lines.wol_status_code%TYPE
                             ,pi_date_raised work_orders.wor_date_raised%TYPE)
  RETURN flags_rec IS
  --
  lr_retval flags_rec;
  --
BEGIN
  /*
  ||Get The Flags.
  */
  SELECT hsc_allow_feature1 feature1
        ,hsc_allow_feature2 feature2
        ,hsc_allow_feature3 feature3
        ,hsc_allow_feature4 feature4
        ,hsc_allow_feature5 feature5
        ,hsc_allow_feature6 feature6
        ,hsc_allow_feature7 feature7
        ,hsc_allow_feature8 feature8
        ,hsc_allow_feature9 feature9
   INTO lr_retval
   FROM hig_status_codes
  WHERE hsc_domain_code = 'WORK_ORDER_LINES'
    AND hsc_status_code = pi_status_code
    AND (TRUNC(pi_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(pi_date_raised))
                                   AND NVL(hsc_end_date  ,TRUNC(pi_date_raised))
         OR pi_date_raised IS NULL)
      ;
  /*
  ||Return The Flags.
  */
  RETURN lr_retval;
  --
END get_wol_status_flags;
--
-----------------------------------------------------------------------------
--
FUNCTION wol_status_is_actual(pi_flags IN flags_rec)
  RETURN BOOLEAN IS
  --
  lv_retval BOOLEAN := FALSE;
  --
BEGIN
  /*
  ||Get The Status Code Flags.
  */
  IF (pi_flags.feature3 = 'Y'
      OR pi_flags.feature8 = 'Y'
      OR pi_flags.feature9 = 'Y')
   THEN
      lv_retval := TRUE;
  END IF;
  --
  RETURN lv_retval;
  --
END wol_status_is_actual;
--
-----------------------------------------------------------------------------
--
PROCEDURE update_wol_status(pi_user_id       IN hig_users.hus_user_id%TYPE
                           ,pi_wol_id        IN work_order_lines.wol_id%TYPE
                           ,pi_new_status    IN work_order_lines.wol_status_code%TYPE
                           ,pi_date_complete IN work_order_lines.wol_date_complete%TYPE
                           ,pi_boq_tab       IN act_boq_tab
                           ,pi_commit        IN VARCHAR2)
  IS
  --
  lr_old_status flags_rec;
  lr_new_status flags_rec;
  --
  lr_wo     work_orders%ROWTYPE;
  lr_wol    work_order_lines%ROWTYPE;
  lr_defect defects%ROWTYPE;
  --
  lv_complete_status  BOOLEAN := FALSE;
  lv_interim_status   BOOLEAN := FALSE;
  lv_not_done_status  BOOLEAN := FALSE;
  lv_valid_transition BOOLEAN := TRUE;
  lv_reason           VARCHAR2(200);
  lv_actual_costs     BOOLEAN := FALSE;
  --
  lv_wor_est_cost           work_orders.wor_est_cost%TYPE;
  lv_wor_est_balancing_sum  work_orders.wor_est_balancing_sum%TYPE;
  lv_wor_est_labour         work_orders.wor_est_labour%TYPE;
  lv_wor_act_cost           work_orders.wor_act_cost%TYPE;
  lv_wor_act_balancing_sum  work_orders.wor_act_balancing_sum%TYPE;
  lv_wor_act_labour         work_orders.wor_act_labour%TYPE;
  lv_wor_date_closed        work_orders.wor_date_closed%TYPE;
  --
  lv_def_status_code  defects.def_status_code%TYPE;
  --
  PROCEDURE validate_date_complete
    IS
  BEGIN
    --
    IF pi_date_complete IS NOT NULL
     THEN
        --
        IF pi_date_complete > SYSDATE
         THEN
            raise_application_error(-20105,'Date Complete Must Be Less Than Or Equal To Todays Date.');
        END IF;
        --
        IF pi_date_complete < lr_wo.wor_date_confirmed
         OR lr_wo.wor_date_confirmed IS NULL
         THEN
            raise_application_error(-20106,'Date Complete Must Be On Or Later Than The Date Instructed ['
                                           ||TO_CHAR(lr_wo.wor_date_confirmed,'DD-MON-RRRR')||'].');
        END IF;
        --
    END IF;
    --
  END validate_date_complete;
  --
  PROCEDURE validate_wol_status_change
    IS
    --
    PROCEDURE set_defect_status
      IS
      --
      lv_def_feature2 hig_status_codes.hsc_allow_feature2%TYPE := 'N';
      lv_def_feature3 hig_status_codes.hsc_allow_feature3%TYPE := 'N';
      lv_def_feature4 hig_status_codes.hsc_allow_feature4%TYPE := 'N';
      lv_dummy        NUMBER;
      --
      PROCEDURE get_def_status
        IS
      BEGIN
        --
        SELECT hsc_status_code
          INTO lv_def_status_code
          FROM hig_status_codes
         WHERE hsc_domain_code = 'DEFECTS'
           AND hsc_allow_feature2 = lv_def_feature2
           AND hsc_allow_feature3 = lv_def_feature3
           AND hsc_allow_feature4 = lv_def_feature4
             ;
        --
      EXCEPTION
        WHEN too_many_rows
         THEN
            raise_application_error(-20108,'Too Many Values Defined For Defect Status.');
        WHEN no_data_found
         THEN
            raise_application_error(-20109,'Cannot Obtain Value For Defect Status.');
        WHEN others
         THEN
            RAISE;
      END get_def_status;
      --
      FUNCTION other_repair_assigned
        RETURN BOOLEAN IS
        --
        lv_dummy  NUMBER;
        lv_retval BOOLEAN := FALSE;
        --
        CURSOR chk_reps(cp_defect_id  defects.def_defect_id%TYPE
                       ,cp_wol_id     work_order_lines.wol_id%TYPE)
            IS
        SELECT 1
          FROM work_order_lines
              ,hig_status_codes
         WHERE wol_def_defect_id = cp_defect_id
           AND wol_status_code != hsc_status_code
           AND wol_id != cp_wol_id
           AND hsc_domain_code = 'WORK_ORDER_LINES'
           AND hsc_allow_feature5 = 'Y'
             ;
      BEGIN
        --
        OPEN  chk_reps(lr_wol.wol_def_defect_id
                      ,lr_wol.wol_id);
        FETCH chk_reps
         INTO lv_dummy;
        lv_retval := chk_reps%FOUND;
        CLOSE chk_reps;
        --
        RETURN lv_retval;
        --
      EXCEPTION
        WHEN no_data_found
         THEN
            RETURN FALSE;
        WHEN others
         THEN
            RAISE;
      END other_repair_assigned;
    BEGIN
      --
      IF lr_new_status.feature2 = 'Y'
       OR lr_new_status.feature3 = 'Y'
       THEN
          /*
          ||WOL Is Held Or Complete
          ||So Defect Is Complete.
          */
          lv_def_feature4 := 'Y';
          --
      ELSIF lr_new_status.feature5 = 'Y'
       THEN
          /*
          ||WOL Is Not Done.
          */
          IF other_repair_assigned
           THEN
              /*
              ||Defect Is Instructed.
              */
              lv_def_feature3 := 'Y';
              --
          ELSE
              /*
              ||Defect Is Available.
              */
              lv_def_feature2 := 'Y';
              --
          END IF;
          --
      ELSE
          /*
          ||Defect Is Instructed.
          */
          lv_def_feature3 := 'Y';
          --
      END IF;
      /*
      ||Now Get Defect Status Code
      ||Based On The Flags Set.
      */
      get_def_status;
      --
    END set_defect_status;
    --
  BEGIN
    /*
    ||Make Sure Status Change Is Allowed.
    */
--    IF NVL(lr_wol.wol_status_code,'@') = NVL(pi_new_status, '@')
--     THEN
--        /*
--        ||No Change In Status So No Need To Do Anything.
--        */
--        lv_valid_transition := FALSE;
--        lv_reason := 'Works Order Line Status Is Already Set To '||pi_new_status;
--    END IF;
    --
    IF lr_wo.wor_date_confirmed IS NULL
     THEN
        /*
        ||Cannot Amend Status On Unconfirmed Works Order.
        */
        lv_valid_transition := FALSE;
        lv_reason := 'Cannot Amend Status On Unconfirmed Works Order.';
    END IF;
    /*
    ||Check That The Transition From The
    ||Old Status To The New Status Is Valid.
    */
    IF lv_valid_transition
     THEN
        /*
        ||Get The Flags.
        */
        BEGIN
          lr_old_status := get_wol_status_flags(pi_status_code => lr_wol.wol_status_code
                                               ,pi_date_raised => NULL);
        EXCEPTION
          WHEN no_data_found
           THEN
              lv_valid_transition:= FALSE;
              lv_reason := 'Old Status Code Does Not Exist.';
          WHEN others
           THEN
              RAISE;
        END;
        --
        BEGIN
          lr_new_status := get_wol_status_flags(pi_status_code => pi_new_status
                                               ,pi_date_raised => lr_wo.wor_date_raised);
        EXCEPTION
          WHEN no_data_found
           THEN
              lv_valid_transition:= FALSE;
              lv_reason := 'New Status Code Does Not Exist.';
          WHEN others
           THEN
              RAISE;
        END;
        --
        IF lv_valid_transition
         THEN
            CASE
              WHEN lr_new_status.feature4 = 'Y'
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'User Cannot Set Status To PAID or PART PAID.';
              WHEN lr_new_status.feature2 = 'Y'
               AND lr_old_status.feature2 = 'Y'
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Status Is Already At HELD.';
              WHEN lr_new_status.feature5 = 'Y'
               AND lr_old_status.feature5 = 'Y'
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Status Is Already At NOT_DONE.';
              WHEN lr_new_status.feature1 = 'Y'
               AND lr_old_status.feature1 = 'Y'
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Status Is Already At INSTRUCTED.';
              WHEN (lr_new_status.feature3 = 'Y'
                    AND lr_old_status.feature3 = 'Y')
               OR (lr_new_status.feature5 = 'Y'
                   AND lr_wol.wol_date_complete IS NOT NULL)
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Work Order Line Has Already Been Completed.';
              WHEN lr_new_status.feature3 = 'Y'
               AND NOT mai.contract_still_in_date(p_wo_no => lr_wol.wol_id)
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Work Order Line Cannot Be Completed, Contract Is Out Of Date.';
              WHEN (lr_old_status.feature2 = 'Y'
                    OR lr_old_status.feature3 = 'Y')
               AND lr_new_status.feature9 = 'Y'
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Status Change From HELD Or COMPLETE To INTERIM Is Not Allowed.';
              --WHEN lr_old_status.feature8 != 'Y'
              -- AND lr_new_status.feature9 = 'Y'
              -- THEN
              --    lv_valid_transition := FALSE;
              --    lv_reason := 'Status Can Only Be Changed To INTERIM From VALUATION.';
              WHEN lr_old_status.feature4 = 'Y'
               AND (lr_new_status.feature2 = 'Y'
                    OR lr_new_status.feature5 = 'Y')
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Status Cannot Be Changed From PAID Or PART PAID To HELD Or NOT DONE.';
              WHEN lr_new_status.feature3 = 'Y'
               AND maiwo.can_complete_wol(p_works_order_no => lr_wo.wor_works_order_no) = 'FALSE'
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'User Is Not Allowed To Complete The Line When The Contractor Interface Is In Use.';
              WHEN NVL(lr_wo.wor_interim_payment_flag,'N') != 'Y'
               AND (lr_new_status.feature8 = 'Y'
                    OR lr_new_status.feature9  = 'Y')
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Works Order Interim Payment Flag Must Be Set Before INTERIM and VALUATION Are Allowed.';
              WHEN ((lr_new_status.feature9 = 'Y' and lr_new_status.feature4 != 'Y')
                    OR lr_new_status.feature8 = 'Y')
               AND maiwo.final_claim_exists(p_wol_id => lr_wol.wol_id)
               THEN
                  lv_valid_transition := FALSE;
                  lv_reason := 'Status Of INTERIM Or VALUATION Is Not Allowed Once A Final Claim Has Been Made.';
              ELSE
                  NULL;
            END CASE;
            --
        END IF;
    END IF;
    --
    IF lv_valid_transition
     THEN
        /*
        ||Determine Whether Any Boq Calculations
        ||Should Be Estimates Or Actuals.
        */
        lv_actual_costs := wol_status_is_actual(pi_flags => lr_new_status);
        /*
        ||Determine Whether New Status
        ||Requires An Interim Payment.
        */
        IF lr_new_status.feature9 = 'Y'
         AND lr_new_status.feature4 != 'Y'
         THEN
            lv_interim_status := TRUE;
        END IF;
        /*
        ||Determine Whether The New Status
        ||Is Completing The Work Order Line.
        */
        lv_complete_status := maiwo.complete_status(p_status => pi_new_status);
        /*
        ||Determine Whether The New Status
        ||Is Marking The Work Order Line As Not Done.
        */
        IF lr_new_status.feature5 = 'Y'
         THEN
            lv_not_done_status := TRUE;
        END IF;
        /*
        ||If The Work Order Line Has A Defect
        ||Associated Determine The Defect Status.
        */
        set_defect_status;
        --
    END IF;
    --
  END validate_wol_status_change;
  --
  PROCEDURE process_boqs
    IS
    --
    lr_sta            standard_items%ROWTYPE;
    lr_blank_boq      boq_items%ROWTYPE;
    lr_new_boq        boq_items%ROWTYPE;
    lr_upd_boq        boq_items%ROWTYPE;
    lr_new_perc_item  boq_items%ROWTYPE;
    --
    lv_perc_item_unit hig_option_values.hov_value%TYPE := hig.get_sysopt('PERC_ITEM');
    --
    PROCEDURE insert_new_perc_item(pi_parent_id IN boq_items.boq_parent_id%TYPE
                                  ,pi_item_code IN standard_items.sta_item_code%TYPE)
      IS
      --
      lr_sta_perc   standard_items%ROWTYPE;
      lr_perc_item  boq_items%ROWTYPE;
      --
      lv_rate  boq_items.boq_act_rate%TYPE;
      --
    BEGIN
      --
      lr_sta_perc := get_sta(pi_sta_item_code => pi_item_code);
      --
      lv_rate := maiwo.reprice_item(p_item_code => pi_item_code
                                   ,p_con_id    => lr_wo.wor_con_id
                                   ,p_rse_he_id => lr_wol.wol_rse_he_id
                                   ,p_priority  => lr_defect.def_priority);
      IF lv_rate IS NULL
       THEN
          raise_application_error(-20101,'Item Code ['||lr_new_boq.boq_sta_item_code||'] Is Not A Valid Contract Item.');
      END IF;
      --
      lr_perc_item.boq_id             := get_next_id('BOQ_ID_SEQ');
      lr_perc_item.boq_parent_id      := pi_parent_id;
      lr_perc_item.boq_sta_item_code  := pi_item_code;
      lr_perc_item.boq_item_name      := lr_sta_perc.sta_item_name;
      lr_perc_item.boq_work_flag      := lr_wol.wol_flag;
      lr_perc_item.boq_defect_id      := NVL(lr_wol.wol_def_defect_id,0);
      lr_perc_item.boq_rep_action_cat := NVL(lr_wol.wol_rep_action_cat,'X');
      lr_perc_item.boq_wol_id         := lr_wol.wol_id;
      lr_perc_item.boq_date_created   := sysdate;
      lr_perc_item.boq_est_dim1       := 0;
      lr_perc_item.boq_est_dim2       := NULL;
      lr_perc_item.boq_est_dim3       := NULL;
      lr_perc_item.boq_est_quantity   := 0;
      lr_perc_item.boq_est_cost       := 0;
      lr_perc_item.boq_est_rate       := 0;
      lr_perc_item.boq_act_dim1       := 1;
      lr_perc_item.boq_act_dim2       := NULL;
      lr_perc_item.boq_act_dim3       := NULL;
      lr_perc_item.boq_act_quantity   := 1;
      lr_perc_item.boq_act_rate       := lv_rate;
      lr_perc_item.boq_act_cost       := 0;
      --
      INSERT
        INTO boq_items
      VALUES lr_perc_item
           ;
      --
    END insert_new_perc_item;
    --
    PROCEDURE recalc_percent_items
      IS
      --
      TYPE perc_item_rec IS RECORD(child_id  boq_items.boq_id%TYPE
                                  ,parent_id boq_items.boq_id%TYPE);
      TYPE perc_item_tab IS TABLE OF perc_item_rec INDEX BY BINARY_INTEGER;
      lt_perc_items perc_item_tab;
      --
      lv_dummy NUMBER;
      --
      PROCEDURE get_perc_items
        IS
      BEGIN
        SELECT boq_id        child_id
              ,boq_parent_id parent_id
          BULK COLLECT
          INTO lt_perc_items
          FROM boq_items
         WHERE boq_wol_id = lr_wol.wol_id
           AND boq_parent_id IS NOT NULL
             ;
      EXCEPTION
        WHEN no_data_found
         THEN
            NULL;
        WHEN others
         THEN
            RAISE;
      END get_perc_items;
      --
    BEGIN
      get_perc_items;
      FOR i IN 1..lt_perc_items.count LOOP
        lv_dummy := maiwo.recalc_percent_item(p_boq_item    => lt_perc_items(i).parent_id
                                             ,p_comp_method => lr_wo.wor_perc_item_comp);
        IF lv_dummy != -1
         THEN
            raise_application_error(-20103,'An Error Occured Whilst Recalculating Percent Items.');
        END IF;
      END LOOP;
    END recalc_percent_items;
    --
  BEGIN
    /*
    ||Process Any BOQs Passed In.
    */
    IF pi_boq_tab.count > 0
     THEN
        IF NOT lv_actual_costs
         THEN
            raise_application_error(-20100,'Update Of BOQs Is Only Supported For Actual Costs.');
        END IF;
        --
        FOR i IN 1..pi_boq_tab.count LOOP
          /*
          ||Validate Standard Item Code.
          */
          IF pi_boq_tab(i).boq_sta_item_code IS NOT NULL
           THEN
              lr_sta := get_sta(pi_sta_item_code => pi_boq_tab(i).boq_sta_item_code);
              IF lr_sta.sta_unit = lv_perc_item_unit
               THEN
                  raise_application_error(-20099,'Parent BOQs Based On Percentage Items Codes Are Not Supported.');
              END IF;
          ELSE
              raise_application_error(-20032,'Invalid Standard Item Code Specified.');
          END IF;
          --
          IF pi_boq_tab(i).boq_id IS NOT NULL
           THEN
              /*
              ||Existing BOQ So Get The Record From The Database.
              */
              lr_upd_boq := lr_blank_boq;
              --
              BEGIN
                SELECT *
                  INTO lr_upd_boq
                  FROM boq_items
                 WHERE boq_id = pi_boq_tab(i).boq_id
                   AND boq_wol_id = lr_wol.wol_id
                     ;
              EXCEPTION
                WHEN no_data_found
                 THEN
                    raise_application_error(-20091,'BOQ_ID ['||TO_CHAR(pi_boq_tab(i).boq_id)
                                                 ||'] Is Not A Child Of The Specified Parent - Work Order Line ['
                                                 ||TO_CHAR(lr_wol.wol_id)||'].');
                WHEN others
                 THEN
                    RAISE;
              END;
              /*
              ||Update Actual Dimensions etc.
              */
              lr_upd_boq.boq_act_dim1 := NVL(pi_boq_tab(i).boq_act_dim1,NVL(lr_upd_boq.boq_act_dim1,0));
              --
              IF lr_sta.sta_dim2_text IS NOT NULL
               THEN
                  lr_upd_boq.boq_act_dim2 := NVL(pi_boq_tab(i).boq_act_dim2,NVL(lr_upd_boq.boq_act_dim2,1));
              END IF;
              --
              IF lr_sta.sta_dim3_text IS NOT NULL
               THEN
                  lr_upd_boq.boq_act_dim3 := NVL(pi_boq_tab(i).boq_act_dim3,NVL(lr_upd_boq.boq_act_dim3,1));
              END IF;
              /*
              ||Set Actual Quantity.
              */
              lr_upd_boq.boq_act_quantity := lr_upd_boq.boq_act_dim1
                                             * NVL(lr_upd_boq.boq_act_dim2,1)
                                             * NVL(lr_upd_boq.boq_act_dim3,1);
              /*
              ||Check Quantity.
              */
              IF lr_upd_boq.boq_act_quantity < lr_sta.sta_min_quantity
               AND lr_upd_boq.boq_act_quantity != 0
               THEN
                  raise_application_error(-20035,'Actual Quantity Is Below The Minimum Quantity.');
              END IF;
              --
              IF lr_upd_boq.boq_act_quantity > lr_sta.sta_max_quantity
               AND lr_upd_boq.boq_act_quantity != 0
               THEN
                  raise_application_error(-20036,'Actual Quantity Is Above The Maximum Quantity.');
              END IF;
              /*
              ||Set Actual Labour
              */
              lr_upd_boq.boq_act_labour := lr_upd_boq.boq_act_quantity * NVL(lr_sta.sta_labour_units,0);
              /*
              ||Set Actual Rate.
              */
              IF lr_upd_boq.boq_sta_item_code != pi_boq_tab(i).boq_sta_item_code
               OR lr_upd_boq.boq_act_rate IS NULL
               THEN
                  lr_upd_boq.boq_sta_item_code := pi_boq_tab(i).boq_sta_item_code;
                  lr_upd_boq.boq_act_rate := maiwo.reprice_item(p_item_code => lr_upd_boq.boq_sta_item_code
                                                               ,p_con_id    => lr_wo.wor_con_id
                                                               ,p_rse_he_id => lr_wol.wol_rse_he_id
                                                               ,p_priority  => lr_defect.def_priority);
                  IF lr_upd_boq.boq_act_rate IS NULL
                   THEN
                      raise_application_error(-20101,'Item Code ['||lr_new_boq.boq_sta_item_code||'] Is Not A Valid Contract Item.');
                  END IF;
                  --
              END IF;
              /*
              ||Set Actual Cost.
              */
              lr_upd_boq.boq_act_cost := ROUND((lr_upd_boq.boq_act_rate * lr_upd_boq.boq_act_quantity),2);
              --
              UPDATE boq_items
                 SET ROW = lr_upd_boq
               WHERE boq_id = pi_boq_tab(i).boq_id
                   ;
              /*
              ||Check To See If A New Percent Item Has Been Specified.
              */
              IF pi_boq_tab(i).add_percent_item = 'Y'
               AND pi_boq_tab(i).percent_item_code IS NOT NULL
               THEN
                  /*
                  ||Check The Parent Is Allowed To Have A Child.
                  */
                  IF lr_sta.sta_allow_percent = 'Y'
                   THEN
                      insert_new_perc_item(pi_parent_id => lr_upd_boq.boq_id
                                          ,pi_item_code => pi_boq_tab(i).percent_item_code);
                  ELSE
                      raise_application_error(-20102,'Percent Items Cannot Be Added To Item Code ['||lr_sta.sta_item_code||'].');
                  END IF;
              END IF;
              --
          ELSE
              lr_new_boq := lr_blank_boq;
              /*
              ||New Boq So Set Some Default Fields.
              */
              lr_new_boq.boq_id             := get_next_id('BOQ_ID_SEQ');
              lr_new_boq.boq_sta_item_code  := pi_boq_tab(i).boq_sta_item_code;
              lr_new_boq.boq_work_flag      := lr_wol.wol_flag;
              lr_new_boq.boq_defect_id      := NVL(lr_wol.wol_def_defect_id,0);
              lr_new_boq.boq_rep_action_cat := NVL(lr_wol.wol_rep_action_cat,'X');
              lr_new_boq.boq_wol_id         := lr_wol.wol_id;
              lr_new_boq.boq_date_created   := SYSDATE;
              lr_new_boq.boq_item_name      := lr_sta.sta_item_name;
              lr_new_boq.boq_est_dim1       := 0;
              lr_new_boq.boq_est_dim2       := NULL;
              lr_new_boq.boq_est_dim3       := NULL;
              lr_new_boq.boq_est_quantity   := 0;
              lr_new_boq.boq_est_cost       := 0;
              lr_new_boq.boq_est_rate       := 0;
              /*
              ||Check/Default Dimentions.
              */
              lr_new_boq.boq_act_dim1 := NVL(pi_boq_tab(i).boq_act_dim1,0);
              --
              IF lr_sta.sta_dim2_text IS NOT NULL
               THEN
                  lr_new_boq.boq_act_dim2 := NVL(pi_boq_tab(i).boq_act_dim2,1);
              END IF;
              --
              IF lr_sta.sta_dim3_text IS NOT NULL
               THEN
                  lr_new_boq.boq_act_dim3 := NVL(pi_boq_tab(i).boq_act_dim3,1);
              END IF;
              /*
              ||Set Actual Quantity.
              */
              lr_new_boq.boq_act_quantity := lr_new_boq.boq_act_dim1
                                             * NVL(lr_new_boq.boq_act_dim2,1)
                                             * NVL(lr_new_boq.boq_act_dim3,1);
              /*
              ||Check Quantity.
              */
              IF lr_new_boq.boq_act_quantity < lr_sta.sta_min_quantity
               AND lr_new_boq.boq_act_quantity != 0
               THEN
                  raise_application_error(-20035,'Actual Quantity Is Below The Minimum Quantity.');
              END IF;
              --
              IF lr_new_boq.boq_act_quantity > lr_sta.sta_max_quantity
               AND lr_new_boq.boq_act_quantity != 0
               THEN
                  raise_application_error(-20036,'Actual Quantity Is Above The Maximum Quantity.');
              END IF;
              /*
              ||Set Actual Labour
              */
              lr_new_boq.boq_act_labour := lr_new_boq.boq_act_quantity * NVL(lr_sta.sta_labour_units,0);
              /*
              ||Set Actual Rate.
              */
              lr_new_boq.boq_act_rate := maiwo.reprice_item(p_item_code => lr_new_boq.boq_sta_item_code
                                                           ,p_con_id    => lr_wo.wor_con_id
                                                           ,p_rse_he_id => lr_wol.wol_rse_he_id
                                                           ,p_priority  => lr_defect.def_priority);
              IF lr_new_boq.boq_act_rate IS NULL
               THEN
                  raise_application_error(-20101,'Item Code ['||lr_new_boq.boq_sta_item_code||'] Is Not A Valid Contract Item.');
              END IF;
              /*
              ||Set Actual Cost.
              */
              lr_new_boq.boq_act_cost := ROUND((lr_new_boq.boq_act_rate * lr_new_boq.boq_act_quantity),2);
              --
              INSERT
                INTO boq_items
              VALUES lr_new_boq
                   ;
              /*
              ||Check To See If A New Percent Item Has Been Specified.
              */
              IF pi_boq_tab(i).add_percent_item = 'Y'
               AND pi_boq_tab(i).percent_item_code IS NOT NULL
               THEN
                  /*
                  ||Check The Parent Is Allowd To Have A Child.
                  */
                  IF lr_sta.sta_allow_percent = 'Y'
                   THEN
                      insert_new_perc_item(pi_parent_id => lr_new_boq.boq_id
                                          ,pi_item_code => pi_boq_tab(i).percent_item_code);
                  ELSE
                      raise_application_error(-20102,'Percent Items Cannot Be Added To Item Code ['||lr_sta.sta_item_code||'].');
                  END IF;
              END IF;
          END IF;
          --
        END LOOP;
    END IF;
    /*
    ||Set Actuals For Any BOQs That Haven't Been Updated.
    */
    IF lv_actual_costs
     OR lv_complete_status
     THEN
        UPDATE boq_items
           SET boq_act_dim1     = NVL(boq_act_dim1, boq_est_dim1)
              ,boq_act_dim2     = NVL(boq_act_dim2, boq_est_dim2)
              ,boq_act_dim3     = NVL(boq_act_dim3, boq_est_dim3)
              ,boq_act_rate     = NVL(boq_act_rate, boq_est_rate)
              ,boq_act_quantity = NVL(boq_act_quantity, boq_est_quantity)
              ,boq_act_cost     = NVL(boq_act_cost, boq_est_cost)
              ,boq_act_labour   = NVL(boq_act_labour, boq_est_labour)
              ,boq_act_discount = NVL(boq_act_discount, boq_est_discount)
         WHERE boq_wol_id = lr_wol.wol_id
             ;
    ELSIF lv_not_done_status
     THEN
        UPDATE boq_items
           SET boq_act_dim1     = NULL
              ,boq_act_dim2     = NULL
              ,boq_act_dim3     = NULL
              ,boq_act_rate     = NULL
              ,boq_act_quantity = NULL
              ,boq_act_cost     = NULL
              ,boq_act_labour   = NULL
              ,boq_act_discount = NULL
         WHERE boq_wol_id = lr_wol.wol_id
             ;
    END IF;
    /*
    ||Recalc Perc Items.
    */
    recalc_percent_items;
    /*
    ||Update Contract Item Usage.
    */
    IF lv_complete_status
     THEN
        maiwo.adjust_contract_figures(p_wol_id    => lr_wol.wol_id
                                     ,p_con_id    => lr_wo.wor_con_id
                                     ,p_operation => '+');
    ELSIF lv_not_done_status
     THEN
        maiwo.adjust_contract_figures(p_wol_id    => lr_wol.wol_id
                                     ,p_con_id    => lr_wo.wor_con_id
                                     ,p_operation => '-');
    END IF;
    --
  END process_boqs;
  --
  PROCEDURE update_wol
    IS
    --
    lv_wol_est_cost    work_order_lines.wol_est_cost%TYPE;
    lv_wol_est_labour  work_order_lines.wol_est_labour%TYPE;
    lv_wol_act_cost    work_order_lines.wol_act_cost%TYPE;
    lv_wol_act_labour  work_order_lines.wol_act_labour%TYPE;
    lv_invoice_status  work_order_lines.wol_invoice_status%TYPE;
    lv_date_complete   work_order_lines.wol_date_complete%TYPE;
    --
    PROCEDURE update_defect
      IS
      CURSOR c1(cp_defect_id       defects.def_defect_id%TYPE
               ,cp_rep_action_cat  repairs.rep_action_cat%TYPE)
          IS
      SELECT 1
        FROM repairs
       WHERE rep_def_defect_id = cp_defect_id
         AND rep_date_completed IS NULL
         AND rep_action_cat != cp_rep_action_cat;
      --
      lv_defect_complete  BOOLEAN;
      lv_dummy            NUMBER;
      --
    BEGIN
      /*
      ||Set The Completion Date On The Repair And The
      ||Defect (If There Are No Outstanding Repairs).
      */
      maiwo.update_defect_date(p_def_id         => lr_wol.wol_def_defect_id
                              ,p_date_compl     => lv_date_complete
                              ,p_works_order_no => lr_wol.wol_works_order_no
                              ,p_wol_id         => lr_wol.wol_id
                              ,p_hour_compl     => TO_NUMBER(TO_CHAR(lv_date_complete,'HH24'))
                              ,p_mins_compl     => TO_NUMBER(TO_CHAR(lv_date_complete,'MI')));
      /*
      ||Check Whether There Are Other Repairs For
      ||This Defect That Are Not Yet Complete.
      ||If All Are Complete Set The Status Of
      ||The Defect To Complete.
      */
      OPEN  c1(lr_wol.wol_def_defect_id
              ,lr_wol.wol_rep_action_cat);
      FETCH c1
       INTO lv_dummy;
      /*
      ||If No Other Repairs Found
      ||The Defect Is Complete.
      */
      lv_defect_complete := c1%NOTFOUND;
      CLOSE c1;
      --
      IF (lv_date_complete IS NOT NULL
          AND lv_defect_complete)
       OR lv_not_done_status
       THEN
          --
          UPDATE defects
             SET def_status_code = lv_def_status_code
                ,def_last_updated_date = SYSDATE
           WHERE def_defect_id = lr_wol.wol_def_defect_id
               ;
          --
      END IF;
      --
    END update_defect;
    --
  BEGIN
    --
    IF lv_complete_status
     THEN
        lv_date_complete := NVL(pi_date_complete,nvl(lr_wol.wol_date_repaired,sysdate));
    END IF;
    --
    SELECT SUM(NVL(boq_est_cost,0))   est_cost
          ,SUM(NVL(boq_est_labour,0)) est_labour
          ,SUM(boq_act_cost)   act_cost
          ,SUM(boq_est_labour) est_labour
      INTO lv_wol_est_cost
          ,lv_wol_est_labour
          ,lv_wol_act_cost
          ,lv_wol_act_labour
      FROM boq_items
     WHERE boq_wol_id = lr_wol.wol_id
         ;
    /*
    ||Update The Work Order Line.
    */
    UPDATE work_order_lines
       SET wol_status_code   = pi_new_status
          ,wol_est_cost      = lv_wol_est_cost
          ,wol_est_labour    = lv_wol_est_labour
          ,wol_act_cost      = lv_wol_act_cost
          ,wol_act_labour    = lv_wol_est_labour
          ,wol_date_complete = lv_date_complete
     WHERE wol_id = lr_wol.wol_id
         ;
    /*
    ||wo claims trigger will fire after this update creating a claim_payment
    ||record. Now then entry has been made we can set the invoice status
    */
    lv_invoice_status := maiwo.wol_invoice_status(p_wol_id => lr_wol.wol_id);
    --
    UPDATE work_order_lines
       SET wol_invoice_status = lv_invoice_status
     WHERE wol_id = lr_wol.wol_id;
    /*
    ||Update The Budget.
    */
    IF lv_not_done_status
     OR (lv_wol_act_cost IS NULL and lr_wol.wol_act_cost IS NOT NULL)
     THEN
        /*
        ||Work Has Not Been Done So Needs
        ||To Be Removed From The Budget.
        */
        IF NOT mai_budgets.budget_reversal(p_wol_id  => lr_wol.wol_id
                                          ,p_bud_id  => lr_wol.wol_bud_id
                                          ,p_wol_act => apply_balancing_sum(pi_con_id => lr_wo.wor_con_id
                                                                           ,pi_value  => (NVL(lv_wol_act_cost,0) - NVL(lr_wol.wol_act_cost,0)))
                                          ,p_wol_est => 0)
         THEN
            raise_application_error(-20047,'Budget Exceeded.');
        END IF;
    ELSE
        IF within_budget(pi_bud_id => lr_wol.wol_bud_id
                        ,pi_con_id => lr_wo.wor_con_id
                        ,pi_est    => lv_wol_est_cost - NVL(lr_wol.wol_est_cost,0)
                        ,pi_act    => lv_wol_act_cost - NVL(lr_wol.wol_act_cost,0)
                        ,pi_wol_id => lr_wol.wol_id)
         THEN
            add_to_budget(pi_wol_id => lr_wol.wol_id
                         ,pi_bud_id => lr_wol.wol_bud_id
                         ,pi_con_id => lr_wo.wor_con_id
                         ,pi_est    => lv_wol_est_cost - NVL(lr_wol.wol_est_cost,0)
                         ,pi_act    => lv_wol_act_cost - NVL(lr_wol.wol_act_cost,0));
        ELSE
            raise_application_error(-20047,'Budget Exceeded.');
        END IF;
    END IF;
    /*
    ||Create Interim Payment Records If Required.
    */
    IF lv_interim_status
     THEN
        IF NOT maiwo.create_interim_payment(p_wol_id   => lr_wol.wol_id
                                           ,p_act_cost => lv_wol_act_cost)
         THEN
            raise_application_error(-20107,'Cannot Enter A Valuation Less Than Previously Paid.');
        END IF;
    ELSIF lv_not_done_status
     THEN
        /*
        ||Work Not Done So Remove Any Unpaid Iterim Payments.
        */
        maiwo.clear_interim_payment(p_wol_id => lr_wol.wol_id);
    END IF;
    /*
    ||Where Appropriate Complete Any Defect/Repair Associated With The Line.
    */
    IF lr_wol.wol_def_defect_id IS NOT NULL
     THEN
        update_defect;
    END IF;
    --
  EXCEPTION
    WHEN value_error
     THEN
        raise_application_error(-20104,'Value Too Large When Calculating Work Order Line Totals.');
    WHEN others
     THEN
        RAISE;
  END update_wol;
  --
  PROCEDURE update_wor
    IS
    --
    PROCEDURE set_date_wor_closed
      IS
    BEGIN
      --
      SELECT MAX(wol_date_complete)
        INTO lv_wor_date_closed
        FROM work_order_lines
       WHERE wol_works_order_no = lr_wo.wor_works_order_no
           ;
      --
    END set_date_wor_closed;
    --
  BEGIN
    --
    SELECT SUM(wol_est_cost)   est_cost
          ,SUM(wol_est_labour) est_labour
          ,SUM(wol_act_cost)   act_cost
          ,SUM(wol_act_labour) act_labour
      INTO lv_wor_est_cost
          ,lv_wor_est_labour
          ,lv_wor_act_cost
          ,lv_wor_act_labour
      FROM work_order_lines
     WHERE wol_works_order_no = lr_wo.wor_works_order_no
         ;
    /*
    ||Get The Balancing Sums.
    */
    lv_wor_est_balancing_sum := get_balancing_sum(lr_wo.wor_con_id,lv_wor_est_cost);
    lv_wor_act_balancing_sum := get_balancing_sum(lr_wo.wor_con_id,lv_wor_act_cost);
    /*
    ||If This Is The Last Line On The Work Order
    ||To Be Completed Then Close The Work Order.
    */
    IF (pi_date_complete IS NOT NULL
        OR lv_not_done_status)
     AND maiwo.works_order_complete(p_works_order_no => lr_wo.wor_works_order_no) = 'TRUE'
     THEN
        set_date_wor_closed;
    END IF;
    /*
    ||Update The Work Order.
    */
    UPDATE work_orders
       SET wor_est_cost          = lv_wor_est_cost
          ,wor_est_balancing_sum = lv_wor_est_balancing_sum
          ,wor_est_labour        = lv_wor_est_labour
          ,wor_act_cost          = lv_wor_act_cost
          ,wor_act_balancing_sum = lv_wor_act_balancing_sum
          ,wor_act_labour        = lv_wor_act_labour
          ,wor_date_closed       = lv_wor_date_closed
          ,wor_closed_by_id      = DECODE(lv_wor_date_closed,NULL,NULL,pi_user_id)
     WHERE wor_works_order_no = lr_wo.wor_works_order_no
         ;
    --
  EXCEPTION
    WHEN value_error
     THEN
        raise_application_error(-20104,'Value Too Large When Calculating Work Order Totals.');
    WHEN others
     THEN
        RAISE;
  END update_wor;
  --
  PROCEDURE update_interfaces
    IS
    --
    lr_ne nm_elements_all%ROWTYPE;
    --
    lv_originator hig_users.hus_name%TYPE;
    lv_con_code   contracts.con_code%TYPE;
    --
    PROCEDURE get_con_code
      IS
    BEGIN
      SELECT con_code
        INTO lv_con_code
        FROM contracts
       WHERE con_id = lr_wo.wor_con_id
           ;
    END get_con_code;
    --
  BEGIN
    --
    nm_debug.debug('update_interfaces A');
    --
    IF interfaces_used(pi_con_id => lr_wo.wor_con_id)
     THEN
        --
        lv_originator := nm3get.get_hus(pi_hus_user_id => lr_wo.wor_peo_person_id).hus_name;
        --
        get_con_code;
        --
        interfaces.add_wor_to_list(p_trans_type   => 'A'
                                  ,p_wor_no       => lr_wo.wor_works_order_no
                                  ,p_wor_flag     => lr_wo.wor_flag
                                  ,p_scheme_type  => lr_wo.wor_scheme_type
                                  ,p_con_code     => lv_con_code
                                  ,p_originator   => lv_originator
                                  ,p_confirmed    => lr_wo.wor_date_confirmed
                                  ,p_est_complete => lr_wo.wor_est_complete
                                  ,p_est_cost     => lv_wor_act_cost
								  ,p_act_cost	  => lv_wor_est_cost
                                  ,p_labour       => lr_wo.wor_est_labour
                                  ,p_ip_flag      => lr_wo.wor_interim_payment_flag
                                  ,p_ra_flag      => lr_wo.wor_risk_assessment_flag
                                  ,p_ms_flag      => lr_wo.wor_method_statement_flag
                                  ,p_wp_flag      => lr_wo.wor_works_programme_flag
                                  ,p_as_flag      => lr_wo.wor_additional_safety_flag
                                  ,p_commence_by  => lr_wo.wor_commence_by
                                  ,p_descr        => lr_wo.wor_descr);
        --
        lr_ne := nm3get.get_ne(pi_ne_id => lr_wol.wol_rse_he_id);
        --
        interfaces.add_wol_to_list(lr_wol.wol_id
                                  ,lr_wol.wol_works_order_no
                                  ,lr_wol.wol_def_defect_id
                                  ,lr_wol.wol_schd_id
                                  ,lr_wol.wol_icb_work_code
                                  ,lr_ne.ne_unique
                                  ,lr_ne.ne_descr);
        --
        interfaces.copy_data_to_interface;
        --
    END IF;
    --
  END update_interfaces;
  --
BEGIN
  /*
  ||Get Details Of The Work Order and Work Order Line
  ||And Lock The Records For Update.
  */
  lr_wol := get_and_lock_wol(pi_wol_id => pi_wol_id);
  lr_wo := get_and_lock_wo(pi_works_order_no => lr_wol.wol_works_order_no);
  IF lr_wol.wol_def_defect_id IS NOT NULL
   THEN
      lr_defect := get_defect(pi_defect_id => lr_wol.wol_def_defect_id);
  END IF;
  /*
  ||For The Moment This Procedure Doesn't
  ||Support Cyclic Maintenance Work Orders.
  */
  IF lr_wo.wor_flag = 'M'
   THEN
      raise_application_error(-20073,'This API Does Not Support Cyclic Work Orders. Please Use The Forms Application To Work With Cyclic Work Orders.');
  END IF;
  /*
  ||If pi_date_complete Is Populated Check It.
  */
  validate_date_complete;
  /*
  ||Validate The Status Transition.
  */
  validate_wol_status_change;
  IF NOT lv_valid_transition
   THEN
      raise_application_error(-20097,'Invalid Status Transition : '||lv_reason);
  END IF;
  /*
  ||Process Any BOQs Supplied.
  */
  process_boqs;
  /*
  ||Update The Work Order Line.
  */
  update_wol;
  /*
  ||Update The Work Order.
  */
  update_wor;
  /*
  ||Update Interfaces If Required.
  */
  update_interfaces;
  /*
  ||Commit If Required.
  */
  IF NVL(pi_commit,'Y') = 'Y'
   THEN
      nm_debug.debug('Commit.');
      COMMIT;
  END IF;
  --
EXCEPTION
  WHEN OTHERS
   THEN
      ROLLBACK;
      RAISE;
END update_wol_status;
--
-----------------------------------------------------------------------------
--
PROCEDURE set_wol_held(pi_user_id       IN hig_users.hus_user_id%TYPE
                      ,pi_wol_id        IN work_order_lines.wol_id%TYPE
                      ,pi_date_complete IN work_order_lines.wol_date_complete%TYPE
                      ,pi_commit        IN VARCHAR2)
  IS
  --
  lv_held_status  hig_status_codes.hsc_status_code%TYPE;
  --
  lt_boqs act_boq_tab;
  --
  PROCEDURE get_held_status
    IS
  BEGIN
    SELECT hsc_status_code
      INTO lv_held_status
      FROM hig_status_codes
     WHERE hsc_domain_code = 'WORK_ORDER_LINES'
       AND hsc_allow_feature2 = 'Y'
       AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                              AND NVL(hsc_end_date  ,TRUNC(SYSDATE))
         ;
  EXCEPTION
    WHEN too_many_rows
     THEN
        raise_application_error(-20094,'Too Many Values Defined For Work Order Line HELD Status.');
    WHEN no_data_found
     THEN
        raise_application_error(-20095,'Cannot Obtain Value For Work Order Line HELD Status.');
    WHEN others
     THEN
        RAISE;
  END get_held_status;
  --
BEGIN
  /*
  ||Validate The User ID.
  */
  IF NOT validate_user_id(pi_user_id        => pi_user_id
                         ,pi_effective_date => TRUNC(SYSDATE))
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
  END IF;
  /*
  ||Update The WOL Status To HELD.
  */
  get_held_status;
  --
  update_wol_status(pi_user_id       => pi_user_id
                   ,pi_wol_id        => pi_wol_id
                   ,pi_new_status    => lv_held_status
                   ,pi_date_complete => pi_date_complete
                   ,pi_boq_tab       => lt_boqs
                   ,pi_commit        => pi_commit);
  --
EXCEPTION
  WHEN OTHERS
   THEN
      RAISE;
END set_wol_held;
--
-----------------------------------------------------------------------------
--
PROCEDURE set_wol_not_done(pi_user_id       IN hig_users.hus_user_id%TYPE
                          ,pi_wol_id        IN work_order_lines.wol_id%TYPE
                          ,pi_commit        IN VARCHAR2)
  IS
  --
  lv_not_done_status  hig_status_codes.hsc_status_code%TYPE;
  --
  lt_boqs act_boq_tab;
  --
  PROCEDURE get_not_done_status
    IS
  BEGIN
    SELECT hsc_status_code
      INTO lv_not_done_status
      FROM hig_status_codes
     WHERE hsc_domain_code = 'WORK_ORDER_LINES'
       AND hsc_allow_feature5 = 'Y'
       AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                              AND NVL(hsc_end_date  ,TRUNC(SYSDATE))
         ;
  EXCEPTION
    WHEN too_many_rows
     THEN
        raise_application_error(-20094,'Too Many Values Defined For Work Order Line NOT_DONE Status.');
    WHEN no_data_found
     THEN
        raise_application_error(-20095,'Cannot Obtain Value For Work Order Line NOT_DONE Status.');
    WHEN others
     THEN
        RAISE;
  END get_not_done_status;
  --
BEGIN
  /*
  ||Validate The User ID.
  */
  IF NOT validate_user_id(pi_user_id        => pi_user_id
                         ,pi_effective_date => TRUNC(SYSDATE))
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
  END IF;
  /*
  ||Update The WOL Status To NOT_DONE.
  */
  get_not_done_status;
  --
  update_wol_status(pi_user_id       => pi_user_id
                   ,pi_wol_id        => pi_wol_id
                   ,pi_new_status    => lv_not_done_status
                   ,pi_date_complete => NULL
                   ,pi_boq_tab       => lt_boqs
                   ,pi_commit        => pi_commit);
  --
EXCEPTION
  WHEN OTHERS
   THEN
      RAISE;
END set_wol_not_done;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_interim_payment(pi_user_id       IN hig_users.hus_user_id%TYPE
                                ,pi_wol_id  IN work_order_lines.wol_id%TYPE
                                ,pi_boq_tab IN act_boq_tab
                                ,pi_commit  IN VARCHAR2)
  IS
  --
  lv_interim_status  hig_status_codes.hsc_status_code%TYPE;
  --
  PROCEDURE get_interim_status
    IS
  BEGIN
    SELECT hsc_status_code
      INTO lv_interim_status
      FROM hig_status_codes
     WHERE hsc_domain_code = 'WORK_ORDER_LINES'
       AND hsc_allow_feature9 = 'Y'
       AND hsc_allow_feature4 != 'Y'
       AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                              AND NVL(hsc_end_date  ,TRUNC(SYSDATE))
         ;
  EXCEPTION
    WHEN too_many_rows
     THEN
        raise_application_error(-20094,'Too Many Values Defined For Work Order Line INTERIM Status.');
    WHEN no_data_found
     THEN
        raise_application_error(-20095,'Cannot Obtain Value For Work Order Line INTERIM Status.');
    WHEN others
     THEN
        RAISE;
  END get_interim_status;
  --
BEGIN
  /*
  ||Validate The User ID.
  */
  IF NOT validate_user_id(pi_user_id        => pi_user_id
                         ,pi_effective_date => TRUNC(SYSDATE))
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
  END IF;
  /*
  ||Update The WOL Status To INTERIM.
  */
  get_interim_status;
  --
  update_wol_status(pi_user_id       => pi_user_id
                   ,pi_wol_id        => pi_wol_id
                   ,pi_new_status    => lv_interim_status
                   ,pi_date_complete => NULL
                   ,pi_boq_tab       => pi_boq_tab
                   ,pi_commit        => pi_commit);
  --
EXCEPTION
  WHEN OTHERS
   THEN
      RAISE;
END create_interim_payment;
--
-----------------------------------------------------------------------------
--
PROCEDURE complete_wol(pi_user_id       IN hig_users.hus_user_id%TYPE
                      ,pi_wol_id        IN work_order_lines.wol_id%TYPE
                      ,pi_date_complete IN work_order_lines.wol_date_complete%TYPE
                      ,pi_boq_tab       IN act_boq_tab
                      ,pi_commit        IN VARCHAR2)
  IS
  --
  lv_complete_status  hig_status_codes.hsc_status_code%TYPE;
  --
  PROCEDURE get_complete_status
    IS
  BEGIN
    SELECT hsc_status_code
      INTO lv_complete_status
      FROM hig_status_codes
     WHERE hsc_domain_code = 'WORK_ORDER_LINES'
       AND hsc_allow_feature3 = 'Y'
       AND TRUNC(SYSDATE) BETWEEN NVL(hsc_start_date,TRUNC(SYSDATE))
                              AND NVL(hsc_end_date  ,TRUNC(SYSDATE))
         ;
  EXCEPTION
    WHEN too_many_rows
     THEN
        raise_application_error(-20094,'Too Many Values Defined For Work Order Line COMPLETE Status.');
    WHEN no_data_found
     THEN
        raise_application_error(-20095,'Cannot Obtain Value For Work Order Line COMPLETE Status.');
    WHEN others
     THEN
        RAISE;
  END get_complete_status;
  --
BEGIN
  /*
  ||Validate The User ID.
  */
  IF NOT validate_user_id(pi_user_id        => pi_user_id
                         ,pi_effective_date => TRUNC(SYSDATE))
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
  END IF;
  /*
  ||Update The WOL Status To INTERIM.
  */
  get_complete_status;
  --
  update_wol_status(pi_user_id       => pi_user_id
                   ,pi_wol_id        => pi_wol_id
                   ,pi_new_status    => lv_complete_status
                   ,pi_date_complete => NVL(pi_date_complete,SYSDATE)
                   ,pi_boq_tab       => pi_boq_tab
                   ,pi_commit        => pi_commit);
  --
EXCEPTION
  WHEN OTHERS
   THEN
      RAISE;
END complete_wol;
--
-----------------------------------------------------------------------------
--
PROCEDURE complete_wor(pi_user_id       IN hig_users.hus_user_id%TYPE
                      ,pi_works_order_no IN work_orders.wor_works_order_no%TYPE
                      ,pi_date_complete  IN work_order_lines.wol_date_complete%TYPE
                      ,pi_commit         IN VARCHAR2)
  IS
  --
  TYPE wol_id_tab IS TABLE OF work_order_lines.wol_id%TYPE;
  lt_wols wol_id_tab;
  --
  lt_boqs act_boq_tab;
  --
  PROCEDURE get_wols
    IS
  BEGIN
    SELECT wol_id
      BULK COLLECT
      INTO lt_wols
      FROM work_order_lines w
     WHERE w.wol_works_order_no = pi_works_order_no
       AND NOT EXISTS(SELECT 'x'
                        FROM hig_status_codes h
                       WHERE h.hsc_domain_code = 'WORK_ORDER_LINES'
                         AND (h.hsc_allow_feature2 = 'Y'
                              OR h.hsc_allow_feature3 = 'Y'
                              OR (h.hsc_allow_feature4 = 'Y' AND h.hsc_allow_feature9 = 'N')
                              OR h.hsc_allow_feature5 = 'Y')
                         AND h.hsc_status_code = w.wol_status_code
                         AND SYSDATE BETWEEN NVL(h.hsc_start_date, SYSDATE)
                                         AND NVL(h.hsc_end_date, SYSDATE))
         ;
  EXCEPTION
    WHEN no_data_found
     THEN
        raise_application_error(-20110,'Work Order Is Already Complete.');
    WHEN others
     THEN
        RAISE;
  END get_wols;
  --
BEGIN
  /*
  ||Validate The User ID.
  */
  IF NOT validate_user_id(pi_user_id        => pi_user_id
                         ,pi_effective_date => TRUNC(SYSDATE))
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
  END IF;
  /*
  ||Make Sure Work Order Is
  ||Not Already Complete.
  */
  IF maiwo.works_order_complete(p_works_order_no => pi_works_order_no) = 'TRUE'
   THEN
      raise_application_error(-20110,'Work Order Is Already Complete.');
  END IF;
  /*
  ||Get WOLs To Complete.
  */
  get_wols;
  /*
  ||Complete The WOLs.
  ||Completion Of The Last WOL Will Complete The Work Order.
  */
  FOR i IN 1..lt_wols.count LOOP
    --
    complete_wol(pi_user_id       => pi_user_id
                ,pi_wol_id        => lt_wols(i)
                ,pi_date_complete => pi_date_complete
                ,pi_boq_tab       => lt_boqs
                ,pi_commit        => 'N');
    --
  END LOOP;
  /*
  ||Now That All WOLs Have
  ||Been Completed Without
  ||Error Commit If Required
  */
  IF NVL(pi_commit,'Y') = 'Y'
   THEN
      COMMIT;
  END IF;
  --
EXCEPTION
  WHEN OTHERS
   THEN
      ROLLBACK;
      RAISE;
END complete_wor;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_gdo_for_mai3801(pi_report_id  IN  activities_report.are_report_id%TYPE
                                ,pi_defect_id  IN  defects.def_defect_id%TYPE
                                ,po_session_id OUT gis_data_objects.gdo_session_id%TYPE) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  --
  TYPE gdo_rec IS RECORD(gdo_session_id    gis_data_objects.gdo_session_id    %TYPE
                        ,gdo_pk_id         gis_data_objects.gdo_pk_id         %TYPE
                        ,gdo_rse_he_id     gis_data_objects.gdo_rse_he_id     %TYPE
                        ,gdo_st_chain      gis_data_objects.gdo_st_chain      %TYPE
                        ,gdo_end_chain     gis_data_objects.gdo_end_chain     %TYPE
                        ,gdo_x_val         gis_data_objects.gdo_x_val         %TYPE
                        ,gdo_y_val         gis_data_objects.gdo_y_val         %TYPE
                        ,gdo_theme_name    gis_data_objects.gdo_theme_name    %TYPE
                        ,gdo_feature_id    gis_data_objects.gdo_feature_id    %TYPE
                        ,gdo_xsp           gis_data_objects.gdo_xsp           %TYPE
                        ,gdo_offset        gis_data_objects.gdo_offset        %TYPE
                        ,gdo_seq_no        gis_data_objects.gdo_seq_no        %TYPE
                        ,gdo_dynamic_theme gis_data_objects.gdo_dynamic_theme %TYPE
                        ,gdo_string        gis_data_objects.gdo_string        %TYPE);
  TYPE gdo_tab IS TABLE OF gdo_rec INDEX BY BINARY_INTEGER;
  lt_gdo gdo_tab;
  --
  lv_session_id gis_data_objects.gdo_session_id%TYPE;
  lv_theme_id   nm_themes_all.nth_theme_id%TYPE := hig.get_user_or_sys_opt('SDODEFNTH');
  lv_theme_name nm_themes_all.nth_theme_name%TYPE;
  --
BEGIN
  --
  IF pi_report_id IS NOT NULL
   THEN
      SELECT NULL          -- gdo_session_id
            ,def_defect_id -- gdo_pk_id
            ,NULL          -- gdo_rse_he_id
            ,NULL          -- gdo_st_chain
            ,NULL          -- gdo_end_chain
            ,0             -- gdo_x_val
            ,0             -- gdo_y_val
            ,NULL          -- gdo_theme_name
            ,NULL          -- gdo_feature_id
            ,NULL          -- gdo_xsp
            ,NULL          -- gdo_offset
            ,0             -- gdo_seq_no
            ,'N'           -- gdo_dynamic_theme
            ,NULL          -- gdo_string
        BULK COLLECT
        INTO lt_gdo
        FROM defects
            ,activities_report
       WHERE are_report_id = pi_report_id
         AND are_report_id = def_are_report_id
           ;
  ELSIF pi_defect_id IS NOT NULL
   THEN
      lt_gdo(1).gdo_pk_id := pi_defect_id;
      lt_gdo(1).gdo_x_val := 0;
      lt_gdo(1).gdo_y_val := 0;
      lt_gdo(1).gdo_seq_no := 0;
      lt_gdo(1).gdo_dynamic_theme := 'N';
  END IF;
  --
  BEGIN
    IF lt_gdo.count > 0
     THEN
        SELECT gis_session_id.nextval
          INTO lv_session_id
          FROM dual
             ;
    END IF;
  EXCEPTION
   WHEN no_data_found
    THEN
       RAISE_APPLICATION_ERROR(-20001,'Cannot Get Next GDO_SESSION_ID');
   WHEN others
    THEN
       RAISE;
  END;
  --
  BEGIN
    IF lt_gdo.count > 0
     THEN
        SELECT nth_theme_name
          INTO lv_theme_name
          FROM nm_themes_all
         WHERE nth_theme_id = lv_theme_id
             ;
    END IF;
  EXCEPTION
   WHEN no_data_found
    THEN
       RAISE_APPLICATION_ERROR(-20002,'Please Set The User/Product Option SDODEFNTH To The Id Of A Valid Defect Layer.');
   WHEN others
    THEN
       RAISE;
  END;
  --
  FOR i IN 1..lt_gdo.count LOOP
    --
    lt_gdo(i).gdo_session_id := lv_session_id;
    lt_gdo(i).gdo_theme_name := lv_theme_name;
    --
  END LOOP;
  --
  FORALL i IN 1..lt_gdo.count
    INSERT
      INTO gis_data_objects
    VALUES lt_gdo(i)
         ;
  --
  COMMIT;
  --
  po_session_id := lv_session_id;
  --
END create_gdo_for_mai3801;
--
-----------------------------------------------------------------------------
--
PROCEDURE check_rules_overlap(pi_mawc_id         IN  mai_auto_wo_rule_criteria.mawc_id%TYPE
                             ,pi_admin_unit      IN  mai_auto_wo_rules.mawr_admin_unit%TYPE
                             ,pi_road_group_id   IN  mai_auto_wo_rules.mawr_road_group_id%TYPE
                             ,pi_activity        IN  mai_auto_wo_rule_criteria.mawc_atv_acty_area_code%TYPE
                             ,pi_priority        IN  mai_auto_wo_rule_criteria.mawc_priority%TYPE
                             ,pi_defect_code     IN  mai_auto_wo_rule_criteria.mawc_dty_defect_code%TYPE
                             ,pi_treatment       IN  mai_auto_wo_rule_criteria.mawc_tre_treat_code%TYPE
                             ,pi_include_temp    IN  mai_auto_wo_rule_criteria.mawc_include_temp_repair%TYPE
                             ,pi_include_perm    IN  mai_auto_wo_rule_criteria.mawc_include_perm_repair%TYPE
                             ,pi_start_date      IN  mai_auto_wo_rules.mawr_start_date%TYPE
                             ,pi_end_date        IN  mai_auto_wo_rules.mawr_end_date%TYPE
                             ,po_mawr_name       OUT mai_auto_wo_rules.mawr_name%TYPE
                             )
  IS
    CURSOR C_validate IS
    SELECT mawr_name
    FROM mai_auto_wo_rule_criteria,
         mai_auto_wo_rules
   WHERE mawc_mawr_id = mawr_id
     AND mawr_admin_unit IN
                     (SELECT hag_parent_admin_unit
                        FROM hig_admin_groups,
                             hig_admin_units
                       WHERE hag_direct_link='Y'
                         AND hau_admin_unit = hag_parent_admin_unit
                       START WITH hag_child_admin_unit = pi_admin_unit
                     CONNECT BY
                       PRIOR hag_parent_admin_unit=hag_child_admin_unit
                         AND hag_direct_link='Y'
                       UNION
                      SELECT pi_admin_unit
                        FROM dual)
     AND ((pi_road_group_id IN (SELECT nm_ne_id_of
                   FROM nm_members
                  WHERE nm_type = 'G'
                CONNECT BY
                  PRIOR nm_ne_id_of = nm_ne_id_in
                  START
                   WITH nm_ne_id_in = mawr_road_group_id)
               OR pi_road_group_id = NVL(mawr_road_group_id,pi_road_group_id)) 
           OR pi_road_group_id IS NULL)
     AND mawr_enabled = 'Y'
     AND mawc_enabled = 'Y'
     AND (pi_start_date BETWEEN mawr_start_date AND mawr_end_date OR
          pi_end_date   BETWEEN mawr_start_date AND mawr_end_date)
     AND mawc_atv_acty_area_code = pi_activity
     AND NVL(mawc_priority, '@') = NVL(pi_priority, '@')
     AND NVL(mawc_dty_defect_code, '@') = NVL(pi_defect_code, '@')
     AND NVL(mawc_tre_treat_code, '@') = NVL(pi_treatment, '@')
     AND (NVL(mawc_include_temp_repair, '@') = NVL(pi_include_temp, '@') OR
          NVL(mawc_include_perm_repair, '@') = NVL(pi_include_perm, '@'))
     AND mawc_id != pi_mawc_id;

BEGIN

   OPEN C_validate;
   FETCH C_validate INTO po_mawr_name;
   CLOSE C_validate;
   
END check_rules_overlap;
--
-----------------------------------------------------------------------------
--
PROCEDURE check_auto_wo_rules(pi_defect_id       IN  defects.def_defect_id%TYPE
                             ,pi_rse_he_id       IN  defects.def_rse_he_id%TYPE
                             ,pi_activity        IN  activities.atv_acty_area_code%TYPE
                             ,pi_priority        IN  defects.def_priority%TYPE
                             ,pi_defect_code     IN  def_types.dty_defect_code%TYPE
                             ,pi_rep_action_cat  IN  VARCHAR2
                             ,pi_treatment       IN  treatments.tre_treat_code%TYPE
                             ,pi_rep_date_due    IN  repairs.rep_date_due%TYPE
                             ,po_rule_id         OUT mai_auto_wo_rules.mawr_id%TYPE
                             ,po_scheme_type     OUT mai_auto_wo_rules.mawr_scheme_type%TYPE
                             ,po_bud_id          OUT mai_auto_wo_rules.mawr_bud_id%TYPE
                             ,po_con_id          OUT mai_auto_wo_rules.mawr_con_id%TYPE
                             ,po_aggregate       OUT mai_auto_wo_rules.mawr_aggregate_repairs%TYPE
                             ,po_auto_instruct   OUT mai_auto_wo_rule_criteria.mawc_auto_instruct%TYPE
                             ,po_create_wo       OUT VARCHAR2
                             ,po_error           OUT VARCHAR2
                             )
  IS
  --
  TYPE wo_criteria_rec IS RECORD
     (mawr_id                 mai_auto_wo_rules.mawr_id%TYPE
     ,mawr_scheme_type        mai_auto_wo_rules.mawr_scheme_type%TYPE
     ,mawr_bud_id             mai_auto_wo_rules.mawr_bud_id%TYPE
     ,mawr_con_id             mai_auto_wo_rules.mawr_con_id%TYPE
     ,mawr_aggregate_repairs  mai_auto_wo_rules.mawr_aggregate_repairs%TYPE
     ,mawc_auto_instruct      mai_auto_wo_rule_criteria.mawc_auto_instruct%TYPE);
  TYPE wo_criteria_tab IS TABLE OF wo_criteria_rec INDEX BY BINARY_INTEGER;
  --
  lt_criteria       wo_criteria_tab;
  --
  lv_admin_unit         hig_admin_units.hau_admin_unit%TYPE;
  lv_mawr_id            mai_auto_wo_rules.mawr_id%TYPE := NULL;
  lv_multiple_criteria  BOOLEAN := FALSE;
  --
BEGIN
  /*
  ||Get The Admin Unit Of the Defect Section.
  */
  nm_debug.debug('Looking up Admin Unit');
  lv_admin_unit := nm3net.get_ne(pi_rse_he_id).ne_admin_unit;

  nm_debug.debug('Checking rules for Admin Unit = '||lv_admin_unit||
                 ' Road Id = '||pi_rse_he_id);
  nm_debug.debug('Activity = '||pi_activity);
  nm_debug.debug('Priority = '||pi_priority);
  nm_debug.debug('Defect Code = '||pi_defect_code);
  nm_debug.debug('Action Cat = '||pi_rep_action_cat);
  nm_debug.debug('Treatment = '||pi_treatment);

  /*
  ||Check for matching rules.
  */
  BEGIN
    SELECT mawr_id
          ,mawr_scheme_type
          ,mawr_bud_id
          ,mawr_con_id
          ,mawr_aggregate_repairs
          ,NVL(mawc_auto_instruct, 'N')
     BULK COLLECT
     INTO lt_criteria
    FROM mai_auto_wo_rule_criteria,
         mai_auto_wo_rules
   WHERE mawc_mawr_id = mawr_id
     AND mawr_admin_unit IN
                     (SELECT hag_parent_admin_unit
                        FROM hig_admin_groups,
                             hig_admin_units
                       WHERE hag_direct_link='Y'
                         AND hau_admin_unit = hag_parent_admin_unit
                       START WITH hag_child_admin_unit = lv_admin_unit
                     CONNECT BY
                       PRIOR hag_parent_admin_unit=hag_child_admin_unit
                         AND hag_direct_link='Y'
                       UNION
                      SELECT lv_admin_unit
                        FROM dual)
     AND (pi_rse_he_id IN (SELECT nm_ne_id_of
                   FROM nm_members
                  WHERE nm_type = 'G'
                CONNECT BY
                  PRIOR nm_ne_id_of = nm_ne_id_in
                  START
                   WITH nm_ne_id_in = mawr_road_group_id)
               OR pi_rse_he_id = NVL(mawr_road_group_id,pi_rse_he_id))
     AND mawr_enabled = 'Y'
     AND mawc_enabled = 'Y'
     AND pi_rep_date_due BETWEEN mawr_start_date AND
                             NVL(mawr_end_date, pi_rep_date_due)
     AND mawc_atv_acty_area_code = pi_activity
     AND NVL(mawc_priority, NVL(pi_priority, '@')) = NVL(pi_priority, '@')
     AND NVL(mawc_dty_defect_code, NVL(pi_defect_code, '@')) = NVL(pi_defect_code, '@')
     AND pi_rep_action_cat IN (DECODE(mawc_include_temp_repair, 'Y', 'T', '@'),
                               DECODE(mawc_include_perm_repair, 'Y', 'P', '@'))
     AND NVL(mawc_tre_treat_code, NVL(pi_treatment, '@')) = NVL(pi_treatment, '@');

     IF lt_criteria.count = 0
       THEN
         --po_error:= 'No matching Automatic Work Order creation criteria found for Defect '||pi_defect_id;
         nm_debug.debug('No matching Automatic Work Order creation criteria found for Defect '||pi_defect_id);
         po_create_wo := 'N';
     ELSE
         FOR i IN 1 .. lt_criteria.count LOOP

            /*
            || If mawr_id does not match previous non-null value, got
            || multiple matching rules
            */
            IF NVL(lv_mawr_id, lt_criteria(i).mawr_id) != lt_criteria(i).mawr_id
              THEN
               lv_multiple_criteria := TRUE;
               EXIT;
            END IF;

            /*
            || Check if any auto instruct = 'Y' for any matching criteria
            */
            IF lt_criteria(i).mawc_auto_instruct = 'Y'
              THEN
               po_auto_instruct := 'Y';

            END IF;

            po_rule_id      := lt_criteria(i).mawr_id;
            po_scheme_type  := lt_criteria(i).mawr_scheme_type;
            po_bud_id       := lt_criteria(i).mawr_bud_id;
            po_con_id       := lt_criteria(i).mawr_con_id;
            po_aggregate    := lt_criteria(i).mawr_aggregate_repairs;

            lv_mawr_id := lt_criteria(i).mawr_id;

         END LOOP;
         --
         IF lv_multiple_criteria
          THEN
             po_rule_id     := NULL;
             po_scheme_type := NULL;
             po_bud_id      := NULL;
             po_con_id      := NULL;
             po_aggregate   := NULL;
             po_error       := 'Multiple Automatic Work Order creation criteria found for Defect '||pi_defect_id||
                               ' Repair Type '||pi_rep_action_cat;
             po_create_wo   := 'N';
         ELSE
             po_create_wo := 'Y';
         END IF;

      END IF;
         --
  END;

END check_auto_wo_rules;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_auto_defect_wo(pi_defect_id         IN     defects.def_defect_id%TYPE
                               ,po_work_order_tab       OUT works_order_tab)
  IS
  --
  lv_user_id           hig_users.hus_user_id%TYPE := nm3user.get_user_id;
  lv_wo_descr          work_orders.wor_descr%TYPE := 'Auto Work Order For Defect '||TO_CHAR(pi_defect_id)||
                                                     ' created on '||TO_CHAR(TRUNC(SYSDATE),'DD-MON-YYYY');
  lv_rule_id           mai_auto_wo_rules.mawr_id%TYPE;
  lv_scheme_type       work_orders.wor_scheme_type%TYPE;
  lv_con_id            contracts.con_id%TYPE;
  lv_bud_id            budgets.bud_id%TYPE;
  lv_aggregate         mai_auto_wo_rules.mawr_aggregate_repairs%TYPE;
  lv_interim_payment   work_orders.wor_interim_payment_flag%TYPE;
  lv_priority          work_orders.wor_priority%TYPE;
  lv_cost_centre       work_orders.wor_coc_cost_centre%TYPE;
  lv_road_group        nm_elements_all.ne_id%TYPE;
  lv_tma_register_flag work_orders.wor_register_flag%TYPE;
  lv_contact           work_orders.wor_contact%TYPE;
  lv_job_number        work_orders.wor_job_number%TYPE;
  lv_rechargeable      work_orders.wor_rechargeable%TYPE;
  lv_date_raised       DATE;
  lv_target_date       DATE;
  lv_required          VARCHAR2(1);
  lv_instruct          VARCHAR2(1);
  lv_commit            VARCHAR2(1) := 'Y';
  lv_error             nm3type.max_varchar2;
  --
  lt_defects_in        mai_wo_api.def_rep_list_in_tab;
  lt_defects_noagg     mai_wo_api.def_rep_list_in_tab;
  lt_defect_boqs       mai_wo_api.boq_tab;
  TYPE wo_rule_rec IS RECORD(rule_id     mai_auto_wo_rules.mawr_id%TYPE
                            ,scheme_type work_orders.wor_scheme_type%TYPE
                            ,con_id      contracts.con_id%TYPE
                            ,instruct    BOOLEAN);
  TYPE wo_rule_tab IS TABLE OF wo_rule_rec INDEX BY BINARY_INTEGER;
  lt_rules  wo_rule_tab;
  --
  lv_work_order_no      work_orders.wor_works_order_no%TYPE;
  lt_defects_on_wo      mai_wo_api.def_rep_list_on_wo_tab;
  lt_defects_not_on_wo  mai_wo_api.def_rep_list_not_on_wo_tab;
  --
  lv_create_work_order    BOOLEAN := FALSE;
  lv_instruct_work_order  BOOLEAN := FALSE;
  lv_multiple_rules       BOOLEAN := FALSE;
  --
  lv_tab_ind  BINARY_INTEGER;
  --
  PROCEDURE build_def_rep_list(pi_defect_id IN defects.def_defect_id%TYPE)
    IS
    --
    TYPE defect_repairs_rec IS RECORD(def_defect_id            defects.def_defect_id%TYPE
                                     ,def_rse_he_id            defects.def_rse_he_id%TYPE
                                     ,def_atv_acty_area_code   defects.def_atv_acty_area_code%TYPE
                                     ,def_defect_code          defects.def_defect_code%TYPE
                                     ,def_priority             defects.def_priority%TYPE
                                     ,rep_tre_treat_code       repairs.rep_tre_treat_code%TYPE
                                     ,rep_action_cat           repairs.rep_action_cat%TYPE
                                     ,rep_date_due             DATE);
    TYPE defect_repairs_tab IS TABLE OF defect_repairs_rec;
    lt_defect_repairs defect_repairs_tab;
    --
    PROCEDURE get_repairs
      IS
    BEGIN
      SELECT def_defect_id
            ,def_rse_he_id
            ,def_atv_acty_area_code
            ,def_defect_code
            ,def_priority
            ,rep_tre_treat_code
            ,rep_action_cat
            ,rep_date_due
        BULK COLLECT
        INTO lt_defect_repairs
        FROM repairs
            ,defects
       WHERE def_defect_id = pi_defect_id
         AND def_defect_id = rep_def_defect_id
         AND rep_action_cat IN('P','T')
       ORDER BY rep_action_cat desc
           ;
    EXCEPTION
      WHEN no_data_found
       THEN
          raise_application_error(-20001,'No Repairs Found For Defect: '||TO_CHAR(pi_defect_id));
      WHEN others
       THEN
          RAISE;
    END get_repairs;
  BEGIN
    --

    nm_debug.debug('Attempting Auto WO creation for Defect = '||pi_defect_id);
    --
    get_repairs;
    --
    nm_debug.debug(lt_defect_repairs.count||' details found');
    --
    FOR i IN 1..lt_defect_repairs.count LOOP
      check_auto_wo_rules(pi_defect_id       =>pi_defect_id
                         ,pi_rse_he_id       => lt_defect_repairs(i).def_rse_he_id
                         ,pi_activity        => lt_defect_repairs(i).def_atv_acty_area_code
                         ,pi_priority        => lt_defect_repairs(i).def_priority
                         ,pi_defect_code     => lt_defect_repairs(i).def_defect_code
                         ,pi_rep_action_cat  => lt_defect_repairs(i).rep_action_cat
                         ,pi_treatment       => lt_defect_repairs(i).rep_tre_treat_code
                         ,pi_rep_date_due    => lt_defect_repairs(i).rep_date_due
                         ,po_rule_id         => lv_rule_id
                         ,po_scheme_type     => lv_scheme_type
                         ,po_bud_id          => lv_bud_id
                         ,po_con_id          => lv_con_id
                         ,po_aggregate       => lv_aggregate
                         ,po_auto_instruct   => lv_instruct
                         ,po_create_wo       => lv_required
                         ,po_error           => lv_error);

      IF lv_required = 'Y'
       THEN
          lv_create_work_order := TRUE;
      END IF;
      --
      IF lv_instruct = 'Y'
       THEN
          lv_instruct_work_order := TRUE;
      END IF;
nm_debug.debug('Required = '||lv_required||' instruct = '||lv_instruct);
nm_debug.debug('lv_error = '||lv_error);
nm_debug.debug('lv_con_id = '||lv_con_id);

      IF lv_error IS NOT NULL
       THEN
         lv_tab_ind := gt_work_orders.count+1;
         gt_work_orders(lv_tab_ind).defect_id := pi_defect_id;
         gt_work_orders(lv_tab_ind).error     := lv_error;
      END IF;

      IF lv_required = 'Y'
       THEN
          lt_defects_in(lt_defects_in.count+1).dlt_defect_id    := pi_defect_id;
          lt_defects_in(lt_defects_in.count).dlt_rep_action_cat := lt_defect_repairs(i).rep_action_cat;
          lt_defects_in(lt_defects_in.count).dlt_budget_id      := lv_bud_id;
          lt_rules(lt_defects_in.count).rule_id     := lv_rule_id;
          lt_rules(lt_defects_in.count).scheme_type := lv_scheme_type;
          lt_rules(lt_defects_in.count).con_id      := lv_con_id;
          lt_rules(lt_defects_in.count).instruct    := (lv_instruct = 'Y');
      END IF;

    END LOOP;
    /*
    ||Check for multiple rules.
    ||NB, checking against previous record in
    ||table so start the loop at index 2.
    */
    FOR i IN 2..lt_rules.count LOOP
      IF lt_rules(i).rule_id != lt_rules(i-1).rule_id
       THEN
          lv_multiple_rules := TRUE;
          exit;
      END IF;
    END LOOP;
    --
  END build_def_rep_list;
  --
  PROCEDURE create_work_order(pi_defects     IN mai_wo_api.def_rep_list_in_tab
                             ,pi_scheme_type IN work_orders.wor_scheme_type%TYPE
                             ,pi_con_id      IN contracts.con_id%TYPE
                             ,pi_instruct    IN BOOLEAN)
    IS
  BEGIN
    IF lv_create_work_order
     THEN
        --
  nm_debug.debug('Creating WO');
        lv_tab_ind := gt_work_orders.count+1;

        create_defect_work_order(pi_user_id           => lv_user_id
                                ,pi_wo_descr          => lv_wo_descr
                                ,pi_scheme_type       => pi_scheme_type
                                ,pi_con_id            => pi_con_id
                                ,pi_interim_payment   => lv_interim_payment
                                ,pi_priority          => lv_priority
                                ,pi_cost_centre       => lv_cost_centre
                                ,pi_road_group_id     => lv_road_group
                                ,pi_tma_register_flag => lv_tma_register_flag
                                ,pi_contact           => lv_contact
                                ,pi_job_number        => lv_job_number
                                ,pi_rechargeable      => lv_rechargeable
                                ,pi_date_raised       => lv_date_raised
                                ,pi_target_date       => lv_target_date
                                ,pi_defects           => pi_defects
                                ,pi_defect_boqs       => lt_defect_boqs
                                ,pi_commit            => lv_commit
                                ,po_work_order_no     => lv_work_order_no
                                ,po_defects_on_wo     => lt_defects_on_wo
                                ,po_defects_not_on_wo => lt_defects_not_on_wo);
        --
  nm_debug.debug('WO No = '||lv_work_order_no);
        gt_work_orders(lv_tab_ind).defect_id := pi_defect_id;
        gt_work_orders(lv_tab_ind).works_order_no := lv_work_order_no;
        --
        IF lt_defects_not_on_wo.count > 0
         THEN
            FOR i IN 1..lt_defects_not_on_wo.count LOOP
              IF i > 1
               THEN
                  gt_work_orders(lv_tab_ind).error := gt_work_orders(lv_tab_ind).error||CHR(10);
              END IF;
              gt_work_orders(lv_tab_ind).error := gt_work_orders(lv_tab_ind).error
                                                ||'Defect Id: '||lt_defects_not_on_wo(i).defect_id
                                                ||' Repair Type: '|| lt_defects_not_on_wo(i).rep_action_cat
                                                ||' was not added to the Work Order because: '
                                                ||lt_defects_not_on_wo(i).reason;

            END LOOP;
        END IF;
        --
    END IF;
    --
    IF pi_instruct
     AND lv_work_order_no IS NOT NULL
     THEN
        --
        instruct_work_order(pi_user_id         => lv_user_id
                           ,pi_works_order_no  => lv_work_order_no
                           ,pi_date_instructed => SYSDATE
                           ,pi_commit          => 'Y');
        --
        gt_work_orders(lv_tab_ind).instructed := 'Y';
        --
    END IF;
  END create_work_order;

BEGIN
nm_debug.debug_on;
  gt_work_orders.DELETE;
  /*
  ||Build the list of repairs to go on the WO.
  */
  build_def_rep_list(pi_defect_id => pi_defect_id);

  /*
  ||Check if auto create criteria matched
  */
   IF lt_defects_in.count > 0
   THEN
      /*
      ||Call The API To Create The Work Order.
      */
      IF lv_aggregate = 'Y'
       AND NOT lv_multiple_rules
       THEN
          /*
          ||The aggregate flag is set and only one
          ||rule has been found so create a single
          ||Work Order for all elegible repairs
          ||and just pass in the data from the
          ||first record in the rules table.
          */
          create_work_order(pi_defects     => lt_defects_in
                           ,pi_scheme_type => lt_rules(1).scheme_type
                           ,pi_con_id      => lt_rules(1).con_id
                           ,pi_instruct    => lv_instruct_work_order);
      ELSE
          /*
          ||Create A Work Order Per Repair.
          */
          FOR k IN 1 .. lt_defects_in.count LOOP
            --
            lt_defects_noagg(1) := lt_defects_in(k);
            --
            BEGIN
              create_work_order(pi_defects     => lt_defects_noagg
                               ,pi_scheme_type => lt_rules(k).scheme_type
                               ,pi_con_id      => lt_rules(k).con_id
                               ,pi_instruct    => lt_rules(k).instruct);
            EXCEPTION
              WHEN others
               THEN
                  gt_work_orders(lv_tab_ind).defect_id := pi_defect_id;
                  gt_work_orders(lv_tab_ind).error := SQLERRM;
            END;
            --
          END LOOP;
      END IF;
  END IF;
  --
  po_work_order_tab := gt_work_orders;
  --
nm_debug.debug_off;
EXCEPTION
  WHEN others
   THEN
      gt_work_orders(lv_tab_ind).defect_id := pi_defect_id;
      gt_work_orders(lv_tab_ind).error := SQLERRM;
      po_work_order_tab := gt_work_orders;
      --RAISE;
END create_auto_defect_wo;
--
-----------------------------------------------------------------------------
--
FUNCTION get_wol_target_date(pi_date_raised IN DATE
                            ,pi_activity    IN activities.atv_acty_area_code%TYPE
                            ,pi_priority    IN defects.def_priority%TYPE
                            ,pi_action_cat  IN repairs.rep_action_cat%TYPE
                            ,pi_rse_he_id   IN nm_elements_all.ne_id%TYPE)
  RETURN DATE IS
  --
  lv_retval DATE;
  lv_dummy  NUMBER;
  --
BEGIN
  --
  mai.rep_date_due(pi_date_raised
                  ,pi_activity
                  ,pi_priority
                  ,pi_action_cat
                  ,pi_rse_he_id
                  ,lv_retval
                  ,lv_dummy);
  --
  RETURN lv_retval;
  --
END get_wol_target_date;
--
-----------------------------------------------------------------------------
--
--PROCEDURE create_small_scheme_work_order(pi_user_id           IN  hig_users.hus_user_id%TYPE
--                                        ,pi_wo_descr          IN  work_orders.wor_descr%TYPE
--                                        ,pi_scheme_type       IN  work_orders.wor_scheme_type%TYPE
--                                        ,pi_con_id            IN  contracts.con_id%TYPE
--                                        ,pi_interim_payment   IN  work_orders.wor_interim_payment_flag%TYPE
--                                        ,pi_priority          IN  work_orders.wor_priority%TYPE
--                                        ,pi_cost_centre       IN  work_orders.wor_coc_cost_centre%TYPE
--                                        ,pi_road_group_id     IN  nm_elements_all.ne_id%TYPE
--                                        ,pi_tma_register_flag IN  work_orders.wor_register_flag%TYPE
--                                        ,pi_contact           IN  work_orders.wor_contact%TYPE
--                                        ,pi_job_number        IN  work_orders.wor_job_number%TYPE
--                                        ,pi_rechargeable      IN  work_orders.wor_rechargeable%TYPE
--                                        ,pi_date_raised       IN  work_orders.wor_date_raised%TYPE
--                                        ,pi_target_date       IN  work_orders.wor_est_complete%TYPE
--                                        ,pi_sections          IN  sections_list_in_tab
--                                        ,pi_commit            IN  VARCHAR2
--                                        ,po_work_order_no     OUT work_orders.wor_works_order_no%TYPE)
--  IS
--  --
--  lv_work_order_no  work_orders.wor_works_order_no%TYPE;
--  --
--  lv_sys_flag           VARCHAR2(1);
--  lv_worrefgen          hig_option_values.hov_value%TYPE := hig.get_sysopt('WORREFGEN');
--  lv_gisgrptyp          hig_option_values.hov_value%TYPE := hig.get_sysopt('GISGRPTYP');
--  lv_gisgrpl            hig_option_values.hov_value%TYPE := hig.get_sysopt('GISGRPL');
--  lv_gisgrpd            hig_option_values.hov_value%TYPE := hig.get_sysopt('GISGRPD');
--  lv_dumconcode         hig_option_values.hov_value%TYPE := NVL(hig.get_sysopt('DUMCONCODE'),'DEFAULT');
--  lv_scheme_type_upd    hig_option_values.hov_value%TYPE := NVL(hig.get_user_or_sys_opt('DEFSCHTYPU'),'Y');
--  lv_def_scheme_type_l  hig_option_values.hov_value%TYPE := NVL(hig.get_user_or_sys_opt('DEFSCHTYPL'),'LR');
--  lv_def_scheme_type_d  hig_option_values.hov_value%TYPE := NVL(hig.get_user_or_sys_opt('DEFSCHTYPD'),'RD');
--  lv_user_admin_unit    nm_admin_units_all.nau_admin_unit%TYPE;
--  lv_road_group_id      nm_elements_all.ne_id%TYPE;
--  lv_rse_admin_unit     nm_admin_units_all.nau_admin_unit%TYPE;
--  lv_rse_sys_flag       VARCHAR2(1);
--  lv_work_code          item_code_breakdowns.icb_work_code%TYPE;
--  lv_scheme_type        work_orders.wor_scheme_type%TYPE;
--  lv_con_admin_unit     nm_admin_units_all.nau_admin_unit%TYPE;
--  lv_discount_group     org_units.oun_cng_disc_group%TYPE;
--  lv_wor_admin_unit     nm_admin_units_all.nau_admin_unit%TYPE;
--  lv_bud_rse_he_id      nm_elements_all.ne_id%TYPE;
--  lv_icb_id             item_code_breakdowns.icb_id%TYPE;
--  lv_date_raised        work_orders.wor_date_raised%TYPE;
--  --
--  lv_wor_est_cost          work_orders.wor_est_cost%TYPE := 0;
--  lv_wor_est_labour        work_orders.wor_est_labour%TYPE := 0;
--  lv_wor_est_balancing_sum work_orders.wor_est_balancing_sum%TYPE := 0;
--  --
--  lv_wol_not_done    hig_status_codes.hsc_status_code%TYPE;
--  lv_wol_instructed  hig_status_codes.hsc_status_code%TYPE;
--  lv_def_instructed  hig_status_codes.hsc_status_code%TYPE;
--  lv_def_available   hig_status_codes.hsc_status_code%TYPE;
--  --
--  lv_wol_null_boq_exists BOOLEAN := FALSE;
--  lv_wor_null_boq_exists BOOLEAN := FALSE;
--  --
--  lt_selected_sections  sections_list_in_tab;
--  --
--  TYPE wol_rec IS RECORD(wol_id              work_order_lines.wol_id%TYPE
--                        ,wol_works_order_no  work_order_lines.wol_works_order_no%TYPE
--                        ,wol_rse_he_id       work_order_lines.wol_rse_he_id%TYPE
--                        ,wol_siss_id         work_order_lines.wol_siss_id%TYPE
--                        ,wol_icb_work_code   work_order_lines.wol_icb_work_code%TYPE
--                        ,wol_act_area_code   work_order_lines.wol_act_area_code%TYPE
--                        ,wol_def_defect_id   work_order_lines.wol_def_defect_id%TYPE
--                        ,wol_rep_action_cat  work_order_lines.wol_rep_action_cat%TYPE
--                        ,wol_flag            work_order_lines.wol_flag%TYPE
--                        ,wol_status_code     work_order_lines.wol_status_code%TYPE
--                        ,wol_wor_flag        work_order_lines.wol_wor_flag%TYPE
--                        ,wol_date_created    work_order_lines.wol_date_created%TYPE
--                        ,wol_bud_id          work_order_lines.wol_bud_id%TYPE
--                        ,wol_est_cost        work_order_lines.wol_est_cost%TYPE
--                        ,wol_est_labour      work_order_lines.wol_est_labour%TYPE);
--  TYPE wol_tab IS TABLE OF wol_rec INDEX BY BINARY_INTEGER;
--  lt_wol wol_tab;
--  --
--  lt_boq boq_tab;
--  lv_boq_tab_ind PLS_INTEGER := 1;
--  --
--  TYPE selected_repairs_rec IS RECORD(rep_rse_he_id          repairs.rep_rse_he_id%TYPE
--                                     ,def_siss_id            defects.def_siss_id%TYPE
--                                     ,def_priority           defects.def_priority%TYPE
--                                     ,rep_atv_acty_area_code repairs.rep_atv_acty_area_code%TYPE
--                                     ,rep_def_defect_id      repairs.rep_def_defect_id%TYPE
--                                     ,rep_action_cat         repairs.rep_action_cat%TYPE
--                                     ,bud_id                 budgets.bud_id%TYPE
--                                     ,work_code              item_code_breakdowns.icb_work_code%TYPE);
--  TYPE selected_repairs_tab IS TABLE OF selected_repairs_rec INDEX BY BINARY_INTEGER;
--  lt_selected_repairs selected_repairs_tab;
--  --
--  TYPE repair_boqs_rec IS RECORD(boq_id            boq_items.boq_id%TYPE
--                                ,boq_sta_item_code boq_items.boq_sta_item_code%TYPE
--                                ,boq_est_quantity  boq_items.boq_est_quantity%TYPE
--                                ,boq_est_labour    boq_items.boq_est_labour%TYPE
--                                ,sta_rogue_flag    standard_items.sta_rogue_flag%TYPE);
--  TYPE repair_boqs_tab IS TABLE OF repair_boqs_rec INDEX BY BINARY_INTEGER;
--  lt_repair_boqs repair_boqs_tab;
--  --
--  PROCEDURE init_defaults
--    IS
--    --
--    PROCEDURE set_date_raised
--      IS
--    BEGIN
--      IF pi_date_raised IS NOT NULL
--       THEN
--          IF pi_date_raised > SYSDATE
--           THEN
--              raise_application_error(-20084,'Date Raised Must Be Less Than Or Equal To Todays Date.');
--          ELSE
--              lv_date_raised := pi_date_raised;
--          END IF;
--      ELSE
--          lv_date_raised := SYSDATE;
--      END IF;
--    END set_date_raised;
--    --
--    PROCEDURE ins_section_list_temp
--      IS
--      --
--      lv_matching_sections NUMBER;
--      --
--    BEGIN
--      /*
--      ||If pi_commit wasn't 'Y' the last time
--      ||the procedure was called there may still
--      ||be records in the temp table.
--      */
--      DELETE
--        FROM section_list_temp;
--      /*
--      ||Insert the supplied Defect Ids
--      ||into the temp table.
--      */
--      nm_debug.debug('inserting '||pi_sections.count||'records into defect_list_temp');
--      FOR i IN 1..pi_sections.count LOOP
--        INSERT
--          INTO section_list_temp
--              (slt_ne_id
--              ,slt_budget_id)
--        VALUES(pi_sections(i).ne_id
--              ,pi_sections(i).budget_id)
--             ;
--      END LOOP;
--      /*
--      ||Make sure all supplied Defect Ids exist.
--      */
--      SELECT count(*)
--        INTO lv_matching_sections
--        FROM road_sections
--       WHERE rse_he_id IN(SELECT slt_ne_id
--                            FROM section_list_temp)
--           ;
--      --
--      IF lv_matching_sections != pi_sections.count
--       THEN
--          raise_application_error(-20072,'Supplied List Of Sections Contains Invalid Ids');
--      END IF;
--      --
--    EXCEPTION
--      WHEN dup_val_on_index
--       THEN
--          raise_application_error(-20071,'Supplied List Of Sections Contains Duplicates');
--      WHEN others
--       THEN
--          RAISE;
--    END ins_section_list_temp;
--    --
--    PROCEDURE validate_user
--      IS
--    BEGIN
--      SELECT hus_admin_unit
--        INTO lv_user_admin_unit
--        FROM hig_users
--       WHERE hus_user_id = pi_user_id
--           ;
--    EXCEPTION
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_user_id)||'].');
--      WHEN others
--       THEN
--          RAISE;
--    END validate_user;
--    --
--    PROCEDURE validate_contract
--      IS
--      --
--      lv_con_code contracts.con_code%TYPE;
--      --
--    BEGIN
--      SELECT con_code
--            ,con_admin_org_id
--            ,oun_cng_disc_group
--        INTO lv_con_code
--            ,lv_con_admin_unit
--            ,lv_discount_group
--        FROM org_units
--            ,contracts
--       WHERE con_id = pi_con_id
--         AND TRUNC(lv_date_raised) BETWEEN NVL(con_start_date, TRUNC(lv_date_raised))
--                                       AND NVL(con_end_date  , TRUNC(lv_date_raised))
--         AND ((con_admin_org_id IN(SELECT hag_child_admin_unit
--                                     FROM hig_admin_groups
--                                    WHERE hag_parent_admin_unit = lv_user_admin_unit))
--              OR con_code = lv_dumconcode)
--         AND con_contr_org_id = oun_org_id
--           ;
--      --
--      IF lv_con_code = lv_dumconcode
--       THEN
--          lv_wor_admin_unit := lv_con_admin_unit;
--      ELSE
--          lv_wor_admin_unit := lv_user_admin_unit;
--      END IF;
--      --
--    EXCEPTION
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20063,'Invalid Contract Id Supplied.');
--      WHEN others
--       THEN
--          RAISE;
--    END validate_contract;
--    --
--    PROCEDURE validate_interim_flag
--      IS
--    BEGIN
--      --
--      IF pi_interim_payment IS NOT NULL
--       AND pi_interim_payment NOT IN ('Y', 'N')
--       THEN
--          raise_application_error(-20081,'Invalid Interim Flag Supplied.');
--      END IF;
--      --
--    END validate_interim_flag;
--    --
--    PROCEDURE validate_rechargeable
--      IS
--    BEGIN
--      --
--      IF pi_rechargeable IS NOT NULL
--       AND pi_rechargeable NOT IN ('Y', 'N')
--       THEN
--          raise_application_error(-20089,'Invalid Rechargeable Flag Supplied.');
--      END IF;
--      --
--    END validate_rechargeable;
--    --
--    PROCEDURE validate_tma_register_flag(pi_flag IN VARCHAR2)
--      IS
--    BEGIN
--      --
--      IF pi_flag IS NOT NULL
--       AND pi_flag NOT IN ('Y', 'N')
--       THEN
--          raise_application_error(-20088,'Invalid TMA Register Flag Supplied.');
--      END IF;
--      --
--    END validate_tma_register_flag;
--    --
--    PROCEDURE validate_wo_priority
--      IS
--      --
--      lv_dummy NUMBER;
--      --
--    BEGIN
--      --
--      IF pi_priority IS NOT NULL
--       THEN
--          SELECT 1
--            INTO lv_dummy
--            FROM hig_codes
--           WHERE hco_domain = 'WOR_PRIORITY'
--             AND hco_code   = pi_priority
--             AND TRUNC(lv_date_raised) BETWEEN NVL(hco_start_date, TRUNC(lv_date_raised))
--                                           AND NVL(hco_end_date, TRUNC(lv_date_raised))
--               ;
--      END IF;
--      --
--    EXCEPTION
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20082,'Invalid Work Order Priority Supplied.');
--      WHEN others
--       THEN
--          RAISE;
--    END validate_wo_priority;
--    --
--    PROCEDURE validate_cost_centre
--      IS
--      --
--      lv_dummy NUMBER;
--      --
--    BEGIN
--      --
--      IF pi_cost_centre IS NOT NULL
--       THEN
--          SELECT 1
--            INTO lv_dummy
--            FROM cost_centres
--                ,hig_admin_groups
--           WHERE hag_parent_admin_unit = lv_user_admin_unit
--             AND hag_child_admin_unit  = coc_org_id
--             AND coc_cost_centre       = pi_cost_centre
--             AND TRUNC(lv_date_raised) BETWEEN NVL(coc_start_date, TRUNC(lv_date_raised))
--                                           AND NVL(coc_end_date, TRUNC(lv_date_raised))
--               ;
--      END IF;
--      --
--    EXCEPTION
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20080,'Invalid Cost Centre Supplied.');
--      WHEN others
--       THEN
--          RAISE;
--    END validate_cost_centre;
--    --
--    PROCEDURE validate_target_complete
--      IS
--      --
--      lv_dummy NUMBER;
--      --
--    BEGIN
--      --
--      IF pi_target_date IS NOT NULL
--       AND pi_target_date < lv_date_raised
--       THEN
--          raise_application_error(-20086,'Target Complete Date Should Not Be Before The Date Raised.');
--      END IF;
--      --
--    END validate_target_complete;
--    --
--    PROCEDURE validate_road_group(pi_group_id IN nm_elements_all.ne_id%TYPE)
--      IS
--    BEGIN
--      --
--      SELECT rse_he_id
--            ,rse_admin_unit
--            ,rse_sys_flag
--        INTO lv_road_group_id
--            ,lv_rse_admin_unit
--            ,lv_sys_flag
--        FROM road_groups
--       WHERE rse_he_id = pi_group_id
--           ;
--      --
--    EXCEPTION
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20087,'Invalid Road Group Id Supplied.');
--      WHEN others
--       THEN
--          RAISE;
--    END validate_road_group;
--    --
--    PROCEDURE set_sys_flag(pi_ne_id     IN nm_elements_all.ne_id%TYPE
--                          ,pi_rse_he_id IN nm_elements_all.ne_id%TYPE)
--      IS
--      --
--      lv_def_he_id nm_elements_all.ne_id%TYPE;
--      --
--    BEGIN
--      --
--      IF pi_rse_he_id IS NOT NULL
--       THEN
--          validate_road_group(pi_rse_he_id);
--      ELSE
--          BEGIN
--            SELECT rse_sys_flag
--              INTO lv_sys_flag
--              FROM road_sections
--             WHERE rse_he_id = pi_ne_id
--                 ;
--          EXCEPTION
--           WHEN others
--            THEN
--               null;
--          END;
--      END IF;
--      --
--      IF lv_sys_flag IS NULL
--       THEN
--          raise_application_error(-20074,'Unable To Obtain sys_flag.');
--      END IF;
--      --
--    END set_sys_flag;
--    --
--    PROCEDURE set_road_group(pi_group_name IN VARCHAR2)
--      IS
--    BEGIN
--      --
--      SELECT rse_he_id
--            ,rse_admin_unit
--        INTO lv_road_group_id
--            ,lv_rse_admin_unit
--        FROM road_groups
--       WHERE rse_unique = pi_group_name
--           ;
--      --
--    EXCEPTION
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20060,'Cannot Set Road Group. Please Check Product Options GISGRPTYP, GISGRPL and GISGRPD');
--      WHEN others
--       THEN
--          RAISE;
--    END set_road_group;
--    --
--    PROCEDURE get_wol_not_done
--      IS
--    BEGIN
--      SELECT hsc_status_code
--        INTO lv_wol_not_done
--        FROM hig_status_codes
--       WHERE hsc_domain_code = 'WORK_ORDER_LINES'
--         AND hsc_allow_feature5 = 'Y'
--         AND TRUNC(lv_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(lv_date_raised))
--                                       AND NVL(hsc_end_date  ,TRUNC(lv_date_raised))
--           ;
--    EXCEPTION
--      WHEN too_many_rows
--       THEN
--          raise_application_error(-20059,'Too Many Values Defined For Work Order Line NOT_DONE Status');
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20055,'Cannot Obtain Value For Work Order Line NOT_DONE Status');
--      WHEN others
--       THEN
--          RAISE;
--    END get_wol_not_done;
--    --
--    PROCEDURE get_wol_instructed
--      IS
--    BEGIN
--      SELECT hsc_status_code
--        INTO lv_wol_instructed
--        FROM hig_status_codes
--       WHERE hsc_domain_code = 'WORK_ORDER_LINES'
--         AND hsc_allow_feature1 = 'Y'
--         AND TRUNC(lv_date_raised) BETWEEN NVL(hsc_start_date,TRUNC(lv_date_raised))
--                                       AND NVL(hsc_end_date  ,TRUNC(lv_date_raised))
--           ;
--    EXCEPTION
--      WHEN too_many_rows
--       THEN
--          raise_application_error(-20058,'Too Many Values Defined For Work Order Line INSTRUCTED Status');
--      WHEN no_data_found
--       THEN
--          raise_application_error(-20054,'Cannot Obtain Value For Work Order Line INSTRUCTED Status');
--      WHEN others
--       THEN
--          RAISE;
--    END get_wol_instructed;
--    --
--    PROCEDURE set_scheme_type
--      IS
--      --
--      PROCEDURE validate_scheme_type
--        IS
--      BEGIN
--        SELECT icb_work_code
--          INTO lv_work_code
--          FROM item_code_breakdowns
--         WHERE icb_type_of_scheme = lv_scheme_type
--           AND icb_dtp_flag       = lv_sys_flag
--             ;
--      EXCEPTION
--        WHEN no_data_found
--         THEN
--            raise_application_error(-20066,'Invalid Scheme Type');
--        WHEN too_many_rows
--         THEN
--            lv_work_code := NULL;
--        WHEN others
--         THEN
--            RAISE;
--      END validate_scheme_type;
--      --
--    BEGIN
--      /*
--      ||Determine The Scheme Type To Use.
--      */
--      IF lv_scheme_type_upd = 'Y'
--       AND pi_scheme_type IS NOT NULL
--       THEN
--          lv_scheme_type := pi_scheme_type;
--      ELSE
--          IF lv_sys_flag = 'L'
--           THEN
--              lv_scheme_type := lv_def_scheme_type_l;
--          ELSE
--              lv_scheme_type := lv_def_scheme_type_d;
--          END IF;
--      END IF;
--      /*
--      ||Now Validate The Scheme Type
--      ||And Set The Work Code.
--      */
--      validate_scheme_type;
--      --
--    END set_scheme_type;
--    --
--  BEGIN
--    /*
--    ||Validate/Default the Date Raised.
--    */
--    set_date_raised;
--    /*
--    ||If No Defects Have Been Specified Raise An Error.
--    */
--    IF pi_sections.count = 0
--     THEN
--        raise_application_error(-20070,'Please Specify At Least One Section For The Work Order.');
--    END IF;
--    /*
--    ||Insert The Defect Ids Into Temp Table
--    ||And Validate Against The Defects Table.
--    */
--    nm_debug.debug('ins_defect_list_temp');
--    ins_section_list_temp;
--    /*
--    ||Get The Sys Flag For The Work Order
--    ||And Validate The Supplied Road Group Id.
--    */
--    nm_debug.debug('set_sys_flag');
--    set_sys_flag(pi_ne_id     => pi_sections(1).ne_id
--                ,pi_rse_he_id => pi_road_group_id);
--    /*
--    ||Default The Road Group For The Work Order
--    ||If Not Suppled.
--    */
--    nm_debug.debug('set_road_group');
--    IF lv_road_group_id IS NULL
--     THEN
--        IF lv_sys_flag = 'L'
--         THEN
--            set_road_group(lv_gisgrpl);
--        ELSE
--            set_road_group(lv_gisgrpd);
--        END IF;
--    END IF;
--    /*
--    ||Get The Users Admin Unit.
--    */
--    nm_debug.debug('validate_user');
--    validate_user;
--    /*
--    ||Get The Contracts Admin Unit.
--    */
--    nm_debug.debug('validate_contract');
--    validate_contract;
--    /*
--    ||Validate/Default Scheme Type.
--    */
--    nm_debug.debug('set_scheme_type');
--    set_scheme_type;
--    /*
--    ||Validate The Interim Flag Supplied.
--    */
--    validate_interim_flag;
--    /*
--    ||Validate The Work Order Priority Supplied.
--    */
--    validate_wo_priority;
--    /*
--    ||Validate The Cost Centre Supplied.
--    */
--    validate_cost_centre;
--    /*
--    ||Validate The WO TMA Register Flag.
--    */
--    validate_tma_register_flag(pi_tma_register_flag);
--    /*
--    ||Validate The Rechargeable Flag.
--    */
--    validate_rechargeable;
--    /*
--    ||Validate The Target Complete Date Supplied.
--    */
--    validate_target_complete;
--    /*
--    ||Get Status Codes.
--    */
--    nm_debug.debug('get_wol_not_done');
--    get_wol_not_done;
--    nm_debug.debug('get_wol_instructed');
--    get_wol_instructed;
--    --
--  END init_defaults;
--  --
--  FUNCTION validate_budget(pi_budget_id  IN budgets.bud_id%TYPE
--                          ,pi_ne_id      IN nm_elements_all.ne_id%TYPE)
--    RETURN BOOLEAN IS
--    --
--    lv_retval BOOLEAN := FALSE;
--    --
--  BEGIN
--    /*
--    ||Init Variables.
--    */
--    lv_bud_rse_he_id := NULL;
--    lv_icb_id        := NULL;
--    lv_work_code     := NULL;
--    --
--    SELECT bud_rse_he_id
--          ,icb_id
--          ,icb_work_code
--      INTO lv_bud_rse_he_id
--          ,lv_icb_id
--          ,lv_work_code
--      FROM item_code_breakdowns icb1,
--           (SELECT b.*
--              FROM road_sections
--                  ,budgets b
--                  ,financial_years fy
--             WHERE TRUNC(fyr_end_date) >= TRUNC(lv_date_raised)
--               AND fy.fyr_id = b.bud_fyr_id
--               AND bud_id = pi_budget_id
--               AND b.bud_sys_flag = rse_sys_flag
--               AND (rse_he_id IN(SELECT nm_ne_id_of
--                                   FROM nm_members
--                                  WHERE nm_type = 'G'
--                                CONNECT BY PRIOR nm_ne_id_of = nm_ne_id_in
--                                  START WITH nm_ne_id_in = b.bud_rse_he_id)
--                    OR rse_he_id = NVL(b.bud_rse_he_id,rse_he_id))
--               AND rse_he_id = pi_ne_id) bud
--     WHERE icb1.icb_item_code = bud.bud_icb_item_code
--       AND icb1.icb_sub_item_code = bud.bud_icb_sub_item_code
--       AND icb1.icb_sub_sub_item_code = bud.bud_icb_sub_sub_item_code
--       AND icb1.icb_dtp_flag = bud.bud_sys_flag
--       AND icb1.icb_type_of_scheme = lv_scheme_type
--         ;
--    --
--    RETURN TRUE;
--    --
--  EXCEPTION
--    WHEN no_data_found
--     THEN
--        RETURN FALSE;
--    WHEN others
--     THEN
--        RAISE;
--  END validate_budget;
--  --
--  PROCEDURE select_sections
--    IS
--    --
--    lr_sta standard_items%ROWTYPE;
--    --
--    lv_perc_item  hig_option_values.hov_value%TYPE := hig.get_sysopt('PERC_ITEM');
--    --
--    FUNCTION check_section(pi_ne_id IN defects.def_defect_id%TYPE)
--      RETURN BOOLEAN IS
--      --
--      lv_retval BOOLEAN;
--      lv_reason VARCHAR2(500);
--      --
--    BEGIN
--      /*
--      ||Check The Defect/Repair Against The Selection Criteria.
--      */
--      SELECT CASE WHEN NOT EXISTS(SELECT 1
--                                    FROM hig_admin_groups
--                                   WHERE hag_parent_admin_unit = lv_con_admin_unit
--                                     AND hag_child_admin_unit  = rse_admin_unit)
--                   THEN 'Section Outside Of The Admin Unit Of The Specified Contract.'
--                  WHEN rse_he_id NOT IN((SELECT nm_ne_id_of
--                                           FROM nm_members
--                                          WHERE nm_type = 'G'
--                                        CONNECT BY
--                                          PRIOR nm_ne_id_of = nm_ne_id_in
--                                            AND nm_end_date IS NULL
--                                          START
--                                           WITH nm_ne_id_in = lv_road_group_id
--                                          UNION
--                                         SELECT ne_id
--                                           FROM nm_elements
--                                          WHERE ne_id = lv_road_group_id)
--                                      INTERSECT
--                                         SELECT nm_ne_id_of
--                                           FROM nm_members
--                                          WHERE nm_type = 'G'
--                                        CONNECT BY
--                                          PRIOR nm_ne_id_of = nm_ne_id_in
--                                            AND nm_end_date IS NULL
--                                          START
--                                           WITH nm_ne_id_in = NVL(lv_bud_rse_he_id,lv_road_group_id))
--                   THEN 'Section Is Not A Member Of The Specified Work Order Road Group.'
--                  ELSE NULL
--             END reason
--        INTO lv_reason
--        FROM road_sections
--       WHERE rse_he_id = pi_ne_id
--           ;
--      --
--      RETURN (lv_reason IS NULL);
--      --
--    END check_section;
--    --
--  BEGIN
--    --
--    nm_debug.debug('Fetching Defects');
--    --
--    FOR i IN 1..pi_sections.count LOOP
--      /*
--      ||Validate The Budget.
--      */
--      IF validate_budget(pi_budget_id => pi_sections(i).budget_id
--                        ,pi_ne_id     => pi_sections(i).ne_id)
--       THEN
--          /*
--          ||Budget Is Valid So Check That The
--          ||Section Is Valid For The Work Order.
--          */
--          IF check_section(pi_ne_id => pi_sections(i).ne_id)
--           THEN
--              lt_selected_sections(lt_selected_sections.count+1) := pi_sections(i);
--          END IF;
--      END IF;
--      --
--    END LOOP;
--    /*
--    ||Generate The Work Order Lines For The Selected Defects.
--    */
--    FOR i IN 1..lt_selected_sections.count LOOP
--      nm_debug.debug('Setting WOL Fields');
--      /*
--      ||Set The Work Order Line Columns.
--      */
--      lt_wol(i).wol_works_order_no := lv_work_order_no;
--      lt_wol(i).wol_rse_he_id      := lt_selected_sections(i).ne_id;
--      lt_wol(i).wol_siss_id        := 'ALL';
--      lt_wol(i).wol_icb_work_code  := lv_work_code;
--      lt_wol(i).wol_flag           := 'O';
--      lt_wol(i).wol_status_code    := lv_wol_instructed;
--      lt_wol(i).wol_date_created   := SYSDATE;
--      lt_wol(i).wol_bud_id         := lt_selected_sections(i).budget_id;
--      lt_wol(i).wol_est_cost       := 0;
--      lt_wol(i).wol_est_labour     := 0;
--      /*
--      ||Reset The Null BOQ Cost WOL Level Flag.
--      */
--      lv_wol_null_boq_exists := FALSE;
--      --
--      /*
--      ||Process BOQs.
--      */
--      /*
--      ||Validate Any Supplied BOQs And Use Them To Replace The Existing Ones.
--      */
--      FOR j IN 1..lt_selected_sections(i).boqs.count LOOP
--        /*
--        ||Validate.
--        */
--        IF lt_selected_sections(i).boqs(j).boq_sta_item_code IS NOT NULL
--         THEN
--            lr_sta := get_sta(pi_sta_item_code => lt_selected_sections(i).boqs(j).boq_sta_item_code);
--            IF lr_sta.sta_unit = lv_perc_item
--             THEN
--                raise_application_error(-20099,'Parent BOQs Based On Percentage Items Codes Are Not Supported.');
--            END IF;
--        ELSE
--            raise_application_error(-20032,'Invalid Standard Item Code Specified.');
--        END IF;
--        --
--        lt_selected_sections(i).boqs(j).boq_item_name      := lr_sta.sta_item_name;
--        lt_selected_sections(i).boqs(j).boq_work_flag      := 'O';
--        lt_selected_sections(i).boqs(j).boq_defect_id      := 0;
--        lt_selected_sections(i).boqs(j).boq_rep_action_cat := 'X';
--        lt_selected_sections(i).boqs(j).boq_date_created   := TRUNC(SYSDATE);
--        /*
--        ||Check/Default Dimentions.
--        */
--        IF lt_selected_sections(i).boqs(j).boq_est_dim1 IS NULL
--         THEN
--            lt_selected_sections(i).boqs(j).boq_est_dim1 := 0;
--        END IF;
--        --
--        IF lr_sta.sta_dim2_text IS NOT NULL
--         AND lt_selected_sections(i).boqs(j).boq_est_dim2 IS NULL
--         THEN
--            lt_selected_sections(i).boqs(j).boq_est_dim2 := 1;
--        END IF;
--        --
--        IF lr_sta.sta_dim3_text IS NOT NULL
--         AND lt_selected_sections(i).boqs(j).boq_est_dim3 IS NULL
--         THEN
--            lt_selected_sections(i).boqs(j).boq_est_dim3 := 1;
--        END IF;
--        --
--        /*
--        ||Set Estimated Quantity.
--        */
--        lt_selected_sections(i).boqs(j).boq_est_quantity := lt_selected_sections(i).boqs(j).boq_est_dim1
--                                                            * NVL(lt_selected_sections(i).boqs(j).boq_est_dim2,1)
--                                                            * NVL(lt_selected_sections(i).boqs(j).boq_est_dim3,1);
--        /*
--        ||Check Quantity.
--        */
--        IF lt_selected_sections(i).boqs(j).boq_est_quantity < lr_sta.sta_min_quantity
--         AND lt_selected_sections(i).boqs(j).boq_est_quantity != 0
--         THEN
--            raise_application_error(-20035,'Estimated Quantity Is Below The Minimum Quantity.');
--        END IF;
--        --
--        IF lt_selected_sections(i).boqs(j).boq_est_quantity > lr_sta.sta_max_quantity
--         AND lt_selected_sections(i).boqs(j).boq_est_quantity != 0
--         THEN
--            raise_application_error(-20036,'Estimated Quantity Is Above The Maximum Quantity.');
--        END IF;
--        /*
--        ||Calculate Estimated Labour
--        */
--        lt_selected_sections(i).boqs(j).boq_est_labour := lt_selected_sections(i).boqs(j).boq_est_quantity * NVL(lr_sta.sta_labour_units,0);
--        /*
--        ||Validate Estimated Rate.
--        */
--        lt_selected_sections(i).boqs(j).boq_est_rate := lr_sta.sta_rate;
--        /*
--        ||Validate Estimated Cost.
--        */
--        IF lt_selected_sections(i).boqs(j).boq_est_cost IS NULL
--         OR lt_selected_sections(i).boqs(j).boq_est_cost != ROUND((lt_selected_sections(i).boqs(j).boq_est_rate * lt_selected_sections(i).boqs(j).boq_est_quantity),2)
--         THEN
--            lt_selected_sections(i).boqs(j).boq_est_cost := ROUND((lt_selected_sections(i).boqs(j).boq_est_rate * lt_selected_sections(i).boqs(j).boq_est_quantity),2);
--        END IF;
--        /*
--        ||Update Work Order and Work Order Line Labour Units.
--        */
--        nm_debug.debug('Calc Labour Units');
--        IF lt_selected_sections(i).boqs(j).boq_est_labour IS NOT NULL
--         THEN
--            lt_wol(i).wol_est_labour := lt_wol(i).wol_est_labour + lt_selected_sections(i).boqs(j).boq_est_labour;
--            lv_wor_est_labour := lv_wor_est_labour + lt_selected_sections(i).boqs(j).boq_est_labour;
--        END IF;
--        /*
--        ||Set The Rate For The BOQ From The Contract Item.
--        */
--        nm_debug.debug('Set BOQ Rate');
--        IF lr_sta.sta_rogue_flag != 'Y'
--         THEN
--            lt_selected_sections(i).boqs(j).boq_est_rate := maiwo.reprice_item(p_item_code => lt_selected_sections(i).boqs(j).boq_sta_item_code
--                                                                              ,p_con_id    => pi_con_id
--                                                                              ,p_rse_he_id => lt_selected_sections(i).ne_id
--                                                                              ,p_priority  => NULL);
--        END IF;
--        /*
--        ||Calculate The Estimated Cost.
--        */
--        nm_debug.debug('Calc Costs');
--        IF lt_selected_sections(i).boqs(j).boq_est_rate IS NOT NULL
--         THEN
--            BEGIN
--              /*
--              ||Update The BOQ Estimated Cost.
--              */
--              lt_selected_sections(i).boqs(j).boq_est_cost := ROUND(lt_selected_sections(i).boqs(j).boq_est_rate*lt_selected_sections(i).boqs(j).boq_est_quantity,2);
--              --
--              IF NOT lv_wol_null_boq_exists
--               THEN
--                  /*
--                  ||No Null BOQ Rates Detected So Far
--                  ||On This WOL So Add The BOQ Estimated
--                  ||Cost To The WOL Total Estimated Cost.
--                  */
--                  BEGIN
--                  /*
--                  ||Update Work Order Line Total.
--                  */
--                  lt_wol(i).wol_est_cost := lt_wol(i).wol_est_cost + lt_selected_sections(i).boqs(j).boq_est_cost;
--                  EXCEPTION
--                    /*
--                    ||Trap The Possibility Of The Value
--                    ||Being Too Large For The Column.
--                    */
--                    WHEN value_error
--                     THEN
--                        raise_application_error(-20077,'Value Too Large For Work Order Line Estimated Cost');
--                    WHEN others
--                     THEN
--                        RAISE;
--                  END;
--                  --
--              END IF;
--                --
--              IF NOT lv_wor_null_boq_exists
--               THEN
--                  /*
--                  ||No Null BOQ Rates Detected So Far
--                  ||On This WO So Add The BOQ Estimated
--                  ||Cost To The WO Total Estimated Cost.
--                  */
--                  BEGIN
--                    /*
--                    ||Update Work Order Total.
--                    */
--                    lv_wor_est_cost := lv_wor_est_cost + lt_selected_sections(i).boqs(j).boq_est_cost;
--                  EXCEPTION
--                    /*
--                    ||Trap The Possibility Of The Value
--                    ||Being Too Large For The Column.
--                    */
--                    WHEN value_error
--                     THEN
--                        raise_application_error(-20076,'Value Too Large For Work Order Estimated Cost');
--                    WHEN others
--                     THEN
--                        RAISE;
--                  END;
--                  --
--              END IF;
--              --
--            EXCEPTION
--              /*
--              ||Trap The Possibility Of The Value
--              ||Being Too Large For The Column.
--              */
--              WHEN value_error
--               THEN
--                  lt_selected_sections(i).boqs(j).boq_est_cost := NULL;
--                  lv_wol_null_boq_exists := TRUE;
--                  lv_wor_null_boq_exists := TRUE;
--              WHEN others
--               THEN
--                  RAISE;
--            END;
--        ELSE
--            lt_selected_sections(i).boqs(j).boq_est_cost := NULL;
--            lv_wol_null_boq_exists := TRUE;
--            lv_wor_null_boq_exists := TRUE;
--        END IF;
--        --
--        --lv_boq_tab_ind := lv_boq_tab_ind+1;
--        --
--      END LOOP; --lt_selected_sections(i).boqs
--      /*
--      ||If Null BOQ Estimated Cost Detected
--      ||At WOL Level Nullify The WOL Estimated Cost.
--      */
--      IF lv_wol_null_boq_exists
--       THEN
--          lt_wol(i).wol_est_cost := NULL;
--      END IF;
--      /*
--      ||Repricing Caused No Errors So Get The WOL_IDs.
--      */
--      lt_wol(i).wol_id := get_next_id('wol_id_seq');
--      /*
--      ||Set The WOL_ID and BOQ_ID On The BOQs.
--      */
--      FOR j IN 1..lt_selected_sections(i).boqs.count LOOP
--        --
--        lt_selected_sections(i).boqs(j).boq_id := get_next_id('boq_id_seq');
--        lt_selected_sections(i).boqs(j).boq_wol_id := lt_wol(i).wol_id;
--        --
--      END LOOP;
--      --
--    END LOOP; --lt_selected_sections
--    /*
--    ||If Null BOQ Estimated Cost Detected
--    ||At WO Level Nullify The WO Estimated Cost.
--    */
--    IF lv_wor_null_boq_exists
--     THEN
--        lv_wor_est_cost := NULL;
--    END IF;
--    --
--  END select_sections;
--  --
--BEGIN
--  --
--  --nm_debug.debug_on;
--  /*
--  ||Initialise Defaults.
--  */
--  init_defaults;
--  /*
--  ||Generate Work Order No.
--  */
--  lv_work_order_no := mai.generate_works_order_no(p_con_id     => pi_con_id
--                                                 ,p_admin_unit => lv_wor_admin_unit);
--  /*
--  ||Determine Which Defects Will Go On The WO.
--  */
--  select_sections;
--  /*
--  ||Create The Work Order.
--  */
--  IF lt_wol.count > 0
--   THEN
--      /*
--      ||Calaculate The Estmated Balancing Sum.
--      */
--      lv_wor_est_balancing_sum := get_balancing_sum(pi_con_id,lv_wor_est_cost);
--      /*
--      ||Insert The Work Order.
--      */
--      INSERT
--        INTO work_orders
--            (wor_scheme_type
--            ,wor_works_order_no
--            ,wor_descr
--            ,wor_sys_flag
--            ,wor_rse_he_id_group
--            ,wor_flag
--            ,wor_con_id
--            ,wor_date_raised
--            ,wor_est_complete
--            ,wor_job_number
--            ,wor_peo_person_id
--            ,wor_icb_item_code
--            ,wor_icb_sub_item_code
--            ,wor_icb_sub_sub_item_code
--            ,wor_interim_payment_flag
--            ,wor_priority
--            ,wor_coc_cost_centre
--            ,wor_register_flag
--            ,wor_contact
--            ,wor_rechargeable
--            ,wor_est_cost
--            ,wor_est_labour
--            ,wor_est_balancing_sum
--            )
--      VALUES(lv_scheme_type
--            ,lv_work_order_no
--            ,pi_wo_descr
--            ,lv_sys_flag
--            ,lv_road_group_id
--            ,'D'
--            ,pi_con_id
--            ,lv_date_raised
--            ,pi_target_date
--            ,NVL(pi_job_number,'00000')
--            ,pi_user_id
--            ,substr(lv_work_code,1,2)
--            ,substr(lv_work_code,3,2)
--            ,substr(lv_work_code,5,2)
--            ,pi_interim_payment
--            ,pi_priority
--            ,pi_cost_centre
--            ,NVL(pi_tma_register_flag,'N')
--            ,pi_contact
--            ,pi_rechargeable
--            ,lv_wor_est_cost
--            ,lv_wor_est_labour
--            ,lv_wor_est_balancing_sum
--            )
--            ;
--      /*
--      ||Insert The Work Order Lines.
--      */
--      FORALL i IN 1..lt_wol.count
--      INSERT
--        INTO(SELECT wol_id
--                   ,wol_works_order_no
--                   ,wol_rse_he_id
--                   ,wol_siss_id
--                   ,wol_icb_work_code
--                   ,wol_act_area_code
--                   ,wol_def_defect_id
--                   ,wol_rep_action_cat
--                   ,wol_flag
--                   ,wol_status_code
--                   ,wol_wor_flag
--                   ,wol_date_created
--                   ,wol_bud_id
--                   ,wol_est_cost
--                   ,wol_est_labour
--               FROM work_order_lines)
--      VALUES lt_wol(i)
--           ;
--      /*
--      ||Insert The BOQs.
--      */
--      FOR i IN 1..lt_selected_sections.count LOOP
--        ins_boqs(pi_boq_tab => lt_selected_sections(i).boqs);
--      END LOOP;
--      /*
--      ||Set The Output Parameters.
--      */
--      po_work_order_no := lv_work_order_no;
--      --
--  END IF;
--  /*
--  ||Commit If Required.
--  */
--  IF lt_wol.count > 0
--   THEN
--      IF NVL(pi_commit,'Y') = 'Y'
--       THEN
--          nm_debug.debug('Commit.');
--          COMMIT;
--      END IF;
--  ELSE
--      /*
--      ||No WO created so rollback to ensure
--      ||any updates (e.g. last wo number)
--      ||are undone.
--      */
--      ROLLBACK;
--  END IF;
--  --
--  --nm_debug.debug_off;
--  --
--EXCEPTION
--  WHEN OTHERS
--   THEN
--      ROLLBACK;
--      --
--      nm_debug.debug_off;
--      --
--      RAISE;
--END create_small_scheme_work_order;
--
-----------------------------------------------------------------------------
--
--PROCEDURE create_stp_work_order(pi_scheme_id     IN  stp_schemes.ss_id%TYPE
--                               ,pi_ne_id         IN  stp_scheme_locations_all.ssl_ne_id%TYPE
--                               ,po_work_order_no OUT work_orders.wor_works_order_no%TYPE)
--  IS
--  --
--  lv_user_id           hig_users.hus_user_id%TYPE := nm3user.get_user_id;
--  lv_wo_descr          work_orders.wor_descr%TYPE;
--  lv_scheme_type       work_orders.wor_scheme_type%TYPE := 'LR';
--  lv_con_id            contracts.con_id%TYPE;
--  lv_bud_code          VARCHAR2(10);
--  lv_bud_id            budgets.bud_id%TYPE;
--  lv_interim_payment   work_orders.wor_interim_payment_flag%TYPE;
--  lv_priority          work_orders.wor_priority%TYPE;
--  lv_cost_centre       work_orders.wor_coc_cost_centre%TYPE;
--  lv_road_group        nm_elements_all.ne_id%TYPE;
--  lv_tma_register_flag work_orders.wor_register_flag%TYPE;
--  lv_contact           work_orders.wor_contact%TYPE;
--  lv_job_number        work_orders.wor_job_number%TYPE;
--  lv_rechargeable      work_orders.wor_rechargeable%TYPE;
--  lv_date_raised       DATE;
--  lv_target_date       DATE;
--  lv_commit            VARCHAR2(1) := 'Y';
--  --
--  lr_stp     stp_schemes%ROWTYPE;
--  lr_wo_job  stp_scheme_jobs_all%ROWTYPE;
--  --
--  lt_sections_in  sections_list_in_tab;
--  lt_job_id       nm3type.tab_number;
--  --
--  PROCEDURE build_sections_list
--    IS
--    --
--    TYPE stp_sections_rec IS RECORD(ssl_id                    stp_scheme_locations_all.ssl_id%TYPE
--                                   ,ssl_ne_id                 stp_scheme_locations_all.ssl_ne_id%TYPE
--                                   ,ssl_activities_to_scheme  stp_scheme_locations_all.ssl_activities_to_scheme%TYPE);
--    TYPE stp_sections_tab IS TABLE OF stp_sections_rec;
--    lt_stp_sections  stp_sections_tab;
--    --
--    lr_wo_job  stp_scheme_jobs_all%ROWTYPE;
--    --
--    TYPE stp_boqs_tab IS TABLE OF stp_scheme_boqs%ROWTYPE;
--    lt_stp_boqs  stp_boqs_tab;
--    --
--    PROCEDURE get_sections
--      IS
--    BEGIN
--      IF pi_ne_id IS NULL
--       THEN
--          SELECT ssl_id
--                ,ssl_ne_id
--                ,ssl_activities_to_scheme
--            BULK COLLECT
--            INTO lt_stp_sections
--            FROM stp_scheme_locations_all
--           WHERE ssl_ss_id = pi_scheme_id
--               ;
--      ELSE
--          SELECT ssl_id
--                ,ssl_ne_id
--                ,ssl_activities_to_scheme
--            BULK COLLECT
--            INTO lt_stp_sections
--            FROM stp_scheme_locations_all
--           WHERE ssl_ss_id = pi_scheme_id
--             AND ssl_ne_id = pi_ne_id
--               ;
--      END IF;
--    END get_sections;
--    --
--    PROCEDURE get_wo_job(pi_ssl_id stp_scheme_locations_all.ssl_id%TYPE)
--      IS
--    BEGIN
--      --
--      IF lr_stp.ss_activities_to_scheme = 'Y'
--       THEN
--          SELECT *
--            INTO lr_wo_job
--            FROM stp_scheme_jobs_all
--           WHERE ssj_ss_id = pi_scheme_id
--             AND ssj_nmo_operation = 'WORKS'
--               ;
--          /*
--          ||Store The Id For Update Of Work Order Number Later.
--          */
--          lt_job_id(1) := lr_wo_job.ssj_id;
--      ELSE
--          SELECT *
--            INTO lr_wo_job
--            FROM stp_scheme_jobs_all
--           WHERE ssj_ss_id = pi_scheme_id
--             AND ssj_nmo_operation = 'WORKS'
--             AND ssj_ssl_id = pi_ssl_id
--               ;
--          /*
--          ||Store The Id For Update Of Work Order Number Later.
--          */
--          lt_job_id(lt_job_id.count+1) := lr_wo_job.ssj_id;
--      END IF;
--      --
--    EXCEPTION
--      WHEN no_data_found
--       THEN
--          NULL;
--      WHEN others
--       THEN
--          RAISE;
--    END get_wo_job;
--    --
--    FUNCTION get_job_data(pi_job_id    IN stp_scheme_jobs_all.ssj_id%TYPE
--                         ,pi_data_item IN stp_scheme_job_data.ssjd_data_item%TYPE)
--      RETURN stp_scheme_job_data.ssjd_value%TYPE IS
--      --
--      lv_retval  stp_scheme_job_data.ssjd_value%TYPE;
--      --
--    BEGIN
--      --
--      SELECT ssjd_value
--        INTO lv_retval
--        FROM stp_scheme_job_data
--       WHERE ssjd_ssj_id = pi_job_id
--         AND ssjd_data_item = pi_data_item
--           ;
--      --
--      RETURN lv_retval;
--      --
--    END get_job_data;
--    --
--    FUNCTION get_bud_id(pi_bud_code IN VARCHAR2)
--      RETURN budgets.bud_id%TYPE IS
--      --
--      lv_retval  budgets.bud_id%TYPE;
--      --
--    BEGIN
--      --
--      SELECT bud_id
--        INTO lv_retval
--        FROM budgets
--       WHERE bud_icb_item_code||bud_icb_sub_item_code||bud_icb_sub_sub_item_code = pi_bud_code
--         AND bud_fyr_id = '2010'
--         AND bud_rse_he_id IS NULL
--           ;
--      --
--      RETURN lv_retval;
--      --
--    END get_bud_id;
--    --
--    PROCEDURE get_boqs(pi_job_id IN stp_scheme_jobs_all.ssj_id%TYPE)
--      IS
--    BEGIN
--      SELECT *
--        BULK COLLECT
--        INTO lt_stp_boqs
--        FROM stp_scheme_boqs
--       WHERE ssbq_ssj_id = pi_job_id
--           ;
--    END get_boqs;
--    --
--  BEGIN
--    /*
--    ||Get The Sections On The Scheme.
--    */
--    get_sections;
--    --
--    FOR i IN 1..lt_stp_sections.count LOOP
--      /*
--      ||Get The Work Order Operation for the Scheme / Section.
--      */
--      get_wo_job(pi_ssl_id => lt_stp_sections(i).ssl_id);
--      --
--      IF lr_wo_job.ssj_id IS NOT NULL
--       THEN
--          /*
--          ||Work Order Operation Exists So
--          ||Create Input For A Work Order Line.
--          */
--          lt_sections_in(lt_sections_in.count+1).ne_id := lt_stp_sections(i).ssl_ne_id;
--          /*
--          ||Get The Scheme Type And Budget.
--          */
--          lv_scheme_type := get_job_data(pi_job_id    => lr_wo_job.ssj_id
--                                        ,pi_data_item => 'SCHEME_TYPE');
--          lv_bud_id := get_bud_id(pi_bud_code => get_job_data(pi_job_id    => lr_wo_job.ssj_id
--                                                             ,pi_data_item => 'BUDGET CODE'));
--          lt_sections_in(lt_sections_in.count).budget_id := lv_bud_id;
--          /*
--          ||Get Any BOQs For The WOL.
--          */
--          get_boqs(pi_job_id => lr_wo_job.ssj_id);
--          --
--          FOR j IN 1..lt_stp_boqs.count LOOP
--            --
--            lt_sections_in(lt_sections_in.count).boqs(lt_sections_in(lt_sections_in.count).boqs.count+1).boq_sta_item_code  := lt_stp_boqs(j).ssbq_sta_item_code;
--            nm_debug.debug('Item Code = '||lt_sections_in(lt_sections_in.count).boqs(lt_sections_in(lt_sections_in.count).boqs.count).boq_sta_item_code);
--            lt_sections_in(lt_sections_in.count).boqs(lt_sections_in(lt_sections_in.count).boqs.count).boq_est_dim1 := lt_stp_boqs(j).ssbq_dim1;
--            lt_sections_in(lt_sections_in.count).boqs(lt_sections_in(lt_sections_in.count).boqs.count).boq_est_dim2 := lt_stp_boqs(j).ssbq_dim2;
--            lt_sections_in(lt_sections_in.count).boqs(lt_sections_in(lt_sections_in.count).boqs.count).boq_est_dim3 := lt_stp_boqs(j).ssbq_dim3;
--            --
--          END LOOP;
--          --
--      END IF;
--      --
--    END LOOP;
--  END build_sections_list;
--  --
--  PROCEDURE update_jobs
--    IS
--    --
--    lv_ssjd_id stp_scheme_job_data.ssjd_id%TYPE;
--    --
--  BEGIN
--    FOR i IN 1..lt_job_id.count LOOP
--      --
--      lv_ssjd_id := get_next_id('STP_SSJD_ID_SEQ');
--      nm_debug.debug('Inserting Job Data '||lv_ssjd_id);
--      --
--      MERGE
--       INTO stp_scheme_job_data ssjd
--      USING(SELECT lt_job_id(i) ssj_id
--                  ,'WORKS' operation
--                  ,'WORK ORDER ID' data_item
--              FROM DUAL) a
--         ON (ssjd.ssjd_ssj_id = a.ssj_id
--             AND ssjd.ssjd_nmo_operation = a.operation
--             AND ssjd.ssjd_data_item = a.data_item)
--       WHEN MATCHED
--        THEN
--           UPDATE SET ssjd_value = po_work_order_no
--       WHEN NOT MATCHED
--        THEN
--           INSERT(ssjd_id
--                 ,ssjd_ssj_id
--                 ,ssjd_nmo_operation
--                 ,ssjd_data_item
--                 ,ssjd_value)
--           VALUES(stp_ssjd_id_seq.nextval
--                 ,lt_job_id(i)
--                 ,'WORKS'
--                 ,'WORK ORDER ID'
--                 ,po_work_order_no)
--      ;
--    END LOOP;
--    COMMIT;
--  END update_jobs;
--BEGIN
--nm_debug.debug_on;
--  --
--  lr_stp := get_stp(pi_ss_id => pi_scheme_id);
--  lv_con_id := lr_stp.ss_con_id;
--  --
--  build_sections_list;
--  --
--  create_small_scheme_work_order(pi_user_id           => lv_user_id
--                                ,pi_wo_descr          => 'Work Order For Scheme '||lr_stp.ss_unique
--                                ,pi_scheme_type       => UPPER(lv_scheme_type)
--                                ,pi_con_id            => lv_con_id
--                                ,pi_interim_payment   => lv_interim_payment
--                                ,pi_priority          => lv_priority
--                                ,pi_cost_centre       => lv_cost_centre
--                                ,pi_road_group_id     => lv_road_group
--                                ,pi_tma_register_flag => lv_tma_register_flag
--                                ,pi_contact           => lv_contact
--                                ,pi_job_number        => lv_job_number
--                                ,pi_rechargeable      => lv_rechargeable
--                                ,pi_date_raised       => lv_date_raised
--                                ,pi_target_date       => lv_target_date
--                                ,pi_sections          => lt_sections_in
--                                ,pi_commit            => lv_commit
--                                ,po_work_order_no     => po_work_order_no);
--  --
--  update_jobs;
--  --
--nm_debug.debug_off;
--END create_stp_work_order;
--
-----------------------------------------------------------------------------
--
FUNCTION get_forward_wo_to_user_lov(pi_works_order_no IN work_orders.wor_works_order_no%TYPE)
  RETURN forward_to_user_tab IS
  --
  lt_retval  forward_to_user_tab;
  --
  lr_wo  work_orders%ROWTYPE;
  --
  /*
  ||Initial Query Based On The Admin Unit Of The Road Group
  ||Associsted With The Works Order (As In MAI3800).
  */
  lv_str  nm3type.max_varchar2;
  --
  lv_consecmode  hig_option_values.hov_value%TYPE := hig.get_sysopt(p_option_id => 'CONSECMODE');
  --
BEGIN
  /*
  ||Get The Works Order Details.
  */
  lr_wo := get_wo(pi_works_order_no => pi_works_order_no);
  /*
  ||Initial Query Based On The Admin Unit Of The Road Group
  ||Associsted With The Works Order (As In MAI3800).
  */
  lv_str := 'SELECT hus_user_id'
 ||CHR(10)||'      ,hus_name'
 ||CHR(10)||'  FROM hig_users'
 ||CHR(10)||' WHERE hus_user_id != nm3user.get_user_id'
 ||CHR(10)||'   AND TRUNC(SYSDATE) BETWEEN hus_start_date AND NVL(hus_end_date,TRUNC(SYSDATE))'
 ||CHR(10)||'   AND (hus_admin_unit IN(SELECT hag_parent_admin_unit'
 ||CHR(10)||'                            FROM nm_elements_all'
 ||CHR(10)||'                                ,hig_admin_groups'
 ||CHR(10)||'                           WHERE hag_child_admin_unit = ne_admin_unit'
 ||CHR(10)||'                             AND ne_id = '||lr_wo.wor_rse_he_id_group||')'
 ||CHR(10)||'        OR EXISTS(SELECT 1'
 ||CHR(10)||'                    FROM nm_elements_all'
 ||CHR(10)||'                        ,hig_admin_units'
 ||CHR(10)||'                   WHERE hau_level = 1'
 ||CHR(10)||'                     AND hau_admin_unit = ne_admin_unit'
 ||CHR(10)||'                     AND ne_id = '||lr_wo.wor_rse_he_id_group||'))'
  ;
  /*
  ||Check To See If Contrator\Contract Security Is Switched On.
  */
  IF lv_consecmode = maisec.c_admin_unit
   THEN
      /*
      ||Add The Contract Admin Unit Clause.
      */
      lv_str := lv_str||'   AND (hus_admin_unit IN(SELECT hag_parent_admin_unit'
             ||CHR(10)||'                            FROM contracts'
             ||CHR(10)||'                                ,hig_admin_groups'
             ||CHR(10)||'                           WHERE hag_child_admin_unit = con_admin_org_id'
             ||CHR(10)||'                             AND con_id = '||lr_wo.wor_con_id||')'
             ||CHR(10)||'        OR (hig.get_sysopt(''INCTOPCON'') = ''Y'''
             ||CHR(10)||'            AND EXISTS(SELECT 1'
             ||CHR(10)||'                         FROM contracts'
             ||CHR(10)||'                             ,hig_admin_units'
             ||CHR(10)||'                        WHERE hau_level = 1'
             ||CHR(10)||'                          AND hau_admin_unit = con_admin_org_id'
             ||CHR(10)||'                          AND  con_id = '||lr_wo.wor_con_id||')))'
      ;
      --
  ELSIF lv_consecmode = maisec.c_user
   THEN
      /*
      ||Add The Contractor User Clause.
      */
      lv_str := lv_str||'   AND (hus_user_id IN(SELECT cou_hus_user_id'
             ||CHR(10)||'                         FROM contractor_users'
             ||CHR(10)||'                             ,contracts'
             ||CHR(10)||'                        WHERE con_id = '||lr_wo.wor_con_id
             ||CHR(10)||'                          AND con_contr_org_id = cou_oun_org_id)'
             ||CHR(10)||'        OR hus_username IN(SELECT hur_username'
             ||CHR(10)||'                             FROM hig_user_roles'
             ||CHR(10)||'                                 ,contractor_roles'
             ||CHR(10)||'                                 ,contracts'
             ||CHR(10)||'                            WHERE con_id = '||lr_wo.wor_con_id
             ||CHR(10)||'                              AND con_contr_org_id = cor_oun_org_id'
             ||CHR(10)||'                              AND cor_role = hur_role))'
      ;
      --
  END IF;
  /*
  ||Add The Order By Clause.
  */
  lv_str := lv_str||' ORDER BY UPPER(hus_name)';
  /*
  ||Run The Query.
  */
  EXECUTE IMMEDIATE lv_str BULK COLLECT INTO lt_retval;
  /*
  ||Return The Results.
  */
  RETURN lt_retval;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN lt_retval;
END get_forward_wo_to_user_lov;
--
-----------------------------------------------------------------------------
--
PROCEDURE forward_works_order(pi_works_order_no     IN     work_orders.wor_works_order_no%TYPE
                             ,pi_forward_to_user_id IN     hig_users.hus_user_id%TYPE
                             ,pi_commit             IN     VARCHAR2 DEFAULT 'Y'
                             ,po_error_text            OUT VARCHAR2)
  IS
  --
  lr_wo  work_orders%ROWTYPE;
  --
BEGIN
  /*
  ||Get The Works Order Details (Will Raise An Error If WO Does Not Exist).
  */
  lr_wo := get_wo(pi_works_order_no => pi_works_order_no);
  --
  IF NOT validate_user_id(pi_user_id        => pi_forward_to_user_id
                         ,pi_effective_date => TRUNC(SYSDATE))
   THEN
      raise_application_error(-20067,'Invalid User Id Supplied ['||TO_CHAR(pi_forward_to_user_id)||'].');
  END IF;
  --
  UPDATE work_orders
     SET wor_forwarded_to = pi_forward_to_user_id
        ,wor_forwarded_by = nm3user.get_user_id
   WHERE wor_works_order_no = pi_works_order_no
       ;
  --
  IF pi_commit = 'Y'
   THEN
      COMMIT;
  END IF;
  --
EXCEPTION
  WHEN others
   THEN
      ROLLBACK;
      po_error_text := SQLERRM;
END;
--
-----------------------------------------------------------------------------
--
END mai_wo_api;
/
