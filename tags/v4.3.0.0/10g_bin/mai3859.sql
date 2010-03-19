-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/10g_bin/mai3859.sql-arc   4.1   Mar 19 2010 09:18:38   lsorathia  $
--       Module Name      : $Workfile:   mai3859.sql  $
--       Date into PVCS   : $Date:   Mar 19 2010 09:18:38  $
--       Date fetched Out : $Modtime:   Mar 19 2010 09:03:32  $
--       PVCS Version     : $Revision:   4.1  $
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
exec HIGGRIRP.write_gri_spool('&1','Blackburn File Structure Interface Program');
prompt Blackburn File Structure Interface Program
exec HIGGRIRP.write_gri_spool('&1','');
prompt
exec HIGGRIRP.write_gri_spool('&1','Working ....');
prompt Working ....
exec HIGGRIRP.write_gri_spool('&1','');
prompt
declare
  l_contractor_id	org_units.oun_contractor_id%type;
  l_seq_no		number;
  l_filepath	varchar2(250);
  l_filename	varchar2(250);
begin
  dbms_output.disable;
  Blackburn.main(&1);
  HIGGRIRP.write_gri_spool(&1,'Info: File  Created');
  dbms_output.put_line('Info: File Created');
  dbms_output.enable(300);
end;
/
exec HIGGRIRP.write_gri_spool('&1','Successfully Completed');

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