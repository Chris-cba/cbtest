CREATE OR REPLACE TRIGGER works_order_fgac
BEFORE INSERT ON WORK_ORDERS
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/works_order_fgac.trg-arc   3.1   Jul 01 2013 15:53:20   James.Wadsworth  $
--       Module Name      : $Workfile:   works_order_fgac.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:53:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
