
/* SCCS ID keywords, do not remove */
/* static char *sccsid = "@(#)r4pdef.c	1.4 06/01/07"; */

/*PVCS keyword, do not remove */
static char *sccsid = "$Workfile:   r4pdef.c  $ $Revision:   2.0  $ $Modtime:   Jun 15 2007 14:39:14  $";

/* ===========================================================================
 * prodefect.c              P R O D E F E C T
 * ===========================================================================
*/
#include <stdio.h>
#include "rmms.h"

extern char pipe_msg[254];

BOOLEAN prodefect(long int heid
                 ,char     *inspdate
                 ,long int reportid
                 ,char     *init
                 ,char     *inspflag
                 ,char     *identcode
                 ,char     *actcode
                 ,long int *stchain
                 ,char     *xsec
                 ,char     *invcode
                 ,long int timehrs
                 ,long int timemins
                 ,char     *locn
                 ,char     *diagno
                 ,long int *norec 
                 ,long int *noerror
                 ,long int *error
                 ,char     *siss
                 ,char     *notifiable
                 ,char     *recharge
                 ,char     *special
                 ,char     *description
                 ,long int responsible)
{ long int  seqid      /* sequence id                                  */
      ,err             /* function return error code                   */
      ,i               /* loop variables                               */
      ,getnextid()     /* function to get next defect id               */
      ,defectcat       /* defect category 1 or 2                       */
      ,defectid        /* defect id                                    */
      ,def_itemid
;
double  def_easting
      ,def_northing
;

 char  defcode[5]      /* Defect code                                  */
      ,def_priority[5] /* Defect priority code                         */
      ,def_category[5]
      ,compdate[7]     /* date completed from immediate repair         */
      ,comptime[5]     /* Immediate repair completion time             */
      ,supflag[2]      /* flag indicating if a defect superseded       */
      ,attr_1[256]      /* Attribute 1 value                            */
      ,attr_2[256]      /* Attribute 2 value                            */
      ,attr_3[256]      /* Attribute 3 value                            */
      ,attr_4[256]      /* Attribute 4 value                            */
      ,temp[10]
;

BOOLEAN        result, /* TRUE = processing OK FALSE = fatal error     */
               wols,   /* TRUE = works orders present on matched defect*/
               pushhhrec();
/* =================================================================== */

*error = 0;

/* ========================================================================
 * Get Defect info from next 'J' record ( Defect Record )
 * ========================================================================
 */


       result = getdefect(supflag,actcode,stchain,xsec,heid 
                         ,defcode,&seqid,&err,invcode,reportid
                         ,init,inspflag,def_priority,def_category
                         ,&def_itemid,&def_easting,&def_northing
                         ,attr_1,attr_2,attr_3,attr_4);

       supflag[1] = '\0';

       if( err == 8502 || result == FALSE ) /* Invalid defect J record type */ 
       {
          *error = err;
          return( result );
       }

/* ==========================================================================
 * Get a new defect id 
 * ==========================================================================
 */
      if( !(defectid = getnextid( "DEF_DEFECT_ID", FALSE ) ) ) 
      {
         *error = 2;
         return( FALSE );                         /* could not get one      */
      }

/* ==========================================================================
 * For each repair record
 * ==========================================================================
 */
     *norec   = 0;                        /* Initialize the record counter   */ 
     *noerror = 0;                        /* Initialize the number of errors */

      do 
      {                                   /* prorepair located in r4prep.c   */ 
          result = prorepair(supflag[0]   /* Superceding indicator           */
                            ,actcode      /* Activity code                   */
                            ,inspdate     /* Inspection date                 */
                            ,heid         /* Highway element.                */
                            ,defectid     /* Defect identification           */
                            ,defcode      /* Defect code                     */
                            ,&defectcat   /* Defect category                 */
                            ,&compdate    /* Date Immediate Repair completed */
                            ,&comptime    /* Time Immediate Repair completed */
                            ,&err         /* Returned error code             */
                            ,def_priority /* Defect priority                 */
                            ,responsible  /* Maintaining agent of the section*/
                            ,attr_1       /* First attribute value           */
                            ,attr_2       /* Second attribute value          */
                            ,attr_3       /* Third attribute value           */
                            ,attr_4       /* Fourth attribute value          */
                            ,seqid);      /* Record ssequence number         */
          if( result == TRUE )            /* Update counts                   */
          { 
            *norec=*norec+1;              /* increment the number of records */
                                          /* that have been located.         */ 

            if( err>0 && err!=8503)       /* If there is an error and the end */
              *noerror++;                 /* of records has been set increment*/
          }                               /* the number of errors.            */
      } while( err==0 );

      if( *norec==0 && err==8503)         /* No repair records             */
      { 
          printf("\nINFO: No action records found at sequence: %d BPR-8605\n",
              seqid );
          strcpy(pipe_msg,"INFO: No action records found at sequence: ");
          i_toa(seqid,temp);
          strcat(pipe_msg,temp);
          strcat(pipe_msg," BPR8605");
          write_pipe(NULL,pipe_msg);
          result = FALSE;
      }
      
      if(*norec>0)                        /* If repair records were located */
      {
       result=putdefect(supflag,compdate,identcode,invcode,locn
                       ,reportid,init,inspflag,defectid,defectcat
                       ,diagno,timehrs,timemins,siss,notifiable
                       ,recharge,special,description,defectcat);
      }
      
      if( result == FALSE ) 
      {
          *error = err;
          return( FALSE );
      }
  }
