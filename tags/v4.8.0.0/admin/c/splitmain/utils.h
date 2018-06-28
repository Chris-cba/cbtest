/* SCCS ID keyword, do not remove */
/* @(#)utils.h	1.1 12/15/06 */
/* Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved. */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>

FILE * open_input_file(char *, FILE *);
FILE * open_output_file(char *, FILE *);
int close_file(FILE *);
char *chomp(char *);
int split(char *[100], char *, char *);
int remove_quotes(char *);
