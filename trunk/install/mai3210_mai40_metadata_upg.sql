--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai40_metadata_upg.sql-arc   2.1   Jul 01 2013 16:02:20   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3210_mai40_metadata_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.38
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
-------------------------------------------------------------------------------------------------
--
-- MAI3664 is now a COR module so re-assign any hig_module roles to the replacement module - Graeme
--
INSERT INTO HIG_MODULE_ROLES(hmr_module
                            ,hmr_role
                            ,hmr_mode)
SELECT 'HIG3664'
      ,hmr_role
      ,hmr_mode
FROM  hig_module_roles hmr1
WHERE hmr_module = 'MAI3664'
AND NOT EXISTS (SELECT 'X'
                FROM hig_module_roles hmr2
                WHERE hmr2.hmr_module = 'HIG3664'
                AND   hmr2.hmr_role   = hmr1.hmr_role)
/
COMMIT
/
--
-------------------------------------------------------------------------------------------------
--
DECLARE
  ---------------------------------------
  -- ADD HIG_MODULES and HIG_MODULE_ROLES
  ---------------------------------------
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
   c_xval CONSTANT VARCHAR2(4) := 'XVAL';
   c_web  CONSTANT VARCHAR2(3) := 'WEB';
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
   l_rec_hmo.hmo_module           := 'MAI3841';
   l_rec_hmo.hmo_title            := 'Payment Run Report';
   l_rec_hmo.hmo_filename         := 'MAI3941';
   l_rec_hmo.hmo_module_type      := 'R25';
   l_rec_hmo.hmo_fastpath_opts    := Null;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'Y';
   l_rec_hmo.hmo_application      := 'MAI';
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr ('MAI_USER','NORMAL');
--
   l_rec_hmo.hmo_module           := 'MAI3807_NET';
   l_rec_hmo.hmo_title            := 'Locator Create Defect On Network';
   l_rec_hmo.hmo_filename         := 'mai3807';
   l_rec_hmo.hmo_module_type      := 'FMX';
   l_rec_hmo.hmo_fastpath_opts    := Null;
   l_rec_hmo.hmo_fastpath_invalid := 'Y';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := 'MAI';
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr('MAI_USER','NORMAL');
   add_hmr('MAI_ADMIN','NORMAL');
--
   l_rec_hmo.hmo_module           := 'MAI0132';
   l_rec_hmo.hmo_title            := 'Work Order Priorities';
   l_rec_hmo.hmo_filename         := 'mai0132';
   l_rec_hmo.hmo_module_type      := 'FMX';
   l_rec_hmo.hmo_fastpath_opts    := Null;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := 'MAI';
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr('MAI_USER','NORMAL');
   add_hmr('MAI_ADMIN','NORMAL');
--
   l_rec_hmo.hmo_module           := 'MAI3811';
   l_rec_hmo.hmo_title            := 'Asset Work Order Lines History';
   l_rec_hmo.hmo_filename         := 'mai3811';
   l_rec_hmo.hmo_module_type      := 'FMX';
   l_rec_hmo.hmo_fastpath_opts    := Null;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := 'MAI';
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr('MAI_USER','NORMAL');
   add_hmr('MAI_ADMIN','NORMAL');
--
   l_rec_hmo.hmo_module           := 'MAI3815';
   l_rec_hmo.hmo_title            := 'Asset Defect History';
   l_rec_hmo.hmo_filename         := 'mai3815';
   l_rec_hmo.hmo_module_type      := 'FMX';
   l_rec_hmo.hmo_fastpath_opts    := Null;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := 'MAI';
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr('MAI_USER','NORMAL');
   add_hmr('MAI_ADMIN','NORMAL');
--
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
--
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
  drop_module('MAI3664');  -- Graeme - module is replace by HIG3664
  drop_module('MAI1440'); -- Graeme - redundant module should have been taken out when MAI first ported
  drop_module('MAI2310'); -- Graeme - no longer shipped

--
-- Redundant PMS modules
--
  drop_module ('PMS4408');
  drop_module ('PMS4404');
  drop_module ('PMS4440');
  drop_module ('PMS4448');
  drop_module ('PMS4442');
  drop_module ('PMS4444');
  drop_module ('PMS4400');
  drop_module ('PMS4402');
  drop_module ('PMS4406');
  drop_module ('PMS4410');
  drop_module ('PMS4412');
  drop_module ('PMS4414');
  drop_module ('PMS4416');

--
--Redundant MAI modules
--
  --
  --Atlas testing log 34476 Sscanlon
  --MAI1410 - will be dropped
  --
  drop_module('MAI1410');

END;
/

--
-- Point at COR module that replaces the MAI one
--
UPDATE hig_modules
SET    hmo_filename = 'nm0306'
WHERE  hmo_module = 'MAI1910'
/

--
-- Point at COR module that replaces the MAI one
--
UPDATE hig_modules
SET    hmo_filename = 'nm0305'
WHERE  hmo_module = 'MAI1920'
/

--
-- Test Manager Fix 33938
-- point MAI2310 at NM0590 instead of redundant form MAI2310
--
UPDATE hig_modules
SET    hmo_filename = 'nm0590'
WHERE  hmo_module = 'MAI2310A'
/

--
-- Atlas testing Fix 34475 Sscanlon
-- MAI1400 - will be kept and renamed to 'v2 Asset Type Translations'
--
UPDATE HIG_MODULES
SET HMO_TITLE = 'v2 Asset Type Translations'
WHERE HMO_MODULE = 'MAI1400'
/

-- FJF gri params and param lookups
--
-- FJF fixes for mai5090/91 log 40384
insert into gri_params
( gp_param
, gp_param_type
, gp_table
, gp_column
, gp_descr_column
, gp_shown_column
, gp_shown_type
, gp_descr_type
, gp_order
, gp_case
, gp_gaz_restriction
)
select
  'MAI_P_DEL_REV'
, 'CHAR'
, 'GRI_PARAM_LOOKUP'
, 'GPL_VALUE'
, 'GPL_DESCR'
, 'GPL_VALUE'
, 'CHAR'
, null
, null
, null
, null
from dual
where not exists
( select 1
from gri_params
where gp_param = 'MAI_P_DEL_REV' )
/

insert into gri_param_lookup
( gpl_param
, gpl_value
, gpl_descr
)
select
  'MAI_P_DEL_REV'
, 'REVIEW'
, 'Review batches for deletion'
from dual
where not exists
( select 1
from gri_param_lookup
where gpl_param = 'MAI_P_DEL_REV'
and gpl_value = 'REVIEW'
)
/

insert into gri_param_lookup
( gpl_param
, gpl_value
, gpl_descr
)
select
  'MAI_P_DEL_REV'
, 'DELETE'
, 'Delete batches'
from dual
where not exists
( select 1
from gri_param_lookup
where gpl_param = 'MAI_P_DEL_REV'
and gpl_value = 'DELETE'
)
/

-- FJF / end

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
--
-- 3 missing GRI modules as reported by TFL
--
  l_rec_grm.grm_module       := 'MAI5220';
  l_rec_grm.grm_module_type  := 'R25';
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
--
  l_rec_grm.grm_module       := 'MAI5235';
  l_rec_grm.grm_module_type  := 'R25';
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
--
  l_rec_grm.grm_module       := 'MAI5240';
  l_rec_grm.grm_module_type  := 'R25';
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
--
 l_rec_grm.grm_module       := 'MAI3841';
 l_rec_grm.grm_module_type  := 'R25';
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
--
-- Three more found by testing
 l_rec_grm.grm_module       := 'MAI5205';
 l_rec_grm.grm_module_type  := 'R25';
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
--
 l_rec_grm.grm_module       := 'MAI5215';
 l_rec_grm.grm_module_type  := 'R25';
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
--
 l_rec_grm.grm_module       := 'MAI5225';
 l_rec_grm.grm_module_type  := 'R25';
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
--
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
--
 l_rec_gmp.gmp_module := 'MAI3841';
 l_rec_gmp.gmp_param := 'CONTRACT_ID';
 l_rec_gmp.gmp_seq := 1;
 l_rec_gmp.gmp_param_descr := 'Select Contract';
 l_rec_gmp.gmp_mandatory := 'Y';
 l_rec_gmp.gmp_no_allowed := 1;
 l_rec_gmp.gmp_where := '';
 l_rec_gmp.gmp_tag_restriction := 'N';
 l_rec_gmp.gmp_tag_where := '';
 l_rec_gmp.gmp_default_table := NULL;
 l_rec_gmp.gmp_default_column := NULL;
 l_rec_gmp.gmp_default_where := NULL;
 l_rec_gmp.gmp_visible := 'Y';
 l_rec_gmp.gmp_gazetteer := 'N';
 l_rec_gmp.gmp_lov := 'Y';
 l_rec_gmp.gmp_wildcard := 'N';
 l_rec_gmp.gmp_hint_text := 'Select Contract';
 l_rec_gmp.gmp_allow_partial := 'N';
 add_gmp;
--
 l_rec_gmp.gmp_module := 'MAI3919';
 l_rec_gmp.gmp_param := 'ANSWER';
 l_rec_gmp.gmp_seq := 1;
 l_rec_gmp.gmp_param_descr := 'Draft Report?';
 l_rec_gmp.gmp_mandatory := 'Y';
 l_rec_gmp.gmp_no_allowed := 1;
 l_rec_gmp.gmp_where := 'GPL_PARAM=''ANSWER''';
 l_rec_gmp.gmp_tag_restriction := 'N';
 l_rec_gmp.gmp_tag_where := '';
 l_rec_gmp.gmp_default_table := 'GRI_PARAM_LOOKUP';
 l_rec_gmp.gmp_default_column := 'GPL_VALUE';
 l_rec_gmp.gmp_default_where := 'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER''';
 l_rec_gmp.gmp_visible := 'Y';
 l_rec_gmp.gmp_gazetteer := 'N';
 l_rec_gmp.gmp_lov := 'Y';
 l_rec_gmp.gmp_wildcard := 'N';
 l_rec_gmp.gmp_hint_text := 'Draft Report?';
 l_rec_gmp.gmp_allow_partial := 'N';
 add_gmp;
 -- FJF fixes for mai5090/91 log 40384
 l_rec_gmp.GMP_MODULE          := 'MAI5090'                                ;
 l_rec_gmp.GMP_PARAM           := 'MAI_P_DEL_REV'                          ;
 l_rec_gmp.GMP_SEQ             := 2                                        ;
 l_rec_gmp.GMP_PARAM_DESCR     := 'Review batch or delete it'              ;
 l_rec_gmp.GMP_MANDATORY       := 'Y'                                      ;
 l_rec_gmp.GMP_NO_ALLOWED      := 1                                        ;
 l_rec_gmp.GMP_WHERE           := 'GPL_PARAM=''MAI_P_DEL_REV'''            ;
 l_rec_gmp.GMP_TAG_RESTRICTION := 'N'                                      ;
 l_rec_gmp.GMP_VISIBLE         := 'Y'                                      ;
 l_rec_gmp.GMP_GAZETTEER       := 'N'                                      ;
 l_rec_gmp.GMP_LOV             := 'Y'                                      ;
 l_rec_gmp.GMP_WILDCARD        := 'Y'                                      ;
 l_rec_gmp.GMP_HINT_TEXT       := 'Review the batch headers or delete them';
 l_rec_gmp.GMP_ALLOW_PARTIAL   := 'N'                                      ;
 add_gmp;
 l_rec_gmp.GMP_MODULE          := 'MAI5091'                                ;
 l_rec_gmp.GMP_PARAM           := 'MAI_P_DEL_REV'                          ;
 l_rec_gmp.GMP_SEQ             := 2                                        ;
 l_rec_gmp.GMP_PARAM_DESCR     := 'Review or delete batch'                 ;
 l_rec_gmp.GMP_MANDATORY       := 'Y'                                      ;
 l_rec_gmp.GMP_NO_ALLOWED      := 1                                        ;
 l_rec_gmp.GMP_WHERE           := 'GPL_PARAM=''MAI_P_DEL_REV'''            ;
 l_rec_gmp.GMP_TAG_RESTRICTION := 'N'                                      ;
 l_rec_gmp.GMP_VISIBLE         := 'Y'                                      ;
 l_rec_gmp.GMP_GAZETTEER       := 'N'                                      ;
 l_rec_gmp.GMP_LOV             := 'Y'                                      ;
 l_rec_gmp.GMP_WILDCARD        := 'Y'                                      ;
 l_rec_gmp.GMP_HINT_TEXT       := 'Review the batch headers or delete them';
 l_rec_gmp.GMP_ALLOW_PARTIAL   := 'N'                                      ;
 add_gmp;
 -- FJF / end
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
-- FJF small changes to module params
-- FJF fixes for mai5090/91 log 40384
update gri_module_params
set gmp_where = 'RUN_NUM>0 AND RUN_STAGE=''OK'' and item_err_cnt  + section_err_cnt = 0'
where gmp_module = 'MAI5090'
and gmp_param = 'RUN_NUM'
/

update gri_module_params
set gmp_where = 'not exists ( select 1 from hh_load_recs hlb where hlb.batch_id = hh_load_batches.batch_id and hlb.error_no is not null )'
where gmp_module = 'MAI5091'
and gmp_param = 'INSP_BATCH'
/
-- FJF / end
--
-------------------------------------------------------------------------------------------------
--
DECLARE
-- Add New Product Options

   TYPE tab_rec_hol IS TABLE OF hig_option_list%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_hol     hig_option_list%ROWTYPE;
   l_tab_rec_hol tab_rec_hol;
--
   l_hol_count      PLS_INTEGER := 0;
--
   PROCEDURE add_hol IS
   BEGIN
      l_hol_count := l_hol_count + 1;
      l_tab_rec_hol(l_hol_count) := l_rec_hol;
   END add_hol;

BEGIN
--
--
--
  l_rec_hol.hol_id          := 'FINAL_FLAG';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Is Final flag to be shown';
  l_rec_hol.hol_remarks     := 'Either Y or N';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'STATVAL';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'mai3802 Status Complete';
  l_rec_hol.hol_remarks     := 'Either Y or N';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'SH_DTE_REP';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Show Date Repaired';
  l_rec_hol.hol_remarks     := 'Either Y or N';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'TRECODEMAN';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Is Treatment code mandatory';
  l_rec_hol.hol_remarks     := 'Either Y or N';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'BUDAUDT';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Budget Audit trail';
  l_rec_hol.hol_remarks     := 'This value must be set to Y to write an audit trail to the temp table';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'DISPBID';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Budget Bid Id';
  l_rec_hol.hol_remarks     := 'This value must be Y to display the Budget Bid id.';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'REPAIRS';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Overwrite Defect date';
  l_rec_hol.hol_remarks     := 'This value must be 1 to close a defect when a temp repair is completed.';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'CPAFORMAT';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Format of Works Order Number';
  l_rec_hol.hol_remarks     := 'Set to 0 to show standard format, 1 to show Causeway format.';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'CPAINTERIM';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'CPA Interims';
  l_rec_hol.hol_remarks     := 'CPA Interims (1= Switched on)';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'DEFRECALUP';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Upper Tolerance For Survey Len';
  l_rec_hol.hol_remarks     := 'This option defines the tolerance (as a % of section length) within which an inspections survey length may be greater than the section length. This is applied to all survey types!';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'DEFRECALLO';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Lower Tolerance For Survey Len';
  l_rec_hol.hol_remarks     := 'This option defines the tolerance (as a % of section length) within which an inspections survey length may be lower than the section length before the survey is regarded as Partial (and therefore not recalibrated). This is applied when the rmms_flag is 3 and the section is local.';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'DEFSUPTYPE';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Superseding Type';
  l_rec_hol.hol_remarks     := 'should Be Set To 1 Or 2, See User Documentation For Details';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'NOTREFOUND';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'Not Refound';
  l_rec_hol.hol_remarks     := 'Enter One Of The Following Values : OFF - Not refound code ignored : ALL - Not Refound code on and runs for all Defects of whatever priority : PRI - Not Refound code on and runs against all Defects EXCEPT Cat 1s.';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
  l_rec_hol.hol_id          := 'DEFSUPRES';
  l_rec_hol.hol_product     := 'MAI';
  l_rec_hol.hol_name        := 'SUPERSEDE REPAIR DATE DUE';
  l_rec_hol.hol_remarks     := 'If set to ''N'' then when superseding, repair due date will be set as if the defect is new. If set to ''Y'' then the repair due date will be set to the superseded defects repair due date.';
  l_rec_hol.hol_domain      := NULL;
  l_rec_hol.hol_datatype    := 'VARCHAR2';
  l_rec_hol.hol_mixed_case  := 'N';
  add_hol;
--
   FOR i IN 1..l_hol_count
    LOOP
      l_rec_hol := l_tab_rec_hol(i);
      INSERT INTO hig_option_list
            (
             hol_id
             , hol_product
             , hol_name
             , hol_remarks
             , hol_domain
             , hol_datatype
             , hol_mixed_case
             )
      SELECT
             l_rec_hol.hol_id
             , l_rec_hol.hol_product
             , l_rec_hol.hol_name
             , l_rec_hol.hol_remarks
             , l_rec_hol.hol_domain
             , l_rec_hol.hol_datatype
             , l_rec_hol.hol_mixed_case
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_option_list
                        WHERE  hol_id = l_rec_hol.hol_id
                       );
   END LOOP;
--
END;
/


--
--Update Hig_option_list
--Atlas testing log 36228 Sscanlon
--
update hig_option_list
set hol_remarks = 'Y= Item Code Breakdowns to be unique at agency level , N = Item Code Breakdowns to be unique at system level.'||chr(10)||
'Setting this option to Y also relies on additional supporting configuration which should be undertaken by/in consultation with exor.'
where hol_id = 'ICBFGAC'
/


--
DECLARE
-- Add New Product Option Values.
--
   TYPE tab_rec_hov IS TABLE OF hig_option_values%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_hov     hig_option_values%ROWTYPE;
   l_tab_rec_hov tab_rec_hov;
--
   l_hov_count      PLS_INTEGER := 0;
--
   PROCEDURE add_hov IS
   BEGIN
      l_hov_count := l_hov_count + 1;
      l_tab_rec_hov(l_hov_count) := l_rec_hov;
   END add_hov;

BEGIN
--
  l_rec_hov.hov_id     := 'FINAL_FLAG';
  l_rec_hov.hov_value  := 'N';
  add_hov;
--
  l_rec_hov.hov_id     := 'STATVAL';
  l_rec_hov.hov_value  := 'N';
  add_hov;
--
  l_rec_hov.hov_id     := 'SH_DTE_REP';
  l_rec_hov.hov_value  := 'N';
  add_hov;
--
  l_rec_hov.hov_id     := 'TRECODEMAN';
  l_rec_hov.hov_value  := 'N';
  add_hov;
--
  l_rec_hov.hov_id     := 'BUDAUDT';
  l_rec_hov.hov_value  := 'N';
  add_hov;
--
  l_rec_hov.hov_id     := 'DISPBID';
  l_rec_hov.hov_value  := 'N';
  add_hov;
--
  l_rec_hov.hov_id     := 'REPAIRS';
  l_rec_hov.hov_value  := 'N';
  add_hov;
--
  l_rec_hov.hov_id     := 'CPAFORMAT';
  l_rec_hov.hov_value  := '0';
  add_hov;
--
  l_rec_hov.hov_id     := 'CPAINTERIM';
  l_rec_hov.hov_value  := '0';
  add_hov;
--
  l_rec_hov.hov_id     := 'DEFRECALUP';
  l_rec_hov.hov_value  := '5';
  add_hov;
--
  l_rec_hov.hov_id     := 'DEFRECALLO';
  l_rec_hov.hov_value  := '50';
  add_hov;
--
  l_rec_hov.hov_id     := 'DEFSUPTYPE';
  l_rec_hov.hov_value  := '1';
  add_hov;
--
  l_rec_hov.hov_id     := 'NOTREFOUND';
  l_rec_hov.hov_value  := 'ALL';
  add_hov;
--
  l_rec_hov.hov_id     := 'DEFSUPRES';
  l_rec_hov.hov_value  := 'Y';
  add_hov;
--
   FOR i IN 1..l_hov_count
    LOOP
      l_rec_hov := l_tab_rec_hov(i);
      INSERT INTO hig_option_values
            (
             hov_id
             , hov_value
             )
      SELECT
             l_rec_hov.hov_id
             , l_rec_hov.hov_value
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_option_values
                        WHERE  hov_id = l_rec_hov.hov_id
                       );
   END LOOP;
--
END;
/
--
DECLARE
-- Add 3 new error messages into nm_errors.
--
   TYPE tab_rec_nme IS TABLE OF nm_errors%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_nme     nm_errors%ROWTYPE;
   l_tab_rec_nme tab_rec_nme;
--
   l_nme_count      PLS_INTEGER := 0;
--
   PROCEDURE add_nme IS
   BEGIN
      l_nme_count := l_nme_count + 1;
      l_tab_rec_nme(l_nme_count) := l_rec_nme;
   END add_nme;

BEGIN
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '910';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot Delete Record - Corresponding Budget Record Exists on Work_Order_Lines Table.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '911';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot Update Final Flag - Date Repaired is Null.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '912';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot Update to Completed as Contract Year End Date has passed.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '913';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot delete line as section is end dated. Line must be completed.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '914';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Only the most recent invoice can be approved for each Works Order Line.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '915';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'This works order cannot be copied.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '916';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'This works order line cannot be copied.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '917';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot derive a works order number.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '918';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Street Works Manager must be installed and licenced in order to Self Notice';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '919';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot find matching works order.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '920';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot find matching works order line.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '921';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Cannot Delete / Modify Record as Associated Records Exist';
  l_rec_nme.ner_cause     := NULL;
  add_nme;
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '922';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Order cannot be instructed as a Dummy Contract is being used.';
  l_rec_nme.ner_cause     := NULL;
  add_nme;  
--
  l_rec_nme.ner_appl      := 'MAI';
  l_rec_nme.ner_id        := '923';
  l_rec_nme.ner_her_no    := NULL;
  l_rec_nme.ner_descr     := 'Record has changed, do you want to requery?';
  l_rec_nme.ner_cause     := NULL;
  add_nme;  
--
   FOR i IN 1..l_nme_count
    LOOP
      l_rec_nme := l_tab_rec_nme(i);
      INSERT INTO nm_errors
            (
             ner_appl
             , ner_id
             , ner_her_no
             , ner_descr
             , ner_cause
             )
      SELECT
             l_rec_nme.ner_appl
             , l_rec_nme.ner_id
             , l_rec_nme.ner_her_no
             , l_rec_nme.ner_descr
             , l_rec_nme.ner_cause
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  nm_errors
                        WHERE  ner_appl = l_rec_nme.ner_appl
                        AND ner_id = l_rec_nme.ner_id
                       );
   END LOOP;
END;
/
--
DECLARE
   TYPE tab_rec_woc IS TABLE OF wo_audit_columns%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_woc     wo_audit_columns%ROWTYPE;
   l_tab_rec_woc tab_rec_woc;
--
   l_woc_count      PLS_INTEGER := 0;
--
   PROCEDURE add_woc IS
   BEGIN
      l_woc_count := l_woc_count + 1;
      l_tab_rec_woc(l_woc_count) := l_rec_woc;
   END add_woc;
--
BEGIN
--
  l_rec_woc.wac_column_name  := 'WOR_PEO_PERSON_ID';
  l_rec_woc.wac_display_text := 'Originator';
  l_rec_woc.wac_audited      := 'Y';
  add_woc;
--
  l_rec_woc.wac_column_name  := 'WOR_MOD_BY_ID';
  l_rec_woc.wac_display_text := 'Authorised by';
  l_rec_woc.wac_audited      := 'Y';
  add_woc;
--
  l_rec_woc.wac_column_name  := 'WOR_LAST_PRINT_DATE';
  l_rec_woc.wac_display_text := 'WO Print Date';
  l_rec_woc.wac_audited      := 'N';
  add_woc;
--
   FOR i IN 1..l_woc_count
    LOOP
      l_rec_woc := l_tab_rec_woc(i);
      INSERT INTO wo_audit_columns
            (
             wac_column_name
             , wac_display_text
             , wac_audited
             )
      SELECT
             l_rec_woc.wac_column_name
             , l_rec_woc.wac_display_text
             , l_rec_woc.wac_audited
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  wo_audit_columns
                        WHERE  wac_column_name = l_rec_woc.wac_column_name
                       );
   END LOOP;
END;
/

--
-------------------------------------------------------------------------------------------------
--
DECLARE
--
-- HIG_DOMAINS and HIG_CODES
--
   l_tab_hdo_domain     nm3type.tab_varchar30;
   l_tab_hdo_product    nm3type.tab_varchar30;
   l_tab_hdo_title      nm3type.tab_varchar2000;
   l_tab_hdo_code_len   nm3type.tab_number;
--
   l_tab_hco_domain     nm3type.tab_varchar30;
   l_tab_hco_code       nm3type.tab_varchar30;
   l_tab_hco_meaning    nm3type.tab_varchar2000;
   l_tab_hco_system     nm3type.tab_varchar4;
   l_tab_hco_seq        nm3type.tab_number;
   l_tab_hco_start_date nm3type.tab_date;
   l_tab_hco_end_date   nm3type.tab_date;
--
   l_hdo_count        PLS_INTEGER := 0;
   l_hco_count        PLS_INTEGER := 0;
--
   l_domain           hig_domains.hdo_domain%TYPE;
--
   PROCEDURE add_hdo (p_domain   VARCHAR2
                     ,p_product  VARCHAR2
                     ,p_title    VARCHAR2
                     ,p_code_len NUMBER
                     ) IS
   BEGIN
      l_hdo_count := l_hdo_count + 1;
      l_tab_hdo_domain(l_hdo_count)   := UPPER(p_domain);
      l_tab_hdo_product(l_hdo_count)  := UPPER(p_product);
      l_tab_hdo_title(l_hdo_count)    := p_title;
      l_tab_hdo_code_len(l_hdo_count) := p_code_len;
   END add_hdo;
--
   PROCEDURE add_hco (p_domain     VARCHAR2
                     ,p_code       VARCHAR2
                     ,p_meaning    VARCHAR2
                     ,p_system     VARCHAR2 DEFAULT 'Y'
                     ,p_seq        NUMBER   DEFAULT NULL
                     ,p_start_date DATE     DEFAULT NULL
                     ,p_end_date   DATE     DEFAULT NULL
                     ) IS
   BEGIN
      l_hco_count := l_hco_count + 1;
      l_tab_hco_domain(l_hco_count)     := UPPER(p_domain);
      l_tab_hco_code(l_hco_count)       := p_code;
      l_tab_hco_meaning(l_hco_count)    := p_meaning;
      l_tab_hco_system(l_hco_count)     := p_system;
      l_tab_hco_seq(l_hco_count)        := p_seq;
      l_tab_hco_start_date(l_hco_count) := p_start_date;
      l_tab_hco_end_date(l_hco_count)   := p_end_date;
   END add_hco;
--
BEGIN

   l_domain := 'WOR_REGISTER_STATUS';
   add_hdo(l_domain, 'MAI', 'Works Order Register Status', 1);
   add_hco(l_domain,'O'  ,'Outstanding','Y',1);
   add_hco(l_domain,'C'  ,'Completed','Y',2);
   add_hco(l_domain,'N'  ,'Nothing to register','Y',3);
--
   FORALL i IN 1..l_hdo_count
      INSERT INTO hig_domains
            (hdo_domain
            ,hdo_product
            ,hdo_title
            ,hdo_code_length
            )
      SELECT l_tab_hdo_domain(i)
            ,l_tab_hdo_product(i)
            ,l_tab_hdo_title(i)
            ,l_tab_hdo_code_len(i)
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_domains
                        WHERE  hdo_domain = l_tab_hdo_domain(i)
                       );
   FORALL i IN 1..l_hco_count
      INSERT INTO hig_codes
            (hco_domain
            ,hco_code
            ,hco_meaning
            ,hco_system
            ,hco_seq
            ,hco_start_date
            ,hco_end_date
            )
      SELECT l_tab_hco_domain(i)
            ,l_tab_hco_code(i)
            ,l_tab_hco_meaning(i)
            ,l_tab_hco_system(i)
            ,l_tab_hco_seq(i)
            ,l_tab_hco_start_date(i)
            ,l_tab_hco_end_date(i)
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_codes
                        WHERE  hco_domain = l_tab_hco_domain(i)
                         AND   hco_code   = l_tab_hco_code(i)
                       )
       AND  EXISTS     (SELECT 1
                         FROM  hig_domains
                        WHERE  hdo_domain = l_tab_hco_domain(i)
                       );
--
END;
/
--
---------------------------------------------------------------------------------------------------
--                   **************** MISCELLANEOUS CHANGES BELOW HERE *******************

-- DC schemes domain is now part of STP

update hig_status_domains
set hsd_product = 'STP'
where hsd_domain_code = 'SCHEMES';

UPDATE hig_products
SET    hpr_product_name = 'structural projects v2 - REDUNDANT'
WHERE  hpr_product = 'PMS'
/

UPDATE GRI_MODULE_PARAMS
SET GMP_WHERE = 'WOR_WORKS_ORDER_NO IN (SELECT WOR_WORKS_ORDER_NO FROM WORK_ORDERS WHERE WOR_DATE_CONFIRMED IS NOT NULL AND :ANSWER = ''N'' UNION SELECT WOR_WORKS_ORDER_NO FROM WORK_ORDERS WHERE :ANSWER = ''Y'') '
  , GMP_SEQ = '2'
WHERE  GMP_MODULE  = 'MAI3919'
AND GMP_PARAM = 'WORKS_ORDER_NO'
/

-- CP 09/11/2006 - Replace manual statement with statement from maidata2.sql
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT
        'MAI3919'
       ,'WORKS_ORDER_NO'
       ,'ANSWER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI3919'
                    AND  GPD_DEP_PARAM = 'WORKS_ORDER_NO'
                    AND  GPD_INDEP_PARAM = 'ANSWER');

--
-- mai2310a to point at nm0590
--
UPDATE hig_modules
SET hmo_filename = 'nm0590'
WHERE hmo_module = 'MAI2310A'
/

-- CP 09/11/2006 - Replace manual statement with statement from maidata2.sql
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_OPERATOR
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_ALLOW_PARTIAL
       )
SELECT
        'MAI3834'
       ,'TO_DATE'
       ,3
       ,'Run Up To Date'
       ,'N'
       ,1
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,'Optional. Processing will include work orders instructed up to this date.'
       ,''
       ,''
       ,''
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI3834'
                    AND  GMP_PARAM = 'TO_DATE');

--

------------------------------------------------------------------------
-- CP 03/11/2006 (Test Id 40898)
-- metadata for MAI8000 (ex-doc0206)
--

INSERT INTO HIG_MODULES
       (HMO_MODULE
       ,HMO_TITLE
       ,HMO_FILENAME
       ,HMO_MODULE_TYPE
       ,HMO_FASTPATH_OPTS
       ,HMO_FASTPATH_INVALID
       ,HMO_USE_GRI
       ,HMO_APPLICATION
       ,HMO_MENU
       )
SELECT
        'MAI8000'
       ,'Batch Works Order Printing'
       ,'MAI8000'
       ,'FMX'
       ,''
       ,'N'
       ,'Y'
       ,'DOC'
       ,'FORM' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULES
                   WHERE HMO_MODULE = 'MAI8000');

INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT
        'MAI8000'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI8000'
                    AND  HMR_ROLE = 'MAI_ADMIN');

INSERT INTO GRI_MODULES
       (GRM_MODULE
       ,GRM_MODULE_TYPE
       ,GRM_MODULE_PATH
       ,GRM_FILE_TYPE
       ,GRM_TAG_FLAG
       ,GRM_TAG_TABLE
       ,GRM_TAG_COLUMN
       ,GRM_TAG_WHERE
       ,GRM_LINESIZE
       ,GRM_PAGESIZE
       ,GRM_PRE_PROCESS
       )
SELECT
        'MAI8000'
       ,'N/A'
       ,'$PROD_HOME/BIN'
       ,'lis'
       ,'Y'
       ,'WORK_ORDERS'
       ,'WOR_WORKS_ORDER_NO'
       ,''
       ,80
       ,80
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI8000');


INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'TEMPLATE_NAME'
       ,10
       ,'Template'
       ,'Y'
       ,1
       ,'DTG_TEMPLATE_NAME IN (SELECT DTU_TEMPLATE_NAME FROM DOC_TEMPLATE_USERS,HIG_USERS  WHERE DTU_USER_ID = HUS_USER_ID AND HUS_USERNAME = USER) '||CHR(10)||'AND DTG_TABLE_NAME =''WORK_ORDERS'''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Select Template to Use'
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'TEMPLATE_NAME');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'FROM_DATE'
       ,20
       ,'From Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :FROM_DATE <= SYSDATE) OR (:TO_DATE IS NULL AND :FROM_DATE <= SYSDATE))'
       ,'Y'
       ,'WOR_DATE_RAISED >= :FROM_DATE'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'TO_DATE'
       ,30
       ,'To Date'
       ,'N'
       ,1
       ,'((:FROM_DATE <= :TO_DATE AND :TO_DATE <= SYSDATE) OR '||CHR(10)||' (:FROM_DATE IS NULL AND :TO_DATE <= SYSDATE))'
       ,'Y'
       ,'WOR_DATE_RAISED <=:TO_DATE'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'N'
       ,''
       ,'N'
       ,''
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'HIG_USER_ID'
       ,40
       ,'Authorised By'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_MOD_BY_ID = :HIG_USER_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Authorised By'
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'HIG_USER_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'H2'
       ,50
       ,'Originated By'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_PEO_PERSON_ID = :H2'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Originated By'
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'H2');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'ROAD_ID'
       ,60
       ,'Road Id'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_RSE_HE_ID_GROUP = :ROAD_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Road Group'
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'ROAD_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'CONTRACTOR_ID'
       ,70
       ,'Contractor'
       ,'N'
       ,1
       ,''
       ,'Y'
       ,'WOR_CON_ID = :CONTRACTOR_ID'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Contractor'
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'CONTRACTOR_ID');
--
INSERT INTO GRI_MODULE_PARAMS
       (GMP_MODULE
       ,GMP_PARAM
       ,GMP_SEQ
       ,GMP_PARAM_DESCR
       ,GMP_MANDATORY
       ,GMP_NO_ALLOWED
       ,GMP_WHERE
       ,GMP_TAG_RESTRICTION
       ,GMP_TAG_WHERE
       ,GMP_DEFAULT_TABLE
       ,GMP_DEFAULT_COLUMN
       ,GMP_DEFAULT_WHERE
       ,GMP_VISIBLE
       ,GMP_GAZETTEER
       ,GMP_LOV
       ,GMP_VAL_GLOBAL
       ,GMP_WILDCARD
       ,GMP_HINT_TEXT
       ,GMP_ALLOW_PARTIAL
       ,GMP_BASE_TABLE
       ,GMP_BASE_TABLE_COLUMN
       ,GMP_OPERATOR
       )
SELECT
        'MAI8000'
       ,'WORKS_ORDER_NO'
       ,80
       ,'Works Order No'
       ,'N'
       ,20
       ,''
       ,'Y'
       ,'WOR_WORKS_ORDER_NO IN (:WORKS_ORDER_NO)'
       ,''
       ,''
       ,''
       ,'Y'
       ,'N'
       ,'Y'
       ,''
       ,'N'
       ,'Enter Specific Works Order No (Use Insert Record to specify more than one)'
       ,'N'
       ,''
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULE_PARAMS
                   WHERE GMP_MODULE = 'MAI8000'
                    AND  GMP_PARAM = 'WORKS_ORDER_NO');


INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT
        'MAI8000'
       ,'FROM_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT
        'MAI8000'
       ,'FROM_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'FROM_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT
        'MAI8000'
       ,'TO_DATE'
       ,'FROM_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'FROM_DATE');
--
INSERT INTO GRI_PARAM_DEPENDENCIES
       (GPD_MODULE
       ,GPD_DEP_PARAM
       ,GPD_INDEP_PARAM
       )
SELECT
        'MAI8000'
       ,'TO_DATE'
       ,'TO_DATE' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_PARAM_DEPENDENCIES
                   WHERE GPD_MODULE = 'MAI8000'
                    AND  GPD_DEP_PARAM = 'TO_DATE'
                    AND  GPD_INDEP_PARAM = 'TO_DATE');

--
-- metadata for MAI8000
------------------------------------------------------------------------


------------------------------------------------------------------------
--Refresh The load_errors Table For The MAI Loaders.
------------------------------------------------------------------------
delete load_errors;

INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Activity (H) Record expected but not found.', 9104, 'Correct the Activity Record Type.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Comment Type.', 9105, 'Correct the Comment Type.', NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Inspection date.', 9302, 'Correct the Inspection date.', NULL, NULL
, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Survey type.', 9303, 'Correct the Survey Type.', NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Defect Location (I) Record Type.', 9501, 'Correct the Defect Location Record Type indicator.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Defect (J) record Type.', 9502, 'Correct the Defect Location Record Type indicator.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Action record (K/L/M/N) expected but not found.', 9503, 'Correct the action type record for this section.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Section chainage record (P) expected but not found.', 9504, 'Correct the section chainage record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Repair record expected but not found.', 9505, 'Correct the repair record and re-submit.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Repair target date cannot be obtained from defect priorities.', 9506, 'Check the defect priorities or correct the defect/activity code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to obtain system option WEEKEND.', 9507, 'Ensure that the system option WEEKEND is defined.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to obtain the current day from DUAL.', 9508, 'Ensure that there is select access from dual - ask support.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to locate defect priority interval record.', 9509, 'Ensure that there is a defect priority record for this interval.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid action completion date.', 9510, 'Ensure that the action completion date is correct.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid action completion time.', 9511, 'Ensure that the action completion time is correct.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Job item location error.', 9512, 'Ensure that the job item is correct.', NULL
, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Q type record expected but not found.', 9513, 'Ensure that the next record is a Job Item record type.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : R type record expected but not found.', 9514, 'Ensure that the next record is a Comment record type.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : S type record expected but not found.', 9515, 'Ensure that the next record is a Complaint record type.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid defect attribute combination.', 9025, 'Correct the defect type attribute.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid defect priority code.', 9304, 'Correct the defect priority code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid complaint record date.', 9701, 'Correct the complaint record date.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid complaint record time.', 9702, 'Correct the complaint record time.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid complaint source code.', 9703, 'Correct the complaint source code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : The Secondary inspector cannot be located.', 9209, 'Correct the Secondary inspectors initials in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Defect sequence value DEF_DEFECT_ID missing from CODE_CONTROLS', 9210, 'Insert the DEF_DEFECT_ID entry into CODE_CONTROLS.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Road Surface condition code.', 9211, 'Correct the Road Surface condition code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Weather condition code.', 9212, 'Correct the weathher condition code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid defect Location time.', 9261, 'Correct the defect location time hhmm'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid chainage indicator.', 9262, 'Correct the chainage indicator value.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid sub-section item code.', 9263, 'Correct the sub-section item code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid notifiable organisation code.', 9264, 'Correct the notifiable organisation code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid rechargeable organisation code.', 9265, 'Correct the rechargeable organisation code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Cross Sectional Position (XSP)', 9266, 'Correct the Cross Sectional Position.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid inspection time.', 9301, 'Correct the inspection time in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Defect/Priority combination.', 9305, 'Correct the Defect/Priority and re-submit.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid reverse survey direction indicator.', 9309, 'Correct the Reverse Survey Direction indicator value (Y/N).'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid activity nmeonic/defect code combination.', 9300, 'Correct the activity code nmeonic.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Treatment Code.', 9400, 'Correct the treatment code.', NULL, NULL
, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : G record expected but not found.', 9200, 'Correct the record type.', NULL
, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Number of attributes in G record type is less than 7', 9201, 'Correct the G record information.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Initiation nmeonic is not recognised.', 9202, 'Correct the initiation nmeonic code.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid initiation inspection date.', 9203, 'Correct the Inspection initiation date in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid initiation inspection time.', 9204, 'Correct the inspection time in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid survey type indicator.', 9205, 'Correct the survey type indicator in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid survey direction indicator.', 9206, 'Correct the survey indicator value in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid Linkcode / Section identifier.', 9207, 'Correct the Linkcode / Section identifier in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : The Primary inspector cannot be located.', 9208, 'Correct the Primary inspectors initials in the G record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Start chainage exceeds end chainage.', 9401, 'Correct the chainage values.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Incorrect start chainage value ( chainage is null )', 9402, 'Correct the start chainage value.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : P record expected but not found.', 9240, 'Correct the P record indicator.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Chainage on I record exceeds required chainage for section.', 9260, 'Correct the section chainage.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : H record expected but not found.', 9220, 'Correct the H record indicator.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Invalid activity area code on H type record for this section.', 9221, 'Correct the defect location time hhmm'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Inspection Date less than previously loaded inspection.  ', 9500, 'Correct the inspection date.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Recalibration for section inspection not started at chainage 0 ', 9600, 'Correct the Start Chainge.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Recalibration for section execeeds 50% of section length .', 9601, 'Correct the Section Length or Chainage value.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Error cannot find P record to carry out recalibration.', 9602, 'Correct the P record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : No Default Treatment for this Defect / Activity area.', 9604, 'Correct the Default Treatment type.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Defect XSP required but not supplied.', 9603, 'Correct the defect location record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Defect chainage value required but not supplied.', 9605, 'Correct the defect location record.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to obtain interval code.', 9213, 'Check the interval codes for valid code values.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to locate specified section.', 9214, 'Check the document management section reference.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to obtain document sequence number.', 9215, 'Check the document sequence for availability.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to obtain inspectors Admin unit.', 9216, 'Check the current inspectors Administration unit.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to insert into the DOCS table.', 9217, 'Check the complaint record for errors.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to locate INTERVAL record.', 9516, 'Ensure there is an INTERVAL record present.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to insert into the DOC_ASSOCS table.', 9218, 'Check the complaint record and correct.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : Unable to obtain the status for a new defect.', 9219, 'Check the STATUS CODES values.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Error : An immediate (COMPLETED) repair may NOT have BOQ items.', 9517, 'All BOQ items associated with the immediate repair must be deleted.'
, NULL, NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Invalid defect Response Category. Use the DOMAINS form.', 9705, 'Using the DOMAINS form check that the category displayed within the'
, 'specified record exists for the DEFECT_RESPONSE_CAT domain.', NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Could not derive Default Complaint Status', 9706, 'Check a valid Complaint Status has been set in Status Codes module (HIG9110).'
, 'The Default Complaint Status should have Feature Code 1 set to Y.', NULL, NULL);
INSERT INTO LOAD_ERRORS ( LER_DESCR, LER_ERROR_NO, LER_ACTION_1, LER_ACTION_2, LER_ACTION_3,
LER_ACTION_4 ) VALUES (
'Invalid Combination of Complaint Category / Complaint Type', 9704, 'The Complaint Category used is derived from the User Option ENQCAT. The'
, 'Complaint Type is supplied in the DCD load file. Check Document Types / Classes'
, '(DOC0110) to ensure that the combination is valid, that they are not end dated'
, 'and that complaints are allowed for these values.');

------------------------------------------------------------------------
--End Of load_errors Refresh.
------------------------------------------------------------------------

--update contracts default year end date

UPDATE CONTRACTS
SET CON_YEAR_END_DATE=con_end_date
/


COMMIT;
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

