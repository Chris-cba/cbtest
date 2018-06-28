CREATE OR REPLACE TRIGGER work_order_lines_ai_trg 
AFTER INSERT
ON WORK_ORDER_LINES 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/trg/work_order_lines_ai_trg.trg-arc   2.2   Jun 28 2018 04:36:42   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   work_order_lines_ai_trg.trg  $
--       Date into SCCS   : $Date:   Jun 28 2018 04:36:42  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
--
--   WORK_ORDER_LINES trigger to update wor_streetwork_notice flag to 'O'
--   when adding a new instructed works order line
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
DECLARE

 l_instructed_status hig_status_codes.hsc_status_code%TYPE;

BEGIN

 SELECT hsc_status_code  -- instructed
 INTO  l_instructed_status
 FROM hig_status_codes
 WHERE hsc_domain_code = 'WORK_ORDER_LINES'
 AND hsc_allow_feature1 = 'Y';


 IF INSERTING AND :NEW.wol_status = l_instructed_status THEN
 
  update work_orders
  set    wor_streetwork_notice = 'O'
  where  wor_works_order_no = :NEW.wol_works_order_no; 

 END IF;							      


END work_order_lines_ai_trg;
/


