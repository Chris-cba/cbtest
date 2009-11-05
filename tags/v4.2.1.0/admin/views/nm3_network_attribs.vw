CREATE OR REPLACE FORCE VIEW nm3_network_attribs(ELEMENT_ID
                                               , HIERARCHY
                                               , NOMINATED
                                               , TOWN
                                               , SUB_PARISH
                                               , SPARE1
                                               , SPARE2
                                               , SECTOR
                                               , LABEL
                                               , SECTION_ID) 
AS
SELECT  
--
-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/views/nm3_network_attribs.vw-arc   3.0   Nov 05 2009 10:35:06   gjohnson  $
--       Module Name      : $Workfile:   nm3_network_attribs.vw  $
--       Date into PVCS   : $Date:   Nov 05 2009 10:35:06  $
--       Date fetched Out : $Modtime:   Nov 04 2009 16:11:38  $
--       Version          : $Revision:   3.0  $
-------------------------------------------------------------------------
--
          ni.iit_ne_id            element_id
        , ni.iit_chr_attrib35     hierarchy
        , ni.iit_chr_attrib36     nominated
        , ni.iit_chr_attrib27     town
        , mai_gmis_util.get_parish(ni.iit_chr_attrib28)     sub_parish
        , ni.iit_chr_attrib41     spare1
        , ni.iit_chr_attrib42     spare2
        , ni.iit_chr_attrib30     sector
        , ne.ne_unique            label
        , ne.ne_id                section_id
from  nm_elements_all ne
    , nm_group_inv_link_all li
    , nm_inv_items_all ni
where ne.ne_id = li.ngil_ne_ne_id (+)
and   li.ngil_iit_ne_id = ni.iit_ne_id (+)
and   ni.iit_inv_type     ='HERM'
/