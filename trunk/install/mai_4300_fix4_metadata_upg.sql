--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix4_metadata_upg.sql-arc   1.0   Mar 02 2011 17:42:24   Mike.Huitson  $
--       Module Name      : $Workfile:   mai_4300_fix4_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Mar 02 2011 17:42:24  $
--       Date fetched Out : $Modtime:   Mar 02 2011 17:40:56  $
--       PVCS Version     : $Revision:   1.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) exor corporation ltd, 2010
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
