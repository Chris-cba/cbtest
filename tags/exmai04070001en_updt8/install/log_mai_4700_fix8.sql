-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/log_mai_4700_fix8.sql-arc   1.0   10 Dec 2014 15:52:30   Mike.Huitson  $
--       Module Name      : $Workfile:   log_mai_4700_fix8.sql  $
--       Date into PVCS   : $Date:   10 Dec 2014 15:52:30  $
--       Date fetched Out : $Modtime:   09 Dec 2014 21:12:38  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2014 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix7.8ql'
              ,p_remarks        => 'MAI 4700 FIX 8 (Build 1)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
