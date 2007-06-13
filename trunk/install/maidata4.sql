/***************************************************************************

INFO
====
As at Release 4.0

GENERATION DATE
===============
03-APR-2006 14:27

TABLES PROCESSED
================
COLOUR_LAYER_MAP
NM_INV_DOMAINS_ALL
NM_INV_TYPES_ALL
NM_INV_ATTRI_LOOKUP_ALL
NM_INV_TYPE_ATTRIBS_ALL
INV_TYPE_TRANSLATIONS

TABLE OWNER
===========
MAIDATA31

MODE (A-Append R-Refresh)
========================
A

***************************************************************************/

define sccsid = '$Revision:   2.0  $'
set define off;
set feedback off;

--------------------
-- PRE-PROCESSING --
--------------------
set define on


---------------------------------
-- START OF GENERATED METADATA --
---------------------------------

--
--********** COLOUR_LAYER_MAP **********--
--
-- Columns
-- COM_COLOUR                     NOT NULL VARCHAR2(30)
--   COM_PK (Pos 1)
-- COM_LAYER                      NOT NULL NUMBER(22)
--   COM_LAYER_MAX
--   COM_PK (Pos 2)
--   COM_UK (Pos 1)
--
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Dark Grey'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Dark Grey'
                    AND  COM_LAYER = 1);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Dark Blue'
       ,2 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Dark Blue'
                    AND  COM_LAYER = 2);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Dark Cyan'
       ,3 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Dark Cyan'
                    AND  COM_LAYER = 3);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Brown'
       ,4 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Brown'
                    AND  COM_LAYER = 4);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Dark Red'
       ,5 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Dark Red'
                    AND  COM_LAYER = 5);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Blue'
       ,6 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Blue'
                    AND  COM_LAYER = 6);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Red'
       ,7 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Red'
                    AND  COM_LAYER = 7);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Green'
       ,8 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Green'
                    AND  COM_LAYER = 8);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Cyan'
       ,9 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Cyan'
                    AND  COM_LAYER = 9);
--
INSERT INTO COLOUR_LAYER_MAP
       (COM_COLOUR
       ,COM_LAYER
       )
SELECT 
        'Yellow'
       ,10 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM COLOUR_LAYER_MAP
                   WHERE COM_COLOUR = 'Yellow'
                    AND  COM_LAYER = 10);
--
--
--********** NM_INV_DOMAINS_ALL **********--
--
-- Columns
-- ID_DOMAIN                      NOT NULL VARCHAR2(30)
--   ID_PK (Pos 1)
-- ID_TITLE                       NOT NULL VARCHAR2(80)
-- ID_START_DATE                  NOT NULL DATE
--   ID_START_DATE_TCHK
-- ID_END_DATE                             DATE
--   ID_END_DATE_TCHK
-- ID_DATATYPE                    NOT NULL VARCHAR2(8)
--   ID_DATATYPE_CHK
-- ID_DATE_CREATED                NOT NULL DATE
-- ID_DATE_MODIFIED               NOT NULL DATE
-- ID_MODIFIED_BY                 NOT NULL VARCHAR2(30)
-- ID_CREATED_BY                  NOT NULL VARCHAR2(30)
--
--
--
--********** NM_INV_TYPES_ALL **********--
--
-- Columns
-- NIT_INV_TYPE                   NOT NULL VARCHAR2(4)
--   ITY_PK1 (Pos 1)
-- NIT_PNT_OR_CONT                NOT NULL VARCHAR2(1)
-- NIT_X_SECT_ALLOW_FLAG          NOT NULL VARCHAR2(1)
-- NIT_ELEC_DRAIN_CARR            NOT NULL VARCHAR2(1)
-- NIT_CONTIGUOUS                 NOT NULL VARCHAR2(1)
-- NIT_REPLACEABLE                NOT NULL VARCHAR2(1)
-- NIT_EXCLUSIVE                  NOT NULL VARCHAR2(1)
-- NIT_CATEGORY                   NOT NULL VARCHAR2(1)
-- NIT_DESCR                      NOT NULL VARCHAR2(80)
-- NIT_LINEAR                     NOT NULL VARCHAR2(1)
-- NIT_USE_XY                     NOT NULL VARCHAR2(1)
-- NIT_MULTIPLE_ALLOWED           NOT NULL VARCHAR2(1)
-- NIT_END_LOC_ONLY               NOT NULL VARCHAR2(1)
-- NIT_SCREEN_SEQ                          NUMBER(3)
-- NIT_VIEW_NAME                           VARCHAR2(32)
-- NIT_START_DATE                 NOT NULL DATE
-- NIT_END_DATE                            DATE
-- NIT_SHORT_DESCR                         VARCHAR2(30)
-- NIT_FLEX_ITEM_FLAG             NOT NULL VARCHAR2(1)
-- NIT_TABLE_NAME                          VARCHAR2(30)
-- NIT_LR_NE_COLUMN_NAME                   VARCHAR2(30)
-- NIT_LR_ST_CHAIN                         VARCHAR2(30)
-- NIT_LR_END_CHAIN                        VARCHAR2(30)
-- NIT_ADMIN_TYPE                          VARCHAR2(4)
-- NIT_ICON_NAME                           VARCHAR2(30)
-- NIT_TOP                        NOT NULL VARCHAR2(1)
-- NIT_FOREIGN_PK_COLUMN                   VARCHAR2(30)
-- NIT_UPDATE_ALLOWED             NOT NULL VARCHAR2(1)
-- NIT_DATE_CREATED               NOT NULL DATE
-- NIT_DATE_MODIFIED              NOT NULL DATE
-- NIT_MODIFIED_BY                NOT NULL VARCHAR2(30)
-- NIT_CREATED_BY                 NOT NULL VARCHAR2(30)
--
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_DF'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'Deflectograph'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,70
       ,'BPR_DDF'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112245','YYYYMMDDHH24MISS')
       ,to_date('20031028112245','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_DF');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_DS'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'Deflectograph Summary'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,71
       ,'BPR_DDS'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_DS');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_HL'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'HRM Longitudinal'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,64
       ,'BPR_DHL'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_HL');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_HR'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'HRM Rutting Depth'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,65
       ,'BPR_DHR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_HR');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_HT'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'HRM Macrotexture'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,67
       ,'BPR_DHT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_HT');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_MI'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'HRM Macrotexture Interval'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,68
       ,'BPR_DMI'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_MI');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_RC'
       ,'C'
       ,'Y'
       ,'R'
       ,'N'
       ,'Y'
       ,'N'
       ,'I'
       ,'Road Construction'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,75
       ,'BPR_DRC'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_RC');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_RI'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'HRM Rutting Depth Interval'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,66
       ,'BPR_DRI'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_RI');
--
INSERT INTO NM_INV_TYPES_ALL
       (NIT_INV_TYPE
       ,NIT_PNT_OR_CONT
       ,NIT_X_SECT_ALLOW_FLAG
       ,NIT_ELEC_DRAIN_CARR
       ,NIT_CONTIGUOUS
       ,NIT_REPLACEABLE
       ,NIT_EXCLUSIVE
       ,NIT_CATEGORY
       ,NIT_DESCR
       ,NIT_LINEAR
       ,NIT_USE_XY
       ,NIT_MULTIPLE_ALLOWED
       ,NIT_END_LOC_ONLY
       ,NIT_SCREEN_SEQ
       ,NIT_VIEW_NAME
       ,NIT_START_DATE
       ,NIT_END_DATE
       ,NIT_SHORT_DESCR
       ,NIT_FLEX_ITEM_FLAG
       ,NIT_TABLE_NAME
       ,NIT_LR_NE_COLUMN_NAME
       ,NIT_LR_ST_CHAIN
       ,NIT_LR_END_CHAIN
       ,NIT_ADMIN_TYPE
       ,NIT_ICON_NAME
       ,NIT_TOP
       ,NIT_FOREIGN_PK_COLUMN
       ,NIT_UPDATE_ALLOWED
       ,NIT_DATE_CREATED
       ,NIT_DATE_MODIFIED
       ,NIT_MODIFIED_BY
       ,NIT_CREATED_BY
       )
SELECT 
        'D_SR'
       ,'C'
       ,'Y'
       ,'R'
       ,'Y'
       ,'Y'
       ,'N'
       ,'I'
       ,'Skid'
       ,'N'
       ,'N'
       ,'N'
       ,'N'
       ,69
       ,'BPR_DSR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,''
       ,'N'
       ,''
       ,''
       ,''
       ,''
       ,'&1'
       ,''
       ,'N'
       ,''
       ,'Y'
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,to_date('20031028112246','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPES_ALL
                   WHERE NIT_INV_TYPE = 'D_SR');
--
--
--********** NM_INV_ATTRI_LOOKUP_ALL **********--
--
-- Columns
-- IAL_DOMAIN                     NOT NULL VARCHAR2(30)
--   IAL_PK (Pos 1)
-- IAL_VALUE                      NOT NULL VARCHAR2(30)
--   IAL_PK (Pos 2)
--   IAL_STOP_QUOTE_CHK
-- IAL_DTP_CODE                            VARCHAR2(4)
-- IAL_MEANING                    NOT NULL VARCHAR2(80)
-- IAL_START_DATE                 NOT NULL DATE
--   IAL_PK (Pos 3)
--   IAL_START_DATE_TCHK
-- IAL_END_DATE                            DATE
--   IAL_END_DATE_TCHK
-- IAL_SEQ                        NOT NULL NUMBER(4)
-- IAL_NVA_ID                              VARCHAR2(30)
-- IAL_DATE_CREATED               NOT NULL DATE
-- IAL_DATE_MODIFIED              NOT NULL DATE
-- IAL_MODIFIED_BY                NOT NULL VARCHAR2(30)
-- IAL_CREATED_BY                 NOT NULL VARCHAR2(30)
--
--
--
--********** NM_INV_TYPE_ATTRIBS_ALL **********--
--
-- Columns
-- ITA_INV_TYPE                   NOT NULL VARCHAR2(4)
--   ITA_PK1 (Pos 1)
--   ITA_UK_VIEW_ATTRI (Pos 1)
--   ITA_UK_VIEW_COL (Pos 1)
-- ITA_ATTRIB_NAME                NOT NULL VARCHAR2(30)
--   ITA_COL_IIT_PK_MAND_CHK
--   ITA_COL_UPPER_CHK
--   ITA_PK1 (Pos 2)
-- ITA_DYNAMIC_ATTRIB             NOT NULL VARCHAR2(1)
-- ITA_DISP_SEQ_NO                NOT NULL NUMBER(4)
-- ITA_MANDATORY_YN               NOT NULL VARCHAR2(1)
--   ITA_COL_IIT_PK_MAND_CHK
--   ITA_EXCL_MAND_CHECK
-- ITA_FORMAT                     NOT NULL VARCHAR2(10)
--   ITA_EXCL_TYPE_CHK
--   ITA_FORMAT_CHK
-- ITA_FLD_LENGTH                 NOT NULL NUMBER(4)
-- ITA_DEC_PLACES                          NUMBER(1)
-- ITA_SCRN_TEXT                  NOT NULL VARCHAR2(30)
-- ITA_ID_DOMAIN                           VARCHAR2(30)
--   ITA_EXCL_TYPE_CHK
--   ITA_ID_FK (Pos 1)
-- ITA_VALIDATE_YN                NOT NULL VARCHAR2(1)
-- ITA_DTP_CODE                            VARCHAR2(4)
-- ITA_MAX                                 NUMBER(11,3)
-- ITA_MIN                                 NUMBER(11,3)
-- ITA_VIEW_ATTRI                 NOT NULL VARCHAR2(30)
--   ITA_UK_VIEW_ATTRI (Pos 2)
-- ITA_VIEW_COL_NAME              NOT NULL VARCHAR2(30)
--   ITA_UK_VIEW_COL (Pos 2)
-- ITA_START_DATE                 NOT NULL DATE
--   ITA_START_DATE_TCHK
-- ITA_END_DATE                            DATE
--   ITA_END_DATE_TCHK
-- ITA_QUERYABLE                  NOT NULL VARCHAR2(1)
--   AVCON_11542_ITA_Q_000
-- ITA_UKPMS_PARAM_NO                      NUMBER(2)
-- ITA_UNITS                               NUMBER(4)
-- ITA_FORMAT_MASK                         VARCHAR2(80)
-- ITA_EXCLUSIVE                  NOT NULL VARCHAR2(1)
--   AVCON_11542_ITA_E_000
--   ITA_EXCL_MAND_CHECK
--   ITA_EXCL_TYPE_CHK
--   ITA_EXCL_YN_CHK
-- ITA_KEEP_HISTORY_YN            NOT NULL VARCHAR2(1)
--   ITA_HIST_YN_CHK
-- ITA_DATE_CREATED               NOT NULL DATE
-- ITA_DATE_MODIFIED              NOT NULL DATE
-- ITA_MODIFIED_BY                NOT NULL VARCHAR2(30)
-- ITA_CREATED_BY                 NOT NULL VARCHAR2(30)
-- ITA_QUERY                               VARCHAR2(240)
-- ITA_DISPLAYED                  NOT NULL VARCHAR2(1)
--   ITA_DISPLAYED_CHK
-- ITA_DISP_WIDTH                          NUMBER(3)
--
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_DF'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Survey Date'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113353','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_DF'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_DF'
       ,'IIT_DISTANCE'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING'
       ,'READING'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113727','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_DF'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_DF'
       ,'IIT_OPTIONS'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Direction'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'DIRECTION_CODE'
       ,'DIRECTION_CODE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113733','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_DF'
                    AND  ITA_ATTRIB_NAME = 'IIT_OPTIONS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_DS'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Year'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113740','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_DS'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_DS'
       ,'IIT_DISTANCE'
       ,'Y'
       ,2
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Band A'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'DEF_BAND_A'
       ,'DEF_BAND_A'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113750','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_DS'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_DS'
       ,'IIT_WIDTH'
       ,'Y'
       ,4
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Band C'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'DEF_BAND_C'
       ,'DEF_BAND_C'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113801','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_DS'
                    AND  ITA_ATTRIB_NAME = 'IIT_WIDTH');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_DS'
       ,'IIT_HEIGHT'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Band B'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'DEF_BAND_B'
       ,'DEF_BAND_B'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_DS'
                    AND  ITA_ATTRIB_NAME = 'IIT_HEIGHT');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HL'
       ,'IIT_ANGLE'
       ,'Y'
       ,4
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Upper Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'UPPER_LIMIT'
       ,'UPPER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HL'
                    AND  ITA_ATTRIB_NAME = 'IIT_ANGLE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HL'
       ,'IIT_GAP'
       ,'Y'
       ,5
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Lower Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'LOWER_LIMIT'
       ,'LOWER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HL'
                    AND  ITA_ATTRIB_NAME = 'IIT_GAP');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HL'
       ,'IIT_DISTANCE'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING'
       ,'READING'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HL'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HL'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Survey Date'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HL'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HL'
       ,'IIT_OPTIONS'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Direction'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'DIRECTION_CODE'
       ,'DIRECTION_CODE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HL'
                    AND  ITA_ATTRIB_NAME = 'IIT_OPTIONS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HR'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Survey Date'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HR'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HR'
       ,'IIT_OPTIONS'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Direction'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'DIRECTION_CODE'
       ,'DIRECTION_CODE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HR'
                    AND  ITA_ATTRIB_NAME = 'IIT_OPTIONS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HR'
       ,'IIT_DISTANCE'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING'
       ,'READING'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HR'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HR'
       ,'IIT_ANGLE'
       ,'Y'
       ,4
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Upper Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'UPPER_LIMIT'
       ,'UPPER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HR'
                    AND  ITA_ATTRIB_NAME = 'IIT_ANGLE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HR'
       ,'IIT_GAP'
       ,'Y'
       ,5
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Lower Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'LOWER_LIMIT'
       ,'LOWER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HR'
                    AND  ITA_ATTRIB_NAME = 'IIT_GAP');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HT'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Survey Date'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HT'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HT'
       ,'IIT_DISTANCE'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING'
       ,'READING'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HT'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HT'
       ,'IIT_GAP'
       ,'Y'
       ,5
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Lower Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'LOWER_LIMIT'
       ,'LOWER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HT'
                    AND  ITA_ATTRIB_NAME = 'IIT_GAP');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HT'
       ,'IIT_ANGLE'
       ,'Y'
       ,4
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Upper Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'UPPER_LIMIT'
       ,'UPPER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HT'
                    AND  ITA_ATTRIB_NAME = 'IIT_ANGLE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_HT'
       ,'IIT_OPTIONS'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Direction'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'DIRECTION_CODE'
       ,'DIRECTION_CODE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_HT'
                    AND  ITA_ATTRIB_NAME = 'IIT_OPTIONS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_MI'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Survey Date'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_MI'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_MI'
       ,'IIT_DISTANCE'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING'
       ,'READING'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_MI'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_MI'
       ,'IIT_GAP'
       ,'Y'
       ,5
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Lower Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'LOWER_LIMIT'
       ,'LOWER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_MI'
                    AND  ITA_ATTRIB_NAME = 'IIT_GAP');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_MI'
       ,'IIT_ANGLE'
       ,'Y'
       ,4
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Upper Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'UPPER_LIMIT'
       ,'UPPER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_MI'
                    AND  ITA_ATTRIB_NAME = 'IIT_ANGLE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_MI'
       ,'IIT_OPTIONS'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Direction'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'DIRECTION_CODE'
       ,'DIRECTION_CODE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_MI'
                    AND  ITA_ATTRIB_NAME = 'IIT_OPTIONS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RC'
       ,'IIT_NO_OF_UNITS'
       ,'Y'
       ,1
       ,'N'
       ,'NUMBER'
       ,3
       ,0
       ,'Layer'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'LAYER'
       ,'LAYER'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RC'
                    AND  ITA_ATTRIB_NAME = 'IIT_NO_OF_UNITS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RC'
       ,'IIT_MATERIAL_TXT'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,8
       ,0
       ,'Material'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'MATERIAL'
       ,'MATERIAL'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RC'
                    AND  ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RC'
       ,'IIT_CLASS'
       ,'Y'
       ,4
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Accuracy'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'ACCURACY'
       ,'ACCURACY'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RC'
                    AND  ITA_ATTRIB_NAME = 'IIT_CLASS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RC'
       ,'IIT_LENGTH'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,0
       ,'Depth'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'DEPTH'
       ,'DEPTH'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RC'
                    AND  ITA_ATTRIB_NAME = 'IIT_LENGTH');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RI'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Survey Date'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RI'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RI'
       ,'IIT_OPTIONS'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Direction'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'DIRECTION_CODE'
       ,'DIRECTION_CODE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RI'
                    AND  ITA_ATTRIB_NAME = 'IIT_OPTIONS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RI'
       ,'IIT_DISTANCE'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING'
       ,'READING'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113918','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RI'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RI'
       ,'IIT_GAP'
       ,'Y'
       ,5
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Lower Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'LOWER_LIMIT'
       ,'LOWER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RI'
                    AND  ITA_ATTRIB_NAME = 'IIT_GAP');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_SR'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,1
       ,'N'
       ,'DATE'
       ,7
       ,0
       ,'Survey Date'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'YEAR'
       ,'YEAR'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_SR'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_SR'
       ,'IIT_WIDTH'
       ,'Y'
       ,5
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading 3'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING_3'
       ,'READING_3'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_SR'
                    AND  ITA_ATTRIB_NAME = 'IIT_WIDTH');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_SR'
       ,'IIT_HEIGHT'
       ,'Y'
       ,4
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading 2'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING_2'
       ,'READING_2'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_SR'
                    AND  ITA_ATTRIB_NAME = 'IIT_HEIGHT');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_SR'
       ,'IIT_HEIGHT_2'
       ,'Y'
       ,7
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Investigate Level'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'INVESTIGATE'
       ,'INVESTIGATE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_SR'
                    AND  ITA_ATTRIB_NAME = 'IIT_HEIGHT_2');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_SR'
       ,'IIT_GAP'
       ,'Y'
       ,6
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Average'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'SKID_AVERAGE'
       ,'SKID_AVERAGE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_SR'
                    AND  ITA_ATTRIB_NAME = 'IIT_GAP');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_SR'
       ,'IIT_OPTIONS'
       ,'Y'
       ,2
       ,'N'
       ,'VARCHAR2'
       ,2
       ,0
       ,'Direction'
       ,''
       ,'Y'
       ,''
       ,null
       ,null
       ,'DIRECTION_CODE'
       ,'DIRECTION_CODE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_SR'
                    AND  ITA_ATTRIB_NAME = 'IIT_OPTIONS');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_SR'
       ,'IIT_DISTANCE'
       ,'Y'
       ,3
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Reading 1'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'READING_1'
       ,'READING_1'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_SR'
                    AND  ITA_ATTRIB_NAME = 'IIT_DISTANCE');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RC'
       ,'IIT_XTRA_DATE_1'
       ,'Y'
       ,5
       ,'Y'
       ,'DATE'
       ,11
       ,0
       ,'Material Age'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'MATERIAL AGE'
       ,'MATERIAL AGE'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028113920','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RC'
                    AND  ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1');
--
INSERT INTO NM_INV_TYPE_ATTRIBS_ALL
       (ITA_INV_TYPE
       ,ITA_ATTRIB_NAME
       ,ITA_DYNAMIC_ATTRIB
       ,ITA_DISP_SEQ_NO
       ,ITA_MANDATORY_YN
       ,ITA_FORMAT
       ,ITA_FLD_LENGTH
       ,ITA_DEC_PLACES
       ,ITA_SCRN_TEXT
       ,ITA_ID_DOMAIN
       ,ITA_VALIDATE_YN
       ,ITA_DTP_CODE
       ,ITA_MAX
       ,ITA_MIN
       ,ITA_VIEW_ATTRI
       ,ITA_VIEW_COL_NAME
       ,ITA_START_DATE
       ,ITA_END_DATE
       ,ITA_QUERYABLE
       ,ITA_UKPMS_PARAM_NO
       ,ITA_UNITS
       ,ITA_FORMAT_MASK
       ,ITA_EXCLUSIVE
       ,ITA_KEEP_HISTORY_YN
       ,ITA_DATE_CREATED
       ,ITA_DATE_MODIFIED
       ,ITA_MODIFIED_BY
       ,ITA_CREATED_BY
       ,ITA_QUERY
       ,ITA_DISPLAYED
       ,ITA_DISP_WIDTH
       )
SELECT 
        'D_RI'
       ,'IIT_ANGLE'
       ,'Y'
       ,4
       ,'N'
       ,'NUMBER'
       ,6
       ,2
       ,'Upper Limit'
       ,''
       ,'N'
       ,''
       ,null
       ,null
       ,'UPPER_LIMIT'
       ,'UPPER_LIMIT'
       ,to_date('19000101000000','YYYYMMDDHH24MISS')
       ,null
       ,'N'
       ,null
       ,null
       ,''
       ,'N'
       ,'N'
       ,to_date('20031028114309','YYYYMMDDHH24MISS')
       ,to_date('20060403140136','YYYYMMDDHH24MISS')
       ,'MAIDATA31'
       ,'MAIDATA31'
       ,''
       ,'Y'
       ,1 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM NM_INV_TYPE_ATTRIBS_ALL
                   WHERE ITA_INV_TYPE = 'D_RI'
                    AND  ITA_ATTRIB_NAME = 'IIT_ANGLE');
--
--
--********** INV_TYPE_TRANSLATIONS **********--
--
-- Columns
-- ITY_DTP_FLAG                   NOT NULL VARCHAR2(1)
-- ITY_ELEC_DRAIN_CARR            NOT NULL VARCHAR2(1)
-- ITY_INV_CODE                   NOT NULL VARCHAR2(2)
--   ITY_PK (Pos 1)
-- ITY_PNT_OR_CONT                NOT NULL VARCHAR2(1)
-- ITY_SYS_FLAG                   NOT NULL VARCHAR2(1)
--   ITY_PK (Pos 2)
-- ITY_X_SECT_ALLOW_FLAG          NOT NULL VARCHAR2(1)
-- ITY_CONTIGUOUS                          VARCHAR2(1)
-- ITY_DESCR                               VARCHAR2(40)
-- ITY_DUPLICATE                           VARCHAR2(1)
-- ITY_FEA_CODE                            NUMBER(5)
-- ITY_PARENT_ITY                          VARCHAR2(2)
-- ITY_HHPOS1                              VARCHAR2(32)
-- ITY_HHPOS10                             VARCHAR2(32)
-- ITY_HHPOS11                             VARCHAR2(32)
-- ITY_HHPOS12                             VARCHAR2(32)
-- ITY_HHPOS13                             VARCHAR2(32)
-- ITY_HHPOS14                             VARCHAR2(32)
-- ITY_HHPOS15                             VARCHAR2(32)
-- ITY_HHPOS2                              VARCHAR2(32)
-- ITY_HHPOS3                              VARCHAR2(32)
-- ITY_HHPOS4                              VARCHAR2(32)
-- ITY_HHPOS5                              VARCHAR2(32)
-- ITY_HHPOS6                              VARCHAR2(32)
-- ITY_HHPOS7                              VARCHAR2(32)
-- ITY_HHPOS8                              VARCHAR2(32)
-- ITY_HHPOS9                              VARCHAR2(32)
-- ITY_HHSTRLNGTH                          NUMBER(3)
-- ITY_HHSUBLNG1                           NUMBER(3)
-- ITY_HHSUBLNG10                          NUMBER(3)
-- ITY_HHSUBLNG2                           NUMBER(3)
-- ITY_HHSUBLNG3                           NUMBER(3)
-- ITY_HHSUBLNG4                           NUMBER(3)
-- ITY_HHSUBLNG5                           NUMBER(3)
-- ITY_HHSUBLNG6                           NUMBER(3)
-- ITY_HHSUBLNG7                           NUMBER(3)
-- ITY_HHSUBLNG8                           NUMBER(3)
-- ITY_HHSUBLNG9                           NUMBER(3)
-- ITY_HHSUBSTATS                          DATE
-- ITY_HHSUBSTRT1                          NUMBER(3)
-- ITY_HHSUBSTRT10                         NUMBER(3)
-- ITY_HHSUBSTRT2                          NUMBER(3)
-- ITY_HHSUBSTRT3                          NUMBER(3)
-- ITY_HHSUBSTRT4                          NUMBER(3)
-- ITY_HHSUBSTRT5                          NUMBER(3)
-- ITY_HHSUBSTRT6                          NUMBER(3)
-- ITY_HHSUBSTRT7                          NUMBER(3)
-- ITY_HHSUBSTRT8                          NUMBER(3)
-- ITY_HHSUBSTRT9                          NUMBER(3)
-- ITY_MAX_ATTR_REQ                        NUMBER(2)
-- ITY_MIN_ATTR_REQ                        NUMBER(2)
-- ITY_ROAD_CHARACTERISTIC                 VARCHAR2(1)
-- ITY_SCREEN_SEQ                          NUMBER(3)
-- ITY_TOLERANCE                           NUMBER(3)
-- ITY_VIEW_NAME                           VARCHAR2(32)
-- ITY_START_DATE                          DATE
-- ITY_END_DATE                            DATE
-- ITY_CONTIG_JOINS_GAP                    NUMBER(1)
-- ITY_HHPOS16                             VARCHAR2(32)
-- ITY_HHPOS17                             VARCHAR2(32)
-- ITY_HHPOS18                             VARCHAR2(32)
-- ITY_HHPOS19                             VARCHAR2(32)
-- ITY_HHPOS20                             VARCHAR2(32)
-- ITY_HHPOS21                             VARCHAR2(32)
-- ITY_HHPOS22                             VARCHAR2(32)
-- ITY_HHPOS23                             VARCHAR2(32)
-- ITY_HHPOS24                             VARCHAR2(32)
-- ITY_HHPOS25                             VARCHAR2(32)
-- ITY_HHPOS26                             VARCHAR2(32)
-- ITY_HHPOS27                             VARCHAR2(32)
-- ITY_HHPOS28                             VARCHAR2(32)
-- ITY_HHPOS29                             VARCHAR2(32)
-- ITY_HHPOS30                             VARCHAR2(32)
-- ITY_HHPOS31                             VARCHAR2(32)
-- ITY_HHPOS32                             VARCHAR2(32)
-- ITY_HHPOS33                             VARCHAR2(32)
-- ITY_HHPOS34                             VARCHAR2(32)
-- ITY_HHPOS35                             VARCHAR2(32)
-- ITY_HHPOS36                             VARCHAR2(32)
-- ITY_HHPOS37                             VARCHAR2(32)
-- ITY_HHPOS38                             VARCHAR2(32)
-- ITY_HHPOS39                             VARCHAR2(32)
-- ITY_HHPOS40                             VARCHAR2(32)
-- ITY_HHPOS41                             VARCHAR2(32)
-- ITY_HHPOS42                             VARCHAR2(32)
-- ITY_HHPOS43                             VARCHAR2(32)
-- ITY_HHPOS44                             VARCHAR2(32)
-- ITY_HHPOS45                             VARCHAR2(32)
-- ITY_HHPOS46                             VARCHAR2(32)
-- ITY_HHPOS47                             VARCHAR2(32)
-- ITY_HHPOS48                             VARCHAR2(32)
-- ITY_HHPOS49                             VARCHAR2(32)
-- ITY_HHPOS50                             VARCHAR2(32)
-- ITY_HHPOS51                             VARCHAR2(32)
-- ITY_HHPOS52                             VARCHAR2(32)
-- ITY_HHPOS53                             VARCHAR2(32)
-- ITY_HHPOS54                             VARCHAR2(32)
-- ITY_HHPOS55                             VARCHAR2(32)
-- ITY_HHPOS56                             VARCHAR2(32)
-- ITY_HHPOS57                             VARCHAR2(32)
-- ITY_HHPOS58                             VARCHAR2(32)
-- ITY_HHPOS59                             VARCHAR2(32)
-- ITY_HHPOS60                             VARCHAR2(32)
-- ITY_HHPOS61                             VARCHAR2(32)
-- ITY_HHPOS62                             VARCHAR2(32)
-- ITY_HHPOS63                             VARCHAR2(32)
-- ITY_HHPOS64                             VARCHAR2(32)
-- ITY_HHPOS65                             VARCHAR2(32)
-- ITY_HHPOS66                             VARCHAR2(32)
-- ITY_HHPOS67                             VARCHAR2(32)
-- ITY_HHPOS68                             VARCHAR2(32)
-- ITY_HHPOS69                             VARCHAR2(32)
-- ITY_HHPOS70                             VARCHAR2(32)
-- ITY_HHPOS71                             VARCHAR2(32)
-- ITY_HHPOS72                             VARCHAR2(32)
-- ITY_HHPOS73                             VARCHAR2(32)
-- ITY_HHPOS74                             VARCHAR2(32)
-- ITY_HHPOS75                             VARCHAR2(32)
-- ITY_AREA_OR_LENGTH                      VARCHAR2(1)
-- ITY_SURVEY                              VARCHAR2(1)
-- ITY_MULTI_ALLOWED                       VARCHAR2(1)
-- ITY_SHORT_DESCR                         VARCHAR2(20)
-- ITY_INCL_ROAD_SEGS             NOT NULL VARCHAR2(1)
-- NIT_INV_TYPE                            VARCHAR2(4)
--
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'DF'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'Deflectograph'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'OPTIONS'
       ,'DISTANCE'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,70
       ,null
       ,'BPR_DDF'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_DF' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'DF'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'DS'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'Deflectograph Summary'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'DISTANCE'
       ,'HEIGHT'
       ,'WIDTH'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,71
       ,null
       ,'BPR_DDS'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_DS' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'DS'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'HL'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'HRM Longitudinal'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'OPTIONS'
       ,'DISTANCE'
       ,'ANGLE'
       ,'GAP'
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,64
       ,null
       ,'BPR_DHL'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_HL' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'HL'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'HR'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'HRM Rutting Depth'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'OPTIONS'
       ,'DISTANCE'
       ,'ANGLE'
       ,'GAP'
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,65
       ,null
       ,'BPR_DHR'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_HR' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'HR'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'HT'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'HRM Macrotexture'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'OPTIONS'
       ,'DISTANCE'
       ,'ANGLE'
       ,'GAP'
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,67
       ,null
       ,'BPR_DHT'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_HT' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'HT'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'MI'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'HRM Macrotexture Interval'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'OPTIONS'
       ,'DISTANCE'
       ,'ANGLE'
       ,'GAP'
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,68
       ,null
       ,'BPR_DMI'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_MI' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'MI'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'RC'
       ,'C'
       ,'D'
       ,'Y'
       ,'N'
       ,'Road Construction'
       ,''
       ,null
       ,''
       ,'NO_OF_UNITS'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'MATERIAL'
       ,'LENGTH'
       ,'CLASS'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'R'
       ,75
       ,null
       ,'BPR_DRC'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_RC' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'RC'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'RI'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'HRM Rutting Depth Interval'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'OPTIONS'
       ,'DISTANCE'
       ,'ANGLE'
       ,'GAP'
       ,''
       ,''
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,66
       ,null
       ,'BPR_DRI'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_RI' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'RI'
                    AND  ITY_SYS_FLAG = 'D');
--
INSERT INTO INV_TYPE_TRANSLATIONS
       (ITY_DTP_FLAG
       ,ITY_ELEC_DRAIN_CARR
       ,ITY_INV_CODE
       ,ITY_PNT_OR_CONT
       ,ITY_SYS_FLAG
       ,ITY_X_SECT_ALLOW_FLAG
       ,ITY_CONTIGUOUS
       ,ITY_DESCR
       ,ITY_DUPLICATE
       ,ITY_FEA_CODE
       ,ITY_PARENT_ITY
       ,ITY_HHPOS1
       ,ITY_HHPOS10
       ,ITY_HHPOS11
       ,ITY_HHPOS12
       ,ITY_HHPOS13
       ,ITY_HHPOS14
       ,ITY_HHPOS15
       ,ITY_HHPOS2
       ,ITY_HHPOS3
       ,ITY_HHPOS4
       ,ITY_HHPOS5
       ,ITY_HHPOS6
       ,ITY_HHPOS7
       ,ITY_HHPOS8
       ,ITY_HHPOS9
       ,ITY_HHSTRLNGTH
       ,ITY_HHSUBLNG1
       ,ITY_HHSUBLNG10
       ,ITY_HHSUBLNG2
       ,ITY_HHSUBLNG3
       ,ITY_HHSUBLNG4
       ,ITY_HHSUBLNG5
       ,ITY_HHSUBLNG6
       ,ITY_HHSUBLNG7
       ,ITY_HHSUBLNG8
       ,ITY_HHSUBLNG9
       ,ITY_HHSUBSTATS
       ,ITY_HHSUBSTRT1
       ,ITY_HHSUBSTRT10
       ,ITY_HHSUBSTRT2
       ,ITY_HHSUBSTRT3
       ,ITY_HHSUBSTRT4
       ,ITY_HHSUBSTRT5
       ,ITY_HHSUBSTRT6
       ,ITY_HHSUBSTRT7
       ,ITY_HHSUBSTRT8
       ,ITY_HHSUBSTRT9
       ,ITY_MAX_ATTR_REQ
       ,ITY_MIN_ATTR_REQ
       ,ITY_ROAD_CHARACTERISTIC
       ,ITY_SCREEN_SEQ
       ,ITY_TOLERANCE
       ,ITY_VIEW_NAME
       ,ITY_START_DATE
       ,ITY_END_DATE
       ,ITY_CONTIG_JOINS_GAP
       ,ITY_HHPOS16
       ,ITY_HHPOS17
       ,ITY_HHPOS18
       ,ITY_HHPOS19
       ,ITY_HHPOS20
       ,ITY_HHPOS21
       ,ITY_HHPOS22
       ,ITY_HHPOS23
       ,ITY_HHPOS24
       ,ITY_HHPOS25
       ,ITY_HHPOS26
       ,ITY_HHPOS27
       ,ITY_HHPOS28
       ,ITY_HHPOS29
       ,ITY_HHPOS30
       ,ITY_HHPOS31
       ,ITY_HHPOS32
       ,ITY_HHPOS33
       ,ITY_HHPOS34
       ,ITY_HHPOS35
       ,ITY_HHPOS36
       ,ITY_HHPOS37
       ,ITY_HHPOS38
       ,ITY_HHPOS39
       ,ITY_HHPOS40
       ,ITY_HHPOS41
       ,ITY_HHPOS42
       ,ITY_HHPOS43
       ,ITY_HHPOS44
       ,ITY_HHPOS45
       ,ITY_HHPOS46
       ,ITY_HHPOS47
       ,ITY_HHPOS48
       ,ITY_HHPOS49
       ,ITY_HHPOS50
       ,ITY_HHPOS51
       ,ITY_HHPOS52
       ,ITY_HHPOS53
       ,ITY_HHPOS54
       ,ITY_HHPOS55
       ,ITY_HHPOS56
       ,ITY_HHPOS57
       ,ITY_HHPOS58
       ,ITY_HHPOS59
       ,ITY_HHPOS60
       ,ITY_HHPOS61
       ,ITY_HHPOS62
       ,ITY_HHPOS63
       ,ITY_HHPOS64
       ,ITY_HHPOS65
       ,ITY_HHPOS66
       ,ITY_HHPOS67
       ,ITY_HHPOS68
       ,ITY_HHPOS69
       ,ITY_HHPOS70
       ,ITY_HHPOS71
       ,ITY_HHPOS72
       ,ITY_HHPOS73
       ,ITY_HHPOS74
       ,ITY_HHPOS75
       ,ITY_AREA_OR_LENGTH
       ,ITY_SURVEY
       ,ITY_MULTI_ALLOWED
       ,ITY_SHORT_DESCR
       ,ITY_INCL_ROAD_SEGS
       ,NIT_INV_TYPE
       )
SELECT 
        'D'
       ,'R'
       ,'SR'
       ,'C'
       ,'D'
       ,'Y'
       ,'Y'
       ,'Skid'
       ,''
       ,null
       ,''
       ,'XTRA_DATE_1'
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'OPTIONS'
       ,'DISTANCE'
       ,'HEIGHT'
       ,'WIDTH'
       ,'GAP'
       ,'HEIGHT_2'
       ,''
       ,''
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,null
       ,0
       ,'M'
       ,69
       ,null
       ,'BPR_DSR'
       ,null
       ,null
       ,null
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,''
       ,'1'
       ,'D_SR' FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM INV_TYPE_TRANSLATIONS
                   WHERE ITY_INV_CODE = 'SR'
                    AND  ITY_SYS_FLAG = 'D');
--
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
