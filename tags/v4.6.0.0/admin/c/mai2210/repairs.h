
/* SCCS ID keywords, do not remove */
/* "@(#)repairs.h	1.2 12/12/06"                       */

/* repairs.h   Host variables for REPAIRS table */
/* ===========================================================================
 *   CHANGE HISTORY :-                                              
 *   DATE         : 10-MAY-90                                       
 *   CHANGED BY   : Steve Voller                                    
 *   DESCRIPTION  : Enhancements iro RMMS Amendment Set VI changes. 
 *                  Declare variables for local date due.           
 *                                                                  
 * ===========================================================================
 */

static varchar  r_actioncat[2];            /* REP_ACTION_CAT             */
static varchar  r_actcode[3];              /* REP_ATV_ACTY_AREA_CODE     */
static varchar  r_supflag[2];              /* REP_SUPERSEDED_FLAG        */
static varchar  r_descr[241];              /* REP_DESCR                  */
static varchar  r_treatcode[5];            /* REP_TRE_TREAT_CODE         */

varchar         r_datecomp[7];             /* REP_DATE_COMPLETED         */
varchar         r_datedue[7];              /* REP_DATE_DUE               */
varchar         r_ldatedue[7];             /* REP_LOCAL_DATE_DUE         */

static long int r_heid,                    /* REP_RSE_HE_ID              */
                r_comphrs,                 /* REP_COMPLETED_HOURS        */
                r_compmins,                /* REP_COMPLETED_MINS         */
                r_defectid;                /* REPDEFECT_ID               */

static short    ir_datecomp,               /* REP_DATE_COMPLETED         */
                ir_datedue,                /* REP_DATE_DUE               */ 
                ir_comphrs,
                ir_compmins,
                ir_ldatedue,               /* REP_LOCAL_DATE_DUE         */ 
                ir_actioncat,              /* REP_ACTION_CAT             */ 
                ir_actcode,                /* REP_ATV_ACTY_AREA_CODE     */ 
                ir_heid,                   /* REP_RSE_HE_ID              */
                ir_defectid,               /* REP_DEF_DEFECTID           */
                ir_supflag;                /* REP_SUPERCEDED_FLAG        */ 

