CREATE OR REPLACE TRIGGER def_update_doc_status
AFTER UPDATE OF    def_status_code
ON defects
FOR EACH ROW

DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/def_update_doc_status.trg-arc   3.2   Apr 14 2011 09:41:08   Chris.Baugh  $
--       Module Name      : $Workfile:   def_update_doc_status.trg  $
--       Date into PVCS   : $Date:   Apr 14 2011 09:41:08  $
--       Date fetched Out : $Modtime:   Apr 14 2011 09:33:56  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------


   CURSOR get_def_status IS
   SELECT hsc_allow_feature10
   FROM   hig_status_codes
   WHERE  hsc_domain_code = 'DEFECTS'
   AND  hsc_allow_feature3 = 'Y'
   AND  hsc_status_code = :new.def_status_code
   AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
   AND nvl(hsc_end_date, sysdate);
--
   CURSOR get_doc_status(pi_feature6  hig_status_codes.hsc_allow_feature6%TYPE) IS
   SELECT hsc_status_code
   FROM   hig_status_codes
   WHERE  hsc_domain_code = 'COMPLAINTS'
   AND  hsc_allow_feature5 = 'Y'
   AND  hsc_allow_feature6 = pi_feature6
   AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
   AND  nvl(hsc_end_date, sysdate);
--
   lv_feature10   hig_status_codes.hsc_allow_feature10%TYPE;
   lv_row_found   BOOLEAN;
   lv_status      hig_status_codes.hsc_status_code%type;
--
BEGIN

   IF :new.def_status_code != :old.def_status_code THEN

      OPEN  get_def_status;
      FETCH get_def_status INTO lv_feature10;
      lv_row_found := get_def_status%FOUND;
      CLOSE get_def_status;

      IF lv_row_found
      THEN
         OPEN  get_doc_status(lv_feature10);
         FETCH get_doc_status INTO lv_status;
         lv_row_found := get_doc_status%FOUND;
         CLOSE get_doc_status;

         IF lv_row_found
         THEN
            IF lv_feature10 = 'Y' -- Defect SELECTED onto WO
            THEN
            
               INSERT INTO doc_assocs
               (das_table_name, das_rec_id, das_doc_id)
               SELECT 'WORK_ORDERS', :new.def_works_order_no, d.doc_id
               FROM   docs d
               WHERE  d.doc_id IN (SELECT das_doc_id
                                   FROM   doc_assocs
                                   WHERE  das_rec_id = TO_CHAR(:new.def_defect_id)
                                   AND  das_table_name = 'DEFECTS')
               AND NOT EXISTS (SELECT 1 FROM doc_assocs
                               WHERE das_table_name = 'WORK_ORDERS'
                               AND   das_rec_id = :new.def_works_order_no
                               AND   das_doc_id = d.doc_id);
           ELSE
              UPDATE docs
              SET  doc_status_code = lv_status,
                   doc_reason      = 'Work Order Instructed : '||:new.def_works_order_no
              WHERE  doc_id IN (SELECT das_doc_id
                                FROM   doc_assocs
                                WHERE  das_rec_id = TO_CHAR(:new.def_defect_id)
                                AND  das_table_name = 'DEFECTS')
              AND  doc_status_code IN (SELECT hsc_status_code
                                       FROM   hig_status_codes
                                       WHERE  hsc_domain_code = 'COMPLAINTS'
                                       AND  hsc_allow_feature6 = 'Y'
                                       AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
                                                                AND nvl(hsc_end_date, sysdate));

           END IF;
        END IF;

     END IF;

  END IF;

END;

/
