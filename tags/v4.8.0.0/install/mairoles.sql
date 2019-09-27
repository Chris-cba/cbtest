-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/mairoles.sql-arc   2.4   Sep 27 2019 15:56:18   Chris.Baugh  $
--       Module Name      : $Workfile:   mairoles.sql  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:56:18  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:54:54  $
--       PVCS Version     : $Revision:   2.4  $
--       based on SCCS Version     : 1.2
--
------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
--   Originally taken from  '@(#)mairoles.sql	1.7 09/28/00';
--   STP roles are now PMS roles, and have been moved to PMS upgrade scripts
-----------------------------------------------------------------------------

rem --------------------------------------------------------------------------
rem	Create a role for granting to the maintenance manager administrator.

set feedback off

PROMPT CREATE ROLE MAI_ADMIN;

DECLARE
  role_exists Exception;
  Pragma Exception_Init(role_exists, -1921); 
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE MAI_ADMIN';
  NULL;
EXCEPTION
WHEN role_exists
THEN 
  Null;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'grant mai_admin to '||USER;
   EXECUTE IMMEDIATE 'grant mai_admin to '||USER||' with admin option';
END;
/

GRANT SELECT ANY TABLE TO MAI_ADMIN;
GRANT INSERT ANY TABLE TO MAI_ADMIN;
GRANT UPDATE ANY TABLE TO MAI_ADMIN;
GRANT DELETE ANY TABLE TO MAI_ADMIN;
GRANT LOCK ANY TABLE TO MAI_ADMIN;
GRANT CREATE ANY TABLE TO MAI_ADMIN;
GRANT CREATE ANY VIEW TO MAI_ADMIN;
GRANT EXECUTE ANY PROCEDURE TO MAI_ADMIN;
GRANT SELECT ANY SEQUENCE TO MAI_ADMIN;
GRANT CREATE SESSION TO MAI_ADMIN;

GRANT ALTER SESSION TO MAI_ADMIN;
GRANT CREATE PUBLIC SYNONYM TO MAI_ADMIN;
GRANT CREATE TRIGGER TO MAI_ADMIN;
GRANT CREATE SEQUENCE TO MAI_ADMIN;
GRANT CREATE ROLE TO MAI_ADMIN;
GRANT CREATE SYNONYM TO MAI_ADMIN;
GRANT CREATE PROCEDURE TO MAI_ADMIN;
GRANT CREATE USER TO MAI_ADMIN;
GRANT GRANT ANY PRIVILEGE TO MAI_ADMIN;
GRANT GRANT ANY ROLE TO MAI_ADMIN;
GRANT DROP PUBLIC SYNONYM TO MAI_ADMIN;
GRANT DROP USER TO MAI_ADMIN;
GRANT ALTER USER TO MAI_ADMIN;


rem --------------------------------------------------------------------------
rem	Create a role for granting to users who need update privileges.

PROMPT CREATE ROLE MAI_USER;

DECLARE
  role_exists Exception;
  Pragma Exception_Init(role_exists, -1921); 
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE MAI_USER';
  NULL;
EXCEPTION
WHEN role_exists
THEN 
  Null;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'grant mai_user to '||USER;
   EXECUTE IMMEDIATE 'grant mai_user to '||USER||' with admin option';
END;
/

GRANT SELECT ANY TABLE TO MAI_USER;
GRANT INSERT ANY TABLE TO MAI_USER;
GRANT UPDATE ANY TABLE TO MAI_USER;
GRANT DELETE ANY TABLE TO MAI_USER;
GRANT LOCK ANY TABLE TO MAI_USER;
GRANT CREATE TABLE TO MAI_USER;
GRANT CREATE VIEW  TO MAI_USER;
GRANT SELECT ANY SEQUENCE TO MAI_USER;
GRANT EXECUTE ANY PROCEDURE TO MAI_USER;
GRANT CREATE SESSION TO MAI_USER;


rem --------------------------------------------------------------------------
rem	Create a role for granting to readonly users.

PROMPT CREATE ROLE MAI_READONLY;

DECLARE
  role_exists Exception;
  Pragma Exception_Init(role_exists, -1921); 
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE MAI_READONLY';
  NULL;
EXCEPTION
WHEN role_exists
THEN 
  Null;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'grant mai_readonly to '||USER;
   EXECUTE IMMEDIATE 'grant mai_readonly to '||USER||' with admin option';
END;
/

GRANT SELECT ANY TABLE TO MAI_READONLY;
GRANT LOCK ANY TABLE TO MAI_READONLY;
GRANT CREATE TABLE TO MAI_READONLY;
GRANT CREATE VIEW  TO MAI_READONLY;
GRANT SELECT ANY SEQUENCE TO MAI_READONLY;
GRANT EXECUTE ANY PROCEDURE TO MAI_READONLY;
GRANT CREATE SESSION TO MAI_READONLY;

GRANT INSERT,UPDATE,DELETE ON BPR34A_TT TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON BPR34B_TT TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON BPR35A_TT TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON BPR35B_TT TO MAI_READONLY;
GRANT        UPDATE        ON CONTRACTS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON INSURANCE_CLAIM_ACTIVITIES TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON INSURANCE_CLAIM_PARAMETERS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON NOTICES TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON NOTICE_DEFECTS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON PBI_QUERY TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON PBI_QUERY_ATTRIBS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON PBI_QUERY_TYPES TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON PBI_RESULTS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_CONTRACTS_LOCK TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_COMMENTS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_COMPSCHEMES TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_DEFBANDS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_DEFECTS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_DEFECT_LIST TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_DETTRTS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_REPORT_SECTIONS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_ROADCONS TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_STRIP_DATA TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_STRIP_HEADER TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TEMP_PMS4440_STRIP_LIST TO MAI_READONLY;
GRANT INSERT,UPDATE,DELETE ON TMP_BPR2140 TO MAI_READONLY;
GRANT        UPDATE        ON WORK_ORDERS TO MAI_READONLY;
GRANT        UPDATE        ON WORK_ORDER_LINES TO MAI_READONLY;


rem --------------------------------------------------------------------------
rem     Create a role for granting to a MAI user allowed to go over budget.

PROMPT CREATE ROLE OVER_BUDGET

DECLARE
  role_exists Exception;
  Pragma Exception_Init(role_exists, -1921); 
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE OVER_BUDGET';
  NULL;
EXCEPTION
WHEN role_exists
THEN 
  Null;
END;
/

rem --------------------------------------------------------------------------
rem	Create a role for granting to the structural projects administrator.

PROMPT CREATE ROLE PMS_ADMIN;

DECLARE
  role_exists Exception;
  Pragma Exception_Init(role_exists, -1921); 
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE pms_ADMIN';
  NULL;
EXCEPTION
WHEN role_exists
THEN 
  Null;
END;
/

grant select any table to pms_admin;
grant insert any table to pms_admin;
grant update any table to pms_admin;
grant delete any table to pms_admin;
grant lock any table to pms_admin;
grant create any table to pms_admin;
grant create any view to pms_admin;
grant execute any procedure to pms_admin;
grant select any sequence to pms_admin;
grant create session to pms_admin;


rem --------------------------------------------------------------------------
rem	Create a role for granting to users who need update privileges.

PROMPT CREATE ROLE PMS_USER;

DECLARE
  role_exists Exception;
  Pragma Exception_Init(role_exists, -1921); 
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE PMS_USER';
  NULL;
EXCEPTION
WHEN role_exists
THEN 
  Null;
END;
/

grant select any table to pms_user;
grant insert any table to pms_user;
grant update any table to pms_user;
grant delete any table to pms_user;
grant lock any table to pms_user;
grant create table to pms_user;
grant create view  to pms_user;
grant select any sequence to pms_user;
grant execute any procedure to pms_user;
grant create session to pms_user;


rem --------------------------------------------------------------------------
rem	Create a role for granting to readonly users.

PROMPT CREATE ROLE PMS_READONLY;

DECLARE
  role_exists Exception;
  Pragma Exception_Init(role_exists, -1921); 
BEGIN
  EXECUTE IMMEDIATE 'CREATE ROLE PMS_READONLY';
  NULL;
EXCEPTION
WHEN role_exists
THEN 
  Null;
END;
/

grant select any table to pms_readonly;
grant lock any table to pms_readonly;
grant create table to pms_readonly;
grant create view  to pms_readonly;
grant select any sequence to pms_readonly;
grant execute any procedure to pms_readonly;
grant create session to pms_readonly;

grant insert,update,delete on pbi_query to pms_readonly;
grant insert,update,delete on pbi_query_attribs to pms_readonly;
grant insert,update,delete on pbi_query_types to pms_readonly;
grant insert,update,delete on pbi_results to pms_readonly;
grant insert,update,delete on temp_pms4440_comments to pms_readonly;
grant insert,update,delete on temp_pms4440_compschemes to pms_readonly;
grant insert,update,delete on temp_pms4440_defbands to pms_readonly;
grant insert,update,delete on temp_pms4440_defects to pms_readonly;
grant insert,update,delete on temp_pms4440_defect_list to pms_readonly;
grant insert,update,delete on temp_pms4440_dettrts to pms_readonly;
grant insert,update,delete on temp_pms4440_report_sections to pms_readonly;
grant insert,update,delete on temp_pms4440_roadcons to pms_readonly;
grant insert,update,delete on temp_pms4440_strip_data to pms_readonly;
grant insert,update,delete on temp_pms4440_strip_header to pms_readonly;
grant insert,update,delete on temp_pms4440_strip_list to pms_readonly;
rem --------------------------------------------------------------------------

rem ---------------------------------------------------------------------------
rem These roles can now be assigned to Oracle users.

REM End of command file
REM
