
/* SCCS ID keywords, do not remove */
/* static char *sccsid = "@(#)r4gloc.c	1.2 06/01/07"; */

/*PVCS keyword, do not remove */
static char *sccsid = "$Workfile:   r4gloc.c  $ $Revision:   2.0  $ $Modtime:   Jun 15 2007 14:39:14  $";

/* ===========================================================================
 * Program : getlocation.c
 *                          G E T L O C A T I O N
 *                          - - - - - - - - - - -
 * Purpose : To get the location information of the next 'I' record.
 *
 * Calling Sequence:
 *
 *       getlocation( heid,
 *                   actcode, xsec, &stchain, locn, &timehrs, &timemins,
 *                   identcode, &diagno, invcode, &error)
 *
 * Input :  int  heid      Current Highway element id
 *
 * Output:  char *actcode  activity code found. 2 character string.
 *
 *       char *xsec     X section found. 1 character string.
 *
 *       int  stchain   Start chainage.
 *
 *       char *locn     Location. Up to 40 characters.
 *
 *       int  timehrs   Time hours.
 *
 *       int  timemins  Time minutes.
 *
 *       char *identcode Idenetity code, upto 8 characters.
 *
 *       int  diagno    Diagram number.
 *
 *       char *invcode  Inventory code for diagram no. 2 characters
 *                      or zero length string.
 *
 *       int  error        0 = Go location info OK.
 *                      8501 = No 'I' record found.
 *                      8261 = Invalid defect location time.
 *                      8222 = Invalid x-section code.
 *                      8223 = Chainage out of range.
 *                      8224 = Invalid time.
 *                      8225 = Invalid inventory item mnemonic.
 *
 *  Notes:   NO CHECKS ON RECORD DONE AT MOMENT.
 *
 *  Author:  Alan Goddard 5 May 88
 *
 *  Changes: H.Buckley ( 11-12-1995 )
 *           The RLINE350 software has a different format of Defect Location
 *           record and this program will have to cater for both the standard
 *           inspections file layout and the roadline 350 file layout.
 *
 *  Changes: H.Buckley ( 27-06-1996 )
 *           For DOT purposes the SISS id must default to ALL if it is null
 *           and the SISS code should also be validated.
 *
 *  Changes: H.Buckley ( 5/5/2000 )
 *           This part of the program has been modified so that the program as a
 *           whole can load both Enhanced and Rline350 files. In the Enhanced
 *           file the inventory code has been added after the diagram number
 *           but the R350 version of the file does NOT have this field and so
 *           I have had to cater for this difference. The inventory code at this
 *           stage undergoes no validation.
 *============================================================================
*/

#include <stdio.h>                          /* Include standard i/o header   */
#include "rmms.h"                           /* Include standard highhways    */

extern BOOLEAN USE_CHAINAGE;                /* Chainage being used boolean   */
extern BOOLEAN DTP_ROAD;                    /* DTp Road type indicator       */
extern BOOLEAN DTP_CHAINAGE;                /* DTp Chainage required ind.    */
extern BOOLEAN LOCAL_CHAINAGE;              /* Local Chainage required ind.  */
extern BOOLEAN ENHANCED;                    /* Is the current file enhanced  */
extern short EXDebug;                       /* Debugging variable            */

/* ============================================================================
 * Function : getlocation()
 * Purpose  : To obtain location details for the negxt defect record.
 * ============================================================================
 */
BOOLEAN getlocation(long int heid
                   ,char *actcode           /* Activity code                 */
                   ,char *xsec              /* XSP                           */
                   ,long int *stchain       /* Start chainage                */
                   ,char *locn              /* Location                      */
                   ,long int *timehrs       /* Time in hours                 */
                   ,long int *timemins      /* Time in minutes               */
                   ,char *identcode         /* Identity code                 */
                   ,char *diagno            /* Diagram number                */
                   ,char *invcode           /* Inventory code                */
                   ,char *invind            /* Inventory indicator code      */
                   ,char *siss              /* Standard Item Sub-section code*/
                   ,long int *notifiable    /* Notifiable organisation       */
                   ,long int *recharge      /* Rechargeable organisation     */
                   ,char *special           /* Special instructions          */
                   ,char *description       /* Defect Description            */
                   ,long int *error         /* Errors                        */
                   ,long int *seqid         /* Loaded record sequence number */
                   ,char *inspdate          /* Inspection date               */
                   )
{
  int rectype,gethhrec(),noargs;
  long int tim, l_seqid;
  int recargs                               /* Number of arguments in record.*/
     ,novalue                               /* Dummy argument to code valid  */
  ;
  char rtext[1001]                          /* I record text buffer          */
      ,vtext[1001]                          /* Copy of I record text         */
      ,*strs[30]                            /* Pointers to record fields     */
      ,v_time[5]                            /* Time string variable          */
      ,v_notifiable[11]                     /* Nullify the notifiable var    */
      ,v_recharge[11]                       /* Nullify the rechargeable var  */
  ;

  *error = 0;
  l_seqid= *seqid;
  *(v_notifiable)='\0';                     /* Had to place the initiaization*/
  *(v_recharge)='\0';                       /* of these here for porting     */
                                            /* purposes.                     */
/* ============================================================================
 * Get defect record details.
 * ============================================================================
 */
  rectype = gethhrec( '\0', 0, &l_seqid, rtext );
  if(rectype != 'I')
    {
    *error = 8501;                                /* 8501 Invalid Defect      */
    pushhhrec();                                  /* Location (I) record type */
    return(FALSE);
    }

  *seqid= l_seqid;

  *identcode = '\0';
  *diagno = '\0';                                 /* Initialize diagram number*/
                                                  /* to a null value          */
  *special= '\0';
  *description='\0';
  strcpy(vtext,rtext);                            /* Make a copy of the rtext */
  recargs=getstrs(rtext,strs);                    /* Obtain number of fields  */
  strcpy(rtext,vtext);                            /* Reassign rtext           */

  if(ENHANCED)
    {
    noargs = getargs("ssdsssssssssss",rtext        /* Fields and args         */
                                     ,actcode      /* Activity code           */
                                     ,xsec         /* XSP                     */
                                     ,stchain      /* Start chainage(NULL)    */
                                     ,locn         /* Defect Location         */
                                     ,v_time       /* Time defect was found   */
                                     ,identcode    /* Identity Code field     */
                                     ,diagno       /* Diagram Number(Not Used)*/
                                     ,invcode      /* Inventory type          */
                                     ,invind       /* Inventory chainage ind. */
                                     ,siss         /* Standard Item Sub code  */
                                     ,v_notifiable /* Notifiable Code         */
                                     ,v_recharge   /* Rechargeable Code       */
                                     ,special      /* Special Instructions    */
                                     ,description  /* Defect Description      */
                                     );
    }
  else
    { /* Code for standard RMMS file */
    *siss='\0';
    *v_notifiable='\0';
    *v_recharge='\0';
    *special='\0';
    noargs = getargs("ssdsssssssssss",rtext        /* Fields and args         */
                                     ,actcode      /* Activity code           */
                                     ,xsec         /* XSP                     */
                                     ,stchain      /* Start chainage(NULL)    */
                                     ,locn         /* Defect Location         */
                                     ,v_time       /* Time defect was found   */
                                     ,identcode    /* Identity Code field     */
                                     ,diagno       /* Diagram Number(Not Used)*/
                                     ,invcode      /* Inventory type          */
                                     ,description  /* Defect Description      */
                                     );
    }
    *error = 0;

  /* =========================================================================
   * At this point certain validations should take place.
   * The values of the following codes should be validated :
   *
   * 1. Validate the time                         [ Both          ]
   * 2. Chainage indicator (Y/N)                  [ Rline350 only ]
   * 3. Validate the xsp                          [ Both          ]
   * 4. Standard Item Sub-System Code             [ Rline350 only ]
   * 5. Notifiable Organisation Code.             [ Rline350 only ]
   * 6. Rechargeable Organisation Code.           [ Rline350 only ]
   * 7. Validate the existance of XSP             [ Both          ]
   * 8. Validate the existance of Start Chainage  [ Both          ]
   * =========================================================================
   */

  if(time_check(v_time)!=SUCCESS)             /* Invalid defect location */
    {                                         /* time.                   */
    pusherror(*seqid,*error=8261 );
    return(FALSE);
    }

  tim=atol(v_time);                           /* Set the integer time value*/
  *timehrs = tim/100;                         /* Set the time in hours     */
  *timemins= tim%100;                         /* Set the time in minutes   */

  if(EXDebug && I_REC)
    {
    printf("Text         : %s\n\n",vtext);
    printf("Record Type  : %c\n"  ,rectype);
    printf("Actcode      : %s\n"  ,actcode);
    printf("Xsec         : %s\n"  ,xsec);
    printf("Stchain      : %d\n"  ,*stchain);
    printf("Locn         : %s\n"  ,locn);
    printf("Time String  : %-4s\n",v_time);
    printf("Timehrs      : %-2d\n",*timehrs);
    printf("Timemins     : %-2d\n",*timemins);
    printf("Identcode    : %s\n"  ,identcode);
    printf("Diagno       : %s\n"  ,diagno);
    printf("Invcode      : %s\n"  ,invcode);
    printf("Chainage Ind : %s\n"  ,invind);
    printf("SISS Id      : %s\n"  ,siss);
    printf("Special      : %s\n"  ,special);
    printf("Description  : %s\n"  ,description);
    }

  if(ENHANCED)
    if(is_yn(invind)!=SUCCESS)
      {
      strcpy(invind,"N");
      }

  /* =========================================================================
   * If the road type is either DTp/Local and the use chainage system option
   * flag has been set for the respective road type then check for a chainage
   * value.
   * =========================================================================
   */

 if(((DTP_ROAD) && (DTP_CHAINAGE)   && (*stchain<0)) ||
   ((!DTP_ROAD) && (LOCAL_CHAINAGE) && (*stchain<0)))
   {
   pusherror(*seqid,*error=8605);
   return(FALSE);
   }

  /* If Survey Has recorded chainage, then we might as well store it
     Therefore code below commented out
  if(((DTP_ROAD) && (!DTP_CHAINAGE)) ||
    ((!DTP_ROAD) && (!LOCAL_CHAINAGE)))
    *stchain='\0';
  */

  /* ============================================================================
   * In order to validate the standard item sub code the inspection date must
   * be included in the validation.
   * For DOT purposes if the SISS id is null then the SISS id should be amended
   * to be 'ALL'
   * ============================================================================
   */

  /* Here the DRD used to require that the SISS be defaulted to ALL if the
     SISS was NULL. I have been informed however that this is not a requirement
     and that this should now be removed.
  */
  if(*(siss)=='\0')         /* If the SISS id is null then change the     */
    strcpy(siss,"ALL");     /* SISS id to be ALL and then validate.       */

  if(*(siss)!='\0')         /* If there is a code to validate             */
    {
    if(validate_code(3,siss,&novalue)!=SUCCESS)
      {
      pusherror(*seqid,*error=8263);         /* Invalid sub-section item  */
      return(FALSE);                         /* code.                     */
      }
    }

  /* ============================================================================
   * The validation of the Notifiable and Rechargeable organisations should
   * return the organisational id of the organisations. This org id will be
   * inserted into the defect record.
   * ============================================================================
   */
  if(*(v_notifiable)!='\0')
    if(validate_code(1,v_notifiable,notifiable)!=SUCCESS)
      {
      pusherror(*seqid,*error=8264);         /* Invalid notifiable        */
      return(FALSE);                         /* orgainsation code.        */
      }

  if(*(v_recharge)!='\0')
    if(validate_code(2,v_recharge,recharge)!=SUCCESS)
      {
      pusherror(*seqid,*error=8265);         /* Invalid rechargeable      */
      return(FALSE);                         /* organisation code.        */
      }

  *stchain = get_chain(*stchain);            /* Obtain start chainage     */

  if(*stchain == -1)                         /* Check start chainage null */
    {
    pusherror(*seqid,*error=8260 );          /* Chainage on I record      */
    return(FALSE);                           /* exceeds required chainage */
    }                                        /* for section.              */
  else
    recalibrate(stchain,seqid);              /* Perform recalibration     */
 
  return(TRUE);
}
