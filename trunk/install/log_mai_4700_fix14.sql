BEGIN
	--
	hig2.upgrade(p_product        => 'MAI'
				,p_upgrade_script => 'log_mai_4700_fix14.sql'
				,p_remarks        => 'MAI 4700 FIX 14 (Build 2)'
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
