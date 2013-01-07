CREATE OR REPLACE PACKAGE BODY DORSET.mai_priority AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_priority.pkb-arc   1.0   Jan 07 2013 09:55:10   Chris.Baugh  $
--       Module Name      : $Workfile:   mai_priority.pkb  $
--       Date into PVCS   : $Date:   Jan 07 2013 09:55:10  $
--       Date fetched Out : $Modtime:   Dec 20 2012 12:38:22  $
--       PVCS Version     : $Revision:   1.0  $
--
-----------------------------------------------------------------------------
--  Copyright (c) exor corporation ltd, 2007
-----------------------------------------------------------------------------
--
g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   1.0  $';
g_package_name  CONSTANT  varchar2(30)   := 'mai_priority';
--
TYPE admin_unit_tab IS TABLE OF nm_admin_units_all.nau_admin_unit%TYPE;
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
-----------------------------------------------------------------------------
--
FUNCTION get_admin_units(pi_ne_id nm_elements_all.ne_id%TYPE)
  RETURN admin_unit_tab IS
  --
  lt_retval     admin_unit_tab;
  --
  lv_ne_admin_unit  nm_admin_units_all.nau_admin_unit%TYPE;
  --
BEGIN
  --
  lv_ne_admin_unit := nm3net.get_ne_all_rowtype(pi_ne_id).ne_admin_unit;
  --
  SELECT hau_admin_unit
    BULK COLLECT
    INTO lt_retval
    FROM hig_admin_units hau
        ,hig_admin_groups hag
   WHERE hag_child_admin_unit = lv_ne_admin_unit
     AND hag_parent_admin_unit = hau_admin_unit
   ORDER
      BY hau_level desc
       ;
   --
   RETURN lt_retval;
   --
EXCEPTION
  WHEN others
   THEN
      RETURN admin_unit_tab();
END get_admin_units;
--
-----------------------------------------------------------------------------
--
FUNCTION get_lowest_dpr_admin_unit(pi_ne_id nm_elements_all.ne_id%TYPE)
  RETURN nm_admin_units_all.nau_admin_unit%TYPE IS
  --
  lv_retval nm_admin_units_all.nau_admin_unit%TYPE;
  lv_count PLS_INTEGER;
  --
  lt_admin_unit admin_unit_tab;
  --
BEGIN
  --
  lt_admin_unit := get_admin_units(pi_ne_id);
  --
  FOR i IN 1..lt_admin_unit.COUNT LOOP
    --
    SELECT count(*)
      INTO lv_count
      FROM defect_priorities
     WHERE dpr_admin_unit = lt_admin_unit(i)
         ;
    --
    IF lv_count > 0
     THEN
        lv_retval := lt_admin_unit(i);
        EXIT;
    END IF;
    --
  END LOOP;
  --
  IF lv_retval = NULL
   THEN
      raise_application_error(-20001,'No Defect Priority found.');
  END IF;
  --
  RETURN lv_retval;
  --
END get_lowest_dpr_admin_unit;
--
-----------------------------------------------------------------------------
--
FUNCTION get_lowest_adsp_admin_unit(pi_ne_id nm_elements_all.ne_id%TYPE)
  RETURN nm_admin_units_all.nau_admin_unit%TYPE IS
  --
  lv_retval nm_admin_units_all.nau_admin_unit%TYPE;
  lv_count PLS_INTEGER;
  --
  lt_admin_unit admin_unit_tab;
  --
BEGIN
  --
  lt_admin_unit := get_admin_units(pi_ne_id);
  --
  FOR i IN 1..lt_admin_unit.COUNT LOOP
    --
    SELECT count(*)
      INTO lv_count
      FROM auto_defect_selection_priority
     WHERE adsp_admin_unit = lt_admin_unit(i)
         ;
    --
    IF lv_count > 0
     THEN
        lv_retval := lt_admin_unit(i);
        EXIT;
    END IF;
    --
  END LOOP;
  --
  IF lv_retval = NULL
   THEN
      raise_application_error(-20002,'No Auto Defect Selection Priority found.');
  END IF;
  --
  RETURN lv_retval;
  --
END get_lowest_adsp_admin_unit;
--
-----------------------------------------------------------------------------
--
FUNCTION valid_admin_unit(pi_unit_code hig_admin_units.hau_unit_code%TYPE) 
  RETURN hig_admin_units.hau_admin_unit%TYPE IS

  lv_return   hig_admin_units.hau_admin_unit%TYPE := NULL;

  cursor c_admin_unit is
    select hau.hau_admin_unit
	from   hig_admin_units hau, 
		   hig_admin_groups hag, 
		   hig_users hu
	where TO_DATE (SYS_CONTEXT ('NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY') BETWEEN 
                               NVL (hau_start_date,TO_DATE ( SYS_CONTEXT ( 'NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY'))
                        AND NVL (hau_end_date,TO_DATE (SYS_CONTEXT ('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY'))
	  and  hu.hus_username = Sys_Context('NM3_SECURITY_CTX','USERNAME')
	  and  hag.hag_parent_admin_unit = hu.hus_admin_unit
	  and  hag.hag_child_admin_unit = hau.hau_admin_unit
	  and  hau.hau_unit_code = pi_unit_code;  
BEGIN
   open c_admin_unit;
   fetch c_admin_unit into lv_return;
   close c_admin_unit;
   
   RETURN lv_return;

END;
--
-----------------------------------------------------------------------------
--
PROCEDURE pop_priority_tab(pi_admin_unit          hig_admin_units.hau_admin_unit%TYPE
                                          ,pi_cpr_id                 doc_def_priorities.ddp_doc_compl_cpr_id%TYPE
                                          ,pi_acty_area_code   doc_def_priorities.ddp_dpr_acty_area_code%TYPE) IS
                                         
 CURSOR c_admin_unit (p_admin_unit   hig_admin_units.hau_admin_unit%TYPE) IS
 SELECT hag.hag_parent_admin_unit
   FROM hig_admin_units hau, hig_admin_groups hag
  WHERE TO_DATE (SYS_CONTEXT ('NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY') BETWEEN 
                 NVL (hau_start_date, TO_DATE (SYS_CONTEXT ( 'NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY'))
             AND NVL (hau_end_date,  TO_DATE (SYS_CONTEXT ( 'NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY'))
    AND hag.hag_child_admin_unit = p_admin_unit
    AND hag.hag_parent_admin_unit = hau.hau_admin_unit
    AND hag.hag_direct_link = 'Y';

  l_curr_admin_unit   hig_admin_units.hau_admin_unit%TYPE;
  l_row_found           boolean;

--
  FUNCTION priority_exists (p_properties_row   doc_def_priorities%ROWTYPE) 
     RETURN BOOLEAN IS
     
     lv_return BOOLEAN := FALSE;
     
  BEGIN
     if g_doc_def_priority_tab.COUNT >0
       then
          FOR i IN 1 .. g_doc_def_priority_tab.COUNT LOOP
              if g_doc_def_priority_tab(i).ddp_dpr_priority = p_properties_row.ddp_dpr_priority and
                 g_doc_def_priority_tab(i).ddp_dpr_action_cat = p_properties_row.ddp_dpr_action_cat
                 then
                    lv_return := TRUE;
                    EXIT;
              end if;
          END LOOP;
     end if;
     
     RETURN lv_return;
  END;
--

  PROCEDURE add_priority(p_admin_unit   hig_admin_units.hau_admin_unit%TYPE
                                      ,pi_cpr_id                 doc_def_priorities.ddp_doc_compl_cpr_id%TYPE
                                      ,pi_acty_area_code   doc_def_priorities.ddp_dpr_acty_area_code%TYPE) IS
  
    CURSOR c_priorities IS
    SELECT * 
      FROM doc_def_priorities 
     WHERE ddp_dpr_admin_unit = p_admin_unit
         AND ddp_doc_compl_cpr_id = pi_cpr_id
         AND ddp_dpr_acty_area_code = pi_acty_area_code;
     
   BEGIN
      FOR l_rec IN c_priorities LOOP
   
          IF NOT priority_exists(l_rec)
            THEN
               g_doc_def_priority_tab(g_doc_def_priority_tab.COUNT+1) := l_rec;
          END IF;
      END LOOP;
   END;

BEGIN
  g_doc_def_priority_tab.DELETE;
  l_curr_admin_unit := pi_admin_unit;
  
  LOOP   
      add_priority(l_curr_admin_unit
                       ,pi_cpr_id                 
                       ,pi_acty_area_code);
      
      open c_admin_unit(l_curr_admin_unit);
      fetch c_admin_unit into l_curr_admin_unit;
      l_row_found := c_admin_unit%FOUND;
      close c_admin_unit;
      
      if not l_row_found
      then
         exit;
      end if;
      
  END LOOP;
END;
--
--
-----------------------------------------------------------------------------
--
PROCEDURE get_doc_def_priorities(pi_admin_unit          IN  hig_admin_units.hau_admin_unit%TYPE
                                                   ,pi_cpr_id                 IN  doc_def_priorities.ddp_doc_compl_cpr_id%TYPE
                                                   ,pi_acty_area_code   IN  doc_def_priorities.ddp_dpr_acty_area_code%TYPE
                                                   ,po_priorities_tab      IN OUT doc_def_priority_tab) IS
 
BEGIN
   pop_priority_tab(pi_admin_unit 
                           ,pi_cpr_id
                           ,pi_acty_area_code);
                           
   po_priorities_tab := g_doc_def_priority_tab;
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_dpr_interval(pi_admin_unit          IN  defect_priorities.dpr_admin_unit%TYPE
                                        ,pi_acty_area_code   IN  defect_priorities.dpr_atv_acty_area_code%TYPE
                                        ,pi_priority                IN  defect_priorities.dpr_priority%TYPE
                                        ,pi_action_cat           IN  defect_priorities.dpr_action_cat%TYPE)
  RETURN defect_priorities.dpr_int_code%TYPE IS

  CURSOR c_int_code IS
  SELECT dpr_int_code
    FROM defect_priorities dpr, 
              hig_admin_units hau, 
              hig_admin_groups hag
  WHERE TO_DATE (SYS_CONTEXT ('NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY') BETWEEN 
                             NVL (hau_start_date, TO_DATE (SYS_CONTEXT ( 'NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY'))
                      AND NVL (hau_end_date,  TO_DATE (SYS_CONTEXT ( 'NM3CORE', 'EFFECTIVE_DATE'), 'DD-MON-YYYY'))
    AND hag.hag_child_admin_unit    =  pi_admin_unit
    AND hag.hag_parent_admin_unit = hau.hau_admin_unit
    AND   dpr_atv_acty_area_code    = pi_acty_area_code
    AND   dpr_priority                      =  pi_priority
    AND   dpr_admin_unit                = hag.hag_parent_admin_unit
     AND  dpr_action_cat                 = pi_action_cat
  ORDER BY hau_level desc;
--   
  lv_return   defect_priorities.dpr_int_code%TYPE := NULL;
--
BEGIN
  open c_int_code;
  fetch c_int_code INTO lv_return;
  close c_int_code;
  
  RETURN lv_return;
END;
--
-----------------------------------------------------------------------------
--

END mai_priority;
/
