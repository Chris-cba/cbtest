CREATE OR REPLACE TRIGGER def_update_doc_status
AFTER UPDATE OF    def_status_code
ON defects
FOR EACH ROW

DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/def_update_doc_status.trg-arc   3.0   Nov 05 2009 11:18:50   gjohnson  $
--       Module Name      : $Workfile:   def_update_doc_status.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:50  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:15:16  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------


   CURSOR get_def_status IS
   SELECT 1
   FROM   hig_status_codes
   WHERE  hsc_domain_code = 'DEFECTS'
   AND  hsc_allow_feature3 = 'Y'
   AND  hsc_status_code = :new.def_status_code
   AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
   AND nvl(hsc_end_date, sysdate);
--
   CURSOR get_doc_status IS
   SELECT hsc_status_code
   FROM   hig_status_codes
   WHERE  hsc_domain_code = 'COMPLAINTS'
   AND  hsc_allow_feature5 = 'Y'
   AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
   AND nvl(hsc_end_date, sysdate);
--
   lnum    number;
   lstatus hig_status_codes.hsc_status_code%type;
--
BEGIN

   IF :new.def_status_code != :old.def_status_code THEN

      OPEN  get_def_status;
      FETCH get_def_status INTO lnum;
      IF get_def_status%FOUND THEN

         CLOSE get_def_status;

         OPEN  get_doc_status;
         FETCH get_doc_status INTO lstatus;
         IF get_doc_status%FOUND THEN

            CLOSE get_doc_status;

            INSERT INTO doc_assocs
            (das_table_name, das_rec_id, das_doc_id)
            SELECT 'WORK_ORDERS', :new.def_works_order_no, d.doc_id
            FROM   docs d
            WHERE  d.doc_id IN (SELECT das_doc_id
                                FROM   doc_assocs
                                WHERE  das_rec_id = TO_CHAR(:new.def_defect_id)
                                AND  das_table_name = 'DEFECTS')
            AND  d.doc_status_code IN (SELECT hsc_status_code
                                       FROM   hig_status_codes
                                       WHERE  hsc_domain_code = 'COMPLAINTS'
            AND  (hsc_allow_feature6 = 'Y'
               OR hsc_allow_feature5 = 'Y')
            AND  sysdate BETWEEN nvl(hsc_start_date, sysdate)
            AND nvl(hsc_end_date, sysdate))
            AND NOT EXISTS (SELECT 1 FROM doc_assocs
                            WHERE das_table_name = 'WORK_ORDERS'
                            AND   das_rec_id = :new.def_works_order_no
                            AND   das_doc_id = d.doc_id);

           UPDATE docs
           SET  doc_status_code = lstatus,
                doc_reason      =  'Work Order Raised : '||:new.def_works_order_no
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

        ELSE

           CLOSE get_doc_status;

        END IF;

     ELSE

        CLOSE get_def_status;

     END IF;

  END IF;

END;

/
