--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/log_mai_4210_fix1.sql-arc   3.0   Aug 04 2010 11:56:12   malexander  $
--       Module Name      : $Workfile:   log_mai_4210_fix1.sql  $
--       Date into PVCS   : $Date:   Aug 04 2010 11:56:12  $
--       Date fetched Out : $Modtime:   Aug 04 2010 11:55:50  $
--       PVCS Version     : $Revision:   3.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2010
--------------------------------------------------------------------------------
--
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4210_fix1.sql'
              ,p_remarks        => 'MAI 4210 FIX 1'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
