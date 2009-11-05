CREATE OR REPLACE FORCE VIEW interface_completions AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/interface_completions.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   interface_completions.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:42:08  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
 *
from   interface_completions_all
where  ic_status is not null
/