CREATE OR REPLACE TRIGGER A_I_HUS_MAI
           AFTER INSERT ON HIG_USERS
           FOR EACH ROW
DECLARE
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/a_i_hus_mai.trg-arc   3.1   Feb 24 2011 18:05:14   Mike.Huitson  $
--       Module Name      : $Workfile:   a_i_hus_mai.trg  $
--       Date into PVCS   : $Date:   Feb 24 2011 18:05:14  $
--       Date fetched Out : $Modtime:   Feb 24 2011 18:04:52  $
--       Version          : $Revision:   3.1  $
-------------------------------------------------------------------------
--
--   TRIGGER A_I_HUS_MAI
--           AFTER INSERT ON HIG_USERS
--           FOR EACH ROW
--
--  Created During the MAI Install to maintain records in the table MAI_USERS.
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2001
-----------------------------------------------------------------------------
--
BEGIN
  -- Create MAI_USERS record.
  mai_user.create_mai_user(pi_hus_user_id => :new.hus_user_id);
  --
END;
/
