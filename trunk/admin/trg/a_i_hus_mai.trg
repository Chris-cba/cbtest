CREATE OR REPLACE TRIGGER A_I_HUS_MAI
           AFTER INSERT ON HIG_USERS
           FOR EACH ROW
DECLARE
--   SCCS Identifiers :-
--
--       sccsid           : @(#)hig_users.trg    1.2 04/10/01
--       Module Name      : hig_users.trg
--       Date into SCCS   : 01/04/10 10:49:54
--       Date fetched Out : 07/06/13 17:02:32
--       SCCS Version     : 1.2
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
