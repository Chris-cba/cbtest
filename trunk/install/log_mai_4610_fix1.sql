-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/log_mai_4610_fix1.sql-arc   3.2   Jun 28 2018 07:41:46   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   log_mai_4610_fix1.sql  $
--       Date into PVCS   : $Date:   Jun 28 2018 07:41:46  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:10:44  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4610_fix1.sql'
              ,p_remarks        => 'MAI 4610 FIX 1'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
