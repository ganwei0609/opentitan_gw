
`ifdef UV_OVM_ON_MODEL
import nvs_uart_pkg::*;
`endif

// ------------------------------------------------------------------------------------------------
// Interface nvs_uv_ovm_master_if
// ------------------------------------------------------------------------------------------------
interface `NVS_UV_SV_BFM_IF ();

  /** @cond PRIVATE */
  //##############################################################################################
  //#                                      XCHANGE                                               #
  //##############################################################################################
  bit  trans_updated            ; 
  bit  trans_updated_rcv        ; 
  bit  update_trans             ; 
  bit  update_trans_rcv         ; 
  bit  trans_updated_count      ; 
  bit  update_trans_count       ; 
  bit [63:0] address_sig        ; 
  bit [31:0] packet_count_sig   ; 
  
  logic [12:0] payload_sig     ;
  logic        parity_sig_tx   ;
  logic        parity_sig_rx   ;
  logic [12:0] packet_tx       ;
  logic [12:0] packet_rx       ;
  reg [3:0]    data_sz_sig     ;
  reg [1:0]    parity_bits_sig ; 
  
  int stop_bits_sig   ;  
  int start_bits_sig  ; 
  int baud_rate_sig   ;
  int crystal_freq_sig;
  
  string full_name = "uart_agent";
  bit          enable_traffic_log;
  
  //##############################################################################################
  //#                                      XACTION IF                                            #
  //##############################################################################################
  bit          call_do_cmd      ;   
  bit          do_cmd_called    ;   
  bit [31:0]   cmd              ;   
  bit [63:0]   address          ;   
  bit [31:0]   packet_count     ;   
  bit          call_do_cfg      ;   
  bit          call_do_cfg_rd   ;   
  bit          do_cfg_called    ;   
  bit          do_cfg_rd_called ;   
  bit [31:0]   param            ;   
  bit [511:0]  pvalue           ;   
  bit [511:0]  pvalue_rd        ;   
  bit          call_do_pkt      ;   
  bit          do_pkt_called    ;   
  bit [31:0]   index            ;   
  bit [63:0]   data             ;   
  bit          call_do_pkt_be   ;   
  bit          do_pkt_called_be ;   
  bit [31:0]   index_be         ;   
  bit [63:0]   data_be          ;   
  bit          call_do_err      ;   
  bit          do_err_called    ;   
  bit [31:0]   err              ;   
  bit [511:0]  value            ;   
  bit          is_dce = 1'b0    ;
  int          count            ;
  
  // Holds connection status of Verilog and SVT Agent's connection
  bit [1:0]    connection_status = 2'b00;
   
  //##############################################################################################
  //#                                       EVENT IF                                             #
  //##############################################################################################
  reg          trans_updated_event_if  ;
  reg          update_trans_event_if   ;
  logic [7:0]  sda_byte_transfered     ;
  event        event_trans_over        ;
  event        event_rts_asserted      ;
  event        event_dsr_detected      ;
  event        event_bfm_idle          ; 
  event        event_bfm_data_send     ;
  event        event_start_pkt_send    ;
  event        event_start_pkt_received;
  event        event_bfm_data_received ;
  event        event_pkt_received_over ;
  event        event_pkt_send_over     ;
  // top file events
  event        event_print_perf    ; //Event 
  event        event_end_test      ; //Event 
  event        event_legend_printed; //Event 
  event        event_start_test    ; //Event 
  event        event_bus_idle      ; //Event 
  
  function void event_trans_over_trigger ();
    -> event_trans_over ;
  endfunction // event_trans_over_trigger
  
  task event_trans_over_wait ();
    @  event_trans_over ;
  endtask // event_trans_over_wait
  
  function void event_rts_asserted_trigger();
    -> 	event_rts_asserted ;
  endfunction // event_rts_asserted_trigger
  
  function void event_dsr_detected_trigger();
    ->	event_dsr_detected ;
  endfunction // event_dsr_detected_trigger
  
  function void event_bfm_idle_trigger();
    ->	event_bfm_idle ;
  endfunction // event_bfm_idle_trigger
  
  function void event_bfm_data_send_trigger();
    ->	event_bfm_data_send ;
  endfunction // event_bfm_data_send_trigger
  
  function void event_start_pkt_send_trigger();
    ->	event_start_pkt_send ;
  endfunction // event_start_pkt_send_trigger
  
  function void event_start_pkt_received_trigger();
    ->	event_start_pkt_received ;
  endfunction // event_start_pkt_received_trigger
  
  function void event_bfm_data_received_trigger();
    ->	event_bfm_data_received ;
  endfunction // event_bfm_data_received_trigger
  
  function void event_pkt_received_over_trigger();
    ->	event_pkt_received_over ;
  endfunction // event_pkt_received_over_trigger
  
  function void event_pkt_send_over_trigger();
    ->	event_pkt_send_over ;
  endfunction // event_pkt_send_over_trigger
  
  task  event_rts_asserted_wait  ();     
    @ event_rts_asserted ;
  endtask // event_rts_asserted_wait
  
  task  event_dsr_detected_wait ();
    @ event_dsr_detected ;
  endtask // event_dsr_detected_wait
  
  task  event_bfm_idle_wait();
    @ event_bfm_idle ;
  endtask // event_bfm_idle_wait
  
  task  event_bfm_data_send_wait();
    @ event_bfm_data_send ;
  endtask // event_bfm_data_send_wait
  
  task  event_start_pkt_send_wait();
    @ event_start_pkt_send ;
  endtask // event_start_pkt_send_wait
  
  task  event_start_pkt_received_wait();
    @ event_start_pkt_received ;
  endtask // event_start_pkt_received_wait
  
  task  event_bfm_data_received_wait();
    @ event_bfm_data_received ;
  endtask // event_bfm_data_received_wait
  
  task  event_pkt_received_over_wait();
    @ event_pkt_received_over ;
  endtask // event_pkt_received_over_wait
  
  task  event_pkt_send_over_wait();
    @ event_pkt_send_over ;
  endtask // event_pkt_send_over_wait
  
  function void set_full_name(string fullname);
    full_name = fullname;
  endfunction // set_full_name

  function void set_enable_traffic_log(bit enable_traffic_log_temp);
    enable_traffic_log = enable_traffic_log_temp;
  endfunction // set_full_name

  // For verilog-SVT agent connection check

  // register_wrapper is called by the verilog driver to update its connection
  // status
  function void register_wrapper();
    connection_status[0] = 1;
  endfunction // register_wrapper();
  
  // register_svt is called by the SVT Agent's monitor to update its
  // connection status
  function void register_svt();
    connection_status[1] = 1;
  endfunction // register_svt();

  // is_wrapper_registered is called by SVT Agent's monitor to confirm the
  // connection status of Verilog module
  function is_wrapper_registered();
    return connection_status[0];
  endfunction

  // is_svt_registered is called by the verilog driver to confirm the
  // connection status of SVT Agent
  function is_svt_registered();
    return connection_status[1];
  endfunction

  /** @endcond */
endinterface // nvs_uv_sv_bfm_if;


