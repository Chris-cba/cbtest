CREATE OR REPLACE FORCE VIEW temp_activities_report AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/temp_activities_report.vw-arc   3.1   Jul 01 2013 15:55:28   James.Wadsworth  $
--       Module Name      : $Workfile:   temp_activities_report.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:28  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:17:56  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       are_date_work_done col1
FROM   activities_report
/
