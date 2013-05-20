REM MAI Translation View creation Script.
REM
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/views/mai_transviews.sql-arc   2.4   May 20 2013 11:39:58   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_transviews.sql  $
--       Date into SCCS   : $Date:   May 20 2013 11:39:58  $
--       Date fetched Out : $Modtime:   May 08 2013 16:01:26  $
--       SCCS Version     : $Revision:   2.4  $
--       Based on SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------

CREATE OR REPLACE FORCE VIEW INV_ITEMS_ALL
(IIT_CREATED_DATE, IIT_CRE_DATE, IIT_ITEM_ID, IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, 
 IIT_LAST_UPDATED_DATE, IIT_RSE_HE_ID, IIT_ST_CHAIN, IIT_ANGLE, IIT_ANGLE_TXT, 
 IIT_CLASS, IIT_CLASS_TXT, IIT_COLOUR, IIT_COLOUR_TXT, IIT_COORD_FLAG, 
 IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE, IIT_END_CHAIN, IIT_END_DATE, 
 IIT_GAP, IIT_HEIGHT, IIT_HEIGHT_2, IIT_ID_CODE, IIT_INSTAL_DATE, 
 IIT_INVENT_DATE, IIT_INV_OWNERSHIP, IIT_ITEMCODE, IIT_LCO_LAMP_CONFIG_ID, IIT_LENGTH, 
 IIT_MATERIAL, IIT_MATERIAL_TXT, IIT_METHOD, IIT_METHOD_TXT, IIT_NOTE, 
 IIT_NO_OF_UNITS, IIT_OPTIONS, IIT_OPTIONS_TXT, IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER, 
 IIT_OWNER_TXT, IIT_PEO_INVENT_BY_ID, IIT_PHOTO, IIT_POWER, IIT_PROV_FLAG, 
 IIT_REV_BY, IIT_REV_DATE, IIT_TYPE, IIT_TYPE_TXT, IIT_WIDTH, 
 IIT_XTRA_CHAR_1, IIT_XTRA_DATE_1, IIT_XTRA_DOMAIN_1, IIT_XTRA_DOMAIN_TXT_1, IIT_XTRA_NUMBER_1, 
 IIT_X_SECT, IIT_PRIMARY_KEY, IIT_FOREIGN_KEY, IIT_DET_XSP, IIT_OFFSET, 
 IIT_NUM_ATTRIB16, IIT_NUM_ATTRIB17, IIT_NUM_ATTRIB18, IIT_NUM_ATTRIB19, IIT_NUM_ATTRIB20, 
 IIT_NUM_ATTRIB21, IIT_NUM_ATTRIB22, IIT_NUM_ATTRIB23, IIT_NUM_ATTRIB24, IIT_NUM_ATTRIB25, 
 IIT_CHR_ATTRIB26, IIT_CHR_ATTRIB27, IIT_CHR_ATTRIB28, IIT_CHR_ATTRIB29, IIT_CHR_ATTRIB30, 
 IIT_CHR_ATTRIB31, IIT_CHR_ATTRIB32, IIT_CHR_ATTRIB33, IIT_CHR_ATTRIB34, IIT_CHR_ATTRIB35, 
 IIT_CHR_ATTRIB36, IIT_CHR_ATTRIB37, IIT_CHR_ATTRIB38, IIT_CHR_ATTRIB39, IIT_CHR_ATTRIB40, 
 IIT_CHR_ATTRIB41, IIT_CHR_ATTRIB42, IIT_CHR_ATTRIB43, IIT_CHR_ATTRIB44, IIT_CHR_ATTRIB45, 
 IIT_CHR_ATTRIB46, IIT_CHR_ATTRIB47, IIT_CHR_ATTRIB48, IIT_CHR_ATTRIB49, IIT_CHR_ATTRIB50, 
 IIT_CHR_ATTRIB51, IIT_CHR_ATTRIB52, IIT_CHR_ATTRIB53, IIT_CHR_ATTRIB54, IIT_CHR_ATTRIB55, 
 IIT_CHR_ATTRIB56, IIT_CHR_ATTRIB57, IIT_CHR_ATTRIB58, IIT_CHR_ATTRIB59, IIT_CHR_ATTRIB60, 
 IIT_CHR_ATTRIB61, IIT_CHR_ATTRIB62, IIT_CHR_ATTRIB63, IIT_CHR_ATTRIB64, IIT_CHR_ATTRIB65, 
 IIT_CHR_ATTRIB66, IIT_CHR_ATTRIB67, IIT_CHR_ATTRIB68, IIT_CHR_ATTRIB69, IIT_CHR_ATTRIB70, 
 IIT_CHR_ATTRIB71, IIT_CHR_ATTRIB72, IIT_CHR_ATTRIB73, IIT_CHR_ATTRIB74, IIT_CHR_ATTRIB75, 
 IIT_NUM_ATTRIB76, IIT_NUM_ATTRIB77, IIT_NUM_ATTRIB78, IIT_NUM_ATTRIB79, IIT_NUM_ATTRIB80, 
 IIT_NUM_ATTRIB81, IIT_NUM_ATTRIB82, IIT_NUM_ATTRIB83, IIT_NUM_ATTRIB84, IIT_NUM_ATTRIB85, 
 IIT_DATE_ATTRIB86, IIT_DATE_ATTRIB87, IIT_DATE_ATTRIB88, IIT_DATE_ATTRIB89, IIT_DATE_ATTRIB90, 
 IIT_DATE_ATTRIB91, IIT_DATE_ATTRIB92, IIT_DATE_ATTRIB93, IIT_DATE_ATTRIB94, IIT_DATE_ATTRIB95,
 IIT_NUM_ATTRIB96, IIT_NUM_ATTRIB97,  IIT_NUM_ATTRIB98, IIT_NUM_ATTRIB99,IIT_NUM_ATTRIB100,
 IIT_NUM_ATTRIB101, IIT_NUM_ATTRIB102, IIT_NUM_ATTRIB103, IIT_NUM_ATTRIB104, IIT_NUM_ATTRIB105,
IIT_NUM_ATTRIB106, IIT_NUM_ATTRIB107, IIT_NUM_ATTRIB108, IIT_NUM_ATTRIB109, IIT_NUM_ATTRIB110,
IIT_NUM_ATTRIB111, IIT_NUM_ATTRIB112, IIT_NUM_ATTRIB113, IIT_NUM_ATTRIB114, IIT_NUM_ATTRIB115,
IIT_POSITION, IIT_X_COORD, IIT_Y_COORD, IIT_X, IIT_Y, IIT_Z
)
AS 
SELECT
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
          iit_date_created iit_created_date, iit_start_date iit_cre_date
        , inv.iit_ne_id iit_item_id, itt.ity_inv_code iit_ity_inv_code
        , itt.ity_sys_flag iit_ity_sys_flag
        , iit_date_modified iit_last_updated_date
        , nm_ne_id_of iit_rse_he_id, nm_begin_mp iit_st_chain
        , iit_angle, iit_angle_txt, iit_class, iit_class_txt, iit_colour
        , iit_colour_txt, iit_coord_flag, iit_description, iit_diagram
        , iit_distance, nm_end_mp iit_end_chain, iit_end_date, iit_gap
        , iit_height, iit_height_2, iit_id_code, iit_instal_date
        , iit_invent_date, iit_inv_ownership, iit_itemcode
        , iit_lco_lamp_config_id, iit_length, iit_material, iit_material_txt
        , iit_method, iit_method_txt, iit_note, iit_no_of_units, iit_options
        , iit_options_txt, iit_oun_org_id_elec_board, iit_owner
        , iit_owner_txt, iit_peo_invent_by_id, iit_photo, iit_power
        , iit_prov_flag, iit_rev_by, iit_rev_date, iit_type, iit_type_txt
        , iit_width, iit_xtra_char_1, iit_xtra_date_1, iit_xtra_domain_1
        , iit_xtra_domain_txt_1, iit_xtra_number_1, iit_x_sect
        , iit_primary_key, iit_foreign_key, iit_det_xsp, iit_offset
        , iit_num_attrib16, iit_num_attrib17, iit_num_attrib18
        , iit_num_attrib19, iit_num_attrib20, iit_num_attrib21
        , iit_num_attrib22, iit_num_attrib23, iit_num_attrib24
        , iit_num_attrib25, iit_chr_attrib26, iit_chr_attrib27
        , iit_chr_attrib28, iit_chr_attrib29, iit_chr_attrib30
        , iit_chr_attrib31, iit_chr_attrib32, iit_chr_attrib33
        , iit_chr_attrib34, iit_chr_attrib35, iit_chr_attrib36
        , iit_chr_attrib37, iit_chr_attrib38, iit_chr_attrib39
        , iit_chr_attrib40, iit_chr_attrib41, iit_chr_attrib42
        , iit_chr_attrib43, iit_chr_attrib44, iit_chr_attrib45
        , iit_chr_attrib46, iit_chr_attrib47, iit_chr_attrib48
        , iit_chr_attrib49, iit_chr_attrib50, iit_chr_attrib51
        , iit_chr_attrib52, iit_chr_attrib53, iit_chr_attrib54
        , iit_chr_attrib55, iit_chr_attrib56, iit_chr_attrib57
        , iit_chr_attrib58, iit_chr_attrib59, iit_chr_attrib60
        , iit_chr_attrib61, iit_chr_attrib62, iit_chr_attrib63
        , iit_chr_attrib64, iit_chr_attrib65, iit_chr_attrib66
        , iit_chr_attrib67, iit_chr_attrib68, iit_chr_attrib69
        , iit_chr_attrib70, iit_chr_attrib71, iit_chr_attrib72
        , iit_chr_attrib73, iit_chr_attrib74, iit_chr_attrib75
        , iit_num_attrib76, iit_num_attrib77, iit_num_attrib78
        , iit_num_attrib79, iit_num_attrib80, iit_num_attrib81
        , iit_num_attrib82, iit_num_attrib83, iit_num_attrib84
        , iit_num_attrib85, iit_date_attrib86, iit_date_attrib87
        , iit_date_attrib88, iit_date_attrib89, iit_date_attrib90
        , iit_date_attrib91, iit_date_attrib92, iit_date_attrib93
        , iit_date_attrib94, iit_date_attrib95, iit_num_attrib96
        , iit_num_attrib97, iit_num_attrib98, iit_num_attrib99
        , iit_num_attrib100, iit_num_attrib101, iit_num_attrib102
        , iit_num_attrib103, iit_num_attrib104, iit_num_attrib105
        , iit_num_attrib106, iit_num_attrib107, iit_num_attrib108
        , iit_num_attrib109, iit_num_attrib110, iit_num_attrib111
        , iit_num_attrib112, iit_num_attrib113, iit_num_attrib114
        , iit_num_attrib115, iit_position, iit_x_coord, iit_y_coord
        , iit_x, iit_y, iit_z
     FROM nm_inv_items_all inv
        , nm_members_all   mem
        , inv_type_translations itt
    WHERE mem.nm_ne_id_in = inv.iit_ne_id
    AND   mem.nm_type = 'I'
    AND   itt.nit_inv_type = inv.iit_inv_type;


CREATE OR REPLACE TRIGGER INV_ITEMS_D_TRG
 INSTEAD OF DELETE
 ON INV_ITEMS_ALL 
 FOR EACH ROW
--
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
BEGIN
        
--
   nm3inv.delete_inv_items(pi_inv_type        => :OLD.iit_ity_inv_code
                          ,pi_cascade         => TRUE
                          ,pi_where           => 'iit_ne_id = '||:old.iit_item_id);
--
END inv_items_d_trg;
/



CREATE OR REPLACE TRIGGER INV_ITEMS_I_TRG
 INSTEAD OF INSERT
 ON INV_ITEMS_ALL 
 FOR EACH ROW
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
DECLARE
--
   CURSOR cs_check (c_pk       nm_inv_items.iit_primary_key%TYPE
                   ,c_inv_type nm_inv_items.iit_inv_type%TYPE
                   ) IS
   SELECT ROWID
    FROM  nm_inv_items
   WHERE  iit_primary_key = c_pk
    AND   iit_inv_type    = c_inv_type;
--
   l_rec_iit    nm_inv_items%ROWTYPE;
   l_temp_ne_id NUMBER;
   l_inv_rowid  UROWID;
   l_effective_date DATE;
   l_warning_code VARCHAR2(80);
   l_warning_msg  VARCHAR2(80);
   l_pl_arr nm_placement_array;
--
BEGIN
--
   l_effective_date := To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY');
   nm3user.set_effective_date(:NEW.IIT_CRE_DATE);

--
   l_rec_iit.iit_ne_id := nm3net.get_next_ne_id;
--
   l_rec_iit.iit_start_date := TRUNC(:NEW.IIT_CRE_DATE);
   l_rec_iit.iit_inv_type := ity_to_nit(:NEW.IIT_ITY_INV_CODE);
   l_rec_iit.iit_ANGLE := :NEW.IIT_ANGLE;
   l_rec_iit.iit_ANGLE_TXT := :NEW.IIT_ANGLE_TXT;
   l_rec_iit.iit_CLASS := :NEW.IIT_CLASS;
   l_rec_iit.iit_CLASS_TXT := :NEW.IIT_CLASS_TXT;
   l_rec_iit.iit_COLOUR := :NEW.IIT_COLOUR;
   l_rec_iit.iit_COLOUR_TXT := :NEW.IIT_COLOUR_TXT;
   l_rec_iit.iit_COORD_FLAG := :NEW.IIT_COORD_FLAG;
   l_rec_iit.iit_DESCRIPTION := :NEW.IIT_DESCRIPTION;
   l_rec_iit.iit_DIAGRAM := :NEW.IIT_DIAGRAM;
   l_rec_iit.iit_DISTANCE := :NEW.IIT_DISTANCE;
   l_rec_iit.iit_END_DATE := :NEW.IIT_END_DATE;
   l_rec_iit.iit_GAP:= :NEW.IIT_GAP;
   l_rec_iit.iit_HEIGHT := :NEW.IIT_HEIGHT;
   l_rec_iit.iit_HEIGHT_2 := :NEW.IIT_HEIGHT_2;
   l_rec_iit.iit_ID_CODE := :NEW.IIT_ID_CODE;
   l_rec_iit.iit_INSTAL_DATE := :NEW.IIT_INSTAL_DATE;
   l_rec_iit.iit_INVENT_DATE := :NEW.IIT_INVENT_DATE;
   l_rec_iit.iit_INV_OWNERSHIP := :NEW.IIT_INV_OWNERSHIP;
   l_rec_iit.iit_ITEMCODE := :NEW.IIT_ITEMCODE;
   l_rec_iit.iit_LCO_LAMP_CONFIG_ID := :NEW.IIT_LCO_LAMP_CONFIG_ID;
   l_rec_iit.iit_LENGTH := :NEW.IIT_LENGTH;
   l_rec_iit.iit_MATERIAL := :NEW.IIT_MATERIAL;
   l_rec_iit.iit_MATERIAL_TXT := :NEW.IIT_MATERIAL_TXT;
   l_rec_iit.iit_METHOD := :NEW.IIT_METHOD;
   l_rec_iit.iit_METHOD_TXT := :NEW.IIT_METHOD_TXT;
   l_rec_iit.iit_NOTE := :NEW.IIT_NOTE;
   l_rec_iit.iit_NO_OF_UNITS := :NEW.IIT_NO_OF_UNITS;
   l_rec_iit.iit_OPTIONS := :NEW.IIT_OPTIONS;
   l_rec_iit.iit_OPTIONS_TXT := :NEW.IIT_OPTIONS_TXT;
   l_rec_iit.iit_OUN_ORG_ID_ELEC_BOARD := :NEW.IIT_OUN_ORG_ID_ELEC_BOARD;
   l_rec_iit.iit_OWNER := :NEW.IIT_OWNER;
   l_rec_iit.iit_OWNER_TXT := :NEW.IIT_OWNER_TXT;
   l_rec_iit.iit_PEO_INVENT_BY_ID := :NEW.IIT_PEO_INVENT_BY_ID;
   l_rec_iit.iit_PHOTO := :NEW.IIT_PHOTO;
   l_rec_iit.iit_POWER := :NEW.IIT_POWER;
   l_rec_iit.iit_PROV_FLAG := :NEW.IIT_PROV_FLAG;
   l_rec_iit.iit_REV_BY := :NEW.IIT_REV_BY;
   l_rec_iit.iit_REV_DATE := :NEW.IIT_REV_DATE;
   l_rec_iit.iit_TYPE := :NEW.IIT_TYPE;
   l_rec_iit.iit_TYPE_TXT := :NEW.IIT_TYPE_TXT;
   l_rec_iit.iit_WIDTH := :NEW.IIT_WIDTH;
   l_rec_iit.iit_XTRA_CHAR_1 := :NEW.IIT_XTRA_CHAR_1;
   l_rec_iit.iit_XTRA_DATE_1 := :NEW.IIT_XTRA_DATE_1;
   l_rec_iit.iit_XTRA_DOMAIN_1 := :NEW.IIT_XTRA_DOMAIN_1;
   l_rec_iit.iit_XTRA_DOMAIN_TXT_1 := :NEW.IIT_XTRA_DOMAIN_TXT_1;
   l_rec_iit.iit_XTRA_NUMBER_1 := :NEW.IIT_XTRA_NUMBER_1;
   l_rec_iit.iit_X_SECT := :NEW.IIT_X_SECT;
   l_rec_iit.iit_PRIMARY_KEY := :NEW.IIT_PRIMARY_KEY;
   l_rec_iit.iit_FOREIGN_KEY := :NEW.IIT_FOREIGN_KEY;
   l_rec_iit.iit_DET_XSP := :NEW.IIT_DET_XSP;
   l_rec_iit.iit_OFFSET := :NEW.IIT_OFFSET;
   l_rec_iit.iit_NUM_ATTRIB16 := :NEW.IIT_NUM_ATTRIB16;
   l_rec_iit.iit_NUM_ATTRIB17 := :NEW.IIT_NUM_ATTRIB17;
   l_rec_iit.iit_NUM_ATTRIB18 := :NEW.IIT_NUM_ATTRIB18;
   l_rec_iit.iit_NUM_ATTRIB19 := :NEW.IIT_NUM_ATTRIB19;
   l_rec_iit.iit_NUM_ATTRIB20 := :NEW.IIT_NUM_ATTRIB20;
   l_rec_iit.iit_NUM_ATTRIB21 := :NEW.IIT_NUM_ATTRIB21;
   l_rec_iit.iit_NUM_ATTRIB22 := :NEW.IIT_NUM_ATTRIB22;
   l_rec_iit.iit_NUM_ATTRIB23 := :NEW.IIT_NUM_ATTRIB23;
   l_rec_iit.iit_NUM_ATTRIB24 := :NEW.IIT_NUM_ATTRIB24;
   l_rec_iit.iit_NUM_ATTRIB25 := :NEW.IIT_NUM_ATTRIB25;
   l_rec_iit.iit_CHR_ATTRIB26 := :NEW.IIT_CHR_ATTRIB26;
   l_rec_iit.iit_CHR_ATTRIB27 := :NEW.IIT_CHR_ATTRIB27;
   l_rec_iit.iit_CHR_ATTRIB28 := :NEW.IIT_CHR_ATTRIB28;
   l_rec_iit.iit_CHR_ATTRIB29 := :NEW.IIT_CHR_ATTRIB29;
   l_rec_iit.iit_CHR_ATTRIB30 := :NEW.IIT_CHR_ATTRIB30;
   l_rec_iit.iit_CHR_ATTRIB31 := :NEW.IIT_CHR_ATTRIB31;
   l_rec_iit.iit_CHR_ATTRIB32 := :NEW.IIT_CHR_ATTRIB32;
   l_rec_iit.iit_CHR_ATTRIB33 := :NEW.IIT_CHR_ATTRIB33;
   l_rec_iit.iit_CHR_ATTRIB34 := :NEW.IIT_CHR_ATTRIB34;
   l_rec_iit.iit_CHR_ATTRIB35 := :NEW.IIT_CHR_ATTRIB35;
   l_rec_iit.iit_CHR_ATTRIB36 := :NEW.IIT_CHR_ATTRIB36;
   l_rec_iit.iit_CHR_ATTRIB37 := :NEW.IIT_CHR_ATTRIB37;
   l_rec_iit.iit_CHR_ATTRIB38 := :NEW.IIT_CHR_ATTRIB38;
   l_rec_iit.iit_CHR_ATTRIB39 := :NEW.IIT_CHR_ATTRIB39;
   l_rec_iit.iit_CHR_ATTRIB40 := :NEW.IIT_CHR_ATTRIB40;
   l_rec_iit.iit_CHR_ATTRIB41 := :NEW.IIT_CHR_ATTRIB41;
   l_rec_iit.iit_CHR_ATTRIB42 := :NEW.IIT_CHR_ATTRIB42;
   l_rec_iit.iit_CHR_ATTRIB43 := :NEW.IIT_CHR_ATTRIB43;
   l_rec_iit.iit_CHR_ATTRIB44 := :NEW.IIT_CHR_ATTRIB44;
   l_rec_iit.iit_CHR_ATTRIB45 := :NEW.IIT_CHR_ATTRIB45;
   l_rec_iit.iit_CHR_ATTRIB46 := :NEW.IIT_CHR_ATTRIB46;
   l_rec_iit.iit_CHR_ATTRIB47 := :NEW.IIT_CHR_ATTRIB47;
   l_rec_iit.iit_CHR_ATTRIB48 := :NEW.IIT_CHR_ATTRIB48;
   l_rec_iit.iit_CHR_ATTRIB49 := :NEW.IIT_CHR_ATTRIB49;
   l_rec_iit.iit_CHR_ATTRIB50 := :NEW.IIT_CHR_ATTRIB50;
   l_rec_iit.iit_CHR_ATTRIB51 := :NEW.IIT_CHR_ATTRIB51;
   l_rec_iit.iit_CHR_ATTRIB52 := :NEW.IIT_CHR_ATTRIB52;
   l_rec_iit.iit_CHR_ATTRIB53 := :NEW.IIT_CHR_ATTRIB53;
   l_rec_iit.iit_CHR_ATTRIB54 := :NEW.IIT_CHR_ATTRIB54;
   l_rec_iit.iit_CHR_ATTRIB55 := :NEW.IIT_CHR_ATTRIB55;
   l_rec_iit.iit_CHR_ATTRIB56 := :NEW.IIT_CHR_ATTRIB56;
   l_rec_iit.iit_CHR_ATTRIB57 := :NEW.IIT_CHR_ATTRIB57;
   l_rec_iit.iit_CHR_ATTRIB58 := :NEW.IIT_CHR_ATTRIB58;
   l_rec_iit.iit_CHR_ATTRIB59 := :NEW.IIT_CHR_ATTRIB59;
   l_rec_iit.iit_CHR_ATTRIB60 := :NEW.IIT_CHR_ATTRIB60;
   l_rec_iit.iit_CHR_ATTRIB61 := :NEW.IIT_CHR_ATTRIB61;
   l_rec_iit.iit_CHR_ATTRIB62 := :NEW.IIT_CHR_ATTRIB62;
   l_rec_iit.iit_CHR_ATTRIB63 := :NEW.IIT_CHR_ATTRIB63;
   l_rec_iit.iit_CHR_ATTRIB64 := :NEW.IIT_CHR_ATTRIB64;
   l_rec_iit.iit_CHR_ATTRIB65 := :NEW.IIT_CHR_ATTRIB65;
   l_rec_iit.iit_CHR_ATTRIB66 := :NEW.IIT_CHR_ATTRIB66;
   l_rec_iit.iit_CHR_ATTRIB67 := :NEW.IIT_CHR_ATTRIB67;
   l_rec_iit.iit_CHR_ATTRIB68 := :NEW.IIT_CHR_ATTRIB68;
   l_rec_iit.iit_CHR_ATTRIB69 := :NEW.IIT_CHR_ATTRIB69;
   l_rec_iit.iit_CHR_ATTRIB70 := :NEW.IIT_CHR_ATTRIB70;
   l_rec_iit.iit_CHR_ATTRIB71 := :NEW.IIT_CHR_ATTRIB71;
   l_rec_iit.iit_CHR_ATTRIB72 := :NEW.IIT_CHR_ATTRIB72;
   l_rec_iit.iit_CHR_ATTRIB73 := :NEW.IIT_CHR_ATTRIB73;
   l_rec_iit.iit_CHR_ATTRIB74 := :NEW.IIT_CHR_ATTRIB74;
   l_rec_iit.iit_CHR_ATTRIB75 := :NEW.IIT_CHR_ATTRIB75;
   l_rec_iit.iit_NUM_ATTRIB76 := :NEW.IIT_NUM_ATTRIB76;
   l_rec_iit.iit_NUM_ATTRIB77 := :NEW.IIT_NUM_ATTRIB77;
   l_rec_iit.iit_NUM_ATTRIB78 := :NEW.IIT_NUM_ATTRIB78;
   l_rec_iit.iit_NUM_ATTRIB79 := :NEW.IIT_NUM_ATTRIB79;
   l_rec_iit.iit_NUM_ATTRIB80 := :NEW.IIT_NUM_ATTRIB80;
   l_rec_iit.iit_NUM_ATTRIB81 := :NEW.IIT_NUM_ATTRIB81;
   l_rec_iit.iit_NUM_ATTRIB82 := :NEW.IIT_NUM_ATTRIB82;
   l_rec_iit.iit_NUM_ATTRIB83 := :NEW.IIT_NUM_ATTRIB83;
   l_rec_iit.iit_NUM_ATTRIB84 := :NEW.IIT_NUM_ATTRIB84;
   l_rec_iit.iit_NUM_ATTRIB85 := :NEW.IIT_NUM_ATTRIB85;
   l_rec_iit.iit_DATE_ATTRIB86 := :NEW.IIT_DATE_ATTRIB86;
   l_rec_iit.iit_DATE_ATTRIB87 := :NEW.IIT_DATE_ATTRIB87;
   l_rec_iit.iit_DATE_ATTRIB88 := :NEW.IIT_DATE_ATTRIB88;
   l_rec_iit.iit_DATE_ATTRIB89 := :NEW.IIT_DATE_ATTRIB89;
   l_rec_iit.iit_DATE_ATTRIB90 := :NEW.IIT_DATE_ATTRIB90;
   l_rec_iit.iit_DATE_ATTRIB91 := :NEW.IIT_DATE_ATTRIB91;
   l_rec_iit.iit_DATE_ATTRIB92 := :NEW.IIT_DATE_ATTRIB92;
   l_rec_iit.iit_DATE_ATTRIB93 := :NEW.IIT_DATE_ATTRIB93;
   l_rec_iit.iit_DATE_ATTRIB94 := :NEW.IIT_DATE_ATTRIB94;
   l_rec_iit.iit_DATE_ATTRIB95 := :NEW.IIT_DATE_ATTRIB95;
   l_rec_iit.iit_NUM_ATTRIB96 := :NEW.IIT_NUM_ATTRIB96;
   l_rec_iit.iit_NUM_ATTRIB97 := :NEW.IIT_NUM_ATTRIB97;
   l_rec_iit.iit_NUM_ATTRIB98 := :NEW.IIT_NUM_ATTRIB98;
   l_rec_iit.iit_NUM_ATTRIB99 := :NEW.IIT_NUM_ATTRIB99;
   l_rec_iit.IIT_NUM_ATTRIB100 := :NEW.IIT_NUM_ATTRIB100;
   l_rec_iit.IIT_NUM_ATTRIB101 := :NEW.IIT_NUM_ATTRIB101;
   l_rec_iit.IIT_NUM_ATTRIB102 := :NEW.IIT_NUM_ATTRIB102;
   l_rec_iit.IIT_NUM_ATTRIB103 := :NEW.IIT_NUM_ATTRIB103;
   l_rec_iit.IIT_NUM_ATTRIB104 := :NEW.IIT_NUM_ATTRIB104;
   l_rec_iit.IIT_NUM_ATTRIB105 := :NEW.IIT_NUM_ATTRIB105;
   l_rec_iit.IIT_NUM_ATTRIB106 := :NEW.IIT_NUM_ATTRIB106;
   l_rec_iit.IIT_NUM_ATTRIB107 := :NEW.IIT_NUM_ATTRIB107;
   l_rec_iit.IIT_NUM_ATTRIB108 := :NEW.IIT_NUM_ATTRIB108;
   l_rec_iit.IIT_NUM_ATTRIB109 := :NEW.IIT_NUM_ATTRIB109;
   l_rec_iit.IIT_NUM_ATTRIB110 := :NEW.IIT_NUM_ATTRIB110;
   l_rec_iit.IIT_NUM_ATTRIB111 := :NEW.IIT_NUM_ATTRIB111;
   l_rec_iit.IIT_NUM_ATTRIB112 := :NEW.IIT_NUM_ATTRIB112;
   l_rec_iit.IIT_NUM_ATTRIB113 := :NEW.IIT_NUM_ATTRIB113;
   l_rec_iit.IIT_NUM_ATTRIB114 := :NEW.IIT_NUM_ATTRIB114;
   l_rec_iit.IIT_NUM_ATTRIB115 := :NEW.IIT_NUM_ATTRIB115;
   l_rec_iit.IIT_POSITION := :NEW.IIT_POSITION;
   l_rec_iit.IIT_X_COORD := :NEW.IIT_X_COORD;
   l_rec_iit.IIT_Y_COORD := :NEW.IIT_Y_COORD;
   l_rec_iit.IIT_X := :NEW.IIT_X;
   l_rec_iit.IIT_Y := :NEW.IIT_Y;
   l_rec_iit.IIT_Z := :NEW.IIT_Z;
--
   IF l_rec_iit.iit_start_date IS NULL
    THEN
      l_rec_iit.iit_start_date := To_Date(Sys_Context('NM3CORE','EFFECTIVE_DATE'),'DD-MON-YYYY');
   END IF;
--
   IF l_rec_iit.iit_primary_key IS NULL
    THEN
      l_rec_iit.iit_primary_key := l_rec_iit.iit_ne_id;
   END IF;
--
-- Derive admin unit from road
--
   IF l_rec_iit.iit_admin_unit IS NULL
    THEN
	   l_rec_iit.iit_admin_unit := nvl(nm3get.get_ne (pi_ne_id => :NEW.iit_rse_he_id).ne_admin_unit,1);
   END IF;
--
--
   OPEN  cs_check (l_rec_iit.iit_primary_key, l_rec_iit.iit_inv_type);
   FETCH cs_check INTO l_inv_rowid;
   IF cs_check%FOUND
    THEN
      UPDATE nm_inv_items
       SET   iit_end_date = nvl(l_rec_iit.iit_start_date,l_rec_iit.iit_end_date)
      WHERE  ROWID        = l_inv_rowid
        AND  l_rec_iit.iit_end_date IS NULL;
   END IF;
   CLOSE cs_check;
--
   IF l_rec_iit.iit_end_date IS NULL THEN
      nm3inv.insert_nm_inv_items (l_rec_iit);
   END IF;
--
--
   IF l_rec_iit.iit_end_date IS NOT NULL THEN
      l_rec_iit.iit_ne_id :=
      nm3xml_load.get_existing_inv_item( pi_inv_type   => l_rec_iit.iit_inv_type
                                        ,pi_nte_job_id => l_temp_ne_id
                                        ,pi_end_date => l_rec_iit.iit_end_date
                                       );
--
      l_temp_ne_id := NM3XML_LOAD.GET_TEMP_EXTENT( pi_iit_ne_id  => l_rec_iit.iit_ne_id
                                                  ,pi_nte_job_id => l_temp_ne_id
                                                 );
--
      l_rec_iit.iit_start_date := l_rec_iit.iit_END_date;
--
   END IF;
--
   if :new.iit_rse_he_id is null then
     raise_application_error(-20099, 'Inventory view requires a location');
   else

--   create a temp extent from the rse_he_id of the object and locate the asset relativeto this.

     nm3extent.create_temp_ne
        (pi_source_id => :new.iit_rse_he_id
        ,pi_source    => nm3extent.c_route
        ,pi_begin_mp  => :NEW.iit_st_chain
        ,pi_end_mp    => :NEW.iit_end_chain
        ,po_job_id    => l_temp_ne_id
       );

   end if;

   IF l_temp_ne_id = -1 THEN

      nm3homo.end_inv_location( pi_iit_ne_id      => l_rec_iit.iit_ne_id
                               ,pi_effective_date => l_rec_iit.iit_start_date
                               ,po_warning_code   => l_warning_code
                               ,po_warning_msg    => l_warning_msg
                               ,pi_ignore_item_loc_mand => true
                              );
   ELSE
      IF l_temp_ne_id IS NOT NULL THEN

         nm3homo.homo_update
           (p_temp_ne_id_in  => l_temp_ne_id
           ,p_iit_ne_id      => l_rec_iit.iit_ne_id
           ,p_effective_date => l_rec_iit.iit_start_date
           );
      END IF;
   END IF;

   nm3user.set_effective_date(l_effective_date);
--
EXCEPTION
   WHEN OTHERS THEN
       nm3user.set_effective_date(l_effective_date);
       RAISE;
END inv_items_i_trg;
/

CREATE OR REPLACE TRIGGER INV_ITEMS_U_TRG
 INSTEAD OF UPDATE
 ON INV_ITEMS_ALL 
 FOR EACH ROW
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
DECLARE
--
   l_rec_iit        nm_inv_items%ROWTYPE;
   l_temp_ne_id     NUMBER;
   l_warning_code   VARCHAR2(80);
   l_warning_msg    VARCHAR2(80);
   l_pl_arr nm_placement_array;
--
BEGIN
--
   IF :NEW.iit_item_id IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001
	                         , 'No item id');
   END IF;
--
   IF :NEW.iit_item_id != :OLD.iit_item_id THEN
      RAISE_APPLICATION_ERROR(-20002
	                         , 'Update of item id not allowed');
   END IF;
--
   IF :NEW.iit_rse_he_id != :OLD.iit_rse_he_id THEN
      RAISE_APPLICATION_ERROR(-20003
	                         , 'Update of rse_he_id not allowed');
   END IF;
--
   IF :NEW.iit_rse_he_id IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004
	                         , 'Inventory view requires a location');
   END IF;
--
   l_rec_iit.iit_ne_id         := :NEW.iit_item_id;
   l_rec_iit.iit_start_date    := :NEW.iit_cre_date;
   l_rec_iit.iit_ne_id         := :NEW.iit_item_id;
   l_rec_iit.iit_inv_type      := ity_to_nit(:NEW.iit_ity_inv_code);
   l_rec_iit.iit_angle         := :NEW.iit_angle;
   l_rec_iit.iit_angle_txt     := :NEW.iit_angle_txt;
   l_rec_iit.iit_class         := :NEW.iit_class;
   l_rec_iit.iit_class_txt     := :NEW.iit_class_txt;
   l_rec_iit.iit_colour        := :NEW.iit_colour;
   l_rec_iit.iit_colour_txt    := :NEW.iit_colour_txt;
   l_rec_iit.iit_coord_flag    := :NEW.iit_coord_flag;
   l_rec_iit.iit_description   := :NEW.iit_description;
   l_rec_iit.iit_diagram       := :NEW.iit_diagram;
   l_rec_iit.iit_distance      := :NEW.iit_distance;
   l_rec_iit.iit_end_date      := TRUNC(:NEW.iit_end_date);
   l_rec_iit.iit_gap           := :NEW.iit_gap;
   l_rec_iit.iit_height        := :NEW.iit_height;
   l_rec_iit.iit_height_2      := :NEW.iit_height_2;
   l_rec_iit.iit_id_code       := :NEW.iit_id_code;
   l_rec_iit.iit_instal_date   := :NEW.iit_instal_date;
   l_rec_iit.iit_invent_date   := :NEW.iit_invent_date;
   l_rec_iit.iit_inv_ownership := :NEW.iit_inv_ownership;
   l_rec_iit.iit_itemcode      := :NEW.iit_itemcode;
   l_rec_iit.iit_lco_lamp_config_id :=
                                  :NEW.iit_lco_lamp_config_id;
   l_rec_iit.iit_length        := :NEW.iit_length;
   l_rec_iit.iit_material      := :NEW.iit_material;
   l_rec_iit.iit_material_txt  := :NEW.iit_material_txt;
   l_rec_iit.iit_method        := :NEW.iit_method;
   l_rec_iit.iit_method_txt    := :NEW.iit_method_txt;
   l_rec_iit.iit_note          := :NEW.iit_note;
   l_rec_iit.iit_no_of_units   := :NEW.iit_no_of_units;
   l_rec_iit.iit_options       := :NEW.iit_options;
   l_rec_iit.iit_options_txt   := :NEW.iit_options_txt;
   l_rec_iit.iit_oun_org_id_elec_board :=
                                  :NEW.iit_oun_org_id_elec_board;
   l_rec_iit.iit_owner         := :NEW.iit_owner;
   l_rec_iit.iit_owner_txt     := :NEW.iit_owner_txt;
   l_rec_iit.iit_peo_invent_by_id :=
                                  :NEW.iit_peo_invent_by_id;
   l_rec_iit.iit_photo         := :NEW.iit_photo;
   l_rec_iit.iit_power         := :NEW.iit_power;
   l_rec_iit.iit_prov_flag     := :NEW.iit_prov_flag;
   l_rec_iit.iit_rev_by        := :NEW.iit_rev_by;
   l_rec_iit.iit_rev_date      := :NEW.iit_rev_date;
   l_rec_iit.iit_type          := :NEW.iit_type;
   l_rec_iit.iit_type_txt      := :NEW.iit_type_txt;
   l_rec_iit.iit_width         := :NEW.iit_width;
   l_rec_iit.iit_xtra_char_1   := :NEW.iit_xtra_char_1;
   l_rec_iit.iit_xtra_date_1   := :NEW.iit_xtra_date_1;
   l_rec_iit.iit_xtra_domain_1 := :NEW.iit_xtra_domain_1;
   l_rec_iit.iit_xtra_domain_txt_1 :=
                                  :NEW.iit_xtra_domain_txt_1;
   l_rec_iit.iit_xtra_number_1 := :NEW.iit_xtra_number_1;
   l_rec_iit.iit_x_sect        := :NEW.iit_x_sect;
   l_rec_iit.iit_primary_key   := :NEW.iit_primary_key;
   l_rec_iit.iit_foreign_key   := :NEW.iit_foreign_key;
   l_rec_iit.iit_det_xsp       := :NEW.iit_det_xsp;
   l_rec_iit.iit_offset        := :NEW.iit_offset;
   l_rec_iit.iit_num_attrib16  := :NEW.iit_num_attrib16;
   l_rec_iit.iit_num_attrib17  := :NEW.iit_num_attrib17;
   l_rec_iit.iit_num_attrib18  := :NEW.iit_num_attrib18;
   l_rec_iit.iit_num_attrib19  := :NEW.iit_num_attrib19;
   l_rec_iit.iit_num_attrib20  := :NEW.iit_num_attrib20;
   l_rec_iit.iit_num_attrib21  := :NEW.iit_num_attrib21;
   l_rec_iit.iit_num_attrib22  := :NEW.iit_num_attrib22;
   l_rec_iit.iit_num_attrib23  := :NEW.iit_num_attrib23;
   l_rec_iit.iit_num_attrib24  := :NEW.iit_num_attrib24;
   l_rec_iit.iit_num_attrib25  := :NEW.iit_num_attrib25;
   l_rec_iit.iit_chr_attrib26  := :NEW.iit_chr_attrib26;
   l_rec_iit.iit_chr_attrib27  := :NEW.iit_chr_attrib27;
   l_rec_iit.iit_chr_attrib28  := :NEW.iit_chr_attrib28;
   l_rec_iit.iit_chr_attrib29  := :NEW.iit_chr_attrib29;
   l_rec_iit.iit_chr_attrib30  := :NEW.iit_chr_attrib30;
   l_rec_iit.iit_chr_attrib31  := :NEW.iit_chr_attrib31;
   l_rec_iit.iit_chr_attrib32  := :NEW.iit_chr_attrib32;
   l_rec_iit.iit_chr_attrib33  := :NEW.iit_chr_attrib33;
   l_rec_iit.iit_chr_attrib34  := :NEW.iit_chr_attrib34;
   l_rec_iit.iit_chr_attrib35  := :NEW.iit_chr_attrib35;
   l_rec_iit.iit_chr_attrib36  := :NEW.iit_chr_attrib36;
   l_rec_iit.iit_chr_attrib37  := :NEW.iit_chr_attrib37;
   l_rec_iit.iit_chr_attrib38  := :NEW.iit_chr_attrib38;
   l_rec_iit.iit_chr_attrib39  := :NEW.iit_chr_attrib39;
   l_rec_iit.iit_chr_attrib40  := :NEW.iit_chr_attrib40;
   l_rec_iit.iit_chr_attrib41  := :NEW.iit_chr_attrib41;
   l_rec_iit.iit_chr_attrib42  := :NEW.iit_chr_attrib42;
   l_rec_iit.iit_chr_attrib43  := :NEW.iit_chr_attrib43;
   l_rec_iit.iit_chr_attrib44  := :NEW.iit_chr_attrib44;
   l_rec_iit.iit_chr_attrib45  := :NEW.iit_chr_attrib45;
   l_rec_iit.iit_chr_attrib46  := :NEW.iit_chr_attrib46;
   l_rec_iit.iit_chr_attrib47  := :NEW.iit_chr_attrib47;
   l_rec_iit.iit_chr_attrib48  := :NEW.iit_chr_attrib48;
   l_rec_iit.iit_chr_attrib49  := :NEW.iit_chr_attrib49;
   l_rec_iit.iit_chr_attrib50  := :NEW.iit_chr_attrib50;
   l_rec_iit.iit_chr_attrib51  := :NEW.iit_chr_attrib51;
   l_rec_iit.iit_chr_attrib52  := :NEW.iit_chr_attrib52;
   l_rec_iit.iit_chr_attrib53  := :NEW.iit_chr_attrib53;
   l_rec_iit.iit_chr_attrib54  := :NEW.iit_chr_attrib54;
   l_rec_iit.iit_chr_attrib55  := :NEW.iit_chr_attrib55;
   l_rec_iit.iit_chr_attrib56  := :NEW.iit_chr_attrib56;
   l_rec_iit.iit_chr_attrib57  := :NEW.iit_chr_attrib57;
   l_rec_iit.iit_chr_attrib58  := :NEW.iit_chr_attrib58;
   l_rec_iit.iit_chr_attrib59  := :NEW.iit_chr_attrib59;
   l_rec_iit.iit_chr_attrib60  := :NEW.iit_chr_attrib60;
   l_rec_iit.iit_chr_attrib61  := :NEW.iit_chr_attrib61;
   l_rec_iit.iit_chr_attrib62  := :NEW.iit_chr_attrib62;
   l_rec_iit.iit_chr_attrib63  := :NEW.iit_chr_attrib63;
   l_rec_iit.iit_chr_attrib64  := :NEW.iit_chr_attrib64;
   l_rec_iit.iit_chr_attrib65  := :NEW.iit_chr_attrib65;
   l_rec_iit.iit_chr_attrib66  := :NEW.iit_chr_attrib66;
   l_rec_iit.iit_chr_attrib67  := :NEW.iit_chr_attrib67;
   l_rec_iit.iit_chr_attrib68  := :NEW.iit_chr_attrib68;
   l_rec_iit.iit_chr_attrib69  := :NEW.iit_chr_attrib69;
   l_rec_iit.iit_chr_attrib70  := :NEW.iit_chr_attrib70;
   l_rec_iit.iit_chr_attrib71  := :NEW.iit_chr_attrib71;
   l_rec_iit.iit_chr_attrib72  := :NEW.iit_chr_attrib72;
   l_rec_iit.iit_chr_attrib73  := :NEW.iit_chr_attrib73;
   l_rec_iit.iit_chr_attrib74  := :NEW.iit_chr_attrib74;
   l_rec_iit.iit_chr_attrib75  := :NEW.iit_chr_attrib75;
   l_rec_iit.iit_num_attrib76  := :NEW.iit_num_attrib76;
   l_rec_iit.iit_num_attrib77  := :NEW.iit_num_attrib77;
   l_rec_iit.iit_num_attrib78  := :NEW.iit_num_attrib78;
   l_rec_iit.iit_num_attrib79  := :NEW.iit_num_attrib79;
   l_rec_iit.iit_num_attrib80  := :NEW.iit_num_attrib80;
   l_rec_iit.iit_num_attrib81  := :NEW.iit_num_attrib81;
   l_rec_iit.iit_num_attrib82  := :NEW.iit_num_attrib82;
   l_rec_iit.iit_num_attrib83  := :NEW.iit_num_attrib83;
   l_rec_iit.iit_num_attrib84  := :NEW.iit_num_attrib84;
   l_rec_iit.iit_num_attrib85  := :NEW.iit_num_attrib85;
   l_rec_iit.iit_date_attrib86 := :NEW.iit_date_attrib86;
   l_rec_iit.iit_date_attrib87 := :NEW.iit_date_attrib87;
   l_rec_iit.iit_date_attrib88 := :NEW.iit_date_attrib88;
   l_rec_iit.iit_date_attrib89 := :NEW.iit_date_attrib89;
   l_rec_iit.iit_date_attrib90 := :NEW.iit_date_attrib90;
   l_rec_iit.iit_date_attrib91 := :NEW.iit_date_attrib91;
   l_rec_iit.iit_date_attrib92 := :NEW.iit_date_attrib92;
   l_rec_iit.iit_date_attrib93 := :NEW.iit_date_attrib93;
   l_rec_iit.iit_date_attrib94 := :NEW.iit_date_attrib94;
   l_rec_iit.iit_date_attrib95 := :NEW.iit_date_attrib95;
   l_rec_iit.iit_num_attrib96 := :NEW.iit_num_attrib96;
   l_rec_iit.iit_num_attrib97 := :NEW.iit_num_attrib97;
   l_rec_iit.iit_num_attrib98 := :NEW.iit_num_attrib98;
   l_rec_iit.iit_num_attrib99 := :NEW.iit_num_attrib99;
   l_rec_iit.iit_num_attrib100 := :NEW.iit_num_attrib100;
   l_rec_iit.iit_num_attrib101 := :NEW.iit_num_attrib101;
   l_rec_iit.iit_num_attrib102 := :NEW.iit_num_attrib102;
   l_rec_iit.iit_num_attrib103 := :NEW.iit_num_attrib103;
   l_rec_iit.iit_num_attrib104 := :NEW.iit_num_attrib104;
   l_rec_iit.iit_num_attrib105 := :NEW.iit_num_attrib105;
   l_rec_iit.iit_num_attrib106 := :NEW.iit_num_attrib106;
   l_rec_iit.iit_num_attrib107 := :NEW.iit_num_attrib107;
   l_rec_iit.iit_num_attrib108 := :NEW.iit_num_attrib108;
   l_rec_iit.iit_num_attrib109 := :NEW.iit_num_attrib109;
   l_rec_iit.iit_num_attrib110 := :NEW.iit_num_attrib110;
   l_rec_iit.iit_num_attrib111 := :NEW.iit_num_attrib111;
   l_rec_iit.iit_num_attrib112 := :NEW.iit_num_attrib112;
   l_rec_iit.iit_num_attrib113 := :NEW.iit_num_attrib113;
   l_rec_iit.iit_num_attrib114 := :NEW.iit_num_attrib114;
   l_rec_iit.iit_num_attrib115 := :NEW.iit_num_attrib115;
   l_rec_iit.iit_position := :NEW.iit_position;
   l_rec_iit.iit_x_coord := :NEW.iit_x_coord;
   l_rec_iit.iit_y_coord := :NEW.iit_y_coord;
   l_rec_iit.iit_x := :NEW.iit_x;
   l_rec_iit.iit_y := :NEW.iit_y;
   l_rec_iit.iit_z := :NEW.iit_z;

--
   IF l_rec_iit.iit_primary_key IS NULL THEN
      l_rec_iit.iit_primary_key := l_rec_iit.iit_ne_id;
   END IF;

   IF :NEW.iit_st_chain  != :OLD.iit_st_chain
   OR :NEW.iit_end_chain != :OLD.iit_end_chain THEN

      l_temp_ne_id := nm3xml_load.get_temp_extent
          ( pi_iit_ne_id  => l_rec_iit.iit_ne_id
          , pi_nte_job_id => l_temp_ne_id );

      nm3extent.create_temp_ne
          ( pi_source_id  => :NEW.iit_rse_he_id
          , pi_source     => nm3extent.c_route
          , pi_begin_mp   => :NEW.iit_st_chain
          , pi_end_mp     => :NEW.iit_end_chain
          , po_job_id     => l_temp_ne_id );

       IF l_temp_ne_id = -1 THEN
          nm3homo.end_inv_location( pi_iit_ne_id      => l_rec_iit.iit_ne_id
                                   ,pi_effective_date => l_rec_iit.iit_start_date
                                   ,po_warning_code   => l_warning_code
                                   ,po_warning_msg    => l_warning_msg
                                   ,pi_ignore_item_loc_mand => TRUE
                                  );
       ELSE
             nm3homo.homo_update
               (p_temp_ne_id_in  => l_temp_ne_id
               ,p_iit_ne_id      => l_rec_iit.iit_ne_id
               ,p_effective_date => l_rec_iit.iit_start_date
               );
       END IF;

   END IF;

   UPDATE nm_inv_items
      SET iit_angle         = :NEW.iit_angle
         ,iit_angle_txt     = :NEW.iit_angle_txt
         ,iit_class         = :NEW.iit_class
         ,iit_class_txt     = :NEW.iit_class_txt
         ,iit_colour        = :NEW.iit_colour
         ,iit_colour_txt    = :NEW.iit_colour_txt
         ,iit_coord_flag    = :NEW.iit_coord_flag
         ,iit_description   = :NEW.iit_description
         ,iit_diagram       = :NEW.iit_diagram
         ,iit_distance      = :NEW.iit_distance
         ,iit_end_date      = TRUNC(:NEW.iit_end_date)
         ,iit_gap           = :NEW.iit_gap
         ,iit_height        = :NEW.iit_height
         ,iit_height_2      = :NEW.iit_height_2
         ,iit_id_code       = :NEW.iit_id_code
         ,iit_instal_date   = :NEW.iit_instal_date
         ,iit_invent_date   = :NEW.iit_invent_date
         ,iit_inv_ownership = :NEW.iit_inv_ownership
         ,iit_itemcode      = :NEW.iit_itemcode
         ,iit_lco_lamp_config_id = :NEW.iit_lco_lamp_config_id
         ,iit_length        = :NEW.iit_length
         ,iit_material      = :NEW.iit_material
         ,iit_material_txt  = :NEW.iit_material_txt
         ,iit_method        = :NEW.iit_method
         ,iit_method_txt    = :NEW.iit_method_txt
         ,iit_note          = :NEW.iit_note
         ,iit_no_of_units   = :NEW.iit_no_of_units
         ,iit_options       = :NEW.iit_options
         ,iit_options_txt   = :NEW.iit_options_txt
         ,iit_oun_org_id_elec_board = :NEW.iit_oun_org_id_elec_board
         ,iit_owner         = :NEW.iit_owner
         ,iit_owner_txt     = :NEW.iit_owner_txt
         ,iit_peo_invent_by_id = :NEW.iit_peo_invent_by_id
         ,iit_photo         = :NEW.iit_photo
         ,iit_power         = :NEW.iit_power
         ,iit_prov_flag     = :NEW.iit_prov_flag
         ,iit_rev_by        = :NEW.iit_rev_by
         ,iit_rev_date      = :NEW.iit_rev_date
         ,iit_type          = :NEW.iit_type
         ,iit_type_txt      = :NEW.iit_type_txt
         ,iit_width         = :NEW.iit_width
         ,iit_xtra_char_1   = :NEW.iit_xtra_char_1
         ,iit_xtra_date_1   = :NEW.iit_xtra_date_1
         ,iit_xtra_domain_1 = :NEW.iit_xtra_domain_1
         ,iit_xtra_domain_txt_1 = :NEW.iit_xtra_domain_txt_1
         ,iit_xtra_number_1 = :NEW.iit_xtra_number_1
         ,iit_x_sect        = :NEW.iit_x_sect
         ,iit_primary_key   = :NEW.iit_primary_key
         ,iit_foreign_key   = :NEW.iit_foreign_key
         ,iit_det_xsp       = :NEW.iit_det_xsp
         ,iit_offset        = :NEW.iit_offset
         ,iit_num_attrib16  = :NEW.iit_num_attrib16
         ,iit_num_attrib17  = :NEW.iit_num_attrib17
         ,iit_num_attrib18  = :NEW.iit_num_attrib18
         ,iit_num_attrib19  = :NEW.iit_num_attrib19
         ,iit_num_attrib20  = :NEW.iit_num_attrib20
         ,iit_num_attrib21  = :NEW.iit_num_attrib21
         ,iit_num_attrib22  = :NEW.iit_num_attrib22
         ,iit_num_attrib23  = :NEW.iit_num_attrib23
         ,iit_num_attrib24  = :NEW.iit_num_attrib24
         ,iit_num_attrib25  = :NEW.iit_num_attrib25
         ,iit_chr_attrib26  = :NEW.iit_chr_attrib26
         ,iit_chr_attrib27  = :NEW.iit_chr_attrib27
         ,iit_chr_attrib28  = :NEW.iit_chr_attrib28
         ,iit_chr_attrib29  = :NEW.iit_chr_attrib29
         ,iit_chr_attrib30  = :NEW.iit_chr_attrib30
         ,iit_chr_attrib31  = :NEW.iit_chr_attrib31
         ,iit_chr_attrib32  = :NEW.iit_chr_attrib32
         ,iit_chr_attrib33  = :NEW.iit_chr_attrib33
         ,iit_chr_attrib34  = :NEW.iit_chr_attrib34
         ,iit_chr_attrib35  = :NEW.iit_chr_attrib35
         ,iit_chr_attrib36  = :NEW.iit_chr_attrib36
         ,iit_chr_attrib37  = :NEW.iit_chr_attrib37
         ,iit_chr_attrib38  = :NEW.iit_chr_attrib38
         ,iit_chr_attrib39  = :NEW.iit_chr_attrib39
         ,iit_chr_attrib40  = :NEW.iit_chr_attrib40
         ,iit_chr_attrib41  = :NEW.iit_chr_attrib41
         ,iit_chr_attrib42  = :NEW.iit_chr_attrib42
         ,iit_chr_attrib43  = :NEW.iit_chr_attrib43
         ,iit_chr_attrib44  = :NEW.iit_chr_attrib44
         ,iit_chr_attrib45  = :NEW.iit_chr_attrib45
         ,iit_chr_attrib46  = :NEW.iit_chr_attrib46
         ,iit_chr_attrib47  = :NEW.iit_chr_attrib47
         ,iit_chr_attrib48  = :NEW.iit_chr_attrib48
         ,iit_chr_attrib49  = :NEW.iit_chr_attrib49
         ,iit_chr_attrib50  = :NEW.iit_chr_attrib50
         ,iit_chr_attrib51  = :NEW.iit_chr_attrib51
         ,iit_chr_attrib52  = :NEW.iit_chr_attrib52
         ,iit_chr_attrib53  = :NEW.iit_chr_attrib53
         ,iit_chr_attrib54  = :NEW.iit_chr_attrib54
         ,iit_chr_attrib55  = :NEW.iit_chr_attrib55
         ,iit_chr_attrib56  = :NEW.iit_chr_attrib56
         ,iit_chr_attrib57  = :NEW.iit_chr_attrib57
         ,iit_chr_attrib58  = :NEW.iit_chr_attrib58
         ,iit_chr_attrib59  = :NEW.iit_chr_attrib59
         ,iit_chr_attrib60  = :NEW.iit_chr_attrib60
         ,iit_chr_attrib61  = :NEW.iit_chr_attrib61
         ,iit_chr_attrib62  = :NEW.iit_chr_attrib62
         ,iit_chr_attrib63  = :NEW.iit_chr_attrib63
         ,iit_chr_attrib64  = :NEW.iit_chr_attrib64
         ,iit_chr_attrib65  = :NEW.iit_chr_attrib65
         ,iit_chr_attrib66  = :NEW.iit_chr_attrib66
         ,iit_chr_attrib67  = :NEW.iit_chr_attrib67
         ,iit_chr_attrib68  = :NEW.iit_chr_attrib68
         ,iit_chr_attrib69  = :NEW.iit_chr_attrib69
         ,iit_chr_attrib70  = :NEW.iit_chr_attrib70
         ,iit_chr_attrib71  = :NEW.iit_chr_attrib71
         ,iit_chr_attrib72  = :NEW.iit_chr_attrib72
         ,iit_chr_attrib73  = :NEW.iit_chr_attrib73
         ,iit_chr_attrib74  = :NEW.iit_chr_attrib74
         ,iit_chr_attrib75  = :NEW.iit_chr_attrib75
         ,iit_num_attrib76  = :NEW.iit_num_attrib76
         ,iit_num_attrib77  = :NEW.iit_num_attrib77
         ,iit_num_attrib78  = :NEW.iit_num_attrib78
         ,iit_num_attrib79  = :NEW.iit_num_attrib79
         ,iit_num_attrib80  = :NEW.iit_num_attrib80
         ,iit_num_attrib81  = :NEW.iit_num_attrib81
         ,iit_num_attrib82  = :NEW.iit_num_attrib82
         ,iit_num_attrib83  = :NEW.iit_num_attrib83
         ,iit_num_attrib84  = :NEW.iit_num_attrib84
         ,iit_num_attrib85  = :NEW.iit_num_attrib85
         ,iit_date_attrib86 = :NEW.iit_date_attrib86
         ,iit_date_attrib87 = :NEW.iit_date_attrib87
         ,iit_date_attrib88 = :NEW.iit_date_attrib88
         ,iit_date_attrib89 = :NEW.iit_date_attrib89
         ,iit_date_attrib90 = :NEW.iit_date_attrib90
         ,iit_date_attrib91 = :NEW.iit_date_attrib91
         ,iit_date_attrib92 = :NEW.iit_date_attrib92
         ,iit_date_attrib93 = :NEW.iit_date_attrib93
         ,iit_date_attrib94 = :NEW.iit_date_attrib94
         ,iit_date_attrib95 = :NEW.iit_date_attrib95
         ,iit_num_attrib96 = :NEW.iit_num_attrib96
         ,iit_num_attrib97 = :NEW.iit_num_attrib97
         ,iit_num_attrib98 = :NEW.iit_num_attrib98
         ,iit_num_attrib99 = :NEW.iit_num_attrib99
         ,iit_num_attrib100 = :NEW.iit_num_attrib100
         ,iit_num_attrib101 = :NEW.iit_num_attrib101
         ,iit_num_attrib102 = :NEW.iit_num_attrib102
         ,iit_num_attrib103 = :NEW.iit_num_attrib103
         ,iit_num_attrib104 = :NEW.iit_num_attrib104
         ,iit_num_attrib105 = :NEW.iit_num_attrib105
         ,iit_num_attrib106 = :NEW.iit_num_attrib106
         ,iit_num_attrib107 = :NEW.iit_num_attrib107
         ,iit_num_attrib108 = :NEW.iit_num_attrib108
         ,iit_num_attrib109 = :NEW.iit_num_attrib109
         ,iit_num_attrib110 = :NEW.iit_num_attrib110
         ,iit_num_attrib111 = :NEW.iit_num_attrib111
         ,iit_num_attrib112 = :NEW.iit_num_attrib112
         ,iit_num_attrib113 = :NEW.iit_num_attrib113
         ,iit_num_attrib114 = :NEW.iit_num_attrib114
         ,iit_num_attrib115 = :NEW.iit_num_attrib115
         ,iit_position = :NEW.iit_position
         ,iit_x_coord = :NEW.iit_x_coord
         ,iit_y_coord = :NEW.iit_y_coord
         ,iit_x = :NEW.iit_x
         ,iit_y = :NEW.iit_y
         ,iit_z = :NEW.iit_z
       WHERE iit_ne_id         = :NEW.iit_item_id;

END inv_items_u_trg;
/


CREATE OR REPLACE FORCE VIEW INV_ITEMS
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
(IIT_CREATED_DATE, IIT_CRE_DATE, IIT_ITEM_ID, IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, 
 IIT_LAST_UPDATED_DATE, IIT_RSE_HE_ID, IIT_ST_CHAIN, IIT_ANGLE, IIT_ANGLE_TXT, 
 IIT_CLASS, IIT_CLASS_TXT, IIT_COLOUR, IIT_COLOUR_TXT, IIT_COORD_FLAG, 
 IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE, IIT_END_CHAIN, IIT_END_DATE, 
 IIT_GAP, IIT_HEIGHT, IIT_HEIGHT_2, IIT_ID_CODE, IIT_INSTAL_DATE, 
 IIT_INVENT_DATE, IIT_INV_OWNERSHIP, IIT_ITEMCODE, IIT_LCO_LAMP_CONFIG_ID, IIT_LENGTH, 
 IIT_MATERIAL, IIT_MATERIAL_TXT, IIT_METHOD, IIT_METHOD_TXT, IIT_NOTE, 
 IIT_NO_OF_UNITS, IIT_OPTIONS, IIT_OPTIONS_TXT, IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER, 
 IIT_OWNER_TXT, IIT_PEO_INVENT_BY_ID, IIT_PHOTO, IIT_POWER, IIT_PROV_FLAG, 
 IIT_REV_BY, IIT_REV_DATE, IIT_TYPE, IIT_TYPE_TXT, IIT_WIDTH, 
 IIT_XTRA_CHAR_1, IIT_XTRA_DATE_1, IIT_XTRA_DOMAIN_1, IIT_XTRA_DOMAIN_TXT_1, IIT_XTRA_NUMBER_1, 
 IIT_X_SECT, IIT_PRIMARY_KEY, IIT_FOREIGN_KEY, IIT_DET_XSP, IIT_OFFSET, 
 IIT_NUM_ATTRIB16, IIT_NUM_ATTRIB17, IIT_NUM_ATTRIB18, IIT_NUM_ATTRIB19, IIT_NUM_ATTRIB20, 
 IIT_NUM_ATTRIB21, IIT_NUM_ATTRIB22, IIT_NUM_ATTRIB23, IIT_NUM_ATTRIB24, IIT_NUM_ATTRIB25, 
 IIT_CHR_ATTRIB26, IIT_CHR_ATTRIB27, IIT_CHR_ATTRIB28, IIT_CHR_ATTRIB29, IIT_CHR_ATTRIB30, 
 IIT_CHR_ATTRIB31, IIT_CHR_ATTRIB32, IIT_CHR_ATTRIB33, IIT_CHR_ATTRIB34, IIT_CHR_ATTRIB35, 
 IIT_CHR_ATTRIB36, IIT_CHR_ATTRIB37, IIT_CHR_ATTRIB38, IIT_CHR_ATTRIB39, IIT_CHR_ATTRIB40, 
 IIT_CHR_ATTRIB41, IIT_CHR_ATTRIB42, IIT_CHR_ATTRIB43, IIT_CHR_ATTRIB44, IIT_CHR_ATTRIB45, 
 IIT_CHR_ATTRIB46, IIT_CHR_ATTRIB47, IIT_CHR_ATTRIB48, IIT_CHR_ATTRIB49, IIT_CHR_ATTRIB50, 
 IIT_CHR_ATTRIB51, IIT_CHR_ATTRIB52, IIT_CHR_ATTRIB53, IIT_CHR_ATTRIB54, IIT_CHR_ATTRIB55, 
 IIT_CHR_ATTRIB56, IIT_CHR_ATTRIB57, IIT_CHR_ATTRIB58, IIT_CHR_ATTRIB59, IIT_CHR_ATTRIB60, 
 IIT_CHR_ATTRIB61, IIT_CHR_ATTRIB62, IIT_CHR_ATTRIB63, IIT_CHR_ATTRIB64, IIT_CHR_ATTRIB65, 
 IIT_CHR_ATTRIB66, IIT_CHR_ATTRIB67, IIT_CHR_ATTRIB68, IIT_CHR_ATTRIB69, IIT_CHR_ATTRIB70, 
 IIT_CHR_ATTRIB71, IIT_CHR_ATTRIB72, IIT_CHR_ATTRIB73, IIT_CHR_ATTRIB74, IIT_CHR_ATTRIB75, 
 IIT_NUM_ATTRIB76, IIT_NUM_ATTRIB77, IIT_NUM_ATTRIB78, IIT_NUM_ATTRIB79, IIT_NUM_ATTRIB80, 
 IIT_NUM_ATTRIB81, IIT_NUM_ATTRIB82, IIT_NUM_ATTRIB83, IIT_NUM_ATTRIB84, IIT_NUM_ATTRIB85, 
 IIT_DATE_ATTRIB86, IIT_DATE_ATTRIB87, IIT_DATE_ATTRIB88, IIT_DATE_ATTRIB89, IIT_DATE_ATTRIB90, 
 IIT_DATE_ATTRIB91, IIT_DATE_ATTRIB92, IIT_DATE_ATTRIB93, IIT_DATE_ATTRIB94, IIT_DATE_ATTRIB95,
 IIT_NUM_ATTRIB96, IIT_NUM_ATTRIB97,  IIT_NUM_ATTRIB98, IIT_NUM_ATTRIB99,IIT_NUM_ATTRIB100,
 IIT_NUM_ATTRIB101, IIT_NUM_ATTRIB102, IIT_NUM_ATTRIB103, IIT_NUM_ATTRIB104, IIT_NUM_ATTRIB105,
IIT_NUM_ATTRIB106, IIT_NUM_ATTRIB107, IIT_NUM_ATTRIB108, IIT_NUM_ATTRIB109, IIT_NUM_ATTRIB110,
IIT_NUM_ATTRIB111, IIT_NUM_ATTRIB112, IIT_NUM_ATTRIB113, IIT_NUM_ATTRIB114, IIT_NUM_ATTRIB115,
IIT_POSITION, IIT_X_COORD, IIT_Y_COORD, IIT_X, IIT_Y, IIT_Z)
AS 
SELECT iit_created_date,
       iit_cre_date, 
       iit_item_id,
       iit_ity_inv_code,
       iit_ity_sys_flag,
       iit_last_updated_date,
       iit_rse_he_id,
       iit_st_chain,
       iit_angle,
       iit_angle_txt,
       iit_class,
       iit_class_txt,
       iit_colour,
       iit_colour_txt,
       iit_coord_flag,
       iit_description,
       iit_diagram,
       iit_distance,
       iit_end_chain,
       iit_end_date,
       iit_gap,
       iit_height,
       iit_height_2,
       iit_id_code,
       iit_instal_date,
       iit_invent_date,
       iit_inv_ownership,
       iit_itemcode,
       iit_lco_lamp_config_id,
       iit_length,
       iit_material,
       iit_material_txt,
       iit_method,
       iit_method_txt,
       iit_note,
       iit_no_of_units,
       iit_options,
       iit_options_txt,
       iit_oun_org_id_elec_board,
       iit_owner,
       iit_owner_txt,
       iit_peo_invent_by_id,
       iit_photo,
       iit_power,
       iit_prov_flag,
       iit_rev_by,
       iit_rev_date,
       iit_type,
       iit_type_txt,
       iit_width,
       iit_xtra_char_1,
       iit_xtra_date_1,
       iit_xtra_domain_1,
       iit_xtra_domain_txt_1,
       iit_xtra_number_1,
       iit_x_sect,
       iit_primary_key,
       iit_foreign_key,
       iit_det_xsp,
       iit_offset,
       iit_num_attrib16,
       iit_num_attrib17,
       iit_num_attrib18,
       iit_num_attrib19,
       iit_num_attrib20,
       iit_num_attrib21,
       iit_num_attrib22,
       iit_num_attrib23,
       iit_num_attrib24,
       iit_num_attrib25,
       iit_chr_attrib26,
       iit_chr_attrib27,
       iit_chr_attrib28,
       iit_chr_attrib29,
       iit_chr_attrib30,
       iit_chr_attrib31,
       iit_chr_attrib32,
       iit_chr_attrib33,
       iit_chr_attrib34,
       iit_chr_attrib35,
       iit_chr_attrib36,
       iit_chr_attrib37,
       iit_chr_attrib38,
       iit_chr_attrib39,
       iit_chr_attrib40,
       iit_chr_attrib41,
       iit_chr_attrib42,
       iit_chr_attrib43,
       iit_chr_attrib44,
       iit_chr_attrib45,
       iit_chr_attrib46,
       iit_chr_attrib47,
       iit_chr_attrib48,
       iit_chr_attrib49,
       iit_chr_attrib50,
       iit_chr_attrib51,
       iit_chr_attrib52,
       iit_chr_attrib53,
       iit_chr_attrib54,
       iit_chr_attrib55,
       iit_chr_attrib56,
       iit_chr_attrib57,
       iit_chr_attrib58,
       iit_chr_attrib59,
       iit_chr_attrib60,
       iit_chr_attrib61,
       iit_chr_attrib62,
       iit_chr_attrib63,
       iit_chr_attrib64,
       iit_chr_attrib65,
       iit_chr_attrib66,
       iit_chr_attrib67,
       iit_chr_attrib68,
       iit_chr_attrib69,
       iit_chr_attrib70,
       iit_chr_attrib71,
       iit_chr_attrib72,
       iit_chr_attrib73,
       iit_chr_attrib74,
       iit_chr_attrib75,
       iit_num_attrib76,
       iit_num_attrib77,
       iit_num_attrib78,
       iit_num_attrib79,
       iit_num_attrib80,
       iit_num_attrib81,
       iit_num_attrib82,
       iit_num_attrib83,
       iit_num_attrib84,
       iit_num_attrib85,
       iit_date_attrib86,
       iit_date_attrib87,
       iit_date_attrib88,
       iit_date_attrib89,
       iit_date_attrib90,
       iit_date_attrib91,
       iit_date_attrib92,
       iit_date_attrib93,
       iit_date_attrib94,
       iit_date_attrib95,
       iit_num_attrib96, 
       iit_num_attrib97, 
       iit_num_attrib98, 
       iit_num_attrib99, 
       iit_num_attrib100, 
       iit_num_attrib101, 
       iit_num_attrib102, 
       iit_num_attrib103, 
       iit_num_attrib104, 
       iit_num_attrib105, 
       iit_num_attrib106, 
       iit_num_attrib107, 
       iit_num_attrib108, 
       iit_num_attrib109, 
       iit_num_attrib110, 
       iit_num_attrib111, 
       iit_num_attrib112, 
       iit_num_attrib113, 
       iit_num_attrib114, 
       iit_num_attrib115, 
       iit_position, 
       iit_x_coord, 
       iit_y_coord, 
       iit_x, 
       iit_y, 
       iit_z
FROM   inv_items_all
WHERE  iit_end_date IS NULL 
AND    iit_prov_flag IS NULL;


CREATE OR REPLACE FORCE VIEW inv_items_all_section
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2009
-----------------------------------------------------------------------------
  (IIT_CREATED_DATE, IIT_CRE_DATE, IIT_ITEM_ID,
  IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, IIT_LAST_UPDATED_DATE,
  IIT_RSE_HE_ID, IIT_ST_CHAIN, IIT_ANGLE, IIT_ANGLE_TXT,
  IIT_CLASS, IIT_CLASS_TXT, IIT_COLOUR, IIT_COLOUR_TXT,
  IIT_COORD_FLAG, IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE,
  IIT_END_CHAIN, IIT_END_DATE, IIT_GAP, IIT_HEIGHT,
  IIT_HEIGHT_2, IIT_ID_CODE, IIT_INSTAL_DATE, IIT_INVENT_DATE,
  IIT_INV_OWNERSHIP, IIT_ITEMCODE, IIT_LCO_LAMP_CONFIG_ID,
  IIT_LENGTH, IIT_MATERIAL, IIT_MATERIAL_TXT, IIT_METHOD,
  IIT_METHOD_TXT, IIT_NOTE, IIT_NO_OF_UNITS, IIT_OPTIONS,
  IIT_OPTIONS_TXT, IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER,
  IIT_OWNER_TXT, IIT_PEO_INVENT_BY_ID, IIT_PHOTO, IIT_POWER,
  IIT_PROV_FLAG, IIT_REV_BY, IIT_REV_DATE, IIT_TYPE,
  IIT_TYPE_TXT, IIT_WIDTH, IIT_XTRA_CHAR_1, IIT_XTRA_DATE_1,
  IIT_XTRA_DOMAIN_1, IIT_XTRA_DOMAIN_TXT_1, IIT_XTRA_NUMBER_1,
  IIT_X_SECT, IIT_PRIMARY_KEY, IIT_FOREIGN_KEY, IIT_DET_XSP,
  IIT_OFFSET, IIT_NUM_ATTRIB16, IIT_NUM_ATTRIB17,
  IIT_NUM_ATTRIB18, IIT_NUM_ATTRIB19, IIT_NUM_ATTRIB20,
  IIT_NUM_ATTRIB21, IIT_NUM_ATTRIB22, IIT_NUM_ATTRIB23,
  IIT_NUM_ATTRIB24, IIT_NUM_ATTRIB25, IIT_CHR_ATTRIB26,
  IIT_CHR_ATTRIB27, IIT_CHR_ATTRIB28, IIT_CHR_ATTRIB29,
  IIT_CHR_ATTRIB30, IIT_CHR_ATTRIB31, IIT_CHR_ATTRIB32,
  IIT_CHR_ATTRIB33, IIT_CHR_ATTRIB34, IIT_CHR_ATTRIB35,
  IIT_CHR_ATTRIB36, IIT_CHR_ATTRIB37, IIT_CHR_ATTRIB38,
  IIT_CHR_ATTRIB39, IIT_CHR_ATTRIB40, IIT_CHR_ATTRIB41,
  IIT_CHR_ATTRIB42, IIT_CHR_ATTRIB43, IIT_CHR_ATTRIB44,
  IIT_CHR_ATTRIB45, IIT_CHR_ATTRIB46, IIT_CHR_ATTRIB47,
  IIT_CHR_ATTRIB48, IIT_CHR_ATTRIB49, IIT_CHR_ATTRIB50,
  IIT_CHR_ATTRIB51, IIT_CHR_ATTRIB52, IIT_CHR_ATTRIB53,
  IIT_CHR_ATTRIB54, IIT_CHR_ATTRIB55, IIT_CHR_ATTRIB56,
  IIT_CHR_ATTRIB57, IIT_CHR_ATTRIB58, IIT_CHR_ATTRIB59,
  IIT_CHR_ATTRIB60, IIT_CHR_ATTRIB61, IIT_CHR_ATTRIB62,
  IIT_CHR_ATTRIB63, IIT_CHR_ATTRIB64, IIT_CHR_ATTRIB65,
  IIT_CHR_ATTRIB66, IIT_CHR_ATTRIB67, IIT_CHR_ATTRIB68,
  IIT_CHR_ATTRIB69, IIT_CHR_ATTRIB70, IIT_CHR_ATTRIB71,
  IIT_CHR_ATTRIB72, IIT_CHR_ATTRIB73, IIT_CHR_ATTRIB74,
  IIT_CHR_ATTRIB75, IIT_NUM_ATTRIB76, IIT_NUM_ATTRIB77,
  IIT_NUM_ATTRIB78, IIT_NUM_ATTRIB79, IIT_NUM_ATTRIB80,
  IIT_NUM_ATTRIB81, IIT_NUM_ATTRIB82, IIT_NUM_ATTRIB83,
  IIT_NUM_ATTRIB84, IIT_NUM_ATTRIB85, IIT_DATE_ATTRIB86,
  IIT_DATE_ATTRIB87, IIT_DATE_ATTRIB88, IIT_DATE_ATTRIB89,
  IIT_DATE_ATTRIB90, IIT_DATE_ATTRIB91, IIT_DATE_ATTRIB92,
  IIT_DATE_ATTRIB93, IIT_DATE_ATTRIB94, IIT_DATE_ATTRIB95,
  IIT_NUM_ATTRIB96, IIT_NUM_ATTRIB97,  IIT_NUM_ATTRIB98, 
  IIT_NUM_ATTRIB99,IIT_NUM_ATTRIB100, IIT_NUM_ATTRIB101, 
  IIT_NUM_ATTRIB102, IIT_NUM_ATTRIB103, IIT_NUM_ATTRIB104, 
  IIT_NUM_ATTRIB105, IIT_NUM_ATTRIB106, IIT_NUM_ATTRIB107, 
  IIT_NUM_ATTRIB108, IIT_NUM_ATTRIB109, IIT_NUM_ATTRIB110,
  IIT_NUM_ATTRIB111, IIT_NUM_ATTRIB112, IIT_NUM_ATTRIB113, 
  IIT_NUM_ATTRIB114, IIT_NUM_ATTRIB115, IIT_POSITION, 
  IIT_X_COORD, IIT_Y_COORD, IIT_X, IIT_Y, IIT_Z)
AS
SELECT IIT_CREATED_DATE, IIT_CRE_DATE, IIT_ITEM_ID,
       IIT_ITY_INV_CODE, IIT_ITY_SYS_FLAG, IIT_LAST_UPDATED_DATE,
       IIT_RSE_HE_ID, IIT_ST_CHAIN, IIT_ANGLE, IIT_ANGLE_TXT,
       IIT_CLASS, IIT_CLASS_TXT, IIT_COLOUR, IIT_COLOUR_TXT,
       IIT_COORD_FLAG, IIT_DESCRIPTION, IIT_DIAGRAM, IIT_DISTANCE,
       IIT_END_CHAIN, IIT_END_DATE, IIT_GAP, IIT_HEIGHT,
       IIT_HEIGHT_2, IIT_ID_CODE, IIT_INSTAL_DATE, IIT_INVENT_DATE,
       IIT_INV_OWNERSHIP, IIT_ITEMCODE, IIT_LCO_LAMP_CONFIG_ID,
       IIT_LENGTH, IIT_MATERIAL, IIT_MATERIAL_TXT, IIT_METHOD,
       IIT_METHOD_TXT, IIT_NOTE, IIT_NO_OF_UNITS, IIT_OPTIONS,
       IIT_OPTIONS_TXT, IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER,
       IIT_OWNER_TXT, IIT_PEO_INVENT_BY_ID, IIT_PHOTO, IIT_POWER,
       IIT_PROV_FLAG, IIT_REV_BY, IIT_REV_DATE, IIT_TYPE,
       IIT_TYPE_TXT, IIT_WIDTH, IIT_XTRA_CHAR_1, IIT_XTRA_DATE_1,
       IIT_XTRA_DOMAIN_1, IIT_XTRA_DOMAIN_TXT_1, IIT_XTRA_NUMBER_1,
       IIT_X_SECT, IIT_PRIMARY_KEY, IIT_FOREIGN_KEY, IIT_DET_XSP,
       IIT_OFFSET, IIT_NUM_ATTRIB16, IIT_NUM_ATTRIB17,
       IIT_NUM_ATTRIB18, IIT_NUM_ATTRIB19, IIT_NUM_ATTRIB20,
       IIT_NUM_ATTRIB21, IIT_NUM_ATTRIB22, IIT_NUM_ATTRIB23,
       IIT_NUM_ATTRIB24, IIT_NUM_ATTRIB25, IIT_CHR_ATTRIB26,
       IIT_CHR_ATTRIB27, IIT_CHR_ATTRIB28, IIT_CHR_ATTRIB29,
       IIT_CHR_ATTRIB30, IIT_CHR_ATTRIB31, IIT_CHR_ATTRIB32,
       IIT_CHR_ATTRIB33, IIT_CHR_ATTRIB34, IIT_CHR_ATTRIB35,
       IIT_CHR_ATTRIB36, IIT_CHR_ATTRIB37, IIT_CHR_ATTRIB38,
       IIT_CHR_ATTRIB39, IIT_CHR_ATTRIB40, IIT_CHR_ATTRIB41,
       IIT_CHR_ATTRIB42, IIT_CHR_ATTRIB43, IIT_CHR_ATTRIB44,
       IIT_CHR_ATTRIB45, IIT_CHR_ATTRIB46, IIT_CHR_ATTRIB47,
       IIT_CHR_ATTRIB48, IIT_CHR_ATTRIB49, IIT_CHR_ATTRIB50,
       IIT_CHR_ATTRIB51, IIT_CHR_ATTRIB52, IIT_CHR_ATTRIB53,
       IIT_CHR_ATTRIB54, IIT_CHR_ATTRIB55, IIT_CHR_ATTRIB56,
       IIT_CHR_ATTRIB57, IIT_CHR_ATTRIB58, IIT_CHR_ATTRIB59,
       IIT_CHR_ATTRIB60, IIT_CHR_ATTRIB61, IIT_CHR_ATTRIB62,
       IIT_CHR_ATTRIB63, IIT_CHR_ATTRIB64, IIT_CHR_ATTRIB65,
       IIT_CHR_ATTRIB66, IIT_CHR_ATTRIB67, IIT_CHR_ATTRIB68,
       IIT_CHR_ATTRIB69, IIT_CHR_ATTRIB70, IIT_CHR_ATTRIB71,
       IIT_CHR_ATTRIB72, IIT_CHR_ATTRIB73, IIT_CHR_ATTRIB74,
       IIT_CHR_ATTRIB75, IIT_NUM_ATTRIB76, IIT_NUM_ATTRIB77,
       IIT_NUM_ATTRIB78, IIT_NUM_ATTRIB79, IIT_NUM_ATTRIB80,
       IIT_NUM_ATTRIB81, IIT_NUM_ATTRIB82, IIT_NUM_ATTRIB83,
       IIT_NUM_ATTRIB84, IIT_NUM_ATTRIB85, IIT_DATE_ATTRIB86,
       IIT_DATE_ATTRIB87, IIT_DATE_ATTRIB88, IIT_DATE_ATTRIB89,
       IIT_DATE_ATTRIB90, IIT_DATE_ATTRIB91, IIT_DATE_ATTRIB92,
       IIT_DATE_ATTRIB93, IIT_DATE_ATTRIB94, IIT_DATE_ATTRIB95,
       IIT_NUM_ATTRIB96, IIT_NUM_ATTRIB97,  IIT_NUM_ATTRIB98, 
       IIT_NUM_ATTRIB99,IIT_NUM_ATTRIB100, IIT_NUM_ATTRIB101, 
       IIT_NUM_ATTRIB102, IIT_NUM_ATTRIB103, IIT_NUM_ATTRIB104, 
       IIT_NUM_ATTRIB105, IIT_NUM_ATTRIB106, IIT_NUM_ATTRIB107, 
       IIT_NUM_ATTRIB108, IIT_NUM_ATTRIB109, IIT_NUM_ATTRIB110,
       IIT_NUM_ATTRIB111, IIT_NUM_ATTRIB112, IIT_NUM_ATTRIB113, 
       IIT_NUM_ATTRIB114, IIT_NUM_ATTRIB115, IIT_POSITION, 
       IIT_X_COORD, IIT_Y_COORD, IIT_X, IIT_Y, IIT_Z
  FROM inv_items_all
;


CREATE OR REPLACE FORCE VIEW INV_ITEM_TYPES
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
(ITY_DTP_FLAG, ITY_ELEC_DRAIN_CARR, ITY_INV_CODE, ITY_PNT_OR_CONT, ITY_SYS_FLAG, 
 ITY_X_SECT_ALLOW_FLAG, ITY_CONTIGUOUS, ITY_DESCR, ITY_DUPLICATE, ITY_FEA_CODE, 
 ITY_PARENT_ITY, ITY_MAX_ATTR_REQ, ITY_MIN_ATTR_REQ, ITY_ROAD_CHARACTERISTIC, ITY_SCREEN_SEQ, 
 ITY_TOLERANCE, ITY_VIEW_NAME, ITY_START_DATE, ITY_END_DATE, ITY_CONTIG_JOINS_GAP, 
 ITY_SURVEY, ITY_MULTI_ALLOWED, ITY_SHORT_DESCR, ITY_AREA_OR_LENGTH, ITY_CLOSE_EXISTING, 
 ITY_INCL_ROAD_SEGS, ITY_HHSUBSTATS, ITY_HHSUBSTRT1, ITY_HHSUBSTRT2, ITY_HHSUBSTRT3, 
 ITY_HHSUBSTRT4, ITY_HHSUBSTRT5, ITY_HHSUBSTRT6, ITY_HHSUBSTRT7, ITY_HHSUBSTRT8, 
 ITY_HHSUBSTRT9, ITY_HHSUBSTRT10, ITY_HHSTRLNGTH, ITY_HHSUBLNG1, ITY_HHSUBLNG2, 
 ITY_HHSUBLNG3, ITY_HHSUBLNG4, ITY_HHSUBLNG5, ITY_HHSUBLNG6, ITY_HHSUBLNG7, 
 ITY_HHSUBLNG8, ITY_HHSUBLNG9, ITY_HHSUBLNG10, ITY_HHPOS1, ITY_HHPOS2, 
 ITY_HHPOS3, ITY_HHPOS4, ITY_HHPOS5, ITY_HHPOS6, ITY_HHPOS7, 
 ITY_HHPOS8, ITY_HHPOS9, ITY_HHPOS10, ITY_HHPOS11, ITY_HHPOS12, 
 ITY_HHPOS13, ITY_HHPOS14, ITY_HHPOS15, ITY_HHPOS16, ITY_HHPOS17, 
 ITY_HHPOS18, ITY_HHPOS19, ITY_HHPOS20, ITY_HHPOS21, ITY_HHPOS22, 
 ITY_HHPOS23, ITY_HHPOS24, ITY_HHPOS25, ITY_HHPOS26, ITY_HHPOS27, 
 ITY_HHPOS28, ITY_HHPOS29, ITY_HHPOS30, ITY_HHPOS31, ITY_HHPOS32, 
 ITY_HHPOS33, ITY_HHPOS34, ITY_HHPOS35, ITY_HHPOS36, ITY_HHPOS37, 
 ITY_HHPOS38, ITY_HHPOS39, ITY_HHPOS40, ITY_HHPOS41, ITY_HHPOS42, 
 ITY_HHPOS43, ITY_HHPOS44, ITY_HHPOS45, ITY_HHPOS46, ITY_HHPOS47, 
 ITY_HHPOS48, ITY_HHPOS49, ITY_HHPOS50, ITY_HHPOS51, ITY_HHPOS52, 
 ITY_HHPOS53, ITY_HHPOS54, ITY_HHPOS55, ITY_HHPOS56, ITY_HHPOS57, 
 ITY_HHPOS58, ITY_HHPOS59, ITY_HHPOS60, ITY_HHPOS61, ITY_HHPOS62, 
 ITY_HHPOS63, ITY_HHPOS64, ITY_HHPOS65, ITY_HHPOS66, ITY_HHPOS67, 
 ITY_HHPOS68, ITY_HHPOS69, ITY_HHPOS70, ITY_HHPOS71, ITY_HHPOS72, 
 ITY_HHPOS73, ITY_HHPOS74, ITY_HHPOS75, ITY_HHPOS76, ITY_HHPOS77,
 ITY_HHPOS78, ITY_HHPOS79, ITY_HHPOS80, ITY_HHPOS81, ITY_HHPOS82,
 ITY_HHPOS83, ITY_HHPOS84, ITY_HHPOS85, ITY_HHPOS86, ITY_HHPOS87,
 ITY_HHPOS88, ITY_HHPOS89, ITY_HHPOS90, ITY_HHPOS91, ITY_HHPOS92,
 ITY_HHPOS93, ITY_HHPOS94, ITY_HHPOS95, ITY_HHPOS96, ITY_HHPOS97,
 ITY_HHPOS98, ITY_HHPOS99, ITY_HHPOS100, ITY_HHPOS101, ITY_HHPOS102,
 ITY_HHPOS103, ITY_HHPOS104, ITY_HHPOS105, ITY_HHPOS106, ITY_HHPOS107,
 ITY_HHPOS108, ITY_HHPOS109, ITY_HHPOS110, ITY_HHPOS111, ITY_HHPOS112,
 ITY_HHPOS113, ITY_HHPOS114, ITY_HHPOS115, ITY_HHPOS116, ITY_HHPOS117,
 ITY_HHPOS118, ITY_HHPOS119, ITY_HHPOS120
 )
AS 
SELECT 
ittc.ity_dtp_flag                        ity_dtp_flag, 
nit_elec_drain_carr                      ity_elec_drain_carr, 
ittc.ity_inv_code                        ity_inv_code, 
nit_pnt_or_cont                          ity_pnt_or_cont, 
ittc.ity_sys_flag                        ity_sys_flag, 
nit_x_sect_allow_flag                    ity_x_sect_allow_flag, 
nit_contiguous                           ity_contiguous, 
nit_descr                                ity_descr, 
ittc.ity_duplicate                       ity_duplicate, 
ittc.ity_fea_code                        ity_fea_code, 
ittp.ity_parent_ity                      ity_parent_ity, 
ittc.ity_max_attr_req                    ity_max_attr_req, 
ittc.ity_min_attr_req                    ity_min_attr_req, 
ittc.ity_road_characteristic             ity_road_characteristic, 
nit_screen_seq                           ity_screen_seq, 
ittc.ity_tolerance                       ity_tolerance, 
ittc.ity_view_name                       ity_view_name, 
nit_start_date                           ity_start_date, 
nit_end_date                             ity_end_date, 
ittc.ity_contig_joins_gap                ity_contig_joins_gap, 
ittc.ity_survey                          ity_survey, 
nit_multiple_allowed                     ity_multi_allowed, 
ittc.ity_short_descr                     ity_short_descr, 
ittc.ity_area_or_length                  ity_area_or_length, 
ittc.ity_close_existing                  ity_close_existing, 
ittc.ity_incl_road_segs                  ity_incl_road_segs, 
ittc.ity_hhsubstats       ity_hhsubstats, 
ittc.ity_hhsubstrt1       ity_hhsubstrt1, 
ittc.ity_hhsubstrt2       ity_hhsubstrt2, 
ittc.ity_hhsubstrt3       ity_hhsubstrt3, 
ittc.ity_hhsubstrt4       ity_hhsubstrt4, 
ittc.ity_hhsubstrt5       ity_hhsubstrt5, 
ittc.ity_hhsubstrt6       ity_hhsubstrt6, 
ittc.ity_hhsubstrt7       ity_hhsubstrt7, 
ittc.ity_hhsubstrt8       ity_hhsubstrt8, 
 ittc.ity_hhsubstrt9       ity_hhsubstrt9, 
 ittc.ity_hhsubstrt10       ity_hhsubstrt10, 
 ittc.ity_hhstrlngth       ity_hhstrlngth, 
 ittc.ity_hhsublng1       ity_hhsublng1, 
 ittc.ity_hhsublng2       ity_hhsublng2, 
 ittc.ity_hhsublng3       ity_hhsublng3, 
 ittc.ity_hhsublng4       ity_hhsublng4, 
 ittc.ity_hhsublng5       ity_hhsublng5, 
 ittc.ity_hhsublng6       ity_hhsublng6, 
 ittc.ity_hhsublng7       ity_hhsublng7, 
 ittc.ity_hhsublng8       ity_hhsublng8, 
 ittc.ity_hhsublng9       ity_hhsublng9, 
 ittc.ity_hhsublng10       ity_hhsublng10, 
 ittc.ity_hhpos1       ity_hhpos1, 
 ittc.ity_hhpos2       ity_hhpos2, 
 ittc.ity_hhpos3       ity_hhpos3, 
 ittc.ity_hhpos4       ity_hhpos4, 
 ittc.ity_hhpos5       ity_hhpos5, 
 ittc.ity_hhpos6       ity_hhpos6, 
 ittc.ity_hhpos7       ity_hhpos7, 
 ittc.ity_hhpos8       ity_hhpos8, 
 ittc.ity_hhpos9       ity_hhpos9, 
 ittc.ity_hhpos10       ity_hhpos10, 
 ittc.ity_hhpos11       ity_hhpos11, 
 ittc.ity_hhpos12       ity_hhpos12, 
 ittc.ity_hhpos13       ity_hhpos13, 
 ittc.ity_hhpos14       ity_hhpos14, 
 ittc.ity_hhpos15       ity_hhpos15, 
 ittc.ity_hhpos16       ity_hhpos16, 
 ittc.ity_hhpos17       ity_hhpos17, 
 ittc.ity_hhpos18       ity_hhpos18, 
 ittc.ity_hhpos19       ity_hhpos19, 
 ittc.ity_hhpos20       ity_hhpos20, 
 ittc.ity_hhpos21       ity_hhpos21, 
 ittc.ity_hhpos22       ity_hhpos22, 
 ittc.ity_hhpos23       ity_hhpos23, 
 ittc.ity_hhpos24       ity_hhpos24, 
 ittc.ity_hhpos25       ity_hhpos25, 
 ittc.ity_hhpos26       ity_hhpos26, 
 ittc.ity_hhpos27       ity_hhpos27, 
 ittc.ity_hhpos28       ity_hhpos28, 
 ittc.ity_hhpos29       ity_hhpos29, 
 ittc.ity_hhpos30       ity_hhpos30, 
 ittc.ity_hhpos31       ity_hhpos31, 
 ittc.ity_hhpos32       ity_hhpos32, 
 ittc.ity_hhpos33       ity_hhpos33, 
 ittc.ity_hhpos34       ity_hhpos34, 
 ittc.ity_hhpos35       ity_hhpos35, 
 ittc.ity_hhpos36       ity_hhpos36, 
 ittc.ity_hhpos37       ity_hhpos37, 
 ittc.ity_hhpos38       ity_hhpos38, 
 ittc.ity_hhpos39       ity_hhpos39, 
 ittc.ity_hhpos40       ity_hhpos40, 
 ittc.ity_hhpos41       ity_hhpos41, 
 ittc.ity_hhpos42       ity_hhpos42, 
 ittc.ity_hhpos43       ity_hhpos43, 
 ittc.ity_hhpos44       ity_hhpos44, 
 ittc.ity_hhpos45       ity_hhpos45, 
 ittc.ity_hhpos46       ity_hhpos46, 
 ittc.ity_hhpos47       ity_hhpos47, 
 ittc.ity_hhpos48       ity_hhpos48, 
 ittc.ity_hhpos49       ity_hhpos49, 
 ittc.ity_hhpos50       ity_hhpos50, 
 ittc.ity_hhpos51       ity_hhpos51, 
 ittc.ity_hhpos52       ity_hhpos52, 
 ittc.ity_hhpos53       ity_hhpos53, 
 ittc.ity_hhpos54       ity_hhpos54, 
 ittc.ity_hhpos55       ity_hhpos55, 
 ittc.ity_hhpos56       ity_hhpos56, 
 ittc.ity_hhpos57       ity_hhpos57, 
 ittc.ity_hhpos58       ity_hhpos58, 
 ittc.ity_hhpos59       ity_hhpos59, 
 ittc.ity_hhpos60       ity_hhpos60, 
 ittc.ity_hhpos61       ity_hhpos61, 
 ittc.ity_hhpos62       ity_hhpos62, 
 ittc.ity_hhpos63       ity_hhpos63, 
 ittc.ity_hhpos64       ity_hhpos64, 
 ittc.ity_hhpos65       ity_hhpos65, 
 ittc.ity_hhpos66       ity_hhpos66, 
 ittc.ity_hhpos67       ity_hhpos67, 
 ittc.ity_hhpos68       ity_hhpos68, 
 ittc.ity_hhpos69       ity_hhpos69, 
 ittc.ity_hhpos70       ity_hhpos70, 
 ittc.ity_hhpos71       ity_hhpos71, 
 ittc.ity_hhpos72       ity_hhpos72, 
 ittc.ity_hhpos73       ity_hhpos73, 
 ittc.ity_hhpos74       ity_hhpos74, 
 ittc.ity_hhpos75       ity_hhpos75, 
 ittc.ity_hhpos76       ity_hhpos76, 
 ittc.ity_hhpos77       ity_hhpos77, 
 ittc.ity_hhpos78       ity_hhpos78, 
 ittc.ity_hhpos79       ity_hhpos79, 
 ittc.ity_hhpos80       ity_hhpos80, 
 ittc.ity_hhpos81       ity_hhpos81, 
 ittc.ity_hhpos82       ity_hhpos82, 
 ittc.ity_hhpos83       ity_hhpos83, 
 ittc.ity_hhpos84       ity_hhpos84, 
 ittc.ity_hhpos85       ity_hhpos85, 
 ittc.ity_hhpos86       ity_hhpos86, 
 ittc.ity_hhpos87       ity_hhpos87, 
 ittc.ity_hhpos88       ity_hhpos88, 
 ittc.ity_hhpos89       ity_hhpos89, 
 ittc.ity_hhpos90       ity_hhpos90, 
 ittc.ity_hhpos91       ity_hhpos91, 
 ittc.ity_hhpos92       ity_hhpos92, 
 ittc.ity_hhpos93       ity_hhpos93, 
 ittc.ity_hhpos94       ity_hhpos94, 
 ittc.ity_hhpos95       ity_hhpos95, 
 ittc.ity_hhpos96       ity_hhpos96, 
 ittc.ity_hhpos97       ity_hhpos97, 
 ittc.ity_hhpos98       ity_hhpos98, 
 ittc.ity_hhpos99       ity_hhpos99, 
 ittc.ity_hhpos100     ity_hhpos100, 
 ittc.ity_hhpos101     ity_hhpos101, 
 ittc.ity_hhpos102     ity_hhpos102, 
 ittc.ity_hhpos103     ity_hhpos103, 
 ittc.ity_hhpos104     ity_hhpos104, 
 ittc.ity_hhpos105     ity_hhpos105, 
 ittc.ity_hhpos106     ity_hhpos106, 
 ittc.ity_hhpos107     ity_hhpos107, 
 ittc.ity_hhpos108     ity_hhpos108, 
 ittc.ity_hhpos109     ity_hhpos109, 
 ittc.ity_hhpos110     ity_hhpos110, 
 ittc.ity_hhpos111     ity_hhpos111, 
 ittc.ity_hhpos112     ity_hhpos112, 
 ittc.ity_hhpos113     ity_hhpos113, 
 ittc.ity_hhpos114     ity_hhpos114, 
 ittc.ity_hhpos115     ity_hhpos115, 
 ittc.ity_hhpos116     ity_hhpos116, 
 ittc.ity_hhpos117     ity_hhpos117, 
 ittc.ity_hhpos118     ity_hhpos118, 
 ittc.ity_hhpos119     ity_hhpos119, 
 ittc.ity_hhpos120     ity_hhpos120 
 FROM nm_inv_types nitc, 
      nm_inv_type_groupings itg, 
      inv_type_translations ittc, 
      inv_type_translations ittp 
where nitc.nit_inv_type = itg.ITG_INV_TYPE (+) 
and   nitc.nit_inv_type = ittc.nit_inv_type 
and   itg.ITG_PARENT_INV_TYPE = ittp.nit_inv_type (+);


CREATE OR REPLACE FORCE VIEW INV_TYPE_ATTRIBS
-----------------------------------------------------------------------------
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
(ITA_ATTRIB_NAME, ITA_DEC_PLACES, ITA_DYNAMIC_ATTRIB, ITA_FLD_LENGTH, ITA_FORMAT, 
 ITA_IIT_INV_CODE, ITA_ITY_SYS_FLAG, ITA_MANDITORY_YN, ITA_SCRN_TEXT, ITA_VALIDATE_YN, 
 ITA_DISP_SEQ_NO, ITA_DTP_CODE, ITA_MAX, ITA_MIN, ITA_VIEW_ATTRI, 
 ITA_VIEW_COL_NAME, ITA_START_DATE, ITA_END_DATE, ITA_PRIMARY_KEY, ITA_FOREIGN_KEY, 
 ITA_QUERYABLE, ITA_UKPMS_PARAM_NO, ITA_UNITS)
AS 
SELECT 
 ita_attrib_name, 
 ita_dec_places, 
 ita_dynamic_attrib, 
 ita_fld_length, 
 ita_format, 
 ity_inv_code    ita_iit_inv_code, 
 ity_sys_flag    ita_ity_sys_flag, 
 ita_mandatory_yn ita_manditory_yn, 
 ita_scrn_text, 
 ita_validate_yn, 
 ita_disp_seq_no, 
 ita_dtp_code, 
 ita_max, 
 ita_min, 
 ita_view_attri, 
 ita_view_col_name, 
 ita_start_date, 
 ita_end_date, 
 NULL ita_primary_key, 
 NULL ita_foreign_key, 
 ita_queryable, 
 ita_ukpms_param_no, 
 ita_units 
FROM 
  nm_inv_type_attribs_all, 
  inv_type_translations 
WHERE 
  ita_inv_type = nit_inv_type;


CREATE OR REPLACE FORCE VIEW ITY_CATEGORY_ROLES
(ICR_CATEGORY, ICR_ROLE, ICR_MODE)
AS 
SELECT 
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
----------------------------------------------------------------------------- 
ity_inv_code  icr_category, 
itr_hro_role icr_role, 
itr_mode icr_mode 
FROM nm_inv_type_roles, 
inv_type_translations 
where nit_inv_type = itr_inv_type;

CREATE OR REPLACE FORCE VIEW inv_type_colours
AS
SELECT
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
 col_id,
 ity_inv_code
FROM nm_inv_type_colours;

CREATE OR REPLACE FORCE VIEW inv_item_history
AS
SELECT
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
iit_created_date iih_created_date,
iit_item_id iih_item_id,
iit_ity_inv_code iih_inv_code,
iit_rse_he_id iih_rse_he_id,
iit_st_chain iih_st_chain,
iit_end_chain iih_end_chain,
iit_x_sect iih_x_sect,
iit_item_id iih_new_item_id,
iit_rse_he_id iih_new_rse_he_id,
iit_created_date iih_last_updated_date,
iit_end_date iih_end_date,
'X' iih_operation
FROM inv_items;

CREATE OR REPLACE FORCE VIEW INV_ATTRI_DOMAINS
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
(IAD_ITA_ATTRIB_NAME, IAD_ITA_INV_CODE, IAD_ITA_ITY_SYS_FLAG, IAD_VALUE, IAD_DTP_CODE, 
 IAD_MEANING, IAD_START_DATE, IAD_END_DATE)
AS 
SELECT 
ita_attrib_name iad_ita_attrib_name, 
ity_inv_code iad_ita_inv_code, 
ity_sys_flag iad_ita_ity_sys_flag, 
ial_value iad_value, 
ial_dtp_code iad_dtp_code, 
ial_meaning iad_meaning, 
ial_start_date iad_start_date, 
ial_end_date iad_end_date 
FROM nm_inv_attri_lookup_all 
    ,nm_inv_type_attribs 
    ,inv_type_translations 
WHERE ial_domain = ita_id_domain 
AND   ita_inv_type = nit_inv_type;

CREATE OR REPLACE FORCE VIEW UNIT_CONVERSIONS
(un_unit_id_in,
 un_unit_id_out,
 un_function,
 un_conversion
) AS
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
SELECT 
 UC_UNIT_ID_IN, 
 UC_UNIT_ID_OUT, 
 UC_FUNCTION, 
 UC_CONVERSION 
FROM NM_UNIT_CONVERSIONS
/

CREATE OR REPLACE FORCE VIEW UNITS
-----------------------------------------------------------------------------
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
(UN_DOMAIN_ID, UN_UNIT_ID, UN_UNIT_NAME, UN_FORMAT_MASK)
AS
SELECT un_domain_id
      ,un_unit_id
      ,un_unit_name
      ,un_format_mask
FROM   nm_units;

CREATE OR REPLACE VIEW inv_type_colours
-----------------------------------------------------------------------------
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------
(col_id, ity_inv_code) AS
select col_id
      ,ity_inv_code
from   nm_inv_type_colours;

CREATE OR REPLACE function ity_to_nit( p_ity_inv_code varchar2 ) return varchar2 is
-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai_transviews.sql	1.14 02/22/05
--       Module Name      : mai_transviews.sql
--       Date into SCCS   : 05/02/22 11:22:34
--       Date fetched Out : 07/06/07 11:16:38
--       SCCS Version     : 1.14
--
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2005
-----------------------------------------------------------------------------

cursor c1( c_ity in varchar2 ) is
  select ity.NIT_INV_TYPE
  from inv_type_translations ity
  where ity.ITY_INV_CODE = c_ity;
  
retval nm_inv_types.nit_inv_type%type;

begin
  open c1( p_ity_inv_code );
  fetch c1 into retval;
  if c1%notfound then
    close c1;
    raise_application_error(-20001, 'No translation exists');
  end if;
  close c1;  
  return retval;
end;
/

