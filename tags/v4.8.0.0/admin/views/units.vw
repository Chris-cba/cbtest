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
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/units.vw-arc   3.3   Sep 27 2019 15:36:16   Chris.Baugh  $
--       Module Name      : $Workfile:   units.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       un_domain_id
      ,un_unit_id
      ,un_unit_name
      ,un_format_mask
FROM   nm_units
/
