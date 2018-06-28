# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2110c.mk	1.1 09/08/03
#       Module Name      : mai2110c.mk
#       Date into SCCS   : 03/09/08 17:35:29
#       Date fetched Out : 07/06/07 11:27:00
#       SCCS Version     : 1.1# 
#
#  Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
#
# ***********************************************************************
# 
# To make this module :
#   % make -f <mai2110c.mk.mk>
#   If Module includes PL SQL
#   % make -f <mai2110c.mk.mk> [USERID=<user>/<pass>] 
# To make a production version of this module 
#   % make -f <mai2110c.mk.mk> product 
# To make a debug version of this module 
#   % make -f <mai2110c.mk.mk> debug 
# To remove intermediate files created by making the module :
#   % make -f <mai2110c.mk.mk> remove 
# 
# 

PROC_FILES = r2mainx.pc r2mainy.pc jobrun.pc sqlerr.pc dblogon.pc
C_FILES    =  catchsig.c unx_pipe.c
H_FILES    =  rmms.h sqlext.h
TARGET     =  mai2110c
PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk

