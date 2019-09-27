CREATE OR REPLACE PACKAGE BODY mai_tab_act IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_tab_act.pkb-arc   2.3   Sep 27 2019 14:39:54   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_tab_act.pkb  $
--       Date into SCCS   : $Date:   Sep 27 2019 14:39:54  $
--       Date fetched Out : $Modtime:   Sep 27 2019 14:15:46  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_act.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_act.pkb	1.1 03/09/04
--
-----------------------------------------------------------------------------
--
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
--
-----------------------------------------------------------------------------
--
   g_body_sccsid CONSTANT  VARCHAR2(2000) := '"$Revision:   2.3  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_act';
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
--   Function to get using ATV_INDEX_P1 index
--
FUNCTION get (pi_atv_acty_area_code activities.atv_acty_area_code%TYPE
             ,pi_atv_dtp_flag       activities.atv_dtp_flag%TYPE
             ,pi_raise_not_found    BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode  PLS_INTEGER DEFAULT -20000
             ) RETURN activities%ROWTYPE IS
--
   CURSOR cs_act IS
   SELECT *
    FROM  activities
   WHERE  atv_acty_area_code = pi_atv_acty_area_code
    AND   atv_dtp_flag       = pi_atv_dtp_flag;
--
   l_found  BOOLEAN;
   l_retval activities%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_act;
   FETCH cs_act INTO l_retval;
   l_found := cs_act%FOUND;
   CLOSE cs_act;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'activities (ATV_INDEX_P1)'
                                              ||CHR(10)||'atv_acty_area_code => '||pi_atv_acty_area_code
                                              ||CHR(10)||'atv_dtp_flag       => '||pi_atv_dtp_flag
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
PROCEDURE ins (p_rec_act IN OUT activities%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO activities
            (atv_acty_area_code
            ,atv_dtp_flag
            ,atv_if_scheduled_flag
            ,atv_maint_insp_flag
            ,atv_sequence_no
            ,atv_specialist_flag
            ,atv_calc_type
            ,atv_cat1p_int_code
            ,atv_cat1t_int_code
            ,atv_cat2_1p_int_code
            ,atv_cat2_2p_int_code
            ,atv_cat2_3p_int_code
            ,atv_descr
            ,atv_dtp_exp_code
            ,atv_la_exp_code
            ,atv_maint_cost
            ,atv_seasonal_flag
            ,atv_unit
            ,atv_start_date
            ,atv_end_date
            ,atv_activity_duration
            )
     VALUES (p_rec_act.atv_acty_area_code
            ,p_rec_act.atv_dtp_flag
            ,p_rec_act.atv_if_scheduled_flag
            ,p_rec_act.atv_maint_insp_flag
            ,p_rec_act.atv_sequence_no
            ,p_rec_act.atv_specialist_flag
            ,p_rec_act.atv_calc_type
            ,p_rec_act.atv_cat1p_int_code
            ,p_rec_act.atv_cat1t_int_code
            ,p_rec_act.atv_cat2_1p_int_code
            ,p_rec_act.atv_cat2_2p_int_code
            ,p_rec_act.atv_cat2_3p_int_code
            ,p_rec_act.atv_descr
            ,p_rec_act.atv_dtp_exp_code
            ,p_rec_act.atv_la_exp_code
            ,p_rec_act.atv_maint_cost
            ,p_rec_act.atv_seasonal_flag
            ,p_rec_act.atv_unit
            ,p_rec_act.atv_start_date
            ,p_rec_act.atv_end_date
            ,p_rec_act.atv_activity_duration
            )
   RETURNING atv_acty_area_code
            ,atv_dtp_flag
            ,atv_if_scheduled_flag
            ,atv_maint_insp_flag
            ,atv_sequence_no
            ,atv_specialist_flag
            ,atv_calc_type
            ,atv_cat1p_int_code
            ,atv_cat1t_int_code
            ,atv_cat2_1p_int_code
            ,atv_cat2_2p_int_code
            ,atv_cat2_3p_int_code
            ,atv_descr
            ,atv_dtp_exp_code
            ,atv_la_exp_code
            ,atv_maint_cost
            ,atv_seasonal_flag
            ,atv_unit
            ,atv_start_date
            ,atv_end_date
            ,atv_activity_duration
      INTO   p_rec_act.atv_acty_area_code
            ,p_rec_act.atv_dtp_flag
            ,p_rec_act.atv_if_scheduled_flag
            ,p_rec_act.atv_maint_insp_flag
            ,p_rec_act.atv_sequence_no
            ,p_rec_act.atv_specialist_flag
            ,p_rec_act.atv_calc_type
            ,p_rec_act.atv_cat1p_int_code
            ,p_rec_act.atv_cat1t_int_code
            ,p_rec_act.atv_cat2_1p_int_code
            ,p_rec_act.atv_cat2_2p_int_code
            ,p_rec_act.atv_cat2_3p_int_code
            ,p_rec_act.atv_descr
            ,p_rec_act.atv_dtp_exp_code
            ,p_rec_act.atv_la_exp_code
            ,p_rec_act.atv_maint_cost
            ,p_rec_act.atv_seasonal_flag
            ,p_rec_act.atv_unit
            ,p_rec_act.atv_start_date
            ,p_rec_act.atv_end_date
            ,p_rec_act.atv_activity_duration;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using ATV_INDEX_P1 index
--
FUNCTION lock_gen (pi_atv_acty_area_code activities.atv_acty_area_code%TYPE
                  ,pi_atv_dtp_flag       activities.atv_dtp_flag%TYPE
                  ,pi_raise_not_found    BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode  PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode     PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_act IS
   SELECT ROWID
    FROM  activities
   WHERE  atv_acty_area_code = pi_atv_acty_area_code
    AND   atv_dtp_flag       = pi_atv_dtp_flag
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
   OPEN  cs_act;
   FETCH cs_act INTO l_retval;
   l_found := cs_act%FOUND;
   CLOSE cs_act;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'activities (ATV_INDEX_P1)'
                                              ||CHR(10)||'atv_acty_area_code => '||pi_atv_acty_area_code
                                              ||CHR(10)||'atv_dtp_flag       => '||pi_atv_dtp_flag
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
                    ,pi_supplementary_info => 'activities (ATV_INDEX_P1)'
                                              ||CHR(10)||'atv_acty_area_code => '||pi_atv_acty_area_code
                                              ||CHR(10)||'atv_dtp_flag       => '||pi_atv_dtp_flag
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using ATV_INDEX_P1 index
--
PROCEDURE lock_gen (pi_atv_acty_area_code activities.atv_acty_area_code%TYPE
                   ,pi_atv_dtp_flag       activities.atv_dtp_flag%TYPE
                   ,pi_raise_not_found    BOOLEAN     DEFAULT TRUE
                   ,pi_not_found_sqlcode  PLS_INTEGER DEFAULT -20000
                   ,pi_locked_sqlcode     PLS_INTEGER DEFAULT -20000
                   ) IS
--
   l_rowid ROWID;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'lock_gen');
--
   l_rowid := lock_gen
                   (pi_atv_acty_area_code => pi_atv_acty_area_code
                   ,pi_atv_dtp_flag       => pi_atv_dtp_flag
                   ,pi_raise_not_found    => pi_raise_not_found
                   ,pi_not_found_sqlcode  => pi_not_found_sqlcode
                   );
--
   nm_debug.proc_end(g_package_name,'lock_gen');
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to del using ATV_INDEX_P1 index
--
PROCEDURE del (pi_atv_acty_area_code activities.atv_acty_area_code%TYPE
              ,pi_atv_dtp_flag       activities.atv_dtp_flag%TYPE
              ,pi_raise_not_found    BOOLEAN     DEFAULT TRUE
              ,pi_not_found_sqlcode  PLS_INTEGER DEFAULT -20000
              ,pi_locked_sqlcode     PLS_INTEGER DEFAULT -20000
              ) IS
   l_rowid ROWID;
BEGIN
--
   nm_debug.proc_start(g_package_name,'del');
--
   -- Lock the row first
   l_rowid := lock_gen
                   (pi_atv_acty_area_code => pi_atv_acty_area_code
                   ,pi_atv_dtp_flag       => pi_atv_dtp_flag
                   ,pi_raise_not_found    => pi_raise_not_found
                   ,pi_not_found_sqlcode  => pi_not_found_sqlcode
                   ,pi_locked_sqlcode     => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE activities
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_act activities%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('atv_acty_area_code    : '||pi_rec_act.atv_acty_area_code,p_level);
   nm_debug.debug('atv_dtp_flag          : '||pi_rec_act.atv_dtp_flag,p_level);
   nm_debug.debug('atv_if_scheduled_flag : '||pi_rec_act.atv_if_scheduled_flag,p_level);
   nm_debug.debug('atv_maint_insp_flag   : '||pi_rec_act.atv_maint_insp_flag,p_level);
   nm_debug.debug('atv_sequence_no       : '||pi_rec_act.atv_sequence_no,p_level);
   nm_debug.debug('atv_specialist_flag   : '||pi_rec_act.atv_specialist_flag,p_level);
   nm_debug.debug('atv_calc_type         : '||pi_rec_act.atv_calc_type,p_level);
   nm_debug.debug('atv_cat1p_int_code    : '||pi_rec_act.atv_cat1p_int_code,p_level);
   nm_debug.debug('atv_cat1t_int_code    : '||pi_rec_act.atv_cat1t_int_code,p_level);
   nm_debug.debug('atv_cat2_1p_int_code  : '||pi_rec_act.atv_cat2_1p_int_code,p_level);
   nm_debug.debug('atv_cat2_2p_int_code  : '||pi_rec_act.atv_cat2_2p_int_code,p_level);
   nm_debug.debug('atv_cat2_3p_int_code  : '||pi_rec_act.atv_cat2_3p_int_code,p_level);
   nm_debug.debug('atv_descr             : '||pi_rec_act.atv_descr,p_level);
   nm_debug.debug('atv_dtp_exp_code      : '||pi_rec_act.atv_dtp_exp_code,p_level);
   nm_debug.debug('atv_la_exp_code       : '||pi_rec_act.atv_la_exp_code,p_level);
   nm_debug.debug('atv_maint_cost        : '||pi_rec_act.atv_maint_cost,p_level);
   nm_debug.debug('atv_seasonal_flag     : '||pi_rec_act.atv_seasonal_flag,p_level);
   nm_debug.debug('atv_unit              : '||pi_rec_act.atv_unit,p_level);
   nm_debug.debug('atv_start_date        : '||pi_rec_act.atv_start_date,p_level);
   nm_debug.debug('atv_end_date          : '||pi_rec_act.atv_end_date,p_level);
   nm_debug.debug('atv_activity_duration : '||pi_rec_act.atv_activity_duration,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_act;
/
