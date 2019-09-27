CREATE OR REPLACE package body int_utility is
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/int_utility.pkb-arc   2.3   Sep 27 2019 14:39:50   Chris.Baugh  $
--       Module Name      : $Workfile:   int_utility.pkb  $
--       Date into SCCS   : $Date:   Sep 27 2019 14:39:50  $
--       Date fetched Out : $Modtime:   Sep 27 2019 14:01:50  $
--       SCCS Version     : $Revision:   2.3  $
--       Based on SCCS Version     : 1.1
--
-- Originally taken from '@(#)intutil.pck	1.1 01/27/99'
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
g_body_sccsid     CONSTANT  varchar2(2000) := '"$Revision:   2.3  $"';
-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN VARCHAR2 IS
BEGIN
  RETURN g_sccsid;
END;
--
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------

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
