--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix5_metadata_upg.sql-arc   1.0   Mar 16 2011 14:14:50   Mike.Huitson  $
--       Module Name      : $Workfile:   mai_4300_fix5_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Mar 16 2011 14:14:50  $
--       Date fetched Out : $Modtime:   Mar 16 2011 11:31:00  $
--       PVCS Version     : $Revision:   1.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2010
--------------------------------------------------------------------------------
--

UPDATE nm_errors
SET ner_descr = 'I, L, M, N, P or R record must follow a K record'
WHERE ner_appl = 'MAI'
AND ner_id = 9526
/

UPDATE nm_errors
SET ner_descr = 'I, M, N, P, Q or R record must follow a L Record'
WHERE ner_appl = 'MAI'
AND ner_id = 9527
/

COMMIT;