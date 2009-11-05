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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_are_batch_grouping.vw-arc   3.0   Nov 05 2009 10:55:16   gjohnson  $
--       Module Name      : $Workfile:   v_are_batch_grouping.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:55:16  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:13:24  $
--       Version          : $Revision:   3.0  $
-- View displaying activity reports grouped by are_batch_id, 
-- for use with mai2200r module_params
-------------------------------------------------------------------------
   MAX(are_report_id), 
   are_batch_id
FROM activities_report 
GROUP BY are_batch_id
/