CREATE OR REPLACE TRIGGER pre_insert_defects
BEFORE INSERT
ON DEFECTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/trg/pre_insert_defects.trg-arc   3.2   Jun 28 2018 04:36:42   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   pre_insert_defects.trg  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:36:42  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:35:46  $
--       Version          : $Revision:   3.2  $
--
--
-----------------------------------------------------------------------------
--    Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

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
