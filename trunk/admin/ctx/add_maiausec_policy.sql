--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/ctx/add_maiausec_policy.sql-arc   1.4   Nov 28 2012 09:28:46   Rob.Coupe  $
--       Module Name      : $Workfile:   add_maiausec_policy.sql  $
--       Date into SCCS   : $Date:   Nov 28 2012 09:28:46  $
--       Date fetched Out : $Modtime:   Nov 28 2012 09:28:34  $
--       SCCS Version     : $Revision:   1.4  $
--
-----------------------------------------------------------------------------
--    Copyright (c) Bentley Systems 2012
-----------------------------------------------------------------------------


SET SERVEROUTPUT ON SIZE 1000000
--
DECLARE
--
-----------------------------------------------------------------------------
--	Copyright (c) Bentley Systems 2012
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
   c_application_owner   CONSTANT VARCHAR2(30) := Sys_Context('NM3CORE','APPLICATION_OWNER');
--
   l_no_fine_grained_security EXCEPTION;
   PRAGMA EXCEPTION_INIT (l_no_fine_grained_security,-439);
   --
   PROCEDURE add_policy (p_policy_name     VARCHAR2
                        ,p_object_name     VARCHAR2
                        ,p_policy_function VARCHAR2
                        ,p_statement_types VARCHAR2
                        ,p_check_option    BOOLEAN DEFAULT TRUE
                        ,p_enable          BOOLEAN DEFAULT TRUE
                        ,p_static_policy   BOOLEAN DEFAULT FALSE
                        ) IS
      i CONSTANT PLS_INTEGER := l_tab_policy_name.COUNT + 1;
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
-- SELECT policies for inventory
--
add_policy ( p_policy_name    => 'DSR_6_AU_READ'            ,p_object_name => 'DEF_SUPERSEDING_RULES'            ,p_policy_function => 'MAIAUSEC.DSR_6_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'BUD_12_AU_READ'            ,p_object_name => 'BUDGETS'            ,p_policy_function => 'MAIAUSEC.BUD_12_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'ICB_13_AU_READ'            ,p_object_name => 'ITEM_CODE_BREAKDOWNS'            ,p_policy_function => 'MAIAUSEC.ICB_13_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'DRL_14_AU_READ'            ,p_object_name => 'DOC_REDIRECTION_LOG'            ,p_policy_function => 'MAIAUSEC.DRL_14_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'MAW_17_AU_READ'            ,p_object_name => 'MAI_AUTO_WO_RULES'            ,p_policy_function => 'MAIAUSEC.MAW_17_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'DEF_18_AU_READ'            ,p_object_name => 'DEFECTS'            ,p_policy_function => 'MAIAUSEC.DEF_18_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'HFC_19_AU_READ'            ,p_object_name => 'HIG_FTP_CONNECTIONS'            ,p_policy_function => 'MAIAUSEC.HFC_19_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'ARE_20_AU_READ'            ,p_object_name => 'ACTIVITIES_REPORT'            ,p_policy_function => 'MAIAUSEC.ARE_20_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'DEF_22_AU_READ'            ,p_object_name => 'MAI_INSP_LOAD_ERROR_DEF'            ,p_policy_function => 'MAIAUSEC.DEF_22_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'WOL_23_AU_READ'            ,p_object_name => 'WORK_ORDER_LINES'            ,p_policy_function => 'MAIAUSEC.WOL_23_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'HPA_25_AU_READ'            ,p_object_name => 'HIG_PROCESS_ALERT_LOG'            ,p_policy_function => 'MAIAUSEC.HPA_25_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'DLD_34_AU_READ'            ,p_object_name => 'DELETED_DEFECTS'            ,p_policy_function => 'MAIAUSEC.DLD_34_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'ARE_42_AU_READ'            ,p_object_name => 'MAI_INSP_LOAD_ERROR_ARE'            ,p_policy_function => 'MAIAUSEC.ARE_42_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'SCH_45_AU_READ'            ,p_object_name => 'SCHEDULE_ROADS'            ,p_policy_function => 'MAIAUSEC.SCH_45_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'MAI_46_AU_READ'            ,p_object_name => 'MAI2325_RESULTS'            ,p_policy_function => 'MAIAUSEC.MAI_46_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'REP_47_AU_READ'            ,p_object_name => 'REPAIRS'            ,p_policy_function => 'MAIAUSEC.REP_47_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'LFR_49_AU_READ'            ,p_object_name => 'LOCAL_FREQS'            ,p_policy_function => 'MAIAUSEC.LFR_49_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'DOC_53_AU_READ'            ,p_object_name => 'DOCS'            ,p_policy_function => 'MAIAUSEC.DOC_53_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'SCH_61_AU_READ'            ,p_object_name => 'SCHEDULES'            ,p_policy_function => 'MAIAUSEC.SCH_61_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'REP_62_AU_READ'            ,p_object_name => 'MAI_INSP_LOAD_ERROR_REP'            ,p_policy_function => 'MAIAUSEC.REP_62_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
add_policy ( p_policy_name    => 'SEC_64_AU_READ'            ,p_object_name => 'NM3_SECTOR_GROUPS'            ,p_policy_function => 'MAIAUSEC.SEC_64_PREDICATE_READ'            ,p_statement_types => 'SELECT,INSERT,UPDATE,DELETE' ); 
--
--
-- Manual ones
--

add_policy ( p_policy_name    => 'CONTRACTS_AU_READ'            ,p_object_name => 'ORG_UNITS'            ,p_policy_function => 'MAIAUSEC.CONTRACTS_PREDICATE_READ'            ,p_statement_types => 'SELECT' );

--
   FOR l_count IN 1..l_tab_policy_name.COUNT

    LOOP
      BEGIN
         dbms_rls.add_policy
            (object_schema   => c_application_owner
            ,object_name     => l_tab_object_name(l_count)
            ,policy_name     => l_tab_policy_name(l_count)
            ,function_schema => c_application_owner
            ,policy_function => l_tab_policy_function(l_count)
            ,statement_types => l_tab_statement_types(l_count)
            ,update_check    => l_tab_check_option(l_count)
            ,enable          => l_tab_enable(l_count)
            ,static_policy   => l_tab_static_policy(l_count)
            );
         dbms_output.put_line(l_count||'. '||l_tab_policy_name(l_count)||' on '||c_application_owner||'.'||l_tab_object_name(l_count)||' created');
      EXCEPTION
         WHEN l_no_fine_grained_security
          THEN
            RAISE;
         WHEN others
          THEN
            dbms_output.put_line(l_count||'. ### '||l_tab_policy_name(l_count)||' on '||l_tab_object_name(l_count)||' ERROR');
            dbms_output.put_line(SUBSTR(SQLERRM,1,255));
      END;
      dbms_output.put_line('--');
   END LOOP;
--
EXCEPTION
   WHEN l_no_fine_grained_security
    THEN
      dbms_output.put_line(SUBSTR(SQLERRM,1,255));
END;
/



