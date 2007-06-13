-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/icb_fgac_temp.sql-arc   2.0   Jun 13 2007 16:32:32   smarshall  $
--       Module Name      : $Workfile:   icb_fgac_temp.sql  $
--       Date into SCCS   : $Date:   Jun 13 2007 16:32:32  $
--       Date fetched Out : $Modtime:   Jun 13 2007 16:31:50  $
--       SCCS Version     : $Revision:   2.0  $
--       based on SCCS Version     : 1.1
--
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
                                                                                                                                                                                                        
