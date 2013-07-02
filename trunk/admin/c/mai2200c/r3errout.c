#include <stdio.h>
#include "rmms.h"
/* SCCS ID keywords, do not remove */
/* Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. */

static char *sccsid = "@(#)r3errout.c	1.2 12/08/06";


/***********
Name : errorout

Purpose : To provide a standard way of handling error conditions from pro*C
programs.

Type : BOOLEAN

Usage :

      return = errorout(errtxt,callfunc,erfi)

Input :
         Name      Type      Meaning
         ----      ----      -------
         (Argument List)
         errtxt    string    Text of the error message.
         callfunc  string    The name of the function that called errout.
         erfi      pointer   Pointer to output file for error messages.

Output :
         Name      Type      Meaning
         ----      ----      -------
         (Argument List)

         Function returned value : Boolean - indicates whether the message has
                                   been output sucessfully.

Externals
Used :

         Reference
         (only)    :

         Changed   :
          DATE         : 31-10-97
          CHANGED BY   : G Fletcher
          DESCRIPTION  : client-server conversion

Notes :

Author : G. Dutton 20-APR-88

Effects :

Modifications :

         Date      Author
         ----      ------

         Reason :

         Modification Description :


         Date      Author
         ----      ------

         Reason :

         Modification Description :

**********/

BOOLEAN errorout(errtxt,callfunc,erfi)
char *errtxt,*callfunc;
FILE *erfi;
{
   if ( (fprintf(erfi,
                 "\nMessage - \n\t%s\n\t\terrorout invoked by : %s\n",
                 errtxt,
                 callfunc)) == IOERROR)
   {
      puts("Message -");
      puts("ERROR: error in outputing previous error condition BPR-8000");
      puts("errorout invoked by : ERROROUT");
      fflush(stdout);
      return(FAIL);
   }
   else
      fflush(erfi);
      return(SUCCESS);
}
