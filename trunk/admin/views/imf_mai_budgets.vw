CREATE OR REPLACE FORCE VIEW IMF_MAI_BUDGETS 
(
   BUDGET_ID,
   NETWORK_ELEMENT_ID,   
   NETWORK_ELEMENT_REFERENCE,
   NETWORK_ELEMENT_DESCRIPTION,
   NETWORK_SYSTEM_TYPE,
   ADMIN_UNIT_NAME,
   ADMIN_UNIT_CODE,
   JOB_SIZE,      
   WORK_CATEGORY,
   WORK_CATEGORY_DESCRIPTION,
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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/imf_mai_budgets.vw-arc   1.2   Mar 19 2009 17:34:00   drawat  $
--       Module Name      : $Workfile:   imf_mai_budgets.vw  $
--       Date into PVCS   : $Date:   Mar 19 2009 17:34:00  $
--       Date fetched Out : $Modtime:   Mar 19 2009 13:03:22  $
--       Version          : $Revision:   1.2  $
-- Foundation view displaying budgets
-------------------------------------------------------------------------   
     B.BUD_ID,
     B.BUD_RSE_HE_ID,
     NE.NE_UNIQUE,
     NE.NE_DESCR,
     DECODE (B.BUD_SYS_FLAG, 'D', 'Trunk', 'Local'),
     NAU.NAU_NAME admin_unit_name,
     NAU.NAU_ADMIN_UNIT admin_unit_code,
     ( SELECT JS.JOB_DESCR 
       FROM   JOB_SIZES JS
       WHERE  JS.JOB_CODE = B.BUD_JOB_CODE ) job_size,
     (B.BUD_ICB_ITEM_CODE || B.BUD_ICB_SUB_ITEM_CODE || B.BUD_ICB_SUB_SUB_ITEM_CODE) work_category,
     ( SELECT ICB.ICB_WORK_CATEGORY_NAME
       FROM   ITEM_CODE_BREAKDOWNS ICB
       WHERE  B.BUD_ICB_ITEM_CODE = ICB.ICB_ITEM_CODE
       AND    B.BUD_ICB_SUB_ITEM_CODE = ICB.ICB_SUB_ITEM_CODE
       AND    B.BUD_ICB_SUB_SUB_ITEM_CODE = ICB.ICB_SUB_SUB_ITEM_CODE ) work_category_description,
     B.BUD_FYR_ID,
     DECODE (B.BUD_VALUE, -1, 0, B.BUD_VALUE),
     NVL (B.BUD_COMMITTED, 0),
     NVL (B.BUD_ACTUAL, 0),
     (DECODE (B.BUD_VALUE, -1, 0, B.BUD_VALUE)
       - (B.BUD_COMMITTED + B.BUD_ACTUAL)),
     NVL (B.BUD_COMMENT, 'None'),
     NVL (B.BUD_COST_CODE, 'Not Set') 
FROM BUDGETS B,
     NM_ELEMENTS_ALL NE,
     NM_ADMIN_UNITS NAU
WHERE   B.BUD_RSE_HE_ID = NE.NE_ID(+)
AND   B.BUD_AGENCY = NAU.NAU_AUTHORITY_CODE
WITH READ ONLY
/

COMMENT ON TABLE IMF_MAI_BUDGETS IS 'Maintenance Manager foundation view of budgets, showing details of budget and work costs against the network.';

COMMENT ON COLUMN IMF_MAI_BUDGETS.BUDGET_ID IS 'Internal Id for a budget';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_ELEMENT_ID IS 'Internal id for a network element';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_ELEMENT_REFERENCE IS 'The network element reference which in this case is a group code';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_ELEMENT_DESCRIPTION IS 'The network element description which in this case is a group name';
COMMENT ON COLUMN IMF_MAI_BUDGETS.NETWORK_SYSTEM_TYPE IS 'The network type, L or T';
COMMENT ON COLUMN IMF_MAI_BUDGETS.ADMIN_UNIT_NAME IS 'The admin unit name';
COMMENT ON COLUMN IMF_MAI_BUDGETS.ADMIN_UNIT_CODE IS 'The admin unit code';
COMMENT ON COLUMN IMF_MAI_BUDGETS.JOB_SIZE IS 'The job size';
COMMENT ON COLUMN IMF_MAI_BUDGETS.WORK_CATEGORY IS 'The work category';
COMMENT ON COLUMN IMF_MAI_BUDGETS.WORK_CATEGORY_DESCRIPTION IS 'The work category description';
COMMENT ON COLUMN IMF_MAI_BUDGETS.FINANCIAL_YEAR IS 'The budget financial year';
COMMENT ON COLUMN IMF_MAI_BUDGETS.BUDGET IS 'The available budget';
COMMENT ON COLUMN IMF_MAI_BUDGETS.COMMITTED IS 'The budget of the work that is committed';
COMMENT ON COLUMN IMF_MAI_BUDGETS.ACTUAL IS 'The actual cost of the work that was instructed';
COMMENT ON COLUMN IMF_MAI_BUDGETS.BALANCE IS 'The budget balance';
COMMENT ON COLUMN IMF_MAI_BUDGETS.COMMENTS IS 'Comments related to the budget';
COMMENT ON COLUMN IMF_MAI_BUDGETS.COST_CODE IS 'The cost code for the work';

