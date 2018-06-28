/* SCCS ID keywords, do not remove */
/* Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved. */
/* "@(#)r1forerr.h	1.1 09/08/03"                       */

/* PVCS ID keywords, do not remove      */
/* "$Workfile:   r1forerr.h  $ $Revision:   2.4  $ $Modtime:   Jun 28 2018 10:28:12  $" */

/* Modification history :-
 * DATE         : 3-11-97
 * CHANGED BY   : G Fletcher
 * DESCRIPTION  : client-server conversion
*/

/* include file contains code to control the output of errors messages found
when format checking HH load files */
/* confirm_err -
sets format error flags - if not set.
rolls back database work - if any.
*/

extern short EXDebug;

BOOLEAN confirm_err()
  {
  void rollback();

  if (forok == TRUE) 
    {
    if (insyn == TRUE)
      {
      rollback();
      }
    insyn=FALSE;forok=FALSE;return(TRUE);
    }
  else
    {
    return(FALSE);
    }
}

/* stack_err -
controls and stacks format errors found.

gets err_msg stacks in err_stack
*/

int stack_err(no)
  int no; /*line count for records*/
  {
  if (no != 0)
    {
    sprintf(err_stack[noerrs],"line %5d - %s",no,err_msg);
    }
  else 
    {
    strcpy(err_stack[noerrs],err_msg);
    }
  noerrs=noerrs + 1;
  return(noerrs);
  }

/* function Format_err - 
controls and stacks format errors found.
gets err_msg stacks in err_stack
sets forok to false 
sets insyn to false 
increments noerrs
type of error 1 - unconfirmed, 2 - confirm unconfirmed errors, 
3 - confirmed  
*/                                                                 

int format_err(no,type)
  int no,type; /*line count for records*/
  {                 
  int dump_errs();

  switch (type) 
    {
    case 1 : stack_err(no);
             break;
            
    case 2 : confirm_err();
             break;

    case 3 :
   default : confirm_err();
             stack_err(no);
             break;
    }

  if (noerrs > 98) 
    {
    dump_errs();
    } 
  return(noerrs);
  }/*end brace format_err*/

/* function dump_errs - 
prints out error stack to stdout and assigned error file
*/
int dump_errs() 
  {                                            
  int i; /*control counts*/

  if (prerrors==0 && noerrs > 0)
    {
	  fprintf(fi,"\nBPR2100 FORMAT CHECK ERRORS FOR HUSKY HUNTER DATA \n\n");
	  if (EXDebug)
		  printf("\nBPR2100 FORMAT CHECK ERRORS FOR HUSKY HUNTER DATA \n\n");
    }

  for (i=0;i < noerrs ;i++)
    {
  	prerrors++;
  	fprintf(fi,"   %s\n",err_stack[i]);
	  if (EXDebug)
  		printf("%s\n",err_stack[i]);
    }
  noerrs=0;
  }
