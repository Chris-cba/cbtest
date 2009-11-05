CREATE OR REPLACE FORCE VIEW temp_activities_report AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/temp_activities_report.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   temp_activities_report.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 14:33:26  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       are_date_work_done col1
FROM   activities_report
/
