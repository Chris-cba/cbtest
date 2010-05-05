------------------------------------------------------------------
-- mai4200_mai4210_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4200_mai4210_ddl_upg.sql-arc   3.1   May 05 2010 15:41:20   malexander  $
--       Module Name      : $Workfile:   mai4200_mai4210_ddl_upg.sql  $
--       Date into PVCS   : $Date:   May 05 2010 15:41:20  $
--       Date fetched Out : $Modtime:   May 05 2010 15:40:12  $
--       Version          : $Revision:   3.1  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2010

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Auto Works Order Creation Rules
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109183
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New tables to store the Auto Work Order Creation Rules.
-- 
------------------------------------------------------------------
CREATE SEQUENCE mawr_id_seq;

CREATE TABLE mai_auto_wo_rules
  (mawr_id                 NUMBER         NOT NULL
  ,mawr_name               VARCHAR2(30)   NOT NULL
  ,mawr_descr              VARCHAR2(500)
  ,mawr_admin_unit         NUMBER(9)      NOT NULL
  ,mawr_road_group_id      NUMBER(9)
  ,mawr_scheme_type        VARCHAR2(2)    NOT NULL
  ,mawr_bud_id             NUMBER(9)      NOT NULL
  ,mawr_con_id             NUMBER(9)      NOT NULL
  ,mawr_aggregate_repairs  VARCHAR2(1)    NOT NULL 
  ,mawr_start_date         DATE           NOT NULL
  ,mawr_end_date           DATE
  ,mawr_enabled            VARCHAR2(1)    Default 'N' NOT NULL 
  ,mawr_created_by         VARCHAR2(30)   NOT NULL
  ,mawr_date_created       DATE           NOT NULL
  ,mawr_modified_by        VARCHAR2(30)   NOT NULL
  ,mawr_date_modified      DATE           NOT NULL);

ALTER TABLE mai_auto_wo_rules
  ADD(CONSTRAINT mawr_pk PRIMARY KEY (mawr_id));

ALTER TABLE mai_auto_wo_rules
  ADD (CONSTRAINT mawr_ne_fk 
  FOREIGN KEY (mawr_road_group_id) 
  REFERENCES nm_elements_all(ne_id));

ALTER TABLE mai_auto_wo_rules
  ADD (CONSTRAINT mawr_nau_fk 
  FOREIGN KEY (mawr_admin_unit) 
  REFERENCES nm_admin_units_all(nau_admin_unit));

Alter TABLE mai_auto_wo_rules ADD (CONSTRAINT mawr_aggregate_repairs_chk CHECK (mawr_aggregate_repairs IN ('Y','N')));

Alter TABLE mai_auto_wo_rules ADD (CONSTRAINT mawr_enabled_chk CHECK (mawr_enabled IN ('Y','N')));

COMMENT ON TABLE mai_auto_wo_rules IS 'Defines the rules for Auto  Work Order Creation'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_id  IS 'Unique identifier generated from a sequence'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_name  IS 'Determines the name of the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_descr IS 'Describes the defined rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_admin_unit  IS 'Identifies the Admin Unit covered by the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_road_group_id  IS 'Identifies the Road Group ID covered by the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_scheme_type IS 'Identifies the Scheme Type to be used on Work Orders created from the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_bud_id  IS 'Identifies the Budget to be used on Work Orders created from the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_con_id  IS 'Identifies the Contract to be used on Work Orders created from the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_aggregate_repairs IS 'Determines whether a defect with multiple qualifying repairs should be placed on a single Work Order or a separate Work Order per repair'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_start_date IS 'Specifies the start date of the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_end_date  IS 'Specifies the end date of the rule'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_DATE_CREATED IS 'Audit details'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_DATE_MODIFIED IS 'Audit details'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_CREATED_BY IS 'Audit details'
/

COMMENT ON COLUMN mai_auto_wo_rules.mawr_MODIFIED_BY IS 'Audit details'
/

CREATE SEQUENCE mawc_id_seq;

CREATE TABLE mai_auto_wo_rule_criteria
  (mawc_id                  NUMBER       NOT NULL
  ,mawc_mawr_id             NUMBER       NOT NULL
  ,mawc_atv_acty_area_code  VARCHAR2(2)  NOT NULL
  ,mawc_dty_defect_code     VARCHAR2(4)
  ,mawc_priority            VARCHAR2(4)
  ,mawc_include_temp_repair VARCHAR2(1)  NOT NULL
  ,mawc_include_perm_repair VARCHAR2(1)  NOT NULL
  ,mawc_tre_treat_code      VARCHAR2(4)
  ,mawc_auto_instruct       VARCHAR2(1)  NOT NULL 
  ,mawc_enabled             VARCHAR2(1)  NOT NULL
  ,mawc_created_by          VARCHAR2(30) NOT NULL
  ,mawc_date_created        DATE         NOT NULL
  ,mawc_modified_by         VARCHAR2(30) NOT NULL
  ,mawc_date_modified       DATE         NOT NULL);

ALTER TABLE mai_auto_wo_rule_criteria
  ADD(CONSTRAINT mawc_pk PRIMARY KEY (mawc_id));

ALTER TABLE mai_auto_wo_rule_criteria
  ADD CONSTRAINT mawc_uk UNIQUE(mawc_mawr_id  
                               ,mawc_atv_acty_area_code
                               ,mawc_dty_defect_code
                               ,mawc_priority
                               ,mawc_include_temp_repair
                               ,mawc_include_perm_repair
                               ,mawc_tre_treat_code);

ALTER TABLE mai_auto_wo_rule_criteria
  ADD (CONSTRAINT mawc_mawr_fk Foreign Key (mawc_mawr_id) References mai_auto_wo_rules (mawr_id));

Alter TABLE mai_auto_wo_rule_criteria ADD (CONSTRAINT mawc_include_temp_repair_chk CHECK (mawc_include_temp_repair IN ('Y','N')));

Alter TABLE mai_auto_wo_rule_criteria ADD (CONSTRAINT mawc_include_perm_repair_chk CHECK (mawc_include_perm_repair IN ('Y','N')));

Alter TABLE mai_auto_wo_rule_criteria ADD (CONSTRAINT mawc_enabled_chk             CHECK (mawc_enabled IN ('Y','N')));

Alter TABLE mai_auto_wo_rule_criteria ADD (CONSTRAINT mawc_auto_instruct_chk       CHECK (mawc_auto_instruct IN ('Y','N')));

COMMENT ON TABLE mai_auto_wo_rule_criteria IS 'Defines the criteria used to identify which defects should be placed onto an automatcaly created  Works Order'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_id  IS 'Unique identifier generated from a sequence'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_atv_acty_area_code  IS 'Identifies the Activity Code'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_dty_defect_code IS 'Identifies the Defect Code'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_priority  IS 'Identifies the Defect Priority'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_include_temp_repair  IS 'This flag indicates whether a WO needs to be generated for Temp repairs'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_include_perm_repair IS  'This flag indicates whether a WO needs to be generated for Permanent repairs'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_tre_treat_code  IS 'Identifies the Treatment Code'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_auto_instruct  IS 'This flag indicate if WO needs to be Auto Instructed after creation'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_enabled IS 'Identifies if the criteria is enabled or disabled'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_DATE_CREATED IS 'Audit details'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_DATE_MODIFIED IS 'Audit details'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_CREATED_BY IS 'Audit details'
/

COMMENT ON COLUMN mai_auto_wo_rule_criteria.mawc_MODIFIED_BY IS 'Audit details'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Defect Superseding Rules
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109270
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New table to store rules used to determine when Defect Superseding should be applied and the tolerance to use when matching Defects
-- 
------------------------------------------------------------------
CREATE SEQUENCE dsr_id_seq
/

CREATE TABLE def_superseding_rules
  (dsr_id               NUMBER(9)    NOT NULL
  ,dsr_admin_unit       NUMBER(9)    NOT NULL
  ,dsr_inititation_type VARCHAR2(3)  NOT NULL
  ,dsr_tolerance        NUMBER       NOT NULL
  ,dsr_created_by       VARCHAR2(30) NOT NULL
  ,dsr_date_created     DATE         NOT NULL
  ,dsr_modified_by      VARCHAR2(30) NOT NULL
  ,dsr_date_modified    DATE         NOT NULL);

ALTER TABLE def_superseding_rules
  ADD (CONSTRAINT dsr_pk
  PRIMARY KEY (dsr_id));

ALTER TABLE def_superseding_rules
  ADD CONSTRAINT dsr_uk
  UNIQUE (dsr_admin_unit,dsr_inititation_type);

ALTER TABLE def_superseding_rules
  ADD (CONSTRAINT dsr_nau_fk
  FOREIGN KEY (dsr_admin_unit)
  REFERENCES nm_admin_units_all(nau_admin_unit));

ALTER TABLE def_superseding_rules
  ADD CONSTRAINT dsr_tolerance_chk
  CHECK (dsr_tolerance >= 0) ENABLE
  VALIDATE;

COMMENT ON TABLE def_superseding_rules IS 'Table to define when Defect Superseding should be applied and the tolerance to use when matching Defects'
/

COMMENT ON COLUMN def_superseding_rules.dsr_id IS 'Unique identifier generated from a sequence' 
/

COMMENT ON COLUMN def_superseding_rules.dsr_admin_unit IS 'Identifies the Admin Unit to which Superseding will be applied'
/

COMMENT ON COLUMN def_superseding_rules.dsr_inititation_type IS 'Identifies the Initiation Type to which Superseding will be applied'
/

COMMENT ON COLUMN def_superseding_rules.dsr_tolerance IS 'Identifies the Tolerance to be used when matching Defects.'
/

COMMENT ON COLUMN def_superseding_rules.dsr_created_by IS 'Audit details'
/

COMMENT ON COLUMN def_superseding_rules.dsr_date_created IS 'Audit details'
/

COMMENT ON COLUMN def_superseding_rules.dsr_modified_by IS 'Audit details'
/

COMMENT ON COLUMN def_superseding_rules.dsr_date_modified IS 'Audit details'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Works Order Work Tray Criteria
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109289
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New tables to store the criteria to be used by the Works Order Work Tray to restrict the Works Orders displayed to a given user.
-- 
------------------------------------------------------------------
CREATE TABLE mai_wo_users
  (mwu_user_id                 NUMBER(9)    NOT NULL
  ,mwu_restrict_by_road_group  VARCHAR2(1)  NOT NULL
  ,mwu_restrict_by_workcode    VARCHAR2(1)  NOT NULL
  ,mwu_receive_alerts          VARCHAR2(1)  NOT NULL
  ,mwu_created_by              VARCHAR2(30) NOT NULL
  ,mwu_date_created            DATE         NOT NULL
  ,mwu_modified_by             VARCHAR2(30) NOT NULL
  ,mwu_date_modified           DATE         NOT NULL);

ALTER TABLE mai_wo_users
  ADD (CONSTRAINT mwu_pk
  PRIMARY KEY (mwu_user_id));

ALTER TABLE mai_wo_users
  ADD (CONSTRAINT mwu_hus_fk 
  FOREIGN KEY (mwu_user_id) 
  REFERENCES hig_users(hus_user_id));

ALTER TABLE mai_wo_users
  ADD CONSTRAINT mwu_restrict_by_road_group_chk
  CHECK (mwu_restrict_by_road_group IN ('Y','N'));

ALTER TABLE mai_wo_users
  ADD CONSTRAINT mwu_restrict_by_workcode_chk
  CHECK (mwu_restrict_by_workcode IN ('Y','N'));

ALTER TABLE mai_wo_users
  ADD CONSTRAINT mwu_receive_alerts_chk
  CHECK (mwu_receive_alerts IN ('Y','N'));

COMMENT ON TABLE mai_wo_users IS 'User specific data relating to Works Orders'
/

COMMENT ON COLUMN mai_wo_users.mwu_user_id IS 'Id of the User to whom this data applies'
/

COMMENT ON COLUMN mai_wo_users.mwu_restrict_by_road_group IS 'Allows the Works Order Work Tray to be restricted by Road Group'
/

COMMENT ON COLUMN mai_wo_users.mwu_restrict_by_workcode IS 'Allows the Works Order Work Tray to be restricted by Work Code'
/

COMMENT ON COLUMN mai_wo_users.mwu_receive_alerts IS 'Identifies the User as a potential recipient of Works Order related Alerts'
/


CREATE TABLE mai_wo_user_road_groups
  (mwur_user_id        NUMBER(9)    NOT NULL
  ,mwur_road_group_id  NUMBER(9)    NOT NULL
  ,mwur_created_by     VARCHAR2(30) NOT NULL
  ,mwur_date_created   DATE         NOT NULL
  ,mwur_modified_by    VARCHAR2(30) NOT NULL
  ,mwur_date_modified  DATE         NOT NULL);

ALTER TABLE mai_wo_user_road_groups
  ADD (CONSTRAINT mwur_pk
  PRIMARY KEY (mwur_user_id,mwur_road_group_id));

ALTER TABLE mai_wo_user_road_groups
  ADD (CONSTRAINT mwur_mwu_fk 
  FOREIGN KEY (mwur_user_id) 
  REFERENCES mai_wo_users(mwu_user_id));
  
ALTER TABLE mai_wo_user_road_groups
  ADD (CONSTRAINT mwur_ne_fk 
  FOREIGN KEY (mwur_road_group_id) 
  REFERENCES nm_elements_all(ne_id));

COMMENT ON TABLE mai_wo_user_road_groups IS 'The Works Order Work Tray will be restricted to the Road Groups specified in this table'
/

COMMENT ON COLUMN mai_wo_user_road_groups.mwur_user_id IS 'Id of the User to whom this data applies'
/

COMMENT ON COLUMN mai_wo_user_road_groups.mwur_road_group_id IS 'The Works Order Work Tray will display Works Orders Related to Sections within the specified Road Group Id'
/


CREATE TABLE mai_wo_user_work_codes
  (mwuw_user_id                NUMBER(9)    NOT NULL
  ,mwuw_icb_item_code          VARCHAR2(2)  NOT NULL
  ,mwuw_icb_sub_item_code      VARCHAR2(2)  
  ,mwuw_icb_sub_sub_item_code  VARCHAR2(2)
  ,mwuw_created_by             VARCHAR2(30) NOT NULL
  ,mwuw_date_created           DATE         NOT NULL
  ,mwuw_modified_by            VARCHAR2(30) NOT NULL
  ,mwuw_date_modified          DATE         NOT NULL);

ALTER TABLE mai_wo_user_work_codes
  ADD CONSTRAINT mwuw_uk UNIQUE(mwuw_user_id
                               ,mwuw_icb_item_code
                               ,mwuw_icb_sub_item_code
                               ,mwuw_icb_sub_sub_item_code);

ALTER TABLE mai_wo_user_work_codes
  ADD (CONSTRAINT mwuw_mwu_fk 
  FOREIGN KEY (mwuw_user_id) 
  REFERENCES mai_wo_users(mwu_user_id));

COMMENT ON TABLE mai_wo_user_work_codes IS 'The Works Order Work Tray will be restricted to the Work Codes specified in this table'
/

COMMENT ON COLUMN mai_wo_user_work_codes.mwuw_user_id IS 'Id of the User to whom this data applies'
/

COMMENT ON COLUMN mai_wo_user_work_codes.mwuw_icb_item_code IS 'The Works Order Work Tray will display Works Orders Related to Budgets with the specified Item Code'
/

COMMENT ON COLUMN mai_wo_user_work_codes.mwuw_icb_sub_item_code IS 'The Works Order Work Tray will display Works Orders Related to Budgets with the specified Sub Item Code'
/

COMMENT ON COLUMN mai_wo_user_work_codes.mwuw_icb_sub_sub_item_code IS 'The Works Order Work Tray will display Works Orders Related to Budgets with the specified Sub Sub Item Code'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Works Order forwarding and flexible attributes
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109038
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 109289
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New columns on the WORK_ORDERS table to allow a Works Order to be forwarded to a given Users Work Tray and a suite of flixible attribute columns.
-- 
------------------------------------------------------------------
ALTER TABLE work_orders
  ADD(wor_forwarded_to  NUMBER(9)
     ,wor_forwarded_by  NUMBER(9)
     ,wor_num_attrib01  NUMBER
     ,wor_num_attrib02  NUMBER
     ,wor_num_attrib03  NUMBER
     ,wor_num_attrib04  NUMBER
     ,wor_num_attrib05  NUMBER
     ,wor_num_attrib06  NUMBER
     ,wor_num_attrib07  NUMBER
     ,wor_num_attrib08  NUMBER
     ,wor_num_attrib09  NUMBER
     ,wor_num_attrib10  NUMBER
     ,wor_num_attrib11  NUMBER
     ,wor_num_attrib12  NUMBER
     ,wor_num_attrib13  NUMBER
     ,wor_num_attrib14  NUMBER
     ,wor_num_attrib15  NUMBER
     ,wor_num_attrib16  NUMBER
     ,wor_num_attrib17  NUMBER
     ,wor_num_attrib18  NUMBER
     ,wor_num_attrib19  NUMBER
     ,wor_num_attrib20  NUMBER
     ,wor_char_attrib21 VARCHAR2(500)
     ,wor_char_attrib22 VARCHAR2(500)
     ,wor_char_attrib23 VARCHAR2(500)
     ,wor_char_attrib24 VARCHAR2(500)
     ,wor_char_attrib25 VARCHAR2(500)
     ,wor_char_attrib26 VARCHAR2(500)
     ,wor_char_attrib27 VARCHAR2(500)
     ,wor_char_attrib28 VARCHAR2(500)
     ,wor_char_attrib29 VARCHAR2(500)
     ,wor_char_attrib30 VARCHAR2(500)
     ,wor_char_attrib31 VARCHAR2(500)
     ,wor_char_attrib32 VARCHAR2(500)
     ,wor_char_attrib33 VARCHAR2(500)
     ,wor_char_attrib34 VARCHAR2(500)
     ,wor_char_attrib35 VARCHAR2(500)
     ,wor_char_attrib36 VARCHAR2(500)
     ,wor_char_attrib37 VARCHAR2(500)
     ,wor_char_attrib38 VARCHAR2(500)
     ,wor_char_attrib39 VARCHAR2(500)
     ,wor_char_attrib40 VARCHAR2(500)
     ,wor_char_attrib41 VARCHAR2(500)
     ,wor_char_attrib42 VARCHAR2(500)
     ,wor_char_attrib43 VARCHAR2(500)
     ,wor_char_attrib44 VARCHAR2(500)
     ,wor_char_attrib45 VARCHAR2(500)
     ,wor_char_attrib46 VARCHAR2(500)
     ,wor_char_attrib47 VARCHAR2(500)
     ,wor_char_attrib48 VARCHAR2(500)
     ,wor_char_attrib49 VARCHAR2(500)
     ,wor_char_attrib50 VARCHAR2(500)
     ,wor_date_attrib51 DATE
     ,wor_date_attrib52 DATE
     ,wor_date_attrib53 DATE
     ,wor_date_attrib54 DATE
     ,wor_date_attrib55 DATE
     ,wor_date_attrib56 DATE
     ,wor_date_attrib57 DATE
     ,wor_date_attrib58 DATE
     ,wor_date_attrib59 DATE
     ,wor_date_attrib60 DATE
     ,wor_date_attrib61 DATE
     ,wor_date_attrib62 DATE
     ,wor_date_attrib63 DATE
     ,wor_date_attrib64 DATE
     ,wor_date_attrib65 DATE
     ,wor_date_attrib66 DATE
     ,wor_date_attrib67 DATE
     ,wor_date_attrib68 DATE
     ,wor_date_attrib69 DATE
     ,wor_date_attrib70 DATE);
     
COMMENT ON COLUMN work_orders.wor_forwarded_to IS 'Id of the User that the Works Order Has Been forwarded to'
/

COMMENT ON COLUMN work_orders.wor_forwarded_by IS 'Id of the User that forwarded the Works Order'
/

COMMENT ON COLUMN work_orders.wor_num_attrib01  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib02  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib03  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib04  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib05  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib06  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib07  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib08  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib09  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib10  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib11  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib12  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib13  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib14  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib15  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib16  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib17  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib18  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib19  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_num_attrib20  IS 'Flexible Numeric Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib21 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib22 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib23 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib24 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib25 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib26 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib27 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib28 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib29 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib30 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib31 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib32 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib33 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib34 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib35 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib36 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib37 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib38 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib39 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib40 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib41 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib42 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib43 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib44 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib45 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib46 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib47 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib48 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib49 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_char_attrib50 IS 'Flexible Character Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib51 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib52 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib53 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib54 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib55 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib56 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib57 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib58 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib59 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib60 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib61 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib62 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib63 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib64 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib65 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib66 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib67 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib68 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib69 IS 'Flexible Date Attribute'
/

COMMENT ON COLUMN work_orders.wor_date_attrib70 IS 'Flexible Date Attribute'
/

------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Defect Status Reason and Date Recorded.
SET TERM OFF

------------------------------------------------------------------
-- ASSOCIATED DEVELOPMENT TASK
-- 109275
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- ASSOCIATED DEVELOPMENT TASK
-- 109278
-- 
-- TASK DETAILS
-- No details supplied
-- 
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- New columns on defects to store a reason for status code change and the date the defect was inspected.
-- 
------------------------------------------------------------------
ALTER TABLE defects
  ADD(def_status_reason   VARCHAR2(500)
     ,def_inspection_date DATE);
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT New Inspection Loader
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (MIKE HUITSON)
-- Tables to support the new Inspection Loader
-- 
------------------------------------------------------------------
CREATE TABLE mai_insp_load_batches
  (milb_batch_id       NUMBER(38)  NOT NULL
  ,milb_hp_process_id  NUMBER(38)  NOT NULL
  ,milb_hpf_file_id    NUMBER(38)  NOT NULL)
/

ALTER TABLE mai_insp_load_batches
  ADD CONSTRAINT milb_pk
  PRIMARY KEY (milb_batch_id)
/

ALTER TABLE mai_insp_load_batches
  ADD CONSTRAINT milb_hp_fk
  FOREIGN KEY (milb_hp_process_id)
  REFERENCES hig_processes(hp_process_id)
/

ALTER TABLE mai_insp_load_batches
  ADD CONSTRAINT milb_hpf_fk
  FOREIGN KEY (milb_hpf_file_id)
  REFERENCES hig_process_files(hpf_file_id)
/

CREATE INDEX milb_hp_fk_ind ON mai_insp_load_batches(milb_hp_process_id)
/

CREATE INDEX milb_hpf_fk_ind ON mai_insp_load_batches(milb_hpf_file_id)
/

CREATE TABLE mai_insp_load_recs
  (milr_batch_id    NUMBER(38)     NOT NULL
  ,milr_seq_no      NUMBER(38)     NOT NULL
  ,milr_rec_type    VARCHAR2(1)
  ,milr_rec_text    VARCHAR2(4000)
  ,milr_error_no    NUMBER(38)
  ,milr_error_text  VARCHAR2(4000)
  ,milr_rec_loaded  VARCHAR2(1) DEFAULT 'N')
/

ALTER TABLE mai_insp_load_recs
  ADD CONSTRAINT milr_pk
  PRIMARY KEY (milr_batch_id, milr_seq_no)
/

ALTER TABLE mai_insp_load_recs
  ADD CONSTRAINT milr_milb_fk
  FOREIGN KEY (milr_batch_id)
  REFERENCES mai_insp_load_batches(milb_batch_id)
/

CREATE TABLE mai_insp_load_error_are
  (are_report_id               NUMBER(8,0) NOT NULL
  ,are_rse_he_id               NUMBER(9,0) NOT NULL
  ,are_batch_id                NUMBER(6,0) NOT NULL
  ,are_created_date            DATE
  ,are_last_updated_date       DATE
  ,are_maint_insp_flag         VARCHAR2(1) NOT NULL
  ,are_sched_act_flag          VARCHAR2(1)
  ,are_date_work_done          DATE
  ,are_end_chain               NUMBER(6,0)
  ,are_initiation_type         VARCHAR2(3)
  ,are_insp_load_date          DATE
  ,are_peo_person_id_actioned  NUMBER(8,0)
  ,are_peo_person_id_insp2     NUMBER(8,0)
  ,are_st_chain                NUMBER(6,0)
  ,are_surface_condition       VARCHAR2(4)
  ,are_weather_condition       VARCHAR2(4)
  ,are_wol_works_order_no      VARCHAR2(16)
  ,are_error                   VARCHAR2(4000))
/

ALTER TABLE mai_insp_load_error_are
  ADD CONSTRAINT mil_are_pk
  PRIMARY KEY (are_report_id)
/

ALTER TABLE mai_insp_load_error_are
  ADD CONSTRAINT mil_are_milb_fk
  FOREIGN KEY (are_batch_id)
  REFERENCES mai_insp_load_batches(milb_batch_id)
/

CREATE INDEX mil_are_milb_fk_ind ON mai_insp_load_error_are(are_batch_id)
/

CREATE TABLE mai_insp_load_error_arl
  (arl_are_report_id       NUMBER(8,0) NOT NULL
  ,arl_atv_acty_area_code  VARCHAR2(2) NOT NULL
  ,arl_error               VARCHAR2(4000))
/

ALTER TABLE mai_insp_load_error_arl
  ADD CONSTRAINT mil_arl_pk
  PRIMARY KEY (arl_are_report_id,arl_atv_acty_area_code)
/

ALTER TABLE mai_insp_load_error_arl
  ADD CONSTRAINT mil_arl_are_fk
  FOREIGN KEY (arl_are_report_id)
  REFERENCES mai_insp_load_error_are(are_report_id)
/

CREATE TABLE mai_insp_load_error_def
  (def_defect_id           NUMBER(8,0)  NOT NULL
  ,def_rse_he_id           NUMBER(9,0)  NOT NULL
  ,def_iit_item_id         NUMBER(9,0)
  ,def_st_chain            NUMBER(6,0)
  ,def_are_report_id       NUMBER(8,0)  NOT NULL
  ,def_atv_acty_area_code  VARCHAR2(2)  NOT NULL
  ,def_siss_id             VARCHAR2(3)
  ,def_works_order_no      VARCHAR2(16)
  ,def_created_date        DATE
  ,def_defect_code         VARCHAR2(4)  NOT NULL
  ,def_last_updated_date   DATE
  ,def_orig_priority       VARCHAR2(4)
  ,def_priority            VARCHAR2(4)  NOT NULL
  ,def_status_code         VARCHAR2(10)
  ,def_superseded_flag     VARCHAR2(1)
  ,def_area                NUMBER(8,1)
  ,def_are_id_not_found    NUMBER(8,0)
  ,def_coord_flag          VARCHAR2(1)
  ,def_date_compl          DATE
  ,def_date_not_found      DATE
  ,def_defect_class        VARCHAR2(1)
  ,def_defect_descr        VARCHAR2(240)
  ,def_defect_type_descr   VARCHAR2(40)
  ,def_diagram_no          VARCHAR2(7)
  ,def_height              NUMBER(6,1)
  ,def_ident_code          VARCHAR2(8)
  ,def_ity_inv_code        VARCHAR2(2)
  ,def_ity_sys_flag        VARCHAR2(1)
  ,def_length              NUMBER(6,1)
  ,def_locn_descr          VARCHAR2(40)
  ,def_maint_wo            NUMBER(8,0)
  ,def_mand_adv            VARCHAR2(1)
  ,def_notify_org_id       NUMBER(8,0)
  ,def_number              NUMBER(5,1)
  ,def_per_cent            NUMBER(5,1)
  ,def_per_cent_orig       NUMBER(5,1)
  ,def_per_cent_rem        NUMBER(5,1)
  ,def_rechar_org_id       NUMBER(8,0)
  ,def_serial_no           VARCHAR2(6)
  ,def_skid_coeff          NUMBER(4,1)
  ,def_special_instr       VARCHAR2(254)
  ,def_superseded_id       NUMBER(8,0)
  ,def_time_hrs            NUMBER(2,0)
  ,def_time_mins           NUMBER(2,0)
  ,def_update_inv          VARCHAR2(1)
  ,def_x_sect              VARCHAR2(1)
  ,def_easting             NUMBER
  ,def_northing            NUMBER
  ,def_response_category   VARCHAR2(4)
  ,def_error               VARCHAR2(4000)
  )
/

ALTER TABLE mai_insp_load_error_def
  ADD CONSTRAINT mil_def_pk
  PRIMARY KEY (def_defect_id)
/

ALTER TABLE mai_insp_load_error_def
  ADD CONSTRAINT mil_def_are_fk
  FOREIGN KEY (def_are_report_id)
  REFERENCES mai_insp_load_error_are(are_report_id)
/

CREATE INDEX mil_def_are_fk_ind ON mai_insp_load_error_def(def_are_report_id)
/

CREATE TABLE mai_insp_load_error_def_attr
  (def_defect_id   NUMBER(8,0)   NOT NULL
  ,def_attr_no     NUMBER(38)    NOT NULL
  ,def_attr_value  VARCHAR2(254))
/

ALTER TABLE mai_insp_load_error_def_attr
  ADD CONSTRAINT mil_def_attr_pk
  PRIMARY KEY (def_defect_id,def_attr_no)
/

ALTER TABLE mai_insp_load_error_def_attr
  ADD CONSTRAINT mil_def_attr_def_fk
  FOREIGN KEY (def_defect_id)
  REFERENCES mai_insp_load_error_def(def_defect_id)
/

CREATE TABLE mai_insp_load_error_rep
  (rep_def_defect_id       NUMBER(8,0) NOT NULL
  ,rep_action_cat          VARCHAR2(1) NOT NULL
  ,rep_rse_he_id           NUMBER(9,0) NOT NULL
  ,rep_tre_treat_code      VARCHAR2(4)
  ,rep_atv_acty_area_code  VARCHAR2(2) NOT NULL
  ,rep_created_date        DATE
  ,rep_date_due            DATE
  ,rep_last_updated_date   DATE
  ,rep_superseded_flag     VARCHAR2(1)
  ,rep_completed_hrs       NUMBER(2,0)
  ,rep_completed_mins      NUMBER(2,0)
  ,rep_date_completed      DATE
  ,rep_descr               VARCHAR2(240)
  ,rep_local_date_due      DATE
  ,rep_old_due_date        DATE
  ,rep_error               VARCHAR2(4000)
  )
/

ALTER TABLE mai_insp_load_error_rep
  ADD CONSTRAINT mil_rep_pk
  PRIMARY KEY (rep_def_defect_id,rep_action_cat)
/

ALTER TABLE mai_insp_load_error_rep
  ADD CONSTRAINT mil_rep_def_fk
  FOREIGN KEY (rep_def_defect_id)
  REFERENCES mai_insp_load_error_def(def_defect_id)
/

CREATE TABLE mai_insp_load_error_boq
  (boq_work_flag       VARCHAR2(1)
  ,boq_defect_id       NUMBER(8,0)  NOT NULL
  ,boq_rep_action_cat  VARCHAR2(1)  NOT NULL
  ,boq_wol_id          NUMBER(9,0)
  ,boq_sta_item_code   VARCHAR2(10) NOT NULL
  ,boq_item_name       VARCHAR2(254)
  ,boq_date_created    DATE
  ,boq_icb_work_code   VARCHAR2(6)
  ,boq_est_dim1        NUMBER(10,2)
  ,boq_est_dim2        NUMBER(10,2)
  ,boq_est_dim3        NUMBER(10,2)
  ,boq_est_quantity    NUMBER(10,2)
  ,boq_est_rate        NUMBER(10,2)
  ,boq_est_discount    NUMBER(6,3)
  ,boq_est_cost        NUMBER(10,2)
  ,boq_est_labour      NUMBER(8,2)
  ,boq_act_dim1        NUMBER(10,2)
  ,boq_act_dim2        NUMBER(10,2)
  ,boq_act_dim3        NUMBER(10,2)
  ,boq_act_quantity    NUMBER(10,2)
  ,boq_act_cost        NUMBER(10,2)
  ,boq_act_labour      NUMBER(8,2)
  ,boq_act_rate        NUMBER(10,2)
  ,boq_act_discount    NUMBER(6,3)
  ,boq_id              NUMBER(9)    NOT NULL
  ,boq_parent_id       NUMBER(9)
  ,boq_error           VARCHAR2(4000)
  )
/

ALTER TABLE mai_insp_load_error_boq
  ADD CONSTRAINT mil_boq_pk
  PRIMARY KEY (boq_id)
/

ALTER TABLE mai_insp_load_error_boq
  ADD CONSTRAINT mil_boq_rep_fk
  FOREIGN KEY (boq_defect_id,boq_rep_action_cat)
  REFERENCES mai_insp_load_error_rep(rep_def_defect_id,rep_action_cat)
/

CREATE INDEX mil_boq_rep_fk_ind ON mai_insp_load_error_boq(boq_defect_id, boq_rep_action_cat)
/

CREATE TABLE mai_insp_load_error_com
  (com_doc_id  					NUMBER(9)    NOT NULL
  ,com_are_report_id    NUMBER(8,0)  NOT NULL
  ,com_title						VARCHAR2(60)
  ,com_category					VARCHAR2(8)
  ,com_dtp_code					VARCHAR2(4)
  ,com_date_issued			DATE
  ,com_reference_code		VARCHAR2(254)
  ,com_descr						VARCHAR2(2000)
  ,com_error           VARCHAR2(4000)
  )
/

ALTER TABLE mai_insp_load_error_com
  ADD CONSTRAINT mil_com_pk
  PRIMARY KEY (com_doc_id)
/

ALTER TABLE mai_insp_load_error_com
  ADD CONSTRAINT mil_com_are_fk
  FOREIGN KEY (com_are_report_id)
  REFERENCES mai_insp_load_error_are(are_report_id)
/

CREATE TABLE mai_insp_load_error_das
  (das_doc_id						NUMBER(9)    NOT NULL
  ,das_are_report_id    NUMBER(8,0)  NOT NULL
  ,das_def_defect_id    NUMBER(8,0)  NOT NULL
  ,das_title						VARCHAR2(60)
  ,das_category					VARCHAR2(8)
  ,das_dtp_code					VARCHAR2(4)
  ,das_date_issued			DATE
  ,das_file							VARCHAR2(254)
  ,das_dlc_dmd_id				NUMBER(9)
  ,das_dlc_id 					NUMBER(9)
  ,das_reference_code		VARCHAR2(254)
  ,das_descr						VARCHAR2(2000)
  ,das_error            VARCHAR2(4000)
  )
/

ALTER TABLE mai_insp_load_error_das
  ADD CONSTRAINT mil_das_pk
  PRIMARY KEY (das_doc_id)
/

ALTER TABLE mai_insp_load_error_das
  ADD CONSTRAINT mil_das_are_fk
  FOREIGN KEY (das_are_report_id)
  REFERENCES mai_insp_load_error_are(are_report_id)
/

ALTER TABLE mai_insp_load_error_das
  ADD CONSTRAINT mil_das_def_fk
  FOREIGN KEY (das_def_defect_id)
  REFERENCES mai_insp_load_error_def(def_defect_id)
/

------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

