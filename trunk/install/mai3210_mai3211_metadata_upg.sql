--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai3210_mai3211_metadata_upg.sql-arc   2.1   Jul 01 2013 16:02:18   James.Wadsworth  $
--       Module Name      : $Workfile:   mai3210_mai3211_metadata_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:18  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
--   Product upgrade script
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--
--
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
--
--
DECLARE
  l_temp nm3type.max_varchar2;
BEGIN
  -- Dummy call to HIG to instantiate it
  l_temp := hig.get_version;
  l_temp := nm_debug.get_version;
EXCEPTION
  WHEN others
   THEN
 Null;
END;
/
----------------------------------------------------------------------------
--Call a proc in nm_debug to instantiate it before calling metadata scripts.
--
--If this is not done any inserts into hig_option_values may fail due to
-- mutating trigger when nm_debug checks DEBUGAUTON.
----------------------------------------------------------------------------
BEGIN
  nm_debug.debug_off;
END;
/
--


--
---------------------------------------------------------------------------------------------------
--                   **************** MISCELLANEOUS CHANGES BELOW HERE *******************


--
COMMIT;
---------------------------------------------------------------------------------------------------
--                        ****************   END OF SCRIPT   *******************

