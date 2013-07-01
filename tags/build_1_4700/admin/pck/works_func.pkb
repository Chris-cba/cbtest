CREATE OR REPLACE Package Body WWO AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/works_func.pkb-arc   2.5   Jul 01 2013 16:26:56   James.Wadsworth  $
--       Module Name      : $Workfile:   works_func.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:26:56  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:46  $
--       SCCS Version     : $Revision:   2.5  $
--       Based on     : 1.2
--
-----------------------------------------------------------------------------
--   Originally taken from @(#)works_func.pck	1.17 12/10/02
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
function strGetErrorMsg(strMessage IN VARCHAR2) RETURN VARCHAR2 is
	strReturn VARCHAR2(255);
Begin
	strReturn := 'Error in :'||MC_MODULE||' - '||strMessage;

	RETURN strReturn;
End;
------------------------------------
------
------------------------------------

Procedure Update_Last_Printed(WorkOrderNo IN VARCHAR2) is

	strErrorMsg VARCHAR2(255) := SQLERRM;

	Cursor Lock_Order is
		SELECT WOR_LAST_PRINT_DATE
			FROM WORK_ORDERS
			WHERE WOR_WORKS_ORDER_NO = WorkOrderNo
			FOR UPDATE NOWAIT;

	datDummy DATE;

	Locked EXCEPTION;
	PRAGMA EXCEPTION_INIT(Locked,-00054);

Begin

	MC_MODULE := 'WWO.Update_Last_Printed';

	---Just test this order to see if we can update it and it exists !
	Open Lock_Order;
	Fetch Lock_Order into datDummy;
	if Lock_Order%NOTFOUND THEN
		RAISE NO_DATA_FOUND;
	end if;
	Close Lock_Order;

	Update Work_Orders Set wor_last_print_date = sysdate
		Where wor_works_order_no = WorkOrderNo;


	Commit;

	MC_MODULE := NULL;

Exception
	WHEN Locked THEN
		if Lock_Order%IsOpen then
			Close Lock_Order;
		end if;
		raise_application_error(-20001,strGetErrorMsg('Work Order is Locked by another user!'));

	WHEN NO_DATA_FOUND THEN
		if Lock_Order%IsOpen then
			Close Lock_Order;
		end if;
		raise_application_error(-20001,strGetErrorMsg('Invalid Work Order No !'));
	WHEN OTHERS THEN
		if Lock_Order%IsOpen then
			Close Lock_Order;
		end if;
		raise_application_error(-20001,strGetErrorMsg(strErrorMsg));

End;

------------------------------------
------
------------------------------------
function strFormatCost(costin IN NUMBER) return VARCHAR2 is
begin
	return to_char(costin,ORA_COST_FORMAT);
end;
------------------------------------
------
------------------------------------
function Get_Work_Order(WorkOrderNo IN VARCHAR2) return VARCHAR2 is
	strReturn VARCHAR2(100);
begin
	strReturn := WorkOrderNo;
	return strReturn;
end;
------------------------------------
------
------------------------------------
function Get_Std_Text return VARCHAR2 is
	strReturn VARCHAR2(100);

  cursor c_sys_opt is
     select hop_value
     from hig_options
     where hop_id = 'WORSTDTXT';

  begin

	open c_sys_opt;
	fetch c_sys_opt into strReturn;
	close c_sys_opt;

	return strReturn;
end;
------------------------------------
------
------------------------------------
function Get_Network_Ind(WorkOrderNo IN VARCHAR2) return VARCHAR2 IS
	Cursor c1 is
		SELECT WOR_SYS_FLAG
		FROM WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo;

	strReturn VARCHAR2(10);
begin
	Open C1;
	Fetch c1 into strReturn;
	Close c1;

	return strReturn;
end;
------------------------------------
------
------------------------------------
function Get_Work_Order_Line
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor Wol is
		SELECT WOL_ID||ORA_TAB||WOL_FLAG||ORA_TAB||WOL_CHECK_COMMENTS||ORA_TAB||WOL_RATE WORKLINE
		FROM WORK_ORDER_LINES
		WHERE WOL_WORKS_ORDER_NO = WorkOrderNo;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in Wol LOOP
		if intRecordCount = intLineNo then
			strLine := recs.WORKLINE;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;

------------------------------------
------
------------------------------------
function Get_Order_Total(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	costReturn NUMBER(11,2);
	---If the order is not complete yet then use estimates
	Cursor cost is
		SELECT decode(WOR_DATE_CLOSED,NULL,(WOR_EST_COST + WOR_EST_BALANCING_SUM),(WOR_ACT_COST + WOR_ACT_BALANCING_SUM))
		FROM WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo;
begin

	Open Cost;
	Fetch Cost into costReturn;
	Close Cost;

	Return strFormatCost(costReturn);

end get_order_total;
------------------------------------
------
------------------------------------
function Get_Order_Sub_Total(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	costReturn NUMBER(11,2);
	---If the order is not complete yet then use estimates
	Cursor cost is
		SELECT decode(WOR_DATE_CLOSED,NULL,WOR_EST_COST,WOR_ACT_COST)
		FROM WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo;
begin

	Open Cost;
	Fetch Cost into costReturn;
	Close Cost;

	Return strFormatCost(costReturn);

end get_order_sub_total;
------------------------------------
------
------------------------------------
function Get_Order_Bal_Sum(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	costReturn NUMBER(11,2);
	---If the order is not complete yet then use estimates
	Cursor cost is
		SELECT decode(WOR_DATE_CLOSED,NULL,WOR_EST_BALANCING_SUM,WOR_ACT_BALANCING_SUM)
		FROM WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo;
begin

	Open Cost;
	Fetch Cost into costReturn;
	Close Cost;

	Return strFormatCost(costReturn);

end get_order_bal_sum;
------------------------------------
------
------------------------------------
function Get_Contract(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	Cursor c1 is
		SELECT CON_NAME
		FROM CONTRACTS,WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo
		AND WOR_CON_ID = CON_ID;

	strReturn VARCHAR2(40);
begin

	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	Return strReturn;
end;
------------------------------------
------
------------------------------------
function Get_Contractor_Addr(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	Cursor c1 is
		SELECT OUN_ADDRESS1||CHR(10)||OUN_ADDRESS2||CHR(10)||OUN_ADDRESS3||CHR(10)||OUN_ADDRESS4||CHR(10)||OUN_ADDRESS5
		FROM CONTRACTS,WORK_ORDERS, ORG_UNITS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo
		AND WOR_CON_ID = CON_ID
            AND CON_CONTR_ORG_ID = OUN_ORG_ID;

	strReturn VARCHAR2(2000);
begin

	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	Return strReturn;
end;
------------------------------------
------
------------------------------------
function Get_Contract_No(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	Cursor c1 is
		SELECT CON_CODE
		FROM CONTRACTS,WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo
		AND WOR_CON_ID = CON_ID;

	strReturn VARCHAR2(40);
begin

	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	Return strReturn;
end;
------------------------------------
------
------------------------------------
function Get_Contractor(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	Cursor c1 is
		SELECT OUN_NAME
		FROM CONTRACTS,WORK_ORDERS,ORG_UNITS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo
		AND WOR_CON_ID = CON_ID
                AND CON_CONTR_ORG_ID = OUN_ORG_ID;

	strReturn VARCHAR2(40);
begin

	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	Return strReturn;
end;
------------------------------------
------
------------------------------------
function Authorised_By(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	Cursor c1 is
		SELECT HUS_NAME
		FROM HIG_USERS,WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo
		AND HUS_USER_ID = WOR_MOD_BY_ID;

	strReturn VARCHAR2(40);
begin
	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	Return strReturn;
end;
------------------------------------
------
------------------------------------
function Raised_By(WorkOrderNo In VARCHAR2) Return VARCHAR2 IS
	Cursor c1 is
		SELECT HUS_NAME
		FROM HIG_USERS,WORK_ORDERS
		WHERE WOR_WORKS_ORDER_NO = WorkOrderNo
		AND HUS_USER_ID = WOR_PEO_PERSON_ID;

	strReturn VARCHAR2(40);
begin
	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	Return strReturn;
end;
------------------------------------
------
------------------------------------


function Get_Road_Group(WorkOrderNo IN VARCHAR2) Return VARCHAR2 IS

	strReturn VARCHAR2(60);

	Cursor Road_Group IS
		select rse_group
		from road_segs,work_orders
		where rse_he_id =wor_rse_he_id_group
		and wor_works_order_no = WorkOrderNo;

	bolFound BOOLEAN := FALSE;
Begin
	Open Road_Group;
	Fetch Road_Group into strReturn;
	Close Road_Group;

	Return strReturn;
End;
------------------------------------
------ New Scheme Type function driven from hig_codes Added Feb 1999 I Forde-Smith
------------------------------------

function Scheme_Type(WorkOrderNo IN VARCHAR2) Return VARCHAR2 IS
	strReturn VARCHAR2(60);

	Cursor Scheme_Type IS
		select HCO_MEANING
		from work_orders,hig_codes
		where wor_works_order_no = WorkOrderNo
		AND HCO_DOMAIN = 'SCHEME_TYPES'
		AND HCO_CODE = WOR_SCHEME_TYPE;

Begin
	Open Scheme_Type;
	Fetch Scheme_Type into strReturn;
	Close Scheme_Type;

	Return strReturn;
End;


------------------------------------
------
------------------------------------

function Get_Defect_Loc_Full
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Loc is
		SELECT RSE_DESCR||ORA_LF||DEF_LOCN_DESCR||ORA_LF||DEF_DEFECT_CODE||'-'||DTY_DESCR1||ORA_LF||ORA_TAB||ORA_TAB||'XSP '||DEF_X_SECT||' Chain '||TO_CHAR(DEF_ST_CHAIN)
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,DEF_TYPES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND DTY_DTP_FLAG = RSE_SYS_FLAG
		AND DTY_ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND DTY_DEFECT_CODE = DEF_DEFECT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	intRecordCount INTEGER :=1;
	strLine	NM3TYPE.MAX_VARCHAR2; -- clb 05012011 Task 0107258

begin
	Open Def_Loc;
	Fetch Def_Loc into strLine;
	Close Def_Loc;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Defect_Loc
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Loc is
		SELECT RSE_DESCR||ORA_LF||DEF_LOCN_DESCR||ORA_LF||DEF_DEFECT_CODE||'-'||DTY_DESCR1
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,DEF_TYPES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND DTY_DTP_FLAG = RSE_SYS_FLAG
		AND DTY_ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND DTY_DEFECT_CODE = DEF_DEFECT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	intRecordCount INTEGER :=1;
	strLine	NM3TYPE.MAX_VARCHAR2; -- clb 05012011 Task 0107258

begin
	Open Def_Loc;
	Fetch Def_Loc into strLine;
	Close Def_Loc;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Defect_Loc_Minimum
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Loc is
		SELECT DEF_LOCN_DESCR
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine	defects.def_locn_descr%type;

begin
	Open Def_Loc;
	Fetch Def_Loc into strLine;
	Close Def_Loc;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Defect_Activity
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS

	Cursor Def_Act is
		SELECT ATV_DESCR
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,ACTIVITIES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND ATV_DTP_FLAG = RSE_SYS_FLAG
		AND ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine	VARCHAR2(60);

begin
	Open Def_Act;
	Fetch Def_Act into strLine;
	Close Def_Act;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Defect_Code_Descr
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Descr is
		SELECT DTY_DESCR1
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,DEF_TYPES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND DTY_DTP_FLAG = RSE_SYS_FLAG
		AND DTY_ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND DTY_DEFECT_CODE = DEF_DEFECT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine	VARCHAR2(40);

begin
	Open Def_Descr;
	Fetch Def_Descr into strLine;
	Close Def_Descr;

	return strLine;
end;
------------------------------------
------
------------------------------------

function Get_Treatment_Desc
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Treat_Desc is
		SELECT TRE_DESCR
		FROM DEFECTS,WORK_ORDER_LINES,REPAIRS,TREATMENTS
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = WOL_RSE_HE_ID
		AND REP_RSE_HE_ID = WOL_RSE_HE_ID
		AND REP_DEF_DEFECT_ID = WOL_DEF_DEFECT_ID
		AND REP_ACTION_CAT = WOL_REP_ACTION_CAT
		AND TRE_TREAT_CODE = REP_TRE_TREAT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine	VARCHAR2(250);

begin
	Open Treat_Desc;
	Fetch Treat_Desc into strLine;
	Close Treat_Desc;

	return strLine;
end;

------------------------------------
------
------------------------------------
function Get_Repair_Desc
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Rep_Desc is
		SELECT DEF_ATV_ACTY_AREA_CODE||'-'||TRE_TREAT_CODE||ORA_LF||TRE_DESCR||ORA_LF||REP_DESCR||ORA_LF||'Defect Id :'||to_char(WOL_DEF_DEFECT_ID)||ORA_LF
		FROM DEFECTS,WORK_ORDER_LINES,REPAIRS,TREATMENTS
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = WOL_RSE_HE_ID
		AND REP_RSE_HE_ID = WOL_RSE_HE_ID
		AND REP_DEF_DEFECT_ID = WOL_DEF_DEFECT_ID
		AND REP_ACTION_CAT = WOL_REP_ACTION_CAT
		AND TRE_TREAT_CODE = REP_TRE_TREAT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine	nm3type.max_varchar2;

begin
	Open Rep_Desc;
	Fetch Rep_Desc into strLine;
	Close Rep_Desc;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Defect_id
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_id is
		SELECT to_char(WOL_DEF_DEFECT_ID)
		FROM WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine;

	strLine	VARCHAR2(250);

begin
	Open Def_id;
	Fetch Def_Id into strLine;
	Close Def_Id;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Defect_Priority
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS

	Cursor Def_Priority is
		SELECT DEF_PRIORITY
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine	VARCHAR2(40);

begin
	Open Def_Priority;
	Fetch Def_Priority into strLine;
	Close Def_Priority;

	return strLine;
end;
------------------------------------
------
------------------------------------
Function Get_Defect_Line
(
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 IS

	strline VARCHAR2(2000);
Begin

	strLine := 	Get_Defect_Id(WorkOrderLine)||ORA_TAB||
		     	Get_Defect_Activity(WorkOrderLine)||ORA_TAB||
			Get_Defect_Code_Descr(WorkOrderLine)||ORA_TAB||
			Get_Treatment_Desc(WorkOrderLine)||ORA_TAB||
			Get_Defect_Priority(WorkOrderLine);


	Return strLine;
End;
------------------------------------
------
------------------------------------

function Get_Defect_Unit
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Unit is
		SELECT DTY_HH_ATTRI_TEXT_1
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,DEF_TYPES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND DTY_DTP_FLAG = RSE_SYS_FLAG
		AND DTY_ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND DTY_DEFECT_CODE = DEF_DEFECT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine VARCHAR2(60);
begin
	Open Def_Unit;
	Fetch Def_Unit into strLine;
	Close Def_Unit;

	return strLine;

end Get_Defect_Unit;
------------------------------------
------
------------------------------------
function Get_Defect_Qty
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Which_Qty is
		SELECT UPPER(DTY_HH_ATTRIBUTE_1)
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,DEF_TYPES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND DTY_DTP_FLAG = RSE_SYS_FLAG
		AND DTY_ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND DTY_DEFECT_CODE = DEF_DEFECT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Qty_Area is
		SELECT TO_CHAR(DEF_AREA)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Qty_Length is
		SELECT TO_CHAR(DEF_LENGTH)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Qty_Number is
		SELECT TO_CHAR(DEF_NUMBER)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine VARCHAR2(60);
	strAttribute VARCHAR2(100);
	bolFound BOOLEAN := FALSE;
begin
	/*
	First find out which attribute within the defects table the qty value
	is stored in - FOUND from def_types attribute_1
	 */

	Open Which_Qty;
	Fetch Which_Qty into strAttribute;
	bolFound := Which_Qty%FOUND;
	Close Which_Qty;

	if not bolFound then
		return null;
	end if;

	if 	strAttribute = MC_AREA then
		Open Def_Qty_Area;
		Fetch Def_Qty_Area into strLine;
		Close Def_Qty_Area;

	elsif strAttribute = MC_LENGTH then
		Open Def_Qty_Length;
		Fetch Def_Qty_Length into strLine;
		Close Def_Qty_Length;

	elsif strAttribute = MC_NUMBER then
		Open Def_Qty_Number;
		Fetch Def_Qty_Number into strLine;
		Close Def_Qty_Number;
	else
		strLine := NULL;
	end if;

	return strLine;

end Get_Defect_Qty;
------------------------------------
------
------------------------------------
function Get_Defect_Rate
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Est_Cost is
		SELECT WOL_EST_COST
		FROM WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine;

	strLine VARCHAR2(60);

	numRate NUMBER(11,2);
	numEstCost NUMBER(11,2);
	intQty NUMBER(11,2);
begin

	intQty := TO_NUMBER(WWO.GET_DEFECT_QTY(WorkOrderLine));

	Open Def_Est_Cost;
	Fetch Def_Est_Cost into numEstCost;
	Close Def_Est_Cost;


	if intQty > 0 and numEstCost >0 then
		numRate := numEstCost/intQty;
	end if;

	return strFormatCost(numRate);

end Get_Defect_Rate;
------------------------------------
------
------------------------------------
function Get_Defect_Est_Value
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Est_Cost is
		SELECT WOL_EST_COST
		FROM WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine;

	numEstCost NUMBER(11,2);
begin

	Open Def_Est_Cost;
	Fetch Def_Est_Cost into numEstCost;
	Close Def_Est_Cost;

	return strFormatCost(numEstCost);

end Get_Defect_Est_Value;
------------------------------------
------
------------------------------------
function Get_Repair_Treat
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Treat is
		SELECT TRE_DESCR
		FROM REPAIRS,WORK_ORDER_LINES,TREATMENTS
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = REP_DEF_DEFECT_ID
		AND WOL_REP_ACTION_CAT = REP_ACTION_CAT
		AND REP_TRE_TREAT_CODE = TRE_TREAT_CODE;

	strLine	VARCHAR2(250);

begin
	Open Def_Treat;
	Fetch Def_Treat into strLine;
	Close Def_Treat;

	return strLine;
end;
------------------------------------
------
------------------------------------

function Get_Wol_Id
(
intLine IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN NUMBER
IS
	intRecordCount INTEGER :=1;
	intReturn INTEGER;
	Cursor c1 is
		SELECT WOL_ID
		FROM WORK_ORDER_LINES
		WHERE WOL_WORKS_ORDER_NO = WorkOrderNo
        ORDER BY wol_flag desc, wol_rse_he_id, wol_act_area_code, wol_are_st_chain;
        -- MJA (28-Jun-07) added Order by - Log 708953
BEGIN
	For Recs in c1 LOOP
		if intRecordCount = intLine then
			intReturn := recs.WOL_ID;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN intReturn;
END;

------------------------------------
------
------------------------------------
function Get_Wol_Link
(
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 is
	strReturn VARCHAR2(20);

	Cursor c1 is
		SELECT RSE_AGENCY||RSE_LINKCODE LINKCODE
		FROM ROAD_SEGS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND RSE_HE_ID = WOL_RSE_HE_ID;

BEGIN
	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	RETURN strReturn;

end Get_Wol_Link;
------------------------------------
------
------------------------------------

function Get_Wol_SectNo
(
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 is
	strReturn VARCHAR2(20);

	Cursor c1 is
		SELECT RSE_SECT_NO
		FROM ROAD_SEGS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND RSE_HE_ID = WOL_RSE_HE_ID;

BEGIN

	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	RETURN strReturn;

end Get_Wol_SectNo;
------------------------------------
------
------------------------------------
function Get_Wol_Road_Section
(
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 is
	strReturn VARCHAR2(40);
begin
	strReturn := Get_Wol_Link(WorkOrderLine);
	if strReturn is not null then
		strReturn := strReturn||'/'||Get_Wol_SectNo(WorkOrderLine);
	end if;

	Return strReturn;

end;
------------------------------------
------
------------------------------------
function Get_Wol_Item_No
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN NUMBER is
	intReturn INTEGER;
        intRecordCount INTEGER;
        Cursor c1 is
                SELECT COUNT(WOL_ID)
                FROM WORK_ORDER_LINES
                WHERE WOL_WORKS_ORDER_NO = WorkOrderNo;

begin

	Open c1;
	Fetch c1 into intRecordCount;
	Close c1;

	if intRecordCount >= intLineNo then
		intReturn := intLineNo;
	else
		intReturn := NULL;
	end if;

	RETURN intReturn;
end;
------------------------------------
------
------------------------------------
function Get_Work_Category
(
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 IS

	strReturn VARCHAR2(10);

	Cursor c1 is
		SELECT WOL_ICB_WORK_CODE
		FROM WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine;

BEGIN

	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	RETURN strReturn;
END;

------------------------------------
------
------------------------------------
function Get_BOQ_Qty
(intBOQLine IN INTEGER,
 WorkOrderLine IN INTEGER
) Return VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT nvl(BOQ_ACT_QUANTITY,BOQ_EST_QUANTITY) QUANTITY
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

BEGIN
	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.QUANTITY;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;
------------------------------------
------
------------------------------------
function Get_BOQ_Rate
(intBOQLine IN INTEGER,
 WorkOrderLine IN INTEGER
) Return VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT nvl(BOQ_ACT_RATE,BOQ_EST_RATE) RATE
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

BEGIN
	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.RATE;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;
------------------------------------
------
------------------------------------
function Get_BOQ_Total
(intBOQLine IN INTEGER,
 WorkOrderLine IN INTEGER
) Return VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;
	strReturn VARCHAR2(20);

	Cursor c1 is
		SELECT nvl(BOQ_ACT_COST,BOQ_EST_COST) COST
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

BEGIN
	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.COST;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;
------------------------------------
------
------------------------------------
function Get_BOQ_Line_Total
(
WorkOrderLine IN INTEGER
) Return VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;
	strReturn VARCHAR2(200);

	Cursor c1 is
		SELECT sum(nvl(BOQ_ACT_COST,BOQ_EST_COST)) COST
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

BEGIN
	Open c1;
	Fetch c1 into intReturn;
	Close c1;
	strReturn := strFormatCost(intReturn);

	if strReturn is not null then
		strReturn := 'Total: '||strReturn;
	end if;

	RETURN strReturn;
END;
------------------------------------
------
------------------------------------

function Get_BOQ_Unit(intBOQLine IN INTEGER, WorkOrderLine IN INTEGER)
RETURN VARCHAR2 IS

	Cursor Boq_Unit is
		SELECT STA_UNIT
		FROM STANDARD_ITEMS,BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine
		AND BOQ_STA_ITEM_CODE = STA_ITEM_CODE(+);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(200);

begin
	For Recs in BOQ_UNIT LOOP
		if intRecordCount = intBOQLine then
			strLine := Recs.STA_UNIT;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------

function Get_BOQ_Item(intBOQLine IN INTEGER, WorkOrderLine IN INTEGER)
RETURN VARCHAR2 IS

	Cursor Boq_Item is
		SELECT BOQ_STA_ITEM_CODE
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(200);

begin
	For Recs in BOQ_ITEM LOOP
		if intRecordCount = intBOQLine then
			strLine := Recs.BOQ_STA_ITEM_CODE;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------

function Get_BOQ_Desc(intBOQLine IN INTEGER, WorkOrderLine IN INTEGER)
RETURN VARCHAR2 IS

	Cursor Boq_Item is
		SELECT BOQ_ITEM_NAME
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(200);

begin
	For Recs in BOQ_ITEM LOOP
		if intRecordCount = intBOQLine then
			strLine := Recs.BOQ_ITEM_NAME;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_BOQ_Line
(
intLineNo IN INTEGER,
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 IS
	Cursor BOQ is
		SELECT BOQ_WOL_ID
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in BOQ LOOP
		if intRecordCount = intLineNo then

			strLine := 	GET_BOQ_ITEM(intLineNo,recs.boq_wol_id)||' '||
					GET_BOQ_DESC(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_UNIT(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_RATE(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_QTY(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_TOTAL(intLineNo,recs.boq_wol_id)||ORA_LF;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_BOQ_Line2
(
intLineNo IN INTEGER,
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 IS
	Cursor BOQ is
		SELECT BOQ_WOL_ID
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in BOQ LOOP
		if intRecordCount = intLineNo then

			strLine := 	GET_BOQ_ITEM(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_DESC(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_EST_QUANTITY(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_RATE(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_EST_COST(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_ACT_QUANTITY(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_ACT_COST(intLineNo,recs.boq_wol_id);
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;


------------------------------------
------
------------------------------------
function Get_BOQ_Line_NoCost
(
intLineNo IN INTEGER,
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 IS
	Cursor BOQ is
		SELECT BOQ_WOL_ID
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in BOQ LOOP
		if intRecordCount = intLineNo then

			strLine := 	GET_BOQ_ITEM(intLineNo,recs.boq_wol_id)||' '||
					GET_BOQ_DESC(intLineNo,recs.boq_wol_id)||ORA_TAB||
					GET_BOQ_UNIT(intLineNo,recs.boq_wol_id)||ORA_TAB||
					ORA_TAB||
					GET_BOQ_QTY(intLineNo,recs.boq_wol_id)||ORA_TAB||
					ORA_LF;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;

------------------------------------
------
------------------------------------

function Get_BOQ_Est_Cost
(
intBOQLine IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT BOQ_Est_Cost
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;
BEGIN

	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.BOQ_Est_Cost;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;
------------------------------------
------
------------------------------------
function Get_BOQ_Est_Quantity
(
intBOQLine IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT BOQ_Est_Quantity
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;
BEGIN

	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.BOQ_Est_Quantity;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;
------------------------------------
------
------------------------------------
function Get_BOQ_Est_Rate
(
intBOQLine IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT BOQ_Est_Rate
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;
BEGIN

	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.BOQ_Est_Rate;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;

------------------------------------
------
------------------------------------

function Get_BOQ_Act_Cost
(
intBOQLine IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT BOQ_Act_Cost
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;
BEGIN

	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.BOQ_Act_Cost;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;
------------------------------------
------
------------------------------------
function Get_BOQ_Act_Quantity
(
intBOQLine IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT BOQ_Act_Quantity
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;
BEGIN

	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.BOQ_Act_Quantity;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;
------------------------------------
------
------------------------------------
function Get_BOQ_Act_Rate
(
intBOQLine IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	intRecordCount INTEGER :=1;
	intReturn NUMBER;

	Cursor c1 is
		SELECT BOQ_Act_Rate
		FROM BOQ_ITEMS
		WHERE BOQ_WOL_ID = WorkOrderLine;
BEGIN

	For Recs in c1 LOOP
		if intRecordCount = intBOQLine then
			intReturn := recs.BOQ_Act_Rate;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	RETURN strFormatCost(intReturn);

END;

/*
	****
	NEW FUNCTIONS FOR DORSET
	****
*/

------------------------------------
------
------------------------------------
function Get_Road_Desc(WorkOrderNo IN VARCHAR2) Return VARCHAR2 IS

	strReturn VARCHAR2(240);

	Cursor Road_Desc IS
		select rse_descr
		from road_segs,work_orders
		where rse_he_id =wor_rse_he_id_group
		and wor_works_order_no = WorkOrderNo;

	bolFound BOOLEAN := FALSE;
Begin
	Open Road_Desc;
	Fetch Road_Desc into strReturn;
	Close Road_Desc;

	Return strReturn;
End;
------------------------------------
------
------------------------------------
function Get_Item_code
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT V_ITEM_CODE
		FROM V_WWO
		WHERE V_WORKS_ORDER_NO = WorkOrderNo;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intLineNo then
			strLine := recs.v_item_code;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;

------------------------------------
------
------------------------------------
function Get_Item_Name
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT V_ITEM_NAME
		FROM V_WWO
		WHERE V_WORKS_ORDER_NO = WorkOrderNo;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intLineNo then
			strLine := recs.v_item_name;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;

------------------------------------
------
------------------------------------
function Get_Item_Desc
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT v_item_name
		FROM V_WWO
		WHERE V_WORKS_ORDER_NO = WorkOrderNo;
-- MJA log 708953: Commented order by out as was causing descriptions
--                 to be out of sequence with non ordered functions
--ORDER BY V_ITEM_CODE;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(255):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intLineNo then
			strLine := recs.v_item_name;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Item_Unit
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT V_UNIT
		FROM V_WWO
		WHERE V_WORKS_ORDER_NO = WorkOrderNo;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intLineNo then
			strLine := recs.v_unit;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Item_Qty
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(v_act_quantity_total,V_EST_QUANTITY_TOTAL) v_qty
		FROM V_WWO
		WHERE V_WORKS_ORDER_NO = WorkOrderNo;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intLineNo then
			strLine := to_char(recs.v_qty);
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Item_Rate
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(v_act_cost_total,V_EST_cost_TOTAL) cost,nvl(v_act_quantity_total,v_est_quantity_total) qty
		FROM V_WWO
		WHERE V_WORKS_ORDER_NO = WorkOrderNo;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intLineNo then
			if recs.qty > 0 then
				strLine := strFormatCost(recs.cost/recs.qty);
			end if;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Item_Cost
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(v_act_cost_total,V_EST_cost_TOTAL) cost
		FROM V_WWO
		WHERE V_WORKS_ORDER_NO = WorkOrderNo;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intLineNo then
			strLine := strFormatCost(recs.cost);
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Get_Wol_Road_Desc
(
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 is
	strReturn VARCHAR2(240);

	Cursor c1 is
		SELECT RSE_DESCR
		FROM ROAD_SEGS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND RSE_HE_ID = WOL_RSE_HE_ID;

BEGIN
	Open c1;
	Fetch c1 into strReturn;
	Close c1;

	RETURN strReturn;

end Get_Wol_Road_Desc;
------------------------------------
------
------------------------------------

/*
	****
	END OF NEW FUNCTIONS
	****
*/

/*
	****
	EXTRA NEW FUNCTIONS - CT
	****
*/

------------------------------------
------
------------------------------------
function Wol_Boq_Code
(
intBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT V_ITEM_CODE
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := recs.v_item_code;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Boq_Name
(
intBoqNo in INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT V_ITEM_NAME
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := recs.v_item_name;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;

------------------------------------
------
------------------------------------
function Wol_Boq_Desc
(
intBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT v_item_name
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo)
ORDER BY V_ITEM_CODE;

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(255):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := recs.v_item_name;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;

------------------------------------
------
------------------------------------
function Wol_Boq_Unit
(
intBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT V_UNIT
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := recs.v_unit;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Boq_Eqty
(
IntBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(V_EST_QUANTITY_TOTAL,0) v_qty
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := to_char(recs.v_qty);
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Boq_Aqty
(
IntBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(V_ACT_QUANTITY_TOTAL,0) v_qty
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := to_char(recs.v_qty);
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Boq_Erate
(
intBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(V_EST_cost_TOTAL,0) cost,nvl(v_est_quantity_total,0) qty
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			if recs.qty <> 0 then
				strLine := strFormatCost(recs.cost/recs.qty);
			end if;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Boq_Arate
(
intBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(V_ACT_cost_TOTAL,0) cost,nvl(v_act_quantity_total,0) qty
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			if recs.qty <> 0 then
				strLine := strFormatCost(recs.cost/recs.qty);
			end if;
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Boq_Ecost
(
intBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(v_est_cost_total,0) cost
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := strFormatCost(recs.cost);
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Boq_Acost
(
intBoqNo IN INTEGER,
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(v_act_cost_total,0) cost
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID=WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	intRecordCount INTEGER :=1;
	strLine	VARCHAR2(250):=NULL;

begin
	For Recs in c1 LOOP
		if intRecordCount = intBoqNo then
			strLine := strFormatCost(recs.cost/1.0);
			exit;
		end if;
		intRecordCount := intRecordCount + 1;
	End Loop;

	return strLine;
end;
------------------------------------
------
------------------------------------
function Wol_Acost
(
intLineNo IN INTEGER,
WorkOrderNo IN VARCHAR2
) RETURN VARCHAR2 IS
	Cursor c1 is
		SELECT nvl(sum(v_act_cost_total),0)
		FROM V_WWOL
		WHERE V_WORKS_ORDER_NO = WorkOrderNo
		AND V_WOL_ID = WWO.GET_WOL_ID(intLineNo,WorkOrderNo);

	strLine	VARCHAR2(250):=NULL;

begin

	Open c1;
	Fetch c1 into strLine;
	Close c1;
	return strFormatCost(strLine);
end;
------------------------------------
------
------------------------------------


/*
	****
	END OF EXTRA NEW FUNCTIONS
	****
*/


---Swansea functions CT  Nov 2000

function Get_Defect_Desc_Min
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Descr is
		SELECT DEF_DEFECT_DESCR
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine VARCHAR2(240);

begin
	Open Def_Descr;
	Fetch Def_Descr into strLine;
	Close Def_Descr;

	return strLine;
end;
-------------------------------------------------------------

function Get_Defect_Special(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS

	Cursor Def_Sp is
		SELECT DEF_SPECIAL_INSTR
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine VARCHAR2(254);

begin
	Open Def_Sp;
	Fetch Def_Sp into strLine;
	Close Def_Sp;

	return strLine;
end;
------------------------------------------------------------

function Get_Repair_Target
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Target is
		SELECT TO_CHAR(REP_DATE_DUE,'DD-MON-RRRR')
		FROM REPAIRS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = REP_DEF_DEFECT_ID
		AND WOL_REP_ACTION_CAT = REP_ACTION_CAT;


	strLine VARCHAR2(11);

begin
	Open Def_Target;
	Fetch Def_Target into strLine;
	Close Def_Target;

	return strLine;
end;
----------------------------------------------------------------

function Get_Repair_Desc_Min
(
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Rep_Desc is
		SELECT REP_DESCR
		FROM DEFECTS,WORK_ORDER_LINES,REPAIRS
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = WOL_RSE_HE_ID
		AND REP_RSE_HE_ID = WOL_RSE_HE_ID
		AND REP_DEF_DEFECT_ID = WOL_DEF_DEFECT_ID
		AND REP_ACTION_CAT = WOL_REP_ACTION_CAT
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine VARCHAR2(240);

begin
	Open Rep_Desc;
	Fetch Rep_Desc into strLine;
	Close Rep_Desc;

	return strLine;
end;

------------------------------------

function Get_Defect_Attr
(
IntAttrNos	  IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Which_Attr is
		SELECT DECODE(IntAttrNos,'1',UPPER(DTY_HH_ATTRIBUTE_1)
						,'2',UPPER(DTY_HH_ATTRIBUTE_2)
						,'3',UPPER(DTY_HH_ATTRIBUTE_3)
						,'4',UPPER(DTY_HH_ATTRIBUTE_4)
						,null)
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,DEF_TYPES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND DTY_DTP_FLAG = RSE_SYS_FLAG
		AND DTY_ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND DTY_DEFECT_CODE = DEF_DEFECT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Area is
		SELECT TO_CHAR(DEF_AREA)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Coord_Flag is
		SELECT DEF_COORD_FLAG
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Defect_Descr is
		SELECT DEF_DEFECT_DESCR
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Diagram_No is
		SELECT DEF_DIAGRAM_NO
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Height is
		SELECT TO_CHAR(DEF_HEIGHT)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Ident_Code is
		SELECT DEF_IDENT_CODE
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Length is
		SELECT TO_CHAR(DEF_LENGTH)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Number is
		SELECT TO_CHAR(DEF_NUMBER)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Per_Cent is
		SELECT TO_CHAR(DEF_PER_CENT)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Serial_No is
		SELECT DEF_SERIAL_NO
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	Cursor Def_Skid_Coeff is
		SELECT TO_CHAR(DEF_SKID_COEFF)
		FROM DEFECTS,WORK_ORDER_LINES
		WHERE WOL_ID = WorkOrderLine
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;


	strLine VARCHAR2(240);
	strAttribute VARCHAR2(100);
	attrFound BOOLEAN := FALSE;

begin
	/*
	First find out which attribute within the defects table the qty value
	is stored in - FOUND from parameter
	 */

	Open Which_Attr;
	Fetch Which_Attr into strAttribute;
	attrFound := Which_Attr%FOUND;
	Close Which_Attr;
	if not attrFound then
		return null;
	end if;

	if    strAttribute = 'DEF_AREA' then
		Open Def_Area;
		Fetch Def_Area into strLine;
		Close Def_Area;

	elsif strAttribute = 'DEF_COORD_FLAG' then
		Open Def_Coord_Flag;
		Fetch Def_Coord_Flag into strLine;
		Close Def_Coord_Flag;

	elsif strAttribute = 'DEF_DEFECT_DESCR' then
		Open Def_Defect_Descr;
		Fetch Def_Defect_Descr into strLine;
		Close Def_Defect_Descr;

	elsif strAttribute = 'DEF_DIAGRAM_NO' then
		Open Def_Diagram_No;
		Fetch Def_Diagram_No into strLine;
		Close Def_Diagram_No;

	elsif strAttribute = 'DEF_HEIGHT' then
		Open Def_Height;
		Fetch Def_Height into strLine;
		Close Def_Height;

	elsif strAttribute = 'DEF_IDENT_CODE' then
		Open Def_Ident_Code;
		Fetch Def_Ident_Code into strLine;
		Close Def_Ident_Code;

	elsif strAttribute = 'DEF_LENGTH' then
		Open Def_Length;
		Fetch Def_Length into strLine;
		Close Def_Length;

	elsif strAttribute = 'DEF_NUMBER' then
		Open Def_Number;
		Fetch Def_Number into strLine;
		Close Def_Number;

	elsif strAttribute = 'DEF_PER_CENT' then
		Open Def_Per_Cent;
		Fetch Def_Per_Cent into strLine;
		Close Def_Per_Cent;

	elsif strAttribute = 'DEF_SERIAL_NO' then
		Open Def_Serial_No;
		Fetch Def_Serial_No into strLine;
		Close Def_Serial_No;

	elsif strAttribute = 'DEF_SKID_COEFF' then
		Open Def_Skid_Coeff;
		Fetch Def_Skid_Coeff into strLine;
		Close Def_Skid_Coeff;
	else
		strLine := NULL;
	end if;


	return strLine;

end Get_Defect_Attr;
------------------------------------

------------------------------------
Function Get_Defect_Attr_Params
(
IntAttrNos	  IN INTEGER,
WorkOrderLine IN INTEGER
) RETURN VARCHAR2 IS

	strline VARCHAR2(2000);
Begin

	strLine := rpad(Get_Defect_Attr_Text(IntAttrNos,WorkOrderLine),20)||
		     Get_Defect_Attr(IntAttrNos,WorkOrderLine);

	Return strLine;
End ;
------------------------------------

------------------------------------
function Get_Defect_Attr_Text
(
IntAttrNos    IN INTEGER,
WorkOrderLine IN INTEGER
)
RETURN VARCHAR2 IS
	Cursor Def_Attr_Text is
		SELECT DECODE(IntAttrNos,'1',DTY_HH_ATTRI_TEXT_1
					,'2',DTY_HH_ATTRI_TEXT_2
					,'3',DTY_HH_ATTRI_TEXT_3
					,'4',DTY_HH_ATTRI_TEXT_4
					,null)
		FROM DEFECTS,WORK_ORDER_LINES,ROAD_SEGS,DEF_TYPES
		WHERE WOL_ID = WorkOrderLine
		AND DEF_RSE_HE_ID = RSE_HE_ID
		AND DTY_DTP_FLAG = RSE_SYS_FLAG
		AND DTY_ATV_ACTY_AREA_CODE = DEF_ATV_ACTY_AREA_CODE
		AND DTY_DEFECT_CODE = DEF_DEFECT_CODE
		AND WOL_DEF_DEFECT_ID = DEF_DEFECT_ID;

	strLine VARCHAR2(60);
begin
	Open Def_Attr_Text;
	Fetch Def_Attr_Text into strLine;
	Close Def_Attr_Text;
	return strLine;
end Get_Defect_Attr_Text;
------------------------------------

--- End of Swansea Functions

--- Get related enquiry doc id if there is one SW 05-SEP-2003, see 694700
function Get_WO_Enquiry (WorkOrderNo IN VARCHAR2) RETURN INTEGER IS
  cursor c_doc_id is
    select das_doc_id
    from   doc_assocs
    where  das_rec_id = WorkOrderNo
    and    das_table_name = 'WORK_ORDERS';
  l_doc_id doc_assocs.das_doc_id%TYPE;
begin
  open c_doc_id;
  fetch c_doc_id into l_doc_id;
  close c_doc_id;

  return l_doc_id;
end Get_WO_Enquiry;

function Get_Defect_Enquiry (WorkOrderLine IN INTEGER) RETURN INTEGER IS
  cursor c_defect_id is
    select wol_def_defect_id
    from   work_order_lines
    where  wol_id = WorkOrderLine;

  cursor c_doc_id(p_defect_id INTEGER) is
    select das_doc_id
    from   doc_assocs
    where  das_rec_id = p_defect_id
    and    das_table_name = 'DEFECTS';

  l_defect_id defects.def_defect_id%TYPE;
  l_doc_id doc_assocs.das_doc_id%TYPE;
begin
  open c_defect_id;
  fetch c_defect_id into l_defect_id;
  close c_defect_id;

  if l_defect_id is not null then
    open c_doc_id (l_defect_id);
    fetch c_doc_id into l_doc_id;
    close c_doc_id;
    return l_doc_id;
  else
    return(null);
  end if;
end Get_Defect_Enquiry;

function Get_Initcap(StrVal IN VARCHAR2) Return VARCHAR2 IS

   strReturn VARCHAR2(255);

Begin
   return initcap(StrVal);
End;


end WWO;
/
