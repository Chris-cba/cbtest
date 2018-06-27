--
SET SERVEROUTPUT ON SIZE 1000000
--
DECLARE
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //new_vm_latest/archives/mai/admin/ctx/mai_policy.sql-arc   3.3   Jun 27 2018 10:38:10   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_policy.sql  $
--       Date into PVCS   : $Date:   Jun 27 2018 10:38:10  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:32:40  $
--       PVCS Version     : $Revision:   3.3  $
--
--   Create MAI security policies
--
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
  l_tab_policy_name     nm3type.tab_varchar30;
  l_tab_object_name     nm3type.tab_varchar30;
  l_tab_policy_function nm3type.tab_varchar2000;
  l_tab_statement_types nm3type.tab_varchar30;
  l_tab_check_option    nm3type.tab_boolean;
  l_tab_enable          nm3type.tab_boolean;
  l_tab_static_policy   nm3type.tab_boolean;
  --
  c_application_owner   CONSTANT VARCHAR2(30) := Sys_Context('NM3CORE', 'APPLICATION_OWNER' ); 
  --
  l_no_fine_grained_security EXCEPTION;
  PRAGMA EXCEPTION_INIT (l_no_fine_grained_security,-439);
  --
  PROCEDURE add_policy(p_policy_name     VARCHAR2
                      ,p_object_name     VARCHAR2
                      ,p_policy_function VARCHAR2
                      ,p_statement_types VARCHAR2
                      ,p_check_option    BOOLEAN DEFAULT TRUE
                      ,p_enable          BOOLEAN DEFAULT TRUE
                      ,p_static_policy   BOOLEAN DEFAULT FALSE)
     IS
     --
     i CONSTANT PLS_INTEGER := l_tab_policy_name.COUNT + 1;
     --
   BEGIN
     l_tab_policy_name(i)     := p_policy_name;
     l_tab_object_name(i)     := p_object_name;
     l_tab_policy_function(i) := p_policy_function;
     l_tab_statement_types(i) := p_statement_types;
     l_tab_check_option(i)    := p_check_option;
     l_tab_enable(i)          := p_enable;
     l_tab_static_policy(i)   := p_static_policy;
   END add_policy;
   --
BEGIN
--   add_policy (p_policy_name     =>
--              ,p_object_name     =>
--              ,p_policy_function =>
--              ,p_statement_types =>
--              );
--
  /*
  ||Define the select policy for Contracts
  */
  add_policy(p_policy_name     => 'CONTRACTS_POLICY_READ'
            ,p_object_name     => 'CONTRACTS'
            ,p_policy_function => 'MAISEC.CON_PREDICATE_READ'
            ,p_statement_types => 'SELECT');
  /*
  ||Define the select policy for Work Orders
  */
  add_policy(p_policy_name     => 'WORK_ORDERS_POLICY_READ'
            ,p_object_name     => 'WORK_ORDERS'
            ,p_policy_function => 'MAISEC.WO_PREDICATE_READ'
            ,p_statement_types => 'SELECT');
  /*
  ||Define the select policy for BOQs
  */
  add_policy(p_policy_name     => 'BOQ_ITEMS_POLICY_READ'
            ,p_object_name     => 'BOQ_ITEMS'
            ,p_policy_function => 'MAISEC.BOQ_PREDICATE_READ'
            ,p_statement_types => 'SELECT');      
  /*
  ||Define the select policy for Contract Items
  */
  add_policy(p_policy_name     => 'CONTRACT_ITEMS_POLICY_READ'
            ,p_object_name     => 'CONTRACT_ITEMS'
            ,p_policy_function => 'MAISEC.CNI_PREDICATE_READ'
            ,p_statement_types => 'SELECT');      
  /*
  ||Create the defined policies.
  */
  FOR l_count IN 1..l_tab_policy_name.COUNT LOOP
    BEGIN
      dbms_rls.add_policy(object_schema   => c_application_owner
                         ,object_name     => l_tab_object_name(l_count)
                         ,policy_name     => l_tab_policy_name(l_count)
                         ,function_schema => c_application_owner
                         ,policy_function => l_tab_policy_function(l_count)
                         ,statement_types => l_tab_statement_types(l_count)
                         ,update_check    => l_tab_check_option(l_count)
                         ,enable          => l_tab_enable(l_count)
                         ,static_policy   => l_tab_static_policy(l_count));
      --
      dbms_output.put_line(l_count||'. '||l_tab_policy_name(l_count)
                         ||' on '||c_application_owner||'.'||l_tab_object_name(l_count)
                         ||' created');
      --
    EXCEPTION
      WHEN l_no_fine_grained_security
       THEN
          RAISE;
      WHEN others
       THEN
          dbms_output.put_line(l_count||'. ### '||l_tab_policy_name(l_count)
                             ||' on '||l_tab_object_name(l_count)||' ERROR');
          dbms_output.put_line(SUBSTR(SQLERRM,1,255));
    END;
    --
    dbms_output.put_line('--');
    --
  END LOOP;
  --
EXCEPTION
  WHEN l_no_fine_grained_security
   THEN
      dbms_output.put_line(SUBSTR(SQLERRM,1,255));
END;
/
