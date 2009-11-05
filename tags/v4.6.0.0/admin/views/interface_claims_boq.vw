CREATE OR REPLACE FORCE VIEW interface_claims_boq AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/interface_claims_boq.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   interface_claims_boq.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:52:28  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
 *
from   interface_claims_boq_all
where  nvl(icboq_status, 'D') != 'D'
/