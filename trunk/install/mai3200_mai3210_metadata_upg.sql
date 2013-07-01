--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3200_mai3210_metadata_upg.sql-arc   2.1   Jul 01 2013 16:02:18   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3200_mai3210_metadata_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:18  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.11
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
   c_xval CONSTANT VARCHAR2(4) := 'XVAL';
   c_web  CONSTANT VARCHAR2(3) := 'WEB';
--
   PROCEDURE add_hmo IS
   BEGIN
      l_hmo_count := l_hmo_count + 1;
      l_tab_rec_hmo(l_hmo_count) := l_rec_hmo;
   END add_hmo;
--
   PROCEDURE add_hmr (p_module   VARCHAR2
                     ,p_role   VARCHAR2
                     ,p_mode VARCHAR2 DEFAULT l_rec_hmo.hmo_module
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
  l_rec_hmo.hmo_title            := 'Create Route and Defect Files for GMIS Inspections';
  l_rec_hmo.hmo_filename         := 'mai2530';
  l_rec_hmo.hmo_module_type      := 'FMX';
  l_rec_hmo.hmo_fastpath_opts    := Null;
  l_rec_hmo.hmo_fastpath_invalid := 'N';
  l_rec_hmo.hmo_use_gri          := 'N';
  l_rec_hmo.hmo_application      := 'MAI';
  l_rec_hmo.hmo_menu             := Null;
  add_hmo;
  add_hmr('MAI2530','MAI_USER','NORMAL');
  --
  l_rec_hmo.hmo_module           := 'MAI3630';
  l_rec_hmo.hmo_title            := 'Budget Allocations';
  l_rec_hmo.hmo_filename         := 'mai3630';
  l_rec_hmo.hmo_module_type      := 'FMX';
  l_rec_hmo.hmo_fastpath_opts    := NULL;
  l_rec_hmo.hmo_fastpath_invalid := 'N';
  l_rec_hmo.hmo_use_gri          := 'N';
  l_rec_hmo.hmo_application      := 'MAI';
  l_rec_hmo.hmo_menu             := 'FORM';
  add_hmo;
  add_hmr('MAI3630','MAI_ADMIN','NORMAL');
  --
  l_rec_hmo.hmo_module           := 'MAI3632';
  l_rec_hmo.hmo_title            := 'Asset Activities';
  l_rec_hmo.hmo_filename         := 'mai3632';
  l_rec_hmo.hmo_module_type      := 'FMX';
  l_rec_hmo.hmo_fastpath_opts    := NULL;
  l_rec_hmo.hmo_fastpath_invalid := 'N';
  l_rec_hmo.hmo_use_gri          := 'N';
  l_rec_hmo.hmo_application      := 'MAI';
  l_rec_hmo.hmo_menu             := 'FORM';
  add_hmo;
  add_hmr('MAI3632','MAI_ADMIN','NORMAL');
  --
  l_rec_hmo.hmo_module           := 'MAI3807';
  l_rec_hmo.hmo_title            := 'Locator Create Defects';
  l_rec_hmo.hmo_filename         := 'mai3807';
  l_rec_hmo.hmo_module_type      := 'FMX';
  l_rec_hmo.hmo_fastpath_opts    := NULL;
  l_rec_hmo.hmo_fastpath_invalid := 'N';
  l_rec_hmo.hmo_use_gri          := 'N';
  l_rec_hmo.hmo_application      := 'MAI';
  l_rec_hmo.hmo_menu             := 'FORM';
  add_hmo;
  add_hmr('MAI3807','MAI_ADMIN','NORMAL');
  add_hmr('MAI3807','MAI_USER' ,'NORMAL');
  --
  l_rec_hmo.hmo_module           := 'MAI3801';
  l_rec_hmo.hmo_title            := 'Raise Work Order';
  l_rec_hmo.hmo_filename         := 'mai3801';
  l_rec_hmo.hmo_module_type      := 'FMX';
  l_rec_hmo.hmo_fastpath_opts    := NULL;
  l_rec_hmo.hmo_fastpath_invalid := 'N';
  l_rec_hmo.hmo_use_gri          := 'N';
  l_rec_hmo.hmo_application      := 'MAI';
  l_rec_hmo.hmo_menu             := 'FORM';
  add_hmo;
  add_hmr('MAI3801','MAI_ADMIN','NORMAL');
  add_hmr('MAI3801','MAI_USER' ,'NORMAL');
  --
  FOR i IN 1..l_hmo_count LOOP
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
          ,hmo_menu)
    SELECT l_rec_hmo.hmo_module
          ,l_rec_hmo.hmo_title
          ,l_rec_hmo.hmo_filename
          ,l_rec_hmo.hmo_module_type
          ,l_rec_hmo.hmo_fastpath_opts
          ,l_rec_hmo.hmo_fastpath_invalid
          ,l_rec_hmo.hmo_use_gri
          ,l_rec_hmo.hmo_application
          ,l_rec_hmo.hmo_menu
      FROM dual
     WHERE NOT EXISTS(SELECT 1
                        FROM hig_modules
                       WHERE hmo_module = l_rec_hmo.hmo_module)
         ;
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

--------------------------------------------------------------------------------------
--Asset Modification Domain.
--------------------------------------------------------------------------------------
INSERT
  INTO HIG_DOMAINS
      (HDO_DOMAIN
      ,HDO_PRODUCT
      ,HDO_TITLE
      ,HDO_CODE_LENGTH)
SELECT 'ASSET_MODIFICATION'
      ,'MAI'
      ,'Asset Modification Flag'
      ,10
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'ASSET_MODIFICATION')
/

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'ASSET_MODIFICATION'
      ,'R'
      ,'Replace'
      ,'Y'
      ,1
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                     AND HCO_CODE = 'R')
/

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'ASSET_MODIFICATION'
      ,'D'
      ,'Decommission'
      ,'Y'
      ,2
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                     AND HCO_CODE = 'D')
/

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'ASSET_MODIFICATION'
      ,'U'
      ,'Upgrade'
      ,'Y'
      ,3
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                     AND HCO_CODE = 'U')
/

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'ASSET_MODIFICATION'
      ,'A'
      ,'Add New'
      ,'Y'
      ,4
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'ASSET_MODIFICATION'
                     AND HCO_CODE = 'A')
/

--------------------------------------------------------------------------------------
--MAINT_INSP_FLAG Domain.
--------------------------------------------------------------------------------------
INSERT
  INTO HIG_DOMAINS
      (HDO_DOMAIN
      ,HDO_PRODUCT
      ,HDO_TITLE
      ,HDO_CODE_LENGTH)
SELECT 'MAINT_INSP_FLAG'
      ,'MAI'
      ,'Maintenance Inspection Flag'
      ,10
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'MAINT_INSP_FLAG')
/

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'MAINT_INSP_FLAG'
      ,'S'
      ,'Safety'
      ,'Y'
      ,1
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'MAINT_INSP_FLAG'
                     AND HCO_CODE = 'S')
/

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'MAINT_INSP_FLAG'
      ,'D'
      ,'Detailed'
      ,'Y'
      ,2
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'MAINT_INSP_FLAG'
                     AND HCO_CODE = 'D')
/

--
-- Ensure DUM value exists in domain INITIATION_TYPE
--

INSERT
  INTO HIG_CODES
      (HCO_DOMAIN
      ,HCO_CODE
      ,HCO_MEANING
      ,HCO_SYSTEM
      ,HCO_SEQ
      ,HCO_START_DATE
      ,HCO_END_DATE)
SELECT 'INITIATION_TYPE'
      ,'DUM'
      ,'Dummy'
      ,'Y'
      ,null
      ,null
      ,null
  FROM DUAL
 WHERE NOT EXISTS(SELECT 1
                    FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'INITIATION_TYPE'
                     AND HCO_CODE = 'DUM')
/

--------------------------------------------------------------------------------------
--Product Options.
--------------------------------------------------------------------------------------
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
  PROCEDURE add(p_hol_id         VARCHAR2
               ,p_hol_product    VARCHAR2
               ,p_hol_name       VARCHAR2
               ,p_hol_remarks    VARCHAR2
               ,p_hol_domain     VARCHAR2 DEFAULT Null
               ,p_hol_datatype   VARCHAR2 DEFAULT 'VARCHAR2'
               ,p_hol_mixed_case VARCHAR2 DEFAULT 'N'
               ,p_hov_value      VARCHAR2 DEFAULT NULL) IS
    --
    c_count PLS_INTEGER := l_tab_hol_id.COUNT+1;
    --
  BEGIN
    --
    l_tab_hol_id(c_count)         := p_hol_id;
    l_tab_hol_product(c_count)    := p_hol_product;
    l_tab_hol_name(c_count)       := p_hol_name;
    l_tab_hol_remarks(c_count)    := p_hol_remarks;
    l_tab_hol_domain(c_count)     := p_hol_domain;
    l_tab_hol_datatype(c_count)   := p_hol_datatype;
    l_tab_hol_mixed_case(c_count) := p_hol_mixed_case;
    l_tab_hov_value(c_count)      := p_hov_value;
    --
  END add;
  --
BEGIN
  --
  add(p_hol_id         => 'INSP_INIT'
     ,p_hol_product    => nm3type.c_mai
     ,p_hol_name       => 'Dflt Insp Initiation Type'
     ,p_hol_remarks    => 'Initiation Type Used When Creating A Default Inspection Record.'
     ,p_hol_domain     => 'INITIATION_TYPE'
     ,p_hol_datatype   => nm3type.c_varchar
     ,p_hol_mixed_case => 'N'
     ,p_hov_value      => 'DUM');
  --
  add(p_hol_id         => 'INSP_SDF'
     ,p_hol_product    => nm3type.c_mai
     ,p_hol_name       => 'Dflt Insp Safety Detailed Flag'
     ,p_hol_remarks    => 'Safety/Detailed Flag Used When Creating A Default Inspection Record.'
     ,p_hol_domain     => 'MAINT_INSP_FLAG'
     ,p_hol_datatype   => nm3type.c_varchar
     ,p_hol_mixed_case => 'N'
     ,p_hov_value      => 'D');
  --
  add(p_hol_id         => 'DEF_SISS'
     ,p_hol_product    => nm3type.c_mai
     ,p_hol_name       => 'Default SISS'
     ,p_hol_remarks    => 'Default SISS Used When Creating A Defect.'
     ,p_hol_domain     => ''
     ,p_hol_datatype   => nm3type.c_varchar
     ,p_hol_mixed_case => 'N'
     ,p_hov_value      => 'ALL');
  --
  add(p_hol_id         => 'DEFSCHTYPU'
     ,p_hol_product    => nm3type.c_mai
     ,p_hol_name       => 'Default Scheme Type Updateable'
     ,p_hol_remarks    => 'Defaulted Scheme Type On Works Order Updateable(Y/N)'
     ,p_hol_domain     => 'Y_OR_N'
     ,p_hol_datatype   => nm3type.c_varchar
     ,p_hol_mixed_case => 'N'
     ,p_hov_value      => 'Y');
  --
  FORALL i IN 1..l_tab_hol_id.COUNT
    INSERT
      INTO hig_option_list
          (hol_id
          ,hol_product
          ,hol_name
          ,hol_remarks
          ,hol_domain
          ,hol_datatype
          ,hol_mixed_case)
    SELECT l_tab_hol_id(i)
          ,l_tab_hol_product(i)
          ,l_tab_hol_name(i)
          ,l_tab_hol_remarks(i)
          ,l_tab_hol_domain(i)
          ,l_tab_hol_datatype(i)
          ,l_tab_hol_mixed_case(i)
      FROM dual
     WHERE NOT EXISTS(SELECT 1
                        FROM hig_option_list
                       WHERE hol_id = l_tab_hol_id(i))
         ;
  --
  FORALL i IN 1..l_tab_hol_id.COUNT
    INSERT
      INTO hig_option_values
          (hov_id
          ,hov_value)
    SELECT l_tab_hol_id(i)
          ,l_tab_hov_value(i)
      FROM dual
     WHERE l_tab_hov_value(i) IS NOT NULL
       AND NOT EXISTS(SELECT 1
                        FROM hig_option_values
                       WHERE hov_id = l_tab_hol_id(i))
         ;
  --
END;
/

--------------------------------------------------------------------------------------
--User Options.
--------------------------------------------------------------------------------------
DECLARE
  --
  -- HIG_CODES
  --
  l_tab_hco_domain        nm3type.tab_varchar30;
  l_tab_hco_code          nm3type.tab_varchar30;
  l_tab_hco_meaning       nm3type.tab_varchar80;
  l_tab_hco_system        nm3type.tab_VARCHAR1;
  l_tab_hco_seq           nm3type.tab_NUMBER;
  l_tab_hco_start_date    nm3type.tab_date;
  l_tab_hco_end_date      nm3type.tab_date;
  --
  PROCEDURE add(p_hco_domain       VARCHAR2
               ,p_hco_code         VARCHAR2
               ,p_hco_meaning      VARCHAR2
               ,p_hco_system       VARCHAR2
               ,p_hco_seq          NUMBER
               ,p_hco_start_date   date
               ,p_hco_end_date     date) IS
    --
    c_count PLS_INTEGER := l_tab_hco_domain.COUNT+1;
    --
  BEGIN
    --
    l_tab_hco_domain(c_count)         :=  p_hco_domain;
    l_tab_hco_code(c_count)           :=  p_hco_code;
    l_tab_hco_meaning(c_count)        :=  p_hco_meaning;
    l_tab_hco_system(c_count)         :=  p_hco_system;
    l_tab_hco_seq(c_count)            :=  p_hco_seq;
    l_tab_hco_start_date(c_count)     :=  p_hco_start_date;
    l_tab_hco_end_date(c_count)       :=  p_hco_end_date;
    --
  END add;
  --
BEGIN
  --
  add(p_hco_domain      => 'USER_OPTIONS'
     ,p_hco_code        => 'DEFSCHTYPD'
     ,p_hco_meaning     => 'Default scheme type for DoT'
     ,p_hco_system      => 'Y'
     ,p_hco_seq         => 99
     ,p_hco_start_date  => NULL
     ,p_hco_end_date    => NULL
     );
  --
  add(p_hco_domain      => 'USER_OPTIONS'
     ,p_hco_code        => 'DEFSCHTYPL'
     ,p_hco_meaning     => 'Default scheme type for Local'
     ,p_hco_system      => 'Y'
     ,p_hco_seq         => 99
     ,p_hco_start_date  => NULL
     ,p_hco_end_date    => NULL
     );
  --
  add(p_hco_domain      => 'USER_OPTIONS'
     ,p_hco_code        => 'DEFSCHTYPU'
     ,p_hco_meaning     => 'Defaulted Scheme Type On Works Order Updateable(Y/N)'
     ,p_hco_system      => 'Y'
     ,p_hco_seq         => 99
     ,p_hco_start_date  => NULL
     ,p_hco_end_date    => NULL
     );
  --
  FORALL i IN 1..l_tab_hco_domain.COUNT
    INSERT INTO hig_codes
          (hco_domain
          ,hco_code
          ,hco_meaning
          ,hco_system
          ,hco_seq
          ,hco_start_date
         ,hco_end_date)
    SELECT l_tab_hco_domain(i)
          ,l_tab_hco_code(i)
          ,l_tab_hco_meaning(i)
          ,l_tab_hco_system(i)
          ,l_tab_hco_seq(i)
          ,l_tab_hco_start_date(i)
          ,l_tab_hco_end_date(i)
      FROM dual
     WHERE NOT EXISTS(SELECT 1
                        FROM hig_codes
                       WHERE hco_domain = l_tab_hco_domain(i)
                         AND hco_code = l_tab_hco_code(i));
  --
END;
/

--------------------------------------------------------------------------------------
--Errors.
--------------------------------------------------------------------------------------
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
  --
  -- NET errors
  --
  l_current_type := 'MAI';
  --
  add_ner(901,'Asset Matches More Than One Budget Allocation Criteria. Please Consult Your exor Systems Administrator');
  add_ner(902,'Budget Allocation does not exist - Please consult your exor Systems Administrator.');
  add_ner(903,'Please Select Assets Of A Single Type');
  add_ner(904,'Cannot Find Interval For Priority/Repair Category');
  add_ner(905,'Cannot Find Interval For Road');
  add_ner(906,'Cannot Find Due Date From Interval');
  add_ner(907,'Auto Defect Priority : Please check your rules - no priority exists');
  --
  FORALL i IN 1..l_tab_ner_id.COUNT
    INSERT INTO nm_errors
          (ner_appl
          ,ner_id
          ,ner_descr)
    SELECT l_tab_appl(i)
          ,l_tab_ner_id(i)
          ,l_tab_ner_descr(i)
      FROM dual
     WHERE NOT EXISTS(SELECT 1
                        FROM nm_errors
                       WHERE ner_id   = l_tab_ner_id(i)
                         AND ner_appl = l_tab_appl(i))
       AND l_tab_ner_descr(i) IS NOT NULL;
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
DELETE FROM hig_hd_mod_uses
WHERE HHU_HHM_MODULE = 'MAI2530_A';
--
DELETE FROM hig_hd_mod_uses
WHERE HHU_HHM_MODULE = 'MAI2530';
--
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'BOQ_ITEMS', 7, 'boq', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 6.4, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 6.3, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 6.2, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 6, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 5, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 4, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 3, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 2, 'def', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530_A', 'DEFECTS', 1, 'def', NULL, 'def_rse_he_id IN (SELECT rtg_tag_id FROM  report_tags  WHERE rtg_job_id = :extent) AND def_status_code = ''AVAILABLE''', 'N', NULL, NULL);
--
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530', 'nm_elements', 4, 'ne', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530', 'nm_elements', 3, 'ne', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530', 'nm_elements', 2, 'ne', 1, NULL, 'N', NULL, NULL);
INSERT INTO HIG_HD_MOD_USES ( HHU_HHM_MODULE, HHU_TABLE_NAME, HHU_SEQ, HHU_ALIAS, HHU_PARENT_SEQ,
HHU_FIXED_WHERE_CLAUSE, HHU_LOAD_DATA, HHU_HINT_TEXT, HHU_TAG ) VALUES (
'MAI2530', 'nm_elements', 1, 'ne', NULL, 'ne_id IN (SELECT rtg_tag_id FROM  report_tags WHERE rtg_job_id = :extent )AND   ne_nt_type  = ''HERM''', 'N', NULL, NULL);
--
--  HIG_HD_JOIN_DEFS
--
 DELETE FROM HIG_HD_JOIN_DEFS
 WHERE HHT_HHU_HHM_MODULE = 'MAI2530_A';
--
 DELETE FROM HIG_HD_JOIN_DEFS
 WHERE HHT_HHU_HHM_MODULE = 'MAI2530';
--
 INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 6.4, 'TABLE', 'to line 6 (def_types)');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 6.3, 'TABLE', 'to line 6 (def_types)');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 6.2, 'TABLE', 'to line 6 (def_types)');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 4, 'TABLE', 'to line 4');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 3, 'TABLE', 'to line 3');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 2, 'TABLE', 'to line 2');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 7, 'TABLE', 'to line 7 (boq_items)');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 5, 'TABLE', 'to line 5');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530_A', 1, 6, 'TABLE', 'to line 6 (def_types)');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530', 1, 2, 'TABLE', 'join to line 3');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530', 1, 1, 'TABLE', 'join to line 2');
INSERT INTO HIG_HD_JOIN_DEFS ( HHT_HHU_HHM_MODULE, HHT_HHU_SEQ, HHT_JOIN_SEQ, HHT_TYPE,
HHT_DESCRIPTION ) VALUES (
'MAI2530', 1, 3, 'TABLE', 'join to line 4');
--
--  HIG_HD_LOOKUP_JOIN_DEFS
--
 DELETE FROM HIG_HD_LOOKUP_JOIN_DEFS
 WHERE HHL_HHU_HHM_MODULE = 'MAI2530_A';
--
 DELETE FROM HIG_HD_LOOKUP_JOIN_DEFS
 WHERE HHL_HHU_HHM_MODULE = 'MAI2530';
--
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS ( HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ, HHL_TABLE_NAME,
HHL_ALIAS, HHL_OUTER_JOIN, HHL_FIXED_WHERE_CLAUSE ) VALUES (
'MAI2530_A', 6.4, 1, 'def_types', 'dty', 'N', 'dty_hh_attribute_4 IS NOT NULL');
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS ( HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ, HHL_TABLE_NAME,
HHL_ALIAS, HHL_OUTER_JOIN, HHL_FIXED_WHERE_CLAUSE ) VALUES (
'MAI2530_A', 6.3, 1, 'def_types', 'dty', 'N', 'dty_hh_attribute_3 IS NOT NULL');
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS ( HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ, HHL_TABLE_NAME,
HHL_ALIAS, HHL_OUTER_JOIN, HHL_FIXED_WHERE_CLAUSE ) VALUES (
'MAI2530_A', 6.2, 1, 'def_types', 'dty', 'N', 'dty_hh_attribute_2 IS NOT NULL');
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS ( HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ, HHL_TABLE_NAME,
HHL_ALIAS, HHL_OUTER_JOIN, HHL_FIXED_WHERE_CLAUSE ) VALUES (
'MAI2530_A', 6, 1, 'def_types', 'dty', 'N', 'dty_hh_attribute_1 IS NOT NULL');
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS ( HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ, HHL_TABLE_NAME,
HHL_ALIAS, HHL_OUTER_JOIN, HHL_FIXED_WHERE_CLAUSE ) VALUES (
'MAI2530_A', 5, 2, 'treatments', 'tre', 'N', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS ( HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ, HHL_TABLE_NAME,
HHL_ALIAS, HHL_OUTER_JOIN, HHL_FIXED_WHERE_CLAUSE ) VALUES (
'MAI2530_A', 5, 1, 'repairs', 'rep', 'N', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_DEFS ( HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ, HHL_TABLE_NAME,
HHL_ALIAS, HHL_OUTER_JOIN, HHL_FIXED_WHERE_CLAUSE ) VALUES (
'MAI2530_A', 1, 1, 'nm_elements', 'ne', 'N', 'ne_nt_type = ''HERM''');
--  HIG_HD_LOOKUP_JOIN_COLS
--
 DELETE FROM HIG_HD_LOOKUP_JOIN_COLS
 WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530_A';
--
 DELETE FROM HIG_HD_LOOKUP_JOIN_COLS
 WHERE HHO_HHL_HHU_HHM_MODULE = 'MAI2530';
--
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.4, 1, 'def_ity_sys_flag', 'dty_dtp_flag', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.4, 1, 'def_defect_code', 'dty_defect_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.4, 1, 'def_atv_acty_area_code', 'dty_atv_acty_area_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.3, 1, 'def_ity_sys_flag', 'dty_dtp_flag', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.3, 1, 'def_defect_code', 'dty_defect_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.3, 1, 'def_atv_acty_area_code', 'dty_atv_acty_area_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.2, 1, 'def_ity_sys_flag', 'dty_dtp_flag', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.2, 1, 'def_defect_code', 'dty_defect_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6.2, 1, 'def_atv_acty_area_code', 'dty_atv_acty_area_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6, 1, 'def_ity_sys_flag', 'dty_dtp_flag', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6, 1, 'def_defect_code', 'dty_defect_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 6, 1, 'def_atv_acty_area_code', 'dty_atv_acty_area_code', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 5, 2, 'rep_tre_treat_code', 'tre_treat_code', 1);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 5, 1, 'def_defect_id', 'rep_def_defect_id', NULL);
INSERT INTO HIG_HD_LOOKUP_JOIN_COLS ( HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_SEQ,
HHO_PARENT_COL, HHO_LOOKUP_COL, HHO_HHL_JOIN_TO_LOOKUP ) VALUES (
'MAI2530_A', 1, 1, 'def_rse_he_id', 'ne_id', NULL);
--
--  HIG_HD_SELECTED_COLS
--
 DELETE FROM HIG_HD_SELECTED_COLS
 WHERE HHC_HHU_HHM_MODULE = 'MAI2530_A';
--
 DELETE FROM HIG_HD_SELECTED_COLS
 WHERE HHC_HHU_HHM_MODULE = 'MAI2530';
--
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 1, 1, '1', 'N', 'Y', 'line1', '''"1''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 1, 2, 'ne_unique', 'N', 'Y', 'ne_unique', 'ne_unique||''"''', NULL, NULL
, 1, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 2, 21, '2', 'N', 'Y', 'line2', '''"2''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 2, 22, 'def_defect_id', 'N', 'Y', 'def_defect_id', NULL, NULL, 1, NULL
, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 2, 23, 'def_atv_acty_area_code', 'N', 'Y', 'def_atv_acty_area_code', NULL
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 2, 24, 'def_defect_code', 'N', 'Y', 'def_defect_code', NULL, NULL, NULL
, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 2, 25, 'def_priority', 'N', 'Y', 'def_priority', NULL, NULL, NULL, NULL
, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 2, 26, 'on_works_order', 'N', 'Y', 'on_wo', 'decode(def_works_order_no, NULL, ''N'', ''Y'')'
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 2, 27, 'def_works_order_no', 'N', 'Y', 'def_works_order_no', 'def_works_order_no||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 3, 31, '3', 'N', 'Y', 'line3', '''"3''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 3, 32, 'def_locn_descr', 'N', 'Y', 'def_locn_descr', NULL, NULL, NULL
, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 3, 33, 'def_st_chain', 'N', 'Y', 'def_st_chain', NULL, NULL, NULL, NULL
, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 3, 34, 'def_x_sect', 'N', 'Y', 'def_x_sect', NULL, NULL, NULL, NULL, 'N'
, NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 3, 35, 'NULL', 'N', 'Y', NULL, 'NULL||''"''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 4, 41, '''"4''', 'N', 'Y', 'line4', '''"4''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 4, 42, 'def_defect_descr', 'N', 'Y', 'def_defect_descr', 'def_defect_descr||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 5, 1, '5', 'N', 'Y', 'line5', '''"5''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 5, 2, 'rep_tre_treat_code', 'N', 'Y', 'rep_tre_treat_code', NULL, NULL
, NULL, 1, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 5, 3, 'tre_descr', 'N', 'Y', 'tre_descr', NULL, NULL, NULL, 2, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 5, 4, 'def_update_inv', 'N', 'Y', 'def_update_inv', 'def_update_inv||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6, 1, '6', 'N', 'Y', 'line6', '''"6''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6, 2, '1', 'N', 'Y', NULL, 'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_1)||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6.2, 1, '6', 'N', 'Y', 'line6', '''"6''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6.2, 2, '2', 'N', 'Y', NULL, 'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_2)||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6.3, 1, '6', 'N', 'Y', 'line6', '''"6''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6.3, 2, '3', 'N', 'Y', NULL, 'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_3)||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6.4, 1, '6', 'N', 'Y', 'line6', '''"6''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 6.4, 2, '4', 'N', 'Y', NULL, 'mai_gmis_util.get_def_attribute(def_defect_id, dty.dty_hh_attribute_4)||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 7, 1, '1', 'N', 'Y', 'line7', '''"7''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 7, 2, 'boq_sta_item_code', 'N', 'Y', 'boq_sta_item_code', NULL, NULL
, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530_A', 7, 3, 'boq_est_quantitiy', 'N', 'Y', 'boq_est_quantitiy', 'boq_est_quantity||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 1, 1, '1', 'N', 'Y', 'rec1', '''"1''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 1, 2, 'ne_unique', 'N', 'Y', 'ne_unique', NULL, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 1, 3, '''NRM''', 'N', 'Y', 'insp', '''NRM''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 1, 4, 'any_defects', 'N', 'Y', 'any_defects', 'mai_gmis_util.defects_exist_on_section (ne_id)'
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 1, 5, 'ne_length', 'N', 'Y', 'ne_length', 'to_char(nm3net.get_ne_length(ne_id), ''99999.999'')||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 2, 20, '2', 'N', 'Y', 'rec', '''"2''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 2, 21, 'ne_descr', 'N', 'Y', 'road_name', 'rtrim(ne_name_1)', NULL, NULL
, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 2, 22, 'null', 'N', 'Y', NULL, 'null||''"''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 3, 30, '3', 'N', 'Y', 'rec3', '''"3''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 3, 31, 'section_desc', 'N', 'Y', 'section_desc', 'rtrim(ne_descr)||''"'''
, NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 4, 40, '4', 'N', 'Y', 'rec4', '''"4''', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 4, 41, 'NULL', 'N', 'Y', NULL, 'NULL', NULL, NULL, NULL, 'N', NULL);
INSERT INTO HIG_HD_SELECTED_COLS ( HHC_HHU_HHM_MODULE, HHC_HHU_SEQ, HHC_COLUMN_SEQ, HHC_COLUMN_NAME,
HHC_SUMMARY_VIEW, HHC_DISPLAYED, HHC_ALIAS, HHC_FUNCTION, HHC_ORDER_BY_SEQ,
HHC_UNIQUE_IDENTIFIER_SEQ, HHC_HHL_JOIN_SEQ, HHC_CALC_RATIO,
HHC_FORMAT ) VALUES (
'MAI2530', 4, 42, 'sysdate', 'N', 'Y', 'download_date', 'TO_CHAR(sysdate, ''YYMMDD'')||''"'''
, NULL, NULL, NULL, 'N', NULL);
--
-- HIG_HD_TABLE_JOIN_COLS
--
 DELETE FROM HIG_HD_TABLE_JOIN_COLS
 WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530_A';
--
 DELETE FROM HIG_HD_TABLE_JOIN_COLS
 WHERE HHJ_HHT_HHU_HHM_MODULE = 'MAI2530';
--
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530', 1, 1, 'ROWID', 2, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530', 1, 2, 'ROWID', 3, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530', 1, 3, 'ROWID', 4, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 2, 'ROWID', 2, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 3, 'ROWID', 3, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 4, 'ROWID', 4, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 5, 'ROWID', 5, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 6, 'ROWID', 6, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 6.2, 'ROWID', 6.2, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 6.3, 'ROWID', 6.3, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 6.4, 'ROWID', 6.4, 'ROWID');
INSERT INTO HIG_HD_TABLE_JOIN_COLS ( HHJ_HHT_HHU_HHM_MODULE, HHJ_HHT_HHU_PARENT_TABLE,
HHJ_HHT_JOIN_SEQ, HHJ_PARENT_COL, HHJ_HHU_CHILD_TABLE, HHJ_CHILD_COL ) VALUES (
'MAI2530_A', 1, 7, 'DEF_DEFECT_ID', 7, 'BOQ_DEFECT_ID');

-------------------------------------------------
-- Sort out missing report parameter for MAI5075
-- FF 08/07/05
-------------------------------------------------
insert into gri_params
  ( GP_PARAM
  , GP_PARAM_TYPE
  , GP_TABLE
  , GP_COLUMN
  , GP_DESCR_COLUMN
  , GP_SHOWN_COLUMN
  , GP_SHOWN_TYPE
  , GP_DESCR_TYPE
  , GP_ORDER
  , GP_CASE
  , GP_GAZ_RESTRICTION
  )
  select 'ROAD_ID'
  ,      'NUMBER'
  ,      'ROAD_SEGMENTS_ALL'
  ,      'RSE_HE_ID'
  ,      'RSE_DESCR'
  ,      'RSE_UNIQUE'
  ,      'CHAR'
  ,      NULL
  ,      NULL
  ,      NULL
  ,      NULL
  from   dual
  where  not exists
  (
  select 1
  from   gri_params
  where  gp_param = 'ROAD_ID'
  )
/
insert into gri_module_params
  ( GMP_MODULE
  , GMP_PARAM
  , GMP_SEQ
  , GMP_PARAM_DESCR
  , GMP_MANDATORY
  , GMP_NO_ALLOWED
  , GMP_WHERE
  , GMP_TAG_RESTRICTION
  , GMP_TAG_WHERE
  , GMP_DEFAULT_TABLE
  , GMP_DEFAULT_COLUMN
  , GMP_DEFAULT_WHERE
  , GMP_VISIBLE
  , GMP_GAZETTEER
  , GMP_LOV
  , GMP_VAL_GLOBAL
  , GMP_WILDCARD
  , GMP_HINT_TEXT
  , GMP_ALLOW_PARTIAL
  , GMP_BASE_TABLE
  , GMP_BASE_TABLE_COLUMN
  , GMP_OPERATOR
  )
  select 'MAI5075'
  ,      'ROAD_ID'
  ,      2
  ,      'Road Part Id'
  ,      'Y'
  ,      1
  ,      'RSE_GTY_GROUP_TYPE=''RP'' AND RSE_END_DATE IS NULL'
  ,      'N'
  ,      null
  ,      null
  ,      null
  ,      null
  ,      'Y'
  ,      'N'
  ,      'Y'
  ,      null
  ,      'N'
  ,      null
  ,      'N'
  ,      null
  ,      null
  ,      null
  from   dual
  where not exists
  (
  select 1
  from  gri_module_params
  where gmp_module = 'MAI5075'
  and   GMP_PARAM = 'ROAD_ID'
  )
/



---------------------------------------------------------------------------------------------------
-- Metadata change for Defect and PEM creation
---------------------------------------------------------------------------------------------------
DECLARE

   CURSOR cur1 IS
   SELECT da.*,iit_start_Date FROM DOC_ASSOCS da
   ,NM_INV_ITEMS_ALL
   WHERE das_table_name IN ( 'INV_ITEMS_ALL'
                            ,'INV_ITEMS'
                            ,'INV_ON_ROADS'
                            ,'NM_INV_ITEMS'
                            ,'NM_INV_ITEMS_ALL')
    AND iit_ne_id=das_rec_id;


   CURSOR cur2 IS
   SELECT * FROM doc_gate_syns
   WHERE dgs_table_syn IN ('INV_ITEMS_ALL'
                          ,'INV_ITEMS'
                          ,'INV_ON_ROADS'
                          ,'NM_INV_ITEMS'
                          ,'NM_INV_ITEMS_ALL');


   l_tab_dgs_dgt_table_name  nm3type.tab_varchar2000;
   l_tab_dgs_table_syn       nm3type.tab_varchar2000;


   PROCEDURE add_row (p_dgs_dgt_table_name VARCHAR2
                     ,p_dgs_table_syn      VARCHAR2
                     ) IS

      c_count CONSTANT pls_integer := l_tab_dgs_dgt_table_name.COUNT+1;

   BEGIN

      l_tab_dgs_dgt_table_name(c_count)    := p_dgs_dgt_table_name;
      l_tab_dgs_table_syn  (c_count)       := p_dgs_dgt_table_name;

   END add_row;


BEGIN


   -- NEED  doc_gateways to have nm_inv_items_all as the gateway

   INSERT INTO doc_gateways
   (
    DGT_TABLE_NAME
   ,DGT_TABLE_DESCR
   ,DGT_PK_COL_NAME
   ,DGT_LOV_DESCR_LIST
   ,DGT_LOV_FROM_LIST
   )
    SELECT
    'NM_INV_ITEMS_ALL'
   ,'Asset items all'
   ,'IIT_NE_ID'
   ,'IIT_INV_TYPE||'||''''||'-'||''''||'||DECODE(IIT_X_SECT,Null,Null,IIT_X_SECT||'||''''||'-'||''''||')||IIT_PRIMARY_KEY'
   ,'NM_INV_ITEMS'
    FROM dual
    WHERE NOT EXISTS (SELECT 1 FROM doc_gateways
                      WHERE dgt_table_name = 'NM_INV_ITEMS_ALL');


  -- need to update doc_gate_syns so that they point to the correct gateway
  -- First need to update any effected doc_assocs records

  FOR rec1 IN cur1 LOOP
   
     Nm3user.set_effective_date(rec1.iit_start_date);
     UPDATE doc_assocs
     SET das_table_name = 'NM_INV_ITEMS_ALL'
     WHERE das_table_name = rec1.das_table_name
     AND   das_rec_id     = rec1.das_rec_id
     AND   das_doc_id     = rec1.das_doc_id;


  END LOOP;

  
 Nm3user.set_effective_date(trunc(sysdate));


  -- Now need to update the doc_gate_syns table so that they point to the correct gateway

  FOR rec2 IN cur2 LOOP                             -- update any existing ones

     UPDATE doc_gate_syns
     SET dgs_dgt_table_name = 'NM_INV_ITEMS_ALL'
     WHERE dgs_table_syn = rec2.dgs_table_syn;

  END LOOP;


   add_row( 'NM_INV_ITEMS_ALL', 'INV_ITEMS_ALL' );
   add_row( 'NM_INV_ITEMS_ALL', 'INV_ITEMS' );
   add_row( 'NM_INV_ITEMS_ALL', 'INV_ON_ROADS');
   add_row( 'NM_INV_ITEMS_ALL', 'NM_INV_ITEMS');

   FORALL i IN 1..l_tab_dgs_dgt_table_name.COUNT          -- create any that do not exist
      INSERT INTO doc_gate_syns
      (
       dgs_dgt_table_name
      ,dgs_table_syn
      )
      SELECT l_tab_dgs_dgt_table_name(i)
            ,l_tab_dgs_table_syn(i)
      FROM  dual
      WHERE  NOT EXISTS (SELECT 1
                          FROM  doc_gate_syns
                          WHERE  dgs_dgt_table_name   = l_tab_dgs_dgt_table_name(i)
                          AND    dgs_table_syn        = l_tab_dgs_table_syn(i)
                        );

END;
/

COMMIT;
--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

