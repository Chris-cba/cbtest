CREATE OR REPLACE package body maiwo is
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/maiwo.pkb-arc   2.14   May 02 2019 09:47:40   Chris.Baugh  $
--       Module Name      : $Workfile:   maiwo.pkb  $
--       Date into SCCS   : $Date:   May 02 2019 09:47:40  $
--       Date fetched Out : $Modtime:   May 02 2019 09:44:34  $
--       SCCS Version     : $Revision:   2.14  $
--       Based onSCCS Version     : 1.6
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maiwo.pck	1.13 08/04/03'
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

--g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '$Revision:   2.14  $';

  g_package_name CONSTANT varchar2(30) := 'maiwo';

  cursor get_top_id(p_boq_item in boq_items.boq_id%type) is
  select boq_id
  from   boq_items boq
  where  boq_parent_id is null
  connect by prior boq_parent_id = boq_id
  start with              boq_id = p_boq_item;

--
-----------------------------------------------------------------------------
--
  function get_version return varchar2 is
  begin
     return g_sccsid;
  end;
--
-----------------------------------------------------------------------------
--

  FUNCTION get_body_version RETURN varchar2 IS
  BEGIN
    RETURN g_body_sccsid;
  END get_body_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_next_id(pi_seq_name IN VARCHAR2)
  RETURN NUMBER IS
  --
  lv_query_string varchar2(1000) := 'SELECT '||pi_seq_name||'.nextval FROM dual';
  lv_seq_no number;
  --
BEGIN
  --
  EXECUTE IMMEDIATE lv_query_string INTO lv_seq_no;
  --
  RETURN lv_seq_no;
  --
END get_next_id;
--
-----------------------------------------------------------------------------
--
  -- get the computation method for a boq item
  function get_perc_item_comp(p_boq_id in boq_items.boq_id%type)
  return varchar2 is

  cursor get_wo_comp is
  select wor_perc_item_comp
  from   work_orders
        ,work_order_lines
        ,boq_items
  where  wor_works_order_no = wol_works_order_no
  and    wol_id = boq_wol_id
  and    boq_id = p_boq_id;

  l_retval      work_orders.wor_perc_item_comp%type;
  begin
    open get_wo_comp;
    fetch get_wo_comp into l_retval;
    close get_wo_comp;
    if l_retval is null then
        return hig.get_sysopt('CUM_PERC');
    else
      return l_retval;
    end if;

  end;

---------------------------------------------------------------------
-- Returns True if the all the WOLs on the WO in question are complete
-- ie. have a completed date. Return type is varchar2 and not boolean
-- so the function can be used in SQL statements
--
--  last 2 parameters are ignored, but are included for compatability with older versions of mai3800

  function works_order_complete (
    p_works_order_no in work_orders.wor_works_order_no%type)
   return varchar2 is

    cursor c1 is
      select 1
      from work_order_lines w
      where w.wol_works_order_no = p_works_order_no
      and not exists (
      select 'x' from hig_status_codes h
      where h.hsc_domain_code = 'WORK_ORDER_LINES'
      and (h.hsc_allow_feature2 = 'Y'
      or   h.hsc_allow_feature3 = 'Y'
      or   (h.hsc_allow_feature4 = 'Y' and h.hsc_allow_feature9 = 'N')
      or   h.hsc_allow_feature5 = 'Y')
      and h.hsc_status_code = w.wol_status_code
      and sysdate between nvl(h.hsc_start_date, sysdate) and  nvl(h.hsc_end_date, sysdate)
      );

    l_dummy number;

  begin

    open  c1;
    fetch c1 into l_dummy;
    if c1%found then
      close c1;
      return 'FALSE';  -- uncompleted lines exist
    end if;
    close c1;

    select count(0)
    into   l_dummy
    from   work_order_lines
    where  wol_works_order_no = p_works_order_no;

    if l_dummy = 0 then
      return 'FALSE';  -- no lines exist
    end if;

    return 'TRUE';     -- all lines complete (or not done)

  end;


---------------------------------------------------------------------
-- Calculates any balancing sum applicable
--

  function bal_sum
      ( p_cost           work_orders.wor_est_cost%type
       ,p_cng_disc_group org_units.oun_cng_disc_group%type)
    return number is

    l_discount contractor_disc_bands.cnb_discount%type;

    cursor c1 is
      select cnb_discount
      from   contractor_disc_bands
      where  p_cost between cnb_min_value and cnb_max_value
      and    cnb_cng_disc_group = p_cng_disc_group;
     
     --
     -- TASK 0108061 LS 01/10/09
     -- Apply accumulative discount if the Discount band is Accumulative
     --
     CURSOR c_acc_disc
     IS
     SELECT 'x'
     FROM   contractor_disc_groups
     WHERE  cng_disc_group = p_cng_disc_group
     AND    Nvl(cng_accumulative_disc,'N') = 'Y';
     l_acc_flag  Varchar2(1);
     l_cost      Number := p_cost ;
     l_acc_disc  Number := 0 ; 
     l_cnt       Number := 0 ;
     --     
  begin

    if nvl(p_cost,0) = 0 then

      -- since cost is zero anyway theres no point in
      -- getting a discount
      return 0;

    else
        --
        -- TASK 0108061
        OPEN  c_acc_disc;
        FETCH c_acc_disc INTO l_acc_flag  ;
        IF c_acc_disc%FOUND
        THEN
            CLOSE c_acc_disc;            
            FOR i IN (SELECT   * 
                      FROM     contractor_disc_bands 
                      WHERE    cnb_cng_disc_group = p_cng_disc_group
                      ORDER BY cnb_min_value)
            LOOP
                l_cnt := l_cnt + 1 ; 
                l_cost := l_cost - (i.cnb_max_value -i.cnb_min_value) ;
                IF l_cost <= 0
                THEN
                    IF l_cnt = 1
                    THEN
                        l_acc_disc := l_acc_disc +  round(p_cost * -1 * ( nvl(i.cnb_discount,0)/100 ), 2);
                    ELSE
                        l_cost := l_cost + (i.cnb_max_value -i.cnb_min_value); 
                        l_acc_disc := l_acc_disc +  round(l_cost * -1 * ( nvl(i.cnb_discount,0)/100 ), 2);
                    END IF ;                            
                    Exit;
                ELSE
                    l_acc_disc := l_acc_disc +  round((i.cnb_max_value -i.cnb_min_value) * -1 * ( nvl(i.cnb_discount,0)/100 ), 2);
                END IF ;
            END LOOP;
            Return l_acc_disc ;           
        ELSE
        --
            CLOSE c_acc_disc;
            -- need to select discount according to org_id and value
            open c1;
            fetch c1 into l_discount;
            close c1;

            -- apply discount to get a negative balance
            return round(p_cost * -1 * ( nvl(l_discount,0)/100 ), 2);
        END IF ;
    end if;
  end;


---------------------------------------------------------------------
-- Updates the completed date on defect and repairs.
--
PROCEDURE update_defect_date(p_def_id         IN defects.def_defect_id%TYPE
                            ,p_date_compl     IN defects.def_date_compl%TYPE
                            ,p_works_order_no IN work_orders.wor_works_order_no%TYPE
                            ,p_wol_id         IN work_order_lines.wol_id%TYPE DEFAULT 0
                            ,p_hour_compl     IN NUMBER DEFAULT 0
                            ,p_mins_compl     IN NUMBER DEFAULT 0)
  IS
  --
  l_today date := SYSDATE;
  ldate repairs.rep_date_completed%TYPE;
  --
  CURSOR c1(cp_def_id defects.def_defect_id%TYPE)
      IS
  SELECT MAX(rep_date_completed)
    FROM repairs
   WHERE rep_def_defect_id = cp_def_id
       ;
  --
BEGIN
  --
  IF (p_wol_id is not null and p_wol_id <> 0)
   THEN
      UPDATE repairs
         SET rep_date_completed = p_date_compl
            ,rep_completed_hrs  = DECODE(p_date_compl,NULL,NULL,p_hour_compl)
            ,rep_completed_mins = DECODE(p_date_compl,NULL,NULL,p_mins_compl)
            ,rep_last_updated_date = l_today
       WHERE rep_def_defect_id IN(SELECT wol.wol_def_defect_id
                                    FROM work_order_lines wol
                                   WHERE wol.wol_def_defect_id = p_def_id
                                     AND wol.wol_def_defect_id = rep_def_defect_id
                                     AND wol.wol_rep_action_cat = rep_action_cat
                                     AND wol.wol_id = p_wol_id)
           ;
  ELSE
      UPDATE repairs
         SET rep_date_completed = p_date_compl
            ,rep_completed_hrs  = decode(p_date_compl,null,null,p_hour_compl)
            ,rep_completed_mins = decode(p_date_compl,null,null,p_mins_compl)
            ,rep_last_updated_date = l_today
       WHERE rep_def_defect_id IN(SELECT wol.wol_def_defect_id
                                    FROM work_order_lines wol
                                   WHERE wol.wol_def_defect_id = p_def_id
                                     AND wol.wol_works_order_no = p_works_order_no
                                     AND wol.wol_def_defect_id = rep_def_defect_id
                                     AND wol.wol_rep_action_cat = rep_action_cat)
           ;
  END IF;
  --
  IF p_date_compl IS NOT NULL
   THEN
      OPEN  c1(p_def_id);
      FETCH c1
       INTO ldate;
      CLOSE c1;
      --
      UPDATE defects
         SET def_date_compl = ldate
            ,def_last_updated_date = l_today
       WHERE def_defect_id = p_def_id
         AND NOT EXISTS(SELECT 1
                          FROM repairs
                         WHERE rep_def_defect_id = def_defect_id
                           AND rep_date_completed is null)
           ;
  ELSE
      UPDATE defects
         SET def_date_compl = p_date_compl
            ,def_last_updated_date = l_today
       WHERE def_defect_id = p_def_id
           ;
  END IF;
  --
END update_defect_date;
---------------------------------------------------------------------
-- Updates the contract item usage figures.
--

  procedure adjust_contract_figures (p_wol_id    in work_order_lines.wol_id%type
                                    ,p_con_id    in contracts.con_id%type
                                    ,p_operation in varchar2 ) is
    cursor c1 is
      select boq_sta_item_code
            ,boq_act_quantity
            ,boq_act_cost
      from   boq_items
      where  boq_wol_id = p_wol_id;

    l_item_code boq_items.boq_sta_item_code%type;
    l_quantity  boq_items.boq_act_quantity%type;
    l_cost      boq_items.boq_act_cost%type;

  begin

    open c1;
    loop

      fetch c1 into l_item_code
                   ,l_quantity
                   ,l_cost;
      exit when c1%notfound;

      update contract_items
      set    cni_usage_count = nvl(cni_usage_count, 0) +
                               decode(p_operation, '+', 1, -1)
            ,cni_usage_quantity = nvl(cni_usage_quantity, 0) +
                                  decode(p_operation, '+', l_quantity,
                                  -l_quantity)
            ,cni_usage_cost = nvl(cni_usage_cost, 0) +
                              decode(p_operation, '+', l_cost, -l_cost)
      where  cni_sta_item_code = l_item_code
      and    cni_con_id = p_con_id;

    end loop;
    close c1;

  end;

  function previous_payment(p_wol_id            claim_payments.cp_wol_id%type
                           ,p_current_claim_ref work_order_claims.woc_claim_ref%type)
     return number is

    cursor c1 is
      select cp1.cp_claim_value
      from   claim_payments cp1
            ,work_order_claims woc1
      where  cp1.cp_wol_id = p_wol_id
      and    cp1.cp_woc_claim_ref = woc1.woc_claim_ref
      and    cp1.cp_woc_con_id = woc1.woc_con_id
      and    exists (select 1
                     from  hig_status_codes hsc
                     where hsc.hsc_domain_code = 'CLAIM STATUS'
                     and   hsc.hsc_allow_feature3 = 'Y'
                     and   hsc.hsc_status_code = cp1.cp_status)
      and    woc1.woc_claim_type = 'I'
      and    woc1.woc_interim_no = (select max(woc2.woc_interim_no)
                                    from   work_order_claims woc2
                                          ,claim_payments cp2
                                    where  woc2.woc_claim_ref = cp2.cp_woc_claim_ref
                                    and    woc2.woc_con_id = cp2.cp_woc_con_id
                                    and    woc2.woc_claim_type = 'I'
                                    and    exists (select 1
                                                   from  hig_status_codes hsc
                                                   where hsc.hsc_domain_code = 'CLAIM STATUS'
                                                   and   hsc.hsc_allow_feature3 = 'Y'
                                                   and   hsc.hsc_status_code = cp2.cp_status)
                                    and    cp2.cp_wol_id = cp1.cp_wol_id
                                    and    cp2.cp_woc_claim_ref != p_current_claim_ref);

    l_value claim_payments.cp_claim_value%type;

  begin

    open c1;
    fetch c1 into l_value;
    if c1%found then
      close c1;
      return l_value;
    else
      close c1;
      return 0;
    end if;

  end;

  function wol_invoice_status(p_wol_id work_order_lines.wol_id%type) return varchar2 is

    cursor c1 is
    select sum(decode(cp_status, 'A', 1, 0)) no_of_approved_invoices
          ,sum(decode(cp_status, 'H', 1, 0)) no_of_held_invoices
          ,sum(decode(cp_status, 'P', 1, 0)) no_of_paid_invoices
    from   claim_payments
    where  cp_wol_id = p_wol_id;

    l_no_approved number;
    l_no_held     number;
    l_no_paid     number;

  begin

    open c1;
    fetch c1 into l_no_approved
                 ,l_no_held
                 ,l_no_paid;
    close c1;

    if l_no_approved = 0 and l_no_held = 0 and l_no_paid = 0 then
      return null; -- No invoices processed.
    elsif l_no_approved > 0 and l_no_held > 0 then
      return 'B'; -- Both held and outstanding records exist.
    elsif l_no_approved > 0 and l_no_held = 0 then
      return 'O'; -- At least one outstanding record exists.
    elsif l_no_approved = 0 and l_no_held > 0 then
      return 'H'; -- At least one held record exists.
    elsif l_no_approved = 0 and l_no_held = 0 and l_no_paid > 0 then
      return 'A'; -- Only paid records exist.
    end if;

    return null;

  end;

  function final_already_paid(p_wol_id work_order_lines.wol_id%type) return varchar2 is

    cursor c1 is
    select 1
    from   claim_payments
          ,work_order_claims
    where  woc_con_id = cp_woc_con_id
    and    woc_claim_ref = cp_woc_claim_ref
    and    woc_claim_type = 'F'
    and    exists (select 1
                   from  hig_status_codes hsc
                   where hsc.hsc_domain_code = 'CLAIM STATUS'
                   and   hsc.hsc_allow_feature3 = 'Y'
                   and   hsc.hsc_status_code = cp_status)
    and    cp_wol_id = p_wol_id;

    l_dummy number(1);

  begin

    open c1;
    fetch c1 into l_dummy;
    if c1%found then
      close c1;
      return 'TRUE';
    end if;
    close c1;
    return 'FALSE';

  end;

-- Checks if user can complete WOL. Check based on value of product option
-- COMPWOLEL. If COMPWOLEL set to N and the contractor uses electronic interfaces
-- then you cannot complete the WOL

  function can_complete_wol(p_works_order_no in work_orders.wor_works_order_no%type)
  return varchar2 is

  cursor c1 is
  select nvl(oun_electronic_orders_flag,'N')
  from   work_orders
        ,contracts
        ,org_units
  where  wor_works_order_no = p_works_order_no
  and    wor_con_id         = con_id
  and    oun_org_id         = con_contr_org_id;

  v_elec_ord varchar2(1);
  v_prod_option varchar2(1);
  begin

    -- check if COMPWOLEL product option is set
    v_prod_option := hig.get_sysopt('COMPWOLEL');

    if (v_prod_option = 'Y') then
      return 'TRUE';
    else
      open c1;
      fetch c1 into v_elec_ord;
      if (c1%notfound) then -- this really shouldn't occur a WOL should always have a org_unit
         close c1;
         return 'FALSE';
      end if;
      close c1;
      -- if org_unit has electronic orders set then cannot complete WOL
      if (v_elec_ord = 'Y') then
         return 'FALSE';
      else
         return 'TRUE';
      end if;
    end if;
  end;

  function get_boq_id_seq
  return number is

  cursor get_id is
  select boq_id_seq.nextval
  from   dual;

  no_such_sequence Exception;
  pragma exception_init(no_such_sequence, -2289);
  retval boq_items.boq_id%type;
  begin
    open get_id;
    fetch get_id into retval;
    close get_id;
    return retval;
  exception when no_such_sequence then
    return null;
  end;
--
------------------------------------------------------------------------------
--
FUNCTION create_interim_payment(p_wol_id work_order_lines.wol_id%TYPE
                               ,p_act_cost IN work_order_lines.wol_act_cost%TYPE)
RETURN BOOLEAN IS
  --
  CURSOR get_all_boqs
      IS
  SELECT boq_id
        ,NVL(boq_act_cost,0) boq_act_cost
    FROM boq_items
   WHERE boq_wol_id = p_wol_id
       ;
  --
  CURSOR get_last_interim(p_boq_id wol_interim_payments.WIP_BOQ_ID%TYPE)
      IS
  SELECT wip_int_id
        ,wip_status
    FROM wol_interim_payments
   WHERE wip_wol_id = p_wol_id
     AND wip_boq_id = p_boq_id
   ORDER
      BY wip_int_id DESC
       ;
  --
  CURSOR get_user
      IS
  SELECT hus_user_id
    FROM hig_users
   WHERE hus_username = USER
       ;
  --
  user_id        get_user%ROWTYPE;
  last_int       get_last_interim%ROWTYPE;
  l_act_cost     work_order_lines.wol_act_cost%TYPE;
  lv_retval      BOOLEAN := TRUE;
  lv_neginterim  hig_option_values.hov_value%TYPE := NVL(hig.get_sysopt('NEGINTERIM'),'N');
  --
BEGIN
  /*
  ||If The Product Option Is Not Set To 'Y'
  ||Make Sure That The New Valuation Is Not
  ||Lower Than Has Been Paid So Far.
  */
  IF lv_neginterim != 'Y'
   THEN
      IF p_act_cost < claimed_so_far(p_wol_id)
       THEN
          lv_retval := FALSE;
      END IF;
  END IF;
  --
  IF lv_retval
   THEN
      --
      OPEN  get_user;
      FETCH get_user
       INTO user_id;
      CLOSE get_user;
      --
      FOR boq_rec IN get_all_boqs LOOP
        --
        OPEN  get_last_interim(boq_rec.boq_id);
        FETCH get_last_interim
         INTO last_int;
        --
        IF get_last_interim%NOTFOUND
         THEN
           last_int.wip_int_id := 0;
           last_int.wip_status := '@';
        END IF;
        /*
        ||Now chack the status of the last interim
        ||if it hasn't been paid then update the record
        ||otherwise create a new one.
        */
        IF last_int.wip_status = 'U'
         THEN
            --
            UPDATE wol_interim_payments
               SET wip_amount = boq_rec.boq_act_cost
                  ,wip_user   = user_id.hus_user_id
                  ,wip_date   = SYSDATE
             WHERE wip_int_id = last_int.wip_int_id
               AND wip_wol_id = p_wol_id
               AND wip_boq_id = boq_rec.boq_id
                 ;
            --
        ELSE
            --
            INSERT
              INTO wol_interim_payments
                  (wip_wol_id
                  ,wip_boq_id
                  ,wip_int_id
                  ,wip_amount
                  ,wip_user
                  ,wip_date
                  ,wip_status)
            VALUES(p_wol_id
                  ,boq_rec.boq_id
                  ,last_int.wip_int_id+1
                  ,boq_rec.boq_act_cost
                  ,user_id.hus_user_id
                  ,SYSDATE
                  ,'U')
                 ;
            --
        END IF;
        --
        CLOSE get_last_interim;
        --
      END LOOP;
  END IF;
  --
  RETURN lv_retval;
  --
END create_interim_payment;
--
------------------------------------------------------------------------------
--
-- function to reverse out any unpaid interim payments
-- when work order line is set to INSTRUCTED from an interim status

  procedure clear_interim_payment(p_wol_id in work_order_lines.wol_id%type)
  is

  begin

    delete
    from work_order_claims woc
    where exists (select 1
                  from  claim_payments
                  where cp_wol_id = p_wol_id
                  and   cp_woc_claim_ref = woc.woc_claim_ref
                  and   exists (select 1
                                from hig_status_codes hsc
                                where hsc.hsc_domain_code = 'CLAIM STATUS'
                                and hsc.hsc_allow_feature1 = 'Y'
                                and hsc.hsc_status_code = cp_status));

    delete
    from  claim_payments
    where cp_wol_id = p_wol_id
    and   exists (select 1
                  from  hig_status_codes hsc
                  where hsc.hsc_domain_code = 'CLAIM STATUS'
                  and   hsc.hsc_allow_feature1 = 'Y'
                  and   hsc.hsc_status_code = cp_status);

    delete
    from wol_interim_payments
    where wip_wol_id = p_wol_id
    and wip_status = 'U';

  end;

  -- function to get total outstanding interim payment for a WOL
  function  get_unpaid_interim_amount(p_wol_id in work_order_lines.wol_id%type)
  return number is

  cursor get_unpaid is
  select sum(wip_amount)
  from   wol_interim_payments
  where  wip_status = 'U'
  and    wip_wol_id = p_wol_id;

  v_topay wol_interim_payments.wip_amount%type;
  begin
    open get_unpaid;
    fetch get_unpaid into v_topay;
    if get_unpaid%notfound then
       close get_unpaid;
       return null;
    else
       close get_unpaid;
       return v_topay;
    end if;
  end;

  -- function to get total outstanding interim payment for a WOL
  function get_last_interim_amount(p_wol_id in work_order_lines.wol_id%type)
  return number is

  cursor get_int_amount is
  select sum(wip.wip_amount) wip_amount
  from wol_interim_payments wip
  where wip.wip_wol_id = p_wol_id
  and (wip.wip_boq_id, wip.wip_int_id) = (select wip_boq_id, max(wip_int_id)
                                          from wol_interim_payments wip2
                                          where wip2.wip_boq_id = wip.wip_boq_id
                                          group by wip_boq_id);

  v_topay wol_interim_payments.wip_amount%type;
  begin
    open get_int_amount;
    fetch get_int_amount into v_topay;
    if get_int_amount%notfound then
       close get_int_amount;
       return null;
    else
       close get_int_amount;
       return v_topay;
    end if;
  end;

  procedure return_perc_sum(p_parent    in     boq_items.boq_id%type
                           ,p_perc_item in     boq_items.boq_id%type default null
                           ,p_est_cost  in out boq_items.boq_est_cost%type
                           ,p_act_cost  in out boq_items.boq_act_cost%type
                           ,p_comp_type in hig_status_codes.hsc_status_code%type default null) is
  cursor get_items is
  select boq.boq_est_cost
        ,boq.boq_act_cost
        ,boq.boq_id
  from   boq_items boq
  connect by prior boq.boq_id = boq.boq_parent_id
  start with           boq_id = p_parent;

  c_boq_items get_items%rowtype;
  l_option hig_options.hop_value%type := get_perc_item_comp(p_parent);

  cursor get_feature (p_option in hig_status_codes.hsc_status_code%type) is
  select hsc_allow_feature2
  from hig_status_codes
  where hsc_domain_code = 'PERC_ITEM_COMP'
  and hsc_status_code = p_option;

  is_cum get_feature%rowtype;
  begin
    open  get_items;
    fetch get_items into c_boq_items;
    -- do not nvl the first assignment as we wish to propagate a null cost if the parent
    -- has a null cost
    p_act_cost := c_boq_items.boq_act_cost;
    p_est_cost := c_boq_items.boq_est_cost;
    -- if cumulative the add on the value of percentage items related to the standard item

    open get_feature(nvl(p_comp_type, l_option));
    fetch get_feature into is_cum;
    close get_feature;

    if is_cum.hsc_allow_feature2 = 'Y' then
      loop
        fetch get_items into c_boq_items;
        exit when get_items%notfound OR c_boq_items.boq_id = p_perc_item;

        p_act_cost := p_act_cost + nvl(c_boq_items.boq_act_cost,0);
        p_est_cost := p_est_cost + nvl(c_boq_items.boq_est_cost,0);
      end loop;
    end if;
    close get_items;
  end;
--
----------------------------------------------------------------
--
PROCEDURE add_percent_items(pi_parent_boqs   IN  boq_id_tab
                           ,pi_percent_item  IN  standard_items.sta_item_code%TYPE
                           ,pi_bud_id        IN  budgets.bud_id%TYPE
                           ,po_child_boqs    OUT boq_id_tab
                           ,po_error_no      OUT PLS_INTEGER)
  IS
  --
  lr_user  hig_users%ROWTYPE;
  --
  TYPE boq_items_tab IS TABLE OF boq_items%ROWTYPE INDEX BY BINARY_INTEGER;
  lt_perc_items  boq_items_tab;
  --
  lv_est_cost      NUMBER(10,2);
  lv_act_cost      NUMBER(10,2);
  lv_result        BOOLEAN := FALSE;
  lv_wor_est_cost  work_orders.wor_est_cost%TYPE;
  lv_check_value   NUMBER;
  --
  error_occured  EXCEPTION;
  --
  CURSOR get_parent_det(cp_parent boq_items.boq_id%TYPE)
      IS
  SELECT boq.boq_est_cost
        ,boq.boq_act_cost
        ,boq.boq_sta_item_code
        ,boq.boq_defect_id
        ,boq.boq_work_flag
        ,boq.boq_rep_action_cat
        ,boq.boq_wol_id
        ,wol.wol_date_complete
        ,(SELECT hsc_allow_feature8
            FROM hig_status_codes
           WHERE hsc_domain_code = 'WORK_ORDER_LINES'
             AND hsc_status_code = wol.wol_status_code) valuation
        ,wor.wor_con_id
        ,wor.wor_est_cost
        ,wor.wor_date_confirmed
        ,(SELECT oun_cng_disc_group
            FROM org_units
                ,contracts
           WHERE con_id = wor.wor_con_id
             AND wor.wor_date_raised BETWEEN NVL(con_start_date,wor.wor_date_raised)
                                         AND NVL(con_end_date,wor.wor_date_raised)
             AND con_contr_org_id = oun_org_id) discount_group
        ,(SELECT NVL(sta_allow_percent,'Y')
            FROM standard_items
           WHERE sta_item_code = boq.boq_sta_item_code) sta_allow_percent
    FROM work_orders wor
        ,work_order_lines wol
        ,boq_items boq
   WHERE wol.wol_works_order_no = wor.wor_works_order_no
     AND boq.boq_wol_id = wol.wol_id
     AND boq.boq_id = cp_parent
       ;
  --
  r_parent_det get_parent_det%ROWTYPE;
  --
  CURSOR percent_item(cp_con_id        contract_items.cni_con_id%TYPE
                     ,cp_percent_item  standard_items.sta_item_code%TYPE)
      IS
  SELECT sta_item_name
        ,cni_rate
        ,cni_rse_he_id
    FROM standard_items
        ,contract_items
   WHERE cni_con_id = cp_con_id
     AND cni_sta_item_code = sta_item_code
     AND sta_item_code = cp_percent_item
       ;
  --
  r_percent    percent_item%ROWTYPE;
  --
BEGIN
  nm_debug.debug_on;
  nm_debug.debug('1');
  /*
  ||Get User Limits.
  */
   lr_user := nm3user.get_hus(pi_hus_user_id => To_Number(Sys_Context('NM3CORE','USER_ID')));
  /*
  ||Loop through the nominated parent items.
  */
nm_debug.debug('2');
  FOR i IN 1..pi_parent_boqs.count LOOP
    /*
    ||Get details of the parent item.
    */
nm_debug.debug('3 boq_id = '||pi_parent_boqs(i));
    OPEN  get_parent_det(pi_parent_boqs(i));
nm_debug.debug('3A');
    FETCH get_parent_det
     INTO r_parent_det;
nm_debug.debug('3B');
    IF get_parent_det%NOTFOUND
     THEN
        CLOSE get_parent_det;
        nm_debug.debug('3C');
        po_error_no := 880;
        RAISE error_occured;
    ELSE
        CLOSE get_parent_det;
    END IF;
    --
nm_debug.debug('4');
    IF r_parent_det.sta_allow_percent = 'N'
     THEN
        po_error_no := 880;
        RAISE error_occured;
    END IF;
    /*
    ||Get details of the percentage item to be added.
    */
nm_debug.debug('5');
    OPEN  percent_item(r_parent_det.wor_con_id
                      ,pi_percent_item);
    FETCH percent_item
     INTO r_percent;
    IF percent_item%NOTFOUND
     THEN
        CLOSE percent_item;
        po_error_no := 880;
        RAISE error_occured;
    ELSE
        CLOSE percent_item;
    END IF;
    /*
    ||compute the cost
    */
nm_debug.debug('6');
    return_perc_sum(p_parent    => pi_parent_boqs(i)
                   ,p_perc_item => NULL
                   ,p_est_cost  => lv_est_cost
                   ,p_act_cost  => lv_act_cost);
    --
nm_debug.debug('7');
    IF r_parent_det.wol_date_complete IS NULL
     AND r_parent_det.valuation != 'Y'
     THEN
        lv_est_cost := round((lv_est_cost / 100) * r_percent.cni_rate,2);
    ELSE
        /*
        ||If the Percentage Item is being added
        ||as an actual cost the estimate should
        ||be zero.
        */
        lv_est_cost := 0;
    END IF;
nm_debug.debug('8');
    /*
    ||Check that the new WO Estimated Cost is within the users limits.
    */
    lv_wor_est_cost := NVL(lv_wor_est_cost,r_parent_det.wor_est_cost) + lv_est_cost;
    --
nm_debug.debug('9');
    IF lv_est_cost != 0
     AND lr_user.hus_wor_flag IN('1','2')
     AND r_parent_det.wor_date_confirmed IS NULL
     THEN
        --
nm_debug.debug('10');
	   	  lv_check_value := lv_wor_est_cost + maiwo.bal_sum(lv_wor_est_cost,r_parent_det.discount_group);
	   	  --
nm_debug.debug('11');
        IF lv_check_value NOT BETWEEN lr_user.hus_wor_value_min
                                  AND lr_user.hus_wor_value_max
         THEN
            IF lr_user.hus_wor_flag = '2'
             THEN
                /*
                ||Error.
                */
                po_error_no := 246;
                RAISE error_occured;
            ELSE
                /*
                ||Warning.
                */
                po_error_no := 247;
            END IF;
        END IF;
    END IF;
    --
nm_debug.debug('12');
    lv_act_cost := round((lv_act_cost / 100) * r_percent.cni_rate,2);
    /*
    ||Check that the additional cost is within budget
    */
    lv_result := mai_budgets.check_budget(pi_bud_id, lv_est_cost, lv_act_cost, r_parent_det.boq_wol_id);
    --
    IF lv_result AND NOT mai_budgets.allow_over_budget
     THEN
        po_error_no := 882;
        RAISE error_occured;
    ELSE
        /*
        ||Store the new percentage item for insert later.
        */
        lt_perc_items(lt_perc_items.count+1).boq_work_flag    := r_parent_det.boq_work_flag;
        lt_perc_items(lt_perc_items.count).boq_defect_id      := r_parent_det.boq_defect_id;
        lt_perc_items(lt_perc_items.count).boq_rep_action_cat := r_parent_det.boq_rep_action_cat;
        lt_perc_items(lt_perc_items.count).boq_wol_id         := r_parent_det.boq_wol_id;
        lt_perc_items(lt_perc_items.count).boq_sta_item_code  := pi_percent_item;
        lt_perc_items(lt_perc_items.count).boq_item_name      := r_percent.sta_item_name;
        lt_perc_items(lt_perc_items.count).boq_date_created   := SYSDATE;
        lt_perc_items(lt_perc_items.count).boq_est_dim1       := 1;
        lt_perc_items(lt_perc_items.count).boq_est_quantity   := 1;
        lt_perc_items(lt_perc_items.count).boq_est_rate       := r_percent.cni_rate;
        lt_perc_items(lt_perc_items.count).boq_est_cost       := lv_est_cost;
        lt_perc_items(lt_perc_items.count).boq_act_dim1       := 1;
        lt_perc_items(lt_perc_items.count).boq_act_cost       := lv_act_cost;
        lt_perc_items(lt_perc_items.count).boq_parent_id      := pi_parent_boqs(i);
        IF lv_act_cost IS NOT NULL
         THEN
            lt_perc_items(lt_perc_items.count).boq_act_quantity := 1;
            lt_perc_items(lt_perc_items.count).boq_act_rate     := r_percent.cni_rate;
        END IF;
    END IF;
  END LOOP;
  /*
  ||Got this far so populate the BOQ_IDs.
  ||and insert the records.
  */
  FOR i IN 1..lt_perc_items.count LOOP
    --
    lt_perc_items(i).boq_id := get_next_id('BOQ_ID_SEQ');
    po_child_boqs(i) := lt_perc_items(i).boq_id;
    --
  END LOOP;
  --
  FORALL i IN 1..lt_perc_items.count
    INSERT
      INTO boq_items
    VALUES lt_perc_items(i)
         ;
  --
  nm_debug.debug_off;
  --
EXCEPTION
  WHEN error_occured
   THEN
      ROLLBACK;
  WHEN others
   THEN
      ROLLBACK;
      nm_debug.debug_off;
      RAISE;
END add_percent_items;
--
----------------------------------------------------------------
--
FUNCTION add_percent_item(p_parent       in boq_items.boq_id%TYPE
                         ,p_percent_item in standard_items.sta_item_code%TYPE
                         ,p_bud_id       in budgets.bud_id%TYPE)
  RETURN NUMBER IS
  --
  CURSOR get_parent_det(cp_parent boq_items.boq_id%TYPE)
      IS
  SELECT boq.boq_est_cost
        ,boq.boq_act_cost
        ,boq.boq_sta_item_code
        ,boq.boq_defect_id
        ,boq.boq_work_flag
        ,boq.boq_rep_action_cat
        ,boq.boq_wol_id
        ,wol.wol_date_complete
        ,(SELECT hsc_allow_feature8
            FROM hig_status_codes
           WHERE hsc_domain_code = 'WORK_ORDER_LINES'
             AND hsc_status_code = wol.wol_status_code) valuation
        ,wor.wor_con_id
    FROM work_orders wor
        ,work_order_lines wol
        ,boq_items boq
   WHERE wol.wol_works_order_no = wor.wor_works_order_no
     AND boq.boq_wol_id = wol.wol_id
     AND boq.boq_id = cp_parent
       ;
  --
  r_parent_det get_parent_det%ROWTYPE;
  --
  CURSOR percent_item(cp_con_id        contract_items.cni_con_id%TYPE
                     ,cp_percent_item  standard_items.sta_item_code%TYPE)
      IS
  SELECT sta_item_name
        ,cni_rate
        ,cni_rse_he_id
    FROM standard_items
        ,contract_items
   WHERE cni_con_id = cp_con_id
     AND cni_sta_item_code = sta_item_code
     AND sta_item_code = cp_percent_item
       ;
  --
  r_percent    percent_item%ROWTYPE;
  --
  CURSOR can_attach_percent(cp_item_code standard_items.sta_item_code%TYPE)
      IS
  SELECT NVL(sta_allow_percent,'Y') sta_allow_percent
    FROM standard_items
   WHERE sta_item_code = cp_item_code
       ;
  --
  l_est_cost  NUMBER(10,4);
  l_act_cost  NUMBER(10,4);
  l_boq_id    boq_items.boq_id%TYPE;
  l_attach    standard_items.sta_allow_percent%TYPE;
  l_result    BOOLEAN := FALSE;
  lv_retval   NUMBER := -1;
  --
  invalid_item  EXCEPTION;
  --
BEGIN
  /*
  ||Get details of the parent item.
  */
  OPEN  get_parent_det(p_parent);
  FETCH get_parent_det
   INTO r_parent_det;
  IF get_parent_det%NOTFOUND
   THEN
      CLOSE get_parent_det;
      RAISE invalid_item;
  ELSE
      CLOSE get_parent_det;
  END IF;
  --
  /*
  ||Check if we can attach percentage
  ||items to this parent item.
  */
  OPEN  can_attach_percent(r_parent_det.boq_sta_item_code);
  FETCH can_attach_percent
   INTO l_attach;
  IF (can_attach_percent%NOTFOUND or l_attach = 'N')
   THEN
      CLOSE can_attach_percent;
      RAISE invalid_item;
  ELSE
      CLOSE can_attach_percent;
  END IF;
  /*
  ||Get details of the percentage item to be added.
  */
  OPEN  percent_item(r_parent_det.wor_con_id
                    ,p_percent_item);
  FETCH percent_item
   INTO r_percent;
  IF percent_item%NOTFOUND
   THEN
      CLOSE percent_item;
      RAISE invalid_item;
  ELSE
      CLOSE percent_item;
  END IF;
  /*
  ||compute the cost
  */
  return_perc_sum(p_parent    => p_parent
                 ,p_perc_item => NULL
                 ,p_est_cost  => l_est_cost
                 ,p_act_cost  => l_act_cost);
  --
  IF r_parent_det.wol_date_complete IS NULL
   AND r_parent_det.valuation != 'Y'
   THEN
      l_est_cost := round((l_est_cost / 100) * r_percent.cni_rate,2);
  ELSE
      /*
      ||If the Percentage Item is being added
      ||as an actual cost the estimate should
      ||be zero.
      */
      l_est_cost := 0;
  END IF;
  --
  l_act_cost := round((l_act_cost / 100) * r_percent.cni_rate,2);
  /*
  ||Check that the additional cost is within budget
  */
  l_result := mai_budgets.check_budget(p_bud_id, l_est_cost, l_act_cost, r_parent_det.boq_wol_id);
  --
  IF l_result AND NOT mai_budgets.allow_over_budget
   THEN
      lv_retval := 0;
  ELSE
      /*
      ||Get next boq_id
      */
      l_boq_id := get_boq_id_seq;
      /*
      ||Insert the boq_item
      */
      INSERT
        INTO boq_items
            (BOQ_WORK_FLAG
            ,BOQ_DEFECT_ID
            ,BOQ_REP_ACTION_CAT
            ,BOQ_WOL_ID
            ,BOQ_STA_ITEM_CODE
            ,BOQ_ITEM_NAME
            ,BOQ_DATE_CREATED
            ,BOQ_ICB_WORK_CODE
            ,BOQ_EST_DIM1
            ,BOQ_EST_DIM2
            ,BOQ_EST_DIM3
            ,BOQ_EST_QUANTITY
            ,BOQ_EST_RATE
            ,BOQ_EST_DISCOUNT
            ,BOQ_EST_COST
            ,BOQ_EST_LABOUR
            ,BOQ_ACT_DIM1
            ,BOQ_ACT_DIM2
            ,BOQ_ACT_DIM3
            ,BOQ_ACT_QUANTITY
            ,BOQ_ACT_COST
            ,BOQ_ACT_LABOUR
            ,BOQ_ACT_RATE
            ,BOQ_ACT_DISCOUNT
            ,BOQ_ID
            ,BOQ_PARENT_ID)
      VALUES(r_parent_det.boq_work_flag
            ,r_parent_det.boq_defect_id
            ,r_parent_det.boq_rep_action_cat
            ,r_parent_det.boq_wol_id
            ,p_percent_item
            ,r_percent.sta_item_name
            ,SYSDATE
            ,NULL
            ,1
            ,NULL
            ,NULL
            ,1
            ,r_percent.cni_rate
            ,NULL
            ,l_est_cost
            ,NULL
            ,1
            ,NULL
            ,NULL
            ,DECODE(l_act_cost,NULL,NULL, 1)
            ,l_act_cost
            ,NULL
            ,DECODE(l_act_cost,NULL,NULL,r_percent.cni_rate)
            ,NULL
            ,l_boq_id
            ,p_parent)
           ;
  END IF;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN invalid_item
   THEN
      RETURN 880;
  WHEN others
   THEN
      RAISE;
END add_percent_item;
--
----------------------------------------------------------------
--
FUNCTION recalc_percent_item(p_boq_item    IN boq_items.boq_id%TYPE
                            ,p_comp_method IN hig_status_codes.hsc_status_code%TYPE DEFAULT NULL)
  RETURN NUMBER IS
  --
  l_percent_unit hig_options.hop_value%TYPE := hig.get_sysopt('PERC_ITEM');
  --
  CURSOR get_children(cp_parent    boq_items.boq_id%TYPE 
                     ,cp_perc_unit hig_options.hop_value%TYPE)
      IS
  SELECT boq.boq_id
        ,(boq.boq_est_rate * boq.boq_est_dim1) boq_est_rate
        ,(boq.boq_act_rate * boq.boq_act_dim1) boq_act_rate
        ,boq.ROWID
        ,wol.wol_date_complete
        ,(SELECT hsc_allow_feature8
            FROM hig_status_codes
           WHERE hsc_domain_code = 'WORK_ORDER_LINES'
             AND hsc_status_code = wol.wol_status_code) valuation
    FROM boq_items boq
        ,work_order_lines wol
   WHERE wol.wol_id = boq.boq_wol_id
     AND level = 2
     AND EXISTS(SELECT 1
                  FROM standard_items sta
                 WHERE sta.sta_unit = cp_perc_unit
                   AND sta.sta_item_code = boq.boq_sta_item_code)
 CONNECT BY PRIOR boq.boq_id = boq.boq_parent_id
   START WITH boq.boq_id = cp_parent
       ;
  --
  CURSOR check_method(cp_comp_method hig_status_codes.hsc_status_code%TYPE)
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'PERC_ITEM_COMP'
     AND hsc_status_code = cp_comp_method
       ;
  --
  c_parent   get_top_id%ROWTYPE;
  l_est_cost NUMBER(10,4);
  l_act_cost NUMBER(10,4);
  l_code     hig_status_codes.hsc_status_code%TYPE := NULL;
  --
BEGIN
  --
  OPEN  get_top_id(p_boq_item);
  FETCH get_top_id
   INTO c_parent;
  CLOSE get_top_id;
  --
  OPEN  check_method(p_comp_method);
  FETCH check_method
   INTO l_code;
  IF check_method%NOTFOUND THEN
    l_code := NULL;
  END IF;
  CLOSE check_method;
  --
  FOR c_child IN get_children(p_boq_item,l_percent_unit) LOOP
    -- compute the cost
    return_perc_sum(c_parent.boq_id, c_child.boq_id, l_est_cost, l_act_cost, l_code);

    IF c_child.wol_date_complete IS NULL
     AND c_child.valuation != 'Y'
     THEN
        l_est_cost := (l_est_cost / 100) * c_child.boq_est_rate;
    ELSE
        /*
        ||If actual costs are being entered don't
        ||update the Estimated Cost.
        */
        l_est_cost := NULL;
    END IF;
    -- no nvl's for the actual cost as we want to insert null if there are no actuals
    l_act_cost := (l_act_cost / 100) * c_child.boq_act_rate;

    UPDATE boq_items
       SET boq_est_cost = NVL(ROUND(l_est_cost,2),boq_est_cost)
          ,boq_act_cost = ROUND(l_act_cost,2)
     WHERE ROWID = c_child.ROWID;

    -- now work out any %age items that may have this item as parent
    IF recalc_percent_item(c_child.boq_id) != -1
     THEN
        RETURN 1000; -- error
    END IF;
    --
  END LOOP;
  --
  RETURN -1; -- success
  --
end recalc_percent_item;
--
----------------------------------------------------------------
--
  function  recalc_perc_dim(p_boq_id  in boq_items.boq_id%type
                           ,p_new_dim in boq_items.boq_act_dim1%type)
  return number is

  c_parent   get_top_id%rowtype;
  begin
    update boq_items
    set    boq_act_dim1 = p_new_dim
    where  boq_id = p_boq_id;

    open  get_top_id(p_boq_id);
    fetch get_top_id into c_parent;
    close get_top_id;
    -- recalculate the costs of this item and any child
    return recalc_percent_item(c_parent.boq_id);

  end;

  procedure return_parent_item_cost(p_boq_id   in     boq_items.boq_id%type
                                   ,p_est_cost in out boq_items.boq_est_cost%type
                                   ,p_act_cost in out boq_items.boq_act_cost%type)
  is

  cursor get_parent is
  select boq_id
  from boq_items
  where level > 1
  connect by prior boq_parent_id = boq_id
  start with boq_id = p_boq_id;

  c_parent   get_parent%rowtype;
  l_est_cost number(10,4);
  l_act_cost number(10,4);
  begin
    dbms_output.put_line('Called with BOQ of '||to_char(p_boq_id));
    open  get_parent;
    fetch get_parent into c_parent;
    close get_parent;

    -- compute the cost
    return_perc_sum(c_parent.boq_id, p_boq_id, l_est_cost, l_act_cost);

    p_est_cost := l_est_cost;
    p_act_cost := l_act_cost;

  end;

  function has_attached_perc_item(p_boq_id in boq_items.boq_id%type)
  return boolean is

  cursor has_item is
  select 1
  from boq_items
  where boq_parent_id = p_boq_id;
  dummy number;
  begin
    open has_item;
    fetch has_item into dummy;
    if has_item%found then
       close has_item;
       return TRUE;
    else
       close has_item;
       return FALSE;
    end if;
  end;

  function delete_percent_item(p_boq_item in boq_items.boq_id%type)
  return number is

  cursor c_get_kids is
  select rowid
  from   boq_items boq
  where  exists (select 1
                 from standard_items sta
                 where sta.sta_unit          = (select hop_value
                                                from hig_options
                                                where hop_id = 'PERC_ITEM')
                 and   boq.boq_sta_item_code = sta.sta_item_code)
  connect by prior boq_id = boq_parent_id
  start with       boq_id = p_boq_item;


  c_parent   get_top_id%rowtype;
  l_option hig_options.hop_value%type := get_perc_item_comp(p_boq_item);

  cursor get_feature is
  select hsc_allow_feature2
  from hig_status_codes
  where hsc_domain_code = 'PERC_ITEM_COMP'
  and hsc_status_code = l_option;

  is_cum get_feature%rowtype;
  begin

    open get_feature;
    fetch get_feature into is_cum;
    close get_feature;

    if is_cum.hsc_allow_feature2 = 'Y' then
       -- get the top item so we can recalculate costs
       open get_top_id(p_boq_item);
       fetch get_top_id into c_parent;
       close get_top_id;
    end if;

    for kid in c_get_kids loop
      delete from boq_items
      where rowid = kid.rowid;
    end loop;

    -- if the percentages are cumulative we will need to recalculate costs
    if is_cum.hsc_allow_feature2 = 'Y' then
       if (recalc_percent_item(c_parent.boq_id) != -1) then
           return 881;
       end if;
    end if;
    return -1;
  end;

  function has_role(r_name in user_role_privs.granted_role%type)
  return varchar2 is

  cursor get_role is
  select 1
  from dba_role_privs
  where  granted_role = r_name
  and grantee = user;

  dummy number;
  begin
     open get_role;
     fetch get_role into dummy;
     if get_role%found then
        close get_role;
        return 'TRUE';
     else
        close get_role;
        return 'FALSE';
     end if;
  end;

  function paid_so_far(p_wol_id in work_order_lines.wol_id%type)
  return number is

  cursor get_int_payment is
  select sum(cp_payment_value)
  from   claim_payments cp
  where  cp.cp_wol_id = p_wol_id
  and  exists (select 1
               from hig_status_codes
               where hsc_domain_code  = 'CLAIM STATUS'
               and hsc_allow_feature3 = 'Y'
               and cp.cp_status       = hsc_status_code);

  l_retval claim_payments.cp_payment_value%type;
  begin
    open get_int_payment;
    fetch get_int_payment into l_retval;
    close get_int_payment;
    if l_retval is null then
       return 0;
    else
       return l_retval;
    end if;

  end;

  function claimed_so_far(p_wol_id in work_order_lines.wol_id%type)
  return number is

  cursor get_int_payment is
  select sum(cp_claim_value)
  from   claim_payments cp
  where  cp.cp_wol_id = p_wol_id
  and  exists (select 1
               from hig_status_codes
               where hsc_domain_code  = 'CLAIM STATUS'
               and hsc_allow_feature3 = 'Y'
               and cp.cp_status       = hsc_status_code);

  l_retval claim_payments.cp_payment_value%type;
  begin
    open get_int_payment;
    fetch get_int_payment into l_retval;
    close get_int_payment;
    if l_retval is null then
       return 0;
    else
       return l_retval;
    end if;

  end;

  function boq_paid_so_far(p_boq_id in boq_items.boq_id%type)
  return number is

  cursor get_last_payment is
  select wip_amount
  from   wol_interim_payments
  where  wip_boq_id = p_boq_id
  and    wip_status = 'P'
  order by wip_int_id desc;

  cursor get_discount is
  select
  trunc (nvl(decode (nvl(wor_Act_cost,0), 0, 0, wor_act_balancing_Sum / wor_act_cost),5),0) discount
  from  work_orders
       ,work_order_lines
       ,boq_items
  where wor_works_order_no = wol_works_order_no
  and   wol_id = boq_wol_id
  and   boq_id = p_boq_id;

  l_retval wol_interim_payments.wip_amount%type;
  l_discount boq_items.boq_act_cost%type;
  begin
    open get_last_payment;
    fetch get_last_payment into l_retval;
    if get_last_payment%notfound then
      close get_last_payment;
      return 0;
    else
      close get_last_payment;
      -- now apply discount
      open get_discount;
      fetch get_discount into l_discount;
      close get_discount;
      l_retval := round(l_retval + (l_discount * l_retval),2);
      return l_retval;
    end if;
  end;
--
---------------------------------------------------------------------
--
-- The following three functions paid_prior_to_payment_run, claimed_prior_to_payment_run and
-- boq_claimed_prior_payment_run are used within the payment run reports to retrieve the amount
-- paid or claimed for a WOL or BOQ before the last payment run.
-- Outside of the payment run reports the functions paid_so_far and boq_paid_so_Far
-- should be used
--
  function paid_prior_to_payment_run(p_wol_id in work_order_lines.wol_id%type
                                    ,p_cnp_id in claim_payments.cp_payment_id%type)
  return number is

  cursor get_int_payment is
  select sum(cp_payment_value)
  from   claim_payments cp
  where  cp.cp_wol_id = p_wol_id
  and  exists (select 1
               from hig_status_codes
               where hsc_domain_code  = 'CLAIM STATUS'
               and hsc_allow_feature3 = 'Y'
               and cp.cp_status       = hsc_status_code)
  and    cp_payment_id < p_cnp_id;

  l_retval claim_payments.cp_payment_value%type;
  begin
    open get_int_payment;
    fetch get_int_payment into l_retval;
    close get_int_payment;
    if l_retval is null then
       return 0;
    else
       return l_retval;
    end if;

  end;
--
---------------------------------------------------------------------
--
  function claimed_prior_to_payment_run(p_wol_id in work_order_lines.wol_id%type
                                       ,p_cnp_id in claim_payments.cp_payment_id%type)
  return number is

  cursor get_int_payment is
  select sum(cp_claim_value)
  from   claim_payments cp
  where  cp.cp_wol_id = p_wol_id
  and  exists (select 1
               from hig_status_codes
               where hsc_domain_code  = 'CLAIM STATUS'
               and hsc_allow_feature3 = 'Y'
               and cp.cp_status       = hsc_status_code)
  and    cp_payment_id < p_cnp_id;

  l_retval claim_payments.cp_payment_value%type;
  begin
    open get_int_payment;
    fetch get_int_payment into l_retval;
    close get_int_payment;
    if l_retval is null then
       return 0;
    else
       return l_retval;
    end if;

  end;
--
---------------------------------------------------------------------
--
FUNCTION boq_claimed_prior_payment_run(pi_boq_id IN boq_items.boq_id%TYPE
                                      ,pi_cnp_id IN contract_payments.cnp_id%TYPE)
  RETURN wol_interim_payments.wip_amount%TYPE IS
  --
  lt_payments    nm3type.tab_number;
  lv_claim_type  work_order_claims.woc_claim_type%TYPE;
  lv_interim_no  PLS_INTEGER;
  lv_retval      wol_interim_payments.wip_amount%TYPE := 0;
  --
  PROCEDURE get_claim_details
    IS
  BEGIN
    SELECT woc_claim_type
          ,NVL(woc_interim_no,9999)
      INTO lv_claim_type
          ,lv_interim_no
      FROM work_order_claims
          ,claim_payments
          ,boq_items
     WHERE boq_id = pi_boq_id
       AND boq_wol_id = cp_wol_id
       AND cp_payment_id = pi_cnp_id
       AND cp_woc_claim_ref = woc_claim_ref
       AND cp_woc_con_id = woc_con_id
         ;
  EXCEPTION
    WHEN no_data_found
     THEN
        NULL;
    WHEN others
     THEN
        RAISE;
  END get_claim_details;  
  --
  PROCEDURE get_payment_recs
    IS
  BEGIN
    SELECT wip_amount
      BULK COLLECT
      INTO lt_payments
      FROM wol_interim_payments
     WHERE wip_boq_id = pi_boq_id
       AND wip_status = 'P'
       AND wip_int_id <= lv_interim_no
     ORDER
        BY wip_int_id DESC
         ;
  END get_payment_recs;
  --
BEGIN
  /*
  ||Get the claim type for the current claim.
  */
  get_claim_details;
  /*
  ||Get The Interim Payment Records.
  */
  get_payment_recs;
  --
  IF lt_payments.count > 0
   THEN
      --
      IF lv_claim_type = 'F'
       THEN
          /*
          ||If the current claim is Final then there will be
          ||no record for the current claim so return the first
          ||record in the table.
          */
          lv_retval := lt_payments(1);
          --
      ELSE
          /*
          ||If the current claim is an Interim the first record
          ||in the table will be for the current claim so return
          ||the second record if there is one, otherwise the 
          ||previous claim value is zero.
          */
          IF lt_payments.count > 1
           THEN
              lv_retval := lt_payments(2);
          END IF;
          --
      END IF;
  END IF;
  --
  RETURN lv_retval;
  --
END;
--
---------------------------------------------------------------------
--
  function complete_status(p_status in hig_status_codes.hsc_status_code%type)
  return boolean is
  cursor is_complete is
  select 1
  from   hig_status_codes
  where  hsc_status_code = p_status
  and    hsc_domain_code = 'WORK_ORDER_LINES'
  and   (hsc_allow_feature2 = 'Y'
  or     hsc_allow_feature3 = 'Y'
  or    (hsc_allow_feature4 = 'Y' and hsc_allow_feature9 = 'N'));

  dummy number;
  begin
  open is_complete;
  fetch is_complete into dummy;
  if is_complete%found then
      close is_complete;
      return TRUE;
  else
      close is_complete;
      return FALSE;
  end if;
  end;

  function final_claim_exists(p_wol_id work_order_lines.wol_id%type) return boolean is

    cursor c1 is
    select 1
    from   claim_payments
          ,work_order_claims
    where  woc_con_id = cp_woc_con_id
    and    woc_claim_ref = cp_woc_claim_ref
    and    woc_claim_type = 'F'
    and    cp_wol_id = p_wol_id;

    l_dummy number(1);

  begin

    open c1;
    fetch c1 into l_dummy;
    if c1%found then
      close c1;
      return TRUE;
    end if;
    close c1;
    return FALSE;

  end;
--
-----------------------------------------------------------------------------
--
FUNCTION process_payment_run(p_con_id     IN     contracts.con_id%TYPE
                            ,p_apply_vat  IN     VARCHAR2
                            ,l_oun_ord_id IN     org_units.oun_org_id%TYPE
                            ,l_no_fc_file IN     VARCHAR2
                            ,l_cnp_id        OUT work_order_lines.wol_cnp_id%TYPE
                            ,l_error_code    OUT hig_errors.her_no%TYPE
                            ,l_error_appl    OUT hig_errors.her_appl%TYPE)
  RETURN BOOLEAN IS
  --
  contract_is_locked    EXCEPTION;
  PRAGMA EXCEPTION_INIT(contract_is_locked, -0054);
  payment_seq_missing   EXCEPTION;
  PRAGMA EXCEPTION_INIT(payment_seq_missing, -2289);
  no_items_for_payment  EXCEPTION;
  credit_file_error     EXCEPTION;
  --
  v_apply_vat           CHAR(1) := SUBSTR(p_apply_vat,0,1);
  v_rechar              org_units.oun_org_id%TYPE;
  v_payment_code        work_order_lines.wol_payment_code%TYPE;
  v_cost_code           contracts.con_cost_code%TYPE;
  v_total_value         contract_payments.cnp_total_value%TYPE := 0;
  v_cnp_id              contract_payments.cnp_id%TYPE := 0;
  v_payment_no          contract_payments.cnp_first_payment_no%TYPE := 0;
  v_first_payment       contract_payments.cnp_first_payment_no%TYPE := 0;
  v_retention_rate      contracts.con_retention_rate%TYPE := 0;
  v_retention_amount    contracts.con_retention_to_date%TYPE := 0;
  v_vat_rate            vat_rates.vat_rate%TYPE := 0;
  v_vat_amount          contract_payments.cnp_vat_amount%TYPE := 0;
  v_cnp_amount          contract_payments.cnp_amount%TYPE := 0;
  v_last_run_date       DATE;
  v_retention_to_date   contracts.con_retention_to_date%TYPE := 0;
  v_max_retention       contracts.con_max_retention%TYPE := 0;
  v_use_interfaces      org_units.oun_electronic_orders_flag%TYPE;
  v_functional_act      CHAR(1);
  v_payment_value       NUMBER(11, 2);
  l_previous_payment    claim_payments.cp_claim_value%TYPE := 0;
  l_file                VARCHAR2(255);
  v_same_year           CHAR(1);
  l_inv_status          work_order_lines.wol_invoice_status%TYPE;
  l_paid_status         work_order_lines.wol_status_code%TYPE;
  l_part_paid_status    work_order_lines.wol_status_code%TYPE;
  l_claim_paid_status   hig_status_codes.hsc_status_code%TYPE;
  dummy                 NUMBER;
  --
  CURSOR c_wol(cp_con_id contracts.con_id%TYPE)
      IS
  SELECT wol_id
        ,wor_coc_cost_centre
        ,wol_schd_id
        ,wol_def_defect_id
        ,wol_siss_id
        ,wor_job_number
        ,(SELECT rse_linkcode
            FROM road_segments_all
           WHERE rse_he_id = wol_rse_he_id) rse_linkcode
        ,cp_woc_claim_ref
        ,cp_claim_value
        ,woc_claim_type
        ,wol_status_code
        ,NVL(wol_act_cost,0) wol_act_cost
        ,NVL(wor_act_cost,0) wor_act_cost
        ,NVL(wor_act_balancing_sum,0) wor_act_balancing_sum
    FROM work_order_claims
        ,claim_payments
        ,hig_status_codes
        ,work_order_lines
        ,work_orders
        ,contracts
   WHERE con_id = cp_con_id
     AND con_id = wor_con_id
     AND wor_works_order_no = wol_works_order_no
     AND wol_status_code = hsc_status_code
     AND hsc_domain_code = 'WORK_ORDER_LINES'
     AND (hsc_allow_feature3 = 'Y'
          OR (hsc_allow_feature9 = 'Y' AND hsc_allow_feature4 = 'N'))
     AND SYSDATE BETWEEN NVL(hsc_start_date, SYSDATE)
                     AND NVL(hsc_end_date, SYSDATE)
     AND wol_id = cp_wol_id
     AND cp_payment_id IS NULL
     AND EXISTS(SELECT 1
                  FROM hig_status_codes hsc
                 WHERE hsc.hsc_domain_code = 'CLAIM STATUS'
                   AND hsc.hsc_allow_feature1 = 'Y'
                   AND hsc.hsc_status_code = cp_status)
     AND cp_woc_claim_ref = woc_claim_ref
     AND cp_woc_con_id = woc_con_id
       ;
  --
  --wol_rec  c_wol%ROWTYPE;
  --
  CURSOR c_elec_interface(cp_con_id contracts.con_id%TYPE)
      IS
  SELECT oun_electronic_orders_flag
    FROM contracts
        ,org_units
   WHERE con_id = cp_con_id
     AND con_contr_org_id = oun_org_id
       ;
  --
  CURSOR c_next_payment
      IS
  SELECT cnp_id_seq.NEXTVAL
    FROM DUAL
       ;
  --
  CURSOR c_last_payment_details(cp_con_id contracts.con_id%TYPE)
      IS
  SELECT NVL(con_last_payment_no,0)
        ,NVL(con_retention_rate,0)
        ,NVL(con_cost_code,' ')
    FROM contracts
   WHERE con_id = cp_con_id
       ;
  --
  CURSOR c_first_payment_details(cp_con_id contracts.con_id%TYPE)
      IS
  SELECT MIN(cnp_first_payment_no)
    FROM contract_payments
   WHERE cnp_con_id = cp_con_id
       ;
  --
  CURSOR c_get_rechar(cp_defect_id defects.def_defect_id%TYPE)
      IS
  SELECT def_rechar_org_id
    FROM defects
   WHERE def_defect_id = cp_defect_id
       ;
  CURSOR c_retention_to_date(cp_con_id contracts.con_id%TYPE)
      IS
  SELECT con_retention_to_date
        ,con_max_retention
    FROM contracts
   WHERE con_id = cp_con_id
       ;
  --
  CURSOR c_vat_rate
      IS
  SELECT vat_rate
    FROM vat_rates
   WHERE vat_effective_date = (SELECT MAX(vat_effective_date)
                                 FROM vat_rates
                                WHERE vat_effective_date <= SYSDATE)
     AND vat_effective_date <= SYSDATE
       ;
  --
  CURSOR c_last_run_date(cp_con_id contracts.con_id%TYPE)
      IS
  SELECT MAX(cnp_run_date)
    FROM contract_payments
   WHERE cnp_con_id = cp_con_id
       ;
  --
  CURSOR c_run_this_year(cp_last_run_date DATE)
      IS
  SELECT 'Y'
    FROM financial_years
   WHERE cp_last_run_date > fyr_start_date
     AND cp_last_run_date < fyr_end_date
     AND SYSDATE > fyr_start_date
     AND SYSDATE < fyr_end_date
       ;
  --
  CURSOR wol_paid_status
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'WORK_ORDER_LINES'
     AND hsc_allow_feature4 = 'Y'
     AND hsc_allow_feature9 = 'N'
       ;
  --
  CURSOR wol_part_paid_status
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'WORK_ORDER_LINES'
     AND hsc_allow_feature4 = 'Y'
     AND hsc_allow_feature9 = 'Y'
       ;
  --
  CURSOR is_complete(cp_code hig_status_codes.hsc_status_code%TYPE)
      IS
  SELECT 1
    FROM hig_status_codes
   WHERE hsc_allow_feature3 = 'Y'
     AND hsc_domain_code = 'WORK_ORDER_LINES'
     AND hsc_status_code = cp_code
       ;
  --
  CURSOR claim_paid_status
      IS
  SELECT hsc_status_code
    FROM hig_status_codes
   WHERE hsc_domain_code = 'CLAIM STATUS'
     AND hsc_allow_feature3 = 'Y'
       ;
  --
BEGIN
  --
  --nm_debug.debug_on;
  --nm_debug.debug('PRE_RUN_SQL entry, Obtaining Contract Id');
  --
  -- Procedure log entry conrols the locking of the contract
  --
  --nm_debug.debug('Obtaining items for payment');
  --
  OPEN  c_elec_interface(p_con_id);
  FETCH c_elec_interface
   INTO v_use_interfaces;
  CLOSE c_elec_interface;
  --nm_debug.debug('Contract locked');
  --
  -- do not close the cursor we want to keep the lock on the contract right through the procedure!
  --
  --nm_debug.debug('Obtaining new payment id from sequence');
  --
  OPEN  c_next_payment;
  FETCH c_next_payment
   INTO v_cnp_id;
  CLOSE c_next_payment;
  --nm_debug.debug('Got next payment id');
  --
  --nm_debug.debug('CNP    : ' || TO_CHAR(v_cnp_id) || ' Con: ' || TO_CHAR(p_con_id));
  --
  OPEN  c_last_payment_details(p_con_id);
  FETCH c_last_payment_details
   INTO v_payment_no
       ,v_retention_rate
       ,v_cost_code;
  CLOSE c_last_payment_details;
  --
  OPEN  c_first_payment_details(p_con_id);
  FETCH c_first_payment_details
   INTO v_first_payment;
  CLOSE c_first_payment_details;
  IF v_first_payment IS NULL
   THEN
      v_first_payment := v_cnp_id;
  END IF;
  --
  --nm_debug.debug('Obtaining work order lines for contract : ' || TO_CHAR(p_con_id));
  --
  OPEN  wol_paid_status;
  FETCH wol_paid_status
   INTO l_paid_status;
  CLOSE wol_paid_status;
  --
  OPEN  wol_part_paid_status;
  FETCH wol_part_paid_status
   INTO l_part_paid_status;
  CLOSE wol_part_paid_status;
  --
  OPEN  claim_paid_status;
  FETCH claim_paid_status
   INTO l_claim_paid_status;
  CLOSE claim_paid_status;
  --
  --nm_debug.debug('Setting Work Order lines to PAID');
  --nm_debug.debug('Updating Work Order Lines');
  --
  FOR wol_rec IN c_wol(p_con_id) LOOP
    --
    IF wol_rec.woc_claim_type IN('I','F')
     AND maiwo.final_already_paid(wol_rec.wol_id) = 'TRUE'
     THEN
        NULL; -- don't process an Interim or Final invoice
              -- if a final has already been paid
    ELSE
        --
        IF wol_rec.wol_def_defect_id IS NOT NULL
         THEN
            OPEN  c_get_rechar(wol_rec.wol_def_defect_id);
            FETCH c_get_rechar
             INTO v_rechar;
            CLOSE c_get_rechar;
        END IF;
        --
        IF v_rechar IS NULL
         THEN
            v_functional_act := '3';
        ELSE
            v_functional_act := '4';
        END IF;
        --
        v_rechar := NULL;
        v_payment_code := RPAD(NVL(wol_rec.wor_coc_cost_centre,' '),3)
                        ||v_functional_act
                        ||RPAD(NVL(wol_rec.wol_siss_id,' '),3)
                        ||RPAD(v_cost_code,4)
                        ||RPAD(NVL(wol_rec.wor_job_number,' '),5)
                        ||RPAD(SUBSTR(NVL(wol_rec.rse_linkcode,' '),1,1),1);
        --
        --do not need this call as it is the extra to pay that is
        --sent to claim_payments and not the total cost.
        --if wol_rec.woc_claim_type != 'P'
        -- then
        --    l_previous_payment := maiwo.previous_payment(wol_rec.wol_id, wol_rec.cp_woc_claim_ref);
        --end if;
        --
        UPDATE work_order_lines
           SET wol_payment_code = v_payment_code
              ,wol_cnp_id = v_cnp_id
         WHERE wol_id = wol_rec.wol_id
             ;
        --
        SELECT DECODE(wol_rec.woc_claim_type,l_claim_paid_status,wol_rec.cp_claim_value
                                                                ,cp_claim_value - l_previous_payment)
          INTO v_payment_value
          FROM claim_payments
         WHERE cp_wol_id = wol_rec.wol_id
           AND cp_woc_claim_ref = wol_rec.cp_woc_claim_ref
           AND cp_woc_con_id = p_con_id
             ;
        --
        -- apply discount if there is one
        --
        IF wol_rec.wor_act_balancing_sum != 0
         AND wol_rec.wor_act_cost != 0
         THEN
            /*
            ||Apply the Discount to the whole cost of
            ||the WOL then take away any previous payments.
            ||This is done in case the total cost of the WO
            ||has moved into a different Discount Band
            ||since the last payment.
            */
            v_payment_value := wol_rec.wol_act_cost
                             + (wol_rec.wol_act_cost * (wol_rec.wor_act_balancing_sum/wol_rec.wor_act_cost))
                             - paid_so_far(p_wol_id => wol_rec.wol_id);
            --
            --nm_debug.debug('Amount to be paid after discount = '||v_payment_value);
            --
        END IF;
        --
        UPDATE claim_payments
           SET cp_payment_date = SYSDATE
              ,cp_payment_id = v_cnp_id
              ,cp_status = l_claim_paid_status
              ,cp_payment_value = v_payment_value
         WHERE cp_wol_id = wol_rec.wol_id
           AND cp_woc_claim_ref = wol_rec.cp_woc_claim_ref
           AND cp_woc_con_id = p_con_id
             ;
        --
        --update the interim_payments table in case the wol has interim payments
        --
        UPDATE wol_interim_payments
           SET wip_status = 'P'
              ,wip_date = SYSDATE
         WHERE wip_wol_id = wol_rec.wol_id
             ;
        --
        v_total_value := v_total_value + NVL(v_payment_value, 0);
        l_inv_status := maiwo.wol_invoice_status(wol_rec.wol_id);
        OPEN  is_complete(wol_rec.wol_status_code);
        FETCH is_complete
         INTO dummy;
        IF is_complete%FOUND
         THEN
            CLOSE is_complete;
            UPDATE work_order_lines
               SET wol_invoice_status = l_inv_status
                  ,wol_status_code = l_paid_status
                  ,wol_date_paid = SYSDATE
             WHERE wol_id = wol_rec.wol_id
                 ;
        ELSE
            CLOSE is_complete;
            UPDATE work_order_lines
               SET wol_invoice_status = l_inv_status
                  ,wol_status_code = l_part_paid_status
             WHERE wol_id = wol_rec.wol_id
                 ;
        END IF;
    END IF;
  END LOOP;
  --
  --nm_debug.debug('Work Order Lines Updated');
  --
  v_retention_amount := ROUND((v_total_value * v_retention_rate / 100),2);
  --
  --nm_debug.debug('Obtaining Contract Extentions');
  --
  OPEN  c_retention_to_date(p_con_id);
  FETCH c_retention_to_date
   INTO v_retention_to_date
       ,v_max_retention;
  CLOSE c_retention_to_date;
  --
  --nm_debug.debug('Contract Retentions Obtained');
  --
  IF v_retention_amount + v_retention_to_date >= v_max_retention
   THEN
      --nm_debug.debug('Recalculating retention rate');
      v_retention_rate := ROUND(((v_max_retention - v_retention_to_date) / NVL(v_total_value,1)) * 100,2);
      v_retention_amount := ROUND((v_total_value * v_retention_rate / 100),2);
  END IF;
  --
  IF v_apply_vat = 'Y'
   THEN
      --nm_debug.debug('Obtaining VAT rate');
      OPEN  c_vat_rate;
      FETCH c_vat_rate
       INTO v_vat_rate;
      CLOSE c_vat_rate;
      --
      v_vat_amount := ROUND(((v_total_value - v_retention_amount) * v_vat_rate / 100),2);
      --
  ELSE
      v_vat_amount := 0.00;
  END IF;
  --
  v_cnp_amount := (v_total_value - v_retention_amount + v_vat_amount);
  --
  --nm_debug.debug('Inserting into Contract Payments'||TO_CHAR(v_total_value)||' total ');
  --
  INSERT
    INTO contract_payments
        (cnp_id
        ,cnp_con_id
        ,cnp_run_date
        ,cnp_username
        ,cnp_first_payment_no
        ,cnp_last_payment_no
        ,cnp_total_value
        ,cnp_retention_amount
        ,cnp_vat_amount
        ,cnp_amount)
  VALUES(v_cnp_id
        ,p_con_id
        ,SYSDATE
        ,USER
        ,v_first_payment
        ,v_payment_no
        ,v_total_value
        ,v_retention_amount
        ,v_vat_amount
        ,v_cnp_amount);
  --
  IF v_use_interfaces = 'Y'
   AND l_no_fc_file = 'Y'
   THEN
      BEGIN
          interfaces.financial_credit_file(v_cnp_id
                                          ,l_file
                                          ,l_oun_ord_id);
      EXCEPTION
        WHEN OTHERS
         THEN
            RAISE credit_file_error;
      END;
  END IF;
  --
  OPEN  c_last_run_date(p_con_id);
  FETCH c_last_run_date
   INTO v_last_run_date;
  CLOSE c_last_run_date;
  --
  IF v_last_run_date IS NOT NULL
   THEN
      OPEN  c_run_this_year(v_last_run_date);
      FETCH c_run_this_year
       INTO v_same_year;
      CLOSE c_run_this_year;
  END IF;
  -- from post
  --nm_debug.debug('Updating contract');
  --
  IF v_same_year = 'Y'
   THEN
      UPDATE contracts
         SET con_spend_to_date = NVL(con_spend_to_date,0) + v_total_value
            ,con_spend_ytd = NVL(con_spend_ytd,0) + v_total_value
            ,con_last_payment_no = v_cnp_id
       WHERE con_id = p_con_id
           ;
  ELSE
      UPDATE contracts
         SET con_spend_to_date = NVL(con_spend_to_date,0) + v_total_value
            ,con_spend_ytd = v_total_value
            ,con_last_payment_no = v_cnp_id
       WHERE con_id = p_con_id
           ;
  END IF;
  --
  IF v_retention_amount + v_retention_to_date >= v_max_retention
   THEN
      UPDATE contracts
         SET con_retention_to_date = NVL(v_max_retention,0)
       WHERE con_id = p_con_id
           ;
  ELSE
      UPDATE contracts
         SET con_retention_to_date = NVL(v_retention_to_date,0) + NVL(v_retention_amount,0)
       WHERE con_id = p_con_id
           ;
  END IF;
  --
  --nm_debug.debug('Transaction Completed and Committed');
  -- got to here O.K return cnp_id for reports and TRUE
  l_cnp_id := v_cnp_id;
  l_error_code := NULL;
  l_error_appl := NULL;
  --
  --nm_debug.debug_off;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN contract_is_locked
   THEN
      ROLLBACK;                                     -- clb 02082010 Task 0109818
      l_cnp_id := NULL;
      l_error_code := 885;
      l_error_appl := 'M_MGR';
      --nm_debug.debug_off;
      RETURN FALSE;
  WHEN payment_seq_missing
   THEN
      ROLLBACK;                                     -- clb 02082010 Task 0109818
      l_cnp_id := NULL;
      l_error_code := 83;
      l_error_appl := 'HWAYS';
      --nm_debug.debug_off;
      RETURN FALSE;
  WHEN no_items_for_payment
   THEN
      ROLLBACK;                                     -- clb 02082010 Task 0109818
      l_cnp_id := NULL;
      l_error_code := 887;
      l_error_appl := 'M_MGR';
      --nm_debug.debug_off;
      RETURN FALSE;
  WHEN credit_file_error
   THEN
      ROLLBACK;                                     -- clb 02082010 Task 0109818
      l_cnp_id := NULL;
      l_error_code := 888;                                      -- other problem
      l_error_appl := 'M_MGR';
      --nm_debug.debug_off;
      RETURN FALSE;
  WHEN DUP_VAL_ON_INDEX
   THEN
      ROLLBACK;                                     -- clb 02082010 Task 0109818
      l_cnp_id := NULL;
      l_error_code := 885;
      l_error_appl := 'M_MGR';
      --nm_debug.debug_off;
      RETURN FALSE;
  WHEN OTHERS
   THEN
      ROLLBACK;                                     -- clb 02082010 Task 0109818
      l_cnp_id := NULL;
      l_error_code := 888;                                      -- other problem
      l_error_appl := 'M_MGR';
      --nm_debug.debug_off;
      RETURN FALSE;
END process_payment_run;
--
-----------------------------------------------------------------------------
-- get the minimum value that the current user can authorise in mai3848.fmt
   function get_user_authorise_min return number
   IS
   rtrn mai_users.mus_wor_aur_min%TYPE := -1;
   CURSOR c1 IS
      SELECT nvl(mus_wor_aur_min,0)
      FROM mai_users
      WHERE mus_user_id = To_Number(Sys_Context('NM3CORE','USER_ID'));
   BEGIN
      OPEN c1;
      FETCH c1 INTO rtrn;
      CLOSE c1;

      return rtrn;
   END;

   -- get the maximum value that the current user can authorise in mai3848.fmt
   function get_user_authorise_max return number
   IS
   rtrn mai_users.mus_wor_aur_max%TYPE := -1;
   CURSOR c1 IS
      SELECT nvl(mus_wor_aur_max,999999999)
      FROM mai_users
      WHERE mus_user_id = To_Number(Sys_Context('NM3CORE','USER_ID'));
   BEGIN
      OPEN c1;
      FETCH c1 INTO rtrn;
      CLOSE c1;

      return rtrn;
    END;

  function get_job_code(p_works_order in work_orders.wor_works_order_no%type)
  return varchar2 is

  cursor job_code is
  select decode(wor_sys_flag,'D', 0, 1)
  from   job_sizes
        ,work_orders
  where nvl(wor_est_cost, 0) between job_min_size and job_max_size
  and   wor_works_order_no = p_works_order;

  l_retval job_sizes.job_code%type;
  begin
    open job_code;
    fetch job_code into l_retval;
    if job_code%notfound then
      close job_code;
      return null;
    else
      close job_code;
      return l_retval;
    end if;
  end;


/* function to return the rate for a boq item according to the contract
   on the work order it is being assigned to                           */
function reprice_item(p_item_code in boq_items.boq_sta_item_code%type
                     ,p_con_id    in work_orders.wor_con_id%type
                     ,p_rse_he_id in work_order_lines.wol_rse_he_id%type
                     ,p_priority  in defects.def_priority%type
) return number is
  cursor c1 is
    select cni_rate
    from   contract_items
          ,contracts
    where (cni_rse_he_id is null
        or cni_rse_he_id in (
           select rsm_rse_he_id_in
           from   road_seg_membs
           connect by prior
           rsm_rse_he_id_in = rsm_rse_he_id_of
           start with rsm_rse_he_id_of = p_rse_he_id)
          )
    and    cni_sta_item_code = p_item_code
    and    cni_con_id        = con_id
    and    sysdate between con_start_date and con_end_date
    and    con_id            = p_con_id;
--
  cursor c2 is
    select cns_percentage
    from   contract_surcharges
    where  cns_priority = p_priority
    and    cns_con_id = p_con_id;
--
  l_rate       contract_items.cni_rate%type;
  l_percentage contract_surcharges.cns_percentage%type;
begin

    open  c1;
    fetch c1 into l_rate;
    close c1;
--
    if p_priority is not null then  -- ie. repricing a defect wol
      open c2;
      fetch c2 into l_percentage;
      if c2%found then
        l_rate := l_rate * (1 + (l_percentage/100));
      end if;
      close c2;
    end if;
--
    return l_rate;
end;
--
---------------------------------------------------------------------------------------------------
--
FUNCTION get_wo(pi_wor_works_order_no  IN work_orders.wor_works_order_no%TYPE
               ,pi_raise_not_found     IN BOOLEAN     DEFAULT TRUE
               ,pi_not_found_sqlcode  IN PLS_INTEGER DEFAULT -20000) RETURN work_orders%ROWTYPE IS


   CURSOR cs_wor IS
   SELECT *
    FROM  work_orders wor
   WHERE  wor.wor_works_order_no = pi_wor_works_order_no;
                
                
   l_found  BOOLEAN;
   l_retval work_orders%ROWTYPE;
--
BEGIN
--
   OPEN  cs_wor;
   FETCH cs_wor INTO l_retval;
   l_found := cs_wor%FOUND;
   CLOSE cs_wor;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'wor_works_order_no => '||pi_wor_works_order_no
                    );
   END IF;
--
   RETURN l_retval;

END get_wo;
--
---------------------------------------------------------------------------------------------------
--
FUNCTION get_wol(pi_wol_id            IN work_order_lines.wol_id%TYPE
                ,pi_raise_not_found   IN BOOLEAN     DEFAULT TRUE
                ,pi_not_found_sqlcode IN PLS_INTEGER DEFAULT -20000) RETURN work_order_lines%ROWTYPE IS


   CURSOR cs_wol IS
   SELECT *
    FROM  work_order_lines wol
   WHERE  wol.wol_id = pi_wol_id;
                
                
   l_found  BOOLEAN;
   l_retval work_order_lines%ROWTYPE;
--
BEGIN
--
   OPEN  cs_wol;
   FETCH cs_wol INTO l_retval;
   l_found := cs_wol%FOUND;
   CLOSE cs_wol;
--
   IF pi_raise_not_found AND NOT l_found
    THEN
      hig.raise_ner (pi_appl               => nm3type.c_hig
                    ,pi_id                 => 67
                    ,pi_sqlcode            => pi_not_found_sqlcode
                    ,pi_supplementary_info => 'wol_id => '||pi_wol_id
                    );
   END IF;
--
   RETURN l_retval;

END get_wol;
--
---------------------------------------------------------------------------------------------------
--
FUNCTION get_acc_discount(pi_disc_group contractor_disc_groups.cng_disc_group%TYPE) 
Return Varchar2
IS
--
   CURSOR c_get_disc_type
   IS
   SELECT Nvl(cng_accumulative_disc,'N')
   FROM   contractor_disc_groups
   WHERE  cng_disc_group = pi_disc_group;
   l_disc_type contractor_disc_groups.cng_accumulative_disc%TYPE;
--
BEGIN
--
   OPEN  c_get_disc_type;
   FETCH c_get_disc_type INTO l_disc_type ;
   CLOSE c_get_disc_type;
   
   RETURN l_disc_type;
--
END get_acc_discount;
--
end maiwo;
/
