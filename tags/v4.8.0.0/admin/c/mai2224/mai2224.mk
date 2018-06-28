
# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2224.mk	1.1 09/16/03
#       Module Name      : mai2224.mk
#       Date into SCCS   : 03/09/16 19:27:06
#       Date fetched Out : 07/06/07 11:29:54
#       SCCS Version     : 1.1
#
# Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved. */
#
# ***********************************************************************
#
# To make this module :
#   % make -f <makefile> <module> [USERID=<user>/<pass>]

PROC_FILES =  mai2224.pc dblogon.pc jobrun.pc sqlerr.pc
C_FILES    =  catchsig.c unx_pipe.c
H_FILES    =  rmms.h sqlext.h
TARGET     =  mai2224 
PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk


