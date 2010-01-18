-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai3834.sql	1.1 09/24/03
--       Module Name      : mai3834.sql
--       Date into SCCS   : 03/09/24 11:56:03
--       Date fetched Out : 07/06/07 11:18:25
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------

set serveroutput on
set ver off
set feed off
prompt

exec HIGGRIRP.write_gri_spool('&1','Highways by Exor');
prompt Highways by Exor
exec HIGGRIRP.write_gri_spool('&1','================');
prompt ================
prompt
exec HIGGRIRP.write_gri_spool('&1','');
prompt 
exec HIGGRIRP.write_gri_spool('&1','Interface Program - Financial Commitment');
prompt Interface Program - Financial Commitment
prompt
exec HIGGRIRP.write_gri_spool('&1','Working ....');
prompt Working ....
exec HIGGRIRP.write_gri_spool('&1','');
prompt
declare
  l_seq_no		number;
  l_filepath	varchar2(250);
  l_filename	varchar2(250);
begin

  dbms_output.disable;

  l_filename := interfaces.financial_commitment_file(&1);

  dbms_output.enable(300);
  if l_filename is not null then
    dbms_output.put_line('Info: File '||l_filename||' created');
  end if;

end;
/

exec HIGGRIRP.write_gri_spool('&1','Successfully completed');

set define on
set term off
set head off

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

