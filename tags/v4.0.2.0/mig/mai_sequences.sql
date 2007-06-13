REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/mig/mai_sequences.sql-arc   2.0   Jun 13 2007 16:46:24   smarshall  $

set echo off
set linesize 120
set heading off
set feedback off

DECLARE

   TYPE tab_varchar2 IS TABLE OF VARCHAR2(5000) INDEX BY BINARY_INTEGER;
   l_tab_seq tab_varchar2;
   l_tab_sql tab_varchar2;

BEGIN

  SELECT UPPER(sequence_name)
        ,'CREATE SEQUENCE '||sequence_name||' INCREMENT BY '||TO_CHAR(INCREMENT_BY)||' MINVALUE '||TO_CHAR(MIN_VALUE)||' MAXVALUE '||TO_CHAR(MAX_VALUE)||DECODE(CYCLE_FLAG,'Y',' CYCLE',' NOCYCLE')||DECODE(CACHE_SIZE,0,' NOCACHE',' CACHE '||TO_CHAR(CACHE_SIZE))||' START WITH '||TO_CHAR(LAST_NUMBER)
  BULK COLLECT INTO  l_tab_seq
                    ,l_tab_sql
  FROM mai_temp_sequences
  ORDER BY 1;

  FOR i IN 1..l_tab_sql.COUNT LOOP

    dbms_output.put_line('Processing '||l_tab_seq(i));

    BEGIN
      execute immediate (l_tab_sql(i));
      dbms_output.put_line('Done');
    EXCEPTION
      WHEN others THEN
        dbms_output.put_line(sqlerrm);
    END;
    
  END LOOP;

END;  
/

