
/* SCCS ID keywords, do not remove */
/* static char *sccsid = "@(#)r4prep.c	1.4 01/10/07"; */

/*PVCS keyword, do not remove */
static char *sccsid = "$Workfile:   r4prep.c  $ $Revision:   2.0  $ $Modtime:   Jun 15 2007 14:39:14  $";

/* ===========================================================================
 * prorepair.c                   P R O R E P A I R
 *
 *   CHANGE HISTORY :-                                                
 *   DATE         : 10-MAY-90                                         
 *   CHANGED BY   : Steve Voller                                      
 *   DESCRIPTION  : Enhancements to RMMS Amendment Set VI changes.   
 *                  Include code to process new def cats 2.1 - 2.3    
 *                  in N part of case statement.                        
 *                  Amend M and L parts of case to allow req by date to 
 *                  be set depending on whether temp action applied to a
 *                  cat 1 defect. IF perm action and no temp action     
 *                  taken perm due date = cat1t ELSE cat1p because if a 
 *                  temp action has not been done then the perm is due  
 *                  within 24 hours.                                    
 *
 *   Record Lengths : K=51 , L=55, M=55, N=45 therefore text=1001
 * ============================================================================
 */

#include <stdio.h>
#include "rmms.h"

extern BOOLEAN REPAIRCOMPLETE; /* Boolean to define if repair complete     */
extern BOOLEAN l_exists;
extern BOOLEAN REPSETPERD;
extern BOOLEAN ENHANCED;
                               /* selected file loaded is for the Roadline */
                               /* 350 product or for standard product.     */

extern short EXDebug;

BOOLEAN prorepair(supflag,actcode,inspdate,heid,defectid,defcode,defectcat
                 ,compdate,comptime,error,d_priority,responsible,attr1,attr2
                 ,attr3,attr4,seqid)
char supflag,*actcode, *inspdate, *defcode, *compdate,*comptime,*d_priority,
     *attr1,*attr2,*attr3,*attr4;
long int  heid, defectid, *defectcat,*error,responsible,seqid;
{ 
  /* ===================================================================== */
  char rtext[1001]                         /* Record text                  */
      ,descr[241]                          /* Repair description           */
      ,treatcode[5]                        /* Treatment Code               */
      ,actioncat[2]                        /* action category I/T/P        */
      ,s_defectcat[3]                      /* string defect catogory       */
      ,datedue[7]                          /* Repair due date as "YYMMDD"  */
      ,sup[2]                              /* Superceding defect indicator */
      ,ldatedue[7]                         /* The local date due of the cat*/
      ,d_use_working_days[2]               /* Use working days indicator   */
      ,d_use_next_insp[2]                  /* Use next inspection days     */
      ,d_interval_code[5]                  /* Repair interval code         */
      ,r_type[20]
      ,v_datedue[7]
      ,tmp_actioncat[2]
      ,tmp_msg[100]
      ;
  int rtype                                /* record type as char or EOF   */
     ,gethhrec()                           /* function to get row from     */
     ,noargs                               /* HH_batch_rows                */
     ,getargs()                            /* No of arguments in record    */
     ,priority=0                           /* Function to get respose days */
     ;                                     /* priority Amendment Set VI    */ 
  long int tim                             /* time as HHMM                 */
          ,timhrs                          /* time hours                   */
          ,timmins                         /* time minutes                 */
          ,error_code                      /* Returned error code value    */
          ,boq_items=0                     /* BOQ items counter            */
          ;                                /* must have been set with      */
                                           /* set activity days            */
  BOOLEAN status;                          /* TRUE if not serious errors   */
  BOOLEAN DATE_CHECK=FALSE;
  BOOLEAN TIME_CHECK=FALSE;
  /*=======================================================================*/

  *error = 0;
  rtype = gethhrec( '\0', 0, &seqid, rtext );

  if((rtype == EOF )||((rtype!='K') 
     &&(rtype!='L') 
     &&(rtype!='M')
     &&(rtype!='N')))
    {
    pushhhrec();
    *error = 8503;                          /* End of record found        */
    return( FALSE );
    }

  *treatcode   = '\0';                        /* Default the treatment code */
  actioncat[1] = '\0';                        /* Default the action category*/

  switch(rtype)
    {
    case 'K':
              noargs = getargs("sss",rtext,descr,compdate,comptime);
              if(noargs < 3)
                tim = 0;
              actioncat[0] = 'I'; 
              *defectcat = 1;
              break;
    case 'L':
              noargs = getargs("ssss",rtext,descr,compdate,comptime,treatcode);
              actioncat[0] = 'T'; 
              *defectcat = 1;
              break;
    case 'M':
              noargs = getargs("ssss",rtext,descr,compdate,comptime,treatcode);
              actioncat[0] = 'P'; 
              *defectcat = 1;
              break;
    case 'N': 
              noargs = getargs("ssd",rtext,descr,treatcode,&priority);
              switch(priority)
                {
                case 1  : 
                          *defectcat=21;
                          break;
                case 2  :
                          *defectcat=22;
                          break;
                case 3  :
                          *defectcat=23;
                          break;
                default :
                          *defectcat=1;
                          break;
                }
              *compdate = '\0';   /* Date NOT required for this record */
               *comptime = '\0';   /* Time NOT required for this record */ 
              tim       =   0 ;   /* Set time variable to 0            */
              actioncat[0] = 'P'; /* Permanent action category         */ 
              break;
    default :
              break;
    }
  /* ===========================================================================
   * The following code has been separated from its original position above.
   * All of the above values apply both to the standard product and to the 
   * Roadline 350 product. The following functions apply specifically to either
   * the standard product or to Roadline350.
   * ===========================================================================
   */ 
 
  /* ============================================================================
   * At this time we should validate both the action date and time.
   * With the Roadline 350 software the values of these may be padded with
   * zeros and may be fully padded and so we will have to cater for this in the
   * code.
   * ============================================================================
   */

  /* ============================================================================
   * Validate the completion date.
   * ============================================================================
   */

  if((strcmp(compdate,"000000")!=0)&&(compdate[0]!='\0')) /* Date not zero filled */
    {
    if(date_check(compdate)!=SUCCESS)       /* date_check function in r4util  */
      {
      pusherror(seqid,*error=8510);         /* Invalid action completion date */
      return(FALSE);
      }
    else 
      DATE_CHECK=TRUE;
    }
  else
    compdate[0]='\0';                        /* Terminate the completed date  */


  if((strcmp(comptime,"0000")!=0)&&(comptime[0]!='\0'))
    {
    if(time_check(comptime)!=SUCCESS)      /* time_check function in r4util  */
      {
      pusherror(seqid,*error=8511);        /* Invalid action completion time */
      return(FALSE);
      }
    else
      TIME_CHECK=TRUE;
    }

  /* 
   * If the repair date and time have been entered and they have been validated
   * then it should be safe to assume that the defect has undergone a repair.
   * This would usually happen in the case of an Immediate repair in which case
   * a BOOLEAN external variable should be set so that the value of this
   * external is picked up to set the defect status. If a defect has been
   * repaired then the defect status should be set to COMPLETED on inserting 
   * the defect into the DEFECTS table.
   *
   */

  if((DATE_CHECK) && (TIME_CHECK))
    {
    REPAIRCOMPLETE=TRUE;
    }
  else
    {
    REPAIRCOMPLETE=FALSE;
    }

  if(!ENHANCED)
    {
    switch (rtype)
      {
      /* K Record - Immediate Cat 1 Repair */
      case 'K': 
                if(set_due_date(seqid,inspdate,actcode,"1",actioncat
                               ,heid,&datedue,error) != TRUE)
                  return(FALSE);
                strcpy(ldatedue,datedue);
                strcpy(d_priority,"1");
                break;
      /* L Record - Temporary Cat 1 Repair */
      case 'L': 
                if(set_due_date(seqid,inspdate,actcode,"1",actioncat
                               ,heid,&datedue,error) != TRUE)
                  return(FALSE);
                strcpy(ldatedue,datedue);
                strcpy(d_priority,"1");
                l_exists = TRUE;
                break;
      /* M Record - Permanent Cat 1 Repair */
      case 'M':
                if((l_exists)||(!REPSETPERD))
                  {
                  if(set_due_date(seqid,inspdate,actcode,"1","P"
                                 ,heid,&datedue,error) != TRUE)
                    return(FALSE);
                  strcpy(ldatedue,datedue);
                  }
                else
                  {
                  if(set_due_date(seqid,inspdate,actcode,"1","T"
                                 ,heid,&datedue,error) != TRUE)
                    return(FALSE);
                  strcpy(ldatedue,datedue);
                  }
                l_exists = FALSE;
                strcpy(d_priority,"1");
                break;
      /* N Record - Permanent Cat 2 Repair */
      case 'N':
                if(set_due_date(seqid,inspdate,actcode,"2.3","P"
                                ,heid,&ldatedue,error) != TRUE)
                  return(FALSE);
                switch(priority)
                  {
                  case 1  :
                            strcpy(d_priority,"2.1");
                            break;
                  case 2  :
                            strcpy(d_priority,"2.2");
                            break;
                  default : 
                            strcpy(d_priority,"2.3");
                            break;
                  }
                if(set_due_date(seqid,inspdate,actcode,d_priority,"P"
                               ,heid,&datedue,error) != TRUE)
                  return(FALSE);
                break;
      }
    }
  else
    {                             /* ...... Roadline 350 start brace */
    /* The following is a server package which is part of the mai.pck
     * package. The package may return the following error codes :
     *      8213 : Unable to obtain interval code.
     *      8509 : Unable to locate defect priority interval record
     * if no error is located and the package is successful then the error
     * code returned will be zero and success will also be returned.
     */
    error_code=0;
    /*
    || Register the fact that a Priority 1 Temporary repair has been processed.
    */
    if((strncmp(d_priority,"1",1) == 0) && (strncmp(actioncat,"T",1) == 0))
      {
      l_exists = TRUE;
      }
    /*
    || If The Priority is 1, the repair is Permanent, no Temporary repair has
    || been processed and the product option REPSETPERD has been set then
    || calculate the Due Date as if the repair is Temporary.
    */
    if((strncmp(d_priority,"1",1) == 0) && (strncmp(actioncat,"P",1) == 0) && (!l_exists) && (REPSETPERD))
      {
      strcpy(tmp_actioncat,"T");
      l_exists = FALSE;
      }
    else
      {
      strcpy(tmp_actioncat,actioncat);
      }
    if(get_due_date(seqid            /* Error sequence id               */
                   ,inspdate         /* Inspection date                 */
                   ,actcode          /* Activity code                   */
                   ,d_priority       /* Priority code                   */
                   ,tmp_actioncat    /* Action category                 */
                   ,heid             /* Highways element                */
                   ,&datedue     
                   ,&error_code) != SUCCESS ) /* Target date         */
      {
      if(error_code > 0)
        {
        pusherror(seqid,*error=error_code); 
        return(FALSE);
        }
      else
        {
        pusherror(seqid,*error=8506); /* Repair target date cannot be */
        return(FALSE);
        }
      }                                  /* Obtained from defect priorities */
      strcpy(ldatedue,datedue);          /* Local due date defaulted to targ*/ 
    }
  /* ==========================================================================
   * At this point the action category is known and the program should now be
   * in a position to validate the defect code,action category, activity and
   * priority against the defect_priorities table 
   * ==========================================================================
   */ 

  sprintf(s_defectcat,"%d\0",*defectcat);

  timhrs = timmins = 0;                         /* Default the time values */

  /*
  || If The Complete Time From The File Is NULL But
  || The Complete Date Is Not NULL And The Priority
  || Is Not 1 Then Default Complete Time To 00:00.
  || This Is Done By Setting A Couple Of Boolean
  || Variables That Are Used Later During The Insert.
  */
  if((DATE_CHECK)&&(comptime[0]=='\0'))
    {
    if(strncmp(d_priority,"1",1) == 0)          /* Priority "1" */
      {
      pusherror(seqid,*error=8511);             /* Invalid completion time */
      return(FALSE);
      }
    else
      {
      TIME_CHECK=TRUE;
      REPAIRCOMPLETE=TRUE;
      }
    }


  if(atoi(comptime)>0) 
    {
    timhrs  = (atoi(comptime)/100);            /* Set repair hours value  */
    timmins = (atoi(comptime)%100);            /* Set repair mins value   */
    }

  if(*treatcode != '\0')                        /* If the treatment code is*/
    {                                              /* not equal to null.      */
    if(!chktcode(treatcode))                     /* Validate treatment      */
      {                                            
      pusherror(seqid,*error=8400);              /* Invalid treatment code  */
      return(FALSE);
      }
    else
      /* ---------------------------------------------------------------------
      ||If the treatment code has not been specified and if getdeftcode is
      ||executed and fails then the program should NOT raise an error since
      ||getdeftcode is used to return DEFAULT treatment codes. If default
      ||treatment codes have not been defined then processing should continue
      ||without an error.
      ||---------------------------------------------------------------------
      */ 
      if((strcmp(treatcode,"/") == 0)&&(romsec()== TRUE))
        { 
        if(getdeftcode(treatcode               /* Obtain default treatment*/
                      ,defcode                 /* Defect code             */
                      ,d_priority              /* Defect priority         */
                      ,actcode) == FALSE)      /* Defect activity code    */
          {
          strcpy(treatcode,"/");
          error_code=0;     
          }
        }
    }

  sup[0] = supflag;
  sup[1] = '\0';
  actioncat[1] = '\0';                 

  if(validate_defect_priority(actcode
                             ,actioncat
                             ,d_priority
                             ,d_interval_code
                             ,d_use_working_days
                             ,d_use_next_insp) != SUCCESS )
    {
    pusherror(seqid,*error=8305);/* Invalid Defect Priority combination */
    return(FALSE);
    }

  if(EXDebug && ( K_REC || L_REC || M_REC || N_REC ))
    {
    switch (rtype)
      {
      case 'K':
                strcpy(r_type,"Immediate");
                boq_items=-1;
                break;
      case 'L':
                strcpy(r_type,"Temporary");
                break;
      case 'M':
      case 'N':
                strcpy(r_type,"Permanent");
                break;
      } 
    }  

  /* ===========================================================================
   * Repair records are processed within this file. For each repair record there
   * may be one or more standard items listed. This next section should obtain
   * and process all standard item records for the current repair.
   * ===========================================================================
   */
  do{                                /* For each job item record.     */ 
    status=proqrec(error,heid,seqid,defectid,actioncat); 
    boq_items++;
    } while (( *error != 8504 ) && (TRUE));
  
  if (*error==8504) *error=0;

  if(EXDebug && ( K_REC || L_REC || M_REC || N_REC ))
    {
    puts("=============================================");
    puts("r4prep.c - prorepair - Defect Action Details");
    puts("=============================================");
    printf("Record type : %c - %s\n",rtype,r_type);
    printf("Action Cat  : %s - %s\n",actioncat,r_type);
    printf("Action Text : %s\n",descr);
    printf("Due date    : %s\n",datedue);
    printf("Action Time : %d\n",tim);
    printf("Time Hours  : %d\n",timhrs); 
    printf("Time Mins   : %d\n",timmins);
    printf("Treatment   : %s\n",treatcode);
    printf("Defect Cat  : %s\n",defectcat);
    printf("Target date : %s\n",datedue);
    printf("ldatedue    : %s\n",ldatedue);
    }

  status = putrepair(actioncat,actcode,datedue,ldatedue,sup,compdate,defcode
                    ,descr,treatcode,heid,timhrs,timmins,defectid,responsible
                    ,attr1,attr2,attr3,attr4,seqid,boq_items);

  return(status);
}

BOOLEAN set_due_date(seqid, inspdate, actcode, prty, actioncat, heid, datedue
       ,error)
long int seqid, heid, *error;
char *inspdate, *actcode, *prty, actioncat[2], datedue[7];
{

   long int error_code = 0;

   if (get_due_date( seqid          /* Error sequence id      */
                    ,inspdate       /* Inspection date        */
                    ,actcode        /* Activity code          */
                    ,prty           /* Priority code          */
                    ,actioncat      /* Action category        */
                    ,heid           /* Highways element       */
                    ,datedue     
                    ,&error_code) != SUCCESS ) 
   {
      if ( error_code > 0 )
      {
         pusherror(seqid,*error=error_code); 
         return(FALSE);
      }
      else
      {
         pusherror(seqid,*error=8506);
         return(FALSE);
      }
   }
   else
   {
      return(TRUE);
   }
}
