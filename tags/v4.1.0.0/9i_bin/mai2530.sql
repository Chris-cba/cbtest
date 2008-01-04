rem
rem ---------------------------------------------------------------------------
rem
rem---------------------------------------------------------------------------
rem
rem   SCCS Identifiers :-
rem
rem       sccsid           : @(#)mai2530.sql	1.1 03/15/04
rem       Module Name      : mai2530.sql
rem       Date into SCCS   : 04/03/15 15:30:40
rem       Date fetched Out : 07/06/07 11:18:22
rem       SCCS Version     : 1.1
rem
rem
rem   Author : Darren Cope
rem
rem   This script will create a GMIS survey file.
rem
rem---------------------------------------------------------------------------
rem	Copyright (c) exor corporation ltd, 2003
rem---------------------------------------------------------------------------
rem
set serveroutput on
set ver off
set feed off

prompt

exec higgrirp.write_gri_spool(&1,'Highways by Exor');
exec higgrirp.write_gri_spool(&1,'================');
exec higgrirp.write_gri_spool(&1,'');
exec higgrirp.write_gri_spool(&1,'GMIS File extract');
exec higgrirp.write_gri_spool(&1,'');
exec higgrirp.write_gri_spool(&1,'Working ....');
exec higgrirp.write_gri_spool(&1,'');
DECLARE
  c_route_file CONSTANT varchar2(50) := 'ROUTE.DAT';
  c_exist_file CONSTANT varchar2(50) := 'EXIST.DAT';
  l_file       clob;
  l_ne_id      nm_elements.ne_id%TYPE := higgrirp.get_parameter_value(&1, 'NM_ELEMENT');
BEGIN
  IF nm3get.get_nuf (pi_name            => c_route_file
                    ,pi_raise_not_found => FALSE
                     ).name IS NOT NULL THEN
    hig.raise_ner (pi_appl               => nm3type.c_hig
                  ,pi_id                 => 64
                  ,pi_supplementary_info => 'nm_upload_files.name = '||nm3flx.string(c_route_file)
                  );
  END IF;

  hig_hd_query.set_parameter('MAI2530', 'extent', l_ne_id);
  
  l_file := hig_hd_extract.output_csv('MAI2530', &1);
  -- get the resulting clob and put it in nm_upload_files.
  
  nm3file.unix2dos(l_file);

  nm3file.write_file_to_nuf(pi_filename         => c_route_file
                           ,pi_all_lines        => nm3clob.clob_to_tab_varchar(l_file)
                           ,pi_append_lf        => FALSE
                           ,pi_delete_if_exists => FALSE);

  hig_hd_query.set_parameter('MAI2530_A', 'extent', l_ne_id);
  
  l_file := hig_hd_extract.output_csv('MAI2530_A', &1);
  
  nm3file.unix2dos(l_file);
  
  nm3file.write_file_to_nuf(pi_filename         => c_exist_file
                           ,pi_all_lines        => nm3clob.clob_to_tab_varchar(l_file)
                           ,pi_append_lf        => FALSE
                           ,pi_delete_if_exists => TRUE);

  UPDATE gri_report_runs 
  SET grr_end_date = sysdate,
  grr_error_no = 0,
  grr_error_descr = 'Normal Successful Completion'
  WHERE grr_job_id = &1
  AND grr_mode != 'WEB';

  COMMIT;
END;
/

exec higgrirp.write_gri_spool(&1,'Finished');

exit;
