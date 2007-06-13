CREATE OR REPLACE TRIGGER wol_register_as_trg
AFTER INSERT OR UPDATE OR DELETE
ON work_order_lines
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/trg/wol_register_as_trg.trg-arc   2.0   Jun 13 2007 16:23:02   smarshall  $
--       Module Name      : $Workfile:   wol_register_as_trg.trg  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:23:02  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:22:42  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
--   Process global pl/sql table that is populated by  
--   trigger wol_register_iud_trg
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2006
-----------------------------------------------------------------------------
BEGIN

 mai.wol_register_as_trg;

END wol_register_as_trg;
/
