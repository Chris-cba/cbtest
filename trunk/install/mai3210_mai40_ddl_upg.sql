--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai40_ddl_upg.sql-arc   2.1   Jul 01 2013 16:02:20   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3210_mai40_ddl_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:20  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.21
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--
--
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
--

--
-- Add FK between budgets and financial_years (which is now a cor table) - Graeme
--
ALTER TABLE BUDGETS ADD
CONSTRAINT BUD_FYR_FK
 FOREIGN KEY (BUD_FYR_ID)
 REFERENCES FINANCIAL_YEARS (FYR_ID) ENABLE
/
--
-- Drop the ICB_INDEX_P3 on ITEM_CODE_BREAKDOWNS
--
ALTER TABLE ITEM_CODE_BREAKDOWNS DROP
CONSTRAINT ICB_INDEX_P3
/
--
-- Add new column for use in mai3842.fmb
ALTER TABLE work_order_lines
ADD (wol_final VARCHAR2(1))
/
--
-- Add new column to contracts for use in mai3880.fmb
-- GJ 13-DEC-2006 populate the column with a default value and then make mandatory (log 42618)
--
ALTER TABLE contracts
ADD (con_year_end_date DATE)
/
update contracts
set con_year_end_date = con_end_date
where con_year_end_date IS NULL
/
alter table contracts modify (con_year_end_date DATE NOT NULL)
/

CREATE TABLE WORK_ORDER_PRIORITIES
(
  WPR_ID               VARCHAR2(4)        NOT NULL,
  WPR_NAME             VARCHAR2(30)       NOT NULL,
  WPR_INT_CODE         VARCHAR2(4)        NOT NULL,
  WPR_USE_WORKING_DAYS VARCHAR2(1)        NOT NULL
)
/
ALTER TABLE WORK_ORDER_PRIORITIES ADD (
  CONSTRAINT WPR_PK PRIMARY KEY (WPR_ID)
)
/
--
DROP INDEX icb_index_p3
/
--
DROP SEQUENCE NEG_BOQ_ID_SEQ
/
--
CREATE SEQUENCE NEG_BOQ_ID_SEQ
 INCREMENT BY -1
 START WITH -1
 NOMAXVALUE
 NOMINVALUE
 NOCYCLE
 NOCACHE
/

--
---------------------
-- SM Budgets changes
---------------------
--
CREATE TABLE BUDGET_AUDIT_TRAIL
 (BAT_ID NUMBER
 ,BAT_BUD_ID NUMBER(9)
 ,BAT_PROC VARCHAR2(16)
 ,BAT_WOL_ID NUMBER(9)
 ,BAT_DATE DATE
 ,BAT_VALUE NUMBER(12,2)
 ,BAT_BUD_VALUE NUMBER(12,2)
 ,BAT_BUD_COMMITED NUMBER(12,2)
 ,BAT_BUD_ACTUAL NUMBER(12,2)
 )
/
CREATE SEQUENCE BAT_ID_SEQ
 NOMAXVALUE
 NOMINVALUE
 NOCYCLE
 NOCACHE
/
alter table BUDGETS add BUD_BID_ID varchar2(20)
/
-- CP 01/02/2007 CPA_ID added
--
CREATE TABLE CLAIM_PAYMENTS_AUDIT
 (CPA_ID NUMBER NOT NULL
 ,CPA_WOC_CLAIM_REF VARCHAR2(20) NOT NULL
 ,CPA_WOC_CON_ID NUMBER(9) NOT NULL
 ,CPA_WOL_ID NUMBER(9) NOT NULL
 ,CPA_DATE DATE NOT NULL
 ,CPA_STATUS VARCHAR2(1) NOT NULL
 ,CPA_CLAIM_VALUE NUMBER(11,2)
 ,CPA_PAYMENT_ID NUMBER(9)
 ,CPA_PAYMENT_VALUE NUMBER(11,2)
 ,CPA_PAYMENT_DATE DATE
 ,CPA_FIS_PAYMENT_REF VARCHAR2(20)
 ,CPA_FYR_ID VARCHAR2(5)
 ,CPA_INVOICE_NO VARCHAR2(20)
 )
/

-- CP 01/02/2007 Amended for new col CPA_ID
--  
ALTER TABLE CLAIM_PAYMENTS_AUDIT
 ADD (CONSTRAINT CPA_PK PRIMARY KEY 
  (CPA_ID))
/

-- CP 01/02/2007 Added
CREATE SEQUENCE CPA_ID_SEQ
 NOMAXVALUE
 NOMINVALUE
 NOCYCLE
 NOCACHE
/

--
---------------------------------
-- UKPMS Changes and corrections
---------------------------------
--
-- Recreate table with correct definition
DROP TABLE UKPMS_UKP0018_TEMP
/
CREATE GLOBAL TEMPORARY TABLE UKPMS_UKP0018_TEMP
 (UKP018_RSE_HE_ID NUMBER
 ,UKP018_RSE_LENGTH NUMBER
 ,UKP018_FW_HIER VARCHAR2(2)
 ,UKP018_FW_LENGTH NUMBER
 ,UKP018_XSP VARCHAR2(5)
 ,UKP018_ST_CHAIN NUMBER
 ,UKP018_END_CHAIN NUMBER
 )
/
--
-- Add potentially missing column and constraint
DECLARE
 ex_no_bother EXCEPTION;
 pragma exception_init(ex_no_bother,-1430);
BEGIN
 EXECUTE IMMEDIATE('alter table ukpms_automatic_pass add (uap_run_against_inventory varchar2(1) DEFAULT ''Y'' NOT NULL)');
EXCEPTION
  WHEN ex_no_bother THEN
   Null;
END;
/
--
DECLARE
 ex_no_bother EXCEPTION;
 pragma exception_init(ex_no_bother,-2264);
BEGIN
 EXECUTE IMMEDIATE('alter table ukpms_automatic_pass add constraint uap_rai_yn_chk check (uap_run_against_inventory IN (''Y'', ''N'',''R''))');
EXCEPTION
  WHEN ex_no_bother THEN
   Null;
END;
/
--
DECLARE
 ex_no_bother EXCEPTION;
 pragma exception_init(ex_no_bother,-2264);
BEGIN
 EXECUTE IMMEDIATE('alter table ukpms_automatic_pass add constraint uap_dvicvi_check check (uap_dvi_cvi_precedence IS NOT NULL)');
EXCEPTION
  WHEN ex_no_bother THEN
   Null;
END;
/
--
-- No exception as will want to know if any issues here
alter table ukpms_pass_road_run_time_dets modify (uprtd_road_type varchar2(5))
/
--
CREATE OR REPLACE FORCE VIEW ukpms_auto_pass_network
(
     uap_auto_pass
    ,uap_auto_pass_desc
    ,uap_rule_set
    ,uap_defect_len_merg_method
    ,uap_projection_method
    ,uap_type_of_ranking
    ,uap_is_network_trends_pass
    ,uap_survey_data_cut_off
    ,uap_time_window_start
    ,uap_time_window_effective
    ,uap_time_window_end
    ,uap_number_of_time_windows
    ,uap_network_selection_id
    ,rse_unique
    ,rse_descr
    ,uap_dvi_cvi_precedence
    ,uap_merge_length
    ,uap_ci_count_tolerance_len
    ,uap_ci_count_tolerance_per
    ,uap_pi_only
    ,uap_run_status
    ,uap_run_against_inventory
)
AS SELECT
       uap_auto_pass
     , uap_auto_pass_desc
     , uap_rule_set
     , uap_defect_len_merg_method
     , uap_projection_method
     , uap_type_of_ranking
     , uap_is_network_trends_pass
     , uap_survey_data_cut_off
     , uap_time_window_start
     , uap_time_window_effective
     , uap_time_window_end
     , uap_number_of_time_windows
     , uap_network_selection_id
     , ne_unique
     , ne_descr
     , uap_dvi_cvi_precedence
     , uap_merge_length
     , uap_ci_count_tolerance_len
     , uap_ci_count_tolerance_per
     , uap_pi_only
     , uap_run_status
     , uap_run_against_inventory
 FROM  ukpms_automatic_pass
      ,nm_elements_all
 WHERE uap_network_selection_id = ne_id
/

------------------------------------------------------------------------------------------
-- GJ 25-AUG-2006
-- remove one column and replace with two new ones which are used to support self noticing
--
alter table work_orders add (WOR_REGISTER_FLAG VARCHAR2(1) DEFAULT 'N' NOT NULL)
/
alter table work_orders add (WOR_REGISTER_STATUS VARCHAR2(1))
/
alter table work_orders add constraint WOR_REGISTER_FLAG_CHK CHECK (WOR_REGISTER_FLAG IN ('N', 'Y'))
/
alter table work_orders drop column WOR_STREETWORK_NOTICE
/
-- GJ 25-AUG-2006
-- remove one column and replace with two new ones which are used to support self noticing
------------------------------------------------------------------------------------------
--

--
------------------------------------------------------------------------------------------
-- MH 13-SEP-2006
-- Rebuild hhinv_load_3 with some new columns
--
-- Make Sure That The Backup Table Name Is Not
-- Already In Use.
BEGIN
  execute immediate('DROP TABLE HHINV_LOAD_3_X CASCADE CONSTRAINTS');
EXCEPTION
  WHEN others
   THEN
      NULL;
END;
/

-- Backup hhinv_load_3 To hhinv_load_3_x.
ALTER TABLE hhinv_load_3 RENAME TO hhinv_load_3_x
/

-- Create Updated Table.
CREATE TABLE HHINV_LOAD_3
      (rec_seq_no            number(8)    NOT NULL,
       he_id                 number(8,0)  NOT NULL,
       linkcode              varchar2(10) NOT NULL,
       section_code          varchar2(5)  NOT NULL,
       inv_code              varchar2(4)  NOT NULL,
       attribute             varchar2(32) NOT NULL,
       st_chain              number       NOT NULL,
       end_chain             number       NOT NULL,
       peo_invent_by_id      number(8,0),
       invent_date           date,
       x_sect                varchar2(1),
       value                 varchar2(500),
       error_msg             varchar2(4000),
       error_flg             varchar2(1),
       length                number(6),
       gap                   number(6,2),
       width                 number(6,2),
       height                number(6,2),
       height_2              number(6,2),
       distance              number(7,2),
       angle                 number(6,2),
       no_of_units           number(3),
       power                 number(6),
       type                  varchar2(2),
       class                 varchar2(2),
       material              varchar2(2),
       colour                varchar2(2),
       owner                 varchar2(4),
       method                varchar2(2),
       options               varchar2(2),
       description           varchar2(40),
       id_code               varchar2(8),
       diagram               varchar2(6),
       photo                 varchar2(6),
       note                  varchar2(40),
       instal_date           date,
       itemcode              varchar2(8),
       xtra_char_1           varchar2(20),
       xtra_date_1           date,
       xtra_domain_1         varchar2(2),
       xtra_number_1         number(10,2),
       primary_key           varchar2(50),
       foreign_key           varchar2(50),
       descr                 varchar2(40),        /* Added For NM3 */
       located_by            number(9),           /* Added For NM3 */
       position              number,              /* Added For NM3 */
       x_coord               number,              /* Added For NM3 */
       y_coord               number,              /* Added For NM3 */
       inv_ownership         varchar2(4),         /* Added For NM3 */
       lco_lamp_config_id    number(3),           /* Added For NM3 */
       oun_org_id_elec_board number(8),           /* Added For NM3 */
       prov_flag             varchar2(1),         /* Added For NM3 */
       rev_by                varchar2(20),        /* Added For NM3 */
       rev_date              date,                /* Added For NM3 */
       offset                number,              /* Added For NM3 */
       x                     number,              /* Added For NM3 */
       y                     number,              /* Added For NM3 */
       z                     number,              /* Added For NM3 */
       num_attrib16          number,
       num_attrib17          number,
       num_attrib18          number,
       num_attrib19          number,
       num_attrib20          number,
       num_attrib21          number,
       num_attrib22          number,
       num_attrib23          number,
       num_attrib24          number,
       num_attrib25          number,
       chr_attrib26          varchar2(50),
       chr_attrib27          varchar2(50),
       chr_attrib28          varchar2(50),
       chr_attrib29          varchar2(50),
       chr_attrib30          varchar2(50),
       chr_attrib31          varchar2(50),
       chr_attrib32          varchar2(50),
       chr_attrib33          varchar2(50),
       chr_attrib34          varchar2(50),
       chr_attrib35          varchar2(50),
       chr_attrib36          varchar2(50),
       chr_attrib37          varchar2(50),
       chr_attrib38          varchar2(50),
       chr_attrib39          varchar2(50),
       chr_attrib40          varchar2(50),
       chr_attrib41          varchar2(50),
       chr_attrib42          varchar2(50),
       chr_attrib43          varchar2(50),
       chr_attrib44          varchar2(50),
       chr_attrib45          varchar2(50),
       chr_attrib46          varchar2(50),
       chr_attrib47          varchar2(50),
       chr_attrib48          varchar2(50),
       chr_attrib49          varchar2(50),
       chr_attrib50          varchar2(50),
       chr_attrib51          varchar2(50),
       chr_attrib52          varchar2(50),
       chr_attrib53          varchar2(50),
       chr_attrib54          varchar2(50),
       chr_attrib55          varchar2(50),
       chr_attrib56          varchar2(200),
       chr_attrib57          varchar2(200),
       chr_attrib58          varchar2(200),
       chr_attrib59          varchar2(200),
       chr_attrib60          varchar2(200),
       chr_attrib61          varchar2(200),
       chr_attrib62          varchar2(200),
       chr_attrib63          varchar2(200),
       chr_attrib64          varchar2(200),
       chr_attrib65          varchar2(200),
       chr_attrib66          varchar2(500),
       chr_attrib67          varchar2(500),
       chr_attrib68          varchar2(500),
       chr_attrib69          varchar2(500),
       chr_attrib70          varchar2(500),
       chr_attrib71          varchar2(500),
       chr_attrib72          varchar2(500),
       chr_attrib73          varchar2(500),
       chr_attrib74          varchar2(500),
       chr_attrib75          varchar2(500),
       num_attrib76          number,
       num_attrib77          number,
       num_attrib78          number,
       num_attrib79          number,
       num_attrib80          number,
       num_attrib81          number,
       num_attrib82          number,
       num_attrib83          number,
       num_attrib84          number,
       num_attrib85          number,
       date_attrib86         date,
       date_attrib87         date,
       date_attrib88         date,
       date_attrib89         date,
       date_attrib90         date,
       date_attrib91         date,
       date_attrib92         date,
       date_attrib93         date,
       date_attrib94         date,
       date_attrib95         date,
       num_attrib96          number,          /* Added For NM3 */
       num_attrib97          number,          /* Added For NM3 */
       num_attrib98          number,          /* Added For NM3 */
       num_attrib99          number,          /* Added For NM3 */
       num_attrib100         number,          /* Added For NM3 */
       num_attrib101         number,          /* Added For NM3 */
       num_attrib102         number,          /* Added For NM3 */
       num_attrib103         number,          /* Added For NM3 */
       num_attrib104         number,          /* Added For NM3 */
       num_attrib105         number,          /* Added For NM3 */
       num_attrib106         number,          /* Added For NM3 */
       num_attrib107         number,          /* Added For NM3 */
       num_attrib108         number,          /* Added For NM3 */
       num_attrib109         number,          /* Added For NM3 */
       num_attrib110         number,          /* Added For NM3 */
       num_attrib111         number,          /* Added For NM3 */
       num_attrib112         number,          /* Added For NM3 */
       num_attrib113         number,          /* Added For NM3 */
       num_attrib114         number,          /* Added For NM3 */
       num_attrib115         number,          /* Added For NM3 */
       det_xsp               varchar2(4),
       ity_sys_flag          varchar2(1))
/

-- Add Comment To Table.
COMMENT ON TABLE hhinv_load_3 IS 'Updated For NM3'
/

-- Copy Data From hhinv_load3_x To hhinv_load_3.
DECLARE
  --
  insert_count  NUMBER := 1;
  --
  CURSOR c1
      IS
  SELECT *
    FROM hhinv_load_3_x sel_tbl
       ;
  --
BEGIN
  --
  FOR r1 IN c1 LOOP
    INSERT /*+ APPEND */
      INTO hhinv_load_3 ins_tbl
          (rec_seq_no
          ,he_id
          ,linkcode
          ,section_code
          ,inv_code
          ,attribute
          ,st_chain
          ,end_chain
          ,peo_invent_by_id
          ,invent_date
          ,x_sect
          ,value
          ,error_msg
          ,error_flg
          ,length
          ,gap
          ,width
          ,height
          ,height_2
          ,distance
          ,angle
          ,no_of_units
          ,power
          ,type
          ,class
          ,material
          ,colour
          ,owner
          ,method
          ,options
          ,description
          ,id_code
          ,diagram
          ,photo
          ,note
          ,instal_date
          ,itemcode
          ,xtra_char_1
          ,xtra_date_1
          ,xtra_domain_1
          ,xtra_number_1
          ,primary_key
          ,foreign_key
          ,descr
          ,located_by
          ,position
          ,x_coord
          ,y_coord
          ,inv_ownership
          ,lco_lamp_config_id
          ,oun_org_id_elec_board
          ,prov_flag
          ,rev_by
          ,rev_date
          ,offset
          ,x
          ,y
          ,z
          ,num_attrib16
          ,num_attrib17
          ,num_attrib18
          ,num_attrib19
          ,num_attrib20
          ,num_attrib21
          ,num_attrib22
          ,num_attrib23
          ,num_attrib24
          ,num_attrib25
          ,chr_attrib26
          ,chr_attrib27
          ,chr_attrib28
          ,chr_attrib29
          ,chr_attrib30
          ,chr_attrib31
          ,chr_attrib32
          ,chr_attrib33
          ,chr_attrib34
          ,chr_attrib35
          ,chr_attrib36
          ,chr_attrib37
          ,chr_attrib38
          ,chr_attrib39
          ,chr_attrib40
          ,chr_attrib41
          ,chr_attrib42
          ,chr_attrib43
          ,chr_attrib44
          ,chr_attrib45
          ,chr_attrib46
          ,chr_attrib47
          ,chr_attrib48
          ,chr_attrib49
          ,chr_attrib50
          ,chr_attrib51
          ,chr_attrib52
          ,chr_attrib53
          ,chr_attrib54
          ,chr_attrib55
          ,chr_attrib56
          ,chr_attrib57
          ,chr_attrib58
          ,chr_attrib59
          ,chr_attrib60
          ,chr_attrib61
          ,chr_attrib62
          ,chr_attrib63
          ,chr_attrib64
          ,chr_attrib65
          ,chr_attrib66
          ,chr_attrib67
          ,chr_attrib68
          ,chr_attrib69
          ,chr_attrib70
          ,chr_attrib71
          ,chr_attrib72
          ,chr_attrib73
          ,chr_attrib74
          ,chr_attrib75
          ,num_attrib76
          ,num_attrib77
          ,num_attrib78
          ,num_attrib79
          ,num_attrib80
          ,num_attrib81
          ,num_attrib82
          ,num_attrib83
          ,num_attrib84
          ,num_attrib85
          ,date_attrib86
          ,date_attrib87
          ,date_attrib88
          ,date_attrib89
          ,date_attrib90
          ,date_attrib91
          ,date_attrib92
          ,date_attrib93
          ,date_attrib94
          ,date_attrib95
          ,num_attrib96
          ,num_attrib97
          ,num_attrib98
          ,num_attrib99
          ,num_attrib100
          ,num_attrib101
          ,num_attrib102
          ,num_attrib103
          ,num_attrib104
          ,num_attrib105
          ,num_attrib106
          ,num_attrib107
          ,num_attrib108
          ,num_attrib109
          ,num_attrib110
          ,num_attrib111
          ,num_attrib112
          ,num_attrib113
          ,num_attrib114
          ,num_attrib115
          ,det_xsp
          ,ity_sys_flag)
    VALUES(r1.rec_seq_no
          ,r1.he_id
          ,r1.linkcode
          ,r1.section_code
          ,r1.inv_code
          ,r1.attribute
          ,r1.st_chain
          ,r1.end_chain
          ,r1.peo_invent_by_id
          ,r1.invent_date
          ,r1.x_sect
          ,r1.value
          ,r1.error_msg
          ,r1.error_flg
          ,r1.length
          ,r1.gap
          ,r1.width
          ,r1.height
          ,r1.height_2
          ,r1.distance
          ,r1.angle
          ,r1.no_of_units
          ,r1.power
          ,r1.type
          ,r1.class
          ,r1.material
          ,r1.colour
          ,r1.owner
          ,r1.method
          ,r1.options
          ,r1.description
          ,r1.id_code
          ,r1.diagram
          ,r1.photo
          ,r1.note
          ,r1.instal_date
          ,r1.itemcode
          ,r1.xtra_char_1
          ,r1.xtra_date_1
          ,r1.xtra_domain_1
          ,r1.xtra_number_1
          ,r1.primary_key
          ,r1.foreign_key
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,r1.num_attrib16
          ,r1.num_attrib17
          ,r1.num_attrib18
          ,r1.num_attrib19
          ,r1.num_attrib20
          ,r1.num_attrib21
          ,r1.num_attrib22
          ,r1.num_attrib23
          ,r1.num_attrib24
          ,r1.num_attrib25
          ,r1.chr_attrib26
          ,r1.chr_attrib27
          ,r1.chr_attrib28
          ,r1.chr_attrib29
          ,r1.chr_attrib30
          ,r1.chr_attrib31
          ,r1.chr_attrib32
          ,r1.chr_attrib33
          ,r1.chr_attrib34
          ,r1.chr_attrib35
          ,r1.chr_attrib36
          ,r1.chr_attrib37
          ,r1.chr_attrib38
          ,r1.chr_attrib39
          ,r1.chr_attrib40
          ,r1.chr_attrib41
          ,r1.chr_attrib42
          ,r1.chr_attrib43
          ,r1.chr_attrib44
          ,r1.chr_attrib45
          ,r1.chr_attrib46
          ,r1.chr_attrib47
          ,r1.chr_attrib48
          ,r1.chr_attrib49
          ,r1.chr_attrib50
          ,r1.chr_attrib51
          ,r1.chr_attrib52
          ,r1.chr_attrib53
          ,r1.chr_attrib54
          ,r1.chr_attrib55
          ,r1.chr_attrib56
          ,r1.chr_attrib57
          ,r1.chr_attrib58
          ,r1.chr_attrib59
          ,r1.chr_attrib60
          ,r1.chr_attrib61
          ,r1.chr_attrib62
          ,r1.chr_attrib63
          ,r1.chr_attrib64
          ,r1.chr_attrib65
          ,r1.chr_attrib66
          ,r1.chr_attrib67
          ,r1.chr_attrib68
          ,r1.chr_attrib69
          ,r1.chr_attrib70
          ,r1.chr_attrib71
          ,r1.chr_attrib72
          ,r1.chr_attrib73
          ,r1.chr_attrib74
          ,r1.chr_attrib75
          ,r1.num_attrib76
          ,r1.num_attrib77
          ,r1.num_attrib78
          ,r1.num_attrib79
          ,r1.num_attrib80
          ,r1.num_attrib81
          ,r1.num_attrib82
          ,r1.num_attrib83
          ,r1.num_attrib84
          ,r1.num_attrib85
          ,r1.date_attrib86
          ,r1.date_attrib87
          ,r1.date_attrib88
          ,r1.date_attrib89
          ,r1.date_attrib90
          ,r1.date_attrib91
          ,r1.date_attrib92
          ,r1.date_attrib93
          ,r1.date_attrib94
          ,r1.date_attrib95
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL
          ,NULL);
    /*
    || Commit After Every 100 Inserts To Avoid Large Rollback Segments.
    */
    IF insert_count = 100
    THEN
      COMMIT;
      insert_count := 1;
    ELSE
      insert_count := insert_count + 1;
    END IF;
  END LOOP;

  COMMIT;
END;
/

-- Drop Indexes.
DROP INDEX hhinv_load_3_ind_3
/

DROP INDEX hhinv_load_3_ind_2
/

-- Recreate Indexes.
CREATE INDEX hhinv_load_3_ind_3 ON hhinv_load_3
(rec_seq_no)
/

CREATE INDEX hhinv_load_3_ind_2 ON hhinv_load_3
(error_flg)
/

-- MH 13-SEP-2006
-- Rebuild hhinv_load_3 with some new columns
------------------------------------------------------------------------------------------

-- MH 13-NOV-2006
-- Increase The Size Of Defect And Repair Descriptions To 240 Characters.
--
ALTER TABLE DEFECTS
  MODIFY(DEF_DEFECT_DESCR VARCHAR2(240))
/

ALTER TABLE REPAIRS
  MODIFY(REP_DESCR VARCHAR2(240))
/

ALTER TABLE TEMP_UNDO_DEFECT_EDIT
  MODIFY(DEF_DEFECT_DESCR VARCHAR2(240))
/

-- MH 13-NOV-2006
-- Increase The Size Of Defect And Repair Descriptions To 240 Characters.
------------------------------------------------------------------------------------------
--

-- added by CP 03/01/2007
CREATE INDEX HLR_ID_SEQ_IND ON HH_LOAD_RECS
 (BATCH_ID
 ,SEQUENCE_NO)
/


------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

