CREATE OR REPLACE PACKAGE BODY imf_mai_foundation_layer
AS
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/pck/imf_mai_foundation_layer.pkb-arc   3.1   Jul 01 2013 16:32:44   James.Wadsworth  $
--       Module Name      : $Workfile:   imf_mai_foundation_layer.pkb  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:32:44  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:30:36  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
--all global package variables here

  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '$Revision:   3.1  $';

  g_package_name CONSTANT varchar2(30) := 'imf_mai_foundation_layer';
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
END imf_mai_foundation_layer;
/
