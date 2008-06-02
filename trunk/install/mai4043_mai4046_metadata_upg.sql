------------------------------------------------------------------
-- mai4043_mai4046_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4043_mai4046_metadata_upg.sql-arc   3.0   Jun 02 2008 14:52:00   jwadsworth  $
--       Module Name      : $Workfile:   mai4043_mai4046_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Jun 02 2008 14:52:00  $
--       Date fetched Out : $Modtime:   Jun 02 2008 14:49:08  $
--       Version          : $Revision:   3.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2008

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF

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

BEGIN
  nm_debug.debug_off;
END;
/

------------------------------------------------------------------


------------------------------------------------------------------

Commit;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

