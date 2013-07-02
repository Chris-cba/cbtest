/* SCCS ID keywords, do not remove */
/* "@(#)deftypes.h	1.1 09/08/03"  */
/* Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. */

/*PVCS keyword, do not remove         */
/* $Workfile:   deftypes.h  $ $Revision:   2.1  $ $Modtime:   Jul 02 2013 10:08:00  $ */

/* ==========================================================================
 * deftypes.h   DEF_TYPES  table Host variables  
 * 
 * ==========================================================================
 */
static varchar f_actcode[3],               /* DTY_ATV_ACTY_AREA_CODE       */
               f_defcode[5];               /* DTY_DEFECT_CODE              */
varchar        f_hhatt1[33],               /* DTY_HH_ATTRIBUTE_1           */
               f_hhatt2[33],               /* DTY_HH_ATTRIBUTE_2           */
               f_hhatt3[33],               /* DTY_HH_ATTRIBUTE_3           */
               f_hhatt4[33];               /* DTY_HH_ATTRIBUTE_4           */
short          hhatt1_if,                  /* DTY_HH_ATTRIBUTE_1           */
               hhatt2_if,                  /* DTY_HH_ATTRIBUTE_2           */
               hhatt3_if,                  /* DTY_HH_ATTRIBUTE_3           */
               hhatt4_if;                  /* DTY_HH_ATTRIBUTE_4           */
