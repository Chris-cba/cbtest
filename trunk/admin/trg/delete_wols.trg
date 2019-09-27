CREATE OR REPLACE TRIGGER DELETE_WOLS
BEFORE DELETE
ON WORK_ORDER_LINES REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE

-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/delete_wols.trg-arc   3.4   Sep 27 2019 15:18:06   Chris.Baugh  $
--       Module Name      : $Workfile:   delete_wols.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:06  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:00  $
--       Version          : $Revision:   3.4  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

   CURSOR get_defects IS
   SELECT das_doc_id FROM doc_assocs
   WHERE das_rec_id = to_char(:old.wol_def_defect_id)
   AND das_table_name = 'DEFECTS';

   CURSOR get_pem IS
   SELECT * FROM doc_assocs
   WHERE das_table_name = 'WORK_ORDERS'
   AND das_rec_id = :old.wol_works_order_no;

   CURSOR get_doc_status IS
   select hsc_status_code
    from   hig_status_codes
    where  hsc_domain_code = 'COMPLAINTS'
      and  hsc_allow_feature7 = 'Y'
      and  sysdate between nvl(hsc_start_date, sysdate)
                       and nvl(hsc_end_date, sysdate);
                       
   lv_status_code   hig_status_codes.hsc_status_code%TYPE;

BEGIN

   For rec IN get_defects LOOP

      DELETE from doc_assocs
      WHERE  das_table_name = 'WORK_ORDER_LINES'
     AND das_rec_id = to_char(:old.wol_id)
     AND das_doc_id = rec.das_doc_id;

   END LOOP;

   -- In addition remove the work order association from the PEM
   -- and update status code
   OPEN get_doc_status;
   FETCH get_doc_status INTO lv_status_code;
   CLOSE get_doc_status;

   FOR rec IN get_pem LOOP

     DELETE FROM doc_assocs
     where das_table_name = 'WORK_ORDERS'
     AND das_rec_id = :old.wol_works_order_no
     AND das_doc_id = rec.das_doc_id;

     UPDATE docs
        SET doc_status_code = lv_status_code,
            doc_reason = 'Associated Defect Removed from Work Order '||:old.wol_works_order_no
      WHERE doc_id = rec.das_doc_id;

   END LOOP;

END DELETE_WOLS;
/
