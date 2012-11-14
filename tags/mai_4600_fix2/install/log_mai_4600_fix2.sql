BEGIN
--
  hig2.upgrade(p_product        => 'MAI'
              ,p_upgrade_script => 'log_mai_4600_fix2.sql'
              ,p_remarks        => 'MAI 4600 FIX 2'
              ,p_to_version     => Null);
--
  commit;
--
EXCEPTION
  WHEN others THEN Null;
END;
/
