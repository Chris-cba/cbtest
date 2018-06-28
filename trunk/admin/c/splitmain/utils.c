/* SCCS ID keyword, do not remove */
/* @(#)utils.c	1.1 12/15/06 */
/* Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved. */

#include "utils.h"

/* open file specified on the command line */
FILE * open_input_file(char * in_fname, FILE * in_file) {
   if ((in_file = fopen(in_fname, "rt"))
         == NULL) {
      printf("Cannot open file: %s\n", in_fname);
      exit(200);
   }
   return in_file;
}

/* open output file */
FILE * open_output_file(char * in_fname, FILE * hFile) {
   if ((hFile = fopen(in_fname, "wt"))
         == NULL) {
      printf("Cannot create file: %s\n", in_fname);
      exit(201);
   }
   return hFile;
}

/* close opened file */
int close_file(FILE * hFile) {
   fclose (hFile);
   return 0;
}


/* remove the eol character from the string */
char * chomp(char * sLine) {
   int l = strlen(sLine);
   *(sLine + l - 1) = '\0';
   return sLine;
}


/* remove the double quote at the beginning and end of line */
int remove_quotes(char * sLine) {
   int l = strlen(sLine);
   char t[2000];
   char * s = sLine;
   char * e = sLine;
   e += (l - 1);

   if ((*s == '\"') && (*e == '\"')) {
      strncpy(t, ++s, l - 2);
      t[l-2] = '\0';
      strcpy(sLine, t);
      return 0;
   }
   return 0;
}

/* split the line into tokens and put into
   an array.  Function returns number of tokens parsed */
int split(char *f[100], char * sline, char * sDelimiter) {
   char temp_line[2000];
   int i=0;
   char * t;

   strcpy(temp_line, sline);
   t = strtok(temp_line, sDelimiter);
   while (t != NULL ) {
      if ((f[i] = malloc(strlen(t) + 1)) == NULL) {
         printf("utils.c: Cannot allocate memory\n");
         exit(100);
      }
      strcpy(f[i], t);
      i++;
      if (i > 99) {
         return i;
      }
      t = strtok(NULL, ",");
   }
   return i;
}

