CREATE OR REPLACE PACKAGE BODY mai_cyclic_wo AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_cyclic_wo.pkb-arc   4.0   Apr 27 2012 18:35:18   Mike.Huitson  $
--       Module Name      : $Workfile:   mai_cyclic_wo.pkb  $
--       Date into PVCS   : $Date:   Apr 27 2012 18:35:18  $
--       Date fetched Out : $Modtime:   Apr 27 2012 18:27:46  $
--       PVCS Version     : $Revision:   4.0  $
--
-----------------------------------------------------------------------------
--  Copyright (c) exor corporation ltd, 2007
-----------------------------------------------------------------------------
--
g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   4.0  $';
g_package_name  CONSTANT  varchar2(30)   := 'mai_cyclic_wo';
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
FUNCTION get_next_id(pi_seq_name IN VARCHAR2)
  RETURN NUMBER IS
  --
  lv_query_string varchar2(1000) := 'SELECT '||pi_seq_name||'.nextval FROM dual';
  lv_seq_no number;
  --
BEGIN
  --
  EXECUTE IMMEDIATE lv_query_string INTO lv_seq_no;
  --
  RETURN lv_seq_no;
  --
END get_next_id;
--
-----------------------------------------------------------------------------
--
FUNCTION get_schedule(pi_schd_id IN schedules.schd_id%TYPE)
  RETURN schedules%ROWTYPE IS
  --
  lr_retval schedules%ROWTYPE;
  --
BEGIN
  /*
  ||Get Schedule Record.
  */
  SELECT *
    INTO lr_retval
    FROM schedules
   WHERE schd_id = pi_schd_id
       ;
  --
  RETURN lr_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20001,'Invalid Schedule Id Supplied.');
  WHEN others
   THEN
      RAISE;
END get_schedule;
--
-----------------------------------------------------------------------------
--
FUNCTION get_schedule_roads_for_wols(pi_schd_id IN schedules.schd_id%TYPE)
  RETURN schr_for_wol_tab IS
  --
  lt_retval schr_for_wol_tab;
  --
BEGIN
  --
  SELECT DISTINCT schr_rse_he_id
        ,schd_icb_work_code
        ,schr_iit_item_id
    BULK COLLECT
    INTO lt_retval
    FROM schedule_roads
        ,schedules
   WHERE schd_id = pi_schd_id
     AND schd_id = schr_schd_id
   ORDER
      BY 1,2,3
       ;
  --
  RETURN lt_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN lt_retval;
  WHEN others
   THEN
      RAISE;
END get_schedule_roads_for_wols;
--
-----------------------------------------------------------------------------
--
FUNCTION get_boqs_for_wol(pi_rse_he_id   IN road_segs.rse_he_id%TYPE
                         ,pi_schd_id     IN schedules.schd_id%TYPE
                         ,pi_iit_item_id IN nm_inv_items_all.iit_ne_id%TYPE)
  RETURN boqs_for_wol_tab IS
  --
  lt_retval boqs_for_wol_tab;
  --
BEGIN
  --
  SELECT schr_sta_item_code                   item_code
        ,schr_act_quantity                    act_quantity
        ,sta_rogue_flag                       rogue_flag
        ,DECODE(sta_dim2_text, NULL, NULL, 1) dim2
        ,DECODE(sta_dim3_text, NULL, NULL, 1) dim3
        ,sta_labour_units                     labour_units
    BULK COLLECT
    INTO lt_retval
    FROM standard_items
        ,schedule_roads
        ,schedules
   WHERE schd_id = pi_schd_id
     AND schd_id = schr_schd_id
     AND schr_rse_he_id = pi_rse_he_id
     AND schr_act_quantity > 0
     AND NVL(schr_iit_item_id,0) = NVL(pi_iit_item_id,0)
     AND schr_sta_item_code = sta_item_code
       ;
  --
  RETURN lt_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      RETURN lt_retval;
  WHEN others
   THEN
      RAISE;
END get_boqs_for_wol;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_wols(pi_wols IN wol_tab) IS
  --
BEGIN
  /*
  ||Insert The WOLs.
  ||NB. ref each column individually to ensure that column defaults are applied.
  */
  FORALL i IN 1 .. pi_wols.COUNT
   INSERT
      INTO work_order_lines
          (wol_id            
          ,wol_works_order_no
          ,wol_bud_id        
          ,wol_schd_id       
          ,wol_rse_he_id     
          ,wol_siss_id       
          ,wol_icb_work_code 
          ,wol_flag          
          ,wol_status_code   
          ,wol_wor_flag      
          ,wol_date_created  
          ,wol_month_due     
          ,wol_iit_item_id   
          ,wol_est_cost      
          ,wol_act_cost      
          ,wol_est_labour)
    VALUES(pi_wols(i).wol_id            
          ,pi_wols(i).wol_works_order_no
          ,pi_wols(i).wol_bud_id        
          ,pi_wols(i).wol_schd_id       
          ,pi_wols(i).wol_rse_he_id     
          ,pi_wols(i).wol_siss_id       
          ,pi_wols(i).wol_icb_work_code 
          ,pi_wols(i).wol_flag          
          ,pi_wols(i).wol_status_code   
          ,pi_wols(i).wol_wor_flag      
          ,pi_wols(i).wol_date_created  
          ,pi_wols(i).wol_month_due     
          ,pi_wols(i).wol_iit_item_id   
          ,pi_wols(i).wol_est_cost      
          ,pi_wols(i).wol_act_cost      
          ,pi_wols(i).wol_est_labour)
         ;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20001, 'Error Occured While Creating WOLs : '||SQLERRM);
END ins_wols;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_boqs(pi_boqs IN boq_tab) IS
  --
BEGIN
  /*
  ||Insert The BOQs.
  ||NB. ref each column individually to ensure that column defaults are applied.
  */
  FORALL i IN 1 .. pi_boqs.COUNT
    INSERT
      INTO boq_items
          (boq_work_flag      
          ,boq_defect_id      
          ,boq_rep_action_cat 
          ,boq_wol_id         
          ,boq_sta_item_code  
          ,boq_date_created   
          ,boq_est_dim1       
          ,boq_est_dim2       
          ,boq_est_dim3       
          ,boq_est_quantity   
          ,boq_est_rate       
          ,boq_est_cost
          ,boq_est_labour
          ,boq_id)
    VALUES(pi_boqs(i).boq_work_flag      
          ,pi_boqs(i).boq_defect_id      
          ,pi_boqs(i).boq_rep_action_cat 
          ,pi_boqs(i).boq_wol_id         
          ,pi_boqs(i).boq_sta_item_code  
          ,pi_boqs(i).boq_date_created   
          ,pi_boqs(i).boq_est_dim1       
          ,pi_boqs(i).boq_est_dim2       
          ,pi_boqs(i).boq_est_dim3       
          ,pi_boqs(i).boq_est_quantity   
          ,pi_boqs(i).boq_est_rate       
          ,pi_boqs(i).boq_est_cost
          ,pi_boqs(i).boq_est_labour
          ,pi_boqs(i).boq_id)
         ;
  --
EXCEPTION
  WHEN others
   THEN
      raise_application_error(-20002, 'Error Occured While Creating BOQs : '||SQLERRM);
END ins_boqs;
--
-----------------------------------------------------------------------------
--
END mai_cyclic_wo;
/
