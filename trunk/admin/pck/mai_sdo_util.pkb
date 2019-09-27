CREATE OR REPLACE PACKAGE BODY mai_sdo_util
IS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_sdo_util.pkb-arc   2.12   Sep 27 2019 14:39:54   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_sdo_util.pkb  $
--       Date into SCCS   : $Date:   Sep 27 2019 14:39:54  $
--       Date fetched Out : $Modtime:   Sep 27 2019 14:15:02  $
--       SCCS Version     : $Revision:   2.12  $
--       Based on SCCS Version     : 1.8
--
--   Author : A. Edwards
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
  g_body_sccsid      CONSTANT VARCHAR2 (2000) := '$Revision:   2.12  $';
  g_package_name     CONSTANT VARCHAR2 (30)   := 'MAI_SDO_UTIL';
  nl                 CONSTANT VARCHAR2 (5)    := chr(10);
  --
  TYPE tab_ntf IS TABLE OF nm_theme_functions_all%ROWTYPE INDEX BY BINARY_INTEGER;
  --
  g_theme_name_xy           nm3type.tab_varchar30;
  g_theme_name_lr           nm3type.tab_varchar30;
  g_theme_functions         tab_ntf;
  g_wol_theme_functions     tab_ntf;
  g_theme_feature_views_lr  nm3type.tab_varchar30;
  g_theme_feature_views_xy  nm3type.tab_varchar30;
  --
  g_wol_theme_name          VARCHAR2(30);
  g_wol_theme_feature_view  VARCHAR2(30);
  --
  g_prod_option     CONSTANT hig_option_values.hov_id%TYPE := 'SDODEFNTH';
  g_wol_prod_option CONSTANT hig_option_values.hov_id%TYPE := 'SDOWOLNTH';
  --
  -- Constants taken from IM_FUNCS package
  c_not_set         CONSTANT VARCHAR2(7)  := 'Not Set';
  c_not_used        CONSTANT VARCHAR2(8)  := 'Not Used';
  c_unknown         CONSTANT VARCHAR2(7)  := 'Unknown';
  c_not_assigned    CONSTANT VARCHAR2(12) := 'Not Assigned';
  c_none            CONSTANT VARCHAR2(4)  := 'None';
  c_public          CONSTANT VARCHAR2(6)  := 'Public';
  c_complete        CONSTANT VARCHAR2(8)  := 'Complete';
  c_part_complete   CONSTANT VARCHAR2(13) := 'Part Complete';
  c_with_contractor CONSTANT VARCHAR2(15) := 'With Contractor';
  c_to_be_issued    CONSTANT VARCHAR2(12) := 'To be issued';
  c_not_recorded    CONSTANT VARCHAR2(12) := 'Not Recorded';
  g_tab_int_code             nm3type.tab_varchar4;
  g_tab_int_descr            nm3type.tab_varchar80;
  g_tab_hau_name             nm3type.tab_varchar80;
  g_tab_hus_name             nm3type.tab_varchar80;
--
-----------------------------------------------------------------------------
--
FUNCTION get_version
   RETURN VARCHAR2
IS
BEGIN
   RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version
   RETURN VARCHAR2
IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--
PROCEDURE update_prod_option(pi_nth_theme_id IN nm_themes_all.nth_theme_id%TYPE)
IS
BEGIN
  UPDATE hig_option_values
     SET hov_value = pi_nth_theme_id
   WHERE hov_id = g_prod_option;
END update_prod_option;
--
-----------------------------------------------------------------------------
--
PROCEDURE update_wol_prod_option(pi_nth_theme_id IN nm_themes_all.nth_theme_id%TYPE)
IS
BEGIN
  UPDATE hig_option_values
     SET hov_value = pi_nth_theme_id
   WHERE hov_id = g_wol_prod_option;
END update_wol_prod_option;
--
-----------------------------------------------------------------------------
--
FUNCTION get_wol_feature_tab
  RETURN user_tables.table_name%TYPE IS
  --
BEGIN
  --
  RETURN g_wol_feature_tab;
  --
END get_wol_feature_tab;
--
-----------------------------------------------------------------------------
--
FUNCTION get_wol_base_theme
  RETURN nm_themes_all.nth_theme_id%TYPE IS
  --
  lv_retval nm_themes_all.nth_theme_id%TYPE;
  --
BEGIN
  --
  SELECT nth_theme_id
    INTO lv_retval
    FROM nm_themes_all
   WHERE nth_feature_table = g_wol_feature_tab
     AND rownum = 1
       ;
  --
  RETURN lv_retval;
  --
END get_wol_base_theme;
--
-----------------------------------------------------------------------------
--
FUNCTION get_feature_table_from_gdo(pi_session_id IN gis_data_objects.gdo_session_id%TYPE)
  RETURN nm_themes_all.nth_feature_table%TYPE IS
  --
  lv_theme_name  nm_themes_all.nth_theme_name%TYPE;
  lv_retval      nm_themes_all.nth_feature_table%TYPE;
  --
  lr_theme       nm_themes_all%ROWTYPE;
  lr_base_theme  nm_themes_all%ROWTYPE;
  --
BEGIN
  /*
  ||Get the theme name from gis_data_objects.
  */
  SELECT gdo_theme_name
    INTO lv_theme_name
    FROM gis_data_objects
   WHERE gdo_session_id = pi_session_id
     AND rownum = 1
       ;
  --
  lr_theme := nm3get.get_nth(pi_nth_theme_name => lv_theme_name);
  --
  IF lr_theme.nth_base_table_theme IS NOT NULL
   THEN
      lv_retval := nm3get.get_nth(pi_nth_theme_id => lr_theme.nth_base_table_theme).nth_feature_table;
  ELSE
      lv_retval := lr_theme.nth_feature_table;
  END IF;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN NULL;
END get_feature_table_from_gdo;
--
-----------------------------------------------------------------------------
--
FUNCTION wol_has_shape(pi_theme_id IN nm_themes_all.nth_theme_id%TYPE
                      ,pi_wol_id   IN work_order_lines.wol_id%TYPE)
  RETURN VARCHAR2 IS
  --
  TYPE theme_cur_type IS REF CURSOR;
  theme_cur  theme_cur_type;
  --
  lr_theme  nm_themes_all%ROWTYPE;
  lv_sql    VARCHAR2(500);
  lv_dummy  NUMBER := 0;
  lv_retval VARCHAR2(10) := 'FALSE';
  --
BEGIN
  /*
  ||Get details for the Theme.
  */
  lr_theme := nm3get.get_nth(pi_theme_id);
  /*
  ||Build the SQL.
  */
  lv_sql := 'SELECT 1'
           ||' FROM DUAL'
          ||' WHERE EXISTS(SELECT 1'
                         ||' FROM '||lr_theme.nth_feature_table
                        ||' WHERE '||lr_theme.nth_feature_pk_column||' = :pi_wol_id)'
       ;
  /*
  ||Execute the SQL.
  */
  OPEN  theme_cur FOR lv_sql USING pi_wol_id;
  FETCH theme_cur
   INTO lv_dummy;
  CLOSE theme_cur;
  /*
  ||If a match is found return "TRUE".
  */
  IF NVL(lv_dummy,0) = 1
   THEN
      lv_retval := 'TRUE';
  END IF;
  --
  RETURN lv_retval;
  --
END wol_has_shape;
--
-----------------------------------------------------------------------------
--
FUNCTION wo_has_shape(pi_theme_id       IN nm_themes_all.nth_theme_id%TYPE
                     ,pi_works_order_no IN work_orders.wor_works_order_no%TYPE)
  RETURN VARCHAR2 IS
  --
  TYPE theme_cur_type IS REF CURSOR;
  theme_cur  theme_cur_type;
  --
  lr_theme  nm_themes_all%ROWTYPE;
  lv_sql    VARCHAR2(500);
  lv_dummy  NUMBER := 0;
  lv_retval VARCHAR2(10) := 'FALSE';
  --
BEGIN
  /*
  ||Get details for the Theme.
  */
  lr_theme := nm3get.get_nth(pi_theme_id);
  /*
  ||Build the SQL.
  */
  lv_sql := 'SELECT 1'
           ||' FROM DUAL'
          ||' WHERE EXISTS(SELECT 1'
                         ||' FROM '||lr_theme.nth_feature_table
                        ||' WHERE '||lr_theme.nth_feature_pk_column||' IN (SELECT wol_id'
                                                                         ||' FROM work_order_lines'
                                                                        ||' WHERE wol_works_order_no = :pi_works_order_no))'
       ;
  /*
  ||Execute the SQL.
  */
  OPEN  theme_cur FOR lv_sql USING pi_works_order_no;
  FETCH theme_cur
   INTO lv_dummy;
  CLOSE theme_cur;
  /*
  ||If a match is found return "TRUE".
  */
  IF NVL(lv_dummy,0) = 1
   THEN
      lv_retval := 'TRUE';
  END IF;
  --
  RETURN lv_retval;
  --
END wo_has_shape;
--
-----------------------------------------------------------------------------
--
PROCEDURE set_themes
  IS
BEGIN
  --
  g_theme_name_xy(1) := 'DEFECTS BY STATUS XY';
  g_theme_name_xy(2) := 'DEFECTS BY ACTIVITY XY';
  g_theme_name_xy(3) := 'DEFECTS BY ACT_STAT XY';
  --
  g_theme_name_lr(1) := 'DEFECTS BY STATUS LR';
  g_theme_name_lr(2) := 'DEFECTS BY ACTIVITY LR';
  g_theme_name_lr(3) := 'DEFECTS BY ACT_STAT LR';
  --
  g_theme_feature_views_lr(1) := 'V_MAI_DEF_STATUS_LR_SDO';
  g_theme_feature_views_lr(2) := 'V_MAI_DEF_ACTIVITY_LR_SDO';
  g_theme_feature_views_lr(3) := 'V_MAI_DEF_ACT_STA_LR_SDO';
  --
  g_theme_feature_views_xy(1) := 'V_MAI_DEF_STATUS_XY_SDO';
  g_theme_feature_views_xy(2) := 'V_MAI_DEF_ACTIVITY_XY_SDO';
  g_theme_feature_views_xy(3) := 'V_MAI_DEF_ACT_STA_XY_SDO';
  --
END set_themes;
--
-----------------------------------------------------------------------------
--
PROCEDURE set_wol_themes(pi_theme_name IN nm_themes_all.nth_theme_name%TYPE)
  IS
BEGIN
  --
  g_wol_theme_name         := pi_theme_name;
  g_wol_theme_feature_view := 'V_WORK_ORDER_LINES_SDO';
  --
END set_wol_themes;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_nin(pi_asset_type IN nm_inv_types.nit_inv_type%TYPE
                    ,po_base_theme OUT nm_themes_all.nth_Theme_id%TYPE)
  IS
  l_tab_nw   nm3type.tab_varchar4;
  l_tab_nth  nm3type.tab_number;
BEGIN
  SELECT vnnt_nt_type
        ,vnnt_nth_theme_id
    BULK COLLECT
    INTO l_tab_nw
        ,l_tab_nth
    FROM v_nm_net_themes
   WHERE EXISTS (SELECT UNIQUE ne_nt_type
                   FROM nm_elements
                  WHERE EXISTS (SELECT 1
                                  FROM defects
                                 WHERE def_rse_he_id = ne_id)
                    AND vnnt_nt_type = ne_nt_type
                    AND NVL (vnnt_gty_type, '%$%') = NVL (ne_gty_group_type, '%$%'));
  --
  FOR i IN 1 .. l_tab_nw.COUNT
  LOOP
    --
    INSERT
      INTO nm_inv_nw
          (nin_nw_type
          ,nin_nit_inv_code
          ,nin_loc_mandatory
          ,nin_start_date
          )
    VALUES(l_tab_nw(i)
          ,pi_asset_type
          ,'N'
          ,To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY')
          );
    --
  END LOOP;
  --
  po_base_theme := l_tab_nth(1);
  --
EXCEPTION
  WHEN NO_DATA_FOUND
   THEN
      RAISE_APPLICATION_ERROR (-20101,
                               'No Network themes could be derived'
                              );
  WHEN DUP_VAL_ON_INDEX
   THEN
      po_base_theme := l_tab_nth(1);
END create_nin;
--
-----------------------------------------------------------------------------
--
PROCEDURE set_theme_functions
  IS
BEGIN
  -- nm_theme_functions_all
  -- Defects
  g_theme_functions(1).ntf_hmo_module    := 'MAI3806';
  g_theme_functions(1).ntf_parameter     := 'GIS_SESSION_ID';
  g_theme_functions(1).ntf_menu_option   := 'View Defect Details';
  --
  -- Defect details
  g_theme_functions(2).ntf_hmo_module    := 'MAI3808';
  g_theme_functions(2).ntf_parameter     := 'GIS_SESSION_ID';
  g_theme_functions(2).ntf_menu_option   := 'Edit Defect Details';
  --
  -- Work Orders
  g_theme_functions(3).ntf_hmo_module    := 'MAI3801';
  g_theme_functions(3).ntf_parameter     := 'GIS_SESSION_ID';
  g_theme_functions(3).ntf_menu_option   := 'Place Defect onto Work Order';
  --
  -- Locator
  g_theme_functions(4).ntf_hmo_module    := 'NM0572';
  g_theme_functions(4).ntf_parameter     := 'GIS_SESSION_ID';
  g_theme_functions(4).ntf_menu_option   := 'Locator';
END set_theme_functions;
--
-----------------------------------------------------------------------------
--
PROCEDURE set_wol_theme_functions
  IS
BEGIN
  -- nm_theme_functions_all
  -- Work Orders
  g_wol_theme_functions(1).ntf_hmo_module    := 'MAI3800';
  g_wol_theme_functions(1).ntf_parameter     := 'GIS_SESSION_ID';
  g_wol_theme_functions(1).ntf_menu_option   := 'WORK ORDERS';
  --
  -- Work Order Line details
  g_wol_theme_functions(2).ntf_hmo_module    := 'NM0572';
  g_wol_theme_functions(2).ntf_parameter     := 'GIS_SESSION_ID';
  g_wol_theme_functions(2).ntf_menu_option   := 'Locator';
  --
END set_wol_theme_functions;
--
-----------------------------------------------------------------------------
--
PROCEDURE make_base_sdo_layer(pi_theme_name    IN  nm_themes_all.nth_theme_name%TYPE
                             ,pi_asset_type    IN  nm_inv_types.nit_inv_type%TYPE
                             ,pi_asset_descr   IN  nm_inv_types.nit_descr%TYPE
                             ,pi_x_column      IN  user_tab_columns.column_name%TYPE
                             ,pi_y_column      IN  user_tab_columns.column_name%TYPE
                             ,pi_lr_ne_column  IN  user_tab_columns.column_name%TYPE
                             ,pi_lr_st_chain   IN  user_tab_columns.column_name%TYPE
                             ,pi_snapping_trig IN  VARCHAR2 DEFAULT 'TRUE')
IS
  l_rec_nth            nm_themes_all%ROWTYPE;
  l_rec_nth_v          nm_themes_all%ROWTYPE;
  l_rec_ntg            nm_theme_gtypes%ROWTYPE;
  l_rec_ntg_v          nm_theme_gtypes%ROWTYPE;
  l_rec_nthr           nm_theme_roles%ROWTYPE;
  l_rec_nith           nm_inv_themes%ROWTYPE;
  l_rec_nith_v         nm_inv_themes%ROWTYPE;
  l_theme_id           NUMBER                  := nm3seq.next_nth_theme_id_seq;
  l_mai_sdo_view_sql   nm3type.max_varchar2;
  l_base_theme_id      nm_themes_all.nth_theme_id%TYPE;
  l_rec_ntf            nm_theme_functions_all%ROWTYPE;
  l_dummy              NUMBER;
  b_no_xy              BOOLEAN := pi_x_column     IS NULL      OR pi_y_column    IS NULL;
  b_no_lref            BOOLEAN := pi_lr_ne_column IS NULL      OR pi_lr_st_chain IS NULL;
  b_using_xy           BOOLEAN := pi_x_column     IS NOT NULL AND pi_y_column    IS NOT NULL
                              AND pi_lr_ne_column IS NULL     AND pi_lr_st_chain IS NULL;
  b_using_lref         BOOLEAN := pi_x_column     IS NULL     AND pi_y_column    IS NULL
                              AND pi_lr_ne_column IS NOT NULL AND pi_lr_st_chain IS NOT NULL;
  b_using_both         BOOLEAN := pi_x_column     IS NOT NULL AND pi_y_column    IS NOT NULL
                              AND pi_lr_ne_column IS NOT NULL AND pi_lr_st_chain IS NOT NULL;
BEGIN
  --
  -- set arrays of predetermined theme names and theme functions
  set_themes;
  set_theme_functions;
  --
  --------------------------------------------------------------
  -- Create admin unit restricted view of DEFECTS
  --------------------------------------------------------------
  --
  make_defect_secure_view;
  --
  --
  IF  b_no_xy
   AND b_no_lref
   THEN
      RAISE_APPLICATION_ERROR (-20109,'No XY or lref columns specified');
  END IF;
  --
  IF nm3get.get_nit(pi_nit_inv_type    => pi_asset_type
                   ,pi_raise_not_found => FALSE).nit_inv_type IS NULL
   THEN
      nm3inv.create_ft_asset_from_table(pi_table_name   => g_view_name
                                       ,pi_pk_column    => g_sdo_pk
                                       ,pi_asset_type   => pi_asset_type
                                       ,pi_asset_descr  => pi_asset_descr
                                       ,pi_pnt_or_cont  => 'P'
                                       ,pi_use_xy       => 'Y'
                                       ,pi_x_column     => NULL--pi_x_column
                                       ,pi_y_column     => NULL--pi_y_column
                                       ,pi_lr_ne_column => g_view_ne_id_col
                                       ,pi_lr_st_chain  => g_view_st_chain_col
                                       ,pi_lr_end_chain => g_view_st_chain_col
                                       ,pi_attrib_ltrim => 7);
  END IF;
  --
  --
  --------------------------------------------------------------
  -- *********************************************************
  -- Build the base table DEFECT theme
  -- *********************************************************
  --------------------------------------------------------------
  --
  l_rec_nth.nth_theme_id   := l_theme_id;
  l_rec_nth.nth_theme_name := pi_theme_name;
  l_rec_nth.nth_table_name := g_table_name;
  --
  IF b_using_xy
   OR b_using_both
   THEN
      l_rec_nth.nth_where := pi_x_column||' IS NOT NULL '||
                            'AND '||pi_y_column||' IS NOT NULL ';
      IF  nm3ddl.does_object_exist (g_feature_tab_xy)
       THEN
          RAISE_APPLICATION_ERROR(-20110,g_feature_tab_xy||' exists - please drop or rename');
      END IF;
  ELSIF b_using_lref
   THEN
      l_rec_nth.nth_where                   := pi_lr_st_chain||' IS NOT NULL ';
      IF  nm3ddl.does_object_exist (g_feature_tab_lr)
       THEN
          RAISE_APPLICATION_ERROR(-20110,g_feature_tab_lr||' exists - please drop or rename');
      END IF;
      --
      create_nin(pi_asset_type, l_base_theme_id);
      --
  END IF;
  --
  l_rec_nth.nth_pk_column        := g_pk_column;
  l_rec_nth.nth_label_column     := g_pk_column;
  l_rec_nth.nth_rse_table_name   := 'NM_ELEMENTS';
  l_rec_nth.nth_rse_fk_column    := pi_lr_ne_column;
  l_rec_nth.nth_st_chain_column  := pi_lr_st_chain;
  l_rec_nth.nth_end_chain_column := NULL;
  l_rec_nth.nth_x_column         := pi_x_column;
  l_rec_nth.nth_y_column         := pi_y_column;
  l_rec_nth.nth_offset_field     := NULL;
  --
  -- Move the l_rec_nth.nth_table_name :=  ;
  -- into this IF statement and set the table_name attribute to be the feature table instaeaf of g_table_name
  IF b_using_xy
  THEN
    l_rec_nth.nth_feature_table := g_feature_tab_xy;
  ELSIF b_using_lref
  THEN
    l_rec_nth.nth_feature_table := g_feature_tab_lr;
  END IF;
  --
  l_rec_nth.nth_feature_pk_column    := g_pk_column;
  l_rec_nth.nth_feature_fk_column    := NULL;
  l_rec_nth.nth_xsp_column           := NULL;
  l_rec_nth.nth_feature_shape_column := g_shape_col;
  l_rec_nth.nth_hpr_product          := 'MAI';
  l_rec_nth.nth_location_updatable   := 'Y';
  l_rec_nth.nth_theme_type           := 'LOCL';
  l_rec_nth.nth_dependency           := 'I';
  l_rec_nth.nth_storage              := 'S';
  l_rec_nth.nth_update_on_edit       := 'N';
  l_rec_nth.nth_use_history          := 'N';
  l_rec_nth.nth_start_date_column    := NULL;
  l_rec_nth.nth_end_date_column      := NULL;
  l_rec_nth.nth_base_table_theme     := NULL;
  l_rec_nth.nth_sequence_name        := 'NTH_' || l_theme_id || '_SEQ';
  l_rec_nth.nth_snap_to_theme        := 'S';
  l_rec_nth.nth_lref_mandatory       := 'N';
  l_rec_nth.nth_tolerance            := 10;
  l_rec_nth.nth_tol_units            := 1;
  l_rec_nth.nth_dynamic_theme        := 'N';
  --
  l_rec_ntg.ntg_theme_id             := l_theme_id;
  l_rec_ntg.ntg_gtype                := '2001';
  l_rec_ntg.ntg_seq_no               := 1;
  l_rec_ntg.ntg_xml_url              := NULL;
  --
  --------------------------------------------------------------
  -- Insert the Theme and associated GType
  --------------------------------------------------------------
  --
  nm3ins.ins_nth(p_rec_nth => l_rec_nth);
  nm3ins.ins_ntg(p_rec_ntg => l_rec_ntg);
  --
  --------------------------------------------------------------
  -- Create the SDO layer
  --------------------------------------------------------------
  --
  nm3sdo.create_sdo_layer_from_locl(l_rec_nth.nth_theme_id, l_base_theme_id);
  --
  --------------------------------------------------------------
  -- Create NM_INV_THEME record to link asset to theme
  --------------------------------------------------------------
  --
  l_rec_nith.nith_nit_id       :=  pi_asset_type;
  l_rec_nith.nith_nth_theme_id :=  l_rec_nth.nth_theme_id;
  --
  nm3ins.ins_nith (l_rec_nith);
  --
  --
  --------------------------------------------------------------
  -- Create base themes
  --------------------------------------------------------------
  --
  nm3layer_tool.associate_base_linear_themes(pi_nth_theme_id => l_rec_nth.nth_theme_id);
  --------------------------------------------------------------
  -- Create theme functions
  --------------------------------------------------------------
  --
  FOR i IN 1..g_theme_functions.COUNT
  LOOP
    -- nm_theme_functions_all
    l_rec_ntf := g_theme_functions(i);
    l_rec_ntf.ntf_nth_theme_id := l_rec_nth.nth_theme_id ;
    nm3ins.ins_ntf (l_rec_ntf);
    --
  END LOOP;
  --    --
  --    --------------------------------------------------------------
  --    -- Register layer in SDE if appropriate
  --    --------------------------------------------------------------
  --    --
  --      IF Hig.get_sysopt ('REGSDELAY') = 'Y'
  --      THEN
  --         EXECUTE IMMEDIATE
  --           ( ' begin  '
  --           ||'    nm3sde.register_sde_layer( p_theme_id => '||TO_CHAR( l_rec_nth.nth_theme_id )||');'
  --           ||' end;'
  --           );
  --      END IF;
  --
  --------------------------------------------------------------
  -- Update product option to set default pem theme
  --------------------------------------------------------------
  --
  update_prod_option(l_rec_nth.nth_theme_id);
  ---------------------------------------------------------------
  -- Create themes for the views
  ---------------------------------------------------------------
  --
  l_rec_nth_v := l_rec_nth;
  --
  -- Loop through the 3 predermined themes and create them
  FOR i IN 1..g_theme_name_lr.COUNT
  LOOP
    --
    l_rec_nth_v.nth_theme_id     := Nm3seq.next_nth_theme_id_seq;
    l_rec_nth_v.nth_table_name   := g_view_name;
    l_rec_nth_v.nth_pk_column    := g_sdo_pk;
    l_rec_nth_v.nth_label_column := g_sdo_pk;
    --
    IF b_using_xy
     THEN
        l_rec_nth_v.nth_theme_name        := g_theme_name_xy(i);
        l_rec_nth_v.nth_feature_pk_column := g_sdo_pk;
        l_rec_nth_v.nth_feature_table     := g_theme_feature_views_xy(i);
    ELSIF b_using_lref
     THEN
        l_rec_nth_v.nth_theme_name        := g_theme_name_lr(i);
        l_rec_nth_v.nth_feature_pk_column := g_sdo_pk;
        l_rec_nth_v.nth_feature_table     := g_theme_feature_views_lr(i);
    END IF;
    --
    l_rec_nth_v.nth_theme_type       := 'SDO';
    l_rec_nth_v.nth_base_table_theme := l_rec_nth.nth_theme_id;
    --
    -- Task 0108740
    -- Remove the WHERE Clause copied from the Base table theme
    l_rec_nth_v.nth_where            := NULL;
    --
    l_rec_ntg_v.ntg_theme_id := l_rec_nth_v.nth_theme_id;
    l_rec_ntg_v.ntg_gtype    := '2001';
    l_rec_ntg_v.ntg_seq_no   := 1;
    --
    BEGIN
      Nm3ins.ins_nth ( l_rec_nth_v );
      Nm3ins.ins_ntg ( l_rec_ntg_v );
    EXCEPTION
      WHEN OTHERS
        THEN ROLLBACK;
        RAISE;
    END;
    --
    -- Create the spatial joined view
    l_mai_sdo_view_sql := ' CREATE OR REPLACE FORCE VIEW '
                          ||l_rec_nth_v.nth_feature_table||nl||
                          ' AS '||nl||

                          '  (SELECT '||nl||
                          nm3ddl.get_sccs_comments(pi_sccs_id => g_body_sccsid)||nl||
                          '          a.* '||nl||

                          '        , b.geoloc, b.objectid '||nl||
                          '     FROM '||g_view_name||' a '||nl||
                          '        , '||l_rec_nth.nth_feature_table||' b '||nl||
                          '    WHERE a.'||g_sdo_pk||' = b.'
                                      ||l_rec_nth.nth_feature_pk_column||' ) ';
    --
    BEGIN
      EXECUTE IMMEDIATE l_mai_sdo_view_sql; 
      Nm3ddl.Create_Synonym_For_Object  (
                                        p_Object_Name => l_Rec_Nth_v.Nth_Feature_Table
                                        );
    EXCEPTION
      WHEN OTHERS
       THEN RAISE;
    END;
    --
    BEGIN
      l_dummy := Nm3sdo.create_sdo_layer(pi_table_name  => l_rec_nth_v.nth_feature_table
                                        ,pi_column_name => l_rec_nth_v.nth_feature_shape_column
                                        ,pi_gtype       => l_rec_ntg_v.ntg_gtype);
    EXCEPTION
      WHEN OTHERS
        THEN RAISE;
    END;
    --
    BEGIN
      IF Hig.get_sysopt ('REGSDELAY') = 'Y'
       THEN
          EXECUTE IMMEDIATE(' begin  '
                          ||'    nm3sde.register_sde_layer( p_theme_id => '||TO_CHAR( l_rec_nth_v.nth_theme_id )||');'
                          ||' end;');
      END IF;
    EXCEPTION
      WHEN OTHERS THEN nm_debug.debug('Problem with SDE = '||l_rec_nth_v.nth_theme_id||' - '||sqlerrm);
    END;
    ---------------------------------------------------------------
    -- Create a theme role - this will copy metadata to subordinate
    -- users if SDMREGULAY is set, and users have the END_USER role
    ----------------------------------------------------------------
    --
    l_rec_nthr.nthr_theme_id := l_rec_nth_v.nth_theme_id;
    l_rec_nthr.nthr_role     := 'MAI_USER';
    l_rec_nthr.nthr_mode     := 'NORMAL';
    --
    Nm3ins.ins_nthr ( l_rec_nthr );
    --
    --------------------------------------------------------------
    -- Create NM_INV_THEME record to link asset to theme
    --------------------------------------------------------------
    --
    l_rec_nith_v.nith_nit_id       :=  pi_asset_type;
    l_rec_nith_v.nith_nth_theme_id :=  l_rec_nth_v.nth_theme_id;
    --
    nm3ins.ins_nith (l_rec_nith_v);
    --
    --------------------------------------------------------------
    -- Create theme functions
    --------------------------------------------------------------
    --
    FOR i IN 1..g_theme_functions.COUNT
    LOOP
      -- nm_theme_functions_all
      l_rec_ntf := g_theme_functions(i);
      l_rec_ntf.ntf_nth_theme_id := l_rec_nth_v.nth_theme_id ;
      nm3ins.ins_ntf (l_rec_ntf);
      --
    END LOOP;
    --
    --------------------------------------------------------------
    -- Create base themes
    --------------------------------------------------------------
    --
    nm3layer_tool.associate_base_linear_themes(pi_nth_theme_id => l_rec_nth_v.nth_theme_id);
    --
  END LOOP;
  --   
  IF pi_snapping_trig = 'TRUE'
   THEN   
      nm3sdm.create_nth_sdo_trigger(l_rec_nth.nth_theme_id);
  END IF;
  --
  --CWS 719472
     UPDATE nm_themes_all
     SET nth_table_name = nth_feature_table
     WHERE nth_theme_id = l_rec_nth.nth_theme_id;
   
  create_lookups(pi_asset_type => pi_asset_type);
  --
END make_base_sdo_layer;
--
-----------------------------------------------------------------------------
--
PROCEDURE generate_wol_shape(pi_wol_id   IN work_order_lines.wol_id%TYPE
                            ,pi_tab_xy   IN nm3sdo_gdo.tab_xys
                            ,pi_geo_type IN nm_theme_gtypes.ntg_gtype%TYPE)
  IS
  --
  lv_shape    mdsys.sdo_geometry;
  lv_theme_id nm_themes_all.nth_theme_id%TYPE := get_wol_base_theme;
  --
BEGIN
  /*
  ||Use the points inserted into gis_date_objects
  ||by Locator to create a new shape for the WOL.
  */
  IF pi_wol_id IS NOT NULL
   AND pi_tab_xy.count > 0
   AND pi_geo_type IS NOT NULL
   THEN
      /*
      ||Generate the shape.
      */
      --nm3sdo_gdo.set_gtype(pi_gtype => pi_geo_type);
      --lv_shape := nm3sdo_gdo.get_geom_from_xys(pi_tab_xys => pi_tab_xy);
      --
      -- AE Use nm3sdo_geom API instead for 4100
      -- 
        lv_shape := nm3sdo_geom.get_geom_from_xys(p_tab_xys => pi_tab_xy
                                                , p_gtype   => pi_geo_type);
      /*
      ||Update the shape table.
      */
      IF lv_shape.sdo_gtype IS NOT NULL
       THEN
          nm3sdo_edit.add_shape(pi_nth_id  => lv_theme_id
                               ,pi_pk      => pi_wol_id
                               ,pi_fk      => NULL
                               ,pi_shape   => lv_shape);
      END IF;
  END IF;
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE generate_wol_shape(pi_wol_id    IN work_order_lines.wol_id%TYPE
                            ,pi_rse_he_id IN work_order_lines.wol_rse_he_id%TYPE
                            ,pi_defect_id IN work_order_lines.wol_def_defect_id%TYPE)
  IS
  --
  lr_defect defects%ROWTYPE;
  lv_shape mdsys.sdo_geometry;
  --
  PROCEDURE get_defect
    IS
  BEGIN
    SELECT *
      INTO lr_defect
      FROM defects
     WHERE def_defect_id = pi_defect_id
         ;
  EXCEPTION
   WHEN no_data_found
    THEN
       NULL;
   WHEN others
    THEN
       RAISE;
  END;
  --
  FUNCTION get_network_shape(pi_ne_id IN nm_elements_all.ne_id%TYPE)
    RETURN mdsys.sdo_geometry IS
    --
    lv_ne_type  nm_elements_all.ne_type%TYPE;
    lv_retval   mdsys.sdo_geometry;
    --
  BEGIN
    /*
    ||Get The Element Type.
    */
    lv_ne_type := nm3get.get_ne(pi_ne_id => pi_ne_id).ne_type;
    /*
    ||Get The Shape For A Datum Or A Group Of Datums.
    */
    IF lv_ne_type = 'S'
     THEN
        --
        lv_retval := sdo_lrs.convert_to_std_geom(nm3sdo.get_layer_element_geometry(p_ne_id => pi_ne_id));
        --
    ELSIF lv_ne_type = 'G'
     THEN
        --
        lv_retval := sdo_lrs.convert_to_std_geom(nm3sdo.get_shape_from_ne(p_ne_id => pi_ne_id));
        --
    END IF;
    --
    RETURN lv_retval;
    --
  END get_network_shape;
  --
BEGIN
  /*
  ||Generate A Default Shape For The Work Order Line.
  */
  IF pi_defect_id IS NULL
   THEN
      /*
      ||No Defect So Get The Shape From The Network.
      */
      lv_shape := get_network_shape(pi_ne_id => pi_rse_he_id);
      --
  ELSE
      /*
      ||Get The Defect Details.
      */
      get_defect;
      --
      IF lr_defect.def_easting IS NOT NULL AND lr_defect.def_northing IS NOT NULL
       THEN
          /*
          ||If x,y co-ordinates Available Use Them To Get A Point Shape.
          */
          lv_shape := nm3sdo.get_2d_pt(p_x => lr_defect.def_easting
                                      ,p_y => lr_defect.def_northing);
          --
      ELSIF lr_defect.def_st_chain IS NOT NULL AND lr_defect.def_rse_he_id IS NULL
       THEN
          /*
          ||Otherwise If An Element And A Measure Is Available Use Them To Get A Point Shape.
          */
          lv_shape := nm3sdo.get_pt_shape_from_ne(p_ne_id_of => lr_defect.def_rse_he_id
                                                 ,p_measure  => lr_defect.def_st_chain);
          --
      ELSE
          /*
          ||If All Else Fails Get The Shape From The Network.
          */
          lv_shape := get_network_shape(pi_ne_id => lr_defect.def_rse_he_id);
          --
      END IF;
      --
  END IF;
  /*
  ||Insert/Update The Shape.
  */
  IF lv_shape.sdo_gtype IS NOT NULL
   THEN
      nm3sdo_edit.add_shape(pi_nth_id  => get_wol_base_theme
                           ,pi_pk      => pi_wol_id
                           ,pi_fk      => NULL
                           ,pi_shape   => lv_shape);
  END IF;
  --
END generate_wol_shape;
--
-----------------------------------------------------------------------------
--
PROCEDURE generate_existing_wol_shapes
  IS
  --
  TYPE wol_rec IS RECORD(wol_id            work_order_lines.wol_id%TYPE
                        ,wol_rse_he_id     work_order_lines.wol_rse_he_id%TYPE
                        ,wol_def_defect_id work_order_lines.wol_def_defect_id%TYPE);
  TYPE wol_tab IS TABLE OF wol_rec;
  lt_wols wol_tab;
  --
BEGIN
  nm_debug.debug_on;
  /*
  ||Query back the WOLs that are to have a shape defaulted.
  ||These should be either INSTRUCTED or subject to an Interim Payment.
  */
  SELECT wol_id
        ,wol_rse_he_id
        ,wol_def_defect_id
    BULK COLLECT
    INTO lt_wols
    FROM work_order_lines
   WHERE wol_status_code NOT IN(SELECT hsc_status_code
                                  FROM hig_status_codes
                                      ,hig_status_domains
                                 WHERE hsd_product='MAI'
                                   AND hsd_domain_code=hsc_domain_code
                                   AND hsc_domain_code='WORK_ORDER_LINES'
                                   AND ((hsc_allow_feature3='Y') -- COMPLETED 
                                        OR(hsc_allow_feature2='Y') -- HELD 
                                        OR(hsc_allow_feature5='Y') -- NOT DONE 
                                        OR(hsc_allow_feature4='Y' AND hsc_allow_feature9='N') -- PAID 
                                        OR(hsc_allow_feature7='Y') -- ACTIONED 
                                       ))
       ;
  /*
  ||Generate a default shape for the WOLs returned.
  */
  FOR i IN 1..lt_wols.count LOOP
    --
    BEGIN
      mai_sdo_util.generate_wol_shape(pi_wol_id    => lt_wols(i).wol_id
                                     ,pi_rse_he_id => lt_wols(i).wol_rse_he_id
                                     ,pi_defect_id => lt_wols(i).wol_def_defect_id);
      --COMMIT;
    EXCEPTION
      WHEN others
       THEN
          nm_debug.debug('Error occured while creating a default shape for an existing WOL');
          nm_debug.debug('wol_id = '||lt_wols(i).wol_id);
          nm_debug.debug('rse_he_id = '||lt_wols(i).wol_rse_he_id);
          nm_debug.debug('defect_id = '||lt_wols(i).wol_def_defect_id);
          nm_debug.debug(SQLERRM);
    END;
    --
  END LOOP;
  --
EXCEPTION
 WHEN no_data_found
  THEN
     NULL;
 WHEN others
  THEN
     RAISE;
END generate_existing_wol_shapes;
--
-----------------------------------------------------------------------------
--
PROCEDURE maintain_wol_sdo_trg(pi_wol_id    IN work_order_lines.wol_id%TYPE
                              ,pi_rse_he_id IN work_order_lines.wol_rse_he_id%TYPE
                              ,pi_defect_id IN work_order_lines.wol_def_defect_id%TYPE
                              ,pi_trg_mode  IN VARCHAR2)
  IS
  --
  PROCEDURE ins
    IS
  BEGIN
    mai_sdo_util.generate_wol_shape(pi_wol_id    => pi_wol_id
                                   ,pi_rse_he_id => pi_rse_he_id
                                   ,pi_defect_id => pi_defect_id);
  EXCEPTION
   WHEN others
    THEN
       NULL;
  END ins;
  --
  PROCEDURE del
    IS
  BEGIN
    nm3sdo_edit.delete_shape(pi_nth_id => mai_sdo_util.get_wol_base_theme
                            ,pi_pk     => pi_wol_id);
  EXCEPTION
   WHEN others
    THEN
       NULL;
  END del;
  --
  PROCEDURE upd
    IS
  BEGIN
    mai_sdo_util.generate_wol_shape(pi_wol_id    => pi_wol_id
                                   ,pi_rse_he_id => pi_rse_he_id
                                   ,pi_defect_id => pi_defect_id);
  EXCEPTION
   WHEN others
    THEN
       NULL;
  END upd;
  --
BEGIN
  --
  IF pi_trg_mode = 'INSERTING'
   THEN
      ins;
  ELSIF pi_trg_mode = 'DELETING'
   THEN
      del;
  ELSIF pi_trg_mode = 'UPDATING'
   THEN
      upd;
  END IF;
  --
END maintain_wol_sdo_trg;
--
-----------------------------------------------------------------------------
--
PROCEDURE build_wol_sdo_trigger(pi_theme_id IN nm_themes_all.nth_theme_id%TYPE)
  IS
  --
  lv_sql nm3type.max_varchar2;
  cr     VARCHAR2(1) := CHR(10);
  --
BEGIN
  --
  lv_sql := 'CREATE OR REPLACE TRIGGER nm_nth_'||TO_CHAR(pi_theme_id)||'_sdo_a_row_trg'
      ||cr||'AFTER INSERT OR DELETE OR UPDATE of wol_rse_he_id,wol_def_defect_id'
      ||cr||'ON '||g_wol_table_name
      ||cr||'FOR EACH ROW'
      ||cr||'DECLARE'
      ||cr||'  --'
      ||cr||'  lv_mode      VARCHAR2(20);'
      ||cr||'  lv_wol_id    work_order_lines.wol_id%TYPE;'
      ||cr||'  lv_rse_he_id work_order_lines.wol_rse_he_id%TYPE;'
      ||cr||'  lv_defect_id work_order_lines.wol_def_defect_id%TYPE;'
      ||cr||'  --'
      ||cr||'BEGIN'
      ||cr||'  --'
      ||cr||'  IF INSERTING'
      ||cr||'   THEN'
      ||cr||'      lv_mode      := ''INSERTING'';'
      ||cr||'      lv_wol_id    := :new.wol_id;'
      ||cr||'      lv_rse_he_id := :new.wol_rse_he_id;'
      ||cr||'      lv_defect_id := :new.wol_def_defect_id;'
      ||cr||'  ELSIF DELETING'
      ||cr||'   THEN'
      ||cr||'      lv_mode      := ''DELETING'';'
      ||cr||'      lv_wol_id    := :old.wol_id;'
      ||cr||'  ELSIF UPDATING'
      ||cr||'   THEN'
      ||cr||'      IF :old.wol_rse_he_id != :new.wol_rse_he_id'
      ||cr||'       OR NVL(:old.wol_def_defect_id,-1) != NVL(:new.wol_def_defect_id,-1)'
      ||cr||'       THEN'
      ||cr||'          lv_mode      := ''UPDATING'';'
      ||cr||'          lv_wol_id    := :new.wol_id;'
      ||cr||'          lv_rse_he_id := :new.wol_rse_he_id;'
      ||cr||'          lv_defect_id := :new.wol_def_defect_id;'
      ||cr||'      END IF;'
      ||cr||'  END IF;'
      ||cr||'  --'
      ||cr||'  IF lv_mode IS NOT NULL'
      ||cr||'   THEN'
      ||cr||'      mai_sdo_util.maintain_wol_sdo_trg(pi_wol_id    => lv_wol_id'
      ||cr||'                                       ,pi_rse_he_id => lv_rse_he_id'
      ||cr||'                                       ,pi_defect_id => lv_defect_id'
      ||cr||'                                       ,pi_trg_mode  => lv_mode);'
      ||cr||'  END IF;'
      ||cr||'  --'
      ||cr||'END;'
  ;
  --
  EXECUTE IMMEDIATE lv_sql;
  --
END build_wol_sdo_trigger;
--
-----------------------------------------------------------------------------
--
PROCEDURE make_base_wol_sdo_layer(pi_theme_name  IN  nm_themes_all.nth_theme_name%TYPE
                                 ,pi_asset_type  IN  nm_inv_types.nit_inv_type%TYPE
                                 ,pi_asset_descr IN  nm_inv_types.nit_descr%TYPE)
  IS
  --
  l_rec_nth            nm_themes_all%ROWTYPE;
  l_rec_nth_v          nm_themes_all%ROWTYPE;
  l_rec_ntg            nm_theme_gtypes%ROWTYPE;
  l_rec_ntg_v          nm_theme_gtypes%ROWTYPE;
  l_rec_nthr           nm_theme_roles%ROWTYPE;
  l_rec_nith           nm_inv_themes%ROWTYPE;
  l_rec_nith_v         nm_inv_themes%ROWTYPE;
  l_theme_id           NUMBER                  := nm3seq.next_nth_theme_id_seq;
  l_mai_sdo_view_sql   nm3type.max_varchar2;
  l_base_theme_id      nm_themes_all.nth_theme_id%TYPE;
  l_rec_ntf            nm_theme_functions_all%ROWTYPE;
  l_dummy              NUMBER;
  --
  PROCEDURE create_wol_sdo_table
  IS
  BEGIN
    --
    IF NOT nm3ddl.does_object_exist(g_wol_feature_tab)
     THEN
        --
        EXECUTE IMMEDIATE 'CREATE TABLE '||g_wol_feature_tab||'(WOL_ID NUMBER NOT NULL,'||g_shape_col||' MDSYS.SDO_GEOMETRY)';
        --
        EXECUTE IMMEDIATE 'ALTER TABLE '||g_wol_feature_tab||' ADD(CONSTRAINT '||g_wol_feature_tab||'_PK PRIMARY KEY('||g_wol_sdo_pk||'))';
        --
        Nm3ddl.Create_Synonym_For_Object  (
                                          p_Object_Name => g_wol_feature_tab
                                          );
        --
    END IF;
  END create_wol_sdo_table;
  --
BEGIN
  --
  -- set arrays of predetermined theme names and theme functions
  set_wol_themes(pi_theme_name => UPPER(pi_theme_name));
  set_wol_theme_functions;
  --
  --------------------------------------------------------------
  -- Create a view of Work Order Lines.
  --------------------------------------------------------------
  --
  make_wol_secure_view;
  /*
  ||Create Locator Asset Lookup Type
  */
  IF nm3get.get_nit (pi_nit_inv_type    => pi_asset_type
                    ,pi_raise_not_found => FALSE).nit_inv_type IS NULL
   THEN
      nm3inv.create_ft_asset_from_table(pi_table_name   => g_wol_view_name
                                       ,pi_pk_column    => g_wol_sdo_pk
                                       ,pi_asset_type   => pi_asset_type
                                       ,pi_asset_descr  => pi_asset_descr
                                       ,pi_pnt_or_cont  => 'P'
                                       ,pi_use_xy       => 'Y'
                                       ,pi_x_column     => NULL
                                       ,pi_y_column     => NULL
                                       ,pi_lr_ne_column => NULL
                                       ,pi_lr_st_chain  => NULL
                                       ,pi_lr_end_chain => NULL
                                       ,pi_attrib_ltrim => 4);
  END IF;
  --
  --
  --------------------------------------------------------------
  -- *********************************************************
  -- Build the base table WOL theme
  -- *********************************************************
  --------------------------------------------------------------
  --
  l_rec_nth.nth_theme_id   := l_theme_id;
  l_rec_nth.nth_theme_name := SUBSTR(UPPER(pi_theme_name),0,26)||'_TAB';
  l_rec_nth.nth_table_name := g_wol_table_name;
  --
  --
  l_rec_nth.nth_pk_column      := g_wol_pk_column;
  l_rec_nth.nth_label_column   := g_wol_pk_column;
  --l_rec_nth.nth_rse_table_name := 'NM_ELEMENTS';
  --
  l_rec_nth.nth_feature_table := g_wol_feature_tab;
  --
  l_rec_nth.nth_feature_pk_column    := g_wol_pk_column;
  l_rec_nth.nth_feature_fk_column    := NULL;
  l_rec_nth.nth_xsp_column           := NULL;
  l_rec_nth.nth_feature_shape_column := g_shape_col;
  l_rec_nth.nth_hpr_product          := 'MAI';
  l_rec_nth.nth_location_updatable   := 'Y';
  l_rec_nth.nth_theme_type           := 'SDO';
  l_rec_nth.nth_dependency           := 'I';
  l_rec_nth.nth_storage              := 'S';
  l_rec_nth.nth_update_on_edit       := 'N';
  l_rec_nth.nth_use_history          := 'N';
  l_rec_nth.nth_start_date_column    := NULL;
  l_rec_nth.nth_end_date_column      := NULL;
  l_rec_nth.nth_base_table_theme     := NULL;
  l_rec_nth.nth_sequence_name        := NULL;
  l_rec_nth.nth_snap_to_theme        := 'N';
  l_rec_nth.nth_lref_mandatory       := 'N';
  l_rec_nth.nth_tolerance            := 10;
  l_rec_nth.nth_tol_units            := 1;
  l_rec_nth.nth_dynamic_theme        := 'N';
  --
  l_rec_ntg.ntg_theme_id := l_theme_id;
  l_rec_ntg.ntg_gtype    := '2003';
  l_rec_ntg.ntg_seq_no   := 1;
  l_rec_ntg.ntg_xml_url  := NULL;
  --
  --------------------------------------------------------------
  -- Insert the Theme and associated GType
  --------------------------------------------------------------
  --
  nm3ins.ins_nth(p_rec_nth => l_rec_nth);
  nm3ins.ins_ntg(p_rec_ntg => l_rec_ntg);
  --
  --------------------------------------------------------------
  -- Create the SDO layer
  --------------------------------------------------------------
  --
  --  nm3sdo.create_sdo_layer_from_locl (l_rec_nth.nth_theme_id, l_base_theme_id);
  /*
  ||Write procedure to create WORK_ORDER_LINES_SDO table.
  ||Also create primary key index
  */
  create_wol_sdo_table;
  /*
  ||Insert user_sdo_geom_metadata.
  */
  BEGIN
    l_dummy := Nm3sdo.create_sdo_layer(pi_table_name  => l_rec_nth.nth_feature_table
                                      ,pi_column_name => l_rec_nth.nth_feature_shape_column
                                      ,pi_gtype       => l_rec_ntg.ntg_gtype);
  EXCEPTION
    WHEN OTHERS
     THEN RAISE;
  END;
  /*
  ||Create SDE Metadata.
  */
  BEGIN
    IF Hig.get_sysopt ('REGSDELAY') = 'Y'
     THEN
        EXECUTE IMMEDIATE('begin'
                        ||'  nm3sde.register_sde_layer(p_theme_id => '||TO_CHAR(l_rec_nth.nth_theme_id)||');'
                        ||'end;');
    END IF;
    EXCEPTION
      WHEN OTHERS THEN nm_debug.debug('Problem with SDE = '||l_rec_nth.nth_theme_id||' - '||sqlerrm);
    END;
  /*
  ||Create default shapes for existing WOLs.
  */
  generate_existing_wol_shapes;
  /*
  ||Analyse the table.
  */
  nm3ddl.analyse_table(pi_table_name => g_wol_feature_tab);
  /*
  ||Create spatial index.
  */
  Nm3sdo.create_spatial_idx(l_rec_nth.nth_feature_table,l_rec_nth.nth_feature_shape_column);
  --
  --------------------------------------------------------------
  -- Create NM_INV_THEME record to link asset to theme
  --------------------------------------------------------------
  --
  l_rec_nith.nith_nit_id       := pi_asset_type;
  l_rec_nith.nith_nth_theme_id := l_rec_nth.nth_theme_id;
  --
  nm3ins.ins_nith(l_rec_nith);
  --
  --------------------------------------------------------------
  -- Update product option to set default WOL theme
  --------------------------------------------------------------
  --
  update_wol_prod_option(l_rec_nth.nth_theme_id);
  ---------------------------------------------------------------
  -- Create themes for the views
  ---------------------------------------------------------------
  --
  l_rec_nth_v := l_rec_nth;
  --
  -- Create the view based theme.
  l_rec_nth_v.nth_theme_id     := Nm3seq.next_nth_theme_id_seq;
  l_rec_nth_v.nth_table_name   := g_wol_view_name;
  l_rec_nth_v.nth_pk_column    := g_wol_sdo_pk;
  l_rec_nth_v.nth_label_column := g_wol_sdo_pk;
  --
  l_rec_nth_v.nth_theme_name        := g_wol_theme_name;
  l_rec_nth_v.nth_feature_pk_column := g_wol_sdo_pk;
  l_rec_nth_v.nth_feature_table     := g_wol_theme_feature_view;
  --
  l_rec_nth_v.nth_theme_type       := 'SDO';
  l_rec_nth_v.nth_base_table_theme := l_rec_nth.nth_theme_id;
  --
  --
  -- Task 0108740
  -- Remove the WHERE Clause copied from the Base table theme
  l_rec_nth_v.nth_where            := NULL;
  --
  l_rec_ntg_v.ntg_theme_id := l_rec_nth_v.nth_theme_id;
  l_rec_ntg_v.ntg_gtype    := '2003';
  l_rec_ntg_v.ntg_seq_no   := 1;
  --
  BEGIN
    Nm3ins.ins_nth(l_rec_nth_v);
    Nm3ins.ins_ntg(l_rec_ntg_v);
  EXCEPTION
    WHEN OTHERS
     THEN
        ROLLBACK;
        RAISE;
  END;
  --
  -- Create the spatial joined view
  -- v_work_order_lines_sdo
  l_mai_sdo_view_sql := ' CREATE OR REPLACE FORCE VIEW '
                        ||l_rec_nth_v.nth_feature_table||nl||
                        ' AS '||nl||
                        '  (SELECT '||nl||
                        nm3ddl.get_sccs_comments(pi_sccs_id => g_body_sccsid)||nl||
                        '          a.* '||nl||
                        '        , b.geoloc'||nl||
                        '     FROM '||g_wol_view_name||' a '||nl||
                        '        , '||l_rec_nth.nth_feature_table||' b '||nl||
                        '    WHERE a.'||g_wol_sdo_pk||' = b.'
                                    ||l_rec_nth.nth_feature_pk_column||' ) ';
  --
  BEGIN
    EXECUTE IMMEDIATE l_mai_sdo_view_sql;
    Nm3ddl.Create_Synonym_For_Object  (
                                      p_Object_Name => l_Rec_Nth_V.Nth_Feature_Table
                                      );
    
  EXCEPTION
    WHEN OTHERS
     THEN
        RAISE;
  END;
  --
  BEGIN
    l_dummy := Nm3sdo.create_sdo_layer(pi_table_name  => l_rec_nth_v.nth_feature_table
                                      ,pi_column_name => l_rec_nth_v.nth_feature_shape_column
                                      ,pi_gtype       => l_rec_ntg_v.ntg_gtype);
  EXCEPTION
    WHEN OTHERS
      THEN RAISE;
  END;
  --
  BEGIN
    --
    IF hig.get_sysopt ('REGSDELAY') = 'Y'
    THEN
       EXECUTE IMMEDIATE('begin'
                       ||'  nm3sde.register_sde_layer( p_theme_id => '||TO_CHAR( l_rec_nth_v.nth_theme_id )||'); '
                       ||'end;');
    END IF;
    --
  EXCEPTION
    WHEN others
     THEN
        nm_debug.debug('Problem with SDE = '||l_rec_nth_v.nth_theme_id||' - '||sqlerrm);
  END;
  ---------------------------------------------------------------
  -- Create a theme role - this will copy metadata to subordinate
  -- users if SDMREGULAY is set, and users have the END_USER role
  ----------------------------------------------------------------
  --
  l_rec_nthr.nthr_theme_id := l_rec_nth_v.nth_theme_id;
  l_rec_nthr.nthr_role     := 'MAI_USER';
  l_rec_nthr.nthr_mode     := 'NORMAL';
  --
  Nm3ins.ins_nthr(l_rec_nthr);
  --
  --------------------------------------------------------------
  -- Create NM_INV_THEME record to link asset to theme
  --------------------------------------------------------------
  --
  l_rec_nith_v.nith_nit_id       :=  pi_asset_type;
  l_rec_nith_v.nith_nth_theme_id :=  l_rec_nth_v.nth_theme_id;
  --
  nm3ins.ins_nith(l_rec_nith_v);
  --
  --------------------------------------------------------------
  -- Create theme functions
  --------------------------------------------------------------
  --
  FOR i IN 1..g_wol_theme_functions.COUNT
  LOOP
    -- nm_theme_functions_all
    l_rec_ntf := g_wol_theme_functions(i);
    l_rec_ntf.ntf_nth_theme_id := l_rec_nth_v.nth_theme_id ;
    nm3ins.ins_ntf(l_rec_ntf);
    --
  END LOOP;
  --
  /*
  ||Create WOL trigger to create default shapes.
  */
  build_wol_sdo_trigger(pi_theme_id => l_rec_nth.nth_theme_id);
  /*
  ||Create Lookups for the FT Asset Type.
  */
  create_wol_lookups(pi_asset_type => pi_asset_type);
  --
END make_base_wol_sdo_layer;
--
-----------------------------------------------------------------------------
--
PROCEDURE make_defect_secure_view
  IS
  --
  nl      VARCHAR2(10) := CHR(10);
  lv_str  nm3type.max_varchar2;
  --
BEGIN
  --------------------------------------------------------------
  -- Create an admin unit restricted view to base the theme on
  --------------------------------------------------------------
  lv_str := 'CREATE OR REPLACE FORCE VIEW '||g_view_name||nl||
            '    AS '||nl||
            'SELECT /*+ FIRST_ROWS */ '||nl||
            '       def.def_defect_id            defect_id '||nl||
            '      ,def.def_rse_he_id            '||g_view_ne_id_col||' '||nl||
            '      ,ne.ne_unique                 defect_road_name '||nl||
            '      ,ne.ne_descr                  defect_road_description '||nl||
            '      ,def.def_st_chain             '||g_view_st_chain_col||' '||nl||
            '      ,def.def_are_report_id        defect_are_report_id '||nl||
            '      ,def.def_siss_id              defect_siss_id '||nl||
            '      ,def.def_works_order_no       defect_works_order_no '||nl||
            '      ,trunc(def.def_created_date)  defect_created_date '||nl||
            '      ,are.are_date_work_done       defect_inspected_date '||nl||
            '      ,def.def_time_hrs||'':''||'||nl||
            '         def.def_time_mins            defect_inspected_time '||nl||
            '      ,def.def_defect_code          defect_code '||nl||
            '      ,def.def_priority             defect_priority '||nl||
            '      ,def.def_status_code          defect_status_code '||nl||
            '      ,def.def_atv_acty_area_code   defect_activity '||nl||
            '      ,def.def_locn_descr           defect_location '||nl||
            '      ,def.def_defect_descr         defect_description '||nl||
            '      ,def.def_ity_inv_code         defect_asset_type '||nl||
            '      ,def.def_iit_item_id          defect_asset_id '||nl||
            '      ,are.are_initiation_type      defect_initiation_type '||nl||
            '      ,upper(hus.hus_initials)          defect_inspector '||nl||
            '      ,def.def_x_sect               defect_x_section '||nl||
            '      ,org1.oun_name                defect_notify_org '||nl||
            '      ,org2.oun_name                defect_recharge_org '||nl||
            '   FROM defects def '||nl||
            '       ,activities_report are '||nl||
            '       ,nm_elements_all ne '||nl||
            '       ,hig_users hus '||nl||
            '       ,org_units org1 '||nl||
            '       ,org_units org2 '||nl||
            '  WHERE def.def_rse_he_id              = ne.ne_id '||nl||
            '    AND def.def_are_report_id          = are.are_report_id '||nl||
            '    AND are.are_peo_person_id_actioned = hus.hus_user_id '||nl||
            '    AND def.def_notify_org_id          = org1.oun_org_id(+) '||nl||
            '    AND def.def_rechar_org_id          = org2.oun_org_id(+) '
           ;
  --
  EXECUTE IMMEDIATE lv_str;
  --                     
  Nm3ddl.Create_Synonym_For_Object  (
                                    p_Object_Name => g_view_name
                                    );  
  --
END make_defect_secure_view;
--
-----------------------------------------------------------------------------
--
PROCEDURE make_wol_secure_view
IS
  nl VARCHAR2(10) := CHR(10);
BEGIN
  --------------------------------------------------------------
  -- Create an admin unit restricted view to base the theme on
  --------------------------------------------------------------
  --v_work_order_lines
  EXECUTE IMMEDIATE 'CREATE OR REPLACE FORCE VIEW '||g_wol_view_name||' AS'
              ||nl||'SELECT wol.wol_id             wol_id'
              ||nl||'      ,wol.wol_works_order_no wol_works_order_no'
              ||nl||'      ,wol.wol_descr          wol_remarks'
              ||nl||'      ,wol.wol_status_code    wol_status'
              ||nl||'      ,wol.wol_icb_work_code  wol_work_category'
              ||nl||'      ,wol.wol_rse_he_id      wol_road_id'
              ||nl||'      ,ne.ne_unique           wol_road_name'
              ||nl||'      ,ne.ne_descr            wol_road_description'
              ||nl||'      ,wol.wol_def_defect_id  wol_defect_id'
              ||nl||'      ,wol.wol_rep_action_cat wol_repair_category'
              ||nl||'      ,def.def_defect_code    wol_defect_type'
              ||nl||'      ,def.def_priority       wol_defect_priority'
              ||nl||'      ,rep.rep_tre_treat_code wol_treatment'
              ||nl||'      ,def.def_locn_descr     wol_defect_location'
              ||nl||'      ,wol.wol_schd_id        wol_schedule'
              ||nl||'      ,wol.wol_iit_item_id    wol_asset_id'
              ||nl||'      ,wol_register_flag      wol_registerable'
              ||nl||'      ,wol.wol_est_labour     wol_labour_units'
              ||nl||'      ,wol.wol_gang           wol_gang'
              ||nl||'      ,wol.wol_est_cost       wol_estimated_cost'
              ||nl||'      ,wol.wol_act_cost       wol_actual_cost'
              ||nl||'      ,DECODE(wol.wol_flag,''D'',rep.rep_date_due'
              ||nl||'                                ,wor.wor_est_complete) wol_target_date'
              ||nl||'      ,DECODE(wol.wol_date_complete,NULL,(NVL(TRUNC(DECODE(wol.wol_flag,''D'',rep.rep_date_due'
              ||nl||'                                                                             ,wor.wor_est_complete)),TRUNC(SYSDATE)) - TRUNC(SYSDATE))'
              ||nl||'                                        ,0) wol_days_to_target'
              ||nl||'      ,wol.wol_date_repaired  wol_date_repaired'
              ||nl||'      ,wol.wol_date_complete  wol_date_completed'
              ||nl||'  FROM defects def'
              ||nl||'      ,repairs rep'
              ||nl||'      ,work_orders wor'
              ||nl||'      ,work_order_lines wol'
              ||nl||'      ,nm_elements_all ne'
              ||nl||' WHERE ne.ne_id               = wol.wol_rse_he_id'
              ||nl||'   AND wol.wol_works_order_no = wor.wor_works_order_no'
              ||nl||'   AND wol.wol_def_defect_id  = rep.rep_def_defect_id(+)'
              ||nl||'   AND wol.wol_rep_action_cat = rep.rep_action_cat(+)'
              ||nl||'   AND rep.rep_def_defect_id  = def.def_defect_id(+)'
                  ;
  --
  Nm3ddl.Create_Synonym_For_Object  (
                                    p_Object_Name => g_wol_view_name
                                    );  
  
  --
END make_wol_secure_view;
--
-----------------------------------------------------------------------------
--
--  FUNCTIONS migrated from IM_FUNCS phantom package!
--
FUNCTION get_nvl_value (pi_nvl_code VARCHAR2) RETURN VARCHAR2 IS
  l_retval varchar2(4000);
BEGIN
  IF    pi_nvl_code = 'NS'
   THEN
      l_retval := c_not_set;
  ELSIF pi_nvl_code = 'NU'
   THEN
      l_retval := c_not_used;
  ELSIF pi_nvl_code = 'UK'
   THEN
      l_retval := c_unknown;
  ELSE
      l_retval := pi_nvl_code;
  END IF;
  RETURN l_retval;
END get_nvl_value;
--
-----------------------------------------------------------------------------
--
FUNCTION is_whole_number (pi_value_in VARCHAR2) RETURN BOOLEAN IS
  l_number NUMBER;
  l_retval BOOLEAN;
BEGIN
  BEGIN
    l_number := TO_NUMBER(pi_value_in);
    l_retval := l_number = TRUNC(l_number);
  EXCEPTION
    WHEN others
     THEN
        l_retval := FALSE;
  END;
  RETURN l_retval;
END is_whole_number;
--
-----------------------------------------------------------------------------
--
FUNCTION get_hco_meaning (pi_hdo_domain hig_domains.hdo_domain%TYPE
                         ,pi_hco_code   hig_codes.hco_code%TYPE
                         ,pi_nvl_code   VARCHAR2 DEFAULT NULL
                         ) RETURN hig_codes.hco_meaning%TYPE IS
  --
  CURSOR cs_hco (c_hdo_domain hig_domains.hdo_domain%TYPE
                ,c_hco_code   hig_codes.hco_code%TYPE
                ) IS
  SELECT hco_meaning
    FROM hig_codes
   WHERE hco_domain = c_hdo_domain
     AND hco_code   = c_hco_code;
  --
  l_retval hig_codes.hco_meaning%TYPE;
  --
BEGIN
  --
  IF  pi_hco_code   IS NULL
   OR pi_hdo_domain IS NULL
   THEN
      l_retval := get_nvl_value (pi_nvl_code);
  ELSE
      OPEN  cs_hco (pi_hdo_domain,pi_hco_code);
      FETCH cs_hco INTO l_retval;
      CLOSE cs_hco;
  END IF;
  --
  RETURN l_retval;
  --
END get_hco_meaning;
--
-----------------------------------------------------------------------------
--
FUNCTION get_interval_desc (pi_int_code intervals.int_code%TYPE) RETURN intervals.int_descr%TYPE IS
  --
  CURSOR cs_int (c_int_code intervals.int_code%TYPE) IS
  SELECT int_descr
    FROM intervals
   WHERE int_code = c_int_code;
  --
  l_retval intervals.int_descr%TYPE;
  l_is_storable_in_array BOOLEAN;
 --
BEGIN
  IF pi_int_code IS NULL
   THEN
      l_retval := c_not_set;
  ELSE
      --
      --  Store the value in a sparse PL/SQL table in array position (ID) if the passed value is a whole number
      --
      l_is_storable_in_array := is_whole_number(pi_int_code);
      IF l_is_storable_in_array
       AND g_tab_int_descr.EXISTS(pi_int_code)
       AND g_tab_int_code(pi_int_code) = pi_int_code
       THEN
          l_retval := g_tab_int_descr (pi_int_code);
      ELSE
          OPEN  cs_int (pi_int_code);
          FETCH cs_int INTO l_retval;
          CLOSE cs_int;
          IF l_is_storable_in_array
           THEN
              g_tab_int_descr (pi_int_code) := l_retval;
              g_tab_int_code (pi_int_code)  := pi_int_code;
          END IF;
      END IF;
  END IF;
  --
  RETURN l_retval;
  --
END get_interval_desc;
--
-----------------------------------------------------------------------------
--
FUNCTION get_treatment_descr (pi_tre_treat_code treatments.tre_treat_code%TYPE) RETURN treatments.tre_descr%TYPE IS
  --
  CURSOR cs_tre (c_tre_treat_code treatments.tre_treat_code%TYPE) IS
  SELECT tre_descr
    FROM treatments
   WHERE tre_treat_code = c_tre_treat_code;
  --
  l_retval treatments.tre_descr%TYPE;
  --
BEGIN
  --
  IF pi_tre_treat_code IS NULL
   THEN
      l_retval := c_not_recorded;
  ELSE
      OPEN  cs_tre (pi_tre_treat_code);
      FETCH cs_tre INTO l_retval;
      CLOSE cs_tre;
  END IF;
  --
  RETURN l_retval;
  --
END get_treatment_descr;
--
-----------------------------------------------------------------------------
--
FUNCTION get_estimated_cost_of_defect (pi_def_defect_id  defects.def_defect_id%TYPE
                                      ,pi_rep_action_cat repairs.rep_action_cat%TYPE
                                      ) RETURN NUMBER IS
  --
  l_retval NUMBER;
  --
BEGIN
  --
  SELECT SUM(boq_est_cost)  estcost
    INTO l_retval
    FROM boq_items
   WHERE boq_defect_id      = pi_def_defect_id
     AND boq_rep_action_cat = pi_rep_action_cat;
  --
  RETURN l_retval;
  --
END get_estimated_cost_of_defect;
--
-----------------------------------------------------------------------------
--
FUNCTION get_actual_cost_of_defect (pi_def_defect_id  defects.def_defect_id%TYPE
                                   ,pi_rep_action_cat repairs.rep_action_cat%TYPE
                                   ) RETURN NUMBER IS
  --
  l_retval NUMBER;
  --
BEGIN
  --
  SELECT SUM(boq_act_cost)  estcost
    INTO l_retval
    FROM boq_items
   WHERE boq_defect_id      = pi_def_defect_id
     AND boq_rep_action_cat = pi_rep_action_cat;
  --
  RETURN l_retval;
  --
END get_actual_cost_of_defect;
--
-----------------------------------------------------------------------------
--
FUNCTION get_admin_unit_descr (pi_hau_admin_unit hig_admin_units.hau_admin_unit%TYPE) RETURN hig_admin_units.hau_name%TYPE IS
  --
  CURSOR cs_hau (c_hau_admin_unit hig_admin_units.hau_admin_unit%TYPE) IS
  SELECT hau_name
   FROM  hig_admin_units
  WHERE  hau_admin_unit = c_hau_admin_unit;
  --
  l_retval hig_admin_units.hau_name%TYPE;
  --
BEGIN
  --
  --  Store the value in a sparse PL/SQL table in array position (ID)
  --
  IF pi_hau_admin_unit IS NOT NULL
   THEN
      IF g_tab_hau_name.EXISTS(pi_hau_admin_unit)
       THEN
          l_retval := g_tab_hau_name(pi_hau_admin_unit);
      ELSE
          OPEN  cs_hau (pi_hau_admin_unit);
          FETCH cs_hau INTO l_retval;
          CLOSE cs_hau;
          g_tab_hau_name(pi_hau_admin_unit) := l_retval;
      END IF;
  END IF;
  --
  RETURN l_retval;
  --
END get_admin_unit_descr;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_lookups(pi_asset_type IN nm_inv_types.nit_inv_type%TYPE)
IS
  --
  TYPE tab_ial IS TABLE OF nm_inv_attri_lookup_all%ROWTYPE INDEX BY BINARY_INTEGER;
  --
  l_lookup_list        nm3type.tab_varchar30;
  l_lookup_sql         nm3type.tab_varchar4000;
  l_lookup_col_name    nm3type.tab_varchar30;
  l_tab_code           nm3type.tab_varchar30;
  l_tab_meaning        nm3type.tab_varchar80;
  l_rec_ial            nm_inv_attri_lookup_all%ROWTYPE;
  l_tab_ial            tab_ial;
  --
BEGIN
  --
  -- Set domain names
  l_lookup_list(1)     := pi_asset_type||'_'||'DEFECT_SISS_ID_DOM';
  l_lookup_list(2)     := pi_asset_type||'_'||'DEFECT_PRIORITY_DOM';
  l_lookup_list(3)     := pi_asset_type||'_'||'DEFECT_STATUS_CODE';
  l_lookup_list(4)     := pi_asset_type||'_'||'DEFECT_ACTIVITY_DOM';
  l_lookup_list(5)     := pi_asset_type||'_'||'DEFECT_ASSET_TYPE_DOM';
  l_lookup_list(6)     := pi_asset_type||'_'||'DEFECT_INIT_TYPE_DOM';
  l_lookup_list(7)     := pi_asset_type||'_'||'DEFECT_INSPECTOR_DOM';
  l_lookup_list(8)     := pi_asset_type||'_'||'DEFECT_NOTIFY_DOM';
  l_lookup_list(9)     := pi_asset_type||'_'||'DEFECT_RECHARGE_DOM';
  -- test_defects
  l_lookup_col_name(1) := 'DEFECT_SISS_ID';
  l_lookup_col_name(2) := 'DEFECT_PRIORITY';
  l_lookup_col_name(3) := 'DEFECT_STATUS_CODE';
  l_lookup_col_name(4) := 'DEFECT_ACTIVITY';
  l_lookup_col_name(5) := 'DEFECT_ASSET_TYPE';
  l_lookup_col_name(6) := 'DEFECT_INITIATION_TYPE';
  l_lookup_col_name(7) := 'DEFECT_INSPECTOR';
  l_lookup_col_name(8) := 'DEFECT_NOTIFY_ORG';
  l_lookup_col_name(9) := 'DEFECT_RECHARGE_ORG';
  --
  -- Set domain lookup sql
  l_lookup_sql(1)      := 'select siss_id, substr(siss_name,0,80) from standard_item_sub_sections';
  l_lookup_sql(2)      := 'select hco_code, substr(hco_meaning,0,80) from hig_codes where hco_domain = ''DEFECT_PRIORITIES'' order by 1';
  l_lookup_sql(3)      := 'select hsc_status_code, substr(hsc_status_name,0,80) from hig_status_codes where hsc_domain_code = ''DEFECTS'' order by 1';
  l_lookup_sql(4)      := 'select atv_acty_area_code, substr(atv_descr,0,80) from activities order by 1';
  l_lookup_sql(5)      := 'select nit_inv_type, substr(nit_descr,0,80) from nm_inv_types order by 1';
  l_lookup_sql(6)      := 'select hco_code, substr(hco_meaning,0,80) from hig_codes where hco_domain like ''INITIATION_TYPE'' order by 1';
  l_lookup_sql(7)      := 'select hus_initials, substr(hus_name,0,80) from hig_users order by 1';
  l_lookup_sql(8)      := 'select oun_org_id, substr(oun_name,0,80) from org_units where oun_org_unit_type = ''NO'' order by 2';
  l_lookup_sql(9)      := 'select oun_org_id, substr(oun_name,0,80) from org_units where oun_org_unit_type = ''RE'' order by 2';
  --
  --nm_debug.debug_on;
  --
  -- NM_INV_ATTRI_LOOKUP_ALL
  FOR i IN 1..l_lookup_list.LAST
  LOOP
    --
    l_tab_ial.DELETE;
    -- Create domain first
    BEGIN
      INSERT INTO nm_inv_domains
        (id_domain, id_title, id_start_date, id_datatype)
      VALUES
        (l_lookup_list(i), l_lookup_list(i), To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY'), 'VARCHAR2');
      --
      EXECUTE IMMEDIATE l_lookup_sql(i) BULK COLLECT INTO l_tab_code, l_tab_meaning;
      --
      nm_debug.debug('Processing - '||l_lookup_list(i));
      --
      IF l_tab_code.COUNT > 0
      THEN
        FOR j IN 1..l_tab_code.LAST
        LOOP
        --
          l_tab_ial(j).ial_domain     := l_lookup_list(i);
          l_tab_ial(j).ial_value      := l_tab_code(j);
          l_tab_ial(j).ial_meaning    := l_tab_meaning(j);
          l_tab_ial(j).ial_start_date := To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY');
          l_tab_ial(j).ial_seq        := j;
        --
          nm_debug.debug('Inserting '||l_lookup_list(i)||' - '||l_tab_code(j)||' - '||l_tab_meaning(j)||' - '||Sys_Context('NM3CORE','EFFECTIVE_DATE'));
        END LOOP;
      END IF;
      --
      FORALL z IN 1..l_tab_ial.COUNT
        INSERT INTO nm_inv_attri_lookup_all
        VALUES l_tab_ial(z);
      --
      UPDATE nm_inv_type_attribs_all
         SET ita_id_domain   = l_lookup_list(i)
       WHERE ita_inv_type    = pi_asset_type
         AND ita_attrib_name = l_lookup_col_name(i);
    EXCEPTION
      WHEN OTHERS THEN NULL;
    END;
    --
  END LOOP;
  --
END create_lookups;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_wol_lookups(pi_asset_type IN nm_inv_types.nit_inv_type%TYPE)
  IS
  --
  TYPE tab_ial IS TABLE OF nm_inv_attri_lookup_all%ROWTYPE INDEX BY BINARY_INTEGER;
  --
  l_lookup_list        nm3type.tab_varchar30;
  l_lookup_sql         nm3type.tab_varchar4000;
  l_lookup_col_name    nm3type.tab_varchar30;
  l_lookup_datatype    nm3type.tab_varchar30;
  l_tab_code           nm3type.tab_varchar30;
  l_tab_meaning        nm3type.tab_varchar80;
  l_rec_ial            nm_inv_attri_lookup_all%ROWTYPE;
  l_tab_ial            tab_ial;
  --
BEGIN
  /*
  ||Set domain names.
  */
  l_lookup_list(1)     := pi_asset_type||'_'||'WOL_STATUS_DOM';
  l_lookup_list(2)     := pi_asset_type||'_'||'WOL_REPAIR_CATEGORY_DOM';
  l_lookup_list(3)     := pi_asset_type||'_'||'WOL_DEFECT_PRIORITY_DOM';
  l_lookup_list(4)     := pi_asset_type||'_'||'WOL_TREATMENT_DOM';
  l_lookup_list(5)     := pi_asset_type||'_'||'WOL_SCHEDULE_DOM';
  l_lookup_list(6)     := pi_asset_type||'_'||'WOL_REGISTERABLE_DOM';
  l_lookup_list(7)     := pi_asset_type||'_'||'WOL_GANG_DOM';
  l_lookup_list(8)     := pi_asset_type||'_'||'WOL_WORK_CATEGORY_DOM';
  /*
  ||Set column names.
  */
  l_lookup_col_name(1) := 'WOL_STATUS';
  l_lookup_col_name(2) := 'WOL_REPAIR_CATEGORY';
  l_lookup_col_name(3) := 'WOL_DEFECT_PRIORITY';
  l_lookup_col_name(4) := 'WOL_TREATMENT';
  l_lookup_col_name(5) := 'WOL_SCHEDULE';
  l_lookup_col_name(6) := 'WOL_REGISTERABLE';
  l_lookup_col_name(7) := 'WOL_GANG';
  l_lookup_col_name(8) := 'WOL_WORK_CATEGORY';
  /*
  ||Set the datatypes.
  */
  l_lookup_datatype(1) := 'VARCHAR2';
  l_lookup_datatype(2) := 'VARCHAR2';
  l_lookup_datatype(3) := 'VARCHAR2';
  l_lookup_datatype(4) := 'VARCHAR2';
  l_lookup_datatype(5) := 'NUMBER';
  l_lookup_datatype(6) := 'VARCHAR2';
  l_lookup_datatype(7) := 'NUMBER';
  l_lookup_datatype(8) := 'VARCHAR2';
  /*
  ||Set domain lookup sql
  */
  l_lookup_sql(1)      := 'select hsc_status_code, substr(hsc_status_name,0,80) from hig_status_codes where hsc_domain_code = ''WORK_ORDER_LINES'' order by hsc_seq_no';
  l_lookup_sql(2)      := 'select hco_code, substr(hco_meaning,0,80) from hig_codes where hco_domain = ''REPAIR_TYPE'' order by hco_seq';
  l_lookup_sql(3)      := 'select hco_code, substr(hco_meaning,0,80) from hig_codes where hco_domain = ''DEFECT_PRIORITIES'' order by hco_code';
  l_lookup_sql(4)      := 'select tre_treat_code,substr(tre_descr,0,80) from treatments order by 1';
  l_lookup_sql(5)      := 'select schd_id, substr(schd_icb_work_code||'' - ''||schd_name,0,80) from schedules order by 1';
  l_lookup_sql(6)      := 'select hco_code, substr(hco_meaning,0,80) from hig_codes where hco_domain = ''Y_OR_N'' order by hco_seq';
  l_lookup_sql(7)      := 'select hco_code, substr(hco_meaning,0,80) from hig_codes where hco_domain = ''GANG'' order by hco_seq';
  l_lookup_sql(8)      := 'select distinct icb_work_code, substr(icb_work_category_name,0,80) from item_code_breakdowns order by 1';
  nm_debug.debug_on;
  /*
  ||Create the domains and lookup values.
  */
  FOR i IN 1..l_lookup_list.LAST
  LOOP
    --
    l_tab_ial.DELETE;
    /*
    ||Create domain first.
    */
    BEGIN
      INSERT INTO nm_inv_domains
        (id_domain, id_title, id_start_date, id_datatype)
      VALUES
        (l_lookup_list(i), l_lookup_list(i),To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY'), l_lookup_datatype(i));
      /*
      ||Now create the lookup values.
      */
      EXECUTE IMMEDIATE l_lookup_sql(i) BULK COLLECT INTO l_tab_code, l_tab_meaning;
      --
      nm_debug.debug('Processing - '||l_lookup_list(i));
      --
      IF l_tab_code.COUNT > 0
      THEN
        FOR j IN 1..l_tab_code.LAST
        LOOP
        --
          l_tab_ial(j).ial_domain     := l_lookup_list(i);
          l_tab_ial(j).ial_value      := l_tab_code(j);
          l_tab_ial(j).ial_meaning    := l_tab_meaning(j);
          l_tab_ial(j).ial_start_date := To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY');
          l_tab_ial(j).ial_seq        := j;
        --
          nm_debug.debug('Inserting '||l_lookup_list(i)||' - '||l_tab_code(j)||' - '||l_tab_meaning(j)||' - '||To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY'));
        END LOOP;
      END IF;
      --
      FORALL z IN 1..l_tab_ial.COUNT
      INSERT INTO nm_inv_attri_lookup_all
      VALUES l_tab_ial(z)
           ;
      --
      UPDATE nm_inv_type_attribs_all
         SET ita_id_domain   = l_lookup_list(i)
       WHERE ita_inv_type    = pi_asset_type
         AND ita_attrib_name = l_lookup_col_name(i)
           ;
      --
--    EXCEPTION
--      WHEN OTHERS THEN NULL;
    END;
    --
  END LOOP;
  --
END create_wol_lookups;
--
-----------------------------------------------------------------------------
--
PROCEDURE get_wol_themes(pi_works_order_no IN  work_orders.wor_works_order_no%TYPE
                        ,pi_wol_id         IN  work_order_lines.wol_id%TYPE
                        ,pi_module         IN  hig_modules.hmo_module%TYPE
                        ,pi_join_to_msv    IN  BOOLEAN
                        ,po_nth_theme_id   OUT NUMBER
                        ,po_lov_sql        OUT VARCHAR2)
  IS
  --
  TYPE rec_gt IS RECORD(gt_theme_name gis_themes.gt_theme_name%TYPE
                       ,dummy         VARCHAR2(10)
                       ,gt_theme_id   gis_themes.gt_theme_id%TYPE);
  TYPE tab_gt IS TABLE OF rec_gt INDEX BY BINARY_INTEGER;
  --
  l_tab_gt  tab_gt;
  lf        VARCHAR2(10) := chr(10);
  l_sql     nm3type.max_varchar2;
  --
BEGIN
  /*
  ||Build the SQL to find the themes.
  */
  l_sql := ' SELECT gt_theme_name, NULL, gt_theme_id'
     ||lf||'   FROM gis_themes'
     ||lf||'       ,gis_theme_functions';
  --
  IF pi_join_to_msv
   THEN
      l_sql := l_sql||lf||'       ,v_nm_msv_map_def';
  END IF;
  --
  IF pi_join_to_msv
   THEN
      l_sql := l_sql||lf||'  WHERE vnmd_name = hig.get_sysopt (''WEBMAPNAME'')'
                    ||lf||'    AND vnmd_theme_name = gt_theme_name'
                    ||lf||'    AND gt_theme_id = gtf_gt_theme_id'
                    ||lf||'    AND gtf_hmo_module = '||nm3flx.string(pi_module);
  ELSE
      l_sql := l_sql||lf||'  WHERE gt_theme_id = gtf_gt_theme_id'
                    ||lf||'    AND gtf_hmo_module = '||nm3flx.string(pi_module);
  END IF;
  /*
  ||If called for a given Work Order or Work Order Line
  ||restrict the themes returned to those that contain them.
  */
  IF pi_wol_id IS NOT NULL
   THEN
      l_sql := l_sql||lf||'    AND EXISTS (SELECT 1 FROM DUAL'
                    ||lf||'                 WHERE mai_sdo_util.wol_has_shape(gt_theme_id,'||pi_wol_id||') = ''TRUE'' )';
  ELSIF pi_works_order_no IS NOT NULL
   THEN
      l_sql := l_sql||lf||'    AND EXISTS (SELECT 1 FROM DUAL'
                    ||lf||'                 WHERE mai_sdo_util.wo_has_shape(gt_theme_id,'||pi_works_order_no||') = ''TRUE'' )';
  END IF;
  /*
  ||Run the sql.
  */
  EXECUTE IMMEDIATE l_sql
  BULK COLLECT INTO l_tab_gt;
  /*
  ||Check the results.
  */
  IF l_tab_gt.COUNT = 1
   THEN
      /*
      ||One Theme found so return Theme Id.
      */
      po_nth_theme_id := l_tab_gt(1).gt_theme_id;
      po_lov_sql      := NULL;
      --
  ELSIF l_tab_gt.COUNT > 1
   THEN
      /*
      ||Multiple Themes found so return LOV SQL for Extended LOV.
      */
      po_nth_theme_id := -1;
      po_lov_sql      := l_sql;
      --
  ELSE
      /*
      ||No Themes found so return nothing.
      */
      po_nth_theme_id := -1;
      po_lov_sql      := NULL;
      --
  END IF;
  --
END get_wol_themes;
--
-----------------------------------------------------------------------------
--
END mai_sdo_util;
/
