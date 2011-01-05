CREATE OR REPLACE PACKAGE BODY P$Interface AS
-----------------------------------------------------------------------------
--
--   PVCS Identifiers :-
--
--       sccsid           : $Header:   //vm_latest/archives/mai/admin/pck/pinterface.pkb-arc   2.1   Jan 05 2011 09:34:52   Chris.Baugh  $
--       Module Name      : $Workfile:   pinterface.pkb  $
--       Date into SCCS   : $Date:   Jan 05 2011 09:34:52  $
--       Date fetched Out : $Modtime:   Jan 05 2011 09:34:18  $
--       SCCS Version     : $Revision:   2.1  $
--       Based onSCCS Version     : 1.1
--
-----------------------------------------------------------------------------
--   Originally taken from '@(#)pinterface.pck	1.3 05/18/99'
-----------------------------------------------------------------------------
--	Copyright (c) exor corporation ltd, 2002
-----------------------------------------------------------------------------
  --
  debug          boolean:=TRUE;
  --
  Type sections_tabtype is table of varchar2(150) index by binary_integer;
  Type exor_load_table  is table of varchar2(150) index by binary_integer;

  --
  File_Handle    utl_file.file_type;        -- File handle
  Input_File     utl_file.file_type;        -- File Handle
  Section_Unique road_segs.rse_unique%type; -- Section identifier
  Section_Descr  road_segs.rse_descr%type;  -- Section description
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
  DemoLine varchar2(80):='-- Highways By EXOR ¿1999';
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
Procedure Get_Params(job_id in number)
is
begin
  --
  FSeq := higgrirp.get_parameter_value(job_id,'A_NUMBER');
  FDest:= upper(higgrirp.get_parameter_value(job_id,'TEXT'));
  FType:= upper(higgrirp.get_parameter_value(job_id,'FILETYPE'));
  FFile:= upper(higgrirp.get_parameter_value(job_id,'FILENAME'));
  --
  if debug then
  dbms_output.put_line('');
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
Function CheckParameters(FType in varchar2 )
return boolean is
begin
    if  (FSeq is null and FFile is null )
	or  FDest is null
	or  FType is null
	then return false;
	elsif  FType != 'S'
	   and FFile is null
	   then return false;
	else return true;
	end if;
end;
--
-- Obtain the next file sequence if one has not been provided
--
Function GetFileSeq
return integer
is
   v_seq number;
   --
   cursor NextFileSeq
   is select file_id_seq.nextval
      from dual;
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
Function GetFields( InString in varchar2 )
return number
is
  i integer:=1;
  f integer:=0;
begin
  --
  for i in 1..length(InString)
  loop
    if substr(InString,i,1)=','
    then f:=f+1;
    end if;
  end loop;
  f:=f+1;
  return f;
end;
--
-- This function should return the specified field from the incoming string buffer.
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
Function FileExists( loc_in   in varchar2
                    ,file_in  in varchar2 )
return boolean
is
begin
  -- Open the file
  if debug then
  dbms_output.put_line('Path   : '||loc_in);
  dbms_output.put_line('File   : '||file_in);
  dbms_output.put_line('Action : '||FWrite);
  end if;
  --
  if not is_open(file_handle)
  then file_handle:=utl_file.fopen(loc_in,file_in,FWrite);
  end if;
  --
  if debug then
  dbms_output.put_line('Info: Handle Obtained - {FileExists}');
  end if;
  --
  -- Return the result of a check with IS_OPEN
  -- utl_file.fclose(file_handle);
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
Function Writeln(File_Handle in utl_file.File_Type, line_in in varchar2 )
return boolean
is
  j integer;
begin
  --
  dbms_output.put_line('Info: '||line_in);
  --
  utl_file.put_line(File_Handle,line_in);
  -- utl_file.fflush(File_Handle);
  return true;
  exception
    when others
	then return false;
end;
--
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
Function ProcessComplRecords
return boolean
is
   --
   -- FileNotFound exception;
   -- Pragma exception_init ( FileNotFound,    );<Here>
   --
   type compl_rectype is record(   dlo_job_no     varchar2(8)
                                  ,order_no       varchar2(12)
								  ,job_status     varchar2(8)
								  ,act_compl_date varchar2(6));
   --
   type compl_table   is table of compl_rectype index by binary_integer;
   --
   h_contractor    varchar2(3);       -- Contractor Code
   h_sequence      varchar2(8);       -- File sequence number
   completion_tab  compl_table;       -- Table of completion records
   total_rows      integer;           -- Total rows counter
   counter_rows    integer:=1;        -- Row counter value
   located         boolean:=false;    -- Location indicator
   hrec            varchar2(2):='00'; -- Header     Record type
   crec            varchar2(2):='10'; -- Completion Record type
   zrec            varchar2(2):='15'; -- Check      Record type
   z_rec_no        integer:=1;        -- Count the number of records
   z_rec_chrs      integer:=0;        -- Count the number of characters
   hline           varchar2(80);      -- H Record output buffer
   cline           varchar2(500);     -- C Record output buffer
   zline           varchar2(80);      -- Z Record output buffer
   zrec_count      number:=1;         -- Number of 'C' records
   v_buffer        varchar2(255);    -- character based buffer
   v_date          varchar2(8);       -- Date variable
   v_time          varchar2(8);       -- Time variable
   i_index         integer:=1;        -- Record index counter
   --
   -- Define the output file and open the file for writing
   --
   --
begin
  --
  -- Open the input file for reading.
  --
  if debug then
  dbms_output.put_line('Dest : '||FDest);
  dbms_output.put_line('File : '||FFile);
  dbms_output.put_line('Read : '||FRead);
  end if;
  --
  --
  -- Obtain the specified file name and location
  --
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  --
  v_filename:='COMP'||lpad(to_char(FSeq),5,'0')||'.lis';
  --
  if  not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
  else dbms_output.put_line('Info: The file '||FDest||'\'||v_filename||' exists - {ProcessCompRecords}');
       if is_open(File_Handle)
	   then dbms_output.put_line('Info: The file exists and is open - {ProcessCompRecords}');
	   end if;
  end if;
  --
  -- Open the input file for reading.
  --
  if is_open(file_handle)
  then if not close_file(file_handle)
       then dbms_output.put_line('Error: Unable to close file - {ProcessCompRecords}');
	   else dbms_output.put_line('Info: Closed file - {ProcessCompRecords}');
	   end if;
  end if;
  --
  file_handle:=utl_file.fopen(FDest,FFile,FRead);
  if not is_open(file_handle)
  then dbms_output.put_line('Error: Unable to open file for reading - {ProcessWorkRecords}');
  else if debug then
       dbms_output.put_line('Info : File open for reading.');
	   end if;
  end if;
  --
  -- Obtain the specified file name and location
  --
  while not EndOfFile
  loop
    get_nextline(File_Handle,v_buffer,EndOfFile);
	--
    -- Once the record has been placed into the buffer we should ensure
	-- that the number of fields in the record is correct.
	--
    if  v_buffer is not null then
	if GetFields(v_buffer)!=4
	then dbms_output.put_line('Error: Expected 4 fields and received '||to_char(GetFields(v_buffer))||
	           ' in record '||to_char(i_index));
    else
         --
	     completion_tab(i_index).dlo_job_no    :=GetField(v_buffer,1);
	     completion_tab(i_index).order_no      :=GetField(v_buffer,2);
	     completion_tab(i_index).job_status    :=GetField(v_buffer,3);
	     completion_tab(i_index).act_compl_date:=GetField(v_buffer,4);
		 --
		 if debug then
		 dbms_output.put_line('DLO   : '||completion_tab(i_index).dlo_job_no);
		 dbms_output.put_line('Order : '||completion_tab(i_index).order_no);
		 dbms_output.put_line('Status: '||completion_tab(i_index).job_status);
		 dbms_output.put_line('Compl : '||completion_tab(i_index).act_compl_date);
		 end if;
		 --
         i_index:=i_index+1;
		 --
	 end if;
	 end if;
  end loop;
  --
  utl_file.fclose(File_Handle); -- Close the input file
  --
  -- Obtain the specified Output file name.
  --
  i_index:=1;
  --
  -- From  the module specification, the contractor id and the
  -- sequence number should be extrtacted from the filename.
  --
  -- Once the file has been obtained the header record can be constructed.
  -- The header record has the following fields :
  -- '00'              - Type
  -- Contractor Id     - Obtained from the filename
  -- Sequence Number   - Obtained from the filename
  -- Date File Created - Obtained from sysdate
  -- Time File Created - Obtained from sysdate
  --
  h_contractor:=substr(FFile,1,3);
  h_sequence  :=substr(FFile,4,(instr(FFile,'.')-4));
  hline:=hrec                          ||separator||
	     h_contractor                  ||separator||
		 lpad(h_sequence,6)            ||separator||
		 to_char(sysdate,'DDMMYYYY')   ||separator||
		 to_char(sysdate,'HH:MM:SS');
  --
  if Is_Open(File_Handle)
  then if not Close_File(File_Handle)
       then dbms_output.put_line('Error: Unable to close output file handle - {ProcessWorkRecords}');
	   end if;
  end if;
  --
  File_Handle:=utl_file.fopen(FDest,v_filename,FWrite);
  if   not Is_Open(File_Handle)
  then dbms_output.put_line('Error: Unable to open output file for writing - {ProcessWorkRecords}');
  end if;
  --
  if not   writeln(File_Handle,hline)
  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
  else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
	   z_rec_chrs:=z_rec_chrs+length(hline); -- Count the number of characters
  end if;
  --
  for i in 1..completion_tab.count
  loop
    --
    -- For each selected record in the complletion pl/sql table produce an
	-- output record.
	-- Here the Defect Id,Schedule Id and completion time are NULL.
	--
    v_buffer   :=crec||separator||
    	      completion_tab(i).order_no||separator||       -- Order No
			  '        '                      ||separator||       -- Defect Id
	          '         '                     ||separator||       -- Schedule Id
			  completion_tab(i).act_compl_date||separator|| -- Comppletion Date
			  '        '                      ||separator||       -- Completion time
			  completion_tab(i).dlo_job_no;
	--
	if debug then
	dbms_output.put_line(v_buffer);
	end if;
    --
	utl_file.put_line(File_Handle,v_buffer);
	z_rec_no:=z_rec_no+1;
    z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
	--
  end loop;
  --
  zline:='Z'||separator||lpad(to_char(z_rec_no),7)||separator||lpad(to_char(z_rec_chrs),7);
  utl_file.put_line(File_Handle,zline);
  utl_file.fclose(File_Handle);
  --
  return true;
  exception
    when utl_file.invalid_operation
    then dbms_output.put_line('Error: An invalid operation occured - {ProcessComplRecords}');
         return false;
    when utl_file.invalid_path
    then dbms_output.put_line('Error: An invalid path error occured - {ProcessComplRecords}');
	     return false;
    when utl_file.read_error
    then dbms_output.put_line('Error: A read error occured on the specified file - {ProcessComplRecords}');
	     return false;
    when utl_file.write_error
    then dbms_output.put_line('Error: Cannot write to the specified file - {ProcessComplRecords}');
	     return false;
    when utl_file.internal_error
    then dbms_output.put_line('Error: An internal error was found - {ProcessComplRecords}');
	     return false;
    when utl_file.invalid_filehandle
    then dbms_output.put_line('Error: The specified file handle does not identify a valid file -
{ProcessComplRecords}');
	     return false;
    when utl_file.invalid_mode
    then dbms_output.put_line('Error: Invalid mode - {ProcessComplRecords}');
	     return false;
    when invalid_number
    then dbms_output.put_line('Error: Invalid number exception raised - {ProcessComplRecords}');
         return false;
    when value_error
    then dbms_output.put_line('Error: Value error exception raised - {ProcessComplRecords}');
         return false;
    when others
    then dbms_output.put_line('Error: An Unknown exception Occured - {ProcessComplRecords}');
    -- check for open files here first
         if   is_open(Input_File)
	     then utl_file.fclose(Input_File);
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
Function ProcessSectRecords
return boolean
is	 --
     cursor All_Sections
	 is select rse_linkcode||'/'||substr(rtrim(rse_sect_no),3,2) section
	          ,rse_descr description
	    from   road_segs
		where rse_type='S';
	--
	v_line     varchar2(120);
	v_buffer   varchar2(500);
	--
begin
   --
   --
  -- Obtain the specified file name and location
  --
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  v_filename:='RSE'||lpad(to_char(FSeq),5,'0')||'.lis';
  --
  if  not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
  else dbms_output.put_line('Info: The file '||FDest||v_filename||' exists - {ProcessComplRecords}');
       if is_open(File_Handle)
	   then dbms_output.put_line('Info: The file exists and is open - {ProcessComnplRecords}');
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
	  dbms_output.put_line(v_line);
	  utl_file.put_line(File_Handle,v_line);
	  utl_file.fflush(File_Handle);
   end loop;
   if not close_file(File_Handle)
   then dbms_output.put_line('Error: The section details file could not be closed - {ProcessSectRecords}');
   end if;
  return true;
  exception
    when utl_file.invalid_operation
	then dbms_output.put_line('Error: Cannot write section details to a readonly file -
{ProcessSectRecords}');
	     return false;
	when utl_file.write_error
	then dbms_output.put_line('Error: Unable to write section details to the file - {ProcessSectRecords}');
	     return false;
	when others
	then dbms_output.put_line('Error: Unidentified exception - {ProcessSectRecords}');
	     return false;
end;
--
-- Get the next line of the specified file.
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
  if debug then
  dbms_output.put_line('There are '||to_char(total_rows)||' rows.');
  end if;
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
  if debug then
  dbms_output.put_line('There are '||to_char(total_rows)||' rows.');
  end if;
  for i in 1..total_rows
  loop
    dbms_output.put_line(table_in(i));
  end loop;
end;
--
-- Load an Exor filetype
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
  if debug then
  dbms_output.put_line('There are '||to_char(total_rows)||' rows.');
  end if;
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
  if debug then
  for i in 1..counter_rows
  loop
    dbms_output.put_line(counter_tab(i).rec_type||' : '||to_char(counter_tab(i).num_of));
  end loop;
  end if;
end;
--
/*=======================================================================
  Work_Orders
      The following section details the Work Orders output file procedure.
	  A file will be provided with the following format :

	  DLO Job Number          A(8)  DLO = Direct Labour Orgaisation
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
--   00 - Header Record
--   05 - Work Order Record
--   06 - Work Order description record
--   10 - Work Order Line Record
--   15 - BOQ Record
--   20 - Footer Record
--
Function ProcessWorkRecords
return boolean
is
   --
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
   total_rows      integer;           -- Total rows counter
   counter_rows    integer:=1;        -- Row counter value
   located         boolean:=false;    -- Location indicator
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
   separator       char:=',';         -- Output field separator
   v_space         char:=' ';         -- Space field separator.
   v_wol_id        work_order_lines.wol_id%type;
   v_work_order_no work_orders.wor_works_order_no%type;
   v_defect_id     defects.def_defect_id%type;
   v_schd_id       schedules.schd_id%type;
   v_date          varchar2(8);       -- Date variable
   v_time          varchar2(8);       -- Time variable
   rectype         varchar2(2);       -- Record Type
   TotWorkOrderRecs integer;          -- Total work order records
   s               integer;
   i               integer;
   j               integer;
   k               integer;
   fld             varchar2(255);
   rec_type        varchar2(2);       -- Record type
   total_value     number(11,2);      -- Sum total BOQ cost value.
   last_total_value number(11,2);      -- Sum total BOQ cost value.
   last_boq_item   standard_items.sta_item_code%type:=null;
   rec             integer:=0;
   --
   -- Define the three record types.
   --
   type wor_rec is record (  IWOR_TRANSACTION_TYPE      VARCHAR2(1)
                         , IWOR_WORKS_ORDER_NO          VARCHAR2(16)
						 , IWOR_SCHEME_TYPE             VARCHAR2(2)
						 , IWOR_CON_CODE                VARCHAR2(10)
						 , IWOR_ORIGINATOR              VARCHAR2(40)
	                     , IWOR_DATE_CONFIRMED          DATE
                         , IWOR_EST_COMPLETE            DATE
						 , IWOR_COST                    NUMBER(11,2)
						 , IWOR_EST_LABOUR              NUMBER(11,2)
						 , IWOR_INTERIM_PAYMENT_FLAG    VARCHAR2(1)
                         , IWOR_RISK_ASSESSMENT_FLAG    VARCHAR2(1)
                         , IWOR_METHOD_STATEMENT_FLAG   VARCHAR2(1)
                         , IWOR_WORKS_PROGRAMME_FLAG    VARCHAR2(1)
                         , IWOR_ADDITIONAL_SAFETY_FLAG  VARCHAR2(1)
						 , IWOR_COMMENCE_BY             DATE
                         , IWOR_FYR_ID                  VARCHAR2(5));
   --
   type wor_descr_rec is record ( wor_descr varchar2(80));
   --
   type wol_rec is record (   IWOL_ID                   NUMBER(9)
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
							 ,IWOL_DEF_X_SECT           VARCHAR2(1)
                             ,IWOL_PERCENT_ADJUST       NUMBER(4,2)
                             ,IWOL_PERCENT_ADJUST_CODE  NUMBER(2)
							 ,iwol_wor                  number(4));
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
                             ,IBOQ_PERCENT_ADJUST_CODE  NUMBER(2));
   --
   type wor_table       is table of wor_rec index by       binary_integer;
   type wor_descr_table is table of wor_descr_rec index by binary_integer;
   type wol_table       is table of wol_rec index by       binary_integer;
   type boq_table       is table of boq_rec index by       binary_integer;
   --
   -- Define the input pl/sql tables
   --
   wor_tab wor_table;             -- Define the actual table wor_tab
   wol_tab wol_table;             -- Define the actual table wol_tab
   wor_descr_tab wor_descr_table; -- Define the work order description table
   boq_tab boq_table;             -- Define the actual table boq_tab
   boq_temp_tab boq_table;        -- Temporary BOQ table
   boq_temp_tab_empty boq_table;  -- Temporary BOQ tbale used for truncating a pl/sql table
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
   -- Open the specified output file for writing.
   --
   output_file utl_file.file_type;
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
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  --
  v_filename:='WOR'||lpad(to_char(FSeq),5,'0')||'.lis';
  --
  if  not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
  else dbms_output.put_line('Info: The file '||FDest||'\'||v_filename||' exists - {ProcessWorkRecords}');
       if is_open(Output_File)
	   then dbms_output.put_line('Info: The file exists and is open - {ProcessWorkRecords}');
	   end if;
  end if;
  --
  -- Open the input file for reading.
  --
  if is_open(file_handle)
  then if not close_file(file_handle)
       then dbms_output.put_line('Error: Unable to close file - {ProcessWorksRecords}');
	   else dbms_output.put_line('Info: Closed file - {ProcessWorksRecords}');
	   end if;
  end if;
  --
  file_handle:=utl_file.fopen(FDest,FFile,FRead);
  if not is_open(file_handle)
  then dbms_output.put_line('Error: Unable to open file for reading - {ProcessWorkRecords}');
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
	     then dbms_output.put_line('Error: 00 - '||to_char(GetFields(v_buffer))||'/5 fields expected -
{ProcessWorkRecords}');
         else -- Fields that make up the header record are : Type,   ,  , Date,Time
		   h_rec_type:=GetField(v_buffer,1); -- Obtain the 1st field
		   h_rec_dso :=GetField(v_buffer,2); -- Obtain the 2nd field
           h_rec_seq :=GetField(v_buffer,3); -- Obtain the 3rd field
           h_rec_date:=GetField(v_buffer,4); -- Obtain the 4th field
           h_rec_time:=GetField(v_buffer,5); -- Obtain the 5th field
		   --
		   if debug then
           dbms_output.put_line('Type : '||h_rec_type);
      	   dbms_output.put_line('Dso  : '||h_rec_dso);
   	       dbms_output.put_line('Seq  : '||h_rec_seq);
 	       dbms_output.put_line('Date : '||h_rec_date);
  	       dbms_output.put_line('Time : '||h_rec_time);
		   end if;
		   --
		 end if;
	     c_00:=c_00+1;
	elsif rectype='05' -- Work Order details
	then c_05:=c_05+1;
	     if GetFields(v_buffer)!=17
		 then dbms_output.put_line('Error: 05 - '||to_char(GetFields(v_buffer))||'/16 fields expected -
{ProcessWorkRecords}');
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
			  if debug then
			  dbms_output.put_line('Type       : '||rectype);
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
	elsif rectype='06' -- Work Order Description record
	then  if GetFields(v_buffer)!=2
	      then dbms_output.put_line('Error: 06 - '||to_char(GetFields(v_buffer))||'/2 fields expected -
{ProcessWorkRecords}');
          else -- Fields that make up the work order title record are Type and Description
	      --
          wor_descr_tab(wor_d_index).wor_descr:=GetField(v_buffer,2);
		  --
		  dbms_output.put_line('Type  : 06');
		  dbms_output.put_line('Descr : '||wor_descr_tab(wor_d_index).wor_descr);
		  --
		  c_06:=c_06+1;
		  wor_d_index:=wor_d_index+1;
		  end if;
	elsif rectype='10' -- Work Order Line details
	then  if GetFields(v_buffer)!=15
	      then dbms_output.put_line('Error: 10 - '||to_char(GetFields(v_buffer))||'/15 fields expected -
{ProcessWorkRecords}');
          else wol_tab(wol_index).IWOL_ID               :=to_number(GetField(v_buffer,2));
               wol_tab(wol_index).IWOL_DEF_DEFECT_ID    :=to_number(GetField(v_buffer,3));
	           wol_tab(wol_index).IWOL_SCHD_ID          :=to_number(GetField(v_buffer,4));
			   wol_tab(wol_index).IWOL_ROAD_ID          :=GetField(v_buffer,5);
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
	           --
			   if debug then
			   dbms_output.put_line('Wol Id   : '||to_char(wol_tab(wol_index).IWOL_ID));
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
			   end if;
			   --
			   wol_tab(wol_index).iwol_wor:=wor_index-1;
			   wol_index:=wol_index+1;
			   --
			   c_10:=c_10+1;
			   --
			   end if;
	elsif rectype='15'
	then  if GetFields(v_buffer)!=11
	      then dbms_output.put_line('Error: 15 - '||to_char(GetFields(v_buffer))||'/11 fields expected -
{ProcessWorkRecords}');
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
			 if debug then
			 dbms_output.put_line('Wol      : '||to_char(boq_tab(boq_index).IBOQ_WOL_ID));
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
        end if;
	elsif rectype='20' -- Footer record
	then if GetFields(v_buffer)!=3
	     then dbms_output.put_line('Error: 20 - '||to_char(GetFields(v_buffer))||'/3 fields expected -
{ProcessWorkRecords}');
         else z_rec_type:=GetField(v_buffer,1); -- Obtain the 1st field
		      z_rec_no  :=GetField(v_buffer,2); -- Obtain the 2nd field
		      z_rec_chrs:=GetField(v_buffer,3); -- Obtain the 3rd field
		      --
			  if debug then
		      dbms_output.put_line('Type : '||z_rec_type);
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
  --
  if debug then
  dbms_output.put_line('00 : '||to_char(c_00));
  dbms_output.put_line('05 : '||to_char(c_05));
  dbms_output.put_line('06 : '||to_char(c_06));
  dbms_output.put_line('10 : '||to_char(c_10));
  dbms_output.put_line('15 : '||to_char(c_15));
  dbms_output.put_line('20 : '||to_char(c_20));
  dbms_output.put_line('U  : '||to_char(c_u));
  dbms_output.put_line('Tot: '||to_char(wol_index+wor_index+2));
  end if;
  -- utl_file.fclose(file_Handle);
  --
  -- At this point we should have the respective records from the text file
  -- in pl/sql tables.
  -- We should be able to flick through the records to ensure that they exist
  -- as we expect.
  --
  if debug then
  dbms_output.put_line('There are : '||to_char(wor_tab.count)||' work order records');
  for i in 1..wor_tab.count
  loop
    dbms_output.put_line('Work Order Number : '||wor_tab(i).iwor_works_order_no);
  end loop;
  --
  for i in 1..wor_descr_tab.count
  loop
    dbms_output.put_line('Descr : '||wor_descr_tab(i).wor_descr);
  end loop;
  --
  for i in 1..wol_tab.count
  loop
    dbms_output.put_line('Wol        : '||wol_tab(i).IWOL_ROAD_ID||' - '||to_char(wol_tab(i).IWOL_id));
    dbms_output.put_line('Work Order : '||to_char(wol_tab(i).iwol_wor));
  end loop;
  --
  dbms_output.put_line(boq_tab.count);
  for i in 1..boq_tab.count
  loop
    dbms_output.put_line('Boq : '||to_char(boq_tab(i).IBOQ_WOL_ID)||' - '||boq_tab(i).IBOQ_STA_ITEM_CODE||' - '||
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
       then dbms_output.put_line('Error: Unable to close handle on file - {ProcessWorkRecords}');
	   end if;
  end if;
  --
  if Is_Open(Output_File)
  then if not Close_File(output_File)
       then dbms_output.put_line('Error: Unable to close output file handle - {ProcessWorkRecords}');
	   end if;
  end if;
  --
  Output_File:=utl_file.fopen(FDest,v_filename,FWrite);
  if   not Is_Open(Output_File)
  then dbms_output.put_line('Error: Unable to open output file for writing - {ProcessWorkRecords}');
  end if;
  --
  z_rec_no:=0; -- Initialize the record counter
  --
  TotWorkOrderRecs:=wol_tab.count;
  for i in 1..TotWorkOrderRecs -- Number of work orders
  loop
        v_buffer:=arec                                       ||separator||
	           lpad(to_char(wol_tab(i).iwol_id),12)          ||separator||
			   lpad(substr(wor_tab(wol_tab(i).iwol_wor).iwor_con_code,1,2),2)  ||separator||
			   'HWAYS'                                       ||separator||
			   lpad(wor_tab(wol_tab(i).iwol_wor).iwor_works_order_no,16)       ||v_space  ||
			   lpad(to_char(wol_tab(i).iwol_def_defect_id),8)||v_space  ||
			   lpad(wol_tab(i).iwol_def_defect_code,4)       ||v_space  ||
			   lpad(wol_tab(i).iwol_def_priority,4);
	  --
	  -- Output the 'A' type record
	  --
      if not   writeln(Output_file,v_buffer)
	  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
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
	  v_buffer:=brec                                       ||separator||
		        wol_tab(i).IWOL_DEF_PRIORITY               ||separator||
				lpad(to_char(total_value),15);
	  --
      -- Output the 'B' type record
	  --
      if not   writeln(Output_file,v_buffer)
	  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
	  else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
	       z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
	  end if;
	  --
	  v_buffer:=drec                             ||separator||
	            wol_tab(i).IWOL_ROAD_ID          ||separator||
				'no'                             ||separator||
			    wor_tab(wol_tab(i).iwol_wor).IWOR_ORIGINATOR;
	  --
	  -- Output the 'D' type record
	  --
	  if not   writeln(Output_file,v_buffer)
	  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
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
		     v_buffer:=lrec||separator||lpad(substr(wol_tab(i).IWOL_ROAD_DESCR,j,30),30);
		     if not writeln(Output_file,v_buffer)
	         then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
 			 else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
	              z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
	         end if;
		     j:=j+30;
	       end loop;
	  end if;
	  --
	  -- Deal with the defect description
	  --
	  if wol_tab(i).IWOL_DEF_LOCN_DESCR is not null
	  then j:=1;
	       loop
	         exit when j>=length(wol_tab(i).IWOL_DEF_LOCN_DESCR);
		     v_buffer:=lrec||separator||lpad(substr(wol_tab(i).IWOL_DEF_LOCN_DESCR,j,30),30);
		     if not   writeln(Output_file,v_buffer)
	         then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
             else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
	              z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
	         end if;
		     j:=j+30;
	       end loop;
	  end if;
	  --
	  -- Deal with the defect description
	  --
	  if wol_tab(i).IWOL_DEF_DEFECT_DESCR is not null
	  then j:=1;
	       loop
	         exit when j>=length(wol_tab(i).IWOL_DEF_DEFECT_DESCR);
	    	 v_buffer:=lrec||separator||lpad(substr(wol_tab(i).IWOL_DEF_DEFECT_DESCR,j,30),30);
		     if not   writeln(Output_file,v_buffer)
	         then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
             else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
	              z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
	         end if;
		     j:=j+30;
	       end loop;
	  end if;
	  --
	  -- Deal with the Special Instructions
	  --
	  if wol_tab(i).IWOL_DEF_SPECIAL_INSTR is not null
	  then j:=1;
	       loop
	         exit when j>=length(wol_tab(i).IWOL_DEF_SPECIAL_INSTR);
		     v_buffer:=lrec||separator||lpad(substr(wol_tab(i).IWOL_DEF_SPECIAL_INSTR,j,30),30);
		     if not   writeln(Output_file,v_buffer)
	         then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
             else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
	              z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
	         end if;
		     j:=j+30;
	       end loop;
	  end if;
	  --
	  -- Output the 'T' type records ( one per type '15' record - BOQ )
	  -- Here the pre-processing will need to amalgamate together any duplicated
	  -- bill items as duplicates are not allowed within the receiving system.
	  --
	  total_value:=0;
	  rec:=1;
	  boq_temp_tab:=boq_temp_tab_empty;
	  for j in 1..boq_tab.count -- For all the BOQ item records
	  loop if boq_tab(j).iboq_wol_id=wol_tab(i).iwol_id
	       then  if   boq_temp_tab.count=0
			     then boq_temp_tab(rec).iboq_sta_item_code:=boq_tab(j).iboq_sta_item_code;
			          boq_temp_tab(rec).iboq_cost:=boq_tab(j).iboq_cost;
				      rec:=rec+1;
                 else
				    for k in 1..boq_temp_tab.count
			        loop if   boq_temp_tab(k).iboq_sta_item_code=boq_tab(j).iboq_sta_item_code
				         then boq_temp_tab(k).iboq_cost:=boq_temp_tab(k).iboq_cost+boq_tab(j).iboq_cost;
				         else boq_temp_tab(rec).iboq_sta_item_code:=boq_tab(j).iboq_sta_item_code;
			                  boq_temp_tab(rec).iboq_cost:=boq_tab(j).iboq_cost;
						      rec:=rec+1;
				         end if;
				    end loop;
  		        end if;
		   end if;
	 end loop;
	 --
	 for j in 1..boq_temp_tab.count -- Output the BOQ item lines.
	 loop
	   v_buffer:=trec||separator||
	            lpad(boq_temp_tab(j).iboq_sta_item_code,12)||separator||
				lpad(to_char(nvl(boq_temp_tab(j).iboq_cost,0),'999999.09'),12);
	            if not writeln(Output_file,v_buffer)
                then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
                else z_rec_no  :=z_rec_no+1;                  -- Count the number of records
	                 z_rec_chrs:=z_rec_chrs+length(v_buffer); -- Count the number of characters
                end if;
	  end loop;
  end loop;
  --
  -- Output the 'Z' record
  --
  v_buffer:=zrec||separator||
	        lpad(to_char(z_rec_no),8)||separator||
		    lpad(to_char(z_rec_chrs),8);
  --
  if not   writeln(Output_file,v_buffer)
  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessWorkRecords}');
  end if;
  utl_file.fclose(Output_File);
  --
  return true;
   exception
    when utl_file.invalid_operation
    then dbms_output.put_line('Error: An invalid operation occured - {ProcessWorkRecords}');
         return false;
    when utl_file.invalid_path
    then dbms_output.put_line('Error: An invalid path error occured - {ProcessWorkRecords}');
	     return false;
    when utl_file.read_error
    then dbms_output.put_line('Error: A read error occured on the specified file - {ProcessWorkRecords}');
	     return false;
    when utl_file.write_error
    then dbms_output.put_line('Error: Cannot write to the specified file - {ProcesswORKRecords}');
	     return false;
    when utl_file.internal_error
    then dbms_output.put_line('Error: An internal error was found - {ProcesswORKRecords}');
	     return false;
    when utl_file.invalid_filehandle
    then dbms_output.put_line('Error: The specified file handle does not identify a valid file -
{ProcessWorkRecords}');
	     return false;
    when utl_file.invalid_mode
    then dbms_output.put_line('Error: Invalid mode - {ProcessWorkRecords}');
	     return false;
    when invalid_number
    then dbms_output.put_line('Error: Invalid number exception raised - {ProcessWorkRecords}');
         return false;
    when value_error
    then dbms_output.put_line('Error: Value error exception raised - {ProcessWorkRecords}');
         return false;
    when others
    then dbms_output.put_line('Error: An Unknown exception Occured - {ProcessWorkRecords}');
       if is_open(Output_File)
	   then utl_file.fclose(Output_File);
	   end if;
	   if is_open(File_Handle)
	   then utl_file.fclose(File_Handle);
	   end if;
	   return false;
end;
--
-- =============================================================================
-- Function: f$invoice_received
-- Descr   : This function should check for received invoices for the specified
--           work order number.
-- =============================================================================
Function f$invoice_received( varchar2 in number )
return boolean
is
   cursor c1 is
   select 1
   from   dual;
   --
   v_ok number;
   --
begin
   open c1;
   fetch c1 into v_ok;
   if c1%notfound
   then close c1;
        return false;
   else close c1;
        return true;
   end if;
end;

/*=======================================================================
  INVOICES

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
Function ProcessInvoiceRecords
return boolean
is
   --
   type invoice_irec    is record( concode       varchar2(8)
                                  ,inv_no        varchar2(20)
								  ,received      varchar2(7)
								  ,wk_received   varchar2(2)
								  ,yr_received   varchar2(2)
								  ,wor           number(12)
								  ,dlo           varchar2(8)
								  ,var_source    varchar2(10)
								  ,sor_code      varchar2(8)
								  ,Qty           number(8,2)
								  ,Inv_line      number(10,2)
								  ,vat_line      number(10,2)
								  ,housing       number(8)
								  ,process_ind   varchar2(1)
								  ,status        varchar2(3)
								  ,status_date   varchar2(7)
								  ,work_order    varchar2(16));
    --
	type work_order_recs is record   ( work_order_no varchar2(16)
	                                  ,tot_quantity  number(11,2));
	--
	type work_order_lines_rec is record ( work_order_line number(8)
	                                     ,tot_quantity    number(11,2));
    --
   type invoice_table    is table of invoice_irec     index by binary_integer;
   type work_order_table is table of work_order_recs index by binary_integer;
   type work_order_lines_table is table of work_order_lines_rec index by binary_integer;
   --
   invoice_tab     invoice_table;     -- Table of invoice records ( Input )
   orders_tab      work_order_table;  -- Table of work order records and totals
   lines_tab       work_order_lines_table; -- Table of work order lines and totals
   --
   total_rows      integer;           -- Total rows counter
   counter_rows    integer:=1;        -- Row counter value
   located         boolean:=false;    -- Location indicator
   i_index         integer:=1;        -- Indexed array counter
   line_counter    integer:=1;        -- Output record counter
   --
   hcontractor     varchar2(3);       -- Contractor code
   hsequence       number:=1;         -- Sequence Number
   hline           varchar2(80);      -- H Record output buffer
   cline           varchar2(500);     -- C Record output buffer
   zline           varchar2(80);      -- Z Record output buffer
   zrec_count      number:=1;         -- Number of 'C' records
   separator       char:=',';         -- Output field separator
   v_work_order_no work_orders.wor_works_order_no%type;
   v_defect_id     defects.def_defect_id%type;
   v_schd_id       schedules.schd_id%type;
   v_date          varchar2(8);       -- Date variable
   v_time          varchar2(8);       -- Time variable
   rec_type        varchar2(2);       -- Record Type
   Fsequence       varchar2(6);       -- Sequence extracted from filename.
   z_rec_no        integer:=0;        -- Number of records
   z_rec_chrs      integer:=0;        -- Number of characters in record
   v_claim_type    char:='F';         -- Claim type ( F,P )
   v_interim       varchar2(3):='   '; -- Interim payment ( null )
   v_invoice_ref   varchar2(20);      -- The invoice reference value
   v_contract_ref  contracts.con_code%type;-- The invoice contract reference
   v_originator    varchar2(40):=' '; -- WOR Originator
   v_date_instructed varchar2(9);     -- WOR instructed date
   v_target_date   varchar2(9);       -- WOR target completion date
   v_start_date    varchar2(9);       -- Start date of the work order
   v_completed_date varchar2(9);      -- Date the work order was completed
   v_tot_order_value number(11,2);     -- Accumulative work order value
   v_found         boolean:=false;
   v2_found        boolean:=false;
   v_buffer        varchar2(2000);
   j               integer;
   --
   -- Obtain the actual work order number and the contract number for
   -- the specified work order line number.
   --
   cursor    get_work_order_details( wol_id in number )
   is select wor.wor_works_order_no
            ,con.con_code
			,wol.wol_def_defect_id
			,wol.wol_schd_id
      from   work_orders      wor
            ,contracts        con
            ,work_order_lines wol
      where wor.wor_works_order_no = wol.wol_works_order_no
      and   wor.wor_con_id         = con.con_id
	  and   wol.wol_id             = wol_id
      and   rownum=1;
   --

begin
--
  -- Open the input file for reading.
  --
  if debug
  then dbms_output.put_line('Dest : '||FDest);
       dbms_output.put_line('File : '||FFile);
       dbms_output.put_line('Read : '||FRead);
  end if;
  --
  --
  -- Obtain the specified file name and location
  --
  if   FSeq is null
  then FSeq:=GetFileSeq;
  end if;
  --
  v_filename:='INV'||lpad(to_char(FSeq),5,'0')||'.lis';
  --
  if  not FileExists(FDest,v_Filename)
  then create_file(FDest,v_filename,StartLine);
  else dbms_output.put_line('Info: The file '||FDest||'\'||v_filename||' exists - {ProcessInvRecords}');
       if is_open(File_Handle)
	   then dbms_output.put_line('Info: The file exists and is open - {ProcessInvRecords}');
	   end if;
  end if;
  --
  -- Open the input file for reading.
  --
  if is_open(file_handle)
  then if not close_file(file_handle)
       then dbms_output.put_line('Error: Unable to close file - {ProcessInvRecords}');
	   else dbms_output.put_line('Info: Closed file - {ProcessInvRecords}');
	   end if;
  end if;
  --
  file_handle:=utl_file.fopen(FDest,FFile,FRead);
  if not is_open(file_handle)
  then dbms_output.put_line('Error: Unable to open file for reading - {ProcessInvRecords}');
  else dbms_output.put_line('Info : File open for reading - {ProcessInvRecords}');
  end if;
  --
  -- Obtain the specified file name and location
  -- Read the records from the file and insert them into the main work order lines
  -- array one at a time. Insert the distinct work order numbers into a second array
  -- and total the actual work order value.
  --
  i_index:=1;
  while not EndOfFile
  loop
    get_nextline(File_Handle,v_buffer,EndOfFile);
	if v_buffer is not null then
    --
    -- There should only be one record per work order inserted into the
    -- array. The output must only contain record per work order.
    --
	if GetFields(v_buffer)!= 16
	then dbms_output.put_line('Error: Invoice Record : '||to_char(GetFields(v_buffer))||'/15 fields expected -
{ProcessInvRecords}');
  else  invoice_tab(i_index).inv_no     :=GetField(v_buffer,2);
	      invoice_tab(i_index).received   :=GetField(v_buffer,3);
     	  invoice_tab(i_index).wk_received:=GetField(v_buffer,4);
	      invoice_tab(i_index).yr_received:=GetField(v_buffer,5);
	      invoice_tab(i_index).wor        :=to_number(GetField(v_buffer,6));
	      invoice_tab(i_index).dlo        :=GetField(v_buffer,7);
	      invoice_tab(i_index).var_source :=GetField(v_buffer,8);
        invoice_tab(i_index).sor_code   :=GetField(v_buffer,9);
        invoice_tab(i_index).qty        :=to_number(GetField(v_buffer,10));
	      invoice_tab(i_index).inv_line   :=GetField(v_buffer,11);
	      invoice_tab(i_index).vat_line   :=GetField(v_buffer,12);
        invoice_tab(i_index).housing    :=to_number(GetField(v_buffer,13));
        invoice_tab(i_index).process_ind:=GetField(v_buffer,14);
        invoice_tab(i_index).status     :=GetField(v_buffer,15);
        invoice_tab(i_index).status_date:=GetField(v_buffer,16);
        --
        open  get_work_order_details(invoice_tab(i_index).wor);
        fetch get_work_order_details
	    into  v_work_order_no
		      ,v_contract_ref
			  ,v_defect_id
			  ,v_schd_id;
	    --
        if    get_work_order_details%notfound
		then  close get_work_order_details;
		      v_work_order_no:='UNKNOWN';
		else  close get_work_order_details;
		end if;
		--
		--
		v2_found:=false;
		for i in 1..orders_tab.count
		loop if orders_tab(i).work_order_no = v_work_order_no
			 then orders_tab(i).tot_quantity:=nvl(orders_tab(i).tot_quantity,0)+invoice_tab(i_index).qty;
				  v2_found:=true;
		     end if;
	    end loop;
		--
        if not v2_found or orders_tab.count=0
	    then  orders_tab(orders_tab.count+1).work_order_no:=v_work_order_no;
			  orders_tab(orders_tab.count+1).tot_quantity:=invoice_tab(i_index).qty;
	    end if;
		--
		-- At this point we must populate the lines table
		--
		v2_found:=false;
		for i in 1..lines_tab.count
		loop if lines_tab(i).work_order_line = invoice_tab(i_index).wor
			 then lines_tab(i).tot_quantity:=nvl(lines_tab(i).tot_quantity,0)+invoice_tab(i_index).qty;
				  v2_found:=true;
		     end if;
	    end loop;
		--
        if not v2_found or lines_tab.count=0
	    then  lines_tab(lines_tab.count+1).work_order_line:=invoice_tab(i_index).wor;
			  lines_tab(lines_tab.count+1).tot_quantity   :=invoice_tab(i_index).qty;
	    end if;
		--
		-- At this point we must obtain the exor work order number.
		--
		invoice_tab(i_index).work_order:=v_work_order_no;
		--
        if debug
        then dbms_output.put_line('Inv No      : '||invoice_tab(i_index).inv_no );
             dbms_output.put_line('Received    : '||invoice_tab(i_index).received);
             dbms_output.put_line('Wk Received : '||invoice_tab(i_index).wk_received);
             dbms_output.put_line('Yr Received : '||invoice_tab(i_index).yr_received);
             dbms_output.put_line('Wor         : '||to_char(invoice_tab(i_index).wor));
             dbms_output.put_line('Dlo         : '||invoice_tab(i_index).dlo);
             dbms_output.put_line('Var Source  : '||invoice_tab(i_index).var_source);
             dbms_output.put_line('Sor Code    : '||invoice_tab(i_index).sor_code);
             dbms_output.put_line('Qty         : '||to_char(invoice_tab(i_index).qty));
             dbms_output.put_line('Inv Line    : '||to_char(invoice_tab(i_index).inv_line));
             dbms_output.put_line('Vat Line    : '||to_char(invoice_tab(i_index).vat_line));
             dbms_output.put_line('Housing     : '||to_char(invoice_tab(i_index).housing));
             dbms_output.put_line('Process Ind : '||invoice_tab(i_index).process_ind);
             dbms_output.put_line('Status      : '||invoice_tab(i_index).status);
             dbms_output.put_line('Status Date : '||invoice_tab(i_index).status_date);
			 dbms_output.put_line('Work Order  : '||invoice_tab(i_index).work_order);
         end if;
		 --
		 i_index:=i_index+1;
		 ---
       end if;
	   end if;
  end loop;
  --
  utl_file.fclose(file_Handle);
  --
  -- At this point we should have two pl/sql tables which contain all work
  -- orders and all work order lines
  --
  -- Display Report
  --
  if debug then
  dbms_output.put_line('List of Orders');
  dbms_output.put_line('==============');
  for i in 1..orders_tab.count
  loop dbms_output.put_line('Order    : '||orders_tab(i).work_order_no||
            ' Quantity : '||to_char(orders_tab(i).tot_quantity));
  end loop;
  --
  dbms_output.put_line('List of Order Lines Totals');
  dbms_output.put_line('==========================');
  for i in 1..lines_tab.count
  loop dbms_output.put_line('Wol : '||to_char(lines_tab(i).work_order_line)||' '||
             'Qty : '||to_char(lines_tab(i).tot_quantity));
  end loop;
  --
  dbms_output.put_line('List of Order Lines');
  dbms_output.put_line('===================');
  for i in 1..invoice_tab.count
  loop dbms_output.put_line('Inv No      : '||invoice_tab(i).inv_no       ||' '||
	         'Received    : '||invoice_tab(i).received     ||' '||
             'Wk Received : '||invoice_tab(i).wk_received  ||' '||
	         'Yr Received : '||invoice_tab(i).yr_received  ||' '||
	         'Wor         : '||to_char(invoice_tab(i).wor) ||' '||
	         'Dlo         : '||invoice_tab(i).dlo          ||' '||
	         'Var Source  : '||invoice_tab(i).var_source   ||' '||
	         'Sor Code    : '||invoice_tab(i).sor_code     ||' '||
	         'Qty         : '||to_char(invoice_tab(i).qty));
  end loop;
  --
  end if;
  --
  hcontractor:=substr((instr(FFile,'.')+1),3);
  hsequence  :=substr(FFile,3,6);
  hline:='00'                         ||separator||
	     hcontractor                  ||separator||
		 lpad(hsequence,6)            ||separator||
		 to_char(sysdate,'DDMMYYYY')  ||separator||
		 to_char(sysdate,'HH:MM:SS');
  --
  if Is_Open(File_Handle)
  then if not Close_File(File_Handle)
       then dbms_output.put_line('Error: Unable to close output file handle - {ProcessWorkRecords}');
	   end if;
  end if;
  --
  File_Handle:=utl_file.fopen(FDest,v_filename,FWrite);
  if   not Is_Open(File_Handle)
  then dbms_output.put_line('Error: Unable to open output file for writing - {ProcessInvRecords}');
  end if;
  --
  if not   writeln(File_Handle,hline)
  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessInvRecords}');
  else z_rec_no  :=z_rec_no+1;             -- Count the number of records
	   z_rec_chrs:=z_rec_chrs+length(hline); -- Count the number of characters
  end if;
  --
  for i_index in 1..orders_tab.count -- For the number of specified work orders
  loop
    --
	-- Start the invoice processing here:
	--
	if    f$invoice_received(orders_tab(i_index).work_order_no)
	then  v_claim_type:='P';
	else  v_claim_type:='F';
	end if;
	--
    open  get_work_order_details(invoice_tab(i_index).wor);
    fetch get_work_order_details
	      into v_work_order_no
		      ,v_contract_ref
			  ,v_defect_id
			  ,v_schd_id;
	--
    if    get_work_order_details%notfound
    then  v_work_order_no:=lpad(length(v_work_order_no),'0');
          v_contract_ref :=lpad(length(v_contract_ref),'0');
    end if;
    close get_work_order_details;
    --
	if   i_index=1
	then v_invoice_ref:=lpad(invoice_tab(i_index).inv_no,20);
	end if;
	--
	cline:='05'                                          ||separator||
	        v_claim_type                                 ||separator||
        	v_interim                                    ||separator||
            v_invoice_ref                                ||separator||
   		    to_char(sysdate,'DDMMMMYYYY')                ||separator||
            lpad(v_work_order_no,20)                     ||separator||
            lpad(v_contract_ref,20)                      ||separator||
            lpad(v_originator,40)                        ||separator||
            lpad(v_date_instructed,9)                    ||separator||
            lpad(v_target_date,9)                        ||separator||
            lpad(to_char(v_tot_order_value),11)          ||separator||
            lpad(v_start_date,9)                         ||separator||
            lpad(v_completed_date,9);
  --
  if not   writeln(File_Handle,cline)
  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessInvRecords}');
  else z_rec_no  :=z_rec_no+1;             -- Count the number of records
	   z_rec_chrs:=z_rec_chrs+length(cline); -- Count the number of characters
  end if;
  --
  --
  -- For each 05-{Claim Record} record entered a sngle 10-{Work Order Line} record should
  -- also be included.
  --
  for i in 1..lines_tab.count
  loop
    for j in 1..invoice_tab.count
	loop
      if invoice_tab(j).wor = lines_tab(i).work_order_line
      then	cline:='10'                                  ||separator||
            lpad(to_char(lines_tab(i).work_order_line),8)||separator||
		    lpad(to_char(nvl(v_defect_id,0)),8)          ||separator||
		    lpad(to_char(v_schd_id),9)                   ||separator||
			lpad(to_char(lines_tab(i).tot_quantity),11)  ||separator||
			lpad(' ',5)                                  ||separator||
			lpad(' ',2)                                  ||separator||
			lpad(invoice_tab(j).received,7);
       end if;
	 end loop;
  end loop;
  --
  if not   writeln(File_Handle,cline)
  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessInvRecords}');
  else z_rec_no  :=z_rec_no+1;             -- Count the number of records
	   z_rec_chrs:=z_rec_chrs+length(cline); -- Count the number of characters
  end if;
  --
  line_counter:=line_counter+1;
  --
  -- Once the Work Order Lines records have been processed then the BOQ items
  -- must be inclided in the file.
  --
  for i in 1..invoice_tab.count
  loop if invoice_tab(i).work_order = orders_tab(i_index).work_order_no
       then cline:='15'                               ||separator||
	              invoice_tab(i).sor_code             ||separator||
				  lpad(to_char(invoice_tab(i).qty),10)||separator|| -- Change
				  lpad(' ',10)                        ||separator||
				  lpad(' ',10)                        ||separator||
				  lpad(to_char(invoice_tab(i).qty),10)||separator||
				  lpad(' ',10)                        ||separator||
				  lpad(to_char(invoice_tab(i).qty),10)||separator|| -- Change
                  lpad(' ',5)                         ||separator||
				  lpad(' ',2);
	   end if;
   end loop;
  --
  --
  if not   writeln(File_Handle,cline)
  then dbms_output.put_line('Error: Unable to write output to designated file - {ProcessInvRecords}');
  else z_rec_no  :=z_rec_no+1;             -- Count the number of records
	   z_rec_chrs:=z_rec_chrs+length(cline); -- Count the number of characters
  end if;
  --
  line_counter:=line_counter+1;
  --
  end loop;
  --
  zline:='Z'||separator||lpad(to_char(line_counter),7);
  utl_file.put_line(File_Handle,zline);
  utl_file.fclose(File_Handle);
  --
  return true;
  exception
  when invalid_number
  then dbms_output.put_line('Error: Invalid number exception raised - {ProcessInvoiceRecords}');
       return false;
  when value_error
  then dbms_output.put_line('Error: Value error exception raised - {ProcessInvoiceRecords}');
       return false;
  when others
  then dbms_output.put_line('Error: An Unknown exception Occured - {ProcessInvoiceRecords}');
       if   is_open(file_handle)
	   then utl_file.fclose(file_handle);
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
  if debug then
  dbms_output.enable(1000000);
  start_time:=dbms_utility.get_time;
  dbms_output.put_line('Start Time : '||to_char(start_time));
  dbms_output.put_line('Info: Output enabled');
  end if;
  --
  get_params( job_id );
  --
  if    FType='C'
  then  if not ProcessComplRecords
        then dbms_output.put_line('Error: Process Completion Records failed - {Main}');
		if   is_open(Input_File)
	    then utl_file.fclose(Input_File);
	    end if;
	    if   is_open(File_Handle)
	    then utl_file.fclose(File_Handle);
	    end if;
  else  dbms_output.enable(300);
        dbms_output.put_line('Info: The file '||v_filename||' has been created in the '||FDest||' directory.');
  end if;
  elsif FType='I'
  then  if not ProcessInvoiceRecords
        then dbms_output.put_line('Error: Process Invoice Records failed - {Main}');
  else  dbms_output.put_line('Info: The file '||v_filename||' has been created in the '||FDest||' directory.');
  		if   is_open(Input_File)
	    then utl_file.fclose(Input_File);
	    end if;
	    if   is_open(File_Handle)
	    then utl_file.fclose(File_Handle);
	    end if;
  end if;
  elsif FType='S'
  then  if Not CheckParameters(FType)
        then dbms_output.put_line('Error: Insufficient parameters for section selection - {Main}');
		elsif not ProcessSectRecords
        then dbms_output.put_line('Error: Process Section Records failed - {Main}');
  else  dbms_output.enable(300);
        dbms_output.put_line('Info: The file '||v_filename||' has been created in the '||FDest||' directory.');
  end if;
  elsif FType='W'
  then  if not ProcessWorkRecords
        then dbms_output.put_line('Error: Process Work Order Records failed - {Main}');
  else  dbms_output.enable(300);
        dbms_output.put_line('Info: The file '||v_filename||' has been created in the '||FDest||' directory.');
  end if;
  else  dbms_output.put_line('Error: Unknown file type from GRI parameters - {Main}');
  end if;

end Main;
end P$Interface;
/
