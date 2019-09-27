CREATE OR REPLACE FORCE VIEW v_mai3820_wol AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/views/v_mai3820_wol.vw-arc   3.3   Sep 27 2019 15:36:18   Chris.Baugh  $
--       Module Name      : $Workfile:   v_mai3820_wol.vw  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:36:18  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:34:24  $
--       Version          : $Revision:   3.3  $
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
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
