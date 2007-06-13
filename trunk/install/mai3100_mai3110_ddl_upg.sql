REM Copyright (c) Exor Corporation Ltd, 2004
REM @(#)$Header:   //vm_latest/archives/mai/install/mai3100_mai3110_ddl_upg.sql-arc   2.0   Jun 13 2007 16:32:34   smarshall  $

set echo off
set linesize 120
set heading off
set feedback off
--
---------------------------------------------------------------------------------------------------
--

--
------------------------------------
-- START OF GMIS CHANGES
------------------------------------
--

CREATE TABLE MAI_GMIS_LOAD_BATCHES (
GLB_LOAD_BATCH	  number(9)    NOT NULL,
GLB_LINE_NUMBER   number(8),
GLB_LOAD_FILE	  clob,
GLB_LOAD_ERRORS   varchar2(1)  DEFAULT 'Y',
GLB_DATE_CREATED  date,
GLB_DATE_MODIFIED date,
GLB_CREATED_BY    varchar2(30),
GLB_MODIFIED_BY   varchar2(30),
GLB_ERROR_TEXT	  varchar2(200),
GLB_ERROR_DATA	  varchar2(500)
);

ALTER TABLE MAI_GMIS_LOAD_BATCHES ADD (CONSTRAINT glb_pk PRIMARY KEY (glb_load_batch));

ALTER TABLE MAI_GMIS_LOAD_BATCHES ADD (CONSTRAINT glb_load_err_chk1 CHECK (glb_load_errors IN ('Y', 'N')));

COMMENT ON TABLE MAI_GMIS_LOAD_BATCHES IS 'Contains details of GMIS load files processed by the gmis inspection loader';

COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LOAD_BATCH IS 'The load batch number. This will match the load batch number on the inspection';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LINE_NUMBER IS 'The line number of the first error';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LOAD_FILE IS 'The load file itself';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LOAD_ERRORS IS 'A flag to signify if there are load errors';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_ERROR_TEXT IS 'The error message returned by the loader';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_ERROR_DATA IS 'The line processed by the loader when the error was encountered';

--
------------------------------------
-- END OF GMIS CHANGES
------------------------------------
--

--
----------------------------------------
-- START OF CHANGES FOR GANG MAINTENANCE
----------------------------------------
--
ALTER TABLE WORK_ORDER_LINES
ADD (WOL_GANG number)
/

ALTER TABLE STANDARD_ITEMS
ADD (STA_GANG_WORK_TYPE VARCHAR2(4))
/
--
----------------------------------------
-- END OF CHANGES FOR GANG MAINTENANCE
----------------------------------------
--


--
----------------------------------------
-- START OF INV LOCATION CHANGES
----------------------------------------
--
SET TERM ON
Prompt Inv Location upgrade
SET TERM OFF
set define on
select '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai_inv_locations' run_file
from dual
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
--
----------------------------------------
-- END OF INV LOCATION CHANGES
----------------------------------------
--
