# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2210.mk	1.1 09/16/03
#       Module Name      : mai2210.mk
#       Date into SCCS   : 03/09/16 19:25:05
#       Date fetched Out : 07/06/07 11:28:33
#       SCCS Version     : 1.1
# 
# ***********************************************************************
# 
# To make this module :
#   % make -f <mai2210.mk.mk>
# To make a production version of this module 
#   % make -f <mai2210.mk.mk> product 
# To make a debug version of this module 
#   % make -f <mai2210.mk.mk> debug 
# To remove intermediate files created by making the module :
#   % make -f <mai2210.mk.mk> remove 
# 
# 

PROC_FILES =  r7main.pc r7cha.pc r7rsd.pc r7util.pc jobrun.pc sqlerr.pc \
              dblogon.pc
C_FILES    =  r7rep.c catchsig.c unx_pipe.c
H_FILES    =  rmms.h sqlext.h
TARGET     =  mai2210 
PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk

