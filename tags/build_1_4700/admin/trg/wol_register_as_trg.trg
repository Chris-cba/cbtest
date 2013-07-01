CREATE OR REPLACE TRIGGER wol_register_as_trg
AFTER INSERT OR UPDATE OR DELETE
ON work_order_lines
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/trg/wol_register_as_trg.trg-arc   2.1   Jul 01 2013 15:53:20   James.Wadsworth  $
--       Module Name      : $Workfile:   wol_register_as_trg.trg  $
--       Date into SCCS   : $Date:   Jul 01 2013 15:53:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
--   Process global pl/sql table that is populated by  
--   trigger wol_register_iud_trg
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN

 mai.wol_register_as_trg;

END wol_register_as_trg;
/
