# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2200c.mk	1.1 09/08/03
#       Module Name      : mai2200c.mk
#       Date into SCCS   : 03/09/08 17:37:13
#       Date fetched Out : 07/06/07 11:27:33
#       SCCS Version     : 1.1# 
#
#   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
#  
# ***********************************************************************
# 
# To make this module :
#   % make -f <mai2200c.mk.mk>
#   If Module includes PL SQL
#   % make -f <mai2200c.mk.mk> [USERID=<user>/<pass>] 
# To make a production version of this module 
#   % make -f <mai2200c.mk.mk> product 
# To make a debug version of this module 
#   % make -f <mai2200c.mk.mk> debug 
# To remove intermediate files created by making the module :
#   % make -f <mai2200c.mk.mk> remove 
# 
# 

PROC_FILES =  r3main.pc r3util.pc r3gbatid.pc r3pbatr.pc r3prec.pc r3phfile.pc \
              jobrun.pc sqlerr.pc dblogon.pc
C_FILES    =  r3errout.c r3chkrec.c catchsig.c unx_pipe.c
H_FILES    =  rmms.h sqlext.h
TARGET     =  mai2200c
PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk
