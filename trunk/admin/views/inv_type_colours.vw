CREATE OR REPLACE FORCE VIEW inv_type_colours
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/inv_type_colours.vw-arc   3.2   Jun 28 2018 04:46:50   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   inv_type_colours.vw  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:46:50  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:45:54  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
 col_id,
 ity_inv_code
FROM nm_inv_type_colours
/
