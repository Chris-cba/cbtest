-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/log_mai_4700_fix22.sql-arc   1.0   Apr 05 2017 08:58:00   Upendra.Hukeri  $
--       Module Name      : $Workfile:   log_mai_4700_fix22.sql  $
--       Date into PVCS   : $Date:   Apr 05 2017 08:58:00  $
--       Date fetched Out : $Modtime:   Apr 05 2017 08:48:54  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2017 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix22.sql'
              ,p_remarks        => 'MAI 4700 FIX 22 (Update 1)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
