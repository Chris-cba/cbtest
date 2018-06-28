REM SCCS ID Keyword, do no remove
REM Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.

define sccsid = '$Revision:   2.2  $';
delete from hhinv_run_log;
insert into hhinv_run_log (fst_run_date,
                           lst_run_date,
                           no_of_runs,
                           run_num,
                           run_stage,
                           run_stat)
values (to_date('01011901','DDMMYYYY'),
        to_date('01011901','DDMMYYYY'),
        0,
        0,
        10,
        10);
delete from hhinv_hold_1;
delete from hhinv_item_err_1;
delete from hhinv_item_err_2;
delete from hhinv_item_err_3;
delete from hhinv_load_1;
delete from hhinv_load_2;
delete from hhinv_load_3;
delete from hhinv_odl_log;
delete from hhinv_sect_log;
