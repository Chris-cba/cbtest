CREATE OR REPLACE FORCE VIEW IMF_MAI_BUDGETS 
(
   BUDGET_ID,
   NETWORK_ELEMENT_ID,   
   NETWORK_SYSTEM_TYPE,
   NETWORK_ELEMENT_REFERENCE,
   NETWORK_ELEMENT_DESCRIPTION,
   ADMIN_UNIT,
   ADMIN_UNIT_ID,
   JOB_SIZE,      
   ITEM_CODE,
   WORK_CATEGORY,
   FINANCIAL_YEAR,
   BUDGET,
   COMMITTED,
   ACTUAL,
   BALANCE,
   COMMENTS,
   COST_CODE
)
AS
SELECT 
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_budgets.vw-arc   1.0   Mar 18 2009 15:21:48   drawat  $
--       Module Name      : $Workfile:   imf_mai_budgets.vw  $
--       Date into PVCS   : $Date:   Mar 18 2009 15:21:48  $
--       Date fetched Out : $Modtime:   Mar 18 2009 15:18:34  $
--       Version          : $Revision:   1.0  $
-- Foundation view displaying budgets
-------------------------------------------------------------------------   
     B.BUD_ID,
     B.BUD_RSE_HE_ID,
     DECODE (NE.NE_GTY_GROUP_TYPE,
             NULL,
             SUBSTR (NE.NE_UNIQUE, 1, INSTR (NE.NE_UNIQUE, '/') - 1),
             NE.NE_UNIQUE),
     NE.NE_DESCR,
     DECODE (B.BUD_SYS_FLAG, 'D', 'Trunk', 'Local'),
     NAU.NAU_NAME ,
     NAU.NAU_ADMIN_UNIT,
     JS.JOB_DESCR,
     ICB.ICB_ITEM_CODE || ICB.ICB_SUB_ITEM_CODE || ICB.ICB_SUB_SUB_ITEM_CODE,
     ICB.ICB_WORK_CATEGORY_NAME,
     B.BUD_FYR_ID,
     DECODE (B.BUD_VALUE, -1, 0, B.BUD_VALUE),
     NVL (B.BUD_COMMITTED, 0),
     NVL (B.BUD_ACTUAL, 0),

     (DECODE (B.BUD_VALUE, -1, 0, B.BUD_VALUE)
       - (B.BUD_COMMITTED + B.BUD_ACTUAL)),
     NVL (B.BUD_COMMENT, 'None'),
     NVL (B.BUD_COST_CODE, 'Not Set') 
FROM BUDGETS B,
     JOB_SIZES JS,
     ITEM_CODE_BREAKDOWNS ICB,
     NM_ELEMENTS_ALL NE,
     NM_ADMIN_UNITS NAU
WHERE B.BUD_JOB_CODE = JS.JOB_CODE(+)
AND   B.BUD_ICB_ITEM_CODE = ICB.ICB_ITEM_CODE(+)
AND   B.BUD_ICB_SUB_ITEM_CODE = ICB.ICB_SUB_ITEM_CODE(+)
AND   B.BUD_ICB_SUB_SUB_ITEM_CODE = ICB.ICB_SUB_SUB_ITEM_CODE(+)
AND   B.BUD_RSE_HE_ID = NE.NE_ID
AND   NE.NE_ADMIN_UNIT = NAU.NAU_ADMIN_UNIT
AND   NE.NE_TYPE IN ('G', 'P') 
AND EXISTS 
           (SELECT   1
              FROM   NM_GROUP_TYPES_ALL
             WHERE   NGT_GROUP_TYPE = NE_GTY_GROUP_TYPE
               AND   NGT_PARTIAL = 'N')
WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_BUDGETS IS 'Maintenance Manager foundation view of budgets, showing details of budget and work costs against the network.';

COMMENT ON COLUMN IMF_MAI_BUDGETS.BUDGET_ID IS 'Internal Id for a budget';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_ELEMENT_ID IS 'Internal id for a network element';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_SYSTEM_TYPE IS 'The network type, L or T';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_ELEMENT_REFERENCE IS 'The network element reference which in this case is a group code';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_ELEMENT_DESCRIPTION IS 'The network element description which in this case is a group name';
COMMENT ON COLUMN IMF_MAI_BUDGETS.ADMIN_UNIT IS 'The admin unit';
COMMENT ON COLUMN IMF_MAI_BUDGETS.ADMIN_UNIT_ID IS 'The admin unit id';
COMMENT ON COLUMN IMF_MAI_BUDGETS.JOB_SIZE IS 'The job size';
COMMENT ON COLUMN IMF_MAI_BUDGETS.ITEM_CODE IS 'The item code';
COMMENT ON COLUMN IMF_MAI_BUDGETS.WORK_CATEGORY IS 'The work category';
COMMENT ON COLUMN IMF_MAI_BUDGETS.FINANCIAL_YEAR IS 'The budget financial year';
COMMENT ON COLUMN IMF_MAI_BUDGETS.BUDGET IS 'The available budget';
COMMENT ON COLUMN IMF_MAI_BUDGETS.COMMITTED IS 'The budget of the work that is committed';
COMMENT ON COLUMN IMF_MAI_BUDGETS.ACTUAL IS 'The actual cost of the work that was instructed';
COMMENT ON COLUMN IMF_MAI_BUDGETS.BALANCE IS 'The budget balance';
COMMENT ON COLUMN IMF_MAI_BUDGETS.COMMENTS IS 'Comments related to the budget';
COMMENT ON COLUMN IMF_MAI_BUDGETS.COST_CODE IS 'The cost code for the work';

