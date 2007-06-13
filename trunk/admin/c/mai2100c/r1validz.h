
/* SCCS ID keywords, do not remove */
/* "@(#)r1validz.h	1.1 09/08/03"                       */

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

BOOLEAN z_validation(rtext,lineno)

/* z type record text */
char *rtext;

/* line number of record */
long int lineno;

{ /* z_validation start brace*/

char text[200],*strs[50];

int noargs,i;

/* make copy of record text to allow protection of record text */

strcpy(text,rtext);

getwstrs(text,strs);

/* b card count */
countvl(strs[0],lineno);

/*c card count */
countvl(strs[1],lineno);

 
return(TRUE);

} /* end brace z_validation */


/* countvl

function to validate the format of count fields from Z type records

parameters passed : count field text. appropriate line number

return value : BOOLEAN passed or failed

validates for numeric or ' ' right justified 

4 characters

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/

countvl(count,lineno)

/* count field text */
char *count;           

/* line number */
long int lineno;

{ /*countvl start brace */

int i;
int max_chars = 6;
int min_chars = 4;

BOOLEAN num;

num = FALSE;    

/*  Max check removed, no longer required  
if (strlen(count) > max_chars)
{ sprintf(err_msg,
"ERROR: Z rec count - More than 4 characters BPR-8045");
format_err(lineno,3);
}   
*/
if (strlen(count) < min_chars)
{ sprintf(err_msg,
"ERROR: Z rec count - Less than 4 characters BPR-8046");
format_err(lineno,3);
}   

for (i=0;i < strlen(count);++i)
{

if (
isdigit(count[i])
||
((count[i] == ' ')&&(num==FALSE)&&(i!=3))
   ) /* end of IF */
  { num = isdigit(count[i])?TRUE:FALSE;} 
else 
{ strcpy(err_msg,
 "ERROR: Counts - Non numeric or embedded space BPR-8047");
format_err(lineno,3);
}      

} /* end brace FOR */

return(TRUE);                        

} /* end brace countvl */
