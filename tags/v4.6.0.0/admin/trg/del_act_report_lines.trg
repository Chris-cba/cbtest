CREATE OR REPLACE TRIGGER del_act_report_lines
AFTER DELETE ON activities_report
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/del_act_report_lines.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   del_act_report_lines.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:07:42  $
--       Version          : $Revision:   3.0  $
--
-- *******************************************************************
-- This trigger should ensure that whenever a record is removed from
-- the ACTIVITIES_REPORT table that all corresponding records are
-- removed for the selected activity report from the ACT_REPPORT_LINES
-- table. 
-- *******************************************************************
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  delete
  from   act_report_lines
  where  arl_are_report_id = :old.are_report_id;
END;
/
