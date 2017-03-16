-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/log_mai_4700_fix16.sql-arc   1.0   Mar 16 2017 15:00:24   Chris.Baugh  $
--       Module Name      : $Workfile:   log_mai_4700_fix16.sql  $
--       Date into PVCS   : $Date:   Mar 16 2017 15:00:24  $
--       Date fetched Out : $Modtime:   Jul 22 2016 11:53:42  $
--       Version          : $Revision:   1.0  $
------------------------------------------------------------------
--   Copyright (c) 2014 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4700_fix16.sql'
              ,p_remarks        => 'MAI 4700 FIX 16 (Build 5)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
