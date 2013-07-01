-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/log_mai_4610_fix1.sql-arc   3.1   Jul 01 2013 16:16:24   James.Wadsworth  $
--       Module Name      : $Workfile:   log_mai_4610_fix1.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:16:24  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:10:44  $
--       Version          : $Revision:   3.1  $
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
