CREATE OR REPLACE TRIGGER works_order_fgac
BEFORE INSERT ON WORK_ORDERS
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/works_order_fgac.trg-arc   3.0   Nov 05 2009 11:18:48   gjohnson  $
--       Module Name      : $Workfile:   works_order_fgac.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:48  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:17:00  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
   --
   -- Get Agency Context
   -- Only set the Agency code if User inserting does not have top level access
   --
   IF mai.GET_ICB_FGAC_CONTEXT(FALSE) != mai.GET_ICB_FGAC_CONTEXT(TRUE) THEN
     --
     :new.wor_agency := mai.GET_ICB_FGAC_CONTEXT(FALSE);
     --
   END IF;
   --
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END works_order_fgac;
/
