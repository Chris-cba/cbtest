CREATE OR REPLACE TRIGGER del_act_report_lines
AFTER DELETE ON activities_report
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/del_act_report_lines.trg-arc   3.2   Jun 28 2018 04:36:40   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   del_act_report_lines.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:40  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
-- *******************************************************************
-- This trigger should ensure that whenever a record is removed from
-- the ACTIVITIES_REPORT table that all corresponding records are
-- removed for the selected activity report from the ACT_REPPORT_LINES
-- table. 
-- *******************************************************************
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  delete
  from   act_report_lines
  where  arl_are_report_id = :old.are_report_id;
END;
/
