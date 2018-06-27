CREATE OR REPLACE PACKAGE BODY inv AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //new_vm_latest/archives/mai/admin/pck/inv.pkb-arc   2.2   Jun 27 2018 13:06:30   Gaurav.Gaurkar  $
--       Module Name      : $Workfile:   inv.pkb  $
--       Date into SCCS   : $Date:   Jun 27 2018 13:06:30  $
--       Date fetched Out : $Modtime:   Jun 27 2018 10:54:14  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.1
--
--   	 The Inventory library package.
--   	 Author : Rob Coupe
--

-----------------------------------------------------------------------------
--   Copyright (c) 2018 Bentley Systems Incorporated. All rights reserved.
-----------------------------------------------------------------------------
--
--all global package variables here
--
   g_body_sccsid     CONSTANT  varchar2(2000) := '"$Revision:   2.2  $"';
--  g_body_sccsid is the SCCS ID for the package body
--
   g_package_name    CONSTANT  varchar2(30)   := 'inv';
--
--   Originally taken from sccsid = '@(#)inv.pck	1.4 12/21/99';
--
-----------------------------------------------------------------------------
--
FUNCTION get_version RETURN VARCHAR2 IS
BEGIN
  RETURN g_sccsid;
END;
--
--
FUNCTION get_body_version RETURN varchar2 IS
BEGIN
   RETURN g_body_sccsid;
END get_body_version;
--
-----------------------------------------------------------------------------
--
FUNCTION get_iit_id ( p_pk_id IN VARCHAR2 ) RETURN NUMBER IS
CURSOR c1 IS
  SELECT iit_item_id
  FROM inv_items_all
  WHERE iit_primary_key = p_pk_id;
retval inv_items_all.iit_item_id%TYPE;
BEGIN
  OPEN c1;
  FETCH c1 INTO retval;
  CLOSE c1;
  RETURN retval;
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_iit_pk ( p_item_id IN NUMBER ) RETURN VARCHAR2 IS
CURSOR c1 IS
  SELECT iit_primary_key
  FROM inv_items_all
  WHERE iit_item_id = p_item_id;
retval inv_items_all.iit_primary_key%TYPE;
BEGIN
  OPEN c1;
  FETCH c1 INTO retval;
  CLOSE c1;
  IF retval IS NULL THEN
    retval :=  'Asset '||to_char(p_item_id );
  END IF;
  RETURN retval;
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_ity_descr ( p_ity IN VARCHAR2) RETURN VARCHAR2 IS
CURSOR c1 is
  SELECT ity_descr
  FROM inv_item_types
  WHERE ity_inv_code = p_ity;

retval inv_item_types.ity_descr%TYPE;

BEGIN
  OPEN c1;
  FETCH c1 INTO retval;
  IF c1%NOTFOUND THEN
    raise_application_error ( -20001, 'Invalid Inventory Type');
  END IF;
  CLOSE c1;
  RETURN retval;
  END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_ity ( p_item_id  IN NUMBER ) RETURN VARCHAR2 IS
CURSOR c1 IS
  SELECT iit_ity_inv_code
  FROM inv_items_all WHERE iit_item_id = p_item_id ;

retval inv_item_types.ity_inv_code%TYPE;

BEGIN
  OPEN c1;
  FETCH c1 INTO retval;
  IF c1%NOTFOUND THEN
    NULL;
  END IF;
  CLOSE c1;
  RETURN retval;
  END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_item_details ( p_item_id  IN NUMBER ) RETURN VARCHAR2 IS
CURSOR c1 IS
  SELECT Initcap( get_ity_descr( iit_ity_inv_code ))||' - Asset '||iit_primary_key||
     'at '||to_char(iit_st_chain)
  FROM inv_items_all WHERE iit_item_id = p_item_id ;

retval VARCHAR2(2000);

BEGIN
  OPEN c1;
  FETCH c1 INTO retval;
  IF c1%NOTFOUND THEN
    NULL;
  END IF;
  CLOSE c1;
  RETURN retval;
  END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_xsp_offset_range( p_sys_flag IN VARCHAR2,
      			        p_scl_class IN VARCHAR2 ) RETURN NUMBER IS

/*
cursor c1 is
  select sum( xsr_offset )
  from xsp_restraints
  where xsr_scl_class = p_scl_class
  and xsr_ity_inv_code = '$$'
  and xsr_ity_sys_flag = p_sys_flag;
*/

CURSOR c1 IS
  SELECT sum( nwx_offset )
  FROM nm_xsp
  WHERE nwx_nsc_sub_class = p_scl_class
  --AND xsr_ity_inv_code = '$$'
  AND nwx_nw_type = p_sys_flag;

retval NUMBER;

BEGIN
  OPEN c1;
  FETCH c1 INTO retval;
  CLOSE c1;

  RETURN retval;

END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_xsp_descr( p_sys_flag IN VARCHAR2,
			 p_scl_class IN VARCHAR2,
			  p_x_sect_val IN VARCHAR2) RETURN VARCHAR2 IS
/*
cursor c1 is
   select xsr_descr
   from xsp_restraints
   where xsr_scl_class = p_scl_class
   and   xsr_ity_inv_code = '$$'
   and   xsr_ity_sys_flag = p_sys_flag
   and xsr_x_sect_value = p_x_sect_val;
*/

CURSOR c1 IS
   SELECT nwx_descr
   FROM  nm_xsp
   WHERE nwx_nsc_sub_class = p_scl_class
   AND   nwx_nw_type = p_sys_flag
   AND   nwx_x_sect = p_x_sect_val;

retval xsp_restraints.xsr_descr%TYPE;

BEGIN
  OPEN c1;
  FETCH c1 INTO retval;
  CLOSE c1;

  RETURN retval;

END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_pk_column_name ( p_sys_flag IN inv_item_types.ity_sys_flag%TYPE,
                               p_ity_inv_code IN inv_item_types.ity_inv_code%TYPE )
   RETURN VARCHAR2 IS

  CURSOR c1 IS
    SELECT ita_view_col_name
    FROM inv_type_attribs
    WHERE ita_attrib_name = 'IIT_PRIMARY_KEY'
    AND  ita_ity_sys_flag = p_sys_flag
    AND  ita_iit_inv_code = p_ity_inv_code;

  retval inv_type_attribs.ita_view_col_name%TYPE;
  c1found BOOLEAN;

  BEGIN
    OPEN c1;
    FETCH c1 INTO retval;
    c1found := c1%FOUND;
    CLOSE c1;
    IF c1found THEN
      RETURN retval;
    ELSE
      raise_application_error(-20001, 'Column mapping does not exist');
    END IF;
  END;
--
-----------------------------------------------------------------------------
--
FUNCTION ity_exists( p_ity in inv_item_types.ity_inv_code%TYPE ) RETURN BOOLEAN IS
CURSOR c1 IS
  SELECT 'x' FROM inv_item_types
  WHERE ity_inv_code = p_ity;
dummy VARCHAR2(1);
retval BOOLEAN;
BEGIN
  OPEN c1;
  FETCH c1 INTO dummy;
  retval := c1%FOUND;
  CLOSE c1;
  RETURN retval;
END;
--
-----------------------------------------------------------------------------
--
PROCEDURE pop_inv_colours IS

resource_busy EXCEPTION;
PRAGMA exception_init( resource_busy, -54 );

BEGIN

  LOCK TABLE inv_type_colours IN EXCLUSIVE MODE NOWAIT;

  DELETE FROM inv_type_colours;

  INSERT INTO inv_type_colours
  ( col_id, ity_inv_code )
  SELECT rownum, ity_inv_code
  FROM inv_item_types;

EXCEPTION
  WHEN resource_busy THEN
    raise_application_error( -20001, 'Colour Map is being used, try again later ');
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_last_mp_rse( p_ity IN VARCHAR2,
			   p_rse_he_id IN NUMBER,
			    p_chain IN NUMBER ) RETURN NUMBER IS

  CURSOR c1( c_rse_he_id NUMBER, c_chain NUMBER, c_ity VARCHAR2 ) IS
    SELECT iit_st_chain, iit_item_id
    FROM inv_items_all
    WHERE c_rse_he_id = iit_rse_he_id
    AND iit_ity_inv_code = c_ity
    AND iit_st_chain <= c_chain
    ORDER BY iit_st_chain desc;

  l_rse_he_id NUMBER;
  l_chain     NUMBER;
  l_item_id   NUMBER;

BEGIN
  OPEN c1( p_rse_he_id, p_chain, p_ity);
  FETCH c1 INTO l_chain, l_item_id;
  IF c1%NOTFOUND THEN
    l_item_id := -1;
  END IF;
  CLOSE c1;
  RETURN l_item_id;
END;
--
-----------------------------------------------------------------------------
--
FUNCTION get_last_mp( p_ity IN VARCHAR2,
		       p_route IN NUMBER,
		        p_rse_he_id IN NUMBER,
		         p_chain IN NUMBER )
RETURN NUMBER IS

  CURSOR c1( c_rse_he_id NUMBER ) IS
    SELECT rse_he_id
    FROM  road_segs, road_seg_membs_all
    WHERE rse_pus_node_id_end = nm3net.get_start_node( c_rse_he_id )
    AND rse_he_id = rsm_rse_he_id_of
    AND rsm_rse_he_id_in = p_route;

  n_rse_he_id NUMBER;
  l_chain     NUMBER;
  retval      NUMBER;
  l_rse_he_id NUMBER := p_rse_he_id;
  l_offset    NUMBER := p_chain;
  l_item_id   NUMBER := -1;

  l_ctr NUMBER := 0;
BEGIN
DBMS_OUTPUT.PUT_LINE( 'Start of loop');
  WHILE l_item_id = -1 LOOP
    l_ctr := l_ctr + 1;
    IF l_ctr > 20 THEN
      EXIT;
    END IF;

--   First get the MP on the current section at a chainage less than that supplied

     l_item_id := get_last_mp_rse( p_ity, l_rse_he_id, l_offset );
     retval := l_item_id;
DBMS_OUTPUT.PUT_LINE('Found '||to_char(retval));
     IF l_item_id = -1 THEN

--     If no MP found then go back over all the connected sections, searching for the last one */

       OPEN c1( l_rse_he_id );
       n_rse_he_id := l_rse_he_id;
       FETCH c1 INTO l_rse_he_id;
       IF c1%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE('Not found a new section');
         retval := -1;
-- := get_section_offset( p_route, n_rse_he_id);
         CLOSE c1;
         EXIT;
       ELSE
         l_offset := 999999;
DBMS_OUTPUT.PUT_LINE('Found a new section'||to_char(l_rse_he_id));

         CLOSE c1;
       END IF;
     END IF;

   END LOOP;

   RETURN retval;
END;

--
-----------------------------------------------------------------------------
--
FUNCTION get_mp_offset( p_iit IN NUMBER,
			 p_route IN NUMBER,
                          p_rse_he_id IN NUMBER,
                           p_chain IN NUMBER ) RETURN NUMBER IS

CURSOR c1 IS
  SELECT rsm_route_begin_mp, iit_st_chain
  FROM road_seg_membs_all, inv_items_all
  WHERE rsm_rse_he_id_in = p_route
  AND   rsm_rse_he_id_of = iit_rse_he_id
  AND   iit_item_id = p_iit;

CURSOR c2 IS
  SELECT rsm_route_begin_mp
  FROM road_seg_membs_all
  WHERE rsm_rse_he_id_in = p_route
  AND rsm_rse_he_id_of = p_rse_he_id;

l_iit_offset NUMBER;
l_iit_chain  NUMBER;
l_rse_offset NUMBER;

l_gty  group_types.gty_group_type%TYPE := nm3net.get_ne_gty( p_route );
l_gty_unit units.un_unit_id%TYPE;

retval NUMBER;

BEGIN

  l_gty_unit := higunit.get_gty_units( l_gty );

  IF p_iit > 0 THEN
    OPEN c1;
    FETCH c1 INTO l_iit_offset, l_iit_chain;
    CLOSE c1;

    OPEN c2;
    FETCH c2 INTO l_rse_offset;
    CLOSE c2;

    l_rse_offset := l_rse_offset - l_iit_offset;

    IF l_gty_unit != 1 THEN
       l_rse_offset := higunit.convert_unit( l_gty_unit, 1, l_rse_offset);
    END IF;

    retval := l_rse_offset - l_iit_chain + p_chain;

  ELSE
    IF l_gty_unit != 1 THEN
    --  retval := higunit.convert_unit( l_gty_unit, 1, offsets.get_section_offset( p_route, p_rse_he_id )) + p_chain;
    retval := higunit.convert_unit( l_gty_unit, 1, nm3lrs.get_element_offset( p_route, p_rse_he_id )) + p_chain;
    ELSE
     -- retval := offsets.get_section_offset( p_route, p_rse_he_id ) + p_chain;
     retval := nm3lrs.get_element_offset( p_route, p_rse_he_id ) + p_chain;
    END IF;
  END IF;

  RETURN retval;
END;
--
-----------------------------------------------------------------------------
--
END;
/
