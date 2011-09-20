------------------------------------------------------------------
-- mai4400_mai4500_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4400_mai4500_metadata_upg.sql-arc   3.0   Sep 20 2011 15:43:34   Mike.Alexander  $
--       Module Name      : $Workfile:   mai4400_mai4500_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Sep 20 2011 15:43:34  $
--       Date fetched Out : $Modtime:   Sep 20 2011 15:24:08  $
--       Version          : $Revision:   3.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2011

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF

DECLARE
  l_temp nm3type.max_varchar2;
BEGIN
  -- Dummy call to HIG to instantiate it
  l_temp := hig.get_version;
  l_temp := nm_debug.get_version;
EXCEPTION
  WHEN others
   THEN
 Null;
END;
/

BEGIN
  nm_debug.debug_off;
END;
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New NM_ERRORS entries for % Uplift
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109785
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- New NM_ERRORS entry for % Uplift
-- 
------------------------------------------------------------------
INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,933
       ,null
       ,'Percent Uplift Standard Item has been assigned to a Work Order Line .'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 933);

INSERT INTO NM_ERRORS
       (NER_APPL
       ,NER_ID
       ,NER_HER_NO
       ,NER_DESCR
       ,NER_CAUSE
       )
SELECT 
        'MAI'
       ,934
       ,null
       ,'Contract does not allow Percent Uplift assignments, or Work Order contains invalid Percent Uplift items .'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 934);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Modification to Inspection Loader NM_ERRORS 9204 and 9402
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 110658
-- 
-- TASK DETAILS
-- A number of error messages used by the Maintenance Inspection Loader have been altered to provide a better description of the problem.
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Modification to correct messaging for NM_ERROR entries 9402 and 9204
-- 
------------------------------------------------------------------
UPDATE nm_errors
SET ner_descr = 'Error : Chainage on P record exceeds required chainage for section. : Correct the section chainage.'
WHERE ner_appl = 'MAI'
AND ner_id = 9402
/

UPDATE nm_errors
SET ner_descr = 'Error : Invalid inspection initiation time. : Correct the Inspection time in the G record.'
WHERE ner_appl = 'MAI'
AND ner_id = 9204
/
------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

