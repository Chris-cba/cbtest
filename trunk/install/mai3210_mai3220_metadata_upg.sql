--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai3220_metadata_upg.sql-arc   2.1   Jul 01 2013 16:02:20   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3210_mai3220_metadata_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.4
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
FROM  hig_module_roles
WHERE hmr_module = 'MAI3664'
/
COMMIT
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
---------------------------------------------------------------------------------------------------
--                   **************** MISCELLANEOUS CHANGES BELOW HERE *******************

-- DC schemes domain is now p[art of STP

update hig_status_domains
set hsd_product = 'STP'
where hsd_domain_code = 'SCHEMES';

--
COMMIT;
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

