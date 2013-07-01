CREATE OR REPLACE PACKAGE BODY mai_tab_dty IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_tab_dty.pkb-arc   2.1   Jul 01 2013 16:26:00   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_tab_dty.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:26:00  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:46  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_dty.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_dty.pkb	1.1 03/09/04
--
-----------------------------------------------------------------------------
--
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
--
-----------------------------------------------------------------------------
--
   g_body_sccsid CONSTANT  VARCHAR2(2000) := '"$Revision:   2.1  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_dty';
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
--
--   Function to get using DTY_INDEX_P1 index
--
FUNCTION get (pi_dty_defect_code        def_types.dty_defect_code%TYPE
             ,pi_dty_atv_acty_area_code def_types.dty_atv_acty_area_code%TYPE
             ,pi_dty_dtp_flag           def_types.dty_dtp_flag%TYPE
             ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
             ) RETURN def_types%ROWTYPE IS
--
   CURSOR cs_dty IS
   SELECT *
    FROM  def_types
   WHERE  dty_defect_code        = pi_dty_defect_code
    AND   dty_atv_acty_area_code = pi_dty_atv_acty_area_code
    AND   dty_dtp_flag           = pi_dty_dtp_flag;
--
   l_found  BOOLEAN;
   l_retval def_types%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_dty;
   FETCH cs_dty INTO l_retval;
   l_found := cs_dty%FOUND;
   CLOSE cs_dty;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'def_types (DTY_INDEX_P1)'
                                              ||CHR(10)||'dty_defect_code        => '||pi_dty_defect_code
                                              ||CHR(10)||'dty_atv_acty_area_code => '||pi_dty_atv_acty_area_code
                                              ||CHR(10)||'dty_dtp_flag           => '||pi_dty_dtp_flag
                    );
   END IF;
--
   nm_debug.proc_end(g_package_name,'get');
--
   RETURN l_retval;
--
END get;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins (p_rec_dty IN OUT def_types%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO def_types
            (dty_atv_acty_area_code
            ,dty_defect_code
            ,dty_dtp_flag
            ,dty_descr1
            ,dty_descr2
            ,dty_hh_attribute_1
            ,dty_hh_attribute_2
            ,dty_hh_attri_text_1
            ,dty_hh_attri_text_2
            ,dty_start_date
            ,dty_end_date
            ,dty_hh_attribute_3
            ,dty_hh_attribute_4
            ,dty_hh_attri_text_3
            ,dty_hh_attri_text_4
            )
     VALUES (p_rec_dty.dty_atv_acty_area_code
            ,p_rec_dty.dty_defect_code
            ,p_rec_dty.dty_dtp_flag
            ,p_rec_dty.dty_descr1
            ,p_rec_dty.dty_descr2
            ,p_rec_dty.dty_hh_attribute_1
            ,p_rec_dty.dty_hh_attribute_2
            ,p_rec_dty.dty_hh_attri_text_1
            ,p_rec_dty.dty_hh_attri_text_2
            ,p_rec_dty.dty_start_date
            ,p_rec_dty.dty_end_date
            ,p_rec_dty.dty_hh_attribute_3
            ,p_rec_dty.dty_hh_attribute_4
            ,p_rec_dty.dty_hh_attri_text_3
            ,p_rec_dty.dty_hh_attri_text_4
            )
   RETURNING dty_atv_acty_area_code
            ,dty_defect_code
            ,dty_dtp_flag
            ,dty_descr1
            ,dty_descr2
            ,dty_hh_attribute_1
            ,dty_hh_attribute_2
            ,dty_hh_attri_text_1
            ,dty_hh_attri_text_2
            ,dty_start_date
            ,dty_end_date
            ,dty_hh_attribute_3
            ,dty_hh_attribute_4
            ,dty_hh_attri_text_3
            ,dty_hh_attri_text_4
      INTO   p_rec_dty.dty_atv_acty_area_code
            ,p_rec_dty.dty_defect_code
            ,p_rec_dty.dty_dtp_flag
            ,p_rec_dty.dty_descr1
            ,p_rec_dty.dty_descr2
            ,p_rec_dty.dty_hh_attribute_1
            ,p_rec_dty.dty_hh_attribute_2
            ,p_rec_dty.dty_hh_attri_text_1
            ,p_rec_dty.dty_hh_attri_text_2
            ,p_rec_dty.dty_start_date
            ,p_rec_dty.dty_end_date
            ,p_rec_dty.dty_hh_attribute_3
            ,p_rec_dty.dty_hh_attribute_4
            ,p_rec_dty.dty_hh_attri_text_3
            ,p_rec_dty.dty_hh_attri_text_4;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using DTY_INDEX_P1 index
--
FUNCTION lock_gen (pi_dty_defect_code        def_types.dty_defect_code%TYPE
                  ,pi_dty_atv_acty_area_code def_types.dty_atv_acty_area_code%TYPE
                  ,pi_dty_dtp_flag           def_types.dty_dtp_flag%TYPE
                  ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode         PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_dty IS
   SELECT ROWID
    FROM  def_types
   WHERE  dty_defect_code        = pi_dty_defect_code
    AND   dty_atv_acty_area_code = pi_dty_atv_acty_area_code
    AND   dty_dtp_flag           = pi_dty_dtp_flag
   FOR UPDATE NOWAIT;
--
   l_found         BOOLEAN;
   l_retval        ROWID;
   l_record_locked EXCEPTION;
   PRAGMA EXCEPTION_INIT (l_record_locked,-54);
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'lock_gen');
--
   OPEN  cs_dty;
   FETCH cs_dty INTO l_retval;
   l_found := cs_dty%FOUND;
   CLOSE cs_dty;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'def_types (DTY_INDEX_P1)'
                                              ||CHR(10)||'dty_defect_code        => '||pi_dty_defect_code
                                              ||CHR(10)||'dty_atv_acty_area_code => '||pi_dty_atv_acty_area_code
                                              ||CHR(10)||'dty_dtp_flag           => '||pi_dty_dtp_flag
                    );
   END IF;
--
   nm_debug.proc_end(g_package_name,'lock_gen');
--
   RETURN l_retval;
--
EXCEPTION
--
   WHEN l_record_locked
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 33
                    ,pi_sqlcode            => pi_locked_sqlcode
                    ,pi_supplementary_info => 'def_types (DTY_INDEX_P1)'
                                              ||CHR(10)||'dty_defect_code        => '||pi_dty_defect_code
                                              ||CHR(10)||'dty_atv_acty_area_code => '||pi_dty_atv_acty_area_code
                                              ||CHR(10)||'dty_dtp_flag           => '||pi_dty_dtp_flag
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using DTY_INDEX_P1 index
--
PROCEDURE lock_gen (pi_dty_defect_code        def_types.dty_defect_code%TYPE
                   ,pi_dty_atv_acty_area_code def_types.dty_atv_acty_area_code%TYPE
                   ,pi_dty_dtp_flag           def_types.dty_dtp_flag%TYPE
                   ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
                   ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
                   ,pi_locked_sqlcode         PLS_INTEGER DEFAULT -20000
                   ) IS
--
   l_rowid ROWID;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'lock_gen');
--
   l_rowid := lock_gen
                   (pi_dty_defect_code        => pi_dty_defect_code
                   ,pi_dty_atv_acty_area_code => pi_dty_atv_acty_area_code
                   ,pi_dty_dtp_flag           => pi_dty_dtp_flag
                   ,pi_raise_not_found        => pi_raise_not_found
                   ,pi_not_found_sqlcode      => pi_not_found_sqlcode
                   );
--
   nm_debug.proc_end(g_package_name,'lock_gen');
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to del using DTY_INDEX_P1 index
--
PROCEDURE del (pi_dty_defect_code        def_types.dty_defect_code%TYPE
              ,pi_dty_atv_acty_area_code def_types.dty_atv_acty_area_code%TYPE
              ,pi_dty_dtp_flag           def_types.dty_dtp_flag%TYPE
              ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
              ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
              ,pi_locked_sqlcode         PLS_INTEGER DEFAULT -20000
              ) IS
   l_rowid ROWID;
BEGIN
--
   nm_debug.proc_start(g_package_name,'del');
--
   -- Lock the row first
   l_rowid := lock_gen
                   (pi_dty_defect_code        => pi_dty_defect_code
                   ,pi_dty_atv_acty_area_code => pi_dty_atv_acty_area_code
                   ,pi_dty_dtp_flag           => pi_dty_dtp_flag
                   ,pi_raise_not_found        => pi_raise_not_found
                   ,pi_not_found_sqlcode      => pi_not_found_sqlcode
                   ,pi_locked_sqlcode         => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE def_types
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_dty def_types%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('dty_atv_acty_area_code : '||pi_rec_dty.dty_atv_acty_area_code,p_level);
   nm_debug.debug('dty_defect_code        : '||pi_rec_dty.dty_defect_code,p_level);
   nm_debug.debug('dty_dtp_flag           : '||pi_rec_dty.dty_dtp_flag,p_level);
   nm_debug.debug('dty_descr1             : '||pi_rec_dty.dty_descr1,p_level);
   nm_debug.debug('dty_descr2             : '||pi_rec_dty.dty_descr2,p_level);
   nm_debug.debug('dty_hh_attribute_1     : '||pi_rec_dty.dty_hh_attribute_1,p_level);
   nm_debug.debug('dty_hh_attribute_2     : '||pi_rec_dty.dty_hh_attribute_2,p_level);
   nm_debug.debug('dty_hh_attri_text_1    : '||pi_rec_dty.dty_hh_attri_text_1,p_level);
   nm_debug.debug('dty_hh_attri_text_2    : '||pi_rec_dty.dty_hh_attri_text_2,p_level);
   nm_debug.debug('dty_start_date         : '||pi_rec_dty.dty_start_date,p_level);
   nm_debug.debug('dty_end_date           : '||pi_rec_dty.dty_end_date,p_level);
   nm_debug.debug('dty_hh_attribute_3     : '||pi_rec_dty.dty_hh_attribute_3,p_level);
   nm_debug.debug('dty_hh_attribute_4     : '||pi_rec_dty.dty_hh_attribute_4,p_level);
   nm_debug.debug('dty_hh_attri_text_3    : '||pi_rec_dty.dty_hh_attri_text_3,p_level);
   nm_debug.debug('dty_hh_attri_text_4    : '||pi_rec_dty.dty_hh_attri_text_4,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_dty;
/
