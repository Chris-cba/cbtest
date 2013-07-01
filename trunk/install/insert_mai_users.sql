-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/insert_mai_users.sql-arc   2.1   Jul 01 2013 16:00:24   James.Wadsworth  $
--       Module Name      : $Workfile:   insert_mai_users.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:00:24  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.2
--
--   Author : M Huitson
--
-----------------------------------------------------------------------------
--
--  insert_mai_users - 
--    Creates a record in the table mai_users for each user defined in hig_users
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
INSERT
  INTO mai_users
      (mus_user_id
      ,mus_wor_flag
      ,mus_wor_value_min
      ,mus_wor_value_max
      ,mus_wor_aur_allowed 
      ,mus_wor_aur_min
      ,mus_wor_aur_max
      ,mus_wor_aur_daily_max)
SELECT hus_user_id
      ,'0'
      ,NULL
      ,NULL
      ,'Y'
      ,NULL
      ,NULL
      ,NULL
  FROM hig_users
 WHERE NOT EXISTS(SELECT 1
                    FROM mai_users
                   WHERE mus_user_id = hus_user_id);
                     
COMMIT;

