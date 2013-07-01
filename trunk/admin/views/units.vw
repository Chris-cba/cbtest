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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/units.vw-arc   3.1   Jul 01 2013 15:55:28   James.Wadsworth  $
--       Module Name      : $Workfile:   units.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:28  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:18:44  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       un_domain_id
      ,un_unit_id
      ,un_unit_name
      ,un_format_mask
FROM   nm_units
/
