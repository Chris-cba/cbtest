
# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2220.mk	1.1 09/16/03
#       Module Name      : mai2220.mk
#       Date into SCCS   : 03/09/16 19:25:48
#       Date fetched Out : 07/06/07 11:29:01
#       SCCS Version     : 1.1
#
# ***********************************************************************
#
# To make this module :
#   % make -f <makefile> <module> [USERID=<user>/<pass>]
#

PROC_FILES =  mai2220.pc jobrun.pc sqlerr.pc dblogon.pc
C_FILES    =  catchsig.c unx_pipe.c
H_FILES    =  rmms.h sqlext.h
TARGET     =  mai2220 
PL_SQL     =  full 

include ${PROD_HOME}/lib/proc_std.mk


