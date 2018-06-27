CREATE OR REPLACE PACKAGE BODY Mai_Budgets AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/mai_budgets.pkb-arc   2.6   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   mai_budgets.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:30  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:54:14  $
--       SCCS Version     : $Revision:   2.6  $
--       Based on SCCS Version     : 1.7
--
-----------------------------------------------------------------------------
--   Originally taken from (#)budgets.pck	1.13 12/18/02'
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--all global package variables here

  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '$Revision:   2.6  $';

--
-----------------------------------------------------------------------------
--
   CURSOR current_budget(v_bud_id BUDGETS.bud_id%TYPE) IS
      SELECT bud_value,
             bud_committed,
             bud_actual
      FROM BUDGETS
      WHERE bud_id = v_bud_id;

   CURSOR wol_unposted_est(p_wol_id IN WORK_ORDER_LINES.wol_id%TYPE) IS
      SELECT NVL(wol_unposted_est,0)
      FROM WORK_ORDER_LINES
      WHERE wol_id = p_wol_id;

--
-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN varchar2 IS
BEGIN
   RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
   -- updates the specified budgets committed values
   -- returns TRUE if value is applied and does not go over budget
   FUNCTION update_budget_committed ( p_wol_id         WORK_ORDER_LINES.wol_id%TYPE,
                                      p_bud_id         BUDGETS.bud_id%TYPE,
                                      p_bud_committed  BUDGETS.bud_committed%TYPE
                                    ) RETURN BOOLEAN
   IS
   rtrn           BOOLEAN := TRUE;
   v_wol_act_cost WORK_ORDER_LINES.wol_act_cost%TYPE;

   CURSOR c1 IS
    SELECT NVL(wol_act_cost,0)
    FROM WORK_ORDER_LINES
    WHERE wol_id = p_wol_id;

   p_bud_value budgets.bud_value%TYPE;
   p_bud_committed2 budgets.bud_committed%TYPE;
   p_bud_actual budgets.bud_actual%TYPE;

   BEGIN
     -- check that there isn't any posting against the wol_act_cost
     OPEN c1;
     FETCH c1 INTO v_wol_act_cost;
     IF c1%NOTFOUND THEN
      RETURN FALSE;
     END IF;
     CLOSE c1;

     IF v_wol_act_cost = 0 THEN
        -- check that applying the value will not go over budget
        IF check_budget(p_bud_id, p_bud_committed, 0) AND NOT allow_over_budget THEN
           rtrn := FALSE;
        ELSE

           UPDATE BUDGETS
           SET bud_committed = bud_committed + p_bud_committed
           WHERE bud_id = p_bud_id;
           -- update the work_order_lines unposted value
           UPDATE WORK_ORDER_LINES
           SET wol_unposted_est = NVL(wol_unposted_est,0) + p_bud_committed
           WHERE wol_id = p_wol_id;
           --
/****************************************************************************************
** SM 5-JAN-2007 707222
** Commented out the wo_budget_check line at GA request based on above log. Wanted it
** moving to form.
*****************************************************************************************
       wo_budget_check.valbud_unique(p_bud_id);
****************************************************************************************/
           --
/*           if hig.get_user_or_sys_opt('BUDAUDT') = 'Y' then
             select bud_value, bud_committed, bud_actual
             into p_bud_value, p_bud_committed2, p_bud_actual
             from budgets
             where bud_id = p_bud_id;
             --
             interfaces.write_BAT( p_bud_id
                                 , 'update_budget_committed'
                                 , p_wol_id
                                 , sysdate
                                 , p_bud_committed
                                 , p_bud_value
                                 , p_bud_committed2
                                 , p_bud_actual
                                 );
             commit;
           end if;*/
        END IF;
     ELSE
        -- handled by update_budget_actual
        rtrn := TRUE;
     END IF;
     RETURN rtrn;
   END;
----------------------------------------------------------------------------------------
   -- updates the specified budgets actual and committed values
   -- returns TRUE if value is applied and does not go over budget
   FUNCTION update_budget_actual ( p_wol_id         WORK_ORDER_LINES.wol_id%TYPE,
                                   p_bud_id         BUDGETS.bud_id%TYPE,
                                   p_bud_actual     BUDGETS.bud_actual%TYPE,
                                   p_claim_type     VARCHAR2 DEFAULT NULL
                                 ) RETURN BOOLEAN
   IS
   rtrn               BOOLEAN := TRUE;
   v_committed        BUDGETS.bud_committed%TYPE ;
   v_wol_unposted_est WORK_ORDER_LINES.wol_unposted_est%TYPE := 0;
   v_wol_est_cost     WORK_ORDER_LINES.wol_est_cost%TYPE;
   v_wol_act_cost     WORK_ORDER_LINES.wol_act_cost%TYPE;
   v_unposted_recalc  BOOLEAN := FALSE;

   cursor c1 is
     select 'COMPLETED'
     from   work_order_lines, hig_status_codes
     where  sysdate between nvl(hsc_start_date,sysdate) and nvl(hsc_end_date,sysdate)
       and  hsc_allow_feature3 = 'Y'
       and  hsc_status_code = wol_status_code
       and  hsc_domain_code = 'WORK_ORDER_LINES'
       and  wol_id = p_wol_id;

   cursor c2 (lp_wol_id WORK_ORDER_LINES.wol_id%TYPE) is
     select wol_est_cost
            ,wol_act_cost
     from   work_order_lines
     where  wol_id = lp_wol_id;

   lstatus varchar2(10) := NULL;
   l_committed      BUDGETS.bud_actual%TYPE := null;
   p_bud_committed2 BUDGETS.bud_committed%TYPE := null;
   p_bud_actual2    BUDGETS.bud_actual%TYPE := null;
   p_bud_value      BUDGETS.bud_value%TYPE;

   BEGIN
      nm_debug.debug_on;
     -- check that applying the value will not go over budget
     -- check that there is enough committed to apply actual

     open c1;
     fetch c1 into lstatus;
     close c1;

     OPEN wol_unposted_est(p_wol_id);
     FETCH wol_unposted_est INTO v_wol_unposted_est;
     CLOSE wol_unposted_est;

     -- calculate what the committed value should be

     IF lstatus IS NULL AND
        NVL(p_claim_type, '@') != 'F' 
     THEN

        IF v_wol_unposted_est = 0 then                --If the Actual Value has been greater than or
                                                      --equal to the Estimated Value WOL_UNPOSTED_EST
           OPEN  c2(p_wol_id);                        --will be zero.
           FETCH c2                                   --If the new Actual Value is below the Estimated
             INTO v_wol_est_cost                      --Value the difference should be place in the
                 ,v_wol_act_cost;                     --Committed Value of the Budget and the
           CLOSE c2;                                  --WOL_UNPOSTED_EST on the WOL.

           IF NVL(v_wol_est_cost,0) - NVL(v_wol_act_cost,0) > 0 THEN
              v_wol_unposted_est := NVL(v_wol_est_cost,0) - NVL(v_wol_act_cost,0);
              v_unposted_recalc := TRUE;
           END IF;

        END IF;
        IF abs(v_wol_unposted_est) >= abs(p_bud_actual) or
           (v_wol_unposted_est < 0 and p_bud_actual > 0 and
            (abs(v_wol_unposted_est) < abs(p_bud_actual))) or
           (v_wol_unposted_est > 0 and p_bud_actual < 0 and
            (v_wol_unposted_est < p_bud_actual)) or
	   (v_wol_unposted_est > 0 and p_bud_actual < 0 and --SM ADDED 1
            (v_wol_unposted_est > p_bud_actual)) THEN
           v_committed := p_bud_actual;
           IF NOT v_unposted_recalc THEN
              v_wol_unposted_est := v_wol_unposted_est - p_bud_actual;
           ELSE
	      v_committed := v_wol_unposted_est*-1;-- SM ADDED 2
           END IF;
        ELSE
           IF v_unposted_recalc THEN
             v_committed := v_wol_unposted_est*-1;
           ELSE
             v_committed := v_wol_unposted_est;
             v_wol_unposted_est := 0;
           END IF;
        END IF;
     ELSIF lstatus = 'COMPLETED' OR
           NVL(p_claim_type,'@') = 'F'
        THEN
        v_committed := v_wol_unposted_est;
        v_wol_unposted_est := 0;
     END IF;

     IF check_budget(p_bud_id, (v_committed * -1), p_bud_actual ) AND NOT allow_over_budget THEN
       rtrn := FALSE;

     ELSE

       UPDATE BUDGETS
       SET bud_committed = NVL(bud_committed,0) - NVL(v_committed,0),
           bud_actual = NVL(bud_actual,0) + NVL(p_bud_actual,0)
       WHERE bud_id = p_bud_id;

       UPDATE WORK_ORDER_LINES
       SET wol_unposted_est = v_wol_unposted_est
       WHERE wol_id = p_wol_id;
       
       -- Log 715703 JW 29-SEP-2008     
       --COMMIT;
       --
/****************************************************************************************
** SM 5-JAN-2007 707222
** Commented out the wo_budget_check line at GA request based on above log. Wanted it
** moving to form.
*****************************************************************************************
       wo_budget_check.valbud_unique(p_bud_id);
****************************************************************************************/       
       --
/*           if hig.get_user_or_sys_opt('BUDAUDT') = 'Y' then
             select bud_value, bud_committed, bud_actual
             into p_bud_value, p_bud_committed2, p_bud_actual2
             from budgets
             where bud_id = p_bud_id;
             --
             interfaces.write_BAT( p_bud_id
                                 , 'update_budget_actual'
                                 , p_wol_id
                                 , sysdate
                                 , p_bud_actual
                                 , p_bud_value
                                 , p_bud_committed2
                                 , p_bud_actual2
                                 );
             commit;
           end if;       */
     END IF;
     RETURN rtrn;
   END;
----------------------------------------------------------------------------------------
   -- returns the value over/under budget if the passed values were to
   -- be applied to the specified budget
   -- negative value means under budget
   FUNCTION  check_budget_value ( p_bud_id         BUDGETS.bud_id%TYPE,
                                  p_bud_committed  BUDGETS.bud_committed%TYPE,
                                  p_bud_actual     BUDGETS.bud_actual%TYPE,
                                  p_wol_id         WORK_ORDER_LINES.wol_id%TYPE DEFAULT NULL
                                ) RETURN NUMBER
   IS

   rtrn NUMBER := 0;
   v_bud_value        BUDGETS.bud_value%TYPE;
   v_bud_committed    BUDGETS.bud_committed%TYPE;
   v_bud_actual       BUDGETS.bud_actual%TYPE;
   v_wol_unposted_est WORK_ORDER_LINES.wol_unposted_est%TYPE := 0;
   v_act_to_check     BUDGETS.bud_actual%TYPE;
   BEGIN
       v_act_to_check := NVL(p_bud_actual,0);
    -- if we are checking against a work order line
    -- if so then check how much of the estimate is left unposted
    -- when posting actual costs
    IF p_wol_id IS NOT NULL THEN
      OPEN wol_unposted_est(p_wol_id);
      FETCH wol_unposted_est INTO v_wol_unposted_est;
      CLOSE wol_unposted_est;

      IF v_wol_unposted_est - NVL(p_bud_actual, 0) >= 0 THEN
         v_act_to_check := 0;
      ELSE
         v_act_to_check := NVL(p_bud_actual,0) - v_wol_unposted_est;
      END IF;
    END IF;

    OPEN current_budget( p_bud_id );
    FETCH current_budget INTO v_bud_value, v_bud_committed, v_bud_actual;
    CLOSE current_budget;

    IF v_bud_value = -1 THEN
      rtrn := 0 - ( v_bud_committed + v_bud_actual + p_bud_committed + v_act_to_check );
    ELSE
      rtrn := v_bud_value - ( v_bud_committed + v_bud_actual + p_bud_committed + v_act_to_check );
      rtrn := rtrn * -1;
    END IF;
    
nm_debug.debug_off;
    
    RETURN rtrn;
   END;
----------------------------------------------------------------------------------------
   -- returns a percent value over/under budget if the passed values were to
   -- be applied to the specified budget
   FUNCTION  check_budget_percent ( p_bud_id         BUDGETS.bud_id%TYPE,
                                    p_bud_committed  BUDGETS.bud_committed%TYPE,
                                    p_bud_actual     BUDGETS.bud_actual%TYPE,
                                    p_wol_id         WORK_ORDER_LINES.wol_id%TYPE DEFAULT NULL
                                  ) RETURN NUMBER
   IS
   rtrn               NUMBER := 0;
   v_temp             NUMBER := 0;
   v_bud_value        BUDGETS.bud_value%TYPE;
   v_bud_committed    BUDGETS.bud_committed%TYPE;
   v_bud_actual       BUDGETS.bud_actual%TYPE;
   v_wol_unposted_est WORK_ORDER_LINES.wol_unposted_est%TYPE := 0;
   v_act_to_check     BUDGETS.bud_actual%TYPE;
   BEGIN
     v_act_to_check := NVL(p_bud_actual,0);
    -- if we are checking against a work order line
    -- if so then check how much of the estimate is left unposted
    -- when posting actual costs
    IF p_wol_id IS NOT NULL THEN
      OPEN wol_unposted_est(p_wol_id);
      FETCH wol_unposted_est INTO v_wol_unposted_est;
      CLOSE wol_unposted_est;

      IF v_wol_unposted_est - NVL(p_bud_actual, 0) >= 0 THEN
         v_act_to_check := 0;
      ELSE
         v_act_to_check := NVL(p_bud_actual,0) - v_wol_unposted_est;
      END IF;
    END IF;

    OPEN current_budget( p_bud_id );
    FETCH current_budget INTO v_bud_value, v_bud_committed, v_bud_actual;
    CLOSE current_budget;

    IF v_bud_value = -1 THEN
      RETURN 0;
    ELSE
      v_temp := v_bud_value - ( v_bud_committed + v_bud_actual + p_bud_committed + v_act_to_check );
    END IF;
    rtrn := (v_temp/v_bud_value)*100;

    RETURN (rtrn * -1);
   END;
----------------------------------------------------------------------------------------
   -- returns TRUE if over budget when passed values are applied to the budget
   -- or returns FALSE is under budget
   FUNCTION  check_budget ( p_bud_id         BUDGETS.bud_id%TYPE,
                            p_bud_committed  BUDGETS.bud_committed%TYPE,
                            p_bud_actual     BUDGETS.bud_actual%TYPE,
                            p_wol_id         WORK_ORDER_LINES.wol_id%TYPE DEFAULT NULL
                          ) RETURN BOOLEAN
   IS
   rtrn               BOOLEAN := FALSE;
   v_temp             NUMBER:=0;
   v_bud_value        BUDGETS.bud_value%TYPE;
   v_bud_committed    BUDGETS.bud_committed%TYPE;
   v_bud_actual       BUDGETS.bud_actual%TYPE;
   v_wol_unposted_est WORK_ORDER_LINES.wol_unposted_est%TYPE := 0;
   v_act_to_check     BUDGETS.bud_actual%TYPE;
   BEGIN
    v_act_to_check := NVL(p_bud_actual,0);
    -- if we are checking against a work order line
    -- if so then check how much of the estimate is left unposted
    -- when posting actual costs
    IF p_wol_id IS NOT NULL THEN
      OPEN wol_unposted_est(p_wol_id);
      FETCH wol_unposted_est INTO v_wol_unposted_est;
      CLOSE wol_unposted_est;

      IF v_wol_unposted_est - NVL(p_bud_actual, 0) >= 0 THEN
         v_act_to_check := 0;
         
      ELSE
         v_act_to_check := NVL(p_bud_actual,0) - v_wol_unposted_est;
      END IF;
    END IF;

    OPEN current_budget( p_bud_id );
    FETCH current_budget INTO v_bud_value, v_bud_committed, v_bud_actual;
    CLOSE current_budget;

    -- only check the budget if doesn't equal -1
    IF v_bud_value != -1 THEN
       v_temp := v_bud_value - ( v_bud_committed + v_bud_actual + p_bud_committed + v_act_to_check );

       IF v_temp < 0 THEN
          rtrn := TRUE;
       END IF;
    END IF;
    RETURN rtrn;
   END;
----------------------------------------------------------------------------------------
   -- for the given icb_code, checks if there is budget for a year.
   -- returns the budget id if there is one
   -- or null if there is no budget
   FUNCTION is_budget_for_code( p_item_code IN WORK_ORDER_LINES.wol_icb_work_code%TYPE
                               ,p_sys_flag  IN BUDGETS.bud_sys_flag%TYPE
                               ,p_job_code  IN BUDGETS.bud_job_code%TYPE
                               ,p_road_seg  IN ROAD_SEGS.rse_he_id%TYPE
                               ,p_year      IN DATE DEFAULT SYSDATE
                              ) RETURN NUMBER
   IS
   rtrn NUMBER := NULL;
-- the order by in the cursor declaration ensures that any budgets
-- against part of the road hierarchy will be returned before any global budgets

   CURSOR c1 IS
   SELECT bud_id
   FROM BUDGETS bud
       ,FINANCIAL_YEARS fy
   WHERE (EXISTS (SELECT 1
                  FROM   road_Seg_membs
                  WHERE  p_year BETWEEN rsm_start_date
                                AND NVL(rsm_end_date,SYSDATE)
                  AND    rsm_rse_he_id_of = p_road_seg
                  CONNECT BY PRIOR rsm_rse_he_Id_of=rsm_rse_he_id_in
                  START WITH rsm_rse_he_id_in=bud.bud_rse_he_id
				  UNION
				  SELECT 1
				  FROM   road_segments
				  WHERE  rse_he_id = bud.bud_rse_he_id
				  AND    rse_he_id = p_road_seg)
              OR bud_rse_he_id IS NULL)
   AND   bud_job_code = p_job_code
   AND bud.bud_fyr_id = fy.fyr_id
   AND fy.fyr_end_date >= p_year
   AND bud_icb_item_code||bud_icb_sub_item_code||bud_icb_sub_sub_item_code = p_item_code
   ORDER BY bud_fyr_id, bud_rse_he_id;

   BEGIN
    OPEN c1;
    FETCH c1 INTO rtrn;
    IF c1%NOTFOUND THEN
      rtrn := NULL;
    END IF;
    CLOSE c1;
    RETURN rtrn;
   END;
----------------------------------------------------------------------------------------
   -- checks if the current user is allowed to go over budget or not
   FUNCTION allow_over_budget RETURN BOOLEAN IS
   dummy VARCHAR2(5);
   BEGIN
     IF Maiwo.has_role('OVER_BUDGET') = 'TRUE' THEN
        RETURN TRUE;
     ELSE
        RETURN FALSE;
     END IF;
   END;
----------------------------------------------------------------------------------------
   FUNCTION budget_reversal( p_wol_id         WORK_ORDER_LINES.wol_id%TYPE,
                             p_bud_id         BUDGETS.bud_id%TYPE,
                             p_wol_act        WORK_ORDER_LINES.wol_act_cost%TYPE,
                             p_wol_est        WORK_ORDER_LINES.wol_est_cost%TYPE
                           ) RETURN BOOLEAN  IS
   rtrn BOOLEAN := FALSE ;

   v_wol_act        WORK_ORDER_LINES.wol_act_cost%TYPE;
   v_wol_unposted_est WORK_ORDER_LINES.wol_unposted_est%TYPE := 0;
   p_bud_committed2 BUDGETS.bud_committed%TYPE;
   p_bud_actual2 BUDGETS.bud_actual%TYPE;
   p_bud_value BUDGETS.bud_value%TYPE;
   BEGIN
     -- fetch outstanding estimate amount
      OPEN wol_unposted_est(p_wol_id);
      FETCH wol_unposted_est INTO v_wol_unposted_est;
      CLOSE wol_unposted_est;

-- DO NOT DO THE FOLLOWING AS IT DOES NOT TAKE -VE VALUES INTO ACCOUNT
-- convert to negative if not already
--      IF p_wol_act > 0 THEN
--         v_wol_act := p_wol_act * -1 ;
--      ELSE
         v_wol_act := p_wol_act;
--      END IF;

      -- does a reversal actual to committed
      -- and resets the wol_unposted_est
      UPDATE BUDGETS
      SET bud_actual = NVL(bud_actual,0) + NVL(v_wol_act,0),
          bud_committed = NVL(bud_committed,0) + NVL(p_wol_est,0) - NVL(v_wol_unposted_est,0)
      WHERE bud_id = p_bud_id;

      UPDATE WORK_ORDER_LINES
      SET wol_unposted_est = NVL(p_wol_est,0)
      WHERE wol_id = p_wol_id;
      rtrn := TRUE;
/*           if hig.get_user_or_sys_opt('BUDAUDT') = 'Y' then
             select bud_value, bud_committed, bud_actual
             into p_bud_value, p_bud_committed2, p_bud_actual2
             from budgets
             where bud_id = p_bud_id;
             --
             interfaces.write_BAT( p_bud_id
                                 , 'budget_reversal'
                                 , p_wol_id
                                 , sysdate
                                 , NVL(p_wol_est,0) - NVL(v_wol_unposted_est,0)
                                 , p_bud_value
                                 , p_bud_committed2
                                 , p_bud_actual2
                                 );
             commit;
           end if;   */
      RETURN rtrn;
   END;

-------------------------------------------------------------------------------------

FUNCTION  check_budget_contract ( p_bud_id         BUDGETS.bud_id%TYPE,
                                     p_bud_committed1 BUDGETS.bud_committed%TYPE,
                                     p_bud_committed2 BUDGETS.bud_committed%TYPE,
                                     p_bud_actual     BUDGETS.bud_actual%TYPE,
                                     p_wol_id         WORK_ORDER_LINES.wol_id%TYPE DEFAULT NULL
                                   ) RETURN BOOLEAN
   IS
   rtrn               BOOLEAN := FALSE;
   v_temp             NUMBER:=0;
   v_bud_value        BUDGETS.bud_value%TYPE;
   v_bud_committed    BUDGETS.bud_committed%TYPE;
   v_bud_actual       BUDGETS.bud_actual%TYPE;
   v_wol_unposted_est WORK_ORDER_LINES.wol_unposted_est%TYPE := 0;
   v_act_to_check     BUDGETS.bud_actual%TYPE;
   BEGIN
    v_act_to_check := NVL(p_bud_actual,0);
    -- if we are checking against a work order line
    -- if so then check how much of the estimate is left unposted
    -- when posting actual costs
    IF p_wol_id IS NOT NULL THEN
      OPEN wol_unposted_est(p_wol_id);
      FETCH wol_unposted_est INTO v_wol_unposted_est;
      CLOSE wol_unposted_est;

      IF v_wol_unposted_est - NVL(p_bud_actual, 0) >= 0 THEN
         v_act_to_check := 0;
      ELSE
         v_act_to_check := NVL(p_bud_actual,0) - v_wol_unposted_est;
      END IF;
    END IF;

    OPEN current_budget( p_bud_id );
    FETCH current_budget INTO v_bud_value, v_bud_committed, v_bud_actual;
    CLOSE current_budget;

    -- only check the budget if doesn't equal -1
    IF v_bud_value != -1 THEN
       v_temp := v_bud_value - ( v_bud_committed + v_bud_actual - p_bud_committed1 + p_bud_committed2 + v_act_to_check );

       IF v_temp < 0 THEN
          rtrn := TRUE;
       END IF;
    END IF;
    RETURN rtrn;
   END;
-------------------------------------------------------------------------------------

FUNCTION reallocate_budget 
   ( p_bud_id_old     IN BUDGETS.bud_id%TYPE,
     p_bud_id_new     IN BUDGETS.bud_id%TYPE,
     p_bud_actual     IN BUDGETS.bud_actual%TYPE) RETURN BOOLEAN
IS
   lv_bud_value       BUDGETS.bud_value%TYPE;
   lv_bud_committed   BUDGETS.bud_committed%TYPE;
   lv_bud_actual      BUDGETS.bud_actual%TYPE;
   lv_temp            NUMBER := 0;
   
BEGIN
   nm_debug.debug_on;
   
   -- check if new budget will be exceeded after applying old_budget values
   OPEN current_budget(p_bud_id_new);
   FETCH current_budget INTO lv_bud_value,
                             lv_bud_committed,
                             lv_bud_actual;
   CLOSE current_budget;
      
   -- only check the budget if doesn't equal -1
   IF lv_bud_value != -1 
   THEN
   
      lv_temp := lv_bud_value - ( lv_bud_committed + lv_bud_actual + NVL(p_bud_actual,0) );

      
      IF lv_temp < 0 
      THEN
         -- budget blown
         RETURN FALSE;
      END IF;
      
   END IF;
   
   -- Within budget so apply changes
         
   -- Add values to new budget
   UPDATE BUDGETS
      SET bud_actual = NVL(bud_actual,0) + NVL(p_bud_actual,0)
    WHERE bud_id = p_bud_id_new;

   -- Subtrazct values from old budget
   UPDATE BUDGETS
      SET bud_actual = NVL(bud_actual,0) - NVL(p_bud_actual,0)
    WHERE bud_id = p_bud_id_old;

   RETURN TRUE;          
   
   nm_debug.debug_off;
    
END reallocate_budget;

----------------------------------------------------------------------------------------
END;
/
