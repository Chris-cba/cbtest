CREATE OR REPLACE FORCE VIEW interface_claims_wor AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/interface_claims_wor.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   interface_claims_wor.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:42:20  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
 *
from   interface_claims_wor_all
where  nvl(icwor_status, 'D') != 'D'
/