
/* SCCS ID keywords, do not remove */
/* static char *sccsid = "@(#)r4ploc.c	1.3 06/01/07"; */

/*PVCS keyword, do not remove */
static char *sccsid = "$Workfile:   r4ploc.c  $ $Revision:   2.0  $ $Modtime:   Jun 15 2007 14:39:14  $";

/* ===========================================================================
 *                       P R O L O C A T I O N
 * Purpose:       To process a defects location and all the defects at that
 *                location.
 *
 * Type:  boolean prolocation();
 *
 * Calling Sequence:      
 * prolocation( heid, inspdate, reportid, &norec, &noerror, &error )
 *
 * Input: int     heid        Highway element ID of Section.
 *
 *     int     reportid    Report id for these defects.
 *
 *     char    inspdate[7] Inspection date as "YYMMDD".
 *
 * Output:        boolean     prolocation    TRUE  = Location and defects info
 *                             processed OK.
 *                         FALSE = Error Hit see error code.
 *
 *     int     norec       No. of records processed.
 *
 *     int     noerror     No. of records marked in error.
 *
 *     int     error      2 = ORACLE error Hit.
 *                     8200 - 8400 = RMMS Error Code
 *                     8501 = Missing 'I' (location) record.
 *                     8502 = Missing 'J' (defect) record.
 *                     8503 = No repair records for a defect.
 *
 *  Effects:       RMMS tables updated as appropriate.
 *     Error information registered with pusherror().
 *     No COMMIT done.
 * ===========================================================================
 */

#include <stdio.h>
#include "rmms.h"                                     

/* ===========================================================================
 * Function : prolocation()
 * Purpose  : Process defect location.
 * ===========================================================================
 */
BOOLEAN prolocation(long int heid
                   ,char     *inspdate
                   ,long int reportid
                   ,char     *init
                   ,char     *inspflag
                   ,long int responsible
                   ,long int *norec
                   ,long int *noerror
                   ,long int *error)
{ long int  stchain            /* start chainage                       */
      ,err                     /* error code                           */
      ,defrecs                 /* No of defect input records           */
      ,timehrs                 /* Time in hours                        */
      ,timemins                /* Time in minutes                      */ 
      ,seqid                   /* sequence  id of location record      */
      ,deferrors               /* No. of defect records in error       */
      ,notifiable=0            /* Notifiable organisation code         */
      ,recharge=0              /* Rechargable organisation code       */
	  ,l_error=0
	;
  char actcode[3]              /* activity area code                   */
      ,xsec[2]                 /* cross sectional code                 */
      ,invcode[3]              /* Inventory item code                  */
      ,locn[41]                /* defect location description          */
      ,identcode[9]            /* location inv item id code            */
      ,invid[2]                /* Inventory chainage indicator         */
      ,siss[4]                 /* Standard Item Sub-Section code       */
      ,special[256]            /* Special instructions                 */
      ,description[241]        /* Defect Description                   */
      ,diagno[8]
;
BOOLEAN        result,  prodefect();
/* ==================================================================== */

*error = *norec = *noerror = 0;

/* ===========================================================================
 * Obtain the defect location from the 'I' record and then deal
 * with the defects that follow for that location.    
 * ===========================================================================
 */

nullfill(invcode,3);

l_error= *error;

result = getlocation(heid,actcode,xsec,&stchain,locn,&timehrs,&timemins,
                     identcode,diagno,invcode,invid,siss,&notifiable,
                     &recharge,special,description,&l_error,&seqid,inspdate);




    if (result == FALSE)
          return(FALSE);

*error= l_error;

    if( *error == 0 ) 
    {
       *norec += 1;

       do {                                         /* For each defect       */
               result = prodefect(heid,inspdate,reportid,init,inspflag
                                 ,identcode,actcode,stchain,xsec,invcode
                                 ,timehrs,timemins,locn,diagno,&defrecs
                                 ,&deferrors,error,&siss,&notifiable
                                 ,&recharge,&special,&description,responsible);

               if( result==TRUE && *error != 8502)  /* Invalid defect (J)    */
               {                                    /* record type.          */
                    *norec    += defrecs;
                    *noerror  += deferrors;
               }
           } while( *error == 0 );
       }

       if( *error == 8502 )                         /* Invalid defect (J)    */
          *error = 0;                               /* record type.          */

   return( result );

}
