--
--------------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/install/mai_4400_fix5.sql-arc   3.2   Jul 01 2013 16:01:52   James.Wadsworth  $
--       Module Name      : $Workfile:   mai_4400_fix5.sql  $
--       Date into PVCS   : $Date:   Jul 01 2013 16:01:52  $
--       Date fetched Out : $Modtime:   Jul 01 2013 14:32:42  $
--       PVCS Version     : $Revision:   3.2  $
--
--------------------------------------------------------------------------------
--   Copyright (c) 2013 Bentley Systems Incorporated. All rights reserved.
--------------------------------------------------------------------------------
--
set echo off
set linesize 120
set heading off
set feedback off
--
-- Grab date/time to append to log file name
--
undefine log_extension
col      log_extension new_value log_extension noprint
set term off
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS')||'.LOG' log_extension from dual
/
set term on
--
--------------------------------------------------------------------------------
--
--
-- Spool to Logfile
--
define logfile1='mai_4400_fix5_&log_extension'
spool &logfile1
--
--------------------------------------------------------------------------------
--
select 'Fix Date ' || to_char(sysdate, 'DD-MON-YYYY HH24:MI:SS') from dual;

SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
--
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET','MAI');

WHENEVER SQLERROR EXIT

BEGIN
  --
  -- Check that the user isn't sys or system
  --
  IF USER IN ('SYS','SYSTEM')
  THEN
    RAISE_APPLICATION_ERROR(-20000,'You cannot install this product as ' || USER);
  END IF;

  --
  -- Check that MAI has been installed @ v4.4.0.0
  --
  hig2.product_exists_at_version (p_product        => 'MAI'
                                 ,p_VERSION        => '4.4.0.0'
                                 );

END;
/

-- Check that mai 4400 fix 1,2,3,4 has been applied before proceeeding (2 not released yet)
Declare
   Cursor c_mai_4400_fix5 Is 
   Select 'Y'
   From Dual
   Where (Exists (Select 1 From hig_upgrades Where remarks = 'MAI 4400 FIX 2')
   And 4 = (Select count (distinct remarks) 
            From hig_upgrades
            Where remarks In('MAI 4400 FIX 1','MAI 4400 FIX 2','MAI 4400 FIX 3','MAI 4400 FIX 4')
           ))
   Or (Not Exists (Select 1 From hig_upgrades Where remarks = 'MAI 4400 FIX 2')
   And 3 = (Select count (distinct remarks) 
           From hig_upgrades
           Where remarks In('MAI 4400 FIX 1','MAI 4400 FIX 3','MAI 4400 FIX 4')
          ));
   --
   l_mai_4400_fix5 Varchar2(1) := 'N';
Begin
   Open c_mai_4400_fix5;
   Fetch c_mai_4400_fix5 Into l_mai_4400_fix5;
   Close c_mai_4400_fix5;
   --
   If Not l_mai_4400_fix5 = 'Y'
   Then
     RAISE_APPLICATION_ERROR(-20000,'This fix is dependent upon Maintenance Manager 4400 FIX 1, 3 and 4 being applied. Please apply prior fixes before proceeding.');
   End If;
End;
/

WHENEVER SQLERROR CONTINUE
--
--
--------------------------------------------------------------------------------
-- Package Headers
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_cyclic_wo.pkh
SET TERM OFF
--
SET FEEDBACK ON
start mai_cyclic_wo.pkh
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Package Bodies
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai.pkw
SET FEEDBACK OFF
--
--
SET TERM ON 
PROMPT mai_cyclic_wo.pkw
SET TERM OFF
--
SET FEEDBACK ON
start mai_cyclic_wo.pkw
SET FEEDBACK OFF
--
--------------------------------------------------------------------------------
-- Views
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT mai_transviews.sql
SET TERM OFF
--
SET FEEDBACK ON
start mai_transviews.sql
SET FEEDBACK OFF
--
--
--------------------------------------------------------------------------------
-- Recompile invalid objects
--------------------------------------------------------------------------------
--
--
SET TERM ON 
PROMPT Recompile invalid objects
SET TERM OFF
--
Spool recompile.sql

Select 'alter '||object_type||' '||object_name||' compile;'
From user_objects
Where status <> 'VALID'
And object_type IN ('VIEW','SYNONYM','PROCEDURE','FUNCTION','PACKAGE','TRIGGER');

Spool off
@recompile.sql
--
Spool recomp_body.sql

Select 'alter '||replace(object_type, ' BODY', '')||' '||object_name||' compile body;'
From user_objects
Where status <> 'VALID'
And object_type IN ('PACKAGE BODY','TYPE BODY');

Spool off
@recomp_body.sql
--
--------------------------------------------------------------------------------
-- Update hig_upgrades with fix ID
--------------------------------------------------------------------------------
--
SET TERM ON 
PROMPT log_mai_4400_fix5.sql 
--
SET FEEDBACK ON
start log_mai_4400_fix5.sql
SET FEEDBACK OFF
SPOOL OFF
EXIT
--
--
