CREATE OR REPLACE FORCE VIEW interface_claims_wor AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/interface_claims_wor.vw-arc   3.3   Sep 27 2019 15:36:14   Chris.Baugh  $
--       Module Name      : $Workfile:   interface_claims_wor.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:14  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 *
from   interface_claims_wor_all
where  nvl(icwor_status, 'D') != 'D'
/
