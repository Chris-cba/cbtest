-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/install/icb_fgac_temp.sql-arc   2.3   Sep 27 2019 15:56:16   Chris.Baugh  $
--       Module Name      : $Workfile:   icb_fgac_temp.sql  $
--       Date into SCCS   : $Date:   Sep 27 2019 15:56:16  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:39:20  $
--       SCCS Version     : $Revision:   2.3  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--   Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
grant create any context to NSG;                                                                                                                                                                        

create context Item_Code_Breakdown_NSG using mai;                                                                                                                                                       

begin                                                                                                                                                                                                   
dbms_rls.add_policy('NSG','ITEM_CODE_BREAKDOWNS','AGENCY','NSG','mai.ICB_FGAC_PREDICATE','SELECT,UPDATE,DELETE',TRUE);end;                                                                              
/                                                                                                                                                                                                       
                                                                                                                                                                                                        

begin                                                                                                                                                                                                   
dbms_rls.add_policy('NSG','BUDGETS','AGENCY','NSG','mai.ICB_BUDGET_FGAC_PREDICATE','SELECT,UPDATE,DELETE',TRUE);end;                                                                                    
/                                                                                                                                                                                                       
                                                                                                                                                                                                        

begin                                                                                                                                                                                                   
dbms_rls.add_policy('NSG','WORK_ORDERS','AGENCY','NSG','mai.ICB_WO_FGAC_PREDICATE','SELECT,UPDATE,DELETE',TRUE);end;                                                                                    
/                                                                                                                                                                                                       
                                                                                                                                                                                                        
