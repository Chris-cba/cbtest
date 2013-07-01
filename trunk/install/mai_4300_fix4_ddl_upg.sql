--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4300_fix4_ddl_upg.sql-arc   1.2   Jul 01 2013 16:01:50   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4300_fix4_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:50  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       PVCS Version     : $Revision:   1.2  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
--------------------------------------------------------------------------------
--
DECLARE
  --
  TYPE columns_rec IS RECORD(table_name  VARCHAR2(30)
                         ,column_name VARCHAR2(30)
                         ,column_id   NUMBER);
  --
  TYPE columns_tab IS TABLE OF columns_rec INDEX BY BINARY_INTEGER;
  --
  lt_columns columns_tab;
  --
  PROCEDURE add(pi_table_name IN VARCHAR2
               ,pi_column_name IN VARCHAR2
               ,pi_column_id   IN NUMBER)
    IS
    --
  BEGIN
    --
    lt_columns(lt_columns.COUNT+1).table_name := pi_table_name;
    lt_columns(lt_columns.COUNT).column_name := pi_column_name;
    lt_columns(lt_columns.COUNT).column_id := pi_column_id;         
    --
  END add;
  --
  FUNCTION column_ok(pi_column columns_rec)
    RETURN BOOLEAN IS
    --
    CURSOR c1
        IS
    SELECT 'x'
      FROM user_tab_cols
     WHERE table_name = pi_column.table_name
       AND column_name = pi_column.column_name
       AND column_id = pi_column.column_id
         ;
    --
    l_dummy VARCHAR2(1) := Null;
    --
  BEGIN
    --
    OPEN  c1;
    FETCH c1
     INTO l_dummy;
    CLOSE c1;
    --
    IF l_dummy IS NULL
     THEN
        RETURN(FALSE);
    ELSE
        RETURN(TRUE);
    END IF;
    --
  END column_ok;
  --
BEGIN
  /*
  ||Set the column order to check.
  */
  add('DEF_TYPES','DTY_ATV_ACTY_AREA_CODE','1');
  add('DEF_TYPES','DTY_DEFECT_CODE'       ,'2');
  add('DEF_TYPES','DTY_DTP_FLAG'          ,'3');
  add('DEF_TYPES','DTY_DESCR1'            ,'4');
  add('DEF_TYPES','DTY_DESCR2'            ,'5');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_1'    ,'6');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_2'    ,'7');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_3'    ,'8');
  add('DEF_TYPES','DTY_HH_ATTRIBUTE_4'    ,'9');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_1'   ,'10');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_2'   ,'11');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_3'   ,'12');
  add('DEF_TYPES','DTY_HH_ATTRI_TEXT_4'   ,'13');
  add('DEF_TYPES','DTY_START_DATE'        ,'14');
  add('DEF_TYPES','DTY_END_DATE'          ,'15');
  /*
  ||Check the columns.
  */
  FOR i IN 1..lt_columns.COUNT LOOP
    IF NOT column_ok(lt_columns(i))
     THEN
        /*
        ||Column order is not valid so rebuild the table.
        */
        DECLARE
          --
          already_exists EXCEPTION;
          PRAGMA Exception_INIT( already_exists,-01430);
          index_not_found EXCEPTION;
          PRAGMA EXCEPTION_INIT(index_not_found,-01418);
          lv_backup_tab VARCHAR2(100) := 'DEF_TYPES_'||TO_CHAR(SYSDATE,'JSSSSS');
          -- 
        BEGIN
          /*
          ||Make backup copy of original table.
          */
          EXECUTE IMMEDIATE 'ALTER TABLE DEF_TYPES RENAME TO '||lv_backup_tab; 
          /*
          ||Create the table with the correct column order.
          */
          EXECUTE IMMEDIATE 'CREATE TABLE def_types'
                          ||' (dty_atv_acty_area_code VARCHAR2(2) NOT NULL'
                          ||' ,dty_defect_code        VARCHAR2(4) NOT NULL'
                          ||' ,dty_dtp_flag           VARCHAR2(1) NOT NULL'
                          ||' ,dty_descr1             VARCHAR2(40)'
                          ||' ,dty_descr2             VARCHAR2(40)'
                          ||' ,dty_hh_attribute_1     VARCHAR2(32)'
                          ||' ,dty_hh_attribute_2     VARCHAR2(32)'
                          ||' ,dty_hh_attribute_3     VARCHAR2(32)'
                          ||' ,dty_hh_attribute_4     VARCHAR2(32)'
                          ||' ,dty_hh_attri_text_1    VARCHAR2(12)'
                          ||' ,dty_hh_attri_text_2    VARCHAR2(12)'
                          ||' ,dty_hh_attri_text_3    VARCHAR2(12)'
                          ||' ,dty_hh_attri_text_4    VARCHAR2(12)'
                          ||' ,dty_start_date         DATE'
                          ||' ,dty_end_date           DATE)';
          /*
          ||Populate the rebuilt table.
          */
          EXECUTE IMMEDIATE 'INSERT INTO def_types'
                          ||' (dty_atv_acty_area_code'
                          ||' ,dty_defect_code'
                          ||' ,dty_dtp_flag'
                          ||' ,dty_descr1'
                          ||' ,dty_descr2'
                          ||' ,dty_hh_attribute_1'
                          ||' ,dty_hh_attribute_2'
                          ||' ,dty_hh_attribute_3'
                          ||' ,dty_hh_attribute_4'
                          ||' ,dty_hh_attri_text_1'
                          ||' ,dty_hh_attri_text_2'
                          ||' ,dty_hh_attri_text_3'
                          ||' ,dty_hh_attri_text_4'
                          ||' ,dty_start_date'
                          ||' ,dty_end_date) '
                          ||'SELECT dty_atv_acty_area_code'
                          ||' ,dty_defect_code'
                          ||' ,dty_dtp_flag'
                          ||' ,dty_descr1'
                          ||' ,dty_descr2'
                          ||' ,dty_hh_attribute_1'
                          ||' ,dty_hh_attribute_2'
                          ||' ,dty_hh_attribute_3'
                          ||' ,dty_hh_attribute_4'
                          ||' ,dty_hh_attri_text_1'
                          ||' ,dty_hh_attri_text_2'
                          ||' ,dty_hh_attri_text_3'
                          ||' ,dty_hh_attri_text_4'
                          ||' ,dty_start_date'
                          ||' ,dty_end_date'
                          ||' FROM '||lv_backup_tab;
          --
          COMMIT;
          /*
          ||Rebuild the index.
          */
          EXECUTE IMMEDIATE 'DROP INDEX dty_index_p1';
          --
          EXECUTE IMMEDIATE 'CREATE UNIQUE INDEX dty_index_p1 ON def_types(dty_defect_code, dty_atv_acty_area_code, dty_dtp_flag)';
          /*
          ||Analyse the table.
          */
          EXECUTE IMMEDIATE 'ANALYZE TABLE def_types COMPUTE STATISTICS';
          --
        EXCEPTION
          WHEN already_exists 
           THEN
              NULL;
          WHEN index_not_found
           THEN
              NULL;
          WHEN OTHERS
           THEN
              RAISE;
        END;
        /*
        ||Table has been rebuilt so exit the loop.
        */
        EXIT;
        --
    END IF; 
  END LOOP;
  --
END; 
/
