CREATE OR REPLACE PACKAGE BODY mai_tab_dpr IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_tab_dpr.pkb-arc   2.0   Jun 13 2007 17:36:50   smarshall  $
--       Module Name      : $Workfile:   mai_tab_dpr.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:50  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_dpr.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_dpr.pkb	1.1 03/09/04
--
-----------------------------------------------------------------------------
--
--	Copyright (c) exor corporation ltd, 2004
--
-----------------------------------------------------------------------------
--
   g_body_sccsid CONSTANT  VARCHAR2(2000) := '"@$Revision:   2.0  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_dpr';
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
--   Function to get using DPR_INDEX_P1 index
--
FUNCTION get (pi_dpr_atv_acty_area_code defect_priorities.dpr_atv_acty_area_code%TYPE
             ,pi_dpr_priority           defect_priorities.dpr_priority%TYPE
             ,pi_dpr_action_cat         defect_priorities.dpr_action_cat%TYPE
             ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
             ) RETURN defect_priorities%ROWTYPE IS
--
   CURSOR cs_dpr IS
   SELECT *
    FROM  defect_priorities
   WHERE  dpr_atv_acty_area_code = pi_dpr_atv_acty_area_code
    AND   dpr_priority           = pi_dpr_priority
    AND   dpr_action_cat         = pi_dpr_action_cat;
--
   l_found  BOOLEAN;
   l_retval defect_priorities%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_dpr;
   FETCH cs_dpr INTO l_retval;
   l_found := cs_dpr%FOUND;
   CLOSE cs_dpr;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'defect_priorities (DPR_INDEX_P1)'
                                              ||CHR(10)||'dpr_atv_acty_area_code => '||pi_dpr_atv_acty_area_code
                                              ||CHR(10)||'dpr_priority           => '||pi_dpr_priority
                                              ||CHR(10)||'dpr_action_cat         => '||pi_dpr_action_cat
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
PROCEDURE ins (p_rec_dpr IN OUT defect_priorities%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO defect_priorities
            (dpr_atv_acty_area_code
            ,dpr_priority
            ,dpr_action_cat
            ,dpr_int_code
            ,dpr_use_working_days
            ,dpr_use_next_insp
            ,dpr_print_targets
            ,dpr_time_mandatory
            )
     VALUES (p_rec_dpr.dpr_atv_acty_area_code
            ,p_rec_dpr.dpr_priority
            ,p_rec_dpr.dpr_action_cat
            ,p_rec_dpr.dpr_int_code
            ,p_rec_dpr.dpr_use_working_days
            ,p_rec_dpr.dpr_use_next_insp
            ,p_rec_dpr.dpr_print_targets
            ,p_rec_dpr.dpr_time_mandatory
            )
   RETURNING dpr_atv_acty_area_code
            ,dpr_priority
            ,dpr_action_cat
            ,dpr_int_code
            ,dpr_use_working_days
            ,dpr_use_next_insp
            ,dpr_print_targets
            ,dpr_time_mandatory
      INTO   p_rec_dpr.dpr_atv_acty_area_code
            ,p_rec_dpr.dpr_priority
            ,p_rec_dpr.dpr_action_cat
            ,p_rec_dpr.dpr_int_code
            ,p_rec_dpr.dpr_use_working_days
            ,p_rec_dpr.dpr_use_next_insp
            ,p_rec_dpr.dpr_print_targets
            ,p_rec_dpr.dpr_time_mandatory;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using DPR_INDEX_P1 index
--
FUNCTION lock_gen (pi_dpr_atv_acty_area_code defect_priorities.dpr_atv_acty_area_code%TYPE
                  ,pi_dpr_priority           defect_priorities.dpr_priority%TYPE
                  ,pi_dpr_action_cat         defect_priorities.dpr_action_cat%TYPE
                  ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode         PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_dpr IS
   SELECT ROWID
    FROM  defect_priorities
   WHERE  dpr_atv_acty_area_code = pi_dpr_atv_acty_area_code
    AND   dpr_priority           = pi_dpr_priority
    AND   dpr_action_cat         = pi_dpr_action_cat
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
   OPEN  cs_dpr;
   FETCH cs_dpr INTO l_retval;
   l_found := cs_dpr%FOUND;
   CLOSE cs_dpr;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'defect_priorities (DPR_INDEX_P1)'
                                              ||CHR(10)||'dpr_atv_acty_area_code => '||pi_dpr_atv_acty_area_code
                                              ||CHR(10)||'dpr_priority           => '||pi_dpr_priority
                                              ||CHR(10)||'dpr_action_cat         => '||pi_dpr_action_cat
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
                    ,pi_supplementary_info => 'defect_priorities (DPR_INDEX_P1)'
                                              ||CHR(10)||'dpr_atv_acty_area_code => '||pi_dpr_atv_acty_area_code
                                              ||CHR(10)||'dpr_priority           => '||pi_dpr_priority
                                              ||CHR(10)||'dpr_action_cat         => '||pi_dpr_action_cat
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using DPR_INDEX_P1 index
--
PROCEDURE lock_gen (pi_dpr_atv_acty_area_code defect_priorities.dpr_atv_acty_area_code%TYPE
                   ,pi_dpr_priority           defect_priorities.dpr_priority%TYPE
                   ,pi_dpr_action_cat         defect_priorities.dpr_action_cat%TYPE
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
                   (pi_dpr_atv_acty_area_code => pi_dpr_atv_acty_area_code
                   ,pi_dpr_priority           => pi_dpr_priority
                   ,pi_dpr_action_cat         => pi_dpr_action_cat
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
--   Procedure to del using DPR_INDEX_P1 index
--
PROCEDURE del (pi_dpr_atv_acty_area_code defect_priorities.dpr_atv_acty_area_code%TYPE
              ,pi_dpr_priority           defect_priorities.dpr_priority%TYPE
              ,pi_dpr_action_cat         defect_priorities.dpr_action_cat%TYPE
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
                   (pi_dpr_atv_acty_area_code => pi_dpr_atv_acty_area_code
                   ,pi_dpr_priority           => pi_dpr_priority
                   ,pi_dpr_action_cat         => pi_dpr_action_cat
                   ,pi_raise_not_found        => pi_raise_not_found
                   ,pi_not_found_sqlcode      => pi_not_found_sqlcode
                   ,pi_locked_sqlcode         => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE defect_priorities
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_dpr defect_priorities%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('dpr_atv_acty_area_code : '||pi_rec_dpr.dpr_atv_acty_area_code,p_level);
   nm_debug.debug('dpr_priority           : '||pi_rec_dpr.dpr_priority,p_level);
   nm_debug.debug('dpr_action_cat         : '||pi_rec_dpr.dpr_action_cat,p_level);
   nm_debug.debug('dpr_int_code           : '||pi_rec_dpr.dpr_int_code,p_level);
   nm_debug.debug('dpr_use_working_days   : '||pi_rec_dpr.dpr_use_working_days,p_level);
   nm_debug.debug('dpr_use_next_insp      : '||pi_rec_dpr.dpr_use_next_insp,p_level);
   nm_debug.debug('dpr_print_targets      : '||pi_rec_dpr.dpr_print_targets,p_level);
   nm_debug.debug('dpr_time_mandatory     : '||pi_rec_dpr.dpr_time_mandatory,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_dpr;
/
