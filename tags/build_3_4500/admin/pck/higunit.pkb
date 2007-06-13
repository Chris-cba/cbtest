create or replace package body higunit as

--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/higunit.pkb-arc   2.0   Jun 13 2007 17:36:48   smarshall  $
--       Module Name      : $Workfile:   higunit.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:48  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
--
--   Author D.Cope
--
--   wrapper package for higunit package.
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2000
-----------------------------------------------------------------------------
   g_body_sccsid     CONSTANT  VARCHAR2(2000) := '"$Revision:   2.0  $"';
--  g_body_sccsid is the SCCS ID for the package body
   g_package_name    CONSTANT  VARCHAR2(30)   := 'higunit';
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
function get_default_unit_id return number is
begin
  return nm3unit.get_default_unit_id;
end;
--
-----------------------------------------------------------------------------
--
function get_next_ud_domain_id return number is
  begin
   RETURN nm3unit.get_next_ud_domain_id;
  end;
--
-----------------------------------------------------------------------------
--
function get_next_unit_id return number is
  begin
    return nm3unit.get_next_unit_id;
  end;
--
-----------------------------------------------------------------------------
--
  function get_length_units return number is
  begin
    return nm3unit.get_length_units;
  end;
--
-----------------------------------------------------------------------------
--
  function get_unit_name( p_un_id in number) return varchar2 is
  begin
    return nm3unit.get_unit_name(p_un_id => p_un_id);
  end;
--
-----------------------------------------------------------------------------
--
  function get_unit_id ( p_un_name in varchar2) return number is
  begin
    return nm3unit.get_unit_id(p_un_name => p_un_name);
  end;
--
-----------------------------------------------------------------------------
--
function convert_unit( p_un_id_in in number, p_un_id_out in number, p_value in number ) return number is

begin
   RETURN nm3unit.convert_unit(p_un_id_in  => p_un_id_in
                              ,p_un_id_out => p_un_id_out
                              ,p_value     => p_value);
--
end convert_unit;
--
-----------------------------------------------------------------------------
--
function get_unit_function ( p_un_id_in in number, p_un_id_out in number ) return varchar2 is
BEGIN
--
   RETURN nm3unit.get_unit_function(p_un_id_in  => p_un_id_in
                                   ,p_un_id_out => p_un_id_out);
--
end get_unit_function;
--
-----------------------------------------------------------------------------
--
  function get_gty_units    ( p_gty in varchar2 ) return number is

  begin
    return nm3unit.get_gty_units(p_gty => p_gty);
  end;
--
-----------------------------------------------------------------------------
--
  function unit_exists ( p_domain_name in nm_unit_domains.ud_domain_name%type, p_unit_id in nm_units.un_unit_id%type ) return boolean is

  begin
    return nm3unit.unit_exists(p_domain_name => p_domain_name
                              ,p_unit_id     => p_unit_id);
  end;
--
-----------------------------------------------------------------------------
--
  function get_unit_mask ( p_unit_id in nm_units.un_unit_id%type ) return varchar2 is
  begin
    return nm3unit.get_unit_mask(p_unit_id => p_unit_id);
  end;
--
-----------------------------------------------------------------------------
--
PROCEDURE build_unit_conversion_function
                (pi_unit_id_in    IN nm_unit_conversions.uc_unit_id_in%TYPE
                ,pi_unit_id_out   IN nm_unit_conversions.uc_unit_id_out%TYPE
                ) IS
--
BEGIN
--
  nm3unit.build_unit_conversion_function(pi_unit_id_in  => pi_unit_id_in
                                        ,pi_unit_id_out => pi_unit_id_out);
--
END build_unit_conversion_function;
--
-----------------------------------------------------------------------------
--
PROCEDURE build_all_unit_conv_functions IS
BEGIN
--
  nm3unit.build_all_unit_conv_functions;
--
END build_all_unit_conv_functions;
--
-----------------------------------------------------------------------------
--
FUNCTION get_function_from_factor (p_function_name nm_unit_conversions.uc_function%TYPE
                                  ,p_factor        nm_unit_conversions.uc_conversion_factor%TYPE
                                  ) RETURN nm_unit_conversions.uc_conversion%TYPE IS
BEGIN
--
   RETURN nm3unit.get_function_from_factor(p_function_name => p_function_name
                                          ,p_factor        => p_factor);
--
END get_function_from_factor;
--
-----------------------------------------------------------------------------
--
function get_uc (p_un_id_in  in number
                ,p_un_id_out in number
                ) return nm_unit_conversions%ROWTYPE IS
begin
--
   RETURN nm3unit.get_uc(p_un_id_in  => p_un_id_in
                        ,p_un_id_out => p_un_id_out);
--
END get_uc;
--
-----------------------------------------------------------------------------
--
FUNCTION get_formatted_value (p_value   NUMBER
                             ,p_unit_id nm_units.un_unit_id%TYPE
                             ) RETURN nm_units.un_format_mask%TYPE IS
BEGIN
--
   RETURN nm3unit.get_formatted_value(p_value   => p_value
                                     ,p_unit_id => p_unit_id);
--
END get_formatted_value;
--
-----------------------------------------------------------------------------
--
end  higunit;
/

