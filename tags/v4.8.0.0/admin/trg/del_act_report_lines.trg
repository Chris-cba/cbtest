CREATE OR REPLACE TRIGGER del_act_report_lines
AFTER DELETE ON activities_report
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/del_act_report_lines.trg-arc   3.3   Sep 27 2019 15:18:06   Chris.Baugh  $
--       Module Name      : $Workfile:   del_act_report_lines.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:06  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.3  $
--
-- *******************************************************************
-- This trigger should ensure that whenever a record is removed from
-- the ACTIVITIES_REPORT table that all corresponding records are
-- removed for the selected activity report from the ACT_REPPORT_LINES
-- table. 
-- *******************************************************************
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  delete
  from   act_report_lines
  where  arl_are_report_id = :old.are_report_id;
END;
/
