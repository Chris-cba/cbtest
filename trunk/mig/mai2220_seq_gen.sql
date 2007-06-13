-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/mig/mai2220_seq_gen.sql-arc   2.0   Jun 13 2007 16:46:24   smarshall  $
--       Module Name      : $Workfile:   mai2220_seq_gen.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:46:24  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:45:44  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
-- This file should be run on the V2 schema to obtain current sequence values
-- It is then required that you run the resultant script, mai2220_create_sequences.sql
-- on the new V3 schema once you have imported the MAI tables.
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
set pagesize 10000 linesize 150 term off feed off head off echo off

spool mai2220_create_sequences.sql

SELECT 'CREATE SEQUENCE '||sequence_name||' INCREMENT BY '||TO_CHAR(INCREMENT_BY)||' MINVALUE '||TO_CHAR(MIN_VALUE)||' MAXVALUE '||TO_CHAR(MAX_VALUE)||DECODE(CYCLE_FLAG,'Y',' CYCLE',' NOCYCLE')||DECODE(CACHE_SIZE,0,' NOCACHE',' CACHE '||TO_CHAR(CACHE_SIZE))||' START WITH '||TO_CHAR(LAST_NUMBER)||';'
from dba_sequences
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
,'NEG_BOQ_ID_SEQ'
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
,'WOL_ID_SEQ')
AND SEQUENCE_OWNER=USER;

spool off
set pagesize 30 linesize 80 term on feed on head on 

Prompt Completed
Prompt Created sql script MAI2220_CREATE_SEQUENCES.SQL
Prompt

