CREATE OR REPLACE PACKAGE BODY Inv_Copy AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/inv_copy.pkb-arc   2.2   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   inv_copy.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:30  $
--       Date fetched Out : $Modtime:   Jun 27 2018 11:04:20  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)inv_copy.pck	1.3 10/22/01'
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------

g_body_sccsid     CONSTANT  varchar2(2000) := '"$Revision:   2.2  $"';

     TYPE inv_rec IS RECORD
      (IIT_CREATED_DATE          inv_items_all.IIT_CREATED_DATE%TYPE,
       IIT_CRE_DATE              inv_items_all.IIT_CRE_DATE%TYPE,
       IIT_ITEM_ID               inv_items_all.IIT_ITEM_ID%TYPE,
       IIT_ITY_INV_CODE          inv_items_all.IIT_ITY_INV_CODE%TYPE,
       IIT_ITY_SYS_FLAG          inv_items_all.IIT_ITY_SYS_FLAG%TYPE,
       IIT_LAST_UPDATED_DATE     inv_items_all.IIT_LAST_UPDATED_DATE%TYPE,
       IIT_RSE_HE_ID             inv_items_all.IIT_RSE_HE_ID%TYPE,
       IIT_ST_CHAIN              inv_items_all.IIT_ST_CHAIN%TYPE,
       IIT_ANGLE                 inv_items_all.IIT_ANGLE%TYPE,
       IIT_ANGLE_TXT             inv_items_all.IIT_ANGLE_TXT%TYPE,
       IIT_CLASS                 inv_items_all.IIT_CLASS%TYPE,
       IIT_CLASS_TXT             inv_items_all.IIT_CLASS_TXT%TYPE,
       IIT_COLOUR                inv_items_all.IIT_COLOUR%TYPE,
       IIT_COLOUR_TXT            inv_items_all.IIT_COLOUR_TXT%TYPE,
       IIT_COORD_FLAG            inv_items_all.IIT_COORD_FLAG%TYPE,
       IIT_DESCRIPTION           inv_items_all.IIT_DESCRIPTION%TYPE,
       IIT_DIAGRAM               inv_items_all.IIT_DIAGRAM%TYPE,
       IIT_DISTANCE              inv_items_all.IIT_DISTANCE%TYPE,
       IIT_END_CHAIN             inv_items_all.IIT_END_CHAIN%TYPE,
       IIT_END_DATE              inv_items_all.IIT_END_DATE%TYPE,
       IIT_GAP                   inv_items_all.IIT_GAP%TYPE,
       IIT_HEIGHT                inv_items_all.IIT_HEIGHT%TYPE,
       IIT_HEIGHT_2              inv_items_all.IIT_HEIGHT_2%TYPE,
       IIT_ID_CODE               inv_items_all.IIT_ID_CODE%TYPE,
       IIT_INSTAL_DATE           inv_items_all.IIT_INSTAL_DATE%TYPE,
       IIT_INVENT_DATE           inv_items_all.IIT_INVENT_DATE%TYPE,
       IIT_INV_OWNERSHIP         inv_items_all.IIT_INV_OWNERSHIP%TYPE,
       IIT_ITEMCODE              inv_items_all.IIT_ITEMCODE%TYPE,
       IIT_LCO_LAMP_CONFIG_ID    inv_items_all.IIT_LCO_LAMP_CONFIG_ID%TYPE,
       IIT_LENGTH                inv_items_all.IIT_LENGTH%TYPE,
       IIT_MATERIAL              inv_items_all.IIT_MATERIAL%TYPE,
       IIT_MATERIAL_TXT          inv_items_all.IIT_MATERIAL_TXT%TYPE,
       IIT_METHOD                inv_items_all.IIT_METHOD%TYPE,
       IIT_METHOD_TXT            inv_items_all.IIT_METHOD_TXT%TYPE,
       IIT_NOTE                  inv_items_all.IIT_NOTE%TYPE,
       IIT_NO_OF_UNITS           inv_items_all.IIT_NO_OF_UNITS%TYPE,
       IIT_OPTIONS               inv_items_all.IIT_OPTIONS%TYPE,
       IIT_OPTIONS_TXT           inv_items_all.IIT_OPTIONS_TXT%TYPE,
       IIT_OUN_ORG_ID_ELEC_BOARD inv_items_all.IIT_OUN_ORG_ID_ELEC_BOARD%TYPE,
       IIT_OWNER                 inv_items_all.IIT_OWNER%TYPE,
       IIT_OWNER_TXT             inv_items_all.IIT_OWNER_TXT%TYPE,
       IIT_PEO_INVENT_BY_ID      inv_items_all.IIT_PEO_INVENT_BY_ID%TYPE,
       IIT_PHOTO                 inv_items_all.IIT_PHOTO%TYPE,
       IIT_POWER                 inv_items_all.IIT_POWER%TYPE,
       IIT_PROV_FLAG             inv_items_all.IIT_PROV_FLAG%TYPE,
       IIT_REV_BY                inv_items_all.IIT_REV_BY%TYPE,
       IIT_REV_DATE              inv_items_all.IIT_REV_DATE%TYPE,
       IIT_TYPE                  inv_items_all.IIT_TYPE%TYPE,
       IIT_TYPE_TXT              inv_items_all.IIT_TYPE_TXT%TYPE,
       IIT_WIDTH                 inv_items_all.IIT_WIDTH%TYPE,
       IIT_XTRA_CHAR_1           inv_items_all.IIT_XTRA_CHAR_1%TYPE,
       IIT_XTRA_DATE_1           inv_items_all.IIT_XTRA_DATE_1%TYPE,
       IIT_XTRA_DOMAIN_1         inv_items_all.IIT_XTRA_DOMAIN_1%TYPE,
       IIT_XTRA_DOMAIN_TXT_1     inv_items_all.IIT_XTRA_DOMAIN_TXT_1%TYPE,
       IIT_XTRA_NUMBER_1         inv_items_all.IIT_XTRA_NUMBER_1%TYPE,
       IIT_X_SECT                inv_items_all.IIT_X_SECT%TYPE,
       IIT_PRIMARY_KEY           inv_items_all.IIT_PRIMARY_KEY%TYPE,
       IIT_FOREIGN_KEY           inv_items_all.IIT_FOREIGN_KEY%TYPE,
       IIT_NUM_ATTRIB16          inv_items_all.IIT_NUM_ATTRIB16%TYPE,
       IIT_NUM_ATTRIB17          inv_items_all.IIT_NUM_ATTRIB17%TYPE,
       IIT_NUM_ATTRIB18          inv_items_all.IIT_NUM_ATTRIB18%TYPE,
       IIT_NUM_ATTRIB19          inv_items_all.IIT_NUM_ATTRIB19%TYPE,
       IIT_NUM_ATTRIB20          inv_items_all.IIT_NUM_ATTRIB20%TYPE,
       IIT_NUM_ATTRIB21          inv_items_all.IIT_NUM_ATTRIB21%TYPE,
       IIT_NUM_ATTRIB22          inv_items_all.IIT_NUM_ATTRIB22%TYPE,
       IIT_NUM_ATTRIB23          inv_items_all.IIT_NUM_ATTRIB23%TYPE,
       IIT_NUM_ATTRIB24          inv_items_all.IIT_NUM_ATTRIB24%TYPE,
       IIT_NUM_ATTRIB25          inv_items_all.IIT_NUM_ATTRIB25%TYPE,
       IIT_CHR_ATTRIB26          inv_items_all.IIT_CHR_ATTRIB26%TYPE,
       IIT_CHR_ATTRIB27          inv_items_all.IIT_CHR_ATTRIB27%TYPE,
       IIT_CHR_ATTRIB28          inv_items_all.IIT_CHR_ATTRIB28%TYPE,
       IIT_CHR_ATTRIB29          inv_items_all.IIT_CHR_ATTRIB29%TYPE,
       IIT_CHR_ATTRIB30          inv_items_all.IIT_CHR_ATTRIB30%TYPE,
       IIT_CHR_ATTRIB31          inv_items_all.IIT_CHR_ATTRIB31%TYPE,
       IIT_CHR_ATTRIB32          inv_items_all.IIT_CHR_ATTRIB32%TYPE,
       IIT_CHR_ATTRIB33          inv_items_all.IIT_CHR_ATTRIB33%TYPE,
       IIT_CHR_ATTRIB34          inv_items_all.IIT_CHR_ATTRIB34%TYPE,
       IIT_CHR_ATTRIB35          inv_items_all.IIT_CHR_ATTRIB35%TYPE,
       IIT_CHR_ATTRIB36          inv_items_all.IIT_CHR_ATTRIB36%TYPE,
       IIT_CHR_ATTRIB37          inv_items_all.IIT_CHR_ATTRIB37%TYPE,
       IIT_CHR_ATTRIB38          inv_items_all.IIT_CHR_ATTRIB38%TYPE,
       IIT_CHR_ATTRIB39          inv_items_all.IIT_CHR_ATTRIB39%TYPE,
       IIT_CHR_ATTRIB40          inv_items_all.IIT_CHR_ATTRIB40%TYPE,
       IIT_CHR_ATTRIB41          inv_items_all.IIT_CHR_ATTRIB41%TYPE,
       IIT_CHR_ATTRIB42          inv_items_all.IIT_CHR_ATTRIB42%TYPE,
       IIT_CHR_ATTRIB43          inv_items_all.IIT_CHR_ATTRIB43%TYPE,
       IIT_CHR_ATTRIB44          inv_items_all.IIT_CHR_ATTRIB44%TYPE,
       IIT_CHR_ATTRIB45          inv_items_all.IIT_CHR_ATTRIB45%TYPE,
       IIT_CHR_ATTRIB46          inv_items_all.IIT_CHR_ATTRIB46%TYPE,
       IIT_CHR_ATTRIB47          inv_items_all.IIT_CHR_ATTRIB47%TYPE,
       IIT_CHR_ATTRIB48          inv_items_all.IIT_CHR_ATTRIB48%TYPE,
       IIT_CHR_ATTRIB49          inv_items_all.IIT_CHR_ATTRIB49%TYPE,
       IIT_CHR_ATTRIB50          inv_items_all.IIT_CHR_ATTRIB50%TYPE,
       IIT_CHR_ATTRIB51          inv_items_all.IIT_CHR_ATTRIB51%TYPE,
       IIT_CHR_ATTRIB52          inv_items_all.IIT_CHR_ATTRIB52%TYPE,
       IIT_CHR_ATTRIB53          inv_items_all.IIT_CHR_ATTRIB53%TYPE,
       IIT_CHR_ATTRIB54          inv_items_all.IIT_CHR_ATTRIB54%TYPE,
       IIT_CHR_ATTRIB55          inv_items_all.IIT_CHR_ATTRIB55%TYPE,
       IIT_CHR_ATTRIB56          inv_items_all.IIT_CHR_ATTRIB56%TYPE,
       IIT_CHR_ATTRIB57          inv_items_all.IIT_CHR_ATTRIB57%TYPE,
       IIT_CHR_ATTRIB58          inv_items_all.IIT_CHR_ATTRIB58%TYPE,
       IIT_CHR_ATTRIB59          inv_items_all.IIT_CHR_ATTRIB59%TYPE,
       IIT_CHR_ATTRIB60          inv_items_all.IIT_CHR_ATTRIB60%TYPE,
       IIT_CHR_ATTRIB61          inv_items_all.IIT_CHR_ATTRIB61%TYPE,
       IIT_CHR_ATTRIB62          inv_items_all.IIT_CHR_ATTRIB62%TYPE,
       IIT_CHR_ATTRIB63          inv_items_all.IIT_CHR_ATTRIB63%TYPE,
       IIT_CHR_ATTRIB64          inv_items_all.IIT_CHR_ATTRIB64%TYPE,
       IIT_CHR_ATTRIB65          inv_items_all.IIT_CHR_ATTRIB65%TYPE,
       IIT_CHR_ATTRIB66          inv_items_all.IIT_CHR_ATTRIB66%TYPE,
       IIT_CHR_ATTRIB67          inv_items_all.IIT_CHR_ATTRIB67%TYPE,
       IIT_CHR_ATTRIB68          inv_items_all.IIT_CHR_ATTRIB68%TYPE,
       IIT_CHR_ATTRIB69          inv_items_all.IIT_CHR_ATTRIB69%TYPE,
       IIT_CHR_ATTRIB70          inv_items_all.IIT_CHR_ATTRIB70%TYPE,
       IIT_CHR_ATTRIB71          inv_items_all.IIT_CHR_ATTRIB71%TYPE,
       IIT_CHR_ATTRIB72          inv_items_all.IIT_CHR_ATTRIB72%TYPE,
       IIT_CHR_ATTRIB73          inv_items_all.IIT_CHR_ATTRIB73%TYPE,
       IIT_CHR_ATTRIB74          inv_items_all.IIT_CHR_ATTRIB74%TYPE,
       IIT_CHR_ATTRIB75          inv_items_all.IIT_CHR_ATTRIB75%TYPE,
       IIT_DET_XSP               inv_items_all.IIT_DET_XSP%TYPE,
       IIT_OFFSET                inv_items_all.IIT_OFFSET%TYPE,
       IIT_NUM_ATTRIB76          inv_items_all.IIT_NUM_ATTRIB76%TYPE,
       IIT_NUM_ATTRIB77          inv_items_all.IIT_NUM_ATTRIB77%TYPE,
       IIT_NUM_ATTRIB78          inv_items_all.IIT_NUM_ATTRIB78%TYPE,
       IIT_NUM_ATTRIB79          inv_items_all.IIT_NUM_ATTRIB79%TYPE,
       IIT_NUM_ATTRIB80          inv_items_all.IIT_NUM_ATTRIB80%TYPE,
       IIT_NUM_ATTRIB81          inv_items_all.IIT_NUM_ATTRIB81%TYPE,
       IIT_NUM_ATTRIB82          inv_items_all.IIT_NUM_ATTRIB82%TYPE,
       IIT_NUM_ATTRIB83          inv_items_all.IIT_NUM_ATTRIB83%TYPE,
       IIT_NUM_ATTRIB84          inv_items_all.IIT_NUM_ATTRIB84%TYPE,
       IIT_NUM_ATTRIB85          inv_items_all.IIT_NUM_ATTRIB85%TYPE,
       IIT_DATE_ATTRIB86         inv_items_all.IIT_DATE_ATTRIB86%TYPE,
       IIT_DATE_ATTRIB87         inv_items_all.IIT_DATE_ATTRIB87%TYPE,
       IIT_DATE_ATTRIB88         inv_items_all.IIT_DATE_ATTRIB88%TYPE,
       IIT_DATE_ATTRIB89         inv_items_all.IIT_DATE_ATTRIB89%TYPE,
       IIT_DATE_ATTRIB90         inv_items_all.IIT_DATE_ATTRIB90%TYPE,
       IIT_DATE_ATTRIB91         inv_items_all.IIT_DATE_ATTRIB91%TYPE,
       IIT_DATE_ATTRIB92         inv_items_all.IIT_DATE_ATTRIB92%TYPE,
       IIT_DATE_ATTRIB93         inv_items_all.IIT_DATE_ATTRIB93%TYPE,
       IIT_DATE_ATTRIB94         inv_items_all.IIT_DATE_ATTRIB94%TYPE,
       IIT_DATE_ATTRIB95         inv_items_all.IIT_DATE_ATTRIB95%TYPE);

-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN VARCHAR2 IS
BEGIN
  RETURN g_sccsid;
END;
--
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------

PROCEDURE create_hier(p_item IN inv_items_all.iit_item_id%TYPE
                     ,p_asset_id IN inv_items_all.iit_primary_key%TYPE) IS
CURSOR c_hier IS
  SELECT iit_item_id, iit_primary_key, iit_foreign_key, iit_item_id_seq.NEXTVAL iit_new_val
  FROM inv_items_all
  CONNECT BY PRIOR iit_primary_key = iit_foreign_key
  START WITH iit_item_id = p_item;
BEGIN
  hier_count := 0;
  FOR c_rec IN c_hier LOOP
    hier_count := hier_count + 1;
    hier_tab(hier_count).old_item_id    := c_rec.iit_item_id;
    hier_tab(hier_count).old_primary_key := c_rec.iit_primary_key;
    hier_tab(hier_count).old_foreign_key := c_rec.iit_foreign_key;
    hier_tab(hier_count).new_item_id := c_rec.iit_new_val;
    IF (hier_count = 1) THEN
      hier_tab(hier_count).new_primary_key := nvl(p_asset_id, c_rec.iit_new_val);
    ELSE
      hier_tab(hier_count).new_primary_key := c_rec.iit_new_val;
    END IF;
  END LOOP;
END;
FUNCTION get_parent(p_item IN inv_items_all.iit_foreign_key%TYPE) RETURN NUMBER IS
i NUMBER;
BEGIN
  FOR i IN 1..hier_count LOOP
    IF (hier_tab(i).old_primary_key = p_item) THEN
       dbms_output.put_line('got old master'||hier_tab(i).new_primary_key|| 'from '|| p_item);
       RETURN hier_tab(i).new_primary_key;
    END IF;
  END LOOP;
  RETURN NULL; -- if we reach here there is no parent so return null
END;
PROCEDURE ins_inv(c_inv_rec IN inv_rec, v_attributes IN BOOLEAN) IS
BEGIN
      IF v_attributes THEN -- copy item + attributes
        INSERT INTO inv_items_all
        ( IIT_CREATED_DATE      , IIT_CRE_DATE             , IIT_ITEM_ID           ,
          IIT_ITY_INV_CODE      , IIT_ITY_SYS_FLAG         , IIT_LAST_UPDATED_DATE ,
          IIT_RSE_HE_ID         , IIT_ST_CHAIN             , IIT_ANGLE             ,
          IIT_ANGLE_TXT         , IIT_CLASS                , IIT_CLASS_TXT         ,
          IIT_COLOUR            , IIT_COLOUR_TXT           , IIT_COORD_FLAG        ,
          IIT_DESCRIPTION       , IIT_DIAGRAM              , IIT_DISTANCE          ,
          IIT_END_CHAIN         , IIT_END_DATE             , IIT_GAP               ,
          IIT_HEIGHT            , IIT_HEIGHT_2             , IIT_ID_CODE           ,
          IIT_INSTAL_DATE       , IIT_INVENT_DATE          , IIT_INV_OWNERSHIP     ,
          IIT_ITEMCODE          , IIT_LCO_LAMP_CONFIG_ID   , IIT_LENGTH            ,
          IIT_MATERIAL          , IIT_MATERIAL_TXT         , IIT_METHOD            ,
          IIT_METHOD_TXT        , IIT_NOTE                 , IIT_NO_OF_UNITS       ,
          IIT_OPTIONS           , IIT_OPTIONS_TXT          , IIT_OUN_ORG_ID_ELEC_BOARD,
          IIT_OWNER             , IIT_OWNER_TXT            , IIT_PEO_INVENT_BY_ID     ,
          IIT_PHOTO             , IIT_POWER                , IIT_PROV_FLAG            ,
          IIT_REV_BY            , IIT_REV_DATE             , IIT_TYPE                 ,
          IIT_TYPE_TXT          , IIT_WIDTH                , IIT_XTRA_CHAR_1          ,
          IIT_XTRA_DATE_1       , IIT_XTRA_DOMAIN_1        , IIT_XTRA_DOMAIN_TXT_1    ,
          IIT_XTRA_NUMBER_1     , IIT_X_SECT               , IIT_PRIMARY_KEY          ,
          IIT_FOREIGN_KEY       , IIT_NUM_ATTRIB16         , IIT_NUM_ATTRIB17         ,
          IIT_NUM_ATTRIB18      , IIT_NUM_ATTRIB19         , IIT_NUM_ATTRIB20         ,
          IIT_NUM_ATTRIB21      , IIT_NUM_ATTRIB22         , IIT_NUM_ATTRIB23         ,
          IIT_NUM_ATTRIB24      , IIT_NUM_ATTRIB25         , IIT_CHR_ATTRIB26         ,
          IIT_CHR_ATTRIB27      , IIT_CHR_ATTRIB28         , IIT_CHR_ATTRIB29         ,
          IIT_CHR_ATTRIB30      , IIT_CHR_ATTRIB31         , IIT_CHR_ATTRIB32         ,
          IIT_CHR_ATTRIB33      , IIT_CHR_ATTRIB34         , IIT_CHR_ATTRIB35         ,
          IIT_CHR_ATTRIB36      , IIT_CHR_ATTRIB37         , IIT_CHR_ATTRIB38         ,
          IIT_CHR_ATTRIB39      , IIT_CHR_ATTRIB40         , IIT_CHR_ATTRIB41         ,
          IIT_CHR_ATTRIB42      , IIT_CHR_ATTRIB43         , IIT_CHR_ATTRIB44         ,
          IIT_CHR_ATTRIB45      , IIT_CHR_ATTRIB46         , IIT_CHR_ATTRIB47         ,
          IIT_CHR_ATTRIB48      , IIT_CHR_ATTRIB49         , IIT_CHR_ATTRIB50         ,
          IIT_CHR_ATTRIB51      , IIT_CHR_ATTRIB52         , IIT_CHR_ATTRIB53         ,
          IIT_CHR_ATTRIB54      , IIT_CHR_ATTRIB55         , IIT_CHR_ATTRIB56         ,
          IIT_CHR_ATTRIB57      , IIT_CHR_ATTRIB58         , IIT_CHR_ATTRIB59         ,
          IIT_CHR_ATTRIB60      , IIT_CHR_ATTRIB61         , IIT_CHR_ATTRIB62         ,
          IIT_CHR_ATTRIB63      , IIT_CHR_ATTRIB64         , IIT_CHR_ATTRIB65         ,
          IIT_CHR_ATTRIB66      , IIT_CHR_ATTRIB67         , IIT_CHR_ATTRIB68         ,
          IIT_CHR_ATTRIB69      , IIT_CHR_ATTRIB70         , IIT_CHR_ATTRIB71         ,
          IIT_CHR_ATTRIB72      , IIT_CHR_ATTRIB73         , IIT_CHR_ATTRIB74         ,
          IIT_CHR_ATTRIB75      , IIT_DET_XSP              , IIT_OFFSET               ,
          IIT_NUM_ATTRIB76      , IIT_NUM_ATTRIB77         , IIT_NUM_ATTRIB78         ,
          IIT_NUM_ATTRIB79      , IIT_NUM_ATTRIB80         , IIT_NUM_ATTRIB81         ,
          IIT_NUM_ATTRIB82      , IIT_NUM_ATTRIB83         , IIT_NUM_ATTRIB84         ,
          IIT_NUM_ATTRIB85      , IIT_DATE_ATTRIB86        , IIT_DATE_ATTRIB87        ,
          IIT_DATE_ATTRIB88     , IIT_DATE_ATTRIB89        , IIT_DATE_ATTRIB90        ,
          IIT_DATE_ATTRIB91     , IIT_DATE_ATTRIB92        , IIT_DATE_ATTRIB93        ,
          IIT_DATE_ATTRIB94     , IIT_DATE_ATTRIB95
          )
        VALUES (trunc(SYSDATE)             , trunc(SYSDATE)                  , c_inv_rec.IIT_ITEM_ID          ,
                c_inv_rec.IIT_ITY_INV_CODE , c_inv_rec.IIT_ITY_SYS_FLAG      , c_inv_rec.IIT_LAST_UPDATED_DATE,
                c_inv_rec.IIT_RSE_HE_ID    , c_inv_rec.IIT_ST_CHAIN          , c_inv_rec.IIT_ANGLE            ,
                c_inv_rec.IIT_ANGLE_TXT    , c_inv_rec.IIT_CLASS             , c_inv_rec.IIT_CLASS_TXT        ,
                c_inv_rec.IIT_COLOUR       , c_inv_rec.IIT_COLOUR_TXT        , c_inv_rec.IIT_COORD_FLAG       ,
                c_inv_rec.IIT_DESCRIPTION  , c_inv_rec.IIT_DIAGRAM           , c_inv_rec.IIT_DISTANCE         ,
                c_inv_rec.IIT_END_CHAIN    , c_inv_rec.IIT_END_DATE          , c_inv_rec.IIT_GAP              ,
                c_inv_rec.IIT_HEIGHT       , c_inv_rec.IIT_HEIGHT_2          , c_inv_rec.IIT_ID_CODE          ,
                c_inv_rec.IIT_INSTAL_DATE  , c_inv_rec.IIT_INVENT_DATE       , c_inv_rec.IIT_INV_OWNERSHIP    ,
                c_inv_rec.IIT_ITEMCODE     , c_inv_rec.IIT_LCO_LAMP_CONFIG_ID, c_inv_rec.IIT_LENGTH           ,
                c_inv_rec.IIT_MATERIAL     , c_inv_rec.IIT_MATERIAL_TXT      , c_inv_rec.IIT_METHOD           ,
                c_inv_rec.IIT_METHOD_TXT   , c_inv_rec.IIT_NOTE              , c_inv_rec.IIT_NO_OF_UNITS      ,
                c_inv_rec.IIT_OPTIONS      , c_inv_rec.IIT_OPTIONS_TXT       , c_inv_rec.IIT_OUN_ORG_ID_ELEC_BOARD,
                c_inv_rec.IIT_OWNER        , c_inv_rec.IIT_OWNER_TXT         , c_inv_rec.IIT_PEO_INVENT_BY_ID,
                c_inv_rec.IIT_PHOTO        , c_inv_rec.IIT_POWER             , c_inv_rec.IIT_PROV_FLAG,
                c_inv_rec.IIT_REV_BY       , c_inv_rec.IIT_REV_DATE          , c_inv_rec.IIT_TYPE,
                c_inv_rec.IIT_TYPE_TXT     , c_inv_rec.IIT_WIDTH             , c_inv_rec.IIT_XTRA_CHAR_1,
                c_inv_rec.IIT_XTRA_DATE_1  , c_inv_rec.IIT_XTRA_DOMAIN_1     , c_inv_rec.IIT_XTRA_DOMAIN_TXT_1,
                c_inv_rec.IIT_XTRA_NUMBER_1, c_inv_rec.IIT_X_SECT            , c_inv_rec.IIT_PRIMARY_KEY,
                c_inv_rec.IIT_FOREIGN_KEY  , c_inv_rec.IIT_NUM_ATTRIB16      , c_inv_rec.IIT_NUM_ATTRIB17      ,
                c_inv_rec.IIT_NUM_ATTRIB18 , c_inv_rec.IIT_NUM_ATTRIB19      , c_inv_rec.IIT_NUM_ATTRIB20,
                c_inv_rec.IIT_NUM_ATTRIB21 , c_inv_rec.IIT_NUM_ATTRIB22      , c_inv_rec.IIT_NUM_ATTRIB23,
                c_inv_rec.IIT_NUM_ATTRIB24 , c_inv_rec.IIT_NUM_ATTRIB25      , c_inv_rec.IIT_CHR_ATTRIB26,
                c_inv_rec.IIT_CHR_ATTRIB27 , c_inv_rec.IIT_CHR_ATTRIB28      , c_inv_rec.IIT_CHR_ATTRIB29,
                c_inv_rec.IIT_CHR_ATTRIB30 , c_inv_rec.IIT_CHR_ATTRIB31      , c_inv_rec.IIT_CHR_ATTRIB32,
                c_inv_rec.IIT_CHR_ATTRIB33 , c_inv_rec.IIT_CHR_ATTRIB34      , c_inv_rec.IIT_CHR_ATTRIB35,
                c_inv_rec.IIT_CHR_ATTRIB36 , c_inv_rec.IIT_CHR_ATTRIB37      , c_inv_rec.IIT_CHR_ATTRIB38,
                c_inv_rec.IIT_CHR_ATTRIB39 , c_inv_rec.IIT_CHR_ATTRIB40      , c_inv_rec.IIT_CHR_ATTRIB41,
                c_inv_rec.IIT_CHR_ATTRIB42 , c_inv_rec.IIT_CHR_ATTRIB43      , c_inv_rec.IIT_CHR_ATTRIB44,
                c_inv_rec.IIT_CHR_ATTRIB45 , c_inv_rec.IIT_CHR_ATTRIB46      , c_inv_rec.IIT_CHR_ATTRIB47,
                c_inv_rec.IIT_CHR_ATTRIB48 , c_inv_rec.IIT_CHR_ATTRIB49      , c_inv_rec.IIT_CHR_ATTRIB50,
                c_inv_rec.IIT_CHR_ATTRIB51 , c_inv_rec.IIT_CHR_ATTRIB52      , c_inv_rec.IIT_CHR_ATTRIB53,
                c_inv_rec.IIT_CHR_ATTRIB54 , c_inv_rec.IIT_CHR_ATTRIB55      , c_inv_rec.IIT_CHR_ATTRIB56,
                c_inv_rec.IIT_CHR_ATTRIB57 , c_inv_rec.IIT_CHR_ATTRIB58      , c_inv_rec.IIT_CHR_ATTRIB59,
                c_inv_rec.IIT_CHR_ATTRIB60 , c_inv_rec.IIT_CHR_ATTRIB61      , c_inv_rec.IIT_CHR_ATTRIB62,
                c_inv_rec.IIT_CHR_ATTRIB63 , c_inv_rec.IIT_CHR_ATTRIB64      , c_inv_rec.IIT_CHR_ATTRIB65,
                c_inv_rec.IIT_CHR_ATTRIB66 , c_inv_rec.IIT_CHR_ATTRIB67      , c_inv_rec.IIT_CHR_ATTRIB68,
                c_inv_rec.IIT_CHR_ATTRIB69 , c_inv_rec.IIT_CHR_ATTRIB70      , c_inv_rec.IIT_CHR_ATTRIB71,
                c_inv_rec.IIT_CHR_ATTRIB72 , c_inv_rec.IIT_CHR_ATTRIB73      , c_inv_rec.IIT_CHR_ATTRIB74,
                c_inv_rec.IIT_CHR_ATTRIB75 , c_inv_rec.IIT_DET_XSP           , c_inv_rec.IIT_OFFSET      ,
                c_inv_rec.IIT_NUM_ATTRIB76 , c_inv_rec.IIT_NUM_ATTRIB77      , c_inv_rec.IIT_NUM_ATTRIB78,
                c_inv_rec.IIT_NUM_ATTRIB79 , c_inv_rec.IIT_NUM_ATTRIB80      , c_inv_rec.IIT_NUM_ATTRIB81,
                c_inv_rec.IIT_NUM_ATTRIB82 , c_inv_rec.IIT_NUM_ATTRIB83      , c_inv_rec.IIT_NUM_ATTRIB84,
                c_inv_rec.IIT_NUM_ATTRIB85 , c_inv_rec.IIT_DATE_ATTRIB86     , c_inv_rec.IIT_DATE_ATTRIB87,
                c_inv_rec.IIT_DATE_ATTRIB88, c_inv_rec.IIT_DATE_ATTRIB89     , c_inv_rec.IIT_DATE_ATTRIB90,
                c_inv_rec.IIT_DATE_ATTRIB91, c_inv_rec.IIT_DATE_ATTRIB92     , c_inv_rec.IIT_DATE_ATTRIB93,
                c_inv_rec.IIT_DATE_ATTRIB94, c_inv_rec.IIT_DATE_ATTRIB95
                );
      ELSE
        INSERT INTO inv_items_all
         ( IIT_CREATED_DATE       , IIT_CRE_DATE         , IIT_ITEM_ID              , IIT_ITY_INV_CODE,
           IIT_ITY_SYS_FLAG       , IIT_LAST_UPDATED_DATE, IIT_RSE_HE_ID            , IIT_ST_CHAIN    ,
           IIT_ANGLE              , IIT_ANGLE_TXT        , IIT_CLASS                , IIT_CLASS_TXT   ,
           IIT_COLOUR             , IIT_COLOUR_TXT       , IIT_COORD_FLAG           , IIT_DESCRIPTION ,
           IIT_DIAGRAM            , IIT_DISTANCE         , IIT_END_CHAIN            , IIT_END_DATE    ,
           IIT_GAP                , IIT_HEIGHT           , IIT_HEIGHT_2             , IIT_ID_CODE     ,
           IIT_INSTAL_DATE        , IIT_INVENT_DATE      , IIT_INV_OWNERSHIP        , IIT_ITEMCODE    ,
           IIT_LCO_LAMP_CONFIG_ID , IIT_LENGTH           , IIT_MATERIAL             , IIT_MATERIAL_TXT,
           IIT_METHOD             , IIT_METHOD_TXT       , IIT_NOTE                 , IIT_NO_OF_UNITS ,
           IIT_OPTIONS            , IIT_OPTIONS_TXT      , IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER       ,
           IIT_OWNER_TXT          , IIT_PEO_INVENT_BY_ID , IIT_PHOTO                , IIT_POWER       ,
           IIT_PROV_FLAG          , IIT_REV_BY           , IIT_REV_DATE             , IIT_TYPE        ,
           IIT_TYPE_TXT           , IIT_WIDTH            , IIT_XTRA_CHAR_1          , IIT_XTRA_DATE_1 ,
           IIT_XTRA_DOMAIN_1      , IIT_XTRA_DOMAIN_TXT_1, IIT_XTRA_NUMBER_1        , IIT_X_SECT      ,
           IIT_PRIMARY_KEY        , IIT_FOREIGN_KEY)
        VALUES
 (trunc(SYSDATE),trunc(SYSDATE),c_inv_rec.IIT_ITEM_ID,c_inv_rec.IIT_ITY_INV_CODE,
  c_inv_rec.IIT_ITY_SYS_FLAG, c_inv_rec.IIT_LAST_UPDATED_DATE, c_inv_rec.IIT_RSE_HE_ID    , c_inv_rec.IIT_ST_CHAIN,
  c_inv_rec.IIT_ANGLE       , c_inv_rec.IIT_ANGLE_TXT        , c_inv_rec.IIT_CLASS        , c_inv_rec.IIT_CLASS_TXT,
  c_inv_rec.IIT_COLOUR      , c_inv_rec.IIT_COLOUR_TXT       , c_inv_rec.IIT_COORD_FLAG   , c_inv_rec.IIT_DESCRIPTION,
  c_inv_rec.IIT_DIAGRAM     , c_inv_rec.IIT_DISTANCE         , c_inv_rec.IIT_END_CHAIN    , c_inv_rec.IIT_END_DATE,
  c_inv_rec.IIT_GAP         , c_inv_rec.IIT_HEIGHT           , c_inv_rec.IIT_HEIGHT_2     , c_inv_rec.IIT_ID_CODE,
  c_inv_rec.IIT_INSTAL_DATE , c_inv_rec.IIT_INVENT_DATE      , c_inv_rec.IIT_INV_OWNERSHIP, c_inv_rec.IIT_ITEMCODE,
  c_inv_rec.IIT_LCO_LAMP_CONFIG_ID, c_inv_rec.IIT_LENGTH     , c_inv_rec.IIT_MATERIAL     , c_inv_rec.IIT_MATERIAL_TXT,
  c_inv_rec.IIT_METHOD      , c_inv_rec.IIT_METHOD_TXT       , c_inv_rec.IIT_NOTE                 , c_inv_rec.IIT_NO_OF_UNITS,
  c_inv_rec.IIT_OPTIONS     , c_inv_rec.IIT_OPTIONS_TXT      , c_inv_rec.IIT_OUN_ORG_ID_ELEC_BOARD, c_inv_rec.IIT_OWNER,
  c_inv_rec.IIT_OWNER_TXT   , c_inv_rec.IIT_PEO_INVENT_BY_ID , c_inv_rec.IIT_PHOTO        , c_inv_rec.IIT_POWER,
  c_inv_rec.IIT_PROV_FLAG   , c_inv_rec.IIT_REV_BY           , c_inv_rec.IIT_REV_DATE     , c_inv_rec.IIT_TYPE,
  c_inv_rec.IIT_TYPE_TXT    , c_inv_rec.IIT_WIDTH            , c_inv_rec.IIT_XTRA_CHAR_1  , c_inv_rec.IIT_XTRA_DATE_1,
  c_inv_rec.IIT_XTRA_DOMAIN_1, c_inv_rec.IIT_XTRA_DOMAIN_TXT_1, c_inv_rec.IIT_XTRA_NUMBER_1, c_inv_rec.IIT_X_SECT,
  c_inv_rec.IIT_PRIMARY_KEY, c_inv_rec.IIT_FOREIGN_KEY);
      END IF;
END;
PROCEDURE drill_down(p_where IN VARCHAR2) IS
BEGIN
  drill_tab(drill_level) := p_where;
  drill_level := drill_level + 1;
END;
FUNCTION drill_up RETURN VARCHAR2 IS
BEGIN
  IF (drill_level = 0) THEN
    RETURN NULL;
  ELSE
    drill_level := drill_level - 1;
    RETURN drill_tab(drill_level);
  END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN
   RETURN NULL;
END;
FUNCTION copy_inventory (p_item IN inv_items_all.iit_item_id%TYPE
                        ,p_section IN road_segs.rse_he_id%TYPE
                        ,p_st_chain IN inv_items_all.iit_st_chain%TYPE
                        ,p_end_chain IN inv_items_all.iit_end_chain%TYPE
                        ,p_xsp IN inv_items_all.iit_x_sect%TYPE
                        ,p_attributes BOOLEAN DEFAULT FALSE
                        ,p_children BOOLEAN DEFAULT FALSE
                        ,p_asset_id IN inv_items_all.iit_primary_key%TYPE DEFAULT NULL)
                        RETURN NUMBER IS
CURSOR c_inv_items (p_item_id inv_items_all.iit_item_id%TYPE) IS
  SELECT   IIT_CREATED_DATE, IIT_CRE_DATE          , IIT_ITEM_ID   , IIT_ITY_INV_CODE,
           IIT_ITY_SYS_FLAG, IIT_LAST_UPDATED_DATE , NVL(p_section , IIT_RSE_HE_ID)iit_rse_he_id, NVL(p_st_chain,IIT_ST_CHAIN) iit_st_chain,
           IIT_ANGLE       , IIT_ANGLE_TXT         , IIT_CLASS     , IIT_CLASS_TXT,
           IIT_COLOUR      , IIT_COLOUR_TXT        , IIT_COORD_FLAG, IIT_DESCRIPTION,
           IIT_DIAGRAM     , IIT_DISTANCE          , NVL(p_end_chain,IIT_END_CHAIN)iit_end_chain , IIT_END_DATE,
           IIT_GAP         , IIT_HEIGHT            , IIT_HEIGHT_2   , IIT_ID_CODE,
           IIT_INSTAL_DATE, IIT_INVENT_DATE, IIT_INV_OWNERSHIP, IIT_ITEMCODE, IIT_LCO_LAMP_CONFIG_ID,
           IIT_LENGTH, IIT_MATERIAL, IIT_MATERIAL_TXT, IIT_METHOD, IIT_METHOD_TXT, IIT_NOTE, IIT_NO_OF_UNITS,
           IIT_OPTIONS, IIT_OPTIONS_TXT, IIT_OUN_ORG_ID_ELEC_BOARD, IIT_OWNER, IIT_OWNER_TXT,
           IIT_PEO_INVENT_BY_ID, IIT_PHOTO, IIT_POWER, IIT_PROV_FLAG, IIT_REV_BY, IIT_REV_DATE, IIT_TYPE,
           IIT_TYPE_TXT, IIT_WIDTH, IIT_XTRA_CHAR_1, IIT_XTRA_DATE_1, IIT_XTRA_DOMAIN_1, IIT_XTRA_DOMAIN_TXT_1,
           IIT_XTRA_NUMBER_1, NVL(p_xsp, IIT_X_SECT) iit_x_sect, IIT_PRIMARY_KEY, IIT_FOREIGN_KEY, IIT_NUM_ATTRIB16, IIT_NUM_ATTRIB17,
           IIT_NUM_ATTRIB18, IIT_NUM_ATTRIB19, IIT_NUM_ATTRIB20, IIT_NUM_ATTRIB21, IIT_NUM_ATTRIB22,
           IIT_NUM_ATTRIB23, IIT_NUM_ATTRIB24, IIT_NUM_ATTRIB25, IIT_CHR_ATTRIB26, IIT_CHR_ATTRIB27,
           IIT_CHR_ATTRIB28, IIT_CHR_ATTRIB29, IIT_CHR_ATTRIB30, IIT_CHR_ATTRIB31, IIT_CHR_ATTRIB32,
           IIT_CHR_ATTRIB33, IIT_CHR_ATTRIB34, IIT_CHR_ATTRIB35, IIT_CHR_ATTRIB36, IIT_CHR_ATTRIB37,
           IIT_CHR_ATTRIB38, IIT_CHR_ATTRIB39, IIT_CHR_ATTRIB40, IIT_CHR_ATTRIB41, IIT_CHR_ATTRIB42,
           IIT_CHR_ATTRIB43, IIT_CHR_ATTRIB44, IIT_CHR_ATTRIB45, IIT_CHR_ATTRIB46, IIT_CHR_ATTRIB47,
           IIT_CHR_ATTRIB48, IIT_CHR_ATTRIB49, IIT_CHR_ATTRIB50, IIT_CHR_ATTRIB51, IIT_CHR_ATTRIB52,
           IIT_CHR_ATTRIB53, IIT_CHR_ATTRIB54, IIT_CHR_ATTRIB55, IIT_CHR_ATTRIB56, IIT_CHR_ATTRIB57,
           IIT_CHR_ATTRIB58, IIT_CHR_ATTRIB59, IIT_CHR_ATTRIB60, IIT_CHR_ATTRIB61, IIT_CHR_ATTRIB62,
           IIT_CHR_ATTRIB63, IIT_CHR_ATTRIB64, IIT_CHR_ATTRIB65, IIT_CHR_ATTRIB66, IIT_CHR_ATTRIB67,
           IIT_CHR_ATTRIB68, IIT_CHR_ATTRIB69, IIT_CHR_ATTRIB70, IIT_CHR_ATTRIB71, IIT_CHR_ATTRIB72,
           IIT_CHR_ATTRIB73, IIT_CHR_ATTRIB74, IIT_CHR_ATTRIB75, IIT_DET_XSP     , IIT_OFFSET      ,
           IIT_NUM_ATTRIB76, IIT_NUM_ATTRIB77, IIT_NUM_ATTRIB78, IIT_NUM_ATTRIB79, IIT_NUM_ATTRIB80,
           IIT_NUM_ATTRIB81, IIT_NUM_ATTRIB82, IIT_NUM_ATTRIB83, IIT_NUM_ATTRIB84, IIT_NUM_ATTRIB85,
           IIT_DATE_ATTRIB86, IIT_DATE_ATTRIB87, IIT_DATE_ATTRIB88, IIT_DATE_ATTRIB89, IIT_DATE_ATTRIB90,
           IIT_DATE_ATTRIB91, IIT_DATE_ATTRIB92, IIT_DATE_ATTRIB93, IIT_DATE_ATTRIB94, IIT_DATE_ATTRIB95
  FROM   inv_items
  WHERE  iit_item_id = p_item_id;

  CURSOR c_get_next_id IS
  SELECT iit_item_id_seq.NEXTVAL
  FROM dual;

--  c_inv_rec     inv_items_all%ROWTYPE;
   --
    c_inv_rec     inv_rec;

i NUMBER;
BEGIN
  IF p_children THEN
    create_hier(p_item, p_asset_id);
    FOR i IN 1..hier_count LOOP
    -- insert record for all in hierarchy
      OPEN  c_inv_items(hier_tab(i).old_item_id);
      FETCH c_inv_items
      INTO  c_inv_rec.IIT_CREATED_DATE,
            c_inv_rec.IIT_CRE_DATE,
            c_inv_rec.IIT_ITEM_ID,
            c_inv_rec.IIT_ITY_INV_CODE,
            c_inv_rec.IIT_ITY_SYS_FLAG,
            c_inv_rec.IIT_LAST_UPDATED_DATE,
            c_inv_rec.iit_rse_he_id,
            c_inv_rec.iit_st_chain,
            c_inv_rec.IIT_ANGLE,
            c_inv_rec.IIT_ANGLE_TXT,
            c_inv_rec.IIT_CLASS,
            c_inv_rec.IIT_CLASS_TXT,
            c_inv_rec.IIT_COLOUR,
            c_inv_rec.IIT_COLOUR_TXT,
            c_inv_rec.IIT_COORD_FLAG,
            c_inv_rec.IIT_DESCRIPTION,
            c_inv_rec.IIT_DIAGRAM,
            c_inv_rec.IIT_DISTANCE,
            c_inv_rec.iit_end_chain,
            c_inv_rec.IIT_END_DATE,
            c_inv_rec.IIT_GAP,
            c_inv_rec.IIT_HEIGHT,
            c_inv_rec.IIT_HEIGHT_2,
            c_inv_rec.IIT_ID_CODE,
            c_inv_rec.IIT_INSTAL_DATE,
            c_inv_rec.IIT_INVENT_DATE,
            c_inv_rec.IIT_INV_OWNERSHIP,
            c_inv_rec.IIT_ITEMCODE,
            c_inv_rec.IIT_LCO_LAMP_CONFIG_ID,
            c_inv_rec.IIT_LENGTH,
            c_inv_rec.IIT_MATERIAL,
            c_inv_rec.IIT_MATERIAL_TXT,
            c_inv_rec.IIT_METHOD,
            c_inv_rec.IIT_METHOD_TXT,
            c_inv_rec.IIT_NOTE,
            c_inv_rec.IIT_NO_OF_UNITS,
            c_inv_rec.IIT_OPTIONS,
            c_inv_rec.IIT_OPTIONS_TXT,
            c_inv_rec.IIT_OUN_ORG_ID_ELEC_BOARD,
            c_inv_rec.IIT_OWNER,
            c_inv_rec.IIT_OWNER_TXT,
            c_inv_rec.IIT_PEO_INVENT_BY_ID,
            c_inv_rec.IIT_PHOTO,
            c_inv_rec.IIT_POWER,
            c_inv_rec.IIT_PROV_FLAG,
            c_inv_rec.IIT_REV_BY,
            c_inv_rec.IIT_REV_DATE,
            c_inv_rec.IIT_TYPE,
            c_inv_rec.IIT_TYPE_TXT,
            c_inv_rec.IIT_WIDTH,
            c_inv_rec.IIT_XTRA_CHAR_1,
            c_inv_rec.IIT_XTRA_DATE_1,
            c_inv_rec.IIT_XTRA_DOMAIN_1,
            c_inv_rec.IIT_XTRA_DOMAIN_TXT_1,
            c_inv_rec.IIT_XTRA_NUMBER_1,
            c_inv_rec.IIT_X_SECT,
            c_inv_rec.IIT_PRIMARY_KEY,
            c_inv_rec.IIT_FOREIGN_KEY,
            c_inv_rec.IIT_NUM_ATTRIB16,
            c_inv_rec.IIT_NUM_ATTRIB17,
            c_inv_rec.IIT_NUM_ATTRIB18,
            c_inv_rec.IIT_NUM_ATTRIB19,
            c_inv_rec.IIT_NUM_ATTRIB20,
            c_inv_rec.IIT_NUM_ATTRIB21,
            c_inv_rec.IIT_NUM_ATTRIB22,
            c_inv_rec.IIT_NUM_ATTRIB23,
            c_inv_rec.IIT_NUM_ATTRIB24,
            c_inv_rec.IIT_NUM_ATTRIB25,
            c_inv_rec.IIT_CHR_ATTRIB26,
            c_inv_rec.IIT_CHR_ATTRIB27,
            c_inv_rec.IIT_CHR_ATTRIB28,
            c_inv_rec.IIT_CHR_ATTRIB29,
            c_inv_rec.IIT_CHR_ATTRIB30,
            c_inv_rec.IIT_CHR_ATTRIB31,
            c_inv_rec.IIT_CHR_ATTRIB32,
            c_inv_rec.IIT_CHR_ATTRIB33,
            c_inv_rec.IIT_CHR_ATTRIB34,
            c_inv_rec.IIT_CHR_ATTRIB35,
            c_inv_rec.IIT_CHR_ATTRIB36,
            c_inv_rec.IIT_CHR_ATTRIB37,
            c_inv_rec.IIT_CHR_ATTRIB38,
            c_inv_rec.IIT_CHR_ATTRIB39,
            c_inv_rec.IIT_CHR_ATTRIB40,
            c_inv_rec.IIT_CHR_ATTRIB41,
            c_inv_rec.IIT_CHR_ATTRIB42,
            c_inv_rec.IIT_CHR_ATTRIB43,
            c_inv_rec.IIT_CHR_ATTRIB44,
            c_inv_rec.IIT_CHR_ATTRIB45,
            c_inv_rec.IIT_CHR_ATTRIB46,
            c_inv_rec.IIT_CHR_ATTRIB47,
            c_inv_rec.IIT_CHR_ATTRIB48,
            c_inv_rec.IIT_CHR_ATTRIB49,
            c_inv_rec.IIT_CHR_ATTRIB50,
            c_inv_rec.IIT_CHR_ATTRIB51,
            c_inv_rec.IIT_CHR_ATTRIB52,
            c_inv_rec.IIT_CHR_ATTRIB53,
            c_inv_rec.IIT_CHR_ATTRIB54,
            c_inv_rec.IIT_CHR_ATTRIB55,
            c_inv_rec.IIT_CHR_ATTRIB56,
            c_inv_rec.IIT_CHR_ATTRIB57,
            c_inv_rec.IIT_CHR_ATTRIB58,
            c_inv_rec.IIT_CHR_ATTRIB59,
            c_inv_rec.IIT_CHR_ATTRIB60,
            c_inv_rec.IIT_CHR_ATTRIB61,
            c_inv_rec.IIT_CHR_ATTRIB62,
            c_inv_rec.IIT_CHR_ATTRIB63,
            c_inv_rec.IIT_CHR_ATTRIB64,
            c_inv_rec.IIT_CHR_ATTRIB65,
            c_inv_rec.IIT_CHR_ATTRIB66,
            c_inv_rec.IIT_CHR_ATTRIB67,
            c_inv_rec.IIT_CHR_ATTRIB68,
            c_inv_rec.IIT_CHR_ATTRIB69,
            c_inv_rec.IIT_CHR_ATTRIB70,
            c_inv_rec.IIT_CHR_ATTRIB71,
            c_inv_rec.IIT_CHR_ATTRIB72,
            c_inv_rec.IIT_CHR_ATTRIB73,
            c_inv_rec.IIT_CHR_ATTRIB74,
            c_inv_rec.IIT_CHR_ATTRIB75,
            c_inv_rec.IIT_DET_XSP,
            c_inv_rec.IIT_OFFSET,
            c_inv_rec.IIT_NUM_ATTRIB76,
            c_inv_rec.IIT_NUM_ATTRIB77,
            c_inv_rec.IIT_NUM_ATTRIB78,
            c_inv_rec.IIT_NUM_ATTRIB79,
            c_inv_rec.IIT_NUM_ATTRIB80,
            c_inv_rec.IIT_NUM_ATTRIB81,
            c_inv_rec.IIT_NUM_ATTRIB82,
            c_inv_rec.IIT_NUM_ATTRIB83,
            c_inv_rec.IIT_NUM_ATTRIB84,
            c_inv_rec.IIT_NUM_ATTRIB85,
            c_inv_rec.IIT_DATE_ATTRIB86,
            c_inv_rec.IIT_DATE_ATTRIB87,
            c_inv_rec.IIT_DATE_ATTRIB88,
            c_inv_rec.IIT_DATE_ATTRIB89,
            c_inv_rec.IIT_DATE_ATTRIB90,
            c_inv_rec.IIT_DATE_ATTRIB91,
            c_inv_rec.IIT_DATE_ATTRIB92,
            c_inv_rec.IIT_DATE_ATTRIB93,
            c_inv_rec.IIT_DATE_ATTRIB94,
            c_inv_rec.IIT_DATE_ATTRIB95;
        -- set up foreign key using old hierarchy
        c_inv_rec.iit_foreign_key := get_parent(c_inv_rec.iit_foreign_key);
        c_inv_rec.iit_primary_key := hier_tab(i).new_primary_key;
        c_inv_rec.iit_item_id     := hier_tab(i).new_item_id;
        ins_inv(c_inv_rec, p_attributes);
      CLOSE c_inv_items;
    END LOOP;
    hier_tab := null_tab;    -- clear out table contents ready for next use
  ELSE -- dont copy children
      -- get next sequence id for new item id
    OPEN c_get_next_id;
    FETCH c_get_next_id INTO c_inv_rec.iit_item_id;
    CLOSE c_get_next_id;

    OPEN c_inv_items(p_item);
    FETCH c_inv_items
    INTO c_inv_rec.IIT_CREATED_DATE,
            c_inv_rec.IIT_CRE_DATE,
            c_inv_rec.IIT_ITEM_ID,
            c_inv_rec.IIT_ITY_INV_CODE,
            c_inv_rec.IIT_ITY_SYS_FLAG,
            c_inv_rec.IIT_LAST_UPDATED_DATE,
            c_inv_rec.iit_rse_he_id,
            c_inv_rec.iit_st_chain,
            c_inv_rec.IIT_ANGLE,
            c_inv_rec.IIT_ANGLE_TXT,
            c_inv_rec.IIT_CLASS,
            c_inv_rec.IIT_CLASS_TXT,
            c_inv_rec.IIT_COLOUR,
            c_inv_rec.IIT_COLOUR_TXT,
            c_inv_rec.IIT_COORD_FLAG,
            c_inv_rec.IIT_DESCRIPTION,
            c_inv_rec.IIT_DIAGRAM,
            c_inv_rec.IIT_DISTANCE,
            c_inv_rec.iit_end_chain,
            c_inv_rec.IIT_END_DATE,
            c_inv_rec.IIT_GAP,
            c_inv_rec.IIT_HEIGHT,
            c_inv_rec.IIT_HEIGHT_2,
            c_inv_rec.IIT_ID_CODE,
            c_inv_rec.IIT_INSTAL_DATE,
            c_inv_rec.IIT_INVENT_DATE,
            c_inv_rec.IIT_INV_OWNERSHIP,
            c_inv_rec.IIT_ITEMCODE,
            c_inv_rec.IIT_LCO_LAMP_CONFIG_ID,
            c_inv_rec.IIT_LENGTH,
            c_inv_rec.IIT_MATERIAL,
            c_inv_rec.IIT_MATERIAL_TXT,
            c_inv_rec.IIT_METHOD,
            c_inv_rec.IIT_METHOD_TXT,
            c_inv_rec.IIT_NOTE,
            c_inv_rec.IIT_NO_OF_UNITS,
            c_inv_rec.IIT_OPTIONS,
            c_inv_rec.IIT_OPTIONS_TXT,
            c_inv_rec.IIT_OUN_ORG_ID_ELEC_BOARD,
            c_inv_rec.IIT_OWNER,
            c_inv_rec.IIT_OWNER_TXT,
            c_inv_rec.IIT_PEO_INVENT_BY_ID,
            c_inv_rec.IIT_PHOTO,
            c_inv_rec.IIT_POWER,
            c_inv_rec.IIT_PROV_FLAG,
            c_inv_rec.IIT_REV_BY,
            c_inv_rec.IIT_REV_DATE,
            c_inv_rec.IIT_TYPE,
            c_inv_rec.IIT_TYPE_TXT,
            c_inv_rec.IIT_WIDTH,
            c_inv_rec.IIT_XTRA_CHAR_1,
            c_inv_rec.IIT_XTRA_DATE_1,
            c_inv_rec.IIT_XTRA_DOMAIN_1,
            c_inv_rec.IIT_XTRA_DOMAIN_TXT_1,
            c_inv_rec.IIT_XTRA_NUMBER_1,
            c_inv_rec.IIT_X_SECT,
            c_inv_rec.IIT_PRIMARY_KEY,
            c_inv_rec.IIT_FOREIGN_KEY,
            c_inv_rec.IIT_NUM_ATTRIB16,
            c_inv_rec.IIT_NUM_ATTRIB17,
            c_inv_rec.IIT_NUM_ATTRIB18,
            c_inv_rec.IIT_NUM_ATTRIB19,
            c_inv_rec.IIT_NUM_ATTRIB20,
            c_inv_rec.IIT_NUM_ATTRIB21,
            c_inv_rec.IIT_NUM_ATTRIB22,
            c_inv_rec.IIT_NUM_ATTRIB23,
            c_inv_rec.IIT_NUM_ATTRIB24,
            c_inv_rec.IIT_NUM_ATTRIB25,
            c_inv_rec.IIT_CHR_ATTRIB26,
            c_inv_rec.IIT_CHR_ATTRIB27,
            c_inv_rec.IIT_CHR_ATTRIB28,
            c_inv_rec.IIT_CHR_ATTRIB29,
            c_inv_rec.IIT_CHR_ATTRIB30,
            c_inv_rec.IIT_CHR_ATTRIB31,
            c_inv_rec.IIT_CHR_ATTRIB32,
            c_inv_rec.IIT_CHR_ATTRIB33,
            c_inv_rec.IIT_CHR_ATTRIB34,
            c_inv_rec.IIT_CHR_ATTRIB35,
            c_inv_rec.IIT_CHR_ATTRIB36,
            c_inv_rec.IIT_CHR_ATTRIB37,
            c_inv_rec.IIT_CHR_ATTRIB38,
            c_inv_rec.IIT_CHR_ATTRIB39,
            c_inv_rec.IIT_CHR_ATTRIB40,
            c_inv_rec.IIT_CHR_ATTRIB41,
            c_inv_rec.IIT_CHR_ATTRIB42,
            c_inv_rec.IIT_CHR_ATTRIB43,
            c_inv_rec.IIT_CHR_ATTRIB44,
            c_inv_rec.IIT_CHR_ATTRIB45,
            c_inv_rec.IIT_CHR_ATTRIB46,
            c_inv_rec.IIT_CHR_ATTRIB47,
            c_inv_rec.IIT_CHR_ATTRIB48,
            c_inv_rec.IIT_CHR_ATTRIB49,
            c_inv_rec.IIT_CHR_ATTRIB50,
            c_inv_rec.IIT_CHR_ATTRIB51,
            c_inv_rec.IIT_CHR_ATTRIB52,
            c_inv_rec.IIT_CHR_ATTRIB53,
            c_inv_rec.IIT_CHR_ATTRIB54,
            c_inv_rec.IIT_CHR_ATTRIB55,
            c_inv_rec.IIT_CHR_ATTRIB56,
            c_inv_rec.IIT_CHR_ATTRIB57,
            c_inv_rec.IIT_CHR_ATTRIB58,
            c_inv_rec.IIT_CHR_ATTRIB59,
            c_inv_rec.IIT_CHR_ATTRIB60,
            c_inv_rec.IIT_CHR_ATTRIB61,
            c_inv_rec.IIT_CHR_ATTRIB62,
            c_inv_rec.IIT_CHR_ATTRIB63,
            c_inv_rec.IIT_CHR_ATTRIB64,
            c_inv_rec.IIT_CHR_ATTRIB65,
            c_inv_rec.IIT_CHR_ATTRIB66,
            c_inv_rec.IIT_CHR_ATTRIB67,
            c_inv_rec.IIT_CHR_ATTRIB68,
            c_inv_rec.IIT_CHR_ATTRIB69,
            c_inv_rec.IIT_CHR_ATTRIB70,
            c_inv_rec.IIT_CHR_ATTRIB71,
            c_inv_rec.IIT_CHR_ATTRIB72,
            c_inv_rec.IIT_CHR_ATTRIB73,
            c_inv_rec.IIT_CHR_ATTRIB74,
            c_inv_rec.IIT_CHR_ATTRIB75,
            c_inv_rec.IIT_DET_XSP,
            c_inv_rec.IIT_OFFSET,
            c_inv_rec.IIT_NUM_ATTRIB76,
            c_inv_rec.IIT_NUM_ATTRIB77,
            c_inv_rec.IIT_NUM_ATTRIB78,
            c_inv_rec.IIT_NUM_ATTRIB79,
            c_inv_rec.IIT_NUM_ATTRIB80,
            c_inv_rec.IIT_NUM_ATTRIB81,
            c_inv_rec.IIT_NUM_ATTRIB82,
            c_inv_rec.IIT_NUM_ATTRIB83,
            c_inv_rec.IIT_NUM_ATTRIB84,
            c_inv_rec.IIT_NUM_ATTRIB85,
            c_inv_rec.IIT_DATE_ATTRIB86,
            c_inv_rec.IIT_DATE_ATTRIB87,
            c_inv_rec.IIT_DATE_ATTRIB88,
            c_inv_rec.IIT_DATE_ATTRIB89,
            c_inv_rec.IIT_DATE_ATTRIB90,
            c_inv_rec.IIT_DATE_ATTRIB91,
            c_inv_rec.IIT_DATE_ATTRIB92,
            c_inv_rec.IIT_DATE_ATTRIB93,
            c_inv_rec.IIT_DATE_ATTRIB94,
            c_inv_rec.IIT_DATE_ATTRIB95;
      c_inv_rec.iit_primary_key := nvl(p_asset_id, c_inv_rec.iit_item_id);
      c_inv_rec.iit_foreign_key := NULL;
      ins_inv(c_inv_rec, p_attributes);
    CLOSE c_inv_items;
  END IF;
  RETURN 0;
EXCEPTION WHEN OTHERS THEN
  RETURN ABS(SQLCODE);
END;

FUNCTION move_inventory (p_item IN inv_items_all.iit_item_id%TYPE
                          ,p_section IN road_segs.rse_he_id%TYPE
                          ,p_st_chain IN inv_items_all.iit_st_chain%TYPE
                          ,p_end_chain IN inv_items_all.iit_end_chain%TYPE
                          ,p_xsp IN inv_items_all.iit_x_sect%TYPE
                          ,p_attributes BOOLEAN DEFAULT FALSE
                          ,p_children BOOLEAN DEFAULT FALSE
                          ,p_asset_id IN inv_items_all.iit_primary_key%TYPE DEFAULT NULL)
RETURN NUMBER IS
CURSOR c_hier IS
SELECT ROWID
FROM inv_items_all
CONNECT BY PRIOR iit_primary_key = iit_foreign_key
START WITH iit_item_id = p_item;
l_error_num NUMBER;
BEGIN
  l_error_num := copy_inventory(p_item
                               ,p_section
                               ,p_st_chain
                               ,p_end_chain
                               ,p_xsp
                               ,p_attributes
                               ,p_children
                               ,p_asset_id);
  IF (l_error_num = 0) THEN   -- end date original hierarchy
    FOR c_rec IN c_hier LOOP
      UPDATE inv_items_all
      SET iit_end_date = trunc(SYSDATE)
      WHERE ROWID = c_rec.ROWID;
    END LOOP;
    RETURN 0;
  ELSE
    RETURN l_error_num; -- return error from copy function
  END IF;
EXCEPTION WHEN OTHERS THEN
   RETURN ABS(SQLCODE);
END;
END Inv_Copy;
/
