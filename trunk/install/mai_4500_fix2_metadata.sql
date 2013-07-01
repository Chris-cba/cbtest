--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4500_fix2_metadata.sql-arc   3.1   Jul 01 2013 16:01:52   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4500_fix2_metadata.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       PVCS Version     : $Revision:   3.1  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
--------------------------------------------------------------------------------
--
update gri_module_params
set gmp_where = NULL
where gmp_module = 'MAI3505'
and gmp_param = 'ROAD_ID'
/
Commit
/
