CREATE OR REPLACE PACKAGE BODY pedif
AS
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/pck/pedif.pkb-arc   3.1   Sep 29 2010 15:16:18   Mike.Huitson  $
--       Module Name      : $Workfile:   pedif.pkb  $
--       Date into PVCS   : $Date:   Sep 29 2010 15:16:18  $
--       Date fetched Out : $Modtime:   Sep 27 2010 12:11:14  $
--       Version          : $Revision:   3.1  $
--       Based on SCCS version :
-------------------------------------------------------------------------
-- Copyright (c) exor corporation ltd, 2010
-------------------------------------------------------------------------
--all global package variables here
-----------
--constants
-----------
--g_body_sccsid is the SCCS ID for the package body
g_body_sccsid   CONSTANT VARCHAR2(2000) := '$Revision:   3.1  $';
g_package_name  CONSTANT VARCHAR2(30) := 'pedif';
--
-- sscanlon fix 709407 12SEP2007
-- Please search for 'sscanlon fix 709407 12SEP2007' throughout this
-- package to see the code changes releated to this fix...
-- The user may wish to specify a default output filename when a PED
-- file is created and a new USER OPTION named PEDFILE holds this
-- default filename. A report parameter named PEDFILE will be initially
-- populated from the user option of the same name.  It can be overwritten
-- by the user, but you need to set the parameter to visible first.
-- The list of inspectors should also be restricted to only show the
-- inspectors within the current users admin unit.  The data in parameter
-- ANSWER2 states if the user wishes to restrict by admin unit or not.
-- Again the ANSWER2 parameter is not visible, and could be changed at
-- run time should you wish, but the parameter will need to be set to
-- visible.
--
debug         BOOLEAN := FALSE;
v_module      VARCHAR2(7) := 'MAI3863';
--
file_handle   utl_file.file_type;                    -- File handle
--
fdiscipline   VARCHAR2(1);                            -- Discipline
ffile         VARCHAR2(80);                      -- Input file name
-- sscanlon fix 709407 12SEP2007
-- Added new variable FAunit to hold the Y/N data from parameter ANSWER 2
-- See top of package body code for problem description
faunit        VARCHAR2(1) := 'N';         -- Admin unit restriction
-- end of sscanlon fix 709407 12SEP2007
fdest         VARCHAR2(80);                 -- Input directory name
ftype         VARCHAR2(1);                             -- File type
fsuffix       VARCHAR2(3);                   -- Entered file suffix
fseq          NUMBER;                            -- Sequence number
fgtype        road_groups.rse_gty_group_type%TYPE; -- Road Group Type
fgroup        road_segs.rse_he_id%TYPE;               -- Road Group
factivity     VARCHAR2(80);                        -- Activity list
factgroup     activity_groups.acg_group_code%TYPE; -- Activity Group
fasset        VARCHAR2(80) := NULL;                   -- Asset type
fheir         VARCHAR2(1);       -- Hierarchical inventory required
ffileext      VARCHAR2(3);                 -- Output file extension
sysflags      VARCHAR(10) := '';     -- Network indicator variables
fxsp          VARCHAR(80) := NULL;                 -- Inventory XSP
--
fread         CHAR := nm3file.c_read_mode;         -- Read Character
fwrite        CHAR := nm3file.c_write_mode;         -- Write character
f_max_linesize BINARY_INTEGER := nm3type.c_max_varchar2_size;
v_filename    VARCHAR2(80);                    -- Compound filename
i             INTEGER;                                   -- Counter
startline     VARCHAR2(1000) := '1,EDIF , Version: '||g_body_sccsid|| ', Created By: '||USER
                                 ||', Date: '||TO_CHAR(SYSDATE,'DDMMYYYY');
--
TYPE def_attr IS TABLE OF VARCHAR2(1000) INDEX BY BINARY_INTEGER;
def_attr_rec  def_attr;
--
l_count_def_attr  BINARY_INTEGER := 0;
--
-----------------------------------------------------------------------------
--
FUNCTION get_version
  RETURN VARCHAR2 IS
BEGIN
  RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version
  RETURN VARCHAR2 IS
BEGIN
  RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--
PROCEDURE get_params(job_id IN NUMBER)
  IS
  --
  CURSOR all_param_values(cp_job_id    IN NUMBER
                         ,cp_parameter IN VARCHAR)
      IS
  SELECT grp_value item_value
    FROM gri_run_parameters
   WHERE grp_param = cp_parameter
     AND grp_job_id = cp_job_id
   ORDER BY grp_seq
       ;
BEGIN
  --
  -- The sequence defines the output filename. The sequence used should be that
  -- used by all modules which use the GRI. The filename extension should also
  -- be obtained from the GRI_MODULES.GRI_FILE_TYPE column.
  --
  fseq        := job_id;
  fdiscipline := higgrirp.get_parameter_value(job_id,'DISCIPLINE');
  fgtype      := higgrirp.get_parameter_value(job_id,'ROAD_TYPE');
  fgroup      := TO_NUMBER(higgrirp.get_parameter_value(job_id,'ROAD_ID'));
  fasset      := higgrirp.get_parameter_value(job_id,'INVENTORY_ITEM');
  factgroup   := higgrirp.get_parameter_value(job_id,'ACTIVITY_GROUP');
  fdest       := LOWER(higgrirp.get_parameter_value(job_id,'TEXT'));
  fheir       := NVL(higgrirp.get_parameter_value(job_id,'ANSWER'),'Y');
  fxsp        := higgrirp.get_parameter_value(job_id,'XSP');
  ffile       := higgrirp.get_parameter_value(job_id,'PEDFILE');
  faunit      := higgrirp.get_parameter_value(job_id,'ANSWER2');
  --
  -- Factivity is used for display when in debug mode only
  --
  IF debug
   THEN
      --
      -- The parameters for this module may include upto 6 activity codes.
      -- For this reason we need to ensure that we obtain any number of activity
      -- parameters.
      --
      FOR each_activity IN all_param_values(job_id,'ACTIVITY') LOOP
        IF each_activity.item_value IS NOT NULL
         THEN
            factivity := factivity||''''||each_activity.item_value||''''||',';
        END IF;
      END LOOP;
      --
      factivity := SUBSTR(factivity,1,LENGTH(factivity)-1);
      --
      FOR each_inv_item IN all_param_values(job_id,'INVENTORY_ITEM') LOOP
        IF each_inv_item.item_value IS NOT NULL
         THEN
            fasset := fasset||''''||each_inv_item.item_value||''''||',';
        END IF;
      END LOOP;
      --
      fasset := SUBSTR(fasset,1,LENGTH(fasset)-1);
      --
      FOR each_inv_item IN all_param_values(job_id,'XSP') LOOP
        IF each_inv_item.item_value IS NOT NULL
         THEN
            fxsp := fxsp||''''||each_inv_item.item_value||''''||',';
        END IF;
      END LOOP;
      --
      fxsp := SUBSTR(fxsp,1,LENGTH(fxsp)-1);
      --
      dbms_output.put_line('');
      dbms_output.put_line('Parameter Discipline    : ' || fdiscipline);
      dbms_output.put_line('Parameter Output Seq.   : ' || TO_CHAR(fseq));
      dbms_output.put_line('Parameter Destination   : ' || fdest);
      dbms_output.put_line('Parameter Group Type    : ' || fgtype);
      dbms_output.put_line('Parameter Group         : ' || TO_CHAR(fgroup));
      dbms_output.put_line('Parameter Activities    : ' || factivity);
      dbms_output.put_line('Parameter Asset         : ' || fasset);
      dbms_output.put_line('Parameter Act Group     : ' || factgroup);
      dbms_output.put_line('Parameter Use Hierarchy : ' || fheir);
      dbms_output.put_line('Parameter Inventory XSP : ' || fxsp);
      dbms_output.put_line('Parameter Output Dir    : ' || fdest);
      dbms_output.put_line('Parameter Output File   : ' || ffile);
      dbms_output.put_line('Parameter Restrict AU   : ' || faunit);
      dbms_output.put_line('');
  END IF;
  --
END;
--
-----------------------------------------------------------------------------
-- Obtain the next file sequence if one has not been provided
--
FUNCTION getfileseq
  RETURN INTEGER IS
  --
  v_seq  NUMBER;
  --
  CURSOR nextfileseq
      IS
  SELECT file_id_seq.NEXTVAL
    FROM DUAL
       ;
  --
BEGIN
  --
  OPEN  nextfileseq;
  FETCH nextfileseq
   INTO v_seq;
  CLOSE nextfileseq;
  --
  RETURN v_seq;
  --
EXCEPTION
  WHEN others
   THEN
      dbms_output.put_line('Error: Sequence does not exist - {GetFileSeq}');
      RETURN 0;
END;
--
-----------------------------------------------------------------------------
-- Procedure Create File
--
PROCEDURE create_file(loc_in  IN VARCHAR2
                     ,file_in IN VARCHAR2
                     ,line_in IN VARCHAR2)
  IS
BEGIN
  -- Open the specified file for writing
  IF debug
   THEN
      dbms_output.put_line('{ Function - Create File }');
      dbms_output.put_line('Location : ' || loc_in);
      dbms_output.put_line('File     : ' || file_in);
      dbms_output.put_line('Line     : ' || line_in);
  END IF;
  --
  file_handle := nm3file.fopen(location     => loc_in
                              ,filename     => file_in
                              ,open_mode    => fwrite
                              ,max_linesize => f_max_linesize);
  --
  IF line_in IS NOT NULL
   THEN
      utl_file.put_line(file_handle
                       ,line_in);
  ELSE
      utl_file.put_line(file_handle
                       ,'Info: End-Of-File here');
  END IF;
  --
EXCEPTION
  WHEN others
   THEN
      dbms_output.put_line('Error: An error occured - {Create_File}');
      RAISE;
END;
--
-----------------------------------------------------------------------------
-- Check for the existance of a specified file
--
FUNCTION fileexists(loc_in  IN VARCHAR2
                   ,file_in IN VARCHAR2)
  RETURN BOOLEAN IS
BEGIN
  -- Open the file
  IF debug
   THEN
      dbms_output.put_line('Path   : ' || loc_in);
      dbms_output.put_line('File   : ' || file_in);
  END IF;
  --
  IF NOT is_open(file_handle)
   THEN
      IF NOT close_file(file_handle)
       THEN
          dbms_output.put_line('Info: Unable to close open file.');
      END IF;
      --
      file_handle := utl_file.fopen(loc_in
                                   ,file_in
                                   ,fread);
  END IF;
  --
  IF debug
   THEN
      dbms_output.put_line('Info: Handle Obtained - {FileExists}');
  END IF;
  --
  -- Return the result of a check with IS_OPEN
  utl_file.fclose(file_handle);
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END;
--
-----------------------------------------------------------------------------
-- Check to see wether a specified file is open
--
FUNCTION is_open(file_in IN utl_file.file_type)
  RETURN BOOLEAN IS
BEGIN
  RETURN utl_file.is_open(file_in);
END;
--
-----------------------------------------------------------------------------
-- Closes an open file.
--
FUNCTION close_file(file_in IN utl_file.file_type)
  RETURN BOOLEAN IS
BEGIN
  utl_file.fclose(file_handle);
  IF is_open(file_handle)
   THEN
      RETURN FALSE;
  ELSE
      RETURN TRUE;
  END IF;
END;
--
-----------------------------------------------------------------------------
--
FUNCTION inspection_order(parent_id IN road_segs.rse_he_id%TYPE
                         ,child_id  IN road_segs.rse_he_id%TYPE)
  RETURN NUMBER IS
  --
  CURSOR get_rsm
      IS
  SELECT rsm_seq_no
    FROM road_seg_membs
   WHERE rsm_rse_he_id_in = parent_id
     AND rsm_rse_he_id_of = child_id
     AND rsm_end_date IS NULL
       ;
  --
  p_rsm  NUMBER;
  --
BEGIN
  OPEN  get_rsm;
  FETCH get_rsm
   INTO p_rsm;
  IF get_rsm%NOTFOUND
   THEN
      p_rsm := NULL;
      CLOSE get_rsm;
  ELSE
      CLOSE get_rsm;
  END IF;
  --
  RETURN p_rsm;
  --
END;
--
-----------------------------------------------------------------------------
-- Write an output line to a file
--
FUNCTION writeln(file_handle IN utl_file.file_type
                ,line_in     IN VARCHAR2)
  RETURN BOOLEAN IS
BEGIN
  --
  utl_file.put_line(file_handle
                   ,line_in);
  utl_file.fflush(file_handle);
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN FALSE;
END;
--
-----------------------------------------------------------------------------
-- This procedure should provide the user with the facility to download
-- data defined by the PEDIF  file format.
--
FUNCTION processpedif(job_id IN NUMBER)
  RETURN BOOLEAN IS
  --
  fn           VARCHAR2(20) := '{ ProcessPedif }';
  rse_pad      INTEGER := 8;                   -- Padded length for section id
  iit_id_pad   INTEGER := 8;                  -- Padded length for Inv Item Id
  chain_pad    INTEGER := 6;              -- Padded length for Chainage values
  rec_count    INTEGER := 0;                       -- number of records loaded
  user_init    hig_users.hus_initials%TYPE := NULL; -- initials of user executing procedure
  --
  -- table type to store buffer output from cursors before outputting contents to a file
  TYPE t1 IS TABLE OF nm3type.max_varchar2 INDEX BY BINARY_INTEGER;
  cursor_recs  t1;
  /*
  ||Cursor definitions
  */
  -- Obtain a distinct list of the road section network indicators
  CURSOR c1(he_id IN road_segs.rse_he_id%TYPE)
      IS
  SELECT rse_sys_flag
    FROM road_segs
   WHERE rse_he_id = he_id
       ;
  -- Activity Type Descripiton
  CURSOR c2
      IS
  SELECT '2,*,'||atv.atv_maint_insp_flag||','||atv.atv_acty_area_code||','|| REPLACE(atv.atv_descr,',',':') rec
    FROM activities atv
   WHERE atv.atv_end_date IS NULL
     AND atv.atv_acty_area_code IN(SELECT DECODE(a.atv_maint_insp_flag,'S',atv.atv_acty_area_code
                                                                          ,DECODE(grp.grp_value,NULL,atv.atv_acty_area_code
                                                                                                    ,grp.grp_value))
                                     FROM activities a
                                         ,gri_run_parameters grp
                                    WHERE a.atv_acty_area_code(+) = grp.grp_value
                                      AND grp.grp_param = 'ACTIVITY'
                                      AND grp.grp_job_id = job_id)
     AND ((NVL(factgroup, 'ALL') = 'ALL')
          OR atv.atv_acty_area_code IN(SELECT agm_acty_code
                                         FROM activity_groups
                                             ,act_group_membs
                                        WHERE acg_group_code = factgroup
                                          AND agm_group_code = acg_group_code))
   ORDER BY 1
       ;
  -- Defect Type Description
  CURSOR c3
      IS
  SELECT DISTINCT '3,*,'||dty_defect_code||','||REPLACE(dty_descr1,',',':')||REPLACE(dty_descr2,',',':') rec
    FROM def_types
   WHERE dty_end_date IS NULL
   ORDER BY 1
       ;
  -- Treatment Type Description
  CURSOR c4
      IS
  SELECT '4,*,'||RPAD(tre_treat_code,4)||','||REPLACE(tre_descr,',',':') rec
    FROM treatments
   WHERE tre_end_date IS NULL
   ORDER BY 1
       ;
  --
  CURSOR c6
      IS
  SELECT '6,*,'||dty_atv_acty_area_code||','||dty_defect_code||','     rec
        ,dty_hh_attribute_1||','||REPLACE(dty_hh_attri_text_1,',',':') attr_1
        ,dty_hh_attribute_2||','||REPLACE(dty_hh_attri_text_2,',',':') attr_2
        ,dty_hh_attribute_3||','||REPLACE(dty_hh_attri_text_3,',',':') attr_3
        ,dty_hh_attribute_4||','||REPLACE(dty_hh_attri_text_4,',',':') attr_4
    FROM def_types
   WHERE TRUNC(SYSDATE) BETWEEN TRUNC(NVL(dty_start_date, SYSDATE))
                            AND TRUNC(NVL(dty_end_date, SYSDATE))
     AND dty_atv_acty_area_code IN(SELECT DECODE(a.atv_maint_insp_flag,'S',dty_atv_acty_area_code
                                                                          ,DECODE(grp.grp_value,NULL,dty_atv_acty_area_code
                                                                                                    ,grp.grp_value))
                                     FROM activities a
                                         ,gri_run_parameters grp
                                    WHERE a.atv_acty_area_code(+) = grp.grp_value
                                      AND grp.grp_param = 'ACTIVITY'
                                      AND grp.grp_job_id = job_id)
     AND ((NVL(factgroup, 'ALL') = 'ALL')
          OR  dty_atv_acty_area_code IN(SELECT agm_acty_code
                                          FROM activity_groups
                                              ,act_group_membs
                                         WHERE acg_group_code = factgroup
                                           AND agm_group_code = acg_group_code))
   ORDER BY 1
       ;
  --
  CURSOR c7
      IS
  SELECT DISTINCT '7,*,'||afr_atv_acty_area_code||','||afr_ity_inv_code rec
    FROM act_freqs
        ,inv_item_types
   WHERE afr_atv_acty_area_code IN(SELECT DECODE(a.atv_maint_insp_flag,'S',afr_atv_acty_area_code
                                                                          ,DECODE(grp.grp_value,NULL,afr_atv_acty_area_code
                                                                                                    ,grp.grp_value))
                                     FROM activities a
                                         ,gri_run_parameters grp
                                    WHERE a.atv_acty_area_code(+) = grp.grp_value
                                      AND grp.grp_param = 'ACTIVITY'
                                      AND grp.grp_job_id = job_id)
     AND ((NVL(factgroup, 'ALL') = 'ALL')
          OR  afr_atv_acty_area_code IN(SELECT agm_acty_code
                                          FROM activity_groups
                                              ,act_group_membs
                                         WHERE acg_group_code = factgroup
                                           AND agm_group_code = acg_group_code))
     AND ity_inv_code = afr_ity_inv_code
     AND ity_road_characteristic = 'I'
     AND ity_elec_drain_carr = NVL(fdiscipline, ity_elec_drain_carr)
     AND (fasset IS NULL
          OR  ity_inv_code IN(SELECT grp_value
                                FROM gri_run_parameters
                               WHERE grp_param = 'INVENTORY_ITEM'
                                 AND grp_job_id = job_id))
     AND INSTR(sysflags,ity_sys_flag) > 0
     AND ity_end_date IS NULL
   ORDER BY 1
       ;
  --
  CURSOR c8
      IS
  SELECT '8,*,'|| dtr_dty_acty_area_code||','||dtr_dty_defect_code||','||RPAD(dtr_tre_treat_code,4) rec
    FROM treatments
        ,def_treats
   WHERE dtr_tre_treat_code = tre_treat_code
     AND tre_end_date IS NULL
     AND dtr_dty_acty_area_code IN(SELECT DECODE(a.atv_maint_insp_flag,'S',dtr_dty_acty_area_code
                                                                          ,DECODE(grp.grp_value,NULL,dtr_dty_acty_area_code
                                                                                                    ,grp.grp_value))
                                     FROM activities a
                                         ,gri_run_parameters grp
                                    WHERE a.atv_acty_area_code(+) = grp.grp_value
                                      AND grp.grp_param = 'ACTIVITY'
                                      AND grp.grp_job_id = job_id)
     AND ((NVL(factgroup, 'ALL') = 'ALL')
          OR  dtr_dty_acty_area_code IN(SELECT agm_acty_code
                                          FROM activity_groups
                                              ,act_group_membs
                                         WHERE acg_group_code = factgroup
                                           AND agm_group_code = acg_group_code))
   ORDER BY 1
       ;
  --
  CURSOR c9
      IS
  SELECT '9,*,'||hco_code||','||REPLACE(hco_meaning,',',':') rec
    FROM hig_codes
     WHERE hco_domain = 'DEFECT_RESPONSE_CAT'
       AND hco_end_date IS NULL;
  CURSOR c11
  IS
      SELECT    '11,'
             || ity_sys_flag
             || ','
             || ity_inv_code
             || ','
             || REPLACE(ity_descr
                       ,','
                       ,':')
             || ','
             || ity_pnt_or_cont
             || ','
             || ity_x_sect_allow_flag
             || ','
             || NVL(ity_contiguous, 'N')
               rec
        FROM inv_item_types
       WHERE ity_road_characteristic = 'I'
         AND ity_elec_drain_carr = NVL(fdiscipline, ity_elec_drain_carr)
         AND (fasset IS NULL
           OR  ity_inv_code IN (SELECT grp_value
                                  FROM gri_run_parameters
                                 WHERE grp_param = 'INVENTORY_ITEM'
                                   AND grp_job_id = job_id))
         AND ity_end_date IS NULL
         AND INSTR(sysflags
                  ,ity_sys_flag) > 0
    ORDER BY 1;
  CURSOR c12
  IS
      SELECT    '12,'
             || i.ita_ity_sys_flag
             || ','
             || i.ita_iit_inv_code
             || ','
             || i.ita_disp_seq_no
             || ','
             || REPLACE(i.ita_scrn_text
                       ,','
                       ,':')
             || ','
             || DECODE(i.ita_format,  'NUMBER', 'I',  'VARCHAR2', 'S',  'S')
             || ','
             || i.ita_fld_length
             || ','
             || TO_CHAR(i.ita_dec_places)
             || ','
             || i.ita_min
             || ','
             || i.ita_max
             || ','
             || i.ita_validate_yn
             || ','
             || i.ita_manditory_yn
               rec
        FROM inv_type_attribs i
            ,nm_inv_type_attribs n
            ,inv_type_translations t
       WHERE n.ita_inspectable = 'Y'
         AND n.ita_attrib_name = i.ita_attrib_name
         AND n.ita_inv_type = i.ita_iit_inv_code
         AND i.ita_iit_inv_code = t.ity_inv_code
         AND t.ity_sys_flag = ita_ity_sys_flag
         AND INSTR(sysflags
                  ,ita_ity_sys_flag) > 0
         AND i.ita_end_date IS NULL
         AND (fasset IS NULL
           OR  ita_iit_inv_code IN (SELECT grp_value
                                      FROM gri_run_parameters
                                     WHERE grp_param = 'INVENTORY_ITEM'
                                       AND grp_job_id = job_id))
    ORDER BY 1;
  CURSOR c13
  IS
      SELECT DISTINCT    '13,'
                      || iad_ita_ity_sys_flag
                      || ','
                      || iad_ita_inv_code
                      || ','
                      || ita_disp_seq_no
                      || ','
                      || iad_value
                      || ','
                      || REPLACE(iad_meaning
                                ,','
                                ,':')
                        rec
        FROM inv_attri_domains
            ,inv_type_attribs
       WHERE iad_ita_attrib_name = ita_attrib_name
         AND iad_ita_inv_code = ita_iit_inv_code
         AND (fasset IS NULL
           OR  iad_ita_inv_code IN (SELECT grp_value
                                      FROM gri_run_parameters
                                     WHERE grp_param = 'INVENTORY_ITEM'
                                       AND grp_job_id = job_id))
         AND iad_end_date IS NULL
         AND INSTR(sysflags
                  ,iad_ita_ity_sys_flag) > 0
    ORDER BY 1;
  /*
  CURSOR c14 IS
     SELECT DISTINCT '14,'||xsr_ity_sys_flag   ||','||
    xsr_scl_class      ||','||
    xsr_x_sect_value   ||','||
    '' rec
     FROM   xsp_restraints
     WHERE (xsr_ity_sys_flag,xsr_scl_class) IN
   ( SELECT DISTINCT rse_sys_flag
    ,rse_scl_sect_class
     FROM  road_segs
     WHERE rse_type='S'
     AND   rse_he_id IN ( SELECT rsm_rse_he_id_of
      FROM   road_seg_membs
      WHERE  rsm_end_date IS NULL
      CONNECT BY PRIOR rsm_rse_he_id_of = rsm_rse_he_id_in
      START WITH rsm_rse_he_id_in       = FGroup))
     ORDER BY 1;
  */
  CURSOR c15
  IS
      SELECT DISTINCT    '15,'
                      || xsr_nw_type
                      || ','
                      || xsr_scl_class
                      || ','
                      || xsr_ity_inv_code
                      || ','
                      || xsr_x_sect_value
                      || ','
                      || REPLACE(xsr_descr
                                ,','
                                ,':')
                        rec
        FROM xsp_restraints
       WHERE (xsr_nw_type, xsr_scl_class) IN
               (SELECT DISTINCT rse_sys_flag
                               ,rse_scl_sect_class
                  FROM road_segs
                 WHERE rse_type = 'S'
                   AND rse_he_id IN
                         (    SELECT rsm_rse_he_id_of
                                FROM road_seg_membs
                               WHERE rsm_end_date IS NULL
                          CONNECT BY PRIOR rsm_rse_he_id_of = rsm_rse_he_id_in
                          START WITH rsm_rse_he_id_in = fgroup))
    ORDER BY 1;
  CURSOR c21
  IS
      SELECT    '21,*,'
             || oun_unit_code
             || ','
             || REPLACE(oun_name
                       ,','
                       ,':')
               rec
        FROM org_units
       WHERE oun_org_unit_type = 'NO'
         AND oun_end_date IS NULL
    ORDER BY 1;
  -- SM 713267 06102008
  -- Cursor 21 and 22 were the original cursors which would return the list of organisations
  -- to the user.  This cursor is fine if the parameter ANSWER2 = 'N'.
  -- If ANSWER2 = 'Y' then an additional restriction needed to be added to this
  -- cursor.  For ease, the cursors were copied and recreated as cursors c21a and c22a, and
  -- the restriction added.
  -- Organisation Details - admin unit restricted
  CURSOR c21a
  IS
      SELECT    '21,*,'
             || oun_unit_code
             || ','
             || REPLACE(oun_name
                       ,','
                       ,':')
               rec
        FROM org_units
       WHERE oun_org_unit_type = 'NO'
         AND oun_end_date IS NULL
         AND oun_admin_org_id IN
               (    SELECT hag_child_admin_unit
                      FROM hig_admin_groups
                     WHERE hag_direct_link = 'Y'
                START WITH hag_parent_admin_unit = (SELECT hus_admin_unit
                                                      FROM hig_users
                                                     WHERE hus_username = USER)
                CONNECT BY PRIOR hag_child_admin_unit = hag_parent_admin_unit
                       AND hag_direct_link = 'Y'
                UNION
                SELECT hus_admin_unit
                  FROM hig_users
                 WHERE hus_username = USER)
    ORDER BY 1;
  CURSOR c22
  IS
      SELECT    '22,*,'
             || oun_unit_code
             || ','
             || REPLACE(oun_name
                       ,','
                       ,':')
               rec
        FROM org_units
       WHERE oun_org_unit_type = 'RE'
         AND oun_end_date IS NULL
    ORDER BY 1;
  CURSOR c22a
  IS
      SELECT    '22,*,'
             || oun_unit_code
             || ','
             || REPLACE(oun_name
                       ,','
                       ,':')
               rec
        FROM org_units
       WHERE oun_org_unit_type = 'RE'
         AND oun_end_date IS NULL
         AND oun_admin_org_id IN
               (    SELECT hag_child_admin_unit
                      FROM hig_admin_groups
                     WHERE hag_direct_link = 'Y'
                START WITH hag_parent_admin_unit = (SELECT hus_admin_unit
                                                      FROM hig_users
                                                     WHERE hus_username = USER)
                CONNECT BY PRIOR hag_child_admin_unit = hag_parent_admin_unit
                       AND hag_direct_link = 'Y'
                UNION
                SELECT hus_admin_unit
                  FROM hig_users
                 WHERE hus_username = USER)
    ORDER BY 1;
  CURSOR c24
  IS
      SELECT DISTINCT    '24,*,'
                      || d.dpr_priority
                      || ','
                      || REPLACE(hig.hco_meaning
                                ,','
                                ,':')
                        rec
        FROM defect_priorities d
            ,hig_codes hig
            ,act_freqs a
            ,inv_item_types i
       WHERE hig.hco_domain = 'DEFECT_PRIORITIES'
         AND hco_end_date IS NULL
         AND hig.hco_code = d.dpr_priority
         AND d.dpr_atv_acty_area_code = a.afr_atv_acty_area_code
         AND DECODE(a.afr_ity_inv_code
                   ,NULL, i.ity_inv_code
                   ,'%%', i.ity_inv_code
                   ,a.afr_ity_inv_code) = i.ity_inv_code
         AND INSTR(sysflags
                  ,i.ity_sys_flag) > 0
         AND i.ity_road_characteristic = 'I'
         AND i.ity_elec_drain_carr = NVL(fdiscipline, i.ity_elec_drain_carr)
    ORDER BY 1;
  CURSOR c25
  IS
      SELECT    '25,*,'
             || hco_code
             || ','
             || REPLACE(hco_meaning
                       ,','
                       ,':')
               rec
        FROM hig_codes
       WHERE hco_domain = 'INITIATION_TYPE'
         AND hco_end_date IS NULL
    ORDER BY 1;
  CURSOR c26
  IS
      SELECT DISTINCT    '26,*,'
                      || det.det_code
                      || ','
                      || REPLACE(det.det_name
                                ,','
                                ,':')
                        rec
        FROM doc_enquiry_types det
            ,doc_types dtp
       WHERE det.det_end_date IS NULL
         AND det.det_dtp_code = dtp.dtp_code
         AND dtp.dtp_end_date IS NULL
         AND dtp.dtp_allow_complaints = 'Y'
    ORDER BY 1;
  CURSOR c27
  IS
      SELECT    '27,*,'
             || hco_code
             || ','
             || REPLACE(hco_meaning
                       ,','
                       ,':')
               rec
        FROM hig_codes
       WHERE hco_domain = 'COMPLAINT_SOURCE'
         AND hco_end_date IS NULL
    ORDER BY 1;
  -- Document Category details.
  CURSOR c28
  IS
      SELECT    '28,*,'
             || hco_code
             || ','
             || REPLACE(hco_meaning
                       ,','
                       ,':')
               rec
        FROM hig_codes
       WHERE hco_domain = 'DOC_CATEGORIES'
         AND hco_end_date IS NULL
    ORDER BY 1;
  -- Surface Condition details
  CURSOR c29
  IS
      SELECT    '29,*,'
             || hco_code
             || ','
             || REPLACE(hco_meaning
                       ,','
                       ,':')
               rec
        FROM hig_codes
       WHERE hco_domain = 'SURFACE_CONDITION'
         AND hco_end_date IS NULL
    ORDER BY 1;
  -- Weather Condition details
  CURSOR c30
  IS
      SELECT    '30,*,'
             || hco_code
             || ','
             || REPLACE(hco_meaning
                       ,','
                       ,':')
               rec
        FROM hig_codes
       WHERE hco_domain = 'WEATHER_CONDITION'
         AND hco_end_date IS NULL
    ORDER BY 1;
  -- sscanlon fix 700407 12SEP2007
  -- Cursor 31 was the original cursor which would return the list of inspectors
  -- to the user.  This cursor is fine if the parameter ANSWER2 = 'N'.
  -- If ANSWER2 = 'Y' then an additional restriction needed to be added to this
  -- cursor.  For ease, the cursor was copied and recreated as cursor C31a, and
  -- the restriction added.
  -- See top of package body code for problem description
  -- Inspector Details - no admin unit restriction
  CURSOR c31
  IS
      /*SELECT '31,*,'||hus_initials||','||replace(hus_name,',',':') rec
      FROM  hig_users
      WHERE hus_job_title='INSP'
      AND   hus_end_date IS NULL
      ORDER BY 1;*/
      -- Added 21-Sep-07 by MJA
      -- Product option EDIFDLROLE shipped to allow restriction by
      -- role entered in here for users else allow all users
      -- Changes included in the c31a cursor too
      SELECT    '31,*,'
             || hus_initials
             || ','
             || REPLACE(hus_name
                       ,','
                       ,':')
               rec
        FROM hig_users
       WHERE hus_end_date IS NULL
         AND (hig.get_sysopt('EDIFDLROLE') IS NULL
           OR  hus_username IN (SELECT hur_username
                                  FROM hig_user_roles
                                 WHERE hur_role = hig.get_sysopt('EDIFDLROLE')))
    ORDER BY 1;
  -- Inspector Details - restricted by users admin unit
  CURSOR c31a
  IS
      SELECT    '31,*,'
             || hus_initials
             || ','
             || REPLACE(hus_name
                       ,','
                       ,':')
               rec
        FROM hig_users
       --WHERE hus_job_title  = 'INSP'
       WHERE hus_end_date IS NULL
         AND (hig.get_sysopt('EDIFDLROLE') IS NULL
           OR  hus_username IN (SELECT hur_username
                                  FROM hig_user_roles
                                 WHERE hur_role = hig.get_sysopt('EDIFDLROLE')))
         AND hus_admin_unit IN
               (    SELECT hag_child_admin_unit
                      FROM hig_admin_groups
                     WHERE hag_direct_link = 'Y'
                START WITH hag_parent_admin_unit = (SELECT hus_admin_unit
                                                      FROM hig_users
                                                     WHERE hus_username = USER)
                CONNECT BY PRIOR hag_child_admin_unit = hag_parent_admin_unit
                       AND hag_direct_link = 'Y'
                UNION
                SELECT hus_admin_unit
                  FROM hig_users
                 WHERE hus_username = USER)
    ORDER BY 1;
  -- end of sscanlon fix 709407 12SEP2007
  --
  -- Standard Item Sections
  CURSOR c32
  IS
      SELECT    '32,*,'
             || sis_id
             || ','
             || REPLACE(sis_name
                       ,',')
               rec
        FROM standard_item_sections
       WHERE sis_end_date IS NULL
         AND sis_id > '0'
    ORDER BY 1;
  -- Standard Item Sub Sections
  CURSOR c33
  IS
      SELECT    '33,*,'
             || siss_sis_id
             || ','
             || siss_id
             || ','
             || REPLACE(siss_name
                       ,',')
               rec
        FROM standard_item_sub_sections
       WHERE siss_end_date IS NULL
         AND EXISTS
               (SELECT 'exists'
                  FROM standard_items sta
                 WHERE sta.sta_siss_id = siss_id)
         AND siss_id > '0'
    ORDER BY 1;
  -- Inventory Hierarchy details
  CURSOR c34
  IS
      SELECT    '34,*,'
             || sta_siss_id
             || ','
             || sta_item_code
             || ','
             || REPLACE(sta_item_name
                       ,',')
             || ','
             || sta_unit
             || ','
             || TO_CHAR(sta_min_quantity)
             || ','
             || TO_CHAR(sta_max_quantity)
             || ','
             || sta_dim1_text
             || ','
             || sta_dim2_text
             || ','
             || sta_dim3_text
               rec
        FROM standard_items
       WHERE NVL(sta_dcd_flag, 'Y') = 'Y'
         AND sta_end_date IS NULL
         AND sta_item_code > '0'
    ORDER BY 1;
  -- SM 10122008 709893
  -- Changed cursor 35, 36 and 37 to use v3 tables rather than translation views.
  CURSOR c35
  IS
      SELECT    '35,*,'
             || LPAD(TO_CHAR(iit_item_id)
                    ,iit_id_pad)
             || ','
             || LPAD(TO_CHAR(iit_rse_he_id)
                    ,rse_pad)
             || ','
             || iit_ity_inv_code
             || ','
             || iit_primary_key
             || ','
             || iit_foreign_key
             || ','
             || LPAD(TO_CHAR(iit_st_chain)
                    ,chain_pad)
             || ','
             || LPAD(TO_CHAR(iit_end_chain)
                    ,chain_pad)
             || ','
             || iit_x_sect
             || ','
             || REPLACE(iit_note
                       ,','
                       ,':')
               rec
        FROM inv_items
            ,inv_item_types
       WHERE iit_ity_inv_code = ity_inv_code
         AND iit_ity_sys_flag = ity_sys_flag
         AND ity_road_characteristic = 'I'
         AND ity_elec_drain_carr = NVL(fdiscipline, ity_elec_drain_carr)
         AND (fasset IS NULL
           OR  ity_inv_code IN (SELECT grp_value
                                  FROM gri_run_parameters
                                 WHERE grp_param = 'INVENTORY_ITEM'
                                   AND grp_job_id = job_id))
         AND (fgroup IS NULL
           OR  iit_rse_he_id IN (    SELECT nm_ne_id_of
                                       FROM nm_members_all
                                      WHERE nm_end_date IS NULL
                                        AND nm_type = 'G'
                                        AND DECODE(get_nt_type(nm_ne_id_of)
                                                  ,'D', 'S'
                                                  ,'L', 'S'
                                                  ,'G') <> 'P'
                                 CONNECT BY PRIOR nm_ne_id_of = nm_ne_id_in
                                 START WITH nm_ne_id_in = fgroup))
         AND (fxsp IS NULL
           OR  EXISTS
                 (SELECT grp_value
                    FROM gri_run_parameters
                   WHERE grp_value = NVL(iit_x_sect, grp_value)
                     AND grp_param = 'XSP'
                     AND grp_job_id = job_id))
    ORDER BY 1;
  -- Inspection Network details
  CURSOR c36(
    he_id IN road_segs.rse_he_id%TYPE)
  IS
    SELECT    '36,*,'
           || LPAD(TO_CHAR(ne.ne_id)
                  ,rse_pad)
           || ','
           || LPAD(
                DECODE(
                  DECODE(ne.ne_gty_group_type
                        ,'LLNK', 'Y'
                        ,'DLNK', 'Y'
                        ,NULL, 'Y'
                        ,'N')
                 ,'Y', ne.ne_owner
                 ,NULL)
               ,4)
           || ','
           || DECODE(
                DECODE(ne.ne_gty_group_type
                      ,'LLNK', 'Y'
                      ,'DLNK', 'Y'
                      ,NULL, 'Y'
                      ,'N')
               ,'Y', ne.ne_sub_type || ne.ne_name_1
               ,NULL)
           || ','
           || DECODE(ne.ne_gty_group_type, NULL, ne.ne_number, NULL)
           || ','
           || ne.ne_sub_class
           || ','
           || REPLACE(ne.ne_descr
                     ,','
                     ,':')
           || ','
           || LPAD(
                TO_CHAR(
                  DECODE(ne.ne_gty_group_type
                        ,NULL, get_ne_length(ne.ne_id)
                        ,NULL))
               ,chain_pad)
           || ','
           || SUBSTR(iit_chr_attrib41
                    ,1
                    ,1)
           || ','
           || SUBSTR(iit_chr_attrib51
                    ,1
                    ,1)
             rec
      FROM nm_elements_all ne
          ,nm_nw_ad_link_all nad
          ,nm_inv_items_all iit
     WHERE ne.ne_id = he_id
       AND ne.ne_end_date IS NULL
       AND ne.ne_id = nad.nad_ne_id(+)
       AND nad.nad_iit_ne_id = iit.iit_ne_id(+)
       AND nad.nad_primary_ad(+) = 'Y';
  --
  -- Section Id and Activity details
  CURSOR c37
  IS
      SELECT '37,*,' || TO_CHAR(ne.ne_id) || ',' || afr.afr_atv_acty_area_code
               rec
        FROM nm_elements_all ne
            ,act_freqs afr
            ,nm_inv_items_all iit
            ,nm_nw_ad_link_all nad
            ,nm_elements_all linkcode
       WHERE afr.afr_atv_acty_area_code IN
               (SELECT DECODE(
                         a.atv_maint_insp_flag
                        ,'S', afr.afr_atv_acty_area_code
                        ,DECODE(grp.grp_value
                               ,NULL, afr.afr_atv_acty_area_code
                               ,grp.grp_value))
                  FROM activities a
                      ,gri_run_parameters grp
                 WHERE a.atv_acty_area_code(+) = grp.grp_value
                   AND grp.grp_param = 'ACTIVITY'
                   AND grp.grp_job_id = job_id)
         AND ((NVL(factgroup, 'ALL') = 'ALL')
           OR  afr.afr_atv_acty_area_code IN
                 (SELECT agm_acty_code
                    FROM activity_groups
                        ,act_group_membs
                   WHERE acg_group_code = factgroup
                     AND agm_group_code = acg_group_code))
         AND afr.afr_ity_sys_flag = ne.ne_prefix
         AND afr.afr_scl_sect_class = ne.ne_sub_class
         AND afr.afr_road_environment = SUBSTR(iit_chr_attrib41
                                              ,1
                                              ,1)
         AND ne.ne_id IN (    SELECT nm.nm_ne_id_of
                                FROM nm_members_all nm
                               WHERE nm_type = 'G'
                                 AND DECODE(get_nt_type(nm_ne_id_of)
                                           ,'D', 'S'
                                           ,'L', 'S'
                                           ,'G') <> 'P'
                                 AND nm.nm_end_date IS NULL
                          CONNECT BY PRIOR nm.nm_ne_id_of = nm.nm_ne_id_in
                          START WITH nm.nm_ne_id_in = fgroup)
         AND ne.ne_id = nad.nad_ne_id(+)
         AND nad.nad_iit_ne_id = iit.iit_ne_id(+)
         AND nad.nad_primary_ad(+) = 'Y'
         AND ne.ne_name_2 = linkcode.ne_unique(+)
    ORDER BY 1;
  --
  CURSOR c38
  IS
        SELECT rsm_rse_he_id_of section
          FROM road_seg_membs
         WHERE rsm_end_date IS NULL
           AND rsm_type = 'S'
    CONNECT BY PRIOR rsm_rse_he_id_of = rsm_rse_he_id_in
    START WITH rsm_rse_he_id_in = fgroup
      ORDER BY inspection_order(rsm_rse_he_id_in
                               ,rsm_rse_he_id_of);
  -- Weather Condition details
  CURSOR c39
  IS
      SELECT    '39,*,'
             || hco_code
             || ','
             || REPLACE(hco_meaning
                       ,','
                       ,':')
               rec
        FROM hig_codes
       WHERE hco_domain = 'ASSET_MODIFICATION'
         AND hco_end_date IS NULL
    ORDER BY 1;
  --
  -- Obtain the file extension from the GRI_MODULES table for the
  -- selected module.
  --
  CURSOR file_extension
  IS
    SELECT grm_file_type
      FROM gri_modules
     WHERE grm_module = v_module;
  --
  -- Retrieve the initials for the user to insert before the filename
  -- so that filename's are specific to users
  --
  CURSOR get_name
  IS
    SELECT hus_initials
      FROM hig_users
     WHERE hus_username = USER;
  --
  -- Added to check if module was run from a web client
  --
  CURSOR get_ui
  IS
    SELECT grr_mode
      FROM gri_report_runs
     WHERE grr_job_id = job_id;
  --
  lc_ui        VARCHAR2(15);
  --
  CURSOR c_def_attr
  IS
    SELECT    dty_hh_attribute_1
           || ','
           || REPLACE(dty_hh_attri_text_1
                     ,','
                     ,':')
             d_attr_text
      FROM def_types
     WHERE dty_hh_attribute_1 IS NOT NULL
    UNION
    SELECT    dty_hh_attribute_2
           || ','
           || REPLACE(dty_hh_attri_text_2
                     ,','
                     ,':')
      FROM def_types
     WHERE dty_hh_attribute_2 IS NOT NULL
    UNION
    SELECT    dty_hh_attribute_3
           || ','
           || REPLACE(dty_hh_attri_text_3
                     ,','
                     ,':')
      FROM def_types
     WHERE dty_hh_attribute_3 IS NOT NULL
    UNION
    SELECT    dty_hh_attribute_4
           || ','
           || REPLACE(dty_hh_attri_text_4
                     ,','
                     ,':')
      FROM def_types
     WHERE dty_hh_attribute_4 IS NOT NULL;
  --
  PROCEDURE handle_error(pi_error_msg IN VARCHAR2)
    IS
  BEGIN
    /*
    ||Report The Error.
    */
    dbms_output.put_line(pi_error_msg);
    higgrirp.write_gri_spool(job_id,SUBSTR(pi_error_msg,1,2000));
    higgrirp.write_gri_spool(job_id,NULL);
    /*
    ||Close The File.
    */
    BEGIN
      IF is_open(file_handle)
       THEN
          utl_file.fclose(file_handle);
      END IF;
    EXCEPTION
      WHEN others
       THEN
          NULL;
    END;
  END handle_error;
  --
BEGIN
  --
  -- Obtain the specified file name and location
  --
  IF fseq IS NULL
  THEN
    fseq := getfileseq;
  END IF;
  --
  OPEN file_extension;
  FETCH file_extension INTO ffileext;
  IF file_extension%NOTFOUND
  THEN
    ffileext := '.lis';
    CLOSE file_extension;
  ELSE
    CLOSE file_extension;
  END IF;
  v_filename := TO_CHAR(fseq) || '.' || ffileext;
  /*
  || Note: For general use witht he GRI it would be best if the filename
  ||       was derived as above, however, the Survey+ software requires that
  ||       the file is called a specific name and so we have had to hard code
  ||       the filename.
  ||
  */
  v_filename := 'SURVEYP.ped';
  --
  -- Code added to check if module was run via a Web client
  --
  OPEN get_ui;
  FETCH get_ui INTO lc_ui;
  CLOSE get_ui;
  --
  IF NVL(lc_ui, 'WIN32') != 'WEB'
  THEN
    v_filename := 'SURVEYP.ped';
    -- Powys require that a file name be specific to a user so put the initials before
    -- the file name
    OPEN get_name;
    FETCH get_name INTO user_init;
    CLOSE get_name;
    -- sscanlon fix 709407 12SEP2007
    -- If the value of FFile (obtained from user option PEDFILE) is populated
    -- then it should be used, otherwise (for customers who don't wish to define
    -- a default filename) the current filename should be used.
    -- See top of package body code for problem description
    v_filename := NVL(ffile, user_init || v_filename);
    -- end of sscanlon fix 709407 12SEP2007
    /*
    ||Create The File.
    */
    create_file(fdest
               ,v_filename
               ,startline);
    --
  ELSE
    -- sscanlon fix 709407 12SEP2007
    -- If the value of FFile (obtained from user option PEDFILE) is populated
    -- then it should be used, otherwise (for customers who don't wish to define
    -- a default filename) the current filename should be used.
    -- See top of package body code for problem description
    v_filename := NVL(ffile, TO_CHAR(job_id) || '.' || ffileext);
    -- end of sscanlon fix 709407 12SEP2007
    dbms_output.put_line('filename = ' || fdest || ' ' || v_filename);
    /*
    ||Open The File.
    */
    create_file(fdest
               ,v_filename
               ,startline);
    --
  END IF;
  -- Obtain distinct system flags ( D,L )
  FOR i_rec IN c38 LOOP
    FOR j_rec IN c1(i_rec.section) LOOP
      IF NVL(INSTR(sysflags
                  ,j_rec.rse_sys_flag)
            ,0) = 0
      THEN
        sysflags := sysflags || ',' || '''' || j_rec.rse_sys_flag || '''';
      END IF;
    END LOOP;
  -- sysflags:=substr(sysflags,2,(length(sysflags)-1));
  END LOOP;
  /* populate pl/sql table with defect attribute descriptions */
  FOR def_rec IN c_def_attr LOOP
    l_count_def_attr := l_count_def_attr + 1;
    def_attr_rec(l_count_def_attr) := def_rec.d_attr_text;
  END LOOP;
  /* fetch in values from all cursors */
  FOR i_rec IN c2 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c3 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c4 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN 1 .. l_count_def_attr LOOP
    rec_count := rec_count + 1;
      SELECT    '5,*,'
             || TO_CHAR(i_rec)
             || ','
             || SUBSTR(def_attr_rec(i_rec)
                      ,INSTR(def_attr_rec(i_rec)
                            ,','
                            ,1)
                       + 1)
             || ','
             || DECODE(data_type,  'VARCHAR2', 'S',  'NUMBER', 'I')
             || ','
             || DECODE(data_type
                      ,'VARCHAR2', data_length
                      ,'NUMBER', data_precision)
             || ','
             || data_scale
               rec
        INTO cursor_recs(rec_count)
        FROM user_tab_columns
       WHERE column_name = SUBSTR(def_attr_rec(i_rec)
                                 ,1
                                 ,INSTR(def_attr_rec(i_rec)
                                       ,','
                                       ,1)
                                  - 1)
         AND table_name = 'DEFECTS'
    ORDER BY 1;
  END LOOP;
  --
  FOR i_rec IN c6 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
    IF i_rec.attr_1 != ','
    THEN
      FOR i IN 1 .. l_count_def_attr LOOP
        IF def_attr_rec(i) = i_rec.attr_1
        THEN
          cursor_recs(rec_count) :=
            cursor_recs(rec_count) || TO_CHAR(i) || ',';
        END IF;
      END LOOP;
    ELSE
      cursor_recs(rec_count) := cursor_recs(rec_count) || '0,';
    END IF;
    IF i_rec.attr_2 != ','
    THEN
      FOR i IN 1 .. l_count_def_attr LOOP
        IF def_attr_rec(i) = i_rec.attr_2
        THEN
          cursor_recs(rec_count) :=
            cursor_recs(rec_count) || TO_CHAR(i) || ',';
        END IF;
      END LOOP;
    ELSE
      cursor_recs(rec_count) := cursor_recs(rec_count) || '0,';
    END IF;
    IF i_rec.attr_3 != ','
    THEN
      FOR i IN 1 .. l_count_def_attr LOOP
        IF def_attr_rec(i) = i_rec.attr_3
        THEN
          cursor_recs(rec_count) :=
            cursor_recs(rec_count) || TO_CHAR(i) || ',';
        END IF;
      END LOOP;
    ELSE
      cursor_recs(rec_count) := cursor_recs(rec_count) || '0,';
    END IF;
    IF i_rec.attr_4 != ','
    THEN
      FOR i IN 1 .. l_count_def_attr LOOP
        IF def_attr_rec(i) = i_rec.attr_4
        THEN
          cursor_recs(rec_count) := cursor_recs(rec_count) || TO_CHAR(i);
        END IF;
      END LOOP;
    ELSE
      cursor_recs(rec_count) := cursor_recs(rec_count) || '0';
    END IF;
  END LOOP;
  --
  FOR i_rec IN c7 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c8 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c9 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c11 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c12 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c13 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  /*
  FOR i_rec IN c14 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  */
  FOR i_rec IN c15 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  -- SM 713267 06102008
  IF faunit = 'N'
  THEN
    FOR i_rec IN c21 LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  ELSE
    FOR i_rec IN c21a LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  END IF;
  IF faunit = 'N'
  THEN
    FOR i_rec IN c22 LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  ELSE
    FOR i_rec IN c22a LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  END IF;
  -- end SM 713267 06102008
  FOR i_rec IN c24 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c25 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c26 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c27 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c28 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c29 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c30 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  -- sscanlon fix 709497 12SEP2007
  -- check the contents of FAunit to see if the user wants to restrict the
  -- list of inspectors based on their Admin Unit, default = 'N' (no restriction).
  -- The default value may be overwritten by the contents of the ANSWER2
  -- gri parameter further up in the code.
  -- See top of package body code for problem description
  IF faunit = 'N'
  THEN
    FOR i_rec IN c31                                           -- Unrestricted
                    LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  ELSE
    FOR i_rec IN c31a                              -- Restricted by Admin Unit
                     LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  END IF;
  --end of sscanlon fix 709407 12SEP2007
  --
  FOR i_rec IN c32 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c33 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  FOR i_rec IN c34 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  --
  IF fheir = 'Y'
  THEN
    --
    FOR i_rec IN c35 LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
    --
    FOR i_rec IN c38 LOOP
      FOR j_rec IN c36(i_rec.section) LOOP
        rec_count := rec_count + 1;
        cursor_recs(rec_count) := j_rec.rec;
      END LOOP;
    END LOOP;
    --
    FOR i_rec IN c37 LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
    --
  END IF;
  --
  FOR i_rec IN c39 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  /* all records in the table now write them out to the file */
  IF (debug)
   THEN
      dbms_output.put_line(rec_count || ' record(s) loaded');
  END IF;
  --
  FOR i IN 1 .. rec_count LOOP
    IF NOT writeln(file_handle
                  ,cursor_recs(i))
     THEN
        higgrirp.write_gri_spool(job_id,'Error: Problem writing to output file.');
        RAISE utl_file.write_error;
    END IF;
  END LOOP;
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN utl_file.invalid_operation
  THEN
    handle_error(pi_error_msg => 'Error: An invalid operation occured - ' || fn);
    RETURN FALSE;
  WHEN utl_file.invalid_path
  THEN
    handle_error(pi_error_msg => 'Error: An invalid path error occured - ' || fn);
    RETURN FALSE;
  WHEN utl_file.read_error
  THEN
    handle_error(pi_error_msg => 'Error: A read error occured on the specified file - ' || fn);
    RETURN FALSE;
  WHEN utl_file.write_error
  THEN
    handle_error(pi_error_msg => 'Error: Cannot write to the specified file - ' || fn);
    RETURN FALSE;
  WHEN utl_file.internal_error
  THEN
    handle_error(pi_error_msg => 'Error: An internal error was found - ' || fn);
    RETURN FALSE;
  WHEN utl_file.invalid_filehandle
  THEN
    handle_error(pi_error_msg => 'Error: The specified file handle does not identify a valid file - '|| fn);
    RETURN FALSE;
  WHEN utl_file.invalid_mode
  THEN
    handle_error(pi_error_msg => 'Error: Invalid mode - ' || fn);
    RETURN FALSE;
  WHEN INVALID_NUMBER
  THEN
    handle_error(pi_error_msg => 'Error: Invalid number exception raised - ' || fn);
    RETURN FALSE;
  WHEN VALUE_ERROR
  THEN
    handle_error(pi_error_msg => 'Error: Value error exception raised - ' || fn);
    RETURN FALSE;
  WHEN OTHERS
  THEN
    handle_error(pi_error_msg => SQLERRM || ' ' || fn);
    RETURN FALSE;
END processpedif;
--
-----------------------------------------------------------------------------
-- This is where the real processing starts
--
PROCEDURE main(job_id IN NUMBER)
IS
  start_time  BINARY_INTEGER;
  end_time    BINARY_INTEGER;
  tot_time    BINARY_INTEGER;
  trace_on    BOOLEAN := FALSE;
  --
BEGIN
  IF trace_on
   THEN
      dbms_session.set_sql_trace(trace_on);
  END IF;
  -- [HB]: Display the current version of the module
  dbms_output.put_line('Version: ' || g_sccsid);
  dbms_output.put_line('.');
  --
  IF debug
   THEN
      dbms_output.enable(1000000);
      start_time := dbms_utility.get_time;
      dbms_output.put_line('Start Time : '||TO_CHAR(start_time));
  END IF;
  --
  get_params(job_id);
  --
  IF NOT processpedif(job_id)
   THEN
      higgrirp.write_gri_spool(job_id,'Error: Pedif file generation failed - {Main}');
  ELSE
      higgrirp.write_gri_spool(job_id,'File created in the INTERPATH directory');
      higgrirp.write_gri_spool(job_id,'Directory : '||fdest);
      higgrirp.write_gri_spool(job_id,'File      : '||v_filename);
  END IF;
  -- close the file if it is still open
  IF (is_open(file_handle))
   THEN
      utl_file.fclose(file_handle);
  END IF;
  IF trace_on
   THEN
      dbms_session.set_sql_trace(trace_on);
  END IF;
END main;
--
-----------------------------------------------------------------------------
--
END pedif;
/