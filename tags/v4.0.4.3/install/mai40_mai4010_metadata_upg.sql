------------------------------------------------------------------
-- mai40_mai4010_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai40_mai4010_metadata_upg.sql-arc   2.0   Jun 13 2007 16:32:36   smarshall  $
--       Module Name      : $Workfile:   mai40_mai4010_metadata_upg.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:36  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.2
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2007
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
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
PROMPT Remove redundant module/role data for MAI3811/MAI3815
SET TERM OFF

-- GJ  03-APR-2007
-- 
-- DEVELOPMENT COMMENTS
-- Module no longer required
------------------------------------------------------------------

delete from hig_module_roles
where hmr_module in ('MAI3815','MAI3811')
/
delete from hig_modules
where hmo_module in ('MAI3815','MAI3811')
/
commit
/
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT NER MAI-924
SET TERM OFF

-- GJ  03-APR-2007
-- 
-- DEVELOPMENT COMMENTS
-- New error message called in MAi3800 when printing the works order details
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
       ,924
       ,null
       ,'Once report has been produced, press OK to refresh data?'
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_ERRORS
                   WHERE NER_APPL = 'MAI'
                    AND  NER_ID = 924);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Metadata required to support trapping of duplicate works order numbers
SET TERM OFF

-- GJ  03-APR-2007
-- 
-- DEVELOPMENT COMMENTS
-- Now that there is a PK constraint on WORK_ORDERS we can trap violation of this constraint in MAI3800 without the need to write bespoke code.
------------------------------------------------------------------
INSERT INTO NM_ERRORS ( NER_APPL
                      , NER_ID
                      , NER_HER_NO
                      , NER_DESCR
                      , NER_CAUSE ) 
SELECT 'MAI'
      , 133
      , NULL, 'Another Works Order already exists with this number'
      , NULL
FROM dual
WHERE NOT EXISTS (SELECT 'x'
                  FROM nm_errors
                  WHERE ner_appl = 'MAI'
                  AND   ner_id = 133)
/
INSERT INTO HIG_CHECK_CONSTRAINT_ASSOCS ( HCCA_CONSTRAINT_NAME
                                        , HCCA_TABLE_NAME
                                        , HCCA_NER_APPL
                                        , HCCA_NER_ID ) 
SELECT 'WOR_PK'
     , 'WORK_ORDERS'
     , 'MAI'
     , 133
FROM dual
WHERE NOT EXISTS (SELECT 'x'
                  FROM hig_check_constraint_assocs
                  WHERE hcca_constraint_name = 'WOR_PK')
/
COMMIT
/

------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
COMMIT
/
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

