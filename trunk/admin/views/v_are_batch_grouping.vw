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
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_are_batch_grouping.vw-arc   3.3   Sep 27 2019 15:36:16   Chris.Baugh  $
--       Module Name      : $Workfile:   v_are_batch_grouping.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
-- View displaying activity reports grouped by are_batch_id, 
-- for use with mai2200r module_params
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
   MAX(are_report_id), 
   are_batch_id
FROM activities_report 
GROUP BY are_batch_id
/
