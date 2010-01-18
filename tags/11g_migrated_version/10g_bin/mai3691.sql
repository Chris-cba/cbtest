--	Copyright (c) Exor Corporation Ltd, 1997 
--
--    APPLICATION     : MM                             
--    MODULE ID       : MAI3690.SQL                                    
--    NAME            : Print Budget Exceptions Report          
--    AUTHOR          : C.Hackforth	20/03/98
--                      Amended MAI3690 in migration to v2.1 of MM   
--    TABLES and                                                        
--    VIEWS USED      : v_budgets
--				report_params
--                                                                      
--	PURPOSE         : Produces Report based on parameters set in MAI3690.FMX
--                                                                      
--    CALLING MODULES : MAI3690.FMX                                           
--                                                                      
--    MODULES CALLED  : Set131                                           
--    COMMENTS        :                                                 
--                                                                      
--    MODIFICATIONS   :                                                 
--  -----------------------------------------------------------------------
-- 
--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai3691.sql	1.1 09/24/03
--       Module Name      : mai3691.sql
--       Date into SCCS   : 03/09/24 11:55:53
--       Date fetched Out : 07/06/07 11:18:23
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------

EXEC higgrirp.write_gri_spool(&&1,'Working ...');

SET FEEDBACK OFF;
SET VERIFY OFF;
SET TERM OFF;
SET HEADING OFF;

--SET FEEDBACK ON;
--SET VERIFY ON
--SET HEADING ON;
--SET TERM ON
set serveroutput on;

spool mai3690.txt

REM  set up calls to other modules.

col spool new_value spool noprint;
column set131 new_value set131 noprint;


START set131;

--REM Turn everything off again

SET FEEDBACK OFF;
SET HEADING OFF;
SET TERMOUT OFF;

SET PAGESIZE 44;

REM ------------------------------------------------------------------------
REM Read parameters from temporary table, populated by calling FORM
REM Note that arraysize is reduced to 1 because of the large
REM amount of data being retrieved.
REM
REM The parameters in this case are making up the actual select
REM statement ie rep_p1 holds the selected columns used in the
REM SELECT, GROUP BY and ORDER BY clauses, rep_p2 holds the
REM WHERE clause and rep_p3 holds the HAVING clause.
REM ------------------------------------------------------------------------

set arraysize 1
set verify off
set linesize 132
set pagesize 55
set num 12 
set head off
set feedback off

column p1 new_value p1 NOPRINT;
column p2 new_value p2 NOPRINT;
column p3 new_value p3 NOPRINT;
column p4 new_value p4 NOPRINT;
column p5 new_value p5 NOPRINT;
column p6 new_value p6 NOPRINT;
column p7 new_value p7 NOPRINT;
column p8 new_value p8 NOPRINT;
column p9 new_value p9 NOPRINT;

col title_1 new_value title_1 noprint;
col title_2 new_value title_2 noprint;
col tdate   new_value tdate   noprint;


COLUMN  v_sys_flag   FORMAT a5             HEADING 'DOT/|Local' 
COLUMN  v_agency     FORMAT a6             HEADING 'Agency' 
COLUMN  v_group      FORMAT a20            HEADING 'Road Group' 
COLUMN  v_job_code   FORMAT a4             HEADING 'Job|Code' 
COLUMN  v_item_code  FORMAT a6             HEADING 'Item|Code' 
COLUMN  v_fyr_id     FORMAT a5             HEADING 'Year'
COLUMN  budget       FORMAT 9999999990.99  HEADING 'Budget' 
COLUMN  commitment   FORMAT 9999999990.99  HEADING 'Committed'
COLUMN  actual       FORMAT 9999999990.99  HEADING 'Actual'
COLUMN  balance      FORMAT 9999999990.99  HEADING 'Balance' 
COLUMN  percent      FORMAT 999999990.99   HEADING 'Balance %' 

BREAK on report
COMPUTE sum LABEL TOTAL of budget on report
COMPUTE sum of commitment on report
COMPUTE sum of actual on report;
COMPUTE sum of balance on report;

select rep_p1 p1,
       rep_p2 p2,
       rep_p3 p3
from report_params
where rep_sessionid = &&1;


select hus_username||'   '||user||
       lpad(' ',(ceil((130 -  length(hau_name))/2) -
                             length(hus_username||'   '||user)))||
       hau_name title_1,
	 hmo_module||
       lpad(' ',(ceil((130 -  length(hmo_title))/2) -
                             length(hmo_module)))||
       hmo_title title_2,
       to_char(sysdate, 'DD-MON-YYYY') tdate
FROM   hig_admin_units,
       hig_users, hig_modules
WHERE
       hus_admin_unit = hau_admin_unit
       and hus_username = USER
       and hmo_module='MAI3690'
       and rownum  = 1;  



select higgrirp.get_module_spoolpath(&&1,user)||higgrirp.get_module_spoolfile(&&1) spool 
from dual;

spool &spool


set heading off

rem -------------------------------------------------
rem    This bit of coding displays the parameters
rem    entered on the screen.
rem -------------------------------------------------

BREAK ON REPORT SKIP PAGE;

ttitle skip left '&title_1' -
      right 'Page' sql.pno format 999 skip-
      left '&title_2' right &tdate skip-
      skip skip;



select 'Selection Criteria :    '||rep_p4,
       '                        '||rep_p5,
       '                        '||rep_p6,
       '                        '||rep_p7,
       '                        '||rep_p8,
       '                        '||rep_p9
from report_params
where rep_sessionid=&&1
/

rem
rem  re-issue title command to start now at page one 
rem

ttitle skip left '&title_1' -
      right 'Page' sql.pno format 999 skip-
      left '&title_2' right &tdate skip-
      skip skip;

delete from report_params
where rep_sessionid = &&1
/

set head on
select &p1 
       ,sum(v_budget) budget
       ,sum(v_committed) commitment
       ,sum(v_actual) actual
       ,sum(v_budget-v_committed-v_actual) balance
       ,trunc(decode(sum(v_budget),0,null,
        sum(v_budget-v_committed-v_actual)
        /sum(v_budget)*100),2) percent
from v_budgets 
       &p2
group by &p1
       &p3
order by &p1 
/

spool off

SET HEADING ON; 

REM
REM ---------------------------------------------------------------------------
REM Tidy up, and exit program


update gri_report_runs 
set grr_end_date = sysdate,
grr_error_no = 0,
grr_error_descr = 'Normal Successful Completion'
where grr_job_id = &&1; 



CLEAR BREAKS;
CLEAR COMPUTES;
BTITLE OFF;
TTITLE OFF;
SET PAGESIZE 14;
SET NEWPAGE 1;
EXEC higgrirp.write_gri_spool(&&1,'Completed successfully');
EXIT
