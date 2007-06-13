rem REPORT : Title
rem
rem AUTHOR : J.Taper
rem VERSION : 1
rem DATE : 30th March 1988
rem DESCRIPTION : Sets up all default column definitions for RMMS 
rem               system reports also default titles. 132 character reports.
rem
rem
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/set131.sql-arc   2.0   Jun 13 2007 16:32:40   smarshall  $
--       Module Name      : $Workfile:   set131.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:40  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:52  $
--       SCCS Version     : $Revision:   2.0  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
set verify off;
set echo off;
set termout on;
set document on;
set heading on;
set sqlprompt 'Type exit to continue  ....';
rem to set pause delete rem statements.
rem set pause 'Press return to continue';
rem set pause on;
rem
rem set up pagesize, linesize, newpage
rem
set pagesize 60;
set linesize 131;
set newpage  1;
rem
rem set up title date
rem
set feedback off;
column sql.pno format 999
column sysdate new_value tdate noprint
select sysdate
from dual;
rem
rem invoke 132 command 
rem
set feedback on;
rem
rem  set up a variable containing a 79 character line for use in titles etc.
rem
define scrlin = -
'-------------------------------------------------------------------------------';
rem
rem set up a default top title.
rem
ttitle  left 'RMMS' center 'Report for RMMS System'-
        right 'Page ' format 999 sql.pno -
        skip left tdate center 'Default Title' skip-
        left &&scrlin-
skip skip;
rem
rem set up a default bottom title.
rem
btitle left &&scrlin;
ttitle off;
btitle off;
