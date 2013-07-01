CREATE OR REPLACE package body int_utility is
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/int_utility.pkb-arc   2.1   Jul 01 2013 16:25:52   James.Wadsworth  $
--       Module Name      : $Workfile:   int_utility.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:25:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:42  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
-- Originally taken from '@(#)intutil.pck	1.1 01/27/99'
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
function get_field(string  varchar2, field_no number) RETURN varchar2 is
begin

  if field_no = 1 then
    if instr(string, ',', 1, 1) = 0 then	    -- there is only one field, return it
      return string;
    else					    -- return first field in string
      return substr(string, 1, instr(string, ',', 1, 1) - 1);
    end if;
  elsif instr(string, ',', 1, field_no) = 0 then
    if instr(string, ',', 1, field_no - 1) = 0 then -- no such field exists, return full string
      return string;
    else					    -- return the last field in the string
      return substr(string, instr(string, ',', 1, field_no - 1) + 1);
    end if;
  else
    return substr(string, instr(string, ',', 1, field_no - 1) + 1,
                          instr(string, ',', 1, field_no) -
	 		  instr(string, ',', 1, field_no - 1) - 1);
  end if;

end;

end int_utility;
/
