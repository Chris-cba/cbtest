--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/maitrgcre.sql-arc   2.7   Jan 21 2011 12:14:28   Mike.Alexander  $
--       Module Name      : $Workfile:   maitrgcre.sql  $
--       Date into PVCS   : $Date:   Jan 21 2011 12:14:28  $
--       Date fetched Out : $Modtime:   Jan 21 2011 12:14:04  $
--       Version          : $Revision:   2.7  $
-------------------------------------------------------------------------
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

