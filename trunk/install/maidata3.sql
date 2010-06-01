-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/maidata3.sql-arc   2.8   Jun 01 2010 12:03:04   malexander  $
--       Module Name      : $Workfile:   maidata3.sql  $
--       Date into PVCS   : $Date:   Jun 01 2010 12:03:04  $
--       Date fetched Out : $Modtime:   Jun 01 2010 11:54:52  $
--       Version          : $Revision:   2.8  $
--       Table Owner      : MAI_METADATA
--       Generation Date  : 01-JUN-2010 11:54
--
--   Product metadata script
--   As at Release 4.2.1.0
--
--   Copyright (c) exor corporation ltd, 2010
--
--   TABLES PROCESSED
--   ================
--   HIG_ROLES
--   HIG_MODULE_ROLES
--   DOC_GATEWAYS
--   DOC_GATE_SYNS
--   HIG_PROCESS_AREAS
--   HIG_PROCESS_TYPES
--   HIG_PROCESS_TYPE_ROLES
--   HIG_PROCESS_TYPE_FREQUENCIES
--   HIG_PROCESS_TYPE_FILES
--   HIG_PROCESS_TYPE_FILE_EXT
--
-----------------------------------------------------------------------------


set define off;
set feedback off;

---------------------------------
-- START OF GENERATED METADATA --
---------------------------------


----------------------------------------------------------------------------------------
-- HIG_ROLES
--
-- select * from mai_metadata.hig_roles
-- order by hro_role
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_roles
SET TERM OFF

INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'MAI_ADMIN'
       ,'MAI'
       ,'Maintenance Manager Administration' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'MAI_READONLY'
       ,'MAI'
       ,'Maintenance Manager Readonly Access' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'MAI_READONLY');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'MAI_USER'
       ,'MAI'
       ,'Maintenance Manager Updates' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'MAI_USER');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'OVER_BUDGET'
       ,'MAI'
       ,'Allowed to go over budget' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'OVER_BUDGET');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'PMS_ADMIN'
       ,'PMS'
       ,'Structural Projects Administration' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'PMS_ADMIN');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'PMS_READONLY'
       ,'PMS'
       ,'Structural Projects Readonly Access' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'PMS_READONLY');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'PMS_USER'
       ,'PMS'
       ,'Structural Projects Updates' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'PMS_USER');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'STP_ADMIN'
       ,'STP'
       ,'Structural Projects Administration' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'STP_ADMIN');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'STP_READONLY'
       ,'STP'
       ,'Structural Projects Readonly Access' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'STP_READONLY');
--
INSERT INTO HIG_ROLES
       (HRO_ROLE
       ,HRO_PRODUCT
       ,HRO_DESCR
       )
SELECT 
        'STP_USER'
       ,'STP'
       ,'Structural Projects Updates' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_ROLES
                   WHERE HRO_ROLE = 'STP_USER');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_MODULE_ROLES
--
-- select * from mai_metadata.hig_module_roles
-- order by hmr_module
--         ,hmr_role
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_module_roles
SET TERM OFF

INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI0132'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI0132'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI0132'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI0132'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1200'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1200'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1200'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1200'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1200'
       ,'PMS_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1200'
                    AND  HMR_ROLE = 'PMS_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1200'
       ,'PMS_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1200'
                    AND  HMR_ROLE = 'PMS_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1205'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1205'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1205'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1205'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1210'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1210'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1210'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1210'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1230'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1230'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1240'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1240'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1240'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1240'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1280'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1280'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1280'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1280'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1300'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1300'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1300'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1300'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1315'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1315'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1315'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1315'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1320'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1320'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1320'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1320'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1325'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1325'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1325'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1325'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1400'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1400'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1400'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1400'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1400'
       ,'PMS_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1400'
                    AND  HMR_ROLE = 'PMS_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1400'
       ,'PMS_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1400'
                    AND  HMR_ROLE = 'PMS_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1430'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1430'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1430'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1430'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1808'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1808'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1830'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1830'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1830'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1830'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1840'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1840'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1870'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1870'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1870'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1870'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1930'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1930'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1930'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1930'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1940'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1940'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI1940'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI1940'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2100'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2100'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2100C'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2100C'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2100F'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2100F'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2105C'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2105C'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2110'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2110'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2110C'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2110C'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2115'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2115'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2120'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2120'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2120'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2120'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2140'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2140'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2140'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2140'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2200A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2200A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2200B'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2200B'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2200C'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2200C'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2200D'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2200D'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2200E'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2200E'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2200R'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2200R'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2210'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2210'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2220'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2220'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2220'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2220'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2222'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2222'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2222'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2222'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2224'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2224'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2224'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2224'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2250'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2250'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2250'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2250'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2305'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2305'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2306'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2306'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2310A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2310A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2310A'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2310A'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2310A'
       ,'PMS_ADMIN'
       ,'READONLY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2310A'
                    AND  HMR_ROLE = 'PMS_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2310A'
       ,'PMS_USER'
       ,'READONLY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2310A'
                    AND  HMR_ROLE = 'PMS_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2315'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2315'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2315'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2315'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2320'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2320'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2325'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2325'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2325'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2325'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2325A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2325A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2325A'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2325A'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2330'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2330'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2340'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2340'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2340'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2340'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2470'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2470'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2470'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2470'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2500'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2500'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2500A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2500A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2501'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2501'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2510'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2510'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2520'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2520'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2521'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2521'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2530'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2530'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2550'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2550'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2600'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2600'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2730'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2730'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2730'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2730'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2760'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2760'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2760'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2760'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2775'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2775'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2775'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2775'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2780'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2780'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2790'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2790'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI2790'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI2790'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI30060'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI30060'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3100'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3100'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3105'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3105'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3150'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3150'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3150'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3150'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3250'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3250'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3440'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3440'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3440'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3440'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3470'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3470'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3480'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3480'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3485'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3485'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3490'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3490'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3500'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3500'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3505'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3505'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3515'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3515'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3515'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3515'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3516'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3516'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3516'
       ,'MAI_READONLY'
       ,'READONLY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3516'
                    AND  HMR_ROLE = 'MAI_READONLY');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3516'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3516'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3517'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3517'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3517'
       ,'MAI_READONLY'
       ,'READONLY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3517'
                    AND  HMR_ROLE = 'MAI_READONLY');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3517'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3517'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3518'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3518'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3518'
       ,'MAI_READONLY'
       ,'READONLY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3518'
                    AND  HMR_ROLE = 'MAI_READONLY');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3518'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3518'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3610'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3610'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3610'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3610'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3624'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3624'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3624'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3624'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3626'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3626'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3626'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3626'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3628'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3628'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3628'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3628'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3630'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3630'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3632'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3632'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3660'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3660'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3660'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3660'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3662'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3662'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3662'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3662'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3666'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3666'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3666'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3666'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3690'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3690'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3690'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3690'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3692'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3692'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3692'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3692'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3800'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3800'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3800'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3800'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3800A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3800A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3800A'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3800A'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3801'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3801'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3801'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3801'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3801_NET'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3801_NET'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3801_NET'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3801_NET'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3802'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3802'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3803'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3803'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3804'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3804'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3804'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3804'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3805'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3805'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3805'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3805'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3806'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3806'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3806'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3806'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3807'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3807'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3807'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3807'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3807_NET'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3807_NET'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3807_NET'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3807_NET'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3808'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3808'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3808'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3808'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3810'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3810'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3810'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3810'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3812'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3812'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3812'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3812'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3813'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3813'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3814'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3814'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3814'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3814'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3816'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3816'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3816'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3816'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3818'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3818'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3819'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3819'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3820'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3820'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3820'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3820'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3825'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3825'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3825'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3825'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3830'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3830'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3834'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3834'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3840'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3840'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3840A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3840A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3840B'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3840B'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3840C'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3840C'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3841'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3841'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3842'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3842'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3842'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3842'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3844'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3844'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3844'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3844'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3846'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3846'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3846'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3846'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3848'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3848'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3848'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3848'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3850'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3850'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3852'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3852'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3854'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3854'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3856'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3856'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3858'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3858'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3859'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3859'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3859'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3859'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3860'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3860'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3860'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3860'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3862'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3862'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3862'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3862'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3863'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3863'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3863'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3863'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3865'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3865'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3865'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3865'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3880'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3880'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3880'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3880'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3881'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3881'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3881'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3881'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3881'
       ,'PMS_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3881'
                    AND  HMR_ROLE = 'PMS_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3881'
       ,'PMS_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3881'
                    AND  HMR_ROLE = 'PMS_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3882'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3882'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3882'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3882'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3884'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3884'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3884'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3884'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3886'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3886'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3886'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3886'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3888'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3888'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3888'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3888'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3890'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3890'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3890'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3890'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3899'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3899'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3899'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3899'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3900'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3900'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3900'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3900'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3902'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3902'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3902'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3902'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3904'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3904'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3904'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3904'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3905'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3905'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3906'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3906'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3906'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3906'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3907'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3907'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3908'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3908'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3908'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3908'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3909'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3909'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3909'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3909'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3910'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3910'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3910'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3910'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3911'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3911'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3911'
       ,'MAI_READONLY'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3911'
                    AND  HMR_ROLE = 'MAI_READONLY');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3911'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3911'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3912'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3912'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3912'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3912'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3916'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3916'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3916'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3916'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3919'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3919'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3919'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3919'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3920'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3920'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3920'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3920'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3922'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3922'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3922'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3922'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3924'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3924'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3924'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3924'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3926'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3926'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3926'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3926'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3930'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3930'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3930'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3930'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3932'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3932'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3932'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3932'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3934'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3934'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3934'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3934'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3940'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3940'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3940'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3940'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3942'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3942'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3942'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3942'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3943'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3943'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3943'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3943'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3944'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3944'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3944'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3944'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3946'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3946'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3946'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3946'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3948'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3948'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3948'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3948'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3950'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3950'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3950'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3950'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3952'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3952'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3952'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3952'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3954'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3954'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3954'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3954'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3956'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3956'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3956'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3956'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3960'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3960'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3970'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3970'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3970'
       ,'MAI_READONLY'
       ,'READONLY' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3970'
                    AND  HMR_ROLE = 'MAI_READONLY');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3970'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3970'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3980'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3980'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3980'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3980'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3981'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3981'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3981'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3981'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3982'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3982'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3982'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3982'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3984'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3984'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3984'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3984'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3986'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3986'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3986'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3986'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3988'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3988'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3988'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3988'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3992'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3992'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3992'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3992'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3994'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3994'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI3994'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI3994'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4400'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4400'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4400'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4400'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4405'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4405'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI4405'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI4405'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5001'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5001'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5010'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5010'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5011'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5011'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5015'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5015'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5018'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5018'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5021'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5021'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5021'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5021'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5022'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5022'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5024'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5024'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5025'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5025'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5027'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5027'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5030'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5030'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5031'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5031'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5032'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5032'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5034A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5034A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5034B'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5034B'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5035A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5035A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5035B'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5035B'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5037'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5037'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5037A'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5037A'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5038'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5038'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5050'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5050'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5050'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5050'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5050D'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5050D'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5060'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5060'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5065'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5065'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5070'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5070'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5075'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5075'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5080'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5080'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5090'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5090'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5091'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5091'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5100'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5100'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5125'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5125'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5130'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5130'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5200'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5200'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5205'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5205'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5210'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5210'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5215'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5215'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5220'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5220'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5225'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5225'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5235'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5235'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI5240'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI5240'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI6100'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI6100'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI6110'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI6110'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI6120'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI6120'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7040'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7040'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7040'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7040'
                    AND  HMR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7040'
       ,'PMS_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7040'
                    AND  HMR_ROLE = 'PMS_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7040'
       ,'PMS_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7040'
                    AND  HMR_ROLE = 'PMS_USER');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7080'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7080'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7082'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7082'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7086'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7086'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI7088'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI7088'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI8000'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI8000'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI9010'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI9010'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAI9020'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAI9020'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAICRVW'
       ,'MAI_ADMIN'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAICRVW'
                    AND  HMR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_MODULE_ROLES
       (HMR_MODULE
       ,HMR_ROLE
       ,HMR_MODE
       )
SELECT 
        'MAIWEB2540'
       ,'MAI_USER'
       ,'NORMAL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_MODULE_ROLES
                   WHERE HMR_MODULE = 'MAIWEB2540'
                    AND  HMR_ROLE = 'MAI_USER');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- DOC_GATEWAYS
--
-- select * from mai_metadata.doc_gateways
-- order by dgt_table_name
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT doc_gateways
SET TERM OFF

INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'ACTIVITIES_REPORT'
       ,'Activities Report'
       ,'ARE_REPORT_ID'
       ,'''BATCH''||LPAD(nvl(ARE_BATCH_ID,''0''),6)||''   INSPECTION''||LPAD(ARE_REPORT_ID,8)||''   ''||ARE_INITIATION_TYPE||''   ''||ARE_DATE_WORK_DONE||''   ''||RSE_UNIQUE'
       ,'ACTIVITIES_REPORT,ROAD_SEGMENTS_ALL'
       ,'ACTIVITIES_REPORT.ARE_RSE_HE_ID = ROAD_SEGMENTS_ALL.RSE_HE_ID'
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'ACTIVITIES_REPORT');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'CONTRACTS'
       ,'Contracts'
       ,'CON_ID'
       ,'RPAD(CON_CODE,11)||CON_NAME'
       ,'CONTRACTS'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'CONTRACTS');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'DEFECTS'
       ,'Defects'
       ,'DEF_DEFECT_ID'
       ,'RSE_UNIQUE||'', ''||'||CHR(10)||'RPAD(DEF_DEFECT_CODE,4)||'', ''||'||CHR(10)||'DEF_CREATED_DATE||'', ''||'||CHR(10)||'NVL(DEF_LOCN_DESCR,''UNKNOWN'')'||CHR(10)||''
       ,'DEFECTS,ROAD_SEGMENTS_ALL'
       ,'DEFECTS.DEF_RSE_HE_ID = ROAD_SEGMENTS_ALL.RSE_HE_ID'
       ,'mai3806'
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'DEFECTS');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'DEF_REP_TREAT'
       ,'Defects Repairs Inspections'
       ,'DEF_DEFECT_ID'
       ,'DTY_DESCR1||'',''|| REP_DESCR'
       ,'DEF_REP_TREAT'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'DEF_REP_TREAT');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'INV_ITEMS_ALL'
       ,'Road Inventory Items'
       ,'IIT_ITEM_ID'
       ,'IIT_ITY_SYS_FLAG||'' ''||IIT_ITY_INV_CODE||'' ''||IIT_ST_CHAIN||'' ''||IIT_END_CHAIN||'' ''||IIT_NOTE'
       ,'INV_ITEMS_ALL'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'INV_ITEMS_ALL');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'NM_INV_ITEMS_ALL'
       ,'Asset items all'
       ,'IIT_NE_ID'
       ,'IIT_INV_TYPE||''-''||DECODE(IIT_X_SECT,Null,Null,IIT_X_SECT||''-'')||IIT_PRIMARY_KEY'
       ,'NM_INV_ITEMS'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'NM_INV_ITEMS_ALL');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'ORG_UNITS'
       ,'Organisations'
       ,'OUN_ORG_ID'
       ,'OUN_NAME'
       ,'ORG_UNITS'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'ORG_UNITS');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'PEOPLE'
       ,'People'
       ,'PEO_PERSON_ID'
       ,'PEOPLE.PEO_INITIALS||'' ''||PEOPLE.PEO_NAME'
       ,'PEOPLE'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'PEOPLE');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'SCHEDULES'
       ,'Schedules'
       ,'SCHD_ID'
       ,'SCHD_NAME'
       ,'SCHEDULES'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'SCHEDULES');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'SCHEMES SCH'
       ,'Structural Schemes'
       ,'SCHEME_ID'
       ,'SCHEME_NAME'
       ,'SCHEMES'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'SCHEMES SCH');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'STANDARD_ITEMS'
       ,'Standard Items'
       ,'STA_ITEM_CODE'
       ,'STA_ITEM_NAME'
       ,'STANDARD_ITEMS'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'STANDARD_ITEMS');
--
INSERT INTO DOC_GATEWAYS
       (DGT_TABLE_NAME
       ,DGT_TABLE_DESCR
       ,DGT_PK_COL_NAME
       ,DGT_LOV_DESCR_LIST
       ,DGT_LOV_FROM_LIST
       ,DGT_LOV_JOIN_CONDITION
       ,DGT_EXPAND_MODULE
       ,DGT_START_DATE
       ,DGT_END_DATE
       )
SELECT 
        'WORK_ORDERS'
       ,'Work Orders'
       ,'WOR_WORKS_ORDER_NO'
       ,'NVL(WOR_DESCR,''UNKNOWN'')'
       ,'WORK_ORDERS'
       ,''
       ,''
       ,null
       ,null FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATEWAYS
                   WHERE DGT_TABLE_NAME = 'WORK_ORDERS');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- DOC_GATE_SYNS
--
-- select * from mai_metadata.doc_gate_syns
-- order by dgs_dgt_table_name
--         ,dgs_table_syn
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT doc_gate_syns
SET TERM OFF

INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'DEFECTS'
       ,'V_MAI3806_DEF' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATE_SYNS
                   WHERE DGS_DGT_TABLE_NAME = 'DEFECTS'
                    AND  DGS_TABLE_SYN = 'V_MAI3806_DEF');
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'INV_ITEMS_ALL'
       ,'INV_ITEMS' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATE_SYNS
                   WHERE DGS_DGT_TABLE_NAME = 'INV_ITEMS_ALL'
                    AND  DGS_TABLE_SYN = 'INV_ITEMS');
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'INV_ITEMS_ALL'
       ,'INV_ITEMS_ALL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATE_SYNS
                   WHERE DGS_DGT_TABLE_NAME = 'INV_ITEMS_ALL'
                    AND  DGS_TABLE_SYN = 'INV_ITEMS_ALL');
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'INV_ITEMS_ALL'
       ,'INV_ON_ROADS' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATE_SYNS
                   WHERE DGS_DGT_TABLE_NAME = 'INV_ITEMS_ALL'
                    AND  DGS_TABLE_SYN = 'INV_ON_ROADS');
--
INSERT INTO DOC_GATE_SYNS
       (DGS_DGT_TABLE_NAME
       ,DGS_TABLE_SYN
       )
SELECT 
        'NM_INV_ITEMS_ALL'
       ,'NM_INV_ITEMS_ALL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM DOC_GATE_SYNS
                   WHERE DGS_DGT_TABLE_NAME = 'NM_INV_ITEMS_ALL'
                    AND  DGS_TABLE_SYN = 'NM_INV_ITEMS_ALL');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_PROCESS_AREAS
--
-- select * from mai_metadata.hig_process_areas
-- order by hpa_area_type
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_process_areas
SET TERM OFF

INSERT INTO HIG_PROCESS_AREAS
       (HPA_AREA_TYPE
       ,HPA_DESCRIPTION
       ,HPA_TABLE
       ,HPA_RESTRICTED_TABLE
       ,HPA_WHERE_CLAUSE
       ,HPA_RESTRICTED_WHERE_CLAUSE
       ,HPA_ID_COLUMN
       ,HPA_MEANING_COLUMN
       )
SELECT 
        'CIM_CONTRACTOR'
       ,'CIM Contractor'
       ,'ORG_UNITS'
       ,'V_PROCESS_CONTRACTORS'
       ,'OUN_ELECTRONIC_ORDERS_FLAG = ''Y'' AND OUN_CONTRACTOR_ID IS NOT NULL'
       ,'OUN_ELECTRONIC_ORDERS_FLAG = ''Y'' AND OUN_CONTRACTOR_ID IS NOT NULL'
       ,'OUN_ORG_ID'
       ,'OUN_UNIT_CODE||'' - ''||OUN_NAME' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_AREAS
                   WHERE HPA_AREA_TYPE = 'CIM_CONTRACTOR');
--
INSERT INTO HIG_PROCESS_AREAS
       (HPA_AREA_TYPE
       ,HPA_DESCRIPTION
       ,HPA_TABLE
       ,HPA_RESTRICTED_TABLE
       ,HPA_WHERE_CLAUSE
       ,HPA_RESTRICTED_WHERE_CLAUSE
       ,HPA_ID_COLUMN
       ,HPA_MEANING_COLUMN
       )
SELECT 
        'CONTRACTOR'
       ,'Contractor'
       ,'ORG_UNITS'
       ,'V_PROCESS_CONTRACTORS'
       ,''
       ,''
       ,'OUN_ORG_ID'
       ,'OUN_UNIT_CODE||'' - ''||OUN_NAME' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_AREAS
                   WHERE HPA_AREA_TYPE = 'CONTRACTOR');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPES
--
-- select * from mai_metadata.hig_process_types
-- order by hpt_process_type_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_process_types
SET TERM OFF

INSERT INTO HIG_PROCESS_TYPES
       (HPT_PROCESS_TYPE_ID
       ,HPT_NAME
       ,HPT_DESCR
       ,HPT_WHAT_TO_CALL
       ,HPT_INITIATION_MODULE
       ,HPT_INTERNAL_MODULE
       ,HPT_INTERNAL_MODULE_PARAM
       ,HPT_PROCESS_LIMIT
       ,HPT_RESTARTABLE
       ,HPT_SEE_IN_HIG2510
       ,HPT_POLLING_ENABLED
       ,HPT_POLLING_FTP_TYPE_ID
       ,HPT_AREA_TYPE
       )
SELECT 
        -1004
       ,'CIM Invoice File'
       ,'CIM Invoice File'
       ,'mai_cim_automation.run_batch(''WI'');'
       ,''
       ,'MAI3854'
       ,'ih_id'
       ,null
       ,'Y'
       ,'Y'
       ,'Y'
       ,null
       ,'CIM_CONTRACTOR' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPES
                   WHERE HPT_PROCESS_TYPE_ID = -1004);
--
INSERT INTO HIG_PROCESS_TYPES
       (HPT_PROCESS_TYPE_ID
       ,HPT_NAME
       ,HPT_DESCR
       ,HPT_WHAT_TO_CALL
       ,HPT_INITIATION_MODULE
       ,HPT_INTERNAL_MODULE
       ,HPT_INTERNAL_MODULE_PARAM
       ,HPT_PROCESS_LIMIT
       ,HPT_RESTARTABLE
       ,HPT_SEE_IN_HIG2510
       ,HPT_POLLING_ENABLED
       ,HPT_POLLING_FTP_TYPE_ID
       ,HPT_AREA_TYPE
       )
SELECT 
        -1003
       ,'CIM Completions File'
       ,'CIM Completions File '
       ,'mai_cim_automation.run_batch(''WC'');'
       ,''
       ,'MAI3854'
       ,'ih_id'
       ,null
       ,'Y'
       ,'Y'
       ,'N'
       ,null
       ,'CIM_CONTRACTOR' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPES
                   WHERE HPT_PROCESS_TYPE_ID = -1003);
--
INSERT INTO HIG_PROCESS_TYPES
       (HPT_PROCESS_TYPE_ID
       ,HPT_NAME
       ,HPT_DESCR
       ,HPT_WHAT_TO_CALL
       ,HPT_INITIATION_MODULE
       ,HPT_INTERNAL_MODULE
       ,HPT_INTERNAL_MODULE_PARAM
       ,HPT_PROCESS_LIMIT
       ,HPT_RESTARTABLE
       ,HPT_SEE_IN_HIG2510
       ,HPT_POLLING_ENABLED
       ,HPT_POLLING_FTP_TYPE_ID
       ,HPT_AREA_TYPE
       )
SELECT 
        -1002
       ,'CIM Works Order Extract'
       ,'CIM Works Order Extract'
       ,'mai_cim_automation.run_batch(''WO'');'
       ,''
       ,''
       ,''
       ,null
       ,'Y'
       ,'Y'
       ,'N'
       ,null
       ,'CIM_CONTRACTOR' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPES
                   WHERE HPT_PROCESS_TYPE_ID = -1002);
--
INSERT INTO HIG_PROCESS_TYPES
       (HPT_PROCESS_TYPE_ID
       ,HPT_NAME
       ,HPT_DESCR
       ,HPT_WHAT_TO_CALL
       ,HPT_INITIATION_MODULE
       ,HPT_INTERNAL_MODULE
       ,HPT_INTERNAL_MODULE_PARAM
       ,HPT_PROCESS_LIMIT
       ,HPT_RESTARTABLE
       ,HPT_SEE_IN_HIG2510
       ,HPT_POLLING_ENABLED
       ,HPT_POLLING_FTP_TYPE_ID
       ,HPT_AREA_TYPE
       )
SELECT 
        -1001
       ,'Maintenance Inspection Loader'
       ,'Loads maintenance inspections from RMMS or EID format files'
       ,'mai_inspection_loader.initialise;'
       ,'MAI4400'
       ,'MAI4405'
       ,'PROCESS_ID'
       ,null
       ,'N'
       ,'Y'
       ,'Y'
       ,null
       ,'ADMIN_UNIT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPES
                   WHERE HPT_PROCESS_TYPE_ID = -1001);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_ROLES
--
-- select * from mai_metadata.hig_process_type_roles
-- order by hptr_process_type_id
--         ,hptr_role
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_process_type_roles
SET TERM OFF

INSERT INTO HIG_PROCESS_TYPE_ROLES
       (HPTR_PROCESS_TYPE_ID
       ,HPTR_ROLE
       )
SELECT 
        -1004
       ,'MAI_USER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_ROLES
                   WHERE HPTR_PROCESS_TYPE_ID = -1004
                    AND  HPTR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_PROCESS_TYPE_ROLES
       (HPTR_PROCESS_TYPE_ID
       ,HPTR_ROLE
       )
SELECT 
        -1003
       ,'MAI_USER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_ROLES
                   WHERE HPTR_PROCESS_TYPE_ID = -1003
                    AND  HPTR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_PROCESS_TYPE_ROLES
       (HPTR_PROCESS_TYPE_ID
       ,HPTR_ROLE
       )
SELECT 
        -1002
       ,'MAI_USER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_ROLES
                   WHERE HPTR_PROCESS_TYPE_ID = -1002
                    AND  HPTR_ROLE = 'MAI_USER');
--
INSERT INTO HIG_PROCESS_TYPE_ROLES
       (HPTR_PROCESS_TYPE_ID
       ,HPTR_ROLE
       )
SELECT 
        -1001
       ,'MAI_ADMIN' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_ROLES
                   WHERE HPTR_PROCESS_TYPE_ID = -1001
                    AND  HPTR_ROLE = 'MAI_ADMIN');
--
INSERT INTO HIG_PROCESS_TYPE_ROLES
       (HPTR_PROCESS_TYPE_ID
       ,HPTR_ROLE
       )
SELECT 
        -1001
       ,'MAI_USER' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_ROLES
                   WHERE HPTR_PROCESS_TYPE_ID = -1001
                    AND  HPTR_ROLE = 'MAI_USER');
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_FREQUENCIES
--
-- select * from mai_metadata.hig_process_type_frequencies
-- order by hpfr_process_type_id
--         ,hpfr_frequency_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_process_type_frequencies
SET TERM OFF

INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1004
       ,-8
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1004
                    AND  HPFR_FREQUENCY_ID = -8);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1004
       ,-7
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1004
                    AND  HPFR_FREQUENCY_ID = -7);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1004
       ,-5
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1004
                    AND  HPFR_FREQUENCY_ID = -5);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1003
       ,-8
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1003
                    AND  HPFR_FREQUENCY_ID = -8);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1003
       ,-7
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1003
                    AND  HPFR_FREQUENCY_ID = -7);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1003
       ,-5
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1003
                    AND  HPFR_FREQUENCY_ID = -5);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1002
       ,-8
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1002
                    AND  HPFR_FREQUENCY_ID = -8);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1002
       ,-7
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1002
                    AND  HPFR_FREQUENCY_ID = -7);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1002
       ,-5
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1002
                    AND  HPFR_FREQUENCY_ID = -5);
--
INSERT INTO HIG_PROCESS_TYPE_FREQUENCIES
       (HPFR_PROCESS_TYPE_ID
       ,HPFR_FREQUENCY_ID
       ,HPFR_SEQ
       )
SELECT 
        -1001
       ,-1
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FREQUENCIES
                   WHERE HPFR_PROCESS_TYPE_ID = -1001
                    AND  HPFR_FREQUENCY_ID = -1);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_FILES
--
-- select * from mai_metadata.hig_process_type_files
-- order by hptf_file_type_id
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_process_type_files
SET TERM OFF

INSERT INTO HIG_PROCESS_TYPE_FILES
       (HPTF_FILE_TYPE_ID
       ,HPTF_NAME
       ,HPTF_PROCESS_TYPE_ID
       ,HPTF_INPUT
       ,HPTF_OUTPUT
       ,HPTF_INPUT_DESTINATION
       ,HPTF_INPUT_DESTINATION_TYPE
       ,HPTF_MIN_INPUT_FILES
       ,HPTF_MAX_INPUT_FILES
       ,HPTF_OUTPUT_DESTINATION
       ,HPTF_OUTPUT_DESTINATION_TYPE
       )
SELECT 
        -1001
       ,'Inspection File'
       ,-1001
       ,'Y'
       ,'N'
       ,'MAI_INSP_DIRECTORY'
       ,'ORACLE_DIRECTORY'
       ,1
       ,1
       ,''
       ,'' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FILES
                   WHERE HPTF_FILE_TYPE_ID = -1001);
--
--
--
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
-- HIG_PROCESS_TYPE_FILE_EXT
--
-- select * from mai_metadata.hig_process_type_file_ext
-- order by hpte_file_type_id
--         ,hpte_extension
--
----------------------------------------------------------------------------------------

SET TERM ON
PROMPT hig_process_type_file_ext
SET TERM OFF

INSERT INTO HIG_PROCESS_TYPE_FILE_EXT
       (HPTE_FILE_TYPE_ID
       ,HPTE_EXTENSION
       )
SELECT 
        -1001
       ,'dat' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM HIG_PROCESS_TYPE_FILE_EXT
                   WHERE HPTE_FILE_TYPE_ID = -1001
                    AND  HPTE_EXTENSION = 'dat');
--
--
--
----------------------------------------------------------------------------------------

--
COMMIT;
--
set feedback on
set define on
--
-------------------------------
-- END OF GENERATED METADATA --
-------------------------------
--
