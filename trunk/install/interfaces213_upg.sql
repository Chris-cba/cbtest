-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/interfaces213_upg.sql-arc   2.1   Jul 01 2013 16:00:26   James.Wadsworth  $
--       Module Name      : $Workfile:   interfaces213_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:00:26  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:34  $
--       SCCS Version     : $Revision:   2.1  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------

insert into HIG_OPTIONS (
HOP_ID
,HOP_PRODUCT
,HOP_NAME
,HOP_VALUE
,HOP_REMARKS
) select
'XTRIFLDS'
,'MAI'
,'Version of Interface Files'
,'NA'
,'If set to 2-1-3 uses additional fields on the end of the WO and WI files. Otherwise set to NA.'
from dual
where not exists (
 select 'not exists'
 from HIG_OPTIONS
where HOP_ID = 'XTRIFLDS'
);
--
create sequence neg_boq_id_seq
increment by -1
start with -1
nomaxvalue;
--
alter table INTERFACE_CLAIMS_BOQ_ALL
add (ICBOQ_BOQ_ID 		NUMBER (10)
  , ICBOQ_PARENT_BOQ_ID		NUMBER (10)
  , ICBOQ_PERCENT_BAND_COMP	VARCHAR2(1)
  , ICBOQ_ROGUE_ITEM		VARCHAR2(1)
  , ICBOQ_ROGUE_ITEM_DESC	VARCHAR2(254));
--
alter table INTERFACE_BOQ
add (IBOQ_BOQ_ID 		NUMBER (10)
  , IBOQ_PARENT_BOQ_ID		NUMBER (10)
  , IBOQ_PERCENT_BAND_COMP	 VARCHAR2(1)
  , IBOQ_ROGUE_ITEM		VARCHAR2(1)
  , IBOQ_ROGUE_ITEM_DESC	 VARCHAR2(254));
--
CREATE OR REPLACE FORCE VIEW INTERFACE_CLAIMS_BOQ
(ICBOQ_IH_ID, ICBOQ_CON_CLAIM_REF, ICBOQ_CON_ID, ICBOQ_WOL_ID, ICBOQ_STA_ITEM_CODE, 
ICBOQ_DIM1, ICBOQ_DIM2, ICBOQ_DIM3, ICBOQ_QUANTITY, ICBOQ_RATE, 
ICBOQ_COST, ICBOQ_PERCENT_ADJUST, ICBOQ_PERCENT_ADJUST_CODE, ICBOQ_STATUS, ICBOQ_ERROR, ICBOQ_BOQ_ID, ICBOQ_PARENT_BOQ_ID, ICBOQ_PERCENT_BAND_COMP, ICBOQ_ROGUE_ITEM, ICBOQ_ROGUE_ITEM_DESC)
AS 
select "ICBOQ_IH_ID","ICBOQ_CON_CLAIM_REF","ICBOQ_CON_ID","ICBOQ_WOL_ID","ICBOQ_STA_ITEM_CODE","ICBOQ_DIM1","ICBOQ_DIM2","ICBOQ_DIM3","ICBOQ_QUANTITY","ICBOQ_RATE","ICBOQ_COST","ICBOQ_PERCENT_ADJUST","ICBOQ_PERCENT_ADJUST_CODE","ICBOQ_STATUS","ICBOQ_ERROR","ICBOQ_BOQ_ID","ICBOQ_PARENT_BOQ_ID","ICBOQ_PERCENT_BAND_COMP","ICBOQ_ROGUE_ITEM","ICBOQ_ROGUE_ITEM_DESC"
from   interface_claims_boq_all
where  nvl(icboq_status, 'D') != 'D';
/

