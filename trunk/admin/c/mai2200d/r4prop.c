/* SCCS ID keywords, do not remove */
/* static char *sccsid = "@(#)r4prop.c	1.1 09/08/03"; */
/* Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. */

/*PVCS keyword, do not remove */
static char *sccsid = "$Workfile:   r4prop.c  $ $Revision:   2.1  $ $Modtime:   Jul 02 2013 10:12:40  $";


/* ==========================================================================
 *                               P R O P R E C
 * Purpose:       To process the next 'P' record containing the start & end 
 *                chainage
 *
 * Type:  boolean proprec();
 *
 * Calling
 * Sequence:      proprec( heid, &stchain, &endchain, &seqid, &error )
 *
 * Input: int     heid    Highway element id for the section being processed.
 *
 * Output:        boolean proprec TRUE  = Got st & end chainage OK.
 *                       FALSE = Error see error code.
 *
 *     int     stchain Start Chainage for this inspection.
 *
 *     int     endchain        End chainage for this section.
 *
 *     int     seqid   Sequence id of "P" record.
 *
 *     int     error      2 = ORACLE error occured.
 *                     8130 = End chainage < start chainage
 *                     8131 = End chanage > section length+5
 *                     8504 = Missing 'P' record.
 *
 * Effects:
 * ========
 *   CHANGE HISTORY :-                                                  
 *   DATE         : 10-JUL-91                                           
 *   CHANGED BY   : Steve Voller                                        
 *   DESCRIPTION  : Correct bug for PC versions. Ensure that when the   
 *                  code is run on a PC then atol is used instead of    
 *                  atoi. Bug advised by R. Strong 26/6/91 following    
 *                  problems at Parkman Associates.                    
 * ==========================================================================
 */


#include <stdio.h>
#include "rmms.h"
extern long int MAXENDCHAIN;  /* Maximum chainage value                     */
extern BOOLEAN ENHANCED;
/* ==========================================================================
   Function : proprec()
   Purpose  : Process 'P' - section chainage record.
 * ==========================================================================
 */
BOOLEAN proprec(heid,stchain,endchain,seqid,error,reverse)
/* ==========================================================================
 *                      Argument Definition Area   
 * ==========================================================================
 */
long int heid;                /* Highway element id for the section being   */
                              /* processsed.                                */
long int *stchain;            /* Start chainage for the P record returned   */
long int *endchain;           /* End chainage for the P record returned     */
long int *seqid;              /* Sequence id of the P record where obtained */
int *error;                   /* Returned error code for the function       */
BOOLEAN reverse;              /* Indicator for reverse inspections          */

/*==========================================================================*/

{ /* ....................................................Proprec Start Brace*/
int tmpstart;

char *strs[30]                            /* Array of string pointers       */
     ,text[80];                           /* Record text array for P record */
int noargs;                               /* Number of arguments.           */

   if (gethhrec('P',8240,seqid,text) == EOF)
   {
      pushprec();
      *error = 8504;                      /* Section chainage record (P)    */
      return(FALSE);                      /* expected but not found.        */
   }

   noargs = getstrs(text,strs);

#ifdef MSDOS
   *stchain  = atol(strs[0]);
   *endchain = atol(strs[1]);
#else
   *stchain  = atoi(strs[0]);
   *endchain = atoi(strs[1]);
#endif


   if (!ENHANCED)
      MAXENDCHAIN = 9999;

   *stchain =
    (*stchain != MAXENDCHAIN && *endchain != MAXENDCHAIN) ?
    get_chain(*stchain) : *stchain;

   *endchain =
   (*stchain != MAXENDCHAIN && *endchain != MAXENDCHAIN) ?
    get_chain(*endchain) : *endchain;

   if ((reverse) && (*stchain > *endchain))
   {
      tmpstart = *stchain;
      *stchain = *endchain;
      *endchain = tmpstart;
   }

   if ((*stchain == -1) || (*endchain == -1))
      pusherror(*seqid,8402);     /* Incorrect chainage value start chainage */
   else                           /* is null                                 */
      if (*stchain > *endchain)
          pusherror(*seqid,8401); /* Start chainage exceeds end chainage. */


   return(TRUE);

} /* PROPREC END BRACE */

