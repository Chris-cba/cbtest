CREATE OR REPLACE package body maifinm AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/maifinm.pkb-arc   2.0   Jun 13 2007 17:36:52   smarshall  $
--       Module Name      : $Workfile:   maifinm.pkb  $
--       Date into SCCS   : $Date:   Jun 13 2007 17:36:52  $
--       Date fetched Out : $Modtime:   Jun 13 2007 17:36:22  $
--       SCCS Version     : $Revision:   2.0  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maifinm.pck	1.1 06/17/99'
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------
FUNCTION calc_discount(
           p_disc_group   in  contractor_disc_bands.cnb_cng_disc_group%TYPE
          ,p_cost         in  work_orders.wor_act_cost%TYPE)
   return number IS

begin

declare l_ret_val number;

   cursor c1 is
           select nvl(cnb_discount,0)
           from contractor_disc_bands
           where cnb_cng_disc_group = p_disc_group
           and p_cost between cnb_min_value and cnb_max_value;

begin
   open c1;

   fetch c1 into l_ret_val;

   if c1%NOTFOUND then
      null;
   end if;

   close c1;

   if l_ret_val is null
   then
      l_ret_val := 0;
   end if;

   return l_ret_val;

end;
end;

end maifinm;
/
