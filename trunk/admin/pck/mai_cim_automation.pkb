CREATE OR REPLACE PACKAGE BODY mai_cim_automation
AS
-----------------------------------------------------------------------------
--   PVCS Identifiers :-
--
--       PVCS id          : $Header:   //vm_latest/archives/mai/admin/pck/mai_cim_automation.pkb-arc   3.1   Jun 08 2010 12:57:10   lsorathia  $
--       Module Name      : $Workfile:   mai_cim_automation.pkb  $
--       Date into PVCS   : $Date:   Jun 08 2010 12:57:10  $
--       Date fetched Out : $Modtime:   Jun 08 2010 12:55:46  $
--       Version          : $Revision:   3.1  $
--       Based on SCCS version : 
--
-----------------------------------------------------------------------------
--    Copyright (c) exor corporation ltd, 2010
-----------------------------------------------------------------------------
--
--all global package variables here

  -----------
  --constants
  -----------
  --g_body_sccsid is the SCCS ID for the package body
  g_body_sccsid  CONSTANT varchar2(2000) := '$Revision:   3.1  $';

  g_package_name CONSTANT varchar2(30) := 'mai_cim_automation';
  l_failed       Varchar2(1) ;
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
PROCEDURE add_to_budget(v_wol_id in work_order_lines.wol_id%type
                       ,v_bud_id in work_order_lines.wol_bud_id%type
                       ,v_est    in work_order_lines.wol_est_cost%type default 0
                       ,v_act    in work_order_lines.wol_act_cost%type default 0)
IS
--
   CURSOR c1 (p_wol_id WORK_ORDER_LINES.wol_id%TYPE) is
   SELECT wol_status_code
   FROM   WORK_ORDER_LINES, HIG_STATUS_CODES
   WHERE  SYSDATE BETWEEN NVL(hsc_start_date,SYSDATE) AND NVL(hsc_end_date,SYSDATE)
   AND    hsc_allow_feature3 = 'Y'
   AND    hsc_status_code = wol_status_code
   AND    hsc_domain_code = 'WORK_ORDER_LINES'
   AND    wol_id = p_wol_id;
   l_status_code WORK_ORDER_LINES.wol_status_code%type;
   v_retval boolean := TRUE;
--
BEGIN
--
   OPEN  c1(v_wol_id);
   FETCH c1 INTO l_status_code;
   IF c1%notfound 
   THEN
       CLOSE c1;
   ELSE
       CLOSE c1;
       UPDATE work_order_lines
       SET    wol_status_code = null
       WHERE  wol_id = v_wol_id;
       v_retval := mai_budgets.update_budget_actual(v_wol_id, v_bud_id, v_act);
       UPDATE work_order_lines
       SET    wol_status_code = l_status_code
       WHERE  wol_id = v_wol_id;
   END IF;
   Commit ;
--  
END add_to_budget;
--
PROCEDURE run_batch(pi_batch_type Varchar2)
IS
--
   l_file_name  Varchar2(100);
   l_continue_rec    hig_ftp_connections%ROWTYPE;
   l_conn       utl_tcp.connection;
   l_cnt        Number;
   l_file_tab   nm3ftp.t_string_table ;
   l_flist      nm3file.file_list;
   l_tmp        Varchar2(100);
   l_path       varchar2(100) ; 
   l_error      Varchar2(32767);
   l_er_error   interface_erroneous_records.ier_error%TYPE;
   l_ih_id      interface_headers.ih_id%TYPE;   
   l_err_no     Integer;
   l_process_id Number := hig_process_api.get_current_process_id;   
   l_msg        Varchar2(500) ;
   l_ih_rec     interface_headers%ROWTYPE ;
   l_wor_count  Number ;
   l_continue   Boolean ;
   l_hpal_rec   hig_process_alert_log%ROWTYPE;
   l_hp_rec     hig_processes%ROWTYPE;   
   CURSOR c_get_dir_path
   IS
   SELECT hdir_path 
   FROM   hig_directories
   WHERE  hdir_name = 'CIM_DIR';  
   CURSOR c_con_details(qp_contractor_id Varchar2)
   IS
   SELECT oun_org_id
         ,oun_name
         ,con_code
         ,con_name
         ,oun_contractor_id
         ,nau_unit_code
         ,nau_admin_unit
         ,con_id
   FROM  org_units 
        ,contracts
        ,nm_admin_units 
   WHERE oun_contractor_id = qp_contractor_id
   AND   oun_org_id        = con_contr_org_id 
   AND   con_admin_org_id = nau_admin_unit;
   l_con_details_rec c_con_details%ROWTYPE;   
   CURSOR c_get_ih (qp_ih_id interface_headers.ih_id%TYPE)
   IS
   SELECT * 
   FROM   interface_headers
   WHERE  ih_id = qp_ih_id ;
   PROCEDURE run_comp_file(pi_contractor_id Varchar2
                          ,pi_file_name     Varchar2)
   IS   
   --
      l_ih_id     interface_headers.ih_id%TYPE;
      l_error     Varchar2(32767);
      l_er_error  interface_erroneous_records.ier_error%TYPE;
   --
   BEGIN
   --
      hig_process_api.log_it(pi_process_id => l_process_id
                            ,pi_message    => 'Loading File '||pi_file_name);
      OPEN  c_con_details(pi_contractor_id) ;
      FETCH c_con_details INTO l_con_details_rec;
      CLOSE c_con_details ;
      interfaces.completion_file_ph1(pi_contractor_id
                                    ,Null
                                    ,Null
                                    ,pi_file_name
                                    ,l_error); 
      IF Sys_Context('NM3SQL','CIM_IH_ID') IS NOT NULL
      THEN
          l_ih_id := Sys_Context('NM3SQL','CIM_IH_ID') ;
          interfaces.auto_load_file(l_ih_id
                                   ,Null
                                   ,l_er_error);
          hig_process_api.set_process_internal_reference(pi_internal_reference => l_ih_id);
          OPEN  c_get_ih(l_ih_id);
          FETCH c_get_ih INTO l_ih_rec ;
          CLOSE c_get_ih ;
          SELECT Count(0) INTO l_wor_count
          FROM interface_completions_all WHERE ic_ih_id = l_ih_id ;
          hig_process_api.log_it(pi_process_id   => l_process_id
                                ,pi_message      => 'Total Work Orders Processed : '||l_wor_count
                                ,pi_summary_flag => 'Y' );
          SELECT Count(0) INTO l_wor_count
          FROM interface_completions WHERE ic_ih_id = l_ih_id ;
          IF Nvl(l_wor_count,0) > 0
          THEN 
              hig_process_api.log_it(pi_process_id   => l_process_id
                                    ,pi_message      => 'Total Work Orders Rejected :'||l_wor_count
                                    ,pi_message_type => 'E'
                                    ,pi_summary_flag => 'Y' );
          END IF ;
          FOR i IN (SELECT * FROM interface_completions WHERE ic_ih_id = l_ih_id )
          LOOP
              hig_process_api.log_it(pi_process_id   => l_process_id
                                    ,pi_message      => i.ic_works_order_no||' : '||i.ic_error
                                    ,pi_message_type => 'E'
                                    ,pi_summary_flag => 'N' );
          END LOOP;
          IF  l_ih_rec.ih_status IS NULL
          THEN
              l_msg := 'Loading file '||pi_file_name||' : Completed Successfully';
          ELSE
              l_msg := 'Loading file '||pi_file_name||' failed '|| l_ih_rec.ih_error;
              l_failed := 'Y' ;
          END IF ;
      ELSE    
          l_msg :=     'Error while loading file '||pi_file_name;
          l_failed := 'Y' ;
      END IF ;      
      hig_process_api.log_it(pi_process_id   => l_process_id
                            ,pi_message      => l_msg
                            ,pi_summary_flag => 'Y' );
      nm3file.move_file(pi_file_name,'CIM_DIR',pi_file_name,'CIM_ARC',null,TRUE,l_err_no,l_error);

   --
   END run_comp_file;
   --
   PROCEDURE run_claim_file(pi_contractor_id Varchar2
                           ,pi_file_name     Varchar2)
   IS
   --
      CURSOR c_col_claim_val (p_wol_id interface_claims_wol_all.icwol_wol_id%TYPE) 
      IS
      SELECT icwol_claim_value  
      FROM   interface_claims_wol_all
      WHERE  icwol_wol_id = p_wol_id ;
      l_works_order_no interface_claims_wor_all.icwor_works_order_no%TYPE;
      l_error     Varchar2(32767);
      l_fd_file   Varchar2(200) ;   
   --
   BEGIN
   --
      hig_process_api.log_it(pi_process_id => l_process_id
                            ,pi_message    => 'Loading File '||pi_file_name); 
      interfaces.claim_file_ph1(pi_contractor_id
                               ,Null
                               ,Null
                               ,pi_file_name
                               ,l_error);
      OPEN  c_con_details(pi_contractor_id) ;
      FETCH c_con_details INTO l_con_details_rec;
      CLOSE c_con_details ;      
      IF Sys_Context('NM3SQL','CIM_WI_IH_ID') IS NOT NULL
      THEN
          l_ih_id := Sys_Context('NM3SQL','CIM_WI_IH_ID') ;
          interfaces.claim_file_ph2(l_ih_id , l_fd_file, l_error);
          IF l_error IS NULL
          THEN
              FOR c2rec IN (SELECT icwor_works_order_no, icwor_claim_value  
                         FROM   interface_claims_wor_all
                         WHERE  icwor_ih_id =  l_ih_id
                         AND    icwor_error IS NULL) 
              LOOP
                  FOR wol_rec IN (SELECT wol_rse_he_id
                                        ,wol_id
                                        ,wol_def_defect_id
                                        ,wol_act_cost
                                        ,wol_est_cost
                                        ,wol_bud_id
                                  FROM   work_order_lines
                                  WHERE  wol_works_order_no = c2rec.icwor_works_order_no ) 
                  LOOP
                      OPEN  c_col_claim_val(wol_rec.wol_id);
                      FETCH c_col_claim_val INTO l_works_order_no;
                      CLOSE c_col_claim_val ;
                      add_to_budget(wol_rec.wol_id
                                   ,wol_rec.wol_bud_id
                                   ,wol_rec.wol_est_cost * -1
                                   ,l_works_order_no);       
                  END LOOP;
              END LOOP;
          END IF ;
          hig_process_api.set_process_internal_reference(pi_internal_reference => l_ih_id);
          OPEN  c_get_ih(l_ih_id);
          FETCH c_get_ih INTO l_ih_rec ;
          CLOSE c_get_ih ;
          SELECT Count(0) INTO l_wor_count
          FROM interface_claims_wor_all WHERE icwor_ih_id = l_ih_id ;
          hig_process_api.log_it(pi_process_id   => l_process_id
                                ,pi_message      => 'Total Work Orders Processed : '||l_wor_count
                                ,pi_summary_flag => 'Y' );
          SELECT Count(0) INTO l_wor_count
          FROM interface_claims_wor WHERE icwor_ih_id = l_ih_id ;
          IF Nvl(l_wor_count,0) > 0
          THEN 
              hig_process_api.log_it(pi_process_id   => l_process_id
                                    ,pi_message      => 'Total Work Orders Rejected :'||l_wor_count
                                    ,pi_message_type => 'E'
                                    ,pi_summary_flag => 'Y' );
          END IF ;
          FOR i IN (SELECT * FROM interface_claims_wor WHERE icwor_ih_id = l_ih_id )
          LOOP
              hig_process_api.log_it(pi_process_id   => l_process_id
                                    ,pi_message      => i.icwor_works_order_no||' : '||i.icwor_error
                                    ,pi_message_type => 'E'
                                    ,pi_summary_flag => 'N' );
          END LOOP;
          IF  l_ih_rec.ih_status IS NULL
          THEN
              l_msg := 'Loading file '||pi_file_name||' : Completed Successfully';
          ELSE
              l_msg := 'Loading file '||pi_file_name||' failed '|| l_ih_rec.ih_error;
              l_failed := 'Y' ;
          END IF ;
      ELSE    
          l_msg :=     'Error while loading file '||pi_file_name;
          l_failed := 'Y' ;
      END IF ;
      hig_process_api.log_it(pi_process_id   => l_process_id
                            ,pi_message      => l_msg
                            ,pi_summary_flag => 'Y' ); 
      nm3file.move_file(pi_file_name,'CIM_DIR',pi_file_name,'CIM_ARC',null,TRUE,l_err_no,l_error);
   --
   END run_claim_file ;
--
BEGIN
--
   --Get oracle dir path into varibale
   OPEN  c_get_dir_path;
   FETCH c_get_dir_path INTO l_path;
   CLOSE c_get_dir_path;
   --loop through all the CIM contractors   
--nm_debug.debug_on;
   l_hp_rec := hig_process_framework.get_process(l_process_id);
   FOR oun IN (SELECT *
               FROM   org_units
               WHERE  oun_electronic_orders_flag = 'Y'
               AND    oun_org_id                 = Nvl(l_hp_rec.hp_area_id,oun_org_id)
               AND    oun_contractor_id IS NOT NULL)
   LOOP       
       IF pi_batch_type ='WO'
       THEN            
           BEGIN
           --
              SELECT Count(0)
              INTO   l_cnt
              FROM   interface_wor
                    ,contracts
                    ,org_units
              WHERE  iwor_con_code     = con_code
              AND    iwor_wo_run_number IS NULL
              AND    con_contr_org_id  = oun_org_id
              AND    oun_contractor_id = oun.oun_contractor_id ;              
              IF l_cnt > 0
              THEN
                  -- Create WO file      
                  OPEN  c_con_details(oun.oun_contractor_id) ;
                  FETCH c_con_details INTO l_con_details_rec;
                  CLOSE c_con_details ;
                  BEGIN
                     --                       
                     l_file_name := interfaces.write_wor_file(oun.oun_contractor_id,Null,Null);
                     l_continue  := True ;
                     hig_process_api.log_it(pi_process_id => l_process_id
                                           ,pi_message    => 'Work Order Extract file '||l_file_name||' created  for Contractor '||oun.oun_contractor_id);
                  --
                  Exception 
                      WHEN OTHERS THEN
                          l_continue  := False ;
                          hig_process_api.log_it(pi_process_id => l_process_id
                                                ,pi_message    => 'Error while generating WO file for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                ,pi_summary_flag => 'Y' );    
                  END ;
                  -- Check for FTP setp 
                  FOR ftp IN (SELECT ftp.* 
                              FROM   hig_process_conns_by_area ,hig_ftp_connections ftp
                              WHERE  hptc_process_type_id = l_hp_rec.hp_process_type_id 
                              AND    hptc_area_id_value   = Nvl(l_hp_rec.hp_area_id,oun.oun_org_id)
                              AND    hfc_id               = hptc_ftp_connection_id)
                  LOOP    
                      --l_continue_rec := get_ftp_details('CIM',oun.oun_contractor_id);
                  --IF  l_continue_rec.hfc_nau_unit_code IS NOT NULL
                  --AND l_continue  
                      IF l_continue
                      THEN
                         BEGIN
                         --
                            nm3ctx.set_context('NM3FTPPASSWORD','Y');
                            BEGIN
                               --
                               l_conn := nm3ftp.login(ftp.hfc_ftp_host,ftp.hfc_ftp_port,ftp.hfc_ftp_username,nm3ftp.get_password(ftp.hfc_ftp_password));
                               l_continue  := True ;
                            EXCEPTION
                                WHEN OTHERS THEN
                                    l_continue  := False ;
                                    hig_process_api.log_it(pi_process_id   => l_process_id
                                                          ,pi_message      => 'Error while connecting to the FTP server for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                          ,pi_summary_flag => 'Y' );
                            END ;
                            IF l_continue 
                            THEN
                                BEGIN
                                   --   
                                   nm3ftp.put(l_conn,'CIM_DIR',l_file_name,ftp.hfc_ftp_out_dir||l_file_name);
                                   hig_process_api.log_it(pi_process_id => l_process_id
                                                             ,pi_message    => 'Work Order Extract file '||l_file_name||' copied to FTP location');
                                   l_continue  := True ;
                                EXCEPTION
                                    WHEN OTHERS THEN
                                        l_continue  := False ; 
                                        hig_process_api.log_it(pi_process_id => l_process_id
                                                              ,pi_message    => 'Following error occurred while copying the WO file to the FTP location for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                              ,pi_summary_flag => 'Y' ); 
                                END  ;            
                                IF l_continue 
                                THEN
                                    BEGIN
                                       --
                                       nm3file.move_file(l_file_name,'CIM_DIR',l_file_name,'CIM_ARC',null,TRUE,l_err_no,l_error);
                                       hig_process_api.log_it(pi_process_id => l_process_id
                                                             ,pi_message    => 'Work Order Extract file '||l_file_name||' archived');
                                       nm3ftp.logout(l_conn);
                                       --
                                     EXCEPTION
                                        WHEN OTHERS THEN
                                            hig_process_api.log_it(pi_process_id => l_process_id
                                                                  ,pi_message    => 'Following error occurred while archiving the WO file for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                                  ,pi_summary_flag => 'Y' ); 
                                    END ;
                                END IF ;
                            END IF ;
                         --
                         EXCEPTION
                         WHEN OTHERS
                         THEN
                             nm3ftp.logout(l_conn);
                             Raise_Application_Error(-20001,'Error '||Sqlerrm);
                         END ;
                      END IF ;
                  END LOOP; -- Ftp Loop
              END IF ; 
           EXCEPTION
               WHEN OTHERS THEN
                   Raise_Application_Error(-20001,'Error '||Sqlerrm);
           END ; 
       ELSIF pi_batch_type ='WC'
       THEN
           l_file_name := Null ;
           l_tmp       := Null ;
           IF Nvl(l_hp_rec.hp_polling_flag,'N')= 'Y'
           THEN
               FOR ftp IN (SELECT ftp.* 
                           FROM   hig_process_conns_by_area ,hig_ftp_connections ftp
                           WHERE  hptc_process_type_id = l_hp_rec.hp_process_type_id 
                           AND    hptc_area_id_value   = Nvl(l_hp_rec.hp_area_id,oun.oun_org_id)
                           AND    hfc_id               = hptc_ftp_connection_id)
               LOOP
                   ---l_continue_rec := get_ftp_details('CIM',oun.oun_contractor_id);
                   --IF l_continue_rec.hfc_nau_unit_code IS NOT NULL
                   --THEN
                   BEGIN
                   --
                      nm3ctx.set_context('NM3FTPPASSWORD','Y');
                      BEGIN
                         --
                         l_conn := nm3ftp.login(ftp.hfc_ftp_host,ftp.hfc_ftp_port,ftp.hfc_ftp_username,nm3ftp.get_password(ftp.hfc_ftp_password));
                         l_continue := True;
                         --
                      EXCEPTION
                          WHEN OTHERS THEN
                              l_continue := False;
                              hig_process_api.log_it(pi_process_id => l_process_id
                                                    ,pi_message    => 'Error while connecting to the FTP server for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                    ,pi_summary_flag => 'Y' ); 
                      END ;
                      IF l_continue 
                      THEN
                          nm3ftp.list(l_conn,ftp.hfc_ftp_in_dir, l_file_tab);
                          FOR i IN 1..l_file_tab.Count
                          LOOP
                              IF l_file_tab(i) IS NOT NULL
                              THEN
                                  l_tmp := Upper(l_file_tab(i)) ;
                                  IF l_tmp Like Upper('%WC%.'||oun.oun_contractor_id)
                                  THEN
                                      l_file_name := Substr(l_tmp,1,Instr(l_tmp,'.'||Upper(oun.oun_contractor_id),1,1)-1);
                                      l_file_name := Substr(l_file_name,Instr(l_file_name,' ',-1,1))||'.'||Upper(oun.oun_contractor_id);
                                  END IF ;
                              END IF;
                              IF l_file_name IS NOT NULL                          
                              THEN
                                  l_file_name := Trim(l_file_name);
                                  BEGIN
                                     -- 
                                     nm3ftp.get(l_conn,ftp.hfc_ftp_in_dir||l_file_name,'CIM_DIR',l_file_name);
                                     l_continue := True;
                                     --
                                  EXCEPTION
                                      WHEN OTHERS THEN
                                          l_continue := False;
                                          hig_process_api.log_it(pi_process_id => l_process_id
                                                                ,pi_message    => 'Error while getting file '||l_file_name||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                                ,pi_summary_flag => 'Y' ); 
                                  END ;
                                  IF l_continue 
                                  THEN                         
                                      BEGIN
                                         -- 
                                          run_comp_file(oun.oun_contractor_id,l_file_name);
                                          l_continue := True;
                                          --
                                      EXCEPTION
                                          WHEN OTHERS THEN
                                              l_continue := False;
                                              hig_process_api.log_it(pi_process_id => l_process_id
                                                                    ,pi_message    => 'Error while loading file '||l_file_name||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                                    ,pi_summary_flag => 'Y' ); 
                                      END ;
                                  END IF ;
                                  IF l_continue
                                  THEN
                                      BEGIN 
                                         --
                                         nm3ftp.rename(l_conn,ftp.hfc_ftp_in_dir||l_file_name,ftp.hfc_ftp_arc_in_dir||l_file_name,TRUE,TRUE);
                                         l_continue := True;
                                         --
                                      EXCEPTION
                                          WHEN OTHERS THEN
                                              l_continue := False;
                                              hig_process_api.log_it(pi_process_id => l_process_id
                                                                    ,pi_message    => 'Error while moving file '||l_file_name||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                                    ,pi_summary_flag => 'Y' ); 
                                      END ;    
                                  END IF ;                              
                              END IF ; -- file name not null
                          END LOOP; -- loop through all the files in the ftp folder
                          nm3ftp.logout(l_conn);                 
                      END IF ; -- Valid connection 
                   --
                   EXCEPTION
                   WHEN OTHERS
                   THEN
                       nm3ftp.logout(l_conn);
                       Raise_Application_Error(-20001,'Error '||Sqlerrm);
                   END ;    
               END LOOP;
           ELSE
               BEGIN
               -- 
                  l_flist := nm3file.get_wildcard_files_in_dir (l_path,'WC*.'||Upper(oun.oun_contractor_id));
                  l_continue := True;
               --
               EXCEPTION
                   WHEN OTHERS THEN
                       l_continue := False;
                       hig_process_api.log_it(pi_process_id => l_process_id
                                             ,pi_message    => 'Error while searhing WC file for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                             ,pi_summary_flag => 'Y' ); 
               END ;
               IF l_continue 
               THEN
                   FOR i IN 1..l_flist.Count
                   LOOP
                       IF Trim(l_flist(i)) IS NOT NULL
                       THEN                        
                           BEGIN
                           --
                              run_comp_file(oun.oun_contractor_id,Trim(l_flist(i)));
                           --
                           EXCEPTION
                               WHEN OTHERS THEN
                               hig_process_api.log_it(pi_process_id => l_process_id
                                                     ,pi_message    => 'Error while loading file '||Trim(l_flist(i))||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                     ,pi_summary_flag => 'Y' ); 
                           END ;                            
                       END IF ;
                   END LOOP;
               END IF ;
           END IF; -- Ftp Setup available for Contractor
       ELSIF pi_batch_type = 'WI'
       THEN
           l_file_name := Null ;
           l_tmp       := Null ;
           IF Nvl(l_hp_rec.hp_polling_flag,'N')= 'Y'
           THEN
               FOR ftp IN (SELECT ftp.* 
                           FROM   hig_process_conns_by_area ,hig_ftp_connections ftp
                           WHERE  hptc_process_type_id = l_hp_rec.hp_process_type_id 
                           AND    hptc_area_id_value   = Nvl(l_hp_rec.hp_area_id,oun.oun_org_id)
                           AND    hfc_id               = hptc_ftp_connection_id)
               LOOP
               --l_continue_rec := get_ftp_details('CIM',oun.oun_contractor_id);
               --IF l_continue_rec.hfc_nau_unit_code IS NOT NULL
               --THEN
                   BEGIN
                   --
                      nm3ctx.set_context('NM3FTPPASSWORD','Y');
                      BEGIN
                         --
                         l_conn := nm3ftp.login(ftp.hfc_ftp_host,ftp.hfc_ftp_port,ftp.hfc_ftp_username,nm3ftp.get_password(ftp.hfc_ftp_password));
                         l_continue := True;
                         --
                      EXCEPTION
                          WHEN OTHERS THEN
                              l_continue := False;
                              hig_process_api.log_it(pi_process_id => l_process_id
                                                    ,pi_message    => 'Error while connecting to the FTP server for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                    ,pi_summary_flag => 'Y' );
                      END ;
                      IF l_continue 
                      THEN
                          nm3ftp.list(l_conn,ftp.hfc_ftp_in_dir, l_file_tab);
                          FOR i IN 1..l_file_tab.Count
                          LOOP
                              IF l_file_tab(i) IS NOT NULL
                              THEN
                                  l_tmp := Upper(l_file_tab(i)) ;
                                  IF l_tmp Like Upper('%WI%.'||oun.oun_contractor_id)
                                  THEN
                                      l_file_name := Substr(l_tmp,1,Instr(l_tmp,'.'||Upper(oun.oun_contractor_id),1,1)-1);
                                      l_file_name := Substr(l_file_name,Instr(l_file_name,' ',-1,1))||'.'||Upper(oun.oun_contractor_id);
                                  END IF ;
                              END IF;
                              IF l_file_name IS NOT NULL
                              THEN
                                  l_file_name := Trim(l_file_name); 
                                  BEGIN
                                  --
                                     nm3ftp.get(l_conn,ftp.hfc_ftp_in_dir||l_file_name,'CIM_DIR',l_file_name);                          
                                     l_continue := True;
                                  --
                                  EXCEPTION
                                     WHEN OTHERS THEN
                                         l_continue := False;
                                         hig_process_api.log_it(pi_process_id => l_process_id
                                                               ,pi_message    => 'Error while getting file '||l_file_name||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                               ,pi_summary_flag => 'Y' );
                                  --
                                  END ;
                                  IF l_continue
                                  THEN
                                      BEGIN
                                      --  
                                         run_claim_file(oun.oun_contractor_id,l_file_name);    
                                         l_continue := True;
                                      --
                                      EXCEPTION
                                         WHEN OTHERS THEN
                                             l_continue := False;
                                             hig_process_api.log_it(pi_process_id => l_process_id
                                                                   ,pi_message    => 'Error while loading file '||l_file_name||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                                   ,pi_summary_flag => 'Y' );
                                      --
                                      END ;
                                  END IF ;
                                  IF l_continue
                                  THEN
                                      BEGIN
                                      --                              
                                         nm3ftp.rename(l_conn,ftp.hfc_ftp_in_dir||l_file_name,ftp.hfc_ftp_arc_in_dir||l_file_name,TRUE,TRUE);                      
                                         l_continue := True;
                                      --
                                      EXCEPTION
                                         WHEN OTHERS THEN
                                             l_continue := False;
                                             hig_process_api.log_it(pi_process_id => l_process_id
                                                                   ,pi_message    => 'Error while moving file '||l_file_name||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                                   ,pi_summary_flag => 'Y' );
                                      --
                                      END ;
                                  END IF ;
                              END IF ;
                          END LOOP; 
                          nm3ftp.logout(l_conn);                 
                      END IF ;  
                   --
                   EXCEPTION
                   WHEN OTHERS
                   THEN
                       nm3ftp.logout(l_conn);
                       Raise_Application_Error(-20001,'Error '||Sqlerrm);
                   END ;    
               END LOOP;
           ELSE
               BEGIN
               --
                  l_flist := nm3file.get_wildcard_files_in_dir (l_path,'WI*.'||Upper(oun.oun_contractor_id));
                  l_continue := True;
               --
               EXCEPTION
                   WHEN OTHERS THEN
                       l_continue := False;
                       hig_process_api.log_it(pi_process_id => l_process_id
                                             ,pi_message    => 'Error while searhing WI file for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                             ,pi_summary_flag => 'Y' ); 
               END ;
               IF l_continue 
               THEN
                   FOR i IN 1..l_flist.Count
                   LOOP
                       IF Trim(l_flist(i)) IS NOT NULL
                       THEN
                           BEGIN
                           --
                              run_claim_file(oun.oun_contractor_id,Trim(l_flist(i)));
                           --
                           EXCEPTION
                               WHEN OTHERS THEN
                               hig_process_api.log_it(pi_process_id => l_process_id
                                                     ,pi_message    => 'Error while loading file '||Trim(l_flist(i))||' for Contractor '||oun.oun_contractor_id||' '||Sqlerrm 
                                                     ,pi_summary_flag => 'Y' ); 
                           END ; 
                       END IF ;
                   END LOOP;
               END IF; 
           END IF ;
       END IF ; -- Batch Type 
   END LOOP;
   IF   Nvl(l_failed,'N') ='Y'
   AND  l_process_id IS NOT NULL
   THEN
       hig_process_api.process_execution_end('N'); 
   END IF ;
--
END run_batch;
--
--FUNCTION get_ftp_details(pi_ftp_type Varchar2
--                        ,pi_contractor_id org_units.oun_contractor_id%TYPE)
--RETURN hig_ftp_connections%ROWTYPE 
--IS
---
--   CURSOR c_get_ftp_details
--   IS
--   SELECT hfc.*
--   FROM   hig_ftp_types hft
--         ,hig_ftp_connections hfc
--   WHERE  hfc_hft_id        = hft_id
--   AND    hft_type          = pi_ftp_type 
--   AND    hfc_nau_unit_code = pi_contractor_id ;
--
--   l_continue_rec hig_ftp_connections%ROWTYPE;
--
--BEGIN
--
--   OPEN  c_get_ftp_details;
--   FETCH c_get_ftp_details INTO l_continue_rec;
--   CLOSE c_get_ftp_details;

--   RETURN l_continue_rec ;
--
--END get_ftp_details ;
--
END mai_cim_automation;
/

