CREATE OR REPLACE FORCE VIEW temp_act_report_lines AS
SELECT
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/temp_act_report_lines.vw-arc   3.1   Jul 01 2013 15:55:28   James.Wadsworth  $
--       Module Name      : $Workfile:   temp_act_report_lines.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:28  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:17:42  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       arl_not_seq_flag col1
FROM   act_report_lines
/
