-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_user_roles.sql-arc   2.1   Jul 01 2013 16:02:10   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_user_roles.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:02:10  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
-- Grant all the privs for each role
BEGIN
   FOR cs_rec IN (SELECT hus_username,hro_role,hus_start_date
                   FROM  hig_users
                        ,hig_roles
                  WHERE  hus_username = USER
                  UNION ALL
                  SELECT hus_username,'JAVA_ADMIN',hus_start_date
                   FROM  hig_users
                  WHERE  hus_username = USER
                 )
    LOOP
      grant_role_to_user (p_user       => cs_rec.hus_username
                         ,p_role       => cs_rec.hro_role
                         ,p_admin      => TRUE
                         ,p_start_date => cs_rec.hus_start_date
                         );
   END LOOP;
END;
/
--
COMMIT;
REM End of command file
REM


