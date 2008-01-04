-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai2320.sql	1.1 09/24/03
--       Module Name      : mai2320.sql
--       Date into SCCS   : 03/09/24 11:55:51
--       Date fetched Out : 07/06/07 11:18:20
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--
--    APPLICATION     : MM                             
--    MODULE ID       : MA2320.SQL                                    
--    NAME            : Inventory Map
--    AUTHOR          : C.Hackforth	19/11/99
--    TABLES and                                                        
--    VIEWS USED      : Local dynamicly created tables
--				plus road_segs, inv_items, xsp_restraints
--	PURPOSE	    :	see original comments below from orig v1.7 
-----------------------------------------------------------------------------
REM COMMENTS        : This report is a matrix report of inv_items against  *
REM                   XSP and chainage.                                    *
REM                   Complications:                                       *
REM                   - More than one inv item at a single matrix point.   *
REM                   - Inv_items with no XSP also required to be displayed.
REM                   - Start,end and point to be defined with 'v','^','.' *
REM                   - XSPs to be in a certain order across the report.   *
REM                   - Running total required down the XSP.               *
REM                                                                        *
REM                   The report will NOT handle more than 18 XSPs, as it  *
REM                   will not be able to fit them in across the report!   *
REM                   This report relies on the xsp_restraints table       *
REM                   holding the following data:                          *
REM                   select * from xsp_restraints                         *
REM                   where xsr_scl_class='08'                             *
REM                   and xsr_ity_sys_flag='D'                             *
REM                   order by xsr_seq                                     *
REM                   The xsr_seq column has been added to the table       *
REM                   specifically for ordering this report for the        *
REM                   Northern Ireland DOE requirement.                    *
REM                   There should be 18 records for the above criteria    *
REM                   and there should NOT be on for xsr_seq = 13, as      *
REM                   this report creates this record later on.            *
REM                                                                        *
REM                                                                        *
REM                   XS XS X XSR_DESCR            X    XSR_SEQ            * 
REM                   -- -- - -------------------- - ----------            *
REM                   $$ 08 1 Left Outer Verge     D          1            *
REM                   $$ 08 W Left Footway Back    D          2            *
REM                   $$ 08 2 Left Footway Front   D          3            *
REM                   $$ 08 3 Left Inside Verge    D          4            *
REM                   $$ 08 4 Lane 1               D          5            *
REM                   $$ 08 5 Lane 2               D          6            *
REM                   $$ 08 6 Lane 3               D          7            *
REM                   $$ 08 7 Lane 4               D          8            *
REM                   $$ 08 8 Right Inside Verge   D          9            *
REM                   $$ 08 9 Right Footway Front  D         10            *
REM                   $$ 08 O Right Footway Back   D         11            *
REM                   $$ 08 0 Right Outer Verge    D         12            *
REM                   $$ 08 E Left Turning Lane    D         14            *
REM                   $$ 08 R Right Turning Lane   D         15            *
REM                   $$ 08 T Bus Lane             D         16            *
REM                   $$ 08 Y Crawler              D         17            *
REM                   $$ 08 U Acceleration Lane    D         18            *
REM                   $$ 08 I Other                D         19            *
REM                                                                        *
REM                                                                        *
REM ------------------------------------------------------------------------
--    CALLING MODULES : GRI                                           
--                                                                      
--    MODULES CALLED  : None.                                           
--    COMMENTS        :                                                 
--                                                                      
--    MODIFICATIONS   :                                                 
--  -----------------------------------------------------------------------
-- 
-- 	GRI PARAMS      : ROAD_ID
--
--
--  SCCS ID Keyword, do no remove
define sccsid = '"@(#)mai2320.sql	1.1 09/24/03"'

SET DOCUMENT ON;
SET FEEDBACK OFF;
SET VERIFY OFF;
SET TERM OFF;
SET HEADING OFF;

--SET FEEDBACK ON;
--SET VERIFY ON
--SET HEADING ON;
SET TERM ON;
set serveroutput on;
begin
higgrirp.write_gri_spool(&&1,'Working...');
dbms_output.put_line('Working...');
end;
/
set serveroutput off;
set lines 132
SET TERM OFF;

DEFINE JOB_ID = &&1; 

COLUMN scl_class NEW_VALUE scl_class NOPRINT;
COLUMN sysflag NEW_VALUE sysflag NOPRINT;
COLUMN rseheid NEW_VALUE rseheid NOPRINT;
COLUMN p1  NEW_VALUE p1  NOPRINT;
COLUMN p2  NEW_VALUE p2  NOPRINT;
COLUMN hus_username NEW_VALUE hus_username NOPRINT;
COLUMN hau_name NEW_VALUE hau_name NOPRINT;
COLUMN hmo_title NEW_VALUE hmo_title NOPRINT;
COLUMN tdate NEW_VALUE tdate NOPRINT;


select to_char(sysdate,'DD-MON-YYYY') tdate
from dual;

select modules.hmo_title
from hig_users users, hig_modules modules
where upper(modules.hmo_module) = 'MAI2320'
and rownum=1;

SELECT hus_username,
       hau_name
FROM   hig_admin_units,
       hig_users
WHERE
       hus_admin_unit = hau_admin_unit
       and hus_username = user
/



col spool new_value spool noprint;

select higgrirp.get_module_spoolpath(&&1,user)||higgrirp.get_module_spoolfile(&&1) spool 
from dual;



select higgrirp.get_parameter_value(&&job_id,'ROAD_ID') rseheid from dual;

SELECT rse_unique||'  '||rse_descr p2,
       rse_scl_sect_class scl_class, rse_sys_flag sysflag
FROM   road_segs
WHERE  rse_he_id = &&rseheid
/


create table mai2320_invtemp&&JOB_ID
  (inv_seq          number(4),
   iit_st_chain     number(6),
   iit_x_sect       varchar2(1),
   iit_ity_inv_code varchar2(3),
   iit_end_chain    number(6),
   chain_type       varchar2(1),
   iit_width        varchar2(6))
/

create index mai2320_idx1&&JOB_ID on mai2320_invtemp&&JOB_ID (iit_st_chain)
/

create table mai2320_codetemp&&JOB_ID
  (inv_seq     number(4),
   st_chain    number(6),
   xsp         varchar2(1),
   inv_code    varchar2(3),
   end_chain   number(6),
   chain_type  varchar2(1),
   inv_count   number(2))
/

create index mai2320_idx2&&JOB_ID on mai2320_codetemp&&JOB_ID (st_chain)
/

create table mai2320_widthtemp&&JOB_ID
  (inv_seq     number(4),
   st_chain    number(6),
   xsp         varchar2(1),
   inv_code    varchar2(3),
   end_chain   number(6),
   chain_type  varchar2(1),
   width       varchar2(6))
/

create index mai2320_idx3&&JOB_ID on mai2320_widthtemp&&JOB_ID (st_chain)
/


create table mai2320_linetemp&&JOB_ID
  (max_inv     number(2),
   st_chain    number(6),
   inv_col     varchar2(244))
/

create index mai2320_idx4&&JOB_ID on mai2320_linetemp&&JOB_ID (st_chain)
/

create table mai2320_xsptemp&&JOB_ID as
select * from xsp_restraints
where xsr_ity_inv_code='$$'
and   xsr_scl_class='&&scl_class'
and   xsr_ity_sys_flag='&&sysflag'
/
commit;

REM
REM  Record added to XSPTEMP to allow processing for inv_items which
REM  do not have an iit_x_sect value eg 'CW'.
REM  This PL/SQL finds the lowest unused sequence no & uses that, to allow
REM  global implementation - the DoE setup should leave 13 unused for SCL
REM  Class 08/SysFlag D
REM 
declare
seqno number(2) := 1;
cursor get_next_xsp_seq is
   select xsr_seq
   from xsp_restraints
   where xsr_ity_inv_code = '$$'
   and   xsr_scl_class = '&&scl_class'
   and   xsr_ity_sys_flag = '&&sysflag'
   order by xsr_seq;
begin
for each_xsr_seq in get_next_xsp_seq
loop
   if seqno <> each_xsr_seq.xsr_seq then
      exit;
   end if;
   seqno := seqno + 1;
end loop;
-- Store the lowest available seqno found:
insert into mai2320_xsptemp&&JOB_ID (
xsr_ity_inv_code,
xsr_scl_class,
xsr_x_sect_value,
xsr_descr,
xsr_ity_sys_flag,
xsr_seq)
values (
'$$',
'&&scl_class',
'Z',
'MAI2320 report req',
'&&sysflag',
seqno);
end;
/


REM ---------------------------------------------------------------------------

REM
REM  Following code required to print out the XSPs across the top of 
REM  each page.
REM
Declare
    cline varchar2(244);
    cursor xsp_cur is
        select decode(xsr_x_sect_value,'Z','ALL',xsr_x_sect_value)xsr_x,
               decode(xsr_seq,5,4,9,4,13,4,3) colsize,
               xsr_seq 
        from   mai2320_xsptemp&&JOB_ID 
	    order by xsr_seq;
Begin
for each_xsp_rec in xsp_cur
  loop
    -- Precede 1st col of each XSP "group" with a space:
    cline := cline||lpad(each_xsp_rec.xsr_x||' ',each_xsp_rec.colsize,' ');
  end loop;
for each_xsp_rec in xsp_cur
  loop
  if each_xsp_rec.xsr_seq <=13 then
    cline := cline||lpad(each_xsp_rec.xsr_x,5,' ');
  end if;
  end loop;
insert into mai2320_linetemp&&JOB_ID values ('','',cline);
cline := '';
End;
/ 


REM
REM   Page headings ie titles for xsp etc. 
REM
column tline0 new_value tline0 NOPRINT;
column tline1 new_value tline1 NOPRINT;
column tline2 new_value tline2 NOPRINT;
column tline3 new_value tline3 NOPRINT;
set lines 132;
set head off; 



--select '       |<------------------ INVENTORY ITEMS ---------------------->|<------------------------- WIDTHS ------------------------>|' tline0
--from dual
--/
--select 'CHAING '||'|< L.VERGE >|<- LANES -->|< R.VERGE ->|<---- LAT/LOCS ----->|<---- L.VERGE ---->|<----- LANES ----->|<---- R.VERGE ---->|' tline2
--from dual
--select '------ -----------------------------------------------------------------------------------------------------------------------------' tline3
--from dual 
--/


select '       |<--------------- INVENTORY ITEMS ------------------>|<------------------------- WIDTHS ------------------------>|' tline0
from dual
/
select 'CHAING '||'|< L.VERGE >|<- LANES -->|< R.VERGE ->|<- LAT/LOCS ->|<---- L.VERGE ---->|<----- LANES ----->|<---- R.VERGE ---->|' tline2
from dual
/

select '------ -----------------------------------------------------------------------------------------------------------------' tline3
from dual 
/
select '       '||substr(inv_col,1,128) tline1
from mai2320_linetemp&&JOB_ID
where st_chain is null
/
spool &spool


REM set up report title 
BREAK ON REPORT SKIP PAGE;
TTITLE LEFT   '&&hus_username' -
       CENTER '&&hau_name' -
       RIGHT  '&&tdate' SKIP -
       LEFT   'MAI2320' -
       CENTER '&&hmo_title' -
       RIGHT  'Page          0' SKIP 7



SELECT 
rpad('Selection Criteria :',132),
rpad('--------------------',132),
rpad(' ',132),
rpad('Section            : '|| '&&p2',132)
FROM        dual 
WHERE       rownum < 2 
/

REM re-issue title command to start now at page one


TTITLE LEFT   '&&hus_username' -
       CENTER '&&hau_name' -
       RIGHT  '&&tdate' SKIP -
       LEFT   'MAI2320' -
       CENTER '&&hmo_title' -
       RIGHT  'Page ' sql.pno FORMAT 999 SKIP 3 -
       LEFT   '&&tline0'  SKIP 1 -
       LEFT   '&&tline2'  SKIP 1 -
       LEFT  '&&tline1'  SKIP 1 -
       LEFT   '&&tline3'  SKIP 2 
       


REM --------------------------------------------------------------------------
REM Perform SQL Query


SET HEADING ON; 

REM
REM  Starting body of the report
REM



declare
    cline          varchar2(244); -- Concatenated string to be printed out
    inv_seq        number(4); -- Sequence of inv item within XSP and chainage
    prev_inv_count number(2); -- Running total at XSP up to this point
    max_inv        number(2); -- Total on inv items at XSP and chainage
    dummy_count    number(2); -- To check if record has been concatenated
    dummy_count1   number(2); -- To check if record has been concatenated
    inv_code     varchar2(3); -- Inventory code concatenated with 'v','^' or '.'
    inv_count      number(2); -- Running total at XSP (downwards)
    insert_count   number(2); -- To check is records has been inserted
    x_sect         varchar2(2); -- To process inv items with no iit_x_sect value


    cursor temp_inv_cur is
        select iit_ity_inv_code,iit_st_chain,iit_x_sect,iit_end_chain,iit_width
        from inv_items
        where iit_rse_he_id = &&rseheid;


    cursor count_inv_cur (chain number) is
        select st_chain,xsp,count(inv_code) inv_tot 
        from   mai2320_codetemp&&JOB_ID 
        where  st_chain = chain
        group by st_chain,xsp
        order by 1,2;


    cursor temp3_cur (chain number,invseq number) is
        select st_chain,xsp,inv_seq,inv_code,end_chain,width,chain_type
        from mai2320_widthtemp&&JOB_ID
        where st_chain=chain
        and   inv_seq=invseq
        order by st_chain,inv_seq,xsp;


    cursor temp_cur (chain number,invseq number) is
         select st_chain,xsp,inv_seq,
         decode(inv_code,'0','-- ',inv_code) inv_code,end_chain,inv_count
         from mai2320_codetemp&&JOB_ID
         where st_chain=chain
         and   inv_seq=invseq
         order by st_chain,inv_seq,xsp;

    cursor inv_cur (chain number, xsp char) is
        select iit_ity_inv_code,iit_st_chain,iit_x_sect,iit_end_chain,iit_width
        from   mai2320_invtemp&&JOB_ID 
        where  iit_st_chain = chain
        and    iit_x_sect = xsp
        order by iit_st_chain,iit_x_sect;
    
    cursor end_inv_cur (chain number, xsp char) is
        select iit_ity_inv_code,iit_st_chain,iit_x_sect,iit_end_chain,iit_width
        from   mai2320_invtemp&&JOB_ID 
        where  iit_end_chain = chain
        and    iit_x_sect = xsp
        order by iit_end_chain,iit_x_sect;

    cursor chain_cur is
        select distinct iit_st_chain chain 
        from   mai2320_invtemp&&JOB_ID 
        union
        select distinct iit_end_chain chain 
        from   mai2320_invtemp&&JOB_ID; 

    cursor xsp2_cur is
        select xsr_x_sect_value, xsr_seq 
        from   mai2320_xsptemp&&JOB_ID 
        where  xsr_seq <= 13
        order by xsr_seq;

    cursor xsp_cur is
        select xsr_x_sect_value, xsr_seq,
        decode(xsr_seq,5,4,9,4,13,4,3) colsize
        from   mai2320_xsptemp&&JOB_ID 
        order by xsr_seq;


begin

--
--  This loop populates MAI2320_invtemp&&JOB_ID table,
--  processing the inv_items with no iit_x_sect value and setting
--  them up as 'Z'.
--
for each_inv_rec in temp_inv_cur
loop
   x_sect := '';
   if each_inv_rec.iit_x_sect is null then
      x_sect := 'Z';
   else
      x_sect := each_inv_rec.iit_x_sect;
   end if;
   insert into mai2320_invtemp&&JOB_ID values 
   ('',each_inv_rec.iit_st_chain,x_sect,each_inv_rec.iit_ity_inv_code,
    each_inv_rec.iit_end_chain,'',each_inv_rec.iit_width);
end loop;

--
--  This loop populates the tables MAI2320_codetemp&&JOB_ID and
--  MAI2320_widthtemp&&JOB_ID.
--  The inv_seq variable is the count of inv items at one particular
--  XSP and chainage eg XSP '1' and chainage '10' can have several
--  inv_items located there.
--  It also keeps a running count of items for the XSP (downwards).
--  This running total will only be displayed at the next unique
--  chainage, if an inv item code is not displayed.
--  The two loops for inv_cur and end_inv_cur are processing the inv
--  records from the start chainage and then the end chainage.
--
for each_xsp_rec in xsp_cur
loop
   inv_count := 0;
   prev_inv_count := 0;    
   for each_chain_rec in chain_cur
   loop
      inv_seq := 0;    
      insert_count := 0;
      for each_inv_rec in end_inv_cur (each_chain_rec.chain,each_xsp_rec.xsr_x_sect_value)
        loop
           if each_inv_rec.iit_end_chain = each_chain_rec.chain and
           each_inv_rec.iit_x_sect = each_xsp_rec.xsr_x_sect_value then
              insert_count := 99;
              if nvl(each_inv_rec.iit_end_chain,each_inv_rec.iit_st_chain) 
              > each_inv_rec.iit_st_chain then
                 inv_count := inv_count - 1;
                 inv_seq := inv_seq + 1; 
	             insert into mai2320_codetemp&&JOB_ID values 
                 (inv_seq,each_inv_rec.iit_end_chain,each_inv_rec.iit_x_sect,
                 each_inv_rec.iit_ity_inv_code||'^',each_inv_rec.iit_st_chain,
                 'E',inv_count);
                 if each_xsp_rec.xsr_seq <= 13 then
	                insert into mai2320_widthtemp&&JOB_ID values 
                    (inv_seq,each_inv_rec.iit_end_chain,each_inv_rec.iit_x_sect,
                    each_inv_rec.iit_ity_inv_code||'^',
                    each_inv_rec.iit_st_chain,
                    'E',each_inv_rec.iit_width);
                 end if;
              end if;
              prev_inv_count := inv_count;
           end if;
        end loop;
      for each_inv_rec in inv_cur (each_chain_rec.chain,each_xsp_rec.xsr_x_sect_value)
      loop
         if each_inv_rec.iit_st_chain = each_chain_rec.chain and
         each_inv_rec.iit_x_sect = each_xsp_rec.xsr_x_sect_value then
            insert_count := 99;
            inv_seq := inv_seq + 1; 
            if nvl(each_inv_rec.iit_end_chain,each_inv_rec.iit_st_chain) > 
            each_inv_rec.iit_st_chain then
               inv_count := inv_count + 1;
	           insert into mai2320_codetemp&&JOB_ID values 
               (inv_seq,each_chain_rec.chain,each_inv_rec.iit_x_sect,
               each_inv_rec.iit_ity_inv_code||'v',each_inv_rec.iit_end_chain,
               'S',inv_count);
               if each_xsp_rec.xsr_seq <= 13 then
	              insert into mai2320_widthtemp&&JOB_ID values 
                  (inv_seq,each_chain_rec.chain,each_inv_rec.iit_x_sect,
                  each_inv_rec.iit_ity_inv_code||'v',each_inv_rec.iit_end_chain,
                  'S',each_inv_rec.iit_width);
               end if;
            else
	           insert into mai2320_codetemp&&JOB_ID values 
               (inv_seq,each_chain_rec.chain,each_inv_rec.iit_x_sect,
               each_inv_rec.iit_ity_inv_code||'.',each_inv_rec.iit_end_chain,
               'S',0);
               if each_xsp_rec.xsr_seq <= 13 then
	              insert into mai2320_widthtemp&&JOB_ID values 
                  (inv_seq,each_chain_rec.chain,each_inv_rec.iit_x_sect,
                  each_inv_rec.iit_ity_inv_code||'.',each_inv_rec.iit_end_chain,
                  'S',each_inv_rec.iit_width);
               end if;
            end if;
            prev_inv_count := inv_count;
         end if;
      end loop;
    if insert_count != 99 then
       insert into mai2320_codetemp&&JOB_ID values 
       (1,each_chain_rec.chain,each_xsp_rec.xsr_x_sect_value,prev_inv_count,
       0,'X',inv_count);
    end if;
    end loop;
end loop;

--
--  This loop is getting the records from the temporary tables populated
--  above and concatenating them into a string, which is then inserted
--  into the temporary table MAI2320_linetemp&&JOB_ID.
--
for each_temp_chain_rec in chain_cur
loop
    max_inv := 0;
    dummy_count := 0;
    dummy_count1 := 0;
    for each_count_inv_rec in count_inv_cur(each_temp_chain_rec.chain)
    loop
      if each_count_inv_rec.inv_tot > max_inv then 
      max_inv := each_count_inv_rec.inv_tot;
      end if;
    end loop;
    for invseq in 1.. max_inv
    loop
        for each_xsp_rec in xsp_cur
        loop
           dummy_count := 0;
           for each_temp_rec in temp_cur(each_temp_chain_rec.chain,invseq)
           loop 
               if each_temp_rec.xsp = each_xsp_rec.xsr_x_sect_value then
                  cline := cline||lpad(each_temp_rec.inv_code,
                                       each_xsp_rec.colsize,' ');
                  dummy_count := 99; 
	           end if;
           end loop;
           if dummy_count != 99 then	
           cline := cline||lpad('-- ',each_xsp_rec.colsize,' ');
           end if;
        end loop;
        for each_xsp_rec in xsp2_cur
        loop
           dummy_count1 := 0;
           for each_temp3_rec in temp3_cur(each_temp_chain_rec.chain,invseq)
           loop 
               if each_temp3_rec.xsp = each_xsp_rec.xsr_x_sect_value
                and each_temp3_rec.width is not null
                and each_xsp_rec.xsr_seq <= 13 then
                    if each_temp3_rec.chain_type = 'S' then
                      cline := cline||lpad(each_temp3_rec.width,5,' ');
                      dummy_count1 := 99; 
                    else
                      cline := cline||'  end';
                      dummy_count1 := 99; 
                    end if;
	           end if;
           end loop;
           if dummy_count1 != 99 then	
           cline := cline||' ----';
           end if;
        end loop;
        insert into mai2320_linetemp&&JOB_ID values 
        (invseq,each_temp_chain_rec.chain,cline);
        cline := '';
    end loop;
end loop;


end;
/

REM
REM  Printing out the data from MAI2320_linetemp&&JOB_ID.
REM
set lines 132;
set head off;
select lpad(st_chain,6,' '), substr(inv_col,1,125) 
from mai2320_linetemp&&JOB_ID
where st_chain is not null
order by st_chain,max_inv
/
REM
REM

REM ---------------------------------------------------------------------------
REM Tidy up, and exit program

drop table mai2320_invtemp&&JOB_ID
/
drop table mai2320_codetemp&&JOB_ID
/
drop table mai2320_widthtemp&&JOB_ID
/
drop table mai2320_linetemp&&JOB_ID
/
drop table mai2320_xsptemp&&JOB_ID
/

commit;

SPOOL  OFF;
CLEAR  BREAKS;
BTITLE OFF;
TTITLE OFF;
SET    PAGESIZE 14;
SET    NEWPAGE 1;

EXEC higgrirp.write_gri_spool(&&1,'Completed successfully');

exit;

