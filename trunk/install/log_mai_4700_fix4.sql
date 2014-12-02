-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/log_mai_4700_fix4.sql-arc   3.1   Dec 02 2014 14:34:40   Mike.Huitson  $
--       Module Name      : $Workfile:   log_mai_4700_fix4.sql  $
--       Date into PVCS   : $Date:   Dec 02 2014 14:34:40  $
--       Date fetched Out : $Modtime:   Dec 02 2014 14:33:18  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2014 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix4.sql'
              ,p_remarks        => 'MAI 4700 FIX 4 (Build 2)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
