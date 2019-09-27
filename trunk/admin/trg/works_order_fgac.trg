CREATE OR REPLACE TRIGGER works_order_fgac
BEFORE INSERT ON WORK_ORDERS
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/works_order_fgac.trg-arc   3.3   Sep 27 2019 15:18:16   Chris.Baugh  $
--       Module Name      : $Workfile:   works_order_fgac.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.3  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
