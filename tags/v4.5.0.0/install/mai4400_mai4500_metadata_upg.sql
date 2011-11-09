------------------------------------------------------------------
-- mai4400_mai4500_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4400_mai4500_metadata_upg.sql-arc   3.1   Nov 09 2011 15:41:00   Mike.Alexander  $
--       Module Name      : $Workfile:   mai4400_mai4500_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Nov 09 2011 15:41:00  $
--       Date fetched Out : $Modtime:   Nov 09 2011 15:31:56  $
--       Version          : $Revision:   3.1  $
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
SET TERM ON
PROMPT New Product Option UPDWOTGT
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 111604
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (CHRIS BAUGH)
-- Product option to allow for manual update of WO target date
-- 
------------------------------------------------------------------
insert into hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
select 'UPDWOTGT'
      ,'MAI'
      ,'Allow update to WO Target Date'      
      ,'If set to Y, the WO Target Date will allow manual update '
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'UPDWOTGT');

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'UPDWOTGT'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'UPDWOTGT')
/
------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

