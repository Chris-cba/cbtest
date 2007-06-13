CREATE OR REPLACE package body wo_budget_check
as
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/wo_budget_check.pkb-arc   2.0   Jun 13 2007 17:36:52   smarshall  $
--       Module Name      : $Workfile:   wo_budget_check.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:52  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based onSCCS Version     : 1.3
--
-----------------------------------------------------------------------------
--   Originally taken from @(#)wo_budget_check.pck	1.1 03/26/02
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------
---------------------------------------------------------------------
PROCEDURE update_budget( p_bud_committed budgets.bud_committed%TYPE
                       , p_bud_actual    budgets.bud_actual%TYPE
                       , p_bud_id        budgets.bud_id%TYPE
                       ) IS

BEGIN
  UPDATE BUDGETS
  SET bud_committed = NVL(p_bud_committed,0)
    , bud_actual    = NVL(p_bud_actual,0)
  WHERE bud_id = p_bud_id;

  COMMIT;
END update_budget;
---------------------------------------------------------------------

PROCEDURE update_valbud( p_bud_id         IN budgets.bud_id%TYPE --IN
                       , p_bud_committed  IN OUT budgets.bud_committed%TYPE --OUT
                       , p_bud_actual     IN OUT budgets.bud_actual%TYPE --OUT
                       , p_update_records IN OUT boolean --OUT
                       ) IS
--

  CURSOR get_wol(p_bud_id BUDGETS.bud_id%TYPE)
      IS
  SELECT wol_status_code,
         wor_date_confirmed, -- GA 17012007
         round(NVL(wol_est_cost,0)+
((nvl(wol_est_cost,0)/decode(wor_est_cost,0,1,null,1,wor_est_cost))*nvl(wor_est_balancing_sum,0)),2) wol_est_cost,
         round(nvl(wol_act_cost,0)+
((nvl(wol_act_cost,0)/decode(wor_act_cost,0,1,null,1,wor_act_cost))*nvl(wor_act_balancing_sum,0)),2) wol_act_cost
    FROM WORK_ORDER_LINES
        ,WORK_ORDERS
   WHERE wor_works_order_no = wol_works_order_no
     AND wol_bud_id         = p_bud_id
       ;
  --
  cursor get_features(p_status_code WORK_ORDER_LINES.wol_status_code%TYPE)
      is
  select hsc_allow_feature1
        ,hsc_allow_feature2
        ,hsc_allow_feature3
        ,hsc_allow_feature4
        ,hsc_allow_feature5
        ,hsc_allow_feature6
        ,hsc_allow_feature7
        ,hsc_allow_feature8
        ,hsc_allow_feature9
    from HIG_STATUS_CODES
   where hsc_domain_code = 'WORK_ORDER_LINES'
     and hsc_status_code = p_status_code
       ;
  --
  lv_allow_feature1  HIG_STATUS_CODES.hsc_allow_feature1%TYPE;
  lv_allow_feature2  HIG_STATUS_CODES.hsc_allow_feature2%TYPE;
  lv_allow_feature3  HIG_STATUS_CODES.hsc_allow_feature3%TYPE;
  lv_allow_feature4  HIG_STATUS_CODES.hsc_allow_feature4%TYPE;
  lv_allow_feature5  HIG_STATUS_CODES.hsc_allow_feature5%TYPE;
  lv_allow_feature6  HIG_STATUS_CODES.hsc_allow_feature6%TYPE;
  lv_allow_feature7  HIG_STATUS_CODES.hsc_allow_feature7%TYPE;
  lv_allow_feature8  HIG_STATUS_CODES.hsc_allow_feature8%TYPE;
  lv_allow_feature9  HIG_STATUS_CODES.hsc_allow_feature9%TYPE;
  --
BEGIN
--
    p_update_records := TRUE;
--
    FOR wol_rec IN get_wol(p_bud_id) LOOP
      --

      open  get_features(wol_rec.wol_status_code);
      fetch get_features
       into lv_allow_feature1
           ,lv_allow_feature2
           ,lv_allow_feature3
           ,lv_allow_feature4
           ,lv_allow_feature5
           ,lv_allow_feature6
           ,lv_allow_feature7
           ,lv_allow_feature8
           ,lv_allow_feature9;
      close get_features;
      --
      IF (lv_allow_feature1 = 'Y'                                   -- INSTRUCTED
        or lv_allow_feature7 = 'Y') and                             -- ACTIONED
          wol_rec.wor_date_confirmed is not null                    -- THE ORDER IS INSTRUCTED -- GA 17012007
       THEN
          --
          p_bud_committed := p_bud_committed + wol_rec.wol_est_cost;
          --
      ELSIF(lv_allow_feature4 = 'Y' AND lv_allow_feature9 = 'Y')   -- PART PAID
            OR lv_allow_feature8 = 'Y'                             -- VALUATION and UNAPROVED
            OR lv_allow_feature9 = 'Y'                             -- INTERIM
            OR lv_allow_feature6 = 'Y'                             -- PART COMP
            OR lv_allow_feature2 = 'Y'                             -- HELD
       THEN
--
--         if (est +ve and act +ve and act >= est) OR (est -ve and act -ve and abs(act) >= est
--            then  nothing to add
--   		  else  add estimate - actual
--
		IF ((sign(wol_rec.wol_est_cost)=1
		 	and sign(wol_rec.wol_act_cost)=1
		 	and wol_rec.wol_act_cost >= wol_rec.wol_est_cost)
		OR (sign(wol_rec.wol_est_cost)=-1
		 	and sign(wol_rec.wol_act_cost)=-1
		 	and abs(wol_rec.wol_act_cost) >= abs(wol_rec.wol_est_cost))
                OR (sign(wol_rec.wol_est_cost)=0)
                OR (sign(wol_rec.wol_est_cost)=-1
                        and sign(wol_rec.wol_act_cost)=1))
		then
			null ; -- do nothing
		elsif (sign(wol_rec.wol_est_cost)=1
                        and sign(wol_rec.wol_act_cost)=-1)
                then
                        p_bud_committed := p_bud_committed + (wol_rec.wol_est_cost + wol_rec.wol_act_cost);
		else
			p_bud_committed := p_bud_committed + (wol_rec.wol_est_cost - wol_rec.wol_act_cost);
		end if;
       	--
          p_bud_actual := p_bud_actual + wol_rec.wol_act_cost;
          --
      ELSIF lv_allow_feature3 = 'Y'                                -- COMPLETED
            OR lv_allow_feature4 = 'Y'                             -- PAID
       THEN
          --
          p_bud_actual := p_bud_actual + wol_rec.wol_act_cost;
          --
      ELSIF lv_allow_feature5 = 'Y'                                -- NOT DONE
       THEN
          /*
          || NOT DONE has no effect on either the commited of the actual values.
          */
          null;
      END IF;
      --
    END LOOP;
    --
END update_valbud;
---------------------------------------------------------------------
PROCEDURE valbud_unique( p_bud_id budgets.bud_id%TYPE
                       ) IS
--
lv_bud_committed   BUDGETS.bud_committed%TYPE := 0;
lv_bud_actual      BUDGETS.bud_actual%TYPE := 0;
update_records     BOOLEAN;
--
BEGIN
--
  update_valbud( p_bud_id
               , lv_bud_committed
               , lv_bud_actual
               , update_records
               );
--
  IF update_records
  THEN

    update_budget( lv_bud_committed
                  , lv_bud_actual
                  , p_bud_id
                  );
  END IF;
--
END valbud_unique;
---------------------------------------------------------------------
PROCEDURE valbud IS
--
  CURSOR get_bud IS
  SELECT bud_id
    FROM budgets
   WHERE to_number(bud_fyr_id) > 1999;
--
BEGIN
--
  FOR bud_rec IN get_bud LOOP
    valbud_unique(bud_rec.bud_id);
  END LOOP;
--
END valbud;
---------------------------------------------------------------------
end wo_budget_check;
/
