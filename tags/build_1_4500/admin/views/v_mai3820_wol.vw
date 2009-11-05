CREATE OR REPLACE FORCE VIEW v_mai3820_wol AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/v_mai3820_wol.vw-arc   3.0   Nov 05 2009 10:35:04   gjohnson  $
--       Module Name      : $Workfile:   v_mai3820_wol.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:04  $
--       Date fetched Out : $Modtime:   Nov 04 2009 15:38:12  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
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