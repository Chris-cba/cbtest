CREATE OR REPLACE PACKAGE BODY MAI3942 AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid                 : $Header:   //vm_latest/archives/mai/admin/pck/mai3942.pkb-arc   2.0   Oct 22 2008 17:34:52   smarshall  $
--       Module Name      : $Workfile:   mai3942.pkb  $
--       Date into PVCS   : $Date:   Oct 22 2008 17:34:52  $
--       Date fetched Out : $Modtime:   Oct 22 2008 17:01:56  $
--       PVCS Version     : $Revision:   2.0  $

-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
--
--all global package variables here

-- --   Package for 716903 fix for drd urgently required.
  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) :='"$Revision:   2.0  $"';

  g_package_name CONSTANT varchar2(30) := 'MAI3942';
--
-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN varchar2 IS
BEGIN
   RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--
FUNCTION count_slash_instr( string_in work_order_lines.wol_works_order_no%TYPE
                          ) RETURN number IS
  substring_loc work_order_lines.wol_works_order_no%TYPE;
  return_value number := 1;
BEGIN
	nm_debug.debug_on;
  loop
    substring_loc := instr(string_in, '/', 1, return_value);
    exit when substring_loc = 0;
      
    return_value := return_value + 1;
  end loop;
  nm_debug.debug(string_in);
  nm_debug.debug(return_value);
  nm_debug.debug_off;
  return return_value -1;
END count_slash_instr;
--
-----------------------------------------------------------------------------
--
END MAI3942;
/