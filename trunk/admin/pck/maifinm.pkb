CREATE OR REPLACE package body maifinm AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/maifinm.pkb-arc   2.2   Jun 27 2018 13:06:38   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   maifinm.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:38  $
--       Date fetched Out : $Modtime:   Jun 27 2018 11:31:12  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)maifinm.pck	1.1 06/17/99'
-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
g_body_sccsid  CONSTANT varchar2(2000) :='"$Revision:   2.2  $"';

-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN varchar2 IS
BEGIN
   RETURN g_sccsid;
END get_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--

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
