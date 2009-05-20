rem *******************************************************************
rem	This script creates all Database Triggers for Maintenance Manager
rem *******************************************************************
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/trg/maitrgcre.sql-arc   2.2   May 20 2009 15:27:58   mhuitson  $
--       Module Name      : $Workfile:   maitrgcre.sql  $
--       Date into SCCS   : $Date:   May 20 2009 15:27:58  $
--       Date fetched Out : $Modtime:   May 18 2009 11:47:52  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.16
--
-----------------------------------------------------------------------------
--   Originally taken from @(#)maitrgcre.sql	1.24 05/13/03
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2003
-----------------------------------------------------------------------------
/*
-- THIS IS NOW DEFUNCT - SHOULD BE DEALT WITH INSIDE INV_ITEMS_ALL INSTEAD_OF_TRIGGERS

REM
PROMPT
PROMPT Creating Trigger UPDATE_INV_ITEMS_ALL
CREATE OR REPLACE TRIGGER UPDATE_INV_ITEMS_ALL
BEFORE INSERT OR UPDATE
ON INV_ITEMS_ALL
FOR EACH ROW
DECLARE
CURSOR C1 IS 		SELECT 	ITY_PNT_OR_CONT
				FROM		inv_item_types
				WHERE		ITY_INV_CODE = :new.IIT_ITY_INV_CODE
				AND		ITY_SYS_FLAG = :new.IIT_ITY_SYS_FLAG;

V_ITY_PNT_OR_CONT		VARCHAR2(1);
begin
	OPEN C1;
	FETCH C1 INTO V_ITY_PNT_OR_CONT ;
	CLOSE C1;

	IF V_ITY_PNT_OR_CONT = 'P' THEN
	     :new.IIT_END_CHAIN := :new.IIT_ST_CHAIN;
	END IF;
end;
/
*/

rem *******************************************************************
rem This trigger should ensure that whenever a record is removed from
rem the ACTIVITIES_REPORT table that all corresponding records are
rem removed for the selected activity report from the ACT_REPPORT_LINES
rem table. This trigger was introduced by HB based on the PMS log :
rem *******************************************************************

prompt Creating trigger DEL_ACT_REPORT_LINES

Create or Replace trigger DEL_ACT_REPORT_LINES
after DELETE on ACTIVITIES_REPORT
for each row
Begin
  delete
  from   act_report_lines
  where  arl_are_report_id = :old.are_report_id;
End;
/

rem *******************************************************************
rem	Inserts a def_movements record when defect status or priority
rem   changes.
rem *******************************************************************

prompt Creating trigger INSERT_DEF_MOVEMENTS

create or replace trigger INSERT_DEF_MOVEMENTS
	after	update
	of	def_status_code, def_priority
	on	defects
	for	each row
begin
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
end;
/

rem *******************************************************************
rem Inserts a scheme_history record whenever the scheme status changes
rem *******************************************************************

prompt Creating trigger INSERT_SCHEME_HISTORY

create or replace trigger INSERT_SCHEME_HISTORY
	before	insert or update
	of	status_code
	on	schemes
	for	each row
begin
  if :old.status_code is null or :new.status_code != :old.status_code
  then
    insert into scheme_history
                values (
                       :new.scheme_id,
                        sysdate,
                       :new.status_code,
                        user,
                       :new.reason);
  end if;
end;
/

prompt Creating trigger DUMMY_CONTRACT_INSERT

create or replace trigger DUMMY_CONTRACT_INSERT
	after 	insert
	on	standard_items
	for	each row
begin
  if :new.sta_rate is not null then
    insert into contract_items
    (      cni_con_id
	  ,cni_sta_item_code
	  ,cni_rate
    )
    select con_id
	  ,:new.sta_item_code
	  ,:new.sta_rate
    from   contracts
    where  con_code = (select hop_value
		       from   hig_options
		       where  hop_id = 'DUMCONCODE');
  end if;
end;
/

prompt Creating trigger DUMMY_CONTRACT_DELETE

create or replace trigger DUMMY_CONTRACT_DELETE
	after 	delete
	on	standard_items
	for	each row
begin
  delete
  from   contract_items
  where  cni_con_id = (
	 select max(con_id)
	 from   contracts
         where  con_code = (select hop_value
		            from   hig_options
		            where  hop_id = 'DUMCONCODE'))
  and    cni_sta_item_code = :old.sta_item_code;
end;
/

prompt Creating trigger DUMMY_CONTRACT_UPDATE

create or replace trigger DUMMY_CONTRACT_UPDATE
	after   update
	of      sta_rate, sta_item_code
        on      standard_items
	for     each row
begin
  if :new.sta_rate != :old.sta_rate or
     :new.sta_item_code != :old.sta_item_code then
    update contract_items
    set    cni_rate = :new.sta_rate
	  ,cni_sta_item_code = :new.sta_item_code
    where  cni_sta_item_code = :old.sta_item_code
    and    cni_con_id = (
	   select max(con_id)
	   from   contracts
	   where  con_code = (
	          select hop_id
	          from   hig_options
                  where  hop_id = 'DUMCONCODE'));
  end if;
end;
/

REM **************************************************
REM  Applicable to DoE only: sets DEF_ORIG_PRIORITY
REM  same as DEF_PRIORITY as long as status is UNAVAIL
REM **************************************************

prompt Creating trigger UPDATE_DOE_DEF_PRIORITY

create or replace trigger UPDATE_DOE_DEF_PRIORITY
        before  update
        of      def_priority
        on      defects
        for each row
        when (new.def_status_code = 'UNAVAIL')
begin
  :new.def_orig_priority := :new.def_priority;
end;
/

REM *******************************************************************
REM This trigger is a workaround that enables budget reports to work.
REM These reports necessitate an agency code be held against each road
REM group involved in cyclic maintenance, however the Maintain Road
REM Groups module does not allow entry of an agency.
REM This trigger ensures that road group agencies are automatically
REM populated from the agency of a schedule.
REM *******************************************************************

prompt Creating trigger UPDATE_RSE_AGENCY

create or replace trigger UPDATE_RSE_AGENCY
	before	insert or update
	of	schd_agency
	on	schedules
	for	each row
begin
  if :new.schd_agency != :old.schd_agency then
    update road_segs
    set    rse_agency = :new.schd_agency
    where  rse_agency is not null
    and    rse_he_id = :new.schd_rse_he_id;
  end if;
end;
/

REM *******************************************************************
REM This trigger updates maintenance manager inventory data following
REM an update to the Road Category of a Road Section.
REM This logic used to reside in NET1115/NET1125, however these modules
REM are part of Core and so cannot update maintenance manager tables
REM directly.
REM *******************************************************************
-- COMMENTED OUT BY GJ - TRIGGER NOT APPLICABLE IN v3
--prompt Creating trigger ROAD_CATEGORY_UPDATES
--
--create or replace trigger ROAD_CATEGORY_UPDATES
--	after	update
--	of	rse_road_category
--	on	road_segs
--	for	each row
--begin
--  update inv_items_all
--  set    iit_owner = decode(:new.rse_road_category,'T','1','2')
--	,iit_last_updated_date = sysdate
--  where	 iit_rse_he_id = :new.rse_he_id;
--end;
--/

prompt creating trigger WO_CLAIMS

CREATE OR REPLACE TRIGGER wo_claims
After update of wol_act_cost, wol_status_code on work_order_lines
For each row
declare
  l_today       date := sysdate;
  l_con_id      work_orders.wor_con_id%type;
  l_woc_con_id  work_order_claims.woc_con_id%type;
  l_comp_status char;
  l_claimdef    char;
  l_to_pay      claim_payments.cp_claim_value%type := :new.wol_act_cost - maiwo.claimed_so_far(:old.wol_id);
  cursor c1 is
    select wor_con_id
    from   work_orders
    where  wor_works_order_no = :new.wol_works_order_no;
  -- get the type of the last claim
  cursor get_last_claim is
    select woc_claim_ref, woc_claim_type, woc_interim_no, woc_con_id
    from   work_order_claims
          ,claim_payments
    where  woc_claim_ref = cp_woc_claim_ref
    and    cp_woc_con_id = woc_con_id
    and    cp_status != 'P'
    and    cp_wol_id = :old.wol_id
    order by woc_claim_type, woc_interim_no desc;
  cursor get_max_interim_no is
    select max(woc_interim_no) max_interim
    from   work_order_claims
          ,claim_payments
    where  woc_claim_ref = cp_woc_claim_ref
    and    cp_woc_con_id = woc_con_id
    and    cp_wol_id = :old.wol_id;
  cursor get_status is
    select decode(hsc_allow_feature3,'Y', 'F', null) complete,
           decode(hsc_allow_feature9,'Y', 'I', null) interim,
           decode(hsc_allow_feature4,'Y', 'P', null) paid
    from   hig_status_codes
    where  hsc_domain_code = 'WORK_ORDER_LINES'
    and    nvl(hsc_start_date, l_today) <= l_today
    and    nvl(hsc_end_date, l_today) >= l_today
    and    hsc_status_code = :new.wol_status_code;
  cursor c5 is
    select hop_value
    from   hig_options
    where  hop_id = 'CLAIMDEF';
    stat       get_status%rowtype;
    last_claim get_last_claim%rowtype;
    max_interim get_max_interim_no%rowtype;

procedure update_det (claim_type in work_order_claims.woc_claim_type%type)is
begin
       update work_order_claims
       set    woc_claim_date  = l_today
             ,woc_claim_value = nvl(l_to_pay, 0)
             ,woc_claim_type  = claim_type
       where  woc_claim_ref = last_claim.woc_claim_ref
       and    woc_con_id = last_claim.woc_con_id;
       update claim_payments
       set    cp_status = l_claimdef
             ,cp_claim_value = nvl(l_to_pay, 0)
       where  cp_woc_claim_ref = last_claim.woc_claim_ref
       and    cp_woc_con_id = last_claim.woc_con_id
       and    cp_wol_id = :new.wol_id;
end;
procedure insert_det (claim_type in work_order_claims.woc_claim_type%type
                     ,interim_no in number default null) is
  cursor c3 is
    select to_char(woc_ref_seq.nextval)
    from   dual;
  l_woc_ref      work_order_claims.woc_claim_ref%type;
begin
       open c3;
       fetch c3 into l_woc_ref;
       close c3;
       insert into work_order_claims (
                WOC_CLAIM_REF
               ,WOC_CON_ID
               ,WOC_CLAIM_TYPE
               ,WOC_CLAIM_DATE
               ,WOC_CLAIM_VALUE
               ,WOC_WORKS_ORDER_NO
               ,WOC_INTERIM_NO)
               values(
               l_woc_ref
              ,l_con_id
              ,claim_type
              ,l_today
              ,nvl(l_to_pay, 0)
              ,:new.wol_works_order_no
              ,interim_no);
       insert into claim_payments (
               CP_WOC_CLAIM_REF
              ,CP_WOC_CON_ID
              ,CP_WOL_ID
              ,CP_STATUS
              ,CP_CLAIM_VALUE)
              values(
              l_woc_ref
             ,l_con_id
             ,:new.wol_id
             ,l_claimdef
             ,nvl(l_to_pay, 0));
end;
begin
  open c1;
  fetch c1 into l_con_id;
  close c1;
  open c5;
  fetch c5 into l_claimdef;
  close c5;
  open get_status;
  fetch get_status into stat;
  close get_status;
  if stat.complete is not null then -- final
     open get_last_claim;
     fetch get_last_claim into last_claim;
     if get_last_claim%notfound then -- previous was a interim
       close get_last_claim;
       insert_det('F');
     else -- final interface found update quantities
       close get_last_claim;
       update_det('F');
    end if;
  elsif stat.interim is not null and stat.paid is null then -- interim status
     open get_last_claim;
     fetch get_last_claim into last_claim;
     if get_last_claim%notfound then -- previous was a interim
       close get_last_claim;
       open get_max_interim_no;
       fetch get_max_interim_no into max_interim;
       close get_max_interim_no;
       insert_det('I', nvl(max_interim.max_interim + 1, 1));
     else
       close get_last_claim;
       update_det('I');
     end if;
  end if; -- end if final
end;
/

prompt Creating trigger WOR_AUDIT

CREATE OR REPLACE TRIGGER wor_audit
After update or insert
   on work_orders
   For each row
begin
  if (inserting) then
     mai_audit.wor_create(:new.wor_works_order_no
                         ,:new.wor_peo_person_id
                         ,:new.wor_mod_by_id);
  else
     mai_audit.wor_audit_setup(:old.wor_works_order_no
                              ,:old.wor_act_cost
                              ,:old.wor_date_confirmed
                              ,:old.wor_act_cost_code
                              ,:old.wor_closed_by_id
                              ,:old.wor_con_id
                              ,:old.wor_est_complete
                              ,:old.wor_est_cost
                              ,:old.wor_last_print_date
                              ,:old.wor_priority
                              ,:old.wor_rse_he_id_group
                              ,:old.wor_score
                              ,:old.wor_peo_person_id
                              ,:old.wor_mod_by_id);

     mai_audit.wor_audit(:new.wor_works_order_no
                        ,:new.wor_act_cost
                        ,:new.wor_date_confirmed
                        ,:new.wor_act_cost_code
                        ,:new.wor_closed_by_id
                        ,:new.wor_con_id
                        ,:new.wor_est_complete
                        ,:new.wor_est_cost
                        ,:new.wor_last_print_date
                        ,:new.wor_priority
                        ,:new.wor_rse_he_id_group
                        ,:new.wor_score
                        ,:new.wor_peo_person_id
                        ,:new.wor_mod_by_id);
   end if;
end;
/

prompt Creating trigger WOL_AUDIT

CREATE OR REPLACE TRIGGER wol_audit
After update or delete or insert
   on work_order_lines
   For each row
begin
  if (inserting) then
     mai_audit.wol_create(:new.wol_works_order_no
                         ,:new.wol_id);

  elsif (deleting) then
     mai_audit.wol_delete(:old.wol_works_order_no
                         ,:old.wol_id);

  else
     mai_audit.wol_audit_setup(:old.wol_works_order_no
                              ,:old.wol_id
                              ,:old.wol_date_complete
                              ,:old.wol_est_cost
                              ,:old.wol_act_cost
                              ,:old.wol_rse_he_id
                              ,:old.wol_status_code
                              ,:old.wol_gang);

     mai_audit.wol_audit(:new.wol_works_order_no
                        ,:new.wol_id
                        ,:new.wol_date_complete
                        ,:new.wol_est_cost
                        ,:new.wol_act_cost
                        ,:new.wol_rse_he_id
                        ,:new.wol_status_code
                        ,:new.wol_gang);
  end if;

end;
/

prompt Creating trigger BOQ_AUDIT

CREATE OR REPLACE TRIGGER boq_audit
After update or delete or insert
   on boq_items
   For each row
begin

  if (inserting) then

     mai_audit.boq_create(:new.boq_id
                         ,:new.boq_wol_id);

  elsif (deleting) then

     mai_audit.boq_delete(:old.boq_id
                         ,:old.boq_wol_id);

  else
     mai_audit.boq_audit_setup(:old.boq_id
                              ,:old.boq_wol_id
                              ,:old.boq_act_cost
                              ,:old.boq_act_quantity
                              ,:old.boq_act_rate
                              ,:old.boq_est_cost
                              ,:old.boq_est_quantity
                              ,:old.boq_est_rate
                              ,:old.boq_sta_item_code);

     mai_audit.boq_audit(:new.boq_id
                        ,:new.boq_wol_id
                        ,:new.boq_act_cost
                        ,:new.boq_act_quantity
                        ,:new.boq_act_rate
                        ,:new.boq_est_cost
                        ,:new.boq_est_quantity
                        ,:new.boq_est_rate
                        ,:new.boq_sta_item_code);
  end if;

end;
/

prompt Creating trigger DELETE_DOC_DEF_TREATS

create or replace trigger DELETE_DOC_DEF_TREATS
      after delete
      on    def_treats
      for   each row
begin
  delete from doc_def_treats
  where  ddt_dtr_acty_area_code = :old.dtr_dty_acty_area_code
    and  ddt_dtr_defect_code = :old.dtr_dty_defect_code
    and  ddt_dtr_treat_code = :old.dtr_tre_treat_code
    and  ddt_dtr_sys_flag = :old.dtr_sys_flag;
end;
/


prompt Creating trigger INSERT_DOC_DEF_TREATS

create or replace trigger INSERT_DOC_DEF_TREATS
	after	insert
	on	def_treats
	for	each row
begin
  if :new.dtr_tre_treat_code is not null then
     insert into doc_def_treats
       ( ddt_dtr_acty_area_code,
         ddt_dtr_defect_code,
         ddt_dtr_treat_code,
         ddt_dtr_sys_flag,
         ddt_doc_compl_type )
     values
       ( :new.dtr_dty_acty_area_code,
         :new.dtr_dty_defect_code,
         :new.dtr_tre_treat_code,
         :new.dtr_sys_flag,
         '' );
  end if;
end;
/


prompt Creating trigger DELETE_DOC_DEF_PRIORITIES

create or replace trigger DELETE_DOC_DEF_PRIORITIES
      after delete
      on    defect_priorities
      for   each row
begin
  delete from doc_def_priorities
  where  ddp_dpr_acty_area_code   = :old.dpr_atv_acty_area_code
    and  ddp_dpr_priority         = :old.dpr_priority
    and  ddp_dpr_action_cat       = :old.dpr_action_cat
    and  ddp_dpr_int_code         = :old.dpr_int_code
    and  ddp_dpr_use_working_days = :old.dpr_use_working_days;
end;
/


prompt Creating trigger UPDATE_DOC_DEF_PRIORITIES

create or replace trigger UPDATE_DOC_DEF_PRIORITIES
	after	update
	of	dpr_int_code, dpr_use_working_days
	on	defect_priorities
	for	each row
begin
  if :new.dpr_int_code != :old.dpr_int_code or
     :new.dpr_use_working_days != :old.dpr_use_working_days then
      update doc_def_priorities
      set    ddp_dpr_int_code = :new.dpr_int_code,
             ddp_dpr_use_working_days = :new.dpr_use_working_days
      where  ddp_dpr_acty_area_code = :new.dpr_atv_acty_area_code
        and  ddp_dpr_priority       = :new.dpr_priority
        and  ddp_dpr_action_cat     = :new.dpr_action_cat;
  end if;
end;
/


prompt Creating trigger INSERT_DOC_DEF_PRIORITIES

create or replace trigger INSERT_DOC_DEF_PRIORITIES
	after	insert
	on	defect_priorities
	for	each row
begin
  if :new.dpr_priority is not null then
     insert into doc_def_priorities
       ( ddp_dpr_acty_area_code,
         ddp_dpr_priority,
         ddp_dpr_action_cat,
         ddp_doc_compl_cpr_id,
         ddp_dpr_int_code,
         ddp_dpr_use_working_days )
     values
       ( :new.dpr_atv_acty_area_code,
         :new.dpr_priority,
         :new.dpr_action_cat,
         '',
         :new.dpr_int_code,
         :new.dpr_use_working_days );
  end if;
end;
/


prompt Creating trigger DEF_UPDATE_DOC_STATUS

CREATE OR REPLACE TRIGGER DEF_UPDATE_DOC_STATUS
AFTER UPDATE OF	def_status_code	ON defects
FOR EACH ROW

DECLARE

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

prompt Creating trigger COMPLETE_DOC_STATUS

create or replace trigger COMPLETE_DOC_STATUS
	after update
	of    def_date_compl
	on    defects
	for each row
declare
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
begin
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
--
end;
/

prompt Creating trigger COMPLETE_WOR_STATUS

create or replace trigger COMPLETE_WOR_STATUS
	after update
	of    wol_status_code
	on    work_order_lines
	for each row
declare
  l_doc_id docs.doc_id%type;
  l_num number;
  l_status work_order_lines.wol_status_code%type;
--
  cursor get_cur_wor_docs is
    select doc_id
    from   doc_assocs, docs, doc_types
 -- where  das_rec_id = :new.def_defect_id  -- siftikhar log 702699 01/02/2006
    where  das_rec_id = to_char(:new.wol_works_order_no)
      and  das_table_name = 'WORK_ORDERS'
      and  das_doc_id = doc_id
      and  doc_dtp_code = dtp_code
      and  dtp_allow_complaints = 'Y';
--
  cursor get_open_wol_docs is
    select 1
    from   doc_assocs
--  where  das_rec_id = rep_def_defect_id   --siftikhar log 702699 01/02/2006
--    and  das_rec_id = :new.def_defect_id
    where  das_rec_id = to_char(:new.wol_works_order_no)
      and  das_table_name = 'WORK_ORDERS'
      and  das_doc_id = l_doc_id
      and  not exists (select 'exists'
                       from hig_status_codes
                       where hsc_domain_code = 'WORK_ORDER_LINES'
                       and :NEW.wol_status_code = hsc_status_code
                       and hsc_allow_feature3 = 'Y'
                       and sysdate between nvl(hsc_start_date, sysdate)
                       and nvl(hsc_end_date, sysdate));
--
  cursor get_doc_status is
    select hsc_status_code
    from   hig_status_codes
    where  hsc_domain_code = 'COMPLAINTS'
      and  hsc_allow_feature4 = 'Y'
      and  sysdate between nvl(hsc_start_date, sysdate)
                       and nvl(hsc_end_date, sysdate);
--
begin
  if :new.wol_status_code is not null then
     for get_cur_wor_docs_rec in get_cur_wor_docs LOOP
         l_doc_id := get_cur_wor_docs_rec.doc_id;
         open get_open_wol_docs;
         fetch get_open_wol_docs into l_num;
         if get_open_wol_docs%notfound then
            close get_open_wol_docs;
            open get_doc_status;
            fetch get_doc_status into l_status;
            if get_doc_status%found then
               close get_doc_status;
               update docs
               set doc_status_code = l_status,
                   doc_reason = 'Works Order complete',
 			 doc_compl_complete = sysdate
               where doc_id = l_doc_id;
            else
               close get_doc_status;
            end if;
         else
            close get_open_wol_docs;
         end if;
     end LOOP;
  end if;
--
end;
/

prompt Creating trigger ACTION_WOR_STATUS

create or replace trigger ACTION_WOR_STATUS
	after update
	of    wol_status_code
	on    work_order_lines
	for each row
declare
  l_doc_id docs.doc_id%type;
  l_num number;
  l_status work_order_lines.wol_status_code%type;
--
  cursor get_cur_wor_docs is
    select doc_id
    from   doc_assocs, docs, doc_types
 -- where  das_rec_id = :new.def_defect_id  -- siftikhar log 702699 01/02/2006
    where  das_rec_id = to_char(:new.wol_works_order_no)
      and  das_table_name = 'WORK_ORDERS'
      and  das_doc_id = doc_id
      and  doc_dtp_code = dtp_code
      and  dtp_allow_complaints = 'Y';
--
  cursor get_open_wol_docs is
    select 1
    from   doc_assocs
--  where  das_rec_id = rep_def_defect_id   --siftikhar log 702699 01/02/2006
--    and  das_rec_id = :new.def_defect_id
    where  das_rec_id = to_char(:new.wol_works_order_no)
      and  das_table_name = 'WORK_ORDERS'
      and  das_doc_id = l_doc_id
      and  not exists (select 'exists'
                       from hig_status_codes
                       where hsc_domain_code = 'WORK_ORDER_LINES'
                       and :NEW.wol_status_code = hsc_status_code
                       and hsc_allow_feature7 = 'Y'
                       and sysdate between nvl(hsc_start_date, sysdate)
                       and nvl(hsc_end_date, sysdate));
--
  cursor get_doc_status is
    select hsc_status_code
    from   hig_status_codes
    where  hsc_domain_code = 'COMPLAINTS'
      and  hsc_allow_feature5 = 'Y'
      and  hsc_allow_feature6 = 'N'
      and  sysdate between nvl(hsc_start_date, sysdate)
                       and nvl(hsc_end_date, sysdate);
--
begin
  if :new.wol_status_code is not null then
     for get_cur_wor_docs_rec in get_cur_wor_docs LOOP
         l_doc_id := get_cur_wor_docs_rec.doc_id;
         open get_open_wol_docs;
         fetch get_open_wol_docs into l_num;
         if get_open_wol_docs%notfound then
            close get_open_wol_docs;
            open get_doc_status;
            fetch get_doc_status into l_status;
            if get_doc_status%found then
               close get_doc_status;
               update docs
               set doc_status_code = l_status,
                   doc_reason = 'Works Order actioned',
 			 doc_compl_complete = sysdate
               where doc_id = l_doc_id;
            else
               close get_doc_status;
            end if;
         else
            close get_open_wol_docs;
         end if;
     end LOOP;
  end if;
--
end;
/

prompt Creating Trigger DEF_DUE_DATE_TIME
CREATE OR REPLACE TRIGGER DEF_DUE_DATE_TIME
AFTER INSERT OR UPDATE
OF def_priority
  ,def_time_hrs
  ,def_time_mins
ON DEFECTS
FOR EACH ROW
DECLARE
  --
  TYPE rep_rec IS RECORD(are_date_work_done activities_report.are_date_work_done%TYPE
                        ,are_rse_he_id      activities_report.are_rse_he_id%TYPE
                        ,rep_action_cat     repairs.rep_action_cat%TYPE);
  TYPE rep_tab IS TABLE OF rep_rec;
  lt_rep rep_tab;
  --
  lv_def_date   date;
  lv_action_cat repairs.rep_action_cat%TYPE;
  lv_err        number;
  lv_outdate    date;
  --
  PROCEDURE get_repairs
    IS
  BEGIN
    --
    SELECT are_date_work_done
          ,are_rse_he_id
          ,rep_action_cat
      BULK COLLECT
      INTO lt_rep
      FROM activities_report
          ,repairs
     WHERE are_report_id     = :new.def_are_report_id
       AND rep_def_defect_id = :new.def_defect_id
         ;
   --
  EXCEPTION
    WHEN no_data_found
     THEN
        NULL;
    WHEN others
     THEN
        RAISE;
  END;
  --
BEGIN
  /*
  ||Get Details Of Any Associated Repairs.
  */
  get_repairs;
  /*
  ||Recalculate The Date Due For Associated Repairs.
  */
  FOR i IN 1..lt_rep.count LOOP
    /*
    ||Calculate The Due Date.
    */
    IF ((hig.get_sysopt('REPSETPERD') = 'Y' AND :new.def_ity_sys_flag = 'D')
        OR (hig.get_sysopt('REPSETPERL') = 'Y' AND :new.def_ity_sys_flag = 'L'))
     AND (lt_rep(i).rep_action_cat = 'P' AND :new.def_priority = '1')
     AND lt_rep.count = 1
     THEN
        /*
        ||The Defect Only Has A Permanent Repair
        ||So Use The Temporary Interval To Calculate
        ||The Due Date.
        */
        lv_action_cat := 'T';
        --
    ELSE
        lv_action_cat := lt_rep(i).rep_action_cat;
    END IF;
    --
    lv_def_date := TO_DATE(TO_CHAR(TRUNC(lt_rep(i).are_date_work_done),'DD-MON-RRRR')
                           ||ltrim(to_char(:new.def_time_hrs,'09'))
                           ||ltrim(to_char(:new.def_time_mins,'09'))
                          ,'DD-MON-RRRRHH24MI');
    --
    mai.rep_date_due(p_date               => lv_def_date
                    ,p_atv_acty_area_code => :new.def_atv_acty_area_code
                    ,p_dpr_priority       => :new.def_priority
                    ,p_dpr_action_cat     => lv_action_cat
                    ,p_heid               => lt_rep(i).are_rse_he_id
                    ,p_out_date           => lv_outdate
                    ,p_error              => lv_err);
    /*
    ||Update The Repair.
    */
    UPDATE repairs
       SET rep_date_due      = lv_outdate
     WHERE rep_def_defect_id = :new.def_defect_id
       AND rep_action_cat    = lt_rep(i).rep_action_cat
         ;
    --
  END LOOP;
  --
END;
/

CREATE OR REPLACE TRIGGER Works_order_FGAC
 BEFORE INSERT ON WORK_ORDERS
FOR EACH ROW
BEGIN
   --
   -- Get Agency Context
   -- Only set the Agency code if User inserting does not have top level access
   --
   IF mai.GET_ICB_FGAC_CONTEXT(FALSE) != mai.GET_ICB_FGAC_CONTEXT(TRUE) THEN
     --
     :new.wor_agency := mai.GET_ICB_FGAC_CONTEXT(FALSE);
     --
   END IF;
   --
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END Works_order_FGAC;
/


CREATE OR REPLACE TRIGGER PRE_INSERT_DEFECTS
BEFORE INSERT
ON DEFECTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
  --
  CURSOR c1(cp_rse_he_id road_segs.rse_he_id%TYPE)
      IS
  SELECT rse_sys_flag
    FROM road_segs
   WHERE rse_he_id = cp_rse_he_id
       ;
  --
  v_sys_flag     VARCHAR2(4) := NULL;
  l_def_priority defects.def_priority%TYPE;
  --
BEGIN
  --
  BEGIN
    --
    IF hig.get_user_or_sys_opt('DEFAUTOPRI') = 'A'
     THEN
        --
        OPEN  c1(:NEW.def_rse_he_id);
        FETCH c1
         INTO v_sys_flag;
        CLOSE c1;
        --
        l_def_priority := mai.GET_AUTO_DEF_PRIORITY(p_rse_he_id     => :NEW.def_rse_he_id
                                                   ,p_network_type  =>  v_sys_flag
                                                   ,p_activity_code => :NEW.def_atv_acty_area_code
                                                   ,p_defect_code   => :NEW.def_defect_code);
        IF l_def_priority IS NOT NULL
           THEN
              :NEW.def_priority := l_def_priority;
        END IF;
        --
        v_sys_flag := NULL;
        --
    END IF;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        hig.raise_ner(pi_appl               => 'MAI'
                     ,pi_id                 => 907
                     ,pi_supplementary_info => 'Activity ['||:NEW.def_atv_acty_area_code
                                               ||'] Defect Code ['||:NEW.def_defect_code||']'
                     );
    WHEN others
     THEN
        hig.raise_ner(pi_appl => 'NET'
                     ,pi_id => 28
                     ,pi_supplementary_info => nm3flx.parse_error_message(SQLERRM));
  END;
END ;
/


SET ECHO OFF
set TERM off
--
COL run_file new_value run_file noprint
--
-------------------------------------------------------------------------
-- GJ 25-AUG-2006
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'wol_register_bs_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
-- GJ 25-AUG-2006
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'wol_register_iud_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
-- GJ 25-AUG-2006
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'wol_register_as_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
-- GJ 25-AUG-2006
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'work_orders_register_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'mai'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'claim_payment_audit_b_ud_trg.trg' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
SET define ON
SELECT '&exor_base'||'nm3'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'who_trg.sql' run_file
FROM dual
/
START '&run_file'
--
-------------------------------------------------------------------------
--
-- new triggers above this
SET TERM ON

