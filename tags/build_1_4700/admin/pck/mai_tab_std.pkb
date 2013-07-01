CREATE OR REPLACE PACKAGE BODY mai_tab_std IS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_tab_std.pkb-arc   2.1   Jul 01 2013 16:26:02   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_tab_std.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:26:02  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:46  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Darren Cope
--
--   Generated package DO NOT MODIFY
--
--   nm3get_gen header : @(#)mai_tab_std.pkb	1.1 03/09/04
--   nm3get_gen body   : @(#)mai_tab_std.pkb	1.1 03/09/04
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
   g_package_name    CONSTANT  varchar2(30)   := 'mai_tab_std';
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
--   Function to get using STA_INDEX_P1 index
--
FUNCTION get (pi_sta_item_code     standard_items.sta_item_code%TYPE
             ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
             ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
             ) RETURN standard_items%ROWTYPE IS
--
   CURSOR cs_std IS
   SELECT *
    FROM  standard_items
   WHERE  sta_item_code = pi_sta_item_code;
--
   l_found  BOOLEAN;
   l_retval standard_items%ROWTYPE;
--
BEGIN
--
   nm_debug.proc_start(g_package_name,'get');
--
   OPEN  cs_std;
   FETCH cs_std INTO l_retval;
   l_found := cs_std%FOUND;
   CLOSE cs_std;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'standard_items (STA_INDEX_P1)'
                                              ||CHR(10)||'sta_item_code => '||pi_sta_item_code
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
PROCEDURE ins (p_rec_std IN OUT standard_items%ROWTYPE) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'ins');
--
--
   INSERT INTO standard_items
            (sta_item_code
            ,sta_item_name
            ,sta_siss_id
            ,sta_icb_id
            ,sta_atv_acty_area_code
            ,sta_rate
            ,sta_unit
            ,sta_calc_type
            ,sta_min_quantity
            ,sta_max_quantity
            ,sta_labour_units
            ,sta_ratio
            ,sta_rogue_flag
            ,sta_dcd_flag
            ,sta_dim1_text
            ,sta_dim2_text
            ,sta_dim3_text
            ,sta_descr
            ,sta_start_date
            ,sta_end_date
            ,sta_allow_percent
            )
     VALUES (p_rec_std.sta_item_code
            ,p_rec_std.sta_item_name
            ,p_rec_std.sta_siss_id
            ,p_rec_std.sta_icb_id
            ,p_rec_std.sta_atv_acty_area_code
            ,p_rec_std.sta_rate
            ,p_rec_std.sta_unit
            ,p_rec_std.sta_calc_type
            ,p_rec_std.sta_min_quantity
            ,p_rec_std.sta_max_quantity
            ,p_rec_std.sta_labour_units
            ,p_rec_std.sta_ratio
            ,p_rec_std.sta_rogue_flag
            ,p_rec_std.sta_dcd_flag
            ,p_rec_std.sta_dim1_text
            ,p_rec_std.sta_dim2_text
            ,p_rec_std.sta_dim3_text
            ,p_rec_std.sta_descr
            ,p_rec_std.sta_start_date
            ,p_rec_std.sta_end_date
            ,p_rec_std.sta_allow_percent
            )
   RETURNING sta_item_code
            ,sta_item_name
            ,sta_siss_id
            ,sta_icb_id
            ,sta_atv_acty_area_code
            ,sta_rate
            ,sta_unit
            ,sta_calc_type
            ,sta_min_quantity
            ,sta_max_quantity
            ,sta_labour_units
            ,sta_ratio
            ,sta_rogue_flag
            ,sta_dcd_flag
            ,sta_dim1_text
            ,sta_dim2_text
            ,sta_dim3_text
            ,sta_descr
            ,sta_start_date
            ,sta_end_date
            ,sta_allow_percent
      INTO   p_rec_std.sta_item_code
            ,p_rec_std.sta_item_name
            ,p_rec_std.sta_siss_id
            ,p_rec_std.sta_icb_id
            ,p_rec_std.sta_atv_acty_area_code
            ,p_rec_std.sta_rate
            ,p_rec_std.sta_unit
            ,p_rec_std.sta_calc_type
            ,p_rec_std.sta_min_quantity
            ,p_rec_std.sta_max_quantity
            ,p_rec_std.sta_labour_units
            ,p_rec_std.sta_ratio
            ,p_rec_std.sta_rogue_flag
            ,p_rec_std.sta_dcd_flag
            ,p_rec_std.sta_dim1_text
            ,p_rec_std.sta_dim2_text
            ,p_rec_std.sta_dim3_text
            ,p_rec_std.sta_descr
            ,p_rec_std.sta_start_date
            ,p_rec_std.sta_end_date
            ,p_rec_std.sta_allow_percent;
--
   nm_debug.proc_end(g_package_name,'ins');
--
END ins;
--
-----------------------------------------------------------------------------
--
--
--   Function to lock using STA_INDEX_P1 index
--
FUNCTION lock_gen (pi_sta_item_code     standard_items.sta_item_code%TYPE
                  ,pi_raise_not_found   BOOLEAN     DEFAULT TRUE
                  ,pi_not_found_sqlcode PLS_INTEGER DEFAULT -20000
                  ,pi_locked_sqlcode    PLS_INTEGER DEFAULT -20000
                  ) RETURN ROWID IS
--
   CURSOR cs_std IS
   SELECT ROWID
    FROM  standard_items
   WHERE  sta_item_code = pi_sta_item_code
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
   OPEN  cs_std;
   FETCH cs_std INTO l_retval;
   l_found := cs_std%FOUND;
   CLOSE cs_std;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'standard_items (STA_INDEX_P1)'
                                              ||CHR(10)||'sta_item_code => '||pi_sta_item_code
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
                    ,pi_supplementary_info => 'standard_items (STA_INDEX_P1)'
                                              ||CHR(10)||'sta_item_code => '||pi_sta_item_code
                    );
--
END lock_gen;
--
-----------------------------------------------------------------------------
--
--
--   Procedure to lock using STA_INDEX_P1 index
--
PROCEDURE lock_gen (pi_sta_item_code     standard_items.sta_item_code%TYPE
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
                   (pi_sta_item_code     => pi_sta_item_code
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
--   Procedure to del using STA_INDEX_P1 index
--
PROCEDURE del (pi_sta_item_code     standard_items.sta_item_code%TYPE
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
                   (pi_sta_item_code     => pi_sta_item_code
                   ,pi_raise_not_found   => pi_raise_not_found
                   ,pi_not_found_sqlcode => pi_not_found_sqlcode
                   ,pi_locked_sqlcode    => pi_locked_sqlcode
                   );
--
   IF l_rowid IS NOT NULL
    THEN
      DELETE standard_items
      WHERE ROWID = l_rowid;
   END IF;
--
   nm_debug.proc_end(g_package_name,'del');
--
END del;
--
-----------------------------------------------------------------------------
--
PROCEDURE debug (pi_rec_std standard_items%ROWTYPE,p_level PLS_INTEGER DEFAULT 3) IS
BEGIN
--
   nm_debug.proc_start(g_package_name,'debug');
--
   nm_debug.debug('sta_item_code          : '||pi_rec_std.sta_item_code,p_level);
   nm_debug.debug('sta_item_name          : '||pi_rec_std.sta_item_name,p_level);
   nm_debug.debug('sta_siss_id            : '||pi_rec_std.sta_siss_id,p_level);
   nm_debug.debug('sta_icb_id             : '||pi_rec_std.sta_icb_id,p_level);
   nm_debug.debug('sta_atv_acty_area_code : '||pi_rec_std.sta_atv_acty_area_code,p_level);
   nm_debug.debug('sta_rate               : '||pi_rec_std.sta_rate,p_level);
   nm_debug.debug('sta_unit               : '||pi_rec_std.sta_unit,p_level);
   nm_debug.debug('sta_calc_type          : '||pi_rec_std.sta_calc_type,p_level);
   nm_debug.debug('sta_min_quantity       : '||pi_rec_std.sta_min_quantity,p_level);
   nm_debug.debug('sta_max_quantity       : '||pi_rec_std.sta_max_quantity,p_level);
   nm_debug.debug('sta_labour_units       : '||pi_rec_std.sta_labour_units,p_level);
   nm_debug.debug('sta_ratio              : '||pi_rec_std.sta_ratio,p_level);
   nm_debug.debug('sta_rogue_flag         : '||pi_rec_std.sta_rogue_flag,p_level);
   nm_debug.debug('sta_dcd_flag           : '||pi_rec_std.sta_dcd_flag,p_level);
   nm_debug.debug('sta_dim1_text          : '||pi_rec_std.sta_dim1_text,p_level);
   nm_debug.debug('sta_dim2_text          : '||pi_rec_std.sta_dim2_text,p_level);
   nm_debug.debug('sta_dim3_text          : '||pi_rec_std.sta_dim3_text,p_level);
   nm_debug.debug('sta_descr              : '||pi_rec_std.sta_descr,p_level);
   nm_debug.debug('sta_start_date         : '||pi_rec_std.sta_start_date,p_level);
   nm_debug.debug('sta_end_date           : '||pi_rec_std.sta_end_date,p_level);
   nm_debug.debug('sta_allow_percent      : '||pi_rec_std.sta_allow_percent,p_level);
--
   nm_debug.proc_end(g_package_name,'debug');
--
END debug;
--
-----------------------------------------------------------------------------
--
END mai_tab_std;
/
