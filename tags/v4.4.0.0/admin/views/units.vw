CREATE OR REPLACE FORCE VIEW units
( un_domain_id
, un_unit_id
, un_unit_name
, un_format_mask)
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/units.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   units.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:10:54  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
       un_domain_id
      ,un_unit_id
      ,un_unit_name
      ,un_format_mask
FROM   nm_units
/
