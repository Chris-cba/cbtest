CREATE OR REPLACE PACKAGE BODY mai_user AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_users.pkb-arc   3.0   Feb 24 2011 17:56:12   Mike.Huitson  $
--       Module Name      : $Workfile:   mai_users.pkb  $
--       Date into PVCS   : $Date:   Feb 24 2011 17:56:12  $
--       Date fetched Out : $Modtime:   Feb 17 2011 13:29:22  $
--       PVCS Version     : $Revision:   3.0  $
--
-----------------------------------------------------------------------------
--  Copyright (c) exor corporation ltd, 2007
-----------------------------------------------------------------------------
--
  g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   3.0  $';
  g_package_name  CONSTANT  varchar2(30)   := 'mai_user';
  --
--
-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN varchar2 IS
BEGIN
   RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--
PROCEDURE create_mai_user(pi_hus_user_id IN hig_users.hus_user_id%TYPE)
  IS
BEGIN
  --
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
  VALUES(pi_hus_user_id
        ,'0'
        ,NULL
        ,NULL
        ,'Y'
        ,NULL
        ,NULL
        ,NULL)
       ;
  --
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE delete_mai_user(pi_hus_user_id IN hig_users.hus_user_id%TYPE)
  IS
BEGIN
  --
  DELETE
    FROM mai_users
   WHERE mus_user_id = pi_hus_user_id
     AND NOT EXISTS(SELECT 1
                      FROM hig_users
                     WHERE hus_user_id = pi_hus_user_id)
       ;
  --
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_mus(pi_mus_user_id IN mai_users.mus_user_id%TYPE)
  RETURN mai_users%ROWTYPE IS
  --
  lv_retval  mai_users%ROWTYPE;
  --
BEGIN
  --
  SELECT *
    INTO lv_retval
    FROM mai_users
   WHERE mus_user_id = pi_mus_user_id
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN no_data_found
   THEN
      raise_application_error(-20001,'UserID '||pi_mus_user_id||' not found in MAI_USERS');
  WHEN others
   THEN
      RAISE;
END;
--
-----------------------------------------------------------------------------
--
END mai_user;
/
