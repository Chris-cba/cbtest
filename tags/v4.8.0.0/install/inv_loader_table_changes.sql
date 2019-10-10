DECLARE
  --
  lt_users nm3type.tab_varchar30;
  --
  FUNCTION get_users
    RETURN nm3type.tab_varchar30 IS
    --
    lt_retval  nm3type.tab_varchar30;
    --
  BEGIN
    --
    SELECT hus_username
      BULK COLLECT
      INTO lt_retval
      FROM hig_users
          ,dba_users
     WHERE username = hus_username
       AND hus_is_hig_owner_flag != 'Y'
         ;
    --
    RETURN lt_retval;
    --
  END get_users;
  --
  FUNCTION get_add_statement(pi_tablename IN VARCHAR2)
    RETURN VARCHAR2 IS
    --
    lv_add     NUMBER;
    lv_retval  nm3type.max_varchar2;
    --
  BEGIN
    --
    SELECT CASE
             WHEN table_name = 'INV_TYPE_TRANSLATIONS'
              THEN
                 'ALTER TABLE '||owner||'.inv_type_translations '
                   ||'ADD(ity_hhpos76 VARCHAR2(32)'
                   ||',ity_hhpos77 VARCHAR2(32)'
                   ||',ity_hhpos78 VARCHAR2(32)'
                   ||',ity_hhpos79 VARCHAR2(32)'
                   ||',ity_hhpos80 VARCHAR2(32)'
                   ||',ity_hhpos81 VARCHAR2(32)'
                   ||',ity_hhpos82 VARCHAR2(32)'
                   ||',ity_hhpos83 VARCHAR2(32)'
                   ||',ity_hhpos84 VARCHAR2(32)'
                   ||',ity_hhpos85 VARCHAR2(32)'
                   ||',ity_hhpos86 VARCHAR2(32)'
                   ||',ity_hhpos87 VARCHAR2(32)'
                   ||',ity_hhpos88 VARCHAR2(32)'
                   ||',ity_hhpos89 VARCHAR2(32)'
                   ||',ity_hhpos90 VARCHAR2(32)'
                   ||',ity_hhpos91 VARCHAR2(32)'
                   ||',ity_hhpos92 VARCHAR2(32)'
                   ||',ity_hhpos93 VARCHAR2(32)'
                   ||',ity_hhpos94 VARCHAR2(32)'
                   ||',ity_hhpos95 VARCHAR2(32)'
                   ||',ity_hhpos96 VARCHAR2(32)'
                   ||',ity_hhpos97 VARCHAR2(32)'
                   ||',ity_hhpos98 VARCHAR2(32)'
                   ||',ity_hhpos99 VARCHAR2(32)'
                   ||',ity_hhpos100 VARCHAR2(32)'
                   ||',ity_hhpos101 VARCHAR2(32)'
                   ||',ity_hhpos102 VARCHAR2(32)'
                   ||',ity_hhpos103 VARCHAR2(32)'
                   ||',ity_hhpos104 VARCHAR2(32)'
                   ||',ity_hhpos105 VARCHAR2(32)'
                   ||',ity_hhpos106 VARCHAR2(32)'
                   ||',ity_hhpos107 VARCHAR2(32)'
                   ||',ity_hhpos108 VARCHAR2(32)'
                   ||',ity_hhpos109 VARCHAR2(32)'
                   ||',ity_hhpos110 VARCHAR2(32)'
                   ||',ity_hhpos111 VARCHAR2(32)'
                   ||',ity_hhpos112 VARCHAR2(32)'
                   ||',ity_hhpos113 VARCHAR2(32)'
                   ||',ity_hhpos114 VARCHAR2(32)'
                   ||',ity_hhpos115 VARCHAR2(32)'
                   ||',ity_hhpos116 VARCHAR2(32)'
                   ||',ity_hhpos117 VARCHAR2(32)'
                   ||',ity_hhpos118 VARCHAR2(32)'
                   ||',ity_hhpos119 VARCHAR2(32)'
                   ||',ity_hhpos120 VARCHAR2(32))'
             WHEN table_name = 'HHINV_LOAD_2'
              THEN
                 'ALTER TABLE '||owner||'.hhinv_load_2 '
                   ||'ADD(hhattr76 VARCHAR2(32)'
                   ||',hhfld76 VARCHAR2(500)'
                   ||',hhattr77 VARCHAR2(32)'
                   ||',hhfld77 VARCHAR2(500)'
                   ||',hhattr78 VARCHAR2(32)'
                   ||',hhfld78 VARCHAR2(500)'
                   ||',hhattr79 VARCHAR2(32)'
                   ||',hhfld79 VARCHAR2(500)'
                   ||',hhattr80 VARCHAR2(32)'
                   ||',hhfld80 VARCHAR2(500)'
                   ||',hhattr81 VARCHAR2(32)'
                   ||',hhfld81 VARCHAR2(500)'
                   ||',hhattr82 VARCHAR2(32)'
                   ||',hhfld82 VARCHAR2(500)'
                   ||',hhattr83 VARCHAR2(32)'
                   ||',hhfld83 VARCHAR2(500)'
                   ||',hhattr84 VARCHAR2(32)'
                   ||',hhfld84 VARCHAR2(500)'
                   ||',hhattr85 VARCHAR2(32)'
                   ||',hhfld85 VARCHAR2(500)'
                   ||',hhattr86 VARCHAR2(32)'
                   ||',hhfld86 VARCHAR2(500)'
                   ||',hhattr87 VARCHAR2(32)'
                   ||',hhfld87 VARCHAR2(500)'
                   ||',hhattr88 VARCHAR2(32)'
                   ||',hhfld88 VARCHAR2(500)'
                   ||',hhattr89 VARCHAR2(32)'
                   ||',hhfld89 VARCHAR2(500)'
                   ||',hhattr90 VARCHAR2(32)'
                   ||',hhfld90 VARCHAR2(500)'
                   ||',hhattr91 VARCHAR2(32)'
                   ||',hhfld91 VARCHAR2(500)'
                   ||',hhattr92 VARCHAR2(32)'
                   ||',hhfld92 VARCHAR2(500)'
                   ||',hhattr93 VARCHAR2(32)'
                   ||',hhfld93 VARCHAR2(500)'
                   ||',hhattr94 VARCHAR2(32)'
                   ||',hhfld94 VARCHAR2(500)'
                   ||',hhattr95 VARCHAR2(32)'
                   ||',hhfld95 VARCHAR2(500)'
                   ||',hhattr96 VARCHAR2(32)'
                   ||',hhfld96 VARCHAR2(500)'
                   ||',hhattr97 VARCHAR2(32)'
                   ||',hhfld97 VARCHAR2(500)'
                   ||',hhattr98 VARCHAR2(32)'
                   ||',hhfld98 VARCHAR2(500)'
                   ||',hhattr99 VARCHAR2(32)'
                   ||',hhfld99 VARCHAR2(500)'
                   ||',hhattr100 VARCHAR2(32)'
                   ||',hhfld100 VARCHAR2(500)'
                   ||',hhattr101 VARCHAR2(32)'
                   ||',hhfld101 VARCHAR2(500)'
                   ||',hhattr102 VARCHAR2(32)'
                   ||',hhfld102 VARCHAR2(500)'
                   ||',hhattr103 VARCHAR2(32)'
                   ||',hhfld103 VARCHAR2(500)'
                   ||',hhattr104 VARCHAR2(32)'
                   ||',hhfld104 VARCHAR2(500)'
                   ||',hhattr105 VARCHAR2(32)'
                   ||',hhfld105 VARCHAR2(500)'
                   ||',hhattr106 VARCHAR2(32)'
                   ||',hhfld106 VARCHAR2(500)'
                   ||',hhattr107 VARCHAR2(32)'
                   ||',hhfld107 VARCHAR2(500)'
                   ||',hhattr108 VARCHAR2(32)'
                   ||',hhfld108 VARCHAR2(500)'
                   ||',hhattr109 VARCHAR2(32)'
                   ||',hhfld109 VARCHAR2(500)'
                   ||',hhattr110 VARCHAR2(32)'
                   ||',hhfld110 VARCHAR2(500)'
                   ||',hhattr111 VARCHAR2(32)'
                   ||',hhfld111 VARCHAR2(500)'
                   ||',hhattr112 VARCHAR2(32)'
                   ||',hhfld112 VARCHAR2(500)'
                   ||',hhattr113 VARCHAR2(32)'
                   ||',hhfld113 VARCHAR2(500)'
                   ||',hhattr114 VARCHAR2(32)'
                   ||',hhfld114 VARCHAR2(500)'
                   ||',hhattr115 VARCHAR2(32)'
                   ||',hhfld115 VARCHAR2(500)'
                   ||',hhattr116 VARCHAR2(32)'
                   ||',hhfld116 VARCHAR2(500)'
                   ||',hhattr117 VARCHAR2(32)'
                   ||',hhfld117 VARCHAR2(500)'
                   ||',hhattr118 VARCHAR2(32)'
                   ||',hhfld118 VARCHAR2(500)'
                   ||',hhattr119 VARCHAR2(32)'
                   ||',hhfld119 VARCHAR2(500)'
                   ||',hhattr120 VARCHAR2(32)'
                   ||',hhfld120 VARCHAR2(500))'
             WHEN table_name = 'HHINV_ITEM_ERR_2'
              THEN
                 'ALTER TABLE '||owner||'.hhinv_item_err_2 '
                   ||'ADD(hhattr76 VARCHAR2(32)'
                   ||',hhfld76 VARCHAR2(500)'
                   ||',hhattr77 VARCHAR2(32)'
                   ||',hhfld77 VARCHAR2(500)'
                   ||',hhattr78 VARCHAR2(32)'
                   ||',hhfld78 VARCHAR2(500)'
                   ||',hhattr79 VARCHAR2(32)'
                   ||',hhfld79 VARCHAR2(500)'
                   ||',hhattr80 VARCHAR2(32)'
                   ||',hhfld80 VARCHAR2(500)'
                   ||',hhattr81 VARCHAR2(32)'
                   ||',hhfld81 VARCHAR2(500)'
                   ||',hhattr82 VARCHAR2(32)'
                   ||',hhfld82 VARCHAR2(500)'
                   ||',hhattr83 VARCHAR2(32)'
                   ||',hhfld83 VARCHAR2(500)'
                   ||',hhattr84 VARCHAR2(32)'
                   ||',hhfld84 VARCHAR2(500)'
                   ||',hhattr85 VARCHAR2(32)'
                   ||',hhfld85 VARCHAR2(500)'
                   ||',hhattr86 VARCHAR2(32)'
                   ||',hhfld86 VARCHAR2(500)'
                   ||',hhattr87 VARCHAR2(32)'
                   ||',hhfld87 VARCHAR2(500)'
                   ||',hhattr88 VARCHAR2(32)'
                   ||',hhfld88 VARCHAR2(500)'
                   ||',hhattr89 VARCHAR2(32)'
                   ||',hhfld89 VARCHAR2(500)'
                   ||',hhattr90 VARCHAR2(32)'
                   ||',hhfld90 VARCHAR2(500)'
                   ||',hhattr91 VARCHAR2(32)'
                   ||',hhfld91 VARCHAR2(500)'
                   ||',hhattr92 VARCHAR2(32)'
                   ||',hhfld92 VARCHAR2(500)'
                   ||',hhattr93 VARCHAR2(32)'
                   ||',hhfld93 VARCHAR2(500)'
                   ||',hhattr94 VARCHAR2(32)'
                   ||',hhfld94 VARCHAR2(500)'
                   ||',hhattr95 VARCHAR2(32)'
                   ||',hhfld95 VARCHAR2(500)'
                   ||',hhattr96 VARCHAR2(32)'
                   ||',hhfld96 VARCHAR2(500)'
                   ||',hhattr97 VARCHAR2(32)'
                   ||',hhfld97 VARCHAR2(500)'
                   ||',hhattr98 VARCHAR2(32)'
                   ||',hhfld98 VARCHAR2(500)'
                   ||',hhattr99 VARCHAR2(32)'
                   ||',hhfld99 VARCHAR2(500)'
                   ||',hhattr100 VARCHAR2(32)'
                   ||',hhfld100 VARCHAR2(500)'
                   ||',hhattr101 VARCHAR2(32)'
                   ||',hhfld101 VARCHAR2(500)'
                   ||',hhattr102 VARCHAR2(32)'
                   ||',hhfld102 VARCHAR2(500)'
                   ||',hhattr103 VARCHAR2(32)'
                   ||',hhfld103 VARCHAR2(500)'
                   ||',hhattr104 VARCHAR2(32)'
                   ||',hhfld104 VARCHAR2(500)'
                   ||',hhattr105 VARCHAR2(32)'
                   ||',hhfld105 VARCHAR2(500)'
                   ||',hhattr106 VARCHAR2(32)'
                   ||',hhfld106 VARCHAR2(500)'
                   ||',hhattr107 VARCHAR2(32)'
                   ||',hhfld107 VARCHAR2(500)'
                   ||',hhattr108 VARCHAR2(32)'
                   ||',hhfld108 VARCHAR2(500)'
                   ||',hhattr109 VARCHAR2(32)'
                   ||',hhfld109 VARCHAR2(500)'
                   ||',hhattr110 VARCHAR2(32)'
                   ||',hhfld110 VARCHAR2(500)'
                   ||',hhattr111 VARCHAR2(32)'
                   ||',hhfld111 VARCHAR2(500)'
                   ||',hhattr112 VARCHAR2(32)'
                   ||',hhfld112 VARCHAR2(500)'
                   ||',hhattr113 VARCHAR2(32)'
                   ||',hhfld113 VARCHAR2(500)'
                   ||',hhattr114 VARCHAR2(32)'
                   ||',hhfld114 VARCHAR2(500)'
                   ||',hhattr115 VARCHAR2(32)'
                   ||',hhfld115 VARCHAR2(500)'
                   ||',hhattr116 VARCHAR2(32)'
                   ||',hhfld116 VARCHAR2(500)'
                   ||',hhattr117 VARCHAR2(32)'
                   ||',hhfld117 VARCHAR2(500)'
                   ||',hhattr118 VARCHAR2(32)'
                   ||',hhfld118 VARCHAR2(500)'
                   ||',hhattr119 VARCHAR2(32)'
                   ||',hhfld119 VARCHAR2(500)'
                   ||',hhattr120 VARCHAR2(32)'
                   ||',hhfld120 VARCHAR2(500))'
             ELSE
                 NULL
           END alter_table
      INTO lv_retval
      FROM dba_tables t
     WHERE owner||'.'||table_name = pi_tablename
       AND ((table_name = 'INV_TYPE_TRANSLATIONS'
             AND NOT EXISTS(SELECT 'X'
                              FROM dba_tab_cols c
                             WHERE c.table_name = t.table_name
                               AND c.owner = t.owner
                               AND c.column_name = 'ITY_HHPOS76'))
           OR(table_name = 'HHINV_LOAD_2'
              AND NOT EXISTS(SELECT 'X'
                               FROM dba_tab_cols c
                              WHERE c.table_name = t.table_name
                                AND c.owner = t.owner
                                AND c.column_name = 'HHATTR76'))
           OR(table_name = 'HHINV_ITEM_ERR_2'
              AND NOT EXISTS(SELECT 'X'
                               FROM dba_tab_cols c
                              WHERE c.table_name = t.table_name
                                AND c.owner = t.owner
                                AND c.column_name = 'HHATTR76')))
         ;
    --
    RETURN lv_retval;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        RETURN NULL;
  END get_add_statement;
  --
  FUNCTION get_xsect_statement(pi_tablename IN VARCHAR2)
    RETURN VARCHAR2 IS
    --
    lv_retval  nm3type.max_varchar2;
    --
  BEGIN
    --
    SELECT 'ALTER TABLE '||c.owner||'.'||c.table_name||' MODIFY(X_SECT VARCHAR2(4))'
      INTO lv_retval
      FROM dba_tab_cols c
     WHERE c.owner||'.'||c.table_name = pi_tablename
       AND c.column_name = 'X_SECT'
       AND c.data_length != 4
         ;
    --
    RETURN lv_retval;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        RETURN NULL;
  END get_xsect_statement;
  --
  PROCEDURE upgrade_table(pi_tablename IN VARCHAR2
                         ,pi_add       IN VARCHAR2
                         ,pi_modify    IN VARCHAR2)
    IS
    --
    lv_step      NUMBER;
    lv_temptable VARCHAR2(61);
    lv_cols      nm3type.max_varchar2;
    --
    lt_cols  nm3type.tab_varchar30;
    --
    CURSOR get_cols(cp_tablename IN VARCHAR2)
        IS
    SELECT c.column_name
      FROM dba_tab_cols c
     WHERE c.owner||'.'||c.table_name = cp_tablename
     ORDER
        BY c.column_id
         ;
    --
  BEGIN
    --
    OPEN  get_cols(pi_tablename);
    FETCH get_cols
     BULK COLLECT
     INTO lt_cols;
    CLOSE get_cols;
    --
    FOR i IN 1..lt_cols.COUNT LOOP
      --
      lv_cols := lv_cols||CASE WHEN i > 1 THEN ',' ELSE NULL END||lt_cols(i);
      --
    END LOOP;
    --
    lv_temptable := pi_tablename||'_'||TO_CHAR(SYSDATE,'DDMMRRHH24MI');
    --
    lv_step := 1;
    EXECUTE IMMEDIATE 'CREATE TABLE '||lv_temptable||' AS SELECT * FROM '||pi_tablename;
    --
    lv_step := 2;
    EXECUTE IMMEDIATE 'DELETE '||pi_tablename;
    --
    lv_step := 3;
    IF pi_add IS NOT NULL
     THEN
        EXECUTE IMMEDIATE pi_add;
    END IF;
    --
    lv_step := 4;
    IF pi_modify IS NOT NULL
     THEN
        EXECUTE IMMEDIATE pi_modify;
    END IF;
    --
    lv_step := 5;
    EXECUTE IMMEDIATE 'INSERT INTO '||pi_tablename||' ('||lv_cols||') SELECT '||lv_cols||' FROM '||lv_temptable;
    --
    lv_step := 6;
    EXECUTE IMMEDIATE 'DROP TABLE '||lv_temptable;
    --
  EXCEPTION
    WHEN others
     THEN
        IF lv_step IN(2,3)
         THEN
            ROLLBACK;
            EXECUTE IMMEDIATE 'DROP TABLE '||lv_temptable;
        END IF;
        --
        raise_application_error(-20001,'Error Occured While Upgrading Table '||pi_tablename||CHR(10)||SQLERRM);
        --
  END upgrade_table;
  --
  PROCEDURE alter_user_tables(pi_username IN VARCHAR2)
    IS
    --
    lt_tables  nm3type.tab_varchar32767;
    --
    lv_add     nm3type.max_varchar2;
    lv_modify  nm3type.max_varchar2;
    --
  BEGIN
    /*
    ||Get The Alter Table Statements That Need To Be Run For The Given User.
    */
    lt_tables(lt_tables.COUNT+1) := pi_username||'.INV_TYPE_TRANSLATIONS';
    lt_tables(lt_tables.COUNT+1) := pi_username||'.HHINV_LOAD_2';
    lt_tables(lt_tables.COUNT+1) := pi_username||'.HHINV_ITEM_ERR_2';
    lt_tables(lt_tables.COUNT+1) := pi_username||'.HHINV_LOAD_3';    
    /*
    ||Run The Statements.
    */
    FOR i IN 1..lt_tables.count LOOP
      --
      lv_add := get_add_statement(pi_tablename => lt_tables(i));
      --
      lv_modify := get_xsect_statement(pi_tablename => lt_tables(i));
      --
      IF lv_add IS NOT NULL
       OR lv_modify IS NOT NULL
       THEN
          upgrade_table(pi_tablename => lt_tables(i)
                       ,pi_add       => lv_add
                       ,pi_modify    => lv_modify);
      END IF;
      --
    END LOOP;
    --
  END alter_user_tables;
  --
BEGIN
  /*
  ||Upgrade The Highways Owners Copies Of The Tables.
  */
  alter_user_tables(pi_username => USER);
  /*
  ||Upgrade Any Other Users Copies Of The Tables.
  */
  EXECUTE IMMEDIATE 'GRANT ALTER ANY TABLE TO '||USER;
  --
  lt_users := get_users;
  --
  FOR i IN 1..lt_users.count LOOP
    --
    alter_user_tables(pi_username => lt_users(i));
    --
  END LOOP;
  --
  EXECUTE IMMEDIATE 'REVOKE ALTER ANY TABLE FROM '||USER;
  --
END;
/