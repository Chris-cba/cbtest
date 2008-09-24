-- PVCS Identifiers :-
--
-- pvcsid : $Header:   //vm_latest/archives/mai/admin/sql/716333_fix.sql-arc   3.0   Sep 24 2008 11:04:56   jwadsworth  $
-- Module Name : $Workfile:   716333_fix.sql  $
-- Date into PVCS : $Date:   Sep 24 2008 11:04:56  $
-- Date fetched Out : $Modtime:   Sep 24 2008 11:04:32  $
-- PVCS Version : $Revision:   3.0  $
insert into hig_option_list
      (hol_id
      ,hol_product
      ,hol_name
      ,hol_remarks
      ,hol_domain
      ,hol_datatype
      ,hol_mixed_case
      ,hol_user_option) 
select 'XTRIFLDS'
      ,'MAI'
      ,'Version of Interface Files'      
      ,'If set to 2-1-3 uses additional fields on the end of the WO and WI files. Otherwise set to NA.'
      ,null
      ,'VARCHAR2'
      ,'N'
      ,'N'
  from dual
 where not exists (select 1
                     from hig_option_list
                    where hol_id = 'XTRIFLDS')
/
alter trigger hov_b_iu_trg disable;

insert into hig_option_values
      (hov_id
      ,hov_value)
select 'XTRIFLDS'
      ,'2-1-3'
  from dual
 where not exists (select 1
                     from hig_option_values
                    where hov_id = 'XTRIFLDS')
/
alter trigger hov_b_iu_trg enable;
commit
/
