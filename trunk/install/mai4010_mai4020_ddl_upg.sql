------------------------------------------------------------------
-- mai4010_mai4020_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4010_mai4020_ddl_upg.sql-arc   2.2   Oct 26 2007 11:53:50   jwadsworth  $
--       Module Name      : $Workfile:   mai4010_mai4020_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Oct 26 2007 11:53:50  $
--       Date fetched Out : $Modtime:   Oct 26 2007 11:27:40  $
--       Version          : $Revision:   2.2  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2007
------------------------------------------------------------------


------------------------------------------------------------------

------------------------------------------------------------------
SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Run in MAI 4010 DDL changes if required
SET TERM OFF

-- JWA  24-OCT-2007
-- 
-- DEVELOPMENT COMMENTS
-- Check to see if 4010 patch needs to be implemented
------------------------------------------------------------------
SET TERM OFF
SET DEFINE ON
SELECT '&exor_base'||'mai'||'&terminator'||'install'||
        '&terminator'||'mai40_mai4010_ddl_upg.sql' run_file
FROM dual
WHERE '&run_4010' = 'Y'
UNION
select '&exor_base'||'nm3'||'&terminator'||'install'||
        '&terminator'||'dummy' run_file
FROM dual
WHERE '&run_4010' = 'N'
/
SET FEEDBACK ON
start &&run_file
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Set variable that drives whether 4.0.1.0 upgrade components  are to be ran in
SET TERM OFF

-- JWA  24-OCT-2007
-- 
-- DEVELOPMENT COMMENTS
-- Adding 4010 DDL changes id needed
------------------------------------------------------------------
--
-- see if patch 4010 has been implemented
-- this info is used to determine whether the 4010 metadata and ddl changes
-- need to be ran in during the 40 to 4100 upgrade
--
undefine run_4010
col         run_4010 new_value run_4010 noprint
set term off

SELECT 'N' run_4010
FROM dual
WHERE EXISTS (select 'upgrade ran'
              from   hig_upgrades
              where  hup_product = 'MAI'
              and    from_version = '4.0'
              and    to_version = '4.0.1.0')
UNION
SELECT 'Y' run_4010
FROM dual
WHERE NOT EXISTS (select 'upgrade ran'
                  from   hig_upgrades
                  where  hup_product = 'MAI'
                  and    from_version = '4.0'
                  and    to_version = '4.0.1.0')		  
/
set term on
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT alter table BUDGETS
SET TERM OFF

-- SSC  25-OCT-2007
-- 
-- DEVELOPMENT COMMENTS
-- Difference between Install and Upgrade scripts picked up during build.
-- On install the BUD_RSE_HE_ID column on the BUDGETS table accepts a null value, this was not the case i fyou upgraded.  This fix should solve this problem and ensure the tables match on install and upgrade.
------------------------------------------------------------------
alter table BUDGETS modify BUD_RSE_HE_ID null;
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT Rebuild WOR_PK
SET TERM OFF

-- AE  26-OCT-2007
-- 
-- DEVELOPMENT COMMENTS
-- Rebuild WOR_PK as a Primary key instead of Unique key
------------------------------------------------------------------
alter table work_orders drop constraint wor_pk;

alter table work_orders add constraint WOR_PK primary key (wor_works_order_no) ENABLE;
------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

