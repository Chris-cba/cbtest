/* SCCS ID keywords, do not remove */
/* Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. */

/* "@(#)defects.h	1.2 12/12/06"                       */

/*PVCS keyword, do not remove         */
/* $Workfile:   defects.h  $ $Revision:   2.1  $ $Modtime:   Jul 02 2013 10:07:46  $ */

/* defects.h  DEFECTS table Host variables */
/* =============================================================================
 *   CHANGE HISTORY :-                                              
 *   DATE         : 10-MAY-90                                       
 *   CHANGED BY   : Steve Voller                                      
 *   DESCRIPTION  : Enhancements iro RMMS Amendment Set VI changes.    
 *                  Redefine d_defcat from int to VARCHAR because it is
 *                  now a floating point eg 2.1                         
 *                                                                      
 * =============================================================================
 */

static varchar  d_actcode[3]                 /* DEF_ARL_ACTY_AREA_CODE     */
               ,d_defcode[5]                 /* DEF_DEFECT_CODE            */
               ,d_supflag[2]                 /* DEF_SUPERSEDED_FLAG        */
               ,d_xsec[2]                    /* DEF_X_SECT                 */
               ,d_invcode[3]                 /* DEF_ITY_INV_CODE           */
               ,d_identcode[9]               /* DEF_IDENT_CODE             */
               ,d_ident_code[9]              /* DEF_IDENT_CODE             */
               ,d_locn[41]                   /* DEF_LOCN_DESCR             */
               ,d_defcat[4]                  /* DEF_DEFECT_CAT             */
               ,d_priority[5]                /* DEF_PRIORITY               */
               ,d_defect_descr[241]           /* DEF_DEFECT_DESCR           */
               ,d_rep_descr[241]              /* Repair description         */
               ,d_special_instr[41]          /* DEF_SPECIAL_INSTR          */
               ,d_status_code[11]            /* DEF_STATUS_CODE            */
               ,d_last_updated_date[12]      /* DEF_LAT_UPDATED_DATE       */
               ,d_orig_priority[5]           /* DEF_ORIG_PRIORITY          */
               ,d_created_date[12]           /* DEF_CREATED_DATE           */
               ,d_siss_id[4]                 /* DEF_SISS_ID                */
               ,d_coord_flag[2]              /* DEF_COORD_FLAG             */
               ,d_defstat[11]                /* DEF_STATUS_CODE            */
               ,d_response_category[5]
               ,d_diagno[8]
 
;            
static long int d_reportid                   /* DEF_ARL_REPORT_ID          */
               ,d_defectid                   /* DEF_DEFECT_ID              */
               ,d_stchain                    /* DEF_ST_CHAIN               */
               ,d_heid                       /* DEF_RSE_HE_ID              */
               ,d_timehrs                    /* DEF_TIME_HRS               */
               ,d_timemins                   /* DEF_TIME_MINS              */
               ,d_supid                      /* DEF_SUPERSEDED_ID          */
               ,d_are_id_not_found           /* DEF_ARE_ID_NOT_FOUND       */
               ,d_works_order_no             /* DEF_WORKS_ORDER_NO         */
               ,d_notifiable                 /* DEF_NOTIFY_ORG_ID    HB    */
               ,d_recharge                   /* DEF_RECHAR_ORG_ID    HB    */
               ,d_iit_item_id
;
double           d_easting
               ,d_northing
;
static varchar d_area[10]                    /* DEF_AREA             [0]   */
              ,d_height[10]                  /* DEF_HEIGHT           [1]   */
              ,d_length[10]                  /* DEF_LENGTH           [2]   */
              ,d_number[10]                  /* DEF_NUMBER           [3]   */
              ,d_percent[10]                 /* DEF_PER_CENT         [4]   */
              ,d_origpercent[10]             /* DEF_PER_CENT_ORIG    [5]   */
              ,d_rempercent[10]              /* DEF_PER_CENT_REM     [6]   */
              ,d_skid[10]                    /* DEF_SKID_COEFF       [7]   */
              ,d_descr[241]                   /* DEF_DEFECT_DESCR           */
              ,d_datecomp[8]                 /* DEF_DATE_COMPL             */
              ,d_update_inv[2]               /* DEF_UPDATE_INV             */
              ,d_dty_acv_acty_area_code[3]   /*                            */
              ,d_siss[4]                     /* DEF_SISS_ID          HB    */
              ,d_special[256]                /* DEF_SPECIAL_INSTR    HB    */
              ,d_serial_no[10]               /* Serial Number              */
              ,d_diagram_no[8]               /* Diagram number             */
;
static short   id_area                       /* DEF_AREA             [0]   */
              ,id_height                     /* DEF_HEIGHT           [1]   */
              ,id_length                     /* DEF_LENGTH           [2]   */
              ,id_number                     /* DEF_NUMBER           [3]   */
              ,id_percent                    /* DEF_PER_CENT         [4]   */
              ,id_origpercent                /* DEF_PER_CENT_ORIG    [5]   */
              ,id_rempercent                 /* DEF_PER_CENT_REM     [6]   */
              ,id_skid                       /* DEF_SKID_COEFF       [7]   */
              ,id_descr                      /* DEF_DEFECT_DESCR           */
              ,id_datecomp                   /* DEF_DATE_COMPL             */
              ,id_supid                      /* DEF_SUPERSEDED_ID          */
              ,id_actcode                    /* DEF_ARL_ACTY_AREA_CODE     */
              ,id_defcode                    /* DEF_DEFECT_CODE            */
              ,id_supflag                    /* DEF_SUPERSEDED_FLAG        */
              ,id_xsec                       /* DEF_X_SECT                 */
              ,id_invcode                    /* DEF_ITY_INV_CODE           */
              ,id_identcode                  /* DEF_IDENT_CODE             */
              ,id_ident_code                 /* DEF_IDENT_CODE             */
              ,id_locn                       /* DEF_LOCN_DESCR             */
              ,id_reportid                   /* DEF_ARL_REPORT_ID          */
              ,id_defectid                   /* DEF_DEFECT_ID              */
              ,id_stchain                    /* DEF_ST_CHAIN               */
              ,id_defcat                     /* DEF_DEFECT_CAT             */
              ,id_diagno                     /* DEF_DIAGRAM_NO             */
              ,id_heid                       /* DEF_RSE_HE_ID              */
              ,id_timehrs                    /* DEF_TIME_HRS               */
              ,id_timemins                   /* DEF_TIME_MINS              */
              ,id_priority                   /* DEF_PRIORITY               */
              ,id_dty_atv_acty_area_code     /* DEF_                       */
              ,id_siss                       /* DEF_SISS_ID          HB    */
              ,id_notifiable                 /* DEF_NOTIFY_ORG_ID    HB    */
              ,id_recharge                   /* DEF_RECHAR_ORG_ID    HB    */
              ,id_special                    /* DEF_SPECIAL_INSTR    HB    */
              ,id_defstat                    /* DEF_STATUS_CODE      HB    */
              ,id_rep_descr                  /* Repair description         */
              ,id_iit_item_id                /* Internal inventory id      */
              ,id_easting                    /* Easting coordinate         */
              ,id_northing                   /* Northing coordinate        */
              ,id_response_category          /* Response category          */
              ,id_coord_flag                 /* Co-ordination flag         */
              ,id_serial_no                  /* Serial number              */          
              ,id_diagram_no                 /* Diagram number             */
;

#define NOATTS 13                               /* No of defect attributes    */
static struct {char    *name;                   /* Attribute column name      */
               unsigned char    *add;           /* Host variable address      */
               short   *iadd;
               } att[NOATTS] = {
               "DEF_AREA",          d_area.arr,        &id_area,
               "DEF_HEIGHT",        d_height.arr,      &id_height,
               "DEF_LENGTH",        d_length.arr,      &id_length,
               "DEF_NUMBER",        d_number.arr,      &id_number,
               "DEF_PER_CENT",      d_percent.arr,     &id_percent,
               "DEF_PER_CENT_ORIG", d_origpercent.arr, &id_origpercent,
               "DEF_PER_CENT_REM",  d_rempercent.arr,  &id_rempercent,
               "DEF_SKID_COEFF",    d_skid.arr,        &id_skid,
               "DEF_DEFECT_DESCR",  d_descr.arr,       &id_descr,
               "DEF_COORD_FLAG",    d_coord_flag.arr,  &id_coord_flag,
               "DEF_IDENT_CODE",    d_ident_code.arr,  &id_ident_code,
               "DEF_DIAGRAM_NO",    d_diagram_no.arr,  &id_diagram_no,
               "DEF_SERIAL_NO",     d_serial_no.arr,   &id_serial_no,
                              };
/* ----------------------------------------------------------------------- */



