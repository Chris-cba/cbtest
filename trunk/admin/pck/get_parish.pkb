CREATE OR REPLACE FUNCTION F$get_Parish ( parcode IN HIG_CODES.hco_code%TYPE)
RETURN VARCHAR IS
/******************************************************************************
   NAME:       f$get_parish
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        30/06/2004          1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     f$get_parish
      Sysdate:         30/06/2004
      Date and Time:   30/06/2004, 16:58:20, and 30/06/2004 16:58:20
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/get_parish.pkb-arc   2.0   Jun 13 2007 17:36:48   smarshall  $
--       Module Name      : $Workfile:   get_parish.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:48  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.2
--
******************************************************************************/

  CURSOR c1( parcode IN NM_INV_ATTRI_LOOKUP_ALL.ial_value%TYPE)
  IS SELECT ial_meaning 
     FROM   NM_INV_ATTRI_LOOKUP_ALL
	 WHERE  ial_domain='SUB_PARISH'
	 AND    ial_value = parcode;

  parname NM_INV_ATTRI_LOOKUP_ALL.ial_meaning%TYPE;

BEGIN
   OPEN c1(parcode);
   FETCH c1 INTO parname;
   IF c1%NOTFOUND
   THEN CLOSE c1;
   ELSE CLOSE c1;
   END IF;

   RETURN parname;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       NULL;
END F$get_Parish;
/
