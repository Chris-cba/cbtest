CREATE OR REPLACE PACKAGE BODY maiausec AS 
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/MAIAUSEC.pkb-arc   1.6   Nov 22 2012 12:33:08   Rob.Coupe  $
--       Module Name      : $Workfile:   MAIAUSEC.pkb  $
--       Date into SCCS   : $Date:   Nov 22 2012 12:33:08  $
--       Date fetched Out : $Modtime:   Nov 22 2012 12:29:12  $
--       SCCS Version     : $Revision:   1.6  $
--
-----------------------------------------------------------------------------
--    Copyright (c) Bentley Systems 2012
-----------------------------------------------------------------------------


g_body_sccsid     CONSTANT VARCHAR2(2000) := '"$Revision:   1.6  $"';

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

 FUNCTION get_string (p_au_col_name  IN varchar2 ) RETURN varchar2 IS 
 l_retval varchar2(2000); 
 BEGIN 
  l_retval := 'exists (SELECT  1 '||CHR(10)|| 
              'FROM  HIG_ADMIN_GROUPS '||CHR(10)||
              'WHERE  HAG_PARENT_ADMIN_UNIT  = Sys_Context('||''''||'NM3CORE'||''''||','||''''||'USER_ADMIN_UNIT'||''''||')'||CHR(10)|| 
              '  AND   HAG_CHILD_ADMIN_UNIT = '||p_au_col_name||CHR(10)|| 
              ' ) '||CHR(10); 
    RETURN l_retval; 
 END get_string; 
 
 FUNCTION get_up_string (p_au_col_name  IN varchar2 ) RETURN varchar2 IS 
 l_retval varchar2(2000); 
 BEGIN 
  l_retval := 'exists (SELECT  1 '||CHR(10)|| 
              'FROM  HIG_ADMIN_GROUPS '||CHR(10)||
              'WHERE  HAG_CHILD_ADMIN_UNIT  = Sys_Context('||''''||'NM3CORE'||''''||','||''''||'USER_ADMIN_UNIT'||''''||')'||CHR(10)|| 
              '  AND   HAG_PARENT_ADMIN_UNIT = '||p_au_col_name||CHR(10)|| 
              ' ) '||CHR(10); 
    RETURN l_retval; 
 END get_up_string; 
 
 FUNCTION get_au_list return int_array_type is 
 begin 
   return au_list.ia; 
 end; 
function SFR_1_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( SFR_RSE_HE_ID)'); 
    END IF; 
 END; 
function ISS_2_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( ISS_RSE_HE_ID)'); 
    END IF; 
 END; 
function IHA_3_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( IHA_RSE_HE_ID)'); 
    END IF; 
 END; 
function DSR_6_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('DSR_ADMIN_UNIT'); 
    END IF; 
 END; 
function ADM_7_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('ADMIN_UNIT_ORG_ID'); 
    END IF; 
 END; 
function QRY_8_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('(select nau_admin_unit from nm_admin_units where nau_authority_code = QRY_AGENCY )'); 
    END IF; 
 END; 
function BUD_12_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('(select nau_admin_unit from nm_admin_units where nau_authority_code = BUD_AGENCY )'); 
    END IF; 
 END; 
function ICB_13_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('(select nau_admin_unit from nm_admin_units where nau_authority_code = ICB_AGENCY_CODE )'); 
    END IF; 
 END; 
function DRL_14_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('DRL_DOC_ADMIN_UNIT'); 
    END IF; 
 END; 
function NAE_15_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('NAE_ADMIN_UNIT'); 
    END IF; 
 END; 
function EXU_16_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( EXU_RSE_HE_ID)'); 
    END IF; 
 END; 
function MAW_17_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('MAWR_ADMIN_UNIT'); 
    END IF; 
 END; 
function DEF_18_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( DEF_RSE_HE_ID)'); 
    END IF; 
 END; 
function HFC_19_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('HFC_NAU_ADMIN_UNIT'); 
    END IF; 
 END; 
function ARE_20_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( ARE_RSE_HE_ID)'); 
    END IF; 
 END; 
function DEF_22_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( DEF_RSE_HE_ID)'); 
    END IF; 
 END; 
function WOL_23_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( WOL_RSE_HE_ID)'); 
    END IF; 
 END; 
function IIT_24_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('IIT_ADMIN_UNIT'); 
    END IF; 
 END; 
function HPA_25_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('HPAL_ADMIN_UNIT'); 
    END IF; 
 END; 
function STR_26_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('STR_NE_ADMIN_UNIT'); 
    END IF; 
 END; 
function NM__31_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('NM_ADMIN_UNIT'); 
    END IF; 
 END; 
function NUA_33_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('NUA_ADMIN_UNIT'); 
    END IF; 
 END; 
function DLD_34_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( DLD_RSE_HE_ID)'); 
    END IF; 
 END; 
function TT2_39_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( TT2_RSE_HE_ID)'); 
    END IF; 
 END; 
function IIT_40_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('IIT_ADMIN_UNIT'); 
    END IF; 
 END; 
function ARE_42_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( ARE_RSE_HE_ID)'); 
    END IF; 
 END; 
function SCH_45_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( SCHR_RSE_HE_ID)'); 
    END IF; 
 END; 
function MAI_46_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( MAI2325_RSE_HE_ID)'); 
    END IF; 
 END; 
function REP_47_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( REP_RSE_HE_ID)'); 
    END IF; 
 END; 
function LFR_49_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( LFR_RSE_HE_ID)'); 
    END IF; 
 END; 
function RSE_52_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( RSE_HE_ID)'); 
    END IF; 
 END; 
function DOC_53_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('DOC_ADMIN_UNIT'); 
    END IF; 
 END; 
function SS__54_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('SS_ADMIN_UNIT2'); 
    END IF; 
 END; 
function SS__55_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('SS_ADMIN_UNIT1'); 
    END IF; 
 END; 
function NAU_56_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('NAU_ADMIN_UNIT')||' OR '||get_up_string('NAU_ADMIN_UNIT');
    END IF; 
 END; 
function NAU_56_predicate_DML( schema_in varchar2, name_in varchar2) RETURN varchar2 IS
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('NAU_ADMIN_UNIT');
    END IF; 
 END; 
function TT1_59_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( TT1_RSE_HE_ID)'); 
    END IF; 
 END; 
function NAR_60_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('NAR_ADMIN_UNIT'); 
    END IF; 
 END; 
function SCH_61_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('(select nau_admin_unit from nm_admin_units where nau_authority_code = SCHD_AGENCY )'); 
    END IF; 
 END; 
function REP_62_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( REP_RSE_HE_ID)'); 
    END IF; 
 END; 
function SEC_64_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('SEC_ADMIN_UNIT'); 
    END IF; 
 END; 
function ICP_67_predicate_read( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('get_admin_unit( ICP_RSE_HE_ID)'); 
    END IF; 
 END;
---
--manual changes
--
function CONTRACTS_PREDICATE_READ( schema_in varchar2, name_in varchar2) RETURN varchar2 IS 
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN '('||get_string('oun_admin_org_id')||' OR exists ( select 1 from contracts '||
                'where oun_org_id = con_contr_org_id )'||')'||
                ' or exists ( select 1 from contractor_users where cou_oun_org_id = oun_org_id '||
                ' AND Sys_Context('||''''||'NM3SQL'||''''||','||''''||'CONSECMODE'||''''||') = '||''''||'U'||''''||							
                ' and cou_hus_user_id = Sys_Context('||''''||'NM3CORE'||''''||','||''''||'USER_ID'||''''||') )'||CHR(10)|| 
                ' or exists ( select 1 from contractor_roles, hig_user_roles '||
                ' where cor_oun_org_id = oun_org_id and cor_role = hur_role '||
                ' AND Sys_Context('||''''||'NM3SQL'||''''||','||''''||'CONSECMODE'||''''||') = '||''''||'U'||''''||				
                ' and hur_username = Sys_Context('||''''||'NM3_SECURITY_CTX'||''''||','||''''||'USERNAME'||''''||') ) ';
/*

	RETURN '('||get_string('oun_admin_org_id')||' OR exists ( select 1 from contracts '||
                'where oun_org_id = con_contr_org_id )'||')' ; -- or oun_admin_org_id is null ';
*/				
    END IF; 
 END;
FUNCTION NE_predicate_READ( schema_in varchar2, name_in varchar2) RETURN varchar2 IS
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('ne_admin_unit')||' OR '||get_up_string('ne_admin_unit');--||' OR exists ( select 1 from nm_admin_units where nau_admin_unit = ne_admin_unit and nau_level = 1 )';
    END IF; 
 END;

FUNCTION NE_predicate_DML( schema_in varchar2, name_in varchar2) RETURN varchar2 IS
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('ne_admin_unit');--||' OR exists ( select 1 from nm_admin_units where nau_admin_unit = ne_admin_unit and nau_level = 1 )';
    END IF; 
 END;

FUNCTION NM_predicate_READ( schema_in varchar2, name_in varchar2) RETURN varchar2 IS
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN '('||get_string('nm_admin_unit')||' OR '||get_up_string('nm_admin_unit')||')';--||' OR exists ( select 1 from nm_admin_units where nau_admin_unit = ne_admin_unit and nau_level = 1 )';
    END IF; 
 END;

FUNCTION NM_predicate_DML( schema_in varchar2, name_in varchar2) RETURN varchar2 IS
BEGIN 
    IF Sys_Context('NM3CORE','UNRESTRICTED_INVENTORY') = 'TRUE' and Sys_Context('NM3_SECURITY_CTX','USERNAME') = Sys_Context('NM3_SECURITY_CTX','ACTUAL_USERNAME') 
     THEN 
       RETURN NULL; 
    ELSE 
       RETURN get_string('nm_admin_unit');--||' OR exists ( select 1 from nm_admin_units where nau_admin_unit = ne_admin_unit and nau_level = 1 )';
    END IF; 
 END;

--  
 begin 
   declare
     luser_au number;
   begin
     select hus_admin_unit into luser_au
     from hig_users where hus_user_id =  sys_context('NM3CORE', 'USER_ID');
     NM3CTX.SET_CORE_CONTEXT('USER_ADMIN_UNIT', luser_au );
     NM3CTX.SET_CONTEXT('CONSECMODE', hig.get_sysopt('CONSECMODE') ); 
   end;
   select nua_admin_unit 
   bulk collect into au_list.ia 
   from nm_user_aus 
   where nua_user_id = sys_context('NM3CORE', 'USER_ID');
 END maiausec;
/


