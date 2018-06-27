CREATE OR REPLACE PACKAGE BODY mai_tab_def IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_tab_def.pkb-arc   2.3   Jun 27 2018 13:06:32   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_tab_def.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:32  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:54:14  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_def.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_def.pkb	1.1 03/09/04
--
-----------------------------------------------------------------------------
--
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
--
-----------------------------------------------------------------------------
--
   g_body_sccsid CONSTANT  VARCHAR2(2000) := '"$Revision:   2.3  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_def';
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
--   Function to get using DEF_INDEX_P1 index
--
FUNCTION get (pi_def_defect_id     defects.def_defect_id%TYPE
             ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
             ) RETURN defects%ROWTYPE IS
--
   CURSOR cs_def IS
   SELECT *
    FROM  defects
   WHERE  def_defect_id = pi_def_defect_id;
--
   l_found  BOOLEAN;
   l_retval defects%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_def;
   FETCH cs_def INTO l_retval;
   l_found := cs_def%FOUND;
   CLOSE cs_def;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'defects (DEF_INDEX_P1)'
                                              ||CHR(10)||'def_defect_id => '||pi_def_defect_id
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
PROCEDURE ins (p_rec_def IN OUT defects%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO defects
            (def_defect_id
            ,def_rse_he_id
            ,def_st_chain
            ,def_are_report_id
            ,def_atv_acty_area_code
            ,def_siss_id
            ,def_works_order_no
            ,def_created_date
            ,def_defect_code
            ,def_last_updated_date
            ,def_orig_priority
            ,def_priority
            ,def_status_code
            ,def_superseded_flag
            ,def_area
            ,def_are_id_not_found
            ,def_coord_flag
            ,def_date_compl
            ,def_date_not_found
            ,def_defect_class
            ,def_defect_descr
            ,def_defect_type_descr
            ,def_diagram_no
            ,def_height
            ,def_ident_code
            ,def_ity_inv_code
            ,def_ity_sys_flag
            ,def_length
            ,def_locn_descr
            ,def_maint_wo
            ,def_mand_adv
            ,def_notify_org_id
            ,def_number
            ,def_per_cent
            ,def_per_cent_orig
            ,def_per_cent_rem
            ,def_rechar_org_id
            ,def_serial_no
            ,def_skid_coeff
            ,def_special_instr
            ,def_superseded_id
            ,def_time_hrs
            ,def_time_mins
            ,def_update_inv
            ,def_x_sect
            ,def_iit_item_id
            ,def_easting
            ,def_northing
            ,def_response_category
            ,def_status_reason
            ,def_inspection_date
            )
     VALUES (p_rec_def.def_defect_id
            ,p_rec_def.def_rse_he_id
            ,p_rec_def.def_st_chain
            ,p_rec_def.def_are_report_id
            ,p_rec_def.def_atv_acty_area_code
            ,p_rec_def.def_siss_id
            ,p_rec_def.def_works_order_no
            ,p_rec_def.def_created_date
            ,p_rec_def.def_defect_code
            ,p_rec_def.def_last_updated_date
            ,p_rec_def.def_orig_priority
            ,p_rec_def.def_priority
            ,p_rec_def.def_status_code
            ,p_rec_def.def_superseded_flag
            ,p_rec_def.def_area
            ,p_rec_def.def_are_id_not_found
            ,p_rec_def.def_coord_flag
            ,p_rec_def.def_date_compl
            ,p_rec_def.def_date_not_found
            ,p_rec_def.def_defect_class
            ,p_rec_def.def_defect_descr
            ,p_rec_def.def_defect_type_descr
            ,p_rec_def.def_diagram_no
            ,p_rec_def.def_height
            ,p_rec_def.def_ident_code
            ,p_rec_def.def_ity_inv_code
            ,p_rec_def.def_ity_sys_flag
            ,p_rec_def.def_length
            ,p_rec_def.def_locn_descr
            ,p_rec_def.def_maint_wo
            ,p_rec_def.def_mand_adv
            ,p_rec_def.def_notify_org_id
            ,p_rec_def.def_number
            ,p_rec_def.def_per_cent
            ,p_rec_def.def_per_cent_orig
            ,p_rec_def.def_per_cent_rem
            ,p_rec_def.def_rechar_org_id
            ,p_rec_def.def_serial_no
            ,p_rec_def.def_skid_coeff
            ,p_rec_def.def_special_instr
            ,p_rec_def.def_superseded_id
            ,p_rec_def.def_time_hrs
            ,p_rec_def.def_time_mins
            ,p_rec_def.def_update_inv
            ,p_rec_def.def_x_sect
            ,p_rec_def.def_iit_item_id
            ,p_rec_def.def_easting
            ,p_rec_def.def_northing
            ,p_rec_def.def_response_category
            ,p_rec_def.def_status_reason
            ,p_rec_def.def_inspection_date
            )
   RETURNING def_defect_id
            ,def_rse_he_id
            ,def_st_chain
            ,def_are_report_id
            ,def_atv_acty_area_code
            ,def_siss_id
            ,def_works_order_no
            ,def_created_date
            ,def_defect_code
            ,def_last_updated_date
            ,def_orig_priority
            ,def_priority
            ,def_status_code
            ,def_superseded_flag
            ,def_area
            ,def_are_id_not_found
            ,def_coord_flag
            ,def_date_compl
            ,def_date_not_found
            ,def_defect_class
            ,def_defect_descr
            ,def_defect_type_descr
            ,def_diagram_no
            ,def_height
            ,def_ident_code
            ,def_ity_inv_code
            ,def_ity_sys_flag
            ,def_length
            ,def_locn_descr
            ,def_maint_wo
            ,def_mand_adv
            ,def_notify_org_id
            ,def_number
            ,def_per_cent
            ,def_per_cent_orig
            ,def_per_cent_rem
            ,def_rechar_org_id
            ,def_serial_no
            ,def_skid_coeff
            ,def_special_instr
            ,def_superseded_id
            ,def_time_hrs
            ,def_time_mins
            ,def_update_inv
            ,def_x_sect
            ,def_iit_item_id
            ,def_easting
            ,def_northing
            ,def_response_category
            ,def_status_reason
            ,def_inspection_date
      INTO   p_rec_def.def_defect_id
            ,p_rec_def.def_rse_he_id
            ,p_rec_def.def_st_chain
            ,p_rec_def.def_are_report_id
            ,p_rec_def.def_atv_acty_area_code
            ,p_rec_def.def_siss_id
            ,p_rec_def.def_works_order_no
            ,p_rec_def.def_created_date
            ,p_rec_def.def_defect_code
            ,p_rec_def.def_last_updated_date
            ,p_rec_def.def_orig_priority
            ,p_rec_def.def_priority
            ,p_rec_def.def_status_code
            ,p_rec_def.def_superseded_flag
            ,p_rec_def.def_area
            ,p_rec_def.def_are_id_not_found
            ,p_rec_def.def_coord_flag
            ,p_rec_def.def_date_compl
            ,p_rec_def.def_date_not_found
            ,p_rec_def.def_defect_class
            ,p_rec_def.def_defect_descr
            ,p_rec_def.def_defect_type_descr
            ,p_rec_def.def_diagram_no
            ,p_rec_def.def_height
            ,p_rec_def.def_ident_code
            ,p_rec_def.def_ity_inv_code
            ,p_rec_def.def_ity_sys_flag
            ,p_rec_def.def_length
            ,p_rec_def.def_locn_descr
            ,p_rec_def.def_maint_wo
            ,p_rec_def.def_mand_adv
            ,p_rec_def.def_notify_org_id
            ,p_rec_def.def_number
            ,p_rec_def.def_per_cent
            ,p_rec_def.def_per_cent_orig
            ,p_rec_def.def_per_cent_rem
            ,p_rec_def.def_rechar_org_id
            ,p_rec_def.def_serial_no
            ,p_rec_def.def_skid_coeff
            ,p_rec_def.def_special_instr
            ,p_rec_def.def_superseded_id
            ,p_rec_def.def_time_hrs
            ,p_rec_def.def_time_mins
            ,p_rec_def.def_update_inv
            ,p_rec_def.def_x_sect
            ,p_rec_def.def_iit_item_id
            ,p_rec_def.def_easting
            ,p_rec_def.def_northing
            ,p_rec_def.def_response_category
            ,p_rec_def.def_status_reason
            ,p_rec_def.def_inspection_date
            ;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using DEF_INDEX_P1 index
--
FUNCTION lock_gen (pi_def_defect_id     defects.def_defect_id%TYPE
                  ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_def IS
   SELECT ROWID
    FROM  defects
   WHERE  def_defect_id = pi_def_defect_id
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
   OPEN  cs_def;
   FETCH cs_def INTO l_retval;
   l_found := cs_def%FOUND;
   CLOSE cs_def;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'defects (DEF_INDEX_P1)'
                                              ||CHR(10)||'def_defect_id => '||pi_def_defect_id
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
                    ,pi_supplementary_info => 'defects (DEF_INDEX_P1)'
                                              ||CHR(10)||'def_defect_id => '||pi_def_defect_id
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using DEF_INDEX_P1 index
--
PROCEDURE lock_gen (pi_def_defect_id     defects.def_defect_id%TYPE
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
                   (pi_def_defect_id     => pi_def_defect_id
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
--   Procedure to del using DEF_INDEX_P1 index
--
PROCEDURE del (pi_def_defect_id     defects.def_defect_id%TYPE
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
                   (pi_def_defect_id     => pi_def_defect_id
                   ,pi_raise_not_found   => pi_raise_not_found
                   ,pi_not_found_sqlcode => pi_not_found_sqlcode
                   ,pi_locked_sqlcode    => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE defects
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_def defects%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('def_defect_id          : '||pi_rec_def.def_defect_id,p_level);
   nm_debug.debug('def_rse_he_id          : '||pi_rec_def.def_rse_he_id,p_level);
   nm_debug.debug('def_st_chain           : '||pi_rec_def.def_st_chain,p_level);
   nm_debug.debug('def_are_report_id      : '||pi_rec_def.def_are_report_id,p_level);
   nm_debug.debug('def_atv_acty_area_code : '||pi_rec_def.def_atv_acty_area_code,p_level);
   nm_debug.debug('def_siss_id            : '||pi_rec_def.def_siss_id,p_level);
   nm_debug.debug('def_works_order_no     : '||pi_rec_def.def_works_order_no,p_level);
   nm_debug.debug('def_created_date       : '||pi_rec_def.def_created_date,p_level);
   nm_debug.debug('def_defect_code        : '||pi_rec_def.def_defect_code,p_level);
   nm_debug.debug('def_last_updated_date  : '||pi_rec_def.def_last_updated_date,p_level);
   nm_debug.debug('def_orig_priority      : '||pi_rec_def.def_orig_priority,p_level);
   nm_debug.debug('def_priority           : '||pi_rec_def.def_priority,p_level);
   nm_debug.debug('def_status_code        : '||pi_rec_def.def_status_code,p_level);
   nm_debug.debug('def_superseded_flag    : '||pi_rec_def.def_superseded_flag,p_level);
   nm_debug.debug('def_area               : '||pi_rec_def.def_area,p_level);
   nm_debug.debug('def_are_id_not_found   : '||pi_rec_def.def_are_id_not_found,p_level);
   nm_debug.debug('def_coord_flag         : '||pi_rec_def.def_coord_flag,p_level);
   nm_debug.debug('def_date_compl         : '||pi_rec_def.def_date_compl,p_level);
   nm_debug.debug('def_date_not_found     : '||pi_rec_def.def_date_not_found,p_level);
   nm_debug.debug('def_defect_class       : '||pi_rec_def.def_defect_class,p_level);
   nm_debug.debug('def_defect_descr       : '||pi_rec_def.def_defect_descr,p_level);
   nm_debug.debug('def_defect_type_descr  : '||pi_rec_def.def_defect_type_descr,p_level);
   nm_debug.debug('def_diagram_no         : '||pi_rec_def.def_diagram_no,p_level);
   nm_debug.debug('def_height             : '||pi_rec_def.def_height,p_level);
   nm_debug.debug('def_ident_code         : '||pi_rec_def.def_ident_code,p_level);
   nm_debug.debug('def_ity_inv_code       : '||pi_rec_def.def_ity_inv_code,p_level);
   nm_debug.debug('def_ity_sys_flag       : '||pi_rec_def.def_ity_sys_flag,p_level);
   nm_debug.debug('def_length             : '||pi_rec_def.def_length,p_level);
   nm_debug.debug('def_locn_descr         : '||pi_rec_def.def_locn_descr,p_level);
   nm_debug.debug('def_maint_wo           : '||pi_rec_def.def_maint_wo,p_level);
   nm_debug.debug('def_mand_adv           : '||pi_rec_def.def_mand_adv,p_level);
   nm_debug.debug('def_notify_org_id      : '||pi_rec_def.def_notify_org_id,p_level);
   nm_debug.debug('def_number             : '||pi_rec_def.def_number,p_level);
   nm_debug.debug('def_per_cent           : '||pi_rec_def.def_per_cent,p_level);
   nm_debug.debug('def_per_cent_orig      : '||pi_rec_def.def_per_cent_orig,p_level);
   nm_debug.debug('def_per_cent_rem       : '||pi_rec_def.def_per_cent_rem,p_level);
   nm_debug.debug('def_rechar_org_id      : '||pi_rec_def.def_rechar_org_id,p_level);
   nm_debug.debug('def_serial_no          : '||pi_rec_def.def_serial_no,p_level);
   nm_debug.debug('def_skid_coeff         : '||pi_rec_def.def_skid_coeff,p_level);
   nm_debug.debug('def_special_instr      : '||pi_rec_def.def_special_instr,p_level);
   nm_debug.debug('def_superseded_id      : '||pi_rec_def.def_superseded_id,p_level);
   nm_debug.debug('def_time_hrs           : '||pi_rec_def.def_time_hrs,p_level);
   nm_debug.debug('def_time_mins          : '||pi_rec_def.def_time_mins,p_level);
   nm_debug.debug('def_update_inv         : '||pi_rec_def.def_update_inv,p_level);
   nm_debug.debug('def_x_sect             : '||pi_rec_def.def_x_sect,p_level);
   nm_debug.debug('def_iit_item_id        : '||pi_rec_def.def_iit_item_id,p_level);
   nm_debug.debug('def_easting            : '||pi_rec_def.def_easting,p_level);
   nm_debug.debug('def_northing           : '||pi_rec_def.def_northing,p_level);
   nm_debug.debug('def_response_category  : '||pi_rec_def.def_response_category,p_level);
   nm_debug.debug('def_status_reason      : '||pi_rec_def.def_status_reason,p_level);
   nm_debug.debug('def_inspection_date    : '||pi_rec_def.def_inspection_date,p_level);

--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_def;
/
