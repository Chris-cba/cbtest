
/* SCCS ID keywords, do not remove */
static char *sccsid = "@(#)r5rep.c	1.1 09/16/03";

/************************************************************ 
* Standard I/O definition header file.                      *
************************************************************/ 
#include <stdio.h>
#include "rmms.h"

/************************************************************ 
 * Function : iif_report()                                  *
 *                                                          *
 * Function to carry out main report of data from           *
 * previously selected conditions.                          *
 *                                                          *
 * Function opens output stream on first call and writes    *
 * header record to stream.                                 *
 *                                                          *
 *                                                          *
 *                                                          *
 *                                                          *
 ************************************************************/ 

FILE *iif_report(inits,no_of_c_inv,no_of_d_inv,no_of_sec)
char *inits;
int *no_of_c_inv;
int *no_of_d_inv;
int *no_of_sec;
{
/* Program control variable                                  */
static short int fst_call=1;
static FILE *fp;
short int fin_sec=1;
short int fin_inv=1;

/* Record Count variables                                    */
/* File Pointer variables                                    */
FILE *open_iif_rep();
void set_sec_qry(),set_inv_qry(),open_inv_qry();

/* Print string variables                                    */
int id; 
char linkcode[11],sec_no[6],st_node[7],end_node[7],road_desc[81];      
char inv_code[3],x_sect;
char c_att_str[2000];
char d_att_str[2000];
char date[7]; 
int st_chain,end_chain;

int loop;
BOOLEAN PRINT_OFF_SITE = FALSE;

  if (fst_call == 1)
  {  fp=open_iif_rep(date); fst_call=0; }

set_sec_qry();
set_inv_qry();


  do 
  {
    *no_of_sec = *no_of_sec + 1;
    fin_sec = fch_sec(&id,linkcode,sec_no,st_node,end_node,road_desc);      
    if (par_set('H','C') == 1)
    /* Initials and rod section description are right padded */
    { if (par_set('S','C') == 1)
        fprintf(fp,"\n\"B,%-10s,%2s,%06s,N,%-3s,%-80s\"",
                   linkcode,sec_no,date,inits,road_desc); 
      else 
        fprintf(fp,"\n\"B,%-10s,%2s,%06s,N,%-3s\"",
                   linkcode,sec_no,date,inits); 
    }  
    else
    { fprintf(fp,"\n\"B,%-10s,%2s,%05s,%05s\"",
               linkcode,sec_no,st_node,end_node);}  

    fin_inv = 1;
    open_inv_qry(id);
    do 
    {
      fin_inv = fch_inv(inv_code,&st_chain,&end_chain,
                        &x_sect,c_att_str,d_att_str); 
      if (fin_inv != -2)
      {     
        *no_of_c_inv = *no_of_c_inv + 1;
        if (par_set('N','C') == 1) 
        {  fprintf(fp,"\n\"C,%-2s,%c,%4d,%4d,%s\"",
                 inv_code,x_sect,st_chain,end_chain,c_att_str); }
        else if (par_set('H','C') == 1)
        {  fprintf(fp,"\n\"C,%-2s,%c,%4d,%4d,%s,%s\"",
                 inv_code,x_sect,st_chain,
                 end_chain,c_att_str,d_att_str); }
        else
        {  fprintf(fp,"\n\"C,%-2s,%c,%4d,%4d,%s\"",
                 inv_code,x_sect,st_chain,end_chain,c_att_str); 
           PRINT_OFF_SITE = FALSE;
           for (loop=0; loop<strlen(d_att_str);loop++)
           {
              if ((d_att_str[loop] != ' ') &&
                  (d_att_str[loop] != ','))
                 PRINT_OFF_SITE = TRUE;
           }
           if (PRINT_OFF_SITE)
           {
              fprintf(fp,"\n\"D,%s\"",d_att_str);
              *no_of_d_inv = *no_of_d_inv + 1;
           }
        }
      }
    } while (fin_inv == 1);


  } while (fin_sec == 1);

if (fflush(fp) == EOF)
   {
      printf("\nERROR : Unable to flush information to log file BPR-8204\n");
      write_pipe(NULL,"ERROR : Unable to flush information to log file BPR-8204");
      exit(EX_FAIL);
    }
else 
   {return(fp);}
}

