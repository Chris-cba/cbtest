--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/GET_ADMIN_UNIT.fnc-arc   1.1   Jul 01 2013 16:24:30   James.Wadsworth  $
--       Module Name      : $Workfile:   GET_ADMIN_UNIT.fnc  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:24:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:42  $
--       SCCS Version     : $Revision:   1.1  $
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

create or replace function get_admin_unit (p_ne_id in nm_elements_all.ne_id%type ) return number deterministic is
retval number;
begin
  select ne_admin_unit
  into retval
  from nm_elements_all
  where ne_id = p_ne_id;
  return retval;
end;
