BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4400_fix1.sql'
              ,p_remarks        => 'MAI 4400 FIX 1'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
