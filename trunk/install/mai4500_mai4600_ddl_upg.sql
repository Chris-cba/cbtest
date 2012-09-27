------------------------------------------------------------------
-- mai4500_mai4600_ddl_upg.sql
------------------------------------------------------------------


------------------------------------------------------------------

--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/install/mai4500_mai4600_ddl_upg.sql-arc   1.0   Sep 27 2012 11:08:00   Chris.Baugh  $
--       Module Name      : $Workfile:   mai4500_mai4600_ddl_upg.sql  $
--       Date into PVCS   : $Date:   Sep 27 2012 11:08:00  $
--       Date fetched Out : $Modtime:   Sep 27 2012 10:47:52  $
--       Version          : $Revision:   1.0  $
--
------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2012

SET ECHO OFF
SET LINESIZE 120
SET HEADING OFF
SET FEEDBACK OFF
------------------------------------------------------------------


------------------------------------------------------------------
SET TERM ON
PROMPT DDL for the XSP change
SET TERM OFF

------------------------------------------------------------------
-- 
-- DEVELOPMENT COMMENTS (STEVEN COOPER)
-- DDL for the XSP change
-- 
------------------------------------------------------------------
DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Defects Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Del_Inv_Items Modify Del_Iit_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Deleted_Defects Modify Dld_Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Interface_Wol Modify Iwol_Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Inv_Mp_Errors Modify Ime_Xsp Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Inv_Tmp Modify Iit_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Mai_Insp_Load_Error_Def Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Temp_Pms4440_Roadcons Modify Const_Iit_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Temp_Replace_Defects Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

DECLARE
--   
   already_exists Exception;
   Pragma Exception_INIT( already_exists,-01430); 
-- 
BEGIN
--
   EXECUTE IMMEDIATE 'Alter Table Temp_Undo_Defect_Edit Modify Def_X_Sect Varchar2(4)';
--   
EXCEPTION
   WHEN already_exists 
   THEN
       Null;
   WHEN OTHERS
   THEN
       RAISE;
END ;
/

------------------------------------------------------------------



------------------------------------------------------------------
-- end of script 
------------------------------------------------------------------

