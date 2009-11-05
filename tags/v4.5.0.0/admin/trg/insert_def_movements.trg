CREATE OR REPLACE TRIGGER insert_def_movements
AFTER UPDATE
OF    def_status_code, def_priority
ON    defects
FOR    each row
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/insert_def_movements.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   insert_def_movements.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:08:26  $
--       Version          : $Revision:   3.0  $
--
--   Inserts a def_movements record when defect status or priority
--   changes.
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
BEGIN
 if :new.def_status_code != :old.def_status_code or
    :new.def_priority != :old.def_priority then
   insert into def_movements
    (dfm_date_mod,
     dfm_old_def_status_code,
     dfm_new_def_status_code,
     dfm_old_def_priority,
     dfm_new_def_priority,
     dfm_def_defect_id,
     dfm_peo_person_id )
   select
     sysdate,
     :old.def_status_code,
     :new.def_status_code,
     :old.def_priority,
     :new.def_priority,
     :old.def_defect_id,
     hus_user_id
   from hig_users
   where hus_username = user
   and rownum = 1;
 end if;
END;
/
