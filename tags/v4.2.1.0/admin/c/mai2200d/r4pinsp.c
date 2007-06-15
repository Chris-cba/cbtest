
/* SCCS ID keywords, do not remove */
/* static char *sccsid = "@(#)r4pinsp.c	1.1 09/08/03"; */

/*PVCS keyword, do not remove */
static char *sccsid = "$Workfile:   r4pinsp.c  $ $Revision:   2.0  $ $Modtime:   Jun 15 2007 14:39:14  $";

#include <stdio.h>
#include "rmms.h"

extern char pipe_msg[254];

/* ===========================================================================
 * Function : pinsp()
 * Purpose  : Process in,spections. 
 * ===========================================================================
 */
BOOLEAN proinsp(batchid)
long int batchid;
{
BOOLEAN error;
long int enseq                   /* Inspection batch gstart sequence number */
        ,stseq                   /* Inspection batch end sequence number    */ 
        ,no;
char   temp[10];
extern FILE *fi;

   error = FALSE;

   if (sethhbatch(batchid) == FALSE)
   {
      printf("\nERROR: This is not a currently loaded batch BPR-8203\n");
      write_pipe(fi,"ERROR: This is not a currently loaded batch BPR-8203");
      return(FALSE);
   }
   else
   {
   fprintf(fi,"\n\n\n\n%20s***  Loading Batch : %ld ***\n\n",
           " ", batchid);
      while (prosection(batchid,&error,&stseq,&enseq)) ;

/* Print any errors encountered before the end of the Batch                  */

   if (iserror(&no))
   {
       rollback();
       puterror();
   fprintf(fi,"\n Non Section Error Summary\n");
            /* -------------- ------- ------ ---- ---- ---- ---- --- --- ---- ------- ------ */
   fprintf(fi,"Link/            Batch Insp   Insp Insp Prim Sec  St. End Input No. of \n");
   fprintf(fi,"Section Id       Id    Date   Time Type Insp Insp Seq Seq Recs  Errors Status");
   fprintf(fi,"\r_____________________________________________________________________________\n");

      fprintf(fi,"\n- %ld - - %ld - %ld %ld  Not Loaded \n",batchid
                                                           ,stseq
                                                           ,no
                                                           ,no);
    /* If errors were displayed or placed in the log file then the user should be
       informed of the fact that the batch failed inspection load.
     */

      strcpy(pipe_msg,"INFO: The batch FAILED to fully load successfully");
      write_pipe(fi,pipe_msg);

   }

      printf("\nINFO: Finished processing batch : %ld BPR-8603",batchid);
      strcpy(pipe_msg,"INFO: Finished processing batch : ");
      i_toa(batchid,temp);
      strcat(pipe_msg,temp);
      strcat(pipe_msg," BPR-8603");
      write_pipe(fi,pipe_msg);
      return(TRUE);
   }
}

