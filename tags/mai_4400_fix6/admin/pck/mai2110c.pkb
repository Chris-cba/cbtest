CREATE OR REPLACE PACKAGE BODY mai2110c
AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid                 : $Header:   //vm_latest/archives/mai/admin/pck/mai2110c.pkb-arc   2.5.1.0   May 10 2012 11:21:48   Mike.Huitson  $
--       Module Name      : $Workfile:   mai2110c.pkb  $
--       Date into PVCS   : $Date:   May 10 2012 11:21:48  $
--       Date fetched Out : $Modtime:   May 10 2012 11:01:46  $
--       PVCS Version     : $Revision:   2.5.1.0  $
--       Based on SCCS version :
--
--
--   Author : M Huitson.
--
--   mai2110c body
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2006
-----------------------------------------------------------------------------
--
--all global package variables here

  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '"$Revision:   2.5.1.0  $"';

  g_package_name CONSTANT varchar2(30) := 'mai2110c';
  --
  g_admin_unit   NUMBER;
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
PROCEDURE set_attrib_values(po_attr_err OUT PLS_INTEGER) IS
  --
  lt_attr_recs attr_rec_tab;
  --
  

  FUNCTION return_date_format(pi_inv_type       IN hhinv_load_3.inv_code%TYPE
                             ,pi_attribute      IN hhinv_load_3.attribute%TYPE
                             ,pi_value          IN hhinv_load_3.value%TYPE
                             ,pi_default_format IN varchar2 DEFAULT 'RRMMDD')
  RETURN nm_inv_type_attribs_all.ita_format_mask%TYPE IS
    l_retval nm_inv_type_attribs_all.ita_format_mask%TYPE := pi_default_format;
    l_date   DATE;
  BEGIN
    /*
    || Atttempt To Convert Value To Default Format
    || If This Fails Then Use The Inv Code And Attribute To Find The Format Mask
    || If There Isnt One Fail, If There Is One Convert The Value Using It
    || If This Fails Then We Are Out Of Options So Fail.
    */
    BEGIN
      --
      l_date := TO_DATE(pi_value, pi_default_format);
      --
    EXCEPTION
      WHEN OTHERS THEN
        /*
        || Look Up The Format Mask.
        */
        l_retval := nm3inv.get_inv_type_attr(pi_inv_type    => mai.translate_mai_inv_type(pi_inv_type)
                                            ,pi_attrib_name => 'IIT_'||pi_attribute).ita_format_mask;
        IF l_retval IS NULL THEN
          RAISE;
        END IF;
        /*
        || Attempt To Convert Using l_retval
        || Exceptions For This Are Allowed To Propogate
        */
        l_date := TO_DATE(pi_value, l_retval);
    END;
    RETURN l_retval;
  END return_date_format;
  --
  PROCEDURE upd_num_attr(pi_rec_seq_no IN hhinv_load_3.rec_seq_no%TYPE
                        ,pi_attribute  IN hhinv_load_3.attribute%TYPE
                        ,pi_value      IN hhinv_load_3.value%TYPE) IS
    --
    lv_string   VARCHAR2(1000);
    lv_attr_val NUMBER;
    --
  BEGIN
    --
    lv_attr_val := TO_NUMBER(pi_value);
    --
    lv_string := 'BEGIN'
      ||CHR(10)||'  UPDATE hhinv_load_3'
      ||CHR(10)||'     SET '||pi_attribute||' = '||to_char(lv_attr_val)
      ||CHR(10)||'   WHERE rec_seq_no = '||to_char(pi_rec_seq_no)
      ||CHR(10)||'     AND attribute  = '||nm3flx.string(pi_attribute)
      ||CHR(10)||'       ;'
      ||CHR(10)||'END;'
    ;
    EXECUTE IMMEDIATE lv_string;
    --
  END upd_num_attr;
  --
  PROCEDURE upd_date_attr(pi_rec_seq_no IN hhinv_load_3.rec_seq_no%TYPE
                         ,pi_inv_code   IN hhinv_load_3.inv_code%TYPE
                         ,pi_attribute  IN hhinv_load_3.attribute%TYPE
                         ,pi_value      IN hhinv_load_3.value%TYPE) IS
    --
    lv_string   VARCHAR2(1000);
    lv_attr_val DATE;
    lv_format   nm_inv_type_attribs_all.ita_format_mask%TYPE := 'RRMMDD';
    --
  BEGIN
    --

    lv_format := return_date_format(pi_inv_type       => pi_inv_code
                                   ,pi_attribute      => pi_attribute
                                   ,pi_value          => pi_value
                                   ,pi_default_format => lv_format);
    lv_attr_val := TO_DATE(pi_value,lv_format);
    --
    lv_string := 'BEGIN'
      ||CHR(10)||'  UPDATE hhinv_load_3'
      ||CHR(10)||'     SET '||pi_attribute||' = TO_DATE('||nm3flx.string(pi_value)||','
                                                         ||nm3flx.string(lv_format)||')'
      ||CHR(10)||'   WHERE rec_seq_no = '||to_char(pi_rec_seq_no)
      ||CHR(10)||'     AND attribute  = '||nm3flx.string(pi_attribute)
      ||CHR(10)||'       ;'
      ||CHR(10)||'END;'
    ;
    EXECUTE IMMEDIATE lv_string;
    --
  END upd_date_attr;
  --
  PROCEDURE upd_char_attr(pi_rec_seq_no IN hhinv_load_3.rec_seq_no%TYPE
                         ,pi_attribute  IN hhinv_load_3.attribute%TYPE
                         ,pi_value      IN hhinv_load_3.value%TYPE) IS
    --
    lv_string   VARCHAR2(1000);
    --
  BEGIN
    --
    lv_string := 'BEGIN'
      ||CHR(10)||'  UPDATE hhinv_load_3'
      ||CHR(10)||'     SET '||pi_attribute||' = '||nm3flx.string(pi_value)
      ||CHR(10)||'   WHERE rec_seq_no = '||to_char(pi_rec_seq_no)
      ||CHR(10)||'     AND attribute  = '||nm3flx.string(pi_attribute)
      ||CHR(10)||'       ;'
      ||CHR(10)||'END;'
    ;
    EXECUTE IMMEDIATE lv_string;
    --
  END upd_char_attr;
  --
  PROCEDURE flag_attr_error(pi_rec_seq_no IN hhinv_load_3.rec_seq_no%TYPE
                           ,pi_attribute  IN hhinv_load_3.attribute%TYPE
                           ,pi_error      IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    --
    UPDATE hhinv_load_3
       SET error_flg = 'Y'
          ,error_msg = pi_error
     WHERE rec_seq_no = pi_rec_seq_no
       AND attribute  = pi_attribute
         ;
    --
    COMMIT;
    --
  END flag_attr_error;
  --
BEGIN
  /*
  || Initialise Output Error Indicator.
  */
  po_attr_err := 0;
  --
  SELECT rec_seq_no
        ,inv_code
        ,attribute
        ,value
        ,nm3flx.get_column_datatype('HHINV_LOAD_3',attribute) datatype
    BULK COLLECT
    INTO lt_attr_recs
    FROM hhinv_load_3
   WHERE VALUE IS NOT NULL
     AND ERROR_FLG IS NULL
       ;
  --
  FOR i IN 1 .. lt_attr_recs.count LOOP
    --
    BEGIN
      --
      IF lt_attr_recs(i).datatype = 'NUMBER'
       THEN
          upd_num_attr(lt_attr_recs(i).rec_seq_no
                      ,lt_attr_recs(i).attribute
                      ,lt_attr_recs(i).value);
      ELSIF lt_attr_recs(i).datatype = 'DATE'
       THEN
          upd_date_attr(lt_attr_recs(i).rec_seq_no
                       ,lt_attr_recs(i).inv_code
                       ,lt_attr_recs(i).attribute
                       ,lt_attr_recs(i).value);
      ELSE
          upd_char_attr(lt_attr_recs(i).rec_seq_no
                       ,lt_attr_recs(i).attribute
                       ,lt_attr_recs(i).value);
      END IF;
      --
    EXCEPTION
      WHEN OTHERS
       THEN
          po_attr_err := 1;
          flag_attr_error(lt_attr_recs(i).rec_seq_no
                         ,lt_attr_recs(i).attribute
                         ,SQLERRM);
    END;
    --
  END LOOP;
  --
END set_attrib_values;
--
-----------------------------------------------------------------------------
--
PROCEDURE check_ukp_overlap
  IS
BEGIN
  /*
  ||Check For Overlaps Based On Specific UKPMS Rules.
  ||
  ||NB: The inline views v1 and v2 are the same so any changes
  ||    required should be made to both!
  */
  UPDATE hhinv_load_3
     SET error_flg = 'Y'
        ,error_msg = DECODE(error_msg,NULL,'Invalid defect overlap.'
                                          ,error_msg||' + Invalid defect overlap.')
   WHERE attribute = 'CHR_ATTRIB26'
     AND rec_seq_no IN(SELECT CASE
                              WHEN level_col = 1
                               THEN v1_rec_seq
                              WHEN level_col = 2
                               THEN v2_rec_seq
                              END v_seq_no
                         FROM (SELECT v1.rec_seq_no v1_rec_seq
                                     ,v2.rec_seq_no v2_rec_seq
                                 FROM (SELECT rec_seq_no
                                             ,he_id
                                             ,inv_code
                                             ,st_chain
                                             ,end_chain
                                             ,MAX(CASE WHEN attribute = 'CHR_ATTRIB26'
                                                       THEN value
                                                   END) defect_type
                                             ,MAX(CASE WHEN attribute = 'DET_XSP'
                                                       THEN NVL(value,x_sect)
                                                   END) det_xsp
                                         FROM hhinv_load_3
                                        WHERE attribute IN('CHR_ATTRIB26','DET_XSP')
                                          AND inv_code IN(SELECT uvd_inv_code
                                                            FROM ukpms_view_definitions
                                                           WHERE uvd_ukpms_code in ('CVI','DVI') )
                                        GROUP
                                           BY rec_seq_no
                                             ,he_id
                                             ,inv_code
                                             ,st_chain
                                             ,end_chain) v1
                                     ,(SELECT rec_seq_no
                                             ,he_id
                                             ,inv_code
                                             ,st_chain
                                             ,end_chain
                                             ,MAX(CASE WHEN attribute = 'CHR_ATTRIB26'
                                                       THEN value
                                                   END) defect_type
                                             ,MAX(CASE WHEN attribute = 'DET_XSP'
                                                       THEN NVL(value,x_sect)
                                                   END) det_xsp
                                         FROM hhinv_load_3
                                        WHERE attribute IN('CHR_ATTRIB26','DET_XSP')
                                          AND inv_code IN(SELECT uvd_inv_code
                                                            FROM ukpms_view_definitions
                                                           WHERE uvd_ukpms_code in ('CVI','DVI') )
                                        GROUP
                                           BY rec_seq_no
                                             ,he_id
                                             ,inv_code
                                             ,st_chain
                                             ,end_chain) v2
                                WHERE v1.defect_type IN('BNAS','BUTS')
                                  AND v1.defect_type != v2.defect_type
                                  AND v1.he_id = v2.he_id
                                  AND v1.det_xsp = v2.det_xsp
                                  AND ((v1.st_chain = v2.st_chain and v1.end_chain = v2.end_chain)
                                       or
                                       (v1.st_chain > v2.st_chain and v1.st_chain < v2.end_chain)
                                       or
                                       (v1.end_chain > v2.st_chain and v1.end_chain < v2.end_chain)
                                       or
                                       (v1.st_chain <= v2.st_chain and v1.end_chain >= v2.end_chain))) inv_view
  		                       ,(SELECT level level_col
                                 FROM dual
                              CONNECT
                                   BY level <= 2) count_view)
        ;
  --
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE ins_assets(pi_run_num   IN  hhinv_sect_log.lst_run_num%TYPE
                    ,po_rec_count OUT PLS_INTEGER
                    ,po_sect_err  OUT PLS_INTEGER) IS
  --
  TYPE he_id_tab IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
  lt_he_id he_id_tab;
  --
  lv_effective_date DATE;
  lv_sect_error     BOOLEAN;
  lv_sect_count     PLS_INTEGER;
  --
  dml_errors EXCEPTION;
  PRAGMA exception_init(dml_errors,-24381);
  -------------------------------------------------------------------------------
  PROCEDURE flag_error(pi_table  IN VARCHAR2
                      ,pi_seq_no IN NUMBER
                      ,pi_error  IN VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    --
    lv_sect_error := TRUE;
    --
    IF pi_table = 'HHINV_LOAD_3'
     THEN
        UPDATE hhinv_load_3
           SET error_flg = 'Y'
              ,error_msg = pi_error
         WHERE rec_seq_no = pi_seq_no
             ;
    ELSIF pi_table = 'HHINV_LOAD_2'
     THEN
        UPDATE hhinv_load_2
           SET error_flg = 'Y'
              ,error_msg = pi_error
         WHERE rec_seq_no = pi_seq_no
             ;
    END IF;
    --
    COMMIT;
    --
  END flag_error;
  -------------------------------------------------------------------------------
  PROCEDURE create_asset(pi_iit_rec   IN OUT nm_inv_items_all%ROWTYPE
                        ,pi_ne_id     IN     hhinv_load_3.he_id%TYPE
                        ,pi_st_chain  IN     hhinv_load_3.st_chain%TYPE
                        ,pi_end_chain IN     hhinv_load_3.end_chain%TYPE) IS
    --
    lv_datum VARCHAR2(1);
    --
  BEGIN
    --
    IF pi_iit_rec.iit_start_date IS NULL
     THEN
        pi_iit_rec.iit_start_date := nm3user.get_effective_date;
    END IF;
    --
    IF pi_iit_rec.iit_primary_key IS NULL
     THEN
        pi_iit_rec.iit_primary_key := pi_iit_rec.iit_ne_id;
    END IF;
    --
    IF pi_iit_rec.iit_admin_unit IS NULL
     THEN
        pi_iit_rec.iit_admin_unit := g_admin_unit;
    END IF;
    --
    lv_effective_date := nm3user.get_effective_date;
    nm3user.set_effective_date(pi_iit_rec.iit_start_date);
    /*
    || GJ 21-DEC-2006
    || if an inventory item already exists with the same IIT_UK and we
    || are intending on inserting a new asset (i.e. iit_end_date is null)
    || then ensure that the insert would not violate IIT_UK
    */
    IF nm3get.get_iit_all(pi_iit_primary_key   => pi_iit_rec.iit_primary_key
                         ,pi_iit_inv_type      => pi_iit_rec.iit_inv_type
                         ,pi_iit_start_date    => pi_iit_rec.iit_start_date
                         ,pi_raise_not_found   => FALSE).iit_ne_id IS NOT NULL
     AND pi_iit_rec.iit_end_date IS NULL
     THEN
        --
        -- NET-0445: Asset item with this primary key/asset type/start date already exists
        --
        hig.raise_ner(pi_appl               => 'NET'
                     ,pi_id                 => 445
                     ,pi_supplementary_info => chr(10)||pi_iit_rec.iit_primary_key
                                             ||chr(10)||pi_iit_rec.iit_inv_type||chr(10)
                                             ||to_char(pi_iit_rec.iit_start_date,'DD-MON-YYYY'));
    END IF;
    /*
    || Insert The Asset.
    */
    INSERT
      INTO nm_inv_items_all
    VALUES pi_iit_rec
         ;
    /*
    || Locate The Asset.
    */
    lv_datum := nm3net.is_nt_datum(nm3net.get_nt_type(pi_ne_id));
    --
    IF lv_datum = 'Y'
     THEN
        INSERT
          INTO NM_MEMBERS_ALL
              (NM_NE_ID_IN
              ,NM_NE_ID_OF
              ,NM_TYPE
              ,NM_OBJ_TYPE
              ,NM_BEGIN_MP
              ,NM_START_DATE
              ,NM_END_DATE
              ,NM_END_MP
              ,NM_SLK
              ,NM_CARDINALITY
              ,NM_ADMIN_UNIT
              ,NM_DATE_CREATED
              ,NM_DATE_MODIFIED
              ,NM_MODIFIED_BY
              ,NM_CREATED_BY
              ,NM_SEQ_NO
              ,NM_SEG_NO
              ,NM_TRUE
              ,NM_END_SLK
              ,NM_END_TRUE)
        VALUES(pi_iit_rec.iit_ne_id
              ,pi_ne_id
              ,'I'
              ,pi_iit_rec.iit_inv_type
              ,pi_st_chain
              ,pi_iit_rec.iit_start_date
              ,NULL
              ,pi_end_chain
              ,0
              ,1
              ,pi_iit_rec.iit_admin_unit
              ,NULL
              ,NULL
              ,NULL
              ,NULL
              ,1
              ,1
              ,0
              ,NULL
              ,NULL)
             ;
    ELSE
        INSERT
          INTO NM_MEMBERS_ALL
              (NM_NE_ID_IN
              ,NM_NE_ID_OF
              ,NM_TYPE
              ,NM_OBJ_TYPE
              ,NM_BEGIN_MP
              ,NM_START_DATE
              ,NM_END_DATE
              ,NM_END_MP
              ,NM_SLK
              ,NM_CARDINALITY
              ,NM_ADMIN_UNIT
              ,NM_DATE_CREATED
              ,NM_DATE_MODIFIED
              ,NM_MODIFIED_BY
              ,NM_CREATED_BY
              ,NM_SEQ_NO
              ,NM_SEG_NO
              ,NM_TRUE
              ,NM_END_SLK
              ,NM_END_TRUE)
        SELECT pi_iit_rec.iit_ne_id
              ,p.pl_ne_id
              ,'I'
              ,pi_iit_rec.iit_inv_type
              ,p.pl_start
              ,pi_iit_rec.iit_start_date
              ,NULL
              ,p.pl_end
              ,0
              ,1
              ,pi_iit_rec.iit_admin_unit
              ,NULL
              ,NULL
              ,NULL
              ,NULL
              ,rownum
              ,1
              ,0
              ,NULL
              ,NULL
          FROM TABLE(cast(mai2110c.get_inv_location(pi_ne_id
                                                   ,pi_st_chain
                                                   ,pi_end_chain).npa_placement_array as nm_placement_array_type)) p;
    END IF;
    --
    nm3user.set_effective_date(lv_effective_date);
    --
  EXCEPTION
    WHEN others
     THEN
        IF lv_effective_date IS NOT NULL
         THEN
            nm3user.set_effective_date(lv_effective_date);
        END IF;
        RAISE;
  END create_asset;
  -------------------------------------------------------------------------------
  PROCEDURE pro_hhinv_load_3(pi_index IN NUMBER) IS
    --
    lt_ins_recs    hhinv_load_3_tab;
    --
    lr_rec_iit     nm_inv_items_all%ROWTYPE;
    --
  BEGIN
    --
    SELECT h.rec_seq_no
          ,h.he_id
          ,round(h.st_chain,3)     -- ecdm 691564
          ,round(h.end_chain,3)    -- ecdm 691564
          ,h.x_sect
          ,h.inv_code
          ,h.peo_invent_by_id
          ,h.invent_date
          ,max(h.length),max(h.gap),max(h.width),max(h.height),max(h.height_2)
          ,max(h.distance),max(h.angle),max(h.no_of_units),max(h.power)
          ,max(h.type),max(h.class),max(h.material),max(h.colour),max( h.owner)
          ,max(h.method),max(h.options),max(h.description),max(h.id_code)
          ,max(h.diagram),max(h.photo),max(h.note),max(h.instal_date)
          ,max(h.itemcode),max(xtra_char_1),max(xtra_date_1)
          ,max(h.xtra_domain_1),max(h.xtra_number_1),h.ity_sys_flag,'I'
          ,max(h.primary_key)  ,max(h.foreign_key)  ,max(descr)
          ,max(located_by)     ,max(position)       ,max(x_coord)
          ,max(y_coord)        ,max(inv_ownership)
          ,max(lco_lamp_config_id),max(oun_org_id_elec_board),max(prov_flag)
          ,max(rev_by)         ,max(rev_date)       ,max(offset)
          ,max(x)              ,max(y)              ,max(z)
          ,max(h.num_attrib16) ,max(h.num_attrib17) ,max(h.num_attrib18)
          ,max(h.num_attrib19) ,max(h.num_attrib20) ,max(h.num_attrib21)
          ,max(h.num_attrib22) ,max(h.num_attrib23) ,max(h.num_attrib24)
          ,max(h.num_attrib25) ,max(h.chr_attrib26) ,max(h.chr_attrib27)
          ,max(h.chr_attrib28) ,max(h.chr_attrib29) ,max(h.chr_attrib30)
          ,max(h.chr_attrib31) ,max(h.chr_attrib32) ,max(h.chr_attrib33)
          ,max(h.chr_attrib34) ,max(h.chr_attrib35) ,max(h.chr_attrib36)
          ,max(h.chr_attrib37) ,max(h.chr_attrib38) ,max(h.chr_attrib39)
          ,max(h.chr_attrib40) ,max(h.chr_attrib41) ,max(h.chr_attrib42)
          ,max(h.chr_attrib43) ,max(h.chr_attrib44) ,max(h.chr_attrib45)
          ,max(h.chr_attrib46) ,max(h.chr_attrib47) ,max(h.chr_attrib48)
          ,max(h.chr_attrib49) ,max(h.chr_attrib50) ,max(h.chr_attrib51)
          ,max(h.chr_attrib52) ,max(h.chr_attrib53) ,max(h.chr_attrib54)
          ,max(h.chr_attrib55) ,max(h.chr_attrib56) ,max(h.chr_attrib57)
          ,max(h.chr_attrib58) ,max(h.chr_attrib59) ,max(h.chr_attrib60)
          ,max(h.chr_attrib61) ,max(h.chr_attrib62) ,max(h.chr_attrib63)
          ,max(h.chr_attrib64) ,max(h.chr_attrib65) ,max(h.chr_attrib66)
          ,max(h.chr_attrib67) ,max(h.chr_attrib68) ,max(h.chr_attrib69)
          ,max(h.chr_attrib70) ,max(h.chr_attrib71) ,max(h.chr_attrib72)
          ,max(h.chr_attrib73) ,max(h.chr_attrib74) ,max(h.chr_attrib75)
          ,max(h.num_attrib76) ,max(h.num_attrib77) ,max(h.num_attrib78)
          ,max(h.num_attrib79) ,max(h.num_attrib80) ,max(h.num_attrib81)
          ,max(h.num_attrib82) ,max(h.num_attrib83) ,max(h.num_attrib84)
          ,max(h.num_attrib85) ,max(h.date_attrib86),max(h.date_attrib87)
          ,max(h.date_attrib88),max(h.date_attrib89),max(h.date_attrib90)
          ,max(h.date_attrib91),max(h.date_attrib92),max(h.date_attrib93)
          ,max(h.date_attrib94),max(h.date_attrib95)
          ,max(num_attrib96)   ,max(num_attrib97)   ,max(num_attrib98)
          ,max(num_attrib99)   ,max(num_attrib100)  ,max(num_attrib101)
          ,max(num_attrib102)  ,max(num_attrib103)  ,max(num_attrib104)
          ,max(num_attrib105)  ,max(num_attrib106)  ,max(num_attrib107)
          ,max(num_attrib108)  ,max(num_attrib109)  ,max(num_attrib110)
          ,max(num_attrib111)  ,max(num_attrib112)  ,max(num_attrib113)
          ,max(num_attrib114)  ,max(num_attrib115)  ,max(h.det_xsp)
      BULK COLLECT
      INTO lt_ins_recs
      FROM hhinv_load_3 h
     WHERE h.he_id = lt_he_id(pi_index)
       AND h.inv_code NOT IN(SELECT uvd_inv_code
                               FROM nm_inv_types_all
                                   ,ukpms_view_definitions
                              WHERE uvd_feature_or_survey IN('F','S')
                                AND uvd_inv_code = nit_inv_type
                                AND nit_table_name IS NOT NULL)
     GROUP
        BY h.rec_seq_no,h.he_id,h.st_chain,h.end_chain
          ,h.x_sect,h.inv_code,h.invent_date,h.peo_invent_by_id
          ,ity_sys_flag,'I'
    HAVING COUNT(H.ERROR_FLG) = 0
         ;
    --
    FOR j IN 1 .. lt_ins_recs.count LOOP
      --
      BEGIN
        --
        IF lt_ins_recs(j).rec_seq_no IS NULL
         THEN
            lt_ins_recs(j).rec_seq_no := nm3net.get_next_ne_id;
        END IF;
        --
        lr_rec_iit.iit_ne_id                   := lt_ins_recs(j).rec_seq_no;
        lr_rec_iit.iit_start_date              := TRUNC(lt_ins_recs(j).iit_start_date);
        lr_rec_iit.iit_inv_type                := mai.translate_mai_inv_type(lt_ins_recs(j).iit_inv_code);
        lr_rec_iit.iit_angle                   := lt_ins_recs(j).iit_angle;
        lr_rec_iit.iit_class                   := lt_ins_recs(j).iit_class;
        lr_rec_iit.iit_colour                  := lt_ins_recs(j).iit_colour;
        lr_rec_iit.iit_description             := lt_ins_recs(j).iit_description;
        lr_rec_iit.iit_diagram                 := lt_ins_recs(j).iit_diagram;
        lr_rec_iit.iit_distance                := lt_ins_recs(j).iit_distance;
        lr_rec_iit.iit_gap                     := lt_ins_recs(j).iit_gap;
        lr_rec_iit.iit_height                  := lt_ins_recs(j).iit_height;
        lr_rec_iit.iit_height_2                := lt_ins_recs(j).iit_height_2;
        lr_rec_iit.iit_id_code                 := lt_ins_recs(j).iit_id_code;
        lr_rec_iit.iit_instal_date             := lt_ins_recs(j).iit_instal_date;
        lr_rec_iit.iit_invent_date             := lt_ins_recs(j).iit_start_date;
        lr_rec_iit.iit_itemcode                := lt_ins_recs(j).iit_itemcode;
        lr_rec_iit.iit_length                  := lt_ins_recs(j).iit_length;
        lr_rec_iit.iit_material                := lt_ins_recs(j).iit_material;
        lr_rec_iit.iit_method                  := lt_ins_recs(j).iit_method;
        lr_rec_iit.iit_note                    := lt_ins_recs(j).iit_note;
        lr_rec_iit.iit_no_of_units             := lt_ins_recs(j).iit_no_of_units;
        lr_rec_iit.iit_options                 := lt_ins_recs(j).iit_options;
        lr_rec_iit.iit_owner                   := lt_ins_recs(j).iit_owner;
        lr_rec_iit.iit_peo_invent_by_id        := lt_ins_recs(j).iit_peo_invent_by_id;
        lr_rec_iit.iit_photo                   := lt_ins_recs(j).iit_photo;
        lr_rec_iit.iit_power                   := lt_ins_recs(j).iit_power;
        lr_rec_iit.iit_type                    := lt_ins_recs(j).iit_type;
        lr_rec_iit.iit_width                   := lt_ins_recs(j).iit_width;
        lr_rec_iit.iit_xtra_char_1             := lt_ins_recs(j).iit_xtra_char_1;
        lr_rec_iit.iit_xtra_date_1             := lt_ins_recs(j).iit_xtra_date_1;
        lr_rec_iit.iit_xtra_domain_1           := lt_ins_recs(j).iit_xtra_domain_1;
        lr_rec_iit.iit_xtra_number_1           := lt_ins_recs(j).iit_xtra_number_1;
        lr_rec_iit.iit_x_sect                  := lt_ins_recs(j).iit_x_sect;
        lr_rec_iit.iit_primary_key             := lt_ins_recs(j).iit_primary_key;
        lr_rec_iit.iit_foreign_key             := lt_ins_recs(j).iit_foreign_key;
        lr_rec_iit.iit_descr                   := lt_ins_recs(j).iit_descr;
        lr_rec_iit.iit_located_by              := lt_ins_recs(j).iit_located_by;
        lr_rec_iit.iit_position                := lt_ins_recs(j).iit_position;
        lr_rec_iit.iit_x_coord                 := lt_ins_recs(j).iit_x_coord;
        lr_rec_iit.iit_y_coord                 := lt_ins_recs(j).iit_y_coord;
        lr_rec_iit.iit_coord_flag              := lt_ins_recs(j).iit_coord_flag;
        lr_rec_iit.iit_inv_ownership           := lt_ins_recs(j).iit_inv_ownership;
        lr_rec_iit.iit_lco_lamp_config_id      := lt_ins_recs(j).iit_lco_lamp_config_id;
        lr_rec_iit.iit_oun_org_id_elec_board   := lt_ins_recs(j).iit_oun_org_id_elec_board;
        lr_rec_iit.iit_prov_flag               := lt_ins_recs(j).iit_prov_flag;
        lr_rec_iit.iit_rev_by                  := lt_ins_recs(j).iit_rev_by;
        lr_rec_iit.iit_rev_date                := lt_ins_recs(j).iit_rev_date;
        lr_rec_iit.iit_offset                  := lt_ins_recs(j).iit_offset;
        lr_rec_iit.iit_x                       := lt_ins_recs(j).iit_x;
        lr_rec_iit.iit_y                       := lt_ins_recs(j).iit_y;
        lr_rec_iit.iit_z                       := lt_ins_recs(j).iit_z;
        lr_rec_iit.iit_det_xsp                 := lt_ins_recs(j).iit_det_xsp;
        lr_rec_iit.iit_num_attrib16            := lt_ins_recs(j).iit_num_attrib16;
        lr_rec_iit.iit_num_attrib17            := lt_ins_recs(j).iit_num_attrib17;
        lr_rec_iit.iit_num_attrib18            := lt_ins_recs(j).iit_num_attrib18;
        lr_rec_iit.iit_num_attrib19            := lt_ins_recs(j).iit_num_attrib19;
        lr_rec_iit.iit_num_attrib20            := lt_ins_recs(j).iit_num_attrib20;
        lr_rec_iit.iit_num_attrib21            := lt_ins_recs(j).iit_num_attrib21;
        lr_rec_iit.iit_num_attrib22            := lt_ins_recs(j).iit_num_attrib22;
        lr_rec_iit.iit_num_attrib23            := lt_ins_recs(j).iit_num_attrib23;
        lr_rec_iit.iit_num_attrib24            := lt_ins_recs(j).iit_num_attrib24;
        lr_rec_iit.iit_num_attrib25            := lt_ins_recs(j).iit_num_attrib25;
        lr_rec_iit.iit_chr_attrib26            := lt_ins_recs(j).iit_chr_attrib26;
        lr_rec_iit.iit_chr_attrib27            := lt_ins_recs(j).iit_chr_attrib27;
        lr_rec_iit.iit_chr_attrib28            := lt_ins_recs(j).iit_chr_attrib28;
        lr_rec_iit.iit_chr_attrib29            := lt_ins_recs(j).iit_chr_attrib29;
        lr_rec_iit.iit_chr_attrib30            := lt_ins_recs(j).iit_chr_attrib30;
        lr_rec_iit.iit_chr_attrib31            := lt_ins_recs(j).iit_chr_attrib31;
        lr_rec_iit.iit_chr_attrib32            := lt_ins_recs(j).iit_chr_attrib32;
        lr_rec_iit.iit_chr_attrib33            := lt_ins_recs(j).iit_chr_attrib33;
        lr_rec_iit.iit_chr_attrib34            := lt_ins_recs(j).iit_chr_attrib34;
        lr_rec_iit.iit_chr_attrib35            := lt_ins_recs(j).iit_chr_attrib35;
        lr_rec_iit.iit_chr_attrib36            := lt_ins_recs(j).iit_chr_attrib36;
        lr_rec_iit.iit_chr_attrib37            := lt_ins_recs(j).iit_chr_attrib37;
        lr_rec_iit.iit_chr_attrib38            := lt_ins_recs(j).iit_chr_attrib38;
        lr_rec_iit.iit_chr_attrib39            := lt_ins_recs(j).iit_chr_attrib39;
        lr_rec_iit.iit_chr_attrib40            := lt_ins_recs(j).iit_chr_attrib40;
        lr_rec_iit.iit_chr_attrib41            := lt_ins_recs(j).iit_chr_attrib41;
        lr_rec_iit.iit_chr_attrib42            := lt_ins_recs(j).iit_chr_attrib42;
        lr_rec_iit.iit_chr_attrib43            := lt_ins_recs(j).iit_chr_attrib43;
        lr_rec_iit.iit_chr_attrib44            := lt_ins_recs(j).iit_chr_attrib44;
        lr_rec_iit.iit_chr_attrib45            := lt_ins_recs(j).iit_chr_attrib45;
        lr_rec_iit.iit_chr_attrib46            := lt_ins_recs(j).iit_chr_attrib46;
        lr_rec_iit.iit_chr_attrib47            := lt_ins_recs(j).iit_chr_attrib47;
        lr_rec_iit.iit_chr_attrib48            := lt_ins_recs(j).iit_chr_attrib48;
        lr_rec_iit.iit_chr_attrib49            := lt_ins_recs(j).iit_chr_attrib49;
        lr_rec_iit.iit_chr_attrib50            := lt_ins_recs(j).iit_chr_attrib50;
        lr_rec_iit.iit_chr_attrib51            := lt_ins_recs(j).iit_chr_attrib51;
        lr_rec_iit.iit_chr_attrib52            := lt_ins_recs(j).iit_chr_attrib52;
        lr_rec_iit.iit_chr_attrib53            := lt_ins_recs(j).iit_chr_attrib53;
        lr_rec_iit.iit_chr_attrib54            := lt_ins_recs(j).iit_chr_attrib54;
        lr_rec_iit.iit_chr_attrib55            := lt_ins_recs(j).iit_chr_attrib55;
        lr_rec_iit.iit_chr_attrib56            := lt_ins_recs(j).iit_chr_attrib56;
        lr_rec_iit.iit_chr_attrib57            := lt_ins_recs(j).iit_chr_attrib57;
        lr_rec_iit.iit_chr_attrib58            := lt_ins_recs(j).iit_chr_attrib58;
        lr_rec_iit.iit_chr_attrib59            := lt_ins_recs(j).iit_chr_attrib59;
        lr_rec_iit.iit_chr_attrib60            := lt_ins_recs(j).iit_chr_attrib60;
        lr_rec_iit.iit_chr_attrib61            := lt_ins_recs(j).iit_chr_attrib61;
        lr_rec_iit.iit_chr_attrib62            := lt_ins_recs(j).iit_chr_attrib62;
        lr_rec_iit.iit_chr_attrib63            := lt_ins_recs(j).iit_chr_attrib63;
        lr_rec_iit.iit_chr_attrib64            := lt_ins_recs(j).iit_chr_attrib64;
        lr_rec_iit.iit_chr_attrib65            := lt_ins_recs(j).iit_chr_attrib65;
        lr_rec_iit.iit_chr_attrib66            := lt_ins_recs(j).iit_chr_attrib66;
        lr_rec_iit.iit_chr_attrib67            := lt_ins_recs(j).iit_chr_attrib67;
        lr_rec_iit.iit_chr_attrib68            := lt_ins_recs(j).iit_chr_attrib68;
        lr_rec_iit.iit_chr_attrib69            := lt_ins_recs(j).iit_chr_attrib69;
        lr_rec_iit.iit_chr_attrib70            := lt_ins_recs(j).iit_chr_attrib70;
        lr_rec_iit.iit_chr_attrib71            := lt_ins_recs(j).iit_chr_attrib71;
        lr_rec_iit.iit_chr_attrib72            := lt_ins_recs(j).iit_chr_attrib72;
        lr_rec_iit.iit_chr_attrib73            := lt_ins_recs(j).iit_chr_attrib73;
        lr_rec_iit.iit_chr_attrib74            := lt_ins_recs(j).iit_chr_attrib74;
        lr_rec_iit.iit_chr_attrib75            := lt_ins_recs(j).iit_chr_attrib75;
        lr_rec_iit.iit_num_attrib76            := lt_ins_recs(j).iit_num_attrib76;
        lr_rec_iit.iit_num_attrib77            := lt_ins_recs(j).iit_num_attrib77;
        lr_rec_iit.iit_num_attrib78            := lt_ins_recs(j).iit_num_attrib78;
        lr_rec_iit.iit_num_attrib79            := lt_ins_recs(j).iit_num_attrib79;
        lr_rec_iit.iit_num_attrib80            := lt_ins_recs(j).iit_num_attrib80;
        lr_rec_iit.iit_num_attrib81            := lt_ins_recs(j).iit_num_attrib81;
        lr_rec_iit.iit_num_attrib82            := lt_ins_recs(j).iit_num_attrib82;
        lr_rec_iit.iit_num_attrib83            := lt_ins_recs(j).iit_num_attrib83;
        lr_rec_iit.iit_num_attrib84            := lt_ins_recs(j).iit_num_attrib84;
        lr_rec_iit.iit_num_attrib85            := lt_ins_recs(j).iit_num_attrib85;
        lr_rec_iit.iit_date_attrib86           := lt_ins_recs(j).iit_date_attrib86;
        lr_rec_iit.iit_date_attrib87           := lt_ins_recs(j).iit_date_attrib87;
        lr_rec_iit.iit_date_attrib88           := lt_ins_recs(j).iit_date_attrib88;
        lr_rec_iit.iit_date_attrib89           := lt_ins_recs(j).iit_date_attrib89;
        lr_rec_iit.iit_date_attrib90           := lt_ins_recs(j).iit_date_attrib90;
        lr_rec_iit.iit_date_attrib91           := lt_ins_recs(j).iit_date_attrib91;
        lr_rec_iit.iit_date_attrib92           := lt_ins_recs(j).iit_date_attrib92;
        lr_rec_iit.iit_date_attrib93           := lt_ins_recs(j).iit_date_attrib93;
        lr_rec_iit.iit_date_attrib94           := lt_ins_recs(j).iit_date_attrib94;
        lr_rec_iit.iit_date_attrib95           := lt_ins_recs(j).iit_date_attrib95;
        lr_rec_iit.iit_num_attrib96            := lt_ins_recs(j).iit_num_attrib96;
        lr_rec_iit.iit_num_attrib97            := lt_ins_recs(j).iit_num_attrib97;
        lr_rec_iit.iit_num_attrib98            := lt_ins_recs(j).iit_num_attrib98;
        lr_rec_iit.iit_num_attrib99            := lt_ins_recs(j).iit_num_attrib99;
        lr_rec_iit.iit_num_attrib100           := lt_ins_recs(j).iit_num_attrib100;
        lr_rec_iit.iit_num_attrib101           := lt_ins_recs(j).iit_num_attrib101;
        lr_rec_iit.iit_num_attrib102           := lt_ins_recs(j).iit_num_attrib102;
        lr_rec_iit.iit_num_attrib103           := lt_ins_recs(j).iit_num_attrib103;
        lr_rec_iit.iit_num_attrib104           := lt_ins_recs(j).iit_num_attrib104;
        lr_rec_iit.iit_num_attrib105           := lt_ins_recs(j).iit_num_attrib105;
        lr_rec_iit.iit_num_attrib106           := lt_ins_recs(j).iit_num_attrib106;
        lr_rec_iit.iit_num_attrib107           := lt_ins_recs(j).iit_num_attrib107;
        lr_rec_iit.iit_num_attrib108           := lt_ins_recs(j).iit_num_attrib108;
        lr_rec_iit.iit_num_attrib109           := lt_ins_recs(j).iit_num_attrib109;
        lr_rec_iit.iit_num_attrib110           := lt_ins_recs(j).iit_num_attrib110;
        lr_rec_iit.iit_num_attrib111           := lt_ins_recs(j).iit_num_attrib111;
        lr_rec_iit.iit_num_attrib112           := lt_ins_recs(j).iit_num_attrib112;
        lr_rec_iit.iit_num_attrib113           := lt_ins_recs(j).iit_num_attrib113;
        lr_rec_iit.iit_num_attrib114           := lt_ins_recs(j).iit_num_attrib114;
        lr_rec_iit.iit_num_attrib115           := lt_ins_recs(j).iit_num_attrib115;
        --
        create_asset(pi_iit_rec   => lr_rec_iit
                    ,pi_ne_id     => lt_ins_recs(j).iit_he_id
                    ,pi_st_chain  => lt_ins_recs(j).iit_st_chain
                    ,pi_end_chain => lt_ins_recs(j).iit_end_chain);
        --
        IF(mod(j,100)=0)
         THEN
            COMMIT;
        END IF;
        --
        lv_sect_count := lv_sect_count+1;
        --
      EXCEPTION
        WHEN others
         THEN
            flag_error(pi_table  => 'HHINV_LOAD_3'
                      ,pi_seq_no => lt_ins_recs(j).rec_seq_no
                      ,pi_error  => SQLERRM);
      END;
    END LOOP;
    --
    COMMIT;
    --
  END pro_hhinv_load_3;
  -------------------------------------------------------------------------------
  PROCEDURE pro_hhinv_load_2(pi_index IN NUMBER) IS
    --
    lt_ins2_recs hhinv_load_2_tab;
    --
    lr_rec2_iit  nm_inv_items_all%ROWTYPE;
    --
  BEGIN
    --
    SELECT rec_seq_no
          ,he_id
          ,round(st_chain,3)  -- ecdm 691564
          ,round(end_chain,3)  -- ecdm 691564
          ,x_sect
          ,inv_code
          ,peo_invent_by_id
          ,invent_date
          ,hhinv_ity_sys_flag
          ,'I'
          ,rec_seq_no
      BULK COLLECT
      INTO lt_ins2_recs
      FROM hhinv_load_2
     WHERE he_id = lt_he_id(pi_index)
       AND error_flg IS NULL
       AND inv_code IN(SELECT ity_inv_code
                         FROM inv_item_types ii
                        WHERE ii.ity_hhpos1 IS NULL
                          AND ii.ity_sys_flag = hhinv_ity_sys_flag)
       AND inv_code NOT IN(SELECT uvd_inv_code
                             FROM nm_inv_types_all
                                 ,ukpms_view_definitions
                            WHERE uvd_feature_or_survey IN('F','S')
                              AND uvd_inv_code = nit_inv_type
                              AND nit_table_name IS NOT NULL)

         ;
    --
    FOR j IN 1 .. lt_ins2_recs.count LOOP
      --
      BEGIN
        --
        IF lt_ins2_recs(j).rec_seq_no IS NULL
         THEN
            lt_ins2_recs(j).rec_seq_no := nm3net.get_next_ne_id;
        END IF;
        --
        lr_rec2_iit.iit_ne_id            := lt_ins2_recs(j).rec_seq_no;
        lr_rec2_iit.iit_start_date       := TRUNC(lt_ins2_recs(j).iit_start_date);
        lr_rec2_iit.iit_inv_type         := mai.translate_mai_inv_type(lt_ins2_recs(j).iit_inv_code);
        lr_rec2_iit.iit_x_sect           := lt_ins2_recs(j).iit_x_sect;
        lr_rec2_iit.iit_peo_invent_by_id := lt_ins2_recs(j).iit_peo_invent_by_id;
        lr_rec2_iit.iit_coord_flag       := lt_ins2_recs(j).iit_coord_flag;
        lr_rec2_iit.iit_primary_key      := lt_ins2_recs(j).iit_primary_key;
        --
        create_asset(pi_iit_rec   => lr_rec2_iit
                    ,pi_ne_id     => lt_ins2_recs(j).iit_he_id
                    ,pi_st_chain  => lt_ins2_recs(j).iit_st_chain
                    ,pi_end_chain => lt_ins2_recs(j).iit_end_chain);
        --
        IF(mod(j,100)=0)
         THEN
            COMMIT;
        END IF;
        --
        lv_sect_count := lv_sect_count+1;
        --
      EXCEPTION
        WHEN others
         THEN
            flag_error(pi_table  => 'HHINV_LOAD_2'
                      ,pi_seq_no => lt_ins2_recs(j).rec_seq_no
                      ,pi_error  => SQLERRM);
      END;
      --
    END LOOP;
    --
    COMMIT;
    --
  END pro_hhinv_load_2;
  --
BEGIN
  /*
  || Initialise Section Error Indicator.
  */
  po_sect_err := 0;
  lv_sect_count := 0;
  /*
  || Get The Elements To Process.
  */
  SELECT he_id
    BULK COLLECT
    INTO lt_he_id
    FROM hhinv_sect_log
   WHERE lst_run_num = pi_run_num
     AND he_id != -9999999
       ;
  /*
  || Loop Through The Elements Found
  || And Attempt To Create The Assets.
  */
  FOR i IN 1 .. lt_he_id.count LOOP
    /*
    || Initialise Internal Section Error Indicator.
    */
    lv_sect_error := FALSE;
    /*
    || Get Admin Unit To Use As A Default.
    */
    g_admin_unit := nvl(nm3get.get_ne(pi_ne_id => lt_he_id(i)).ne_admin_unit,1);
    /*
    || Create The Assets In The Holding Tables.
    */
    pro_hhinv_load_3(i);
    --
    pro_hhinv_load_2(i);
    --
    IF lv_sect_error = TRUE
     THEN
        /*
        || Errors Occured So Set
        || The Output Error Indicator.
        */
        po_sect_err := 1;
    END IF;
    --
    po_rec_count := nvl(po_rec_count,0) + lv_sect_count;
    lv_sect_count := 0;
    --
  END LOOP;
  --
EXCEPTION
  WHEN OTHERS
  THEN
      IF lv_effective_date IS NOT NULL
       THEN
          nm3user.set_effective_date(lv_effective_date);
      END IF;
      RAISE;
END ins_assets;
--
-----------------------------------------------------------------------------
--
FUNCTION get_inv_location(pi_ne_id IN NUMBER
                         ,pi_start IN NUMBER
                         ,pi_end   IN NUMBER)
  RETURN nm_placement_array IS
  --
  CURSOR c1(cp_ne_id IN NUMBER
           ,cp_start IN NUMBER
           ,cp_end   IN NUMBER)
      IS
  SELECT nm_ne_id_of
        ,nm_slk
        ,nm_end_slk
        ,nm_cardinality
        ,ne_length
    FROM nm_members
        ,nm_elements
   WHERE nm_ne_id_in = cp_ne_id
     AND nm_ne_id_of = ne_id
     AND ((nm_slk < cp_end AND nm_end_slk > cp_start AND cp_start <  cp_end)
          OR(nm_slk <= cp_end AND nm_end_slk >= cp_start AND cp_start = cp_end))
       ;
  --
  retval nm_placement_array:=nm_placement_array(nm_placement_array_type(nm_placement(NULL,NULL,NULL,NULL)));
  --
  lt_ne_id  Nm3type.tab_number;
  lt_start  Nm3type.tab_number;
  lt_end    Nm3type.tab_number;
  lt_s_slk  Nm3type.tab_number;
  lt_e_slk  Nm3type.tab_number;
  lt_card   Nm3type.tab_number;
  lt_length Nm3type.tab_number;
  --
BEGIN
  --
  OPEN  c1(pi_ne_id,pi_start,pi_end);
  FETCH c1
   BULK COLLECT
   INTO lt_ne_id
       ,lt_s_slk
       ,lt_e_slk
       ,lt_card
       ,lt_length;
  CLOSE c1;
  --
  FOR i IN 1..lt_ne_id.COUNT LOOP
    --
    IF lt_s_slk(i) >= pi_start
     AND lt_e_slk(i) <= pi_end
     THEN
        retval := retval.add_element(lt_ne_id(i),0,lt_length(i),0,FALSE);
    ELSIF lt_s_slk(i) < pi_start
     AND lt_e_slk(i) < pi_end
     THEN
        IF lt_card(i) > 0
         THEN
            retval := retval.add_element(lt_ne_id(i),pi_start-lt_s_slk(i),lt_length(i),0,FALSE);
        ELSE
            retval := retval.add_element(lt_ne_id(i),0,lt_e_slk(i)-pi_start,0,FALSE);
        END IF;
    ELSIF lt_e_slk(i) > pi_end
     AND lt_s_slk(i) > pi_start
     THEN
        IF lt_card(i) > 0
         THEN
            retval := retval.add_element(lt_ne_id(i),0,lt_length(i)-(lt_e_slk(i)-pi_end),0,FALSE);
        ELSE
            retval := retval.add_element(lt_ne_id(i),lt_e_slk(i)-pi_end,lt_length(i),0,FALSE);
        END IF;
    ELSE
        IF lt_card(i) > 0
         THEN
            retval := retval.add_element(lt_ne_id(i),pi_start-lt_s_slk(i),lt_length(i)-(lt_e_slk(i)-pi_end),0,FALSE);
        ELSE
            retval := retval.add_element(lt_ne_id(i),lt_e_slk(i)-pi_end,lt_e_slk(i)-pi_start,0,FALSE);
        END IF;
    END IF;
    --
  END LOOP;
  --
  RETURN retval;
  --
END get_inv_location;
--
-----------------------------------------------------------------------------
--
END mai2110c;
/
