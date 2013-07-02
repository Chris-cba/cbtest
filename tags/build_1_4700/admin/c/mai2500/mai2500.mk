# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2500.mk	1.1 09/16/03
#       Module Name      : mai2500.mk
#       Date into SCCS   : 03/09/16 19:27:37
#       Date fetched Out : 07/06/07 11:30:23
#       SCCS Version     : 1.1
#
# Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved. 
#
# ***********************************************************************
# 
#   % make -f <makefile> <module> [USERID=<user>/<pass>] 
# To remove intermediate files created by making the module :
#   % make -f <makefile> clean_<module>
# 


PROC_FILES =  r5main.pc r5util.pc r5inv.pc r5hea.pc r5dom.pc r5cha.pc r5att.pc \
              jobrun.pc sqlerr.pc dblogon.pc
C_FILES    =  r5rep.c catchsig.c unx_pipe.c
H_FILES    =  rmms.h sqlext.h
TARGET     =  mai2500
PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk

