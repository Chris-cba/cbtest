set serveroutput on size 200000
DECLARE

-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/check_mai_table_columns.sql-arc   2.2   Jun 28 2018 07:41:24   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   check_mai_table_columns.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 07:41:24  $
--       Date fetched Out : $Modtime:   Jun 28 2018 07:40:36  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.3
--
--
--   Author : Graeme Johnson
--
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

 TYPE rec_cols IS RECORD (table_name VARCHAR2(30)
                             ,column_name VARCHAR2(30)
							 ,column_id   NUMBER);
							 
 TYPE tab_rec_cols IS TABLE OF rec_cols INDEX BY BINARY_INTEGER;
 
 l_tab_rec_cols tab_rec_cols;
 
 PROCEDURE add(pi_table_name IN VARCHAR2
              ,pi_column_name IN VARCHAR2
			  ,pi_column_id   IN NUMBER) IS
			  
  l_subscript PLS_INTEGER := l_tab_rec_cols.COUNT+1;			  
			  
 BEGIN
 
  l_tab_rec_cols(l_subscript).table_name := pi_table_name;
  l_tab_rec_cols(l_subscript).column_name := pi_column_name;
  l_tab_rec_cols(l_subscript).column_id := pi_column_id;         
 
 END add;			  
 
 FUNCTION column_ok(pi_rec_cols rec_cols) RETURN BOOLEAN IS

  CURSOR c1 IS
  SELECT 'x'
  FROM   user_tab_cols
  WHERE  table_name = pi_rec_cols.table_name
  AND    column_name = pi_rec_cols.column_name
  AND    column_id = pi_rec_cols.column_id;
  
  l_dummy VARCHAR2(1) := Null;
 
 BEGIN

  OPEN c1;
  FETCH c1 INTO l_dummy;
  CLOSE c1;
  
  IF l_dummy IS NULL THEN
    RETURN(FALSE);
  ELSE
    RETURN(TRUE);
  END IF;
 
 END column_ok;
 
begin

add('ACTIVITIES', 'ATV_ACTY_AREA_CODE',    '1' ) ;
add('ACTIVITIES', 'ATV_DTP_FLAG',          '2' ) ;
add('ACTIVITIES', 'ATV_IF_SCHEDULED_FLAG', '3' ) ;
add('ACTIVITIES', 'ATV_MAINT_INSP_FLAG',   '4' ) ;
add('ACTIVITIES', 'ATV_SEQUENCE_NO',       '5' ) ;
add('ACTIVITIES', 'ATV_SPECIALIST_FLAG',   '6' ) ;
add('ACTIVITIES', 'ATV_CALC_TYPE',         '7' ) ;
add('ACTIVITIES', 'ATV_CAT1P_INT_CODE',    '8' ) ;
add('ACTIVITIES', 'ATV_CAT1T_INT_CODE',    '9' ) ;
add('ACTIVITIES', 'ATV_CAT2_1P_INT_CODE',  '10' ) ;
add('ACTIVITIES', 'ATV_CAT2_2P_INT_CODE',  '11' ) ;
add('ACTIVITIES', 'ATV_CAT2_3P_INT_CODE',  '12' ) ;
add('ACTIVITIES', 'ATV_DESCR',             '13' ) ;
add('ACTIVITIES', 'ATV_DTP_EXP_CODE',      '14' ) ;
add('ACTIVITIES', 'ATV_LA_EXP_CODE',       '15' ) ;
add('ACTIVITIES', 'ATV_MAINT_COST',        '16' ) ;
add('ACTIVITIES', 'ATV_SEASONAL_FLAG',     '17' ) ;
add('ACTIVITIES', 'ATV_UNIT',              '18' ) ;
add('ACTIVITIES', 'ATV_ACTIVITY_DURATION', '19' ) ;
add('ACTIVITIES', 'ATV_START_DATE',        '20' ) ;
add('ACTIVITIES', 'ATV_END_DATE',          '21' ) ;

add('ACTIVITIES_REPORT','ARE_REPORT_ID','1');
add('ACTIVITIES_REPORT','ARE_RSE_HE_ID','2');
add('ACTIVITIES_REPORT','ARE_BATCH_ID','3');
add('ACTIVITIES_REPORT','ARE_CREATED_DATE','4');
add('ACTIVITIES_REPORT','ARE_LAST_UPDATED_DATE','5');
add('ACTIVITIES_REPORT','ARE_MAINT_INSP_FLAG','6');
add('ACTIVITIES_REPORT','ARE_SCHED_ACT_FLAG','7');
add('ACTIVITIES_REPORT','ARE_DATE_WORK_DONE','8');
add('ACTIVITIES_REPORT','ARE_END_CHAIN','9');
add('ACTIVITIES_REPORT','ARE_INITIATION_TYPE','10');
add('ACTIVITIES_REPORT','ARE_INSP_LOAD_DATE','11');
add('ACTIVITIES_REPORT','ARE_PEO_PERSON_ID_ACTIONED','12');
add('ACTIVITIES_REPORT','ARE_PEO_PERSON_ID_INSP2','13');
add('ACTIVITIES_REPORT','ARE_ST_CHAIN','14');
add('ACTIVITIES_REPORT','ARE_SURFACE_CONDITION','15');
add('ACTIVITIES_REPORT','ARE_WEATHER_CONDITION','16');
add('ACTIVITIES_REPORT','ARE_WOL_WORKS_ORDER_NO','17');

add('DEFECTS','DEF_EASTING','47');
add('DEFECTS','DEF_NORTHING','48');
add('DEFECTS','DEF_RESPONSE_CATEGORY','49');
add('DEFECTS','DEF_DEFECT_ID','1');
add('DEFECTS','DEF_RSE_HE_ID','2');
add('DEFECTS','DEF_IIT_ITEM_ID','3');
add('DEFECTS','DEF_ST_CHAIN','4');
add('DEFECTS','DEF_ARE_REPORT_ID','5');
add('DEFECTS','DEF_ATV_ACTY_AREA_CODE','6');
add('DEFECTS','DEF_SISS_ID','7');
add('DEFECTS','DEF_WORKS_ORDER_NO','8');
add('DEFECTS','DEF_CREATED_DATE','9');
add('DEFECTS','DEF_DEFECT_CODE','10');
add('DEFECTS','DEF_LAST_UPDATED_DATE','11');
add('DEFECTS','DEF_ORIG_PRIORITY','12');
add('DEFECTS','DEF_PRIORITY','13');
add('DEFECTS','DEF_STATUS_CODE','14');
add('DEFECTS','DEF_SUPERSEDED_FLAG','15');
add('DEFECTS','DEF_AREA','16');
add('DEFECTS','DEF_ARE_ID_NOT_FOUND','17');
add('DEFECTS','DEF_COORD_FLAG','18');
add('DEFECTS','DEF_DATE_COMPL','19');
add('DEFECTS','DEF_DATE_NOT_FOUND','20');
add('DEFECTS','DEF_DEFECT_CLASS','21');
add('DEFECTS','DEF_DEFECT_DESCR','22');
add('DEFECTS','DEF_DEFECT_TYPE_DESCR','23');
add('DEFECTS','DEF_DIAGRAM_NO','24');
add('DEFECTS','DEF_HEIGHT','25');
add('DEFECTS','DEF_IDENT_CODE','26');
add('DEFECTS','DEF_ITY_INV_CODE','27');
add('DEFECTS','DEF_ITY_SYS_FLAG','28');
add('DEFECTS','DEF_LENGTH','29');
add('DEFECTS','DEF_LOCN_DESCR','30');
add('DEFECTS','DEF_MAINT_WO','31');
add('DEFECTS','DEF_MAND_ADV','32');
add('DEFECTS','DEF_NOTIFY_ORG_ID','33');
add('DEFECTS','DEF_NUMBER','34');
add('DEFECTS','DEF_PER_CENT','35');
add('DEFECTS','DEF_PER_CENT_ORIG','36');
add('DEFECTS','DEF_PER_CENT_REM','37');
add('DEFECTS','DEF_RECHAR_ORG_ID','38');
add('DEFECTS','DEF_SERIAL_NO','39');
add('DEFECTS','DEF_SKID_COEFF','40');
add('DEFECTS','DEF_SPECIAL_INSTR','41');
add('DEFECTS','DEF_SUPERSEDED_ID','42');
add('DEFECTS','DEF_TIME_HRS','43');
add('DEFECTS','DEF_TIME_MINS','44');
add('DEFECTS','DEF_UPDATE_INV','45');
add('DEFECTS','DEF_X_SECT','46');

add('INV_TYPE_TRANSLATIONS', 'ITY_DTP_FLAG',              '1' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_ELEC_DRAIN_CARR',       '2' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_INV_CODE',              '3' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_PNT_OR_CONT',           '4' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_SYS_FLAG',              '5' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_X_SECT_ALLOW_FLAG',     '6' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_CONTIGUOUS',            '7' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_DESCR',                 '8' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_DUPLICATE',             '9' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_FEA_CODE',              '10' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_PARENT_ITY',            '11' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS1',                '12' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS10',               '13' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS11',               '14' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS12',               '15' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS13',               '16' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS14',               '17' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS15',               '18' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS2',                '19' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS3',                '20' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS4',                '21' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS5',                '22' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS6',                '23' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS7',                '24' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS8',                '25' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS9',                '26' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSTRLNGTH',            '27' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG1',             '28' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG10',            '29' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG2',             '30' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG3',             '31' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG4',             '32' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG5',             '33' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG6',             '34' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG7',             '35' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG8',             '36' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBLNG9',             '37' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTATS',            '38' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT1',            '39' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT10',           '40' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT2',            '41' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT3',            '42' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT4',            '43' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT5',            '44' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT6',            '45' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT7',            '46' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT8',            '47' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHSUBSTRT9',            '48' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_MAX_ATTR_REQ',          '49' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_MIN_ATTR_REQ',          '50' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_ROAD_CHARACTERISTIC',   '51' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_SCREEN_SEQ',            '52' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_TOLERANCE',             '53' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_VIEW_NAME',             '54' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_START_DATE',            '55' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_END_DATE',              '56' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_CONTIG_JOINS_GAP',      '57' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS16',               '58' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_SURVEY',                '59' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_MULTI_ALLOWED',         '60' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_SHORT_DESCR',           '61' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_AREA_OR_LENGTH',        '62' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS17',               '63' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS18',               '64' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS19',               '65' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS20',               '66' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS21',               '67' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS22',               '68' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS23',               '69' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS24',               '70' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS25',               '71' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS26',               '72' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS27',               '73' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS28',               '74' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS29',               '75' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS30',               '76' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS31',               '77' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS32',               '78' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS33',               '79' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS34',               '80' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS35',               '81' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS36',               '82' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS37',               '83' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS38',               '84' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS39',               '85' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS40',               '86' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS41',               '87' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS42',               '88' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS43',               '89' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS44',               '90' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS45',               '91' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS46',               '92' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS47',               '93' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS48',               '94' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS49',               '95' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS50',               '96' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS51',               '97' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS52',               '98' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS53',               '99' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS54',               '100' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS55',               '101' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS56',               '102' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS57',               '103' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS58',               '104' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS59',               '105' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS60',               '106' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS61',               '107' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS62',               '108' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS63',               '109' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS64',               '110' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS65',               '111' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS66',               '112' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS67',               '113' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS68',               '114' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS69',               '115' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS70',               '116' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS71',               '117' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS72',               '118' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS73',               '119' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS74',               '120' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_HHPOS75',               '121' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_CLOSE_EXISTING',        '122' ) ;
add('INV_TYPE_TRANSLATIONS', 'ITY_INCL_ROAD_SEGS',        '123' ) ;
add('INV_TYPE_TRANSLATIONS', 'NIT_INV_TYPE',              '124' ) ;

add('REPAIRS','REP_DEF_DEFECT_ID','1');
add('REPAIRS','REP_ACTION_CAT','2');
add('REPAIRS','REP_RSE_HE_ID','3');
add('REPAIRS','REP_TRE_TREAT_CODE','4');
add('REPAIRS','REP_ATV_ACTY_AREA_CODE','5');
add('REPAIRS','REP_CREATED_DATE','6');
add('REPAIRS','REP_DATE_DUE','7');
add('REPAIRS','REP_LAST_UPDATED_DATE','8');
add('REPAIRS','REP_SUPERSEDED_FLAG','9');
add('REPAIRS','REP_COMPLETED_HRS','10');
add('REPAIRS','REP_COMPLETED_MINS','11');
add('REPAIRS','REP_DATE_COMPLETED','12');
add('REPAIRS','REP_DESCR','13');
add('REPAIRS','REP_LOCAL_DATE_DUE','14');
add('REPAIRS','REP_OLD_DUE_DATE','15');


 FOR i IN 1..l_tab_rec_cols.COUNT LOOP
  IF NOT column_ok(l_tab_rec_cols(i)) THEN
    dbms_output.put_line(l_tab_rec_cols(i).table_name||'.'||l_tab_rec_cols(i).column_name||' is incorrectly defined - table requires a rebuild - contact exor');
  END IF; 
 END LOOP;

end; 
/ 							 


