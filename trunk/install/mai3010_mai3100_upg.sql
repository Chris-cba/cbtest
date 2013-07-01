-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3010_mai3100_upg.sql-arc   2.1   Jul 01 2013 16:02:14   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3010_mai3100_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:14  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.11
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
spool mai3100_upg.log
--
--get some db info

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ( 'MAI');
--
WHENEVER SQLERROR EXIT
begin
   hig2.pre_upgrade_check (p_product               => 'MAI'
                          ,p_new_version           => '3.1.0.0'
                          ,p_allowed_old_version_1 => '3.0.1.0'
                          ,p_allowed_old_version_2 => '3.0.8.1'
                          ,p_allowed_old_version_3 => '3.0.8.2'
                           );
END;
/
WHENEVER SQLERROR CONTINUE

prompt
prompt Running icb_fgac_upg script ...

set term off
select '&exor_base'||'mai'||'&terminator'||'install'||
	'&terminator'||'icb_fgac_upg.sql' run_file
from dual
/
start '&&run_file'

INSERT
  INTO GRI_MODULE_PARAMS
      (GMP_MODULE
      ,GMP_PARAM
      ,GMP_SEQ
      ,GMP_PARAM_DESCR
      ,GMP_MANDATORY
      ,GMP_NO_ALLOWED
      ,GMP_WHERE
      ,GMP_TAG_RESTRICTION
      ,GMP_TAG_WHERE
      ,GMP_DEFAULT_TABLE
      ,GMP_DEFAULT_COLUMN
      ,GMP_DEFAULT_WHERE
      ,GMP_VISIBLE
      ,GMP_GAZETTEER
      ,GMP_LOV
      ,GMP_VAL_GLOBAL
      ,GMP_WILDCARD
      ,GMP_HINT_TEXT)
VALUES('MAI3100'
      ,'TEXT'
      ,10
      ,'Scheduled Initiation Types'
      ,'N'
      ,1
      ,NULL
      ,'N'
      ,NULL
      ,'DUAL'
      ,'''NRM,DUM'''
      ,NULL
      ,'N'
      ,'N'
      ,'N'
      ,NULL
      ,'N'
      ,'Comma Separated List Of Scheduled Initiation Types')
/

insert into HIG_ERRORS (
HER_APPL
,HER_NO
,HER_TYPE
,HER_DESCR
,HER_ACTION_1
,HER_ACTION_2
,HER_ACTION_3
,HER_ACTION_4
,HER_ACTION_5
,HER_ACTION_6
,HER_ACTION_7
) values (
'M_MGR'
,899
,'E'
,'Contract Items related to the BOQs on this Work Order Line are being updated by another User'
,''
,''
,''
,''
,''
,''
,''
)
/

INSERT INTO HIG_ERRORS ( 
HER_APPL
,HER_NO
,HER_TYPE
,HER_DESCR
,HER_ACTION_1
,HER_ACTION_2
,HER_ACTION_3
,HER_ACTION_4
,HER_ACTION_5
,HER_ACTION_6
,HER_ACTION_7 
) VALUES ( 
'PMS'
,100
,'E'
,'Cannot complete Scheme: A section has been entered where the Start Date > Scheme Complete Date'
,''
,''
,''
,''
,''
,''
,''
)
/


/*
    ============================================== 
    UPGRADE SCRIPT for AUTO Defect Prioritisation
    ==============================================
*/


/*
    =============
    TABLE CHANGES
    =============
*/

PROMPT 
PROMPT Altering INTERFACE_RUN_LOG

alter table INTERFACE_RUN_LOG add
 (irl_grr_job_id  NUMBER(9) NULL)
/

PROMPT Adding new objects/data for Auto Defect Prioritisation
PROMPT

-------------------------------------------------------
-- New Table required to hold rules 
-------------------------------------------------------

CREATE TABLE AUTO_DEFECT_SELECTION_PRIORITY
 (ADSP_ATV_ACTY_AREA_CODE VARCHAR2(2) NOT NULL,
  ADSP_DEFECT_CODE VARCHAR2(4) NOT NULL,
  ADSP_DTP_FLAG	VARCHAR2(4) NOT NULL,
  ADSP_FLEX_ATTRIB VARCHAR2(1) NOT NULL,
  ADSP_CNTRL_VALUE VARCHAR2(2) NOT NULL,
  ADSP_PRIORITY VARCHAR2(4),
  ADSP_PRIORITY_RANK NUMBER);
  
-------------------------------------------------------
-- NEW Unique Index
-------------------------------------------------------
  
CREATE UNIQUE INDEX ADSP_UNIQUE_IND ON AUTO_DEFECT_SELECTION_PRIORITY
  (ADSP_ATV_ACTY_AREA_CODE, ADSP_DEFECT_CODE, ADSP_FLEX_ATTRIB, ADSP_CNTRL_VALUE);

-------------------------------------------------------
-- NEW Primary Key for Auto_Defect_Selection_Priority  
-------------------------------------------------------

ALTER TABLE AUTO_DEFECT_SELECTION_PRIORITY ADD (
  CONSTRAINT ADSP_PK PRIMARY KEY (ADSP_ATV_ACTY_AREA_CODE, ADSP_DEFECT_CODE, ADSP_FLEX_ATTRIB, ADSP_CNTRL_VALUE));

-------------------------------------------------------
-- NEW Trigger on DEFECTS to overwrite Defect Priority
-- when loading Inspection files.
-------------------------------------------------------

CREATE OR REPLACE TRIGGER PRE_INSERT_DEFECTS
BEFORE INSERT
ON DEFECTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

 CURSOR c1 (cp_rse_he_id IN NUMBER) IS 
   SELECT rse_sys_flag
     FROM road_segs
	WHERE rse_he_id = cp_rse_he_id;
	
	v_sys_flag VARCHAR2(4) := NULL;

BEGIN

 IF hig.get_user_or_sys_opt('DEFAUTOPRI') = 'A'
  THEN
    
	 OPEN c1(:NEW.def_rse_he_id);
	 FETCH c1 INTO v_sys_flag;
	 CLOSE c1;
 
    :NEW.def_priority := mai.GET_AUTO_DEF_PRIORITY(p_rse_he_id     => :NEW.def_rse_he_id,
                                                   p_network_type  =>  v_sys_flag,
                                                   p_activity_code => :NEW.def_atv_acty_area_code,
                                                   p_defect_code   => :NEW.def_defect_code);    
	 v_sys_flag := NULL;
	 
 END IF;

END ;

/

--
-- RIRF Upgrade
-- 

-- PROMPT RIRF_SECT_FREQS
CREATE TABLE RIRF_SECT_FREQS
(
  RSE_UNIQUE         VARCHAR2(20)                          NOT NULL,
  ACT_NAME           VARCHAR2(50)                          NOT NULL,
  INTERVAL           VARCHAR2(4)                                   ,
  FREQUENCY          VARCHAR2(4)                                   ,
  FREQ_INT           NUMBER(4)                                     ,
  FREQ_INT_UNIT      VARCHAR2(50)                                  
)
LOGGING 
NOCACHE
NOPARALLEL;

COMMENT ON TABLE RIRF_SECT_FREQS IS 'RIRF file import, table of activities, inspection frequencies'
/

-- PROMPT RIRF_ACTIVITIES
CREATE TABLE RIRF_ACTIVITIES
(
  VALID_ACT_NAME     VARCHAR2(50)                          NOT NULL,
  ACT_DESC           VARCHAR2(200)                                 
)
LOGGING 
NOCACHE
NOPARALLEL;

COMMENT ON TABLE RIRF_ACTIVITIES IS 'RIRF file import, table of activites'
/

-- PROMPT RIRF_ACTIVITY_INT
CREATE TABLE RIRF_ACTIVITY_INT
(
  VALID_ACT_NAME     VARCHAR2(50)                          NOT NULL,
  CATEGORY           VARCHAR2(50)                                  ,
  ACTION             VARCHAR2(50)                                  ,
  ACT_INTERVAL       NUMBER(4)                                     ,
  UNIT               VARCHAR2(50)                                  
)
LOGGING 
NOCACHE
NOPARALLEL;

COMMENT ON TABLE RIRF_ACTIVITY_INT IS 'RIRF file import, table of activity intervals'
/

-- PROMPT RIRF_DEF_TYPES
CREATE TABLE RIRF_DEF_TYPES
(
  VALID_ACT_NAME     VARCHAR2(50)                          NOT NULL,
  DEFECT_NAME        VARCHAR2(50)                          NOT NULL,
  DEFECT_DESC        VARCHAR2(200)                                 
)
LOGGING 
NOCACHE
NOPARALLEL;

COMMENT ON TABLE RIRF_DEF_TYPES IS 'RIRF file import, table of defect types'
/

-- PROMPT RIRF_XSP_VALUES
CREATE TABLE RIRF_XSP_VALUES
(
  XSP        VARCHAR2(50)                          NOT NULL
)
LOGGING 
NOCACHE
NOPARALLEL;

COMMENT ON TABLE RIRF_XSP_VALUES IS 'RIRF file import, table of valid xsp values'
/


/*
 ===============
 MODULE METADATA
 ===============
*/
-------------------------------------------------------
-- HIG MODULES - New form (MAI3813)
-------------------------------------------------------
insert into HIG_MODULES (
HMO_MODULE
,HMO_TITLE
,HMO_FILENAME
,HMO_MODULE_TYPE
,HMO_FASTPATH_OPTS
,HMO_FASTPATH_INVALID
,HMO_USE_GRI
,HMO_APPLICATION
,HMO_MENU
) select
'MAI3813'
,'Maintain Automatic Defect Prioritisation'
,'mai3813'
,'FMX'
,''
,'N'
,'N'
,'MAI'
,'FORM'
from dual
where not exists (
 select 'not exists'
 from HIG_MODULES
where HMO_MODULE = 'MAI3813'
);

commit;

insert into HIG_MODULE_ROLES (
HMR_MODULE
,HMR_ROLE
,HMR_MODE
) select
'MAI3813'
,'MAI_ADMIN'
,'NORMAL'
from dual
where not exists (
 select 'not exists'
 from HIG_MODULE_ROLES
where HMR_MODULE = 'MAI3813'
 and HMR_ROLE = 'MAI_ADMIN'
);

commit;

-------------------------------------------
-- Removing redundant modules roles/modules
-------------------------------------------
delete from hig_module_roles
where hmr_module IN ('MAI2312','MAI2130','MAI1060','MAI2150','MAI2350')
/
delete from hig_modules
where hmo_module IN ('MAI2312','MAI2130','MAI1060','MAI2150','MAI2350')
/
commit;


/*
 ==============
 PRODUCT OPTION
 ==============
*/

-------------------------------
-- Product Option DEFAUTOPRI --
-------------------------------
INSERT INTO HIG_OPTIONS 
(
 HOP_ID
,HOP_PRODUCT
,HOP_NAME
,HOP_VALUE
,HOP_REMARKS
) SELECT
'DEFAUTOPRI'
,'MAI'
,'Defect Automatic Priority'
,'Z'
,'Auto Defect Prioritisation - Value of A will make Defect Priority field non-navigable, value of B will make Defect Priority field navigable and
  will allow end user to over-type defaulted value, otherwise if null then dont provide a default priority'
FROM dual
WHERE NOT EXISTS (
 SELECT 'not exists'
 FROM HIG_OPTIONS
WHERE HOP_ID = 'DEFAUTOPRI'
);

COMMIT;


/*
 ==========
 NEW DOMAIN
 ==========
*/
-------------------------------------------------------
-- HIG DOMAINS - ADSP_RSE_ATTS
-------------------------------------------------------

insert into HIG_DOMAINS (
HDO_DOMAIN
,HDO_PRODUCT
,HDO_TITLE
,HDO_CODE_LENGTH
) select
'ADSP_RSE_ATTS'
,'MAI'
,'Road Section Attributes'
,10
from dual
where not exists (
 select 'not exists'
 from HIG_DOMAINS
where HDO_DOMAIN = 'ADSP_RSE_ATTS'
);

commit;


-------------------------------------------------------- 
-- HIG CODES - DEFAUTOPRI values 
--------------------------------------------------------
insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'USER_OPTIONS'
,'DEFAUTOPRI'
,'Auto Defect Prioritisation'
,'Y'
,1
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'USER_OPTIONS'
 and HCO_CODE = 'DEFAUTOPRI'
);

commit;

-------------------------------------------------------- 
-- HIG CODES - ADSP_RSE_ATTS values 
--------------------------------------------------------

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'1'
,'RSE_ROAD_TYPE'
,'Y'
,1
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '1'
);

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'2'
,'RSE_CARRIAGEWAY_TYPE'
,'Y'
,2
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '2'
);

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'3'
,'RSE_ROAD_ENVIRONMENT'
,'Y'
,3
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '3'
);

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'4'
,'RSE_MAINT_CATEGORY'
,'Y'
,4
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '4'
);

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'5'
,'RSE_FOOTWAY_CATEGORY'
,'Y'
,5
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '5'
);

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'6'
,'RSE_ROAD_CATEGORY'
,'Y'
,6
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '6'
);

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'7'
,'RSE_TRAFFIC_LEVEL'
,'Y'
,7
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '7'
);

insert into HIG_CODES (
HCO_DOMAIN
,HCO_CODE
,HCO_MEANING
,HCO_SYSTEM
,HCO_SEQ
,HCO_START_DATE
,HCO_END_DATE
) select
'ADSP_RSE_ATTS'
,'8'
,'RSE_SCL_SECT_CLASS'
,'Y'
,8
,null
,null
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'ADSP_RSE_ATTS'
 and HCO_CODE = '8'
);

commit;
-------------------------------------------------------------
-- Fix gri parameters for mai3863
-------------------------------------------------------------
update gri_module_params
set gmp_where = '(NOT EXISTS (SELECT ''X'' FROM ACT_FREQS WHERE AFR_ATV_ACTY_AREA_CODE = ATV_ACTY_AREA_CODE) AND ATV_DTP_FLAG IN (SELECT ITY_SYS_FLAG FROM INV_ITEM_TYPES WHERE ITY_ELEC_DRAIN_CARR = NVL(:DISCIPLINE, ITY_ELEC_DRAIN_CARR))) OR ATV_ACTY_AREA_CODE IN (SELECT AFR_ATV_ACTY_AREA_CODE FROM ACT_FREQS, INV_ITEM_TYPES WHERE NVL(AFR_ITY_INV_CODE,ITY_INV_CODE) = ITY_INV_CODE AND AFR_ITY_SYS_FLAG = ITY_SYS_FLAG AND ITY_ELEC_DRAIN_CARR = NVL(:DISCIPLINE,ITY_ELEC_DRAIN_CARR)) ORDER BY ATV_ACTY_AREA_CODE'
where gmp_param = 'ACTIVITY'
and gmp_module = 'MAI3863';

update gri_module_params
set gmp_where = 'ACG_GROUP_CODE IN (SELECT AGM.AGM_GROUP_CODE FROM ACT_GROUP_MEMBS AGM WHERE (NOT EXISTS (SELECT ''X'' FROM ACT_FREQS AFR1 WHERE AFR1.AFR_ATV_ACTY_AREA_CODE = AGM.AGM_ACTY_CODE) AND ACG_SYS_FLAG IN (SELECT IIT1.ITY_SYS_FLAG FROM INV_ITEM_TYPES IIT1 WHERE IIT1.ITY_ELEC_DRAIN_CARR = NVL(:DISCIPLINE, IIT1.ITY_ELEC_DRAIN_CARR))) OR AGM.AGM_ACTY_CODE IN (SELECT AFR2.AFR_ATV_ACTY_AREA_CODE FROM ACT_FREQS AFR2, INV_ITEM_TYPES IIT2 WHERE NVL(AFR2.AFR_ITY_INV_CODE,IIT2.ITY_INV_CODE) = IIT2.ITY_INV_CODE AND AFR2.AFR_ITY_SYS_FLAG = IIT2.ITY_SYS_FLAG AND IIT2.ITY_ELEC_DRAIN_CARR = NVL(:DISCIPLINE,IIT2.ITY_ELEC_DRAIN_CARR))) ORDER BY ACG_GROUP_CODE'
where gmp_param = 'ACTIVITY_GROUP'
and gmp_module = 'MAI3863';

commit;

-------------------------------------------------------------
-- 3010->3100 (2211-2220)
-------------------------------------------------------------

-- ADD TT2_RSE_HE_ID to TABLE SECT_FREQ2
ALTER TABLE SECT_FREQ2 ADD (tt2_rse_he_id NUMBER(8));


-- Insert into Hig_Options
insert into HIG_OPTIONS (
HOP_ID
,HOP_PRODUCT
,HOP_NAME
,HOP_VALUE
,HOP_REMARKS
) select
'XTRIFLDS'
,'MAI'
,'Version of Interface Files'
,'NA'
,'If set to 2-1-3 uses additional fields on the end of the WO and WI files. Otherwise set to NA.'
from dual
where not exists (
 select 'not exists'
 from HIG_OPTIONS
where HOP_ID = 'XTRIFLDS'
);
--
create sequence neg_boq_id_seq
increment by -1
start with -1
nomaxvalue;
--
alter table INTERFACE_CLAIMS_BOQ_ALL
add (ICBOQ_BOQ_ID 		NUMBER (10)
  , ICBOQ_PARENT_BOQ_ID		NUMBER (10)
  , ICBOQ_PERCENT_BAND_COMP	VARCHAR2(1)
  , ICBOQ_ROGUE_ITEM		VARCHAR2(1)
  , ICBOQ_ROGUE_ITEM_DESC	VARCHAR2(254));
--
alter table INTERFACE_BOQ
add (IBOQ_BOQ_ID 		NUMBER (10)
  , IBOQ_PARENT_BOQ_ID		NUMBER (10)
  , IBOQ_PERCENT_BAND_COMP	 VARCHAR2(1)
  , IBOQ_ROGUE_ITEM		VARCHAR2(1)
  , IBOQ_ROGUE_ITEM_DESC	 VARCHAR2(254));
--
CREATE OR REPLACE FORCE VIEW INTERFACE_CLAIMS_BOQ
(ICBOQ_IH_ID, ICBOQ_CON_CLAIM_REF, ICBOQ_CON_ID, ICBOQ_WOL_ID, ICBOQ_STA_ITEM_CODE, 
ICBOQ_DIM1, ICBOQ_DIM2, ICBOQ_DIM3, ICBOQ_QUANTITY, ICBOQ_RATE, 
ICBOQ_COST, ICBOQ_PERCENT_ADJUST, ICBOQ_PERCENT_ADJUST_CODE, ICBOQ_STATUS, ICBOQ_ERROR, ICBOQ_BOQ_ID, ICBOQ_PARENT_BOQ_ID, ICBOQ_PERCENT_BAND_COMP, ICBOQ_ROGUE_ITEM, ICBOQ_ROGUE_ITEM_DESC)
AS 
select "ICBOQ_IH_ID","ICBOQ_CON_CLAIM_REF","ICBOQ_CON_ID","ICBOQ_WOL_ID","ICBOQ_STA_ITEM_CODE","ICBOQ_DIM1","ICBOQ_DIM2","ICBOQ_DIM3","ICBOQ_QUANTITY","ICBOQ_RATE","ICBOQ_COST","ICBOQ_PERCENT_ADJUST","ICBOQ_PERCENT_ADJUST_CODE","ICBOQ_STATUS","ICBOQ_ERROR","ICBOQ_BOQ_ID","ICBOQ_PARENT_BOQ_ID","ICBOQ_PERCENT_BAND_COMP","ICBOQ_ROGUE_ITEM","ICBOQ_ROGUE_ITEM_DESC"
from   interface_claims_boq_all
where  nvl(icboq_status, 'D') != 'D';
--
-- END of database Upgrades
--
--
------------------------------------------------------------------------------------------------
--
set term on
Prompt Creating Views
set term off
set define on
set feedback off
select '&exor_base'||'mai'||'&terminator'||'admin'||'&terminator'||'views'||
        '&terminator'||'maiviews.sql' run_file
from dual
/
start '&&run_file'
--
------------------------------------------------------------------------------------------------
--
set term on
prompt Creating Package Headers
set term off
set feedback off
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maipkh.sql' run_file
from dual
/
start '&&run_file'
--
------------------------------------------------------------------------------------------------
--
set term on
prompt Creating Package Bodies
set term off
set feedback off
set define on
select '&exor_base'||'mai'||'&terminator'||'admin'||
        '&terminator'||'pck'||'&terminator'||'maipkb.sql' run_file
from dual
/
start '&&run_file'
--
------------------------------------------------------------------------------------------------
--
set term on
prompt Setting MAI user roles
set term off
set define on
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai_user_roles.sql' run_file
from dual
/
set echo off feed on
start '&&run_file'
--
set feedback off echo off
--
------------------------------------------------------------------------------------------------
--
set define on
set term on
prompt Metadata - see metadata.log
prompt Running maidata1 ...
set term off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata1' run_file
from dual
/
start '&&run_file'
commit;
/
--
------------------------------------------------------------------------------------------------
--
set define on
set term on
prompt Running maidata2 ...
set term off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata2' run_file
from dual
/
start '&&run_file'
commit;
/
--
------------------------------------------------------------------------------------------------
--
set define on
set term on
prompt Running maidata3 ...
set term off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata3' run_file
from dual
/
start '&&run_file'
commit;
/
--
------------------------------------------------------------------------------------------------
--
set define on
set term on
prompt Running maidata4 ...
set term off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata4' run_file
from dual
/
start '&&run_file' &p_admin_type
commit;
/
--
------------------------------------------------------------------------------------------------
--
set define on
set term on
prompt Running maidata5 ...
set term off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata5' run_file
from dual
/
start '&&run_file'
commit;
/
--
------------------------------------------------------------------------------------------------
--
/*
set define on
set term on
prompt Running maidata7 ...
set term off
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'maidata7' run_file
from dual
/
start '&&run_file'
commit;
/
*/
--
---------------------------------------------------------------------------------
--
set term on
set define off
prompt Refreshing Maintenance Manager HIG_ERRORS
set term off
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'HWAYS'
       ,9611
       ,'E'
       ,'Master Record already exists, use query to retrieve info.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 1;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,1
       ,'E'
       ,'This is a mandatory field.'
       ,'This field must be entered before proceeding.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 2;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,2
       ,'I'
       ,'Transaction complete.'
       ,'All Posting and Commiting have completed successfully.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 3;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,3
       ,'E'
       ,'Invalid Road Type entered'
       ,'You must enter a valid Road Type or press [List] to select from a list of'
       ,'valid Road Types.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 4;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,4
       ,'E'
       ,'Invalid Road Part Name entered'
       ,'You must enter a valid Road Part Name for a DTp road type.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 5;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,5
       ,'E'
       ,'Invalid Linkcode entered'
       ,'You must enter a valid Linkcode for a Local Road Type, press [List] for'
       ,'a list of valid Linkcodes.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 6;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,6
       ,'E'
       ,'The linkcode entered has incorrect prefix for this Road Type'
       ,'The Linkcode you enter must start with the one character prefix associated'
       ,'with this Road Type.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 7;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,7
       ,'E'
       ,'At first block'
       ,'You are at the first blck. There are no further blocks preceding this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 8;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,8
       ,'E'
       ,'At last block'
       ,'You are at the last block. The are no further blocks following this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 9;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,9
       ,'E'
       ,'Include flag must = ''N'' to proceed to Sections block'
       ,'The include flag must be set to ''N'' to indicate that the linkcode as a'
       ,'whole is not bto be included in the works order.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 10;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,10
       ,'E'
       ,'All Include flags must = ''N'' to proceed to Sections block'
       ,'All the include flags must be set to ''N'' to indicate that none of the'
       ,'linkcodes as a whole are to be included in the works order.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 11;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,11
       ,'E'
       ,'No Links exist for the network parameters entered.'
       ,'You have entered an invalid combination of Agency/Road Type/Road Part Name'
       ,'Linkcode as no links exist for this combination.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 12;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,12
       ,'E'
       ,'No Sections exist for this Linkcode.'
       ,'There are no defined Sections for the linkcode'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 13;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,13
       ,'E'
       ,'Invalid Agency code entered'
       ,'You must enter a known Agency code or select a valid code from [List].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 14;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,14
       ,'E'
       ,'Immediate, Permanent or both Repairs must be selected as Y'
       ,'Immediate, Permanent or both Repairs must be selected as Y'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 15;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,15
       ,'E'
       ,'Not a valid Treatment code for this activity area'
       ,'Not a valid Treatment code for this activity area'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 16;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,16
       ,'E'
       ,'Section not in specified Road Segment Group'
       ,'The section is not in the specified Road Segment Group'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 17;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,17
       ,'E'
       ,'Incomplete cost code. Set up cost info prior to raising W.O.'
       ,'Incomplete cost code. Set up cost info prior to raising W.O.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 18;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,18
       ,'E'
       ,'Both Estimated Cost and Include in W.O. must be completed'
       ,'Both Estimated Cost and Include in W.O. must be completed'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 19;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,19
       ,'E'
       ,'An Estimated Cost must be entered'
       ,'An Estimated Cost must be entered'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 20;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,20
       ,'S'
       ,'Unable to read ROAD_SECTION record.'
       ,'Cannot look up Section. Contact Support.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 21;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,21
       ,'E'
       ,'Budget on this Date already exists.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 22;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,22
       ,'E'
       ,'Date entered cannot be before today''s date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 23;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,23
       ,'E'
       ,'You must provide both a Group Type AND Group Name or Neither'
       ,'You must enter both a Group Type AND Group Name or leave both blank'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 24;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,24
       ,'E'
       ,'Not a valid Group Name for the specified Group Type'
       ,'Not a valid Group Name for the specified Group Type'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 25;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,25
       ,'E'
       ,'You cannot associate this Works Order with another LINK'
       ,'You cannot associate this Works Order with another LINK'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 26;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,26
       ,'E'
       ,'This is not a valid Agency / Linkcode combination'
       ,'Not a valid Agency / Linkcode combination'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 27;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,27
       ,'E'
       ,'You must enter ''Y'' or ''N'' only'
       ,'The only valid entries are ''Y'' and ''N'''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 28;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,28
       ,'S'
       ,'Unable to update CODE_CONTROLS record.'
       ,'Unable to update Code Controls record.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 29;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,29
       ,'I'
       ,'Scrolling to last record'
       ,'You are at the first record in the list and are about to scroll to the'
       ,'last record in the list'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 30;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,30
       ,'I'
       ,'Scrolling to first record'
       ,'You are at the last record in the block and are about to scroll to the'
       ,'first record in the block'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 31;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,31
       ,'E'
       ,'At first record'
       ,'You are positioned at the first record in the block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 32;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,32
       ,'E'
       ,'Activity date must be between the start and end date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 33;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,33
       ,'E'
       ,'Correct error on current block before proceeding.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 34;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,34
       ,'E'
       ,'Date must be of MON-YY format.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 35;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,35
       ,'E'
       ,'This is not a valid Activity Code; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 36;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,36
       ,'E'
       ,'Link may not be deleted until membership records are.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 37;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,37
       ,'E'
       ,'Links may not be entered on this screen.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 38;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,38
       ,'E'
       ,'No records retrieved - Entering block 3 to enable insert.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 39;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,39
       ,'E'
       ,'Record must exist in this block before proceeding.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 40;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,40
       ,'E'
       ,'Start date of this group is later than the activity date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 41;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,41
       ,'E'
       ,'This is not a valid number.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 42;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,42
       ,'E'
       ,'This is not a valid entry for this field.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 43;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,43
       ,'E'
       ,'This is not a valid Group Type; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 44;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,44
       ,'E'
       ,'This is not a valid Organisation Name; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 45;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,45
       ,'E'
       ,'This is not a valid Organisation Unit Identity.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 46;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,46
       ,'E'
       ,'This group already has this activity on this date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 47;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,47
       ,'E'
       ,'This group does not use this type of activity.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 48;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,48
       ,'E'
       ,'This name does not match the Group Type; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 49;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,49
       ,'S'
       ,'Unable to update CODE_CONTROLS record.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 50;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,50
       ,'E'
       ,'You cannot commit records in this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 51;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,51
       ,'E'
       ,'You cannot delete records in this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 52;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,52
       ,'E'
       ,'Default date not within Group start/end dates.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 53;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,53
       ,'E'
       ,'Group does not exist with this Agency, Date and Activity.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 54;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,54
       ,'E'
       ,'There are no maintenance details to delete for this group.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 55;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,55
       ,'E'
       ,'This group has no sections for this activity area/agency.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 56;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,56
       ,'E'
       ,'You must COMMIT action code I or D first.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 57;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,57
       ,'E'
       ,'Invalid value - Enter I, D or space.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 58;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,58
       ,'E'
       ,'Invalid Agency/Linkcode and Section.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 59;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,59
       ,'E'
       ,'Section already scheduled for this activity & due date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 60;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,60
       ,'E'
       ,'This section is not currently active.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 61;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,61
       ,'E'
       ,'Default date not within section start/end dates.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 62;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,62
       ,'E'
       ,'This section does not use this maintenance activity.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 63;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,63
       ,'E'
       ,'You cannot modify records in this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 64;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,64
       ,'E'
       ,'Deletion not allowed on this block. Set end date instead.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 65;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,65
       ,'E'
       ,'You cannot create records in this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 66;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,66
       ,'E'
       ,'You cannot make changes in this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 67;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,67
       ,'E'
       ,'You cannot duplicate records in this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 68;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,68
       ,'E'
       ,'Inventory type must be entered before entering Block 3.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 69;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,69
       ,'E'
       ,'Can only query as at or on a range of dates.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 70;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,70
       ,'E'
       ,'End date must be <= today''s date, > start date or null.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 71;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,71
       ,'E'
       ,'Electricity board not applicable for this inventory type.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 72;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,72
       ,'E'
       ,'This is not a valid inventory item type.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 73;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,73
       ,'E'
       ,'Start chainage must be less than length of section.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 74;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,74
       ,'E'
       ,'End chainage must = start or blank for this inv. type.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 75;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,75
       ,'E'
       ,'End chainage must be > start and < section length.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 76;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,76
       ,'E'
       ,'Cross section cannot be entered for this item.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 77;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,77
       ,'E'
       ,'This is not a valid cross-section position.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 78;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,78
       ,'E'
       ,'This is not a valid Electricity Board; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 79;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,79
       ,'E'
       ,'Lamp configuration cannot be recorded for this inv. type.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 80;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,80
       ,'E'
       ,'This is not a valid lamp code.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 81;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,81
       ,'E'
       ,'Value must be entered for this attribute.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 82;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,82
       ,'E'
       ,'This function key is not defined for this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 83;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,83
       ,'E'
       ,'The date entered is not in a valid format eg. 27-MAY-88.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 84;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,84
       ,'E'
       ,'Length of value exceeds maximum length.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 85;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,85
       ,'E'
       ,'The value entered is outside the max and min range.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 86;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,86
       ,'E'
       ,'You cannot create records in this block; use [Enter Query]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 87;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,87
       ,'E'
       ,'List of values not available for this field.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 88;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,88
       ,'W'
       ,'Works Order deleted as no ''lines'' remain on it.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 89;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,89
       ,'E'
       ,'Modified By field must be entered.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 90;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,90
       ,'E'
       ,'Date raised must be <= todays date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 91;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,91
       ,'E'
       ,'Enter Agency, Linkcode and Section or none at all.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 92;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,92
       ,'E'
       ,'You cannot query on start chain unless you enter a section.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 93;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,93
       ,'E'
       ,'Last row of query retrieved.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 94;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,94
       ,'E'
       ,'Modified By field must be completed before amending.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 95;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,95
       ,'E'
       ,'%     b_pc_calc_err.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 96;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,96
       ,'E'
       ,'There are no work order lines for this works order.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 97;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,97
       ,'E'
       ,'This is not a valid division code.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 98;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,98
       ,'E'
       ,'Defect category must be 1.2, 2.1, 2.2 or 2.3'
       ,'Defect category must be 1.2, 2.1, 2.2 or 2.3'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 99;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,99
       ,'E'
       ,'The activity area has not been set up.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 100;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,100
       ,'E'
       ,'Section length must be not null and > 0 before proceeding'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 101;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,101
       ,'E'
       ,'The target linkcode already has this section num'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 102;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,102
       ,'E'
       ,'This is not a valid Works Order Type; use [List]'
       ,'This flag indicates the various kinds of works order.'
       ,'D for detailed inspections, M for cyclic maintenance or'
       ,'S for small schemes.'
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 103;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,103
       ,'E'
       ,'Enter a valid Scheme Type.'
       ,'Valid values may be obtained by using the [List] key.'
       ,'Item codes are populated by entry to this field.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 104;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,104
       ,'E'
       ,'This is not a valid Price Type; use [List]'
       ,'Enter a valid Price Type using List of Values if necessary.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 105;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,105
       ,'E'
       ,'This is not a valid Item Code Breakdown; use [List]'
       ,'List of values may be used to select a valid item code breakdown'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 106;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,106
       ,'E'
       ,'Invalid Engineer''s Initials; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 107;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,107
       ,'S'
       ,'Duplicate records exist in ROAD_GROUPS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 108;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,108
       ,'E'
       ,'Duplicate records exist in CONTRACTOR_DISC_BANDS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 109;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,109
       ,'E'
       ,'Duplicate records exist in GROUP_TYPES.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 110;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,110
       ,'E'
       ,'Duplicate records exist in CONTRACTOR_DISC_GROUPS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 111;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,111
       ,'E'
       ,'This is not a valid Road Group Type; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 112;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,112
       ,'E'
       ,'Discount Group already exists.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 113;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,113
       ,'E'
       ,'This is not a valid Area; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 114;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,114
       ,'E'
       ,'A Discount Band record must exist for a Discount Group.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 115;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,115
       ,'E'
       ,'Discount Band already exists for this Discount Group.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 116;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,116
       ,'E'
       ,'A record must exist in master before querying.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 117;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,117
       ,'E'
       ,'Invalid Defect Type'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 118;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,118
       ,'S'
       ,'Duplicate records exist in ORG_UNITS table.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 119;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,119
       ,'S'
       ,'Duplicate records exist in ACTIVITIES.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 120;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,120
       ,'S'
       ,'Duplicate records exist in TREATMENTS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 121;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,121
       ,'S'
       ,'Duplicate records exist in CONTRACTOR_DIDC_GROUPS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 122;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,122
       ,'S'
       ,'Duplicate records exist in CONTRACTOR_RATES.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 123;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,123
       ,'E'
       ,'This Contractor does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 124;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,124
       ,'E'
       ,'This Activity does not exist; use [List]'
       ,'Enter a valid acivitiy area - user [List of Values] if available.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 125;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,125
       ,'E'
       ,'This Defect Type does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 126;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,126
       ,'E'
       ,'Invalid Treatment Code.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 127;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,127
       ,'E'
       ,'This Discount Group does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 128;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,128
       ,'E'
       ,'Contractor Rate already exists.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 129;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,129
       ,'E'
       ,'This contractor rate overlaps with another rate.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 130;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,130
       ,'E'
       ,'Delete prevented - Work Order Lines exist for this Section.'
       ,'Remove the Works Order Lines associated with this section before'
       ,'deleting the section.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 131;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,131
       ,'E'
       ,'This Activity is not valid for the W.O. Sub Sub Item Code'
       ,'The entered activity is not one of the activities associated'
       ,'with the Sub Sub Item code for this works order.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 132;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,132
       ,'E'
       ,'This Activity must be a Maintenance Activity'
       ,'Only Maintenance activities are valid in this context.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 133;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,133
       ,'E'
       ,'Another Works Order already exists with this number.'
       ,'Works Order Number must be unique within the system.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 134;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,134
       ,'E'
       ,'Date Confirmed must be on or later than the Date Raised'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 135;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,135
       ,'E'
       ,'Contractor records use this Group - Delete prevented.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 136;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,136
       ,'E'
       ,'Contractor Rates records use this Group - Delete prevented.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 137;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,137
       ,'E'
       ,'Every W.O. line must be costed before confirmation'
       ,'At least one works order line record does not have a cost'
       ,'associated with it. Populate the cost field on this record then'
       ,'re-enter the confirmation date.'
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 138;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,138
       ,'W'
       ,'Some GIS selected sections lie outside the nominated group.'
       ,'The list of sections which wree nominated by the GIS are not fully'
       ,'enclosed by the nominated group on the works order.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 139;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,139
       ,'E'
       ,'GIS sections lying outside W.O. Group may not be deleted'
       ,'This record was selected by the GIS and is not used to retrieve'
       ,'defects etc but cannot be deleted or amended.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 140;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,140
       ,'E'
       ,'Group must be entered before entering road selection screen'
       ,'Enter a valid road group then enter road selection screen.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 141;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,141
       ,'S'
       ,'Duplicate records exist in INV_ITEM_TYPES.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 142;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,142
       ,'S'
       ,'Duplicate records exist in REF_BASE.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 143;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,143
       ,'S'
       ,'Duplicate records exist in MAINT_COST_RULES.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 144;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,144
       ,'E'
       ,'This Inventory Type does not exist; use [List]'
       ,'Enter a valid acivitiy area - user [List of Values] if available.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 145;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,145
       ,'E'
       ,'This Rule does not exist; use [List]'
       ,'Enter a valid Rule - use [List of Values] if available.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 146;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,146
       ,'E'
       ,'Inventory Rule already exists.'
       ,'This Inventory rule has already been entered in this table.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 147;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,147
       ,'E'
       ,'This activity is in use on a works order line.'
       ,'This activity is currently being used on a works order line, delete not'
       ,'permitted unless related works order line has been deleted.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 148;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,148
       ,'E'
       ,'Quantities must exist on records to be included.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 149;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,149
       ,'E'
       ,'A Contract must be entered for a confirmed order.'
       ,'If the date confirmed has been entered then a contract must be selected.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 150;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,150
       ,'S'
       ,'Duplicate records exist in BUDGETS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 151;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,151
       ,'E'
       ,'Budget already exists.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 152;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,152
       ,'S'
       ,'Duplicate records exist in JOB_SIZES.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 153;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,153
       ,'S'
       ,'Duplicate records exist in ITEM_CODE_BREAKDOWNS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 154;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,154
       ,'S'
       ,'Duplicate records exist in FINACNIAL_YEARS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 155;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,155
       ,'S'
       ,'Duplicate records exist in ROAD_GROUPS.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 156;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,156
       ,'E'
       ,'Amount must be between Max and Min Job size.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 157;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,157
       ,'E'
       ,'This Agency does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 158;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,158
       ,'E'
       ,'This Job Size does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 159;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,159
       ,'E'
       ,'This Item Type does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 160;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,160
       ,'E'
       ,'This Financial Year does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 161;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,161
       ,'E'
       ,'This Group does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 162;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,162
       ,'E'
       ,'Activity Area must be specified for Small Schemes.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 163;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,163
       ,'E'
       ,'Date Confirmed must not be later than today''s date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 164;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,164
       ,'E'
       ,'Date Closed must not be later than today''s date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 165;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,165
       ,'E'
       ,'Date Completed must be later than Date Instructed %s1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 166;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,166
       ,'E'
       ,'Line changes may not be made to a confirmed works order.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 167;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,167
       ,'E'
       ,'Contractor may not be changed on a confirmed order.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 168;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,168
       ,'E'
       ,'Cost Recharged must not be more than the order Total Cost.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 169;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,169
       ,'E'
       ,'At last record'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 170;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,170
       ,'E'
       ,'A Job Size Code of ''0'' for DTp must exist.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 171;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,171
       ,'E'
       ,'Size must be ''0'' for this job code'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 172;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,172
       ,'E'
       ,'Size must be > ''0'' for this job code'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 173;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,173
       ,'E'
       ,'Maximum size must be > Minimum size'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 174;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,174
       ,'E'
       ,'Minimum size must be < Maximum size'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 175;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,175
       ,'E'
       ,'Job Code must be unique'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 176;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,176
       ,'E'
       ,'Job size values must not overlap those of other job codes'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 177;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,177
       ,'E'
       ,'The Maximum - Minimum job size values must be unbroken'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 178;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,178
       ,'E'
       ,'Commit changes before proceeding'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 179;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,179
       ,'E'
       ,'Selection screens may not be called for closed works orders.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 180;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,180
       ,'E'
       ,'Road Part must be used on a DTp works order'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 181;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,181
       ,'E'
       ,'Start Date overlaps corresponding Contractor Rates records'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 182;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,182
       ,'E'
       ,'End Date overlaps corresponding Contractor Rates records'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 183;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,183
       ,'E'
       ,'Start Date is not contiguous with latest End Date'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 184;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,184
       ,'E'
       ,'End Date is not contiguous with earliest Start Date'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 185;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,185
       ,'E'
       ,'Start, End Date combination overlaps corresponding records'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 186;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,186
       ,'E'
       ,'Deletion prevented when associated Discount Bands exist.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 187;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,187
       ,'E'
       ,'Minimum Value overlaps existing Bands for this Group.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 188;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,188
       ,'E'
       ,'Maximum Value overlaps existing Bands for this Group.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 189;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,189
       ,'E'
       ,'Minimum Value not contiguous with the largest Maximum Value'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 190;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,190
       ,'E'
       ,'Maximum Value not contiguous with the smallest Minimum Value'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 191;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,191
       ,'E'
       ,'Minimum, Maximum combination overlaps other Bands'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 192;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,192
       ,'E'
       ,'Maximum Value must be > Minimum Value'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 193;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,193
       ,'E'
       ,'Minimum Size overlaps other Job Sizes'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 194;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,194
       ,'E'
       ,'Maximum Size overlaps other Job Sizes'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 195;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,195
       ,'E'
       ,'Minimum Size not contiguous with largest Maximum Size'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 196;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,196
       ,'E'
       ,'Maximum Size not contiguous with smallest Minimum Size'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 197;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,197
       ,'E'
       ,'Job Size limits are overlapping or not contiguous'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 198;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,198
       ,'E'
       ,'No Job Size other than Job Code ''0'' starting at 0'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 199;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,199
       ,'E'
       ,'A Band with Min Size 0 must exist for this Group.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 200;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,200
       ,'E'
       ,'Band Value limits are overlapping or not contiguous'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 201;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,201
       ,'E'
       ,'Start Date must not be later than End Date'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 202;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,202
       ,'E'
       ,'Financial Year already exists.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 203;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,203
       ,'E'
       ,'Allowed Conditions are: ''=''.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 204;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,204
       ,'E'
       ,'Allowed Conditions are: ''='', ''<'', ''>''.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 205;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,205
       ,'E'
       ,'Allowed Conditions are: ''='' or ''L''.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 206;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,206
       ,'E'
       ,'This order sequence has already been issued.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 207;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,207
       ,'E'
       ,'Start, End Dates overlap or are not contiguous'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 208;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,208
       ,'E'
       ,'Delete prevented as Budgets exist for this Year.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 209;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,209
       ,'E'
       ,'Rule must be ''A'' or ''S''  (Add or Subtract)'
       ,'You must enter ''A'' or ''S'' for the Rule.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 210;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,210
       ,'E'
       ,'DTp Budgets must have a Job Code of ''0'''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 211;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,211
       ,'E'
       ,'Delete prevented as Budgets exist with this Job Code.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 212;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,212
       ,'E'
       ,'Job Code ''0'' must only be used for DTp Budgets'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 213;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,213
       ,'I'
       ,'This Works Order is affected by External Activities'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 214;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,214
       ,'E'
       ,'Inserts are not permitted in this block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 215;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,215
       ,'E'
       ,'Value must be entered when operator specified.'
       ,'Enter the Value.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 216;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,216
       ,'E'
       ,'Operator must be entered when value specified.'
       ,'Enter the operator.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 217;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,217
       ,'E'
       ,'Allowed Conditions are: ''='',''<='',''>='',''<'' or ''>''.'
       ,'Enter a valid condition.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 218;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,218
       ,'W'
       ,'Works Order is now UNCONFIRMED due to unpriced lines.'
       ,'The Confirmed Date has been removed from this Works Order because'
       ,'lines exist on it with no cost. A Works Order may only be confirmed if'
       ,'all its associated lines have been costed.'
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 219;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,219
       ,'I'
       ,'Remember to enter a new Balancing Sum for this Order'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 220;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,220
       ,'E'
       ,'The upper limit of the largest band must be 9999999999.99'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 221;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,221
       ,'E'
       ,'Defect and Treatment must be ''/'' for non-inspections.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 222;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,222
       ,'E'
       ,'Defect or Treatment wildcards not allowed for Insp. Actys'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 223;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,223
       ,'E'
       ,'Unscheduled Activities are not valid here.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 224;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,224
       ,'E'
       ,'Cyclic Maintenance may not start before the works order date'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 225;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,225
       ,'E'
       ,'Date closed must be later than due date of all lines'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 226;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,226
       ,'W'
       ,'No budget exists for this works order'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 227;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,227
       ,'E'
       ,'Work is scheduled later than the works order end date'
       ,'Enter an end date which is later than all the associated scheduled'
       ,'work on this works order.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 228;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,228
       ,'E'
       ,'No Budgets Exist for this Works order'
       ,'Ensure budget exists for works order before attempting to confirm.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 229;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,229
       ,'E'
       ,'Column is already defined; use [Enter Query]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 230;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,230
       ,'E'
       ,'Column may not be defined; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 231;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,231
       ,'E'
       ,'Invalid Item Code; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 232;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,232
       ,'E'
       ,'This is an invalid Defect Priority; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 233;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,233
       ,'E'
       ,'This Work Category does not exist; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 234;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,234
       ,'E'
       ,'Contracts pricing by area not allow on cyclic work orders'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 235;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,235
       ,'E'
       ,'Group start date cannot be greater than today'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 236;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,236
       ,'E'
       ,'This is not a valid node type; Use [LIST]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 237;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,237
       ,'E'
       ,'More than one completed defect status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 238;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,238
       ,'E'
       ,'No completed defect status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 239;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,239
       ,'E'
       ,'More than one instructed defect status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 240;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,240
       ,'E'
       ,'No instructed defect status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 241;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,241
       ,'E'
       ,'> 1 completed work order line status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 242;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,242
       ,'E'
       ,'No completed work order line status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 243;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,243
       ,'E'
       ,'> 1 instructed work order line status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 244;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,244
       ,'E'
       ,'No instructed work order lines status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 245;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,245
       ,'E'
       ,'Total Qty is outside the allowed range for this item code'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 246;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,246
       ,'E'
       ,'Work Order value should be between %s1 and %s2'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 247;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,247
       ,'W'
       ,'Work Order value should be between %s1 and %s2'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 248;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,248
       ,'E'
       ,'This SISS is invalid'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 249;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,249
       ,'E'
       ,'The Road Group is not valid for your Admin Unit'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 250;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,250
       ,'E'
       ,'This gives a value which is too large for the field size'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 251;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,251
       ,'E'
       ,'BOQ Items must be unique'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 252;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,252
       ,'E'
       ,'Invalid Schedule; Use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 253;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,253
       ,'E'
       ,'Another dimension must be entered'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 254;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,254
       ,'E'
       ,'A Road Id must be entered'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 255;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,255
       ,'E'
       ,'Defects being selected by another user, try again later'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 256;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,256
       ,'E'
       ,'Work order lines must have at least 1 BOQ Item (Id: %s1)'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 257;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,257
       ,'E'
       ,'A Work Category must be entered'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 258;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,258
       ,'E'
       ,'Cannot delete defects automatically created by a cyclic work order'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 259;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,259
       ,'E'
       ,'This status code is only valid for %s1 work order lines'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 260;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,260
       ,'W'
       ,'No inventory rules exist for this item'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 261;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,261
       ,'A'
       ,'Invalid Group'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 262;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,262
       ,'E'
       ,'This defect does not exist in this road group'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 263;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,263
       ,'E'
       ,'Invalid Activity/Defect/Treatment combination'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 264;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,264
       ,'E'
       ,'Item already exists on this treatment model'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 265;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,265
       ,'E'
       ,'Invalid section; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 266;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,266
       ,'E'
       ,'Status codes cannot be amended on an unconfirmed work order'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 267;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,267
       ,'E'
       ,'Contract out of date or has inappropriate status'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 268;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,268
       ,'W'
       ,'Cost Centre not in current list'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 269;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,269
       ,'W'
       ,'Actual quantities have already been set up'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 270;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,270
       ,'E'
       ,'Item does not exist or is not on this schedule'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 271;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,271
       ,'E'
       ,'Line changes may not be made to a completed works order.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 272;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,272
       ,'E'
       ,'Unconfirmed work orders cannot have completed lines'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 273;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,273
       ,'E'
       ,'More than one available defect status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 274;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,274
       ,'E'
       ,'No available defect status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 275;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,275
       ,'E'
       ,'> 1 not done work order line status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 276;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,276
       ,'E'
       ,'No not done work order line status code exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 277;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,277
       ,'E'
       ,'Invalid Frequency; use [List]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 278;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,278
       ,'W'
       ,'This schedule has not yet been completed on %s1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 279;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,279
       ,'E'
       ,'Rogue items on a confirmed works order must have a rate'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 280;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,280
       ,'E'
       ,'Interval does not exist; Use [LIST]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 281;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,281
       ,'E'
       ,'Target complete date should not be before the date raised'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 282;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,282
       ,'E'
       ,'Each line on a confirmed work order must be priced'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 283;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,283
       ,'E'
       ,'Only items on contract can be used on a confirmed work order'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 285;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,285
       ,'E'
       ,'End chain must be larger than the start chain'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 286;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,286
       ,'E'
       ,'Road must be a child of the Work Order header group'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 287;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,287
       ,'E'
       ,'One or more of the mandatory parameters has no default value'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 288;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,288
       ,'W'
       ,'You have not entered the Date Instructed'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 289;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,289
       ,'E'
       ,'All lines must have same work category to confirm an order'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 290;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,290
       ,'E'
       ,'%s1 is a duplicate priority; Duplicates are not allowed.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 291;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,291
       ,'E'
       ,'Code too long for work order number generation (max 8 chars)'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 292;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,292
       ,'E'
       ,'Admin Unit Code too long for work order number (max 6 chars)'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 293;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,293
       ,'E'
       ,'Road is not within the Admin Unit covered by the contract'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 294;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,294
       ,'I'
       ,'Cannot update Road Group as Contract Items already exist for this Contract'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 295;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,295
       ,'E'
       ,'A Contractor with this name already exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 296;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,296
       ,'I'
       ,'Cannot update Item Code as it exists on a Contract'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 297;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,297
       ,'E'
       ,'Unable to Generate Budgets'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 298;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,298
       ,'E'
       ,'Cannot delete restraint as associated inventory exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 299;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,299
       ,'E'
       ,'Cannot delete Contractor as associated Contractor Scheme exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 300;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,300
       ,'E'
       ,'This is an invalid Priority'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 320;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,320
       ,'E'
       ,'Rejections not allowed'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 791;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,791
       ,'I'
       ,'Record Marked as deleted - <Commit> to Confirm'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 792;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,792
       ,'E'
       ,'From Section must be <= To Section'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 793;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,793
       ,'E'
       ,'From Date must be <= To Date'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 794;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,794
       ,'E'
       ,'Road Group Name must be Entered'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 796;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,796
       ,'E'
       ,'Overlapping Inventory'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 797;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,797
       ,'E'
       ,'Duplicate Item already Exists'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 799;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,799
       ,'E'
       ,'There are XSP changes. Press [Commit] or [Rollback]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 800;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,800
       ,'E'
       ,'No interval code exists with this translation; Use [LIST]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 801;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,801
       ,'E'
       ,'The last repair must not be removed.'
       ,'You may not remove the last repair.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 802;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,802
       ,'E'
       ,'You must enter hours minutes and date'
       ,'Enter a value for all three time fields.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 803;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,803
       ,'E'
       ,'Enter a value for the hours and the minutes.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 804;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,804
       ,'W'
       ,'Superseded defects have been re-opened.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 805;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,805
       ,'E'
       ,'Non unique repair type for this defect.'
       ,'The repair type already exists.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 806;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,806
       ,'E'
       ,'Error in code controls; Contact your system support rep.'
       ,'The code control value used to populate defect ids is not available.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 807;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,807
       ,'E'
       ,'No interval exists for the given interval code'
       ,'The interval record identified by the interval code foreign key does not'
       ,'exist. Create an interval with the correct code.'
       ,'No repair date can be calculated without this interval.'
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 808;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,808
       ,'E'
       ,'No interval code exists for this priority and repair type.'
       ,'No interval can be found for the given defect priority and repair type.'
       ,'Hence no repair due date can be calculated.'
       ,'Check the defect priorities table and make sure there is an entry for'
       ,'each of the values. If the message appears during an update to an existing'
       ,'defect, then it implies that a repair type would be rendered illegal by'
       ,'the change to the priority. Check the existing repairs, add new priority'
       ,'records if neccessary.' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 809;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,809
       ,'E'
       ,'No available default defect status.'
       ,'Check the status codes reference data. One of the defect status codes must'
       ,'have a feature code available to indicate that it is used on creation.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 810;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,810
       ,'E'
       ,'Status of defect prevents any changes.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 811;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,811
       ,'E'
       ,'Illegal repair type; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 812;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,812
       ,'E'
       ,'Invalid treatment code; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 813;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,813
       ,'E'
       ,'Future dates not allowed.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 814;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,814
       ,'E'
       ,'A repair needs to be recommended for this defect.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 815;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,815
       ,'E'
       ,'The status of the record prevents update'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 816;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,816
       ,'E'
       ,'Superseded defects may not be removed'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 817;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,817
       ,'E'
       ,'Resource is busy'
       ,'You have tried to access a record which another user has been changing.'
       ,'Try to make the changes later when the other user has finishhed.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 818;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,818
       ,'E'
       ,'The chainage of the start position is too large.'
       ,'Enter a chainage which is less than or equal to the section length.'
       ,'The chainage must also be within the bounds of the inspection.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 819;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,819
       ,'E'
       ,'Illegal status code'
       ,'The code you have entered is not a valid status code.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 820;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,820
       ,'E'
       ,'Illegal Priority; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 821;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,821
       ,'W'
       ,'The repair due date is being set.'
       ,'The repair due date is a function of the priority and repair type. On'
       ,'update of priority, the repair date is recalculated.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 822;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,822
       ,'E'
       ,'Illegal activity area code; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 823;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,823
       ,'E'
       ,'Illegal Inventory Type; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 824;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,824
       ,'W'
       ,'Treatment model may be invalid.'
       ,'The treatment model which was used to create the standard BOQ items'
       ,'may have been invalidated by a change to the treatment code. Check that'
       ,'BOQ items arte consistent with the recommended repair.'
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 825;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,825
       ,'E'
       ,'Not a Notifiable Organisation; Use [LIST]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 826;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,826
       ,'E'
       ,'A type description is required for rogue defect types.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 827;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,827
       ,'E'
       ,'The repair is completed, BOQ items may not be modified.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 828;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,828
       ,'E'
       ,'Illegal Road Section'
       ,'The section is not available due to imposed security.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 829;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,829
       ,'E'
       ,'Not a valid Rechargable Organisation'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 830;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,830
       ,'E'
       ,'Roadstud Type may only be entered for RS inventory types.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 831;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,831
       ,'E'
       ,'Illegal road stud type; Use M or A.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 832;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,832
       ,'E'
       ,'Problem in generating the batch identifier'
       ,'The sequence delivering the batch identifier has failed.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 833;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,833
       ,'E'
       ,'Problem in retrieving the next code control value'
       ,'The code controls next value is unavailable.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 834;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,834
       ,'E'
       ,'At least one Activity must be entered for the Inspection'
       ,'ACTION: You must enter at least one activity for the inspection before'
       ,'proceeding through this form.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 835;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,835
       ,'E'
       ,'Illegal Inspector; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 836;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,836
       ,'E'
       ,'Illegal Second Inspector; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 837;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,837
       ,'E'
       ,'Defects exist; The inspection may not be removed here.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 838;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,838
       ,'W'
       ,'No defects in this inspection'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 839;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,839
       ,'W'
       ,'The defects in the inspection have been updated.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 840;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,840
       ,'E'
       ,'Defects are being updated by another user; Try later.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 841;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,841
       ,'E'
       ,'Problem updating the defect status.'
       ,'A problem has occurred in the update of the defect status codes in this'
       ,'batch.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 842;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,842
       ,'E'
       ,'Illegal batch number.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 843;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,843
       ,'E'
       ,'Inspection may not be later than today.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 844;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,844
       ,'E'
       ,'Illegal Initiation Type; Use [LIST]'
       ,'Use the [LIST] key to display the valid set of inspection reports'
       ,'initiation types. You should have used the [LIST] key in the first place'
       ,'since the [LIST] lamp was lit. If you know the initiation types'
       ,'but just made a spelling mistake then just re-enter the correct'
       ,'initiation type and ignore the instruction "Use [LIST]" on the error'
       ,'message.'
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 846;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,846
       ,'E'
       ,'Illegal Inspection Type; Use S for Safety, D for Detailed.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 847;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,847
       ,'E'
       ,'A road segment must be available prior to next block.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 848;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,848
       ,'E'
       ,'Entry of data is not allowed here.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 849;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,849
       ,'E'
       ,'Defects exist; Update is prevented.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 850;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,850
       ,'E'
       ,'Defects exist at a greater chainage; Update prevented.'
       ,'An attempt has been made to update the end chainage of the inspection'
       ,'despite the fact that defects have been found at a higher chainage'
       ,'during this inspection. The chainages of the defects must be consistent'
       ,'with the chainages of the inspection.'
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 851;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,851
       ,'E'
       ,'Invalid Weather Condition; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 852;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,852
       ,'E'
       ,'Invalid Road Surface Condition; Use [LIST].'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 853;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,853
       ,'E'
       ,'Repairs exist with an invalid treatment for this defect type'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 854;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,854
       ,'E'
       ,'Defects exist on this activity.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 855;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,855
       ,'E'
       ,'Repair does not exist; BOQ items will not exist.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 856;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,856
       ,'E'
       ,'Entering data is not allowed here; Use [CLEAR RECORD]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 857;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,857
       ,'E'
       ,'Defect attribute is invalid; Check the def_type record.'
       ,'The column which is being utilised as a flexible attribute for this'
       ,'defect type can not be found in the ORACLE RDBMS data dictionary.'
       ,'Check the column against the list of values on the Maintain Defect Control'
       ,'data screen.'
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 858;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,858
       ,'E'
       ,'The attribute is mandatory.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 859;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,859
       ,'E'
       ,'The length is invaliid.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 860;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,860
       ,'E'
       ,'Invalid number.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 861;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,861
       ,'E'
       ,'Invalid date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 862;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,862
       ,'E'
       ,'Too many rows returned.'
       ,'See your support representative.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 863;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,863
       ,'E'
       ,'Illegal or no inspection interval assigned to the section.'
       ,'The defect priority information indicates that the interval'
       ,'assigned to the section should be used to calculate the repair due date.'
       ,'This interval code is either invalid or null. Hence the user should check'
       ,'the Next Insp flag on defect priorities, if this is correctly set to Y'
       ,'then an interval code should be assigned to the section.'
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 864;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,864
       ,'E'
       ,'Status code may not be amended to this value; Use [LIST]'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 865;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,865
       ,'E'
       ,'An immediate (completed) repair may not have BOQ items.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 866;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,866
       ,'W'
       ,'The user has no gri data to be copied to the new user.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 867;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,867
       ,'W'
       ,'Record has been changed by another user; Re-execute query.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 868;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,868
       ,'W'
       ,'Repair Time is mandatory for Cat 1 repair action carried out'
       ,'You have not entered a repair time for the immediate/temporary/permanent'
       ,'repair you have specified.  If you were entering details of a repair that'
       ,'has been carried out, then YOU MUST ENTER THE TIME THE REPAIR WAS ACTIONED,'
       ,'else if you were specifying a RECOMMENDED repair then you need not enter a'
       ,'time, but should do so if and when you complete a Works Order for this'
       ,'defect.'
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 869;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,869
       ,'E'
       ,'No BOQ items exist and the repair is completed.'
       ,'Access to the BOQ items block is denied since no boq items exist'
       ,'and the repair is complete. No changes would be possible if entry'
       ,'to the block were available.'
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 870;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,870
       ,'E'
       ,'More than one repair exists; Navigate through repairs;'
       ,'It makes no sense to allow entry to the BOQ block without navigating'
       ,'through the repairs block since more than one repair exists.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 871;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,871
       ,'E'
       ,'Repair cannot be completed before the inspection date.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 872;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,872
       ,'E'
       ,'Selected item code control value exists.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 873;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,873
       ,'E'
       ,'Contract must be entered before Work Order Number can be generated'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 874;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,874
       ,'E'
       ,'The road is closed - you may not change the data'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 875;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,875
       ,'E'
       ,'Line changes may not be made to a printed works order.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 876;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,876
       ,'E'
       ,'You cannot complete the works order line, this contractor uses electronic interfaces'
       ,'The product option COMPWOLEL controls the completion of WOLs'
       ,'where a contractor has interfaces set to Y'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 877;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,877
       ,'E'
       ,'Works order line status prevents modification of BOQ items.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 878;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,878
       ,'E'
       ,'The status of the Works Order line prevents deletion'
       ,'You cannot delete a works order line once it has been completed'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 879;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,879
       ,'W'
       ,'Cannot set an interim status when the Works Order does not allow interim payments.'
       ,'The works order must have the interim payment flag set'
       ,'before performing a valuation.'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 880;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,880
       ,'W'
       ,'Cannot attach a percentage item to this BOQ item'
       ,'This BOQ Item does not allow percentage items'
       ,'Check the set-up of the BOQ item in Standard Items'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 881;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,881
       ,'W'
       ,'Unable to delete the BOQ item'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 882;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,882
       ,'E'
       ,'Cannot complete operation. Budget limit exceeded.'
       ,'You have exceeded the budget limit'
       ,'And will need to clear items from this budget, or raise'
       ,'the budget limit to complete the operation.'
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 883;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,883
       ,'W'
       ,'You cannot authorise a works order you have raised'
       ,'Check the setting of product option AUTH_OWN'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 884;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,884
       ,'W'
       ,'Cannot enter a valuation less than previously paid'
       ,'A valuation must be for a greater amount than previously paid.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 885;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,885
       ,'E'
       ,'Processing halted, unable to obtain lock for contractor'
       ,'There has been a problem with the payment run for this contractor.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 886;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,886
       ,'E'
       ,'Cannot set interim or valuation status once work order line has been completed'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 887;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,887
       ,'I'
       ,'There are no items for payment for this contract.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 888;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,888
       ,'E'
       ,'An error occurred whilst executing the payment run. Payment run halted. '
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 889;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,889
       ,'E'
       ,'Cannot complete, works order cost is outside user limits '
       ,'The limit the current user can authorise, or raise'
       ,'does not cover the cost of the works order'
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 890;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,890
       ,'W'
       ,'You must authorise the work order before it can be instructed '
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 891;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,891
       ,'E'
       ,'No available budget for item code %s1'
       ,'There is no budget for this work item code'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 892;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,892
       ,'E'
       ,'Defect start chainage must be within start and end chainage of inspection'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 893;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,893
       ,'I'
       ,'No new budgets created'
       ,'This years budgets already have budgets for next year.'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 894;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,894
       ,'E'
       ,'Invalid Inventory (Asset) Type for Group'
       ,'ACTION: Please add a valid Inventory (Asset) Type for Group'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 895;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,895
       ,'E'
       ,'Cannot assign new Contract. Contract Items not defined for existing BOQs'
       ,'Update Contract Items for Contract or choose a different Contract'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 896;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,896
       ,'E'
       ,'Item Code seletced must be defined at top Admin unit'
       ,'Select Item Code from LOV or define at top admin unit'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 897;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,897
       ,'E'
       ,'Sub Item Code seletced must be defined at top Admin unit'
       ,'Select Item Code from LOV or define at top admin unit'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 898;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,898
       ,'E'
       ,'The Agency you have entered is invalid according to your Admin Unit'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
--
DELETE FROM HIG_ERRORS
 WHERE HER_APPL = 'M_MGR'
  AND  HER_NO = 899;
--
INSERT INTO HIG_ERRORS
       (HER_APPL
       ,HER_NO
       ,HER_TYPE
       ,HER_DESCR
       ,HER_ACTION_1
       ,HER_ACTION_2
       ,HER_ACTION_3
       ,HER_ACTION_4
       ,HER_ACTION_5
       ,HER_ACTION_6
       ,HER_ACTION_7
       )
SELECT 
        'M_MGR'
       ,899
       ,'E'
       ,'Contract Items related to the BOQs on this Work Order Line are being updated by another User'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'' FROM DUAL;
commit;       
--
-- hig_option for worcs enhancements
--

INSERT INTO HIG_OPTIONS ( HOP_ID, HOP_PRODUCT, HOP_NAME, HOP_VALUE,
HOP_REMARKS ) VALUES ( 
'STADETAIL', 'MAI', 'Detailed Standard Item LOV', 'Y', 'Used in Works Orders Lines to allow detailed Standard Item Codes LOV.'); 

COMMIT;
------------------------------------------------------------------------------------------------
--
set term on
Prompt Compile Schema - see compile_schema.log
set term off
spool off
set feedback on
set define on
select '&exor_base'||'nm3'||'&terminator'||'admin'||
        '&terminator'||'utl'||'&terminator'||'compile_schema.sql' run_file
from dual
/
start '&&run_file'
-- compile_schema produces a file compile_all.sql in the current dir
-- so run it
spool compile_schema.log
--get some db info
select 'Install Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MM:SS') from dual;
SELECT 'Install Running on ' ||LOWER(username||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance
    ,user_users;
--
start compile_all.sql

------------------------------------------
--The compile_all will have reset the user
--context so we must reinitialise it
------------------------------------------
PROMPT Reinitialising context...
BEGIN
  nm3context.initialise_context;
  nm3user.instantiate_user;
END;
/
--
---------------------------------------------------------------------------------------------------
--
Prompt CREATING synonyms that do not exist
Prompt ===================================
EXECUTE nm3ddl.refresh_all_synonyms;
--
---------------------------------------------------------------------------------------------------
--
spool off

prompt Upgrade the version number
DECLARE
   TYPE tab_product IS TABLE OF hig_products.hpr_product%TYPE INDEX BY BINARY_INTEGER;
   l_tab_product tab_product;
BEGIN
   l_tab_product(1) := 'MAI';
   FOR i IN 1..l_tab_product.COUNT
    LOOP
      hig2.upgrade(l_tab_product(i),'mai_3_install.sql','Installed version 3.1.0.0','3.1.0.0');
   END LOOP;
END;
/

PROMPT
PROMPT Finished
spool off

