CREATE OR REPLACE PACKAGE BODY maiclose IS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/maiclose.pkb-arc   2.4   Sep 27 2019 14:40:20   Chris.Baugh  $
--       Module Name      : $Workfile:   maiclose.pkb  $
--       Date into SCCS   : $Date:   Sep 27 2019 14:40:20  $
--       Date fetched Out : $Modtime:   Sep 27 2019 14:29:08  $
--       SCCS Version     : $Revision:   2.4  $
--       Based on SCCS Version     : 1.2
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maiclose.pck  1.2 02/16/98';
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
g_body_sccsid  CONSTANT varchar2(2000) :='"$Revision:   2.4  $"';

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
PROCEDURE check_data(p_id             IN     NUMBER
                    ,p_effective_date IN     DATE
                    ,p_errors         IN OUT NUMBER
                    ,p_error_string   IN OUT VARCHAR2)
  IS
  --
  l_message  VARCHAR2(80);
  --
  CURSOR c1(cp_id              NUMBER
           ,cp_effective_date  DATE)
      IS
  SELECT 'ERROR : An uncompleted scheme exists for this section.'
    FROM scheme_roads scr
        ,schemes sch
   WHERE scr.rse_he_id = cp_id
     AND scr.scheme_id = sch.scheme_id
     AND (cp_effective_date < NVL(TRUNC(sch.date_work_complete),cp_effective_date)
          OR sch.date_work_complete IS NULL)
       ;
  --
BEGIN
  --
  maisplit.check_data(p_id
                     ,0
                     ,p_effective_date
                     ,p_errors
                     ,p_error_string);
  --
  OPEN  c1(p_id
          ,p_effective_date);
  FETCH c1
   INTO l_message;
  IF c1%FOUND
   THEN
      p_errors := p_errors + 1;
      p_error_string := p_error_string||CHR(13)||l_message;
  END IF;
  CLOSE c1;
  --
END check_data;
--
-----------------------------------------------------------------------------
--
PROCEDURE close_data(p_id             IN NUMBER
                    ,p_effective_date IN DATE)
  IS
  --
  l_actioned_date  DATE := SYSDATE;
  --
BEGIN
  --
  UPDATE repairs
     SET rep_date_completed = p_effective_date
        ,rep_last_updated_date = l_actioned_date
   WHERE rep_date_completed IS NULL
     AND rep_rse_he_id = p_id
       ;
  --
  UPDATE defects
     SET def_date_compl = p_effective_date
        ,def_date_not_found = p_effective_date
        ,def_last_updated_date = l_actioned_date
   WHERE def_date_compl IS NULL
     AND def_rse_he_id = p_id
       ;
  --
  UPDATE ext_act_road_usage
     SET exu_sign_off_date = p_effective_date
        ,exu_last_updated_date = l_actioned_date
   WHERE exu_rse_he_id = p_id
       ;
  --
END close_data;
--
-----------------------------------------------------------------------------
--
PROCEDURE unclose_data(p_id            IN NUMBER
                      ,p_history_date  IN VARCHAR2)
  IS
  --
  l_unactioned_date  DATE := SYSDATE;
  l_rmmsflag         VARCHAR2(1) := hig.get_sysopt('RMMSFLAG');
  --
BEGIN
  --
  UPDATE repairs
     SET rep_date_completed = NULL
        ,rep_last_updated_date = l_unactioned_date
   WHERE rep_date_completed = TO_DATE(p_history_date)
     AND rep_rse_he_id = p_id
     AND rep_def_defect_id IN(SELECT def_defect_id
                                FROM defects
                               WHERE def_date_compl = TO_DATE(p_history_date)
                                 AND def_date_not_found = TO_DATE(p_history_date)
                                 AND def_are_id_not_found IS NULL
                                 AND def_rse_he_id = p_id)
       ;
  --
  UPDATE defects
     SET def_date_compl = NULL
        ,def_date_not_found = NULL
        ,def_last_updated_date = l_unactioned_date
   WHERE def_date_compl = TO_DATE(p_history_date)
     AND def_date_not_found = TO_DATE(p_history_date)
     AND def_are_id_not_found IS NULL
     AND def_rse_he_id = p_id
       ;
  --
  IF l_rmmsflag IN ('3','4')
   THEN
      --
      UPDATE ext_act_road_usage
         SET exu_sign_off_date = NULL
            ,exu_current = 'Y'
            ,exu_last_updated_date = l_unactioned_date
       WHERE exu_rse_he_id = p_id
           ;
      --
  END IF;
  --
END unclose_data;
--
-----------------------------------------------------------------------------
--
END maiclose;
/
