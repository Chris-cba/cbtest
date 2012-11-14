--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/GET_ADMIN_UNIT.fnc-arc   1.0   Nov 14 2012 11:50:04   Rob.Coupe  $
--       Module Name      : $Workfile:   GET_ADMIN_UNIT.fnc  $
--       Date into SCCS   : $Date:   Nov 14 2012 11:50:04  $
--       Date fetched Out : $Modtime:   Nov 14 2012 11:49:38  $
--       SCCS Version     : $Revision:   1.0  $
--
-----------------------------------------------------------------------------
--    Copyright (c) Bentley Systems 2012
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