CREATE OR REPLACE TRIGGER complete_doc_status
AFTER UPDATE
OF    def_date_compl
ON    defects
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/trg/complete_doc_status.trg-arc   3.0   Nov 05 2009 11:18:52   gjohnson  $
--       Module Name      : $Workfile:   complete_doc_status.trg  $
--       Date into PVCS   : $Date:   Nov 05 2009 11:18:52  $
--       Date fetched Out : $Modtime:   Nov 05 2009 11:15:44  $
--       Version          : $Revision:   3.0  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------

  l_doc_id docs.doc_id%type;
  l_num number;
  l_status defects.def_status_code%type;
--
  cursor get_cur_def_docs is
    select doc_id
    from   doc_assocs, docs, doc_types
 -- where  das_rec_id = :new.def_defect_id  -- siftikhar log 702699 01/02/2006
    where  das_rec_id = to_char(:new.def_defect_id)
      and  das_table_name = 'DEFECTS'
      and  das_doc_id = doc_id
      and  doc_dtp_code = dtp_code
      and  dtp_allow_complaints = 'Y';
--
  cursor get_open_def_docs is
    select 1
    from   doc_assocs, repairs
--  where  das_rec_id = rep_def_defect_id   --siftikhar log 702699 01/02/2006
--    and  das_rec_id = :new.def_defect_id
    where  das_rec_id = to_char(rep_def_defect_id)
      and  das_rec_id = to_char(:new.def_defect_id)
      and  das_table_name = 'DEFECTS'
      and  das_doc_id = l_doc_id
      and  rep_date_completed is null;
--
  cursor get_doc_status is
    select hsc_status_code
    from   hig_status_codes
    where  hsc_domain_code = 'COMPLAINTS'
      and  hsc_allow_feature4 = 'Y'
      and  sysdate between nvl(hsc_start_date, sysdate)
                       and nvl(hsc_end_date, sysdate);
--
BEGIN

  if :new.def_date_compl is not null then
     for get_cur_def_docs_rec in get_cur_def_docs LOOP
         l_doc_id := get_cur_def_docs_rec.doc_id;
         open get_open_def_docs;
         fetch get_open_def_docs into l_num;
         if get_open_def_docs%notfound then
            close get_open_def_docs;
            open get_doc_status;
            fetch get_doc_status into l_status;
            if get_doc_status%found then
               close get_doc_status;
               update docs
               set doc_status_code = l_status,
                   doc_reason = 'All Defects complete',
              doc_compl_complete = sysdate
               where doc_id = l_doc_id;
            else
               close get_doc_status;
            end if;
         else
            close get_open_def_docs;
         end if;
     end LOOP;
  end if;

END;
/
