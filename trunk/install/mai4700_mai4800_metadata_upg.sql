------------------------------------------------------------------
-- mai4700_mai4800_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/install/mai4700_mai4800_metadata_upg.sql-arc   1.0   Oct 10 2019 09:29:12   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4700_mai4800_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Oct 10 2019 09:29:12  $
--       Date fetched Out : $Modtime:   Oct 03 2019 10:57:28  $
--       Version          : $Revision:   1.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2014

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
SET TERM ON
PROMPT New Product Option DEFDOCCAT
SET TERM OFF
INSERT INTO HIG_OPTION_LIST 
           (HOL_ID,
            HOL_PRODUCT,
            HOL_NAME,
            HOL_REMARKS,
            HOL_DOMAIN,
            HOL_DATATYPE,
            HOL_MIXED_CASE,
            HOL_USER_OPTION)
SELECT 'DEFDOCCAT',
             'MAI',
             'Default Document Category',
             'Contains the default Document Category for Defect document attachments loaded via Maintenace Inspection Loader.',
             '',
             'VARCHAR2',
             'N',
             'Y'
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                  FROM HIG_OPTION_LIST
                  WHERE HOL_ID = 'DEFDOCCAT'
                  )
/

INSERT INTO HIG_OPTION_VALUES
           (HOV_ID, 
            HOV_VALUE
           )  
SELECT 'DEFDOCCAT'
      ,'<TO BE DEFINED>'
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                    FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFDOCCAT'
                 )
/

------------------------------------------------------------------
SET TERM ON
PROMPT User Option DEFDOCTYPE and DEFDOCLOCN
SET TERM OFF
UPDATE HIG_OPTION_LIST
SET HOL_USER_OPTION ='Y'
WHERE HOL_ID in ('DEFDOCTYPE','DEFDOCLOCN')
/
------------------------------------------------------------------
SET TERM ON
PROMPT Alert Manager Lookup Parameters Metadata
SET TERM OFF
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -17
       ,'DEF$'
       ,'Asset Primary Key'
       ,'select  iit_primary_key from nm_inv_items_all where iit_ne_id = :1'
       ,'DEF_IIT_ITEM_ID'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -17);
--
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -16
       ,'DEF$'
       ,'Inspector'
       ,'select hc.hus_name from hig_users hc,activities_report are where are.are_peo_person_id_actioned = hc.hus_user_id and are.are_report_id=:1'
       ,'def_are_report_id'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -16);
--
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -15
       ,'DEF$'
       ,'Initiation Type'
       ,'select hc.hco_meaning from hig_codes hc, activities_report are where hc.hco_domain =''INITIATION_TYPE'' and sysdate between nvl( hc.hco_start_date, sysdate ) and nvl( hc.hco_end_date, sysdate ) and hc.hco_code = are.are_initiation_type and are.are_report_id = :1'
       ,'def_are_report_id'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120240','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -15);
--
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -14
       ,'DEF$'
       ,'Asset Type'
       ,'select nt.nit_descr from nm_inv_items_all ni,nm_inv_types_all nt where ni.iit_ne_id = :1 and nt.nit_inv_type=ni.iit_inv_type'
       ,'DEF_IIT_ITEM_ID'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -14);
--
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -13
       ,'DEF$'
       ,'Asset Description'
       ,'select iit_descr from nm_inv_items_all  where iit_ne_id = :1'
       ,'DEF_IIT_ITEM_ID'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -13);
--
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -12
       ,'WOR$'
       ,'Contractor Contact'
       ,'select ou.oun_contact_name from contracts c , org_units ou where con_id=:1  and ou.oun_org_unit_type = ''CO'' and ou.oun_org_id = c.con_contr_org_id'
       ,'wor_con_id'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120241','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -12);
--
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -11
       ,'WOR$'
       ,'Contractor Name'
       ,'select ou.oun_name from contracts c, org_units ou where con_id =:1 and ou.oun_org_unit_type = ''CO'' and ou.oun_org_id = c.con_contr_org_id'
       ,'wor_con_id'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -11);
--
INSERT INTO HIG_ALERT_TYPE_MAIL_LOOKUP
       (HATML_ID
       ,HATML_INV_TYPE
       ,HATML_SCREEN_TEXT
       ,HATML_QUERY
       ,HATML_QUERY_COL
       ,HATML_DATE_CREATED
       ,HATML_CREATED_BY
       ,HATML_DATE_MODIFIED
       ,HATML_MODIFIED_BY
       )
SELECT 
        -10
       ,'WOR$'
       ,'Contractor Phone'
       ,'select ou.oun_phone from contracts c,org_units ou where con_id = :1 and ou.oun_org_unit_type=''CO'' and ou.oun_org_id=c.con_contr_org_id'
       ,'wor_con_id'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA'
       ,to_date('20150317120242','YYYYMMDDHH24MISS')
       ,'MAI_METADATA' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ALERT_TYPE_MAIL_LOOKUP
                   WHERE HATML_ID = -10);

------------------------------------------------------------------
SET TERM ON
PROMPT New Product Options MCPWOLTHME, MCPDMTEMPL, MCPDMCLASS
SET TERM OFF
SET TERM ON
PROMPT hig_option_list
SET TERM OFF

INSERT INTO HIG_OPTION_LIST 
           (HOL_ID,
            HOL_PRODUCT,
            HOL_NAME,
            HOL_REMARKS,
            HOL_DOMAIN,
            HOL_DATATYPE,
            HOL_MIXED_CASE,
            HOL_USER_OPTION,
            HOL_MAX_LENGTH
            )
SELECT 'MCPWOLTHME'
      ,'MAI'
      ,'Mapcapture WOL Theme'
      ,'Defines the Theme used by New Mapcapture to identify Work Order and Defect details used to produce CIM WC File'
      ,NULL
      ,'VARCHAR2'
      ,'N'
      ,'N'
      ,2000
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                    FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'MCPWOLTHME'
                 )
/
--
INSERT INTO HIG_OPTION_LIST 
           (HOL_ID,
            HOL_PRODUCT,
            HOL_NAME,
            HOL_REMARKS,
            HOL_DOMAIN,
            HOL_DATATYPE,
            HOL_MIXED_CASE,
            HOL_USER_OPTION,
            HOL_MAX_LENGTH
            )
SELECT 'MCPDMTEMPL'
      ,'MAI'
      ,'MCP Doc. Man. Template'
      ,'Defines the Document Manager Template name used for New Mapcapture'
      ,NULL
      ,'VARCHAR2'
      ,'N'
      ,'N'
      ,2000
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                    FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'MCPDMTEMPL'
                 )
/
--
INSERT INTO HIG_OPTION_LIST 
           (HOL_ID,
            HOL_PRODUCT,
            HOL_NAME,
            HOL_REMARKS,
            HOL_DOMAIN,
            HOL_DATATYPE,
            HOL_MIXED_CASE,
            HOL_USER_OPTION,
            HOL_MAX_LENGTH
            )
SELECT 'MCPDMCLASS'
      ,'MAI'
      ,'MCP Doc. Man. Class'
      ,'Defines the Document Manager Class name used for New Mapcapture'
      ,NULL
      ,'VARCHAR2'
      ,'N'
      ,'N'
      ,2000
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                    FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'MCPDMCLASS'
                 )
/

--
--------------------------------------------------------------------------------
-- HIG_OPTION_VALUES
--------------------------------------------------------------------------------
--
--
SET TERM ON
PROMPT hig_option_values
SET TERM OFF

INSERT INTO HIG_OPTION_VALUES
           (HOV_ID, 
            HOV_VALUE
           )  
SELECT 'MCPWOLTHME'
      ,'<TO BE DEFINED>'
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                    FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'MCPWOLTHME'
                 )
/
--
INSERT INTO HIG_OPTION_VALUES
           (HOV_ID, 
            HOV_VALUE
           )  
SELECT 'MCPDMTEMPL'
      ,'<TO BE DEFINED>'
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                    FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'MCPDMTEMPL'
                 )
/
--
INSERT INTO HIG_OPTION_VALUES
           (HOV_ID, 
            HOV_VALUE
           )  
SELECT 'MCPDMCLASS'
      ,'<TO BE DEFINED>'
FROM DUAL
WHERE NOT EXISTS (SELECT 1
                    FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'MCPDMCLASS'
                 )
/
------------------------------------------------------------------
SET TERM ON
PROMPT BREAKDOWN_HEADINGS domain
SET TERM OFF
SET TERM ON
PROMPT hig_domains
SET TERM OFF

INSERT INTO HIG_DOMAINS
       (HDO_DOMAIN
       ,HDO_PRODUCT
       ,HDO_TITLE
       ,HDO_CODE_LENGTH
       )
SELECT 
        'BREAKDOWN_HEADINGS'
       ,'MAI'
       ,'MAI3880 Breakdown Column_Headings'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_DOMAINS
                   WHERE HDO_DOMAIN = 'BREAKDOWN_HEADINGS');
--
INSERT INTO HIG_CODES
       (HCO_DOMAIN
       ,HCO_CODE
       ,HCO_MEANING
       ,HCO_SYSTEM
       ,HCO_SEQ
       ,HCO_START_DATE
       ,HCO_END_DATE
       )
SELECT 
        'BREAKDOWN_HEADINGS'
       ,'VALUE 1'
       ,'Update before using breakdown'
       ,'Y'
       ,1
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_CODES
                   WHERE HCO_DOMAIN = 'BREAKDOWN_HEADINGS'
                    AND  HCO_CODE = 'VALUE 1');

------------------------------------------------------------------
SET TERM ON
PROMPT New Product Options DEFPHOTTEM and COMMTEMPLA
SET TERM OFF
INSERT INTO hig_option_list
    (SELECT 'DEFPHOTTEM',
            'MAI',
            'eB Template Id for defects',
            'eB template ID for creating documents for defects.',
            NULL,
            'NUMBER',
            'N',
            'N',
            2000
       FROM DUAL
      WHERE NOT EXISTS
                (SELECT 1
                   FROM hig_option_list
                  WHERE hol_id = 'DEFPHOTTEM'))
/

INSERT INTO hig_option_values
    (SELECT 'DEFPHOTTEM', 1234
       FROM DUAL
      WHERE NOT EXISTS
                (SELECT 1
                   FROM hig_option_values
                  WHERE hov_id = 'DEFPHOTTEM'))
/


INSERT INTO hig_option_list
    (SELECT 'COMMTEMPLA',
            'MAI',
            'eB Template Id for comments',
            'eB template ID for creating commnets document.',
            NULL,
            'NUMBER',
            'N',
            'N',
            2000
       FROM DUAL
      WHERE NOT EXISTS
                (SELECT 1
                   FROM hig_option_list
                  WHERE hol_id = 'COMMTEMPLA'))
/

INSERT INTO hig_option_values
    (SELECT 'COMMTEMPLA', 1234
       FROM DUAL
      WHERE NOT EXISTS
                (SELECT 1
                   FROM hig_option_values
                  WHERE hov_id = 'COMMTEMPLA'))
/
------------------------------------------------------------------
SET TERM ON
PROMPT New Product Options DEFPHOTFSM and DEFPHOTLM
SET TERM OFF
INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       ,HOL_MAX_LENGTH
       )
SELECT 
        'DEFPHOTFSM'
       ,'MAI'
       ,'Defect Photo files per record'
       ,'If set to N files will be loaded as one record per file if set to yes files will be loaded all files in one record max 20 files'
       ,NULL
       ,'VARCHAR2'
       ,'N'
       ,'N'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFPHOTFSM')
/

INSERT INTO HIG_OPTION_LIST
       (HOL_ID
       ,HOL_PRODUCT
       ,HOL_NAME
       ,HOL_REMARKS
       ,HOL_DOMAIN
       ,HOL_DATATYPE
       ,HOL_MIXED_CASE
       ,HOL_USER_OPTION
       ,HOL_MAX_LENGTH
       )
SELECT 
        'DEFPHOTLM'
       ,'MAI'
       ,'Defect Photo Title'
       ,'Title for MAI photo records'
       ,NULL
       ,'VARCHAR2'
       ,'N'
       ,'N'
       ,30 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_LIST
                   WHERE HOL_ID = 'DEFPHOTLM')
/

----------------------------------------------------------------------------------------
-- HIG_OPTION_VALUES
--
-- select * from nm3_metadata.hig_option_values
-- order by hov_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_option_values
SET TERM OFF

INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFPHOTFSM'
       ,'N' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFPHOTFSM')
/

INSERT INTO HIG_OPTION_VALUES
       (HOV_ID
       ,HOV_VALUE
       )
SELECT 
        'DEFPHOTLM'
       ,'DEFECT BEFORE PHOTO' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_OPTION_VALUES
                   WHERE HOV_ID = 'DEFPHOTLM')
/
------------------------------------------------------------------
Commit;

------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

