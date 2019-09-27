CREATE OR REPLACE TRIGGER wol_register_bs_trg
BEFORE INSERT OR UPDATE OR DELETE
ON work_order_lines
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/trg/wol_register_bs_trg.trg-arc   2.3   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   wol_register_bs_trg.trg  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:02  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.1
--
--   Clear out global pl/sql table that is populated by  
--   trigger wol_register_iud_trg
--
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN

 mai.wol_register_bs_trg;

END wol_register_bs_trg;
/
