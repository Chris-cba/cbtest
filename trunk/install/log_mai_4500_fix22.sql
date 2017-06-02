--------------------------------------------------------------------------------
--   Copyright (c) 2017 Bentley Systems Incorporated.  All rights reserved. 
--------------------------------------------------------------------------------
BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4500_fix22.sql'
              ,p_remarks        => 'MAI 4500 FIX 22 (Build 1)'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
