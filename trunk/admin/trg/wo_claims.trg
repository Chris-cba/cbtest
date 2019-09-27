CREATE OR REPLACE TRIGGER wo_claims
AFTER UPDATE OF wol_act_cost, wol_status_code 
ON work_order_lines
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/wo_claims.trg-arc   3.3   Sep 27 2019 15:18:08   Chris.Baugh  $
--       Module Name      : $Workfile:   wo_claims.trg  $
--       Date into PVCS   : $Date:   Sep 27 2019 15:18:08  $
--       Date fetched Out : $Modtime:   Sep 27 2019 15:17:02  $
--       Version          : $Revision:   3.3  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2019 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

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


BEGIN

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

END;
/
