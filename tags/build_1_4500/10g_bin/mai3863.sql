-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai3863.sql	1.1 09/24/03
--       Module Name      : mai3863.sql
--       Date into SCCS   : 03/09/24 11:56:27
--       Date fetched Out : 07/06/07 11:18:29
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
rem
rem  Date   : March 1999
rem  Author : H.Buckley
rem  Descr  : This program will enable the user to create specified output
rem           file formats from the standard exor interface extraction
rem           programs.
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
prompt Mai3863: Download Assets by Inspection
exec higgrirp.write_gri_spool(&1,'Mai3863: Download Assets by Inspection');
prompt
exec higgrirp.write_gri_spool(&1,'');
prompt Working ....
exec higgrirp.write_gri_spool(&1,'Working ....');
prompt
exec higgrirp.write_gri_spool(&1,'');
declare
  l_contractor_id	org_units.oun_contractor_id%type;
  l_seq_no		number;
  l_filepath	varchar2(250);
  l_filename	varchar2(250);
begin
  dbms_output.enable(1000000);
  Pedif.main(&1);
end;
/

set define on
set term off
set head off

spool run_file.sql
select 'Prompt Press Return to exit '||chr(10)||' pause'
from gri_report_runs
where grr_job_id = '&1'
and grr_mode != 'WEB'
/

exec higgrirp.write_gri_spool(&1,'Finished');

set term on
set define off
spool off
start run_file

exit;

