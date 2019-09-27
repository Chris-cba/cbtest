CREATE OR REPLACE TRIGGER A_I_HUS_MAI
           AFTER INSERT ON HIG_USERS
           FOR EACH ROW
DECLARE
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/a_i_hus_mai.trg-arc   3.4   Sep 27 2019 15:17:40   Chris.Baugh  $
--       Module Name      : $Workfile:   a_i_hus_mai.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:17:40  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.4  $
-------------------------------------------------------------------------
--
--   TRIGGER A_I_HUS_MAI
--           AFTER INSERT ON HIG_USERS
--           FOR EACH ROW
--
--  Created During the MAI Install to maintain records in the table MAI_USERS.
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
BEGIN
  -- Create MAI_USERS record.
  mai_user.create_mai_user(pi_hus_user_id => :new.hus_user_id);
  --
END;
/
