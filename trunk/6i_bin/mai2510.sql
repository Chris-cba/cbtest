rem
rem ---------------------------------------------------------------------------
rem
rem---------------------------------------------------------------------------
rem
rem   SCCS Identifiers :-
rem
rem       sccsid           : @(#)mai2510.sql	1.3 11/04/03
rem       Module Name      : mai2510.sql
rem       Date into SCCS   : 03/11/04 10:11:02
rem       Date fetched Out : 07/06/07 11:18:21
rem       SCCS Version     : 1.3
rem
rem
rem   Author : D. Cope
rem
rem   This script will call the package procedure to create an audit file extract.
rem
rem---------------------------------------------------------------------------
rem	Copyright (c) exor corporation ltd, 2003
rem---------------------------------------------------------------------------
rem
set serveroutput on
set ver off
set feed off

prompt

prompt Highways by Exor
exec higgrirp.write_gri_spool(&1,'Highways by Exor');
prompt ================
exec higgrirp.write_gri_spool(&1,'================');
prompt
exec higgrirp.write_gri_spool(&1,'');
prompt Audit file extract
exec higgrirp.write_gri_spool(&1,'Audit File extract');
prompt
exec higgrirp.write_gri_spool(&1,'');
prompt Working ....
exec higgrirp.write_gri_spool(&1,'Working ....');
prompt
exec higgrirp.write_gri_spool(&1,'');
declare
  l_dir  varchar2(200) DEFAULT higgrirp.get_parameter_value(&1, 'DIRECTORY');
  l_file varchar2(100) DEFAULT higgrirp.get_parameter_value(&1, 'FILENAME');
begin
  dbms_output.enable(1000000);
  hig_hd_extract.output_xml('MAI2510', l_dir, l_file, &1);

  update gri_report_runs 
  set grr_end_date = sysdate,
  grr_error_no = 0,
  grr_error_descr = 'Normal Successful Completion'
  where grr_job_id = &1
  and grr_mode != 'WEB';

  commit;
end;
/

exec higgrirp.write_gri_spool(&1,'Finished');

exit;
