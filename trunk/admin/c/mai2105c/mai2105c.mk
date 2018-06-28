# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2105c.mk	1.1 09/16/03
#       Module Name      : mai2105c.mk
#       Date into SCCS   : 03/09/16 19:24:28
#       Date fetched Out : 07/06/07 11:26:30
#       SCCS Version     : 1.1
# 
#      Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
#
# ***********************************************************************
# 
# To make this module :
#   % make -f <mai2105.mk>
#   If Module includes PL SQL
#   % make -f <mai2105.mk> [USERID=<user>/<pass>] 
# To make a production version of this module 
#   % make -f <mai2105.mk> product 
# To make a debug version of this module 
#   % make -f <mai2105.mk> debug 
# To remove intermediate files created by making the module :
#   % make -f <mai2105> remove 
# 
# 
# redefine/add to PROFLAGS for this module
# 

PROC_FILES =  mai2105.pc jobrun.pc sqlerr.pc dblogon.pc
C_FILES    =  catchsig.c unx_pipe.c
H_FILES    =  rmms.h sqlext.h
TARGET     =  mai2105c
PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk

