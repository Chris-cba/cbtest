CREATE OR REPLACE PACKAGE BODY Pedif
AS
 -----------------------------------------------------------------------------
 --
 --   PVCS Identifiers :-
 --
 --       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai3863.pkb-arc   2.8   Jun 18 2010 09:33:18   aedwards  $
 --       Module Name      : $Workfile:   mai3863.pkb  $
 --       Date into SCCS   : $Date:   Jun 18 2010 09:33:18  $
 --       Date fetched Out : $Modtime:   Jun 18 2010 09:32:38  $
 --       SCCS Version     : $Revision:   2.8  $
 --       Based on SCCS Version     : 1.3
 --
 -----------------------------------------------------------------------------
 --   Originally taken from '@(#)mai3863.pck    @(#)mai3863.pck 1.31 08/05/02';
 -----------------------------------------------------------------------------
 -- Copyright (c) exor corporation ltd, 2002
 -----------------------------------------------------------------------------
  
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
  debug          BOOLEAN:=FALSE;
  v_module       VARCHAR2(7):='MAI3863';
  --
  --
  File_Handle    utl_file.file_type;    -- File handle
  Output_File    utl_file.file_type;    -- File handle
  --
  FDiscipline VARCHAR2(1);      -- Discipline
  FFile       VARCHAR2(80);     -- Input file name
  -- sscanlon fix 709407 12SEP2007
  -- Added new variable FAunit to hold the Y/N data from parameter ANSWER 2 
  -- See top of package body code for problem description   
     FAunit      Varchar2(1):='N'; -- Admin unit restriction  
  -- end of sscanlon fix 709407 12SEP2007     
  FDest       VARCHAR2(80);     -- Input directory name
  Ftype       VARCHAR2(1);      -- File type
  FSuffix     VARCHAR2(3);      -- Entered file suffix
  FSeq        NUMBER;       -- Sequence number
  FGType      road_groups.RSE_GTY_GROUP_TYPE%TYPE; -- Road Group Type
  FGroup      Road_segs.rse_he_id%TYPE; -- Road Group
  FActivity   VARCHAR2(80);    -- Activity list
  FActGroup   ACTIVITY_GROUPS.ACG_GROUP_CODE%TYPE;-- Activity Group
  FAsset      VARCHAR2(80):= null; -- Asset type
  FHeir       VARCHAR2(1);     -- Hierarchical inventory required
  FFileext    VARCHAR2(3);     -- Output file extension
  sysflags    VARCHAR(10):='';     -- Network indicator variables
  FXsp        VARCHAR(80):= null;  -- Inventory XSP
  --
  FRead       CHAR:='R';      -- Read Character
  FWrite      CHAR:='W';      -- Write character
  v_filename  VARCHAR2(80);       -- Compound filename
  i           INTEGER;    -- Counter
  StartLine   VARCHAR2(1000):='1,EDIF , Version: '||g_sccsid||', Created By: '||USER||', Date: '||TO_CHAR(SYSDATE,'DDMMYYYY');
  --
  type def_attr is table of varchar2(1000) index by binary_integer;
  def_attr_rec def_attr;
  l_count_def_attr binary_integer := 0;
  --
PROCEDURE Get_Params(job_id IN NUMBER) IS
  CURSOR all_param_values( job_id    IN NUMBER
                          ,parameter IN VARCHAR )
  IS SELECT grp_value item_value
     FROM   gri_run_parameters
     WHERE  grp_param=parameter
     AND    grp_job_id = job_id
     ORDER BY grp_seq;
BEGIN
  --
  -- The sequence defines the output filename. The sequence used should be that
  -- used by all modules which use the GRI. The filename extension should also
  -- be obtained from the GRI_MODULES.GRI_FILE_TYPE column.
  FSeq       := job_id;
  FDiscipline:= Higgrirp.get_parameter_value(job_id,'DISCIPLINE');
  FGType     := Higgrirp.get_parameter_value(job_id,'ROAD_TYPE');
  FGroup     := TO_NUMBER(Higgrirp.get_parameter_value(job_id,'ROAD_ID'));
  FAsset     := Higgrirp.get_parameter_value(job_id,'INVENTORY_ITEM');
  FActGroup  := Higgrirp.get_parameter_value(job_id,'ACTIVITY_GROUP');
  FDest      := LOWER(Higgrirp.get_parameter_value(job_id,'TEXT'));
  FHeir      := NVL(Higgrirp.get_parameter_value(job_id,'ANSWER'),'Y');
  FXsp       := Higgrirp.get_parameter_value(job_id,'XSP');
  
  -- sscanlon fix 709497 12SEP2007 
  -- get the values from the parameters PEDFILE and ANSWER2 
     FFile      := Higgrirp.get_parameter_value(job_id,'PEDFILE');
     FAunit     := Higgrirp.get_parameter_value(job_id,'ANSWER2');
  --end of sscanlon fix 709497 12SEP2007 
  
  -- Factivity is used for display when in debug mode only
  IF debug THEN
  --
  -- The parameters for this module may include upto 6 activity codes.
  -- For this reason we need to ensure that we obtain any number of activity
  -- parameters.
  --
  FOR each_activity IN all_param_values(job_id,'ACTIVITY')
  LOOP
    IF (each_activity.item_value IS NOT NULL) THEN
      FActivity:=FActivity||''''||each_activity.item_value||''''||',';
    END IF;
  END LOOP;
  --
  FActivity:=SUBSTR(FActivity,1,LENGTH(FActivity)-1);
  --
  FOR each_inv_item IN all_param_values(job_id,'INVENTORY_ITEM')
  LOOP
    IF (each_inv_item.item_value IS NOT NULL) THEN
      FAsset:=FAsset||''''||each_inv_item.item_value||''''||',';
    END IF;
  END LOOP;
  --
  FAsset:=SUBSTR(FAsset,1,LENGTH(FAsset)-1);
  --
  FOR each_inv_item IN all_param_values(job_id,'XSP')
  LOOP
    IF (each_inv_item.item_value IS NOT NULL) THEN
       FXsp:=FXsp||''''||each_inv_item.item_value||''''||',';
    END IF;
  END LOOP;
  --
  FXsp:=SUBSTR(FXsp,1,LENGTH(FXsp)-1);
--
  dbms_output.put_line('');
  dbms_output.put_line('Parameter Discipline    : '||FDiscipline);
  dbms_output.put_line('Parameter Output Seq.   : '||TO_CHAR(FSeq));
  dbms_output.put_line('Parameter Destination   : '||FDest);
  dbms_output.put_line('Parameter Group Type    : '||FGType);
  dbms_output.put_line('Parameter Group         : '||TO_CHAR(FGroup));
  dbms_output.put_line('Parameter Activities    : '||FActivity);
  dbms_output.put_line('Parameter Asset         : '||FAsset);
  dbms_output.put_line('Parameter Act Group     : '||FActGroup);
  dbms_output.put_line('Parameter Use Hierarchy : '||FHeir);
  dbms_output.put_line('Parameter Inventory XSP : '||FXsp);
  dbms_output.put_line('Parameter Output Dir    : '||FDest);
  -- sscanlon fix 709407 12SEP2007
  -- additional debug output for the new variables added above. 
  -- See top of package body code for problem description   
     dbms_output.put_line('Parameter Output File   : '||FFile);
     dbms_output.put_line('Parameter Restrict AU   : '||FAunit);  
  -- end of sscanlon fix 709407 12SEP2007 
  dbms_output.put_line('');
  END IF;
  --
END;
-- *****************************************************************************
-- Obtain the next file sequence if one has not been provided
-- *****************************************************************************
FUNCTION GetFileSeq
RETURN INTEGER
IS
  v_seq NUMBER;
  --
  CURSOR NextFileSeq
  IS SELECT File_id_seq.NEXTVAL
     FROM   dual;
   --
BEGIN
  --
  OPEN  NextFileSeq;
  FETCH NextFileSeq INTO v_seq;
  CLOSE NextFileSeq;
  --
  RETURN v_seq;
EXCEPTION
  WHEN -- Ora-2289 { Sequence does not exist }
  OTHERS
  THEN dbms_output.put_line('Error: Sequence does not exist - {GetFileSeq}');
  RETURN 0;
END;
-- *****************************************************************************
-- Procedure Create File
-- *****************************************************************************
PROCEDURE  Create_File(loc_in IN VARCHAR2
                      ,file_in IN VARCHAR2
                      ,line_in IN VARCHAR2)
IS
BEGIN
  -- Open the specified file for writing
  IF debug
  THEN dbms_output.put_line('{ Function - Create File }');
       dbms_output.put_line('Location : '||loc_in);
       dbms_output.put_line('File     : '||file_in);
       dbms_output.put_line('Line     : '||line_in);
  END IF;
  file_handle:=utl_file.fopen(loc_in,file_in,FWrite);
  IF   line_in IS NOT NULL
  THEN utl_file.put_line(file_handle,line_in);
  ELSE utl_file.put_line(file_handle,'Info: End-Of-File here');
  END IF;
  --
EXCEPTION
  WHEN OTHERS
  THEN dbms_output.put_line('Error: An unknown error occured - {Create_File}');
  RAISE;
END;
-- *****************************************************************************
-- Check for the existance of a specified file
-- *****************************************************************************
FUNCTION FileExists( loc_in   IN VARCHAR2
                    ,file_in  IN VARCHAR2 )
RETURN BOOLEAN
IS
BEGIN
  -- Open the file
  IF debug THEN
  dbms_output.put_line('Path   : '||loc_in);
  dbms_output.put_line('File   : '||file_in);
  END IF;
  --
  IF NOT is_open(file_handle)
  THEN IF NOT Close_File(File_handle)
       THEN dbms_output.put_line('Info: Unable to close open file.');
       END IF;
       file_handle:=utl_file.fopen(loc_in,file_in,FRead);
  END IF;
  --
  IF debug
  THEN dbms_output.put_line('Info: Handle Obtained - {FileExists}');
  END IF;
  --
  -- Return the result of a check with IS_OPEN
  utl_file.fclose(file_handle);
  --
  RETURN TRUE;
  --
EXCEPTION
  WHEN OTHERS
  THEN RETURN FALSE;
END;
-- *****************************************************************************
-- Check to see wether a specified file is open
-- *****************************************************************************
FUNCTION Is_Open(file_in IN utl_file.file_type)
RETURN BOOLEAN
IS
BEGIN
  IF utl_file.is_open(file_in)
  THEN RETURN TRUE;
  ELSE RETURN FALSE;
  END IF;
END;
-- *****************************************************************************
-- Closes an open file.
-- *****************************************************************************
FUNCTION Close_File(file_in IN utl_file.file_type)
RETURN BOOLEAN
IS
BEGIN
  utl_file.fclose(File_Handle);
  IF is_open(File_Handle)
  THEN RETURN FALSE;
  ELSE RETURN TRUE;
  END IF;
END;
--
FUNCTION  Inspection_Order( Parent_id IN road_segs.rse_he_id%TYPE
                          , Child_Id  IN road_segs.rse_he_id%TYPE
              )
RETURN NUMBER
IS
  CURSOR get_rsm
  IS SELECT rsm_seq_no
     FROM   road_seg_membs
     WHERE  rsm_rse_he_id_in = Parent_id
     AND    rsm_rse_he_id_of = Child_Id
     AND    rsm_end_date IS NULL;
  --
  p_rsm NUMBER;
  --
BEGIN
  OPEN  get_rsm;
  FETCH get_rsm INTO p_rsm;
  IF    get_rsm%notfound
  THEN  p_rsm:=NULL;
        CLOSE get_rsm;
  ELSE CLOSE get_rsm;
  END IF;
  RETURN p_rsm;
END;
--
-- *****************************************************************************
-- Write an output line to a file
-- *****************************************************************************
--
FUNCTION Writeln(File_Handle IN utl_file.File_Type, line_in IN VARCHAR2 )
RETURN BOOLEAN
IS
BEGIN
  --
  utl_file.put_line(File_Handle,line_in);
  utl_file.fflush(File_Handle);
  --
  RETURN TRUE;
EXCEPTION
  WHEN OTHERS
  THEN RETURN FALSE;
END;
--
-- *****************************************************************************
-- This procedure should provide the user with the facility to download
-- data defined by the PEDIF  file format.
-- *****************************************************************************
FUNCTION ProcessPedif( job_id IN NUMBER )
RETURN BOOLEAN
IS
  fn     VARCHAR2(20):='{ ProcessPedif }';
  rse_pad    INTEGER:=8; -- Padded length for section id
  iit_id_pad INTEGER:=8; -- Padded length for Inv Item Id
  chain_pad  INTEGER:=6; -- Padded length for Chainage values
  rec_count  INTEGER:=0; -- number of records loaded
  user_init  hig_users.hus_initials%TYPE := NULL; -- initials of user executing procedure
  -- table type to store buffer output from cursors before outputting contents to a file
  TYPE t1 IS TABLE OF VARCHAR2(300)
  INDEX BY BINARY_INTEGER;
  cursor_recs t1;
  /* cursor definitions */
-- Obtain a distinct list of the road section network indicators
  CURSOR c1(he_id IN road_segs.rse_he_id%TYPE)
  IS SELECT rse_sys_flag
     FROM   road_segs
     WHERE  rse_he_id = he_id;
-- Activity Type Descripiton
  CURSOR c2 IS
  -- was atv_dtp_flag
  -- was where instr(sysflags,atv_dtp_flag)>0
    SELECT '2,'||'*'       ||','||
           atv.atv_maint_insp_flag||','||
           atv.atv_acty_area_code ||','||
           replace(atv.atv_descr,',',':')  rec
    FROM   activities atv
    WHERE  atv.atv_end_date IS NULL
    AND    atv.atv_acty_area_code IN ( SELECT DECODE(a.atv_maint_insp_flag
                                                   ,'S',atv.atv_acty_area_code
                                                   ,DECODE(grp.grp_value
                                                          ,NULL,atv.atv_acty_area_code
                                                          ,grp.grp_value))
                                       FROM   activities a
                                       ,      gri_run_parameters grp
                                       WHERE  a.atv_acty_area_code(+) = grp.grp_value
                                       AND    grp.grp_param = 'ACTIVITY'
                                       AND    grp.grp_job_id = job_id)
    AND    (( NVL(FActGroup,'ALL')='ALL' )
    OR     atv.atv_acty_area_code IN ( SELECT agm_acty_code
                                       FROM   ACTIVITY_GROUPS
                                       ,      ACT_GROUP_MEMBS
                                       WHERE  ACG_GROUP_CODE = FActGroup
                                       AND    AGM_GROUP_CODE = ACG_GROUP_CODE ))
    ORDER BY 1;
-- Defect Type Description
  CURSOR c3 IS
  -- was dty_dtp_flag
  -- was where instr(sysflags,dty_dtp_flag)>0
    SELECT DISTINCT '3,'||'*'       ||','||
           dty_defect_code   ||','||
           replace(dty_descr1,',',':')    ||
           replace(dty_descr2,',',':') rec
    FROM   def_types
    WHERE  dty_end_date IS NULL
    ORDER BY 1;
-- Treatment Type Description
  CURSOR c4 IS
    SELECT '4,*,'||RPAD(tre_treat_code,4)||','||
           replace(tre_descr,',',':') rec
    FROM   treatments
    WHERE  tre_end_date IS NULL
    ORDER BY 1;
-- Defect Attributes
-- Now using pl/sql table instead so this cursor no longer required.
/*      SELECT  '5,*,'||to_char(hco_seq)||','||
      hco_meaning||','||
      decode(data_type,'VARCHAR2','S','NUMBER','I')||','||
      decode(data_type,'VARCHAR2',data_length,'NUMBER',data_precision)||','||
      data_scale  rec
      FROM  hig_codes
      , user_tab_columns
      WHERE hco_domain='DEFECT_ATTRIBUTES'
      AND   hco_code  =column_name
      AND   hco_end_date IS NULL
      AND   table_name='DEFECTS'
      ORDER BY 1;*/
  CURSOR c6 IS
  -- was dty_sys_flag
    SELECT '6,'||'*'       ||','|| -- Network Ind.
           dty_atv_acty_area_code||','|| -- Activity Code
           dty_defect_code       ||',' rec -- Defect Code
    ,      dty_hh_attribute_1||','||replace(dty_hh_attri_text_1,',',':') attr_1
    ,      dty_hh_attribute_2||','||replace(dty_hh_attri_text_2,',',':') attr_2
    ,      dty_hh_attribute_3||','||replace(dty_hh_attri_text_3,',',':') attr_3
    ,      dty_hh_attribute_4||','||replace(dty_hh_attri_text_4,',',':') attr_4
    FROM   def_types
    WHERE  trunc(sysdate) between trunc(nvl(dty_start_date,sysdate)) and trunc(nvl(dty_end_date,sysdate))
    AND    dty_atv_acty_area_code IN ( SELECT DECODE(a.atv_maint_insp_flag
                                                    ,'S',dty_atv_acty_area_code
                                                    ,DECODE(grp.grp_value
                                                           ,NULL,dty_atv_acty_area_code
                                                           ,grp.grp_value))
                                       FROM   activities a
                                       ,      gri_run_parameters grp
                                       WHERE  a.atv_acty_area_code(+) = grp.grp_value
                                       AND    grp.grp_param = 'ACTIVITY'
                                       AND    grp.grp_job_id = job_id)
    AND    (( NVL(FActGroup,'ALL') = 'ALL' )
    OR     dty_atv_acty_area_code IN ( SELECT agm_acty_code
                                       FROM   ACTIVITY_GROUPS
                                       ,      ACT_GROUP_MEMBS
                                       WHERE  ACG_GROUP_CODE = FActGroup
                                       AND    AGM_GROUP_CODE = ACG_GROUP_CODE ))
    ORDER BY 1;
  CURSOR c7 IS
  -- was afr_ity_sys_flag
    SELECT DISTINCT '7,'||'*'      ||','||
           afr_atv_acty_area_code||','||
           afr_ity_inv_code rec
    FROM  act_freqs
    ,     inv_item_types
    WHERE afr_atv_acty_area_code IN ( SELECT DECODE(a.atv_maint_insp_flag
                                                   ,'S',afr_atv_acty_area_code
                                                   ,DECODE(grp.grp_value
                                                          ,NULL,afr_atv_acty_area_code
                                                          ,grp.grp_value))
                                      FROM   activities a
                                      ,      gri_run_parameters grp
                                      WHERE  a.atv_acty_area_code(+) = grp.grp_value
                                      AND    grp.grp_param = 'ACTIVITY'
                                      AND    grp.grp_job_id = job_id)
    AND   (( NVL(FActGroup,'ALL')='ALL' )
    OR    afr_atv_acty_area_code IN ( SELECT agm_acty_code
                                      FROM   ACTIVITY_GROUPS
                                      ,      ACT_GROUP_MEMBS
                                      WHERE  ACG_GROUP_CODE = FActGroup
                                      AND    AGM_GROUP_CODE = ACG_GROUP_CODE ))
    AND   ity_inv_code    = afr_ity_inv_code
    AND   ity_road_characteristic = 'I'
    AND   ity_elec_drain_carr = NVL(FDiscipline,ity_elec_drain_carr)
    AND   ( Fasset IS NULL
    OR    ity_inv_code IN ( SELECT grp_value
                            FROM   gri_run_parameters
                            WHERE  grp_param  = 'INVENTORY_ITEM'
                            AND    grp_job_id = job_id))
    AND   INSTR(sysflags,ity_sys_flag)>0
    ORDER BY 1;
  CURSOR c8 IS
  -- was dtr_sys_flag
  -- was  and  instr(sysflags,dtr_sys_flag)>0
    SELECT '8,*,'      ||
           dtr_dty_acty_area_code||','||
           dtr_dty_defect_code   ||','||
           RPAD(dtr_tre_treat_code,4) rec
    FROM   def_treats
    WHERE  dtr_dty_acty_area_code IN
                 (SELECT DECODE(a.atv_maint_insp_flag
                               ,'S',dtr_dty_acty_area_code
                               ,DECODE(grp.grp_value
                                      ,NULL,dtr_dty_acty_area_code
                                      ,grp.grp_value))
                  FROM   activities a
                  ,      gri_run_parameters grp
                  WHERE  a.atv_acty_area_code(+) = grp.grp_value
                  AND    grp.grp_param = 'ACTIVITY'
                  AND    grp.grp_job_id = job_id )
    AND  (( NVL(FActGroup,'ALL')='ALL' )
    OR    dtr_dty_acty_area_code IN ( SELECT agm_acty_code
                                      FROM   ACTIVITY_GROUPS
                                      ,      ACT_GROUP_MEMBS
                                      WHERE  ACG_GROUP_CODE = FActGroup
                                      AND    AGM_GROUP_CODE = ACG_GROUP_CODE ))
    ORDER BY 1;
  CURSOR c9 IS
    SELECT '9,*,'||hco_code||','||replace(hco_meaning,',',':') rec
    FROM   hig_codes
    WHERE  hco_domain='DEFECT_RESPONSE_CAT'
    AND    hco_end_date IS NULL;
  CURSOR c11 IS
    SELECT '11,'||ity_sys_flag      ||','||
           ity_inv_code      ||','||
           REPLACE(ity_descr,',',':')||','||
           ity_pnt_or_cont       ||','||
           ity_x_sect_allow_flag     ||','||
           NVL(ity_contiguous,'N') rec
    FROM   inv_item_types
    WHERE  ity_road_characteristic = 'I'
    AND    ity_elec_drain_carr=NVL(FDiscipline,ity_elec_drain_carr)
    AND    ( FAsset IS NULL
    OR     ity_inv_code IN ( SELECT grp_value
                             FROM   gri_run_parameters
                             WHERE  grp_param  = 'INVENTORY_ITEM'
                             AND    grp_job_id = job_id))
    AND    ity_end_date IS NULL
    AND    INSTR(sysflags,ity_sys_flag)>0
    ORDER BY 1;
  CURSOR c12 IS
    SELECT '12,'||i.ita_ity_sys_flag           ||','||
           i.ita_iit_inv_code                  ||','||
           i.ita_disp_seq_no                   ||','||
           replace(i.ita_scrn_text,',',':')    ||','||
           DECODE(i.ita_format,'NUMBER','I','VARCHAR2','S','S')||','||
           i.ita_fld_length                    ||','||
           TO_CHAR(i.ita_dec_places)           ||','||
           i.ita_min                           ||','||
           i.ita_max                           ||','||
           i.ita_validate_yn                   ||','||
           i.ita_manditory_yn rec
    FROM   inv_type_attribs i
         , nm_inv_type_attribs n
         , inv_type_translations t
    WHERE  n.ita_inspectable = 'Y'
       AND n.ita_attrib_name = i.ita_attrib_name
       AND n.ita_inv_type = i.ita_iit_inv_code
       AND i.ita_iit_inv_code    = t.ity_inv_code
       AND t.ity_sys_flag = ita_ity_sys_flag
       AND INSTR(sysflags,ita_ity_sys_flag)>0
       AND i.ita_end_date IS NULL
       AND ( FAsset IS NULL
        OR ita_iit_inv_code IN ( SELECT grp_value
                                   FROM gri_run_parameters
                                  WHERE grp_param  = 'INVENTORY_ITEM'
                                    AND grp_job_id = job_id))
  ORDER BY 1;
  CURSOR c13 IS
    SELECT DISTINCT '13,'||iad_ita_ity_sys_flag||','||
           iad_ita_inv_code    ||','||
           ita_disp_seq_no     ||','||
           iad_value       ||','||
           replace(iad_meaning,',',':') rec
    FROM   inv_attri_domains
    ,      inv_type_attribs
    WHERE  iad_ita_attrib_name = ita_attrib_name
    AND    iad_ita_inv_code    = ita_iit_inv_code
    AND    ( FAsset IS NULL
    OR     iad_ita_inv_code IN ( SELECT grp_value
                                 FROM   gri_run_parameters
                                 WHERE  grp_param  = 'INVENTORY_ITEM'
                                 AND    grp_job_id = job_id))
    AND    iad_end_date IS NULL
    AND    INSTR(sysflags,iad_ita_ity_sys_flag)>0
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
CURSOR c15 IS
      SELECT DISTINCT '15,'||xsr_nw_type    ||','||
     xsr_scl_class       ||','||
     xsr_ity_inv_code    ||','||
     xsr_x_sect_value    ||','||
     replace(xsr_descr,',',':')    rec
      FROM  xsp_restraints
      WHERE (xsr_nw_type,xsr_scl_class) IN
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
   CURSOR c21 IS
      SELECT '21,*,'||oun_unit_code||','||replace(oun_name,',',':') rec
      FROM org_units
      WHERE oun_org_unit_type = 'NO'
      AND   oun_end_date IS NULL
      ORDER BY 1;
-- SM 713267 06102008
-- Cursor 21 and 22 were the original cursors which would return the list of organisations 
-- to the user.  This cursor is fine if the parameter ANSWER2 = 'N'.
-- If ANSWER2 = 'Y' then an additional restriction needed to be added to this 
-- cursor.  For ease, the cursors were copied and recreated as cursors c21a and c22a, and 
-- the restriction added.
    -- Organisation Details - admin unit restricted        
       CURSOR C21a IS
          SELECT '21,*,'||oun_unit_code||','||replace(oun_name,',',':') rec
          FROM  org_units
          WHERE oun_org_unit_type = 'NO'
          AND   oun_end_date IS NULL
          AND   OUN_ADMIN_ORG_ID in ( SELECT HAG_CHILD_ADMIN_UNIT
                                    FROM   HIG_ADMIN_GROUPS
                                    WHERE  HAG_DIRECT_LINK='Y'
                                    START WITH HAG_PARENT_ADMIN_UNIT = ( SELECT HUS_ADMIN_UNIT 
                                                                         FROM   HIG_USERS
                                                                         WHERE  HUS_USERNAME=USER )                                                                     
                                    CONNECT BY PRIOR HAG_CHILD_ADMIN_UNIT=HAG_PARENT_ADMIN_UNIT
                                    AND HAG_DIRECT_LINK='Y'
                                    UNION
                                    SELECT HUS_ADMIN_UNIT
                                    FROM HIG_USERS
                                    WHERE HUS_USERNAME=USER)
          ORDER BY 1;       
   CURSOR c22 IS
      SELECT '22,*,'||oun_unit_code||','||replace(oun_name,',',':') rec
      FROM org_units
      WHERE oun_org_unit_type = 'RE'
      AND   oun_end_date IS NULL
      ORDER BY 1;
       CURSOR C22a IS
          SELECT '22,*,'||oun_unit_code||','||replace(oun_name,',',':') rec
          FROM  org_units
          WHERE oun_org_unit_type = 'RE'
          AND   oun_end_date IS NULL
          AND   OUN_ADMIN_ORG_ID in ( SELECT HAG_CHILD_ADMIN_UNIT
                                    FROM   HIG_ADMIN_GROUPS
                                    WHERE  HAG_DIRECT_LINK='Y'
                                    START WITH HAG_PARENT_ADMIN_UNIT = ( SELECT HUS_ADMIN_UNIT 
                                                                         FROM   HIG_USERS
                                                                         WHERE  HUS_USERNAME=USER )                                                                     
                                    CONNECT BY PRIOR HAG_CHILD_ADMIN_UNIT=HAG_PARENT_ADMIN_UNIT
                                    AND HAG_DIRECT_LINK='Y'
                                    UNION
                                    SELECT HUS_ADMIN_UNIT
                                    FROM HIG_USERS
                                    WHERE HUS_USERNAME=USER)
          ORDER BY 1; 
   CURSOR c24 IS
      SELECT DISTINCT '24,*,'||d.dpr_priority||','||replace(hig.hco_meaning,',',':') rec
      FROM  defect_priorities d
       ,hig_codes     hig
       ,act_freqs     a
       ,inv_item_types    i
      WHERE hig.hco_domain       = 'DEFECT_PRIORITIES'
      AND   hco_end_date IS NULL
      AND   hig.hco_code     = d.dpr_priority
      AND   d.dpr_atv_acty_area_code = a.afr_atv_acty_area_code
      AND   decode(a.afr_ity_inv_code
      ,null,i.ity_inv_code
      ,'%%',i.ity_inv_code
      ,a.afr_ity_inv_code) = i.ity_inv_code
      AND   INSTR(sysflags,i.ity_sys_flag)>0
      AND   i.ity_road_characteristic = 'I'
      AND   i.ity_elec_drain_carr    = NVL(FDiscipline,i.ity_elec_drain_carr)
      ORDER BY 1;
   CURSOR c25 IS
      SELECT '25,*,'||hco_code||','||replace(hco_meaning,',',':') rec
      FROM hig_codes
      WHERE hco_domain = 'INITIATION_TYPE'
      AND   hco_end_date IS NULL
      ORDER BY 1;
   CURSOR c26 IS
      SELECT distinct '26,*,'||det.det_code||','||replace(det.det_name,',',':') rec
      FROM   doc_enquiry_types det
      ,      doc_types         dtp
      WHERE  det.det_end_date is null
      AND    det.det_dtp_code = dtp.dtp_code
      AND    dtp.dtp_end_date is null
      AND    dtp.dtp_allow_complaints = 'Y'
      ORDER BY 1;
   CURSOR c27 IS
      SELECT '27,*,'||hco_code||','||replace(hco_meaning,',',':') rec
      FROM hig_codes
      WHERE hco_domain = 'COMPLAINT_SOURCE'
      AND   hco_end_date IS NULL
      ORDER BY 1;
-- Document Category details.
   CURSOR c28 IS
      SELECT '28,*,'||hco_code||','||replace(hco_meaning,',',':') rec
      FROM hig_codes
      WHERE hco_domain = 'DOC_CATEGORIES'
      AND   hco_end_date IS NULL
      ORDER BY 1;
-- Surface Condition details
   CURSOR c29 IS
      SELECT '29,*,'||hco_code||','||replace(hco_meaning,',',':') rec
      FROM hig_codes
      WHERE hco_domain = 'SURFACE_CONDITION'
      AND   hco_end_date IS NULL
      ORDER BY 1;
-- Weather Condition details
   CURSOR c30 IS
      SELECT '30,*,'||hco_code||','||replace(hco_meaning,',',':') rec
      FROM hig_codes
      WHERE hco_domain = 'WEATHER_CONDITION'
      AND   hco_end_date IS NULL
      ORDER BY 1;
-- sscanlon fix 700407 12SEP2007
-- Cursor 31 was the original cursor which would return the list of inspectors 
-- to the user.  This cursor is fine if the parameter ANSWER2 = 'N'.
-- If ANSWER2 = 'Y' then an additional restriction needed to be added to this 
-- cursor.  For ease, the cursor was copied and recreated as cursor C31a, and 
-- the restriction added.
-- See top of package body code for problem description 
    -- Inspector Details - no admin unit restriction 
       CURSOR c31 IS
          /*SELECT '31,*,'||hus_initials||','||replace(hus_name,',',':') rec
          FROM  hig_users
          WHERE hus_job_title='INSP'
          AND   hus_end_date IS NULL
          ORDER BY 1;*/
          -- Added 21-Sep-07 by MJA
          -- Product option EDIFDLROLE shipped to allow restriction by
          -- role entered in here for users else allow all users
          -- Changes included in the c31a cursor too
          SELECT '31,*,'||hus_initials||','||replace(hus_name,',',':') rec
          FROM  hig_users
          WHERE hus_end_date IS NULL
          AND  (hig.get_sysopt('EDIFDLROLE') Is Null     
           OR   hus_username IN (Select hur_username
                                 From   hig_user_roles
                                 Where  hur_role = hig.get_sysopt('EDIFDLROLE')
                                )
               )
          ORDER BY 1;
    -- Inspector Details - restricted by users admin unit       
       CURSOR C31a IS
          SELECT '31,*,'||hus_initials||','||replace(hus_name,',',':') rec
          FROM  hig_users
          --WHERE hus_job_title  = 'INSP'
          WHERE hus_end_date IS NULL
          AND  (hig.get_sysopt('EDIFDLROLE') Is Null     
           OR   hus_username IN (Select hur_username
                                 From   hig_user_roles
                                 Where  hur_role = hig.get_sysopt('EDIFDLROLE')
                                )
               )
          AND   hus_admin_unit in ( SELECT HAG_CHILD_ADMIN_UNIT
                                    FROM   HIG_ADMIN_GROUPS
                                    WHERE  HAG_DIRECT_LINK='Y'
                                    START WITH HAG_PARENT_ADMIN_UNIT = ( SELECT HUS_ADMIN_UNIT 
                                                                         FROM   HIG_USERS
                                                                         WHERE  HUS_USERNAME=USER )                                                                     
                                    CONNECT BY PRIOR HAG_CHILD_ADMIN_UNIT=HAG_PARENT_ADMIN_UNIT
                                    AND HAG_DIRECT_LINK='Y'
                                    UNION
                                    SELECT HUS_ADMIN_UNIT
                                    FROM HIG_USERS
                                    WHERE HUS_USERNAME=USER)
          ORDER BY 1;
-- end of sscanlon fix 709407 12SEP2007  
--     
-- Standard Item Sections
   CURSOR c32 IS
     SELECT '32,*,'||sis_id  ||','||
      REPLACE(sis_name,',') rec
      FROM   standard_item_sections
      WHERE  sis_end_date IS NULL
      AND    sis_id > '0'
      ORDER BY 1;
-- Standard Item Sub Sections
   CURSOR c33 IS
      SELECT '33,*,'||siss_sis_id  ||','||
      siss_id      ||','||
      REPLACE(siss_name,',') rec
      FROM     standard_item_sub_sections
      WHERE siss_end_date IS NULL
      AND EXISTS
       ( SELECT 'exists'
     FROM    standard_items sta
     WHERE   sta.sta_siss_id = siss_id )
      AND     siss_id > '0'
      ORDER BY 1;
-- Inventory Hierarchy details
   CURSOR c34 IS
      SELECT '34,*,'||sta_siss_id       ||','||
      sta_item_code     ||','||
      REPLACE(sta_item_name,',')||','||
      sta_unit      ||','||
      TO_CHAR(sta_min_quantity) ||','||
      TO_CHAR(sta_max_quantity) ||','||
      sta_dim1_text     ||','||
      sta_dim2_text     ||','||
      sta_dim3_text rec
      FROM     standard_items
      WHERE    NVL(sta_dcd_flag,'Y')='Y'
      AND      sta_end_date   IS NULL
      AND      sta_item_code > '0'
      ORDER BY 1;
-- SM 10122008 709893      
-- Changed cursor 35, 36 and 37 to use v3 tables rather than translation views.
   CURSOR c35 IS
    SELECT '35,*,'||LPAD(TO_CHAR(iit_item_id),iit_id_pad) ||','||
                    LPAD(TO_CHAR(iit_rse_he_id),rse_pad)  ||','||
                    iit_ity_inv_code                      ||','||
                    iit_primary_key                       ||','||
                    iit_foreign_key                       ||','||
                    LPAD(TO_CHAR(iit_st_chain),chain_pad) ||','||
                    LPAD(TO_CHAR(iit_end_chain),chain_pad)||','||
                    iit_x_sect                            ||','||
                    replace(iit_note,',',':') rec
      FROM  inv_items
       ,inv_item_types
      WHERE iit_ity_inv_code    = ity_inv_code
      AND   iit_ity_sys_flag    = ity_sys_flag
      AND   ity_road_characteristic = 'I'
      AND   ity_elec_drain_carr = NVL(FDiscipline,ity_elec_drain_carr)
      AND   ( FAsset IS NULL
      OR ity_inv_code IN ( SELECT grp_value
                           FROM   gri_run_parameters
                           WHERE  grp_param  = 'INVENTORY_ITEM'
                           AND    grp_job_id = job_id))
      AND   ( FGroup IS NULL
      OR      iit_rse_he_id IN ( SELECT nm_ne_id_of
                                 FROM   nm_members_all
                                 WHERE  nm_end_date IS NULL
                                 AND nm_type = 'G'
                                 AND DECODE (get_nt_type (nm_ne_id_of), 'D', 'S', 'L', 'S', 'G') <> 'P'
                                 CONNECT BY PRIOR nm_ne_id_of = nm_ne_id_in
                                 START WITH nm_ne_id_in       = FGroup))
      AND   ( FXsp IS NULL
      OR EXISTS ( SELECT grp_value
                  FROM   gri_run_parameters
                  WHERE  grp_value  = NVL(iit_x_sect, grp_value)
                  AND    grp_param  = 'XSP'
                  AND    grp_job_id = job_id ))
      ORDER BY 1;
-- Inspection Network details
   CURSOR c36(he_id IN road_segs.rse_he_id%TYPE)
   IS 
   SELECT '36,*,'||LPAD(TO_CHAR(ne.ne_id),rse_pad)||',' 
    ||LPAD(DECODE (DECODE (ne.ne_gty_group_type,
              'LLNK', 'Y',
              'DLNK', 'Y',
              NULL, 'Y',
              'N'),
           'Y',
           ne.ne_owner,
           NULL
   ),4)||','
    ||DECODE (DECODE (ne.ne_gty_group_type,
              'LLNK', 'Y',
              'DLNK', 'Y',
              NULL, 'Y',
              'N'),
           'Y',
           ne.ne_sub_type || ne.ne_name_1,
           NULL
   )||','
    ||DECODE (ne.ne_gty_group_type, NULL, ne.ne_number, NULL)||',' 
    ||ne.ne_sub_class||','
    ||REPLACE(ne.ne_descr,',',':')||','
    ||LPAD(TO_CHAR(DECODE (ne.ne_gty_group_type, NULL, get_ne_length (ne.ne_id), NULL)),chain_pad)||',' 
    ||SUBSTR (iit_chr_attrib41, 1, 1)||','
    ||SUBSTR (iit_chr_attrib51, 1, 1) rec 
      FROM  nm_elements_all ne,nm_nw_ad_link_all nad,nm_inv_items_all iit
      WHERE ne.ne_id = he_id
      AND   ne.ne_end_date IS NULL
      AND ne.ne_id = nad.nad_ne_id(+)
         AND nad.nad_iit_ne_id = iit.iit_ne_id(+)
         AND nad.nad_primary_ad(+) = 'Y';
--
-- Section Id and Activity details
   CURSOR c37 IS
      SELECT '37,*,'||TO_CHAR(ne.ne_id)||','
    ||afr.afr_atv_acty_area_code rec
      FROM  nm_elements_all ne
       ,act_freqs afr
       ,nm_inv_items_all iit
       ,nm_nw_ad_link_all nad
       ,nm_elements_all linkcode
      WHERE afr.afr_atv_acty_area_code IN
                 ( SELECT DECODE(a.atv_maint_insp_flag
                                ,'S',afr.afr_atv_acty_area_code
                                ,DECODE(grp.grp_value
                                       ,NULL,afr.afr_atv_acty_area_code
                                       ,grp.grp_value))
                   FROM   activities a
                   ,      gri_run_parameters grp
                   WHERE  a.atv_acty_area_code(+) = grp.grp_value
                   AND    grp.grp_param = 'ACTIVITY'
                   AND    grp.grp_job_id = job_id)
      AND  (( NVL(FActGroup,'ALL')='ALL' )
      OR    afr.afr_atv_acty_area_code IN ( SELECT agm_acty_code
                                            FROM   ACTIVITY_GROUPS
                                            ,      ACT_GROUP_MEMBS
                                            WHERE  ACG_GROUP_CODE = FActGroup
                                            AND    AGM_GROUP_CODE = ACG_GROUP_CODE ))
       AND   afr.afr_ity_sys_flag     = ne.ne_prefix
       AND   afr.afr_scl_sect_class   = ne.ne_sub_class
       AND   afr.afr_road_environment = SUBSTR (iit_chr_attrib41, 1, 1)
       AND   ne.ne_id IN ( SELECT nm.nm_ne_id_of
                                FROM   nm_members_all nm
                                WHERE  nm_type = 'G'
                                AND DECODE (get_nt_type (nm_ne_id_of), 'D', 'S', 'L', 'S', 'G') <> 'P'   
                                AND nm.nm_end_date IS NULL
                                CONNECT BY PRIOR nm.nm_ne_id_of = nm.nm_ne_id_in
                                START WITH nm.nm_ne_id_in       = FGroup )
       AND ne.ne_id = nad.nad_ne_id(+)
       AND nad.nad_iit_ne_id = iit.iit_ne_id(+)
       AND nad.nad_primary_ad(+) = 'Y'
       AND ne.ne_name_2 = linkcode.ne_unique(+)                                
      ORDER BY 1;
   --
   CURSOR c38 IS
      SELECT  rsm_rse_he_id_of section
      FROM    road_seg_membs
      WHERE   rsm_end_date IS NULL
      AND     rsm_type='S'
      CONNECT BY PRIOR rsm_rse_he_id_of  = rsm_rse_he_id_in
      START   WITH rsm_rse_he_id_in      = FGroup
      ORDER   BY Inspection_Order(rsm_rse_he_id_in
     ,rsm_rse_he_id_of);
    --
    -- Obtain the file extension from the GRI_MODULES table for the
    -- selected module.
    --
    CURSOR file_extension
    IS SELECT grm_file_type
       FROM   gri_modules
       WHERE  grm_module=v_module;
    --
    -- Retrieve the initials for the user to insert before the filename
    -- so that filename's are specific to users
    --
    CURSOR get_name IS
       SELECT hus_initials
       FROM hig_users
       WHERE hus_username = USER;
--
-- Added to check if module was run from a web client
--
    CURSOR get_UI IS
      SELECT grr_mode
      FROM   gri_report_runs
      WHERE  grr_job_id = job_id;
--
    lc_ui VARCHAR2(15);
    --
    cursor c_def_attr is
     select dty_hh_attribute_1||','||replace(dty_hh_attri_text_1,',',':') d_attr_text
     from   def_types
     where  dty_hh_attribute_1 is not null
     union
     select dty_hh_attribute_2||','||replace(dty_hh_attri_text_2,',',':')
     from   def_types
     where  dty_hh_attribute_2 is not null
     union
     select dty_hh_attribute_3||','||replace(dty_hh_attri_text_3,',',':')
     from   def_types
     where  dty_hh_attribute_3 is not null
     union
     select dty_hh_attribute_4||','||replace(dty_hh_attri_text_4,',',':')
     from   def_types
     where  dty_hh_attribute_4 is not null;
--
BEGIN
  --
  -- Obtain the specified file name and location
  --
  IF   FSeq IS NULL
  THEN FSeq:=GetFileSeq;
  END IF;
  --
  OPEN  file_extension;
  FETCH file_extension INTO FFileext;
  IF file_extension%notfound
  THEN FFileext:='.lis';
       CLOSE file_extension;
  ELSE CLOSE file_extension;
  END IF;
  v_filename:=TO_CHAR(FSeq)||'.'||FFileext;
  /*
  || Note: For general use witht he GRI it would be best if the filename
  ||       was derived as above, however, the Survey+ software requires that
  ||       the file is called a specific name and so we have had to hard code
  ||       the filename.
  ||
  */
  v_filename:='SURVEYP.ped';
  --
  -- Code added to check if module was run via a Web client
  --
  OPEN get_ui;
  FETCH get_ui
  INTO  lc_ui;
  CLOSE get_ui;
  --
  IF NVL(lc_ui,'WIN32') !='WEB' THEN
    v_filename:='SURVEYP.ped';
    -- Powys require that a file name be specific to a user so put the initials before
    -- the file name
    OPEN  get_name;
    FETCH get_name INTO user_init;
    CLOSE get_name;
    
    -- sscanlon fix 709407 12SEP2007 
    -- If the value of FFile (obtained from user option PEDFILE) is populated 
    -- then it should be used, otherwise (for customers who don't wish to define 
    -- a default filename) the current filename should be used. 
    -- See top of package body code for problem description 
       v_filename := nvl(FFile,user_init||v_filename);
    -- end of sscanlon fix 709407 12SEP2007
    
    IF  NOT FileExists(FDest,v_Filename)
    THEN create_file(FDest,v_filename,StartLine);
    ELSE create_file(FDest,v_filename,Startline);  -- [HB]: Overwrite the file anyway
       -- dbms_output.put_line('Info: The file '||FDest||'\'||v_filename||' exists - '||fn);
       -- if   is_open(Output_File)
       --      then dbms_output.put_line('Info: The file exists and is open - '||fn);
       -- end if;
    END IF;
  ELSE
  
    -- sscanlon fix 709407 12SEP2007 
    -- If the value of FFile (obtained from user option PEDFILE) is populated 
    -- then it should be used, otherwise (for customers who don't wish to define 
    -- a default filename) the current filename should be used. 
    -- See top of package body code for problem description   
       v_filename := nvl(FFILE,TO_CHAR(job_id)||'.'||FFileext);
    -- end of sscanlon fix 709407 12SEP2007
           
    IF  NOT FileExists(FDest,v_Filename)    THEN
      create_file(FDest,v_filename,StartLine);
    ELSE
      create_file(FDest,v_filename,Startline); -- [HB]: Overwrite the file anyway
       -- dbms_output.put_line('Info: The file '||FDest||'\'||v_filename||' exists - '||fn);       -- if   is_open(Output_File)       --      then dbms_output.put_line('Info: The file exists and is open - '||fn);       -- end if;    END IF;
    END IF;
  END IF;
  -- Obtain distinct system flags ( D,L )
  FOR i_rec IN c38 LOOP
    FOR j_rec IN c1(i_rec.section)
    LOOP IF   NVL(INSTR(sysflags,j_rec.rse_sys_flag),0)=0
     THEN sysflags:=sysflags||','||''''||j_rec.rse_sys_flag||'''';
     END IF;
    END LOOP;
    -- sysflags:=substr(sysflags,2,(length(sysflags)-1));
  END LOOP;
  /* populate pl/sql table with defect attribute descriptions */
  for def_rec in c_def_attr loop
    l_count_def_attr := l_count_def_attr + 1;
    def_attr_rec(l_count_def_attr) := def_rec.d_attr_text;
  end loop;
  /* fetch in values from all cursors */
  FOR i_rec IN c2 LOOP
      rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c3 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c4 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec in 1..l_count_def_attr LOOP
    rec_count := rec_count + 1;
      SELECT  '5,*,'||to_char(i_rec)||','||
       substr(def_attr_rec(i_rec),instr(def_attr_rec(i_rec),',',1)+1)||','||
       decode(data_type,'VARCHAR2','S','NUMBER','I')||','||
       decode(data_type,'VARCHAR2',data_length,'NUMBER',data_precision)||','||
       data_scale  rec
      INTO  cursor_recs(rec_count)
      FROM  user_tab_columns
      WHERE column_name = substr(def_attr_rec(i_rec),1,instr(def_attr_rec(i_rec),',',1)-1)
      AND   table_name='DEFECTS'
      ORDER BY 1;
  END LOOP;
  FOR i_rec IN c6 LOOP
    rec_count := rec_count + 1;
       cursor_recs(rec_count) := i_rec.rec;
      IF i_rec.attr_1 != ',' THEN
    FOR i IN 1..l_count_def_attr LOOP
      IF def_attr_rec(i) = i_rec.attr_1 THEN
    cursor_recs(rec_count) := cursor_recs(rec_count)||to_char(i)||',';
      END IF;
    END LOOP;
      ELSE
    cursor_recs(rec_count) := cursor_recs(rec_count)||'0,';
      END IF;
      IF i_rec.attr_2 != ',' THEN
    FOR i IN 1..l_count_def_attr LOOP
      IF def_attr_rec(i) = i_rec.attr_2 THEN
    cursor_recs(rec_count) := cursor_recs(rec_count)||to_char(i)||',';
      END IF;
    END LOOP;
      ELSE
    cursor_recs(rec_count) := cursor_recs(rec_count)||'0,';
      END IF;
      IF i_rec.attr_3 != ',' THEN
    FOR i IN 1..l_count_def_attr LOOP
      IF def_attr_rec(i) = i_rec.attr_3 THEN
    cursor_recs(rec_count) := cursor_recs(rec_count)||to_char(i)||',';
      END IF;
    END LOOP;
      ELSE
    cursor_recs(rec_count) := cursor_recs(rec_count)||'0,';
      END IF;
      IF i_rec.attr_4 != ',' THEN
    FOR i IN 1..l_count_def_attr LOOP
      IF def_attr_rec(i) = i_rec.attr_4 THEN
    cursor_recs(rec_count) := cursor_recs(rec_count)||to_char(i);
      END IF;
    END LOOP;
      ELSE
    cursor_recs(rec_count) := cursor_recs(rec_count)||'0';
      END IF;
  END LOOP;
  FOR i_rec IN c7 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c8 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
    FOR i_rec IN c9 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c11 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c12 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
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
  if FAunit='N' then
    FOR i_rec IN c21 LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  else
    FOR i_rec IN c21a LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  end if;
  if FAunit='N' then
    FOR i_rec IN c22 LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  else
    FOR i_rec IN c22a LOOP
      rec_count := rec_count + 1;
      cursor_recs(rec_count) := i_rec.rec;
    END LOOP;
  end if;
-- end SM 713267 06102008  
  FOR i_rec IN c24 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c25 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c26 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c27 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c28 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c29 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
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
      if FAunit='N'
      then FOR i_rec IN c31   -- Unrestricted 
           LOOP rec_count := rec_count + 1;
                cursor_recs(rec_count) := i_rec.rec;
           END LOOP;
      else FOR i_rec IN c31a  -- Restricted by Admin Unit
           LOOP rec_count := rec_count + 1;
                cursor_recs(rec_count) := i_rec.rec;
           END LOOP;
      end if;
  --end of sscanlon fix 709407 12SEP2007 
  
  FOR i_rec IN c32 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c33 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  FOR i_rec IN c34 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  IF FHeir='Y'
  THEN FOR i_rec IN c35 LOOP
       rec_count := rec_count + 1;
       cursor_recs(rec_count) := i_rec.rec;
       END LOOP;
  FOR i_rec IN c38 LOOP
      FOR j_rec IN c36(i_rec.section)
      LOOP rec_count := rec_count + 1;
      cursor_recs(rec_count) := j_rec.rec;
      END LOOP;
  END LOOP;
  FOR i_rec IN c37 LOOP
    rec_count := rec_count + 1;
    cursor_recs(rec_count) := i_rec.rec;
  END LOOP;
  END IF;
  /* all records in the table now write them out to the file */
  IF (debug) THEN
    dbms_output.put_line(rec_count||' record(s) loaded');
  END IF;
 --
  FOR i IN 1..rec_count LOOP
    IF   NOT writeln(File_Handle,cursor_recs(i))
    THEN dbms_output.put_line('Info: Problem writing to output file.');
    END  IF;
  END LOOP;
 --
  RETURN TRUE;
  EXCEPTION
    WHEN utl_file.invalid_operation
    THEN dbms_output.put_line('Error: An invalid operation occured - '||fn);
     RETURN FALSE;
    WHEN utl_file.invalid_path
    THEN dbms_output.put_line('Error: An invalid path error occured - '||fn);
     RETURN FALSE;
    WHEN utl_file.read_error
    THEN dbms_output.put_line('Error: A read error occured on the specified file - '||fn);
     RETURN FALSE;
    WHEN utl_file.write_error
    THEN dbms_output.put_line('Error: Cannot write to the specified file - '||fn);
     RETURN FALSE;
    WHEN utl_file.internal_error
    THEN dbms_output.put_line('Error: An internal error was found - '||fn);
     RETURN FALSE;
    WHEN utl_file.invalid_filehandle
    THEN dbms_output.put_line('Error: The specified file handle does not identify a valid file -
{ProcessWorkRecords}');
     RETURN FALSE;
    WHEN utl_file.invalid_mode
    THEN dbms_output.put_line('Error: Invalid mode - '||fn);
     RETURN FALSE;
    WHEN INVALID_NUMBER
    THEN dbms_output.put_line('Error: Invalid number exception raised - '||fn);
     RETURN FALSE;
    WHEN VALUE_ERROR
    THEN dbms_output.put_line('Error: Value error exception raised - '||fn);
     RETURN FALSE;
    WHEN OTHERS
    THEN dbms_output.put_line(SQLERRM||' '||fn);
       IF is_open(Output_File)
       THEN utl_file.fclose(Output_File);
       END IF;
       IF is_open(File_Handle)
       THEN utl_file.fclose(File_Handle);
       END IF;
       RETURN FALSE;
END;
-- *****************************************************************************
-- This is where the real processing starts
-- *****************************************************************************
PROCEDURE Main( job_id IN NUMBER)
IS
  start_time   BINARY_INTEGER;
  end_time     BINARY_INTEGER;
  tot_time     BINARY_INTEGER;
  TRACE_ON     BOOLEAN:=FALSE;
BEGIN
  IF trace_on
  THEN dbms_session.set_sql_trace(trace_on);
  END IF;
  -- [HB]: Display the current version of the module
  dbms_output.put_line('Version: '||g_sccsid);
  dbms_output.put_line('.');
  --
  IF debug
  THEN dbms_output.enable(1000000);
       start_time:=dbms_utility.get_time;
       dbms_output.put_line('Start Time : '||TO_CHAR(start_time));
  END IF;
  --
  get_params( job_id );
  --
  IF NOT ProcessPedif(job_id)
  THEN dbms_output.put_line('Error: Pedif file generation failed - {Main}');
  ELSE dbms_output.put_line('Info : The following file has been generated : ');
       dbms_output.put_line('.');
       dbms_output.put_line('Directory : '||FDest);
       dbms_output.put_line('File      : '||v_filename);
  END IF;
  -- close the file if it is still open
  IF (is_open(File_handle)) THEN
       utl_file.fclose(File_Handle);
  END IF;
  IF trace_on
  THEN dbms_session.set_sql_trace(trace_on);
  END IF;
END;
END Pedif;
/

