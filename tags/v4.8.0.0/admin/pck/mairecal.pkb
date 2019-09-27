CREATE OR REPLACE PACKAGE BODY mairecal
AS
  -----------------------------------------------------------------------------
  --   PVCS Identifiers :-
  --
  --       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mairecal.pkb-arc   2.7   Sep 27 2019 14:40:22   Chris.Baugh  $
  --       Module Name      : $Workfile:   mairecal.pkb  $
  --       Date into SCCS   : $Date:   Sep 27 2019 14:40:22  $
  --       Date fetched Out : $Modtime:   Sep 27 2019 14:33:26  $
  --       SCCS Version     : $Revision:   2.7  $
  --       Based on SCCS Version     : 1.3
  --
  --  This package contains procedures and functions which are required by
  --  the Shift / Recalibrate process within Network Manager.
  --
  --  Maintenance Manager specific functionality can be found here,
  --  whilst the core functionality of the network processes can be found
  --  in the HIGRECAL package.
  --
  --  Originally taken from '@(#)mairecal.pck 1.4 08/07/98';
  --  Now taken from '@(#)mairecal.pck  1.5 01/30/03';
  -----------------------------------------------------------------------------
  --   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
  -----------------------------------------------------------------------------
  g_body_sccsid     CONSTANT  varchar2(2000) := '@(#)$Revision:   2.7  $';
  g_package_name    CONSTANT  varchar2(30)   := 'mairecal';
  --
  TYPE placement_tbl_rec IS RECORD(begin_mp  nm3type.tab_number
                                  ,end_mp    nm3type.tab_number);
  --
  l_rmmsflag  hig_options.hop_value%TYPE := hig.get_sysopt('RMMSFLAG');
  --
  -----------------------------------------------------------------------------
  --
  FUNCTION get_version
    RETURN VARCHAR2 IS
  BEGIN
    RETURN g_sccsid;
  END get_version;

  --
  -----------------------------------------------------------------------------
  --
  FUNCTION get_body_version
    RETURN VARCHAR2 IS
  BEGIN
    RETURN g_body_sccsid;
  END get_body_version;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE check_overhang(p_min_chain    IN     NUMBER
                          ,p_max_chain    IN     NUMBER
                          ,p_length       IN     road_sections.rse_length%TYPE
                          ,p_adjust       IN     NUMBER
                          ,p_err_text     IN     VARCHAR2
                          ,p_errors       IN OUT NUMBER
                          ,p_error_string IN OUT VARCHAR2)
    IS
    --
    l_message varchar2(80);
    --
    --Function to check if items are shifted off the beginning of the section
    --OR off the end, OR point items (which have only a start chain) exceed
    --the end of the section
    --
    FUNCTION overhang(p_min_chain NUMBER
                     ,p_max_chain NUMBER)
      RETURN BOOLEAN IS
    BEGIN
      IF(NVL(p_min_chain,999999)+NVL(p_adjust,0) < 0)
       OR(NVL(p_max_chain,0)+NVL(p_adjust,0)>(NVL(p_length,0)*1.05))
       OR(NVL(p_min_chain,0)+NVL(p_adjust,0)>(NVL(p_length,0)*1.05))
       THEN
          RETURN TRUE;
      ELSE
          RETURN FALSE;
      END IF;
    END overhang;
  --
  BEGIN
    IF overhang(p_min_chain, p_max_chain)
     THEN
        p_errors := p_errors + 1;
        l_message := 'ERROR : Overhanging '||p_err_text||' shift aborted.';
        dbms_output.put_line(l_message);
        p_error_string := p_error_string||chr(13)||l_message;
    END IF;
  END check_overhang;


  --
  ------------------------------------------------------------------------------
  --**** SHIFT PROCEDURES *****
  ------------------------------------------------------------------------------
  --
  PROCEDURE check_data(p_rse_he_id    IN     NUMBER  -- section to shift
                      ,p_new_length   IN     NUMBER  -- new shift length
                      ,p_from_chain   IN     NUMBER  -- chainage from which to shift
                      ,p_chain_adjust IN     NUMBER  -- chainage to shift by
                      ,p_errors       IN OUT NUMBER
                      ,p_error_string IN OUT VARCHAR2)
    IS
    --
    l_min_chain  inv_items_all.iit_st_chain%TYPE;
    l_max_chain  inv_items_all.iit_st_chain%TYPE;
    l_message    VARCHAR2(80);
    --
    CURSOR c2
        IS
    SELECT MIN(are_st_chain)
          ,MAX(are_end_chain)
      FROM activities_report
     WHERE are_rse_he_id = p_rse_he_id
       AND are_st_chain >= p_from_chain
         ;
    --
    CURSOR c3
        IS
    SELECT MIN(def_st_chain)
          ,MAX(def_st_chain)
      FROM defects
     WHERE def_rse_he_id = p_rse_he_id
       AND def_st_chain >= p_from_chain
         ;
    --
    CURSOR c7
        IS
    SELECT MIN(lfr_start_chain)
          ,MAX(lfr_end_chain)
      FROM local_freqs
     WHERE lfr_rse_he_id = p_rse_he_id
       AND lfr_start_chain >= p_from_chain
         ;
    --
    CURSOR c8
        IS
    SELECT MIN(wol_are_st_chain)
          ,MAX(wol_are_st_chain)
      FROM work_order_lines
     WHERE wol_rse_he_id = p_rse_he_id
       AND wol_are_st_chain >= p_from_chain
         ;
    --
    CURSOR c9
        IS
    SELECT MIN(start_point)
          ,MAX(end_point)
      FROM scheme_roads
     WHERE rse_he_id = p_rse_he_id
       AND start_point >= p_from_chain
         ;
    --
  BEGIN
    --
    OPEN  c2;
    FETCH c2
     INTO l_min_chain
         ,l_max_chain;
    IF c2%FOUND
     THEN
        check_overhang(p_min_chain    => l_min_chain
                      ,p_max_chain    => l_max_chain
                      ,p_length       => p_new_length
                      ,p_adjust       => p_chain_adjust
                      ,p_err_text     => 'activity reports'
                      ,p_errors       => p_errors
                      ,p_error_string => p_error_string);
    END IF;
    CLOSE c2;
    --
    OPEN  c3;
    FETCH c3
     INTO l_min_chain
         ,l_max_chain;
    IF c3%FOUND
     THEN
        check_overhang(p_min_chain    => l_min_chain
                      ,p_max_chain    => l_max_chain
                      ,p_length       => p_new_length
                      ,p_adjust       => p_chain_adjust
                      ,p_err_text     => 'defects'
                      ,p_errors       => p_errors
                      ,p_error_string => p_error_string);
    END IF;
    CLOSE c3;
    --
    OPEN  c7;
    FETCH c7
     INTO l_min_chain
         ,l_max_chain;
    IF c7%FOUND
     THEN
        check_overhang(p_min_chain    => l_min_chain
                      ,p_max_chain    => l_max_chain
                      ,p_length       => p_new_length
                      ,p_adjust       => p_chain_adjust
                      ,p_err_text     => 'local frequencies'
                      ,p_errors       => p_errors
                      ,p_error_string => p_error_string);
    END IF;
    CLOSE c7;
    --
    OPEN  c8;
    FETCH c8
     INTO l_min_chain
         ,l_max_chain;
    IF c8%FOUND
     THEN
        check_overhang(p_min_chain    => l_min_chain
                      ,p_max_chain    => l_max_chain
                      ,p_length       => p_new_length
                      ,p_adjust       => p_chain_adjust
                      ,p_err_text     => 'work order details'
                      ,p_errors       => p_errors
                      ,p_error_string => p_error_string);
    END IF;
    CLOSE c8;
    --
    OPEN  c9;
    FETCH c9
     INTO l_min_chain
         ,l_max_chain;
    IF c9%FOUND
     THEN
        check_overhang(p_min_chain    => l_min_chain
                      ,p_max_chain    => l_max_chain
                      ,p_length       => p_new_length
                      ,p_adjust       => p_chain_adjust
                      ,p_err_text     => 'scheme details'
                      ,p_errors       => p_errors
                      ,p_error_string => p_error_string);
    END IF;
    CLOSE c9;
    --
  END check_data;

  --
  -----------------------------------------------------------------------------
  --
  /****************************************************************************
  *                                                                           *
  *  Not sure if the business rules here are correct. Take the case where an  *
  *  inventory item has a start chainage of 5 less than the shift from point  *
  *  and an end chainage 5 after. If the adjustment is 10 this item will not  *
  *  be affected by the shift. Should it be???                                *
  *                                                                           *
  ****************************************************************************/
  PROCEDURE shift_data(p_rse_he_id    IN NUMBER  -- section to shift
                      ,p_new_length   IN NUMBER  -- not required here
                      ,p_from_chain   IN NUMBER  -- chainage from which to shift
                      ,p_chain_adjust IN NUMBER) -- chainage to shift by
    IS
    --
    --  This procedure updates all tables that hold a start/end chainage
    --  and increments both the start/end values by the amount of the shift.
    --  This occurs for ALL "items" that start AFTER, ON or SPAN (ie. start
    --  before and end after) the shift point.
    --
    l_actioned_date VARCHAR2(22) := TO_CHAR(SYSDATE, 'DD-MON-YYYY,HH24:MI:SS');
    --
  BEGIN
    --
    UPDATE activities_report
       SET are_st_chain = DECODE(SIGN(are_st_chain - p_from_chain),-1,are_st_chain
                                                                     ,are_st_chain + p_chain_adjust)
          ,are_end_chain = are_end_chain + p_chain_adjust
          ,are_last_updated_date = TO_DATE(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
     WHERE are_rse_he_id = p_rse_he_id
       AND (are_st_chain >= p_from_chain
            OR are_end_chain >= p_from_chain)
         ;
    --
    UPDATE defects
       SET def_st_chain = DECODE(SIGN(def_st_chain - p_from_chain),-1,def_st_chain
                                                                     ,def_st_chain + p_chain_adjust)
           ,def_last_updated_date = TO_DATE(l_actioned_date ,'DD-MON-YYYY,HH24:MI:SS')
     WHERE def_rse_he_id = p_rse_he_id
       AND def_st_chain >= p_from_chain
         ;
    --
    UPDATE local_freqs
       SET lfr_start_chain = DECODE(SIGN(lfr_start_chain - p_from_chain),-1,lfr_start_chain
                                                                           ,lfr_start_chain + p_chain_adjust)
          ,lfr_end_chain = lfr_end_chain + p_chain_adjust
     WHERE lfr_rse_he_id = p_rse_he_id
       AND (lfr_start_chain >= p_from_chain
            OR lfr_end_chain >= p_from_chain)
         ;
    --
    UPDATE work_order_lines
       SET wol_are_st_chain = DECODE(SIGN(wol_are_st_chain - p_from_chain),-1,wol_are_st_chain
                                                                             ,wol_are_st_chain + p_chain_adjust)
     WHERE wol_rse_he_id = p_rse_he_id
       AND wol_are_st_chain >= p_from_chain
         ;
    --
    UPDATE scheme_roads
       SET start_point = DECODE(SIGN(start_point - p_from_chain),-1,start_point
                                                                   ,start_point + p_chain_adjust)
          ,end_point = end_point + p_chain_adjust
     WHERE rse_he_id = p_rse_he_id
       AND (start_point >= p_from_chain
            OR end_point >= p_from_chain)
         ;
    --
  END shift_data;

  -----------------------------------------------------------------------------
  --**** RECALIBRATE PROCEDURES *****
  -----------------------------------------------------------------------------
  PROCEDURE recalibrate_placements(ptr_mp               IN OUT placement_tbl_rec
                                  ,pi_recal_start_point IN     NUMBER
                                  ,pi_length_ratio      IN     NUMBER
                                  ,pi_dec_places        IN     NUMBER)
    IS
    --
    l_new_begin_mp         NUMBER;
    l_new_end_mp           NUMBER;
    l_begin_mp_from_recal  NUMBER;
    l_end_mp_from_recal    NUMBER;
    --
  BEGIN
    --
    FOR i in 1..ptr_mp.begin_mp.COUNT LOOP
      --
      l_begin_mp_from_recal := ptr_mp.begin_mp(i) - pi_recal_start_point;
      --
      IF ptr_mp.begin_mp(i) < pi_recal_start_point
       THEN
          l_new_begin_mp := ptr_mp.begin_mp(i);
      ELSE
          l_new_begin_mp := pi_recal_start_point + (l_begin_mp_from_recal * pi_length_ratio);
      END IF;
      --
      l_end_mp_from_recal := ptr_mp.end_mp(i) - pi_recal_start_point;
      --
      IF ptr_mp.end_mp(i) < pi_recal_start_point
       THEN
          l_new_end_mp := ptr_mp.end_mp(i);
      ELSE
          l_new_end_mp := pi_recal_start_point + (l_end_mp_from_recal * pi_length_ratio);
      END IF;
      --
      ptr_mp.begin_mp(i) := round(l_new_begin_mp, pi_dec_places);
      ptr_mp.end_mp(i) := round(l_new_end_mp, pi_dec_places );
      --
    END LOOP;
    --
  END recalibrate_placements;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE recal_data(pi_ne_id             IN NUMBER
                      ,pi_recal_start_point IN NUMBER
                      ,pi_length_ratio      IN NUMBER
                      ,pi_dec_places        IN NUMBER)
    IS
    --
    t_rowid     nm3type.tab_rowid;
    tr_mp       placement_tbl_rec;
    l_actioned_date constant date := sysdate;
    --
  BEGIN
    /*
    ||Activities report.
    */
    SELECT ROWID
          ,are_st_chain
          ,are_end_chain
      BULK COLLECT
      INTO t_rowid
          ,tr_mp.begin_mp
          ,tr_mp.end_mp
      FROM activities_report
      WHERE are_rse_he_id = pi_ne_id
        AND are_end_chain >= pi_recal_start_point
          ;
    --
    recalibrate_placements(ptr_mp               => tr_mp
                          ,pi_recal_start_point => pi_recal_start_point
                          ,pi_length_ratio      => pi_length_ratio
                          ,pi_dec_places        => pi_dec_places);
    --
    FORALL i IN 1..t_rowid.COUNT
      UPDATE activities_report
         SET are_st_chain = tr_mp.begin_mp(i)
            ,are_end_chain = tr_mp.end_mp(i)
            ,are_last_updated_date = l_actioned_date
       WHERE ROWID = t_rowid(i)
           ;
    /*
    ||Defects.
    */
    SELECT ROWID
          ,def_st_chain
          ,def_st_chain
      BULK COLLECT
      INTO t_rowid
          ,tr_mp.begin_mp
          ,tr_mp.end_mp
      FROM defects
     WHERE def_rse_he_id = pi_ne_id
       AND def_st_chain >= pi_recal_start_point
         ;
    --
    recalibrate_placements(ptr_mp               => tr_mp
                          ,pi_recal_start_point => pi_recal_start_point
                          ,pi_length_ratio      => pi_length_ratio
                          ,pi_dec_places        => pi_dec_places);
    --
    FORALL i IN 1..t_rowid.COUNT
      UPDATE defects
         SET def_st_chain = tr_mp.begin_mp(i)
            ,def_last_updated_date = l_actioned_date
       WHERE ROWID = t_rowid(i)
           ;
    /*
    ||Local_freqs
    */
    SELECT ROWID
          ,lfr_start_chain
          ,lfr_end_chain
      BULK COLLECT
      INTO t_rowid
          ,tr_mp.begin_mp
          ,tr_mp.end_mp
      FROM local_freqs
     WHERE lfr_rse_he_id = pi_ne_id
       AND lfr_end_chain >= pi_recal_start_point
         ;
    --
    recalibrate_placements(ptr_mp               => tr_mp
                          ,pi_recal_start_point => pi_recal_start_point
                          ,pi_length_ratio      => pi_length_ratio
                          ,pi_dec_places        => pi_dec_places);
    --
    FORALL i IN 1..t_rowid.COUNT
      UPDATE local_freqs
         SET lfr_start_chain = tr_mp.begin_mp(i)
            ,lfr_end_chain = tr_mp.end_mp(i)
       WHERE ROWID = t_rowid(i)
           ;
    /*
    ||work_order_lines
    */
    SELECT ROWID
          ,wol_are_st_chain
          ,wol_are_st_chain
      BULK COLLECT
      INTO t_rowid
          ,tr_mp.begin_mp
          ,tr_mp.end_mp
      FROM work_order_lines
     WHERE wol_rse_he_id = pi_ne_id
       AND wol_are_st_chain >= pi_recal_start_point
         ;
    --
    recalibrate_placements(ptr_mp               => tr_mp
                          ,pi_recal_start_point => pi_recal_start_point
                          ,pi_length_ratio      => pi_length_ratio
                          ,pi_dec_places        => pi_dec_places);
    --
    FORALL i IN 1..t_rowid.COUNT
      UPDATE work_order_lines
         SET wol_are_st_chain = tr_mp.begin_mp(i)
       WHERE ROWID = t_rowid(i)
           ;
    /*
    ||scheme_roads
    */
    SELECT ROWID
          ,start_point
          ,end_point
      BULK COLLECT
      INTO t_rowid
          ,tr_mp.begin_mp
          ,tr_mp.end_mp
      FROM scheme_roads
     WHERE rse_he_id = pi_ne_id
       AND end_point >= pi_recal_start_point
         ;
    --
    recalibrate_placements(ptr_mp               => tr_mp
                          ,pi_recal_start_point => pi_recal_start_point
                          ,pi_length_ratio      => pi_length_ratio
                          ,pi_dec_places        => pi_dec_places);
    --
    FORALL i IN 1..t_rowid.COUNT
      UPDATE scheme_roads
         SET start_point  = tr_mp.begin_mp(i)
            ,end_point = tr_mp.end_mp(i)
       WHERE ROWID = t_rowid(i)
           ;
    --
  END recal_data;

  --
  ---------------------------------------------------------------------------------
  --
  PROCEDURE mai_reversal(p_effective_date IN DATE DEFAULT TO_DATE(SYS_CONTEXT('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY'))
    IS
    -- This procedure will create new MAI objects
    -- after a reversal has been done on a route.
    -- the nm_reversal table needs to be populated
    --
    -- This is basically a copy of the mairepl.replace_data procedure
    --  except that all of the MPs (chainages) used are the length complement
    --  do deal with the reversed data
    --
    lv_new_insp_id       activities_report.are_report_id%TYPE;
    lv_new_defect_id     defects.def_defect_id%TYPE;
    lv_actioned_date     DATE := SYSDATE;
    lv_route_ne_id       nm_elements_all.ne_id%TYPE := nm3rvrs.g_route_ne_id;
    lv_cardinality_flip  BOOLEAN := nm3rvrs.g_cardinality_flip;
    --
    TYPE reversal_rec IS RECORD(old_ne_id  nm_elements_all.ne_id%TYPE
                               ,new_ne_id  nm_elements_all.ne_id%TYPE);
    TYPE reversal_tab IS TABLE OF reversal_rec;
    lt_reversal  reversal_tab;
    --
    TYPE insp_rec IS RECORD(are_report_id  activities_report.are_report_id%TYPE
                           ,are_rse_he_id  activities_report.are_rse_he_id%TYPE
                           ,are_st_chain   activities_report.are_st_chain%TYPE
                           ,are_end_chain  activities_report.are_end_chain%TYPE);
    TYPE insp_tab IS TABLE OF insp_rec;
    lt_insp  insp_tab;
    --
    TYPE defect_rec IS RECORD(def_defect_id  defects.def_defect_id%TYPE
                             ,def_st_chain   defects.def_st_chain%TYPE);
    TYPE defect_tab IS TABLE OF defect_rec;
    lt_defects  defect_tab;
    --
    CURSOR get_reversal_members
        IS
    SELECT ne_id
          ,ne_new_id
      FROM nm_reversal
         ;
    --
    CURSOR get_inspections(cp_ne_id  nm_elements_all.ne_id%TYPE)
        IS
    SELECT are_report_id
          ,are_rse_he_id
          ,are_st_chain
          ,are_end_chain
      FROM activities_report
     WHERE are_report_id IN(SELECT def_are_report_id
                              FROM defects
                                  ,repairs
                             WHERE NOT EXISTS(SELECT 'x'
                                                FROM work_order_lines
                                               WHERE wol_def_defect_id = rep_def_defect_id
                                                 AND wol_rep_action_cat = rep_action_cat)
                               AND rep_date_completed IS NULL
                               AND rep_def_defect_id = def_defect_id
                               AND def_superseded_flag = 'N'
                               AND def_rse_he_id = cp_ne_id)
         ;
    --
    CURSOR get_defects(cp_are_report_id  activities_report.are_report_id%TYPE)
        IS
    SELECT def_defect_id
          ,NVL(def_st_chain,0) def_st_chain
      FROM defects
     WHERE def_defect_id IN(SELECT rep_def_defect_id
                              FROM repairs
                             WHERE rep_date_completed IS NULL
                               AND NOT EXISTS(SELECT 'x'
                                                FROM work_order_lines
                                               WHERE wol_def_defect_id = rep_def_defect_id
                                                 AND wol_rep_action_cat = rep_action_cat))
       AND def_superseded_flag = 'N'
       AND def_are_report_id = cp_are_report_id
         ;
    --
    CURSOR get_all_inspections(cp_group_id  nm_elements_all.ne_id%TYPE)
        IS
    SELECT are_report_id
          ,are_rse_he_id
          ,are_st_chain
          ,are_end_chain
      FROM activities_report
     WHERE are_rse_he_id = cp_group_id
         ;
    --
    PROCEDURE reverse_group(pi_group_id IN nm_elements_all.ne_id%TYPE)
      IS
      --
      CURSOR get_all_inspections(cp_group_id  nm_elements_all.ne_id%TYPE)
          IS
      SELECT are_report_id
            ,are_rse_he_id
            ,are_st_chain
            ,are_end_chain
        FROM activities_report
       WHERE are_rse_he_id = cp_group_id
           ;
      --
    BEGIN
      /*
      ||Get the Inspections that are located on the Group.
      ||NB If Inspections are located on the Groups members i.e. Maintenance Sections are Datumn Elements
      ||no update is required because only the cardinality of their membership of the group has been changed.
      */
      OPEN  get_all_inspections(cp_group_id => pi_group_id);
      FETCH get_all_inspections
       BULK COLLECT
       INTO lt_insp;
      CLOSE get_all_inspections;
      /*
      ||Update the Inspection and Defect chainages.
      */
      FORALL i IN 1..lt_insp.COUNT
        UPDATE activities_report
           SET are_st_chain = nm3rvrs.reverse_length(are_rse_he_id,are_st_chain)
              ,are_end_chain = nm3rvrs.reverse_length(are_rse_he_id,are_end_chain)
         WHERE are_report_id = lt_insp(i).are_report_id
             ;
      --
      FORALL i IN 1..lt_insp.COUNT
        UPDATE defects
           SET def_st_chain = nm3rvrs.reverse_length(def_rse_he_id,def_st_chain)
         WHERE def_are_report_id = lt_insp(i).are_report_id
             ;
      /*
      ||Update work order lines.
      */
      UPDATE work_order_lines
         SET wol_are_st_chain = nm3rvrs.reverse_length(wol_rse_he_id,wol_are_st_chain)
       WHERE wol_rse_he_id = pi_group_id
         AND wol_are_st_chain IS NOT NULL
           ;
      /*
      ||No need for External Activities, Frequencies etc as no new elements are involved.
      */
    END reverse_group;
    --
  BEGIN
    --
    IF lv_cardinality_flip
     THEN
        /*
        ||Update the inspections, defects and work order lines.
        */
        reverse_group(pi_group_id => lv_route_ne_id);
    ELSE
        /*
        ||Inspections may be located on the route rather than it's members.
        */
        reverse_group(pi_group_id => lv_route_ne_id);
        /*
        ||New member elements created so deal with them if needed.
        */
        OPEN  get_reversal_members;
        FETCH get_reversal_members
         BULK COLLECT
         INTO lt_reversal;
        CLOSE get_reversal_members;
        /*
        ||ACTIVITY REPORTS, DEFECTS, REPAIRS
        */
        FOR i IN 1..lt_reversal.COUNT LOOP
          --
          OPEN  get_inspections(cp_ne_id => lt_reversal(i).old_ne_id);
          FETCH get_inspections
           BULK COLLECT
           INTO lt_insp;
          CLOSE get_inspections;
          --
          FOR i IN 1..lt_insp.COUNT LOOP
            --
            lv_new_insp_id := are_report_id_seq.NEXTVAL;
            --
            maisplit.create_new_insp(lt_insp(i).are_report_id
                                    ,lv_new_insp_id
                                    ,lt_reversal(i).new_ne_id
                                    ,nm3rvrs.reverse_length(lt_reversal(i).new_ne_id,lt_insp(i).are_st_chain)
                                    ,nm3rvrs.reverse_length(lt_reversal(i).new_ne_id,lt_insp(i).are_end_chain)
                                    ,p_effective_date);
            --
            OPEN  get_defects(cp_are_report_id => lt_insp(i).are_report_id);
            FETCH get_defects
             BULK COLLECT
             INTO lt_defects;
            CLOSE get_defects;
            --
            FOR j IN 1..lt_defects.COUNT LOOP
              --
              lv_new_defect_id := def_defect_id_seq.NEXTVAL;
              --
              maisplit.create_new_defect(lt_defects(j).def_defect_id
                                        ,lv_new_defect_id
                                        ,lt_reversal(i).new_ne_id
                                        ,lv_new_insp_id
                                        ,nm3rvrs.reverse_length(lt_reversal(i).new_ne_id,lt_defects(j).def_st_chain)
                                        ,p_effective_date);
            END LOOP;
            --
          END LOOP;
          /*
          ||EXTERNAL ACTS
          */
          INSERT
            INTO ext_act_road_usage
                (exu_rse_he_id
                ,exu_ext_id
                ,exu_current
                ,exu_start_date
                ,exu_sign_off_date
                ,exu_created_date
                ,exu_last_updated_date)
          SELECT lt_reversal(i).new_ne_id
                ,exu_ext_id
                ,exu_current
                ,exu_start_date
                ,exu_sign_off_date
                ,lv_actioned_date
                ,lv_actioned_date
            FROM ext_act_road_usage
           WHERE exu_rse_he_id = lt_reversal(i).old_ne_id
             AND l_rmmsflag IN ('3','4')
               ;
          --
          UPDATE ext_act_road_usage
             SET exu_sign_off_date = p_effective_date
                ,exu_current = NULL
                ,exu_last_updated_date = lv_actioned_date
           WHERE exu_rse_he_id = lt_reversal(i).old_ne_id
             AND l_rmmsflag IN('3','4')
               ;
          /*
          ||FREQUENCIES
          */
          INSERT
            INTO local_freqs
                (lfr_atv_acty_area_code
                ,lfr_int_code
                ,lfr_rse_he_id
                ,lfr_approved_by
                ,lfr_approved_ref
                ,lfr_date_approved
                ,lfr_descr
                ,lfr_end_chain
                ,lfr_ity_inv_code
                ,lfr_start_chain
                ,lfr_ity_sys_flag)
          SELECT lfr_atv_acty_area_code
                ,lfr_int_code
                ,lt_reversal(i).new_ne_id
                ,lfr_approved_by
                ,lfr_approved_ref
                ,lfr_date_approved
                ,lfr_descr
                ,nm3rvrs.reverse_length(lt_reversal(i).new_ne_id,lfr_end_chain)
                ,lfr_ity_inv_code
                ,nm3rvrs.reverse_length(lt_reversal(i).new_ne_id,lfr_start_chain)
                ,lfr_ity_sys_flag
            FROM local_freqs
           WHERE lfr_rse_he_id = lt_reversal(i).old_ne_id
               ;
          --
          INSERT
            INTO section_freqs
                (sfr_atv_acty_area_code
                ,sfr_int_code
                ,sfr_rse_he_id)
          SELECT sfr_atv_acty_area_code
                ,sfr_int_code
                ,lt_reversal(i).new_ne_id
            FROM section_freqs
           WHERE sfr_rse_he_id = lt_reversal(i).old_ne_id
               ;
          /*
          ||STRUCTURAL PROJECTS
          */
          UPDATE scheme_roads
             SET rse_he_id = lt_reversal(i).new_ne_id
           WHERE rse_he_id = lt_reversal(i).old_ne_id
               ;
          --
        END LOOP;
        --
    END IF;
    --
  END mai_reversal;

  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE mai_reclassify(pi_old_ne_id      nm_elements.ne_id%TYPE
                          ,pi_new_ne_id      nm_elements.ne_id%TYPE
                          ,pi_effective_date DATE)
    IS
  BEGIN
    --
    nm_debug.proc_start(g_package_name,'mai_reclassify');
    --
    mairepl.replace_data(p_rse_he_id_new  => pi_new_ne_id
                        ,p_rse_he_id      => pi_old_ne_id
                        ,p_effective_date => pi_effective_date);
    --
    nm_debug.proc_end(g_package_name,'mai_reclassify');
    --
  END mai_reclassify;
  
  --
  -----------------------------------------------------------------------------
  --
  PROCEDURE resize_data(pi_ne_id       IN nm_elements.ne_id%TYPE
                       ,pi_orig_length IN NUMBER
                       ,pi_new_length  IN NUMBER)
    IS
    --
    lv_length_ratio  NUMBER;
    lv_dec_places    NUMBER;
    --
  BEGIN
    /*
    ||Derive the length change ratio.
    */
    lv_dec_places := nm3flx.get_dec_places_from_mask(nm3unit.get_unit_mask(nm3net.get_nt_units(nm3net.get_ne(pi_ne_id).ne_nt_type)));
    lv_length_ratio := pi_new_length/pi_orig_length;
    /*
    ||Call recal to apply the changes.
    */
    mairecal.recal_data(pi_ne_id             => pi_ne_id
                       ,pi_recal_start_point => 0
                       ,pi_length_ratio      => lv_length_ratio
                       ,pi_dec_places        => lv_dec_places);
    --
  END resize_data;
  --
END mairecal;
/
