CREATE OR REPLACE FORCE VIEW inv_type_colours
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/inv_type_colours.vw-arc   3.1   Jul 01 2013 15:55:26   James.Wadsworth  $
--       Module Name      : $Workfile:   inv_type_colours.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:26  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:16:12  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 col_id,
 ity_inv_code
FROM nm_inv_type_colours
/
