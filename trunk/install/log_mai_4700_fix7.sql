-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/log_mai_4700_fix7.sql-arc   3.0   Dec 03 2014 10:07:32   Mike.Huitson  $
--       Module Name      : $Workfile:   log_mai_4700_fix7.sql  $
--       Date into PVCS   : $Date:   Dec 03 2014 10:07:32  $
--       Date fetched Out : $Modtime:   Dec 03 2014 09:55:24  $
--       Version          : $Revision:   3.0  $
------------------------------------------------------------------
--   Copyright (c) 2014 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix7.sql'
              ,p_remarks        => 'MAI 4700 FIX 7 (Build 1)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
