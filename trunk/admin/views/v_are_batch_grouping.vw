CREATE OR REPLACE FORCE VIEW v_are_batch_grouping
(
   max_are_report_id, 
   are_batch_id
)
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_are_batch_grouping.vw-arc   3.2   Jun 28 2018 04:46:52   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   v_are_batch_grouping.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:52  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
-- View displaying activity reports grouped by are_batch_id, 
-- for use with mai2200r module_params
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
   MAX(are_report_id), 
   are_batch_id
FROM activities_report 
GROUP BY are_batch_id
/
