CREATE OR REPLACE TRIGGER work_orders_register_trg
BEFORE INSERT OR UPDATE OF wor_register_flag ON WORK_ORDERS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/trg/work_orders_register_trg.trg-arc   2.1   Jul 01 2013 15:53:20   James.Wadsworth  $
--       Module Name      : $Workfile:   work_orders_register_trg.trg  $
--       Date into SCCS   : $Date:   Jul 01 2013 15:53:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
--
--
--   WORK_ORDERS trigger to update wor_register_status depending on the value of the flag
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
BEGIN

 :NEW.wor_register_status := mai.determine_reg_status_for_flag(pi_works_order_no    => :NEW.wor_works_order_no
                                                              ,pi_wor_register_flag => :NEW.wor_register_flag);

END work_orders_register_trg;
/
