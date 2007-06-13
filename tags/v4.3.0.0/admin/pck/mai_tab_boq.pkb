CREATE OR REPLACE PACKAGE BODY mai_tab_boq IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_tab_boq.pkb-arc   2.0   Jun 13 2007 17:36:50   smarshall  $
--       Module Name      : $Workfile:   mai_tab_boq.pkb  $
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
--   nm3get_gen header : @(#)mai_tab_boq.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_boq.pkb	1.1 03/09/04
--
-----------------------------------------------------------------------------
--
--	Copyright (c) exor corporation ltd, 2004
--
-----------------------------------------------------------------------------
--
   g_body_sccsid CONSTANT  VARCHAR2(2000) := '"$Revision:   2.0  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_boq';
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
--   Function to get using BOQ_PK constraint
--
FUNCTION get (pi_boq_id            boq_items.boq_id%TYPE
             ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
             ) RETURN boq_items%ROWTYPE IS
--
   CURSOR cs_boq IS
   SELECT *
    FROM  boq_items
   WHERE  boq_id = pi_boq_id;
--
   l_found  BOOLEAN;
   l_retval boq_items%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_boq;
   FETCH cs_boq INTO l_retval;
   l_found := cs_boq%FOUND;
   CLOSE cs_boq;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'boq_items (BOQ_PK)'
                                              ||CHR(10)||'boq_id => '||pi_boq_id
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
PROCEDURE ins (p_rec_boq IN OUT boq_items%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO boq_items
            (boq_work_flag
            ,boq_defect_id
            ,boq_rep_action_cat
            ,boq_wol_id
            ,boq_sta_item_code
            ,boq_item_name
            ,boq_date_created
            ,boq_icb_work_code
            ,boq_est_dim1
            ,boq_est_dim2
            ,boq_est_dim3
            ,boq_est_quantity
            ,boq_est_rate
            ,boq_est_discount
            ,boq_est_cost
            ,boq_est_labour
            ,boq_act_dim1
            ,boq_act_dim2
            ,boq_act_dim3
            ,boq_act_quantity
            ,boq_act_cost
            ,boq_act_labour
            ,boq_act_rate
            ,boq_act_discount
            ,boq_id
            ,boq_parent_id
            )
     VALUES (p_rec_boq.boq_work_flag
            ,p_rec_boq.boq_defect_id
            ,p_rec_boq.boq_rep_action_cat
            ,p_rec_boq.boq_wol_id
            ,p_rec_boq.boq_sta_item_code
            ,p_rec_boq.boq_item_name
            ,p_rec_boq.boq_date_created
            ,p_rec_boq.boq_icb_work_code
            ,p_rec_boq.boq_est_dim1
            ,p_rec_boq.boq_est_dim2
            ,p_rec_boq.boq_est_dim3
            ,p_rec_boq.boq_est_quantity
            ,p_rec_boq.boq_est_rate
            ,p_rec_boq.boq_est_discount
            ,p_rec_boq.boq_est_cost
            ,p_rec_boq.boq_est_labour
            ,p_rec_boq.boq_act_dim1
            ,p_rec_boq.boq_act_dim2
            ,p_rec_boq.boq_act_dim3
            ,p_rec_boq.boq_act_quantity
            ,p_rec_boq.boq_act_cost
            ,p_rec_boq.boq_act_labour
            ,p_rec_boq.boq_act_rate
            ,p_rec_boq.boq_act_discount
            ,p_rec_boq.boq_id
            ,p_rec_boq.boq_parent_id
            )
   RETURNING boq_work_flag
            ,boq_defect_id
            ,boq_rep_action_cat
            ,boq_wol_id
            ,boq_sta_item_code
            ,boq_item_name
            ,boq_date_created
            ,boq_icb_work_code
            ,boq_est_dim1
            ,boq_est_dim2
            ,boq_est_dim3
            ,boq_est_quantity
            ,boq_est_rate
            ,boq_est_discount
            ,boq_est_cost
            ,boq_est_labour
            ,boq_act_dim1
            ,boq_act_dim2
            ,boq_act_dim3
            ,boq_act_quantity
            ,boq_act_cost
            ,boq_act_labour
            ,boq_act_rate
            ,boq_act_discount
            ,boq_id
            ,boq_parent_id
      INTO   p_rec_boq.boq_work_flag
            ,p_rec_boq.boq_defect_id
            ,p_rec_boq.boq_rep_action_cat
            ,p_rec_boq.boq_wol_id
            ,p_rec_boq.boq_sta_item_code
            ,p_rec_boq.boq_item_name
            ,p_rec_boq.boq_date_created
            ,p_rec_boq.boq_icb_work_code
            ,p_rec_boq.boq_est_dim1
            ,p_rec_boq.boq_est_dim2
            ,p_rec_boq.boq_est_dim3
            ,p_rec_boq.boq_est_quantity
            ,p_rec_boq.boq_est_rate
            ,p_rec_boq.boq_est_discount
            ,p_rec_boq.boq_est_cost
            ,p_rec_boq.boq_est_labour
            ,p_rec_boq.boq_act_dim1
            ,p_rec_boq.boq_act_dim2
            ,p_rec_boq.boq_act_dim3
            ,p_rec_boq.boq_act_quantity
            ,p_rec_boq.boq_act_cost
            ,p_rec_boq.boq_act_labour
            ,p_rec_boq.boq_act_rate
            ,p_rec_boq.boq_act_discount
            ,p_rec_boq.boq_id
            ,p_rec_boq.boq_parent_id;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using BOQ_PK constraint
--
FUNCTION lock_gen (pi_boq_id            boq_items.boq_id%TYPE
                  ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_boq IS
   SELECT ROWID
    FROM  boq_items
   WHERE  boq_id = pi_boq_id
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
   OPEN  cs_boq;
   FETCH cs_boq INTO l_retval;
   l_found := cs_boq%FOUND;
   CLOSE cs_boq;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'boq_items (BOQ_PK)'
                                              ||CHR(10)||'boq_id => '||pi_boq_id
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
                    ,pi_supplementary_info => 'boq_items (BOQ_PK)'
                                              ||CHR(10)||'boq_id => '||pi_boq_id
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using BOQ_PK constraint
--
PROCEDURE lock_gen (pi_boq_id            boq_items.boq_id%TYPE
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
                   (pi_boq_id            => pi_boq_id
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
--   Procedure to del using BOQ_PK constraint
--
PROCEDURE del (pi_boq_id            boq_items.boq_id%TYPE
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
                   (pi_boq_id            => pi_boq_id
                   ,pi_raise_not_found   => pi_raise_not_found
                   ,pi_not_found_sqlcode => pi_not_found_sqlcode
                   ,pi_locked_sqlcode    => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE boq_items
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_boq boq_items%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('boq_work_flag      : '||pi_rec_boq.boq_work_flag,p_level);
   nm_debug.debug('boq_defect_id      : '||pi_rec_boq.boq_defect_id,p_level);
   nm_debug.debug('boq_rep_action_cat : '||pi_rec_boq.boq_rep_action_cat,p_level);
   nm_debug.debug('boq_wol_id         : '||pi_rec_boq.boq_wol_id,p_level);
   nm_debug.debug('boq_sta_item_code  : '||pi_rec_boq.boq_sta_item_code,p_level);
   nm_debug.debug('boq_item_name      : '||pi_rec_boq.boq_item_name,p_level);
   nm_debug.debug('boq_date_created   : '||pi_rec_boq.boq_date_created,p_level);
   nm_debug.debug('boq_icb_work_code  : '||pi_rec_boq.boq_icb_work_code,p_level);
   nm_debug.debug('boq_est_dim1       : '||pi_rec_boq.boq_est_dim1,p_level);
   nm_debug.debug('boq_est_dim2       : '||pi_rec_boq.boq_est_dim2,p_level);
   nm_debug.debug('boq_est_dim3       : '||pi_rec_boq.boq_est_dim3,p_level);
   nm_debug.debug('boq_est_quantity   : '||pi_rec_boq.boq_est_quantity,p_level);
   nm_debug.debug('boq_est_rate       : '||pi_rec_boq.boq_est_rate,p_level);
   nm_debug.debug('boq_est_discount   : '||pi_rec_boq.boq_est_discount,p_level);
   nm_debug.debug('boq_est_cost       : '||pi_rec_boq.boq_est_cost,p_level);
   nm_debug.debug('boq_est_labour     : '||pi_rec_boq.boq_est_labour,p_level);
   nm_debug.debug('boq_act_dim1       : '||pi_rec_boq.boq_act_dim1,p_level);
   nm_debug.debug('boq_act_dim2       : '||pi_rec_boq.boq_act_dim2,p_level);
   nm_debug.debug('boq_act_dim3       : '||pi_rec_boq.boq_act_dim3,p_level);
   nm_debug.debug('boq_act_quantity   : '||pi_rec_boq.boq_act_quantity,p_level);
   nm_debug.debug('boq_act_cost       : '||pi_rec_boq.boq_act_cost,p_level);
   nm_debug.debug('boq_act_labour     : '||pi_rec_boq.boq_act_labour,p_level);
   nm_debug.debug('boq_act_rate       : '||pi_rec_boq.boq_act_rate,p_level);
   nm_debug.debug('boq_act_discount   : '||pi_rec_boq.boq_act_discount,p_level);
   nm_debug.debug('boq_id             : '||pi_rec_boq.boq_id,p_level);
   nm_debug.debug('boq_parent_id      : '||pi_rec_boq.boq_parent_id,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
FUNCTION next_boq_id_seq RETURN PLS_INTEGER IS
-- Get BOQ_ID_SEQ.NEXTVAL
   l_retval PLS_INTEGER;
BEGIN
   SELECT BOQ_ID_SEQ.NEXTVAL
    INTO  l_retval
    FROM  dual;
   RETURN l_retval;
END next_boq_id_seq;
--
-----------------------------------------------------------------------------
--
FUNCTION curr_boq_id_seq RETURN PLS_INTEGER IS
-- Get BOQ_ID_SEQ.CURRVAL
   l_retval PLS_INTEGER;
BEGIN
   SELECT BOQ_ID_SEQ.CURRVAL
    INTO  l_retval
    FROM  dual;
   RETURN l_retval;
END curr_boq_id_seq;
--
-----------------------------------------------------------------------------
--
END mai_tab_boq;
/
