-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/log_mai_4700_fix20.sql-arc   1.0   Jan 30 2017 11:34:38   Upendra.Hukeri  $
--       Module Name      : $Workfile:   log_mai_4700_fix20.sql  $
--       Date into PVCS   : $Date:   Jan 30 2017 11:34:38  $
--       Date fetched Out : $Modtime:   Jan 30 2017 11:30:10  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2016 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix20.sql'
              ,p_remarks        => 'MAI 4700 FIX 20 (Update 1)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
