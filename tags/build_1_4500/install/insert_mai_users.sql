-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/insert_mai_users.sql-arc   2.0   May 06 2011 11:46:04   Mike.Huitson  $
--       Module Name      : $Workfile:   insert_mai_users.sql  $
--       Date into SCCS   : $Date:   May 06 2011 11:46:04  $
--       Date fetched Out : $Modtime:   May 06 2011 11:41:00  $
--       SCCS Version     : $Revision:   2.0  $
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
--	Copyright (c) exor corporation ltd, 2011
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

