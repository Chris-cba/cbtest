--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4500_fix2_metadata.sql-arc   3.0   Feb 14 2012 14:07:38   Mike.Alexander  $
--       Module Name      : $Workfile:   mai_4500_fix2_metadata.sql  $
--       Date into PVCS   : $Date:   Feb 14 2012 14:07:38  $
--       Date fetched Out : $Modtime:   Feb 14 2012 14:02:32  $
--       PVCS Version     : $Revision:   3.0  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2012 Bentley Systems Incorporated.
--------------------------------------------------------------------------------
--
update gri_module_params
set gmp_where = NULL
where gmp_module = 'MAI3505'
and gmp_param = 'ROAD_ID'
/
Commit
/