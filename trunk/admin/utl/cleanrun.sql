--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/utl/cleanrun.sql-arc   2.2   Jun 28 2018 04:42:12   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   cleanrun.sql  $
--       Date into SCCS   : $Date:   Jun 28 2018 04:42:12  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:41:24  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
undefine run_number
col run_number new_value run_number noprint
prompt
prompt Please enter the run number of the inventory load run you want to delete
prompt But please do not pick run number zero as we need that for the loaders to work!
prompt
accept run_number prompt "Enter run number : "

prompt Working ....

set term off 
set feed off
set verify off
set head off
spool a.sql
select 'prompt INFO: Run number zero should not be deleted.  Press return to exit.' a
      , null
from   dual
where  &&run_number = 0
union
select 'pause;'                          a
,	null
from   dual
where  &&run_number = 0
union
select 'exit;'                          a
,	null
from   dual
where  &&run_number = 0
union
select 'prompt' a
       ,'prompt INFO: Removing inventory load run now'
from   dual
where  &&run_number <> 0
order by 1 desc;
spool off
set term on
set feed on
set verify on
set head on
@a.sql

delete from hhinv_run_log where run_num = &run_number;
delete from hhinv_hold_1 hh1
       where exists (select 'x'
                     from hhinv_sect_log  hhsl
                     where hh1.rec_seq_no between hhsl.rec_seq_no and hhsl.max_seq_no
                     and hhsl.lst_run_num = &run_number);
delete from hhinv_load_1 hhl1
       where exists (select 'x'
                     from hhinv_sect_log  hhsl
                     where hhl1.rec_seq_no between hhsl.rec_seq_no and hhsl.max_seq_no
                     and hhsl.lst_run_num = &run_number);
delete from hhinv_load_2 hhl2
       where exists (select 'x'
                     from hhinv_sect_log  hhsl
                     where hhl2.rec_seq_no between hhsl.rec_seq_no and hhsl.max_seq_no
                     and hhsl.lst_run_num = &run_number);
delete from hhinv_load_3 hhl3
       where exists (select 'x'
                     from hhinv_sect_log  hhsl
                     where hhl3.rec_seq_no between hhsl.rec_seq_no and hhsl.max_seq_no
                     and hhsl.lst_run_num = &run_number);
delete from hhinv_item_err_1 hhi1 where hhi1.hway_seq_no in
                    (select hhsl.rec_seq_no
                     from   hhinv_sect_log hhsl
                     where  hhsl.lst_run_num = &run_number );
delete from hhinv_item_err_2 hhi2 where hhi2.sect_hdr_seq_no in
                    (select hhsl.rec_seq_no
                     from   hhinv_sect_log hhsl
                     where  hhsl.lst_run_num = &run_number);
delete from hhinv_item_err_3 hhi3 where hhi3.rec_seq_no in
                    (select hhsl.rec_seq_no
                     from   hhinv_sect_log hhsl
                     where  hhsl.lst_run_num = &run_number);
delete from hhinv_sect_log where lst_run_num = &run_number;

prompt
prompt *******************************************************
prompt If you are happy you entered the right run number
prompt type COMMIT; to make the changes permanent
prompt otherwise type ROLLBACK; to undo.  Do NOT just exit out
prompt of SQLPlus as this may automatically COMMIT!
prompt *******************************************************
prompt

