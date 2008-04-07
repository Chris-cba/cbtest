
/* SCCS ID keywords, do not remove */
/* "@(#)r1validb.h	1.1 09/08/03"                       */

/* r1validb.h

contains C functions for checking the format of husky hunter B load records
 
*/

/* putspace - put spaces into a string

usage text - string to use

pos        - postion to put space

no         - no spaces to put
*/


void putspace(text,pos,no)
char *text; /*string to put space*/
int pos; /*postion of space*/
int no;  /*number of spaces*/
{
char newtext[2000];
int noput = 0,newlen = 0,i; 
newlen = strlen(text) + no;

for (i=0;i<newlen;i++)
{
  newtext[i] =   ( (i < pos) || (i >= (pos + no)) ) ? text[i-noput] : ' '; 
  noput      =   ( (i >= pos) && (i < (pos + no)) ) ? (noput + 1) : noput; 
} /*END BRACE for */
newtext[newlen] = '\0';
strcpy(text,newtext);

} /*END BRACE putspace*/

/* MAPSTR
remap character string back onto itself

usage

text - string to remap

map - old positions to map to 

eg. mapstr("abc","3.2.1") would mapstr "abc" to "cba"

old string postions not refered to are removed

mapstr("abc","2.3") = "bc"

non numeric characters are inserted as in string.

string not to exceed 200 characters

string is null terminated 
*/


void mapstr(text,map)
char *text; /*string to process*/
char *map; /*map of new string*/
{
char *pos[200]; /* array of strings to contain map postions*/
char newtext[2000];
int i=0,nopos=0;

nopos = getmap(map,pos);

for(i=0;i<nopos;i++)
{newtext[i] = isdigit(*pos[i]) ? text[atoi(pos[i])] : *pos[i];}
newtext[nopos] = '\0';
strcpy(text,newtext);

} /*END BRACE mapstr*/

/* hhtodate 

returns husky hunter dates (YYMMDD) as 3 numerics

representing : year 
               
               month 

               day
*/
                                       
void hhtodate( date,yr,month,day)
char *date;
int *yr,*month,*day;
{ static char num[3]="xx"; int atoi();
    *num= *date++; *(num+1)= *date++; *yr   = atoi(num);
    *num= *date++; *(num+1)= *date++; *month = atoi(num);
    *num= *date++;*(num+1)= *date++; *day   = atoi(num);
}


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

number of fields = 6

link : 10 alphanumeric or space  by linkvl

section : 2 numeric

date : valid date in above format.

direction : is Y or N

inspectors initials : 3 characters

*/


BOOLEAN b_validation(rtext,lineno)

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

if (((noargs = getwstrs(text,strs)) < 5)  ||
    ((noargs = getwstrs(text,strs)) > 7))
{                           
  sprintf(err_msg,
          "ERROR: %d fields in B type record  BPR-8014",
           (noargs + 1));
  format_err(lineno,1);
}    

/* link : 10 alphanumeric or trailing space*/
linkvl(strs[0],lineno);

/* section : 2 numeric */
sectvl(strs[1],lineno);

/* date : valid date in above format. */
datevl(strs[2],lineno);

/* direction is Y or N */
/* HMDIF MOD
if ( (strlen(strs[3]) > 1 )||(strlen(strs[3]) < 1 )
   ||((*strs[3] != 'Y') && (*strs[3] != 'N')) )
{ strcpy(err_msg,
"ERROR: Direction flag - does not equal (Y,N)  BPR-8015");
format_err(lineno,1); 
}   
*/

/* inspectors initials : 3 characters */
inspvl(strs[4],lineno); 

return(TRUE);

} /* end brace b_validation */


/* linkvl

function to validate the format of link fields from B type records

parameters passed : link field text. appropriate line number

return value : BOOLEAN passed or failed

validates for alphanumeric or trailing spaces (except pos 0 and 4)

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/

linkvl(link,lineno)
char *link;           
long int lineno;
{ 

   int i;

/* ARCHANGES START */
/* The code below validates the link id. This is not necessary and hinders */
/* loading for non RMMS UKPMS users such as Barnet */

   return(TRUE);                        

/* ARCHANGES END */

   if (strlen(link) > 10)
   { 
      strcpy(err_msg,
         "ERROR: Link code format - More than 10 characters BPR-8016");
      format_err(lineno,1);
   }   

   if (strlen(link)  < 10)
   { 
      strcpy(err_msg,
         "ERROR: Link code format - Less than 10 characters BPR-8017");
      format_err(lineno,1);
   }   

   if (link[0] == ' ')
   {
      strcpy(err_msg,"ERROR: Link code format - Not left justified BPR-8018");
      format_err(lineno,1);
   }

/*
   if (link[9] == ' ')
   {
      strcpy(err_msg,
         "ERROR: Link code format - Must end with non space BPR-8018");
      format_err(lineno,1);
   }
*/

   return(TRUE);                        
} 

/* sectvl

function to validate the format of section fields from B type records

parameters passed : section field text. appropriate line number

return value : BOOLEAN passed or failed

validates for numeric 

2 characters

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/

sectvl(section,lineno)

/* section field text */
char *section;           

/* line number */
long int lineno;

{ /*sectvl start brace */

int i;

if (strlen(section) > 5)
{ strcpy(err_msg,
"ERROR: Section code format - More than 2 characters BPR-8020");
          format_err(lineno,1);
}   


if (strlen(section)  < 2)
{ strcpy(err_msg,
"ERROR: Section code format - Less than 2 characters BPR-8021");
          format_err(lineno,1);
}   

/* -------------------------------------------------------------------- *
   24-Apr-01. MRE. Changed to allow SECTION NUMBER to contain alphabetic
   characters if product option ANSECTNO is 'Y'.
 * -------------------------------------------------------------------- */
if(strcmp(ansectno_flag.arr,"Y") == 0 ){
    for (i=0;i < strlen(section);++i)
    {
    if (isdigit(section[i]) || isupper(section[i]) || islower(section[i]) )
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
    if (isdigit(section[i]))
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

} /* end brace sectvl */
                 

/* datevl

function to validate the format of date fields from B type records

parameters passed : date field text. appropriate line number

return value : BOOLEAN passed or failed

validates for date 

6 characters

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/


datevl(date,lineno)

/* date field text */
char *date;           

/* line number */
long int lineno;

{ /*datevl start brace */

int i,yr,month,day;

if (strlen(date) > 6)
{ strcpy(err_msg,
"ERROR: Date format - More than 6 characters BPR-8023");
  format_err(lineno,1);
}   


if (strlen(date)  < 6)
{ strcpy(err_msg,
"ERROR: Date format - Less than 6 characters BPR-8024");
  format_err(lineno,1);
}   

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

} /* end brace datevl */


/* inspvl

function to validate the format of inspector fields from B type records

parameters passed : inspector field text. appropriate line number

return value : BOOLEAN passed or failed

validates for character 

3 characters  or ' '

external action : output to stdout appropriate error message.
                  and line number . via global string err_msg. 

*/

inspvl(insp,lineno)

/* insp field text */
char *insp;           

/* line number */
long int lineno;

{ /*inspvl start brace */

int i;

if (strlen(insp) > 3)
{ strcpy(err_msg,
"ERROR: Inspector initials  - More than 3 characters BPR-8032");
  format_err(lineno,1);
}   


if (strlen(insp)  < 3)
{ strcpy(err_msg,
"ERROR: Inspector initials  - Less than 3 characters BPR-8033");
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

} /* end brace inspvl */
                 





/* getwstrs

   returns the no of strings found (seperator = ',') in line

   input : line

   output : args - array of char pointers to line

   effects : truncates line by inserting a 0 at pos of first comma

   does not remove trailing spaces from strings
*/
                                       


int getwstrs( line, args )
char *line,*args[];
{ int noargs=0,i;
 char *strchr(),*l;

while( line!= NULL && *line != '\0' ) {
    args[noargs++]=line;
    line=strchr(line,',');
    if( line != NULL ) *line++ = '\0';
    }

return(noargs);
}

int getmap( line, args )
char *line,*args[];
{ int noargs=0,i;
 char *strchr(),*l;

while( line!= NULL && *line != '\0' ) {
    args[noargs++]=line;
    line=strchr(line,'.');
    if( line != NULL ) *line++ = '\0';
    }

return(noargs);
}

