/* r1validc.h                                                                  */
/* contains C functions for checking the format of husky hunter C load records */

/* SCCS ID keywords, do not remove */
/* Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. */
/* "@(#)r1validc.h	1.2 05/20/04"  */

/* PVCS ID keywords, do not remove      */
/* "$Workfile:   r1validc.h  $ $Revision:   2.6  $ $Modtime:   Jul 02 2013 09:36:44  $" */

/* ---------------------------------------------------------------------- *
   Change History
   --------------
   Who            When       Change Description
   -------------- ---------  --------------------------------------------
   M R Elsmore    26-Apr-01  Changed to allow chainage to be non-integer
                             (decimal) number of any length. Leading and
                             trailing spaces are allowed, but embedded
                             spaces are not.
 * ---------------------------------------------------------------------- */


/* C Validation
function to validate the format of C type records
parameters passed : C type record text, sequence no.
return value : BOOLEAN passed or failed
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg.
Assumed C card from Husky Hunter
inventory mnemonic : 2 characters
x section positon : 1 numeric or  ' '
start chain : 6 numeric or ' '
end chain   : 6 numeric or ' '
** attributes : 40 printable characters or less
*/
BOOLEAN inventvl();
BOOLEAN xsectvl();
BOOLEAN chainvl();

#include <string.h>

BOOLEAN c_validation(rtext,lineno,hermis_file,ped4chrass_value)
  /* c type record text */
  char *rtext;
  /* line number of record */
  long int lineno;
  BOOLEAN hermis_file;
  char *ped4chrass_value;
  {
  char text[2000],*strs[1000];
  int noargs,i;

  /* make copy of record text to allow protection of record text */
  strcpy(text,rtext);

  /* checks max no attributes permitted and breaks up attribute string with
  null terminators, returns array of string pointers to each attribute in
  string text */
  if ((noargs = getwstrs(text,strs)) > 130)
    {
    sprintf(err_msg,"ERROR: %d fields in C type record (Max 130) BPR-8035",(noargs + 1));
    format_err(lineno,3);
    }

  /* inventory mnemonic : 2 characters  */
  inventvl(strs[0],lineno,ped4chrass_value);

  /*x section positon : 1 numeric or Q W E R T Y or ' '*/
  xsectvl(strs[1],lineno,hermis_file);

  /*start chain :  numeric or ' '*/
  chainvl(strs[2],lineno);

  /*end chain   :  numeric or ' '*/
  chainvl(strs[3],lineno);

  for (i=4;i < noargs;++i)
    {
    if (strlen(strs[i]) > 500)
      {
      strcpy(err_msg,"ERROR: Inventory item field > 40 characters BPR-8036");
      format_err(lineno,3);
      }
    }
  return(TRUE);
} /* end brace c_validation */

/* inventvl
function to validate the format of inventory  fields from C type records
parameters passed : inventory  field text. appropriate line number
return value : BOOLEAN passed or failed
validates for character
2 characters
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg.
*/
BOOLEAN inventvl(inv,lineno,ped4chrass_value)
  /* inventory  field text */
  char *inv;
  /* line number */
  long int lineno;
  char *ped4chrass_value;
  {
  int i;

  /* If the product option PED4CHRASS is set to Y then any device using the
   * PED File will be outputing 4 character (nm3) asset codes so we need to
   * allow them, if PED4CHRASS is set to N (or any other value) the asset
   * codes should be the 2 characters that MAI normaly deals with. */
  
  if (strlen(inv) > 2 && strcmp(ped4chrass_value,"N")==0)
    {
    strcpy(err_msg,"ERROR: Inventory item  - More than 2 characters BPR-8037");
    format_err(lineno,3);
    }

  if (strlen(inv) > 4)
    {
    strcpy(err_msg,"ERROR: Inventory item  - More than 4 characters BPR-8037");
    format_err(lineno,3);
    }

  if (strlen(inv)  < 2)
    {
    strcpy(err_msg,"ERROR: Inventory item  - Less than 2 characters BPR-8038");
    format_err(lineno,3);
    }

  for (i=0;i < strlen(inv);++i)
    {
    if ((isalpha(inv[i])) || (isdigit(inv[i])))
      {
      /* do nothing */;
      }
    else
      {
      strcpy(err_msg,"ERROR: Inventory item - Invalid character BPR-8039");
      format_err(lineno,3);
      }
    } /* end brace FOR */
  return(TRUE);
  } /* end brace inventvl */

/* xsectvl
function to validate the format of x section fields from C type records
parameters passed : X section field text. appropriate line number
return value : BOOLEAN passed or failed
validates for alpha numeric  or ' '
1 character
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg.
*/
BOOLEAN xsectvl(xsection,lineno,hermis_file)
  /* x section field text */
  char *xsection;
  /* line number */
  long int lineno;
  BOOLEAN hermis_file;
  {
  if ((strlen(xsection) > 4) && (hermis_file == FALSE))
    {
    strcpy(err_msg,"ERROR: X Section - More than 1 characters BPR-8040");
    format_err(lineno,3);
    }

  if (strlen(xsection)  < 1)
    {
    strcpy(err_msg,"ERROR: X Section - Less than 1 characters BPR-8041");
    format_err(lineno,3);
    }

  if (isalnum(*xsection) || (*xsection == ' '))
    {
    /* do nothing */;
    }
  else
    {
    strcpy(err_msg,"ERROR: X Section - Invalid character BPR-8042");
    format_err(lineno,3);
    }
  return(TRUE);
  } /* end brace xsectvl */


/* chainvl
function to validate the format of chainage fields from C type records
parameters passed : chainage field text. appropriate line number
return value : BOOLEAN passed or failed
validates for numeric or ' ' right justified
4 characters
external action : output to stdout appropriate error message.
                  and line number . via global string err_msg.
*/
BOOLEAN chainvl(chain,lineno)
  /* chainage field text */
  char *chain;
  /* line number */
  long int lineno;
  {
  /* ------------------------------------------------------- *
   * 25-Apr-01. MRE. Following validation checks replaces    *
   * original code. This is for HongKong to allow non-integer*
   * chainage to be loaded.                                  *
   * ------------------------------------------------------- */
	int i;
	BOOLEAN num_found        = FALSE;
	BOOLEAN point_found      = FALSE;
	BOOLEAN valid_num        = TRUE;
	BOOLEAN trailing_space   = FALSE;
  char    *before_dec;

	for(i = 0; i < strlen(chain) && valid_num; i++)
    {
    /* ------------------------------------------------------------------------------------ *
       If the current character is a white space, and we have already had a digit or
       the decimal point, then set flag to indicate trailing spaces.
     * ------------------------------------------------------------------------------------ */
		if(isspace(chain[i]) && (num_found || point_found))
      {
			trailing_space=TRUE;
		  }
		if(isdigit(chain[i]))
      {
			num_found = TRUE;
		  }
		if(chain[i] == '.')
      {
			if(point_found)
        {
				valid_num = FALSE;
			  }
			point_found = TRUE;
		  }
		if(isspace(chain[i]) || isdigit(chain[i]) || chain[i] == '.')
      {
			;
		  }
		else
      {
			valid_num = FALSE;
	  	}
    /* ------------------------------------------------------------------------------------ *
       If the current character is a digit or the decimal point, and we have had trailing
       spaces, then there are embedded spaces int the string.
     * ------------------------------------------------------------------------------------ */
		if((isdigit(chain[i]) || chain[i] == '.') && (trailing_space))
      {
			if(trailing_space)
        {
				valid_num = FALSE;
			  }
		  }
	  }

	if(!valid_num)
    {
		strcpy(err_msg,"ERROR: Chainage - Non numeric or embedded space BPR-8044");
		format_err(lineno,3);
	  }

  before_dec = (char*)strtok(chain,".");
  if(strlen(before_dec) > 6)
    {
    strcpy(err_msg,"ERROR: Chainage - More than 6 characters BPR-8043");
    format_err(lineno,3);
    }

  /* ------------------------------------------------------- *
   * 25-Apr-01. MRE. Following validation checks replaced.   *
   * with above code.                                        *
   * ------------------------------------------------------- */
  /*  if (strlen(chain) > 6)                                 */
  /*  { strcpy(err_msg,                                      */
  /*  "ERROR: Chainage - More than 6 characters BPR-8043");  */
  /*    format_err(lineno,3);                                */
  /*  }                                                      */
  /*                                                         */
  /*   for (i=0;i < strlen(chain);++i)                       */
  /*   {                                                     */
  /*                                                         */
  /*   if (                                                  */
  /*   isdigit(chain[i])                                     */
  /*   ||                                                    */
  /*   ((chain[i] == ' ')&&(num==FALSE)&&(i!=3))             */
  /*      ) /- end of IF -/                                  */
  /*     { num = isdigit(chain[i])?TRUE:FALSE;}              */
  /*   else                                                  */
  /*   { strcpy(err_msg,                                     */
  /*    "ERROR: Chainage - Non numeric or embedded space BPR-8044");   */
  /*     format_err(lineno,3);                               */
  /*   }                                                     */
  /*                                                         */
  /*   } /- end brace FOR -/                                 */
  /* ------------------------------------------------------  */

  return(TRUE);
  } /* end brace chainvl */
