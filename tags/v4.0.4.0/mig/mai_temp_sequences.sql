REM Copyright (c) Exor Corporation Ltd, 2004
REM SCCS_ID Do not remove
REM '$Header:   //vm_latest/archives/mai/mig/mai_temp_sequences.sql-arc   2.0   Jun 13 2007 16:46:24   smarshall  $'

----------------
-- MAI SEQUENCES
----------------
set lines 1000
set pages 100

spool mai_temp_sequences.log

Prompt
Prompt Creating Table mai_temp_sequences
Prompt =================================

create table mai_temp_sequences
as select * from user_sequences
WHERE SEQUENCE_NAME IN (
                        'ARE_BATCH_ID_SEQ'
                       ,'ARE_REPORT_ID_SEQ'
                       ,'BOQ_ID_SEQ'
                       ,'BUD_ID_SEQ'
                       ,'CNP_ID_SEQ'
                       ,'CON_ID_SEQ'
                       ,'DEF_DEFECT_ID_SEQ'
                       ,'EXT_ID_SEQ'
                       ,'FILE_ID_SEQ'
                       ,'ICB_ID_SEQ'
                       ,'IH_ID_SEQ'
                       ,'INSURANCE_CLAIM_ID'
                       ,'IWOR_ID_SEQ'
                       ,'NEXT_SEQ'
                       ,'NOT_ID_SEQ'
                       ,'OUN_ORG_ID_SEQ'
                       ,'PBI_ID'
                       ,'PBR_ID'
                       ,'PEO_PERSON_ID_SEQ'
                       ,'SCHD_ID_SEQ'
                       ,'SCHEME_ID_SEQ'
                       ,'SCH_RD_SEQ'
                       ,'TMO_ID_SEQ'
                       ,'WOC_REF_SEQ'
                       ,'WOL_CHECK_ID_SEQ'
                       ,'WOL_ID_SEQ');

Prompt Table Contents
Prompt ==============

select sequence_name
      ,last_number 
from mai_temp_sequences;

spool off

Prompt Done: Please check mai_temp_sequences.log





