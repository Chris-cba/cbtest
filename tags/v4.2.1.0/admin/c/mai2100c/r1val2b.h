
/* SCCS ID keywords, do not remove */
/* "@(#)r1val2b.h	1.1 09/08/03"                       */

/* code to account for 2nd HH load formats */



/* B Validation

function to validate the format of B type records

parameters passed : B type record text, sequence no.

return value : BOOLEAN passed or failed

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

Assumed B card from Husky Hunter

link : 10 alpha fixed format 

section : 2 numeric
                   
date : YYMMDD

direction : 1  apha domain (Y N)

inspectors  initials : 3 alpha  or ' '


Validation performed :

number of fields = 5

link : 10 alphanumeric or space  by linkvl

section : 2 numeric

date : valid date in above format.

direction : is Y or N

inspectors initials : 3 characters

*/


BOOLEAN sb_validation(rtext,lineno)

/* b type record text */
char *rtext;

/* line number of record */
long int lineno;

{ /* b_validation start brace*/

char text[200],*strs[10];

int noargs;

/* make copy of record text to allow protection of record text */

strcpy(text,rtext);

/* check number of fields in B record */

if ((noargs = getwstrs(text,strs)) != 11)
{                           
  sprintf(err_msg,
          "ERROR: %d fields in B type record  BPR-8014",
           (noargs + 1));
  format_err(lineno,1);              
}    

/* link : 6 alphanumeric or trailing space*/
slinkvl(strs[1],lineno);

/* section : 5 numeric */
ssectvl(strs[2],lineno);

/* date : valid date in above format. */
sdatevl(strs[0],lineno);

/* inspectors initials : 5 characters */
sinspvl(strs[3],lineno);

return(TRUE);

} /* end brace b_validation */


/* slinkvl

function to validate the format of link fields from B type records

parameters passed : link field text. appropriate line number

return value : BOOLEAN passed or failed

validates for alphanumeric or trailing spaces (except pos 0 )

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/

slinkvl(link,lineno)

/* link field text */
char *link;           

/* line number */
long int lineno;

{ /*linkvl start brace */

int i;

if (strlen(link) > 6)
{ strcpy(err_msg,
"ERROR: Link code format - More than 6 characters BPR-8016");
  format_err(lineno,1);              
}   


if (strlen(link)  < 6)
{ strcpy(err_msg,
"ERROR: Link code format - Less than 6 characters BPR-8017");
  format_err(lineno,1);              
}   
/* Test for an Alpha Numeric Linkcode striped out for D.o.E.
for (i=0;i < strlen(link);++i)
{

if (isalnum(link[i]))
  {;} 
else
  {if (link[i] == ' ' && i != 0)
     {;} 
   else
     { if (link[i] == ' ')
         { strcpy(err_msg,
          "ERROR: Link code format - Not left justified BPR-8018");
         format_err(lineno,1);              
         }
         else
         { strcpy(err_msg,
          "ERROR: Link code format - Invalid character BPR-8019");
         format_err(lineno,1);              
         }      
     }
  }

}
*/
return(TRUE);                        

} /* end brace slinkvl */

/* ssectvl

function to validate the format of section fields from B type records

parameters passed : section field text. appropriate line number

return value : BOOLEAN passed or failed

validates for numeric 

5 characters

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/

ssectvl(section,lineno)

/* section field text */
char *section;           

/* line number */
long int lineno;

{ /*sectvl start brace */

int i;

if (strlen(section) > 5)
{ strcpy(err_msg,
"ERROR: Section code format - More than 5 characters BPR-8020");
  format_err(lineno,1);              
}   


if (strlen(section)  < 5)
{ strcpy(err_msg,
"ERROR: Section code format - Less than 5 characters BPR-8021");
  format_err(lineno,1);              
}   

/* -------------------------------------------------------------------- *
   24-Apr-01. MRE. Changed to allow SECTION NUMBER to contain alphabetic
   characters if product option ANSECTNO is 'Y'.
 * -------------------------------------------------------------------- */
if(strcmp(ansectno_flag.arr,"Y") == 0 ){
    for (i=0;i < strlen(section);++i)
    {
    if (isdigit(section[i]) || isspace(section[i]) || isupper(section[i]) || islower(section[i]) )
      { /* do nothing */ ;} 
    else 
      { strcpy(err_msg,
        "ERROR: Section code format - Invalid character BPR-8022");
         format_err(lineno,1);
       }      
    } /* end brace FOR */
}
else {
    for (i=0;i < strlen(section);++i)
    {
    if (isdigit(section[i]) || isspace(section[i]) )
      { /* do nothing */ ;} 
    else 
      { strcpy(err_msg,
        "ERROR: Section code format - Invalid character BPR-8022");
         format_err(lineno,1);
       }      
    } /* end brace FOR */
} /* end brace for else */
/* -------------------------------------------------------------------- *
   24-Apr-01. MRE. End of changes.
 * -------------------------------------------------------------------- */

return(TRUE);                        

} /* end brace ssectvl */
                 

/* sdatevl

function to validate the format of date fields from B type records

parameters passed : date field text. appropriate line number

return value : BOOLEAN passed or failed

validates for date 

6 characters

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/


sdatevl(date,lineno)

/* date field text */
char *date;           

/* line number */
long int lineno;

{ /*datevl start brace */

int i,yr,month,day;
char map[30];

if (strlen(date) > 8)
{ strcpy(err_msg,
"ERROR: Date format - More than 8 characters BPR-8023");
  format_err(lineno,1);              
}   


if (strlen(date)  < 8)
{ strcpy(err_msg,
"ERROR: Date format - Less than 8 characters BPR-8024");
  format_err(lineno,1);              
}   

strcpy(map,"6.7.3.4.0.1");
mapstr(date,map);

for (i=0;i < strlen(date);++i)
{

if (isdigit(date[i]))
  { /* do nothing */ ;} 
else 
  { strcpy(err_msg,
    "ERROR: Date format - Invalid character BPR-8025");
     format_err(lineno,1);              
   }      

} /* end brace FOR */
                  
hhtodate(date,&yr,&month,&day);

if (day == 0)
  { strcpy(err_msg,
    "ERROR: Date format - Invalid day BPR-8027");
     format_err(lineno,1);              
   }      

switch (month)
{
/* months with 31 days */ 
case 1 : case 3 : case 5 : case 7 : case 8 : case 10 : case 12 :              
if (day > 31)
  { strcpy(err_msg,
    "ERROR: Date format - Invalid day BPR-8027");
     format_err(lineno,1);              
   }      
   break;

/* months with 30 days */ 
case 4 : case 6 : case 9 : case 11 :             
if (day > 30)
  { strcpy(err_msg,
    "ERROR: Date format - Invalid day BPR-8027");
     format_err(lineno,1);              
   }      
   break;

/* febuary */
case 2 :    
if (
((yr%4==0)&&(day <= 29))
||(day <= 28)
   )
  { /* do nothing */ ;}  
else
  { strcpy(err_msg,
    "ERROR: Date format - Invalid day BPR-8027");
     format_err(lineno,1);              
   }      
break;

default  : strcpy(err_msg,
"ERROR: Date format - Invalid Month        BPR-8031");
           format_err(lineno,1);              
           break;
} /* end brace SWITCH */

              
return(TRUE);                        

} /* end brace sdatevl */


/* sinspvl

function to validate the format of inspector fields from B type records

parameters passed : inspector field text. appropriate line number

return value : BOOLEAN passed or failed

validates for character 

3 characters  or ' '

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/

sinspvl(insp,lineno)

/* insp field text */
char *insp;           

/* line number */
long int lineno;

{ /*inspvl start brace */

int i;

if (strlen(insp) > 5)
{ strcpy(err_msg,
"ERROR: Inspector initials  - More than 5 characters BPR-8032");
  format_err(lineno,1);              
}   


if (strlen(insp)  < 5)
{ strcpy(err_msg,
"ERROR: Inspector initials  - Less than 5 characters BPR-8033");
  format_err(lineno,1);              
}   

for (i=0;i < strlen(insp);++i)
{

if (isalpha(insp[i])||(insp[i]==' '))
  { /* do nothing */ ;} 
else 
  { strcpy(err_msg,
    "ERROR: Inspectors initials - Invalid character BPR-8034");
     format_err(lineno,1);              
   }      

} /* end brace FOR */

return(TRUE);                        

} /* end brace sinspvl */
                 
                
