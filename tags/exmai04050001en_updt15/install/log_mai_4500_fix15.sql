BEGIN
	--
	hig2.upgrade(p_product        => 'MAI'
				,p_upgrade_script => 'log_mai_4500_fix15.sql'
				,p_remarks        => 'MAI 4500 FIX 15'
				,p_to_version     => NULL
				);
	--
	COMMIT;
	--
EXCEPTION 
	WHEN OTHERS THEN
	--
		NULL;
	--
END;
/
