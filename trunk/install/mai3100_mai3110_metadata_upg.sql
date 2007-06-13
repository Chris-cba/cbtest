REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/install/mai3100_mai3110_metadata_upg.sql-arc   2.0   Jun 13 2007 16:32:34   smarshall  $

SET FEEDBACK OFF
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
-------------------------------------------------------------------------------------------------
--
DECLARE
   --
   -- NM_ERRORS
   --
   l_tab_ner_id    nm3type.tab_number;
   l_tab_ner_descr nm3type.tab_varchar2000;
   l_tab_appl      nm3type.tab_varchar30;
   --
   l_tab_dodgy_ner_id    nm3type.tab_number;
   l_tab_dodgy_ner_appl  nm3type.tab_varchar30;
   l_tab_dodgy_descr_old nm3type.tab_varchar2000;
   l_tab_dodgy_descr_new nm3type.tab_varchar2000;
   --
   l_current_type  nm_errors.ner_appl%TYPE;
   --
   PROCEDURE add_ner (p_ner_id    number
                     ,p_ner_descr varchar2
                     ,p_app       varchar2 DEFAULT l_current_type
                     ) IS
      c_count CONSTANT pls_integer := l_tab_ner_id.COUNT+1;
   BEGIN
      l_tab_ner_id(c_count)    := p_ner_id;
      l_tab_ner_descr(c_count) := p_ner_descr;
      l_tab_appl(c_count)      := p_app;
   END add_ner;
   --
   PROCEDURE add_dodgy (p_ner_id        number
                       ,p_ner_descr_old varchar2
                       ,p_ner_descr_new varchar2
                       ,p_app           varchar2 DEFAULT l_current_type
                       ) IS
      c_count CONSTANT pls_integer := l_tab_dodgy_ner_id.COUNT+1;
   BEGIN
      l_tab_dodgy_ner_id(c_count)    := p_ner_id;
      l_tab_dodgy_descr_old(c_count) := p_ner_descr_old;
      l_tab_dodgy_descr_new(c_count) := NVL(p_ner_descr_new,p_ner_descr_old);
      l_tab_dodgy_ner_appl(c_count)  := p_app;
   END add_dodgy;
   --
BEGIN

   l_current_type := nm3type.c_mai;   
   add_ner(900, 'Gang cannot be null for re-allocation.');
  
   --
   -- Fix dodgy NM_ERRORS records
   --
   l_current_type := nm3type.c_hig;
   --add_dodgy (p_ner_id        => 126
   --          ,p_ner_descr_old => 'You should not be here.'
   --          ,p_ner_descr_new => 'You do not have privileges to perform this action');

   FORALL i IN 1..l_tab_ner_id.COUNT
      INSERT INTO nm_errors
            (ner_appl
            ,ner_id
            ,ner_descr
            )
      SELECT l_tab_appl(i)
            ,l_tab_ner_id(i)
            ,l_tab_ner_descr(i)
       FROM  dual
      WHERE  NOT EXISTS (SELECT 1
                          FROM  nm_errors
                         WHERE  ner_id   = l_tab_ner_id(i)
                          AND   ner_appl = l_tab_appl(i)
                        )
       AND   l_tab_ner_descr(i) IS NOT NULL;
   --
   FORALL i IN 1..l_tab_dodgy_ner_id.COUNT
      UPDATE nm_errors
       SET   ner_descr = l_tab_dodgy_descr_new (i)
      WHERE  ner_id    = l_tab_dodgy_ner_id(i)
       AND   ner_appl  = l_tab_dodgy_ner_appl(i)
       AND   ner_descr = l_tab_dodgy_descr_old(i);
   --
END;
/
--
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
   l_rec_hmo.hmo_module           := 'MAI2530';
   l_rec_hmo.hmo_title            := 'Create Survey File';
   l_rec_hmo.hmo_filename         := 'mai2530';
   l_rec_hmo.hmo_module_type      := 'SQL';
   l_rec_hmo.hmo_fastpath_opts    := NULL;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'Y';
   l_rec_hmo.hmo_application      := nm3type.c_mai;
   l_rec_hmo.hmo_menu             := NULL;
   add_hmo;
   add_hmr('MAI_USER',nm3type.c_normal);
--
   l_rec_hmo.hmo_module           := 'MAIWEB2540';
   l_rec_hmo.hmo_title            := 'GMIS Survey File Loader';
   l_rec_hmo.hmo_filename         := 'mai_gmis_load.load_survey_file';
   l_rec_hmo.hmo_module_type      := 'WEB';
   l_rec_hmo.hmo_fastpath_opts    := NULL;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := nm3type.c_mai;
   l_rec_hmo.hmo_menu             := NULL;
   add_hmo;
   add_hmr('WEB_USER',nm3type.c_normal);
--
   l_rec_hmo.hmo_module           := 'MAI2550';
   l_rec_hmo.hmo_title            := 'Review GMIS Inspection Loads';
   l_rec_hmo.hmo_filename         := 'mai2550';
   l_rec_hmo.hmo_module_type      := 'FMX';
   l_rec_hmo.hmo_fastpath_opts    := NULL;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := nm3type.c_mai;
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr('MAI_USER',nm3type.c_normal);
--
   l_rec_hmo.hmo_module           := 'MAI3805';
   l_rec_hmo.hmo_title            := 'Gang Allocation';
   l_rec_hmo.hmo_filename         := 'mai3805';
   l_rec_hmo.hmo_module_type      := 'FMX';
   l_rec_hmo.hmo_fastpath_opts    := NULL;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'N';
   l_rec_hmo.hmo_application      := nm3type.c_mai;
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr('MAI_ADMIN',nm3type.c_normal);
   add_hmr('MAI_USER',nm3type.c_normal);   
--
   l_rec_hmo.hmo_module           := 'MAI3908';
   l_rec_hmo.hmo_title            := 'Print Works Order';
   l_rec_hmo.hmo_filename         := 'mai3908';
   l_rec_hmo.hmo_module_type      := 'R25';
   l_rec_hmo.hmo_fastpath_opts    := NULL;
   l_rec_hmo.hmo_fastpath_invalid := 'N';
   l_rec_hmo.hmo_use_gri          := 'Y';
   l_rec_hmo.hmo_application      := nm3type.c_mai;
   l_rec_hmo.hmo_menu             := 'FORM';
   add_hmo;
   add_hmr('MAI_ADMIN',nm3type.c_normal);
   add_hmr('MAI_USER',nm3type.c_normal);      
--
-- add missing module roles for query forms
--
   add_hmr ('MAI_USER',nm3type.c_normal,'MAI2305');
   add_hmr ('MAI_USER',nm3type.c_normal,'MAI2306');   
--
--
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
--

-----------------------
-- For Gang Maintenance
-----------------------
   add_hdo ('GANG', 'MAI', 'Gang Number Allocation', 10);
   add_hco ('GANG', '1', 'Gang 1', 'N', 1, NULL, NULL); 
   add_hco ('GANG', '2', 'Gang 2', 'N', 2, NULL, NULL);    
   add_hco ('GANG', '3', 'Gang 3', 'N', 3, NULL, NULL); 
   add_hco ('GANG', '4', 'Gang 4', 'N', 4, NULL, NULL); 
   add_hdo ('GANG_WORK_TYPE', 'MAI', 'Gang Work type', 4); 
   add_hco ('GANG_WORK_TYPE', 'ALL', 'All items', 'N', 4, NULL, NULL);    
   add_hco ('GANG_WORK_TYPE', 'CA', 'Cash Value', 'N', 5, NULL, NULL); 
   add_hco ('GANG_WORK_TYPE', 'JET', 'Jetting', 'N', 1, NULL, NULL); 
   add_hco ('GANG_WORK_TYPE', 'POT', 'Pothole', 'N', 2, NULL, NULL); 
   add_hco ('GANG_WORK_TYPE', 'TM', 'Traffic Management', 'N', 3, NULL, NULL); 
--
   
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
-------------------------------------------------------------------------------------------------
--
DECLARE
--
-- HIG_STATUS_DOMAINS and HIG_STATUS_CODES
--
   TYPE l_tab_hsd IS TABLE OF hig_status_domains%ROWTYPE INDEX BY BINARY_INTEGER;
   TYPE l_tab_hsc IS TABLE OF hig_status_codes%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_hsd hig_status_domains%ROWTYPE;
   l_rec_hsc hig_status_codes%ROWTYPE;

   l_tab_rec_hsd l_tab_hsd;
   l_tab_rec_hsc l_tab_hsc;
--
   l_hsd_count        PLS_INTEGER := 0;
   l_hsc_count        PLS_INTEGER := 0;
--
   PROCEDURE add_hsd IS
   BEGIN
      l_hsd_count := l_hsd_count + 1;
      l_tab_rec_hsd(l_hsd_count) := l_rec_hsd;

   END add_hsd;
--
   PROCEDURE add_hsc IS
   BEGIN
      l_hsc_count := l_hsc_count + 1;
      l_tab_rec_hsc(l_hsc_count) := l_rec_hsc;

   END add_hsc;
--
BEGIN
--
   l_rec_hsc.hsc_domain_code    := 'DEFECTS';
   l_rec_hsc.hsc_status_code    := 'OBSERVED';
   l_rec_hsc.hsc_status_name    := 'Observed as done';
   l_rec_hsc.hsc_seq_no         := 6;
   l_rec_hsc.hsc_allow_feature1 := 'N';
   l_rec_hsc.hsc_allow_feature2 := 'N';
   l_rec_hsc.hsc_allow_feature3 := 'Y';
   l_rec_hsc.hsc_allow_feature4 := 'N';
   l_rec_hsc.hsc_allow_feature5 := 'N';
   l_rec_hsc.hsc_allow_feature6 := 'N';
   l_rec_hsc.hsc_allow_feature7 := 'N';
   l_rec_hsc.hsc_allow_feature8 := 'N';
   l_rec_hsc.hsc_allow_feature9 := 'N';
   l_rec_hsc.hsc_start_date     := NULL;
   l_rec_hsc.hsc_end_date       := NULL;
   add_hsc;
--   
   FOR i IN 1..l_hsd_count LOOP
   
      l_rec_hsd := l_tab_rec_hsd(i);
      
      INSERT INTO HIG_STATUS_DOMAINS (
             hsd_domain_code
            ,hsd_product
            ,hsd_description
            ,hsd_feature1
            ,hsd_feature2
            ,hsd_feature3
            ,hsd_feature4
            ,hsd_feature5
            ,hsd_feature6
            ,hsd_feature7
            ,hsd_feature8
            ,hsd_feature9 )
      SELECT 
             l_rec_hsd.hsd_domain_code
            ,l_rec_hsd.hsd_product
            ,l_rec_hsd.hsd_description
            ,l_rec_hsd.hsd_feature1
            ,l_rec_hsd.hsd_feature2
            ,l_rec_hsd.hsd_feature3
            ,l_rec_hsd.hsd_feature4
            ,l_rec_hsd.hsd_feature5
            ,l_rec_hsd.hsd_feature6
            ,l_rec_hsd.hsd_feature7
            ,l_rec_hsd.hsd_feature8
            ,l_rec_hsd.hsd_feature9
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_status_domains
                        WHERE  hsd_domain_code = l_rec_hsd.hsd_domain_code
                       );
   END LOOP;
                       
   FOR i IN 1..l_hsc_count LOOP
   
     l_rec_hsc := l_tab_rec_hsc(i);
     
     INSERT INTO HIG_STATUS_CODES ( 
            hsc_domain_code
          , hsc_status_code
          , hsc_status_name
          , hsc_seq_no
          , hsc_allow_feature1
          , hsc_allow_feature2
          , hsc_allow_feature3
          , hsc_allow_feature4
          , hsc_allow_feature5
          , hsc_allow_feature6
          , hsc_allow_feature7
          , hsc_allow_feature8
          , hsc_allow_feature9
          , hsc_start_date
          , hsc_end_date )
      SELECT
            l_rec_hsc.hsc_domain_code
          , l_rec_hsc.hsc_status_code
          , l_rec_hsc.hsc_status_name
          , l_rec_hsc.hsc_seq_no
          , l_rec_hsc.hsc_allow_feature1
          , l_rec_hsc.hsc_allow_feature2
          , l_rec_hsc.hsc_allow_feature3
          , l_rec_hsc.hsc_allow_feature4
          , l_rec_hsc.hsc_allow_feature5
          , l_rec_hsc.hsc_allow_feature6
          , l_rec_hsc.hsc_allow_feature7
          , l_rec_hsc.hsc_allow_feature8
          , l_rec_hsc.hsc_allow_feature9
          , l_rec_hsc.hsc_start_date
          , l_rec_hsc.hsc_end_date
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  hig_status_codes
                        WHERE  hsc_domain_code = l_rec_hsc.hsc_domain_code
                        AND    hsc_status_code = l_rec_hsc.hsc_status_code
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
-- HIG_OPTION_LIST and HIG_OPTION_VALUES
--
   l_tab_hol_id         nm3type.tab_varchar30;
   l_tab_hol_product    nm3type.tab_varchar30;
   l_tab_hol_name       nm3type.tab_varchar30;
   l_tab_hol_remarks    nm3type.tab_varchar2000;
   l_tab_hol_domain     nm3type.tab_varchar30;
   l_tab_hol_datatype   nm3type.tab_varchar30;
   l_tab_hol_mixed_case nm3type.tab_varchar30;
   l_tab_hov_value      nm3type.tab_varchar2000;
--
   c_y_or_n CONSTANT    hig_domains.hdo_domain%TYPE := 'Y_OR_N';
--
   PROCEDURE add (p_hol_id         VARCHAR2
                 ,p_hol_product    VARCHAR2
                 ,p_hol_name       VARCHAR2
                 ,p_hol_remarks    VARCHAR2
                 ,p_hol_domain     VARCHAR2 DEFAULT Null
                 ,p_hol_datatype   VARCHAR2 DEFAULT nm3type.c_varchar
                 ,p_hol_mixed_case VARCHAR2 DEFAULT 'N'
                 ,p_hov_value      VARCHAR2 DEFAULT NULL
                 ) IS
      c_count PLS_INTEGER := l_tab_hol_id.COUNT+1;
   BEGIN
      l_tab_hol_id(c_count)         := p_hol_id;
      l_tab_hol_product(c_count)    := p_hol_product;
      l_tab_hol_name(c_count)       := p_hol_name;
      l_tab_hol_remarks(c_count)    := p_hol_remarks;
      l_tab_hol_domain(c_count)     := p_hol_domain;
      l_tab_hol_datatype(c_count)   := p_hol_datatype;
      l_tab_hol_mixed_case(c_count) := p_hol_mixed_case;
      l_tab_hov_value(c_count)      := p_hov_value;
   END add;
BEGIN

-----------------------
-- For Gang Maintenance
-----------------------
   add (p_hol_id         => 'GANGENABLE'
       ,p_hol_product    => 'MAI'
       ,p_hol_name       => 'GANG ENABLE'
       ,p_hol_remarks    => 'Enable Gang Alloaction'
       ,p_hol_domain     => NULL
       ,p_hol_datatype   => nm3type.c_varchar
       ,p_hol_mixed_case => 'N'
       ,p_hov_value      => NULL
       );
       
   add (p_hol_id         => 'UNICLASS'
       ,p_hol_product    => 'MAI'
       ,p_hol_name       => 'UNICLASS'
       ,p_hol_remarks    => 'Gang allocation restriction'
       ,p_hol_domain     => NULL
       ,p_hol_datatype   => nm3type.c_varchar
       ,p_hol_mixed_case => 'N'
       ,p_hov_value      => NULL
       );       

   FORALL i IN 1..l_tab_hol_id.COUNT
      INSERT INTO hig_option_list
            (hol_id
            ,hol_product
            ,hol_name
            ,hol_remarks
            ,hol_domain
            ,hol_datatype
            ,hol_mixed_case
            )
      SELECT l_tab_hol_id(i)
            ,l_tab_hol_product(i)
            ,l_tab_hol_name(i)
            ,l_tab_hol_remarks(i)
            ,l_tab_hol_domain(i)
            ,l_tab_hol_datatype(i)
            ,l_tab_hol_mixed_case(i)
        FROM dual
      WHERE  NOT EXISTS (SELECT 1
                          FROM  hig_option_list
                         WHERE  hol_id = l_tab_hol_id(i)
                        );
--
   FORALL i IN 1..l_tab_hol_id.COUNT
      INSERT INTO hig_option_values
            (hov_id
            ,hov_value
            )
      SELECT l_tab_hol_id(i)
            ,l_tab_hov_value(i)
        FROM dual
      WHERE  l_tab_hov_value(i) IS NOT NULL
       AND   NOT EXISTS (SELECT 1
                          FROM  hig_option_values
                         WHERE  hov_id = l_tab_hol_id(i)
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
-- *  GRI_PARAMS  *
-- ****************
--
   TYPE tab_rec_grp IS TABLE OF gri_params%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_grp     gri_params%ROWTYPE;
   l_tab_rec_grp tab_rec_grp;
--
   l_grp_count      PLS_INTEGER := 0;
--
   PROCEDURE add_grp IS
   BEGIN
      l_grp_count := l_grp_count + 1;
      l_tab_rec_grp(l_grp_count) := l_rec_grp;
   END add_grp;
--
BEGIN
--

  l_rec_grp.gp_param            := 'NM_ELEMENT';
  l_rec_grp.gp_param_type       := 'NUMBER';
  l_rec_grp.gp_table            := 'NM_ELEMENTS';
  l_rec_grp.gp_column           := 'NE_ID';
  l_rec_grp.gp_descr_column     := 'NE_DESCR';
  l_rec_grp.gp_shown_column     := 'NE_UNIQUE';
  l_rec_grp.gp_shown_type       := 'CHAR';
  l_rec_grp.gp_descr_type       := 'CHAR';
  l_rec_grp.gp_order            := Null;
  l_rec_grp.gp_case             := Null;
  l_rec_grp.gp_gaz_restriction  := 'NW_ALL';
  add_grp;


   FOR i IN 1..l_grp_count
    LOOP
      l_rec_grp := l_tab_rec_grp(i);
      INSERT INTO gri_params
            (
             gp_param
            ,gp_param_type
            ,gp_table
            ,gp_column
            ,gp_descr_column
            ,gp_shown_column
            ,gp_shown_type
            ,gp_descr_type
            ,gp_order
            ,gp_case
            ,gp_gaz_restriction
            )
      SELECT
            l_rec_grp.gp_param
          , l_rec_grp.gp_param_type
          , l_rec_grp.gp_table
          , l_rec_grp.gp_column
          , l_rec_grp.gp_descr_column
          , l_rec_grp.gp_shown_column
          , l_rec_grp.gp_shown_type
          , l_rec_grp.gp_descr_type
          , l_rec_grp.gp_order
          , l_rec_grp.gp_case
          , l_rec_grp.gp_gaz_restriction
       FROM  dual
      WHERE NOT EXISTS (SELECT 1
                         FROM  gri_params
                        WHERE  gp_param = l_rec_grp.gp_param
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

  l_rec_grm.grm_module       := 'MAI2530';
  l_rec_grm.grm_module_type  := 'SQL';
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
  
  
  l_rec_grm.grm_module       := 'MAI3908';
  l_rec_grm.grm_module_type  := 'N/A';
  l_rec_grm.grm_module_path  := '$PROD_HOME\bin';
  l_rec_grm.grm_file_type    := 'lis';
  l_rec_grm.grm_tag_flag     := 'N';
  l_rec_grm.grm_tag_table    := Null;
  l_rec_grm.grm_tag_column   := Null;
  l_rec_grm.grm_tag_where    := Null;
  l_rec_grm.grm_linesize     := 80;
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

  l_rec_gmp.gmp_module            := 'MAI2530';
  l_rec_gmp.gmp_param             := 'NM_ELEMENT';
  l_rec_gmp.gmp_seq               := 1;
  l_rec_gmp.gmp_param_descr       := 'Select Location';
  l_rec_gmp.gmp_mandatory         := 'Y';
  l_rec_gmp.gmp_no_allowed        := 3;
  l_rec_gmp.gmp_where             := Null;
  l_rec_gmp.gmp_tag_restriction   := 'N';
  l_rec_gmp.gmp_tag_where         := Null;
  l_rec_gmp.gmp_default_table     := Null;
  l_rec_gmp.gmp_default_column    := Null;
  l_rec_gmp.gmp_default_where     := Null;
  l_rec_gmp.gmp_visible           := 'Y';
  l_rec_gmp.gmp_gazetteer         := 'Y';
  l_rec_gmp.gmp_lov               := 'Y';
  l_rec_gmp.gmp_val_global        := NULL;
  l_rec_gmp.gmp_wildcard          := 'N';
  l_rec_gmp.gmp_hint_text         := 'Select Survey Area';
  l_rec_gmp.gmp_allow_partial     := 'N';
  l_rec_gmp.gmp_base_table        := 'NM_ELEMENTS'; 
  l_rec_gmp.gmp_base_table_column := 'NE_ID';
  l_rec_gmp.gmp_operator          := '=';
  add_gmp;
--
  l_rec_gmp.gmp_module            := 'MAI3908';
  l_rec_gmp.gmp_param             := 'WORKS_ORDER_NO';
  l_rec_gmp.gmp_seq               := 1;
  l_rec_gmp.gmp_param_descr       := 'Works Order No';
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
  l_rec_gmp.gmp_hint_text         := Null;
  l_rec_gmp.gmp_allow_partial     := 'N';
  l_rec_gmp.gmp_base_table        := Null; 
  l_rec_gmp.gmp_base_table_column := Null;
  l_rec_gmp.gmp_operator          := Null;
  add_gmp;
--
  l_rec_gmp.gmp_module            := 'MAI3908';
  l_rec_gmp.gmp_param             := 'ANSWER';
  l_rec_gmp.gmp_seq               := 2;
  l_rec_gmp.gmp_param_descr       := 'Print Labour Units (Y/N)';
  l_rec_gmp.gmp_mandatory         := 'Y';
  l_rec_gmp.gmp_no_allowed        := 1;
  l_rec_gmp.gmp_where             := 'GPL_PARAM=''ANSWER''';
  l_rec_gmp.gmp_tag_restriction   := 'N';
  l_rec_gmp.gmp_tag_where         := Null;
  l_rec_gmp.gmp_default_table     := 'GRI_PARAM_LOOKUP';
  l_rec_gmp.gmp_default_column    := 'GPL_VALUE';
  l_rec_gmp.gmp_default_where     := 'GPL_VALUE=''N'' AND GPL_PARAM=''ANSWER''';
  l_rec_gmp.gmp_visible           := 'Y';
  l_rec_gmp.gmp_gazetteer         := 'N';
  l_rec_gmp.gmp_lov               := 'Y';
  l_rec_gmp.gmp_val_global        := NULL;
  l_rec_gmp.gmp_wildcard          := 'N';
  l_rec_gmp.gmp_hint_text         := Null;
  l_rec_gmp.gmp_allow_partial     := 'N';
  l_rec_gmp.gmp_base_table        := Null; 
  l_rec_gmp.gmp_base_table_column := Null;
  l_rec_gmp.gmp_operator          := Null;
  add_gmp;

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
-- HIG_HD Data
-------------------------------------------------------------------------------------------------
--
--
--
REM;
REM HIG_HD_MODULES ;
REM;
--
-- Columns
-- HHM_MODULE                     NOT NULL VARCHAR2(30)
--   HIG_HD_HHM_PK (Pos 1)
-- HHM_TAG                                 VARCHAR2(30)
--
-- Constraints
-- HIG_HD_HHM_PK - Primary Key
--
INSERT INTO HIG_HD_MODULES
       (HHM_MODULE
       ,HHM_TAG
       )
SELECT 
        'MAI2530_A'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MODULES
                   WHERE HHM_MODULE = 'MAI2530_A');
--
INSERT INTO HIG_HD_MODULES
       (HHM_MODULE
       ,HHM_TAG
       )
SELECT 
        'MAI2530'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MODULES
                   WHERE HHM_MODULE = 'MAI2530');
--
REM;
REM HIG_HD_MOD_USES ;
REM;
--
-- Columns
-- HHU_HHM_MODULE                 NOT NULL VARCHAR2(30)
--   HIG_HD_HHU_HHM_FK (Pos 1)
--   HIG_HD_HHU_PK (Pos 1)
-- HHU_TABLE_NAME                 NOT NULL VARCHAR2(30)
-- HHU_SEQ                        NOT NULL NUMBER(22)
--   HIG_HD_HHU_PK (Pos 2)
-- HHU_ALIAS                               VARCHAR2(30)
-- HHU_PARENT_SEQ                          NUMBER(22)
-- HHU_FIXED_WHERE_CLAUSE                  VARCHAR2(500)
-- HHU_LOAD_DATA                  NOT NULL VARCHAR2(1)
--   HIG_HD_HHU_LOAD_DATA_CHK
-- HHU_TAG                                 VARCHAR2(100)
-- HHU_HINT_TEXT                           VARCHAR2(100)
--
-- Constraints
-- HIG_HD_HHU_HHM_FK - Referential Integrity
--  References HIG_HD_HHM_PK on HIG_HD_MODULES (Delete Rule:CASCADE)
-- HIG_HD_HHU_LOAD_DATA_CHK - Check
--  HHU_LOAD_DATA IN ('Y', 'N')
-- HIG_HD_HHU_PK - Primary Key
--
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'BOQ_ITEMS'
       ,7
       ,'boq'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 7);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6.4
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6.4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6.3
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6.3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6.2
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6.2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,6
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 6);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,5
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 5);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,4
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,3
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,2
       ,'def'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530_A'
       ,'DEFECTS'
       ,1
       ,'def'
       ,null
       ,'def_rse_he_id IN (SELECT nm_ne_id_of'||CHR(10)||'       FROM  nm_members'||CHR(10)||'       CONNECT BY PRIOR nm_ne_id_of = nm_ne_id_in'||CHR(10)||'       START WITH nm_ne_id_in       = :extent'||CHR(10)||'      )'||CHR(10)||'AND def_status_code = ''AVAILABLE'''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHU_SEQ = 1);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,4
       ,'ne'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 4);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,3
       ,'ne'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 3);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,2
       ,'ne'
       ,1
       ,''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 2);
--
INSERT INTO HIG_HD_MOD_USES
       (HHU_HHM_MODULE
       ,HHU_TABLE_NAME
       ,HHU_SEQ
       ,HHU_ALIAS
       ,HHU_PARENT_SEQ
       ,HHU_FIXED_WHERE_CLAUSE
       ,HHU_LOAD_DATA
       ,HHU_TAG
       ,HHU_HINT_TEXT
       )
SELECT 
        'MAI2530'
       ,'nm_elements'
       ,1
       ,'ne'
       ,null
       ,'ne_id IN (SELECT nm_ne_id_of'||CHR(10)||'       FROM  nm_members'||CHR(10)||'       CONNECT BY PRIOR nm_ne_id_of = nm_ne_id_in'||CHR(10)||'       START WITH nm_ne_id_in       = :extent'||CHR(10)||'      )'||CHR(10)||'AND   ne_nt_type  = ''HERM'''
       ,'N'
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_MOD_USES
                   WHERE HHU_HHM_MODULE = 'MAI2530'
                    AND  HHU_SEQ = 1);
--
REM;
REM HIG_HD_LOOKUP_JOIN_DEFS ;
REM;
--
-- Columns
-- HHL_HHU_HHM_MODULE             NOT NULL VARCHAR2(30)
--   HIG_HD_HHL_HHU_FK (Pos 1)
--   HIG_HD_HHL_PK (Pos 1)
-- HHL_HHU_SEQ                    NOT NULL NUMBER(22)
--   HIG_HD_HHL_HHU_FK (Pos 2)
--   HIG_HD_HHL_PK (Pos 2)
-- HHL_JOIN_SEQ                   NOT NULL NUMBER(22)
--   HIG_HD_HHL_PK (Pos 3)
-- HHL_TABLE_NAME                 NOT NULL VARCHAR2(30)
-- HHL_ALIAS                      NOT NULL VARCHAR2(30)
-- HHL_OUTER_JOIN                 NOT NULL VARCHAR2(1)
--   HIG_HD_HHL_OUTER_JOIN
-- HHL_FIXED_WHERE_CLAUSE                  VARCHAR2(500)
--
-- Constraints
-- HIG_HD_HHL_HHU_FK - Referential Integrity
--  References HIG_HD_HHU_PK on HIG_HD_MOD_USES (Delete Rule:CASCADE)
-- HIG_HD_HHL_OUTER_JOIN - Check
--  HHL_OUTER_JOIN IN ('Y', 'N')
-- HIG_HD_HHL_PK - Primary Key
--
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_4 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6.4
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_3 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6.3
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_2 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6.2
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_types'
       ,'dty'
       ,'N'
       ,'dty_hh_attribute_1 IS NOT NULL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 6
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,5
       ,2
       ,'treatments'
       ,'tre'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,5
       ,1
       ,'repairs'
       ,'rep'
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 5
                    AND  HHL_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS
       (HHL_HHU_HHM_MODULE
       ,HHL_HHU_SEQ
       ,HHL_JOIN_SEQ
       ,HHL_TABLE_NAME
       ,HHL_ALIAS
       ,HHL_OUTER_JOIN
       ,HHL_FIXED_WHERE_CLAUSE
       )
SELECT 
        'MAI2530_A'
       ,1
       ,1
       ,'nm_elements'
       ,'ne'
       ,'N'
       ,'ne_nt_type = ''HERM''' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_DEFS
                   WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHL_HHU_SEQ = 1
                    AND  HHL_JOIN_SEQ = 1);
--
REM;
REM HIG_HD_LOOKUP_JOIN_COLS ;
REM;
--
-- Columns
-- HHO_HHL_HHU_HHM_MODULE         NOT NULL VARCHAR2(30)
--   HIG_HD_HHO_HHL_FK (Pos 1)
--   HIG_HD_HHO_HHL_LOOKUP_FK (Pos 1)
--   HIG_HD_HHO_PK (Pos 1)
-- HHO_HHL_HHU_SEQ                NOT NULL NUMBER(22)
--   HIG_HD_HHO_HHL_FK (Pos 2)
--   HIG_HD_HHO_HHL_LOOKUP_FK (Pos 2)
--   HIG_HD_HHO_PK (Pos 2)
-- HHO_HHL_JOIN_SEQ               NOT NULL NUMBER(22)
--   HIG_HD_HHO_HHL_FK (Pos 3)
--   HIG_HD_HHO_PK (Pos 3)
-- HHO_PARENT_COL                 NOT NULL VARCHAR2(30)
--   HIG_HD_HHO_PK (Pos 4)
-- HHO_LOOKUP_COL                 NOT NULL VARCHAR2(30)
--   HIG_HD_HHO_PK (Pos 5)
-- HHO_HHL_JOIN_TO_LOOKUP                  NUMBER(22)
--   HIG_HD_HHO_HHL_LOOKUP_FK (Pos 3)
--
-- Constraints
-- HIG_HD_HHO_HHL_FK - Referential Integrity
--  References HIG_HD_HHL_PK on HIG_HD_LOOKUP_JOIN_DEFS (Delete Rule:CASCADE)
-- HIG_HD_HHO_HHL_LOOKUP_FK - Referential Integrity
--  References HIG_HD_HHL_PK on HIG_HD_LOOKUP_JOIN_DEFS (Delete Rule:CASCADE)
-- HIG_HD_HHO_PK - Primary Key
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.4
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.4
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_ity_sys_flag'
       ,'dty_dtp_flag'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.3
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_ity_sys_flag'
                    AND  HHO_LOOKUP_COL = 'dty_dtp_flag');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.3
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.3
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_ity_sys_flag'
       ,'dty_dtp_flag'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.2
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_ity_sys_flag'
                    AND  HHO_LOOKUP_COL = 'dty_dtp_flag');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.2
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6.2
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_ity_sys_flag'
       ,'dty_dtp_flag'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_ity_sys_flag'
                    AND  HHO_LOOKUP_COL = 'dty_dtp_flag');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_defect_code'
       ,'dty_defect_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_code'
                    AND  HHO_LOOKUP_COL = 'dty_defect_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'def_atv_acty_area_code'
       ,'dty_atv_acty_area_code'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 6
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_atv_acty_area_code'
                    AND  HHO_LOOKUP_COL = 'dty_atv_acty_area_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,5
       ,2
       ,'rep_tre_treat_code'
       ,'tre_treat_code'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 2
                    AND  HHO_PARENT_COL = 'rep_tre_treat_code'
                    AND  HHO_LOOKUP_COL = 'tre_treat_code');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,5
       ,1
       ,'def_defect_id'
       ,'rep_def_defect_id'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 5
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_defect_id'
                    AND  HHO_LOOKUP_COL = 'rep_def_defect_id');
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS
       (HHO_HHL_HHU_HHM_MODULE
       ,HHO_HHL_HHU_SEQ
       ,HHO_HHL_JOIN_SEQ
       ,HHO_PARENT_COL
       ,HHO_LOOKUP_COL
       ,HHO_HHL_JOIN_TO_LOOKUP
       )
SELECT 
        'MAI2530_A'
       ,1
       ,1
       ,'def_rse_he_id'
       ,'ne_id'
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_LOOKUP_JOIN_COLS
                   WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHO_HHL_HHU_SEQ = 1
                    AND  HHO_HHL_JOIN_SEQ = 1
                    AND  HHO_PARENT_COL = 'def_rse_he_id'
                    AND  HHO_LOOKUP_COL = 'ne_id');
--
REM;
REM HIG_HD_SELECTED_COLS ;
REM;
--
-- Columns
-- HHC_HHU_HHM_MODULE             NOT NULL VARCHAR2(30)
--   HIG_HD_HHC_HHL_FK (Pos 1)
--   HIG_HD_HHC_HHU_FK (Pos 1)
--   HIG_HD_HHC_PK (Pos 1)
-- HHC_HHU_SEQ                    NOT NULL NUMBER(22)
--   HIG_HD_HHC_HHL_FK (Pos 2)
--   HIG_HD_HHC_HHU_FK (Pos 2)
--   HIG_HD_HHC_PK (Pos 2)
-- HHC_COLUMN_SEQ                 NOT NULL NUMBER(22)
--   HIG_HD_HHC_PK (Pos 3)
-- HHC_COLUMN_NAME                NOT NULL VARCHAR2(30)
-- HHC_SUMMARY_VIEW               NOT NULL VARCHAR2(1)
--   HIG_HD_HHC_SUMMARY_VIEW
-- HHC_DISPLAYED                  NOT NULL VARCHAR2(1)
--   HIG_HD_HHC_DISPLAYED
-- HHC_ALIAS                               VARCHAR2(30)
-- HHC_FUNCTION                            VARCHAR2(200)
-- HHC_ORDER_BY_SEQ                        NUMBER(22)
-- HHC_UNIQUE_IDENTIFIER_SEQ               NUMBER(22)
-- HHC_HHL_JOIN_SEQ                        NUMBER(22)
--   HIG_HD_HHC_HHL_FK (Pos 3)
-- HHC_CALC_RATIO                          VARCHAR2(1)
-- HHC_FORMAT                              VARCHAR2(30)
--
-- Constraints
-- HIG_HD_HHC_HHL_FK - Referential Integrity
--  References HIG_HD_HHL_PK on HIG_HD_LOOKUP_JOIN_DEFS (Delete Rule:CASCADE)
-- HIG_HD_HHC_HHU_FK - Referential Integrity
--  References HIG_HD_HHU_PK on HIG_HD_MOD_USES (Delete Rule:CASCADE)
-- HIG_HD_HHC_DISPLAYED - Check
--  HHC_DISPLAYED IN ('Y', 'N')
-- HIG_HD_HHC_PK - Primary Key
-- HIG_HD_HHC_SUMMARY_VIEW - Check
--  HHC_SUMMARY_VIEW IN ('Y', 'N')
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,1
       ,1
       ,'1'
       ,'N'
       ,'Y'
       ,'line1'
       ,'''"1'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,1
       ,2
       ,'ne_unique'
       ,'N'
       ,'Y'
       ,'ne_unique'
       ,'ne_unique||''"'''
       ,null
       ,null
       ,1
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,21
       ,'2'
       ,'N'
       ,'Y'
       ,'line2'
       ,'''"2'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 21);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,22
       ,'def_defect_id'
       ,'N'
       ,'Y'
       ,'def_defect_id'
       ,''
       ,null
       ,1
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 22);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,23
       ,'def_atv_acty_area_code'
       ,'N'
       ,'Y'
       ,'def_atv_acty_area_code'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 23);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,24
       ,'def_defect_code'
       ,'N'
       ,'Y'
       ,'def_defect_code'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 24);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,25
       ,'def_priority'
       ,'N'
       ,'Y'
       ,'def_priority'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 25);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,26
       ,'on_works_order'
       ,'N'
       ,'Y'
       ,'on_wo'
       ,'decode(def_works_order_no, NULL, ''N'', ''Y'')'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 26);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,2
       ,27
       ,'def_works_order_no'
       ,'N'
       ,'Y'
       ,'def_works_order_no'
       ,'def_works_order_no||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 27);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,31
       ,'3'
       ,'N'
       ,'Y'
       ,'line3'
       ,'''"3'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 31);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,32
       ,'def_locn_descr'
       ,'N'
       ,'Y'
       ,'def_locn_descr'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 32);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,33
       ,'def_st_chain'
       ,'N'
       ,'Y'
       ,'def_st_chain'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 33);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,34
       ,'def_x_sect'
       ,'N'
       ,'Y'
       ,'def_x_sect'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 34);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,3
       ,35
       ,'NULL'
       ,'N'
       ,'Y'
       ,''
       ,'NULL||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 35);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,4
       ,41
       ,'''"4'''
       ,'N'
       ,'Y'
       ,'line4'
       ,'''"4'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 41);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,4
       ,42
       ,'def_defect_descr'
       ,'N'
       ,'Y'
       ,'def_defect_descr'
       ,'def_defect_descr||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 42);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,1
       ,'5'
       ,'N'
       ,'Y'
       ,'line5'
       ,'''"5'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,2
       ,'rep_tre_treat_code'
       ,'N'
       ,'Y'
       ,'rep_tre_treat_code'
       ,''
       ,null
       ,null
       ,1
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,3
       ,'tre_descr'
       ,'N'
       ,'Y'
       ,'tre_descr'
       ,''
       ,null
       ,null
       ,2
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 3);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,5
       ,4
       ,'def_update_inv'
       ,'N'
       ,'Y'
       ,'def_update_inv'
       ,'def_update_inv||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 5
                    AND  HHC_COLUMN_SEQ = 4);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6
       ,2
       ,'1'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_1)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.2
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.2
       ,2
       ,'2'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_2)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.2
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.3
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.3
       ,2
       ,'3'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_3)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.3
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,1
       ,'6'
       ,'N'
       ,'Y'
       ,'line6'
       ,'''"6'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.4
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,6.4
       ,2
       ,'4'
       ,'N'
       ,'Y'
       ,''
       ,'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_4)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 6.4
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,7
       ,1
       ,'1'
       ,'N'
       ,'Y'
       ,'line7'
       ,'''"7'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 7
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,7
       ,2
       ,'boq_sta_item_code'
       ,'N'
       ,'Y'
       ,'boq_sta_item_code'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 7
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530_A'
       ,7
       ,3
       ,'boq_est_quantitiy'
       ,'N'
       ,'Y'
       ,'boq_est_quantitiy'
       ,'boq_est_quantity||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHC_HHU_SEQ = 7
                    AND  HHC_COLUMN_SEQ = 3);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,1
       ,'1'
       ,'N'
       ,'Y'
       ,'rec1'
       ,'''"1'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 1);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,2
       ,'ne_unique'
       ,'N'
       ,'Y'
       ,'ne_unique'
       ,''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 2);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,3
       ,'''INSP'''
       ,'N'
       ,'Y'
       ,'insp'
       ,'''INSP'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 3);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,4
       ,'any_defects'
       ,'N'
       ,'Y'
       ,'any_defects'
       ,'mai_gmis_util.defects_exist_on_section (ne_id)'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 4);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,1
       ,5
       ,'ne_length'
       ,'N'
       ,'Y'
       ,'ne_length'
       ,'to_char(nm3net.get_ne_length(ne_id), ''99999.999'')||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 1
                    AND  HHC_COLUMN_SEQ = 5);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,2
       ,20
       ,'2'
       ,'N'
       ,'Y'
       ,'rec'
       ,'''"2'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 20);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,2
       ,21
       ,'ne_descr'
       ,'N'
       ,'Y'
       ,'road_name'
       ,'rtrim(ne_name_1)'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 21);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,2
       ,22
       ,'null'
       ,'N'
       ,'Y'
       ,''
       ,'null||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 2
                    AND  HHC_COLUMN_SEQ = 22);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,3
       ,30
       ,'3'
       ,'N'
       ,'Y'
       ,'rec3'
       ,'''"3'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 30);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,3
       ,31
       ,'section_desc'
       ,'N'
       ,'Y'
       ,'section_desc'
       ,'rtrim(ne_descr)||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 3
                    AND  HHC_COLUMN_SEQ = 31);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,4
       ,40
       ,'4'
       ,'N'
       ,'Y'
       ,'rec4'
       ,'''"4'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 40);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,4
       ,41
       ,'NULL'
       ,'N'
       ,'Y'
       ,''
       ,'NULL'
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 41);
--
INSERT INTO HIG_HD_SELECTED_COLS
       (HHC_HHU_HHM_MODULE
       ,HHC_HHU_SEQ
       ,HHC_COLUMN_SEQ
       ,HHC_COLUMN_NAME
       ,HHC_SUMMARY_VIEW
       ,HHC_DISPLAYED
       ,HHC_ALIAS
       ,HHC_FUNCTION
       ,HHC_ORDER_BY_SEQ
       ,HHC_UNIQUE_IDENTIFIER_SEQ
       ,HHC_HHL_JOIN_SEQ
       ,HHC_CALC_RATIO
       ,HHC_FORMAT
       )
SELECT 
        'MAI2530'
       ,4
       ,42
       ,'sysdate'
       ,'N'
       ,'Y'
       ,'download_date'
       ,'TO_CHAR(sysdate, ''YYMMDD'')||''"'''
       ,null
       ,null
       ,null
       ,'N'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_SELECTED_COLS
                   WHERE HHC_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHC_HHU_SEQ = 4
                    AND  HHC_COLUMN_SEQ = 42);
--
REM;
REM HIG_HD_JOIN_DEFS ;
REM;
--
-- Columns
-- HHT_HHU_HHM_MODULE             NOT NULL VARCHAR2(30)
--   HIG_HD_HHT_PK (Pos 1)
--   HIG_HD_MUJ_MU_FK (Pos 1)
-- HHT_HHU_SEQ                    NOT NULL NUMBER(22)
--   HIG_HD_HHT_PK (Pos 2)
--   HIG_HD_MUJ_MU_FK (Pos 2)
-- HHT_JOIN_SEQ                   NOT NULL NUMBER(22)
--   HIG_HD_HHT_PK (Pos 3)
-- HHT_TYPE                       NOT NULL VARCHAR2(30)
-- HHT_DESCRIPTION                         VARCHAR2(30)
--
-- Constraints
-- HIG_HD_MUJ_MU_FK - Referential Integrity
--  References HIG_HD_HHU_PK on HIG_HD_MOD_USES (Delete Rule:CASCADE)
-- HIG_HD_HHT_PK - Primary Key
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.4
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6.4);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.3
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6.3);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.2
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6.2);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,4
       ,'TABLE'
       ,'to line 4' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 4);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,3
       ,'TABLE'
       ,'to line 3' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 3);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,2
       ,'TABLE'
       ,'to line 2' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,7
       ,'TABLE'
       ,'to line 7 (boq_items)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 7);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,5
       ,'TABLE'
       ,'to line 5' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 5);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6
       ,'TABLE'
       ,'to line 6 (def_types)' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 6);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530'
       ,1
       ,2
       ,'TABLE'
       ,'join to line 3' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 2);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530'
       ,1
       ,1
       ,'TABLE'
       ,'join to line 2' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 1);
--
INSERT INTO HIG_HD_JOIN_DEFS
       (HHT_HHU_HHM_MODULE
       ,HHT_HHU_SEQ
       ,HHT_JOIN_SEQ
       ,HHT_TYPE
       ,HHT_DESCRIPTION
       )
SELECT 
        'MAI2530'
       ,1
       ,3
       ,'TABLE'
       ,'join to line 4' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_JOIN_DEFS
                   WHERE HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHT_HHU_SEQ = 1
                    AND  HHT_JOIN_SEQ = 3);
--
REM;
REM HIG_HD_TABLE_JOIN_COLS ;
REM;
--
-- Columns
-- HHJ_HHT_HHU_HHM_MODULE         NOT NULL VARCHAR2(30)
--   HIG_HD_HHJ_HHC_PARENT_FK (Pos 1)
--   HIG_HD_HHJ_HHT_FK (Pos 1)
--   HIG_HD_HHJ_HHU_CHILD_FK (Pos 1)
--   HIG_HD_HHJ_PK (Pos 1)
-- HHJ_HHT_HHU_PARENT_TABLE       NOT NULL NUMBER(22)
--   HIG_HD_HHJ_HHC_PARENT_FK (Pos 2)
--   HIG_HD_HHJ_HHT_FK (Pos 2)
--   HIG_HD_HHJ_PK (Pos 2)
-- HHJ_HHT_JOIN_SEQ               NOT NULL NUMBER(22)
--   HIG_HD_HHJ_HHT_FK (Pos 3)
--   HIG_HD_HHJ_PK (Pos 3)
-- HHJ_PARENT_COL                 NOT NULL VARCHAR2(30)
--   HIG_HD_HHJ_PK (Pos 4)
-- HHJ_HHU_CHILD_TABLE            NOT NULL NUMBER(22)
--   HIG_HD_HHJ_HHU_CHILD_FK (Pos 2)
--   HIG_HD_HHJ_PK (Pos 5)
-- HHJ_CHILD_COL                  NOT NULL VARCHAR2(30)
--   HIG_HD_HHJ_PK (Pos 6)
--
-- Constraints
-- HIG_HD_HHJ_HHT_FK - Referential Integrity
--  References HIG_HD_HHT_PK on HIG_HD_JOIN_DEFS (Delete Rule:CASCADE)
-- HIG_HD_HHJ_HHC_PARENT_FK - Referential Integrity
--  References HIG_HD_HHU_PK on HIG_HD_MOD_USES (Delete Rule:CASCADE)
-- HIG_HD_HHJ_HHU_CHILD_FK - Referential Integrity
--  References HIG_HD_HHU_PK on HIG_HD_MOD_USES (Delete Rule:CASCADE)
-- HIG_HD_HHJ_PK - Primary Key
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,4
       ,'ROWID'
       ,4
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 4
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 4
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,3
       ,'ROWID'
       ,3
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 3
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 3
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,2
       ,'ROWID'
       ,2
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 2
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 2
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,7
       ,'DEF_DEFECT_ID'
       ,7
       ,'BOQ_DEFECT_ID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 7
                    AND  HHJ_PARENT_COL = 'DEF_DEFECT_ID'
                    AND  HHJ_HHU_CHILD_TABLE = 7
                    AND  HHJ_CHILD_COL = 'BOQ_DEFECT_ID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.4
       ,'ROWID'
       ,6.4
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 6.4
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 6.4
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6.3
       ,'ROWID'
       ,6.3
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 6.3
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 6.3
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,6
       ,'ROWID'
       ,6
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 6
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 6
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530_A'
       ,1
       ,5
       ,'ROWID'
       ,5
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 5
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 5
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530'
       ,1
       ,2
       ,'ROWID'
       ,3
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 2
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 3
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530'
       ,1
       ,1
       ,'ROWID'
       ,2
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 1
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 2
                    AND  HHJ_CHILD_COL = 'ROWID');
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS
       (HHJ_HHT_HHU_HHM_MODULE
       ,HHJ_HHT_HHU_PARENT_TABLE
       ,HHJ_HHT_JOIN_SEQ
       ,HHJ_PARENT_COL
       ,HHJ_HHU_CHILD_TABLE
       ,HHJ_CHILD_COL
       )
SELECT 
        'MAI2530'
       ,1
       ,3
       ,'ROWID'
       ,4
       ,'ROWID' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_HD_TABLE_JOIN_COLS
                   WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530'
                    AND  HHJ_HHT_HHU_PARENT_TABLE = 1
                    AND  HHJ_HHT_JOIN_SEQ = 3
                    AND  HHJ_PARENT_COL = 'ROWID'
                    AND  HHJ_HHU_CHILD_TABLE = 4
                    AND  HHJ_CHILD_COL = 'ROWID');


--

-----------------------
-- For Gang Maintenance
-----------------------
INSERT INTO WO_AUDIT_COLUMNS ( WAC_COLUMN_NAME
                             , WAC_DISPLAY_TEXT
                             , WAC_AUDITED ) 
                      SELECT
                              'WOL_GANG'
                             ,'WOL Gang'
                             ,'N'
FROM DUAL
 WHERE NOT EXISTS (SELECT 1 
                   FROM   WO_AUDIT_COLUMNS
                   WHERE  WAC_COLUMN_NAME = 'WOL_GANG');                             

COMMIT;

--------
-- Other
--------
UPDATE hig_modules
SET    hmo_use_gri = 'N'
WHERE  hmo_module IN ('MAI3946'
                     ,'MAI5065'
                     ,'MAI5200'
                     ,'MAI5205'
                     ,'MAI5210'
                     ,'MAI5215'
                     ,'MAI5220'                     
                     ,'MAI5225'
                     ,'MAI5235'
                     ,'MAI5240'
                     ,'MAI9020'
                     ,'MAI2600'
                     ,'MAI2105C')
/
COMMIT;

--
SET FEEDBACK ON

--
-- Re-Fresh GRI Meta-Data....
--
set define on
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata2' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF

COMMIT;

