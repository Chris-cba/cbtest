CREATE OR REPLACE TRIGGER wol_register_iud_trg 
AFTER INSERT OR UPDATE OR DELETE
ON WORK_ORDER_LINES 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/trg/wol_register_iud_trg.trg-arc   2.2   Jun 28 2018 04:36:42   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   wol_register_iud_trg.trg  $
--       Date into SCCS   : $Date:   Jun 28 2018 04:36:42  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
--   Add details of wol to a global pl/sql table that is processed by 
--   trigger wol_register_as_trg
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN

 IF INSERTING OR DELETING OR :NEW.wol_status != :OLD.wol_status THEN
 
   mai.wol_register_iud_trg(pi_wol_works_order_no => NVL(:OLD.wol_works_order_no,:NEW.wol_works_order_no)); -- nvl caters for insert i.e. no :OLD
  
 END IF;							      


END wol_register_iud_trg;
/
