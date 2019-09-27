CREATE OR REPLACE TRIGGER update_doe_def_priority
BEFORE  UPDATE
OF      def_priority
ON      defects
FOR EACH ROW
WHEN (new.def_status_code = 'UNAVAIL')
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/update_doe_def_priority.trg-arc   3.3   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   update_doe_def_priority.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:02  $
--       Version          : $Revision:   3.3  $
--
--   Applicable to DoE only: sets DEF_ORIG_PRIORITY
--   same as DEF_PRIORITY as long as status is UNAVAIL
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  :new.def_orig_priority := :new.def_priority;
END;
/
