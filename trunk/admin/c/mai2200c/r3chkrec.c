#include <stdio.h>
#include "rmms.h"
/* SCCS ID keywords, do not remove */
/* Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. */
static char *sccsid = "@(#)r3chkrec.c	1.1 09/08/03";

extern short EXDebug;
extern char pipe_msg[254];

static struct rectypes {
                       char vrec;
                       int  crec;
                       int  excrec;
                       int  lrec;
                       }
                       recs[14] =
                      {'1',0,0,0,
                       'G',0,0,0,
                       'H',0,0,0,
                       'I',0,0,0,
                       'J',0,0,0,
                       'K',0,0,0,
                       'L',0,0,0,
                       'M',0,0,0,
                       'N',0,0,0,
                       'P',0,0,0,
                       'Q',0,0,0,         /* Quantities added for rline350  */
                       'R',0,0,0,         /* Comments   added for rline350  */
                       'S',0,0,0,         /* Complaints added for rline350  */
                       'X',0,1,0};

static int count;

char *nxtpos(string,c)
char c,*string;
{
   while (*string != '\0')
   {
     if (*string == c )
     {
         string++;
         return(string);
     }
     string++;
   }
return(NULL);

}

/* *********************************************************************
   Function : initcounts
   Descr    : Initialize record counters in array.

   ********************************************************************* */
BOOLEAN initcounts()
{

   for (count=0;count<14;count++)
       recs[count].crec = 0;
   return(SUCCESS);
}

BOOLEAN countrec(rectype)
char rectype;
{
BOOLEAN status;

   status = FALSE;
   
   for (count=0;count<14;count++)       /* Counts all records including 'X' */
   {
      if (recs[count].vrec == rectype)
      {
         recs[count].crec++;
         status = SUCCESS;
      }
   }
   return(status);
}


BOOLEAN chktermrec(termrec,erfi)
char termrec[];
FILE *erfi;
{
BOOLEAN status;
char *nxtpos();
char inlinex[MAXLLINE]
    ,outline[MAXLLINE]
    ,ivalue[MAXLINE]
;
int  i                            /* Integer counter                    */
    ,fld_count                    /* Field counter value                */
    ,counter
;
   status = SUCCESS;

   if (EXDebug)
   {
      printf("Function : chktermrec - r3chkrec.c\n");
      write_pipe(erfi,"Function : chktermrec - r3chkrec.c");
   }

   strcpy(outline,termrec);
   fld_count=numoffields(outline);
   if (fld_count!=12)                        /* Not the Roadline350 product */
      fld_count=9;

       for (counter=1;counter<=fld_count;counter++)
       {
           nullfill(ivalue,6); 
           if ( counter<=(fld_count-1) ) 
           {
              strncpy(ivalue,outline,getnxtpos(outline,','));
              recs[counter].excrec = atoi(ivalue);
              strcpy(outline,nxtpos(outline,',')); 
           }
           else
           {
              strcpy(ivalue,outline);
              recs[counter].excrec = atoi(ivalue);
           }
       }
       for (counter=1;counter<=fld_count;counter++)
       {
           if (recs[counter].crec != recs[counter].excrec)
           {
                errorout(BPR8011,"CHKHHREC",erfi);
                status = FALSE;
                break;
            }
        }
   return(status);
}

/* *************************************************************************
   Function : numoffields
   Descr    : For a specified string value, return the number of comma
              separtated fields.

   ************************************************************************* */
int numoffields( in_string )
char in_string[];
{
   int  i 
       ,ld_cnt=1 
   ;
   char fld_sep=','
   ;

   if (EXDebug)
   {
      printf("Function : NUMOFFIELDS  .... r3chkrec.c\n");
      write_pipe(NULL,"Function : NUMOFFIELDS  .... r3chkrec.c");
   }

    for (i=0;i<strlen(in_string);i++ )
      if ( in_string[i] == fld_sep )
         ld_cnt++;

    return ld_cnt;
} 

/* ===========================================================================
 * Function : getnxtpos 
 * Descr    : For a specified string value, return the position within the 
 *            string of the first occurence of the specified character which
 *            is passed as a parameter.
 *
 * ===========================================================================
 */ 
int getnxtpos( in_string,c )
char in_string[];
char c;
{
   int i
      ,ld_cnt=0
   ;
 
   if (EXDebug)
   {
      printf("Function : GETNXTPOS ..... r3chkrec.c\n");
      write_pipe(NULL,"Function : GETNXTPOS ..... r3chkrec.c");
   }
 
   while (1)
   {
     if ( in_string[ld_cnt]==c)
     {
          break;
     }
   ld_cnt++;
   }
   return ld_cnt;
}

