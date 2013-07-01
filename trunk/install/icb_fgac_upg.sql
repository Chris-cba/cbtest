-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/icb_fgac_upg.sql-arc   2.1   Jul 01 2013 16:00:24   James.Wadsworth  $
--       Module Name      : $Workfile:   icb_fgac_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:00:24  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       based on SCCS Version     : 1.1
-----------------------------------------------------------------------------
--   Originally taken from '@(#)icb_fgac_upg.sql	1.3 06/20/03';
-----------------------------------------------------------------------------

set define on
set feedback off
undefine run_file
set verify off head off term on
col run_file new_value run_file noprint
---
--- Add new Agency Column to table Item_Code_Breakdowns
---
alter table item_code_breakdowns add icb_agency_code VARCHAR2(4) null;

drop index icb_index_p1;
drop index icb_index_p2;
drop index icb_index_p3;

CREATE UNIQUE INDEX ICB_INDEX_P1 ON ITEM_CODE_BREAKDOWNS
(ICB_AGENCY_CODE,ICB_ID);

CREATE UNIQUE INDEX ICB_INDEX_P2 ON ITEM_CODE_BREAKDOWNS
(ICB_AGENCY_CODE,ICB_DTP_FLAG, ICB_ITEM_CODE, ICB_SUB_ITEM_CODE, ICB_SUB_SUB_ITEM_CODE);

CREATE UNIQUE INDEX ICB_INDEX_P3 ON ITEM_CODE_BREAKDOWNS
(ICB_AGENCY_CODE,ICB_WORK_CATEGORY_NAME);
--
-- Populate Default Agency Code Here
--
update item_code_breakdowns
set icb_agency_code = (select hau_authority_code from hig_admin_units where hau_admin_unit = 1);
--
-- Now create new mai.pck and new trigger on work_orders
--
--
-- Now Make ICB_AGENCY_CODE A Mandatory Column
--
alter table item_code_breakdowns modify icb_agency_code varchar2(4) not null;
--
-- Product option to enable FGAC
--
INSERT INTO HIG_OPTIONS ( HOP_ID, HOP_PRODUCT, HOP_NAME, HOP_VALUE,
HOP_REMARKS ) VALUES (
'ICBFGAC', 'MAI', 'Item code Breakdowns FGAC', 'N', 'Y= Item Code Breakdowns to be unique at agency level , N = Item Code Breakdowns to be unique at system level.');
COMMIT;

--
-- * NEW *
-- User option to choose how WO Header id is generated
--
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
,'WORREFGEN'
,'Work Order Ref No Generation'
,'Y'
,1
,NULL
,NULL
from dual
where not exists (
 select 'not exists'
 from HIG_CODES
where HCO_DOMAIN = 'USER_OPTIONS'
 and HCO_CODE = 'WORREFGEN'
);

COMMIT;

--
-- Add policy if Enterprise Version of Oracle
--
set head off
set feedback off
set term off
set linesize 200
Spool icb_fgac_temp.sql
--
-- Now add policy to ITEM_CODE_BREAKDOWNS but only for Enterprise version of Oracle
--
select 'grant create any context to '||user||';' from dual;
--
select 'create context Item_Code_Breakdown_'||user||' using mai;'
from dual;
--
select 'begin '||chr(10)||
          'dbms_rls.add_policy('''||user||''','||
                               '''ITEM_CODE_BREAKDOWNS'','||
                               '''AGENCY'','''||
                               user||''','||
                               '''mai.ICB_FGAC_PREDICATE'','||
                               '''SELECT,UPDATE,DELETE'','||
                               'TRUE'||');'||
        'end;'||chr(10)||
        '/'
from dual
where INSTR('&&_O_VERSION','Enterprise') != 0;
--
-- Budgets
--
select 'begin '||chr(10)||
          'dbms_rls.add_policy('''||user||''','||
                               '''BUDGETS'','||
                               '''AGENCY'','''||
                               user||''','||
                               '''mai.ICB_BUDGET_FGAC_PREDICATE'','||
                               '''SELECT,UPDATE,DELETE'','||
                               'TRUE'||');'||
        'end;'||chr(10)||
        '/'
from dual
where INSTR('&&_O_VERSION','Enterprise') != 0;

select 'begin '||chr(10)||
          'dbms_rls.add_policy('''||user||''','||
                               '''WORK_ORDERS'','||
                               '''AGENCY'','''||
                               user||''','||
                               '''mai.ICB_WO_FGAC_PREDICATE'','||
                               '''SELECT,UPDATE,DELETE'','||
                               'TRUE'||');'||
        'end;'||chr(10)||
        '/'
from dual
where INSTR('&&_O_VERSION','Enterprise') != 0;
spool off

@icb_fgac_temp.sql
set head on
set feedback on
set term on
set linesize 80

--
-- Insert new error messages for Item Code and Sub Item Code validation
--
INSERT INTO HIG_ERRORS ( HER_APPL,
                         HER_NO,
                         HER_TYPE,
                         HER_DESCR,
                         HER_ACTION_1,
                         HER_ACTION_2,
                         HER_ACTION_3,
                         HER_ACTION_4,
                         HER_ACTION_5,
                         HER_ACTION_6,
                         HER_ACTION_7 )
                VALUES ( 'M_MGR',
                         896,
                         'E',
                         'Item Code seletced must be defined at top Admin unit',
                         'Select Item Code from LOV or define at top admin unit',
                         NULL,
                         NULL,
                         NULL,
                         NULL,
                         NULL,
                         NULL);

INSERT INTO HIG_ERRORS ( HER_APPL,
                         HER_NO,
                         HER_TYPE,
                         HER_DESCR,
                         HER_ACTION_1,
                         HER_ACTION_2,
                         HER_ACTION_3,
                         HER_ACTION_4,
                         HER_ACTION_5,
                         HER_ACTION_6,
                         HER_ACTION_7 )
                VALUES ( 'M_MGR',
                         897,
                         'E',
                         'Sub Item Code seletced must be defined at top Admin unit',
                         'Select Item Code from LOV or define at top admin unit', NULL,
                          NULL,
                          NULL,
                          NULL,
                          NULL,
                          NULL);

INSERT INTO HIG_ERRORS ( HER_APPL
                        ,HER_NO
                        ,HER_TYPE
                        ,HER_DESCR
                        ,HER_ACTION_1
                        ,HER_ACTION_2
                        ,HER_ACTION_3
                        ,HER_ACTION_4
                        ,HER_ACTION_5
                        ,HER_ACTION_6
                        ,HER_ACTION_7)
               values ( 'M_MGR'
                        ,898
                        ,'E'
                        ,'The Agency you have entered is invalid according to your Admin Unit'
                        ,''
                        ,''
                        ,''
                        ,''
                        ,''
                        ,''
                        ,'')
;
commit;



