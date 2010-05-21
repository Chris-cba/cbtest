CREATE OR REPLACE PACKAGE BODY mai_inspection_loader AS
--
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       pvcsid           : $Header:   //vm_latest/archives/mai/admin/pck/mai_inspection_loader.pkb-arc   3.7   May 21 2010 16:31:12   mhuitson  $
--       Module Name      : $Workfile:   mai_inspection_loader.pkb  $
--       Date into PVCS   : $Date:   May 21 2010 16:31:12  $
--       Date fetched Out : $Modtime:   May 21 2010 11:44:00  $
--       PVCS Version     : $Revision:   3.7  $
--
-----------------------------------------------------------------------------
--  Copyright (c) exor corporation ltd, 2007
-----------------------------------------------------------------------------
--
g_body_sccsid   CONSTANT  varchar2(2000) := '$Revision:   3.7  $';
g_package_name  CONSTANT  varchar2(30)   := 'mai_inspection_loader';
--
c_process_type_name CONSTANT VARCHAR2(30)   := 'Maintenance Inspection Loader';
c_file_type_name    CONSTANT VARCHAR2(30)   := 'INSPECTION FILE';
  
g_insp_load_process_type      hig_process_types%ROWTYPE; 
g_insp_load_file_type         hig_process_type_files%ROWTYPE;
--
gt_tokens  nm3type.tab_varchar32767;
--
invalid_file      EXCEPTION; 
invalid_record    EXCEPTION; 
--
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
--Function to make sure that the given value will fit in the variable
--supplied, if all is okay the value is assigned to the supplied variable
--and the function returns true. The function will return false if an
--exception is raised by the assignment, this should normaly be a value error.
--i.e.
--ORA-06502: PL/SQL: numeric or value error: character string buffer too small
--
FUNCTION set_varchar2(pi_value   IN     VARCHAR2
                     ,pio_target IN OUT VARCHAR2)
  RETURN BOOLEAN IS
BEGIN
  /*
  ||Do the assignment.
  */
  pio_target := pi_value;
  /*
  ||No exception raised so return true.
  */
  RETURN TRUE;
  --
EXCEPTION
  WHEN others
   THEN
      /*
      ||Return false to indicate that
      ||the assignment failed.
      */
      --nm_debug.debug(SQLERRM);
      RETURN FALSE;
END set_varchar2;
--
-----------------------------------------------------------------------------
--
PROCEDURE process_log_entry(pi_ner_id             IN nm_errors.ner_id%TYPE
                           ,pi_ner_appl           IN nm_errors.ner_appl%TYPE
                           ,pi_message_type       IN hig_process_log.hpl_message_type%TYPE DEFAULT 'I'
                           ,pi_summary_flag       IN hig_process_log.hpl_summary_flag%TYPE default 'Y'
                           ,pi_supplementary_info IN VARCHAR2 DEFAULT NULL)
  IS
  --
  lv_text hig_process_log.hpl_message%TYPE;
  --
BEGIN
  --
  lv_text := SUBSTR(nm3get.get_ner(pi_ner_id   => pi_ner_id
                                  ,pi_ner_appl => pi_ner_appl).ner_descr||': '||pi_supplementary_info
                   ,1
                   ,500);
  --
  hig_process_api.log_it(pi_message_type => pi_message_type
                        ,pi_message      => lv_text
                        ,pi_summary_flag => pi_summary_flag);
  --
END process_log_entry;
--
-----------------------------------------------------------------------------
--
FUNCTION tokenise_string(pi_string         IN VARCHAR2
                        ,pi_enclosed_by    IN VARCHAR2 DEFAULT '"'
                        ,pi_raised_enc_err IN VARCHAR2 DEFAULT 'Y'
                        ,pi_delimiter      IN VARCHAR2 DEFAULT ','
                        ,pi_trim           IN VARCHAR2 DEFAULT 'Y')
  RETURN nm3type.tab_varchar4000 IS
  --
  i         PLS_INTEGER;
  lv_length PLS_INTEGER := LENGTH(pi_string);
  lv_char   VARCHAR2(1);
  lv_token  nm3type.max_varchar2;
  --
  lv_enclosed_token BOOLEAN := FALSE;
  --
  lt_retval nm3type.tab_varchar4000;
  --
BEGIN
  /*
  ||Make Sure A String Has Been Passed In.
  */
  IF pi_string IS NOT NULL
   THEN
      /*
      ||Read The String 1 Char At A Time.
      */
      FOR i IN 1..lv_length LOOP
        --
        lv_char := SUBSTR(pi_string,i,1);
        /*
        ||If The Current Char Is Not The Delimiter
        ||Then Add It To The Current Token.
        */
        IF lv_char != pi_delimiter
         AND i <= lv_length
         THEN
            /*
            ||If The Current Char Matches The Enclosed By
            ||Paramater Set The Flag To Indicate An Enclosed
            ||Token Is Being Processed.
            */
            IF lv_char = pi_enclosed_by
             THEN
                /*
                ||If The Enclosed Token Flag Is Already Set This Is The End Of
                ||The Token So Reset The Flag So That The Token Is Writen To
                ||The Output Table.
                */
                IF lv_enclosed_token
                 THEN
                   lv_enclosed_token := FALSE;
                ELSE
                   lv_enclosed_token := TRUE;
                END IF;
            ELSE
                lv_token := lv_token||lv_char;
            END IF;
            --
        END IF;
        /*
        ||If The Current Char Is The Delimiter And An Enclosed
        ||Token Is Not Being Processed, Or The Current Char Is
        ||The Last Char In The String Add The Token To The
        ||Table For Output.
        */
        IF (lv_char = pi_delimiter AND NOT lv_enclosed_token)
         OR i = lv_length
         THEN
            --
            IF pi_trim = 'Y'
             THEN
                lv_token := LTRIM(RTRIM(lv_token));
            END IF;
            --
            lt_retval(lt_retval.count+1) := lv_token;
            --
            lv_token := NULL;
            --
        END IF;
        /*
        ||If The Last Char In The String Is
        ||The Delimiter Add A Null Token To
        ||The Table For Output.
        */
        IF lv_char = pi_delimiter
         AND i = lv_length
         THEN
            --
            lt_retval(lt_retval.count+1) := NULL;
            --
        END IF;
        --
      END LOOP;
  END IF;
  /*
  ||If The Begining Of An Enclosed Token Has
  ||Been Found But The End Hasn't Then Raise
  ||An Error.
  */
  IF pi_raised_enc_err = 'Y'
   AND lv_enclosed_token
   THEN
      hig.raise_ner(pi_appl               => 'MAI'
                   ,pi_id                 => 9106
                   ,pi_supplementary_info => pi_enclosed_by);
  END IF;
  --
  RETURN lt_retval;
  --
END tokenise_string;
--
-----------------------------------------------------------------------------
--
FUNCTION get_token_value(pi_tokens   IN nm3type.tab_varchar4000
                        ,pi_position IN PLS_INTEGER)
  RETURN VARCHAR2 IS
  --
BEGIN
  RETURN pi_tokens(pi_position);
EXCEPTION
  WHEN others
   THEN
      RETURN NULL;
END get_token_value;
--
-----------------------------------------------------------------------------
--Function returns the user id for the given initials.
--The pi_initials parameter is VARCHAR2 rather than
--being based on hig_users.hus_initials%TYPE because
--the data in a file may be larger than the column.
--
FUNCTION get_user_id(pi_initials       IN VARCHAR2
                    ,pi_effective_date IN DATE)
  RETURN hig_users.hus_user_id%TYPE IS
  --
  lv_retval  hig_users.hus_user_id%TYPE;
  --
  --Use a cursor to avoid Too Many Rows errors.
  --As hus_initials is not constrained as unique.
  --
  CURSOR get_user(cp_initials       VARCHAR2
                 ,cp_effective_date DATE)
      IS
  SELECT hus_user_id
    FROM hig_users
   WHERE hus_initials = cp_initials
     AND pi_effective_date BETWEEN NVL(hus_start_date,cp_effective_date)
                               AND NVL(hus_end_date,cp_effective_date)
       ;
  --
BEGIN
  --
  OPEN  get_user(pi_initials
                ,pi_effective_date);
  FETCH get_user
   INTO lv_retval;
  CLOSE get_user;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN NULL;
END get_user_id;
--
-----------------------------------------------------------------------------
--
FUNCTION get_org_id(pi_org_code VARCHAR2)
  RETURN org_units.oun_org_id%TYPE IS
  --
  lv_retval org_units.oun_org_id%TYPE;
  --
BEGIN
  --
  SELECT oun_org_id
    INTO lv_retval
    FROM org_units
   WHERE oun_unit_code = pi_org_code
       ;
  --
  RETURN lv_retval;
  --
EXCEPTION
  WHEN others
   THEN
      RETURN NULL;
END get_org_id;
--
-----------------------------------------------------------------------------
--
FUNCTION extract_records_from_file(pi_filename  IN VARCHAR2
                                  ,pi_directory IN VARCHAR2
                                  ,pi_batch_id  IN PLS_INTEGER)
  RETURN BOOLEAN IS
  --
  lc_create_string constant nm3type.max_varchar2
            := 'CREATE TABLE mai_insp_raw${batch_id}'
    ||chr(10)||'  ('
    ||chr(10)||'  line_no NUMBER, rec_type VARCHAR2(1), rec_text VARCHAR2(4000)'
    ||chr(10)||'  )'
    ||chr(10)||'ORGANIZATION external'
    ||chr(10)||'  ('
    ||chr(10)||'  TYPE oracle_loader'
    ||chr(10)||'  DEFAULT DIRECTORY ${location}'
    ||chr(10)||'  ACCESS PARAMETERS'
    ||chr(10)||'    ('
    ||chr(10)||'    RECORDS DELIMITED BY ${format} '
    ||chr(10)||'    BADFILE '||nm3flx.string('${log_file_name}')
    ||chr(10)||'    DISCARDFILE '||nm3flx.string('${log_file_name}')
    ||chr(10)||'    LOGFILE '||nm3flx.string('${log_file_name}')
    ||chr(10)||'    FIELDS LRTRIM'
    ||chr(10)||'    MISSING FIELD VALUES ARE NULL'
    ||chr(10)||'      ('
    ||chr(10)||'      line_no RECNUM, rec_type (2:2), rec_text(4:+4000)'
    ||chr(10)||'      )'
    ||chr(10)||'    )'
    ||chr(10)||'    LOCATION (''${file_name}'')'
    ||chr(10)||'  )'
    ||chr(10)||'REJECT LIMIT 0'
  ;
  --
  l_work_buff nm3type.max_varchar2 := lc_create_string ;
  l_sql VARCHAR2(500);
  --
  ------------------------------------
  --
BEGIN
  --
  nm_debug.debug('Dropping Load Table');
  BEGIN
    EXECUTE IMMEDIATE ('drop table mai_insp_raw'||pi_batch_id);
  EXCEPTION
    WHEN others
     THEN
        NULL;
  END;
  --
  nm_debug.debug('Replacing Values');
  l_work_buff := REPLACE(l_work_buff,'${file_name}',pi_filename) ;
  l_work_buff := REPLACE(l_work_buff,'${log_file_name}',SUBSTR(pi_filename,1,INSTR(pi_filename,'.')-1)) ;
  l_work_buff := REPLACE(l_work_buff,'${location}',pi_directory) ;
  l_work_buff := REPLACE(l_work_buff,'${batch_id}',pi_batch_id) ;
  l_work_buff := REPLACE(l_work_buff,'${format}',REPLACE(nm3file.external_table_record_delim(nm3file.dos_or_unix_file(pi_filename,'MAI_INSP_DIRECTORY')),'0X''','0X''22')) ;
  --
nm_debug.debug('Creating External Table');
nm_debug.debug(l_work_buff);
  EXECUTE IMMEDIATE l_work_buff ;
  --
nm_debug.debug('External Table Created');
  l_sql := 'INSERT'
||CHR(10)||'  INTO mai_insp_load_recs'
||CHR(10)||'SELECT '||nm3flx.string(pi_batch_id)
||CHR(10)||'      ,line_no*10'
||CHR(10)||'      ,UPPER(rec_type)'
||CHR(10)||'      ,rec_text'
||CHR(10)||'      ,NULL'
||CHR(10)||'      ,NULL'
||CHR(10)||'      ,'||nm3flx.string('N')
||CHR(10)||'  FROM mai_insp_raw'||pi_batch_id
  ;
nm_debug.debug('Inserting data into load table');
  execute immediate (l_sql);
  --
nm_debug.debug('dropping external table');
  execute immediate ('drop table mai_insp_raw'||pi_batch_id);
  --
nm_debug.debug('external table dropped');
  RETURN(TRUE); -- i.e. was a success
  --
EXCEPTION
  WHEN others
   THEN
      --nm_debug.debug('extracting records from file setting file status to error for file '||pi_file_rec.nlfl_file_id);
      --set_file_status(pi_file_id => pi_file_rec.nlfl_file_id
      --               ,pi_status  => gc_read_with_error
      --               ,pi_message => substr('Error reading file: '||sqlerrm,1,500));
      --
      RAISE;
      --RETURN(FALSE);
      --
END extract_records_from_file;
--
-----------------------------------------------------------------------------
--
PROCEDURE process_rmms_or_eid_file(pi_batch_id    IN     activities_report.are_batch_id%TYPE
                                  ,pio_api_params IN OUT mai_inspection_api.insp_tab)
  IS
  --
  lv_enhanced    BOOLEAN := FALSE;
  lv_rmmsflag    hig_option_values.hov_value%TYPE := hig.get_sysopt('RMMSFLAG');
  lv_usedefchnl  BOOLEAN := (NVL(hig.get_sysopt('USEDEFCHNL'),'N') = 'Y');
  lv_usedefchnd  BOOLEAN := (NVL(hig.get_sysopt('USEDEFCHND'),'N') = 'Y');
  lv_romsec      BOOLEAN := FALSE;
  lv_reverse     BOOLEAN := FALSE;
  lv_recal_done  BOOLEAN := FALSE;
  lv_defrecalup  hig_option_values.hov_value%TYPE := hig.get_sysopt('DEFRECALUP');
  lv_defrecallo  hig_option_values.hov_value%TYPE := hig.get_sysopt('DEFRECALLO');
  --
  lv_rse_admin_unit    nm_admin_units_all.nau_admin_unit%TYPE;
  lv_rse_length        nm_elements_all.ne_length%TYPE;
  lv_sys_flag          VARCHAR2(1);
  lv_doc_title         VARCHAR2(60);
  --
  /*
  ||Field Positions On The G Record.
  ||Defaulted to RMMS File Positions.
  */
  lv_g_rec_rse_he_id       PLS_INTEGER;
  lv_g_rec_link            PLS_INTEGER := 1;
  lv_g_rec_section         PLS_INTEGER := 2;
  lv_g_rec_first_insp      PLS_INTEGER := 3;
  lv_g_rec_inspdate        PLS_INTEGER := 4;
  lv_g_rec_insptime        PLS_INTEGER;
  lv_g_rec_safety_detailed PLS_INTEGER := 5;
  lv_g_rec_init_type       PLS_INTEGER := 6;
  lv_g_rec_direction       PLS_INTEGER := 7;
  lv_g_rec_second_insp     PLS_INTEGER;
  lv_g_rec_weather         PLS_INTEGER := 8;
  lv_g_rec_surfcond        PLS_INTEGER := 9;
  lv_g_rec_sectdesc        PLS_INTEGER := 10;
  lv_max_end_chain         PLS_INTEGER := 9999;
  --
  lv_i_rec_activity      PLS_INTEGER := 1;
  lv_i_rec_xsect         PLS_INTEGER := 2;
  lv_i_rec_stchain       PLS_INTEGER := 3;
  lv_i_rec_locn          PLS_INTEGER := 4;
  lv_i_rec_insp_time     PLS_INTEGER := 5;
  lv_i_rec_identcode     PLS_INTEGER := 6;
  lv_i_rec_diagno        PLS_INTEGER := 7;
  lv_i_rec_invcode       PLS_INTEGER := 8;
  lv_i_rec_invind        PLS_INTEGER;
  lv_i_rec_siss          PLS_INTEGER;
  lv_i_rec_notifiable    PLS_INTEGER;
  lv_i_rec_recharge      PLS_INTEGER;
  lv_i_rec_special_instr PLS_INTEGER;
  lv_i_rec_description   PLS_INTEGER := 9;
  --
  lv_j_rec_defcode       PLS_INTEGER := 1;
  lv_j_rec_def_priority  PLS_INTEGER;
  lv_j_rec_def_category  PLS_INTEGER;
  lv_j_rec_asset_id      PLS_INTEGER;
  lv_j_rec_str_easting   PLS_INTEGER;
  lv_j_rec_str_northing  PLS_INTEGER;
  lv_j_rec_hhatt1        PLS_INTEGER := 2;
  lv_j_rec_hhatt2        PLS_INTEGER := 3;
  lv_j_rec_hhatt3        PLS_INTEGER;
  lv_j_rec_hhatt4        PLS_INTEGER;
  lv_j_rec_road_stud     PLS_INTEGER := 4;
  --
  lt_api_params  mai_inspection_api.insp_tab;
  lr_are         activities_report%ROWTYPE;
  lt_activities  mai_inspection_api.activities_tab;
  lt_defects     mai_inspection_api.def_tab;
  lr_def         defects%ROWTYPE;
  lt_def_attr    mai_inspection_api.def_attr_tab;
  lt_repairs     mai_inspection_api.rep_tab;
  lt_com_tab     mai_inspection_api.com_tab;
  lt_das_tab     mai_inspection_api.das_tab;
  --
  TYPE load_recs_tab IS TABLE OF mai_insp_load_recs%ROWTYPE;
  lt_records load_recs_tab;
  --
  TYPE rec_counter_tab IS TABLE OF PLS_INTEGER INDEX BY VARCHAR2(1);
  lt_rec_counts rec_counter_tab;
  --
  TYPE x_rec_counts_rec IS RECORD(rec_type  VARCHAR2(1)
                                 ,rec_count PLS_INTEGER);
  TYPE x_rec_counts_tab IS TABLE OF x_rec_counts_rec INDEX BY BINARY_INTEGER;
  lt_x_rec_counts x_rec_counts_tab;
  --
  TYPE error_rec IS RECORD(seq_no      mai_insp_load_recs.milr_seq_no%TYPE
                          ,ner_id      nm_errors.ner_id%TYPE
                          ,error_text  mai_insp_load_recs.milr_error_text%TYPE);
  TYPE error_tab IS TABLE OF error_rec INDEX BY BINARY_INTEGER;
  lt_errors  error_tab;
  --
  lt_tokens      nm3type.tab_varchar4000;
  lt_seq_no_tab  seq_no_store_tab;
  --
  TYPE rec_index_tab IS TABLE OF PLS_INTEGER INDEX BY BINARY_INTEGER;
  lt_g_rec_index rec_index_tab;
  --
  lv_p_rec_index  PLS_INTEGER;
  lv_h_rec_index  PLS_INTEGER;
  lv_r_rec_index  PLS_INTEGER;
  --
  invalid_record  EXCEPTION;
  --
  PROCEDURE add_error_to_stack(pi_seq_no             IN mai_insp_load_recs.milr_seq_no%TYPE
                              ,pi_ner_id             IN nm_errors.ner_id%TYPE
                              ,pi_supplementary_info IN VARCHAR2 DEFAULT NULL)
    IS
    --
    lv_text  mai_insp_load_recs.milr_error_text%TYPE;
    --
  BEGIN
    --
    nm_debug.debug('Adding error to stack '||pi_ner_id);
    lt_errors(lt_errors.count+1).seq_no := pi_seq_no;
    lt_errors(lt_errors.count).ner_id := pi_ner_id;
    lv_text := SUBSTR(nm3get.get_ner(pi_ner_id   => pi_ner_id
                                    ,pi_ner_appl => 'MAI').ner_descr||': '||nm3flx.parse_error_message(pi_supplementary_info)
                     ,1
                     ,4000);
    lt_errors(lt_errors.count).error_text := lv_text;
    --
    --lt_errors(lt_errors.count).error_text := hig.raise_and_catch_ner(pi_appl               => 'MAI'
    --                                                                ,pi_id                 => pi_ner_id
    --                                                                ,pi_supplementary_info => nm3flx.parse_error_message(pi_supplementary_info));
    --
    nm_debug.debug('Error Added.');
  END add_error_to_stack;
  --
  FUNCTION errors_raised
    RETURN BOOLEAN IS
  BEGIN
    RETURN (lt_errors.count > 0);
  END errors_raised;
  --
  PROCEDURE process_error_stack
    IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
--    nm_debug.debug('Logging error');
    /*
    ||Clear down any current errors
    */
    IF lt_errors.count >0 THEN
    
      UPDATE mai_insp_load_recs
         SET milr_error_no = NULL
            ,milr_error_text = NULL
       WHERE milr_batch_id = pi_batch_id;
       
    END IF;

nm_debug.debug('Error count = '||lt_errors.count);
    /*
    ||Update The Load Records Table
    */
    FOR i IN 1..lt_errors.count LOOP
      --
      UPDATE mai_insp_load_recs
         SET milr_error_no = lt_errors(i).ner_id
            ,milr_error_text = lt_errors(i).error_text
       WHERE milr_batch_id = pi_batch_id
         AND milr_seq_no = lt_errors(i).seq_no
           ;
      --
--      nm_debug.debug('Logging error with framework '||lt_errors(i).error_text);
      hig_process_api.log_it(pi_message_type => 'E'
                            ,pi_message      => lt_errors(i).error_text);
      --
    END LOOP;
    /*
    ||Commit The Changes.
    */
    COMMIT;
    /*
    ||Cleardown The Error Stack.
    */
    lt_errors.delete;
    --
  END process_error_stack;
  --
  PROCEDURE set_enhanced_rec_pos
    IS
  BEGIN
    --
    lv_g_rec_rse_he_id       := 1;
    lv_g_rec_link            := 2;
    lv_g_rec_section         := 3;
    lv_g_rec_first_insp      := 4;
    lv_g_rec_inspdate        := 5;
    lv_g_rec_insptime        := 6;
    lv_g_rec_safety_detailed := 7;
    lv_g_rec_init_type       := 8;
    lv_g_rec_direction       := 9;
    lv_g_rec_second_insp     := 10;
    lv_g_rec_weather         := 11;
    lv_g_rec_surfcond        := 12;
    lv_g_rec_sectdesc        := 13;
    --
    lv_max_end_chain := 999999;
    --
    lv_i_rec_activity      := 1;
    lv_i_rec_xsect         := 2;
    lv_i_rec_stchain       := 3;
    lv_i_rec_locn          := 4;
    lv_i_rec_insp_time     := 5;
    lv_i_rec_identcode     := 6;
    lv_i_rec_diagno        := 7;
    lv_i_rec_invcode       := 8;
    lv_i_rec_invind        := 9;
    lv_i_rec_siss          := 10;
    lv_i_rec_notifiable    := 11;
    lv_i_rec_recharge      := 12;
    lv_i_rec_special_instr := 13;
    lv_i_rec_description   := 14;
    --
    lv_j_rec_defcode       := 1;
    lv_j_rec_def_priority  := 2;
    lv_j_rec_def_category  := 3;
    lv_j_rec_asset_id      := 4;
    lv_j_rec_str_easting   := 5;
    lv_j_rec_str_northing  := 6;
    lv_j_rec_hhatt1        := 7;
    lv_j_rec_hhatt2        := 8;
    lv_j_rec_hhatt3        := 9;
    lv_j_rec_hhatt4        := 10;
    lv_j_rec_road_stud     := 11;
    --
  END set_enhanced_rec_pos;
  --
  PROCEDURE get_records(pi_batch_id IN mai_insp_load_recs.milr_batch_id%TYPE)
    IS
  BEGIN
    --
    SELECT *
      BULK COLLECT
      INTO lt_records
      FROM mai_insp_load_recs
     WHERE milr_batch_id = pi_batch_id
     ORDER
        BY milr_seq_no
         ;
    --
  END get_records;
  --
  FUNCTION check_number(pi_number IN VARCHAR2)
    RETURN BOOLEAN IS
    --
    lv_number NUMBER;
    --
  BEGIN
    --
    lv_number := TO_NUMBER(pi_number);
    --
    RETURN TRUE;
    --
  EXCEPTION
    WHEN others
     THEN
        RETURN FALSE;
  END check_number;
  --
  FUNCTION check_date(pi_date IN VARCHAR2)
    RETURN BOOLEAN IS
    --
    lv_date DATE;
    --
  BEGIN
    --
    lv_date := TO_DATE(pi_date,'RRMMDD');
    --
    RETURN TRUE;
    --
  EXCEPTION
    WHEN others
     THEN
        RETURN FALSE;
  END check_date;
  --
  FUNCTION check_time(pi_time IN VARCHAR2)
    RETURN BOOLEAN IS
    --
    lv_date DATE;
    --
  BEGIN
    --
    lv_date := TO_DATE(pi_time,'HH24MI');
    --
    RETURN TRUE;
    --
  EXCEPTION
    WHEN others
     THEN
        RETURN FALSE;
  END check_time;
  --
  FUNCTION get_chain(pi_chainage IN NUMBER)
    RETURN NUMBER IS
    --
    lv_retval NUMBER;
    --
  BEGIN
    /*
    ||Make Sure That The Chainage Is Within
    ||Tollerence Of The End Of The Section.
    */
    IF pi_chainage > (lv_rse_length + ((lv_rse_length/100) * lv_defrecalup))
     THEN
        lv_retval := -1;
    ELSE
        /*
        ||If The Survey Has Been Carried Out In Reverse
        ||Direction i.e. The Chainage Given Is Relative
        ||To The End Of The Section Return The Chainage
        ||Relative To The Start Of The Section.
        */
        IF lv_reverse
         THEN
            lv_retval := lv_rse_length - pi_chainage;
        ELSE
            lv_retval := pi_chainage;
        END IF;
    END IF;
    --
    RETURN lv_retval;
    --
  END get_chain;
  --
  FUNCTION recalibrate_chainage(pi_chainage   IN NUMBER
                               ,pi_insp_start IN NUMBER
                               ,pi_insp_end   IN NUMBER)
    RETURN NUMBER IS
    --
    lv_retval           NUMBER;
    lv_perc_rse_length  NUMBER;
    --
  BEGIN
    --
    lv_retval := pi_chainage;
    /*
    ||If MAI is being used
    */
    IF lv_romsec
     THEN
        lv_perc_rse_length := (pi_insp_end / lv_rse_length)*100;
        /*
        ||And Not A Partial Survey
        */
        IF lv_perc_rse_length > lv_defrecallo
         AND pi_insp_start = 0
         THEN
            lv_retval := (lv_retval * lv_rse_length) / pi_insp_end;
            lv_recal_done := TRUE;
            --fprintf(fi,"Recalibration Applied\n\tOriginal Survey Length : %ld\n\tNew Survey Length      : %ld\n\n",end,slength);
        ELSE
            --fprintf(fi,"Recalibration NOT applied\n");
            NULL;
        END IF;
    END IF;
    --
    RETURN lv_retval;
    --
  END recalibrate_chainage;
  --
  FUNCTION validate_section(pi_link        IN     VARCHAR2
                           ,pi_section     IN     VARCHAR2
                           ,pio_rse_he_id  IN OUT NUMBER
                           ,pio_admin_unit IN OUT NUMBER
                           ,pio_sys_flag   IN OUT VARCHAR2
                           ,pio_rse_length IN OUT NUMBER
                           ,pio_doc_title  IN OUT VARCHAR2)
    RETURN BOOLEAN IS
    --
    lv_agency   VARCHAR2(4);
    lv_linkcode VARCHAR2(10);
    lv_sect_no  road_sections.rse_sect_no%TYPE;
    --
  BEGIN
    /*
    || If The File Is ENHANCED It May Well Contain The rse_he_id
    || In Which Case It Will Have Been Passed In So Use It To Get
    || The Section Details.
    */
    IF pio_rse_he_id IS NOT NULL
     THEN
        BEGIN
          SELECT NVL(NVL(rse_length,rse_max_chain),lv_max_end_chain)
                ,UPPER(SUBSTR(rse_unique||' '||rse_descr,1,60))
                ,rse_admin_unit
                ,rse_sys_flag
                ,rse_sect_no
            INTO pio_rse_length
                ,pio_doc_title
                ,pio_admin_unit
                ,pio_sys_flag
                ,lv_sect_no
            FROM road_sections
           WHERE rse_he_id = pio_rse_he_id
               ;
        EXCEPTION
          WHEN no_data_found
           THEN
              pio_rse_he_id := NULL;
          WHEN others
           THEN
              RAISE;
        END;
    END IF;
    /*
    || If The Select Based On The rse_he_id Passed In Failed
    || To Return A Row Or No rse_he_id Was Passed In Use The
    || Agency Code, Linkcode And Section Number To Validate
    || The Section.
    */
    IF pio_rse_he_id IS NULL
     THEN
        /*
        ||Split The Link from the file
        ||into agency and linkcode.
        */
        lv_agency := SUBSTR(pi_link,1,4);
        lv_linkcode := SUBSTR(pi_link,5,LENGTH(pi_link)-4);
        --
        CASE lv_rmmsflag
          WHEN '3'
           THEN
              SELECT rse_he_id
                    ,NVL(NVL(rse_length,rse_max_chain),lv_max_end_chain)
                    ,UPPER(SUBSTR(rse_unique||' '||rse_descr,1,60))
                    ,rse_admin_unit
                    ,rse_sys_flag
                    ,rse_sect_no
                INTO pio_rse_he_id
                    ,pio_rse_length
                    ,pio_doc_title
                    ,pio_admin_unit
                    ,pio_sys_flag
                    ,lv_sect_no
                FROM road_sections
               WHERE rse_agency = lv_agency
                 AND rse_linkcode = lv_linkcode
                 AND (rse_sect_no = pi_section
                      OR rse_sect_no = SUBSTR(pi_section,4,2))
                   ;
          WHEN '4'
           THEN
              SELECT rse_he_id
                    ,NVL(NVL(rse_length,rse_max_chain),lv_max_end_chain)
                    ,UPPER(SUBSTR(rse_unique||' '||rse_descr,1,60))
                    ,rse_admin_unit
                    ,rse_sys_flag
                    ,rse_sect_no
                INTO pio_rse_he_id
                    ,pio_rse_length
                    ,pio_doc_title
                    ,pio_admin_unit
                    ,pio_sys_flag
                    ,lv_sect_no
                FROM road_sections
               WHERE rse_group = pi_link
                 AND (rse_sect_no = pi_section
                      OR rse_sect_no = SUBSTR(pi_section,4,2))
                   ;
          ELSE
              SELECT rse_he_id
                    ,NVL(NVL(rse_length,rse_max_chain),lv_max_end_chain)
                    ,UPPER(SUBSTR(rse_unique||' '||rse_descr,1,60))
                    ,rse_admin_unit
                    ,rse_sys_flag
                    ,rse_sect_no
                INTO pio_rse_he_id
                    ,pio_rse_length
                    ,pio_doc_title
                    ,pio_admin_unit
                    ,pio_sys_flag
                    ,lv_sect_no
                FROM road_sections
               WHERE rse_agency = lv_agency
                 AND rse_linkcode = lv_linkcode
                 AND rse_sect_no = pi_section
                   ;
        END CASE;
    END IF;
    /*
    ||Set The Rommis Section Flag if the network is
    ||a Maintenance Manager network and the Section
    ||Numbers are 5 characters long.
    */
    IF lv_rmmsflag = 3
     AND length(lv_sect_no) = 5
       THEN
          lv_romsec := TRUE;
    END IF;
    --
    RETURN TRUE;
    --
  EXCEPTION
    WHEN others
     THEN
        RETURN FALSE;
  END validate_section;
  --
  FUNCTION get_next_rec_index(pi_rec_type      IN mai_insp_load_recs.milr_rec_type%TYPE
                             ,pi_current_index IN BINARY_INTEGER)
    RETURN BINARY_INTEGER IS
    --
    lv_retval BINARY_INTEGER;
    --
  BEGIN
    --
    FOR i in pi_current_index..lt_records.count LOOP
      --
      IF lt_records(i).milr_rec_type = pi_rec_type
       THEN
          lv_retval := i;
          exit;
      END IF;
      --
    END LOOP;
    --
    RETURN lv_retval;
    --
  END get_next_rec_index;
  --
  PROCEDURE process_g_rec(pi_g_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_g_seq_no          mai_insp_load_recs.milr_seq_no%TYPE;
    lv_token             VARCHAR2(4000);
    lv_file_date         VARCHAR2(10);
    lv_rse_he_id         nm_elements_all.ne_id%TYPE;
    lv_survey_direction  VARCHAR2(1);
    --
  BEGIN
    /*
    ||Reset The Recalibration Flag.
    */
    lv_recal_done := FALSE;
    /*
    ||Get The Values From The G Record;
    */
    lv_g_seq_no := lt_records(pi_g_rec_index).milr_seq_no;
    lt_tokens := tokenise_string(pi_string => lt_records(pi_g_rec_index).milr_rec_text);
    /*
    ||Get The Inspection Date.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_inspdate);
nm_debug.debug('File inspdate = '||lv_token);
    IF check_date(pi_date => lv_token)
     THEN
        /*
        ||If Processing an Enhanced File The Inspection
        ||Time Should Also Be Provided So Get It Before
        ||Setting The Inspection Date.
        */
        IF lv_enhanced
         THEN
            /*
            ||Store The Inspection Date From The File.
            */
            lv_file_date := lv_token;
            /*
            ||Get The Inspection Time From The File.
            */
            lv_token := get_token_value(pi_tokens   => lt_tokens
                                       ,pi_position => lv_g_rec_insptime);
            /*
            ||Check The Inspection Time.
            */
            IF check_time(pi_time => lv_token)
             THEN
                /*
                ||If The Inspection Time Is NULL In The File The Conversion
                ||Below Will Still Work But Return A Date With No Time.
                ||If At Some Point It Is Required That An Error Is Raised
                ||When The Time Is NULL An Extra Clause Will Need To Be Added
                ||To The IF Statement Above To Explicitly Check For A NULL Value.
                */
                lr_are.are_date_work_done := TO_DATE(lv_file_date||lv_token,'RRMMDDHH24MI');
            ELSE
                --Raise an Error
                add_error_to_stack(pi_seq_no => lv_g_seq_no
                                  ,pi_ner_id => 9204);
                RAISE invalid_record;
            END IF;
        ELSE
            /*
            ||No Time Element In File So Just Convert The Date.
            */
            lr_are.are_date_work_done := TO_DATE(lv_token,'RRMMDD');
        END IF;
    ELSE
        --Raise 9203 Error And Stop The Load.
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9203);
        RAISE invalid_record;
    END IF;
    /*
    ||Inspection Date Must Be In The Past.
    */
    IF lr_are.are_date_work_done > SYSDATE
     THEN
        --RAISE An Error
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9203);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Initiation Type.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_init_type);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_are.are_initiation_type)
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9202);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Safety/Detailed Flag.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_safety_detailed);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_are.are_maint_insp_flag)
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9205);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Survey Direction Flag.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_direction);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lv_survey_direction)
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9206);
        RAISE invalid_record;
    ELSIF lv_survey_direction NOT IN('Y','N')
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9206);
        RAISE invalid_record;
    END IF;
    /*
    ||Set The Reverse Survey Flag So That
    ||Chainages Can Be Reversed If The Section
    ||Is Surveyed From End To Start.
    */
    IF lv_survey_direction = 'Y'
     THEN
        lv_reverse := TRUE;
    ELSE
        lv_reverse := FALSE;
    END IF;
    /*
    ||Extract The Weather Condition.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_weather);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_are.are_weather_condition)
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9212);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Surface Condition.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_surfcond);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_are.are_surface_condition)
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9211);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Road Section Details.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_rse_he_id);
    IF check_number(pi_number => lv_token)
     THEN
        lv_rse_he_id := TO_NUMBER(lv_token);
    ELSE
        lv_rse_he_id := NULL;
    END IF;
    --
    IF NOT validate_section(pi_link         => get_token_value(pi_tokens => lt_tokens,pi_position => lv_g_rec_link)
                           ,pi_section      => get_token_value(pi_tokens => lt_tokens,pi_position => lv_g_rec_section)
                           ,pio_rse_he_id   => lv_rse_he_id
                           ,pio_admin_unit  => lv_rse_admin_unit
                           ,pio_sys_flag    => lv_sys_flag
                           ,pio_rse_length  => lv_rse_length
                           ,pio_doc_title   => lv_doc_title)
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9207);
        RAISE invalid_record;
    END IF;
    --
    lr_are.are_rse_he_id := lv_rse_he_id;
    /*
    ||Extract The First Inspector Initials.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_first_insp);
    IF lv_token IS NOT NULL
     THEN
        lr_are.are_peo_person_id_actioned := get_user_id(pi_initials       => lv_token
                                                        ,pi_effective_date => lr_are.are_date_work_done);
    END IF;
    /*
    ||If The First Inspector Is NULL In The File
    ||Or The Initials Supplied Are Invalid Raise
    ||An Error (First Inspector Is Mandatory In The File).
    */
    IF lr_are.are_peo_person_id_actioned IS NULL
     THEN
        add_error_to_stack(pi_seq_no => lv_g_seq_no
                          ,pi_ner_id => 9208);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Second Inspector Initials.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_g_rec_second_insp);
    IF lv_token IS NOT NULL
     THEN
        --
        lr_are.are_peo_person_id_insp2 := get_user_id(pi_initials       => lv_token
                                                     ,pi_effective_date => lr_are.are_date_work_done);
        --
        IF lr_are.are_peo_person_id_insp2 IS NULL
         THEN
            add_error_to_stack(pi_seq_no => lv_g_seq_no
                              ,pi_ner_id => 9209);
            RAISE invalid_record;
        END IF;
        --
    END IF;
    --
    lr_are.are_batch_id := pi_batch_id;
    lr_are.are_report_id := mai_inspection_api.get_next_id(pi_seq_name => 'ARE_REPORT_ID_SEQ');
    --
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_g_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
        --RAISE invalid_record;
        RAISE;
  END process_g_rec;
  --
  PROCEDURE process_p_rec(pi_p_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_p_seq_no  mai_insp_load_recs.milr_seq_no%TYPE;
    lv_token     VARCHAR2(4000);
    lv_temp_st   activities_report.are_st_chain%TYPE;
    lv_st_chain  activities_report.are_st_chain%TYPE;
    lv_end_chain activities_report.are_end_chain%TYPE;
    --
  BEGIN
    /*
    ||Get The Values From The P Record;
    */
    lv_p_seq_no := lt_records(pi_p_rec_index).milr_seq_no;
    lt_tokens := tokenise_string(pi_string => lt_records(pi_p_rec_index).milr_rec_text);
    /*
    ||Get The Survey Start And End Chainage From The Record.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => 1);
    IF check_number(pi_number => lv_token)
     THEN
        lv_st_chain := TO_NUMBER(lv_token);
    END IF;
    --
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => 2);
    IF check_number(pi_number => lv_token)
     THEN
        lv_end_chain := TO_NUMBER(lv_token);
    END IF;
    --
    IF lv_st_chain IS NULL
     OR lv_end_chain IS NULL
     THEN
        add_error_to_stack(pi_seq_no => lv_p_seq_no
                          ,pi_ner_id => 9602);
        RAISE invalid_record;
    END IF;
    /*
    ||If The Max End Chainage Value Has
    ||Not Been Given In Either Field
    ||Make Sure The Chainage Is Within
    ||Tollerance Of The Section Length
    ||And Reverse It If Required.
    */
    IF lv_st_chain != lv_max_end_chain
     AND lv_end_chain != lv_max_end_chain
     THEN
        lv_st_chain := get_chain(pi_chainage => lv_st_chain);
        lv_end_chain := get_chain(pi_chainage => lv_end_chain);
        IF lv_st_chain = -1
         OR lv_end_chain = -1
         THEN
            add_error_to_stack(pi_seq_no => lv_p_seq_no
                              ,pi_ner_id => 9402);
            RAISE invalid_record;
        END IF;
    END IF;
    /*
    ||Some Files Will Indicate That The Survey Is In Reverse
    ||Direction But Specify The Start And End Chainages On The
    ||P Record In The Correct Order And Therefore Do Not Need To
    ||Be Reversed.
    */
    IF lv_st_chain > lv_end_chain
     AND lv_reverse
     THEN
        --
        lv_temp_st := lv_st_chain;
        lv_st_chain := lv_end_chain;
        lv_end_chain := lv_temp_st;
        --
    END IF;
    /*
    ||Make Sure That The End Chainage Is Greater Than The Start Chainage.
    */
    IF lv_st_chain > lv_end_chain
     THEN
        add_error_to_stack(pi_seq_no => lv_p_seq_no
                              ,pi_ner_id => 9401);
        RAISE invalid_record;
    END IF;
    /*
    ||Assign The Final Chainages To The Inspection Record.
    */
    lr_are.are_st_chain := lv_st_chain;
    --
    IF lv_end_chain = lv_max_end_chain
     THEN
        lr_are.are_end_chain := mai_inspection_api.validate_section(pi_rse_he_id => lr_are.are_rse_he_id).rse_length;
    ELSE
        lr_are.are_end_chain := lv_end_chain;
    END IF;
    --
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_p_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
--        RAISE invalid_record;
        RAISE;
  END process_p_rec;
  --
  PROCEDURE process_h_rec(pi_h_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_h_seq_no  mai_insp_load_recs.milr_seq_no%TYPE;
    lv_token     VARCHAR2(4000);
    lv_activity  activities.atv_acty_area_code%TYPE;
    --
  BEGIN
    /*
    ||Get The Values From The P Record;
    */
    lv_h_seq_no := lt_records(pi_h_rec_index).milr_seq_no;
    lt_tokens := tokenise_string(pi_string => lt_records(pi_h_rec_index).milr_rec_text);
    /*
    ||Loop Through The Fields And Build A Table Of Activities.
    */
    FOR i IN 1..lt_tokens.count LOOP
      --
      IF set_varchar2(pi_value   => lt_tokens(i)
                     ,pio_target => lv_activity)
       THEN
          lt_activities(i).atv_acty_area_code := lv_activity;
      ELSE
          add_error_to_stack(pi_seq_no => lv_h_seq_no
                            ,pi_ner_id => 9221);
          RAISE invalid_record;
      END IF;
      --
    END LOOP;
    --
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_h_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
--        RAISE invalid_record;
        RAISE;
  END process_h_rec;
--  
  PROCEDURE process_r_rec(pi_r_rec_index IN BINARY_INTEGER,
                          pi_p_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_r_seq_no       mai_insp_load_recs.milr_seq_no%TYPE;
    lv_index          BINARY_INTEGER;
    lv_doc_id         docs.doc_id%TYPE;
    --
  BEGIN
      
    FOR i IN (pi_r_rec_index) .. (pi_p_rec_index-1) LOOP
      IF lt_records(i).milr_rec_type = 'R'
        THEN
        /*
        ||Get The Values From The R Record;
        */
        lv_r_seq_no := lt_records(i).milr_seq_no;
        lt_tokens := tokenise_string(pi_string => lt_records(i).milr_rec_text);
        --
        lv_index := lt_com_tab.count+1;
        /*
        ||Get DOC_ID Sequence
        */
        lv_doc_id := mai_inspection_api.get_next_id(pi_seq_name => 'DOC_ID_SEQ');
        lt_com_tab(lv_index).com_doc_id := lv_doc_id;
        lt_com_tab(lv_index).com_title  := lv_doc_title;
        --  
        /*
        ||Get the Comment Class.
        */
        lt_com_tab(lv_index).com_category     := get_token_value(pi_tokens   => lt_tokens
                                                                ,pi_position => 1);
        lt_com_tab(lv_index).com_dtp_code     := 'COMM';
        lt_com_tab(lv_index).com_date_issued  := lr_are.are_date_work_done;
        lt_com_tab(lv_index).com_descr        := get_token_value(pi_tokens   => lt_tokens
                                                                ,pi_position => 2);

        lt_com_tab(lv_index).com_reference_code := lr_are.are_batch_id; 

      END IF;
      
    END LOOP;
    
  EXCEPTION
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_r_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
        RAISE;
  END process_r_rec;
  --
  PROCEDURE process_i_rec(pi_i_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_i_seq_no         mai_insp_load_recs.milr_seq_no%TYPE;
    lv_token            VARCHAR2(4000);
    lv_chainage         defects.def_st_chain%TYPE;
    lv_org_id           org_units.oun_org_id%TYPE;
    lv_def_locn_descr   VARCHAR2(240);
    --
  BEGIN
    /*
    ||Get The Values From The I Record;
    */
    lv_i_seq_no := lt_records(pi_i_rec_index).milr_seq_no;
    lt_tokens := tokenise_string(pi_string => lt_records(pi_i_rec_index).milr_rec_text);
    /*
    ||Extract The Activity.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_activity);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_def.def_atv_acty_area_code)
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9300);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The XSP.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_xsect);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_def.def_x_sect)
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9266);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Defect Chainage.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_stchain);
    /*
    ||If Chainage Is Mandatory And The Value In
    ||The File Is NULL Raise An Error.
    */
    IF (lv_sys_flag = 'D' AND lv_usedefchnd)
     OR (lv_sys_flag = 'L' AND lv_usedefchnl)
     AND lv_token IS NULL
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9605);
        RAISE invalid_record;
    ELSE
        IF check_number(pi_number => lv_token)
         THEN
            lv_chainage := TO_NUMBER(lv_token);
        ELSE
            add_error_to_stack(pi_seq_no => lv_i_seq_no
                              ,pi_ner_id => 9262);
            RAISE invalid_record;
        END IF;
    END IF;
    /*
    ||Make Sure The Chainage Is Within
    ||Tollerance Of The Section Length
    ||And Reverse It If Required.
    */
    lv_chainage := get_chain(pi_chainage => lv_chainage);
    --
    IF lv_chainage = -1
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                              ,pi_ner_id => 9260);
        RAISE invalid_record;
    END IF;
    /*
    ||If Loading Against A ROMIS Network
    ||Recalibrate The Chainage.
    */
    lv_chainage := recalibrate_chainage(pi_chainage   => lv_chainage
                                       ,pi_insp_start => lr_are.are_st_chain
                                       ,pi_insp_end   => lr_are.are_end_chain);
    /*
    ||Assign The Final Chainage Value To The Defect Record.
    */
    lr_def.def_st_chain := lv_chainage;
    /*
    ||Extract The Defect Location.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_locn);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lv_def_locn_descr)
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9268);
        RAISE invalid_record;
    END IF;
    /*
    || Truncate the defect location description to 40 characters
    || to avoid failure
    */
    lr_def.def_locn_descr := SUBSTR(lv_def_locn_descr,1,40);
    /*
    ||Get The Defect Time From The File.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_insp_time);
    /*
    ||Check The Defect Time.
    */
    IF lv_token IS NOT NULL
     AND check_time(pi_time => lv_token)
     THEN
        lr_def.def_inspection_date := lr_are.are_date_work_done;
        lr_def.def_time_hrs := TO_NUMBER(TO_CHAR(TO_DATE(lv_token,'HH24MI'),'HH24'));
        lr_def.def_time_mins := TO_NUMBER(TO_CHAR(TO_DATE(lv_token,'HH24MI'),'MI'));
    ELSE
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9261);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Identity Code.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_identcode);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_def.def_ident_code)
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9269);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Diagram Number.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_diagno);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_def.def_diagram_no)
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9270);
        RAISE invalid_record;
    END IF;
    /*
    ||Extract The Asset Type.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_invcode);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_def.def_ity_inv_code)
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9271);
        RAISE invalid_record;
    END IF;
    /*
    ||Process The Fields That Only Occur In The Enhanced Format File.
    */
    IF lv_enhanced
     THEN
        /*
        ||Extract The Inventory Change Indicator.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_i_rec_invind);
        IF NOT set_varchar2(pi_value   => lv_token
                           ,pio_target => lr_def.def_update_inv)
         THEN
            add_error_to_stack(pi_seq_no => lv_i_seq_no
                              ,pi_ner_id => 9285);
            RAISE invalid_record;
        END IF;
        /*
        ||Extract The SISS.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_i_rec_siss);
        IF lv_token IS NOT NULL
         THEN
            IF NOT set_varchar2(pi_value   => lv_token
                               ,pio_target => lr_def.def_siss_id)
             THEN
                add_error_to_stack(pi_seq_no => lv_i_seq_no
                                  ,pi_ner_id => 9263);
                RAISE invalid_record;
            END IF;
        ELSE
            lr_def.def_siss_id := 'ALL';
        END IF;
        /*
        ||Extract The Notifiable Org.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_i_rec_notifiable);
        IF lv_token IS NOT NULL
         THEN
            --
            lv_org_id := get_org_id(pi_org_code => lv_token);
            --
            IF lv_org_id IS NULL
             THEN
                add_error_to_stack(pi_seq_no => lv_i_seq_no
                                  ,pi_ner_id => 9264);
                RAISE invalid_record;
            ELSE
                lr_def.def_notify_org_id := lv_org_id;
            END IF;
        END IF;
        /*
        ||Extract The Recharge Org.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_i_rec_recharge);
        IF lv_token IS NOT NULL
         THEN
            --
            lv_org_id := get_org_id(pi_org_code => lv_token);
            --
            IF lv_org_id IS NULL
             THEN
                add_error_to_stack(pi_seq_no => lv_i_seq_no
                                  ,pi_ner_id => 9265);
                RAISE invalid_record;
            ELSE
                lr_def.def_rechar_org_id := lv_org_id;
            END IF;
        END IF;
        /*
        ||Special Instructions.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_i_rec_special_instr);
        IF NOT set_varchar2(pi_value   => lv_token
                           ,pio_target => lr_def.def_special_instr)
         THEN
            add_error_to_stack(pi_seq_no => lv_i_seq_no
                              ,pi_ner_id => 9267);
            RAISE invalid_record;
        END IF;

    END IF;
    /*
    ||Extract The Defect Description.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_i_rec_description);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lr_def.def_defect_descr)
     THEN
        add_error_to_stack(pi_seq_no => lv_i_seq_no
                          ,pi_ner_id => 9272);
        RAISE invalid_record;
    END IF;
    /*
    ||Set The Defect Section.
    */
    lr_def.def_rse_he_id := lr_are.are_rse_he_id;
    --
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_i_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
--        RAISE invalid_record;
        RAISE;
  END process_i_rec;
  --
  PROCEDURE process_j_rec(pi_i_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_j_seq_no    mai_insp_load_recs.milr_seq_no%TYPE;
    lv_j_rec_text  VARCHAR2(4000);
    lv_token       VARCHAR2(4000);
    lv_road_stud   VARCHAR2(1);
    lv_attr_value  VARCHAR2(254);
    --
  BEGIN
    /*
    ||Get The Values From The J Record;
    */
    lv_j_seq_no := lt_records(pi_i_rec_index+1).milr_seq_no;
    lv_j_rec_text := lt_records(pi_i_rec_index+1).milr_rec_text;
    /*
    ||Make Sure That A J Record Follows The I record .
    */
    IF lt_records(pi_i_rec_index+1).milr_rec_type != 'J'
     THEN
        add_error_to_stack(pi_seq_no => lv_j_seq_no
                          ,pi_ner_id => 9502);
        RAISE invalid_record;
    END IF;
    /*
    ||If Processing A Road Stud Defect Defect
    ||Strip The Last Field (Road Stud Indicator)
    ||From The Record.
    ||Need to do this because RMMS files don't contain a fixed
    ||number of fields so all we know is that the Road Stud
    ||indicator is the last one.
    */
    IF lr_def.def_atv_acty_area_code IN('RS','RC')
     THEN
        --
        lv_token := substr(lv_j_rec_text
                          ,instr(lv_j_rec_text,',',-1)+1
                          ,length(lv_j_rec_text) - instr(lv_j_rec_text,',',-1)+1);
        --
        IF NOT set_varchar2(pi_value   => lv_token
                           ,pio_target => lv_road_stud)
         THEN
            add_error_to_stack(pi_seq_no => lv_j_seq_no
                              ,pi_ner_id => 9273);
            RAISE invalid_record;
        END IF;
        --
        lv_j_rec_text := substr(lv_j_rec_text,1,instr(lv_j_rec_text,',',-1)-1);
        --
    END IF;
    nm_debug.debug('J Record = '||lv_j_rec_text);
    /*
    ||Now Tokenise And Process The Rest Of The Fields In The Record.
    */
    lt_tokens := tokenise_string(pi_string => lv_j_rec_text);
    /*
    ||Extract The Defect Type.
    */
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_j_rec_defcode);
    IF lv_token IS NOT NULL
     THEN
        IF NOT set_varchar2(pi_value   => lv_token
                           ,pio_target => lr_def.def_defect_code)
         THEN
            add_error_to_stack(pi_seq_no => lv_j_seq_no
                              ,pi_ner_id => 9274);
            RAISE invalid_record;
        END IF;
    ELSE
        add_error_to_stack(pi_seq_no => lv_j_seq_no
                          ,pi_ner_id => 9275);
        RAISE invalid_record;
    END IF;
    /*
    ||Process The Fields That Only Occur In The Enhanced Format File.
    */
    IF lv_enhanced
     THEN
        /*
        ||Extract The Priority.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_j_rec_def_priority);
        IF lv_token IS NOT NULL
         THEN
            IF NOT set_varchar2(pi_value   => lv_token
                               ,pio_target => lr_def.def_priority)
             THEN
                add_error_to_stack(pi_seq_no => lv_j_seq_no
                                  ,pi_ner_id => 9277);
                RAISE invalid_record;
            END IF;
        ELSE
            add_error_to_stack(pi_seq_no => lv_j_seq_no
                              ,pi_ner_id => 9276);
            RAISE invalid_record;
        END IF;
        /*
        ||Extract The Response Category.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_j_rec_def_category);
        IF NOT set_varchar2(pi_value   => lv_token
                           ,pio_target => lr_def.def_response_category)
         THEN
            add_error_to_stack(pi_seq_no => lv_j_seq_no
                              ,pi_ner_id => 9278);
            RAISE invalid_record;
        END IF;
        /*
        ||Extract The Asset Id.
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_j_rec_asset_id);
        IF check_number(pi_number => lv_token)
         THEN
            lr_def.def_iit_item_id := TO_NUMBER(lv_token);
        ELSE
            add_error_to_stack(pi_seq_no => lv_j_seq_no
                              ,pi_ner_id => 9279);
            RAISE invalid_record;
        END IF;
        /*
        ||Extract The Easting (X Co-ordinate).
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_j_rec_str_easting);
        IF check_number(pi_number => lv_token)
         THEN
            lr_def.def_easting := TO_NUMBER(lv_token);
        ELSE
            add_error_to_stack(pi_seq_no => lv_j_seq_no
                              ,pi_ner_id => 9280);
            RAISE invalid_record;
        END IF;
        /*
        ||Extract The Northing (Y Co-ordinate).
        */
        lv_token := get_token_value(pi_tokens   => lt_tokens
                                   ,pi_position => lv_j_rec_str_northing);
        IF check_number(pi_number => lv_token)
         THEN
            lr_def.def_northing := TO_NUMBER(lv_token);
        ELSE
            add_error_to_stack(pi_seq_no => lv_j_seq_no
                              ,pi_ner_id => 9281);
            RAISE invalid_record;
        END IF;
    END IF;
    /*
    ||Extract The Defect Attributes.
    */
    --Attribute 1
    nm_debug.debug('Setting Defect Attributes');
    --
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_j_rec_hhatt1);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lv_attr_value)
     THEN
        add_error_to_stack(pi_seq_no => lv_j_seq_no
                          ,pi_ner_id => 9282);
        RAISE invalid_record;
    ELSE
        lt_def_attr(1) := lv_attr_value;
    END IF;
    --Attribute 2
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_j_rec_hhatt2);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lv_attr_value)
     THEN
        add_error_to_stack(pi_seq_no => lv_j_seq_no
                          ,pi_ner_id => 9282);
        RAISE invalid_record;
    ELSE
        lt_def_attr(2) := lv_attr_value;
    END IF;
    --Attribute 3
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_j_rec_hhatt3);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lv_attr_value)
     THEN
        add_error_to_stack(pi_seq_no => lv_j_seq_no
                          ,pi_ner_id => 9282);
        RAISE invalid_record;
    ELSE
        lt_def_attr(3) := lv_attr_value;
    END IF;
    --Attribute 4
    lv_token := get_token_value(pi_tokens   => lt_tokens
                               ,pi_position => lv_j_rec_hhatt4);
    IF NOT set_varchar2(pi_value   => lv_token
                       ,pio_target => lv_attr_value)
     THEN
        add_error_to_stack(pi_seq_no => lv_j_seq_no
                          ,pi_ner_id => 9282);
        RAISE invalid_record;
    ELSE
        lt_def_attr(4) := lv_attr_value;
    END IF;
    --
    nm_debug.debug('Defect Attributes Set');
    /*
    ||Got This Far So Set The Inspection and Defect Ids.
    */
    lr_def.def_are_report_id := lr_are.are_report_id;
    lr_def.def_defect_id := mai_inspection_api.get_next_id('DEF_DEFECT_ID_SEQ');
    --
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        nm_debug.debug(SQLERRM);
        add_error_to_stack(pi_seq_no             => lv_j_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
--        RAISE invalid_record;
        RAISE;
  END process_j_rec;
  --
  PROCEDURE process_d_rec(pi_d_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_d_seq_no    mai_insp_load_recs.milr_seq_no%TYPE;
    lv_token       VARCHAR2(4000);
    lv_index       BINARY_INTEGER;
    lv_doc_id      docs.doc_id%TYPE;
    --
  BEGIN
    /*
    ||Get The Values From The d Record;
    */
    lv_d_seq_no := lt_records(pi_d_rec_index).milr_seq_no;
    /*
    ||Tokenise The Fields In The Record.
    */
    lt_tokens := tokenise_string(pi_string => lt_records(pi_d_rec_index).milr_rec_text);
    --
    lv_index  := lt_das_tab.count+1;
    /*
    ||Get DOC_ID Sequence
    */
    lv_doc_id := mai_inspection_api.get_next_id(pi_seq_name => 'DOC_ID_SEQ');
    lt_das_tab(lv_index).das_doc_id     := lv_doc_id;
    /*
    ||Extract Type.
    */
    lt_das_tab(lv_index).das_dtp_code := get_token_value(pi_tokens   => lt_tokens 
                                                        ,pi_position => 1);
    /*
    ||Extract Title.
    */
    lt_das_tab(lv_index).das_title := get_token_value(pi_tokens   => lt_tokens 
                                                     ,pi_position => 2);
    /*
    ||Extract Description.
    */
    lt_das_tab(lv_index).das_descr := get_token_value(pi_tokens   => lt_tokens 
                                                     ,pi_position => 3);
    /*
    ||Extract Category.
    */
    lt_das_tab(lv_index).das_category := get_token_value(pi_tokens   => lt_tokens 
                                                        ,pi_position => 4);
    /*
    ||Extract Location.
    */
    lt_das_tab(lv_index).das_location := get_token_value(pi_tokens   => lt_tokens 
                                                        ,pi_position => 5);
    /*
    ||Extract Filename.
    */
    lt_das_tab(lv_index).das_file := get_token_value(pi_tokens   => lt_tokens 
                                                    ,pi_position => 6);
    /*
    ||Set The Report Id.
    */
    lt_das_tab(lv_index).das_are_report_id := lr_are.are_report_id;
    /*
    ||Set The Defect Id.
    */
    lt_das_tab(lv_index).das_def_defect_id := lr_def.def_defect_id;

    --
  EXCEPTION
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_d_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
        RAISE;
  END process_d_rec;
  --
  --
  PROCEDURE process_repair_recs(pi_start_index IN BINARY_INTEGER
                               ,pi_end_index   IN BINARY_INTEGER)
    IS
    --
    lv_seq_no           mai_insp_load_recs.milr_seq_no%TYPE;
    lv_boq_seq_no       mai_insp_load_recs.milr_seq_no%TYPE;
    lv_token            VARCHAR2(4000);
    lv_rec_type         mai_insp_load_recs.milr_rec_type%TYPE;
    lv_priority         defects.def_priority%TYPE;
    lv_dflt_treat_code  repairs.rep_tre_treat_code%TYPE;
    lv_file_date        VARCHAR2(10);
    j                   PLS_INTEGER;
    --
    lr_rep      repairs%ROWTYPE;
    lr_boq      boq_items%ROWTYPE;
    lt_boqs     mai_inspection_api.boq_tab;
    --
    lt_boq_tokens  nm3type.tab_varchar4000;
    --
    lv_k_rec_found  BOOLEAN := FALSE;
    lv_l_rec_found  BOOLEAN := FALSE;
    lv_m_rec_found  BOOLEAN := FALSE;
    lv_n_rec_found  BOOLEAN := FALSE;
    --
  BEGIN
    --
    FOR i IN (pi_start_index)..(pi_end_index-1) LOOP
      --
      lv_seq_no   := lt_records(i).milr_seq_no;
      lt_tokens   := tokenise_string(pi_string => lt_records(i).milr_rec_text);
      lv_rec_type := lt_records(i).milr_rec_type;
      --
      IF lv_rec_type = 'D'
       THEN
          /*
          ||Add The Document Association To
          ||The Store To Be Processed Later.
          */
          process_d_rec(pi_d_rec_index =>i);
          
      ELSIF lv_rec_type IN('K','L','M','N')
       THEN
          /*
          ||Extract The Repair Description.
          */
          lv_token := get_token_value(pi_tokens   => lt_tokens
                                     ,pi_position => 1);
          IF lv_token IS NOT NULL
           THEN
              IF NOT set_varchar2(pi_value   => lv_token
                                 ,pio_target => lr_rep.rep_descr)
               THEN
                  add_error_to_stack(pi_seq_no => lv_seq_no
                              ,pi_ner_id => 9283);
                  RAISE invalid_record;
              END IF;
          END IF;
          /*
          ||If Record Type Is K, L or M get the Date/Time Complete.
          */
          IF lv_rec_type IN('K','L','M')
           THEN
              lv_token := get_token_value(pi_tokens   => lt_tokens
                                         ,pi_position => 2);
              nm_debug.debug('File repair complete date = '||lv_token);
              /*
              ||Completed Date/Time are optional on L and M records
              ||this can either be a NULL value of zero padded.
              */
              IF lv_token IS NOT NULL
               AND lv_token != '000000'
               THEN
                  IF check_date(pi_date => lv_token)
                   THEN
                      /*
                      ||Store The Completion Date From The File.
                      */
                      lv_file_date := lv_token;
                      /*
                      ||Get The Completion Time From The File.
                      */
                      lv_token := get_token_value(pi_tokens   => lt_tokens
                                                 ,pi_position => 3);
                      /*
                      ||Check The Completion Time.
                      */
                      IF lv_token IS NOT NULL
                       THEN
                          IF check_time(pi_time => lv_token)
                           THEN
                              lr_rep.rep_date_completed := TO_DATE(lv_file_date,'RRMMDD');
                              lr_rep.rep_completed_hrs := TO_NUMBER(TO_CHAR(TO_DATE(lv_token,'HH24MI'),'HH24'));
                              lr_rep.rep_completed_mins := TO_NUMBER(TO_CHAR(TO_DATE(lv_token,'HH24MI'),'MI'));
                          ELSE
                              --Raise an Error
                              add_error_to_stack(pi_seq_no => lv_seq_no
                                                ,pi_ner_id => 9511);
                              RAISE invalid_record;
                          END IF;
                      ELSE
                          /*
                          ||No Time Element In File So Raise An Error.
                          */
                          add_error_to_stack(pi_seq_no => lv_seq_no
                                            ,pi_ner_id => 9511);
                          RAISE invalid_record;
                      END IF;
                  ELSE
                      --Raise Error And Stop The Load.
                      add_error_to_stack(pi_seq_no => lv_seq_no
                                        ,pi_ner_id => 9510);
                      RAISE invalid_record;
                  END IF;
              ELSIF lv_rec_type = 'K'
               THEN
                  /*
                  ||Completion Date and Time are mandatory
                  ||for Immediate repairs.
                  */
                  add_error_to_stack(pi_seq_no => lv_seq_no
                                    ,pi_ner_id => 9510);
                  RAISE invalid_record;
              END IF;
          END IF;
          /*
          ||Get The Treatment Code.
          */
          IF lv_rec_type IN('L','M','N')
           THEN
              --
              IF lv_rec_type = 'N'
               THEN
                  lv_token := get_token_value(pi_tokens   => lt_tokens
                                             ,pi_position => 2);
              ELSE
                  lv_token := get_token_value(pi_tokens   => lt_tokens
                                             ,pi_position => 4);
              END IF;
              --
              IF lv_token IS NOT NULL
               THEN
                  IF NOT set_varchar2(pi_value   => lv_token
                                     ,pio_target => lr_rep.rep_tre_treat_code)
                   THEN
                      add_error_to_stack(pi_seq_no => lv_seq_no
                                        ,pi_ner_id => 9400);
                      RAISE invalid_record;
                  END IF;
              END IF;
          END IF;
          /*
          ||Get The Priority 2 Sub Category.
          */
          IF lv_rec_type = 'N'
           THEN
              lv_token := get_token_value(pi_tokens   => lt_tokens
                                         ,pi_position => 3);
              IF check_number(pi_number => lv_token)
               THEN
                  CASE TO_NUMBER(lv_token)
                    WHEN 1
                     THEN
                        lv_priority := '2.1';
                    WHEN 2
                     THEN
                        lv_priority := '2.2';
                    WHEN 3
                     THEN
                        lv_priority := '2.3';
                    ELSE
                        lv_priority := '1';
                  END CASE;
                  --
              ELSE
                 add_error_to_stack(pi_seq_no => lv_seq_no
                                   ,pi_ner_id => 9276);
                 RAISE invalid_record;
              END IF;
              --
          END IF;
          /*
          ||If Not An Enhanced Format File Set The Defect
          ||Priority Based On The Type Of Repair.
          */
          IF NOT lv_enhanced
           THEN
              IF lv_rec_type IN('K','L','M')
               THEN
                  lr_def.def_priority := '1';
              ELSE
                  lr_def.def_priority := lv_priority;
              END IF;
          END IF;
          /*
          ||If The Treatment Specified Is "No Action" And The Network
          ||In Use Is Rommis Sections Check For A Default Treatment.
          */
          IF lr_rep.rep_tre_treat_code = '/'
           AND lv_romsec
           THEN
              lv_dflt_treat_code := mai_inspection_api.get_default_treatment(pi_defect_type => lr_def.def_defect_code
                                                                            ,pi_priority    => lr_def.def_priority
                                                                            ,pi_activity    => lr_def.def_atv_acty_area_code);
              IF lv_dflt_treat_code IS NOT NULL
               THEN
                  lr_rep.rep_tre_treat_code := lv_dflt_treat_code;
              END IF;
          END IF;
          /*
          ||Set The Repair Type.
          */
          CASE lv_rec_type
            WHEN 'K'
             THEN
                lr_rep.rep_action_cat := 'I';
                lv_k_rec_found := TRUE;
            WHEN 'L'
             THEN
                lr_rep.rep_action_cat := 'T';
                lv_l_rec_found := TRUE;
            WHEN 'M'
             THEN
                lr_rep.rep_action_cat := 'P';
                lv_m_rec_found := TRUE;
            WHEN 'N'
             THEN
                lr_rep.rep_action_cat := 'P';
                lv_n_rec_found := TRUE;
          END CASE;
          /*
          ||Set The Defect Id.
          */
          lr_rep.rep_def_defect_id := lr_def.def_defect_id;
          /*
          ||Assign the rse_he_id
          */
          lr_rep.rep_rse_he_id := lr_def.def_rse_he_id;
          /*
          ||Assign the Activity Area Code
          */
          lr_rep.rep_atv_acty_area_code := lr_def.def_atv_acty_area_code;
          /*
          ||Check For BOQs Related To The Repair.
          */
          IF lt_records(i+1).milr_rec_type = 'Q'
           THEN
              IF lt_records(i).milr_rec_type != 'K'
               THEN
                  j := i+1;
                  WHILE lt_records(j).milr_rec_type = 'Q' LOOP
                    /*
                    ||Tokenise The Record.
                    */
                    lv_boq_seq_no := lt_records(j).milr_seq_no;
                    lt_boq_tokens := tokenise_string(pi_string => lt_records(j).milr_rec_text);
                    /*
                    ||Get The Standard Item Code.
                    */
                    lv_token := get_token_value(pi_tokens   => lt_boq_tokens
                                               ,pi_position => 1);
                    IF lv_token IS NOT NULL
                     THEN
                        IF NOT set_varchar2(pi_value   => lv_token
                                           ,pio_target => lr_boq.boq_sta_item_code)
                         THEN
                            add_error_to_stack(pi_seq_no => lv_boq_seq_no
                                              ,pi_ner_id => 9512);
                            RAISE invalid_record;
                        END IF;
                    ELSE
                        add_error_to_stack(pi_seq_no => lv_boq_seq_no
                                          ,pi_ner_id => 9512);
                        RAISE invalid_record;
                    END IF;
                    /*
                    ||Get The Dimension 1 Value.
                    */
                    lv_token := get_token_value(pi_tokens   => lt_boq_tokens
                                               ,pi_position => 2);
                    IF lv_token IS NOT NULL
                     THEN
                        IF check_number(pi_number => lv_token)
                         THEN
                            lr_boq.boq_est_dim1 := TO_NUMBER(lv_token);
                        ELSE
                            add_error_to_stack(pi_seq_no             => lv_boq_seq_no
                                              ,pi_ner_id             => 9284
                                              ,pi_supplementary_info => '(1)');
                            RAISE invalid_record;
                        END IF;
                    ELSE
                        add_error_to_stack(pi_seq_no             => lv_boq_seq_no
                                          ,pi_ner_id             => 9284
                                          ,pi_supplementary_info => '(1)');
                        RAISE invalid_record;
                    END IF;
                    /*
                    ||Get The Dimension 2 Value.
                    */
                    lv_token := get_token_value(pi_tokens   => lt_boq_tokens
                                               ,pi_position => 3);
                    IF lv_token IS NOT NULL
                     THEN
                        IF check_number(pi_number => lv_token)
                         THEN
                            lr_boq.boq_est_dim2 := TO_NUMBER(lv_token);
                        ELSE
                            add_error_to_stack(pi_seq_no             => lv_boq_seq_no
                                              ,pi_ner_id             => 9284
                                              ,pi_supplementary_info => '(2)');
                            RAISE invalid_record;
                        END IF;
                    END IF;
                    /*
                    ||Get The Dimension 3 Value.
                    */
                    lv_token := get_token_value(pi_tokens   => lt_boq_tokens
                                               ,pi_position => 4);
                    IF lv_token IS NOT NULL
                     THEN
                        IF check_number(pi_number => lv_token)
                         THEN
                            lr_boq.boq_est_dim3 := TO_NUMBER(lv_token);
                        ELSE
                            add_error_to_stack(pi_seq_no             => lv_boq_seq_no
                                              ,pi_ner_id             => 9284
                                              ,pi_supplementary_info => '(3)');
                            RAISE invalid_record;
                        END IF;
                    END IF;
                    /*
                    ||Don't Worry About The Quantity In The File.
                    ||The API Will Calculate The Quantity From The
                    ||Given Dimensions Anyway.
                    ||
                    lv_token := get_token_value(pi_tokens   => lt_boq_tokens
                                               ,pi_position => 5);
                    IF lv_token IS NOT NULL
                     AND check_number(pi_number => lv_token)
                     THEN
                        lr_boq.boq_est_quantity := TO_NUMBER(lv_token);
                    END IF;
                    */

                    /*
                    ||Add The Current BOQ To The Table Of BOQs.
                    */
                    lr_boq.boq_id := mai_inspection_api.get_next_id('BOQ_ID_SEQ');
                    lr_boq.boq_defect_id := lr_def.def_defect_id;
                    lr_boq.boq_rep_action_cat := lr_rep.rep_action_cat;
                    mai_inspection_api.add_boq_to_boq_tab(pi_boq_rec  => lr_boq
                                                         ,pio_boq_tab => lt_boqs);
                    lr_boq := NULL;
                    --
                    j := j+1;
                    --
                  END LOOP;
              ELSE
                  /*
                  ||BOQs Are Not Allowed For Immediate Repairs.
                  */
                  add_error_to_stack(pi_seq_no => lt_records(i+1).milr_seq_no
                                    ,pi_ner_id => 9517);
                  RAISE invalid_record;
              END IF;
          END IF;
          /*
          ||Add The Repair To The Table Of Repairs.
          */
          mai_inspection_api.add_rep_to_rep_tab(pi_rep_rec  => lr_rep
                                               ,pio_rep_tab => lt_repairs);
          lr_rep := NULL;
          /*
          ||Add The Table Of BOQs To The Table Of Repairs.
          */
          mai_inspection_api.add_boq_tab_to_rep_tab(pi_boq_tab  => lt_boqs
                                                   ,pio_rep_tab => lt_repairs);
          lt_boqs.delete;
          --
      END IF;
    END LOOP;
    --
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
        RAISE invalid_record;
        --RAISE;
  END process_repair_recs;
  --
  PROCEDURE process_defect_recs(pi_h_rec_index IN BINARY_INTEGER
                               ,pi_p_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_seq_no     mai_insp_load_recs.milr_seq_no%TYPE;
    lv_token      VARCHAR2(4000);
    lv_end_index  BINARY_INTEGER;
    --
    lt_i_rec_index rec_index_tab;
    --
  BEGIN
    /*
    ||Establish The Indexes To Access The I Records.
    */
    FOR i IN (pi_h_rec_index+1) .. (pi_p_rec_index-1) LOOP
      IF lt_records(i).milr_rec_type = 'I'
       THEN
          lt_i_rec_index(lt_i_rec_index.count+1) := i;
      END IF;
    END LOOP;
    /*
    ||Process The I Records.
    */
    FOR i IN 1..lt_i_rec_index.count LOOP
      --
      process_i_rec(pi_i_rec_index => lt_i_rec_index(i));
      process_j_rec(pi_i_rec_index => lt_i_rec_index(i));
      /*
      ||Set The Index Of The Next I record As The End
      ||Of The Current Defect Block.
      ||If Processing The Last Defect In The Inspection
      ||The End Of The Current Defect Block Will Be The
      ||Index Of The P Record.
      */
      IF i < lt_i_rec_index.count
       THEN
          lv_end_index := lt_i_rec_index(i+1);
      ELSE
          lv_end_index := pi_p_rec_index;
      END IF;
      --
      process_repair_recs(pi_start_index => lt_i_rec_index(i) + 1 /* Incremented to Account For The J Record. */
                         ,pi_end_index   => lv_end_index);
      --
nm_debug.debug('Adding Defect To API Params');
nm_debug.debug('Def Priority = '||lr_def.def_priority);
      /*
      ||Add The Defect To The Table Of Defects.
      */
      mai_inspection_api.add_def_to_def_tab(pi_def_rec  => lr_def
                                           ,pio_def_tab => lt_defects);
      lr_def := NULL;
      /*
      ||Add The Defect Attributes Table To The Table Of Defects.
      */
      mai_inspection_api.add_def_attr_tab_to_def_tab(pi_def_attr_tab => lt_def_attr
                                                    ,pio_def_tab     => lt_defects);
      lt_def_attr.delete;
      /*
      ||Add The Table Of Repairs To The Table of Defects.
      */
      mai_inspection_api.add_rep_tab_to_def_tab(pi_rep_tab  => lt_repairs
                                               ,pio_def_tab => lt_defects);
      lt_repairs.delete;
      /*
      ||Add any Doc assocs to defect rec.
      */
      mai_inspection_api.add_das_tab_to_def_tab(pi_das_tab  => lt_das_tab
                                               ,pio_def_tab => lt_defects);
      lt_repairs.delete;
    END LOOP;
    /*
    ||If Recalibration Has Occured Set The Inspection
    ||End Chainage To The Section Length.
    */
    IF lv_recal_done
     THEN
        lr_are.are_end_chain := lv_rse_length;
    END IF;
    --
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
        --RAISE invalid_record;
        RAISE;
  END process_defect_recs;
  --
  PROCEDURE inc_rec_count(pi_rec_type IN VARCHAR2)
    IS
  BEGIN
    /*
    ||Increment The Record Count
    ||For The Given Record Type.
    */
    lt_rec_counts(pi_rec_type) := lt_rec_counts(pi_rec_type) + 1;
    --
  EXCEPTION
    WHEN no_data_found
     THEN
        /*
        ||First Time The Procedure Has Been
        ||Called For The Given Record Type
        ||So Set The Count To 1.
        */
        lt_rec_counts(pi_rec_type) := 1;
  END inc_rec_count;
  --
  FUNCTION get_rec_count(pi_rec_type IN VARCHAR2)
    RETURN BINARY_INTEGER IS
  BEGIN
    /*
    ||Return The Record Count For The Given Record Type.
    */
    RETURN lt_rec_counts(pi_rec_type);
    --
  EXCEPTION
    WHEN others
     THEN
        /*
        ||Chances Are That This Is A no_data_found Exception
        ||i.e. A Count Has Not Been Set For The Given Record
        ||Type So Return 0.
        */
        RETURN 0;
  END get_rec_count;
  --
  PROCEDURE set_x_rec_count(pi_rec_type IN VARCHAR2
                           ,pi_count    IN PLS_INTEGER)
    IS
  BEGIN
    --
    lt_x_rec_counts(lt_x_rec_counts.count+1).rec_type := pi_rec_type;
    lt_x_rec_counts(lt_x_rec_counts.count).rec_count := NVL(pi_count,0);
    --
  END set_x_rec_count;
  --
  FUNCTION check_rec_counts(pi_x_rec_counts IN x_rec_counts_tab)
    RETURN BOOLEAN IS
    --
    lv_retval BOOLEAN := TRUE;
    --
  BEGIN
    --
    FOR i IN 1..pi_x_rec_counts.count LOOP
      --
nm_debug.debug('Checking Record Type '||pi_x_rec_counts(i).rec_type||', X rec Count = '||pi_x_rec_counts(i).rec_count||' File Count = '||get_rec_count(pi_rec_type => pi_x_rec_counts(i).rec_type));
      IF pi_x_rec_counts(i).rec_count != get_rec_count(pi_rec_type => pi_x_rec_counts(i).rec_type)
       THEN
          lv_retval := FALSE;
          exit;
      END IF;
      --
    END LOOP;
    --
    RETURN lv_retval;
    --
  END check_rec_counts;
  --
  PROCEDURE process_x_rec(pi_x_rec_index IN BINARY_INTEGER)
    IS
    --
    lv_seq_no mai_insp_load_recs.milr_seq_no%TYPE;
    --
  BEGIN
    lv_seq_no := lt_records(pi_x_rec_index).milr_seq_no;
    --
    lt_tokens := tokenise_string(pi_string => lt_records(pi_x_rec_index).milr_rec_text);
    /*
    ||Check That The Number Of Records Specified
    ||In The X Record Match The Contents Of The File.
    */
    IF lt_tokens.count IN(12,13) AND lv_enhanced
     THEN
        --
        set_x_rec_count(pi_rec_type => 'G', pi_count => lt_tokens(1));
        set_x_rec_count(pi_rec_type => 'H', pi_count => lt_tokens(2));
        set_x_rec_count(pi_rec_type => 'I', pi_count => lt_tokens(3));
        set_x_rec_count(pi_rec_type => 'J', pi_count => lt_tokens(4));
        --
        IF lt_tokens.count = 12
         THEN
            set_x_rec_count(pi_rec_type => 'K', pi_count => lt_tokens(5));
            set_x_rec_count(pi_rec_type => 'L', pi_count => lt_tokens(6));
            set_x_rec_count(pi_rec_type => 'M', pi_count => lt_tokens(7));
            set_x_rec_count(pi_rec_type => 'N', pi_count => lt_tokens(8));
            set_x_rec_count(pi_rec_type => 'P', pi_count => lt_tokens(9));
            set_x_rec_count(pi_rec_type => 'Q', pi_count => lt_tokens(10));
            set_x_rec_count(pi_rec_type => 'R', pi_count => lt_tokens(11));
            set_x_rec_count(pi_rec_type => 'S', pi_count => lt_tokens(12));
        ELSE
            set_x_rec_count(pi_rec_type => 'D', pi_count => lt_tokens(5));
            set_x_rec_count(pi_rec_type => 'K', pi_count => lt_tokens(6));
            set_x_rec_count(pi_rec_type => 'L', pi_count => lt_tokens(7));
            set_x_rec_count(pi_rec_type => 'M', pi_count => lt_tokens(8));
            set_x_rec_count(pi_rec_type => 'N', pi_count => lt_tokens(9));
            set_x_rec_count(pi_rec_type => 'P', pi_count => lt_tokens(10));
            set_x_rec_count(pi_rec_type => 'Q', pi_count => lt_tokens(11));
            set_x_rec_count(pi_rec_type => 'R', pi_count => lt_tokens(12));
            set_x_rec_count(pi_rec_type => 'S', pi_count => lt_tokens(13));
        END IF;
        --
    ELSIF lt_tokens.count >= 9
     THEN
        set_x_rec_count(pi_rec_type => 'G', pi_count => lt_tokens(1));
        set_x_rec_count(pi_rec_type => 'H', pi_count => lt_tokens(2));
        set_x_rec_count(pi_rec_type => 'I', pi_count => lt_tokens(3));
        set_x_rec_count(pi_rec_type => 'J', pi_count => lt_tokens(4));
        set_x_rec_count(pi_rec_type => 'K', pi_count => lt_tokens(5));
        set_x_rec_count(pi_rec_type => 'L', pi_count => lt_tokens(6));
        set_x_rec_count(pi_rec_type => 'M', pi_count => lt_tokens(7));
        set_x_rec_count(pi_rec_type => 'N', pi_count => lt_tokens(8));
        set_x_rec_count(pi_rec_type => 'P', pi_count => lt_tokens(9));
    ELSE
        add_error_to_stack(pi_seq_no => lv_seq_no
                          ,pi_ner_id => 9010);
        RAISE invalid_record;
    END IF;
    --
    IF NOT check_rec_counts(pi_x_rec_counts => lt_x_rec_counts)
     THEN
        add_error_to_stack(pi_seq_no => lv_seq_no
                          ,pi_ner_id => 9011);
        RAISE invalid_record;
    END IF;
    --
    IF get_rec_count(pi_rec_type => 'G') != get_rec_count(pi_rec_type => 'H')
     OR get_rec_count(pi_rec_type => 'G') != get_rec_count(pi_rec_type => 'P')
     THEN
        add_error_to_stack(pi_seq_no => lv_seq_no
                          ,pi_ner_id => 9014);
        RAISE invalid_record;
    END IF;
  EXCEPTION
    WHEN invalid_record
     THEN
        process_error_stack;
        RAISE;
    WHEN others
     THEN
        add_error_to_stack(pi_seq_no             => lv_seq_no
                          ,pi_ner_id             => 9107
                          ,pi_supplementary_info => SQLERRM);
        process_error_stack;
--        RAISE invalid_record;
        RAISE;
  END process_x_rec;
  --
  PROCEDURE validate_file
    IS
  BEGIN
    /*
    ||Get The Records From mai_insp_load_recs
    */
    get_records(pi_batch_id => pi_batch_id);
    /*
    ||File Must Start With Either A '1' Or A 'G' Record.
    */
    IF lt_records(1).milr_rec_type = '1'
     THEN
        --Log "INFO: Processing RMMS format data file." (Should really be an NM_ERROR)
        hig_process_api.log_it('Processing RMMS format data file.');
        lv_enhanced := TRUE;
        set_enhanced_rec_pos;
    ELSIF lt_records(1).milr_rec_type = 'G'
     THEN
        --Log "INFO: Processing ENHANCED format data file." (Should really be an NM_ERROR)
        hig_process_api.log_it('Processing ENHANCED format data file.');
    ELSE
        add_error_to_stack(pi_seq_no => lt_records(1).milr_seq_no
                          ,pi_ner_id => 9009);
        RAISE invalid_file;
    END IF;
    /*
    ||Loop Through The Records To Validate
    ||The Record Sequence And X Record Counts.
    */
    FOR i IN 1..lt_records.count LOOP
      /*
      ||Check The Sequence Of Record Types.
      */
      IF i > 1
       THEN
          /*
          ||Not The First Record So Check The Previous Record Type
          ||To Make Sure The Current Record Type Is Allowed To Follow It.
          */
          CASE lt_records(i-1).milr_rec_type
            WHEN '1'
             THEN
                IF lt_records(i).milr_rec_type != 'G'
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9520);
                    RAISE invalid_file;
                END IF;
            WHEN 'G'
             THEN
                /*
                ||Store The Index Of G Records For Later Processing.
                */
                lt_g_rec_index(lt_g_rec_index.count+1) := i-1;
                --
                IF lt_records(i).milr_rec_type != 'H'
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9521);
                    RAISE invalid_file;
                END IF;
            WHEN 'H'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('I','P','R')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9522);
                    RAISE invalid_file;
                END IF;
            WHEN 'I'
             THEN
                IF lt_records(i).milr_rec_type != 'J'
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9523);
                    RAISE invalid_file;
                END IF;
            WHEN 'J'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('D','K','L','M','N')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9524);
                    RAISE invalid_file;
                END IF;
            WHEN 'D'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('D','K','L','M','N')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9525);
                    RAISE invalid_file;
                END IF;
            WHEN 'K'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('L','M','N','P','R')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9526);
                    RAISE invalid_file;
                END IF;
            WHEN 'L'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('M','N','P','Q','R')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9527);
                    RAISE invalid_file;
                END IF;
            WHEN 'M'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('I','P','Q','R')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9528);
                    RAISE invalid_file;
                END IF;
            WHEN 'N'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('I','P','Q','R')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9529);
                    RAISE invalid_file;
                END IF;
            WHEN 'P'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('G','S','X')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9530);
                    RAISE invalid_file;
                END IF;
            WHEN 'Q'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('I','M','N','P','Q','R')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9531);
                    RAISE invalid_file;
                END IF;
            WHEN 'R'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('R','P')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9532);
                    RAISE invalid_file;
                END IF;
            WHEN 'S'
             THEN
                IF lt_records(i).milr_rec_type NOT IN('S','X')
                 THEN
                    add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                      ,pi_ner_id => 9533);
                    RAISE invalid_file;
                END IF;
            WHEN 'X'
             THEN
                add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                  ,pi_ner_id => 9534);
                RAISE invalid_file;
            ELSE
              --ERROR: unknown husky hunter record type BPR-8008
              add_error_to_stack(pi_seq_no => lt_records(i).milr_seq_no
                                ,pi_ner_id => 9534);RAISE invalid_file;
          END CASE;
      END IF;
      /*
      ||Increment the record count.
      */
      inc_rec_count(pi_rec_type => lt_records(i).milr_rec_type);
      --
      IF lt_records(i).milr_rec_type = 'X'
       THEN
          process_x_rec(pi_x_rec_index => i);
      END IF;
      --
    END LOOP;
    /*
    ||The File Record Sequence Is Correct So Loop
    ||Through The Records Again And Extract The Data.
    */
    FOR i IN 1..lt_g_rec_index.count LOOP
      --
      BEGIN
        /*
        ||Extract The Data From The G Record.
        */
nm_debug.debug('Calling process_g_rec');
        process_g_rec(pi_g_rec_index => lt_g_rec_index(i));
        /*
        ||Get The P Record To Find The Inspection Start And End Chainage.
        */
        lv_p_rec_index := get_next_rec_index(pi_rec_type      => 'P'
                                            ,pi_current_index => lt_g_rec_index(i));
nm_debug.debug('Calling process_p_rec');
        IF lv_p_rec_index IS NOT NULL
         THEN
            process_p_rec(pi_p_rec_index => lv_p_rec_index);
        ELSE
            add_error_to_stack(pi_seq_no => lt_records(lt_g_rec_index(i)).milr_seq_no
                              ,pi_ner_id => 9602);
            RAISE invalid_file;
        END IF;
        /*
        ||Get The H Record And Process The Activity Codes.
        */
        lv_h_rec_index := get_next_rec_index(pi_rec_type      => 'H'
                                            ,pi_current_index => lt_g_rec_index(i));
nm_debug.debug('Calling process_h_rec');
        IF lv_h_rec_index IS NOT NULL
         THEN
            process_h_rec(pi_h_rec_index => lv_h_rec_index);
        ELSE
            add_error_to_stack(pi_seq_no => lt_records(lt_g_rec_index(i)).milr_seq_no
                              ,pi_ner_id => 9220);
            RAISE invalid_file;
        END IF;
        /*
        ||If There Are Defect Records To Process Then Do So.
        ||i.e. The Are Records Between The H and P Records.
        */
nm_debug.debug('Calling process_defect_recs');
        IF lv_p_rec_index - lv_h_rec_index > 1
         THEN
            process_defect_recs(pi_h_rec_index => lv_h_rec_index
                               ,pi_p_rec_index => lv_p_rec_index);
        END IF;
        /*
        ||Get The R Record And Process any Comments.
        */
        lv_r_rec_index := get_next_rec_index(pi_rec_type      => 'R'
                                            ,pi_current_index => lt_g_rec_index(i));
nm_debug.debug('Calling process_r_recs');
        IF lv_r_rec_index IS NOT NULL
         THEN
            process_r_rec(pi_r_rec_index => lv_r_rec_index,
                          pi_p_rec_index => lv_p_rec_index);
        END IF;
        /*
        ||Whole Inspection Passed Validation So Far
        ||So Add It To The Params For The Inspection API.
        */
        mai_inspection_api.add_are_to_insp_tab(pi_are_rec   => lr_are
                                              ,pio_insp_tab => lt_api_params);
        lr_are := NULL;
        lt_seq_no_tab(lt_api_params.count).g_seq_no := lt_records(lt_g_rec_index(i)).milr_seq_no;
        lt_seq_no_tab(lt_api_params.count).p_seq_no := lt_records(lv_p_rec_index).milr_seq_no;
        --
        mai_inspection_api.add_activities_tab_to_insp_tab(pi_activities_tab => lt_activities
                                                         ,pio_insp_tab      => lt_api_params);
        lt_activities.delete;
        --
        mai_inspection_api.add_def_tab_to_insp_tab(pi_def_tab   => lt_defects
                                                  ,pio_insp_tab => lt_api_params);
        lt_defects.delete;
        --
        mai_inspection_api.add_comm_tab_to_insp_tab(pi_com_tab   => lt_com_tab
                                                   ,pio_insp_tab => lt_api_params);
        lt_com_tab.delete;
    --
      EXCEPTION
        WHEN others
         THEN
            process_error_stack;
            --RAISE invalid_file;
            RAISE;
      END;
    END LOOP;
    --
  EXCEPTION
    WHEN others
     THEN
        --RAISE invalid_file;
        RAISE;
  END validate_file;
  --
BEGIN
  nm_debug.debug_on;
  /*
  ||Validate File Format.
  */
  validate_file;
  /*
  ||Pass The Data Back To The Calling Procedure.
  */
  --pio_seq_no_tab := lt_seq_no_tab;
  pio_api_params := lt_api_params;
  --
EXCEPTION
  WHEN invalid_record then
      nm_debug.debug('Raised invalid_record'); --clb
      RAISE;
  WHEN invalid_file
   THEN
      process_error_stack;
      nm_debug.debug('Invalid File raised');
      RAISE; --clb
  WHEN others
   THEN
      RAISE;
END process_rmms_or_eid_file;

PROCEDURE move_insp_to_error_tabs(pi_insp_rec IN mai_inspection_api.insp_rec)
  IS
BEGIN
  /*
  ||Insert Activities Report.
  */
  INSERT
    INTO mai_insp_load_error_are
        (are_report_id
        ,are_rse_he_id
        ,are_batch_id
        ,are_created_date
        ,are_last_updated_date
        ,are_maint_insp_flag
        ,are_sched_act_flag
        ,are_date_work_done
        ,are_end_chain
        ,are_initiation_type
        ,are_insp_load_date
        ,are_peo_person_id_actioned
        ,are_peo_person_id_insp2
        ,are_st_chain
        ,are_surface_condition
        ,are_weather_condition
        ,are_wol_works_order_no
        ,are_error)
  VALUES(pi_insp_rec.insp_record.are_report_id
        ,pi_insp_rec.insp_record.are_rse_he_id
        ,pi_insp_rec.insp_record.are_batch_id
        ,pi_insp_rec.insp_record.are_created_date
        ,pi_insp_rec.insp_record.are_last_updated_date
        ,pi_insp_rec.insp_record.are_maint_insp_flag
        ,pi_insp_rec.insp_record.are_sched_act_flag
        ,pi_insp_rec.insp_record.are_date_work_done
        ,pi_insp_rec.insp_record.are_end_chain
        ,pi_insp_rec.insp_record.are_initiation_type
        ,pi_insp_rec.insp_record.are_insp_load_date
        ,pi_insp_rec.insp_record.are_peo_person_id_actioned
        ,pi_insp_rec.insp_record.are_peo_person_id_insp2
        ,pi_insp_rec.insp_record.are_st_chain
        ,pi_insp_rec.insp_record.are_surface_condition
        ,pi_insp_rec.insp_record.are_weather_condition
        ,pi_insp_rec.insp_record.are_wol_works_order_no
        ,pi_insp_rec.insp_error
        );
  /*
  ||Insert Activities Report Lines.
  */
  FOR i IN 1..pi_insp_rec.insp_activities.count LOOP
    --
    INSERT
      INTO mai_insp_load_error_arl
          (arl_are_report_id
          ,arl_atv_acty_area_code
          ,arl_error)
    VALUES(pi_insp_rec.insp_record.are_report_id
          ,pi_insp_rec.insp_activities(i).atv_acty_area_code
          ,pi_insp_rec.insp_activities(i).atv_error)
         ;
    --
  END LOOP;
  /*
  ||Insert Defects.
  */
  FOR i IN 1..pi_insp_rec.insp_defects.count LOOP
    --
    INSERT
      INTO mai_insp_load_error_def
          (def_defect_id         
          ,def_rse_he_id         
          ,def_iit_item_id       
          ,def_st_chain          
          ,def_are_report_id     
          ,def_atv_acty_area_code
          ,def_siss_id           
          ,def_works_order_no    
          ,def_created_date      
          ,def_defect_code       
          ,def_last_updated_date 
          ,def_orig_priority     
          ,def_priority          
          ,def_status_code       
          ,def_superseded_flag   
          ,def_area              
          ,def_are_id_not_found  
          ,def_coord_flag        
          ,def_date_compl        
          ,def_date_not_found    
          ,def_defect_class      
          ,def_defect_descr      
          ,def_defect_type_descr 
          ,def_diagram_no        
          ,def_height            
          ,def_ident_code        
          ,def_ity_inv_code      
          ,def_ity_sys_flag      
          ,def_length            
          ,def_locn_descr        
          ,def_maint_wo          
          ,def_mand_adv          
          ,def_notify_org_id     
          ,def_number            
          ,def_per_cent          
          ,def_per_cent_orig     
          ,def_per_cent_rem      
          ,def_rechar_org_id     
          ,def_serial_no         
          ,def_skid_coeff        
          ,def_special_instr     
          ,def_superseded_id     
          ,def_time_hrs          
          ,def_time_mins         
          ,def_update_inv        
          ,def_x_sect            
          ,def_easting           
          ,def_northing          
          ,def_response_category
          ,def_inspection_date
          ,def_error)
    VALUES(pi_insp_rec.insp_defects(i).def_record.def_defect_id         
          ,pi_insp_rec.insp_defects(i).def_record.def_rse_he_id         
          ,pi_insp_rec.insp_defects(i).def_record.def_iit_item_id       
          ,pi_insp_rec.insp_defects(i).def_record.def_st_chain          
          ,pi_insp_rec.insp_defects(i).def_record.def_are_report_id     
          ,pi_insp_rec.insp_defects(i).def_record.def_atv_acty_area_code
          ,pi_insp_rec.insp_defects(i).def_record.def_siss_id           
          ,pi_insp_rec.insp_defects(i).def_record.def_works_order_no    
          ,pi_insp_rec.insp_defects(i).def_record.def_created_date      
          ,pi_insp_rec.insp_defects(i).def_record.def_defect_code       
          ,pi_insp_rec.insp_defects(i).def_record.def_last_updated_date 
          ,pi_insp_rec.insp_defects(i).def_record.def_orig_priority     
          ,pi_insp_rec.insp_defects(i).def_record.def_priority          
          ,pi_insp_rec.insp_defects(i).def_record.def_status_code       
          ,pi_insp_rec.insp_defects(i).def_record.def_superseded_flag   
          ,pi_insp_rec.insp_defects(i).def_record.def_area              
          ,pi_insp_rec.insp_defects(i).def_record.def_are_id_not_found  
          ,pi_insp_rec.insp_defects(i).def_record.def_coord_flag        
          ,pi_insp_rec.insp_defects(i).def_record.def_date_compl        
          ,pi_insp_rec.insp_defects(i).def_record.def_date_not_found    
          ,pi_insp_rec.insp_defects(i).def_record.def_defect_class      
          ,pi_insp_rec.insp_defects(i).def_record.def_defect_descr      
          ,pi_insp_rec.insp_defects(i).def_record.def_defect_type_descr 
          ,pi_insp_rec.insp_defects(i).def_record.def_diagram_no        
          ,pi_insp_rec.insp_defects(i).def_record.def_height            
          ,pi_insp_rec.insp_defects(i).def_record.def_ident_code        
          ,pi_insp_rec.insp_defects(i).def_record.def_ity_inv_code      
          ,pi_insp_rec.insp_defects(i).def_record.def_ity_sys_flag      
          ,pi_insp_rec.insp_defects(i).def_record.def_length            
          ,pi_insp_rec.insp_defects(i).def_record.def_locn_descr        
          ,pi_insp_rec.insp_defects(i).def_record.def_maint_wo          
          ,pi_insp_rec.insp_defects(i).def_record.def_mand_adv          
          ,pi_insp_rec.insp_defects(i).def_record.def_notify_org_id     
          ,pi_insp_rec.insp_defects(i).def_record.def_number            
          ,pi_insp_rec.insp_defects(i).def_record.def_per_cent          
          ,pi_insp_rec.insp_defects(i).def_record.def_per_cent_orig     
          ,pi_insp_rec.insp_defects(i).def_record.def_per_cent_rem      
          ,pi_insp_rec.insp_defects(i).def_record.def_rechar_org_id     
          ,pi_insp_rec.insp_defects(i).def_record.def_serial_no         
          ,pi_insp_rec.insp_defects(i).def_record.def_skid_coeff        
          ,pi_insp_rec.insp_defects(i).def_record.def_special_instr     
          ,pi_insp_rec.insp_defects(i).def_record.def_superseded_id     
          ,pi_insp_rec.insp_defects(i).def_record.def_time_hrs          
          ,pi_insp_rec.insp_defects(i).def_record.def_time_mins         
          ,pi_insp_rec.insp_defects(i).def_record.def_update_inv        
          ,pi_insp_rec.insp_defects(i).def_record.def_x_sect            
          ,pi_insp_rec.insp_defects(i).def_record.def_easting           
          ,pi_insp_rec.insp_defects(i).def_record.def_northing          
          ,pi_insp_rec.insp_defects(i).def_record.def_response_category 
          ,pi_insp_rec.insp_defects(i).def_record.def_inspection_date 
          ,pi_insp_rec.insp_defects(i).def_error)
         ;
    /*
    ||Insert Defect Attributes.
    */
    FOR j IN 1..pi_insp_rec.insp_defects(i).def_attribs.count LOOP
      INSERT
        INTO mai_insp_load_error_def_attr
            (def_defect_id
            ,def_attr_no
            ,def_attr_value)
      VALUES(pi_insp_rec.insp_defects(i).def_record.def_defect_id
            ,j
            ,pi_insp_rec.insp_defects(i).def_attribs(j))
           ;
    END LOOP;
    /*
    ||Insert Doc Assocs.
    */
    FOR j IN 1..pi_insp_rec.insp_defects(i).def_assocs.count LOOP
      INSERT
        INTO mai_insp_load_error_das
            (das_doc_id
            ,das_are_report_id
            ,das_def_defect_id
            ,das_title
            ,das_category
            ,das_dtp_code 
            ,das_date_issued
            ,das_file
            ,das_dlc_dmd_id 
            ,das_dlc_id
            ,das_reference_code
            ,das_descr
            ,das_location
            ,das_error)
      VALUES(pi_insp_rec.insp_defects(i).def_assocs(j).das_doc_id
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_are_report_id
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_def_defect_id
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_title
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_category
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_dtp_code 
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_date_issued
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_file
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_dlc_dmd_id 
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_dlc_id
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_reference_code
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_descr
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_location
            ,pi_insp_rec.insp_defects(i).def_assocs(j).das_error)
           ;
    END LOOP;
    /*
    ||Insert repairs.
    */
    FOR j IN 1..pi_insp_rec.insp_defects(i).def_repairs.count LOOP
      --
      INSERT
        INTO mai_insp_load_error_rep
            (rep_def_defect_id     
            ,rep_action_cat        
            ,rep_rse_he_id         
            ,rep_tre_treat_code    
            ,rep_atv_acty_area_code
            ,rep_created_date      
            ,rep_date_due          
            ,rep_last_updated_date 
            ,rep_superseded_flag   
            ,rep_completed_hrs     
            ,rep_completed_mins    
            ,rep_date_completed    
            ,rep_descr             
            ,rep_local_date_due    
            ,rep_old_due_date      
            ,rep_error)
      VALUES(pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_def_defect_id     
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_action_cat        
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_rse_he_id         
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_tre_treat_code    
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_atv_acty_area_code
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_created_date      
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_date_due          
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_last_updated_date 
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_superseded_flag   
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_completed_hrs     
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_completed_mins    
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_date_completed    
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_descr             
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_local_date_due    
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_old_due_date      
            ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_error)
           ;
      /*
      ||Insert BOQs.
      */
      FOR k IN 1..pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs.count LOOP
        --   
        INSERT
          INTO mai_insp_load_error_boq
              (boq_work_flag     
              ,boq_defect_id     
              ,boq_rep_action_cat
              ,boq_wol_id        
              ,boq_sta_item_code 
              ,boq_item_name     
              ,boq_date_created  
              ,boq_icb_work_code 
              ,boq_est_dim1      
              ,boq_est_dim2      
              ,boq_est_dim3      
              ,boq_est_quantity  
              ,boq_est_rate      
              ,boq_est_discount  
              ,boq_est_cost      
              ,boq_est_labour    
              ,boq_act_dim1      
              ,boq_act_dim2      
              ,boq_act_dim3      
              ,boq_act_quantity  
              ,boq_act_cost      
              ,boq_act_labour    
              ,boq_act_rate      
              ,boq_act_discount  
              ,boq_id            
              ,boq_parent_id     
              ,boq_error)
        VALUES(pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_work_flag     
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_defect_id     
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_rep_action_cat
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_wol_id        
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_sta_item_code 
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_item_name     
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_date_created  
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_icb_work_code 
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_dim1      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_dim2      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_dim3      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_quantity  
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_rate      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_discount  
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_cost      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_labour    
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_dim1      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_dim2      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_dim3      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_quantity  
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_cost      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_labour    
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_rate      
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_discount  
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_id            
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_parent_id     
              ,pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_error)
              ;
        --
      END LOOP;
      --
    END LOOP;
    --
  END LOOP;
  /*
  ||Insert Comments.
  */
  FOR i IN 1..pi_insp_rec.insp_comments.count LOOP
    --
    INSERT
      INTO mai_insp_load_error_com
          (com_doc_id
          ,com_are_report_id
          ,com_title
          ,com_category
          ,com_dtp_code
          ,com_date_issued
          ,com_reference_code
          ,com_descr
          ,com_error)
    VALUES(pi_insp_rec.insp_comments(i).com_doc_id
          ,pi_insp_rec.insp_record.are_report_id
          ,pi_insp_rec.insp_comments(i).com_title
          ,pi_insp_rec.insp_comments(i).com_category
          ,pi_insp_rec.insp_comments(i).com_dtp_code
          ,pi_insp_rec.insp_comments(i).com_date_issued
          ,pi_insp_rec.insp_comments(i).com_reference_code
          ,pi_insp_rec.insp_comments(i).com_descr
          ,pi_insp_rec.insp_comments(i).com_error)
         ;
    --
  END LOOP;
  --
END move_insp_to_error_tabs;
--
-----------------------------------------------------------------------------
--
PROCEDURE load_rmms_or_eid_file
  IS
  --
  lv_file_loaded    BOOLEAN;
  lv_insp_batch_id  mai_insp_load_recs.milr_batch_id%TYPE;
  lv_process_id     hig_processes.hp_process_id%TYPE;
  lv_api_error      VARCHAR2(1);
  lv_comment_error  VARCHAR2(1);
  lv_errors         BOOLEAN := FALSE;
  lv_no_rejected    PLS_INTEGER := 0;
  lv_no_created     PLS_INTEGER := 0;
  --
  lt_files       hig_process_api.tab_process_files;
  lt_seq_no_tab  seq_no_store_tab;
  lt_api_params  mai_inspection_api.insp_tab;
  --
  PROCEDURE get_process_details
    IS
  BEGIN
    --
    lv_process_id := hig_process_api.get_current_process_id;
    --
    lt_files := hig_process_api.get_current_process_in_files;
    --
  END;
  --
BEGIN
  --
  nm_debug.debug_on;
  /*
  ||
  */
  process_log_entry(pi_ner_id   => 9805
                   ,pi_ner_appl => 'MAI'
                   ,pi_supplementary_info => get_body_version);
  /*
  ||Get The Files To Be Loaded.
  */
  get_process_details;
  /*
  ||Start File Loop
  */
  FOR i IN 1..lt_files.count LOOP
    BEGIN
      /*
      ||Loading File Message.
      */
      process_log_entry(pi_ner_id   => 9800
                       ,pi_ner_appl => 'MAI'
                       ,pi_supplementary_info => lt_files(i).hpf_filename);
      /*
      ||Create a header record in
      */
      lv_insp_batch_id := mai_inspection_api.get_next_id('ARE_BATCH_ID_SEQ');
      --
      INSERT
        INTO mai_insp_load_batches
            (milb_batch_id
            ,milb_hp_process_id
            ,milb_hpf_file_id)
      VALUES(lv_insp_batch_id
            ,lv_process_id
            ,lt_files(i).hpf_file_id)
           ;
      /*
      ||Batch Id Message.
      */
      process_log_entry(pi_ner_id   => 9801
                       ,pi_ner_appl => 'MAI'
                       ,pi_supplementary_info => lv_insp_batch_id);
      /*
      ||Read Contents Of File.
      */
      lv_file_loaded := extract_records_from_file(pi_filename   => lt_files(i).hpf_filename
                                                 ,pi_directory  => lt_files(i).hpf_destination
                                                 ,pi_batch_id   => lv_insp_batch_id);
      /*
      ||Validate The File Structure And Tokenise The Records.
      */
      IF lv_file_loaded
       THEN
          process_rmms_or_eid_file(pi_batch_id    => lv_insp_batch_id
                                  --,pio_seq_no_tab => lt_seq_no_tab
                                  ,pio_api_params => lt_api_params);
          /*
          ||Number Of Inspections In File Message.
          */
          process_log_entry(pi_ner_id   => 9802
                           ,pi_ner_appl => 'MAI'
                           ,pi_supplementary_info => lt_api_params.count);
      ELSE
          --Log An Error;
          process_log_entry(pi_ner_id       => 9002
                           ,pi_ner_appl     => 'MAI'
                           ,pi_message_type => 'E');
      END IF;
      /*
      ||Pass The Data Into The Inspection API.
      */
      FOR i IN 1..lt_api_params.count LOOP
        --
        BEGIN
          --
          nm_debug.debug('Processing Inspection '||i);
          nm_debug.debug('Inspection rse_he_id = '||lt_api_params(i).insp_record.are_rse_he_id);
          --
          /*
          || Set inspection load date
          */
          lt_api_params(i).insp_record.are_insp_load_date := sysdate;

          mai_inspection_api.create_inspection(pio_insp_rec  => lt_api_params(i)
                                              ,pi_commit     => 'N'
                                              ,po_error_flag => lv_api_error);
          nm_debug.debug('Processed Inspection '||i);
          --
          IF NVL(lv_api_error,'N') = 'Y'
           THEN
              /*
              ||Handle the error, insert into error tables etc...
              */
              move_insp_to_error_tabs(pi_insp_rec => lt_api_params(i));
              lv_errors := TRUE;
              --
              /*
              ||Increment The Number Of Inspections Rejected Counter.
              */
              lv_no_rejected := lv_no_rejected+1;
              /*
              ||Inspection Rejected Message.
              */
              hig_process_api.log_it('Inspection rejected: '||lt_api_params(i).insp_record.are_report_id
                                    ,pi_summary_flag => 'N');
              --
          ELSE
              /*
              ||Update The Date Last Inspected For The Section.
              */
              IF NOT mai_inspection_api.update_sect_last_updated(pi_ne_id              => lt_api_params(i).insp_record.are_rse_he_id
                                                                ,pi_are_date_work_done => lt_api_params(i).insp_record.are_date_work_done)
               THEN
                  hig_process_api.log_it(pi_message_type => 'W'
                                        ,pi_message      => 'Unable To Update Section Last Inspected Date'
                                        ,pi_summary_flag => 'N');
              END IF;
              
              /*
              ||Increment The Number Of Inspections Create Counter.
              */
              lv_no_created := lv_no_created+1;
              /*
              ||Inspection Created Message.
              */
              process_log_entry(pi_ner_id   => 9803
                               ,pi_ner_appl => 'MAI'
                               ,pi_summary_flag => 'N'
                               ,pi_supplementary_info => lt_api_params(i).insp_record.are_report_id);
          END IF;
          --
        EXCEPTION
          WHEN others
           THEN
              --
              hig_process_api.log_it(pi_message_type => 'E'
                                    ,pi_message      => SQLERRM);
              lv_errors := TRUE;
              --
        END;
        --
        COMMIT;
        --
      END LOOP;
      --
      IF lt_api_params.count > 0
       THEN
          /*
          ||The Inspection Data Will Now Either
          ||Be In The Inspection Tables Or The
          ||Detailed Error Tables So The File
          ||Records Are No Longer Needed.
          */
          DELETE mai_insp_load_recs
           WHERE milr_batch_id = lv_insp_batch_id
               ;
      END IF;
      /*
      ||Completed Processing File Message.
      */
      hig_process_api.log_it('Number of Inspections loaded  : '||lv_no_created);
      hig_process_api.log_it('Number of Inspections rejected: '||lv_no_rejected);
      process_log_entry(pi_ner_id   => 9804
                       ,pi_ner_appl => 'MAI'
                       ,pi_supplementary_info => lt_files(i).hpf_filename);
      --
    EXCEPTION
      WHEN invalid_record THEN
          lv_errors := TRUE;
      WHEN invalid_file THEN
          lv_errors := TRUE;
      WHEN others
       THEN
          --
          hig_process_api.log_it(pi_message_type => 'E' --clb
                                ,pi_message => SQLERRM);
          lv_errors := TRUE;
          --
    END;
    --
    lv_no_rejected := 0;
    lv_no_created  := 0;
    --
  END LOOP;
  --
  IF lv_errors
   THEN
      hig_process_api.log_it('ERRORS FOUND DURING LOAD PROCESS.');
      hig_process_api.log_it('Use Maintenance Inspection Error Correction module to check and correct the errors.');
      hig_process_api.log_it('Load NOT successful.');
      hig_process_api.process_execution_end(pi_success_flag => 'N');
  ELSE
      hig_process_api.log_it('No errors were encountered during this load.');
      hig_process_api.log_it('Load successful.');
  END IF;
  --
  nm_debug.debug_off;
  --
END load_rmms_or_eid_file;
--
-----------------------------------------------------------------------------
--
PROCEDURE resubmit_batch(pi_insp_batch_id IN PLS_INTEGER)
 IS
  
  CURSOR c_process(cp_batch_id   MAI_INSP_LOAD_BATCHES.MILB_BATCH_ID%TYPE) 
      IS
  SELECT milb_hp_process_id
    FROM mai_insp_load_batches
   WHERE milb_batch_id = cp_batch_id;
  --
  --
  CURSOR c_batches(cp_process_id  hig_processes.hp_process_id%TYPE)
      IS
  SELECT 1
    FROM mai_insp_load_batches,
         mai_insp_load_recs 
   WHERE milb_batch_id = milr_batch_id
     AND milb_hp_process_id = cp_process_id;

  CURSOR c_inspections(cp_process_id  hig_processes.hp_process_id%TYPE)
      IS
  SELECT 1
    FROM mai_insp_load_batches,
         mai_insp_load_error_are 
   WHERE are_batch_id = milb_batch_id
     AND milb_hp_process_id = cp_process_id;
  --                             
  --                             
  lv_process_id     hig_processes.hp_process_id%TYPE;
  lv_api_error      VARCHAR2(1);
  lv_errors         BOOLEAN := FALSE;
  lv_no_rejected    PLS_INTEGER := 0;
  lv_no_created     PLS_INTEGER := 0;
  lv_job_sequence   hig_process_job_runs.hpjr_job_run_seq%TYPE;
  lv_dummy          PLS_INTEGER;
  lv_row_found      BOOLEAN;
  --
  lt_files       hig_process_api.tab_process_files;
  lt_api_params  mai_inspection_api.insp_tab;
  --
BEGIN
  --
  nm_debug.debug_on;
  --
  /*
  ||Obtain the relevant process_id related to the batch
  */
  OPEN c_process(pi_insp_batch_id);
  FETCH c_process INTO lv_process_id;
  CLOSE c_process;
  
  nm_debug.debug('Reprocessing process ('||lv_process_id||') batch ('||pi_insp_batch_id||')');
  
  hig_process_api.set_current_process_id(pi_process_id => lv_process_id);
  lv_job_sequence := hig_process_api.last_process_job_run(pi_process_id => lv_process_id);
  nm_debug.debug('Current Job Run Sequence = '||lv_job_sequence);
  hig_process_api.set_current_job_run_seq(pi_job_run_seq => lv_job_sequence);
  hig_process_api.log_it('--------------------------------------');
  hig_process_api.log_it('Re-Processing batch '||pi_insp_batch_id);
   

  BEGIN
      /*
      || Re-process the batch
      */
      process_rmms_or_eid_file(pi_batch_id    => pi_insp_batch_id
                              ,pio_api_params => lt_api_params);
      /*
      ||Number Of Inspections In File Message.
      */
      
      process_log_entry(pi_ner_id   => 9802
                       ,pi_ner_appl => 'MAI'
                       ,pi_supplementary_info => lt_api_params.count);

      nm_debug.debug('Inspection to Process = '||lt_api_params.count);
      /*
      ||Pass The Data Into The Inspection API.
      */

      FOR i IN 1..lt_api_params.count LOOP
        --
        BEGIN
          --
          nm_debug.debug('Processing Inspection '||i);
          nm_debug.debug('Inspection rse_he_id = '||lt_api_params(i).insp_record.are_rse_he_id);
          --
          /*
          || Set inspection load date
          */
          lt_api_params(i).insp_record.are_insp_load_date := sysdate;

          mai_inspection_api.create_inspection(pio_insp_rec  => lt_api_params(i)
                                              ,pi_commit     => 'Y'
                                              ,po_error_flag => lv_api_error);
          nm_debug.debug('Processed Inspection '||i);
          --
          IF NVL(lv_api_error,'N') = 'Y'
           THEN
              /*
              ||Handle the error, insert into error tables etc...
              */
              move_insp_to_error_tabs(pi_insp_rec => lt_api_params(i));
              lv_errors := TRUE;
              --
              /*
              ||Increment The Number Of Inspections Rejected Counter.
              */
              lv_no_rejected := lv_no_rejected+1;
              /*
              ||Inspection Rejected Message.
              */
              hig_process_api.log_it('Inspection rejected: '||lt_api_params(i).insp_record.are_report_id
                                    ,pi_summary_flag => 'N');
              
              nm_debug.debug('Inspection Rejected - '||lt_api_params(i).insp_record.are_report_id);
          ELSE
              /*
              ||Update The Date Last Inspected For The Section.
              */
              IF NOT mai_inspection_api.update_sect_last_updated(pi_ne_id              => lt_api_params(i).insp_record.are_rse_he_id
                                                                ,pi_are_date_work_done => lt_api_params(i).insp_record.are_date_work_done)
               THEN
                  hig_process_api.log_it(pi_message_type => 'W'
                                        ,pi_message      => 'Unable To Update Section Last Inspected Date'
                                        ,pi_summary_flag => 'N');
              END IF;
              /*
              ||Create any comments.
              */
              /*
              ||Increment The Number Of Inspections Create Counter.
              */
              lv_no_created := lv_no_created+1;
              /*
              ||Inspection Created Message.
              */
              process_log_entry(pi_ner_id   => 9803
                               ,pi_ner_appl => 'MAI'
                               ,pi_summary_flag => 'N'
                               ,pi_supplementary_info => lt_api_params(i).insp_record.are_report_id);
                               
              nm_debug.debug('Inspection Created - '||lt_api_params(i).insp_record.are_report_id);
           END IF;
          --
        EXCEPTION
          WHEN others
           THEN
              --
              hig_process_api.log_it(pi_message_type => 'E'
                                    ,pi_message      => SQLERRM);
              
              nm_debug.debug('Error - '|| SQLERRM);
              lv_errors := TRUE;
              --
        END;
        --
        COMMIT;
        --
      END LOOP;
      
          --
      IF lt_api_params.count > 0
       THEN
          /*
          ||The Inspection Data Will Now Either
          ||Be In The Inspection Tables Or The
          ||Detailed Error Tables So The File
          ||Records Are No Longer Needed.
          */
          DELETE mai_insp_load_recs
           WHERE milr_batch_id = pi_insp_batch_id
               ;
      END IF;
      /*
      ||Completed Processing File Message.
      */
      hig_process_api.log_it('Number of Inspections loaded  : '||lv_no_created);
      hig_process_api.log_it('Number of Inspections rejected: '||lv_no_rejected);
      COMMIT;
--
  EXCEPTION
      WHEN others
           THEN
              --
              hig_process_api.log_it(pi_message_type => 'E'
                                    ,pi_message      => SQLERRM);
              lv_errors := TRUE;    
              lv_no_rejected := 0;
  END;
   
  lv_no_created  := 0;
    --
  --
  IF lv_errors
  THEN
     hig_process_api.log_it('ERRORS FOUND DURING LOAD PROCESS.');
     hig_process_api.log_it('Use Maintenance Inspection Error Correction module to check and correct the errors.');
     hig_process_api.log_it('Load NOT successful.');
     hig_process_api.process_execution_end(pi_success_flag => 'N');
     nm_debug.debug('Errors found');
  ELSE
     hig_process_api.log_it('Batch '||pi_insp_batch_id||' processed successfuly.');

     /*
      ||Check if all batches have been processed for a Process.
      */
     OPEN c_batches(lv_process_id);
     FETCH c_batches INTO lv_dummy;
     lv_row_found := c_batches%FOUND;
     CLOSE c_batches;
     
     IF NOT lv_row_found THEN
     
       /*
        ||Check if all inspections have been processed for a Process.
        */
         OPEN c_inspections(lv_process_id);
         FETCH c_inspections INTO lv_dummy;
         lv_row_found := c_inspections%FOUND;
         CLOSE c_inspections;
         
         IF NOT lv_row_found THEN
           hig_process_api.log_it('All inspections for Process = '||lv_process_id||' have been successfully processed.');
           hig_process_api.process_execution_end(pi_force  => TRUE);
         END IF;
         
     END IF;
     nm_debug.debug('Successful');
  END IF;
  --
  nm_debug.debug_off;
  --
EXCEPTION
WHEN OTHERS THEN
   nm_debug.debug('Error - '||SQLERRM);
END resubmit_batch;
--
-----------------------------------------------------------------------------
--
PROCEDURE resubmit_inspection(pi_inspection_id IN mai_insp_load_error_are.are_report_id%TYPE)
  IS

  CURSOR c_process(cp_batch_id   mai_insp_load_batches.milb_batch_id%TYPE) 
      IS
  SELECT milb_hp_process_id
    FROM mai_insp_load_batches
   WHERE milb_batch_id = cp_batch_id;
  
  --
  CURSOR c_batches(cp_process_id  hig_processes.hp_process_id%TYPE)
      IS
  SELECT 1
    FROM mai_insp_load_batches,
         mai_insp_load_recs 
   WHERE milb_batch_id = milr_batch_id
     AND milb_hp_process_id = cp_process_id;

  CURSOR c_inspections(cp_process_id  hig_processes.hp_process_id%TYPE)
      IS
  SELECT 1
    FROM mai_insp_load_batches,
         mai_insp_load_error_are 
   WHERE are_batch_id = milb_batch_id
     AND milb_hp_process_id = cp_process_id;
  --                             
  TYPE activities_tab IS TABLE OF mai_insp_load_error_are%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE activity_lines_tab IS TABLE OF mai_insp_load_error_arl%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE defects_tab IS TABLE OF mai_insp_load_error_def%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE defect_atts_tab IS TABLE OF mai_insp_load_error_def_attr%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE repairs_tab IS TABLE OF mai_insp_load_error_rep%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE boq_tab IS TABLE OF mai_insp_load_error_boq%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE com_tab IS TABLE OF mai_insp_load_error_com%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE das_tab IS TABLE OF mai_insp_load_error_das%ROWTYPE INDEX BY BINARY_INTEGER;
  --
  lr_mai_are          mai_insp_load_error_are%ROWTYPE;
  lt_activity_lines   activity_lines_tab; 
  lt_defects          defects_tab;  
  lt_defect_atts      defect_atts_tab;
  lt_repairs          repairs_tab;
  lt_boqs             boq_tab;
  lt_com              com_tab;
  lt_das              das_tab;
  lt_insp_rec         mai_inspection_api.insp_rec;
  --
  lv_process_id     hig_processes.hp_process_id%TYPE;
  lv_job_sequence   hig_process_job_runs.hpjr_job_run_seq%TYPE;
  lv_api_error      VARCHAR2(1);
  lv_errors         BOOLEAN := FALSE;
  lv_no_created     PLS_INTEGER := 0;
  lv_no_rejected    PLS_INTEGER := 0;
  lv_dummy          PLS_INTEGER;
  lv_row_found      BOOLEAN;

  PROCEDURE update_error_tabs(pi_insp_rec   mai_inspection_api.insp_rec)
    IS
  BEGIN

    /*
    ||Update Activities Report.
    */
    nm_debug.debug('are_error '||pi_insp_rec.insp_error);
    UPDATE mai_insp_load_error_are
       SET are_error = pi_insp_rec.insp_error
     WHERE are_report_id = pi_insp_rec.insp_record.are_report_id;
     
    /*
    ||Update Activities Report Lines.
    */
    FOR i IN 1..pi_insp_rec.insp_activities.count LOOP
    
      nm_debug.debug('arl_error '||pi_insp_rec.insp_activities(i).atv_error);
      UPDATE mai_insp_load_error_arl
         SET arl_error = lt_insp_rec.insp_activities(i).atv_error
       WHERE arl_are_report_id = pi_insp_rec.insp_record.are_report_id
         AND arl_atv_acty_area_code = pi_insp_rec.insp_activities(i).atv_acty_area_code;
      --
    END LOOP;

    /*
    ||Update Defects.
    */
    FOR i IN 1..pi_insp_rec.insp_defects.count LOOP
    
      nm_debug.debug('def_error '||pi_insp_rec.insp_defects(i).def_error);
      UPDATE mai_insp_load_error_def
         SET def_error = pi_insp_rec.insp_defects(i).def_error
       WHERE def_defect_id = pi_insp_rec.insp_defects(i).def_record.def_defect_id;
           
      /*
      ||Update Defect Docs.
      */
      FOR j IN 1..pi_insp_rec.insp_defects(i).def_assocs.count LOOP
        --
        nm_debug.debug('das_error '||pi_insp_rec.insp_defects(i).def_assocs(j).das_error);
        UPDATE mai_insp_load_error_das
           SET das_error = pi_insp_rec.insp_defects(i).def_assocs(j).das_error
         WHERE das_doc_id = pi_insp_rec.insp_defects(i).def_assocs(j).das_doc_id;
      END LOOP;
         
      /*
      ||Update Repairs.
      */
      FOR j IN 1..pi_insp_rec.insp_defects(i).def_repairs.count LOOP
        --
        nm_debug.debug('rep_error '||pi_insp_rec.insp_defects(i).def_repairs(j).rep_error);
        UPDATE mai_insp_load_error_rep
           SET rep_error = pi_insp_rec.insp_defects(i).def_repairs(j).rep_error
         WHERE rep_def_defect_id = pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_def_defect_id
           AND rep_action_cat = pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_action_cat;
           
             
        /*
        ||Update BOQs.
        */
        FOR k IN 1..pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs.count LOOP
          --
          nm_debug.debug('boq_error '||pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_error);
          UPDATE mai_insp_load_error_boq
             SET boq_error = pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_error
           WHERE boq_id = pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_id;      
          --
        END LOOP;
        --
      END LOOP;
      --
    END LOOP;

    /*
    ||Update Comments.
    */
    FOR i IN 1..pi_insp_rec.insp_comments.count LOOP
    
      nm_debug.debug('doc_error '||pi_insp_rec.insp_comments(i).com_error);
      UPDATE mai_insp_load_error_com
         SET com_error = lt_insp_rec.insp_comments(i).com_error
       WHERE com_doc_id = pi_insp_rec.insp_comments(i).com_doc_id;
      --
    END LOOP;
     
  END update_error_tabs;
  
  PROCEDURE remove_from_error_tabs(pi_insp_rec   mai_inspection_api.insp_rec)
    IS
  BEGIN

    /*
    ||Remove Comments.
    */
    nm_debug.debug('deleting Comments');
    DELETE FROM mai_insp_load_error_com
     WHERE com_are_report_id = pi_insp_rec.insp_record.are_report_id;
    /*
    ||Remove Doc Assocs.
    */
    nm_debug.debug('deleting Doc Assocs');
    DELETE FROM mai_insp_load_error_das
     WHERE das_are_report_id = pi_insp_rec.insp_record.are_report_id;
     
    FOR i IN 1..pi_insp_rec.insp_defects.count LOOP
    
      FOR j IN 1..pi_insp_rec.insp_defects(i).def_repairs.count LOOP
        /*
        ||Remove BOQs.
        */
        FOR k IN 1..pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs.count LOOP
          --
          nm_debug.debug('deleting BOQ');
          DELETE FROM mai_insp_load_error_boq
           WHERE boq_id = pi_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_id;      
          --
        END LOOP;
        --
        /*
        ||Remove Repairs.
        */
        nm_debug.debug('deleting Repair');
        DELETE FROM mai_insp_load_error_rep
         WHERE rep_def_defect_id = pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_def_defect_id
           AND rep_action_cat = pi_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_action_cat;
           
        --     
      END LOOP;
      --
      /*
      ||Remove Defect Attributes.
      */
      nm_debug.debug('deleting Defect Attribute');
      DELETE FROM mai_insp_load_error_def_attr
       WHERE def_defect_id = pi_insp_rec.insp_defects(i).def_record.def_defect_id;
           
      --
      /*
      ||Remove Defects.
      */
      nm_debug.debug('deleting Defect');
      DELETE FROM  mai_insp_load_error_def
       WHERE def_defect_id = pi_insp_rec.insp_defects(i).def_record.def_defect_id;
           
    END LOOP;

    /*
    ||Remove Activities Report Lines.
    */
    FOR i IN 1..pi_insp_rec.insp_activities.count LOOP
    
      nm_debug.debug('deleting Activities Report Line');
      DELETE mai_insp_load_error_arl
       WHERE arl_are_report_id = pi_insp_rec.insp_record.are_report_id
         AND arl_atv_acty_area_code = pi_insp_rec.insp_activities(i).atv_acty_area_code;
      --
    END LOOP;

    /*
    ||Remove Activities Report.
    */
    nm_debug.debug('deleting Activities Report');
    DELETE FROM mai_insp_load_error_are
     WHERE are_report_id = pi_insp_rec.insp_record.are_report_id;
     

  END remove_from_error_tabs;
  
  
  BEGIN

  nm_debug.debug_on;

  SELECT *
  INTO lr_mai_are
  FROM mai_insp_load_error_are
  WHERE are_report_id = pi_inspection_id;
   
  /*
  ||Obtain the relevant process_id related to the inspection
  */
  OPEN c_process(lr_mai_are.are_batch_id);
  FETCH c_process INTO lv_process_id;
  CLOSE c_process;
  
  nm_debug.debug('Reprocessing inspection ('||pi_inspection_id||') for process ('||lv_process_id||
                 ') and batch ('||lr_mai_are.are_batch_id||')');
  
  hig_process_api.set_current_process_id(pi_process_id => lv_process_id);
  lv_job_sequence := hig_process_api.last_process_job_run(pi_process_id => lv_process_id);
  nm_debug.debug('Current Job Run Sequence = '||lv_job_sequence);
  hig_process_api.set_current_job_run_seq(pi_job_run_seq => lv_job_sequence);
  hig_process_api.log_it('--------------------------------------');
  hig_process_api.log_it('Re-Processing inspection '||pi_inspection_id);
   
  nm_debug.debug ('ARE - '||lr_mai_are.are_report_id);
  lt_insp_rec.insp_record.are_report_id              := lr_mai_are.are_report_id;
  lt_insp_rec.insp_record.are_rse_he_id              := lr_mai_are.are_rse_he_id;
  lt_insp_rec.insp_record.are_batch_id               := lr_mai_are.are_batch_id;
  lt_insp_rec.insp_record.are_created_date           := lr_mai_are.are_created_date;
  lt_insp_rec.insp_record.are_last_updated_date      := lr_mai_are.are_last_updated_date;
  lt_insp_rec.insp_record.are_maint_insp_flag        := lr_mai_are.are_maint_insp_flag;
  lt_insp_rec.insp_record.are_sched_act_flag         := lr_mai_are.are_sched_act_flag;
  lt_insp_rec.insp_record.are_date_work_done         := lr_mai_are.are_date_work_done;
  lt_insp_rec.insp_record.are_end_chain              := lr_mai_are.are_end_chain;
  lt_insp_rec.insp_record.are_initiation_type        := lr_mai_are.are_initiation_type;
  lt_insp_rec.insp_record.are_insp_load_date         := lr_mai_are.are_insp_load_date;
  lt_insp_rec.insp_record.are_peo_person_id_actioned := lr_mai_are.are_peo_person_id_actioned;
  lt_insp_rec.insp_record.are_peo_person_id_insp2    := lr_mai_are.are_peo_person_id_insp2;
  lt_insp_rec.insp_record.are_st_chain               := lr_mai_are.are_st_chain;
  lt_insp_rec.insp_record.are_surface_condition      := lr_mai_are.are_surface_condition;
  lt_insp_rec.insp_record.are_weather_condition      := lr_mai_are.are_weather_condition;
  lt_insp_rec.insp_record.are_wol_works_order_no     := lr_mai_are.are_wol_works_order_no;
  lt_insp_rec.insp_error                             := NULL;

  SELECT *
  BULK COLLECT
  INTO lt_activity_lines
  FROM mai_insp_load_error_arl
  WHERE arl_are_report_id = lr_mai_are.are_report_id;
    
  FOR i IN 1 .. lt_activity_lines.count LOOP
          
    nm_debug.debug('ARL - '||lt_activity_lines(i).arl_atv_acty_area_code);
    lt_insp_rec.insp_activities(i).atv_acty_area_code := lt_activity_lines(i).arl_atv_acty_area_code;
    lt_insp_rec.insp_activities(i).atv_error          := NULL;
              
  END LOOP;
       
  SELECT *
  BULK COLLECT
  INTO lt_defects
  FROM mai_insp_load_error_def
  WHERE def_are_report_id = lr_mai_are.are_report_id;
    
  FOR i IN 1 .. lt_defects.count LOOP

      nm_debug.debug('DEF - '||lt_defects(i).def_defect_id);
      lt_insp_rec.insp_defects(i).def_record.def_defect_id          := lt_defects(i).def_defect_id;
      lt_insp_rec.insp_defects(i).def_record.def_rse_he_id          := lt_defects(i).def_rse_he_id;
      lt_insp_rec.insp_defects(i).def_record.def_iit_item_id        := lt_defects(i).def_iit_item_id;
      lt_insp_rec.insp_defects(i).def_record.def_st_chain           := lt_defects(i).def_st_chain;
      lt_insp_rec.insp_defects(i).def_record.def_are_report_id      := lt_defects(i).def_are_report_id;
      lt_insp_rec.insp_defects(i).def_record.def_atv_acty_area_code := lt_defects(i).def_atv_acty_area_code;
      lt_insp_rec.insp_defects(i).def_record.def_siss_id            := lt_defects(i).def_siss_id;
      lt_insp_rec.insp_defects(i).def_record.def_works_order_no     := lt_defects(i).def_works_order_no;
      lt_insp_rec.insp_defects(i).def_record.def_created_date       := lt_defects(i).def_created_date;
      lt_insp_rec.insp_defects(i).def_record.def_defect_code        := lt_defects(i).def_defect_code;
      lt_insp_rec.insp_defects(i).def_record.def_last_updated_date  := lt_defects(i).def_last_updated_date;
      lt_insp_rec.insp_defects(i).def_record.def_orig_priority      := lt_defects(i).def_orig_priority;
      lt_insp_rec.insp_defects(i).def_record.def_priority           := lt_defects(i).def_priority;
      lt_insp_rec.insp_defects(i).def_record.def_status_code        := lt_defects(i).def_status_code;
      lt_insp_rec.insp_defects(i).def_record.def_superseded_flag    := lt_defects(i).def_superseded_flag;
      lt_insp_rec.insp_defects(i).def_record.def_area               := lt_defects(i).def_area;
      lt_insp_rec.insp_defects(i).def_record.def_are_id_not_found   := lt_defects(i).def_are_id_not_found;
      lt_insp_rec.insp_defects(i).def_record.def_coord_flag         := lt_defects(i).def_coord_flag;
      lt_insp_rec.insp_defects(i).def_record.def_date_compl         := lt_defects(i).def_date_compl;
      lt_insp_rec.insp_defects(i).def_record.def_date_not_found     := lt_defects(i).def_date_not_found;
      lt_insp_rec.insp_defects(i).def_record.def_defect_class       := lt_defects(i).def_defect_class;
      lt_insp_rec.insp_defects(i).def_record.def_defect_descr       := lt_defects(i).def_defect_descr;
      lt_insp_rec.insp_defects(i).def_record.def_defect_type_descr  := lt_defects(i).def_defect_type_descr;
      lt_insp_rec.insp_defects(i).def_record.def_diagram_no         := lt_defects(i).def_diagram_no;
      lt_insp_rec.insp_defects(i).def_record.def_height             := lt_defects(i).def_height;
      lt_insp_rec.insp_defects(i).def_record.def_ident_code         := lt_defects(i).def_ident_code;
      lt_insp_rec.insp_defects(i).def_record.def_ity_inv_code       := lt_defects(i).def_ity_inv_code;
      lt_insp_rec.insp_defects(i).def_record.def_ity_sys_flag       := lt_defects(i).def_ity_sys_flag;
      lt_insp_rec.insp_defects(i).def_record.def_length             := lt_defects(i).def_length;
      lt_insp_rec.insp_defects(i).def_record.def_locn_descr         := lt_defects(i).def_locn_descr;
      lt_insp_rec.insp_defects(i).def_record.def_maint_wo           := lt_defects(i).def_maint_wo;
      lt_insp_rec.insp_defects(i).def_record.def_mand_adv           := lt_defects(i).def_mand_adv;
      lt_insp_rec.insp_defects(i).def_record.def_notify_org_id      := lt_defects(i).def_notify_org_id;
      lt_insp_rec.insp_defects(i).def_record.def_number             := lt_defects(i).def_number;
      lt_insp_rec.insp_defects(i).def_record.def_per_cent           := lt_defects(i).def_per_cent;
      lt_insp_rec.insp_defects(i).def_record.def_per_cent_orig      := lt_defects(i).def_per_cent_orig;
      lt_insp_rec.insp_defects(i).def_record.def_per_cent_rem       := lt_defects(i).def_per_cent_rem;
      lt_insp_rec.insp_defects(i).def_record.def_rechar_org_id      := lt_defects(i).def_rechar_org_id;
      lt_insp_rec.insp_defects(i).def_record.def_serial_no          := lt_defects(i).def_serial_no;
      lt_insp_rec.insp_defects(i).def_record.def_skid_coeff         := lt_defects(i).def_skid_coeff;
      lt_insp_rec.insp_defects(i).def_record.def_special_instr      := lt_defects(i).def_special_instr;
      lt_insp_rec.insp_defects(i).def_record.def_superseded_id      := lt_defects(i).def_superseded_id;
      lt_insp_rec.insp_defects(i).def_record.def_time_hrs           := lt_defects(i).def_time_hrs;
      lt_insp_rec.insp_defects(i).def_record.def_time_mins          := lt_defects(i).def_time_mins;
      lt_insp_rec.insp_defects(i).def_record.def_update_inv         := lt_defects(i).def_update_inv;
      lt_insp_rec.insp_defects(i).def_record.def_x_sect             := lt_defects(i).def_x_sect;
      lt_insp_rec.insp_defects(i).def_record.def_easting            := lt_defects(i).def_easting;
      lt_insp_rec.insp_defects(i).def_record.def_northing           := lt_defects(i).def_northing;
      lt_insp_rec.insp_defects(i).def_record.def_response_category  := lt_defects(i).def_response_category;
      lt_insp_rec.insp_defects(i).def_record.def_inspection_date    := lt_defects(i).def_inspection_date;
      lt_insp_rec.insp_defects(i).def_error                         := NULL;
                      
      SELECT *
      BULK COLLECT
      INTO lt_defect_atts
      FROM mai_insp_load_error_def_attr
      WHERE def_defect_id = lt_defects(i).def_defect_id;
            
      FOR j IN 1 .. lt_defect_atts.count LOOP
                          
          nm_debug.debug('DEF_ATT - '||lt_defect_atts(j).def_attr_no);
          lt_insp_rec.insp_defects(i).def_record.def_defect_id := lt_defect_atts(j).def_defect_id;
          lt_insp_rec.insp_defects(i).def_attribs(j)           := lt_defect_atts(j).def_attr_value;

      END LOOP;
                          
      SELECT *
      BULK COLLECT
      INTO lt_das
      FROM mai_insp_load_error_das
      WHERE das_def_defect_id = lt_defects(i).def_defect_id;
            
      FOR j IN 1 .. lt_das.count LOOP
                          
          nm_debug.debug('DAS - '||j);
          lt_insp_rec.insp_defects(i).def_assocs(j).das_doc_id         := lt_das(j).das_doc_id;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_are_report_id  := lt_das(j).das_are_report_id;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_def_defect_id  := lt_das(j).das_def_defect_id;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_category       := lt_das(j).das_category;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_title          := lt_das(j).das_title;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_dtp_code       := lt_das(j).das_dtp_code;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_date_issued    := lt_das(j).das_date_issued;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_file           := lt_das(j).das_file;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_dlc_dmd_id     := lt_das(j).das_dlc_dmd_id;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_dlc_id         := lt_das(j).das_dlc_id;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_reference_code := lt_das(j).das_reference_code;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_descr          := lt_das(j).das_descr;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_location       := lt_das(j).das_location;
          lt_insp_rec.insp_defects(i).def_assocs(j).das_error := NULL;

      END LOOP;
                          
      SELECT *
      BULK COLLECT
      INTO lt_repairs
      FROM mai_insp_load_error_rep
      WHERE rep_def_defect_id = lt_defects(i).def_defect_id;
            
      FOR j in 1 .. lt_repairs.count LOOP
                  
          nm_debug.debug('REP - '||lt_repairs(j).rep_action_cat);
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_def_defect_id      := lt_repairs(j).rep_def_defect_id;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_action_cat         := lt_repairs(j).rep_action_cat;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_rse_he_id          := lt_repairs(j).rep_rse_he_id;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_tre_treat_code     := lt_repairs(j).rep_tre_treat_code;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_atv_acty_area_code := lt_repairs(j).rep_atv_acty_area_code;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_created_date       := lt_repairs(j).rep_created_date;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_date_due           := lt_repairs(j).rep_date_due;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_last_updated_date  := lt_repairs(j).rep_last_updated_date;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_superseded_flag    := lt_repairs(j).rep_superseded_flag;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_completed_hrs      := lt_repairs(j).rep_completed_hrs;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_completed_mins     := lt_repairs(j).rep_completed_mins;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_date_completed     := lt_repairs(j).rep_date_completed;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_descr              := lt_repairs(j).rep_descr;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_local_date_due     := lt_repairs(j).rep_local_date_due;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_record.rep_old_due_date       := lt_repairs(j).rep_old_due_date;
          lt_insp_rec.insp_defects(i).def_repairs(j).rep_error                         := NULL;

          SELECT *
          BULK COLLECT
          INTO lt_boqs
          FROM mai_insp_load_error_boq
          WHERE boq_defect_id = lt_defects(i).def_defect_id
            AND boq_rep_action_cat = lt_repairs(j).rep_action_cat;
            
          FOR k IN 1 .. lt_boqs.count LOOP
                                
              nm_debug.debug('BOQ - '||lt_boqs(k).boq_id); 
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_work_flag      := lt_boqs(k).boq_work_flag;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_defect_id      := lt_boqs(k).boq_defect_id;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_rep_action_cat := lt_boqs(k).boq_rep_action_cat;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_wol_id         := lt_boqs(k).boq_wol_id;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_sta_item_code  := lt_boqs(k).boq_sta_item_code;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_item_name      := lt_boqs(k).boq_item_name;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_date_created   := lt_boqs(k).boq_date_created;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_icb_work_code  := lt_boqs(k).boq_icb_work_code;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_dim1       := lt_boqs(k).boq_est_dim1;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_dim2       := lt_boqs(k).boq_est_dim2;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_dim3       := lt_boqs(k).boq_est_dim3;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_quantity   := lt_boqs(k).boq_est_quantity;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_rate       := lt_boqs(k).boq_est_rate;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_discount   := lt_boqs(k).boq_est_discount;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_cost       := lt_boqs(k).boq_est_cost;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_est_labour     := lt_boqs(k).boq_est_labour;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_dim1       := lt_boqs(k).boq_act_dim1;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_dim2       := lt_boqs(k).boq_act_dim2;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_dim3       := lt_boqs(k).boq_act_dim3;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_quantity   := lt_boqs(k).boq_act_quantity;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_cost       := lt_boqs(k).boq_act_cost;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_labour     := lt_boqs(k).boq_act_labour;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_rate       := lt_boqs(k).boq_act_rate;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_act_discount   := lt_boqs(k).boq_act_discount;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_id             := lt_boqs(k).boq_id;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_record.boq_parent_id      := lt_boqs(k).boq_parent_id;
              lt_insp_rec.insp_defects(i).def_repairs(j).rep_boqs(k).boq_error                     := NULL;
            
          END LOOP;
             
      END LOOP;
          
  END LOOP;
       
  SELECT *
  BULK COLLECT
  INTO lt_com
  FROM mai_insp_load_error_com
  WHERE com_are_report_id = lr_mai_are.are_report_id;
  
  nm_debug.debug('Comments count = '||lt_com.count); 
  FOR i IN 1 .. lt_com.count LOOP
          
    nm_debug.debug('COM - '||lt_com(i).com_doc_id);
    lt_insp_rec.insp_comments(i).com_doc_id           := lt_com(i).com_doc_id;
    lt_insp_rec.insp_comments(i).com_are_report_id    := lt_com(i).com_are_report_id;
    lt_insp_rec.insp_comments(i).com_title            := lt_com(i).com_title;
    lt_insp_rec.insp_comments(i).com_category         := lt_com(i).com_category;
    lt_insp_rec.insp_comments(i).com_dtp_code         := lt_com(i).com_dtp_code;
    lt_insp_rec.insp_comments(i).com_date_issued      := lt_com(i).com_date_issued;
    lt_insp_rec.insp_comments(i).com_reference_code   := lt_com(i).com_reference_code;
    lt_insp_rec.insp_comments(i).com_descr            := lt_com(i).com_descr;
    lt_insp_rec.insp_comments(i).com_error          := NULL;
              
  END LOOP;
  /*
  || Set inspection load date
  */
  lt_insp_rec.insp_record.are_insp_load_date := sysdate;

  mai_inspection_api.create_inspection(pio_insp_rec  => lt_insp_rec
                                      ,pi_commit     => 'Y'
                                      ,po_error_flag => lv_api_error);
  --
  nm_debug.debug('Completed create_inspection with '||lv_api_error);
  IF NVL(lv_api_error,'N') = 'Y'
   THEN
      /*
      ||Update Error tabs.
      */
      lv_errors := TRUE;
      update_error_tabs(pi_insp_rec => lt_insp_rec);      
      --
      /*
      ||Increment The Number Of Inspections Rejected Counter.
      */
      lv_no_rejected := lv_no_rejected+1;
      /*
      ||Inspection Rejected Message.
      */
      nm_debug.debug('Inspection Rejected - '||lt_insp_rec.insp_record.are_report_id);
      --
      hig_process_api.log_it('Inspection rejected: '||lt_insp_rec.insp_record.are_report_id
                            ,pi_summary_flag => 'N');
      hig_process_api.log_it('Use Maintenance Inspection Error Correction module to check and correct the errors.');
              --
  ELSE
      /*
      ||Update The Date Last Inspected For The Section.
      */
      IF NOT mai_inspection_api.update_sect_last_updated(pi_ne_id              => lt_insp_rec.insp_record.are_rse_he_id
                                                        ,pi_are_date_work_done => lt_insp_rec.insp_record.are_date_work_done)
       THEN
          hig_process_api.log_it(pi_message_type => 'W'
                                ,pi_message      => 'Unable To Update Section Last Inspected Date'
                                ,pi_summary_flag => 'N');
      END IF;
      /*
      ||Increment The Number Of Inspections Create Counter.
      */
      lv_no_created := lv_no_created+1;
      
      /*
      ||Remove error table entries.
      */
      nm_debug.debug('Removing inspection '||lt_insp_rec.insp_record.are_report_id||
                     ' from error table');
      remove_from_error_tabs(pi_insp_rec => lt_insp_rec);
      /*
      ||Inspection Created Message.
      */
      process_log_entry(pi_ner_id   => 9803
                       ,pi_ner_appl => 'MAI'
                       ,pi_summary_flag => 'N'
                       ,pi_supplementary_info => lr_mai_are.are_report_id);
                       
      nm_debug.debug('Inspection Created - '||lt_insp_rec.insp_record.are_report_id);

     /*
      ||Check if all batches have been processed for a Process.
      */
     OPEN c_batches(lv_process_id);
     FETCH c_batches INTO lv_dummy;
     lv_row_found := c_batches%FOUND;
     CLOSE c_batches;
     
     IF NOT lv_row_found THEN
     
       /*
        ||Check if all inspections have been processed for a Process.
        */
         OPEN c_inspections(lv_process_id);
         FETCH c_inspections INTO lv_dummy;
         lv_row_found := c_inspections%FOUND;
         CLOSE c_inspections;
         
         IF NOT lv_row_found THEN
           hig_process_api.log_it('All inspections for Process = '||lv_process_id||' have been successfully processed.');
           hig_process_api.process_execution_end(pi_force  => TRUE);
         END IF;
         
     END IF;

   END IF;
  --
  COMMIT;
  --
  nm_debug.debug_off;
  
EXCEPTION
  WHEN others
   THEN
      --
      hig_process_api.log_it(pi_message_type => 'E'
                            ,pi_message      => SQLERRM);
          
      
      nm_debug.debug('Error - '|| SQLERRM);
      lv_errors := TRUE;
      
END resubmit_inspection;
--
-----------------------------------------------------------------------------
--
PROCEDURE initialise IS


BEGIN

  g_insp_load_process_type  := hig_process_framework.get_process_type(pi_process_type_name => UPPER(c_process_type_name));
  
  IF g_insp_load_process_type.hpt_process_type_id IS NULL THEN
     hig.raise_ner(pi_appl => 'HIG'
                 , pi_id    => 534 -- PROCESS TYPE DOES NOT EXIST
                 , pi_supplementary_info => c_process_type_name); 
  END IF;


  g_insp_load_file_type     := hig_process_framework.get_process_type_file(pi_process_type_id  => g_insp_load_process_type.hpt_process_type_id 
                                                                          ,pi_file_type_name   => c_file_type_name);    

  IF g_insp_load_file_type.hptf_file_type_id IS NULL THEN
     hig.raise_ner(pi_appl => 'HIG'
                 , pi_id    => 535 -- FILE TYPE FOR THIS PROCESS TYPE DOES NOT EXIST
                 , pi_supplementary_info => chr(10)||'File Type ['||c_file_type_name||']'||chr(10)||'Process Type ['||c_file_type_name||']'); 
  END IF;
  

--  hig_process_api.log_it(pi_message => '   Checking that the '''||g_doc_bundle_file_type.hptf_input_destination||''' Oracle directory is valid'
--                        ,pi_summary_flag => 'N'); 

  
  nm3file.check_directory_valid(pi_dir_name        => g_insp_load_file_type.hptf_input_destination
                               ,pi_check_delimiter => FALSE);

  
END initialise;
--
-----------------------------------------------------------------------------
----
-----------------------------------------------------------------------------
--
PROCEDURE ftp_in_to_database(pi_ftp_type                IN hig_ftp_types.hft_type%TYPE) IS


  l_files         nm3type.tab_varchar32767;
  l_process_id    hig_processes.hp_process_id%TYPE;
  l_job_name      hig_processes.hp_job_name%TYPE;
  l_date          date;
  
 
  PROCEDURE initialise_files_for_process  IS

    l_file_rec      hig_process_api.rec_temp_files;

  BEGIN


     hig_process_api.initialise_temp_files;  

     FOR f IN 1..l_files.COUNT LOOP
         
         l_file_rec := Null;
         
         l_file_rec.filename         := l_files(f);
         l_file_rec.file_type_id     := g_insp_load_file_type.hptf_file_type_id;
         l_file_rec.I_or_O           := 'I';
         l_file_rec.destination      := g_insp_load_file_type.hptf_input_destination;
         l_file_rec.destination_type := g_insp_load_file_type.hptf_input_destination_type;
         l_file_rec.content          := Null;
         
         
         hig_process_api.add_temp_file(pi_rec => l_file_rec) ;
         
     END LOOP;
     
  END initialise_files_for_process;
  
BEGIN

  nm_debug.debug_on;

  hig_process_api.log_it(pi_message => 'Looking for inspection loader files in the '||g_insp_load_file_type.hptf_input_destination||' Oracle directory');

  l_files:= nm3ftp.ftp_in_to_database
              ( pi_ftp_type                => pi_ftp_type
              , pi_db_location_to_move_to  => g_insp_load_file_type.hptf_input_destination
              , pi_file_mask               => '%');

  nm_debug.debug('pi_ftp_type ='||pi_ftp_type);
  nm_debug.debug(l_files.count||' inspection loader files found');
             
  IF l_files.count > 0 THEN


     
      hig_process_api.log_it(pi_message => l_files.count||' inspection loader files found');



      initialise_files_for_process;
      
      hig_process_api.create_and_schedule_process
                          ( pi_process_type_id           => g_insp_load_process_type.hpt_process_type_id
                          , pi_initiated_by_username     => user
                          , pi_initiated_date            => SYSDATE
                          , pi_initiators_ref            => 'via FTP'
                          , pi_start_date                => SYSDATE
                          , pi_frequency_id              => -1 -- once
                          , po_process_id                => l_process_id
                          , po_job_name                  => l_job_name
                          , po_scheduled_start_date      => l_date);

      hig_process_api.log_it(pi_message => 'Process '||hig_process_framework_utils.formatted_process_id(l_process_id)||' created');

 ELSE
 
 
      hig_process_api.log_it(pi_message => 'No inspection loader files found');
              
 END IF;

  nm_debug.debug_off;

END ftp_in_to_database;
--
-----------------------------------------------------------------------------
--
BEGIN
--
  initialise;
--
END mai_inspection_loader;
/
