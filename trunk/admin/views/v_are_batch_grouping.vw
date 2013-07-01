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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_are_batch_grouping.vw-arc   3.1   Jul 01 2013 15:55:28   James.Wadsworth  $
--       Module Name      : $Workfile:   v_are_batch_grouping.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:28  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:19:40  $
--       Version          : $Revision:   3.1  $
-- View displaying activity reports grouped by are_batch_id, 
-- for use with mai2200r module_params
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
   MAX(are_report_id), 
   are_batch_id
FROM activities_report 
GROUP BY are_batch_id
/
