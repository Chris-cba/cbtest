/* SCCS ID keywords, do not remove */
/* Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved. */
/* "@(#)r1validz.h	1.1 09/08/03"                       */

/* PVCS ID keywords, do not remove      */
/* "$Workfile:   r1validz.h  $ $Revision:   2.4  $ $Modtime:   Jun 28 2018 10:28:12  $" */

/* r1validc.h
contains C functions for checking the format of husky hunter Z load records
*/

/* Z Validation
function to validate the format of Z type records
parameters passed : Z type record text, sequence no.
return value : BOOLEAN passed or failed
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 
Assumed Z card from Husky Hunter
number of B cards : 4 digits right justified and packed with spaces
number of C cards : 4 digits right justified and packed with spaces
*/
BOOLEAN countvl();

BOOLEAN z_validation(rtext,lineno)
  /* z type record text */
  char *rtext;
  /* line number of record */
  long int lineno;
  {
  char text[200],*strs[50];

  /* make copy of record text to allow protection of record text */
  strcpy(text,rtext);

  getwstrs(text,strs);

  /* b card count */
  countvl(strs[0],lineno);

  /*c card count */
  countvl(strs[1],lineno);
 
  return(TRUE);
  }

/* countvl
function to validate the format of count fields from Z type records
parameters passed : count field text. appropriate line number
return value : BOOLEAN passed or failed
validates for numeric or ' ' right justified 
4 characters
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 
*/
BOOLEAN countvl(count,lineno)
  /* count field text */
  char *count;           
  /* line number */
  long int lineno;
  {
  int i;
  int min_chars = 4;
  BOOLEAN num = FALSE;

  if (strlen(count) < min_chars)
    {
    sprintf(err_msg,"ERROR: Z rec count - Less than 4 characters BPR-8046");
    format_err(lineno,3);
    }   

  for (i=0;i < strlen(count);++i)
    {
    if (isdigit(count[i])||((count[i] == ' ')&&(num==FALSE)&&(i!=3)))
      {
      num = isdigit(count[i])?TRUE:FALSE;
      } 
    else 
      {
      strcpy(err_msg,"ERROR: Counts - Non numeric or embedded space BPR-8047");
      format_err(lineno,3);
      }      
    }

  return(TRUE);                        
  } /* end brace countvl */
