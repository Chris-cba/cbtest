CREATE OR REPLACE FORCE VIEW temp_act_report_lines AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/temp_act_report_lines.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   temp_act_report_lines.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 14:33:28  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       arl_not_seq_flag col1
FROM   act_report_lines
/