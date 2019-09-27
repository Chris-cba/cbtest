CREATE OR REPLACE FORCE VIEW temp_activities_report AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/temp_activities_report.vw-arc   3.3   Sep 27 2019 15:36:16   Chris.Baugh  $
--       Module Name      : $Workfile:   temp_activities_report.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       are_date_work_done col1
FROM   activities_report
/
