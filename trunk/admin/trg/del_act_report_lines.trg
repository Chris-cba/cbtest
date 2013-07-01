CREATE OR REPLACE TRIGGER del_act_report_lines
AFTER DELETE ON activities_report
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/del_act_report_lines.trg-arc   3.1   Jul 01 2013 15:52:50   James.Wadsworth  $
--       Module Name      : $Workfile:   del_act_report_lines.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
-- *******************************************************************
-- This trigger should ensure that whenever a record is removed from
-- the ACTIVITIES_REPORT table that all corresponding records are
-- removed for the selected activity report from the ACT_REPPORT_LINES
-- table. 
-- *******************************************************************
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  delete
  from   act_report_lines
  where  arl_are_report_id = :old.are_report_id;
END;
/
