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
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/insert_def_movements.trg-arc   3.1   Jul 01 2013 15:52:52   James.Wadsworth  $
--       Module Name      : $Workfile:   insert_def_movements.trg  $
--       Date into PVCS   : $Date:   Jul 01 2013 15:52:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 13:59:40  $
--       Version          : $Revision:   3.1  $
--
--   Inserts a def_movements record when defect status or priority
--   changes.
--
-----------------------------------------------------------------------------
--    Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
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
