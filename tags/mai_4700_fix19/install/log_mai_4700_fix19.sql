-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/log_mai_4700_fix19.sql-arc   1.0   Jul 05 2016 09:33:34   Upendra.Hukeri  $
--       Module Name      : $Workfile:   log_mai_4700_fix19.sql  $
--       Date into PVCS   : $Date:   Jul 05 2016 09:33:34  $
--       Date fetched Out : $Modtime:   Jul 05 2016 09:32:26  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2016 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix19.sql'
              ,p_remarks        => 'MAI 4700 FIX 19 (Update 1)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
