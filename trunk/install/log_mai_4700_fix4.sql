-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/log_mai_4700_fix4.sql-arc   3.0   Oct 23 2014 15:16:30   Mike.Huitson  $
--       Module Name      : $Workfile:   log_mai_4700_fix4.sql  $
--       Date into PVCS   : $Date:   Oct 23 2014 15:16:30  $
--       Date fetched Out : $Modtime:   Oct 23 2014 15:11:28  $
--       Version          : $Revision:   3.0  $
------------------------------------------------------------------
--   Copyright (c) 2014 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix4.sql'
              ,p_remarks        => 'MAI 4700 FIX 4'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
