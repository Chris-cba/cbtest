CREATE OR REPLACE PACKAGE BODY mai_tab_tre IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_tab_tre.pkb-arc   2.3   Sep 27 2019 14:39:56   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_tab_tre.pkb  $
--       Date into SCCS   : $Date:   Sep 27 2019 14:39:56  $
--       Date fetched Out : $Modtime:   Sep 27 2019 14:22:10  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_tre.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_tre.pkb	1.1 03/09/04
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
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_tre';
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
--   Function to get using TRE_INDEX_P1 index
--
FUNCTION get (pi_tre_treat_code    treatments.tre_treat_code%TYPE
             ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
             ) RETURN treatments%ROWTYPE IS
--
   CURSOR cs_tre IS
   SELECT *
    FROM  treatments
   WHERE  tre_treat_code = pi_tre_treat_code;
--
   l_found  BOOLEAN;
   l_retval treatments%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_tre;
   FETCH cs_tre INTO l_retval;
   l_found := cs_tre%FOUND;
   CLOSE cs_tre;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'treatments (TRE_INDEX_P1)'
                                              ||CHR(10)||'tre_treat_code => '||pi_tre_treat_code
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
PROCEDURE ins (p_rec_tre IN OUT treatments%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO treatments
            (tre_treat_code
            ,tre_descr
            ,tre_dtp_exp_code
            ,tre_la_exp_code
            ,tre_sequence_no
            ,tre_start_date
            ,tre_end_date
            )
     VALUES (p_rec_tre.tre_treat_code
            ,p_rec_tre.tre_descr
            ,p_rec_tre.tre_dtp_exp_code
            ,p_rec_tre.tre_la_exp_code
            ,p_rec_tre.tre_sequence_no
            ,p_rec_tre.tre_start_date
            ,p_rec_tre.tre_end_date
            )
   RETURNING tre_treat_code
            ,tre_descr
            ,tre_dtp_exp_code
            ,tre_la_exp_code
            ,tre_sequence_no
            ,tre_start_date
            ,tre_end_date
      INTO   p_rec_tre.tre_treat_code
            ,p_rec_tre.tre_descr
            ,p_rec_tre.tre_dtp_exp_code
            ,p_rec_tre.tre_la_exp_code
            ,p_rec_tre.tre_sequence_no
            ,p_rec_tre.tre_start_date
            ,p_rec_tre.tre_end_date;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using TRE_INDEX_P1 index
--
FUNCTION lock_gen (pi_tre_treat_code    treatments.tre_treat_code%TYPE
                  ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_tre IS
   SELECT ROWID
    FROM  treatments
   WHERE  tre_treat_code = pi_tre_treat_code
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
   OPEN  cs_tre;
   FETCH cs_tre INTO l_retval;
   l_found := cs_tre%FOUND;
   CLOSE cs_tre;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'treatments (TRE_INDEX_P1)'
                                              ||CHR(10)||'tre_treat_code => '||pi_tre_treat_code
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
                    ,pi_supplementary_info => 'treatments (TRE_INDEX_P1)'
                                              ||CHR(10)||'tre_treat_code => '||pi_tre_treat_code
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using TRE_INDEX_P1 index
--
PROCEDURE lock_gen (pi_tre_treat_code    treatments.tre_treat_code%TYPE
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
                   (pi_tre_treat_code    => pi_tre_treat_code
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
--   Procedure to del using TRE_INDEX_P1 index
--
PROCEDURE del (pi_tre_treat_code    treatments.tre_treat_code%TYPE
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
                   (pi_tre_treat_code    => pi_tre_treat_code
                   ,pi_raise_not_found   => pi_raise_not_found
                   ,pi_not_found_sqlcode => pi_not_found_sqlcode
                   ,pi_locked_sqlcode    => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE treatments
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_tre treatments%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('tre_treat_code   : '||pi_rec_tre.tre_treat_code,p_level);
   nm_debug.debug('tre_descr        : '||pi_rec_tre.tre_descr,p_level);
   nm_debug.debug('tre_dtp_exp_code : '||pi_rec_tre.tre_dtp_exp_code,p_level);
   nm_debug.debug('tre_la_exp_code  : '||pi_rec_tre.tre_la_exp_code,p_level);
   nm_debug.debug('tre_sequence_no  : '||pi_rec_tre.tre_sequence_no,p_level);
   nm_debug.debug('tre_start_date   : '||pi_rec_tre.tre_start_date,p_level);
   nm_debug.debug('tre_end_date     : '||pi_rec_tre.tre_end_date,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_tre;
/
