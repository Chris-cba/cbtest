CREATE OR REPLACE FORCE VIEW v_mai3806_def2
( works_order_no
, wol_date_created
, wol_target_date
, wol_date_complete
, wol_status_code
, wol_date_paid
, wol_cnp_id
, wol_work_sheet_no
, wol_check_id
, wol_check_date
, wor_con_id
, wor_date_closed
, wor_date_confirmed
, hco_meaning
, def_defect_id
, rep_descr
, rep_tre_treat_code
, rep_date_due
, rep_date_completed
, rep_def_defect_id
, rep_superseded_flag
, rep_local_date_due
, rep_old_due_date
, rep_created_date
, rep_last_updated_date
, rep_action_cat
, rep_atv_acty_area_code
, rep_completed_hrs
, rep_completed_mins
, rep_rse_he_id)
AS
SELECT  /*+ FIRST_ROWS_N */
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3806_def2.vw-arc   3.1   Feb 21 2011 12:22:58   Chris.Baugh  $
--       Module Name      : $Workfile:   v_mai3806_def2.vw  $
--       Date into PVCS   : $Date:   Feb 21 2011 12:22:58  $
--       Date fetched Out : $Modtime:   Feb 21 2011 12:22:00  $
--       Version          : $Revision:   3.1  $
-------------------------------------------------------------------------
--
       wol.wol_works_order_no
      ,wol.wol_date_created
      ,wol.wol_target_date
      ,wol.wol_date_complete
      ,wol.wol_status_code
      ,wol.wol_date_paid
      ,wol.wol_cnp_id
      ,wol.wol_work_sheet_no
      ,wol.wol_check_id
      ,wol.wol_check_date
      ,wor.wor_con_id
      ,wor.wor_date_closed
      ,wor.wor_date_confirmed
      ,(select hco_meaning
        from   hig_codes
        where  hco_domain = 'CHECK_RESULT'
         AND   hco_code = wol.wol_check_result
        ) hco_meaning 
      ,rep.rep_def_defect_id
      ,rep.rep_descr
      ,rep.rep_tre_treat_code
      ,rep.rep_date_due
      ,rep.rep_date_completed
      ,rep.rep_def_defect_id
      ,rep.rep_superseded_flag
      ,rep.rep_local_date_due
      ,rep.rep_old_due_date
      ,rep.rep_created_date
      ,rep.rep_last_updated_date
      ,rep.rep_action_cat
      ,rep.rep_atv_acty_area_code
      ,rep.rep_completed_hrs
      ,rep.rep_completed_mins
      ,rep.rep_rse_he_id
  FROM repairs rep
      ,work_order_lines wol
      ,work_orders wor
 WHERE wor.wor_works_order_no(+) = wol.wol_works_order_no
   AND wol.wol_def_defect_id(+) = rep.rep_def_defect_id
   AND wol.wol_rep_action_cat(+) = rep.rep_action_cat
 ORDER
    BY wol.wol_id desc
/