
/* SCCS ID keywords, do not remove */
/* "@(#)r4strtoc.c	1.1 09/08/03"                       */

/* ora_char_to_str.c      O R A _ C H A R _ T O _ S T R

Purpose: To convert ORACLE VARCHAR variables to NULL terminated
         strings after they have been filled by a select.
         For Example:

              VARCHAR name[15],status[5];

         then EXEC SQL select ... into :name,:status ...;

         followed by:

              ora_char_to_str(&name, &status, NULL);

              printf("name = %s, status = %s\n",name.arr,status.arr);

         Note (1) Up to 8 VARCHAR variables can be included in the
                  argument list followed by NULL.

              (2) The address of the varchar structure must be passed
                  ie &name not name.

-----------------------------------------------------------------------
*/
#include <stdio.h>

ora_char_to_str(v1,v2,v3,v4,v5,v6,v7,v8,v9)
 struct { int len; char arr[1];} *v1,*v2,*v3,*v4,*v5,*v6,*v7,*v8,*v9;
{
if( v1 != NULL ) v1->arr[v1->len] = '\0';else return(1);
if( v2 != NULL ) v2->arr[v2->len] = '\0';else return(1);
if( v3 != NULL ) v3->arr[v3->len] = '\0';else return(1);
if( v4 != NULL ) v4->arr[v4->len] = '\0';else return(1);
if( v5 != NULL ) v5->arr[v5->len] = '\0';else return(1);
if( v6 != NULL ) v6->arr[v6->len] = '\0';else return(1);
if( v7 != NULL ) v7->arr[v7->len] = '\0';else return(1);
if( v8 != NULL ) v8->arr[v8->len] = '\0';else return(1);
if( v9 != NULL ) v9->arr[v9->len] = '\0';else return(1);
}
