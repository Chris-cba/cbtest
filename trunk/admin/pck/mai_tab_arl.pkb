CREATE OR REPLACE PACKAGE BODY mai_tab_arl IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_tab_arl.pkb-arc   2.2   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_tab_arl.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:30  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:54:14  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_arl.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_arl.pkb	1.1 03/09/04
--
-----------------------------------------------------------------------------
--
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
--
-----------------------------------------------------------------------------
--
   g_body_sccsid CONSTANT  VARCHAR2(2000) := '"$Revision:   2.2  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_arl';
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
--   Function to get using ARL_INDEX_P1 index
--
FUNCTION get (pi_arl_are_report_id      act_report_lines.arl_are_report_id%TYPE
             ,pi_arl_atv_acty_area_code act_report_lines.arl_atv_acty_area_code%TYPE
             ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
             ) RETURN act_report_lines%ROWTYPE IS
--
   CURSOR cs_arl IS
   SELECT *
    FROM  act_report_lines
   WHERE  arl_are_report_id      = pi_arl_are_report_id
    AND   arl_atv_acty_area_code = pi_arl_atv_acty_area_code;
--
   l_found  BOOLEAN;
   l_retval act_report_lines%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_arl;
   FETCH cs_arl INTO l_retval;
   l_found := cs_arl%FOUND;
   CLOSE cs_arl;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'act_report_lines (ARL_INDEX_P1)'
                                              ||CHR(10)||'arl_are_report_id      => '||pi_arl_are_report_id
                                              ||CHR(10)||'arl_atv_acty_area_code => '||pi_arl_atv_acty_area_code
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
PROCEDURE ins (p_rec_arl IN OUT act_report_lines%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO act_report_lines
            (arl_act_status
            ,arl_are_report_id
            ,arl_atv_acty_area_code
            ,arl_created_date
            ,arl_last_updated_date
            ,arl_not_seq_flag
            ,arl_report_id_part_of
            )
     VALUES (p_rec_arl.arl_act_status
            ,p_rec_arl.arl_are_report_id
            ,p_rec_arl.arl_atv_acty_area_code
            ,p_rec_arl.arl_created_date
            ,p_rec_arl.arl_last_updated_date
            ,p_rec_arl.arl_not_seq_flag
            ,p_rec_arl.arl_report_id_part_of
            )
   RETURNING arl_act_status
            ,arl_are_report_id
            ,arl_atv_acty_area_code
            ,arl_created_date
            ,arl_last_updated_date
            ,arl_not_seq_flag
            ,arl_report_id_part_of
      INTO   p_rec_arl.arl_act_status
            ,p_rec_arl.arl_are_report_id
            ,p_rec_arl.arl_atv_acty_area_code
            ,p_rec_arl.arl_created_date
            ,p_rec_arl.arl_last_updated_date
            ,p_rec_arl.arl_not_seq_flag
            ,p_rec_arl.arl_report_id_part_of;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using ARL_INDEX_P1 index
--
FUNCTION lock_gen (pi_arl_are_report_id      act_report_lines.arl_are_report_id%TYPE
                  ,pi_arl_atv_acty_area_code act_report_lines.arl_atv_acty_area_code%TYPE
                  ,pi_raise_not_found        BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode      PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode         PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_arl IS
   SELECT ROWID
    FROM  act_report_lines
   WHERE  arl_are_report_id      = pi_arl_are_report_id
    AND   arl_atv_acty_area_code = pi_arl_atv_acty_area_code
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
   OPEN  cs_arl;
   FETCH cs_arl INTO l_retval;
   l_found := cs_arl%FOUND;
   CLOSE cs_arl;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'act_report_lines (ARL_INDEX_P1)'
                                              ||CHR(10)||'arl_are_report_id      => '||pi_arl_are_report_id
                                              ||CHR(10)||'arl_atv_acty_area_code => '||pi_arl_atv_acty_area_code
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
                    ,pi_supplementary_info => 'act_report_lines (ARL_INDEX_P1)'
                                              ||CHR(10)||'arl_are_report_id      => '||pi_arl_are_report_id
                                              ||CHR(10)||'arl_atv_acty_area_code => '||pi_arl_atv_acty_area_code
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using ARL_INDEX_P1 index
--
PROCEDURE lock_gen (pi_arl_are_report_id      act_report_lines.arl_are_report_id%TYPE
                   ,pi_arl_atv_acty_area_code act_report_lines.arl_atv_acty_area_code%TYPE
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
                   (pi_arl_are_report_id      => pi_arl_are_report_id
                   ,pi_arl_atv_acty_area_code => pi_arl_atv_acty_area_code
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
--   Procedure to del using ARL_INDEX_P1 index
--
PROCEDURE del (pi_arl_are_report_id      act_report_lines.arl_are_report_id%TYPE
              ,pi_arl_atv_acty_area_code act_report_lines.arl_atv_acty_area_code%TYPE
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
                   (pi_arl_are_report_id      => pi_arl_are_report_id
                   ,pi_arl_atv_acty_area_code => pi_arl_atv_acty_area_code
                   ,pi_raise_not_found        => pi_raise_not_found
                   ,pi_not_found_sqlcode      => pi_not_found_sqlcode
                   ,pi_locked_sqlcode         => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE act_report_lines
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_arl act_report_lines%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('arl_act_status         : '||pi_rec_arl.arl_act_status,p_level);
   nm_debug.debug('arl_are_report_id      : '||pi_rec_arl.arl_are_report_id,p_level);
   nm_debug.debug('arl_atv_acty_area_code : '||pi_rec_arl.arl_atv_acty_area_code,p_level);
   nm_debug.debug('arl_created_date       : '||pi_rec_arl.arl_created_date,p_level);
   nm_debug.debug('arl_last_updated_date  : '||pi_rec_arl.arl_last_updated_date,p_level);
   nm_debug.debug('arl_not_seq_flag       : '||pi_rec_arl.arl_not_seq_flag,p_level);
   nm_debug.debug('arl_report_id_part_of  : '||pi_rec_arl.arl_report_id_part_of,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_arl;
/
