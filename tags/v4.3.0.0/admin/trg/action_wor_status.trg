CREATE OR REPLACE TRIGGER action_wor_status
  AFTER UPDATE OF wol_status_code
  ON work_order_lines
  FOR EACH ROW
DECLARE
  -----------------------------------------------------------------------------
  --
  --   PVCS Identifiers :-
  --
  --       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/action_wor_status.trg-arc   3.1   Sep 03 2010 17:36:54   Mike.Huitson  $
  --       Module Name      : $Workfile:   action_wor_status.trg  $
  --       Date into PVCS   : $Date:   Sep 03 2010 17:36:54  $
  --       Date fetched Out : $Modtime:   Sep 03 2010 12:33:54  $
  --       Version          : $Revision:   3.1  $
  --
  --
  -----------------------------------------------------------------------------
  --    Copyright (c) exor corporation ltd, 2009
  -----------------------------------------------------------------------------
  l_doc_id  docs.doc_id%TYPE;
  l_num     NUMBER;
  l_status  work_order_lines.wol_status_code%TYPE;
  --
  CURSOR get_cur_wor_docs(cp_works_order_no  work_order_lines.wol_works_order_no%TYPE)
      IS
  SELECT doc_id
    FROM doc_assocs
        ,docs
        ,doc_types
   WHERE das_rec_id = cp_works_order_no
     AND das_table_name = 'WORK_ORDERS'
     AND das_doc_id = doc_id
     AND doc_dtp_code = dtp_code
     AND dtp_allow_complaints = 'Y'
       ;
  --
  CURSOR get_open_wol_docs(cp_works_order_no   work_order_lines.wol_works_order_no%TYPE
                          ,cp_wol_status_code  work_order_lines.wol_status_code%TYPE)
      IS
  SELECT 1
    FROM doc_assocs
   WHERE das_rec_id = cp_works_order_no
     AND das_table_name = 'WORK_ORDERS'
     AND das_doc_id = l_doc_id
     AND NOT EXISTS(SELECT 'exists'
                      FROM hig_status_codes
                     WHERE hsc_domain_code = 'WORK_ORDER_LINES'
                       AND hsc_status_code = cp_wol_status_code
                       AND hsc_allow_feature7 = 'Y'
                       AND SYSDATE BETWEEN NVL(hsc_start_date, SYSDATE)
                                       AND NVL(hsc_end_date, SYSDATE))
       ;
  --
  CURSOR get_doc_status
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'COMPLAINTS'
     AND hsc_allow_feature5 = 'Y'
     AND hsc_allow_feature6 = 'N'
     AND SYSDATE BETWEEN NVL(hsc_start_date, SYSDATE)
                     AND NVL(hsc_end_date, SYSDATE)
       ;
  --
BEGIN
  IF :new.wol_status_code IS NOT NULL
   THEN
      FOR get_cur_wor_docs_rec IN get_cur_wor_docs(:new.wol_works_order_no) LOOP
        --
        l_doc_id := get_cur_wor_docs_rec.doc_id;
        --
        OPEN  get_open_wol_docs(:new.wol_works_order_no
                               ,:new.wol_status_code);
        FETCH get_open_wol_docs
         INTO l_num;
        IF get_open_wol_docs%NOTFOUND
         THEN
            CLOSE get_open_wol_docs;
            --
            OPEN  get_doc_status;
            FETCH get_doc_status
             INTO l_status;
            IF get_doc_status%FOUND
             THEN
                CLOSE get_doc_status;
                --
                UPDATE docs
                   SET doc_status_code = l_status
                      ,doc_reason = 'Works Order actioned'
                      ,doc_compl_complete = SYSDATE
                 WHERE doc_id = l_doc_id
                   AND doc_compl_complete IS NULL
                     ;
            ELSE
                CLOSE get_doc_status;
            END IF;
        ELSE
            CLOSE get_open_wol_docs;
        END IF;
      END LOOP;
  END IF;
END;
/