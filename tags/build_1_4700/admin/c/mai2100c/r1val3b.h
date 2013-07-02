/* SCCS ID keywords, do not remove */
/* Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. */
/* "@(#)r1val3b.h	1.1 09/08/03"                       */

/* PVCS ID Keywords, do not remove */
/* "$Workfile:   r1val3b.h  $ $Revision:   2.4  $ $Modtime:   Jul 02 2013 09:35:46  $" */

/* r1val3b.h
contains C functions for checking the format of husky hunter B load records
for ROMIS
*/

/* G B Validation
function to validate the format of B type records
for ROMIS
parameters passed : B type record text, sequence no.
return value : BOOLEAN passed or failed
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 
Assumed B card from Husky Hunter
link : 10 alpha fixed format 
section : 5 numeric
date : YYMMDD
direction : 1  apha domain (Y N)
inspectors  initials : 3 alpha  or ' '
Validation performed :
number of fields = 5
link : 10 alphanumeric or space  by linkvl
section : 5 numeric
date : valid date in above format.
direction : is Y or N
inspectors initials : 3 characters
*/
BOOLEAN gsectvl();

BOOLEAN gb_validation(rtext,lineno)
  /* b type record text */
  char *rtext;
  /* line number of record */ 
  long int lineno;
  {
  char text[200],*strs[10];
  int noargs;

  /* make copy of record text to allow protection of record text */
  strcpy(text,rtext);

  noargs = getwstrs(text,strs);

  if ((noargs != 5) && (noargs != 9))
    {                           
    sprintf(err_msg,"ERROR: %d fields in B type record  BPR-8014",(noargs + 1));
    format_err(lineno,1);
    }    

  /* link : 10 alphanumeric or trailing space*/
  linkvl(strs[0],lineno);

  /* section : 2 numeric */
  gsectvl(strs[1],lineno);

  /* date : valid date in above format. */
  datevl(strs[2],lineno);

  /* direction is Y or N */
  /* HMDIF MOD
  if ((strlen(strs[3]) > 1 )||(strlen(strs[3]) < 1 )||((*strs[3] != 'Y') && (*strs[3] != 'N')))
    {
    strcpy(err_msg,"ERROR: Direction flag - does not equal (Y,N)  BPR-8015");
    format_err(lineno,1);
    }   
  */

  /* inspectors initials : 3 characters */
  inspvl(strs[4],lineno); 

  return(TRUE);
  } /* end brace b_validation */



/* gsectvl
function to validate the format of section fields from B type records
for ROMIS
parameters passed : section field text. appropriate line number
return value : BOOLEAN passed or failed
validates for numeric 
5 characters
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 
*/
BOOLEAN gsectvl(section,lineno)
  /* section field text */
  char *section;           
  /* line number */
  long int lineno;
  {
  int i;

  if (strlen(section) > 5)
    {
    strcpy(err_msg,"ERROR: Section code format - More than 5 characters BPR-8020");
    format_err(lineno,1);
  }   

  if (strlen(section)  < 1)
    {
    strcpy(err_msg,"ERROR: Section code format - Less than 1 character BPR-8021");
    format_err(lineno,1);
    }   

  /* -------------------------------------------------------------------- *
   24-Apr-01. MRE. Changed to allow SECTION NUMBER to contain alphabetic
   characters if product option ANSECTNO is 'Y'.
  * -------------------------------------------------------------------- */
  if(strcmp(ansectno_flag.arr,"Y") == 0 )
    {
    for (i=0;i < strlen(section);++i)
      {
      if (isdigit(section[i]) || isupper(section[i]) || islower(section[i]) )
        {
        /* do nothing */ ;
        } 
      else 
        {
        strcpy(err_msg,"ERROR: Section code format - Invalid character BPR-8022");
        format_err(lineno,1);
        }      
      }
    }
  else
    {
    for (i=0;i < strlen(section);++i)
      {
      if (isdigit(section[i]))
        {
        /* do nothing */ ;
        } 
      else 
        {
        strcpy(err_msg,"ERROR: Section code format - Invalid character BPR-8022");
        format_err(lineno,1);
        }      
      }
    }
  /* -------------------------------------------------------------------- *
   24-Apr-01. MRE. End of changes.
  * -------------------------------------------------------------------- */

  return(TRUE);                        
  } /* end brace gsectvl */
