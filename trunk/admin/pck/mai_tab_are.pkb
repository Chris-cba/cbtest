CREATE OR REPLACE PACKAGE BODY mai_tab_are IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_tab_are.pkb-arc   2.2   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_tab_are.pkb  $
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
--   nm3get_gen header : @(#)mai_tab_are.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_are.pkb	1.1 03/09/04
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
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_are';
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
--   Function to get using ARE_INDEX_P1 index
--
FUNCTION get (pi_are_report_id     activities_report.are_report_id%TYPE
             ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
             ) RETURN activities_report%ROWTYPE IS
--
   CURSOR cs_are IS
   SELECT *
    FROM  activities_report
   WHERE  are_report_id = pi_are_report_id;
--
   l_found  BOOLEAN;
   l_retval activities_report%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_are;
   FETCH cs_are INTO l_retval;
   l_found := cs_are%FOUND;
   CLOSE cs_are;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'activities_report (ARE_INDEX_P1)'
                                              ||CHR(10)||'are_report_id => '||pi_are_report_id
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
PROCEDURE ins (p_rec_are IN OUT activities_report%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO activities_report
            (are_report_id
            ,are_rse_he_id
            ,are_batch_id
            ,are_created_date
            ,are_last_updated_date
            ,are_maint_insp_flag
            ,are_sched_act_flag
            ,are_date_work_done
            ,are_end_chain
            ,are_initiation_type
            ,are_insp_load_date
            ,are_peo_person_id_actioned
            ,are_peo_person_id_insp2
            ,are_st_chain
            ,are_surface_condition
            ,are_weather_condition
            ,are_wol_works_order_no
            )
     VALUES (p_rec_are.are_report_id
            ,p_rec_are.are_rse_he_id
            ,p_rec_are.are_batch_id
            ,p_rec_are.are_created_date
            ,p_rec_are.are_last_updated_date
            ,p_rec_are.are_maint_insp_flag
            ,p_rec_are.are_sched_act_flag
            ,p_rec_are.are_date_work_done
            ,p_rec_are.are_end_chain
            ,p_rec_are.are_initiation_type
            ,p_rec_are.are_insp_load_date
            ,p_rec_are.are_peo_person_id_actioned
            ,p_rec_are.are_peo_person_id_insp2
            ,p_rec_are.are_st_chain
            ,p_rec_are.are_surface_condition
            ,p_rec_are.are_weather_condition
            ,p_rec_are.are_wol_works_order_no
            )
   RETURNING are_report_id
            ,are_rse_he_id
            ,are_batch_id
            ,are_created_date
            ,are_last_updated_date
            ,are_maint_insp_flag
            ,are_sched_act_flag
            ,are_date_work_done
            ,are_end_chain
            ,are_initiation_type
            ,are_insp_load_date
            ,are_peo_person_id_actioned
            ,are_peo_person_id_insp2
            ,are_st_chain
            ,are_surface_condition
            ,are_weather_condition
            ,are_wol_works_order_no
      INTO   p_rec_are.are_report_id
            ,p_rec_are.are_rse_he_id
            ,p_rec_are.are_batch_id
            ,p_rec_are.are_created_date
            ,p_rec_are.are_last_updated_date
            ,p_rec_are.are_maint_insp_flag
            ,p_rec_are.are_sched_act_flag
            ,p_rec_are.are_date_work_done
            ,p_rec_are.are_end_chain
            ,p_rec_are.are_initiation_type
            ,p_rec_are.are_insp_load_date
            ,p_rec_are.are_peo_person_id_actioned
            ,p_rec_are.are_peo_person_id_insp2
            ,p_rec_are.are_st_chain
            ,p_rec_are.are_surface_condition
            ,p_rec_are.are_weather_condition
            ,p_rec_are.are_wol_works_order_no;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using ARE_INDEX_P1 index
--
FUNCTION lock_gen (pi_are_report_id     activities_report.are_report_id%TYPE
                  ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_are IS
   SELECT ROWID
    FROM  activities_report
   WHERE  are_report_id = pi_are_report_id
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
   OPEN  cs_are;
   FETCH cs_are INTO l_retval;
   l_found := cs_are%FOUND;
   CLOSE cs_are;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'activities_report (ARE_INDEX_P1)'
                                              ||CHR(10)||'are_report_id => '||pi_are_report_id
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
                    ,pi_supplementary_info => 'activities_report (ARE_INDEX_P1)'
                                              ||CHR(10)||'are_report_id => '||pi_are_report_id
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using ARE_INDEX_P1 index
--
PROCEDURE lock_gen (pi_are_report_id     activities_report.are_report_id%TYPE
                   ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
                   ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
                   ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
                   ) IS
--
   l_rowid ROWID;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'lock_gen');
--
   l_rowid := lock_gen
                   (pi_are_report_id     => pi_are_report_id
                   ,pi_raise_not_found   => pi_raise_not_found
                   ,pi_not_found_sqlcode => pi_not_found_sqlcode
                   );
--
   nm_debug.proc_end(g_package_name,'lock_gen');
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to del using ARE_INDEX_P1 index
--
PROCEDURE del (pi_are_report_id     activities_report.are_report_id%TYPE
              ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
              ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
              ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
              ) IS
   l_rowid ROWID;
BEGIN
--
   nm_debug.proc_start(g_package_name,'del');
--
   -- Lock the row first
   l_rowid := lock_gen
                   (pi_are_report_id     => pi_are_report_id
                   ,pi_raise_not_found   => pi_raise_not_found
                   ,pi_not_found_sqlcode => pi_not_found_sqlcode
                   ,pi_locked_sqlcode    => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE activities_report
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_are activities_report%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('are_report_id              : '||pi_rec_are.are_report_id,p_level);
   nm_debug.debug('are_rse_he_id              : '||pi_rec_are.are_rse_he_id,p_level);
   nm_debug.debug('are_batch_id               : '||pi_rec_are.are_batch_id,p_level);
   nm_debug.debug('are_created_date           : '||pi_rec_are.are_created_date,p_level);
   nm_debug.debug('are_last_updated_date      : '||pi_rec_are.are_last_updated_date,p_level);
   nm_debug.debug('are_maint_insp_flag        : '||pi_rec_are.are_maint_insp_flag,p_level);
   nm_debug.debug('are_sched_act_flag         : '||pi_rec_are.are_sched_act_flag,p_level);
   nm_debug.debug('are_date_work_done         : '||pi_rec_are.are_date_work_done,p_level);
   nm_debug.debug('are_end_chain              : '||pi_rec_are.are_end_chain,p_level);
   nm_debug.debug('are_initiation_type        : '||pi_rec_are.are_initiation_type,p_level);
   nm_debug.debug('are_insp_load_date         : '||pi_rec_are.are_insp_load_date,p_level);
   nm_debug.debug('are_peo_person_id_actioned : '||pi_rec_are.are_peo_person_id_actioned,p_level);
   nm_debug.debug('are_peo_person_id_insp2    : '||pi_rec_are.are_peo_person_id_insp2,p_level);
   nm_debug.debug('are_st_chain               : '||pi_rec_are.are_st_chain,p_level);
   nm_debug.debug('are_surface_condition      : '||pi_rec_are.are_surface_condition,p_level);
   nm_debug.debug('are_weather_condition      : '||pi_rec_are.are_weather_condition,p_level);
   nm_debug.debug('are_wol_works_order_no     : '||pi_rec_are.are_wol_works_order_no,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
FUNCTION next_are_batch_id_seq RETURN PLS_INTEGER IS
-- Get ARE_BATCH_ID_SEQ.NEXTVAL
   l_retval PLS_INTEGER;
BEGIN
   SELECT ARE_BATCH_ID_SEQ.NEXTVAL
    INTO  l_retval
    FROM  dual;
   RETURN l_retval;
END next_are_batch_id_seq;
--
-----------------------------------------------------------------------------
--
FUNCTION curr_are_batch_id_seq RETURN PLS_INTEGER IS
-- Get ARE_BATCH_ID_SEQ.CURRVAL
   l_retval PLS_INTEGER;
BEGIN
   SELECT ARE_BATCH_ID_SEQ.CURRVAL
    INTO  l_retval
    FROM  dual;
   RETURN l_retval;
END curr_are_batch_id_seq;
--
-----------------------------------------------------------------------------
--
FUNCTION next_are_report_id_seq RETURN PLS_INTEGER IS
-- Get ARE_REPORT_ID_SEQ.NEXTVAL
   l_retval PLS_INTEGER;
BEGIN
   SELECT ARE_REPORT_ID_SEQ.NEXTVAL
    INTO  l_retval
    FROM  dual;
   RETURN l_retval;
END next_are_report_id_seq;
--
-----------------------------------------------------------------------------
--
FUNCTION curr_are_report_id_seq RETURN PLS_INTEGER IS
-- Get ARE_REPORT_ID_SEQ.CURRVAL
   l_retval PLS_INTEGER;
BEGIN
   SELECT ARE_REPORT_ID_SEQ.CURRVAL
    INTO  l_retval
    FROM  dual;
   RETURN l_retval;
END curr_are_report_id_seq;
--
-----------------------------------------------------------------------------
--
END mai_tab_are;
/
