------------------------------------------------------------------
-- mai4020_mai4022_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4020_mai4022_metadata_upg.sql-arc   2.0   Nov 28 2007 08:56:38   jwadsworth  $
--       Module Name      : $Workfile:   mai4020_mai4022_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Nov 28 2007 08:56:38  $
--       Date fetched Out : $Modtime:   Nov 28 2007 08:56:16  $
--       Version          : $Revision:   2.0  $
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
PROMPT mai3970_metadata
SET TERM OFF

-- MH  22-NOV-2007
-- 
-- DEVELOPMENT COMMENTS
-- Metadata for new Print Gang Work Orders report.
------------------------------------------------------------------
INSERT INTO hig_modules
      (hmo_module
      ,hmo_title
      ,hmo_filename
      ,hmo_module_type
      ,hmo_fastpath_opts
      ,hmo_fastpath_invalid
      ,hmo_use_gri
      ,hmo_application
      ,hmo_menu
      )
SELECT
       'MAI3970'
      ,'Print Gang Work Orders'
      ,'mai3970'
      ,'R25'
      ,NULL
      ,'N'
      ,'Y'
      ,'MAI'
      ,'FORM'
  FROM dual
 WHERE NOT EXISTS(SELECT 1
                    FROM hig_modules
                   WHERE hmo_module = 'MAI3970');

INSERT INTO hig_module_roles
      (hmr_module
      ,hmr_role
      ,hmr_mode
      )
SELECT 'MAI3970'
      ,'MAI_ADMIN'
      ,'NORMAL'
 FROM  dual
WHERE NOT EXISTS (SELECT 1
                   FROM  hig_module_roles
                  WHERE  hmr_module = 'MAI3970'
                   AND   hmr_role   = 'MAI_ADMIN'
                 )
 AND  EXISTS     (SELECT 1
                   FROM  hig_roles
                  WHERE  hro_role   = 'MAI_ADMIN'
                 )
 AND  EXISTS     (SELECT 1
                   FROM  hig_modules
                  WHERE  hmo_module = 'MAI3970'
                 );

INSERT INTO hig_module_roles
      (hmr_module
      ,hmr_role
      ,hmr_mode
      )
SELECT 'MAI3970'
      ,'MAI_USER'
      ,'NORMAL'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                    FROM  hig_module_roles
                   WHERE  hmr_module = 'MAI3970'
                    AND   hmr_role   = 'MAI_USER'
                  )
  AND  EXISTS     (SELECT 1
                    FROM  hig_roles
                   WHERE  hro_role   = 'MAI_USER'
                  )
  AND  EXISTS     (SELECT 1
                    FROM  hig_modules
                   WHERE  hmo_module = 'MAI3970'
                  );

INSERT INTO hig_module_roles
      (hmr_module
      ,hmr_role
      ,hmr_mode
      )
SELECT 'MAI3970'
      ,'MAI_READONLY'
      ,'READONLY'
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                    FROM  hig_module_roles
                   WHERE  hmr_module = 'MAI3970'
                    AND   hmr_role   = 'MAI_READONLY'
                  )
  AND  EXISTS     (SELECT 1
                    FROM  hig_roles
                   WHERE  hro_role   = 'MAI_READONLY'
                  )
  AND  EXISTS     (SELECT 1
                    FROM  hig_modules
                   WHERE  hmo_module = 'MAI3970'
                  );

INSERT INTO HIG_STANDARD_FAVOURITES
       (HSTF_PARENT
       ,HSTF_CHILD
       ,HSTF_DESCR
       ,HSTF_TYPE
       ,HSTF_ORDER
       )
SELECT 
       'MAI_WORKS_REPORTS'
      ,'MAI3970'
      ,'Print Gang Work Orders'
      ,'M'
      ,3
  FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_STANDARD_FAVOURITES
                   WHERE HSTF_PARENT = 'MAI_WORKS_REPORTS'
                     AND  HSTF_CHILD = 'MAI3970');

INSERT INTO GRI_PARAMS
      (gp_param
      ,gp_param_type
      ,gp_table
      ,gp_column
      ,gp_descr_column
      ,gp_shown_column
      ,gp_shown_type
      ,gp_descr_type
      ,gp_order
      ,gp_case
      ,gp_gaz_restriction)
SELECT
       'GANG'
      ,'NUMBER'
      ,'HIG_CODES'
      ,'TO_NUMBER(HCO_CODE)'
      ,'HCO_MEANING'
      ,'HCO_CODE'
      ,'CHAR'
      ,'CHAR'
      ,NULL
      ,NULL
      ,NULL
  FROM DUAL
 WHERE NOT EXISTS (SELECT 1
                     FROM GRI_PARAMS
                    WHERE GP_PARAM = 'GANG');

INSERT INTO GRI_MODULES
      (GRM_MODULE
      ,GRM_MODULE_TYPE
      ,GRM_MODULE_PATH
      ,GRM_FILE_TYPE
      ,GRM_TAG_FLAG
      ,GRM_TAG_TABLE
      ,GRM_TAG_COLUMN
      ,GRM_TAG_WHERE
      ,GRM_LINESIZE
      ,GRM_PAGESIZE
      ,GRM_PRE_PROCESS
      )
SELECT
       'MAI3970'
      ,'N/A'
      ,'$PROD_HOME/bin'
      ,'lis'
      ,'N'
      ,NULL
      ,NULL
      ,NULL
      ,80
      ,66
      ,NULL
  FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM GRI_MODULES
                   WHERE GRM_MODULE = 'MAI3970');

INSERT INTO gri_module_params
      (gmp_module
      ,gmp_param
      ,gmp_seq
      ,gmp_param_descr
      ,gmp_mandatory
      ,gmp_no_allowed
      ,gmp_where
      ,gmp_tag_restriction
      ,gmp_tag_where
      ,gmp_default_table
      ,gmp_default_column
      ,gmp_default_where
      ,gmp_visible
      ,gmp_gazetteer
      ,gmp_lov
      ,gmp_val_global
      ,gmp_wildcard
      ,gmp_hint_text
      ,gmp_allow_partial
      ,gmp_base_table
      ,gmp_base_table_column
      ,gmp_operator      
      )
SELECT
       'MAI3970'
      ,'GANG'
      ,1
      ,'Gang'
      ,'Y' 
      ,1
      ,'HCO_DOMAIN=''GANG'' AND SYSDATE BETWEEN NVL(HCO_START_DATE,SYSDATE) AND NVL(HCO_END_DATE,SYSDATE)'
      ,'N'
      ,NULL
      ,NULL 
      ,NULL
      ,NULL
      ,'Y'
      ,'N'
      ,'Y'
      ,NULL
      ,'N'
      ,'Enter The Gang For The Report'
      ,'N'
      ,NULL
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM gri_module_params
                    WHERE gmp_module = 'MAI3970'
                      AND gmp_param  = 'GANG');

INSERT INTO gri_module_params
      (gmp_module
      ,gmp_param
      ,gmp_seq
      ,gmp_param_descr
      ,gmp_mandatory
      ,gmp_no_allowed
      ,gmp_where
      ,gmp_tag_restriction
      ,gmp_tag_where
      ,gmp_default_table
      ,gmp_default_column
      ,gmp_default_where
      ,gmp_visible
      ,gmp_gazetteer
      ,gmp_lov
      ,gmp_val_global
      ,gmp_wildcard
      ,gmp_hint_text
      ,gmp_allow_partial
      ,gmp_base_table
      ,gmp_base_table_column
      ,gmp_operator
      )
SELECT 'MAI3970'
      ,'ORDER_SHEET_BOTH'
      ,2
      ,'Wrks Ord/Ctrl Sht/Both'
      ,'Y'
      ,1
      ,'GPL_PARAM=''ORDER_SHEET_BOTH'''
      ,'N'
      ,NULL
      ,'GRI_PARAM_LOOKUP'
      ,'GPL_VALUE'
      ,'GPL_VALUE=''W'' AND GPL_PARAM=''ORDER_SHEET_BOTH'''
      ,'Y'
      ,'N'
      ,'Y'
      ,NULL
      ,'N'
      ,'Enter W - Works Order, C - Control Sheet, B - Both'
      ,'N'
      ,NULL
      ,NULL
      ,NULL
  FROM dual
 WHERE NOT EXISTS (SELECT 1
                     FROM gri_module_params
                    WHERE gmp_module = 'MAI3970'
                      AND gmp_param  = 'ORDER_SHEET_BOTH');

COMMIT;

------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
COMMIT
/
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

