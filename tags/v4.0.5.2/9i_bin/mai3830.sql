-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/9i_bin/mai3830.sql-arc   3.1   Apr 16 2008 15:50:06   smarshall  $
--       Module Name      : $Workfile:   mai3830.sql  $
--       Date into PVCS   : $Date:   Apr 16 2008 15:50:06  $
--       Date fetched Out : $Modtime:   Apr 16 2008 15:49:46  $
--       PVCS Version     : $Revision:   3.1  $
--       Based on SCCS Version     : 1.1
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
prompt
exec HIGGRIRP.write_gri_spool('&1','Interface Program - Work Order Extract');
prompt Interface Program - Work Order Extract
exec HIGGRIRP.write_gri_spool('&1','');
prompt
exec HIGGRIRP.write_gri_spool('&1','Working ....');
prompt Working ....
exec HIGGRIRP.write_gri_spool('&1','');
prompt
declare
  l_contractor_id	org_units.oun_contractor_id%type;
  l_filename	varchar2(250);
begin

  dbms_output.disable;

  l_filename := interfaces.write_wor_file( &1);

  dbms_output.enable(300);
  if l_filename is not null then
    HIGGRIRP.write_gri_spool(&1,'Info: File '||l_filename||' created');
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

