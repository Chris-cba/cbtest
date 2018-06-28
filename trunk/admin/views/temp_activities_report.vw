CREATE OR REPLACE FORCE VIEW temp_activities_report AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/temp_activities_report.vw-arc   3.2   Jun 28 2018 04:46:52   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   temp_activities_report.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:52  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       are_date_work_done col1
FROM   activities_report
/
