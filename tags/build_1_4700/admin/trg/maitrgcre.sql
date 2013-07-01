--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/maitrgcre.sql-arc   2.11   Jul 01 2013 15:54:32   James.Wadsworth  $
--       Module Name      : $Workfile:   maitrgcre.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:54:32  $
--       Date fetched Out : $Modtime:   Jul 01 2013 15:54:10  $
--       Version          : $Revision:   2.11  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
--
SET ECHO OFF
set TERM off
--
COL run_file new_value run_file noprint
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'boq_audit.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'claim_payment_audit_b_ud_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'complete_doc_status.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'def_due_date_time.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'def_update_doc_status.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'del_act_report_lines.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'delete_doc_def_priorities.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'delete_doc_def_treats.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'dummy_contract_delete.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'dummy_contract_insert.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'dummy_contract_update.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'insert_def_movements.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'insert_doc_def_priorities.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'insert_doc_def_treats.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'insert_scheme_history.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'pre_insert_defects.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'update_doc_def_priorities.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'update_doe_def_priority.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'update_rse_agency.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'wo_claims.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'wol_audit.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'wol_register_as_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'wol_register_bs_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'wol_register_iud_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'wor_audit.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'work_orders_register_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'works_order_fgac.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'delete_wols.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'a_i_hus_mai.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'action_wor_status.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'trg'||'&terminator'||'org_units_ai_contractor.trg' run_file
FROM dual
/
START '&run_file'
--
-- new triggers above this
--
--
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'nm3'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'who_trg.sql' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------

SET TERM ON

