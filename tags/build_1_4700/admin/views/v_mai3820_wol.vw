CREATE OR REPLACE FORCE VIEW v_mai3820_wol AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3820_wol.vw-arc   3.1   Jul 01 2013 15:55:30   James.Wadsworth  $
--       Module Name      : $Workfile:   v_mai3820_wol.vw  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:55:30  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:23:06  $
--       Version          : $Revision:   3.1  $
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--
       rse_unique,
       rse_descr,
       hus_initials,
       wol.*
from   road_segments_all,
       hig_users,
       work_order_lines wol
where  wol_rse_he_id = rse_he_id
and    wol_check_peo_id = hus_user_id (+)
and    wol_date_complete is not null
/
