--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix5_metadata_upg.sql-arc   1.1   Jul 01 2013 16:01:50   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4300_fix5_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       PVCS Version     : $Revision:   1.1  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
