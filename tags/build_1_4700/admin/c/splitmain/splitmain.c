/* SCCS ID keyword, do not remove */
/* @(#)splitmain.c	1.1 12/15/06 */


#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include "utils.h"

const long MAX_C_RECS = 9000;
long user_max_c_recs;

FILE *in_inv_data, *out_inv_data;

int check_total_crecs(FILE *, char *);
int make_z_rec (char * z_rec, char *z_fields[10], 
            int numof_z_fields, long b_recs, long c_recs);

main (int argc, char *  argv[]) {

   char in_rec[2000];
   char a_rec[100];
   char z_rec[100];
   char temp_rec[2000];
   char out_name[254];
   char out_ext[100];
   char out_fname[254];
   int of_seq = 0;

   char * inv_fname[2];
   char * fields[100];
   char * z_fields[10];

   int numof_fields;
   int numof_z_fields;
   int f = 0;

   long b_recs = 0;
   long c_recs = 0;

   if (argc < 2) {
      printf("Usage: splitmain <filename> <Max C recs>\n");
      exit(3);
   }

   /* Set The Max Number Of C Records */
   /* Each Output File Should Contain */
   if(argc==3)
     {
     user_max_c_recs = atoi(argv[2]);
     }
   else
     {
     user_max_c_recs = MAX_C_RECS;
     }

   /* open input file */
   in_inv_data = open_input_file(argv[1], in_inv_data);

   /* check that the input file does indeed need splitting first */
   if (check_total_crecs(in_inv_data, z_rec)==0) {
      close_file(in_inv_data);
      printf("Input file does not require splitting\n");
      exit(1);
   }

   /* split the Z record into its components */
   chomp(z_rec);
   remove_quotes(z_rec);
   numof_z_fields = split(z_fields, z_rec, ",");


   /* input file does need splitting, reopen input file */
   in_inv_data = open_input_file(argv[1], in_inv_data);

   /* first sequence number for the output file is 1 */
   of_seq = 1;

   /* split the filename into name and extension. */
   split(inv_fname, argv[1], ".");
   strcpy(out_name, inv_fname[0]);
   strcpy(out_ext, inv_fname[1]);

   /* construct the new output filename */
   sprintf(out_fname, "%s%02d.%s", out_name, of_seq, out_ext);

   /* open the first output file */
   out_inv_data = open_output_file(out_fname, out_inv_data);

   /* read and store the A record */
   fgets(in_rec, 2000, in_inv_data);
   strcpy(a_rec, in_rec);

   /* read through input file until eof encountered */
   while (!feof(in_inv_data)) {
      strcpy (temp_rec, in_rec);  /* copy to temporary storage to preserve original */
      chomp (temp_rec);
      remove_quotes(temp_rec);
      numof_fields = split(fields, temp_rec, ",");
      if (*fields[0]== 'B') {
         if (c_recs > user_max_c_recs) {
            make_z_rec(z_rec, z_fields, numof_z_fields, b_recs, c_recs);
            fprintf(out_inv_data, "%s\n", z_rec);
            close_file(out_inv_data);
            b_recs = 0;
            c_recs = 0;
            of_seq++;
            sprintf(out_fname, "%s%02d.%s", out_name, of_seq, out_ext);
            out_inv_data = open_output_file (out_fname, out_inv_data);
            fputs(a_rec, out_inv_data);
         }
         b_recs++;
      }

      if (*fields[0] == 'C') {
         c_recs++;
      }
      if (*fields[0] == 'Z') {
         make_z_rec(z_rec, z_fields, numof_z_fields, b_recs, c_recs);
         fprintf(out_inv_data, "%s\n", z_rec);
      }
      else {
         fputs(in_rec, out_inv_data);
      }
      
      /* release allocated memory */
      for (f=0; f < numof_fields; f++) {
         free(fields[f]);
      }

      fgets(in_rec, 2000, in_inv_data);
   }

   close_file(in_inv_data);
   close_file(out_inv_data);
   return 0;
}


/* checks to see if this file needs splitting
   and stores the Z record for later */
int check_total_crecs(FILE * h_file, char * z_record) {
   char in_rec[2000];
   long c_recs = 0;

   fgets(in_rec, 2000, h_file);
   while (!feof(in_inv_data)) {
      if (*(in_rec + 1) == 'C')
         c_recs++;
      else
      if (*(in_rec + 1) == 'Z')
         strcpy(z_record, in_rec);

      fgets(in_rec, 2000, h_file);
   }

   if (c_recs > 9999) {
      return 1;
   } else {
      return 0;
   }
}


/* reassemble the Z record */
int make_z_rec (char * z_rec, char *z_fields[10], 
            int numof_z_fields, long b_recs, long c_recs) {
   int i=0;
   sprintf(z_fields[1], "%4lu", b_recs);
   sprintf(z_fields[2], "%4lu", c_recs);
   strcpy(z_rec, "\"");
   strcat(z_rec, z_fields[0]);
   for (i=1; i < numof_z_fields; i++) {
      strcat(z_rec, ",");
      strcat(z_rec, z_fields[i]);
   }
   strcat(z_rec, "\"");
   return 0;
}
