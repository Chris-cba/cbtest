CREATE OR REPLACE TRIGGER wol_register_as_trg
AFTER INSERT OR UPDATE OR DELETE
ON work_order_lines
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/trg/wol_register_as_trg.trg-arc   2.2   Jun 28 2018 04:36:42   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   wol_register_as_trg.trg  $
--       Date into SCCS   : $Date:   Jun 28 2018 04:36:42  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
--   Process global pl/sql table that is populated by  
--   trigger wol_register_iud_trg
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN

 mai.wol_register_as_trg;

END wol_register_as_trg;
/
