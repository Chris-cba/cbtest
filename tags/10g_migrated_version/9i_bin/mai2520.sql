rem
rem ---------------------------------------------------------------------------
rem
rem---------------------------------------------------------------------------
rem
rem   SCCS Identifiers :-
rem
rem       sccsid           : @(#)mai2520.sql	1.3 11/04/03
rem       Module Name      : mai2520.sql
rem       Date into SCCS   : 03/11/04 10:12:03
rem       Date fetched Out : 07/06/07 11:18:21
rem       SCCS Version     : 1.3
rem
rem
rem   Author : D. Cope
rem
rem   This script will call the package procedure to insert a rirf file.
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
prompt RIRF file import
exec higgrirp.write_gri_spool(&1,'RIRF file import');
prompt
exec higgrirp.write_gri_spool(&1,'');
prompt Working ....
exec higgrirp.write_gri_spool(&1,'Working ....');
prompt
exec higgrirp.write_gri_spool(&1,'');
-- remove all previous input first
  truncate table RIRF_ACTIVITIES drop storage;
  truncate table RIRF_ACTIVITY_INT drop storage;
  truncate table RIRF_DEF_TYPES drop storage;
  truncate table RIRF_SECT_FREQS drop storage;
  truncate table RIRF_XSP_VALUES drop storage;
--
declare
  l_doc  xmldom.domdocument;
  l_num  pls_integer;
  l_dir  varchar2(200) DEFAULT higgrirp.get_parameter_value(&1, 'DIRECTORY');
  l_file varchar2(100) DEFAULT higgrirp.get_parameter_value(&1, 'FILENAME');
  l_cmt  pls_integer   DEFAULT higgrirp.get_parameter_value(&1, 'COMMIT_PER_ROWS');
  l_user hig_users.hus_username%TYPE DEFAULT hig.get_application_owner;
begin
  dbms_output.enable(1000000);

  l_doc := hig_hd_insert.read_xml_file(l_dir, l_file);

  l_num := hig_hd_insert.insert_all_details('MAI2520', l_doc, l_user, l_cmt);

  dbms_output.put_line(l_num ||' rows inserted.');

  update gri_report_runs 
  set grr_end_date = sysdate,
  grr_error_no = 0,
  grr_error_descr = 'Normal Successful Completion, '||l_num ||' rows inserted.'
  where grr_job_id = &1
  and grr_mode != 'WEB';

  commit;

end;
/

exec higgrirp.write_gri_spool(&1,'Finished');

exit;

