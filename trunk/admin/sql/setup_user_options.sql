-------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //new_vm_latest/archives/mai/admin/sql/setup_user_options.sql-arc   3.2   Jun 28 2018 04:12:46   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   setup_user_options.sql  $
--       Date into PVCS   : $Date:   Jun 28 2018 04:12:46  $
--       Date fetched Out : $Modtime:   Jun 28 2018 04:11:46  $
--       Version          : $Revision:   3.2  $
------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
------------------------------------------------------------------

Insert into HIG_USER_OPTION_LIST
    (HUOL_ID
    ,HUOL_PRODUCT
    ,HUOL_NAME
    ,HUOL_REMARKS
    ,HUOL_DOMAIN
    ,HUOL_DATATYPE
    ,HUOL_MIXED_CASE
    )
Select 'GISGRPD'
      ,'MAI'
      ,'Road Group for DoT GIS Work'
      ,'This must be a valid Road Group.  It will be automatically placed on the header of all DoT work orders created from the GIS.'
      ,NULL
      ,'VARCHAR2'
      ,'Y'
From DUAL
Where Not Exists (Select 1 From HIG_USER_OPTION_LIST
                   Where HUOL_ID = 'GISGRPD'
                     And HUOL_PRODUCT = 'MAI')
/
--
--
Insert into HIG_USER_OPTION_LIST
   (HUOL_ID
   ,HUOL_PRODUCT
   ,HUOL_NAME
   ,HUOL_REMARKS
   ,HUOL_DOMAIN
   ,HUOL_DATATYPE
   ,HUOL_MIXED_CASE
   )
 Select 'GISGRPL'
        ,'MAI'
        ,'Road Group for Local GIS Work', 'This must be a valid Road Group.  It will be automatically placed on the header of all local work orders created from the GIS.'
        ,NULL
        ,'VARCHAR2'
        ,'Y'
From Dual
Where Not Exists (Select 1 From HIG_USER_OPTION_LIST
                   Where HUOL_ID = 'GISGRPL'
                     And HUOL_PRODUCT = 'MAI')
/
--
--
Insert into HIG_USER_OPTION_LIST
   (HUOL_ID
   ,HUOL_PRODUCT
   ,HUOL_NAME
   ,HUOL_REMARKS
   ,HUOL_DOMAIN 
   ,HUOL_DATATYPE
   ,HUOL_MIXED_CASE
   )
Select 'GISGRPTYPE'
       ,'NET'
       ,'GIS Road Group Type'
       ,'The type of road group created by GIS'
       ,NULL
       ,'VARCHAR2'
       ,'N'
From Dual
Where Not Exists (Select 1 From HIG_USER_OPTION_LIST
                   Where HUOL_ID = 'GISGRPTYP'
                     And HUOL_PRODUCT = 'NET')
/

Update HIG_OPTION_LIST
   Set HOL_USER_OPTION = 'Y' 
 Where HOL_ID IN ('GISGRPL','GISGRPD','GISGRPTYP')
/
commit
/
