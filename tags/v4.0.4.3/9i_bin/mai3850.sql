-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai3850.sql	1.1 09/24/03
--       Module Name      : mai3850.sql
--       Date into SCCS   : 03/09/24 11:56:08
--       Date fetched Out : 07/06/07 11:18:26
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------

exec higgrirp.write_gri_spool(&1,'Highways by Exor');
exec higgrirp.write_gri_spool(&1,'================');
exec higgrirp.write_gri_spool(&1,'');
exec higgrirp.write_gri_spool(&1,'Working ....');

set ver off
set feed off
col spool new_value spool noprint;

select higgrirp.get_module_spoolpath(&1,user)||higgrirp.get_module_spoolfile(&1) spool 
from dual;

spool &spool

prompt

prompt Highways by Exor
prompt ================
prompt
prompt 
prompt Interface Program - Completions
prompt
prompt Working ....
prompt
declare
  l_contractor_id	org_units.oun_contractor_id%type;
  l_seq_no		number;
  l_filepath	varchar2(255);
  l_filename      varchar2(12); -- This restriction is in the interfaces package. (May need changing at a future date)
  l_error		varchar2(255);
begin

  dbms_output.disable;
  l_contractor_id := higgrirp.get_parameter_value(&1, 'CONTRACTOR_CODE');
  l_seq_no        := higgrirp.get_parameter_value(&1, 'A_NUMBER');
  l_filepath      := higgrirp.get_parameter_value(&1, 'TEXT');
  l_filename      := higgrirp.get_parameter_value(&1, 'FILENAME');
  
  interfaces.completion_file_ph1(&1
                          ,l_contractor_id
			        ,l_seq_no
			        ,l_filepath
                          ,l_filename
				  ,l_error);

  dbms_output.enable;
  if l_error is null then
    higgrirp.write_gri_spool(&1,'Info: Completion file processed.');
    dbms_output.put_line('Info: Completion file processed.');
  else
    higgrirp.write_gri_spool(&1,'Error: '||l_error);
    dbms_output.put_line('Error: '||l_error);
  end if;

end;
/
set define on
set term off
set head off

spool off

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
