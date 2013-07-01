CREATE OR REPLACE TRIGGER A_I_HUS_MAI
           AFTER INSERT ON HIG_USERS
           FOR EACH ROW
DECLARE
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/a_i_hus_mai.trg-arc   3.2   Jul 01 2013 15:52:48   James.Wadsworth  $
--       Module Name      : $Workfile:   a_i_hus_mai.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:48  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.2  $
-------------------------------------------------------------------------
--
--   TRIGGER A_I_HUS_MAI
--           AFTER INSERT ON HIG_USERS
--           FOR EACH ROW
--
--  Created During the MAI Install to maintain records in the table MAI_USERS.
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
BEGIN
  -- Create MAI_USERS record.
  mai_user.create_mai_user(pi_hus_user_id => :new.hus_user_id);
  --
END;
/
