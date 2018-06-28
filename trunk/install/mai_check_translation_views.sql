set serveroutput on size 99999

DECLARE

-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mai_check_translation_views.sql-arc   2.2   Jun 28 2018 07:41:56   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_check_translation_views.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 07:41:56  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
--
--   Author : Chris Parkinson
--
--   MAI Translation View checking script
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

/*
-----------------------------------------------------------------------------
Generate the translation view checks from following SQL run on a 'clean' 
install schema
-----------------------------------------------------------------------------
select 'add ('''||table_name||''','''||column_name||''','||column_id||','||data_length||');'
from user_tab_columns
where table_name in (
 'INV_ITEMS_ALL'
,'INV_ITEMS'
,'INV_ITEM_TYPES'
,'INV_TYPE_ATTRIBS'
,'ITY_CATEGORY_ROLES'
,'INV_ITEM_HISTORY'
,'INV_ITEM_TYPES'
,'INV_TYPE_ATTRIBS'
,'INV_ATTRI_DOMAINS'
,'UNIT_CONVERSIONS'
,'UNITS'
,'INV_TYPE_COLOURS'
)
order by table_name, column_id

-----------------------------------------------------------------------------
Generate the Trigger checks with following SQL run on a 'clean' 
install schema
-----------------------------------------------------------------------------
select '  chktrg ('''||table_name||''','''||trigger_name||''');'
from   user_triggers
where  table_name in (
 'INV_ITEMS_ALL'
,'INV_ITEMS'
,'INV_ITEM_TYPES'
,'INV_TYPE_ATTRIBS'
,'ITY_CATEGORY_ROLES'
,'INV_ITEM_HISTORY'
,'INV_ITEM_TYPES'
,'INV_TYPE_ATTRIBS'
,'INV_ATTRI_DOMAINS'
,'UNIT_CONVERSIONS'
,'UNITS'
,'INV_TYPE_COLOURS'
)

*/

  TYPE rec_cols IS RECORD (table_name VARCHAR2(30)
                          ,column_name VARCHAR2(30)
                          ,column_id   NUMBER
                          ,data_length NUMBER);
                             
  TYPE tab_rec_cols IS TABLE OF rec_cols INDEX BY BINARY_INTEGER;
 
  l_tab_rec_cols tab_rec_cols;
 
  -- Declaration of Trigger checking variables
 
  TYPE rec_trgs IS RECORD (table_name   VARCHAR2(30)
                          ,trigger_name VARCHAR2(50));
                             
  TYPE tab_rec_trgs IS TABLE OF rec_trgs INDEX BY BINARY_INTEGER;
 
  l_tab_rec_trgs tab_rec_trgs;

  PROCEDURE add(pi_table_name IN VARCHAR2
               ,pi_column_name IN VARCHAR2
               ,pi_column_id   IN NUMBER
               ,pi_data_length IN NUMBER) IS
              
   l_subscript PLS_INTEGER := l_tab_rec_cols.COUNT+1;              
              
  BEGIN
 
    l_tab_rec_cols(l_subscript).table_name  := pi_table_name;
    l_tab_rec_cols(l_subscript).column_name := pi_column_name;
    l_tab_rec_cols(l_subscript).column_id   := pi_column_id;         
    l_tab_rec_cols(l_subscript).data_length := pi_data_length;           
 
  END add;              
 
  FUNCTION column_ok(pi_rec_cols rec_cols) RETURN BOOLEAN IS

    CURSOR c1 IS
      SELECT 'x'
      FROM   user_tab_cols
      WHERE  table_name  = pi_rec_cols.table_name
      AND    column_name = pi_rec_cols.column_name
      AND    column_id   = pi_rec_cols.column_id
      AND    data_length = pi_rec_cols.data_length;
  
    l_dummy VARCHAR2(1) := Null;
 
  BEGIN

    OPEN  c1;
    FETCH c1 INTO l_dummy;
    CLOSE c1;
  
    IF l_dummy IS NULL THEN
      RETURN(FALSE);
    ELSE
      RETURN(TRUE);
    END IF;
 
  END column_ok;  
  
 
  PROCEDURE chktrg(pi_table_name   IN VARCHAR2
                  ,pi_trigger_name IN VARCHAR2) IS
              
   l_subscript PLS_INTEGER := l_tab_rec_trgs.COUNT+1;              
              
  BEGIN
 
    l_tab_rec_trgs(l_subscript).table_name   := pi_table_name;
    l_tab_rec_trgs(l_subscript).trigger_name := pi_trigger_name;
 
  END chktrg;              
 
  FUNCTION trigger_ok(pi_rec_trgs rec_trgs) RETURN BOOLEAN IS

    CURSOR c1 IS
      SELECT 'x'
      FROM   user_triggers
      WHERE  table_name  = pi_rec_trgs.table_name
      AND    trigger_name = pi_rec_trgs.trigger_name;
  
    l_dummy VARCHAR2(1) := Null;
 
  BEGIN

    OPEN  c1;
    FETCH c1 INTO l_dummy;
    CLOSE c1;
  
    IF l_dummy IS NULL THEN
      RETURN(FALSE);
    ELSE
      RETURN(TRUE);
    END IF;
 
  END trigger_ok;
  
BEGIN

  add ('INV_ATTRI_DOMAINS','IAD_ITA_ATTRIB_NAME',1,30);
  add ('INV_ATTRI_DOMAINS','IAD_ITA_INV_CODE',2,2);
  add ('INV_ATTRI_DOMAINS','IAD_ITA_ITY_SYS_FLAG',3,1);
  add ('INV_ATTRI_DOMAINS','IAD_VALUE',4,30);
  add ('INV_ATTRI_DOMAINS','IAD_DTP_CODE',5,4);
  add ('INV_ATTRI_DOMAINS','IAD_MEANING',6,80);
  add ('INV_ATTRI_DOMAINS','IAD_START_DATE',7,7);
  add ('INV_ATTRI_DOMAINS','IAD_END_DATE',8,7);
  add ('INV_ITEMS','IIT_CREATED_DATE',1,7);
  add ('INV_ITEMS','IIT_CRE_DATE',2,7);
  add ('INV_ITEMS','IIT_ITEM_ID',3,22);
  add ('INV_ITEMS','IIT_ITY_INV_CODE',4,2);
  add ('INV_ITEMS','IIT_ITY_SYS_FLAG',5,1);
  add ('INV_ITEMS','IIT_LAST_UPDATED_DATE',6,7);
  add ('INV_ITEMS','IIT_RSE_HE_ID',7,22);
  add ('INV_ITEMS','IIT_ST_CHAIN',8,22);
  add ('INV_ITEMS','IIT_ANGLE',9,22);
  add ('INV_ITEMS','IIT_ANGLE_TXT',10,20);
  add ('INV_ITEMS','IIT_CLASS',11,2);
  add ('INV_ITEMS','IIT_CLASS_TXT',12,20);
  add ('INV_ITEMS','IIT_COLOUR',13,2);
  add ('INV_ITEMS','IIT_COLOUR_TXT',14,20);
  add ('INV_ITEMS','IIT_COORD_FLAG',15,1);
  add ('INV_ITEMS','IIT_DESCRIPTION',16,40);
  add ('INV_ITEMS','IIT_DIAGRAM',17,6);
  add ('INV_ITEMS','IIT_DISTANCE',18,22);
  add ('INV_ITEMS','IIT_END_CHAIN',19,22);
  add ('INV_ITEMS','IIT_END_DATE',20,7);
  add ('INV_ITEMS','IIT_GAP',21,22);
  add ('INV_ITEMS','IIT_HEIGHT',22,22);
  add ('INV_ITEMS','IIT_HEIGHT_2',23,22);
  add ('INV_ITEMS','IIT_ID_CODE',24,8);
  add ('INV_ITEMS','IIT_INSTAL_DATE',25,7);
  add ('INV_ITEMS','IIT_INVENT_DATE',26,7);
  add ('INV_ITEMS','IIT_INV_OWNERSHIP',27,4);
  add ('INV_ITEMS','IIT_ITEMCODE',28,8);
  add ('INV_ITEMS','IIT_LCO_LAMP_CONFIG_ID',29,22);
  add ('INV_ITEMS','IIT_LENGTH',30,22);
  add ('INV_ITEMS','IIT_MATERIAL',31,30);
  add ('INV_ITEMS','IIT_MATERIAL_TXT',32,20);
  add ('INV_ITEMS','IIT_METHOD',33,2);
  add ('INV_ITEMS','IIT_METHOD_TXT',34,20);
  add ('INV_ITEMS','IIT_NOTE',35,40);
  add ('INV_ITEMS','IIT_NO_OF_UNITS',36,22);
  add ('INV_ITEMS','IIT_OPTIONS',37,2);
  add ('INV_ITEMS','IIT_OPTIONS_TXT',38,20);
  add ('INV_ITEMS','IIT_OUN_ORG_ID_ELEC_BOARD',39,22);
  add ('INV_ITEMS','IIT_OWNER',40,4);
  add ('INV_ITEMS','IIT_OWNER_TXT',41,20);
  add ('INV_ITEMS','IIT_PEO_INVENT_BY_ID',42,22);
  add ('INV_ITEMS','IIT_PHOTO',43,6);
  add ('INV_ITEMS','IIT_POWER',44,22);
  add ('INV_ITEMS','IIT_PROV_FLAG',45,1);
  add ('INV_ITEMS','IIT_REV_BY',46,20);
  add ('INV_ITEMS','IIT_REV_DATE',47,7);
  add ('INV_ITEMS','IIT_TYPE',48,2);
  add ('INV_ITEMS','IIT_TYPE_TXT',49,20);
  add ('INV_ITEMS','IIT_WIDTH',50,22);
  add ('INV_ITEMS','IIT_XTRA_CHAR_1',51,20);
  add ('INV_ITEMS','IIT_XTRA_DATE_1',52,7);
  add ('INV_ITEMS','IIT_XTRA_DOMAIN_1',53,2);
  add ('INV_ITEMS','IIT_XTRA_DOMAIN_TXT_1',54,20);
  add ('INV_ITEMS','IIT_XTRA_NUMBER_1',55,22);
  add ('INV_ITEMS','IIT_X_SECT',56,4);
  add ('INV_ITEMS','IIT_PRIMARY_KEY',57,50);
  add ('INV_ITEMS','IIT_FOREIGN_KEY',58,50);
  add ('INV_ITEMS','IIT_DET_XSP',59,4);
  add ('INV_ITEMS','IIT_OFFSET',60,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB16',61,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB17',62,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB18',63,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB19',64,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB20',65,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB21',66,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB22',67,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB23',68,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB24',69,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB25',70,22);
  add ('INV_ITEMS','IIT_CHR_ATTRIB26',71,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB27',72,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB28',73,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB29',74,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB30',75,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB31',76,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB32',77,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB33',78,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB34',79,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB35',80,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB36',81,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB37',82,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB38',83,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB39',84,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB40',85,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB41',86,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB42',87,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB43',88,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB44',89,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB45',90,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB46',91,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB47',92,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB48',93,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB49',94,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB50',95,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB51',96,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB52',97,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB53',98,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB54',99,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB55',100,50);
  add ('INV_ITEMS','IIT_CHR_ATTRIB56',101,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB57',102,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB58',103,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB59',104,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB60',105,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB61',106,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB62',107,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB63',108,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB64',109,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB65',110,200);
  add ('INV_ITEMS','IIT_CHR_ATTRIB66',111,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB67',112,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB68',113,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB69',114,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB70',115,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB71',116,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB72',117,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB73',118,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB74',119,500);
  add ('INV_ITEMS','IIT_CHR_ATTRIB75',120,500);
  add ('INV_ITEMS','IIT_NUM_ATTRIB76',121,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB77',122,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB78',123,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB79',124,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB80',125,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB81',126,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB82',127,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB83',128,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB84',129,22);
  add ('INV_ITEMS','IIT_NUM_ATTRIB85',130,22);
  add ('INV_ITEMS','IIT_DATE_ATTRIB86',131,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB87',132,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB88',133,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB89',134,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB90',135,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB91',136,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB92',137,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB93',138,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB94',139,7);
  add ('INV_ITEMS','IIT_DATE_ATTRIB95',140,7);
  add ('INV_ITEMS_ALL','IIT_CREATED_DATE',1,7);
  add ('INV_ITEMS_ALL','IIT_CRE_DATE',2,7);
  add ('INV_ITEMS_ALL','IIT_ITEM_ID',3,22);
  add ('INV_ITEMS_ALL','IIT_ITY_INV_CODE',4,2);
  add ('INV_ITEMS_ALL','IIT_ITY_SYS_FLAG',5,1);
  add ('INV_ITEMS_ALL','IIT_LAST_UPDATED_DATE',6,7);
  add ('INV_ITEMS_ALL','IIT_RSE_HE_ID',7,22);
  add ('INV_ITEMS_ALL','IIT_ST_CHAIN',8,22);
  add ('INV_ITEMS_ALL','IIT_ANGLE',9,22);
  add ('INV_ITEMS_ALL','IIT_ANGLE_TXT',10,20);
  add ('INV_ITEMS_ALL','IIT_CLASS',11,2);
  add ('INV_ITEMS_ALL','IIT_CLASS_TXT',12,20);
  add ('INV_ITEMS_ALL','IIT_COLOUR',13,2);
  add ('INV_ITEMS_ALL','IIT_COLOUR_TXT',14,20);
  add ('INV_ITEMS_ALL','IIT_COORD_FLAG',15,1);
  add ('INV_ITEMS_ALL','IIT_DESCRIPTION',16,40);
  add ('INV_ITEMS_ALL','IIT_DIAGRAM',17,6);
  add ('INV_ITEMS_ALL','IIT_DISTANCE',18,22);
  add ('INV_ITEMS_ALL','IIT_END_CHAIN',19,22);
  add ('INV_ITEMS_ALL','IIT_END_DATE',20,7);
  add ('INV_ITEMS_ALL','IIT_GAP',21,22);
  add ('INV_ITEMS_ALL','IIT_HEIGHT',22,22);
  add ('INV_ITEMS_ALL','IIT_HEIGHT_2',23,22);
  add ('INV_ITEMS_ALL','IIT_ID_CODE',24,8);
  add ('INV_ITEMS_ALL','IIT_INSTAL_DATE',25,7);
  add ('INV_ITEMS_ALL','IIT_INVENT_DATE',26,7);
  add ('INV_ITEMS_ALL','IIT_INV_OWNERSHIP',27,4);
  add ('INV_ITEMS_ALL','IIT_ITEMCODE',28,8);
  add ('INV_ITEMS_ALL','IIT_LCO_LAMP_CONFIG_ID',29,22);
  add ('INV_ITEMS_ALL','IIT_LENGTH',30,22);
  add ('INV_ITEMS_ALL','IIT_MATERIAL',31,30);
  add ('INV_ITEMS_ALL','IIT_MATERIAL_TXT',32,20);
  add ('INV_ITEMS_ALL','IIT_METHOD',33,2);
  add ('INV_ITEMS_ALL','IIT_METHOD_TXT',34,20);
  add ('INV_ITEMS_ALL','IIT_NOTE',35,40);
  add ('INV_ITEMS_ALL','IIT_NO_OF_UNITS',36,22);
  add ('INV_ITEMS_ALL','IIT_OPTIONS',37,2);
  add ('INV_ITEMS_ALL','IIT_OPTIONS_TXT',38,20);
  add ('INV_ITEMS_ALL','IIT_OUN_ORG_ID_ELEC_BOARD',39,22);
  add ('INV_ITEMS_ALL','IIT_OWNER',40,4);
  add ('INV_ITEMS_ALL','IIT_OWNER_TXT',41,20);
  add ('INV_ITEMS_ALL','IIT_PEO_INVENT_BY_ID',42,22);
  add ('INV_ITEMS_ALL','IIT_PHOTO',43,6);
  add ('INV_ITEMS_ALL','IIT_POWER',44,22);
  add ('INV_ITEMS_ALL','IIT_PROV_FLAG',45,1);
  add ('INV_ITEMS_ALL','IIT_REV_BY',46,20);
  add ('INV_ITEMS_ALL','IIT_REV_DATE',47,7);
  add ('INV_ITEMS_ALL','IIT_TYPE',48,2);
  add ('INV_ITEMS_ALL','IIT_TYPE_TXT',49,20);
  add ('INV_ITEMS_ALL','IIT_WIDTH',50,22);
  add ('INV_ITEMS_ALL','IIT_XTRA_CHAR_1',51,20);
  add ('INV_ITEMS_ALL','IIT_XTRA_DATE_1',52,7);
  add ('INV_ITEMS_ALL','IIT_XTRA_DOMAIN_1',53,2);
  add ('INV_ITEMS_ALL','IIT_XTRA_DOMAIN_TXT_1',54,20);
  add ('INV_ITEMS_ALL','IIT_XTRA_NUMBER_1',55,22);
  add ('INV_ITEMS_ALL','IIT_X_SECT',56,4);
  add ('INV_ITEMS_ALL','IIT_PRIMARY_KEY',57,50);
  add ('INV_ITEMS_ALL','IIT_FOREIGN_KEY',58,50);
  add ('INV_ITEMS_ALL','IIT_DET_XSP',59,4);
  add ('INV_ITEMS_ALL','IIT_OFFSET',60,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB16',61,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB17',62,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB18',63,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB19',64,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB20',65,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB21',66,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB22',67,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB23',68,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB24',69,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB25',70,22);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB26',71,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB27',72,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB28',73,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB29',74,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB30',75,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB31',76,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB32',77,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB33',78,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB34',79,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB35',80,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB36',81,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB37',82,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB38',83,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB39',84,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB40',85,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB41',86,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB42',87,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB43',88,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB44',89,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB45',90,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB46',91,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB47',92,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB48',93,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB49',94,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB50',95,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB51',96,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB52',97,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB53',98,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB54',99,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB55',100,50);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB56',101,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB57',102,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB58',103,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB59',104,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB60',105,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB61',106,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB62',107,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB63',108,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB64',109,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB65',110,200);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB66',111,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB67',112,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB68',113,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB69',114,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB70',115,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB71',116,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB72',117,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB73',118,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB74',119,500);
  add ('INV_ITEMS_ALL','IIT_CHR_ATTRIB75',120,500);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB76',121,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB77',122,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB78',123,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB79',124,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB80',125,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB81',126,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB82',127,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB83',128,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB84',129,22);
  add ('INV_ITEMS_ALL','IIT_NUM_ATTRIB85',130,22);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB86',131,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB87',132,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB88',133,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB89',134,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB90',135,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB91',136,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB92',137,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB93',138,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB94',139,7);
  add ('INV_ITEMS_ALL','IIT_DATE_ATTRIB95',140,7);
  add ('INV_ITEM_HISTORY','IIH_CREATED_DATE',1,7);
  add ('INV_ITEM_HISTORY','IIH_ITEM_ID',2,22);
  add ('INV_ITEM_HISTORY','IIH_INV_CODE',3,2);
  add ('INV_ITEM_HISTORY','IIH_RSE_HE_ID',4,22);
  add ('INV_ITEM_HISTORY','IIH_ST_CHAIN',5,22);
  add ('INV_ITEM_HISTORY','IIH_END_CHAIN',6,22);
  add ('INV_ITEM_HISTORY','IIH_X_SECT',7,4);
  add ('INV_ITEM_HISTORY','IIH_NEW_ITEM_ID',8,22);
  add ('INV_ITEM_HISTORY','IIH_NEW_RSE_HE_ID',9,22);
  add ('INV_ITEM_HISTORY','IIH_LAST_UPDATED_DATE',10,7);
  add ('INV_ITEM_HISTORY','IIH_END_DATE',11,7);
  add ('INV_ITEM_HISTORY','IIH_OPERATION',12,1);
  add ('INV_ITEM_TYPES','ITY_DTP_FLAG',1,1);
  add ('INV_ITEM_TYPES','ITY_ELEC_DRAIN_CARR',2,1);
  add ('INV_ITEM_TYPES','ITY_INV_CODE',3,2);
  add ('INV_ITEM_TYPES','ITY_PNT_OR_CONT',4,1);
  add ('INV_ITEM_TYPES','ITY_SYS_FLAG',5,1);
  add ('INV_ITEM_TYPES','ITY_X_SECT_ALLOW_FLAG',6,1);
  add ('INV_ITEM_TYPES','ITY_CONTIGUOUS',7,1);
  add ('INV_ITEM_TYPES','ITY_DESCR',8,80);
  add ('INV_ITEM_TYPES','ITY_DUPLICATE',9,1);
  add ('INV_ITEM_TYPES','ITY_FEA_CODE',10,22);
  add ('INV_ITEM_TYPES','ITY_PARENT_ITY',11,2);
  add ('INV_ITEM_TYPES','ITY_MAX_ATTR_REQ',12,22);
  add ('INV_ITEM_TYPES','ITY_MIN_ATTR_REQ',13,22);
  add ('INV_ITEM_TYPES','ITY_ROAD_CHARACTERISTIC',14,1);
  add ('INV_ITEM_TYPES','ITY_SCREEN_SEQ',15,22);
  add ('INV_ITEM_TYPES','ITY_TOLERANCE',16,22);
  add ('INV_ITEM_TYPES','ITY_VIEW_NAME',17,32);
  add ('INV_ITEM_TYPES','ITY_START_DATE',18,7);
  add ('INV_ITEM_TYPES','ITY_END_DATE',19,7);
  add ('INV_ITEM_TYPES','ITY_CONTIG_JOINS_GAP',20,22);
  add ('INV_ITEM_TYPES','ITY_SURVEY',21,1);
  add ('INV_ITEM_TYPES','ITY_MULTI_ALLOWED',22,1);
  add ('INV_ITEM_TYPES','ITY_SHORT_DESCR',23,20);
  add ('INV_ITEM_TYPES','ITY_AREA_OR_LENGTH',24,1);
  add ('INV_ITEM_TYPES','ITY_CLOSE_EXISTING',25,1);
  add ('INV_ITEM_TYPES','ITY_INCL_ROAD_SEGS',26,1);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTATS',27,7);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT1',28,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT2',29,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT3',30,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT4',31,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT5',32,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT6',33,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT7',34,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT8',35,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT9',36,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBSTRT10',37,22);
  add ('INV_ITEM_TYPES','ITY_HHSTRLNGTH',38,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG1',39,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG2',40,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG3',41,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG4',42,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG5',43,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG6',44,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG7',45,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG8',46,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG9',47,22);
  add ('INV_ITEM_TYPES','ITY_HHSUBLNG10',48,22);
  add ('INV_ITEM_TYPES','ITY_HHPOS1',49,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS2',50,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS3',51,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS4',52,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS5',53,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS6',54,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS7',55,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS8',56,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS9',57,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS10',58,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS11',59,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS12',60,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS13',61,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS14',62,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS15',63,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS16',64,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS17',65,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS18',66,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS19',67,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS20',68,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS21',69,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS22',70,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS23',71,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS24',72,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS25',73,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS26',74,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS27',75,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS28',76,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS29',77,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS30',78,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS31',79,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS32',80,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS33',81,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS34',82,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS35',83,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS36',84,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS37',85,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS38',86,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS39',87,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS40',88,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS41',89,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS42',90,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS43',91,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS44',92,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS45',93,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS46',94,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS47',95,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS48',96,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS49',97,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS50',98,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS51',99,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS52',100,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS53',101,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS54',102,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS55',103,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS56',104,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS57',105,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS58',106,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS59',107,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS60',108,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS61',109,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS62',110,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS63',111,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS64',112,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS65',113,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS66',114,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS67',115,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS68',116,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS69',117,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS70',118,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS71',119,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS72',120,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS73',121,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS74',122,32);
  add ('INV_ITEM_TYPES','ITY_HHPOS75',123,32);
  add ('INV_TYPE_ATTRIBS','ITA_ATTRIB_NAME',1,30);
  add ('INV_TYPE_ATTRIBS','ITA_DEC_PLACES',2,22);
  add ('INV_TYPE_ATTRIBS','ITA_DYNAMIC_ATTRIB',3,1);
  add ('INV_TYPE_ATTRIBS','ITA_FLD_LENGTH',4,22);
  add ('INV_TYPE_ATTRIBS','ITA_FORMAT',5,10);
  add ('INV_TYPE_ATTRIBS','ITA_IIT_INV_CODE',6,2);
  add ('INV_TYPE_ATTRIBS','ITA_ITY_SYS_FLAG',7,1);
  add ('INV_TYPE_ATTRIBS','ITA_MANDITORY_YN',8,1);
  add ('INV_TYPE_ATTRIBS','ITA_SCRN_TEXT',9,30);
  add ('INV_TYPE_ATTRIBS','ITA_VALIDATE_YN',10,1);
  add ('INV_TYPE_ATTRIBS','ITA_DISP_SEQ_NO',11,22);
  add ('INV_TYPE_ATTRIBS','ITA_DTP_CODE',12,4);
  add ('INV_TYPE_ATTRIBS','ITA_MAX',13,22);
  add ('INV_TYPE_ATTRIBS','ITA_MIN',14,22);
  add ('INV_TYPE_ATTRIBS','ITA_VIEW_ATTRI',15,30);
  add ('INV_TYPE_ATTRIBS','ITA_VIEW_COL_NAME',16,30);
  add ('INV_TYPE_ATTRIBS','ITA_START_DATE',17,7);
  add ('INV_TYPE_ATTRIBS','ITA_END_DATE',18,7);
  add ('INV_TYPE_ATTRIBS','ITA_PRIMARY_KEY',19,0);
  add ('INV_TYPE_ATTRIBS','ITA_FOREIGN_KEY',20,0);
  add ('INV_TYPE_ATTRIBS','ITA_QUERYABLE',21,1);
  add ('INV_TYPE_ATTRIBS','ITA_UKPMS_PARAM_NO',22,22);
  add ('INV_TYPE_ATTRIBS','ITA_UNITS',23,22);
  add ('INV_TYPE_COLOURS','COL_ID',1,22);
  add ('INV_TYPE_COLOURS','ITY_INV_CODE',2,4);
  add ('ITY_CATEGORY_ROLES','ICR_CATEGORY',1,2);
  add ('ITY_CATEGORY_ROLES','ICR_ROLE',2,30);
  add ('ITY_CATEGORY_ROLES','ICR_MODE',3,10);
  add ('UNITS','UN_DOMAIN_ID',1,22);
  add ('UNITS','UN_UNIT_ID',2,22);
  add ('UNITS','UN_UNIT_NAME',3,20);
  add ('UNITS','UN_FORMAT_MASK',4,80);
  add ('UNIT_CONVERSIONS','UN_UNIT_ID_IN',1,22);
  add ('UNIT_CONVERSIONS','UN_UNIT_ID_OUT',2,22);
  add ('UNIT_CONVERSIONS','UN_FUNCTION',3,40);
  add ('UNIT_CONVERSIONS','UN_CONVERSION',4,2000);

  FOR i IN 1..l_tab_rec_cols.COUNT LOOP
    IF NOT column_ok(l_tab_rec_cols(i)) THEN
      dbms_output.put_line('Translation view '||l_tab_rec_cols(i).table_name||'.'||l_tab_rec_cols(i).column_name||' is incorrectly defined/missing - view requires a rebuild');
    END IF; 
  END LOOP;

  
  -- Check the existence of triggers on translation views
  
  chktrg ('INV_ITEMS_ALL','INV_ITEMS_D_TRG');
  chktrg ('INV_ITEMS_ALL','INV_ITEMS_I_TRG');
  chktrg ('INV_ITEMS_ALL','INV_ITEMS_U_TRG');

  FOR i IN 1..l_tab_rec_trgs.COUNT LOOP
    IF NOT trigger_ok(l_tab_rec_trgs(i)) THEN
      dbms_output.put_line('Translation view '||l_tab_rec_trgs(i).table_name||' does not have the trigger '||l_tab_rec_trgs(i).trigger_name||' defined.');
    END IF; 
  END LOOP;
  
  
END; 
/                              

