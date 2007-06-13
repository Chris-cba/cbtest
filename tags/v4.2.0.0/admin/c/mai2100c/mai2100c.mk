# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2100c.mk	1.1 09/08/03
#       Module Name      : mai2100c.mk
#       Date into SCCS   : 03/09/08 17:33:56
#       Date fetched Out : 07/06/07 11:25:10
#       SCCS Version     : 1.1# 
# 
# ***********************************************************************
# 
# To make this module :
#   % make -f <mai2100c.mk.mk>
#   If Module includes PL SQL
#   % make -f <mai2100c.mk.mk> [USERID=<user>/<pass>] 
# To make a production version of this module 
#   % make -f <mai2100c.mk.mk> product 
# To make a debug version of this module 
#   % make -f <mai2100c.mk.mk> debug 
# To remove intermediate files created by making the module :
#   % make -f <mai2100c.mk.mk> remove 
# 
# 

PROC_FILES =  r1load.pc r1main.pc r1util.pc jobrun.pc sqlerr.pc dblogon.pc
C_FILES    =  catchsig.c unx_pipe.c
H_FILES    =  rmms.h r1forerr.h r1val2b.h r1val3b.h r1validb.h \
              r1validc.h r1validz.h sqlext.h
TARGET     =  mai2100c
PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk

