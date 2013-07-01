rem *******************************************************************
rem	This script creates dummy Contract details 
rem *******************************************************************

-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/dummy_contract.sql-arc   2.1   Jul 01 2013 16:00:24   James.Wadsworth  $
--       Module Name      : $Workfile:   dummy_contract.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:00:24  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:32  $
--       SCCS Version     : $Revision:   2.1  $
--
-----------------------------------------------------------------------------


prompt Creating dummy contract

insert into org_units 
( oun_org_id, oun_org_unit_type,
 oun_unit_code, oun_name ) 
select oun_org_id_seq.nextval, 'CO', 
'DUMMY', 'dummy contractor' 
from dual
where not exists (
 select 'not exists'
 from org_units
where oun_name = 'dummy contractor'
)
/

insert into contracts
  (con_id  ,con_code
  ,con_name
  ,con_admin_org_id ,con_contr_org_id
  ,con_start_date ,con_end_date
  ,con_status_code)
   select con_id_seq.nextval,'DEFAULT',
  'Dummy contract for initial estimates'
  ,1,oun_org_id,
   To_Date('01-01-1900','dd-mm-yyyy'), To_Date('31-12-2099','dd-mm-yyyy'),
  'ACTIVE' 
   from org_units
   where oun_org_unit_type = 'CO'
   and oun_unit_code = 'DUMMY'
   and not exists (select 1 from contracts
   where con_code = 'DEFAULT')
/


rem switch the dummy contract on so we can insert contract items

UPDATE HIG_OPTIONS
SET hop_value = 'DEFAULT'
WHERE hop_id = 'DUMCONCODE'
/

INSERT INTO contract_items (cni_con_id, cni_sta_item_code, cni_rate)
            SELECT con.con_id, sta.sta_item_code, NVL(sta.sta_rate,1)
            FROM standard_items sta, contracts con
            where con_code = (select hop_value
                              from hig_options
                              where hop_id = 'DUMCONCODE')
            and not exists (select 'not exists'
                            from contract_items
                            where cni_con_id = con.con_id
                            and   cni_sta_item_code = sta.sta_item_code)
/

rem turn the dummy contract off.

UPDATE HIG_OPTIONS
SET hop_value = 'DISABLED'
WHERE hop_id = 'DUMCONCODE'
/

commit
/

rem

