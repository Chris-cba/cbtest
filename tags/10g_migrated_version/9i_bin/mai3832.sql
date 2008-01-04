-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai3832.sql	1.1 09/24/03
--       Module Name      : mai3832.sql
--       Date into SCCS   : 03/09/24 11:56:01
--       Date fetched Out : 07/06/07 11:18:25
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------

set serveroutput on
set ver off
prompt

begin

  dbms_output.put_line('File '||interfaces.write_wor_file('&1',&2, '&3')||
					  ' created');

end;
/
prompt
pause Press Return to exit;
exit;
