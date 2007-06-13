REM Copyright (c) Exor Corporation Ltd, 2003
REM '$Revision:   2.0  $'
--
undefine log_extension
col         log_extension new_value log_extension noprint
set term off
select  TO_CHAR(sysdate,'DDMONYYYY_HH24MISS') log_extension from dual
/
set term on

define logfile='Norfolk_gmis_upg_&log_extension'
spool &logfile
--
COL run_file new_value run_file noprint
--
--get some db info
--
SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET','MAI');
--
WHENEVER SQLERROR EXIT
begin
   hig2.pre_upgrade_check (p_product               => 'MAI'
                          ,p_new_version           => '3.1.0.0'
                          ,p_allowed_old_version_1 => '3.1.0.0'
                          );
END;
/
WHENEVER SQLERROR CONTINUE

--
--
---------------------------------------------------------------------------------------------------
--
--            **************** PUT TABLE UPGRADES HERE *******************
--
---------------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------------
--Start of Gmis
---------------------------------------------------------------------------------------------------
CREATE TABLE MAI_GMIS_LOAD_BATCHES (
GLB_LOAD_BATCH	  number(9)    NOT NULL,
GLB_LINE_NUMBER   number(8),
GLB_LOAD_FILE	  clob,
GLB_LOAD_ERRORS   varchar2(1)  DEFAULT 'Y',
GLB_DATE_CREATED  date,
GLB_DATE_MODIFIED date,
GLB_CREATED_BY    varchar2(30),
GLB_MODIFIED_BY   varchar2(30),
GLB_ERROR_TEXT	  varchar2(200),
GLB_ERROR_DATA	  varchar2(500)
);

ALTER TABLE MAI_GMIS_LOAD_BATCHES ADD (CONSTRAINT glb_pk PRIMARY KEY (glb_load_batch));

ALTER TABLE MAI_GMIS_LOAD_BATCHES ADD (CONSTRAINT glb_load_err_chk1 CHECK (glb_load_errors IN ('Y', 'N')));

COMMENT ON TABLE MAI_GMIS_LOAD_BATCHES IS 'Contains details of GMIS load files processed by the gmis inspection loader';

COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LOAD_BATCH IS 'The load batch number. This will match the load batch number on the inspection';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LINE_NUMBER IS 'The line number of the first error';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LOAD_FILE IS 'The load file itself';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_LOAD_ERRORS IS 'A flag to signify if there are load errors';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_ERROR_TEXT IS 'The error message returned by the loader';
COMMENT ON COLUMN MAI_GMIS_LOAD_BATCHES.GLB_ERROR_DATA IS 'The line processed by the loader when the error was encountered';

CREATE TABLE hig_hd_mod_parameters (
hhp_hhm_module           varchar2(30) NOT NULL,
hhp_parameter            varchar2(80) NOT NULL,
hhp_default_value        varchar2(200));


COMMENT ON TABLE hig_hd_mod_parameters IS 'Lists parameter definitions used in queries';

COMMENT ON COLUMN hig_hd_mod_parameters.hhp_hhm_module IS 'Module Name, (FK) to hig_hd_modules';

COMMENT ON COLUMN hig_hd_mod_parameters.hhp_parameter IS 'Parameter name';

COMMENT ON COLUMN hig_hd_mod_parameters.hhp_default_value IS 'Default value of the parameter';

ALTER TABLE hig_hd_mod_parameters ADD (CONSTRAINT hig_hd_hhp_pk PRIMARY KEY (hhp_hhm_module, hhp_parameter));

ALTER TABLE hig_hd_mod_parameters ADD (CONSTRAINT hig_hd_hhp_hhm_fk FOREIGN KEY (hhp_hhm_module) REFERENCES hig_hd_modules (hhm_module) ON DELETE CASCADE);


ALTER TABLE hig_hd_lookup_join_cols ADD (HHO_HHL_JOIN_TO_LOOKUP NUMBER);

COMMENT ON COLUMN hig_hd_lookup_join_cols.hho_hhl_join_to_lookup IS 'The lookup join table the column joins to. If null then the column is joined to the driving table';

ALTER TABLE hig_hd_lookup_join_cols ADD (CONSTRAINT hig_hd_hho_hhl_lookup_fk FOREIGN KEY (HHO_HHL_HHU_HHM_MODULE, HHO_HHL_HHU_SEQ, HHO_HHL_JOIN_TO_LOOKUP) REFERENCES hig_hd_lookup_join_defs (HHL_HHU_HHM_MODULE, HHL_HHU_SEQ, HHL_JOIN_SEQ) ON DELETE CASCADE);


--  
---------------------------------------------------------------------------------------------------
--End of Gmis
---------------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------------
--
--             **************** END OF TABLE UPGRADES *******************
--
---------------------------------------------------------------------------------------------------
--

---------------------------------------------------------------------------------------------------
--                      **************** PACKAGES *******************
---------------------------------------------------------------------------------------------------
-- NM3 pacakges

SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'nm3file.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'nm3file.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'nm3load.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'nm3load.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'nm3xsp.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'nm3xsp.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'hig_hd_query.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'hig_hd_query.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'hig_hd_extract.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'hig_hd_extract.pkw' run_file
FROM dual
/
--
START '&run_file'
--
-- CORE MAI packages

SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai.pkw' run_file
FROM dual
/
--
START '&run_file'


-- Gmis Packages
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_load.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_load.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_util.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_util.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_validate.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_gmis_validate.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_act.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_act.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_are.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_are.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_arl.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_arl.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_boq.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_boq.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_def.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_def.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dpr.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dpr.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dty.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_dty.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_glb.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_glb.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_std.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_std.pkw' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_tre.pkh' run_file
FROM dual
/
--
START '&run_file'
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'pck'||'&terminator'||'mai_tab_tre.pkw' run_file
FROM dual
/
--
START '&run_file'
---------------------------------------------------------------------------------------------------
--                      **************** VIEWS *******************
---------------------------------------------------------------------------------------------------
--
--
SET echo OFF
SET term OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'trg'||'&terminator'||'who_trg.sql' run_file
FROM dual
/
START '&run_file'
--
spool OFF
prompt compile_schema_script
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'admin'||
'&terminator'||'utl'||'&terminator'||'compile_schema.sql' run_file
FROM dual
/
START '&run_file'
--
define compfile='Norfolk_gmis_upg_2_&log_extension'
spool &compfile

--get some db info
SELECT 'Install Running on ' ||LOWER(USER||'@'||instance_name||'.'||host_name)||' - DB ver : '||version
FROM v$instance;
SELECT 'Current version of '||hpr_product||' ' ||hpr_version
FROM hig_products
WHERE hpr_product IN ('HIG','NET','MAI');

START compile_all.sql

------------------------------------------
--The compile_all will have reset the user
--context so we must reinitialise it
------------------------------------------
PROMPT Reinitialising context...
BEGIN
  nm3context.initialise_context;
  nm3user.instantiate_user;
END;
/

--
---------------------------------------------------------------------------------------------------
--                      **************** METADATA *******************
---------------------------------------------------------------------------------------------------
PROMPT Metadata upgrade
SET feedback OFF
SET define ON
SELECT '&exor_base'||'gmis'||'&terminator'||'install'||
        '&terminator'||'norfolk_gmis_metadata_upg' run_file
FROM dual
/
START '&&run_file'
----------------------------------------------------------------------------------------------------

--
--
--- Run all post upgrade stuff here ---------------------------------------------------------
--
--
--- /Run all post upgrade stuff here ---------------------------------------------------------
--
--
EXIT
