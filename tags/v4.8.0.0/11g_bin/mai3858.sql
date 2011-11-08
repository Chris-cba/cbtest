-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai3858.sql	1.1 09/24/03
--       Module Name      : mai3858.sql
--       Date into SCCS   : 03/09/24 11:56:21
--       Date fetched Out : 07/06/07 11:18:28
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------

set serveroutput on
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
prompt Interface Program - Payment Transaction
prompt
prompt Working ....
prompt
prompt

declare
  l_seq_no	 number;
  l_filepath varchar2(255);
  l_error	 varchar2(255);
  l_filename varchar2(12);

begin

  dbms_output.disable;
  l_seq_no   := higgrirp.get_parameter_value(&1, 'A_NUMBER');
  l_filepath := higgrirp.get_parameter_value(&1, 'TEXT');
  l_filename := higgrirp.get_parameter_value(&1, 'FILENAME');

  interfaces.payment_transaction_file(&1,l_seq_no, l_filepath,l_filename, l_error);

  dbms_output.enable;
  if l_error is null then
    dbms_output.put_line('Info: Payment file processed.');
  else
    dbms_output.put_line(l_error);
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

set term on
set define off
spool off
start run_file

exit;
