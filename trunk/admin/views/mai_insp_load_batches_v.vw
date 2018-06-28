CREATE OR REPLACE FORCE VIEW mai_insp_load_batches_v AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/mai_insp_load_batches_v.vw-arc   3.2   Jun 28 2018 04:46:52   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_insp_load_batches_v.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:52  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
       milb.milb_batch_id
      ,milb.milb_hp_process_id
      ,hp.hp_formatted_process_id
      ,milb.milb_hpf_file_id
      ,(SELECT hpf_filename
          FROM hig_process_files
         WHERE hpf_file_id = milb.milb_hpf_file_id) hpf_filename
      ,hp.hp_initiated_by_username
      ,hp.hp_initiators_ref
      ,hp.hp_initiated_date
      ,hp.hp_success_flag
      ,hp.hp_success_flag_meaning
      ,hp.hp_area_id
      ,hp.hp_area_meaning
      ,hp.hp_requires_attention_flag
  FROM hig_processes_v hp
      ,mai_insp_load_batches milb
 WHERE milb.milb_hp_process_id = hp.hp_process_id(+)
/


COMMENT ON TABLE mai_insp_load_batches_v IS 'Maintenance Manager Inspection Loader Batches. Shows Batch and related Process details.'
/
