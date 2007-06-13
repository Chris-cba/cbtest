CREATE OR REPLACE PACKAGE BODY PMSLAYER AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/pmslayer.pkb-arc   2.0   Jun 13 2007 17:36:52   smarshall  $
--       Module Name      : $Workfile:   pmslayer.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:52  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based onSCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)pmslayer.pck	1.1 10/02/97'
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------

	FUNCTION ChainageStart(HE_ID IN INV_ITEMS_ALL.IIT_RSE_HE_ID%TYPE,
				   XSP IN INV_ITEMS_ALL.IIT_X_SECT%TYPE) RETURN NUMBER IS
		intMinChainage	NUMBER;
	BEGIN

		SELECT MIN(IIT_ST_CHAIN)
		INTO intMinChainage
		FROM INV_ITEMS_ALL
		WHERE IIT_ITY_INV_CODE = 'RC'
		AND   IIT_END_DATE IS NULL
		AND IIT_RSE_HE_ID = HE_ID
		AND IIT_X_SECT = XSP;

		RETURN intMinChainage;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN 0;
	END ChainageStart;

	FUNCTION MaxChainageLength(HE_ID IN INV_ITEMS_ALL.IIT_RSE_HE_ID%TYPE,
				   XSP IN INV_ITEMS_ALL.IIT_X_SECT%TYPE) RETURN NUMBER IS
		intMaxChainage	NUMBER;
	BEGIN

		SELECT MAX(IIT_END_CHAIN)-MIN(IIT_ST_CHAIN)
		INTO intMaxChainage
		FROM INV_ITEMS_ALL
		WHERE IIT_ITY_INV_CODE = 'RC'
		AND   IIT_END_DATE IS NULL
		AND IIT_RSE_HE_ID = HE_ID
		AND IIT_X_SECT = XSP;

		RETURN intMaxChainage;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN 0;
	END MaxChainageLength;


	FUNCTION MaxXSPDepth(HE_ID IN INV_ITEMS_ALL.IIT_RSE_HE_ID%TYPE,
			     XSP IN INV_ITEMS_ALL.IIT_X_SECT%TYPE) RETURN NUMBER IS
		intMaxDepth	NUMBER;
	BEGIN

		SELECT max(SUM(IIT_LENGTH))
		INTO intMaxDepth
		FROM INV_ITEMS_ALL
		WHERE IIT_ITY_INV_CODE = 'RC'
		AND   IIT_END_DATE IS NULL
		AND IIT_RSE_HE_ID = HE_ID
		AND IIT_X_SECT = XSP
		GROUP BY IIT_ST_CHAIN,IIT_END_CHAIN;

		RETURN intMaxDepth;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN 0;
	END MaxXSPDepth;

END PMSLAYER;
/
