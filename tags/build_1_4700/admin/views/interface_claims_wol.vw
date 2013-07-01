CREATE OR REPLACE FORCE VIEW interface_claims_wol AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/interface_claims_wol.vw-arc   3.1   Jul 01 2013 15:55:26   James.Wadsworth  $
--       Module Name      : $Workfile:   interface_claims_wol.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:26  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:14:30  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 *
from   interface_claims_wol_all
where  nvl(icwol_status, 'D') != 'D'
/
