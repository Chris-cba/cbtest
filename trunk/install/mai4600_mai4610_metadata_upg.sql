------------------------------------------------------------------
-- mai4600_mai4610_metadata_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4600_mai4610_metadata_upg.sql-arc   1.0   Jan 09 2013 10:35:56   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4600_mai4610_metadata_upg.sql  $
--       Date into PVCS   : $Date:   Jan 09 2013 10:35:56  $
--       Date fetched Out : $Modtime:   Jan 09 2013 09:49:20  $
--       Version          : $Revision:   1.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2013

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

