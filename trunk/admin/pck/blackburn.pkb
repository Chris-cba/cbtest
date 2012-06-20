CREATE OR REPLACE PACKAGE BODY Blackburn AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/blackburn.pkb-arc   2.2   Jun 20 2012 15:34:46   Mike.Huitson  $
--       Module Name      : $Workfile:   blackburn.pkb  $
--       Date into SCCS   : $Date:   Jun 20 2012 15:34:46  $
--       Date fetched Out : $Modtime:   Jun 14 2012 16:45:48  $
--       SCCS Version     : $Revision:   2.2  $
--       Based on SCCS Version     : 1.2
--
-----------------------------------------------------------------------------
--
  Type sections_tabtype is table of varchar2(150) index by binary_integer;
  Type exor_load_table  is table of varchar2(150) index by binary_integer;
  --
  File_Handle    utl_file.file_type;        -- File handle
  Output_File    utl_file.file_type;        -- File handle
  Section_Unique road_segs.rse_unique%type; -- Section identifier
  Section_Descr  road_segs.rse_descr%type;  -- Section description
  debug          boolean:=false;
  --
  FFile    varchar2(80);     -- Input file name
  FDest    varchar2(80);     -- Input directory name
  Ftype    varchar2(1);      -- File type
  FSuffix  varchar2(3);      -- Entered file suffix
  FSeq     number;           -- Sequence number
  --
  FRead      char:='R';      -- Read character
  FWrite     char:='W';      -- Write character
  v_csv      boolean:=true;  -- Boolean value for the output record type
  v_filename varchar2(80);   -- Compound filename
  StartLine  varchar2(80):='Highways By Exor (c)1999';
  EndOfFile  boolean:=false; -- End of file indicator
  separator  char(1):=',';   -- Field separator character
  --
  -- Record Types
  --
  RecA char:='A';  -- Order header       record type
  RecB char:='B';  -- Priority/Cost      record type
  RecD char:='D';  -- Property Reference record type
  RecL char:='L';  -- Order Description  record type
  RecT char:='T';  -- Bill Item          record type
  RecU char:='U';  -- Bill notes         record type
  RecZ char:='Z';  -- Terminator         record type
  --
  DemoLine varchar2(80):='-- Highways By EXOR ?1999';
  --
--
-- This procedure should be executable from several modules since
-- the program will be capable of generating several output files of
-- verious defined formats. A third parameter has therefore been added
-- to the GRI parameters and this will indicate the type of output
-- produced by the procedure.
-- File Types are : 'S' - Sections
--                  'W' - Work Orders
--                  'I' - Invoice details
--                  'C' - Completions
--
-----------------------------------------------------------------------------
--
Procedure Get_Params(job_id in number)
is
begin
  --
  FSeq := higgrirp.get_parameter_value(job_id,'A_NUMBER');
  FDest:= higgrirp.get_parameter_value(job_id,'TEXT');
  FType:= upper(higgrirp.get_parameter_value(job_id,'FILETYPE'));
  FFile:= upper(higgrirp.get_parameter_value(job_id,'FILENAME'));
  --
  if debug
  then dbms_output.put_line('');
       dbms_output.put_line('Parameter Output Seq. : '||to_char(FSeq));
       dbms_output.put_line('Parameter Destination : '||FDest);
       dbms_output.put_line('Parameter Filetype    : '||FType);
       dbms_output.put_line('Parameter Input File  : '||FFile);
       dbms_output.put_line('');
  end if;
  --
end;
--
-- This function should check the values of the parameters obtained from
-- the GRI for the specified report.
--
-----------------------------------------------------------------------------
--
Function CheckParameters(FType in varchar2 )
return boolean is
begin
   /*
    This part of the program will now be performed by the
  GRI.
    if  (FSeq is null and FFile is null )
  or  FDest is null
  or  FType is null
  then return false;
  elsif  FType != 'S'
     and FFile is null
     then return false;
  else return true;
  end if;
  */
  return true;
end;
--
-- Obtain the next file sequence if one has not been provided
--
-----------------------------------------------------------------------------
--
Function GetFileSeq
return integer
is
   v_seq number;
   --
   cursor NextFileSeq
   is select file_id_seq.nextval
      from   dual;
   --
  begin
  --
    open  NextFileSeq;
  fetch NextFileSeq into v_seq;
  close NextFileSeq;
  --
  return v_seq;
  exception
    when -- Ora-2289 { Sequence does not exist }
  others
  then dbms_output.put_line('Error: Sequence does not exist - {GetFileSeq}');
        return 0;
end;
--
-- This function should return the number of csv fields in a string
--
-----------------------------------------------------------------------------
--
Function GetFields( InString in varchar2 )
return number
is
  i integer:=1;
  f integer:=0;
begin
  --
  loop
    exit when i>length(InString);
    if substr(InString,i,1)=','
    then f:=f+1;
    end if;
  i:=i+1;
  end loop;
  f:=f+1;
  return f;
end;
--
-- This function should return the specified field from the incoming string buffer.
--
-----------------------------------------------------------------------------
--
Function GetField( InString in varchar2,FldNo in number )
return varchar2
is
  fldstg varchar2(254);-- Return string
  sp    integer:=1;    -- Start point
  ep    integer;       -- End point
begin
  --
  if    FldNo=1
  then  sp:=0;
        ep:=instr(InString,',',1)-1;
  elsif FldNo<GetFields(InString)
  then  sp:=instr(InString,',',1,(FldNo-1))+1;
        ep:=instr(InString,',',1,(FldNo));
  else  sp:=instr(InString,',',1,(FldNo-1))+1;
        ep:=length(InString)+1;
  end if;
  --
  if sp=ep
  then fldstg:='';
  else fldstg:=substr(InString,sp,(ep-sp));
  end if;
  --
  return FldStg;
end;
--
-- Procedure Create File
--
-----------------------------------------------------------------------------
--
Procedure  Create_File(loc_in in varchar2
                     ,file_in in varchar2
           ,line_in in varchar2)
is
Begin
  -- Open the specified file for writing
  file_handle:=utl_file.fopen(loc_in,file_in,FWrite);
  if   line_in is not null
  then utl_file.put_line(file_handle,line_in);
  else utl_file.put_line(file_handle,'Info: End-Of-File here');
  end if;
  --
  --utl_file.fclose(file_handle);
exception
when others
then dbms_output.put_line('Error: An unknown errorr occured - {Create_File}');
end;
--
-- Check for the existance of a specified file
--
-----------------------------------------------------------------------------
--
Function FileExists( loc_in   in varchar2
                    ,file_in  in varchar2 )
return boolean
is
begin
  --
  if debug
  then dbms_output.put_line('Path   : '||loc_in);
       dbms_output.put_line('File   : '||file_in);
       dbms_output.put_line('Action : '||FWrite);
  end if;
  --
  if not is_open(file_handle)
  then file_handle:=utl_file.fopen(loc_in,file_in,FWrite);
  end if;
  --
  if debug
  then dbms_output.put_line('Info: Handle Obtained - {FileExists}');
  end if;
  --
  --
  return true;
  --
  exception
  when utl_file.invalid_operation
  then dbms_output.put_line('Error: An invalid operation occured - {FileExists}');
  when utl_file.invalid_path
  then dbms_output.put_line('Error: An invalid path error occured - {FileExists}');
  when utl_file.read_error
  then dbms_output.put_line('Error: A read error occured on the specified file - {FileExists}');
  when utl_file.write_error
  then dbms_output.put_line('Error: Cannot write to the specified file - {FileExists}');
  when utl_file.internal_error
  then dbms_output.put_line('Error: An internal error was found - {FileExists}');
  when utl_file.invalid_filehandle
  then dbms_output.put_line('Error: The specified file handle does not identify a valid file');
  when utl_file.invalid_mode
  then dbms_output.put_line('Error: Invalid mode - {FileExists}');
  when others
  then dbms_output.put_line('Error: Unable to create file '||Loc_In||File_In||' {FileExists}');
       return false;
end;
--
-- Check to see wether a specified file is open
--
-----------------------------------------------------------------------------
--
Function Is_Open(file_in in utl_file.file_type)
return boolean
is
begin
  if utl_file.is_open(file_in)
  then return true;
  else return false;
  end if;
end;
--
-- Closes an open file.
--
-----------------------------------------------------------------------------
--
Function Close_File(file_in in utl_file.file_type)
return boolean
is
begin
   utl_file.fclose(File_Handle);
   if is_open(File_Handle)
   then return false;
   else return true;
   end if;
end;
--
-- Write an output line to a file
--
-----------------------------------------------------------------------------
--
Function Writeln(File_Handle in utl_file.File_Type, line_in in varchar2 )
return boolean
is
  j integer;
begin
  --
  if debug
  then dbms_output.put_line('Info: '||line_in);
  end if;
  --
  utl_file.put_line(File_Handle,line_in);
  -- utl_file.fflush(File_Handle);
  return true;
  exception
    when others
  then return false;
end;
--
--
-----------------------------------------------------------------------------
--
Function GetFileType( VModule in varchar2 )
return varchar2
is
    --
    ModuleSuffix gri_modules.grm_file_type%type;
  --
    cursor get_suffix
  is select grm_file_type
     from   gri_modules
     where  grm_module=vModule;
begin
   open  get_suffix;
   fetch get_suffix into ModuleSuffix;
   if    get_suffix%notfound
   then  ModuleSuffix:='lis';
         close get_suffix;
   else  close get_suffix;
   end if;
   return ModuleSuffix;
end;
--
-- Test procedure to list all errors into the file.
--
-----------------------------------------------------------------------------
--
Procedure Put_errors( loc_in  in varchar2
                     ,file_in in varchar2)
is
  --
  v_line varchar2(80);
  --
  cursor all_errors
  is select her_no
           ,her_appl
       ,her_descr
   from hig_errors
   order by
          her_no
         ,her_appl
       ,her_descr;
begin
   for each_error in all_errors
   loop
      --
      v_line:=substr(to_char(each_error.her_no) ||' '||
                    each_error.her_appl       ||' '||
           substr(each_error.her_descr,1,50),1,80);
      --
    dbms_output.put_line(v_line);
    utl_file.put_line(File_Handle,v_line);
    utl_file.fflush(File_Handle);
   end loop;
  exception
    when utl_file.invalid_operation then
  dbms_output.put_line('Error: Cannot write to a readonly file');
  when utl_file.write_error then
  dbms_output.put_line('Error: Unable to write to the file.');
  when others
  then dbms_output.put_line('Error: Unidentified exception');
end;
/* =======================================================================
   COMPLETIONS
      The following section details the completions output file procedure.
    A file will be provided with the following format :
      DLO Job Number        A(8)  DLO = Direct Labour Orgaisation
    Order Number          A(12) Wol Number
    Job Status            A(8)
    Actual Completin Date A(6) DDMMYY '00' Assume 2000
   a) Read in the completions file.
   b) Reformat and provide an output file.
   =======================================================================
*/
--
-- This procedure shoud go through the whole record array and should
-- create an array of record types and counters.
--
-----------------------------------------------------------------------------
--
Function ProcessComplRecords(job_id in number )
return boolean
is
   --
   type compl_rectype is record(   dlo_job_no     varchar2(8)
                                  ,order_no       varchar2(12)
                  ,job_status     varchar2(8)
                  ,act_compl_date varchar2(6));
   --
   type compl_table   is table of compl_rectype index by binary_integer;
   --
   completion_tab  compl_table;       -- Table of completion records
   total_rows      integer;           -- Total rows counter
   line_counter    integer:=1;        -- A line counter
   hrec            varchar2(2):='00'; -- Header     Record type
   crec            varchar2(2):='10'; -- Completion Record type
   zrec            varchar2(2):='15'; -- Check      Record type
   hcontractor     varchar2(3);       -- Contractor code
   hline           varchar2(80);      -- H Record output buffer
   cline           varchar2(500);     -- C Record output buffer
   zline           varchar2(80);      -- Z Record output buffer
   v_buffer        varchar2(80);      -- character based buffer
   v_wol_id        work_order_lines.wol_id%type;
   v_work_order_no work_orders.wor_works_order_no%type;
   v_def_id        work_order_lines.wol_def_defect_id%type;
   v_schd_id       work_order_lines.wol_schd_id%type;
   fn              varchar2(30):='{ProcessComplRecords}';
   invalid_order   exception;
   compl_file      utl_file.file_type;
   --
   cursor get_wor_no is
     select wol_works_order_no
           ,wol_def_defect_id
           ,wol_schd_id
    from   work_order_lines
    where  wol_id = v_wol_id;

   cursor contractor_id(p_wol_id work_order_lines.wol_id%type)
   is select oun_contractor_id
      from   org_units
          ,work_order_lines
      ,work_orders
      ,contracts
    where  wol_id = p_wol_id
    and    wol_works_order_no = wor_works_order_no
    and    wor_con_id = con_id
    and    con_contr_org_id = oun_org_id;

begin
  --
  -- Open the input file for reading.
  --
  compl_file := utl_file.fopen(FDest,FFile,FRead);
  -- this next line causes oracle to crash!!!!!!
/*  if not is_open(compl_file)
  then dbms_output.put_line('Error: Unable to obtain file '||FDest||'/'||FFile||' for reading');
  end if;*/
  --
  line_counter:=1;
  while not EndOfFile
  loop
    get_nextline(compl_file,v_buffer,EndOfFile);
    --
    if debug
  then dbms_output.put_line('Buffer: '||v_buffer||'  length: '||to_char(length(v_buffer)));
  end if;
  --
  if length(v_buffer)=37
  then completion_tab(line_counter).dlo_job_no    :=substr(v_buffer,1,8);
       completion_tab(line_counter).order_no      :=substr(v_buffer,10,12);
       completion_tab(line_counter).job_status    :=substr(v_buffer,22,8);
       completion_tab(line_counter).act_compl_date:=substr(v_buffer,32,6);

     if debug
     then dbms_output.put_line(' Job   : ' ||completion_tab(line_counter).dlo_job_no  ||
                                ' Order : ' ||completion_tab(line_counter).order_no    ||
                       ' Status: ' ||completion_tab(line_counter).job_status  ||
                               ' Compl : ' ||completion_tab(line_counter).act_compl_date);
     end if;
       --
         line_counter:=line_counter+1;
       --

    elsif not EndOfFile
  then dbms_output.put_line('Line is not 37 characters in length - '||v_buffer);
  end if;
  end loop;
  --
  utl_file.fclose(compl_file);
  --
  hcontractor := 'UKN'; -- at this point the contractor is unknown
  --
  -- Use any record to get the contractor id to put in the header record and
  -- use as the output file extension
  --
  for i in 1..completion_tab.count loop
    if completion_tab(i).order_no is not null then
      open contractor_id(completion_tab(i).order_no);
      fetch contractor_id into hcontractor;
      if contractor_id%found then
        close contractor_id;
        exit;
  end if;
      close contractor_id;
    end if;
  end loop;
  --
  -- Define file name for and open output file
  --
  FSeq:=job_id;
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  --
  v_filename:='WC'||to_char(FSeq)||'.'||hcontractor;
  --

  if  not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
  else if debug
       then dbms_output.put_line('Info: The file '||FDest||v_filename||' exists - {ProcessComplRecords}');
     end if;
       if is_open(File_Handle)
     then if debug
          then dbms_output.put_line('Info: The file exists and is open - {ProcessComnplRecords}');
      end if;
     end if;
  end if;

  --
  -- Create and write header record
  --
  hline:=hrec                                         ||separator||
         hcontractor                                ||separator||
       to_char(Fseq)                ||separator||
       to_char(sysdate,'DDMMYYYY')                ||separator||
       to_char(sysdate,'HH:MM:SS');
  if not writeln(File_Handle,hline)
  then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
  end if;
  line_counter:=1; -- Record type 10 counter.
  for i in 1..completion_tab.count
  loop
  --
  if debug
  then dbms_output.put_line(' Job   : ' ||completion_tab(i).dlo_job_no  ||
                            ' Order : ' ||completion_tab(i).order_no    ||
                          ' Status: ' ||completion_tab(i).job_status  ||
                          ' Compl : ' ||to_char(to_date(
            completion_tab(i).act_compl_date,'ddmmrr'),'ddmmyyyy'));
  end if;

  v_wol_id := to_number(completion_tab(i).order_no);
  open  get_wor_no;
  fetch get_wor_no into v_work_order_no,
                            v_def_id,
                            v_schd_id;
  if    get_wor_no%notfound
  then  dbms_output.put_line('Error: Cannot find Work Order for Line '||to_char(v_wol_id)||' - '||fn);
      v_work_order_no := 'Not Found';
        close get_wor_no;
  else  close get_wor_no;
  end if;
  --

  if debug
  then dbms_output.put_line(' Order : ' ||lpad(v_work_order_no,16) ||
        ' Wol   : ' ||lpad(to_char(v_wol_id),9));
  end if;
    --
  cline:=crec                               ||separator||
       v_work_order_no            ||separator||
               to_char(v_wol_id)                ||separator||
       to_char(v_def_id)            ||separator||
       to_char(v_schd_id)            ||separator||
       to_char(to_date(completion_tab(i).act_compl_date,'ddmmrr'),'ddmmyyyy')
                      ||separator||
       ''                  ||separator||
       ''                  ||separator||
       completion_tab(i).dlo_job_no;
    --
    if not writeln(File_Handle,cline)
    then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
    end if;
  --
  end loop;
  --
  zline:=zrec||separator||to_char(completion_tab.count);
  if not writeln(File_Handle,zline)
  then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
  end if;
  utl_file.fclose(File_Handle);
  --
  dbms_output.put_line('');
  dbms_output.put_line('');
  dbms_output.put_line('Output File : '||v_filename);
  dbms_output.put_line('Directory   : '||FDest);
  --
  return true;
  exception
    when utl_file.invalid_operation
    then dbms_output.put_line('Error: An invalid operation occured (this can include an invalid filename) - '||fn);
         return false;
    when utl_file.invalid_path
    then dbms_output.put_line('Error: An invalid path error occured - '||fn);
       return false;
    when utl_file.read_error
    then dbms_output.put_line('Error: A read error occured on the specified file - '||fn);
       return false;
    when utl_file.write_error
    then dbms_output.put_line('Error: Cannot write to the specified file - '||fn);
       return false;
    when utl_file.internal_error
    then dbms_output.put_line('Error: An internal error was found - '||fn);
       return false;
    when utl_file.invalid_filehandle
    then dbms_output.put_line('Error: The specified file handle does not identify a valid file - '||fn);
       return false;
    when utl_file.invalid_mode
    then dbms_output.put_line('Error: Invalid mode - '||fn);
       return false;
    when invalid_number
    then dbms_output.put_line('Error: Invalid number exception raised - '||fn);
         return false;
    when value_error
    then dbms_output.put_line('Error: Value error exception raised - '||fn);
         return false;
  when invalid_order
  then dbms_output.put_line('Error: Invalid order number, cannot obtain contractor - '||fn);
         return false;
    when others
    then dbms_output.put_line('Error: An Unknown exception Occured - '||fn);
  -- check for open files here first
       if   is_open(compl_file)
     then utl_file.fclose(compl_file);
     end if;
     if   is_open(File_Handle)
     then utl_file.fclose(File_Handle);
     end if;
     return false;
end;
--
-- This procedure should create a file which contains the client network details
-- This file should be of the format : Link      (a6)
--                                     Separator '/'
--                                     Section   (a2)
--
-----------------------------------------------------------------------------
--
Function ProcessSectRecords( Job_Id in number )
return boolean
is   --
--     vModule    gri_modules.grm_module%type:='MAI3859C';
   ModSuffix  gri_modules.grm_file_type%type;
   v_filename varchar2(30);
     v_line     varchar2(120);
   v_buffer   varchar2(500);
   fn         varchar2(30):='{ ProcessSectRecords }';
   --
     cursor All_Sections
   is select rse_linkcode||'/'||substr(rtrim(rse_sect_no),4,2) section
            ,rse_descr description
      from   road_segs
    where  rse_type='S';
  --
begin
  --
  --
  -- Obtain the specified file name and location
  --
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  --
  ModSuffix:='sec'; --GetFileType(vModule);
  --
  v_filename:=to_char(FSeq)||'.'||ModSuffix;
  --
  if  not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
  else if is_open(File_Handle) and debug
     then dbms_output.put_line('Info: The file exists and is open - '||fn);
     end if;
  end if;
  --
  for each_section in all_sections
  loop
      if   v_csv
    then v_line:=each_section.section||','||each_section.description;
    else v_line:='"'||each_section.section||'"'||' '||'"'||each_section.description||'"';
    end if;
      --
    -- dbms_output.put_line(v_line);
    utl_file.put_line(File_Handle,v_line);
    utl_file.fflush(File_Handle);
   end loop;
   if not close_file(File_Handle)
   then dbms_output.put_line('Error: The section details file could not be closed - '||fn);
   end if;
  dbms_output.put_line('');
  dbms_output.put_line('');
  dbms_output.put_line('Output File : '||v_filename);
  dbms_output.put_line('Directory   : '||FDest);
  return true;
  exception
    when utl_file.invalid_operation
  then dbms_output.put_line('Error: Cannot write section details to a readonly file - '||fn);
       return false;
  when utl_file.write_error
  then dbms_output.put_line('Error: Unable to write section details to the file - '||fn);
       return false;
  when others
  then dbms_output.put_line('Error: Unidentified exception - '||fn);
       return false;
end;
--
-- Get the next line of the specified file.
--
-----------------------------------------------------------------------------
--
Procedure Get_NextLine( in_file  in utl_file.file_type
                       ,out_line out varchar2
             ,not_eof  out boolean )
is
begin
   utl_file.get_line(in_file,out_line);
   not_eof:=false;
exception
  when no_data_found
  then out_line:=null;
       not_eof:=true;
end;
--
-- Load the specified table into the specified pl/sql table
--
Procedure File_To_Table ( loc_in   in varchar2
                         ,file_in  in varchar2
             ,table_in in out sections_tabtype )
is
  names_file utl_file.file_type:=utl_file.fopen(loc_in,file_in,FRead);
  line_counter integer:=1;
begin
  while not EndOfFile
  loop
    get_nextline(names_file,table_in(line_counter),EndOfFile);
  line_counter:=line_counter+1;
  end loop;
  utl_file.fclose(names_file);
end;
--
--
--
-----------------------------------------------------------------------------
--
Procedure Exor_File_To_Table ( loc_in   in varchar2
                              ,file_in  in varchar2
                  ,table_in in out Exor_Load_Table )
is
  names_file utl_file.file_type:=utl_file.fopen(loc_in,file_in,FRead);
  line_counter integer:=1;
begin
  while not EndOfFile
  loop
    get_nextline(names_file,table_in(line_counter),EndOfFile);
  line_counter:=line_counter+1;
  dbms_output.put_line(line_counter);
  end loop;
  utl_file.fclose(names_file);
end;
--
-- Display the specified table contents.
--
Procedure Display_Load_Table( table_in in sections_tabtype)
is
   total_rows integer;
begin
  total_rows:=table_in.count;
  dbms_output.put_line('There are '||to_char(total_rows)||' rows.');
  for i in 1..total_rows
  loop
    dbms_output.put_line(table_in(i));
  end loop;
end;
--
-- Display the specified table contents.
--
Procedure Display_Load_Table( table_in in exor_load_table)
is
   total_rows integer;
begin
  total_rows:=table_in.count;
  dbms_output.put_line('There are '||to_char(total_rows)||' rows.');
  for i in 1..total_rows
  loop
    dbms_output.put_line(table_in(i));
  end loop;
end;
--
-- Load an Exor filetype
--
-----------------------------------------------------------------------------
--
Function Load_Exor_File( In_Loc  in varchar2
                        ,in_File in varchar2
            ,table_in in out exor_load_table )
return boolean
is
begin
  Exor_File_To_Table(In_Loc,In_File,Table_In);
  return true;
  exception
    when others
  then dbms_output.put_line('Error: There was an error loading the file - {Load_Exor_File');
       return false;
end;
--
-- This procedure shoud go through the whole record array and should
-- create an array of record types and counters.
--
-----------------------------------------------------------------------------
--
Procedure Check_Record_Types( table_in in exor_load_table)
is
   --
   type counter_rectype is record( rec_type varchar2(2)
                                  ,num_of   integer );
   type counter_table   is table of counter_rectype index by binary_integer;
   --
   counter_tab  counter_table;
   total_rows   integer:=table_in.count;
   counter_rows integer:=counter_tab.count;
   v_rec_type   varchar2(2):=null;
   located      boolean:=false;
begin
  total_rows:=table_in.count;
  dbms_output.put_line('There are '||to_char(total_rows)||' rows.');
  for i in 1..total_rows
  loop
    located:=false;
  v_rec_type:=substr(table_in(i),1,2);
  counter_rows:=counter_tab.count;
  for j in 1..counter_rows
  loop
      if counter_tab(j).rec_type=v_rec_type
    then located:=true;
         counter_tab(j).num_of:=counter_tab(j).num_of+1;
    end if;
  end loop;
  if not located
  then counter_tab(counter_rows+1).rec_type:=v_rec_type;
       counter_tab(counter_rows+1).num_of:=1;
  end if;
  end loop;
  counter_rows:=counter_tab.count;
  for i in 1..counter_rows
  loop
    dbms_output.put_line(counter_tab(i).rec_type||' : '||to_char(counter_tab(i).num_of));
  end loop;
end;
--
/*=======================================================================
  Work_Orders
      The following section details the Work Orders output file procedure.
    A file will be provided with the following format :
    DLO Job Number        A(8)  DLO = Direct Labour Orgaisation
    Order Number          A(12) Wol Number
    Job Status            A(8)
    Actual Completin Date A(6) DDMMYY '00' Assume 2000
   a) Read in the completions file.
   b) Reformat and provide an output file.
   =======================================================================
*/
--
-- This procedure should load the specified file going through each record.
-- For the selected record type the record is inserted into the appropreate
-- type related table. Once all records have ben loaded into pl/sql tables
-- the data can be addressed and reformatted into an output file.
--
-- Supplied record types are :
--   00 - Header
--   05
--   06
--   10
--   15
--   20 - Footer
--
-----------------------------------------------------------------------------
--
Function ProcessWorkRecords( job_id in number )
return boolean
is
   --
   vModule    gri_modules.grm_module%type:='MAI3859';
   type exor_header_rec is record( hrec          varchar2(2)
                                  ,contractor_id varchar2(3)
                  ,sequence      number(6)
                          ,date_created  varchar2(8)
                             ,time_created  varchar2(8));
   --
   type head_table is table of exor_header_rec index by binary_integer;
   --
   header_tab      head_table;        -- Table of header records
   --
   fn              varchar2(20):='{ProcessWorkRecords}';
   total_rows      integer;           -- Total rows counter
   counter_rows    integer:=1;        -- Row counter value
   located         boolean:=false;    -- Location indicator
   boq_located     boolean:=false;    -- BOQ location identifier
   --
   wol_index       integer:=1;        -- Wol table record counter
   wor_index       integer:=1;        -- Wor table record counter
   boq_index       integer:=1;        -- Boq table record counter
   wor_d_index     integer:=1;        -- Wor description record counter
   --
   arec            varchar2(1):='A';  -- Output header record type
   brec            varchar2(1):='B';  -- Output B record type
   drec            varchar2(1):='D';  -- Output D record type
   lrec            varchar2(1):='L';  -- Output L record type
   trec            varchar2(1):='T';  -- Output T record type
   urec            varchar2(1):='U';  -- Output U record type
   zrec            varchar2(1):='Z';  -- Output Z record type
   --
   hcontractor     varchar2(3);       -- Contractor code
   hsequence       number:=1;         -- Sequence Number
   hline           varchar2(80);      -- H Record output buffer
   cline           varchar2(500);     -- C Record output buffer
   zline           varchar2(80);      -- Z Record output buffer
   zrec_count      number:=1;         -- Number of 'C' records
   v_buffer        varchar2(2000);    -- character based buffer
   separator       varchar2(3):='" "';-- Output field separator
   v_space         char:=' ';         -- Space field separator.
   v_wol_id        work_order_lines.wol_id%type;
   v_work_order_no work_orders.wor_works_order_no%type;
   v_defect_id     defects.def_defect_id%type;
   v_schd_id       schedules.schd_id%type;
   v_date          varchar2(8);       -- Date variable
   v_time          varchar2(8);       -- Time variable
   rectype         varchar2(2);       -- Record Type
   transtype     varchar2(1);      -- Transaction Type
   TotWorkOrderRecs integer;          -- Total work order records
   s               integer;
   i               integer;
   j               integer;
   k               integer;
   l               integer;
   fld             varchar2(255);
   rec_type        varchar2(2);       -- Record type
   total_value     number(11,2);      -- Sum total BOQ cost value.
   last_total_value number(11,2);      -- Sum total BOQ cost value.
   last_boq_item   standard_items.sta_item_code%type:=null;
   rec             integer:=0;
   --
   -- Define the three record types.
   --
   type wor_rec is record (IWOR_TRANSACTION_TYPE      VARCHAR2(1)
                          ,IWOR_WORKS_ORDER_NO          VARCHAR2(16)
                          ,IWOR_SCHEME_TYPE             VARCHAR2(2)
                          ,IWOR_CON_CODE                VARCHAR2(10)
                          ,IWOR_ORIGINATOR              VARCHAR2(40)
                          ,IWOR_DATE_CONFIRMED          DATE
                          ,IWOR_EST_COMPLETE            DATE
                          ,IWOR_COST                    NUMBER(11,2)
                          ,IWOR_EST_LABOUR              NUMBER(11,2)
                          ,IWOR_INTERIM_PAYMENT_FLAG    VARCHAR2(1)
                          ,IWOR_RISK_ASSESSMENT_FLAG    VARCHAR2(1)
                          ,IWOR_METHOD_STATEMENT_FLAG   VARCHAR2(1)
                          ,IWOR_WORKS_PROGRAMME_FLAG    VARCHAR2(1)
                          ,IWOR_ADDITIONAL_SAFETY_FLAG  VARCHAR2(1)
                          ,IWOR_COMMENCE_BY             DATE
                          ,IWOR_FYR_ID                  VARCHAR2(5));
   --
   type wor_descr_rec is record (wor_descr work_orders.wor_descr%type);
   --
   type wol_rec is record (IWOL_ID                   NUMBER(9)
                          ,IWOL_WORKS_ORDER_NO       VARCHAR2(16)
                          ,IWOL_DEF_DEFECT_ID        NUMBER(8)
                          ,IWOL_SCHD_ID              NUMBER(9)
                          ,IWOL_ROAD_ID              VARCHAR2(20)
                          ,IWOL_ROAD_DESCR           VARCHAR2(80)
                          ,IWOL_DEF_LOCN_DESCR       VARCHAR2(1000) -- clb 05012011 Task 0107258
                          ,IWOL_DEF_DEFECT_DESCR     VARCHAR2(254)
                          ,IWOL_DEF_SPECIAL_INSTR    VARCHAR2(254)
                          ,IWOL_DEF_PRIORITY         VARCHAR2(4)
                          ,IWOL_DEF_DEFECT_CODE      VARCHAR2(4)
                          ,IWOL_DEF_ST_CHAIN         NUMBER(6)
                          ,IWOL_DEF_X_SECT           VARCHAR2(4)
                          ,IWOL_PERCENT_ADJUST       NUMBER(4,2)
                          ,IWOL_PERCENT_ADJUST_CODE  NUMBER(2)
                          ,IWOL_WORK_CAT             VARCHAR2(10)
                          ,IWOL_COST_CODE            VARCHAR2(60)
                          ,IWOL_DEF_ACTY             VARCHAR2(2)
                          ,IWOL_ITY_INV_CODE         VARCHAR2(2)
                          ,IWOL_IIT_ITEM_ID          NUMBER(8)
                          ,IWOL_DATE_WORK_DONE       DATE
                          ,IWOL_REP_ACTION_CAT       VARCHAR2(1)
                          ,IWOL_REP_DESCR            VARCHAR2(240)
                          ,IWOL_REP_TRE_TREAT_CODE   VARCHAR2(4)
                          ,IWOL_REP_DATE_DUE         DATE);
   --
     type boq_rec is record ( IBOQ_WOL_ID               NUMBER(9)
                             ,IBOQ_STA_ITEM_CODE        VARCHAR2(10)
                             ,IBOQ_DIM1                 NUMBER(10,2)
                             ,IBOQ_DIM2                 NUMBER(10,2)
                             ,IBOQ_DIM3                 NUMBER(10,2)
                             ,IBOQ_QUANTITY             NUMBER(10,2)
                             ,IBOQ_RATE                 NUMBER(10,2)
                             ,IBOQ_COST                 NUMBER(10,2)
                             ,IBOQ_PERCENT_ADJUST       NUMBER(4,2)
                             ,IBOQ_PERCENT_ADJUST_CODE  NUMBER(2)
                             ,IBOQ_AMALGAMATED          VARCHAR2(1));
   --
   type wor_table       is table of wor_rec index by       binary_integer;
   type wor_descr_table is table of wor_descr_rec index by binary_integer;
   type wol_table       is table of wol_rec index by       binary_integer;
   type boq_table       is table of boq_rec index by       binary_integer;
   --
   -- Define the input pl/sql tables
   --
   ModSuffix  gri_modules.grm_file_type%type;
   wor_tab wor_table;             -- Define the actual table wor_tab
   wol_tab wol_table;             -- Define the actual table wol_tab
   wor_descr_tab wor_descr_table; -- Define the work order description table
   boq_tab boq_table;             -- Define the actual table boq_tab
   boq_temp_tab boq_table;        -- Temporary BOQ table
   boq_temp_tab_empty boq_table;  -- Temporary BOQ table used for truncating a pl/sql table
   --
   c_00 integer:=0;
   c_05 integer:=0;
   c_06 integer:=0;
   c_10 integer:=0;
   c_15 integer:=0;
   c_20 integer:=0;
   c_u  integer:=0;
   --
   h_rec_type varchar2(2);
   h_rec_dso  varchar2(3);
   h_rec_seq  number(6);
   h_rec_date varchar2(8);
   h_rec_time varchar2(8);
   --
   z_rec_type varchar2(2);
   z_rec_no   integer:=0;
   z_rec_chrs integer:=0;
   --
   cursor get_wol_details( v_wol_id in work_order_lines.wol_id%type )
   is select substr(con_code,1,3)
      from   work_orders
          ,work_order_lines
          ,contracts
      where  wor_works_order_no = wol_works_order_no
    and    wol_id             = v_wol_id
    and    wor_con_id         = con_id;
   --
   cursor get_wol_details2(v_wol_id in work_order_lines.wol_id%type)
   is select wor_works_order_no
            ,wol_def_defect_id
      ,wol_schd_id
      ,to_char(rep_date_completed,'DDMMYYYY')
      ,to_char(rep_date_completed,'HH:MM:SS')
    from   work_orders
          ,work_order_lines
      ,defects
      ,repairs
    where  wol_id = v_wol_id
    and    wol_works_order_no = wor_works_order_no
    and    def_defect_id      = wol_def_defect_id
    and    rep_def_defect_id  = def_defect_id;
  --
begin
  --
  -- Obtain the specified file name and location
  --
  FSeq:=job_id;
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  --
  ModSuffix:=GetFileType(vModule);
  --
  v_filename:=to_char(FSeq)||'.'||ModSuffix;
  --
  -- Open the input file for reading.
  --
  if is_open(file_handle)
  then if not close_file(file_handle)
       then dbms_output.put_line('Error: Unable to close file - '||fn);
     else dbms_output.put_line('Info: Closed file - '||fn);
     end if;
  end if;
  --
  file_handle:=utl_file.fopen(FDest,FFile,FRead);
  if not is_open(file_handle)
  then dbms_output.put_line('Error: Unable to open file for reading - '||fn);
  end if;
  --
  -- Obtain the specified file name and location
  --
  while not EndOfFile
  loop
    get_nextline(File_Handle,v_buffer,EndOfFile);
    --
  -- Obtain the record type from the standard exor output file.
  -- The record types should be 00,05,06,10,15,20
  rectype:=substr(v_buffer,1,2);
  if    rectype='00'
  then if GetFields(v_buffer)!=5
       then dbms_output.put_line('Error: 00 - '||to_char(GetFields(v_buffer))||'/5 fields expected - '||fn);
         else -- Fields that make up the header record are : Type,   ,  , Date,Time
       h_rec_type:=GetField(v_buffer,1); -- Obtain the 1st field
       h_rec_dso :=GetField(v_buffer,2); -- Obtain the 2nd field
           h_rec_seq :=GetField(v_buffer,3); -- Obtain the 3rd field
           h_rec_date:=GetField(v_buffer,4); -- Obtain the 4th field
           h_rec_time:=GetField(v_buffer,5); -- Obtain the 5th field
       --
       if debug
       then dbms_output.put_line('Type : '||h_rec_type);
                dbms_output.put_line('Dso  : '||h_rec_dso);
                 dbms_output.put_line('Seq  : '||h_rec_seq);
               dbms_output.put_line('Date : '||h_rec_date);
                dbms_output.put_line('Time : '||h_rec_time);
       end if;
       --
     end if;
       c_00:=c_00+1;
  elsif rectype='05' -- Work Order details
  then transtype := GetField(v_buffer,2);
         if transtype not in ('D', 'A') -- strip out all deletion and amend transactions
       then c_05:=c_05+1;
            if GetFields(v_buffer)!=17
          then dbms_output.put_line('Error: 05 - '||to_char(GetFields(v_buffer))||'/17 fields expected - '||fn);
              else wor_tab(wor_index).IWOR_TRANSACTION_TYPE:=GetField(v_buffer,2);
                   wor_tab(wor_index).IWOR_WORKS_ORDER_NO  :=GetField(v_buffer,3);
             wor_tab(wor_index).IWOR_SCHEME_TYPE     :=GetField(v_buffer,4);
                 wor_tab(wor_index).IWOR_CON_CODE        :=GetField(v_buffer,5);
                 wor_tab(wor_index).IWOR_ORIGINATOR      :=GetField(v_buffer,6);
                 wor_tab(wor_index).IWOR_DATE_CONFIRMED  :=to_date(GetField(v_buffer,7),'DDMMYYYY'); -- Date
                   wor_tab(wor_index).IWOR_EST_COMPLETE          :=to_date(GetField(v_buffer,8),'DDMMYYYY');-- Date
              wor_tab(wor_index).IWOR_COST                  :=to_number(GetField(v_buffer,9)); -- Number
               wor_tab(wor_index).IWOR_EST_LABOUR            :=to_number(GetField(v_buffer,10));-- Number
              wor_tab(wor_index).IWOR_INTERIM_PAYMENT_FLAG  :=GetField(v_buffer,11);
                   wor_tab(wor_index).IWOR_RISK_ASSESSMENT_FLAG  :=GetField(v_buffer,12);
                   wor_tab(wor_index).IWOR_METHOD_STATEMENT_FLAG :=GetField(v_buffer,13);
                   wor_tab(wor_index).IWOR_WORKS_PROGRAMME_FLAG  :=GetField(v_buffer,14);
                   wor_tab(wor_index).IWOR_ADDITIONAL_SAFETY_FLAG:=GetField(v_buffer,15);
             wor_tab(wor_index).IWOR_COMMENCE_BY           :=to_date(GetField(v_buffer,16),'DDMMYYYY');
                   wor_tab(wor_index).IWOR_FYR_ID                :=to_number(GetField(v_buffer,17));
                   --
             -- These lines should be left in place.
             --
             if debug
             then dbms_output.put_line('Type       : '||rectype);
                 dbms_output.put_line('Trans Type : '||wor_tab(wor_index).IWOR_TRANSACTION_TYPE);
                   dbms_output.put_line('Order Num  : '||wor_tab(wor_index).IWOR_WORKS_ORDER_NO);
                  dbms_output.put_line('Scheme     : '||wor_tab(wor_index).IWOR_SCHEME_TYPE);
                 dbms_output.put_line('ConCode    : '||wor_tab(wor_index).IWOR_CON_CODE);
                  dbms_output.put_line('Originator : '||wor_tab(wor_index).IWOR_ORIGINATOR);
                  dbms_output.put_line('Confirmed  : '||to_char(wor_tab(wor_index).IWOR_DATE_CONFIRMED));
                 dbms_output.put_line('Est Compl  : '||to_char(wor_tab(wor_index).IWOR_EST_COMPLETE));
                 dbms_output.put_line('Cost       : '||to_char(wor_tab(wor_index).IWOR_COST));
                 dbms_output.put_line('Labour     : '||to_char(wor_tab(wor_index).IWOR_EST_LABOUR));
                  dbms_output.put_line('Payment    : '||wor_tab(wor_index).IWOR_INTERIM_PAYMENT_FLAG);
                  dbms_output.put_line('Risk       : '||wor_tab(wor_index).IWOR_RISK_ASSESSMENT_FLAG);
                 dbms_output.put_line('Method     : '||wor_tab(wor_index).IWOR_METHOD_STATEMENT_FLAG);
                 dbms_output.put_line('Programme  : '||wor_tab(wor_index).IWOR_WORKS_PROGRAMME_FLAG);
                  dbms_output.put_line('Add Safety : '||wor_tab(wor_index).IWOR_ADDITIONAL_SAFETY_FLAG);
                  dbms_output.put_line('Commence By: '||to_char(wor_tab(wor_index).IWOR_COMMENCE_BY));
                 dbms_output.put_line('Fyr Id     : '||wor_tab(wor_index).IWOR_FYR_ID);
             end if;
             --
            wor_index:=wor_index+1;
            --
            end if;
       end if;
  elsif rectype='06' -- Work Order Description record
  then if transtype not in ('D', 'A') -- strip out all deletion and amend transactions
       then if GetFields(v_buffer)!=2
            then dbms_output.put_line('Error: 06 - '||to_char(GetFields(v_buffer))||'/2 fields expected - '||fn);
              else -- Fields that make up the work order title record are Type and Description
                 --
                   wor_descr_tab(wor_d_index).wor_descr:=GetField(v_buffer,2);
               --
               c_06:=c_06+1;
               --
               wor_d_index:=wor_d_index+1;
               --
          end if;
     end if;
  elsif rectype='10' -- Work Order Line details
  then if transtype not in ('D', 'A') -- strip out all deletion and amend transactions
       then if GetFields(v_buffer)!=25
            then dbms_output.put_line('Error: 10 - '||to_char(GetFields(v_buffer))||'/25 fields expected - '||fn);
              else wol_tab(wol_index).IWOL_ID               :=to_number(GetField(v_buffer,2));
             wol_tab(wol_index).IWOL_WORKS_ORDER_NO  :=wor_tab(wor_index-1).IWOR_WORKS_ORDER_NO;
                   wol_tab(wol_index).IWOL_DEF_DEFECT_ID    :=to_number(GetField(v_buffer,3));
                 wol_tab(wol_index).IWOL_SCHD_ID          :=to_number(GetField(v_buffer,4));
--             wol_tab(wol_index).IWOL_ROAD_ID          :=substr(GetField(v_buffer,5),5,9);
-- discard agency and use last 2 digits of section no to handle both 2 and 5 digit section nos
             wol_tab(wol_index).IWOL_ROAD_ID :=
          substr(GetField(v_buffer,5),5,instr(GetField(v_buffer,5),'/')-5)||'/'||
          substr(substr(GetField(v_buffer,5),instr(GetField(v_buffer,5),'/')+1),
             length(substr(GetField(v_buffer,5),instr(GetField(v_buffer,5),'/')))-2);
                   wol_tab(wol_index).IWOL_ROAD_DESCR       :=GetField(v_buffer,6);
               wol_tab(wol_index).IWOL_DEF_LOCN_DESCR   :=GetField(v_buffer,7);
                   wol_tab(wol_index).IWOL_DEF_DEFECT_DESCR :=GetField(v_buffer,8);
             wol_tab(wol_index).IWOL_DEF_SPECIAL_INSTR:=GetField(v_buffer,9);
                   wol_tab(wol_index).IWOL_DEF_PRIORITY     :=GetField(v_buffer,10);
             wol_tab(wol_index).IWOL_DEF_DEFECT_CODE  :=GetField(v_buffer,11);
                   wol_tab(wol_index).IWOL_DEF_ST_CHAIN     :=to_number(GetField(v_buffer,12));
             wol_tab(wol_index).IWOL_DEF_X_SECT       :=GetField(v_buffer,13);
                   wol_tab(wol_index).IWOL_PERCENT_ADJUST   :=to_number(GetField(v_buffer,14));
                   wol_tab(wol_index).IWOL_PERCENT_ADJUST_CODE :=to_number(GetField(v_buffer,15));
             wol_tab(wol_index).IWOL_WORK_CAT         :=GetField(v_buffer,16);
             wol_tab(wol_index).IWOL_COST_CODE        :=GetField(v_buffer,17);
             wol_tab(wol_index).IWOL_DEF_ACTY         :=GetField(v_buffer,18);
             wol_tab(wol_index).IWOL_ITY_INV_CODE     :=GetField(v_buffer,19);
             wol_tab(wol_index).IWOL_IIT_ITEM_ID      :=to_number(GetField(v_buffer,20));
             wol_tab(wol_index).IWOL_DATE_WORK_DONE   :=to_date(GetField(v_buffer,21),'DDMMYYYY');
             wol_tab(wol_index).IWOL_REP_ACTION_CAT   :=GetField(v_buffer,22);
             wol_tab(wol_index).IWOL_REP_DESCR    :=GetField(v_buffer,23);
             wol_tab(wol_index).IWOL_REP_TRE_TREAT_CODE :=GetField(v_buffer,24);
             wol_tab(wol_index).IWOL_REP_DATE_DUE    :=to_date(GetField(v_buffer,25),'DDMMYYYY');
                 --
             if debug
             then dbms_output.put_line('Wol Id   : '||to_char(wol_tab(wol_index).IWOL_ID));
                  dbms_output.put_line('Defect   : '||to_char(wol_tab(wol_index).IWOL_DEF_DEFECT_ID));
                  dbms_output.put_line('Scheme   : '||to_char(wol_tab(wol_index).IWOL_SCHD_ID));
                  dbms_output.put_line('Road     : '||wol_tab(wol_index).IWOL_ROAD_ID);
                  dbms_output.put_line('Road Desc: '||wol_tab(wol_index).IWOL_ROAD_DESCR);
                  dbms_output.put_line('Location : '||wol_tab(wol_index).IWOL_DEF_LOCN_DESCR);
                  dbms_output.put_line('Def Descr: '||wol_tab(wol_index).IWOL_DEF_DEFECT_DESCR);
                  dbms_output.put_line('Special  : '||wol_tab(wol_index).IWOL_DEF_SPECIAL_INSTR);
                      dbms_output.put_line('Priority : '||wol_tab(wol_index).IWOL_DEF_PRIORITY);
                  dbms_output.put_line('Def Code : '||wol_tab(wol_index).IWOL_DEF_DEFECT_CODE);
                  dbms_output.put_line('Def Chain: '||to_char(wol_tab(wol_index).IWOL_DEF_ST_CHAIN));
                  dbms_output.put_line('XSP      : '||wol_tab(wol_index).IWOL_DEF_X_SECT);
                  dbms_output.put_line('% Adjust : '||wol_tab(wol_index).IWOL_PERCENT_ADJUST );
                  dbms_output.put_line('Adj Code : '||wol_tab(wol_index).IWOL_PERCENT_ADJUST_CODE);
                  dbms_output.put_line('Work Cat : '||wol_tab(wol_index).IWOL_WORK_CAT);
                  dbms_output.put_line('Cost Code: '||wol_tab(wol_index).IWOL_COST_CODE);
                  dbms_output.put_line('Def Acty : '||wol_tab(wol_index).IWOL_DEF_ACTY);
                  dbms_output.put_line('Inv Code : '||wol_tab(wol_index).IWOL_ITY_INV_CODE);
                  dbms_output.put_line('Item Id  : '||to_char(wol_tab(wol_index).IWOL_IIT_ITEM_ID));
                  dbms_output.put_line('Work done: '||to_char(wol_tab(wol_index).IWOL_DATE_WORK_DONE));
                  dbms_output.put_line('Act Cat  : '||wol_tab(wol_index).IWOL_REP_ACTION_CAT);
                  dbms_output.put_line('Rep Desc : '||wol_tab(wol_index).IWOL_REP_DESCR);
                  dbms_output.put_line('Tre Code : '||wol_tab(wol_index).IWOL_REP_TRE_TREAT_CODE);
                  dbms_output.put_line('Date Due : '||to_char(wol_tab(wol_index).IWOL_REP_DATE_DUE));
             end if;
             --
             wol_index:=wol_index+1;
             --
             c_10:=c_10+1;
             --
             end if;
    end if;
  elsif rectype='15'
  then if transtype not in ('D', 'A') -- strip out all deletion and amend transactions
       then if GetFields(v_buffer)!=11
            then dbms_output.put_line('Error: 15 - '||to_char(GetFields(v_buffer))||'/11 fields expected - '||fn);
              else
               boq_tab(boq_index).IBOQ_WOL_ID        :=to_number(GetField(v_buffer,2));
               boq_tab(boq_index).IBOQ_STA_ITEM_CODE :=GetField(v_buffer,3);
                 boq_tab(boq_index).IBOQ_DIM1          :=GetField(v_buffer,4);
           boq_tab(boq_index).IBOQ_DIM2          :=GetField(v_buffer,5);
              boq_tab(boq_index).IBOQ_DIM3          :=GetField(v_buffer,6);
                 boq_tab(boq_index).IBOQ_QUANTITY      :=to_number(GetField(v_buffer,7));
           boq_tab(boq_index).IBOQ_RATE          :=to_number(GetField(v_buffer,8));
               boq_tab(boq_index).IBOQ_COST          :=to_number(GetField(v_buffer,9));
                 boq_tab(boq_index).IBOQ_PERCENT_ADJUST:=to_number(GetField(v_buffer,10));
           boq_tab(boq_index).IBOQ_PERCENT_ADJUST_CODE:=to_number(GetField(v_buffer,11));
           --
           if debug
           then dbms_output.put_line('Wol      : '||to_char(boq_tab(boq_index).IBOQ_WOL_ID));
                dbms_output.put_line('Sta Item : '||boq_tab(boq_index).IBOQ_STA_ITEM_CODE);
                dbms_output.put_line('Dim1     : '||boq_tab(boq_index).IBOQ_DIM1);
                dbms_output.put_line('Dim2     : '||boq_tab(boq_index).IBOQ_DIM2);
                dbms_output.put_line('Dim3     : '||boq_tab(boq_index).IBOQ_DIM3);
                dbms_output.put_line('Quantity : '||to_char(boq_tab(boq_index).IBOQ_QUANTITY));
                dbms_output.put_line('Rate     : '||to_char(boq_tab(boq_index).IBOQ_RATE));
                dbms_output.put_line('Cost     : '||to_char(boq_tab(boq_index).IBOQ_COST));
                dbms_output.put_line('% Adjust : '||to_char(boq_tab(boq_index).IBOQ_PERCENT_ADJUST));
                dbms_output.put_line('Adjust Co: '||to_char(boq_tab(boq_index).IBOQ_PERCENT_ADJUST_CODE));
           end if;
           --
                 boq_index:=boq_index+1;
           --
           c_15:=c_15+1;
           --
            end if;
        end if;
  elsif rectype='20' -- Footer record
  then if GetFields(v_buffer)!=3
       then dbms_output.put_line('Error: 20 - '||to_char(GetFields(v_buffer))||'/3 fields expected - '||fn);
         else z_rec_type:=GetField(v_buffer,1); -- Obtain the 1st field
          z_rec_no  :=GetField(v_buffer,2); -- Obtain the 2nd field
          z_rec_chrs:=GetField(v_buffer,3); -- Obtain the 3rd field
          --
        if debug
        then dbms_output.put_line('Type : '||z_rec_type);
                   dbms_output.put_line('Recs : '||z_rec_no);
                    dbms_output.put_line('Chrs : '||z_rec_chrs);
        end if;
          --
            c_20:=c_20+1;
     end if;
     --
  else c_u:=c_u+1;
  end if;
  end loop;
  if debug
  then dbms_output.put_line('00 : '||to_char(c_00));
       dbms_output.put_line('05 : '||to_char(c_05));
       dbms_output.put_line('06 : '||to_char(c_06));
       dbms_output.put_line('10 : '||to_char(c_10));
       dbms_output.put_line('15 : '||to_char(c_15));
       dbms_output.put_line('20 : '||to_char(c_20));
       dbms_output.put_line('U  : '||to_char(c_u));
       dbms_output.put_line('Tot: '||to_char(wol_index+wor_index+boq_index+2));
  end if;
  --
  utl_file.fclose(file_Handle);
  --
  -- At this point we should have the respective records from the text file
  -- in pl/sql tables.
  -- We should be able to flick through the records to ensure that they exist
  -- as we expect.
  --
  if debug
  then dbms_output.put_line('There are : '||to_char(wor_tab.count)||' work order records');
       for i in 1..wor_tab.count
       loop dbms_output.put_line('Work Order Number : '||wor_tab(i).IWOR_WORKS_ORDER_NO);
       end loop;
       --
       for i in 1..wor_descr_tab.count
       loop dbms_output.put_line('Descr : '||wor_descr_tab(i).wor_descr);
       end loop;
       --
       for i in 1..wol_tab.count
       loop dbms_output.put_line('Wol : '||wol_tab(i).IWOL_ROAD_ID||' - '||to_char(wol_tab(i).IWOL_id));
       end loop;
       --
       dbms_output.put_line(boq_tab.count);
     --
       for i in 1..boq_tab.count
       loop dbms_output.put_line('Boq : '||to_char(boq_tab(i).IBOQ_WOL_ID)||' - '||boq_tab(i).IBOQ_STA_ITEM_CODE||' - '||
          boq_tab(i).IBOQ_cost );
       end loop;
  end if;
  --
  -- At this point we should be able to start to format the output and we should
  -- therefore be in a position to create the file that we require.
  --
  -- Record type 'A' - One per type '10' record,
  --
  if Is_Open(File_Handle)
  then if not Close_File(File_Handle)
       then dbms_output.put_line('Error: Unable to close handle on file - '||fn);
     end if;
  end if;
  --
  if  not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
/*  else dbms_output.put_line('Info: The file '||FDest||'\'||v_filename||' exists - '||fn);
       if is_open(File_Handle)
     then dbms_output.put_line('Info: The file exists and is open - '||fn);
     end if;
*/
  end if;
  --
  z_rec_no:=0; -- Initialize the record counter
  -- Work Order Number should be 12 characters.
  -- The 4th field should be 40 characters.
  --
  for l in 1..wor_tab.count
  loop

    for i in 1..wol_tab.count
    loop
    if wor_tab(l).IWOR_WORKS_ORDER_NO = wol_tab(i).IWOL_WORKS_ORDER_NO
    then v_buffer:='"'||arec                                  ||separator||
         lpad(to_char(wol_tab(i).IWOL_ID),12)          ||separator||
         lpad(substr(wor_tab(l).IWOR_CON_CODE,1,2),2)   ||separator||
         'HWAYS'                                       ||separator||
         lpad(wol_tab(i).IWOL_WORKS_ORDER_NO,16)       ||v_space  ||
         lpad(to_char(wol_tab(i).IWOL_DEF_DEFECT_ID),8)||v_space  ||
         lpad(wol_tab(i).IWOL_DEF_DEFECT_CODE,4)       ||v_space  ||
         lpad(wol_tab(i).IWOL_DEF_PRIORITY,26)||'"';
         --
         -- Output the 'A' type record
         --
           if not writeln(File_Handle,v_buffer)
         then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
         else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
              z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
         end if;
         --
         -- Go through all boq records for the specified work order line and
         -- sum total the cost value.
           --
         total_value:=0;
         for j in 1..boq_tab.count
         loop
           if   boq_tab(j).IBOQ_WOL_ID=wol_tab(i).iwol_id
         then total_value:=total_value+nvl(boq_tab(j).IBOQ_COST,0);
         end if;
         end loop;
         --
         -- for a non-defect work order line we will have to provide a default
         -- priority code. This code will therefore be set to '0' and this has
         -- been agreed with Blackburn.
         --
         v_buffer:='"'||brec                                ||separator||
                     nvl(wol_tab(i).IWOL_DEF_PRIORITY,'0')||separator||
                   lpad(to_char(total_value),12)||'"';
         --
           -- Output the 'B' type record
         --
           if not   writeln(File_Handle,v_buffer)
         then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
          else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
              z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
         end if;
         --
         -- The 'D' record should be ended with a 0 length null field ( ie two " )
         --
         v_buffer:='"'||drec                        ||separator||
                   wol_tab(i).IWOL_ROAD_ID          ||separator||
             'no'                             ||separator||
             wor_tab(l).IWOR_ORIGINATOR||'" ""';
         --
         -- Output the 'D' type record
         --
         if not   writeln(File_Handle,v_buffer)
         then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
           else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
              z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
         end if;
         --
         -- Deal with the road description
         --
         if wol_tab(i).IWOL_ROAD_DESCR is not null
         then j:=1;
              loop
              exit when j>=length(wol_tab(i).IWOL_ROAD_DESCR);
              v_buffer:='"'||lrec||separator||lpad(substr(wol_tab(i).IWOL_ROAD_DESCR,j,60),60)||'"';
              if not writeln(File_Handle,v_buffer)
                then   dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
             else   z_rec_no  :=z_rec_no+1;                  -- Count the number of records
                       z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
                end if;
              j:=j+60;
              end loop;
         end if;
         --
         -- Deal with the defect description
         --
         if wol_tab(i).IWOL_DEF_LOCN_DESCR is not null
         then j:=1;
              loop
                exit when j>=length(wol_tab(i).IWOL_DEF_LOCN_DESCR);
              v_buffer:='"'||lrec||separator||lpad(substr(wol_tab(i).IWOL_DEF_LOCN_DESCR,j,60),60)||'"';
              if not   writeln(File_Handle,v_buffer)
                then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
                  else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
                     z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
                end if;
              j:=j+60;
              end loop;
         end if;
         --
         -- Deal with the defect description
         --
         if wol_tab(i).IWOL_DEF_DEFECT_DESCR is not null
         then j:=1;
              loop
                exit when j>=length(wol_tab(i).IWOL_DEF_DEFECT_DESCR);
              v_buffer:='"'||lrec||separator||lpad(substr(wol_tab(i).IWOL_DEF_DEFECT_DESCR,j,60),60)||'"';
              if not   writeln(File_Handle,v_buffer)
                then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
                  else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
                     z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
                end if;
              j:=j+60;
              end loop;
         end if;
         --
         -- Deal with the Special Instructions
         --
         if wol_tab(i).IWOL_DEF_SPECIAL_INSTR is not null
         then j:=1;
              loop
                exit when j>=length(wol_tab(i).IWOL_DEF_SPECIAL_INSTR);
              v_buffer:='"'||lrec||separator||lpad(substr(wol_tab(i).IWOL_DEF_SPECIAL_INSTR,j,60),60)||'"';
              if not   writeln(File_Handle,v_buffer)
                then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
                  else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
                     z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
                end if;
              j:=j+60;
              end loop;
         end if;
         --
         -- Output the 'T' type records ( one per type '15' record - BOQ )
         -- Here the pre-processing will need to amalgamate together any duplicated
         -- bill items as duplicates are not allowed within the receiving system.
         --
         total_value:=0;
         rec:=1;
         --
         boq_temp_tab:=boq_temp_tab_empty;
         --
         for j in 1..boq_tab.count -- For all the BOQ item records
         loop if boq_tab(j).iboq_wol_id=wol_tab(i).iwol_id
              then
             if   boq_temp_tab.count=0
           then boq_temp_tab(rec).iboq_sta_item_code:=boq_tab(j).iboq_sta_item_code;
                boq_temp_tab(rec).iboq_quantity     :=boq_tab(j).iboq_quantity;
                boq_temp_tab(rec).iboq_dim1      :=boq_tab(j).iboq_dim1;
                boq_temp_tab(rec).iboq_dim2      :=boq_tab(j).iboq_dim2;
                boq_temp_tab(rec).iboq_dim3      :=boq_tab(j).iboq_dim3;
            boq_temp_tab(rec).iboq_amalgamated  :='N';
              rec:=rec+1;
                 else
             boq_located:=false;
            for k in 1..boq_temp_tab.count
              loop if   boq_temp_tab(k).iboq_sta_item_code   =boq_tab(j).iboq_sta_item_code
                 then boq_located:=true;
                  boq_temp_tab(k).iboq_quantity       :=boq_temp_tab(k).iboq_quantity+boq_tab(j).iboq_quantity;
                  boq_temp_tab(k).iboq_amalgamated    :='Y';
             end if;
          end loop;
                    if not boq_located
          then boq_temp_tab(rec).iboq_sta_item_code:=boq_tab(j).iboq_sta_item_code;
                   boq_temp_tab(rec).iboq_quantity     :=boq_tab(j).iboq_quantity;
             boq_temp_tab(rec).iboq_dim1     :=boq_tab(j).iboq_dim1;
              boq_temp_tab(rec).iboq_dim2     :=boq_tab(j).iboq_dim2;
             boq_temp_tab(rec).iboq_dim3     :=boq_tab(j).iboq_dim3;
                boq_temp_tab(rec).iboq_amalgamated  :='N';
             rec:=rec+1;
            end if;
               end if;
           end if;
        end loop;
        --
        -- The boq item should be 8 characters in length
        --
        for j in 1..boq_temp_tab.count -- Output the BOQ item lines.
        loop
          v_buffer:='"'||trec||separator||'G'||
              boq_temp_tab(j).iboq_sta_item_code||separator||
        lpad(to_char(nvl(boq_temp_tab(j).iboq_quantity,0),'999999.09'),12)||'" ""';
              if not writeln(File_Handle,v_buffer)
                then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
                else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
                   z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
                end if;
          --
          -- Output U record, 1 per T record, made up of item codes
          -- and dimensions. Amalgamated '15' records are marked as
          -- 'Multiple measurements'
          --
          if boq_temp_tab(j).iboq_amalgamated = 'N' then
            v_buffer:='"'||urec||separator||'G'||
              boq_temp_tab(j).iboq_sta_item_code||'-'||
        to_char(boq_temp_tab(j).iboq_dim1)||v_space||
        to_char(boq_temp_tab(j).iboq_dim2)||v_space||
        to_char(boq_temp_tab(j).iboq_dim3)||v_space||'"';
          else
               v_buffer:='"'||urec||separator||'G'||
              boq_temp_tab(j).iboq_sta_item_code||'-Multiple measurements'||'"';
            end if;
        if not writeln(File_Handle,v_buffer)
                then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
                else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
                   z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
                end if;
        --
         end loop;
         --
           -- Output the 'Z' record
           -- The Z record should just have the 'Z' character and no additional fields.
           v_buffer:='"'||zrec||'"';
         --
         if not   writeln(File_Handle,v_buffer)
           then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
           end if;
         --
         z_rec_no  :=0;
         z_rec_chrs:=0;
         --
      end if;
    end loop;
  end loop;
  --
  utl_file.fclose(File_Handle);
  --
  dbms_output.put_line('');
  dbms_output.put_line('');
  dbms_output.put_line('Output File : '||v_filename);
  dbms_output.put_line('Directory   : '||FDest);
  --
  return true;
   exception
    when utl_file.invalid_operation
    then dbms_output.put_line('Error: An invalid operation occured (this can include an invalid filename) - '||fn);
         return false;
    when utl_file.invalid_path
    then dbms_output.put_line('Error: An invalid path error occured - '||fn);
       return false;
    when utl_file.read_error
    then dbms_output.put_line('Error: A read error occured on the specified file - '||fn);
       return false;
    when utl_file.write_error
    then dbms_output.put_line('Error: Cannot write to the specified file - '||fn);
       return false;
    when utl_file.internal_error
    then dbms_output.put_line('Error: An internal error was found - '||fn);
       return false;
    when utl_file.invalid_filehandle
    then dbms_output.put_line('Error: The specified file handle does not identify a valid file - '||fn);
       return false;
    when utl_file.invalid_mode
    then dbms_output.put_line('Error: Invalid mode - '||fn);
       return false;
    when invalid_number
    then dbms_output.put_line('Error: Invalid number exception raised - '||fn);
         return false;
    when value_error
    then dbms_output.put_line('Error: Value error exception raised - '||fn);
         return false;
    when others
    then dbms_output.put_line('Error: An Unknown exception Occured - '||fn);
       if is_open(Output_File)
     then utl_file.fclose(Output_File);
     end if;
     if is_open(File_Handle)
     then utl_file.fclose(File_Handle);
     end if;
     return false;
end;
--
/*=======================================================================
  Invoices
      The following section details the Invoices output file procedure.
    A file will be provided with the following format :
      Contractor Code          A(8)
    Invoice Number           A(20)
    Date Invoice Received    Date
    Week Received            N(2)
    Year Received            N(2)
    Works Order No           A(12)
    DLO Job Number           A(8)
    Variation Source         A(10)
    SOR Code                 A(8)
    Quantity                 N(11,2)
    Invoice Line Value       N(13,2)
    Vat on Invoice Line      N(13,2)
    Housing Budget Head      N(8)
    Processed Indicator Flag A(1)
    Status                   A(3)
    Status Date              Date
   a) Read in the completions file.
   b) Reformat and provide an output file.
   =======================================================================
*/
--
-- This procedure should load the specified file going through each record.
-- For the selected record type the record is inserted into the appropreate
-- type related table. Once all records have ben loaded into pl/sql tables
-- the data can be addressed and reformatted into an output file.
--
Function ProcessInvoiceRecords(job_id in number)
return boolean
is
   --
   type invoice_irec    is record( received      varchar2(8)
                  ,wk_received   varchar2(2)
                  ,yr_received   varchar2(2)
                  ,wor_no        varchar2(16)
                  ,wol_id     number(9)
                  ,dlo           varchar2(8)
                  ,var_source    varchar2(10)
                  ,sor_code      varchar2(8)
                  ,Qty           number(8,2)
                  ,rate       number(10,2)
                  ,Inv_line      number(10,2)
                  ,vat_line      number(10,2)
                  ,housing       number(8)
                  ,process_ind   varchar2(1)
                  ,status        varchar2(3)
                  ,status_date   varchar2(8));
   --
   type invoice_table is table of invoice_irec   index by binary_integer;
   invoice_tab     invoice_table;     -- Table of invoice records ( Input )
   --
   type wor_rec is record( wor_no     varchar2(16)
                 ,claim_type   varchar2(1)
              ,inv_no        varchar2(20)
              ,con_code     varchar2(10)
              ,originator   varchar2(40)
                    ,total_value   number(11,2));
   --
   type wor_table is table of wor_rec  index by binary_integer;
   wor_tab wor_table;
   --
   type wol_rec is record( wol_id     number(9)
                 ,claim_type   varchar2(1)
                    ,wor_no     varchar2(16)
              ,def_id     number(8)
              ,schd_id     number(9)
                          ,total_value   number(11,2)
              ,completed   varchar2(8));
   --
   type wol_table is table of wol_rec  index by binary_integer;
   wol_tab wol_table;
   --
   fn              varchar2(23):='{ProcessInvoiceRecords}';
   total_rows      integer;           -- Total rows counter
   total_wor_rows  integer;        -- Total wor rows counter
   total_wol_rows  integer;        -- Total wol rows counter
   line_counter    integer:=1;        -- A line counter
   invoice_value   number(12,2):=0;    -- Sum of all invoice lines
   --
   hrec            varchar2(2):='00';  -- Output header record type
   crec            varchar2(2):='05';  -- Output claim record type
   wrec            varchar2(2):='10';  -- Output work order line record type
   brec            varchar2(2):='15';  -- Output bill item record type
   zrec            varchar2(2):='20';  -- Output check record type
   --
   hcontractor     varchar2(3);       -- Contractor id
   hline           varchar2(80);      -- H Record output buffer
   cline           varchar2(500);     -- C Record output buffer
   wline           varchar2(500);     -- W Record output buffer
   bline           varchar2(500);     -- B Record output buffer
   zline           varchar2(80);      -- Z Record output buffer
   v_buffer        varchar2(200);      -- character based buffer
   separator       char:=',';         -- Output field separator
   v_dummy       number(1);      -- Dummy variable
   v_found       boolean;         -- Wor located in table
   invoice_file    utl_file.file_type;
   --
   cursor contractor_id(p_wor_no work_orders.wor_works_order_no%type)
   is select oun_contractor_id
      from   org_units
          ,work_orders
      ,contracts
    where  wor_works_order_no = p_wor_no
    and    wor_con_id = con_id
    and    con_contr_org_id = oun_org_id;

   cursor missing_wol_details(p_wol_id work_order_lines.wol_id%type)
   is select wol_works_order_no
           ,wol_def_defect_id
      ,wol_schd_id
    from   work_order_lines
    where  wol_id = p_wol_id;

   cursor existing_claim(p_wol_id work_order_lines.wol_id%type)
   is select 1
      from   claim_payments
    where  cp_wol_id = p_wol_id;

   cursor missing_wor_details(p_wor_no work_orders.wor_works_order_no%type)
   is select substr(p_wor_no||to_char(woc_ref_seq.nextval), 1, 20)
           ,con_code
            ,hus_name
      from   work_orders
          ,contracts
      ,hig_users
    where  con_id = wor_con_id
    and    hus_user_id = wor_peo_person_id
    and    wor_works_order_no = p_wor_no;

   cursor missing_boq_details(p_wol_id boq_items.boq_wol_id%type
                      ,p_item_code boq_items.boq_sta_item_code%type)
   is select nvl(boq_act_rate, boq_est_rate)
      from   boq_items
    where  boq_wol_id = p_wol_id
    and    boq_sta_item_code = p_item_code;
begin
  --
  -- Open the input file for reading.
  --
  invoice_file := utl_file.fopen(FDest,FFile,FRead);
  --
  FSeq:=job_id;
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  --
  if not is_open(invoice_file)
  then dbms_output.put_line('Error: Unable to obtain file '||FDest||'/'||FFile||' for reading');
  end if;
  --
  -- Populate invoice table with input data from file
  --
  while not EndOfFile
  loop
    get_nextline(invoice_file,v_buffer,EndOfFile);
    --
  invoice_tab(line_counter).received:=substr(v_buffer,29,8);
  invoice_tab(line_counter).wk_received:=substr(v_buffer,37,2);
  invoice_tab(line_counter).yr_received:=substr(v_buffer,39,2);
  invoice_tab(line_counter).wol_id:=to_number(nvl(rtrim(ltrim(substr(v_buffer,41,12),' '),' '),'0'));
  invoice_tab(line_counter).dlo:=rtrim(substr(v_buffer,53,8),' ');
  invoice_tab(line_counter).var_source:=rtrim(substr(v_buffer,61,10),' ');
  invoice_tab(line_counter).sor_code:=rtrim(substr(v_buffer,71,8),' ');
    --
  invoice_tab(line_counter).qty:=to_number(nvl(rtrim(ltrim(substr(v_buffer,79,10),' '),' '),'0.00'));
  invoice_tab(line_counter).inv_line:=to_number(nvl(rtrim(ltrim(substr(v_buffer,89,13),' '),' '),'0.00'));
  invoice_tab(line_counter).vat_line:=to_number(nvl(rtrim(ltrim(substr(v_buffer,102,13),' '),' '),'0.00'));
  invoice_tab(line_counter).housing:=to_number(nvl(rtrim(ltrim(substr(v_buffer,115,8),' '),' '),'0'));
  invoice_tab(line_counter).process_ind:=substr(v_buffer,123,1);
  invoice_tab(line_counter).status:=substr(v_buffer,124,3);
  invoice_tab(line_counter).status_date:=substr(v_buffer,127,8);
    --
    line_counter:=line_counter+1;
  end loop;
  utl_file.fclose(invoice_file);
  --
  total_rows:=invoice_tab.count;
  --
  line_counter:=0;
  --
  -- Populate the WOL table from invoice table and the database also
  -- populate the BOQ rate from the database
  --
  for i in 1..total_rows
  loop
  v_found:=false;
    open missing_boq_details(invoice_tab(i).wol_id
                     ,invoice_tab(i).sor_code);
  fetch missing_boq_details into invoice_tab(i).rate;
  close missing_boq_details;
    total_wol_rows:=wol_tab.count;
    for j in 1..total_wol_rows
  loop
    if wol_tab(j).wol_id = invoice_tab(i).wol_id
    then wol_tab(j).total_value := wol_tab(j).total_value + invoice_tab(i).inv_line;
         v_found:=true;
         exit;
    end if;
  end loop;
  if not v_found
  then wol_tab(total_wol_rows+1).wol_id:=invoice_tab(i).wol_id;
        wol_tab(total_wol_rows+1).wor_no:=invoice_tab(i).wor_no;
       wol_tab(total_wol_rows+1).total_value:=invoice_tab(i).inv_line;
     wol_tab(total_wol_rows+1).completed:=invoice_tab(i).received;
     --
         open missing_wol_details(invoice_tab(i).wol_id);
         fetch missing_wol_details into wol_tab(total_wol_rows+1).wor_no
                          ,wol_tab(total_wol_rows+1).def_id
                         ,wol_tab(total_wol_rows+1).schd_id;
       close missing_wol_details;
     --
     open existing_claim(invoice_tab(i).wol_id);
       fetch existing_claim into v_dummy;
     if existing_claim%found
     then wol_tab(total_wol_rows+1).claim_type := 'P';
     else wol_tab(total_wol_rows+1).claim_type := 'F';
       end if;
     close existing_claim;
  end if;
  end loop;
  --
  -- Populate the WOR table from the WOL table and the database
  --
  for i in 1..wol_tab.count
  loop
    v_found:=false;
    total_wor_rows:=wor_tab.count;
  for j in 1..total_wor_rows
  loop
    if wor_tab(j).wor_no = wol_tab(i).wor_no and wor_tab(j).claim_type = wol_tab(i).claim_type
    then wor_tab(j).total_value := wor_tab(j).total_value + wol_tab(i).total_value;
         v_found:=true;
         exit;
    end if;
  end loop;
  if not v_found
  then wor_tab(total_wor_rows+1).wor_no:=wol_tab(i).wor_no;
     wor_tab(total_wor_rows+1).claim_type:=wol_tab(i).claim_type;
       wor_tab(total_wor_rows+1).total_value:=wol_tab(i).total_value;
     --
     open missing_wor_details(wol_tab(i).wor_no);
     fetch missing_wor_details into wor_tab(total_wor_rows+1).inv_no
                            ,wor_tab(total_wor_rows+1).con_code
                            ,wor_tab(total_wor_rows+1).originator;
     close missing_wor_details;
  end if;
  end loop;
  --
  if debug
  then for i in 1..wor_tab.count
       loop
       dbms_output.put_line('Wor No     : '||wor_tab(i).wor_no);
       dbms_output.put_line('Claim type : '||wor_tab(i).claim_type);
       dbms_output.put_line('Inv No     : '||wor_tab(i).inv_no);
        dbms_output.put_line('Con Code   : '||wor_tab(i).con_code);
        dbms_output.put_line('Originator : '||wor_tab(i).originator);
     dbms_output.put_line('Wor Total  : '||to_char(wor_tab(i).total_value));
     for j in 1..wol_tab.count
     loop
           if wor_tab(i).wor_no = wol_tab(j).wor_no and wor_tab(i).claim_type = wol_tab(j).claim_type
       then dbms_output.put_line('Wol Id    : '||to_char(wol_tab(j).wol_id));
            dbms_output.put_line('Def Id    : '||to_char(wol_tab(j).def_id));
            dbms_output.put_line('Schd Id   : '||to_char(wol_tab(j).schd_id));
            dbms_output.put_line('Wol Total : '||to_char(wol_tab(j).total_value));
            dbms_output.put_line('Completed : '||wol_tab(j).completed);
        for k in 1..invoice_tab.count
        loop
          if wol_tab(j).wol_id = invoice_tab(k).wol_id
          then dbms_output.put_line('Item code: '||invoice_tab(k).sor_code);
                      dbms_output.put_line('Qty      : '||to_char(invoice_tab(k).qty));
                      dbms_output.put_line('Rate     : '||to_char(invoice_tab(k).rate));
                      dbms_output.put_line('Inv Line : '||to_char(invoice_tab(k).inv_line));
          end if;
        end loop;
       end if;
     end loop;
     end loop;
  end if;
  --
  -- Start outputing info here:
  --
  hcontractor := 'UKN'; -- contractor is unknown at this point and
        -- remains so if one is not found
  for i in 1..wor_tab.count loop
    if wor_tab(i).wor_no is not null then  -- loop until a work order record with
               -- a wor no is reached (incase first records
               -- are for cancelled wors)
      open contractor_id(wor_tab(i).wor_no);
      fetch contractor_id into hcontractor;
      if contractor_id%found then
        close contractor_id;
        exit;
      end if;
      close contractor_id;
    end if;
  end loop;
  --
  v_filename:='WI'||to_char(FSeq)||'.'||hcontractor;
  --
  if not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
  else if debug
       then dbms_output.put_line('Info: The file '||FDest||v_filename||' exists - {ProcessInvoiceRecords}');
     end if;
       if is_open(File_Handle)
     then if debug
          then dbms_output.put_line('Info: The file exists and is open - {ProcessInvoiceRecords}');
      end if;
     end if;
  end if;
  --
  hline:=hrec||separator||hcontractor||separator||to_char(FSeq)||separator||
        to_char(sysdate,'DDMMYYYY')||separator||
      to_char(sysdate,'HH:MM:SS');
  if not writeln(File_Handle,hline)
  then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
  end if;
  --
  for i in 1..wor_tab.count-1
  loop
  cline:=crec                             ||separator||
           wor_tab(i).claim_type                   ||separator||
                                                 separator||
       wor_tab(i).inv_no                       ||separator||
       to_char(trunc(sysdate),'DDMMYYYY')     ||separator||
           wor_tab(i).wor_no                       ||separator||
           wor_tab(i).con_code                     ||separator||
           wor_tab(i).originator                   ||separator||
                                                 separator||
                                                 separator||
           to_char(wor_tab(i).total_value)         ||separator||
                                                 separator;
    --
    if not writeln(File_Handle,cline)
    then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
    else line_counter:=line_counter+1;
     invoice_value:=invoice_value+wor_tab(i).total_value;
    end if;
  --
  for j in 1..wol_tab.count
  loop
    if wor_tab(i).wor_no = wol_tab(j).wor_no and wor_tab(i).claim_type = wol_tab(j).claim_type
    then wline:=wrec||separator||
           to_char(wol_tab(j).wol_id)         ||separator||
       to_char(wol_tab(j).def_id)            ||separator||
       to_char(wol_tab(j).schd_id)          ||separator||
       to_char(wol_tab(j).total_value)        ||separator||
                                    separator||
                                 separator||
           wol_tab(j).completed;
        --
           if not writeln(File_Handle,wline)
           then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
         else line_counter:=line_counter+1;
         end if;
           --
           for k in 1..invoice_tab.count
         loop
         if wol_tab(j).wol_id = invoice_tab(k).wol_id
       then bline:=brec                 ||separator||
            invoice_tab(k).sor_code       ||separator||
          to_char(invoice_tab(k).qty)     ||separator||
                                separator||
                                separator||
          to_char(invoice_tab(k).qty)       ||separator||
          to_char(invoice_tab(k).rate)     ||separator||
            to_char(invoice_tab(k).inv_line)   ||separator||
                               separator;
          --
              if not writeln(File_Handle,bline)
              then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
          else line_counter:=line_counter+1;
              end if;
              --
       end if;
         end loop;
    end if;
  end loop;
  end loop;
  --
  zline:=zrec||separator||to_char(line_counter)||separator||to_char(invoice_value);
  if not writeln(File_Handle,zline)
  then dbms_output.put_line('Error: Unable to write output to designated file - '||fn);
  end if;
  utl_file.fclose(File_Handle);
  --
  dbms_output.put_line('');
  dbms_output.put_line('');
  dbms_output.put_line('Output File : '||v_filename);
  dbms_output.put_line('Directory   : '||FDest);
  --
  return true;
  exception
    when utl_file.invalid_operation
    then dbms_output.put_line('Error: An invalid operation occured (this can include an invalid filename) - '||fn);
         return false;
    when utl_file.invalid_path
    then dbms_output.put_line('Error: An invalid path error occured - '||fn);
       return false;
    when utl_file.read_error
    then dbms_output.put_line('Error: A read error occured on the specified file - '||fn);
       return false;
    when utl_file.write_error
    then dbms_output.put_line('Error: Cannot write to the specified file - '||fn);
       return false;
    when utl_file.internal_error
    then dbms_output.put_line('Error: An internal error was found - '||fn);
       return false;
    when utl_file.invalid_filehandle
    then dbms_output.put_line('Error: The specified file handle does not identify a valid file - '||fn);
       return false;
    when utl_file.invalid_mode
    then dbms_output.put_line('Error: Invalid mode - '||fn);
       return false;
    when invalid_number
    then dbms_output.put_line('Error: Invalid number exception raised - '||fn);
         return false;
    when value_error
    then dbms_output.put_line('Error: Value error exception raised - '||fn);
         return false;
    when others
    then dbms_output.put_line('Error: An Unknown exception Occured - '||fn);
  -- check for open files here first
       if   is_open(Invoice_file)
     then utl_file.fclose(Invoice_file);
     end if;
     if   is_open(File_Handle)
     then utl_file.fclose(File_Handle);
     end if;
     return false;
end;
--
-- This is where the real processing starts
--
Procedure Main( job_id in number)
is
  start_time   binary_integer;
  end_time     binary_integer;
  tot_time     binary_integer;
  sections_tab sections_tabtype;
  Load_Table   exor_load_table;
Begin
  --
  dbms_output.enable(1000000);
  --
  if debug
  then start_time:=dbms_utility.get_time;
       dbms_output.put_line('Start Time : '||to_char(start_time));
       dbms_output.put_line('Info: Output enabled');
  end if;
  --
  get_params( job_id );
  --
  if    FType='C'
  then  if not ProcessComplRecords(job_id)
        then dbms_output.put_line('Error: Process Completion Records failed - {Main}');
  end if;
  elsif FType='I'
  then  if not ProcessInvoiceRecords(job_id)
        then dbms_output.put_line('Error: Process Invoice Records failed - {Main}');
  end if;
  elsif FType='S'
  then  if Not CheckParameters(FType)
        then dbms_output.put_line('Error: Insufficient parameters for section selection - {Main}');
    elsif not ProcessSectRecords(job_id)
        then dbms_output.put_line('Error: Process Section Records failed - {Main}');
  end if;
  elsif FType='W'
  then  if not ProcessWorkRecords(job_id)
        then dbms_output.put_line('Error: Process Work Order Records failed - {Main}');
        end if;
  else  dbms_output.put_line('Error: Unknown file type from GRI parameters - {Main}');
  end if;
end Main;
END Blackburn;
/
