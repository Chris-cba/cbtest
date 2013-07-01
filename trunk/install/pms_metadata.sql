-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/pms_metadata.sql-arc   2.1   Jul 01 2013 16:03:54   James.Wadsworth  $
--       Module Name      : $Workfile:   pms_metadata.sql  $
--       Date into SCCS   : $Date:   Jul 01 2013 16:03:54  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:44  $
--       SCCS Version     : $Revision:   2.1  $
--       based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from 
-----------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
insert into INV_ITEM_TYPES (
ITY_DTP_FLAG
,ITY_ELEC_DRAIN_CARR
,ITY_INV_CODE
,ITY_PNT_OR_CONT
,ITY_SYS_FLAG
,ITY_X_SECT_ALLOW_FLAG
,ITY_CONTIGUOUS
,ITY_DESCR
,ITY_DUPLICATE
,ITY_FEA_CODE
,ITY_PARENT_ITY
,ITY_HHPOS1
,ITY_HHPOS10
,ITY_HHPOS11
,ITY_HHPOS12
,ITY_HHPOS13
,ITY_HHPOS14
,ITY_HHPOS15
,ITY_HHPOS2
,ITY_HHPOS3
,ITY_HHPOS4
,ITY_HHPOS5
,ITY_HHPOS6
,ITY_HHPOS7
,ITY_HHPOS8
,ITY_HHPOS9
,ITY_HHSTRLNGTH
,ITY_HHSUBLNG1
,ITY_HHSUBLNG10
,ITY_HHSUBLNG2
,ITY_HHSUBLNG3
,ITY_HHSUBLNG4
,ITY_HHSUBLNG5
,ITY_HHSUBLNG6
,ITY_HHSUBLNG7
,ITY_HHSUBLNG8
,ITY_HHSUBLNG9
,ITY_HHSUBSTATS
,ITY_HHSUBSTRT1
,ITY_HHSUBSTRT10
,ITY_HHSUBSTRT2
,ITY_HHSUBSTRT3
,ITY_HHSUBSTRT4
,ITY_HHSUBSTRT5
,ITY_HHSUBSTRT6
,ITY_HHSUBSTRT7
,ITY_HHSUBSTRT8
,ITY_HHSUBSTRT9
,ITY_MAX_ATTR_REQ
,ITY_MIN_ATTR_REQ
,ITY_ROAD_CHARACTERISTIC
,ITY_SCREEN_SEQ
,ITY_TOLERANCE
,ITY_VIEW_NAME
,ITY_START_DATE
,ITY_END_DATE
,ITY_CONTIG_JOINS_GAP
,ITY_HHPOS16
,ITY_HHPOS17
,ITY_HHPOS18
,ITY_HHPOS19
,ITY_HHPOS20
,ITY_HHPOS21
,ITY_HHPOS22
,ITY_HHPOS23
,ITY_HHPOS24
,ITY_HHPOS25
,ITY_HHPOS26
,ITY_HHPOS27
,ITY_HHPOS28
,ITY_HHPOS29
,ITY_HHPOS30
,ITY_HHPOS31
,ITY_HHPOS32
,ITY_HHPOS33
,ITY_HHPOS34
,ITY_HHPOS35
,ITY_HHPOS36
,ITY_HHPOS37
,ITY_HHPOS38
,ITY_HHPOS39
,ITY_HHPOS40
,ITY_HHPOS41
,ITY_HHPOS42
,ITY_HHPOS43
,ITY_HHPOS44
,ITY_HHPOS45
,ITY_HHPOS46
,ITY_HHPOS47
,ITY_HHPOS48
,ITY_HHPOS49
,ITY_HHPOS50
,ITY_HHPOS51
,ITY_HHPOS52
,ITY_HHPOS53
,ITY_HHPOS54
,ITY_HHPOS55
,ITY_HHPOS56
,ITY_HHPOS57
,ITY_HHPOS58
,ITY_HHPOS59
,ITY_HHPOS60
,ITY_HHPOS61
,ITY_HHPOS62
,ITY_HHPOS63
,ITY_HHPOS64
,ITY_HHPOS65
,ITY_HHPOS66
,ITY_HHPOS67
,ITY_HHPOS68
,ITY_HHPOS69
,ITY_HHPOS70
,ITY_HHPOS71
,ITY_HHPOS72
,ITY_HHPOS73
,ITY_HHPOS74
,ITY_HHPOS75
,ITY_AREA_OR_LENGTH
,ITY_SURVEY
,ITY_MULTI_ALLOWED
,ITY_SHORT_DESCR
,ITY_INCL_ROAD_SEGS
) select
'D'
,'R'
,'RC'
,'C'
,'L'
,'Y'
,'N'
,'Road Construction'
,''
,null
,''
,'NO_OF_UNITS'
,''
,''
,''
,''
,''
,''
,'MATERIAL'
,'LENGTH'
,'CLASS'
,''
,''
,''
,''
,''
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,null
,0
,'R'
,75
,null
,'BPR_DRC'
,null
,null
,null
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,''
,'1'
from dual
where not exists (
 select 'not exists'
 from INV_ITEM_TYPES
where ITY_INV_CODE = 'RC'
 and ITY_SYS_FLAG = 'L'
);

insert into INV_TYPE_ATTRIBS (
ITA_ATTRIB_NAME
,ITA_DEC_PLACES
,ITA_DYNAMIC_ATTRIB
,ITA_FLD_LENGTH
,ITA_FORMAT
,ITA_IIT_INV_CODE
,ITA_ITY_SYS_FLAG
,ITA_MANDITORY_YN
,ITA_SCRN_TEXT
,ITA_VALIDATE_YN
,ITA_DISP_SEQ_NO
,ITA_DTP_CODE
,ITA_MAX
,ITA_MIN
,ITA_VIEW_ATTRI
,ITA_VIEW_COL_NAME
,ITA_START_DATE
,ITA_END_DATE
) select
'IIT_NO_OF_UNITS'
,0
,'Y'
,3
,'NUMBER'
,'RC'
,'L'
,'N'
,'Layer'
,'N'
,1
,''
,null
,null
,''
,'LAYER'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_TYPE_ATTRIBS
where ITA_ITY_SYS_FLAG = 'L'
 and ITA_IIT_INV_CODE = 'RC'
 and ITA_ATTRIB_NAME = 'IIT_NO_OF_UNITS'
);

insert into INV_TYPE_ATTRIBS (
ITA_ATTRIB_NAME
,ITA_DEC_PLACES
,ITA_DYNAMIC_ATTRIB
,ITA_FLD_LENGTH
,ITA_FORMAT
,ITA_IIT_INV_CODE
,ITA_ITY_SYS_FLAG
,ITA_MANDITORY_YN
,ITA_SCRN_TEXT
,ITA_VALIDATE_YN
,ITA_DISP_SEQ_NO
,ITA_DTP_CODE
,ITA_MAX
,ITA_MIN
,ITA_VIEW_ATTRI
,ITA_VIEW_COL_NAME
,ITA_START_DATE
,ITA_END_DATE
) select
'IIT_MATERIAL_TXT'
,0
,'Y'
,8
,'VARCHAR2'
,'RC'
,'L'
,'N'
,'Material'
,'Y'
,2
,''
,null
,null
,''
,'MATERIAL'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_TYPE_ATTRIBS
where ITA_ITY_SYS_FLAG = 'L'
 and ITA_IIT_INV_CODE = 'RC'
 and ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
);

insert into INV_TYPE_ATTRIBS (
ITA_ATTRIB_NAME
,ITA_DEC_PLACES
,ITA_DYNAMIC_ATTRIB
,ITA_FLD_LENGTH
,ITA_FORMAT
,ITA_IIT_INV_CODE
,ITA_ITY_SYS_FLAG
,ITA_MANDITORY_YN
,ITA_SCRN_TEXT
,ITA_VALIDATE_YN
,ITA_DISP_SEQ_NO
,ITA_DTP_CODE
,ITA_MAX
,ITA_MIN
,ITA_VIEW_ATTRI
,ITA_VIEW_COL_NAME
,ITA_START_DATE
,ITA_END_DATE
) select
'IIT_CLASS'
,0
,'Y'
,2
,'VARCHAR2'
,'RC'
,'L'
,'N'
,'Accuracy'
,'Y'
,4
,''
,null
,null
,''
,'ACCURACY'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_TYPE_ATTRIBS
where ITA_ITY_SYS_FLAG = 'L'
 and ITA_IIT_INV_CODE = 'RC'
 and ITA_ATTRIB_NAME = 'IIT_CLASS'
);

insert into INV_TYPE_ATTRIBS (
ITA_ATTRIB_NAME
,ITA_DEC_PLACES
,ITA_DYNAMIC_ATTRIB
,ITA_FLD_LENGTH
,ITA_FORMAT
,ITA_IIT_INV_CODE
,ITA_ITY_SYS_FLAG
,ITA_MANDITORY_YN
,ITA_SCRN_TEXT
,ITA_VALIDATE_YN
,ITA_DISP_SEQ_NO
,ITA_DTP_CODE
,ITA_MAX
,ITA_MIN
,ITA_VIEW_ATTRI
,ITA_VIEW_COL_NAME
,ITA_START_DATE
,ITA_END_DATE
) select
'IIT_LENGTH'
,0
,'Y'
,6
,'NUMBER'
,'RC'
,'L'
,'N'
,'Depth'
,'N'
,3
,''
,null
,null
,''
,'DEPTH'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_TYPE_ATTRIBS
where ITA_ITY_SYS_FLAG = 'L'
 and ITA_IIT_INV_CODE = 'RC'
 and ITA_ATTRIB_NAME = 'IIT_LENGTH'
);

insert into INV_TYPE_ATTRIBS (
ITA_ATTRIB_NAME
,ITA_DEC_PLACES
,ITA_DYNAMIC_ATTRIB
,ITA_FLD_LENGTH
,ITA_FORMAT
,ITA_IIT_INV_CODE
,ITA_ITY_SYS_FLAG
,ITA_MANDITORY_YN
,ITA_SCRN_TEXT
,ITA_VALIDATE_YN
,ITA_DISP_SEQ_NO
,ITA_DTP_CODE
,ITA_MAX
,ITA_MIN
,ITA_VIEW_ATTRI
,ITA_VIEW_COL_NAME
,ITA_START_DATE
,ITA_END_DATE
) select
'IIT_XTRA_DATE_1'
,0
,'Y'
,11
,'DATE'
,'RC'
,'L'
,'Y'
,'Material Age'
,'N'
,5
,''
,null
,null
,''
,'MATERIAL AGE'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_TYPE_ATTRIBS
where ITA_ITY_SYS_FLAG = 'L'
 and ITA_IIT_INV_CODE = 'RC'
 and ITA_ATTRIB_NAME = 'IIT_XTRA_DATE_1'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_CLASS'
,'RC'
,'L'
,'S'
,''
,'Sure'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_CLASS'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'S'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_CLASS'
,'RC'
,'L'
,'D'
,''
,'Definite'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_CLASS'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'D'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_CLASS'
,'RC'
,'L'
,'G'
,''
,'Guess'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_CLASS'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'G'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'SL'
,''
,'Steel'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'SL'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'BP'
,''
,'Block Paving'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'BP'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'CH'
,''
,'Chipping'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'CH'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'CO'
,''
,'Concrete'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'CO'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'FL'
,''
,'Concrete Flags'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'FL'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'GR'
,''
,'Grass'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'GR'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'KB'
,''
,'Kerbs'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'KB'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'NS'
,''
,'Natural Stone'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'NS'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'PA'
,''
,'Paint'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'PA'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'SD'
,''
,'Surface Dressing'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'SD'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'SS'
,''
,'Slurry Seal'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'SS'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'SM'
,''
,'Special Material'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'SM'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'ST'
,''
,'Stone'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'ST'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'SA'
,''
,'Salt'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'SA'
);

commit;
insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'TS'
,''
,'Thermo Spray'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'TS'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'TC'
,''
,'Thermo Screed'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'TC'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'WD'
,''
,'Wood'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'WD'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'AS'
,''
,'Asphalt'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'AS'
);

insert into INV_ATTRI_DOMAINS (
IAD_ITA_ATTRIB_NAME
,IAD_ITA_INV_CODE
,IAD_ITA_ITY_SYS_FLAG
,IAD_VALUE
,IAD_DTP_CODE
,IAD_MEANING
,IAD_START_DATE
,IAD_END_DATE
) select
'IIT_MATERIAL_TXT'
,'RC'
,'L'
,'BI'
,''
,'Bitmac'
,null
,null
from dual
where not exists (
 select 'not exists'
 from INV_ATTRI_DOMAINS
where IAD_ITA_INV_CODE = 'RC'
 and IAD_ITA_ATTRIB_NAME = 'IIT_MATERIAL_TXT'
 and IAD_ITA_ITY_SYS_FLAG = 'L'
 and IAD_VALUE = 'BI'
);

insert into XSP_RESTRAINTS (
XSR_ITY_INV_CODE
,XSR_SCL_CLASS
,XSR_X_SECT_VALUE
,XSR_DESCR
,XSR_ITY_SYS_FLAG
,XSR_SEQ
) select
'RC'
,'AP'
,'4'
,'Lane 1'
,'L'
,5
from dual
where not exists (
 select 'not exists'
 from XSP_RESTRAINTS
where XSR_ITY_SYS_FLAG = 'L'
 and XSR_ITY_INV_CODE = 'RC'
 and XSR_SCL_CLASS = 'AP'
 and XSR_X_SECT_VALUE = '4'
);

insert into XSP_RESTRAINTS (
XSR_ITY_INV_CODE
,XSR_SCL_CLASS
,XSR_X_SECT_VALUE
,XSR_DESCR
,XSR_ITY_SYS_FLAG
,XSR_SEQ
) select
'RC'
,'AP'
,'5'
,'Lane 2'
,'L'
,6
from dual
where not exists (
 select 'not exists'
 from XSP_RESTRAINTS
where XSR_ITY_SYS_FLAG = 'L'
 and XSR_ITY_INV_CODE = 'RC'
 and XSR_SCL_CLASS = 'AP'
 and XSR_X_SECT_VALUE = '5'
);
