--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3130_mai3200_metadata_upg.sql-arc   2.1   Jul 01 2013 16:02:16   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3130_mai3200_metadata_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:16  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.3
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--
--
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
--
--
DECLARE
  l_temp nm3type.max_varchar2;
BEGIN
  -- Dummy call to HIG to instantiate it
  l_temp := hig.get_version;
  l_temp := nm_debug.get_version;
EXCEPTION
  WHEN others
   THEN
 Null;
END;
/
----------------------------------------------------------------------------
--Call a proc in nm_debug to instantiate it before calling metadata scripts.
--
--If this is not done any inserts into hig_option_values may fail due to
-- mutating trigger when nm_debug checks DEBUGAUTON.
----------------------------------------------------------------------------
BEGIN
  nm_debug.debug_off;
END;
/
--
--
--
-------------------------------------------------------------------------------------------------
--  
DECLARE

  -------------------------------
  -- REMOVE REDUNDANT HIG_MODULES
  -------------------------------
   
   PROCEDURE drop_module(pi_hmo_module IN hig_modules.hmo_module%TYPE) IS
   
   BEGIN
    
         DELETE FROM hig_module_keywords
         WHERE       hmk_hmo_module = pi_hmo_module;

         DELETE FROM gri_param_dependencies
         WHERE       gpd_module = pi_hmo_module;

         DELETE FROM gri_module_params
         WHERE       gmp_module = pi_hmo_module;         

         DELETE FROM gri_modules
         WHERE       grm_module = pi_hmo_module;
            
         DELETE FROM hig_module_roles
         WHERE       hmr_module = pi_hmo_module;

         DELETE FROM hig_modules
         WHERE       hmo_module = pi_hmo_module;

         DELETE FROM hig_standard_favourites
         WHERE       hstf_child = pi_hmo_module;

         DELETE FROM hig_user_favourites 
         WHERE       huf_child = pi_hmo_module;

         DELETE FROM hig_system_favourites 
         WHERE       hsf_child = pi_hmo_module;
   
   END drop_module;

BEGIN
  drop_module('PMS4442');
  drop_module('PMS4448');  
  drop_module('PMS4410'); 
  drop_module('MAI2530'); 
END;
/
-------------------------------------------------------------------------------------------------
--
DECLARE
--
--  HIG_MODULES and HIG_MODULE_ROLES
--
   TYPE tab_rec_module IS TABLE OF hig_modules%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_hmo     hig_modules%ROWTYPE;
   l_tab_rec_hmo tab_rec_module;
--
   l_tab_hmr_module nm3type.tab_varchar30;
   l_tab_hmr_role   nm3type.tab_varchar30;
   l_tab_hmr_mode   nm3type.tab_varchar30;
--
   l_hmo_count      PLS_INTEGER := 0;
   l_hmr_count      PLS_INTEGER := 0;
--
   PROCEDURE add_hmo IS
   BEGIN
      l_hmo_count := l_hmo_count + 1;
      l_tab_rec_hmo(l_hmo_count) := l_rec_hmo;
   END add_hmo;
--
   PROCEDURE add_hmr (p_role   VARCHAR2
                     ,p_mode   VARCHAR2
                     ,p_module VARCHAR2 DEFAULT l_rec_hmo.hmo_module
                     ) IS
   BEGIN
      l_hmr_count := l_hmr_count + 1;
      l_tab_hmr_module(l_hmr_count) := UPPER(p_module);
      l_tab_hmr_role(l_hmr_count)   := UPPER(p_role);
      l_tab_hmr_mode(l_hmr_count)   := UPPER(p_mode);
   END add_hmr;
--
BEGIN
--

   l_rec_hmo.hmo_module           := 'MAI3918';
   l_rec_hmo.hmo_title            := 'Print Any Works Order';
   l_rec_hmo.hmo_filename         := 'mai3918';
   l_rec_hmo.hmo_module_type      := 'R25';
   l_rec_hmo.hmo_fastpath_opts    := NULL;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'Y';
   l_rec_hmo.hmo_application      := nm3type.c_mai;   
   l_rec_hmo.hmo_menu             := 'FORM';            
   add_hmo;
   
   l_rec_hmo.hmo_module           := 'MAI2530';
   l_rec_hmo.hmo_title            := 'Inspection Routes';
   l_rec_hmo.hmo_filename         := 'mai2530';
   l_rec_hmo.hmo_module_type      := 'FMX';
   l_rec_hmo.hmo_fastpath_opts    := NULL;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := 'MAI';   
   l_rec_hmo.hmo_menu             := null;            
   add_hmo;
   

   add_hmr('MAI_USER',nm3type.c_normal);
   add_hmr('MAI_ADMIN',nm3type.c_normal);
     
   FOR i IN 1..l_hmo_count
    LOOP
      l_rec_hmo := l_tab_rec_hmo(i);
      INSERT INTO hig_modules
            (hmo_module
            ,hmo_title
            ,hmo_filename
            ,hmo_module_type
            ,hmo_fastpath_opts
            ,hmo_fastpath_invalid
            ,hmo_use_gri
            ,hmo_application
            ,hmo_menu
            )
      SELECT l_rec_hmo.hmo_module
            ,l_rec_hmo.hmo_title
            ,l_rec_hmo.hmo_filename
            ,l_rec_hmo.hmo_module_type
            ,l_rec_hmo.hmo_fastpath_opts
            ,l_rec_hmo.hmo_fastpath_invalid
            ,l_rec_hmo.hmo_use_gri
            ,l_rec_hmo.hmo_application
            ,l_rec_hmo.hmo_menu
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_modules
                        WHERE  hmo_module = l_rec_hmo.hmo_module
                       );
   END LOOP;
--
   FORALL i IN 1..l_hmr_count
      INSERT INTO hig_module_roles
            (hmr_module
            ,hmr_role
            ,hmr_mode
            )
      SELECT l_tab_hmr_module(i)
            ,l_tab_hmr_role(i)
            ,l_tab_hmr_mode(i)
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_module_roles
                        WHERE  hmr_module = l_tab_hmr_module(i)
                         AND   hmr_role   = l_tab_hmr_role(i)
                       )
       AND  EXISTS     (SELECT 1
                         FROM  hig_roles
                        WHERE  hro_role   = l_tab_hmr_role(i)
                       )
       AND  EXISTS     (SELECT 1
                         FROM  hig_modules
                        WHERE  hmo_module = l_tab_hmr_module(i)
                       );
--
END;
/

--
-------------------------------------------------------------------------------------------------
--

DECLARE
--
-- ****************
-- *  GRI_MODULES *
-- ****************
--
   TYPE tab_rec_grm IS TABLE OF gri_modules%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_grm     gri_modules%ROWTYPE;
   l_tab_rec_grm tab_rec_grm;
--
   l_grm_count      PLS_INTEGER := 0;
--
   PROCEDURE add_grm IS
   BEGIN
      l_grm_count := l_grm_count + 1;
      l_tab_rec_grm(l_grm_count) := l_rec_grm;
   END add_grm;
--
BEGIN

  l_rec_grm.grm_module       := 'MAI3918';
  l_rec_grm.grm_module_type  := 'N/A';
  l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
  l_rec_grm.grm_file_type    := 'lis';
  l_rec_grm.grm_tag_flag     := 'N';
  l_rec_grm.grm_tag_table    := Null;
  l_rec_grm.grm_tag_column   := Null;
  l_rec_grm.grm_tag_where    := Null;
  l_rec_grm.grm_linesize     := 132;
  l_rec_grm.grm_pagesize     := 66;
  l_rec_grm.grm_pre_process  := Null;
  add_grm;
  
  
  FOR i IN 1..l_grm_count
    LOOP
      l_rec_grm := l_tab_rec_grm(i);
      INSERT INTO gri_modules
            (
             grm_module
            ,grm_module_type
            ,grm_module_path
            ,grm_file_type
            ,grm_tag_flag
            ,grm_tag_table
            ,grm_tag_column
            ,grm_tag_where
            ,grm_linesize
            ,grm_pagesize
            ,grm_pre_process
            )
      SELECT
             l_rec_grm.grm_module
            ,l_rec_grm.grm_module_type
            ,l_rec_grm.grm_module_path
            ,l_rec_grm.grm_file_type
            ,l_rec_grm.grm_tag_flag
            ,l_rec_grm.grm_tag_table
            ,l_rec_grm.grm_tag_column
            ,l_rec_grm.grm_tag_where
            ,l_rec_grm.grm_linesize
            ,l_rec_grm.grm_pagesize
            ,l_rec_grm.grm_pre_process
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  gri_modules
                        WHERE  grm_module = l_rec_grm.grm_module
                       );
   END LOOP;
--
END;
/

--
-------------------------------------------------------------------------------------------------
--

DECLARE
--
-- **********************
-- *  GRI_MODULE_PARAMS *
-- **********************
--
   TYPE tab_rec_gmp IS TABLE OF gri_module_params%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_gmp     gri_module_params%ROWTYPE;
   l_tab_rec_gmp tab_rec_gmp;
--
   l_gmp_count      PLS_INTEGER := 0;
--
   PROCEDURE add_gmp IS
   BEGIN
      l_gmp_count := l_gmp_count + 1;
      l_tab_rec_gmp(l_gmp_count) := l_rec_gmp;
   END add_gmp;
--
BEGIN
-- check this one on monday paul
  l_rec_gmp.gmp_module            := 'MAI3918';
  l_rec_gmp.gmp_param             := 'WORKS_ORDER_NO';
  l_rec_gmp.gmp_seq               := 1;
  l_rec_gmp.gmp_param_descr       := 'Works Order No.';
  l_rec_gmp.gmp_mandatory         := 'Y';
  l_rec_gmp.gmp_no_allowed        := 1;
  l_rec_gmp.gmp_where             := Null;
  l_rec_gmp.gmp_tag_restriction   := 'N';
  l_rec_gmp.gmp_tag_where         := Null;
  l_rec_gmp.gmp_default_table     := Null;
  l_rec_gmp.gmp_default_column    := Null;
  l_rec_gmp.gmp_default_where     := Null;
  l_rec_gmp.gmp_visible           := 'Y';
  l_rec_gmp.gmp_gazetteer         := 'N';
  l_rec_gmp.gmp_lov               := 'Y';
  l_rec_gmp.gmp_val_global        := NULL;
  l_rec_gmp.gmp_wildcard          := 'N';
  l_rec_gmp.gmp_hint_text         := 'Enter a Works Order number';
  l_rec_gmp.gmp_allow_partial     := 'N';
  l_rec_gmp.gmp_base_table        := 'NM_ELEMENTS'; 
  l_rec_gmp.gmp_base_table_column := 'NE_ID';
  l_rec_gmp.gmp_operator          := '=';
  add_gmp;
--

   FOR i IN 1..l_gmp_count
    LOOP
      l_rec_gmp := l_tab_rec_gmp(i);
      INSERT INTO gri_module_params
            (
             gmp_module
            ,gmp_param
            ,gmp_seq
            ,gmp_param_descr
            ,gmp_mandatory
            ,gmp_no_allowed
            ,gmp_where
            ,gmp_tag_restriction
            ,gmp_tag_where
            ,gmp_default_table
            ,gmp_default_column
            ,gmp_default_where
            ,gmp_visible
            ,gmp_gazetteer
            ,gmp_lov
            ,gmp_val_global
            ,gmp_wildcard
            ,gmp_hint_text
            ,gmp_allow_partial
            ,gmp_base_table
            ,gmp_base_table_column
            ,gmp_operator
            )
      SELECT
            l_rec_gmp.gmp_module
           ,l_rec_gmp.gmp_param
           ,l_rec_gmp.gmp_seq
           ,l_rec_gmp.gmp_param_descr
           ,l_rec_gmp.gmp_mandatory
           ,l_rec_gmp.gmp_no_allowed
           ,l_rec_gmp.gmp_where
           ,l_rec_gmp.gmp_tag_restriction
           ,l_rec_gmp.gmp_tag_where
           ,l_rec_gmp.gmp_default_table
           ,l_rec_gmp.gmp_default_column
           ,l_rec_gmp.gmp_default_where
           ,l_rec_gmp.gmp_visible
           ,l_rec_gmp.gmp_gazetteer
           ,l_rec_gmp.gmp_lov
           ,l_rec_gmp.gmp_val_global
           ,l_rec_gmp.gmp_wildcard
           ,l_rec_gmp.gmp_hint_text
           ,l_rec_gmp.gmp_allow_partial
           ,l_rec_gmp.gmp_base_table
           ,l_rec_gmp.gmp_base_table_column
           ,l_rec_gmp.gmp_operator
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  gri_module_params
                        WHERE  gmp_module = l_rec_gmp.gmp_module
                        AND    gmp_param  = l_rec_gmp.gmp_param
                       );
   END LOOP;
--
END;
/
--
-------------------------------------------------------------------------------------------------
--
COMMIT;
--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

