
/* SCCS ID keywords, do not remove */
/* "@(#)r7rep.c	1.1 09/16/03"                       */
/* Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved. */

/************************************************************ 
* Standard I/O definition and rmms header file.             *
************************************************************/ 
#include <stdio.h>
#include "rmms.h"




FILE *rep_secs()
{
void set_sec_qry();
FILE *fp,*def_rs_rep();
int id,per_defects,tot_defects,tot_rs;    
char dtp_id[16];
short int fin_sec;

  set_sec_qry();


  do
  {

    fin_sec = fch_sec(&id,dtp_id,&per_defects,&tot_defects,&tot_rs);   
    fp=def_rs_rep(id,dtp_id,tot_defects,tot_rs,per_defects);    

  } while (fin_sec != -1) ;

return(fp);
}


