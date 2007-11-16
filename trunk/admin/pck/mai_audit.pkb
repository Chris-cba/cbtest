CREATE OR REPLACE package body mai_audit as
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_audit.pkb-arc   2.1   Nov 16 2007 16:07:12   dyounger  $
--       Module Name      : $Workfile:   mai_audit.pkb  $
--       Date into SCCS   : $Date:   Nov 16 2007 16:07:12  $
--       Date fetched Out : $Modtime:   Nov 08 2007 10:26:28  $
--       SCCS Version     : $Revision:   2.1  $
--       Based on SCCS Version     : 1.7
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)mai_audit.pck	1.1 08/23/00'
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------

  old_rec old_vals;
  audit_rec aud_tab;
  clear_rec old_vals;     -- null record used to clear entries from record after posting

  -- get all of the columns currently audited
  cursor get_audit_cols is
  select lower(wac_column_name) col_name
  from wo_audit_columns
  where wac_audited = 'Y';

-- get works order number for boq postings
  cursor get_wo_id(p_wol_Id in work_order_lines.wol_id%type) is
  select wol_works_order_no
  from work_order_lines
  where wol_id = p_wol_id;
----------------------------------------------------------------------------------------
  FUNCTION  get_version RETURN VARCHAR2 IS
  BEGIN
    RETURN  g_sccsid;
  END;

  function is_audited(p_column_name in wo_audit_columns.wac_column_name%type)
  return boolean is
  i integer;
  begin
  dbms_output.put_line('Param '||p_column_name);
    for i in 1..aud_tab_no loop
      dbms_output.put_line('val '||audit_rec(i));
      if audit_rec(i) = lower(p_column_name) then
         return TRUE;
      end if;
    end loop;
  return FALSE;
  end;

  procedure write_log(p_column_name in wo_audit_columns.wac_column_name%type
                     ,p_change      in wo_audit.wad_change%type
                     ,p_original    in wo_audit.wad_change_from%type) is

  cursor get_last_change is
  select 1 /*+ FIRST_ROWS */
  from wo_audit
  where  wad_date > session_start
  and wad_user = user
  and wad_wor_works_order_no = old_rec.wor_works_order_no
  and (wad_wol_id = old_rec.wol_id
    or wad_wol_id is null)
  and (wad_boq_id = old_rec.boq_id
    or wad_boq_id is null)
  and wad_column_name = p_column_name
  for update of wad_change, wad_date;

  dummy number;
  begin
    if log_all = 'N' then
      open get_last_change;
      fetch get_last_change into dummy;
      if get_last_change%found then

         update wo_audit
         set wad_change = p_change
            ,wad_date   = sysdate
         where current of get_last_change;
         close get_last_change;

      else
         close get_last_change;

         insert into wo_audit(wad_wor_works_order_no
                             ,wad_wol_id
                             ,wad_boq_id
                             ,wad_user
                             ,wad_date
                             ,wad_column_name
                             ,wad_change
                             ,wad_change_from)
         values
        (old_rec.wor_works_order_no
        ,old_rec.wol_id
        ,old_rec.boq_id
        ,user
        ,sysdate
        ,p_column_name
        ,p_change
        ,p_original);
      end if;
    else

      insert into wo_audit(wad_wor_works_order_no
                          ,wad_wol_id
                          ,wad_boq_id
                          ,wad_user
                          ,wad_date
                          ,wad_column_name
                          ,wad_change
                          ,wad_change_from)
      values
      (old_rec.wor_works_order_no
      ,old_rec.wol_id
      ,old_rec.boq_id
      ,user
      ,sysdate
      ,p_column_name
      ,p_change
      ,p_original);
    end if;
  end;

   procedure wor_audit_setup(p_wor_works_order_no in work_orders.wor_works_order_no%type
                            ,p_wor_act_cost        work_orders.wor_act_cost%type
                            ,p_wor_date_confirmed  work_orders.wor_date_confirmed%type
                            ,p_wor_act_cost_code   work_orders.wor_act_cost_code%type
                            ,p_wor_closed_by_id    work_orders.wor_closed_by_id%type
                            ,p_wor_con_id          work_orders.wor_con_id%type
                            ,p_wor_est_complete    work_orders.wor_est_complete%type
                            ,p_wor_est_cost        work_orders.wor_est_cost%type
                            ,p_wor_last_print_date work_orders.wor_last_print_date%type
                            ,p_wor_priority        work_orders.wor_priority%type
                            ,p_wor_rse_he_id_group work_orders.wor_rse_he_id_group%type
                            ,p_wor_score           work_orders.wor_score%type
                            ,p_wor_peo_person_id   work_orders.wor_peo_person_id%type
                            ,p_wor_mod_by_id       work_orders.wor_mod_by_id%type) is

  begin
     old_rec.wor_works_order_no  := p_wor_works_order_no;
     old_rec.wor_act_cost        := p_wor_act_cost;
     old_rec.wor_date_confirmed  := p_wor_date_confirmed;
     old_rec.wor_act_cost_code   := p_wor_act_cost_code;
     old_rec.wor_closed_by_id    := p_wor_closed_by_id;
     old_rec.wor_con_id          := p_wor_con_id;
     old_rec.wor_est_complete    := p_wor_est_complete;
     old_rec.wor_est_cost        := p_wor_est_cost;
     old_rec.wor_last_print_date := p_wor_last_print_date;
     old_rec.wor_priority        := p_wor_priority;
     old_rec.wor_rse_he_id_group := p_wor_rse_he_id_group;
     old_rec.wor_score           := p_wor_score;
     old_rec.wor_peo_person_id   := p_wor_peo_person_id;
     old_rec.wor_mod_by_id       := p_wor_mod_by_id;

  end;
  -- turn these two procedures into 1
   procedure wor_audit(p_wor_works_order_no in work_orders.wor_works_order_no%type
                      ,p_wor_act_cost        work_orders.wor_act_cost%type
                      ,p_wor_date_confirmed  work_orders.wor_date_confirmed%type
                      ,p_wor_act_cost_code   work_orders.wor_act_cost_code%type
                      ,p_wor_closed_by_id    work_orders.wor_closed_by_id%type
                      ,p_wor_con_id          work_orders.wor_con_id%type
                      ,p_wor_est_complete    work_orders.wor_est_complete%type
                      ,p_wor_est_cost        work_orders.wor_est_cost%type
                      ,p_wor_last_print_date work_orders.wor_last_print_date%type
                      ,p_wor_priority        work_orders.wor_priority%type
                      ,p_wor_rse_he_id_group work_orders.wor_rse_he_id_group%type
                      ,p_wor_score           work_orders.wor_score%type
                      ,p_wor_peo_person_id   work_orders.wor_peo_person_id%type
                      ,p_wor_mod_by_id       work_orders.wor_mod_by_id%type) is

       p_user hig_users%ROWTYPE;
       p_user2 hig_users%ROWTYPE;
  begin
    if (nvl(old_rec.wor_works_order_no,'@') != nvl(p_wor_works_order_no,'@') and is_audited('wor_works_order_no')) then
       write_log('wor_works_order_no',p_wor_works_order_no, old_rec.wor_works_order_no);
    end if;
    if (nvl(old_rec.wor_act_cost,'0') != nvl(p_wor_act_cost,'0') and is_audited('wor_act_cost')) then
       write_log('wor_act_cost', p_wor_act_cost, old_rec.wor_act_cost);
    end if;
    if (nvl(old_rec.wor_date_confirmed,'01-JAN-1901') != nvl(p_wor_date_confirmed,'01-JAN-1901') and is_audited('wor_date_confirmed')) then
       write_log('wor_date_confirmed', p_wor_date_confirmed, old_rec.wor_date_confirmed);
    end if;
    if (nvl(old_rec.wor_act_cost_code,'@') != nvl(p_wor_act_cost_code,'@') and is_audited('wor_act_cost_code')) then
       write_log('wor_act_cost_code', p_wor_act_cost_code, old_rec.wor_act_cost_code);
    end if;
    if (nvl(old_rec.wor_closed_by_id,'0') != nvl(p_wor_closed_by_id,'0') and is_audited('wor_closed_by_id')) then
       write_log('wor_closed_by_id', p_wor_closed_by_id, old_rec.wor_closed_by_id);
    end if;
    if (nvl(old_rec.wor_con_id,'0') != nvl(p_wor_con_id,'0') and is_audited('wor_con_id')) then
       write_log('wor_con_id', p_wor_con_id, old_rec.wor_con_id);
    end if;
    if (nvl(old_rec.wor_est_complete,'01-JAN-1901') != nvl(p_wor_est_complete,'01-JAN-1901') and is_audited('wor_est_complete')) then
       write_log('wor_est_complete', p_wor_est_complete, old_rec.wor_est_complete);
    end if;
    if (nvl(old_rec.wor_est_cost,'0') != nvl(p_wor_est_cost,'0') and is_audited('wor_est_cost')) then
       write_log('wor_est_cost', p_wor_est_cost, old_rec.wor_est_cost);
    end if;
    if (nvl(old_rec.wor_last_print_date,'01-JAN-1901') != nvl(p_wor_last_print_date,'01-JAN-1901') and is_audited('wor_last_print_date')) then
       write_log('wor_last_print_date', p_wor_last_print_date, old_rec.wor_last_print_date);
    end if;
    if (nvl(old_rec.wor_priority,'@') != nvl(p_wor_priority,'@') and is_audited('wor_priority')) then
       write_log('wor_priority', p_wor_priority, old_rec.wor_priority);
    end if;
    if (nvl(old_rec.wor_rse_he_id_group,'0') != nvl(p_wor_rse_he_id_group,'0') and is_audited('wor_rse_he_id_group')) then
       write_log('wor_rse_he_id_group', p_wor_rse_he_id_group, old_rec.wor_rse_he_id_group);
    end if;
    if (nvl(old_rec.wor_score,'0') != nvl(p_wor_score,'0') and is_audited('wor_score')) then
       write_log('wor_score', p_wor_score, old_rec.wor_score);
    end if;
    if (nvl(old_rec.wor_peo_person_id ,'0')!= nvl(p_wor_peo_person_id,'0') and is_audited('wor_peo_person_id')) then
       p_user := nm3get.get_hus(p_wor_peo_person_id);
       p_user2 := nm3get.get_hus(old_rec.wor_peo_person_id);
       write_log('wor_peo_person_id', p_user.hus_initials||' '||p_user.hus_name, p_user2.hus_initials||' '||p_user2.hus_name);
    end if;
    if (nvl(old_rec.wor_mod_by_id,'0') != nvl(p_wor_mod_by_id,'0') and is_audited('wor_mod_by_id')) then
       p_user := nm3get.get_hus(p_wor_peo_person_id);
       p_user2 := nm3get.get_hus(old_rec.wor_peo_person_id);
       write_log('wor_mod_by_id', p_user.hus_initials||' '||p_user.hus_name, p_user2.hus_initials||' '||p_user2.hus_name);
       write_log('wor_est_cost', p_wor_est_cost, old_rec.wor_est_cost);
    end if;
    old_rec := clear_rec; -- clear out changes
  end;

   procedure wor_create (p_wor_works_order_no in work_orders.wor_works_order_no%type
                        ,p_wor_peo_person_id  in work_orders.wor_peo_person_id%type
                        ,p_wor_mod_by_id      in work_orders.wor_mod_by_id%type) is
       p_user hig_users%ROWTYPE;
       p_user2 hig_users%ROWTYPE;
   begin
     old_rec.wor_works_order_no := p_wor_works_order_no;
     old_rec.wor_peo_person_id  := p_wor_peo_person_id;
     old_rec.wor_mod_by_id      := p_wor_mod_by_id;
     p_user := nm3get.get_hus(p_wor_peo_person_id);
     p_user2 := nm3get.get_hus(old_rec.wor_peo_person_id);
     write_log('wor_works_order_no', p_wor_works_order_no, null);
     write_log('wor_peo_person_id', p_user.hus_initials||' '||p_user.hus_name, null);
     write_log('wor_mod_by_id', p_user2.hus_initials||' '||p_user.hus_name, null);
     old_rec := clear_rec; -- clear out changes
   end;

   procedure wol_audit_setup(p_wor_works_order_no in work_orders.wor_works_order_no%type
                            ,p_wol_id             in work_order_lines.wol_id%type
                            ,p_wol_date_complete  in work_order_lines.wol_date_complete%type
                            ,p_wol_est_cost       in work_order_lines.wol_est_cost%type
                            ,p_wol_act_cost       in work_order_lines.wol_act_cost%type
                            ,p_wol_rse_he_id      in work_order_lines.wol_rse_he_id%type
                            ,p_wol_status_code    in work_order_lines.wol_status_code%type
                            ,p_wol_gang           in work_order_lines.wol_gang%type) is
   begin
     old_rec.wor_works_order_no := p_wor_works_order_no;
     old_rec.wol_id             := p_wol_id;
     old_rec.wol_date_complete  := p_wol_date_complete;
     old_rec.wol_est_cost       := p_wol_est_cost;
     old_rec.wol_act_cost       := p_wol_act_cost;
     old_rec.wol_rse_he_id      := p_wol_rse_he_id;
     old_rec.wol_status_code    := p_wol_status_code;
     old_rec.wol_gang           := p_wol_gang;
   end;

   procedure wol_audit(p_wor_works_order_no in work_orders.wor_works_order_no%type
                      ,p_wol_id             in work_order_lines.wol_id%type
                      ,p_wol_date_complete  in work_order_lines.wol_date_complete%type
                      ,p_wol_est_cost       in work_order_lines.wol_est_cost%type
                      ,p_wol_act_cost       in work_order_lines.wol_act_cost%type
                      ,p_wol_rse_he_id      in work_order_lines.wol_rse_he_id%type
                      ,p_wol_status_code    in work_order_lines.wol_status_code%type
                      ,p_wol_gang           in work_order_lines.wol_gang%type) is
   begin
    if (old_rec.wol_date_complete != p_wol_date_complete and is_audited('wol_date_complete')) then
       write_log('wol_date_complete', p_wol_date_complete, old_rec.wol_date_complete);
    end if;
    if (old_rec.wol_est_cost != p_wol_est_cost and is_audited('wol_est_cost')) then
       write_log('wol_est_cost', p_wol_est_cost, old_rec.wol_est_cost);
    end if;
    if (old_rec.wol_act_cost != p_wol_act_cost and is_audited('wol_act_cost')) then
       write_log('wol_act_cost', p_wol_act_cost, old_rec.wol_act_cost);
    end if;
    if (old_rec.wol_rse_he_id != p_wol_rse_he_id and is_audited('wol_rse_he_id')) then
       write_log('wol_rse_he_id', p_wol_rse_he_id, old_rec.wol_rse_he_id);
    end if;
    if (old_rec.wol_status_code != p_wol_status_code and is_audited('wol_status_code')) then
       write_log('wol_status_code', p_wol_status_code, old_rec.wol_status_code);
    end if;
    if (old_rec.wol_gang != p_wol_gang and is_audited('wol_gang')) then
       write_log('wol_gang', p_wol_gang, old_rec.wol_gang);
    end if;
    old_rec := clear_rec; -- clear out changes
   end;


   procedure wol_delete (p_wor_works_order_no in work_orders.wor_works_order_no%type
                        ,p_wol_id         in work_order_lines.wol_id%type) is
   begin
     old_rec.wor_works_order_no := p_wor_works_order_no;
     old_rec.wol_id := p_wol_id;
     write_log('wol_id', '* DELETED *', null);
     old_rec := clear_rec; -- clear out changes
   end;

   procedure wol_create (p_wor_works_order_no in work_orders.wor_works_order_no%type
                        ,p_wol_id         in work_order_lines.wol_id%type) is
   begin
     old_rec.wor_works_order_no := p_wor_works_order_no;
     old_rec.wol_id := p_wol_id;
     write_log('wol_id', '* CREATED *', null);
     old_rec := clear_rec; -- clear out changes
   end;


  procedure boq_audit_setup(p_boq_id             in boq_items.boq_id%type
                           ,p_boq_wol_id         in boq_items.boq_wol_id%type
                           ,p_boq_act_cost       in boq_items.boq_act_cost%type
                           ,p_boq_act_quantity   in boq_items.boq_act_quantity%type
                           ,p_boq_act_rate       in boq_items.boq_act_rate%type
                           ,p_boq_est_cost       in boq_items.boq_est_cost%type
                           ,p_boq_est_quantity   in boq_items.boq_est_quantity%type
                           ,p_boq_est_rate       in boq_items.boq_est_rate%type
                           ,p_boq_sta_item_code  in boq_items.boq_sta_item_code%type
                           ) is

begin
  old_rec.boq_id            := p_boq_id;
  old_rec.wol_id            := p_boq_wol_id;

  open  get_wo_id(p_boq_wol_id);
  fetch get_wo_id into old_rec.wor_works_order_no;
  close get_wo_id;

  old_rec.boq_act_cost      := p_boq_act_cost;
  old_rec.boq_act_quantity  := p_boq_act_quantity;
  old_rec.boq_act_rate      := p_boq_act_rate;
  old_rec.boq_est_cost      := p_boq_est_cost;
  old_rec.boq_est_quantity  := p_boq_est_quantity;
  old_rec.boq_est_rate      := p_boq_est_rate;
  old_rec.boq_sta_item_code := p_boq_sta_item_code;
end;

  procedure boq_audit(p_boq_id             in boq_items.boq_id%type
                     ,p_boq_wol_id         in boq_items.boq_wol_id%type
                     ,p_boq_act_cost       in boq_items.boq_act_cost%type
                     ,p_boq_act_quantity   in boq_items.boq_act_quantity%type
                     ,p_boq_act_rate       in boq_items.boq_act_rate%type
                     ,p_boq_est_cost       in boq_items.boq_est_cost%type
                     ,p_boq_est_quantity   in boq_items.boq_est_quantity%type
                     ,p_boq_est_rate       in boq_items.boq_est_rate%type
                     ,p_boq_sta_item_code  in boq_items.boq_sta_item_code%type
                     ) is

  begin
    if (old_rec.boq_act_cost != p_boq_act_cost and is_audited('boq_act_cost')) then
       write_log('boq_act_cost', p_boq_act_cost, old_rec.boq_act_cost);
    end if;
    if (old_rec.boq_act_quantity != p_boq_act_quantity and is_audited('boq_act_quantity')) then
       write_log('boq_act_quantity', p_boq_act_quantity, old_rec.boq_act_quantity);
    end if;
    if (old_rec.boq_act_rate != p_boq_act_rate and is_audited('boq_act_rate')) then
       write_log('boq_act_rate', p_boq_act_rate, old_rec.boq_act_rate);
    end if;
    if (old_rec.boq_est_cost != p_boq_est_cost and is_audited('boq_est_cost')) then
       write_log('boq_est_cost', p_boq_est_cost, old_rec.boq_est_cost);
    end if;
    if (old_rec.boq_est_quantity != p_boq_est_quantity and is_audited('boq_est_quantity')) then
       write_log('boq_est_quantity', p_boq_est_quantity, old_rec.boq_est_quantity);
    end if;
    if (old_rec.boq_est_rate != p_boq_est_rate and is_audited('boq_est_rate')) then
       write_log('boq_est_rate', p_boq_est_rate, old_rec.boq_est_rate);
    end if;
    if (old_rec.boq_sta_item_code != p_boq_sta_item_code and is_audited('boq_sta_item_code')) then
       write_log('boq_sta_item_code', p_boq_sta_item_code, old_rec.boq_sta_item_code);
    end if;
    if (old_rec.boq_act_quantity != p_boq_act_quantity and is_audited('boq_act_quantity')) then
       write_log('boq_act_quantity', p_boq_act_quantity, old_rec.boq_act_quantity);
    end if;
    old_rec := clear_rec; -- clear out changes
  end;

   procedure boq_delete (p_boq_id             in boq_items.boq_id%type
                        ,p_boq_wol_id         in boq_items.boq_wol_id%type) is
   begin
     old_rec.boq_id := p_boq_id;
     old_rec.wol_id := p_boq_wol_id;

     open  get_wo_id(p_boq_wol_id);
     fetch get_wo_id into old_rec.wor_works_order_no;
     close get_wo_id;

     write_log('boq_id', '* DELETED *', null);
     old_rec := clear_rec; -- clear out changes
   end;

   procedure boq_create (p_boq_id             in boq_items.boq_id%type
                        ,p_boq_wol_id         in boq_items.boq_wol_id%type) is
   begin
     old_rec.boq_id := p_boq_id;
     old_rec.wol_id := p_boq_wol_id;

     open  get_wo_id(p_boq_wol_id);
     fetch get_wo_id into old_rec.wor_works_order_no;
     close get_wo_id;

     write_log('boq_id', '* CREATED *', null);
     old_rec := clear_rec; -- clear out changes
   end;

   procedure cp_audit ( pi_wol_id         wo_audit.WAD_WOL_ID%TYPE
                      , pi_new_status     wo_audit.WAD_CHANGE%TYPE
                      , pi_old_status     wo_audit.WAD_CHANGE_FROM%TYPE
                      ) IS
   PRAGMA AUTONOMOUS_TRANSACTION;
   cursor c1 ( p_wol_id work_order_lines.wol_id%TYPE
             ) is
   select wol_works_order_no
   from work_order_lines
   where wol_id = p_wol_id;

   l_works_order_no work_order_lines.wol_works_order_no%TYPE;
   begin
     open c1(pi_wol_id);
     fetch c1 into l_works_order_no;
     close c1;

     insert into wo_audit
               ( WAD_WOR_WORKS_ORDER_NO
               , WAD_WOL_ID
               , WAD_BOQ_ID
               , WAD_USER
               , WAD_DATE
               , WAD_COLUMN_NAME
               , WAD_CHANGE
               , WAD_CHANGE_FROM
               ) values
               ( l_works_order_no
               , pi_wol_id
               , ''
               , user
               , sysdate
               , 'cp_status'
               , pi_new_status
               , pi_old_status
               );

     commit;
   end;

   procedure cpa_audit ( pi_cp_woc_claim_ref   in claim_payments.cp_woc_claim_ref%TYPE
                       , pi_cp_woc_con_id      in claim_payments.cp_woc_con_id%TYPE
                       , pi_cp_wol_id          in claim_payments.cp_wol_id%TYPE
                       , pi_cp_status          in claim_payments.cp_status%TYPE
                       , pi_cp_claim_value     in claim_payments.cp_claim_value%TYPE
                       , pi_cp_payment_id      in claim_payments.cp_payment_id%TYPE
                       , pi_cp_payment_value   in claim_payments.cp_payment_value%TYPE
                       , pi_cp_payment_date    in claim_payments.cp_payment_date%TYPE
                       , pi_cp_fis_payment_ref in claim_payments.cp_fis_payment_ref%TYPE
                       , pi_cp_fyr_id          in claim_payments.cp_fyr_id%TYPE
                       , pi_cp_invoice_no      in claim_payments.cp_invoice_no%TYPE
                       ) IS
   l_cpa_id claim_payments_audit.cpa_id%TYPE;

   cursor c1 is
   select CPA_ID_SEQ.NEXTVAL
   from dual;

   begin
     open c1;
     fetch c1 into l_cpa_id;
     close c1;

     insert into claim_payments_audit ( CPA_ID
                                      , CPA_WOC_CLAIM_REF
                                      , CPA_WOC_CON_ID
                                      , CPA_WOL_ID
                                      , CPA_DATE
                                      , CPA_STATUS
                                      , CPA_CLAIM_VALUE
                                      , CPA_PAYMENT_ID
                                      , CPA_PAYMENT_VALUE
                                      , CPA_PAYMENT_DATE
                                      , CPA_FIS_PAYMENT_REF
                                      , CPA_FYR_ID
                                      , CPA_INVOICE_NO
                                      )
     values
     ( l_cpa_id
     , pi_cp_woc_claim_ref
     , pi_cp_woc_con_id
     , pi_cp_wol_id
     , sysdate
     , pi_cp_status
     , pi_cp_claim_value
     , pi_cp_payment_id
     , pi_cp_payment_value
     , pi_cp_payment_date
     , pi_cp_fis_payment_ref
     , pi_cp_fyr_id
     , pi_cp_invoice_no
     );
   end;
-----------------------------------------------------------------------------------------
-- startup code

begin
   -- create list of audited columns
   for a_rec in get_audit_cols loop
     aud_tab_no := aud_tab_no + 1;
     audit_rec(aud_tab_no) := a_rec.col_name;
   end loop;

   -- check what user wishes to log
   log_all := hig.get_sysopt('AUDIT_ALL');
   if log_all = 'N' then
      session_start := sysdate;
   end if;
-----------------------------------------------------------------------------------------
end;
/
