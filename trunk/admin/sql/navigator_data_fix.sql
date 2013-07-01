--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/sql/navigator_data_fix.sql-arc   3.1   Jul 01 2013 15:52:36   James.Wadsworth  $
--       Module Name      : $Workfile:   navigator_data_fix.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:36  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:58:52  $
--       PVCS Version     : $Revision:   3.1  $
--
------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------
-- This script can be run on any schema irrespective of the Licensed Products
DECLARE
--
   l_mai Varchar2(1);    
   l_tma Varchar2(1);    
   l_enq Varchar2(1);    
--
BEGIN
--
   FOR i IN (SELECT hpr_product FROM hig_products WHERE hpr_product  IN ('MAI','ENQ','TMA'))
   LOOP
       --
       IF i.hpr_product = 'MAI'
       THEN
           l_mai := 'Y';
       ELSIF i.hpr_product = 'TMA'
       THEN
           l_TMA := 'Y';
       ELSIF i.hpr_product = 'ENQ'
       THEN
           l_enq := 'Y';
       END IF ;
       --       
   END LOOP;
   --
   IF Nvl(l_tma,'N') = 'N'
   THEN
       -- Delete the TMA Hierarchy records if TMA product does not exists
       DELETE FROM HIG_NAVIGATOR
       WHERE HNV_HIERARCHY_LABEL = 'Notice';
   END IF ;
   --
   IF Nvl(l_enq,'N') = 'N'
   THEN
       -- Delete the ENQ Hierarchy records if ENQ product does not exists
       DELETE FROM HIG_NAVIGATOR
       WHERE HNV_HIERARCHY_LABEL = 'Enquiry';
   END IF ;
   IF Nvl(l_mai,'N') = 'N'
   THEN
       -- Delete the MAI Hierarchy records if MAI product does not exists
       DELETE FROM HIG_NAVIGATOR
       WHERE HNV_HIERARCHY_LABEL IN ('Budget','Defect','Inspection','Repair','Work Order','Work Order Line');
   END IF ;
   -- Update new column with the appropriate Products 
   UPDATE hig_navigator 
   SET       hnv_hpr_product = Decode(hnv_hierarchy_label,'Notice','TMA'
                                                         ,'Enquiry','ENQ'
                                                         ,'Asset','AST','MAI');   
  --
  IF l_mai = 'Y'
  THEN
      -- Corrected the Table name
      UPDATE hig_navigator 
      SET    hnv_parent_table = 'WORK_ORDER_LINES'
      WHERE   hnv_parent_table = 'WOR_ORDER_LINES';
  END IF ;
  Commit;
--   
END;
/



