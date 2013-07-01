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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/update_doe_def_priority.trg-arc   3.1   Jul 01 2013 15:53:18   James.Wadsworth  $
--       Module Name      : $Workfile:   update_doe_def_priority.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:53:18  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--   Applicable to DoE only: sets DEF_ORIG_PRIORITY
--   same as DEF_PRIORITY as long as status is UNAVAIL
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN
  :new.def_orig_priority := :new.def_priority;
END;
/
