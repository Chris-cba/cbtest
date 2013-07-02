# ***********************************************************************
#  ------------------------------- Comment ------------------------------
#  SCCS Identifiers :-
#       sccsid           : @(#)mai2200d.mk	1.1 09/08/03
#       Module Name      : mai2200d.mk
#       Date into SCCS   : 03/09/08 17:38:31
#       Date fetched Out : 07/06/07 11:28:02
#       SCCS Version     : 1.1
#
#   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
#
# ***********************************************************************
# 
# To make this module :
#   % make -f <mai2200d.mk.mk>
# To make a production version of this module 
#   % make -f <mai2200d.mk.mk> product 
# To make a debug version of this module 
#   % make -f <mai2200d.mk.mk> debug 
# To remove intermediate files created by making the module :
#   % make -f <mai2200d.mk.mk> remove 
# 
# 
# The list of Pro*C files for the module.
PROC_FILES =  r4util.pc r4hhrows.pc r4psect.pc r4puterr.pc r4prog.pc       \
              r4proh.pc r4putrep.pc r4gdef.pc  r4gnxid.pc      \
              r4gbatid.pc r4rsd.pc r4prepare.pc r4prorrec.pc r4prosrec.pc  \
              r4proqrec.pc r4main.pc jobrun.pc sqlerr.pc dblogon.pc

# The list of C files for the module, do not list files already in PROC_FILES.
C_FILES    = r4gloc.c r4pdef.c r4ploc.c r4prop.c r4pinsp.c \
             r4prep.c catchsig.c unx_pipe.c

# The list of H files for the module. Normally rmms.h.
H_FILES    =  rmms.h defects.h deftypes.h repairs.h sqlext.h

# The name of the target ie. the executable module name.
TARGET     =  mai2200d

PL_SQL     =  full

include ${PROD_HOME}/lib/proc_std.mk

