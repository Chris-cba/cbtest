CREATE OR REPLACE PACKAGE BODY mai_sdo_util
IS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_sdo_util.pkb-arc   2.0   Jun 13 2007 17:36:50   smarshall  $
--       Module Name      : $Workfile:   mai_sdo_util.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:50  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.8
--
--   Author : A. Edwards
--
-----------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2006
-----------------------------------------------------------------------------
--
   g_body_sccsid      CONSTANT VARCHAR2 (2000) := '$Revision:   2.0  $';
   g_package_name     CONSTANT VARCHAR2 (30)   := 'MAI_SDO_UTIL';
   nl                 CONSTANT VARCHAR2 (5)    := chr(10);
--
  TYPE tab_ntf
    IS TABLE OF nm_theme_functions_all%ROWTYPE INDEX BY BINARY_INTEGER;
--
   g_theme_name_xy           nm3type.tab_varchar30;
   g_theme_name_lr           nm3type.tab_varchar30;
   g_theme_functions         tab_ntf;
   g_theme_feature_views_lr  nm3type.tab_varchar30;
   g_theme_feature_views_xy  nm3type.tab_varchar30;
--
   g_prod_option      CONSTANT hig_option_values.hov_id%TYPE     := 'SDODEFNTH';
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
--nm_themes_All
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
  PROCEDURE update_prod_option
              ( pi_nth_theme_id IN nm_themes_all.nth_theme_id%TYPE )
  IS
  BEGIN
    UPDATE hig_option_values
       SET hov_value = pi_nth_theme_id
     WHERE hov_id = g_prod_option;
  END update_prod_option;
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
   PROCEDURE create_nin (pi_asset_type IN nm_inv_types.nit_inv_type%TYPE
                        ,po_base_theme OUT nm_themes_all.nth_Theme_id%TYPE )
   IS
      l_tab_nw   nm3type.tab_varchar4;
      l_tab_nth  nm3type.tab_number;
   BEGIN
      SELECT vnnt_nt_type, vnnt_nth_theme_id
      BULK COLLECT INTO l_tab_nw, l_tab_nth
        FROM v_nm_net_themes
       WHERE EXISTS (
                SELECT UNIQUE ne_nt_type
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
         INSERT INTO nm_inv_nw
                     (nin_nw_type, nin_nit_inv_code, nin_loc_mandatory,
                      nin_start_date
                     )
              VALUES (l_tab_nw (i), pi_asset_type, 'N',
                      nm3user.get_effective_date
                     );
      --
      END LOOP;
      --
      po_base_theme := l_tab_nth(1);
      --
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
--
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
  END set_theme_functions;
--
-----------------------------------------------------------------------------
--
   PROCEDURE make_base_sdo_layer
               ( pi_theme_name    IN  nm_themes_all.nth_theme_name%TYPE
               , pi_asset_type    IN  nm_inv_types.nit_inv_type%TYPE
               , pi_asset_descr   IN  nm_inv_types.nit_descr%TYPE
               , pi_x_column      IN  user_tab_columns.column_name%TYPE
               , pi_y_column      IN  user_tab_columns.column_name%TYPE
               , pi_lr_ne_column  IN  user_tab_columns.column_name%TYPE
               , pi_lr_st_chain   IN  user_tab_columns.column_name%TYPE
               , pi_snapping_trig IN  VARCHAR2 DEFAULT 'TRUE')
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
     IF nm3get.get_nit (pi_nit_inv_type         => pi_asset_type,
                        pi_raise_not_found      => FALSE
                       ).nit_inv_type IS NULL
     THEN
       nm3inv.create_ft_asset_from_table
         ( pi_table_name         => g_view_name
         , pi_pk_column          => g_sdo_pk
         , pi_asset_type         => pi_asset_type
         , pi_asset_descr        => pi_asset_descr
         , pi_pnt_or_cont        => 'P'
         , pi_use_xy             => 'Y'
         , pi_x_column           => NULL--pi_x_column
         , pi_y_column           => NULL-- pi_y_column
         , pi_lr_ne_column       => NULL-- pi_lr_ne_column
         , pi_lr_st_chain        => NULL-- pi_lr_st_chain
         , pi_lr_end_chain       => NULL
         , pi_attrib_ltrim       => 7);
     END IF;
    --
    --
    --------------------------------------------------------------
    -- *********************************************************
    -- Build the base table DEFECT theme
    -- *********************************************************
    --------------------------------------------------------------
    --
      l_rec_nth.nth_theme_id                := l_theme_id;
      l_rec_nth.nth_theme_name              := pi_theme_name;
      l_rec_nth.nth_table_name              := g_table_name;
    --
      IF b_using_xy
      OR b_using_both
      THEN
        l_rec_nth.nth_where                   := pi_x_column||' IS NOT NULL '||
                                         'AND '||pi_y_column||' IS NOT NULL ';

        IF  nm3ddl.does_object_exist (g_feature_tab_xy)
        THEN
          RAISE_APPLICATION_ERROR (-20110,g_feature_tab_xy||' exists - please drop or rename');
        END IF;

      ELSIF b_using_lref
      THEN

        l_rec_nth.nth_where                   := pi_lr_st_chain||' IS NOT NULL ';

        IF  nm3ddl.does_object_exist (g_feature_tab_lr)
        THEN
          RAISE_APPLICATION_ERROR (-20110,g_feature_tab_lr||' exists - please drop or rename');
        END IF;
        --
        create_nin (pi_asset_type, l_base_theme_id);
        --
      END IF;
    --
      l_rec_nth.nth_pk_column               := g_pk_column;
      l_rec_nth.nth_label_column            := g_pk_column;
      l_rec_nth.nth_rse_table_name          := 'NM_ELEMENTS';
      l_rec_nth.nth_rse_fk_column           := pi_lr_ne_column;
      l_rec_nth.nth_st_chain_column         := pi_lr_st_chain;
      l_rec_nth.nth_end_chain_column        := NULL;
      l_rec_nth.nth_x_column                := pi_x_column;
      l_rec_nth.nth_y_column                := pi_y_column;
      l_rec_nth.nth_offset_field            := NULL;

      IF b_using_xy
      THEN
        l_rec_nth.nth_feature_table           := g_feature_tab_xy;
      ELSIF b_using_lref
      THEN
        l_rec_nth.nth_feature_table           := g_feature_tab_lr;
      END IF;

      l_rec_nth.nth_feature_pk_column       := g_pk_column;
      l_rec_nth.nth_feature_fk_column       := NULL;
      l_rec_nth.nth_xsp_column              := NULL;
      l_rec_nth.nth_feature_shape_column    := g_shape_col;
      l_rec_nth.nth_hpr_product             := 'MAI';
      l_rec_nth.nth_location_updatable      := 'Y';
      l_rec_nth.nth_theme_type              := 'LOCL';
      l_rec_nth.nth_dependency              := 'I';
      l_rec_nth.nth_storage                 := 'S';
      l_rec_nth.nth_update_on_edit          := 'N';
      l_rec_nth.nth_use_history             := 'N';
      l_rec_nth.nth_start_date_column       := NULL;
      l_rec_nth.nth_end_date_column         := NULL;
      l_rec_nth.nth_base_table_theme        := NULL;
      l_rec_nth.nth_sequence_name           := 'NTH_' || l_theme_id || '_SEQ';
      l_rec_nth.nth_snap_to_theme           := 'S';
      l_rec_nth.nth_lref_mandatory          := 'N';
      l_rec_nth.nth_tolerance               := 10;
      l_rec_nth.nth_tol_units               := 1;
      l_rec_nth.nth_dynamic_theme           := 'N';
    --
      l_rec_ntg.ntg_theme_id                := l_theme_id;
      l_rec_ntg.ntg_gtype                   := '2001';
      l_rec_ntg.ntg_seq_no                  := 1;
      l_rec_ntg.ntg_xml_url                 := NULL;
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
      nm3sdo.create_sdo_layer_from_locl (l_rec_nth.nth_theme_id, l_base_theme_id);
    --
    --------------------------------------------------------------
    -- Create NM_INV_THEME record to link asset to theme
    --------------------------------------------------------------
    --
      l_rec_nith.nith_nit_id        :=  pi_asset_type;
      l_rec_nith.nith_nth_theme_id  :=  l_rec_nth.nth_theme_id;
    --
      nm3ins.ins_nith (l_rec_nith);
    --
    --
    --------------------------------------------------------------
    -- Create base themes
    --------------------------------------------------------------
    --
      nm3layer_tool.associate_base_linear_themes
                      ( pi_nth_theme_id => l_rec_nth.nth_theme_id );
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
      update_prod_option ( l_rec_nth.nth_theme_id );

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
        l_rec_nth_v.nth_theme_id               := Nm3seq.next_nth_theme_id_seq;
        l_rec_nth_v.nth_table_name             := g_view_name;
        l_rec_nth_v.nth_pk_column              := g_sdo_pk;
        l_rec_nth_v.nth_label_column           := g_sdo_pk;

        IF b_using_xy
        THEN
          l_rec_nth_v.nth_theme_name           := g_theme_name_xy(i);
          l_rec_nth_v.nth_feature_pk_column    := g_sdo_pk;
          l_rec_nth_v.nth_feature_table        := g_theme_feature_views_xy(i);
        ELSIF b_using_lref
        THEN
          l_rec_nth_v.nth_theme_name           := g_theme_name_lr(i);
          l_rec_nth_v.nth_feature_pk_column    := g_sdo_pk;
          l_rec_nth_v.nth_feature_table        := g_theme_feature_views_lr(i);
        END IF;

      --
        l_rec_nth_v.nth_theme_type             := 'SDO';
        l_rec_nth_v.nth_base_table_theme       := l_rec_nth.nth_theme_id;
      --
        l_rec_ntg_v.ntg_theme_id               := l_rec_nth_v.nth_theme_id;
        l_rec_ntg_v.ntg_gtype                  := '2001';
        l_rec_ntg_v.ntg_seq_no                 := 1;
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
          Nm3ddl.create_synonym_for_object (l_rec_nth_v.nth_feature_table);
        EXCEPTION
          WHEN OTHERS
            THEN RAISE ;
        END;
      --
        BEGIN
          l_dummy := Nm3sdo.create_sdo_layer
                     ( pi_table_name   => l_rec_nth_v.nth_feature_table
                     , pi_column_name  => l_rec_nth_v.nth_feature_shape_column
                     , pi_gtype        => l_rec_ntg_v.ntg_gtype);
        EXCEPTION
          WHEN OTHERS
            THEN RAISE;
        END;
      --
        BEGIN
          IF Hig.get_sysopt ('REGSDELAY') = 'Y'
          THEN
           EXECUTE IMMEDIATE
             ( ' begin  '
             ||'    nm3sde.register_sde_layer( p_theme_id => '||TO_CHAR( l_rec_nth_v.nth_theme_id )||');'
             ||' end;'
             );
          END IF;
        EXCEPTION 
          WHEN OTHERS THEN nm_debug.debug('Problem with SDE = '||l_rec_nth_v.nth_theme_id||' - '||sqlerrm);
        END;
       
        ---------------------------------------------------------------
        -- Create a theme role - this will copy metadata to subordinate
        -- users if SDMREGULAY is set, and users have the END_USER role
        ----------------------------------------------------------------
        --
        l_rec_nthr.nthr_theme_id  := l_rec_nth_v.nth_theme_id;
        l_rec_nthr.nthr_role      := 'MAI_USER';
        l_rec_nthr.nthr_mode      := 'NORMAL';
      --
        Nm3ins.ins_nthr ( l_rec_nthr );
        --
        --------------------------------------------------------------
        -- Create NM_INV_THEME record to link asset to theme
        --------------------------------------------------------------
        --
        l_rec_nith_v.nith_nit_id        :=  pi_asset_type;
        l_rec_nith_v.nith_nth_theme_id  :=  l_rec_nth_v.nth_theme_id;
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
        nm3layer_tool.associate_base_linear_themes
                          ( pi_nth_theme_id => l_rec_nth_v.nth_theme_id);
      --
      END LOOP;
      --
      IF pi_snapping_trig = 'TRUE'
      THEN
        nm3sdm.create_nth_sdo_trigger ( l_rec_nth.nth_theme_id );
      END IF;
    --
      create_lookups
             ( pi_asset_type => pi_asset_type);
    --
   END make_base_sdo_layer;
--
-----------------------------------------------------------------------------
--
   PROCEDURE make_defect_secure_view
   IS
     nl                           VARCHAR2(10)               := CHR(10);
   BEGIN
     --------------------------------------------------------------
     -- Create an admin unit restricted view to base the theme on
     --------------------------------------------------------------
     EXECUTE IMMEDIATE
--       nm3ddl.get_sccs_comments( pi_sccs_id => g_body_sccsid)||nl||
       'CREATE OR REPLACE FORCE VIEW '||g_view_name||nl||
       ' AS '||nl||
       '  SELECT /*+ FIRST_ROWS */ '||nl||
       '         def.def_defect_id            defect_id '||nl||
       '       , def.def_rse_he_id            defect_road_id '||nl||
       '       , ne.ne_unique                 defect_road_name '||nl||
       '       , ne.ne_descr                  defect_road_description '||nl||
       '       , def.def_st_chain             defect_start_chain '||nl||
       '       , def.def_are_report_id        defect_are_report_id '||nl||
       '       , def.def_siss_id              defect_siss_id '||nl||
       '       , def.def_works_order_no       defect_works_order_no '||nl||
       '       , trunc(def.def_created_date)  defect_created_date '||nl||
       '       , are.are_date_work_done       defect_inspected_date '||nl||
       '       , def.def_time_hrs||'':''||'||nl||
       '         def.def_time_mins            defect_inspected_time '||nl||
       '       , def.def_defect_code          defect_code '||nl||
       '       , def.def_priority             defect_priority '||nl||
       '       , def.def_status_code          defect_status_code '||nl||
       '       , def.def_atv_acty_area_code   defect_activity '||nl||
       '       , def.def_locn_descr           defect_location '||nl||
       '       , def.def_defect_descr         defect_description '||nl||
       '       , def.def_ity_inv_code         defect_asset_type '||nl||
       '       , def.def_iit_item_id          defect_asset_id '||nl||
       '       , are.are_initiation_type      defect_initiation_type '||nl||
       '       , upper(hus.hus_name)          defect_inspector '||nl||
       '       , def.def_x_sect               defect_x_section '||nl||
       '       , org1.oun_name                defect_notify_org '||nl||
       '       , org2.oun_name                defect_recharge_org '||nl||
       '    FROM defects def '||nl||
       '       , activities_report are '||nl||
       '       , nm_elements_all ne '||nl||
       '       , hig_users hus '||nl||
       '       , org_units org1 '||nl||
       '       , org_units org2 '||nl||
       '   WHERE def.def_rse_he_id              = ne.ne_id '||nl||
       '     AND def.def_are_report_id          = are.are_report_id '||nl||
       '     AND are.are_peo_person_id_actioned = hus.hus_user_id '||nl||
       '     AND def.def_notify_org_id          = org1.oun_org_id(+) '||nl||
       '     AND def.def_rechar_org_id          = org2.oun_org_id(+)';

--       ' (DEF_DEFECT_ID, STATUS, ADMIN_UNIT, ADMIN_UNIT_ID, ROAD_HE_ID, '||nl||
--       '  ROAD_ID, ROAD_NAME, MAINTENANCE_CATEGORY, INSPECTION_FREQUENCY, LOCATION,'||nl||
--       '  DESCRIPTION, XSP, OFFSET, EASTING, NORTHING, '||nl||
--       '  INSPECTION_ID, PRIORITY, ACTIVITY_TYPE, DEFECT_TYPE, ACTION_TYPE, '||nl||
--       '  ACTION, ACTION_DESCRIPTION, DATE_INSPECTED, DUE_DATE, DATE_REPAIRED, '||nl||
--       '  LATE, WO_NUMBER, ESTIMATED_COST, ACTUAL_COST) '||nl||
--       ' AS '||nl||
--       ' SELECT '||nl||
--       '   def_defect_id DEF_DEFECT_ID '||nl||
--       '  ,def_status_code STATUS '||nl||
--       '  ,SUBSTR(mai_sdo_util.get_admin_unit_descr(rse_admin_unit),1,40) ADMIN_UNIT '||nl||
--       '  ,rse_admin_unit ADMIN_UNIT_ID '||nl||
--       '  ,rse_he_id ROAD_HE_ID '||nl||
--       '  ,rse_unique ROAD_ID '||nl||
--       '  ,rse_descr ROAD_NAME '||nl||
--       '  ,SUBSTR(mai_sdo_util.get_hco_meaning('||nm3flx.string('MAINTENANCE_CATEGORY')
--              ||',rse_maint_category),1,52) MAINTENANCE_CATEGORY '||nl||
--       '  ,SUBSTR(mai_sdo_util.get_interval_desc(rse_int_code),1,40) INSPECTION_FREQUENCY '||nl||
--       '  ,def_locn_descr LOCATION '||nl||
--       '  ,def_defect_descr DESCRIPTION '||nl||
--       '  ,SUBSTR(mai_sdo_util.get_hco_meaning('||nm3flx.string('XSP_VALUES')
--              ||',def_x_sect),1,52) XSP '||nl||
--       '  ,def_st_chain OFFSET '||nl||
--       '  ,def_easting EASTING '||nl||
--       '  ,def_northing NORTHING '||nl||
--       '  ,def_are_report_id INSPECTION_ID '||nl||
--       '  ,SUBSTR(mai_sdo_util.get_hco_meaning('||nm3flx.string('DEFECT_PRIORITIES')
--              ||',def_x_sect),1,52) PRIORITY '||nl||
--       '  ,atv_descr ACTIVITY_TYPE '||nl||
--       '  ,dty_descr1 DEFECT_TYPE '||nl||
--       '  ,DECODE(rep_action_cat,'||nm3flx.string('I')
--                             ||','||nm3flx.string('Immediate')
--                             ||','||nm3flx.string('T')
--                             ||','||nm3flx.string('Temporary')
--                             ||','||nm3flx.string('Permanent')||') ACTION_TYPE '||nl||
--      '   ,SUBSTR(mai_sdo_util.get_treatment_descr(rep_tre_treat_code),1,40) ACTION '||nl||
--      '   ,rep_descr ACTION_DESCRIPTION '||nl||
--      '   ,def_created_date DATE_INSPECTED '||nl||
--      '   ,rep_date_due DUE_DATE '||nl||
--      '   ,rep_date_completed DATE_REPAIRED '||nl||
--      '   ,DECODE(SIGN(rep_date_due-rep_date_completed),-1,'||nm3flx.string('Y')
--                             ||','||nm3flx.string('N')||') LATE '||nl||
--      '   ,def_works_order_no WO_NUMBER '||nl||
--      '   ,mai_sdo_util.get_estimated_cost_of_defect(def_defect_Id,rep_action_cat) ESTIMATED_COST '||nl||
--      '   ,mai_sdo_util.get_actual_cost_of_defect(def_defect_Id,rep_action_cat) ACTUAL_COST '||nl||
--      '   FROM  (SELECT def.* '||nl||
--      '         ,dty.dty_dtp_flag '||nl||
--      '         ,dty.dty_descr1 '||nl||
--      '         ,rep.* '||nl||
--      '   FROM  DEFECTS   def '||nl||
--      '        ,DEF_TYPES dty '||nl||
--      '        ,REPAIRS   rep '||nl||
--      '  WHERE  def_defect_code        = dty_defect_code '||nl||
--      '    AND   def_atv_acty_area_code = dty_atv_acty_area_code '||nl||
--      '    AND   def_defect_id          = rep_def_defect_id '||nl||
--      '  ) '||nl||
--      ' ,road_sections '||nl||
--      ' ,ACTIVITIES '||nl||
--      ' WHERE  atv_acty_area_code     = def_atv_acty_area_code ' ||nl||
--      '   AND   atv_dtp_flag           = rse_sys_flag '||nl||
--      '   AND   dty_dtp_flag           = rse_sys_flag '||nl||
--      '   AND   def_rse_he_id          = rse_he_id ';
     --
     Nm3ddl.create_synonym_for_object (g_view_name);
     --
   END make_defect_secure_view;
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
       FROM  hig_codes
      WHERE  hco_domain = c_hdo_domain
       AND   hco_code   = c_hco_code;
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
       FROM  intervals
      WHERE  int_code = c_int_code;
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
         IF   l_is_storable_in_array
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
       FROM  treatments
      WHERE  tre_treat_code = c_tre_treat_code;
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
       INTO  l_retval
       FROM  boq_items
      WHERE  boq_defect_id      = pi_def_defect_id
       AND   boq_rep_action_cat = pi_rep_action_cat;
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
       INTO  l_retval
       FROM  boq_items
      WHERE  boq_defect_id      = pi_def_defect_id
       AND   boq_rep_action_cat = pi_rep_action_cat;
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
  PROCEDURE create_lookups
             ( pi_asset_type   IN   nm_inv_types.nit_inv_type%TYPE )
  IS
  --
    TYPE
      tab_ial IS TABLE OF nm_inv_attri_lookup_all%ROWTYPE INDEX BY BINARY_INTEGER;
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
          (l_lookup_list(i), l_lookup_list(i), nm3user.get_effective_date, 'VARCHAR2');
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
            l_tab_ial(j).ial_start_date := nm3user.get_effective_date;
            l_tab_ial(j).ial_seq        := j;
          --
            nm_debug.debug('Inserting '||l_lookup_list(i)||' - '||l_tab_code(j)||' - '||l_tab_meaning(j)||' - '||nm3user.get_effective_date);
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
END mai_sdo_util;
/
