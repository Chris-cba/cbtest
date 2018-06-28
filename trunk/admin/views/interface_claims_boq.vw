CREATE OR REPLACE FORCE VIEW interface_claims_boq AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/interface_claims_boq.vw-arc   3.2   Jun 28 2018 04:46:50   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   interface_claims_boq.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:50  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 *
from   interface_claims_boq_all
where  nvl(icboq_status, 'D') != 'D'
/
