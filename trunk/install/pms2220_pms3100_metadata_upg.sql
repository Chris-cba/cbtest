-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/pms2220_pms3100_metadata_upg.sql-arc   2.1   Jul 01 2013 16:03:54   James.Wadsworth  $
--       Module Name      : $Workfile:   pms2220_pms3100_metadata_upg.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:03:54  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

SET FEEDBACK OFF
--
DECLARE
  l_temp nm3type.max_varchar2;
BEGIN
  -- Dummy call to HIG to instantiate it
  l_temp := hig.get_version;
  l_temp := nm_debug.get_version;
EXCEPTION
  WHEN others
   THEN
     Null;
END;
/
--
--
-- DATA UPDATES
--
rem --------------------------------------------------------------------------
rem	Create a role for granting to the structural projects administrator.

prompt create role pms_admin;
create role pms_admin;

grant select any table to pms_admin;
grant insert any table to pms_admin;
grant update any table to pms_admin;
grant delete any table to pms_admin;
grant lock any table to pms_admin;
grant create any table to pms_admin;
grant create any view to pms_admin;
grant execute any procedure to pms_admin;
grant select any sequence to pms_admin;
grant create session to pms_admin;


rem --------------------------------------------------------------------------
rem	Create a role for granting to users who need update privileges.

prompt create role pms_user;
create role pms_user;

grant select any table to pms_user;
grant insert any table to pms_user;
grant update any table to pms_user;
grant delete any table to pms_user;
grant lock any table to pms_user;
grant create table to pms_user;
grant create view  to pms_user;
grant select any sequence to pms_user;
grant execute any procedure to pms_user;
grant create session to pms_user;


rem --------------------------------------------------------------------------
rem	Create a role for granting to readonly users.

prompt create role pms_readonly;
create role pms_readonly;

grant select any table to pms_readonly;
grant lock any table to pms_readonly;
grant create table to pms_readonly;
grant create view  to pms_readonly;
grant select any sequence to pms_readonly;
grant execute any procedure to pms_readonly;
grant create session to pms_readonly;

grant insert,update,delete on pbi_query to pms_readonly;
grant insert,update,delete on pbi_query_attribs to pms_readonly;
grant insert,update,delete on pbi_query_types to pms_readonly;
grant insert,update,delete on pbi_results to pms_readonly;
grant insert,update,delete on temp_pms4440_comments to pms_readonly;
grant insert,update,delete on temp_pms4440_compschemes to pms_readonly;
grant insert,update,delete on temp_pms4440_defbands to pms_readonly;
grant insert,update,delete on temp_pms4440_defects to pms_readonly;
grant insert,update,delete on temp_pms4440_defect_list to pms_readonly;
grant insert,update,delete on temp_pms4440_dettrts to pms_readonly;
grant insert,update,delete on temp_pms4440_report_sections to pms_readonly;
grant insert,update,delete on temp_pms4440_roadcons to pms_readonly;
grant insert,update,delete on temp_pms4440_strip_data to pms_readonly;
grant insert,update,delete on temp_pms4440_strip_header to pms_readonly;
grant insert,update,delete on temp_pms4440_strip_list to pms_readonly;
rem --------------------------------------------------------------------------
--
update HIG_OPTIONS 
set HOP_PRODUCT = 'PMS'
where HOP_ID = 'ADMINLEVEL'
and exists (
           select 'exists'
           from HIG_OPTIONS
           where HOP_PRODUCT = 'STP'
           and HOP_ID = 'ADMINLEVEL'
           );
--
update HIG_OPTIONS 
set HOP_PRODUCT = 'PMS'
where HOP_ID = 'ACTTOSCHEM'
and exists (
           select 'exists'
           from HIG_OPTIONS
           where HOP_PRODUCT = 'STP'
           and HOP_ID = 'ACTTOSCHEM'
           );
--
delete from HIG_PRODUCTS
where HPR_PRODUCT = 'PMS'
and exists (
           select 'exists'
           from HIG_PRODUCTS
           where HPR_PRODUCT = 'PMS'
           );
--           
insert into HIG_PRODUCTS (
HPR_PRODUCT
,HPR_PRODUCT_NAME
,HPR_VERSION
,HPR_PATH_NAME
,HPR_KEY
,HPR_SEQUENCE
) select
'PMS'
,'structural projects v2'
,'3.0.9.0'
,''
,null
,20
from dual
where not exists (
 select 'not exists'
 from HIG_PRODUCTS
where HPR_PRODUCT = 'PMS'
);
--
insert into HIG_ROLES (
HRO_ROLE
,HRO_PRODUCT
,HRO_DESCR
) select
'PMS_ADMIN'
,'PMS'
,'Structural Projects Administration'
from dual
where not exists (
 select 'not exists'
 from HIG_ROLES
where HRO_ROLE = 'PMS_ADMIN'
);
--
insert into HIG_ROLES (
HRO_ROLE
,HRO_PRODUCT
,HRO_DESCR
) select
'PMS_USER'
,'PMS'
,'Structural Projects Updates'
from dual
where not exists (
 select 'not exists'
 from HIG_ROLES
where HRO_ROLE = 'PMS_USER'
);
--
insert into HIG_ROLES (
HRO_ROLE
,HRO_PRODUCT
,HRO_DESCR
) select
'PMS_READONLY'
,'PMS'
,'Structural Projects Readonly Access'
from dual
where not exists (
 select 'not exists'
 from HIG_ROLES
where HRO_ROLE = 'PMS_READONLY'
);
--
--
DECLARE
--
--  HIG_MODULES and HIG_MODULE_ROLES
--
   TYPE tab_rec_module IS TABLE OF hig_modules%ROWTYPE INDEX BY BINARY_INTEGER;
--
   l_rec_hmo     hig_modules%ROWTYPE;
   l_tab_rec_hmo tab_rec_module;
--
   l_tab_hmr_module nm3type.tab_varchar30;
   l_tab_hmr_role   nm3type.tab_varchar30;
   l_tab_hmr_mode   nm3type.tab_varchar30;
--
   l_hmo_count      PLS_INTEGER := 0;
   l_hmr_count      PLS_INTEGER := 0;
--
   PROCEDURE add_hmo IS
   BEGIN
      l_hmo_count := l_hmo_count + 1;
      l_tab_rec_hmo(l_hmo_count) := l_rec_hmo;
   END add_hmo;
--
   PROCEDURE add_hmr (p_role   VARCHAR2
                     ,p_mode   VARCHAR2
                     ,p_module VARCHAR2 DEFAULT l_rec_hmo.hmo_module
                     ) IS
   BEGIN
      l_hmr_count := l_hmr_count + 1;
      l_tab_hmr_module(l_hmr_count) := UPPER(p_module);
      l_tab_hmr_role(l_hmr_count)   := UPPER(p_role);
      l_tab_hmr_mode(l_hmr_count)   := UPPER(p_mode);
   END add_hmr;
--
BEGIN
--
   l_rec_hmo.hmo_module           := 'PMS4408';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal);
   add_hmr('PMS_USER',nm3type.c_normal);
   --
   l_rec_hmo.hmo_module           := 'PMS4404';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal);
   add_hmr('PMS_USER',nm3type.c_normal);
   --
   l_rec_hmo.hmo_module           := 'PMS4440';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_USER',nm3type.c_normal);
   --
   l_rec_hmo.hmo_module           := 'PMS4448';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal);
   add_hmr('PMS_USER',nm3type.c_normal);
   --
   l_rec_hmo.hmo_module           := 'PMS4442';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal);
   add_hmr('PMS_USER',nm3type.c_normal);
   --
   l_rec_hmo.hmo_module           := 'PMS4444';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal); 
   add_hmr('PMS_USER',nm3type.c_normal);        
   --
   l_rec_hmo.hmo_module           := 'PMS4400';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal);  
   add_hmr('PMS_USER',nm3type.c_normal); 
   --
   l_rec_hmo.hmo_module           := 'PMS4402';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal); 
   add_hmr('PMS_USER',nm3type.c_normal);  
   --
   l_rec_hmo.hmo_module           := 'PMS4406';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal); 
   add_hmr('PMS_USER',nm3type.c_normal);  
   --
   l_rec_hmo.hmo_module           := 'PMS4410';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal); 
   add_hmr('PMS_USER',nm3type.c_normal);  
   --
   l_rec_hmo.hmo_module           := 'PMS4412';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal);   
   add_hmr('PMS_USER',nm3type.c_normal);    
   --
   l_rec_hmo.hmo_module           := 'PMS4414';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal);  
   add_hmr('PMS_USER',nm3type.c_normal);     
   --
   l_rec_hmo.hmo_module           := 'PMS4416';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_ADMIN',nm3type.c_normal); 
   add_hmr('PMS_USER',nm3type.c_normal);      
   --
   l_rec_hmo.hmo_module           := 'PMS4442';
   l_rec_hmo.hmo_application      := nm3type.c_net;
   add_hmo;
   add_hmr('PMS_USER',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI2310';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI3881';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI1400';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI1920';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI3664';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI1910';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI7040';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI1200';   
   add_hmr('PMS_ADMIN',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI2310';   
   add_hmr('PMS_USER',nm3type.c_normal);       
--
   l_rec_hmo.hmo_module           := 'MAI3881';   
   add_hmr('PMS_USER',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI1400';   
   add_hmr('PMS_USER',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI1920';   
   add_hmr('PMS_USER',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI3664';   
   add_hmr('PMS_USER',nm3type.c_normal);       
   --
   l_rec_hmo.hmo_module           := 'MAI1910';   
   add_hmr('PMS_USER',nm3type.c_normal);     
   --
   l_rec_hmo.hmo_module           := 'MAI7040';   
   add_hmr('PMS_USER',nm3type.c_normal);     
   --
   l_rec_hmo.hmo_module           := 'MAI1200';   
   add_hmr('PMS_USER',nm3type.c_normal);     
--
   FOR i IN 1..l_hmo_count
    LOOP
      l_rec_hmo := l_tab_rec_hmo(i);
      update HIG_MODULES
         set HMO_APPLICATION = l_rec_hmo.hmo_application
       where HMO_MODULE = l_rec_hmo.hmo_module
         and exists (
                    select 'exists'
                      from HIG_MODULES
                     where HMO_APPLICATION = 'STP'
                       and HMO_MODULE = l_rec_hmo.hmo_module
                    );
   END LOOP;
--
   FORALL i IN 1..l_hmr_count
      update HIG_MODULE_ROLES
         set HMR_ROLE = l_tab_hmr_role(i)
       where HMR_MODULE = l_tab_hmr_module(i)
         and exists (
                    select 'exists'
                      from HIG_MODULE_ROLES
                     where HMR_ROLE = 'STP_ADMIN'
                       and HMR_MODULE = l_tab_hmr_module(i)
                    )
         AND EXISTS (
                    SELECT 1
                     FROM  hig_roles
                    WHERE  hro_role   = l_tab_hmr_role(i)
                    )
         AND EXISTS (
                    SELECT 1
                     FROM  hig_modules
                    WHERE  hmo_module = l_tab_hmr_module(i)
                    );   
--
END;
/
