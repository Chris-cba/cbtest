--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/GET_ADMIN_UNIT.fnc-arc   1.2   Sep 27 2019 14:39:30   Chris.Baugh  $
--       Module Name      : $Workfile:   GET_ADMIN_UNIT.fnc  $
--       Date into SCCS   : $Date:   Sep 27 2019 14:39:30  $
--       Date fetched Out : $Modtime:   Sep 27 2019 13:24:34  $
--       SCCS Version     : $Revision:   1.2  $
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
