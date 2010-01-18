-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai3859.sql	1.1 09/24/03
--       Module Name      : mai3859.sql
--       Date into SCCS   : 03/09/24 11:56:24
--       Date fetched Out : 07/06/07 11:18:28
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
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
prompt ================
prompt
prompt 
prompt Blackburn File Structure Interface Program
prompt
prompt Working ....
prompt
prompt
declare
  l_contractor_id	org_units.oun_contractor_id%type;
  l_seq_no		number;
  l_filepath	varchar2(250);
  l_filename	varchar2(250);
begin
  dbms_output.disable;
  Blackburn.main(&1);
  dbms_output.enable(300);
end;
/
prompt
pause Press Return to exit;
exit;
