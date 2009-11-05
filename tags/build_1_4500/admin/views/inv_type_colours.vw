CREATE OR REPLACE FORCE VIEW inv_type_colours
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/inv_type_colours.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   inv_type_colours.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:10:24  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
 col_id,
 ity_inv_code
FROM nm_inv_type_colours
/
