// ------------------------------------------------------------------------------------------------
// Interface nvs_uv_ovm_chk_if
// ------------------------------------------------------------------------------------------------
interface `NVS_UV_SV_CHK_IF () ;

   // import enum package
   //import nvs_uv_sv_enum_pkg::*;
   
   //#############################################################
   //#                                                           #
   //#                                                           #
   //#                 XCHANGE IF                                #
   //#                                                           #
   //#                                                           #
   //#############################################################
   // ------------------------------------------------------------------------------------------------
   // Variable declaration for xchange interface
   // ------------------------------------------------------------------------------------------------
   bit [31:0]      id_chk         ; 
   bit 	     trans_updated            ;
   bit 	     update_trans             ;
   bit [`SVT_UART_MAX_RULE:0] rule_error;
   // ------------------------------------------------------------------------------------------------
   //Variables diclared to collect Cheker rule coverages.
   // ------------------------------------------------------------------------------------------------
   integer           chk_rule_exe_id;
   integer           chk_rule_error_id;
   integer           chk_rule_log_id;
   
   logic             chk_rule_exe_sig;
   logic             chk_rule_error_sig;
   logic             chk_rule_log_sig;

   logic             chk_exe_id_updated;
   logic             chk_error_id_updated;
   logic             chk_log_id_updated;
   
   // ------------------------------------------------------------------------------------------------
   // Variables associated with do_cmd
   // ------------------------------------------------------------------------------------------------
   logic [31:0]      packet_count_sig ; // Variable for the byte count of the command initiated by the
   // BFM
   // ------------------------------------------------------------------------------------------------
   // master
   // ------------------------------------------------------------------------------------------------
   // ------------------------------------------------------------------------------------------------
   // slave
   // ------------------------------------------------------------------------------------------------
   
   //#############################################################
   //#                                                           #
   //#                                                           #
   //#                 XACTION IF                                #
   //#                                                           #
   //#                                                           #
   //#############################################################
   // ------------------------------------------------------------------------------------------------
   // Variable declaration for xaction interface
   // ------------------------------------------------------------------------------------------------
   bit [31:0]      id_chk_xchange_if; 
   // ------------------------------------------------------------------------------------------------
   // Signals releated to do_cfg and do_cfg_rd task
   // ------------------------------------------------------------------------------------------------
   bit             call_do_cfg    ; 
   bit             call_do_cfg_rd ; 
   bit             do_cfg_called  ; 
   bit             do_cfg_rd_called; 
   logic [31:0]    param          ; 
   logic [31:0]    pvalue         ; 
   logic [511:0]   pvalue_rd      ; 
   // ------------------------------------------------------------------------------------------------
   // Events
   // ------------------------------------------------------------------------------------------------
   bit             end_simulation ; 
   bit             master_idle_sig; 
   bit             slave_idle_sig ;

   event 	   event_slverr_high;
   event 	   event_slverr_low;
   
   
   //#################################################################################################
   //#                                                                                               #
   //#                                                                                               #
   //#                                       EVENT IF                                                #
   //#                                                                                               #
   //#                                                                                               #
   //#################################################################################################
   // ------------------------------------------------------------------------------------------------
   // Variable declaration for event interface
   // ------------------------------------------------------------------------------------------------
   logic 	     trans_updated_event_if   ; // 1bit var
   logic 	     update_trans_event_if    ; // 1bit var
   event 	     event_chk_bfm_idle_event_if ; // Event
   // top file events
   event 	     event_print_perf    ; //Event 
   event 	     event_end_test      ; //Event 
   event 	     event_legend_printed; //Event 
   event 	     event_start_test    ; //Event 
   event 	     event_bus_idle      ; //Event 
   
   
   // event mapping
   event 	     event_start_detected_u;
   event 	     event_stop_detected_u;
   event 	     event_start_detected_d;
   event 	     event_stop_detected_d;
   event             event_xon_detected;
   event             event_xoff_detected;
   
   function void event_start_detected_u_trigger();
      -> event_start_detected_u ;
   endfunction
   function void	event_stop_detected_u_trigger();
      -> event_stop_detected_u ;
   endfunction
   function void	event_start_detected_d_trigger();
      -> event_start_detected_d ;
   endfunction
   function void	event_stop_detected_d_trigger();
      -> event_stop_detected_d ;
   endfunction
   function void event_xon_detected_trigger();
     -> event_xon_detected;
   endfunction
   function void event_xoff_detected_trigger();
     -> event_xoff_detected;
   endfunction
   
   task	event_start_detected_u_wait();
      @ event_start_detected_u ;
   endtask
   task	event_stop_detected_u_wait();
      @ event_stop_detected_u ;
   endtask
   task	event_start_detected_d_wait();
      @ event_start_detected_d ;
   endtask
   task	event_stop_detected_d_wait();
      @ event_stop_detected_d ;
   endtask
   
   




endinterface // nvs_uv_sv_chk_if;

 //------------------------------------------------------------------------------------------------
 // ************************ END OF FILE ********************************
