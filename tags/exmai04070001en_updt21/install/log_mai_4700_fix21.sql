-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/log_mai_4700_fix21.sql-arc   1.0   Feb 01 2017 13:12:56   Upendra.Hukeri  $
--       Module Name      : $Workfile:   log_mai_4700_fix21.sql  $
--       Date into PVCS   : $Date:   Feb 01 2017 13:12:56  $
--       Date fetched Out : $Modtime:   Feb 01 2017 12:56:24  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2016 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix21.sql'
              ,p_remarks        => 'MAI 4700 FIX 21 (Update 1)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
