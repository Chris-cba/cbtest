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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/update_doe_def_priority.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   update_doe_def_priority.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:10:50  $
--       Version          : $Revision:   3.0  $
--
--   Applicable to DoE only: sets DEF_ORIG_PRIORITY
--   same as DEF_PRIORITY as long as status is UNAVAIL
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
  :new.def_orig_priority := :new.def_priority;
END;
/
