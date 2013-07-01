-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/log_mai_4210_fix5.sql-arc   3.1   Jul 01 2013 16:16:20   James.Wadsworth  $
--       Module Name      : $Workfile:   log_mai_4210_fix5.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:16:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:08:02  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4210_fix5.sql'
              ,p_remarks        => 'MAI 4210 FIX 5'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
