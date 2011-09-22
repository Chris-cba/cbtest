--
SET SERVEROUTPUT ON SIZE 1000000
--
DECLARE
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/ctx/drop_mai_policy.sql-arc   3.1   Sep 22 2011 12:34:58   Rob.Coupe  $
--       Module Name      : $Workfile:   drop_mai_policy.sql  $
--       Date into PVCS   : $Date:   Sep 22 2011 12:34:58  $
--       Date fetched Out : $Modtime:   Sep 22 2011 12:34:08  $
--       PVCS Version     : $Revision:   3.1  $
--
--   Drop MAI security policies
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2001
-----------------------------------------------------------------------------
--
  CURSOR cs_policies_to_drop (c_owner VARCHAR2)
      IS
  SELECT object_owner
        ,object_name
        ,policy_name
    FROM all_policies
   WHERE object_owner = c_owner
     AND object_name IN('WORK_ORDERS'
                       ,'CONTRACTS'
                       ,'BOQ_ITEMS'
                       ,'CONTRACT_ITEMS');
  --
  c_application_owner CONSTANT VARCHAR2(30) := Sys_Context('NM3CORE', 'APPLICATION_OWNER');
  --
BEGIN
  --
  FOR cs_rec IN cs_policies_to_drop(c_application_owner) LOOP
    BEGIN
      --
      dbms_rls.drop_policy(object_schema => cs_rec.object_owner
                          ,object_name   => cs_rec.object_name
                          ,policy_name   => cs_rec.policy_name);
      --
      dbms_output.put_line(cs_policies_to_drop%ROWCOUNT||'. '||cs_rec.policy_name
                         ||' on '||cs_rec.object_owner||'.'||cs_rec.object_name||' dropped');
      --
    EXCEPTION
      WHEN others
       THEN
          dbms_output.put_line(cs_policies_to_drop%ROWCOUNT||'. ### '||cs_rec.policy_name
                             ||' on '||cs_rec.object_name||' ERROR');
          dbms_output.put_line(SUBSTR(SQLERRM,1,255));
    END;
    --
    dbms_output.put_line('--');
    --
  END LOOP;
  --
END;
/
