CREATE OR REPLACE PACKAGE BODY mai_tab_glb IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_tab_glb.pkb-arc   2.2   Jun 27 2018 13:06:32   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_tab_glb.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:32  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:54:14  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_glb.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_glb.pkb	1.1 03/09/04
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
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_glb';
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
--   Function to get using GLB_PK constraint
--
FUNCTION get (pi_glb_load_batch    mai_gmis_load_batches.glb_load_batch%TYPE
             ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
             ) RETURN mai_gmis_load_batches%ROWTYPE IS
--
   CURSOR cs_glb IS
   SELECT *
    FROM  mai_gmis_load_batches
   WHERE  glb_load_batch = pi_glb_load_batch;
--
   l_found  BOOLEAN;
   l_retval mai_gmis_load_batches%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_glb;
   FETCH cs_glb INTO l_retval;
   l_found := cs_glb%FOUND;
   CLOSE cs_glb;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'mai_gmis_load_batches (GLB_PK)'
                                              ||CHR(10)||'glb_load_batch => '||pi_glb_load_batch
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
PROCEDURE ins (p_rec_glb IN OUT mai_gmis_load_batches%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
   p_rec_glb.glb_load_errors                := NVL(p_rec_glb.glb_load_errors,'Y');
--
   INSERT INTO mai_gmis_load_batches
            (glb_load_batch
            ,glb_line_number
            ,glb_load_file
            ,glb_load_errors
            ,glb_date_created
            ,glb_date_modified
            ,glb_created_by
            ,glb_modified_by
            ,glb_error_text
            ,glb_error_data
            )
     VALUES (p_rec_glb.glb_load_batch
            ,p_rec_glb.glb_line_number
            ,p_rec_glb.glb_load_file
            ,p_rec_glb.glb_load_errors
            ,p_rec_glb.glb_date_created
            ,p_rec_glb.glb_date_modified
            ,p_rec_glb.glb_created_by
            ,p_rec_glb.glb_modified_by
            ,p_rec_glb.glb_error_text
            ,p_rec_glb.glb_error_data
            )
   RETURNING glb_load_batch
            ,glb_line_number
            ,glb_load_errors
            ,glb_date_created
            ,glb_date_modified
            ,glb_created_by
            ,glb_modified_by
            ,glb_error_text
            ,glb_error_data
      INTO   p_rec_glb.glb_load_batch
            ,p_rec_glb.glb_line_number
            ,p_rec_glb.glb_load_errors
            ,p_rec_glb.glb_date_created
            ,p_rec_glb.glb_date_modified
            ,p_rec_glb.glb_created_by
            ,p_rec_glb.glb_modified_by
            ,p_rec_glb.glb_error_text
            ,p_rec_glb.glb_error_data;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using GLB_PK constraint
--
FUNCTION lock_gen (pi_glb_load_batch    mai_gmis_load_batches.glb_load_batch%TYPE
                  ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_glb IS
   SELECT ROWID
    FROM  mai_gmis_load_batches
   WHERE  glb_load_batch = pi_glb_load_batch
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
   OPEN  cs_glb;
   FETCH cs_glb INTO l_retval;
   l_found := cs_glb%FOUND;
   CLOSE cs_glb;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'mai_gmis_load_batches (GLB_PK)'
                                              ||CHR(10)||'glb_load_batch => '||pi_glb_load_batch
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
                    ,pi_supplementary_info => 'mai_gmis_load_batches (GLB_PK)'
                                              ||CHR(10)||'glb_load_batch => '||pi_glb_load_batch
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using GLB_PK constraint
--
PROCEDURE lock_gen (pi_glb_load_batch    mai_gmis_load_batches.glb_load_batch%TYPE
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
                   (pi_glb_load_batch    => pi_glb_load_batch
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
--   Procedure to del using GLB_PK constraint
--
PROCEDURE del (pi_glb_load_batch    mai_gmis_load_batches.glb_load_batch%TYPE
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
                   (pi_glb_load_batch    => pi_glb_load_batch
                   ,pi_raise_not_found   => pi_raise_not_found
                   ,pi_not_found_sqlcode => pi_not_found_sqlcode
                   ,pi_locked_sqlcode    => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE mai_gmis_load_batches
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_glb mai_gmis_load_batches%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('glb_load_batch    : '||pi_rec_glb.glb_load_batch,p_level);
   nm_debug.debug('glb_line_number   : '||pi_rec_glb.glb_line_number,p_level);
   nm_debug.debug('glb_load_errors   : '||pi_rec_glb.glb_load_errors,p_level);
   nm_debug.debug('glb_date_created  : '||pi_rec_glb.glb_date_created,p_level);
   nm_debug.debug('glb_date_modified : '||pi_rec_glb.glb_date_modified,p_level);
   nm_debug.debug('glb_created_by    : '||pi_rec_glb.glb_created_by,p_level);
   nm_debug.debug('glb_modified_by   : '||pi_rec_glb.glb_modified_by,p_level);
   nm_debug.debug('glb_error_text    : '||pi_rec_glb.glb_error_text,p_level);
   nm_debug.debug('glb_error_data    : '||pi_rec_glb.glb_error_data,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_glb;
/
