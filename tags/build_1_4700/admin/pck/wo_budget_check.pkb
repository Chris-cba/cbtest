CREATE OR REPLACE package body wo_budget_check
as
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/wo_budget_check.pkb-arc   2.3   Jul 01 2013 16:26:54   James.Wadsworth  $
--       Module Name      : $Workfile:   wo_budget_check.pkb  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:26:54  $
--       Date fetched Out : $Modtime:   Jul 01 2013 16:17:46  $
--       SCCS Version     : $Revision:   2.3  $
--       Based onSCCS Version     : 1.3
--
-----------------------------------------------------------------------------
--   Originally taken from @(#)wo_budget_check.pck	1.1 03/26/02
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   2.3  $';
g_package_name  CONSTANT  varchar2(30)   := 'wo_budget_check';
--
-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN VARCHAR2 IS
BEGIN
  RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version RETURN VARCHAR2 IS
BEGIN
  RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--
PROCEDURE update_budget(p_bud_committed budgets.bud_committed%TYPE
                       ,p_bud_actual    budgets.bud_actual%TYPE
                       ,p_bud_id        budgets.bud_id%TYPE)
  IS
  --
BEGIN
  --
  UPDATE BUDGETS
     SET bud_committed = NVL(p_bud_committed,0)
        ,bud_actual    = NVL(p_bud_actual,0)
   WHERE bud_id = p_bud_id
       ;
  --
  COMMIT;
  --
END update_budget;
---------------------------------------------------------------------

PROCEDURE update_valbud(p_bud_id         IN budgets.bud_id%TYPE
                       ,p_bud_committed  IN OUT budgets.bud_committed%TYPE
                       ,p_bud_actual     IN OUT budgets.bud_actual%TYPE
                       ,p_update_records IN OUT boolean)
  IS
  --
  TYPE wol_rec IS RECORD (wol_id              work_order_lines.wol_id%TYPE
                         ,wol_status_code     work_order_lines.wol_status_code%TYPE
                         ,wor_date_confirmed  work_orders.wor_date_confirmed%TYPE
                         ,wol_est_cost        work_order_lines.wol_est_cost%TYPE
                         ,wol_act_cost        work_order_lines.wol_act_cost%TYPE
                         ,wol_unposted_est    work_order_lines.wol_unposted_est%TYPE);
  TYPE wol_rec_tab IS TABLE OF wol_rec INDEX BY BINARY_INTEGER;
  lt_wols wol_rec_tab;
  --
  CURSOR get_features(cp_status_code WORK_ORDER_LINES.wol_status_code%TYPE)
      IS
  SELECT hsc_allow_feature1
        ,hsc_allow_feature2
        ,hsc_allow_feature3
        ,hsc_allow_feature4
        ,hsc_allow_feature5
        ,hsc_allow_feature6
        ,hsc_allow_feature7
        ,hsc_allow_feature8
        ,hsc_allow_feature9
    FROM hig_status_codes
   WHERE hsc_domain_code = 'WORK_ORDER_LINES'
     AND hsc_status_code = cp_status_code
       ;
  --
  lv_allow_feature1  hig_status_codes.hsc_allow_feature1%TYPE;
  lv_allow_feature2  hig_status_codes.hsc_allow_feature2%TYPE;
  lv_allow_feature3  hig_status_codes.hsc_allow_feature3%TYPE;
  lv_allow_feature4  hig_status_codes.hsc_allow_feature4%TYPE;
  lv_allow_feature5  hig_status_codes.hsc_allow_feature5%TYPE;
  lv_allow_feature6  hig_status_codes.hsc_allow_feature6%TYPE;
  lv_allow_feature7  hig_status_codes.hsc_allow_feature7%TYPE;
  lv_allow_feature8  hig_status_codes.hsc_allow_feature8%TYPE;
  lv_allow_feature9  hig_status_codes.hsc_allow_feature9%TYPE;
  --
  lv_calc_wol_unposted_est WORK_ORDER_LINES.wol_unposted_est%TYPE;
  --
BEGIN
  --
  p_update_records := TRUE;
  --
  SELECT wol_id
        ,wol_status_code
        ,wor_date_confirmed -- GA 17012007
        ,ROUND(NVL(wol_est_cost,0)
               + ((NVL(wol_est_cost,0)/DECODE(NVL(wor_est_cost,0),0,1,wor_est_cost))*NVL(wor_est_balancing_sum,0))
              ,2) wol_est_cost
        ,ROUND(NVL(wol_act_cost,0)
               + ((NVL(wol_act_cost,0)/DECODE(NVL(wor_act_cost,0),0,1,wor_act_cost))*NVL(wor_act_balancing_sum,0))
              ,2) wol_act_cost
        ,wol_unposted_est
    BULK COLLECT
    INTO lt_wols
    FROM work_order_lines
        ,work_orders
   WHERE wor_works_order_no = wol_works_order_no
     AND wol_bud_id         = p_bud_id
       ;
  --
  FOR i IN 1..lt_wols.count LOOP
    --
    OPEN  get_features(lt_wols(i).wol_status_code);
    FETCH get_features
     INTO lv_allow_feature1
         ,lv_allow_feature2
         ,lv_allow_feature3
         ,lv_allow_feature4
         ,lv_allow_feature5
         ,lv_allow_feature6
         ,lv_allow_feature7
         ,lv_allow_feature8
         ,lv_allow_feature9;
    CLOSE get_features;
    --
    IF (lv_allow_feature1 = 'Y' OR lv_allow_feature7 = 'Y')       -- INSTRUCTED or ACTIONED
     AND lt_wols(i).wor_date_confirmed IS NOT NULL                   -- THE ORDER IS INSTRUCTED -- GA 17012007
     THEN
        --
        p_bud_committed := p_bud_committed + lt_wols(i).wol_est_cost;
        lv_calc_wol_unposted_est := lt_wols(i).wol_est_cost;
        --
    ELSIF(lv_allow_feature4 = 'Y' AND lv_allow_feature9 = 'Y')   -- PART PAID
     OR lv_allow_feature8 = 'Y'                                  -- VALUATION and UNAPROVED
     OR lv_allow_feature9 = 'Y'                                  -- INTERIM
     OR lv_allow_feature6 = 'Y'                                  -- PART COMP
     OR lv_allow_feature2 = 'Y'                                  -- HELD
     THEN
        --
        -- if (est +ve and act +ve and act >= est) OR (est -ve and act -ve and abs(act) >= est
        -- then nothing to add
        -- else add estimate - actual
        --
		    IF ((sign(lt_wols(i).wol_est_cost)=1
		 	       AND sign(lt_wols(i).wol_act_cost)=1
		 	       AND lt_wols(i).wol_act_cost >= lt_wols(i).wol_est_cost)
		        OR(sign(lt_wols(i).wol_est_cost)=-1
		 	         AND sign(lt_wols(i).wol_act_cost)=-1
		 	         AND abs(lt_wols(i).wol_act_cost) >= abs(lt_wols(i).wol_est_cost))
            OR(sign(lt_wols(i).wol_est_cost)=0)
            OR(sign(lt_wols(i).wol_est_cost)=-1
               AND sign(lt_wols(i).wol_act_cost)=1))
		     THEN
			      null ; -- do nothing
--		    ELSIF sign(lt_wols(i).wol_est_cost)=1
--         AND sign(lt_wols(i).wol_act_cost)=-1
--         THEN
--            p_bud_committed := p_bud_committed + (lt_wols(i).wol_est_cost + lt_wols(i).wol_act_cost);
		    ELSE
		        lv_calc_wol_unposted_est := lt_wols(i).wol_est_cost - lt_wols(i).wol_act_cost;
			      p_bud_committed := p_bud_committed + lv_calc_wol_unposted_est;
		    END IF;
       	--
        p_bud_actual := p_bud_actual + lt_wols(i).wol_act_cost;
        --
    ELSIF lv_allow_feature3 = 'Y'  -- COMPLETED
     OR lv_allow_feature4 = 'Y'    -- PAID
     THEN
        --
        lv_calc_wol_unposted_est := 0;
        p_bud_actual := p_bud_actual + lt_wols(i).wol_act_cost;
        --
    ELSIF lv_allow_feature5 = 'Y'  -- NOT DONE
     THEN
        /*
        || NOT DONE has no effect on either the commited or the actual values.
        */
        null;
    END IF;
    /*
    || Check the calculated unposted est against the
    || unposted est on the WOL and update where necessary.
    */
    IF lv_calc_wol_unposted_est < 0
     THEN
        lv_calc_wol_unposted_est := 0;
    END IF;
    --
    IF lv_calc_wol_unposted_est != lt_wols(i).wol_unposted_est
     THEN
        UPDATE work_order_lines
           SET wol_unposted_est = lv_calc_wol_unposted_est
         WHERE wol_id = lt_wols(i).wol_id
             ;
    END IF;
    --
  END LOOP;
  --
END update_valbud;
---------------------------------------------------------------------
PROCEDURE valbud_unique(p_bud_id budgets.bud_id%TYPE)
  IS
  --
  lv_bud_committed   BUDGETS.bud_committed%TYPE := 0;
  lv_bud_actual      BUDGETS.bud_actual%TYPE := 0;
  update_records     BOOLEAN;
  --
BEGIN
  --
  update_valbud(p_bud_id         => p_bud_id
               ,p_bud_committed  => lv_bud_committed
               ,p_bud_actual     => lv_bud_actual
               ,p_update_records => update_records);
  --
  IF update_records
   THEN
      update_budget(p_bud_committed => lv_bud_committed
                   ,p_bud_actual    => lv_bud_actual
                   ,p_bud_id        => p_bud_id);
  END IF;
  --
  COMMIT;
  --
END valbud_unique;
---------------------------------------------------------------------
PROCEDURE valbud IS
  --
  CURSOR get_bud
      IS
  SELECT bud_id
    FROM budgets
   WHERE to_number(bud_fyr_id) > 1999;
  --
BEGIN
  --
  FOR bud_rec IN get_bud LOOP
    valbud_unique(p_bud_id => bud_rec.bud_id);
  END LOOP;
  --
END valbud;
---------------------------------------------------------------------
END wo_budget_check;
/
