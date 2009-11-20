CREATE OR REPLACE package body maiwo is
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maiwo.pkb-arc   2.5   Nov 20 2009 11:12:18   mhuitson  $
--       Module Name      : $Workfile:   maiwo.pkb  $
--       Date into SCCS   : $Date:   Nov 20 2009 11:12:18  $
--       Date fetched Out : $Modtime:   Nov 19 2009 14:01:10  $
--       SCCS Version     : $Revision:   2.5  $
--       Based onSCCS Version     : 1.6
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maiwo.pck	1.13 08/04/03'
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------

--g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '$Revision:   2.5  $';

  g_package_name CONSTANT varchar2(30) := 'maiwo';

  cursor get_top_id(p_boq_item in boq_items.boq_id%type) is
  select boq_id
  from   boq_items boq
  where  boq_parent_id is null
  connect by prior boq_parent_id = boq_id
  start with              boq_id = p_boq_item;


  function get_version return varchar2 is
  begin
     return g_sccsid;
  end;

  FUNCTION get_body_version RETURN varchar2 IS
  BEGIN
    RETURN g_body_sccsid;
  END get_body_version;


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

  function add_percent_item(p_parent       in boq_items.boq_id%type
                           ,p_percent_item in standard_items.sta_item_code%type
                           ,p_bud_id       in budgets.bud_id%type
                           ) return number is

  cursor get_parent_det is
  select boq.boq_est_cost
        ,boq.boq_act_cost
        ,boq.boq_sta_item_code
        ,boq.boq_defect_id
        ,boq.boq_work_flag
        ,boq.boq_rep_action_cat
        ,boq.boq_wol_id
        ,wor.wor_con_id
  from  work_orders wor
       ,work_order_lines wol
       ,boq_items boq
  where wol.wol_works_order_no = wor.wor_works_order_no
  and   boq.boq_wol_id         = wol.wol_id
  and   boq.boq_id             = p_parent;

  r_parent_det get_parent_det%rowtype;

  cursor percent_item is
  select sta_item_name
        ,cni_rate
        ,cni_rse_he_id
  from   standard_items
        ,contract_items
  where  sta_item_code = cni_sta_item_code
  and    sta_item_code = p_percent_item
  and    cni_con_id    = r_parent_det.wor_con_id;

  cursor can_attach_percent is
  select nvl(sta_allow_percent,'Y') sta_allow_percent
  from standard_items
  where sta_item_code = r_parent_det.boq_sta_item_code;

  r_percent    percent_item%rowtype;
  l_est_cost   number(10,4);
  l_act_cost   number(10,4);
  l_boq_id     boq_items.boq_id%type;
  l_attach     standard_items.sta_allow_percent%type;
  l_result     BOOLEAN := FALSE;

  begin

    open get_parent_det;
    fetch get_parent_det into r_parent_det;
    if get_parent_det%notfound then
    -- we really should have a valid parent to call this, however just in case
       close get_parent_det;
       return 880;
    else
       close get_parent_det;
    end if;

    open percent_item;
    fetch percent_item into r_percent;
    if percent_item%notfound then
       close percent_item;
       return 880;
    else
       close percent_item;
    end if;

    -- check if we can attach percentage items to this parent item

    open can_attach_percent;
    fetch can_attach_percent into l_attach;
    if (can_attach_percent%notfound or l_attach = 'N') then
       close can_attach_percent;
       return 880;
    else
       close can_attach_percent;
    end if;

    -- compute the cost
    return_perc_sum(p_parent, null, l_est_cost, l_act_cost);
    dbms_output.put_line('estimate '||to_char(l_est_cost));
    l_est_cost := round((l_est_cost / 100) * r_percent.cni_rate,2);
    -- no nvl's for the actual cost as we want to insert null if there are no actuals
    l_act_cost := round((l_act_cost / 100) * r_percent.cni_rate,2);

    -- check that the additional cost is within budget

    l_result := mai_budgets.check_budget(p_bud_id, l_est_cost, l_act_cost, r_parent_det.boq_wol_id);

    if l_result and not mai_budgets.allow_over_budget then
       return 0;
    end if;

    -- get next boq_id
    l_boq_id := get_boq_id_seq;
    -- insert the boq_item

    insert into boq_items (BOQ_WORK_FLAG, BOQ_DEFECT_ID, BOQ_REP_ACTION_CAT
                          ,BOQ_WOL_ID, BOQ_STA_ITEM_CODE, BOQ_ITEM_NAME
                          ,BOQ_DATE_CREATED, BOQ_ICB_WORK_CODE, BOQ_EST_DIM1
                          ,BOQ_EST_DIM2, BOQ_EST_DIM3, BOQ_EST_QUANTITY
                          ,BOQ_EST_RATE, BOQ_EST_DISCOUNT, BOQ_EST_COST
                          ,BOQ_EST_LABOUR, BOQ_ACT_DIM1, BOQ_ACT_DIM2
                          ,BOQ_ACT_DIM3, BOQ_ACT_QUANTITY, BOQ_ACT_COST
                          ,BOQ_ACT_LABOUR, BOQ_ACT_RATE, BOQ_ACT_DISCOUNT
                          ,BOQ_ID, BOQ_PARENT_ID )
                           SELECT
                           r_parent_det.boq_work_flag, r_parent_det.boq_defect_id, r_parent_det.boq_rep_action_cat
                          ,r_parent_det.boq_wol_id, p_percent_item, r_percent.sta_item_name
                          ,sysdate, null, 1
                          ,null, null, 1
                          , r_percent.cni_rate, null, l_est_cost
                          ,null, 1 /* need a actual dimension as we do not enter actuals */, null
                          ,null, decode(l_act_cost, null, null, 1), l_act_cost
                          ,null, decode(l_act_cost, null, null, r_percent.cni_rate), null
                          ,l_boq_id, p_parent
                          from dual;
    return -1;
  end;

  function recalc_percent_item(p_boq_item in boq_items.boq_id%type
                              ,p_comp_method in hig_status_codes.hsc_status_code%type default null)
  return number is

  l_percent_unit hig_options.hop_value%type := hig.get_sysopt('PERC_ITEM');

  cursor get_children is
  select boq.boq_id
        ,(boq.boq_est_rate * boq.boq_est_dim1) boq_est_rate
        ,(boq.boq_act_rate * boq.boq_act_dim1) boq_act_rate
        ,rowid
  from   boq_items boq
  where  level = 2
  and exists (select 1
              from standard_items sta
              where sta.sta_unit          = l_percent_unit
              and   boq.boq_sta_item_code = sta.sta_item_code)
  connect by prior boq_id = boq_parent_id
  start with       boq_id = p_boq_item;

  cursor check_method is
  select hsc_status_code
  from   hig_status_codes
  where  hsc_domain_code = 'PERC_ITEM_COMP'
  and    hsc_status_code = p_comp_method;


  c_parent   get_top_id%rowtype;
  l_est_cost number(10,4);
  l_act_cost number(10,4);
  l_code hig_status_codes.hsc_status_code%type := null;
  begin
    dbms_output.put_line('Called with BOQ of '||to_char(p_boq_item));
    open  get_top_id(p_boq_item);
    fetch get_top_id into c_parent;
    close get_top_id;

    open check_method;
    fetch check_method into l_code;
    if check_method%notfound then
      l_code := null;
    end if;
    close check_method;

    for c_child in get_children loop
      -- compute the cost
      return_perc_sum(c_parent.boq_id, c_child.boq_id, l_est_cost, l_act_cost, l_code);
      l_est_cost := (l_est_cost / 100) * c_child.boq_est_rate;
      -- no nvl's for the actual cost as we want to insert null if there are no actuals
      l_act_cost := (l_act_cost / 100) * c_child.boq_act_rate;

      dbms_output.put_line('BOQ '||to_char(c_child.boq_id)||' estimate '||to_char(l_est_cost)||' actual '||to_char(l_act_cost));
      update boq_items
      set    boq_est_cost = round(l_est_cost,2)
            ,boq_act_cost = round(l_act_cost,2)
      where rowid = c_child.rowid;

      -- now work out any %age items that may have this item as parent
      if recalc_percent_item(c_child.boq_id) != -1
         then return 1000; -- error
      end if;

    end loop;
    return -1; -- success
  end;

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

  -- The following four functions paid_prior_to_payment_run and boq_paid_prior_to_payment_run
  -- are used within the payment run reports to retrieve the amount paid or claimed for a WOL or BOQ
  -- before the last payment run. Outside of the payment run reports the functions
  -- paid_so_far and boq_paid_so_Far should be used

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

  function boq_paid_prior_to_payment_run(p_boq_id in boq_items.boq_id%type)
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

  l_retval   wol_interim_payments.wip_amount%type;
  l_discount boq_items.boq_act_cost%type;
  begin
    open get_last_payment;
-- first fetch gets last paid amount
    fetch get_last_payment into l_retval;
    if get_last_payment%notfound then
      close get_last_payment;
      return 0;
    else
    -- second fetch gets amount paid prior to payment run
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
    end if;
  end;

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

  function boq_claimed_prior_payment_run(p_boq_id in boq_items.boq_id%type)
  return number is

  cursor get_last_payment is
  select wip_amount
  from   wol_interim_payments
  where  wip_boq_id = p_boq_id
  and    wip_status = 'P'
  order by wip_int_id desc;

  l_retval wol_interim_payments.wip_amount%type;

  begin
    open get_last_payment;
-- first fetch gets last paid amount
    fetch get_last_payment into l_retval;
    if get_last_payment%notfound then
      close get_last_payment;
      return 0;
    else
    -- second fetch gets amount paid prior to payment run
      fetch get_last_payment into l_retval;
      if get_last_payment%notfound then
        close get_last_payment;
        return 0;
      else
        close get_last_payment;
        return l_retval;
      end if;
    end if;
  end;

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

  function process_payment_run(p_con_id     in contracts.con_id%type
                              ,p_apply_vat in varchar2
                              ,l_oun_ord_id in org_units.oun_org_id%type
                              ,l_NO_FC_FILE in varchar2
                              ,l_cnp_id     out work_order_lines.wol_cnp_id%type
                              ,l_error_code out hig_errors.her_no%type
                              ,l_error_appl out hig_errors.her_appl%type
                              )
  return boolean is
   contract_is_locked exception;
   pragma exception_init ( contract_is_locked,-0054 );
   payment_seq_missing exception;
   pragma exception_init ( payment_seq_missing,-2289);
   no_items_for_payment exception;
   credit_file_error exception;

   v_apply_vat          char(1):=substr(p_apply_vat,0,1);
   v_rechar             org_units.oun_org_id%type;
   v_payment_code       work_order_lines.wol_payment_code%type;
   v_cost_code          contracts.con_cost_code%type;
   v_total_value        contract_payments.cnp_total_value%type:=0;
   v_cnp_id             contract_payments.cnp_id%type:=0;
   v_payment_no         contract_payments.cnp_first_payment_no%type:=0;
   v_first_payment      contract_payments.cnp_first_payment_no%type:=0;
   v_retention_rate     contracts.con_retention_rate%type:=0;
   v_retention_amount   contracts.con_retention_to_date%type:=0;
   v_vat_rate           vat_rates.vat_rate%type:=0;
   v_vat_amount         contract_payments.cnp_vat_amount%type:=0;
   v_cnp_amount         contract_payments.cnp_amount%type:=0;
   v_last_run_date      date;
   v_retention_to_date  contracts.con_retention_to_date%type:=0;
   v_max_retention      contracts.con_max_retention%type:=0;
   v_use_interfaces     org_units.oun_electronic_orders_flag%type;
   v_functional_act     char(1);
   v_payment_value      number(11,2);
   l_previous_payment   claim_payments.cp_claim_value%type := 0;
   l_file               varchar2(255);
   v_same_year          char(1);
   l_inv_status         work_order_lines.wol_invoice_status%type;
   l_paid_status        work_order_lines.wol_status_code%type;
   l_part_paid_status   work_order_lines.wol_status_code%type;
   l_claim_paid_status  hig_status_codes.hsc_status_code%type;
   dummy                number;

   cursor c_wol(v_con_id contracts.con_id%type) is
      select wol_id
            ,wor_coc_cost_centre
            ,wol_schd_id
            ,wol_def_defect_id
            ,wol_siss_id
            ,wor_job_number
            ,rse_linkcode
            ,cp_woc_claim_ref
            ,cp_claim_value
            ,woc_claim_type
            ,wol_status_code
            ,nvl(wor_act_cost,0) wor_act_cost
            ,nvl(wor_act_balancing_sum,0) wor_act_balancing_sum
      from   work_orders
            ,work_order_lines
            ,claim_payments
            ,work_order_claims
            ,road_segments_all
            ,contracts
            ,hig_status_codes
      where  wor_con_id = con_id
      and    con_id = v_con_id
      and    wor_works_order_no = wol_works_order_no
      and    hsc_domain_code    = 'WORK_ORDER_LINES'
      and    (hsc_allow_feature3 = 'Y' or (hsc_allow_feature9 = 'Y' and hsc_allow_feature4 = 'N'))
      and    wol_status_code    = hsc_status_code
      and    sysdate between nvl(hsc_start_date, sysdate) and nvl(hsc_end_date, sysdate)
      and    wol_id = cp_wol_id
      and    cp_payment_id is null
      and    exists (select 1
                     from hig_status_codes hsc
                     where hsc.hsc_domain_code = 'CLAIM STATUS'
                     and hsc.hsc_allow_feature1 = 'Y'
                     and cp_status = hsc.hsc_status_code)
      and    cp_woc_claim_ref = woc_claim_ref
      and    cp_woc_con_id = woc_con_id
      and    rse_he_id = wol_rse_he_id;

   wol_rec             c_wol%rowtype;

   cursor c_elec_interface (v_con_id contracts.con_id%type) is
      select oun_electronic_orders_flag
      from   contracts, org_units
      where  con_id = v_con_id
      and    con_contr_org_id = oun_org_id;

   cursor c_next_payment is
      select cnp_id_seq.nextval
      from   dual;

   cursor c_last_payment_details (v_con_id contracts.con_id%type) is
      select nvl(con_last_payment_no,0)
            ,nvl(con_retention_rate,0)
            ,nvl(con_cost_code,' ')
      from    contracts
      where   con_id = v_con_id;

   cursor c_first_payment_details(v_con_id contracts.con_id%type) is
     select min(cnp_first_payment_no)
     from   contract_payments
     where  cnp_con_id = v_con_id;

   cursor c_get_rechar (v_defect defects.def_defect_id%type) is
      select def_rechar_org_id
      from   defects
      where  def_defect_id = v_defect;

   cursor c_retention_to_date (v_con_id contracts.con_id%type) is
      select con_retention_to_date, con_max_retention
      from   contracts
      where  con_id = v_con_id;

   cursor c_vat_rate is
      select vat_rate
      from   vat_rates
      where  vat_effective_date = (select max(vat_effective_date)
                                   from vat_rates
                                   where vat_effective_date <= sysdate)
      and    vat_effective_date <= sysdate;

   cursor c_last_run_date (v_con_id contracts.con_id%type) is
      select max(cnp_run_date)
      from   contract_payments
      where  cnp_con_id = v_con_id;

   cursor c_run_this_year(v_last_run_date date) is
      select 'Y'
      from   financial_years
      where  v_last_run_date > fyr_start_date
      and    v_last_run_date < fyr_end_date
      and    sysdate > fyr_start_date
      and    sysdate < fyr_end_date;

   cursor wol_paid_status is
      select hsc_status_code
      from   hig_status_codes
      where  hsc_domain_code = 'WORK_ORDER_LINES'
      and    hsc_allow_feature4 = 'Y' and hsc_allow_feature9 = 'N';

   cursor wol_part_paid_status is
      select hsc_status_code
      from   hig_status_codes
      where  hsc_domain_code = 'WORK_ORDER_LINES'
      and    hsc_allow_feature4 = 'Y'
      and    hsc_allow_feature9 = 'Y';

   cursor is_complete(c_code in hig_status_codes.hsc_status_code%type) is
      select 1
      from   hig_status_codes
      where  hsc_allow_feature3 = 'Y'
      and    hsc_domain_code = 'WORK_ORDER_LINES'
      and    hsc_status_code = c_code;

   cursor claim_paid_status is
      select hsc_status_code
      from   hig_status_codes
      where  hsc_domain_code = 'CLAIM STATUS'
      and    hsc_allow_feature3 = 'Y';


  begin

   --
   dbms_output.put_line('PRE_RUN_SQL entry, Obtaining Contract Id');
   --
   -- Procedure log entry conrols the locking of the contract
   --
   dbms_output.put_line('Obtaining items for payment');
   --

   open c_elec_interface(p_con_id);
   fetch c_elec_interface into v_use_interfaces;
   close c_elec_interface;

   dbms_output.put_line('Contract locked');
   --
   -- do not close the cursor we want to keep the lock on the contract right through the procedure!
   --
   dbms_output.put_line('Obtaining new payment id from sequence');
   --
   open c_next_payment;
   fetch c_next_payment into v_cnp_id;
   close c_next_payment;

   dbms_output.put_line('Got next payment id');
   --
   dbms_output.put_line('CNP    : '||to_char(v_cnp_id)||' Con: '||to_char(p_con_id));
   --
   open c_last_payment_details (p_con_id);
   fetch c_last_payment_details into v_payment_no, v_retention_rate, v_cost_code;
   close c_last_payment_details;

   open c_first_payment_details(p_con_id);
   fetch c_first_payment_details into v_first_payment;
   close c_first_payment_details;

   if v_first_payment is null then
      v_first_payment := v_cnp_id;
   end if;

   dbms_output.put_line('Obtaining work order lines for contract : '||to_char(p_con_id));

   open wol_paid_status;
   fetch wol_paid_status into l_paid_status;
   close wol_paid_status;

   open wol_part_paid_status;
   fetch wol_part_paid_status into l_part_paid_status;
   close wol_part_paid_status;

   open claim_paid_status;
   fetch claim_paid_status into l_claim_paid_status;
   close claim_paid_status;

   dbms_output.put_line('Setting Work Order lines to PAID');
   dbms_output.put_line('Updating Work Order Lines');
   --
   for wol_rec in c_wol(p_con_id) loop

     if wol_rec.woc_claim_type in ('I', 'F') and
        maiwo.final_already_paid(wol_rec.wol_id) = 'TRUE' then

          null; -- don't process an Interim or Final invoice
                  -- if a final has already been paid

     else

      if wol_rec.wol_def_defect_id is not null then
         open c_get_rechar (wol_rec.wol_def_defect_id);
         fetch c_get_rechar into v_rechar;
         close c_get_rechar;
      end if;

      if v_rechar is null then
         v_functional_act := '3';
      else
         v_functional_act := '4';
      end if;
      v_rechar := null;

      v_payment_code := rpad(nvl(wol_rec.wor_coc_cost_centre,' '),3)||
                        v_functional_act||
                        rpad(nvl(wol_rec.wol_siss_id,' '),3)||
                        rpad(v_cost_code,4)||
                        rpad(nvl(wol_rec.wor_job_number,' '),5)||
                        rpad(substr(nvl(wol_rec.rse_linkcode,' '),1,1),1);

-- do not need this call as it is the extra to pay that is
-- sent to claim_payments and not the total cost.

--      if wol_rec.woc_claim_type != 'P' then
--        l_previous_payment := maiwo.previous_payment(wol_rec.wol_id, wol_rec.cp_woc_claim_ref);
--      end if;

      update work_order_lines
      set    wol_payment_code = v_payment_code,
             wol_cnp_id = v_cnp_id
      where  wol_id = wol_rec.wol_id;

      select decode(wol_rec.woc_claim_type, l_claim_paid_status,
             wol_rec.cp_claim_value,
             cp_claim_value - l_previous_payment)
      into   v_payment_value
      from   claim_payments
      where  cp_wol_id = wol_rec.wol_id
      and    cp_woc_claim_ref = wol_rec.cp_woc_claim_ref
      and    cp_woc_con_id = p_con_id;

      -- apply discount if there is one
      if (wol_rec.wor_act_balancing_sum != 0 and wol_rec.wor_act_cost != 0) then
        v_payment_value := v_payment_value + v_payment_value * (wol_rec.wor_act_balancing_sum / wol_rec.wor_act_cost);
      end if;

      update claim_payments
      set    cp_payment_date = sysdate
            ,cp_payment_id = v_cnp_id
            ,cp_status = l_claim_paid_status
            ,cp_payment_value = v_payment_value
      where  cp_wol_id = wol_rec.wol_id
      and    cp_woc_claim_ref = wol_rec.cp_woc_claim_ref
      and    cp_woc_con_id = p_con_id;

      -- update the interim_payments table in case the wol has interim payments
      update wol_interim_payments
      set    wip_status = 'P'
            ,wip_date   = sysdate
      where  wip_wol_id = wol_rec.wol_id;

      v_total_value := v_total_value + nvl(v_payment_value, 0);

      l_inv_status := maiwo.wol_invoice_status(wol_rec.wol_id);

      open is_complete(wol_rec.wol_status_code);
      fetch is_complete into dummy;
      if is_complete%found then

        close is_complete;
        update work_order_lines
        set    wol_invoice_status = l_inv_status,
               wol_status_code = l_paid_status,
               wol_date_paid = sysdate
        where  wol_id =  wol_rec.wol_id;
      else
        close is_complete;
        update work_order_lines
        set    wol_invoice_status = l_inv_status,
               wol_status_code = l_part_paid_status
        where  wol_id =  wol_rec.wol_id;
      end if;

    end if;

   end loop;
   --
   dbms_output.put_line('Work Order Lines Updated');
   --
   v_retention_amount := round((v_total_value * v_retention_rate / 100),2);
   --
   dbms_output.put_line('Obtaining Contract Extentions');
   --
   open c_retention_to_date(p_con_id);
   fetch c_retention_to_date into v_retention_to_date, v_max_retention;
   close c_retention_to_date;
   --
   dbms_output.put_line('Contract Retentions Obtained');
   --
   if v_retention_amount + v_retention_to_date >= v_max_retention then
      dbms_output.put_line('Recalculating retention rate');
      v_retention_rate :=
      round (((v_max_retention - v_retention_to_date)/nvl(v_total_value,1))*100,2);
      v_retention_amount := round((v_total_value * v_retention_rate / 100),2);
   end if;

   if v_apply_vat = 'Y' then
      dbms_output.put_line('Obtaining VAT rate');
      open c_vat_rate;
      fetch c_vat_rate into v_vat_rate;
      close c_vat_rate;

      v_vat_amount := round(((v_total_value - v_retention_amount) * v_vat_rate / 100),2);
   else
      v_vat_amount := 0.00;
   end if;
   v_cnp_amount := (v_total_value - v_retention_amount + v_vat_amount);
   --
   dbms_output.put_line('Inserting into Contract Payments'||to_char(v_total_value)||' total ');
   --

   insert into contract_payments
      (cnp_id, cnp_con_id, cnp_run_date, cnp_username,
       cnp_first_payment_no, cnp_last_payment_no, cnp_total_value,
       cnp_retention_amount, cnp_vat_amount, cnp_amount)
      values
      (v_cnp_id, p_con_id, sysdate, user,
       v_first_payment, v_payment_no, v_total_value,
       v_retention_amount, v_vat_amount, v_cnp_amount);

   if v_use_interfaces = 'Y' and l_NO_FC_FILE = 'Y' then

     begin
       interfaces.financial_credit_file(v_cnp_id, l_file, l_oun_ord_id);
     exception
       when others then
         raise credit_file_error;
     end;

   end if;

   open c_last_run_date(p_con_id);
   fetch c_last_run_date into v_last_run_date;
   close c_last_run_date;


   if v_last_run_date is not null then

      open c_run_this_year(v_last_run_date);
      fetch c_run_this_year into v_same_year;
      close c_run_this_year;

   end if;

-- from post
   dbms_output.put_line('Updating contract');

   if v_same_year = 'Y' then
      update contracts
      set con_spend_to_date = nvl(con_spend_to_date,0) + v_total_value,
          con_spend_ytd = nvl(con_spend_ytd,0) + v_total_value,
          con_last_payment_no = v_cnp_id
      where con_id = p_con_id;
   else
      update contracts
      set con_spend_to_date = nvl(con_spend_to_date,0) + v_total_value,
          con_spend_ytd = v_total_value,
          con_last_payment_no = v_cnp_id
      where con_id = p_con_id;
   end if;

  if v_retention_amount + v_retention_to_date >= v_max_retention then
    update contracts
    set    con_retention_to_date = nvl(v_max_retention,0)
    where  con_id = p_con_id;
  else
    update contracts
    set    con_retention_to_date = nvl(v_retention_to_date,0) + nvl(v_retention_amount,0)
    where  con_id = p_con_id;
  end if;

   dbms_output.put_line('Transaction Completed and Committed');

-- got to here O.K return cnp_id for reports and TRUE
   l_cnp_id     := v_cnp_id;
   l_error_code := null;
   l_error_appl := null;
   return TRUE;

  exception
  when contract_is_locked
  then
    l_cnp_id     := null;
    l_error_code := 885;
    l_error_appl := 'M_MGR';
    return false;
  when payment_seq_missing
  then
    l_cnp_id     := null;
    l_error_code := 83;
    l_error_appl := 'HWAYS';
    return false;
  when no_items_for_payment
  then
    l_cnp_id     := null;
    l_error_code := 887;
    l_error_appl := 'M_MGR';
    return false;
  when credit_file_error
  then
    l_cnp_id     := null;
    l_error_code := 888; -- other problem
    l_error_appl := 'M_MGR';
    return false;
  when DUP_VAL_ON_INDEX then
    l_cnp_id     := null;
    l_error_code := 885;
    l_error_appl := 'M_MGR';
    return false;
  when others
  then
    l_cnp_id     := null;
    l_error_code := 888; -- other problem
    l_error_appl := 'M_MGR';
    return false;
  end;

   -- get the minimum value that the current user can authorise in mai3848.fmt
   function get_user_authorise_min return number
   IS
   rtrn hig_users.hus_wor_aur_min%TYPE := -1;
   CURSOR c1 IS
      SELECT nvl(hus_wor_aur_min,0)
      FROM hig_users
      WHERE hus_username = user;
   BEGIN
      OPEN c1;
      FETCH c1 INTO rtrn;
      CLOSE c1;

      return rtrn;
   END;

   -- get the maximum value that the current user can authorise in mai3848.fmt
   function get_user_authorise_max return number
   IS
   rtrn hig_users.hus_wor_aur_max%TYPE := -1;
   CURSOR c1 IS
      SELECT nvl(hus_wor_aur_max,999999999)
      FROM hig_users
      WHERE hus_username = user;
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
