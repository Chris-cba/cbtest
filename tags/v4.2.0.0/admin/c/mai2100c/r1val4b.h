/*=================================================================*/
/* r1val4b.h                                                       */
/*=================================================================*/
/* SCCS ID keywords, do not remove                                 */
/* "@(#)r1val4b.h	1.1 05/20/04"                                  */
/*=================================================================*/
/* Contains functions to check HERMIS B records and to reformat    */
/* them to fit the ROMIS format expected by Stage 2.               */
/*                                                                 */
/*=================================================================*/

/*=================================================================*/
/* herm_b_validation                                               */
/*=================================================================*/
/* parameters passed : B type record text, sequence no.            */
/* return value      : BOOLEAN passed or failed.                   */
/* external action   : output to stdout appropriate error message. */
/*                     and line number . via global string err_msg.*/ 
/*                                                                 */
/* Validation performed :-                                         */
/*                                                                 */
/* number of fields     : 5                                        */
/* link                 : 10 alpha. No Agency Code so the first 4  */
/*                        characters should be spaces.             */
/*                        Next 6 characters are the Link Code, this*/
/*                        can be between 1 and 6 characters padded */
/*                        with trailing spaces.                    */
/* section              : Upto 5 numeric padded with leading spaces*/
/* date                 : YYMMDD                                   */
/* direction            : 1 apha domain (Y/N)                      */
/* inspectors  initials : Up to 3 alpha or Spaces                  */
/*=================================================================*/

BOOLEAN herm_b_validation(rtext,lineno)
  char *rtext;
  long int lineno;
{
  char text[200],*strs[10];
  int noargs;

  strcpy(text,rtext);

  if((noargs = getwstrs(text,strs)) != 5)
    {                           
    sprintf(err_msg,"ERROR: %d fields in B type record  BPR-8014"
                   ,(noargs + 1));
    format_err(lineno,1);
    }    

  herm_linkvl(strs[0],lineno);            /* Check Link Code       */

  herm_sectvl(strs[1],lineno);            /* Check Section         */

  datevl(strs[2],lineno);                 /* Check Date            */

  /* HMDIF MOD
  if((strlen(strs[3]) > 1 )
     ||(strlen(strs[3]) < 1)
     ||((*strs[3] != 'Y') && (*strs[3] != 'N')))
    {
    strcpy(err_msg,"ERROR: Direction flag - does not equal (Y/N)  BPR-8015");
    format_err(lineno,1); 
    }   
  */

  inspvl(strs[4],lineno);                 /* Check Inspector       */

  return(TRUE);
} /* herm_b_validation */

/*=================================================================*/
/* herm_linkvl                                                     */
/*=================================================================*/
herm_linkvl(link,lineno)
  char *link;           
  long int lineno;
{ 
  int i;
  BOOLEAN err_found=FALSE;

  if(strlen(link) > 10)
    { 
    strcpy(err_msg,"ERROR: Link code format > 10 characters BPR-8016");
    format_err(lineno,1);
    }   

  if(strlen(link) < 10)
    { 
    strcpy(err_msg,"ERROR: Link code format < 10 characters BPR-8017");
    format_err(lineno,1);
    }   

  for(i=0;i<4;i++)
    {
    if(link[i] != ' ')
      err_found=TRUE;
    }

  if(err_found)
    {
    strcpy(err_msg,"ERROR: Link code format - Agency Code Is Not NULL BPR-XXXX");
    format_err(lineno,1);
    }

/*
  if(link[0] == ' ')
    {
    strcpy(err_msg,"ERROR: Link code format - Not left justified BPR-8018");
    format_err(lineno,1);
    }
*/
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

/*=================================================================*/
/* herm_sectvl                                                     */
/*=================================================================*/
herm_sectvl(section,lineno)
  char *section;           
  long int lineno;
{
  int i;
  
  if(strlen(section) > 5)
    {
    strcpy(err_msg,"ERROR: Section code format > 5 characters BPR-8020");
    format_err(lineno,1);
    }   
  
  
  if(strlen(section)  < 5)
    {
    strcpy(err_msg,"ERROR: Section code format < 5 characters BPR-8021");
    format_err(lineno,1);
    }   
  
  if(strcmp(ansectno_flag.arr,"Y") == 0)
    {
    for(i=0;i < strlen(section);++i)
      {
      if(isdigit(section[i])||isupper(section[i])||islower(section[i])||isspace(section[i]))
        { /* do nothing */ ;} 
      else 
        {
        strcpy(err_msg,"ERROR: Section code format - Invalid character BPR-8022");
        format_err(lineno,1);
        }      
      }
    }
  else
    {
    for(i=0;i < strlen(section);++i)
      {
      if (isdigit(section[i])||isspace(section[i]))
        { /* do nothing */ ;} 
      else 
        {
        strcpy(err_msg,"ERROR: Section code format - Invalid character BPR-8022");
        format_err(lineno,1);
        }      
      }
    }
  
  return(TRUE);                        
} /* herm_sectvl */
