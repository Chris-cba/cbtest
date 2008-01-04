-----------------------------------------------------------------------------
--
--   SCCS Identifiers :-
--
--       sccsid           : @(#)mai9010.sql	1.1 09/24/03
--       Module Name      : mai9010.sql
--       Date into SCCS   : 03/09/24 11:56:30
--       Date fetched Out : 07/06/07 11:18:30
--       SCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--    APPLICATION     : MM                             
--    MODULE ID       : MAI9010.SQL                                    
--    NAME            : Detect Inventory Gap\Overlap
--    AUTHOR          : C.Hackforth	16/01/98
--                      Adapted to version of mai9010.sql
--                      in migration to v2.1 of MM   
--    TABLES and                                                        
--    VIEWS USED      : Road_Sections,
--				Inv_items, Inv_item_types                              
--
--    PURPOSE
--									    
--	This PL/SQL script finds all records in the road_segments_all       
--	table where the rse_type = 'S'. For each of these records, the      
--	inv_items_all table is checked to make sure that records exist 	    
--	which, when placed "end-to-end" based upon their begin and end	    
--	mile chainages, inclusively span the begin and end mile points of the  
--	corresponding road_segments_all record, with no gaps or overlaps.   
--	If a gap or overlap is detected anywhere, a record is inserted	    
--	into inv_mp_errors.						    
--									    
--
--    CALLING MODULES : GRI                                           
--                                                                      
--    MODULES CALLED  : None.                                           
--    COMMENTS        :                                                 
--                                                                      
--    MODIFICATIONS   :                                                 
--  -----------------------------------------------------------------------
-- 
-- 	GRI PARAMS      : ROAD_ID
--
--
--  SCCS ID Keyword, do no remove
define sccsid = '"@(#)mai9010.sql	1.1 09/24/03"';

SET FEEDBACK OFF;
SET VERIFY OFF;
SET TERM OFF;
SET HEADING OFF;

--SET FEEDBACK ON;
--SET VERIFY ON
--SET HEADING ON;
--SET TERM ON
set serveroutput on;

--spool mai9010.lis

col spool new_value spool ;

exec HIGGRIRP.write_gri_spool('&1','Working ...');

select higgrirp.get_module_spoolpath(&&1,user)||higgrirp.get_module_spoolfile(&&1) spool 
from dual;

spool &spool

delete from inv_mp_errors;

declare 
  p_rse_he_id road_sections.rse_he_id%type;
  p_start_chain inv_items.iit_st_chain%type;
  p_end_chain inv_items.iit_end_chain%type;
  i number;

	cursor c1 is
	select distinct rse.rse_he_id, rse.rse_length,rse.rse_unique, ity.ity_inv_code, ity.ity_road_characteristic
	from inv_item_types ity,road_sections rse, inv_items iit
	where iit.iit_rse_he_id=rse.rse_he_id
	and iit.iit_ity_inv_code = ity.ity_inv_code
	and ity.ity_contiguous = 'Y'
	and ity.ity_road_characteristic = 'I'
      and iit.iit_st_chain >= nvl(p_start_chain,iit.iit_st_chain)  
      and iit.iit_end_chain >= nvl(p_end_chain,iit.iit_end_chain)  
	and rse.rse_he_id in
	((select rsm_rse_he_id_of from road_seg_membs 
		connect by prior rsm_rse_he_id_of = rsm_rse_he_id_in
		start with rsm_rse_he_id_in = p_rse_he_id)
	union
	(select rse1.rse_he_id from road_sections rse1
		where rse_he_id= p_rse_he_id));

begin
  p_rse_he_id:= higgrirp.get_parameter_value(&&1,'ROAD_ID');
  p_start_chain:=to_number(higgrirp.get_parameter_value(&&1,'CHAINAGE'));
  p_end_chain:=to_number(higgrirp.get_parameter_value(&&1,'CHAINAGE2'));

	for c1_rec in c1 loop
        dbms_output.put_line(c1_rec.rse_unique);
        dbms_output.put_line(c1_rec.ity_inv_code);

	  declare
		cursor c2 is
			select iit_st_chain start_chain, 
			       iit_end_chain end_chain,
			       iit_item_id item_id,
			       iit_ity_inv_code inv_code
			from inv_items_all 
			where iit_ity_inv_code = c1_rec.ity_inv_code
			and iit_rse_he_id = c1_rec.rse_he_id
                        and   iit_end_date is null 
			order by 1,2;
		start_chain	inv_items_all.iit_st_chain%TYPE;
		end_chain	inv_items_all.iit_end_chain%TYPE;
		prev_end_chain	inv_items_all.iit_end_chain%TYPE;
		item_id		inv_items_all.iit_item_id%TYPE;
		inv_code	inv_items_all.iit_ity_inv_code%TYPE;
		first_fetch	char(5)	:= 'TRUE';
	  begin
		for c2_rec in c2 loop
			start_chain := c2_rec.start_chain;
			end_chain := c2_rec.end_chain;
			item_id := c2_rec.item_id;
			inv_code := c2_rec.inv_code;
			if first_fetch = 'TRUE' then
			  first_fetch := 'FALSE';
			  if start_chain < 0 then
				insert into inv_mp_errors
					( ime_item_id, ime_rse_he_id,
					  ime_inv_code, ime_start_chain,
					  ime_end_chain, ime_error_msg )
				values
					( item_id, c1_rec.rse_he_id,
					  inv_code, start_chain, end_chain,
					  'Start chainage too small.');
HIGGRIRP.write_gri_spool('&&1','Start chainage too small.');
dbms_output.put_line('Start chainage too small.');
			  elsif start_chain > 0 then
				insert into inv_mp_errors
					( ime_item_id, ime_rse_he_id,
					  ime_inv_code, ime_start_chain,
					  ime_end_chain, ime_error_msg )
				values
					( item_id, c1_rec.rse_he_id,
					  inv_code, start_chain, end_chain,
					  'Start chainage too large.');
dbms_output.put_line('Start chainage too large.');
HIGGRIRP.write_gri_spool('&&1','Start chainage too large.');
			  end if;
			else
			  if start_chain < prev_end_chain then
				insert into inv_mp_errors
					( ime_item_id, ime_rse_he_id,
					  ime_inv_code, ime_start_chain,
					  ime_end_chain, ime_error_msg )
				values
					( item_id, c1_rec.rse_he_id,
					  inv_code, start_chain, end_chain,
					  'Overlap detected.');
dbms_output.put_line('Overlap detected.');
HIGGRIRP.write_gri_spool('&&1','Overlap detected.');
			  elsif start_chain > prev_end_chain then
				insert into inv_mp_errors
					( ime_item_id, ime_rse_he_id,
					  ime_inv_code, ime_start_chain,
					  ime_end_chain, ime_error_msg )
				values
					( item_id, c1_rec.rse_he_id,
					  inv_code, start_chain, end_chain,
					  'Gap detected.');
dbms_output.put_line('Gap detected.');
HIGGRIRP.write_gri_spool('&&1','Gap detected.');
			  end if;
			end if; 
			prev_end_chain := end_chain;
		end loop;
  		if prev_end_chain < c1_rec.rse_length then
			insert into inv_mp_errors
				( ime_item_id, ime_rse_he_id,
				  ime_inv_code, ime_start_chain,
				  ime_end_chain, ime_error_msg )
			values
				( item_id, c1_rec.rse_he_id,
				  inv_code, start_chain, end_chain,
				  'End chainage too small.');
dbms_output.put_line('End chainage too small.');
HIGGRIRP.write_gri_spool('&&1','End chainage too small.');
  		elsif prev_end_chain > c1_rec.rse_length then
			insert into inv_mp_errors
				( ime_item_id, ime_rse_he_id,
				  ime_inv_code, ime_start_chain,
				  ime_end_chain, ime_error_msg )
			values
				( item_id, c1_rec.rse_he_id,
				  inv_code, start_chain, end_chain,
				  'End chainage too large.');
dbms_output.put_line('End chainage too large.');
HIGGRIRP.write_gri_spool('&&1','End chainage too large.');
		end if;
	  end;
	end loop;

update gri_report_runs 
set grr_end_date = sysdate,
grr_error_no = 0,
grr_error_descr = 'Normal Successful Completion'
where grr_job_id = &&1; 

dbms_output.put_line('Normal Successful Completion');

end;
/

exec HIGGRIRP.write_gri_spool('&&1','Normal Successful Completion');

spool off
set term on
exit

