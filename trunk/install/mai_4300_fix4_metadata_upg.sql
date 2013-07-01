--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix4_metadata_upg.sql-arc   1.1   Jul 01 2013 16:01:50   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4300_fix4_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       PVCS Version     : $Revision:   1.1  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
--------------------------------------------------------------------------------
--
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,9547
       ,null
       ,'Please Select An Inspection To Be Re-Submitted.'
       ,''
  FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 9547);
--
UPDATE hig_modules
   SET hmo_title = 'Maintenance Inspection Summary/Error Correction'
 WHERE hmo_module = 'MAI4405';
--
UPDATE hig_standard_favourites
   SET hstf_descr = 'Maintenance Inspection Summary/Error Correction'
 WHERE hstf_child = 'MAI4405';
--
COMMIT;
